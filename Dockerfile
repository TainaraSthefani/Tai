FROM python:3.13.5-alpine3.22

# 1. Imagem base: Usamos uma imagem slim do Python para um tamanho menor.
# O readme menciona Python 3.10+, então a 3.11 é uma ótima escolha.

# 2. Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# 3. Copia o arquivo de dependências primeiro para aproveitar o cache do Docker
COPY requirements.txt .

# 4. Instala as dependências da aplicação
# A flag --no-cache-dir ajuda a manter a imagem final menor
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# 6. Expõe a porta em que o uvicorn irá rodar
EXPOSE 8000

# 7. Comando para iniciar a aplicação quando o contêiner for executado
# Usamos 0.0.0.0 para que a API seja acessível de fora do contêiner.
# O --reload não é usado aqui, pois é ideal para desenvolvimento, não para produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
