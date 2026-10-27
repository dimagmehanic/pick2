from bs4 import BeautifulSoup
import json 

def get_images(html_data):
    soup = BeautifulSoup(html_data, "html.parser")
    image_list = []

    for ind, link in enumerate(soup.select("a.iusc[m]")):

        try:
            info = json.loads(link["m"])
        except (json.JSONDecodeError, KeyError):
            continue

        image_url = info.get("murl")
        thumbnail_url = info.get("turl")
        page_url = info.get("purl")
        title = info.get("t")
        description = info.get("desc")

        if image_url:
            image_list.append({
                "index": ind,
                "title": title,
                "description": description,
                "page_url": page_url,
                "image_url": image_url,
                "thumbnail_url": thumbnail_url
            })

    return image_list
