## 1. Clonar

```
git clone git@github.com:dicastech/prices.git
```

## 2. Buildar

```
docker-compose build
```

## 3. Executar

```
docker-compose up
```

## 4. Testar

Enviando dados para a API via CURL:

```
curl --location --request POST 'http://localhost:3000/prices' \
  --header 'Content-Type: application/json' \
  --data '{"rental_price": 3000}'
```

Enviando dados para a API via frontend:

- http://localhost:9000/frontend/form.html

Lendo dados da API via CURL:

```
curl --location --request GET 'http://localhost:3000/prices'
```