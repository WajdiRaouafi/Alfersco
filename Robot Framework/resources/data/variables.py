import json
import os

def get_variables():
    json_path = os.path.join(os.path.dirname(__file__), 'test_data.json')
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    result = {
        'MODEL_DATA'    : data['modele'],
        'ASPECT_DATA'   : data['aspect'],
        'PROP_LIST'     : data['proprietes'],
        'FAVORI_DOSSIER': data['favoris']['dossier'],
        'FICHIER_LIST'  : data['favoris']['fichiers'],
    }
    for i, prop in enumerate(data['proprietes']):
        result[f'PROP_DATA_{i + 1}'] = prop
    for i, fichier in enumerate(data['favoris']['fichiers']):
        result[f'FICHIER_DATA_{i + 1}'] = fichier

    return result