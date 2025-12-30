# Makefile for Pierre Ollivier's Resume

# Variables
VENV_DIR = .venv
PYTHON = python3
PIP = $(VENV_DIR)/bin/pip
RENDERCV = $(VENV_DIR)/bin/rendercv
OUTPUT_DIR = rendercv_output

# Default target
all: english french

# Build English Resume
english: $(VENV_DIR)
	$(RENDERCV) render Pierre_Ollivier_CV_EN.yaml

# Build French Resume
french: $(VENV_DIR)
	$(RENDERCV) render Pierre_Ollivier_CV_FR.yaml

# Create Virtual Environment
venv:
	test -d $(VENV_DIR) || $(PYTHON) -m venv $(VENV_DIR)
	@echo "Virtual environment created in $(VENV_DIR)"

# Install Dependencies
install: venv
	$(PIP) install rendercv
	@echo "Dependencies installed."

# Helper to remind user how to activate venv
source:
	@echo "To activate the virtual environment, run:"
	@echo "source $(VENV_DIR)/bin/activate"

# Clean intermediate files (keep PDFs)
clean:
	@echo "Cleaning intermediate files..."
	find $(OUTPUT_DIR) -type f ! -name "*.pdf" -delete 2>/dev/null || true
	@echo "Done."

# Full Clean (remove output directory)
fclean:
	@echo "Removing output directory..."
	rm -rf $(OUTPUT_DIR)
	@echo "Done."

# Rebuild everything
re: fclean all

.PHONY: all english french venv install source clean fclean re
