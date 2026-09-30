#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Setup script para o PDK comercial TSMC 65nm no OpenRAM
"""

import os

# ÂNCORA CRUCIAL: Diz ao OpenRAM que esta pasta é uma tecnologia válida
TECHNOLOGY = "tsmc65N"

# Configurações de ambiente para ferramentas seletivas (opcional)
os.environ["MGC_TMPDIR"] = "/tmp"

# Se o seu PDK depender de caminhos para simuladores (como Spectre ou HSPICE),
# ou caminhos para Calibre/Assura, você pode exportá-los aqui no futuro:
# os.environ["SPICE_MODEL_DIR"] = "/caminho/para/modelos/tsmc65"

