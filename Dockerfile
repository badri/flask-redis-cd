FROM python:3.12
WORKDIR /code
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy entrypoint script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY . .

# Use the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
