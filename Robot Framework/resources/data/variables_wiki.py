import json
import os

def get_variables():
    json_path = os.path.join(os.path.dirname(__file__), 'test_data_wiki.json')
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    result = {
        'WIKI_SITE' : data['site'],
        'WIKI_PAGES': data['wikis'],
    }
    # Expose chaque page individuellement : WIKI_PAGE_1, WIKI_PAGE_2, ...
    for i, wiki in enumerate(data['wikis']):
        result[f'WIKI_PAGE_{i + 1}'] = wiki

    return result