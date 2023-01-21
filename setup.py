from pathlib import Path

from setuptools import setup

# Loading packages from requirements.txt
BASE_DIR = Path(__file__).parent
with open(Path(BASE_DIR, "requirements.txt"), "r") as file:
    required_packages = [ln.strip() for ln in file.readlines()]

# Packages required for documentation

docs_packages = ["mkdocs==1.3.0", "mkdocstrings==0.18.1"]

style_packages = ["black==22.3.0", "flake8==3.9.2", "isort==5.10.1", "black[jupyter]"]

test_packages = ["pytest==7.2.1", "pytest-cov==4.0.0", "great-expectations==0.15.44",
    "pre-commit==2.21.0"]

setup(
    name="classifyops",
    version=0.1,
    description="Classify ML projects.",
    author="Octave Antoni",
    author_email="octave.antoni@gmail.com",
    url="https://github.com/Faskill/MLOps-Text-Classification",
    python_requires=">=3.9",
    py_modules=[],
    install_requires=[required_packages],
    extras_require={
        "dev": docs_packages + style_packages + test_packages,
        "docs": docs_packages,
        "test": test_packages,
    },
)
