import os
import json
from langchain.agents import Tool, AgentExecutor, create_react_agent
from langchain.prompts import PromptTemplate
from langchain_core.tools import tool
from langchain.llms import OpenAI
from langchain_community.utilities import SerpAPIWrapper
from langchain.schema import AgentFinish
from typing import List, Dict, Any
import requests
from bs4 import BeautifulSoup
from urllib.parse import urlparse

# Note: must first locally set up environment variables for OpenAI API key and SerpAPI key
os.environ["OPENAI_API_KEY"] = "openai_api_key"
os.environ["SERPAPI_API_KEY"] = "serp_api_key"

# Default input prompt
DEFAULT_INPUT = "Search for women with stories that aren't widely known but who are hidden figures who have had an impact yet have been obscured by history"

# Set up tools
search = SerpAPIWrapper()

@tool
def scrape_women_list(url: str) -> str:
    """Extract women from a relevant listicle"""
    # Validate URL
    parsed_url = urlparse(url)
    if not parsed_url.scheme or not parsed_url.netloc:
        return "Error: Invalid URL provided. Please provide a complete URL including http:// or https://"

    try:
        response = requests.get(url)
        response.raise_for_status()  # Raises an HTTPError for bad responses

        soup = BeautifulSoup(response.text, 'html.parser')
        # Super basic way of scraping all women in <li> tags
        women_list = [li.text for li in soup.select('li')]
        return f"Scraped {len(women_list)} names: {', '.join(women_list[:5])}..." if women_list else "No names found on this page."
    except requests.RequestException as e:
        return f"Error scraping the website: {str(e)}"

@tool
def has_untold_story(name: str) -> bool:
    """Find if a Wikipedia page already exists for the woman at hand"""
    return not wiki.page(name).exists()

tools = [
    Tool(
        name="Search",
        func=search.run,
        description="Useful for finding websites with lists of women who contributed to history"
    ),
    Tool(
        name="Wikipedia",
        func=has_untold_story,
        description="Useful for seeing if a woman has already been documented on Wikipedia"
    ),
    Tool(
        name="ScrapeWomenList",
        func=scrape_women_list,
        description="Useful for scraping a list of women from a given URL. Input should be a full URL."
    )
]

# Set up prompt template
template = """You are an agent designed to uncover and highlight significant women in history whose contributions have been overlooked or underreported.

Your task is to search for lists of important women throughout history, scrape them, and identify those whose stories have not been adequately documented, and ensure they are recognized for their achievements.

You have access to the following tools:

{tools}

Use the following format:

Question: the input question you must answer
Thought: you should always think about what to do
Action: the action to take, should be one of [{tool_names}]
Action Input: the input to the action
Observation: the result of the action
... (this Thought/Action/Action Input/Observation can repeat N times)
Thought: I now know the final answer
Final Answer: the final answer to the original input question

Begin!

Question: {input}
Thought: To find significant women in history whose contributions have been overlooked, I should first search for lists of notable women, identify those who have not been adequately recognized, and return their names.

{agent_scratchpad}
"""

prompt = PromptTemplate.from_template(template)

# Set up LLM
llm = OpenAI()

# Create the agent using Langchain ReAct framework
agent = create_react_agent(llm, tools, prompt)

# Set up the agent executor
agent_executor = AgentExecutor.from_agent_and_tools(
    agent=agent,
    tools=tools,
    verbose=True
)

# Method to call the agent
def call_agent(input: str = DEFAULT_INPUT):
    return agent_executor.invoke({"input": input})

# Save names to file
def research_new_names():
    # Check if api keys are set
    if "OPENAI_API_KEY" in os.environ and "SERPAPI_API_KEY" in os.environ and os.environ["OPENAI_API_KEY"] != "openai_api_key" and os.environ["SERPAPI_API_KEY"] != "serp_api_key":
        
        # Call the agent
        result = call_agent()

        # Save the result to a file
        with open('agent_output.json', 'w') as file:
            json.dump(result, file)
    else:
        print("You need to set your OpenAI and SerpAPI API keys as environment variables before calling the agent")