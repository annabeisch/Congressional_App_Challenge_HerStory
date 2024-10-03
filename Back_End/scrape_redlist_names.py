import json
import requests
from bs4 import BeautifulSoup
import os
import time

# Helper methods to scrape Redlist names from Wikipedia

def fetch_html(url):
    """
    Helper to fetch and parse HTML content from a given URL.

    Args:
        url (str): The URL to fetch HTML content from.

    Returns:
        str: The parsed HTML content.
    """
    response = requests.get(url, timeout=10)
    response.raise_for_status()  # Raise an error for bad status codes
    return response.text

def scrape_names_from_table(url):
    """
    Scrapes just the names from a table given a Wikipedia page URL.

    Args:
        url (str): The URL to scrape the elements from.

    Returns:
        list: A list of strings containing the scraped elements.
    """
    html_content = fetch_html(url)
    soup = BeautifulSoup(html_content, 'html.parser')
    td_elements = soup.select('td:nth-child(1)')

    scraped_names = [td.get_text(strip=True) for td in td_elements]

    # Remove initial scraped non-name fields
    scraped_names = scraped_names[2:]

    return scraped_names

def get_redlist_links():
    """
    Gets all relevant links from the WikiProject Women in Red Redlist Index.

    Returns:
        list: A list of strings containing the relevant links.
    """
    base_url = 'https://en.wikipedia.org'
    url = base_url + '/wiki/Wikipedia:WikiProject_Women_in_Red/Redlist_index'
    html_content = fetch_html(url)
    soup = BeautifulSoup(html_content, 'html.parser')
    links = soup.select('.div-col li > a:last-child')
    return [base_url + link['href'] for link in links]

def scrape_redlist_names(timeout=30):
    """
    Scrapes all names from the WikiProject Women in Red Redlist Index.
    """

    # Check if file already exists and was updatde within the same day, if so we don't need to scrape again
    if os.path.exists('redlist_scraped.json'):
        file_modified_time = os.path.getmtime('redlist_scraped.json')
        current_time = time.time()
        time_difference = current_time - file_modified_time
        if time_difference < 86400:  # 86400 seconds -> 1 day
            return

    # Scrape
    start_time = time.time()
    redlist_links = get_redlist_links()
    all_scraped_data = []

    for link in redlist_links:
        td_first_child = scrape_names_from_table(link)
        all_scraped_data.extend(td_first_child)
        # Save any intermediate results to a JSON file
        with open('redlist_scraped.json', 'w', encoding='utf-8') as f:
            json.dump(all_scraped_data, f, ensure_ascii=False, indent=4)
        # Break if timeout is reached
        if time.time() - start_time >= timeout:
            break
    
    # Save final results to a JSON file
    with open('redlist_scraped.json', 'w', encoding='utf-8') as f:
        json.dump(all_scraped_data, f, ensure_ascii=False, indent=4)