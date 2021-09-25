from urllib import request
from datetime import datetime
import gzip, json, time


class ApiStackoverflow:
    """Consume la API de respuestas de Stackoverflow"""

    def __init__(self, urlApi):
        self.data = self.getJson(urlApi)
        self.title = ""
        self.owner = ""
        self.reputation = ""

    def getJson(self, urlApi):
        """Obtiene los datos de respuestas de stackoverflow y
        los convierte a formato Json."""
        data = request.urlopen(urlApi).read()
        decompress_data = gzip.decompress(data).decode('utf-8')
        return json.loads(decompress_data)

    def countAnswered(self):
        """Obtiene la cantidad de respuestas contestadas."""
        count = 0
        for item in self.data['items']:
            if item['is_answered']:
                count = count + 1
        return count

    def countNotAnswered(self):
        """Obtiene la cantidad de respuestas no contestadas."""
        count = 0
        for item in self.data['items']:
            if not item['is_answered']:
                count = count + 1
        return count

    def fewestViews(self):
        """Obtiene la respuesta con la menor cantidad de
        visitas. Devuelve el titulo, el autor y el número de
        visitas para una mayor descripción."""
        f_view = 100000
        for item in self.data['items']:
            if item['view_count'] < f_view:
                f_view = item['view_count']
                self.title = item['title']
                self.owner = item['owner']['display_name']
        return self.title, self.owner, f_view

    def oldestAnswer(self):
        """Obtiene la respuesta más antigua.
        Devuelve el titulo, el autor y la fecha de publicación
        para una mayor descripción."""
        date = round(time.time())
        for item in self.data['items']:
            if item['creation_date'] < date:
                date = item['creation_date']
                self.title = item['title']
                self.owner = item['owner']['display_name']
        return self.title, self.owner, time.strftime("%d/%m/%Y", time.localtime(date))

    def higherReputation(self):
        """Ontiene la respuesta publicada por el autor con
        mayor reputación. Devuelve el titulo de la respuesta
        y el autor para una mayor descripción."""
        reputation = 0
        title = ""
        owner = ""
        for item in self.data['items']:
            if item['owner']['reputation'] > reputation:
                reputation = item['owner']['reputation']
                owner = item['owner']['display_name']
                title = item['title']

        return title, owner
