from setuptools import setup
setup(
    name="bdafinal",
    packages=["bdafinal"],
    version="0.0.1.dev1",
    description="Bayesian Data Analysis - Final Project",
    author="Fabio Colella, Michele Vantini",
    author_email="fabio.colella@aalto.fi, michele.vantini@aalto.fi",
    url="https://github.com/fcole90/bdafinal",
    download_url="https://github.com/fcole90/bdafinal",
    keywords=["bayesian", "data", "analysis", "death", "diseases"],
    classifiers=[
        "Development Status :: 1 - Planning",
        "Environment :: Console",
        "Intended Audience :: Developers",
        "Intended Audience :: Science/Research"
        "License :: OSI Approved :: MIT License",
        "Natural Language :: English",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3",
        "Topic :: Scientific/Engineering"
        ],
    long_description="""\
Algorithmic Methods of Data Mining - Final Project
""",
    install_requires=['jupyter',
                      'matplotlib',
                      'pystan',
                      'numpy'],
    python_requires='>=3.4'
)
