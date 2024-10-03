from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional, List
from datetime import date
import uvicorn
import json
import uuid
import random
import os

# Import the functions from the other files
from scrape_redlist_names import scrape_redlist_names
from langchain_agent import research_new_names

app = FastAPI()

def generate_uuid():
    return str(uuid.uuid4())

class UnsungHero(BaseModel):
    """
    Represents a woman who has made a significant contribution to society but has not been recognized for her work.
    """
    id: str
    name: str
    added_date: date
    completion_status: Optional[str] = 'Pending'

    def dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "added_date": self.added_date.strftime("%Y-%m-%d"),
            "completion_status": self.completion_status
        }

class UnsungHeroCandidate(BaseModel):
    """
    Represents a potential candidate for an unsung hero.
    """
    name: str

class UnsungHeroUpdateRequest(BaseModel):
    """
    Represents a status change request for an unsung hero.
    """
    status: str

class Wikithon(BaseModel):
    """
    Represents a wikithon event.
    """
    id: str
    name: str
    date: str
    unsung_heroes: List[UnsungHero]

class CreateWikithonRequest(BaseModel):
    """
    Represents a request to create a new wikithon event.
    """
    name: str
    date: str
    n: int = 25 # set default number of unsung heroes to 25 for a wikithon event

def load_unsung_heroes() -> List[UnsungHero]:
    """
    Loads unsung heroes from a local JSON file.
    """
    if os.path.exists("unsung_heroes.json"):
        with open("unsung_heroes.json", "r") as file:
            heroes = json.load(file)
            return [UnsungHero(**hero) for hero in heroes]
    return []

unsung_heroes = load_unsung_heroes()

@app.get("/")
def welcome():
    return {"message": "Hi, welcome to the HerStory API :)"}

@app.get("/heroes/", response_model=List[UnsungHero])
def get_all_heroes():
    return unsung_heroes

@app.get("/unclaimed-heroes/", response_model=List[UnsungHero])
def get_unclaimed_heroes():
    unclaimed_heroes = [hero for hero in unsung_heroes if hero.completion_status == 'Pending']
    return unclaimed_heroes

@app.get("/heroes/{hero_id}", response_model=UnsungHero)
def get_hero_by_id(hero_id: str):
    for hero in unsung_heroes:
        if hero.id == hero_id:
            return hero
    raise HTTPException(status_code=404, detail="Hero not found")

@app.post("/heroes/add/", response_model=UnsungHero | str)
def add_unsung_hero(hero_candidate: UnsungHeroCandidate):

    for hero in unsung_heroes:
        if hero.name == hero_candidate.name:
            # Hero already exists in our database, so return the existing record
            hero.dict()

    # otherwise, create a new unsung hero object
    hero = UnsungHero(id=generate_uuid(), name=hero_candidate.name, added_date=date.today(), completion_status='Pending')
    
    # Save the new hero for review
    with open("pending_review.json", "r") as file:
        pending_review_data = json.load(file)

    pending_review_data.append(hero.dict())
    with open("pending_review.json", "w") as file:
        json.dump(pending_review_data, file, indent=4)

    return hero.dict()

# Live update unsung heroes data

@app.put("/heroes/fetch/", response_model=List[UnsungHero])
def fetch_heroes():
    # scrape redlist names
    scrape_redlist_names()

    # Read scraped Redlist names
    with open("redlist_scraped.json", "r") as file:
        redlist_data = json.load(file)

    # Create UnsungHero objects for each name
    new_heroes = [UnsungHero(id=generate_uuid(),
                             name=name,
                             added_date=date.today(),
                             completion_status='Pending') for name in redlist_data]

    # call the langchain agent to research new names
    research_new_names()

    # Read names from LLM agent output
    with open("agent_output.json", "r") as file:
        langchain_data = json.load(file)

    # Create UnsungHero objects for each name
    new_heroes.extend([UnsungHero(id=generate_uuid(),
                                  name=name, added_date=date.today(),
                                  completion_status='Pending') for name in langchain_data])

    # Save all new heroes to a new file for manual review
    with open("pending_review.json", "w") as file:
        json.dump([hero.dict() for hero in new_heroes], file, indent=4)

    return new_heroes

@app.get("/heroes/pending-review/", response_model=List[UnsungHero])
def get_pending_review_heroes():
    # Make sure we have called /heroes/fetch/ endpoint first to fetch new heroes
    if os.path.exists("pending_review.json"):
        with open("pending_review.json", "r") as file:
            heroes = json.load(file)
            return [UnsungHero(**hero) for hero in heroes]
    else:
        raise HTTPException(status_code=404, detail="No new heroes have been fetched")

# Create a new wikithon event with a subset of unsung heroes, to turn red links into blue links

@app.post("/wikithon/create/", response_model=Wikithon)
def create_wikithon(wiki_request: CreateWikithonRequest):
    # get desired number of unsung heroes
    n = wiki_request.n

    if n > len(unsung_heroes):
        raise HTTPException(status_code=400, detail="Not enough unsung heroes available.")
   
    selected_heroes = random.sample(unsung_heroes, n)

    wikithon = Wikithon(id=generate_uuid(), name=wiki_request.name, date=wiki_request.date, unsung_heroes=selected_heroes)
    return wikithon

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
