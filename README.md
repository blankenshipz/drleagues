# DRL

[drleagues.io](http://www.drleagues.io)

A rails application to manage private Deep Racer Leagues

## Getting up and running for local development

This project uses `docker-compose`

```bash
docker-compose run --rm web ./bin/setup # Runs migrations etc
docker-compose up                       # Launches the webservice

open http://localhost:3000              # Open the website in a browser
```


