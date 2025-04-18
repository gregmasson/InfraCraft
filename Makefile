# Nom du dossier de l'environnement virtuel
VENV_DIR := .venv
ACTIVATE := $(VENV_DIR)/bin/activate

.PHONY: init install run freeze clean

# Initialisation complète du projet
init:
	@echo "📦 Creating virtual environment..."
	python3 -m venv $(VENV_DIR)
	@echo "🚀 Activating and upgrading pip..."
	$(ACTIVATE) && python -m pip install --upgrade pip
	@echo "⚙️  Installing FastAPI and dependencies..."
	$(ACTIVATE) && pip install fastapi uvicorn[standard] python-multipart pillow
	@echo "📝 Freezing dependencies to requirements.txt..."
	$(ACTIVATE) && pip freeze > requirements.txt
	@echo "✅ Project initialized successfully."

# Installation des dépendances à partir du requirements.txt
install:
	@echo "📚 Installing from requirements.txt..."
	$(ACTIVATE) && pip install -r requirements.txt

# Lancer l'application FastAPI en mode dev
run:
	@echo "🚀 Running FastAPI server..."
	$(ACTIVATE) && uvicorn app.main:app --reload

# Sauvegarder les dépendances dans requirements.txt
freeze:
	@echo "📦 Freezing current environment..."
	$(ACTIVATE) && pip freeze > requirements.txt

# Nettoyer l'environnement virtuel
clean:
	@echo "🧹 Removing virtual environment..."
	rm -rf $(VENV_DIR)
