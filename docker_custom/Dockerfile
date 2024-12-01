# Use the official Python 3.10 image as the base
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install pipx and Poetry
RUN pip install --no-cache-dir pipx \
    && pipx install poetry

# Ensure that Poetry is in PATH
ENV PATH="/root/.local/bin:$PATH"

# Copy the pyproject.toml and poetry.lock first to leverage Docker cache
COPY pyproject.toml poetry.lock ./

# Install backend dependencies
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Copy the rest of the application code
COPY . .

# Make the setup_env.sh script executable and run it
RUN chmod +x ./scripts/setup/setup_env.sh \
    && ./scripts/setup/setup_env.sh

# Expose the port that the backend service runs on
EXPOSE 7860

# Set environment variables if needed (you can adjust or add variables here)
ENV HOST=0.0.0.0 \
    PORT=7860 \
    LOG_LEVEL=info \
    ENV_FILE=.env

# Command to run the backend application
CMD ["poetry", "run", "uvicorn", "--factory", "langflow.main:create_app", \
     "--host", "0.0.0.0", "--port", "7860", "--env-file", ".env", "--loop", "asyncio", "--reload"]
