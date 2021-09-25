from API import ApiStackoverflow

url = "https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow"
api = ApiStackoverflow(url)

# Se muestra el número des respuestas contestadas y no contestadas
print(
    f"El número de respuestas contestadas es {api.countAnswered()} y el número de respuestas no contestadas es {api.countNotAnswered()}\n")
title, owner, views = api.fewestViews()
# Se muetsra la respuesta con menos visitas
print(f'La respuesta con menos vistas, tiene {views} vistas. Publicada por {owner} y lleva por titulo "{title}"\n')
title, owner, date = api.oldestAnswer()
# Se muestra la respuesta más antigua
print(f'La respuesta más antigua fue publicada por {owner} en la siguiente fecha {date}. Lleva por titulo "{title}"\n')
title, owner = api.higherReputation()
# Se muestra la respuesta publicada por el usuario con mayor reputación
print(f'"{title}" es la respuesta publicada por {owner}, usuario con mayor reputación')
