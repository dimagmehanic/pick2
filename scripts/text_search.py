from bs4 import BeautifulSoup

def get_text(html_country_data):

    soup = BeautifulSoup( html_country_data, "html.parser")

    # Extract Bing search result text
    results = soup.select("li.b_algo")

    text = "\n".join([ result.get_text(" ", strip=True) for result in results])

    return text
