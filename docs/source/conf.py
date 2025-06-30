
# -- Path setup --------------------------------------------------------------

import os
import sys
sys.path.insert(0, os.path.abspath('../..'))  # 项目根目录，确保可以导入项目模块

# -- Project information -----------------------------------------------------

project = 'statserver'
copyright = '2025, statml'
author = 'statml'
release = '0.2.0'

# -- General configuration ---------------------------------------------------

extensions = [
    'myst_parser',                # 替代 recommonmark
    'sphinx_markdown_tables',
    'sphinx.ext.autosectionlabel',
]

# 支持的文档后缀
source_suffix = ['.rst', '.md']

# 自动为标题添加编号，方便 crossref
autosectionlabel_prefix_document = True

# -- Options for HTML output -------------------------------------------------

import sphinx_rtd_theme

html_theme = 'sphinx_rtd_theme'
html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]

# -- myst-parser 配置 -------------------------------------------------------

myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "html_admonition",
    "html_image",
    "linkify",
    "replacements",
    "smartquotes",
    "substitution",
    "tasklist",
]

# -- 其他可选配置 ------------------------------------------------------------

# suppress warnings about duplicate labels (来自autosectionlabel)
suppress_warnings = ['autosectionlabel.*']

