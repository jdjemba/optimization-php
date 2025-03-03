# Web performances optimization <!-- omit in toc -->

## Table of content <!-- omit in toc -->

- [About this exercice](#about-this-exercice)
- [Pre requisite](#pre-requisite)
- [How to install](#how-to-install)
- [Objectives](#objectives)
  - [Notation](#notation)
    - [Analysis document](#analysis-document-10)
    - [Programming fixes](#programming-fixes-10)
- [Rendu](#rendu)

## Pre requisite

You need to have these installed on your machine :

- docker engine
- docker compose
- psql

## Objective

You have been contacted by the maintainer of this application to improve the performances of the page `/carousel`. The maintainer notices that, after a rewrite of the website, there are little to none visitors. It impacts the revenue of its shop.

Your goal is to analyze the webpage to spot what could lead to its poor performances, how would you fix them, and try to fix them.

The application has been written in PHP with Symfony 7 and is using Tailwindcss. It pulls data from a postgresql database.

Everything is hosted on a singular VPS, which has 2 CPU cores and 2Go of RAM. The VPS is located in Canada (North America).

You only have access to the application source code and the database. You don't have access to the server that host.

### Notation

#### Analysis document /10

#### Analysis document /10
Permalink: Analysis document /10
- intro
  - why performance is important: Une application lente va frustrer puis repousser les utilisateurs, donc diminuer les revenus.
- hypothesis
  - what is wrong with the application:
    #### Le chargement des assets
    - Les fichiers medias, CSS et JS sont longs à charger pour le navigateur
- tests and measurements
  - what metrics confirm your hypothesis
    - Performance : 42
    - Largest Contentful Paint = 12.0 s
    - Total Blocking Time = 1,470 ms
  - what tools you will use to measure/test
    - Googe Lighthouse extension
- solutions
  - what immediate programming solutions could fix the application
    - Preload des images
    - Compression des assets
    - Taille fixe des images ?
- conclusion
  - new measurements to confirm your solutions:
    - Performance de 75
    - First Contentful Paint = 1.3 s
    - Largest Contentful Paint = 10.5 s
    - Total Blocking Time = 0 ms
    - Cumulative Layout Shift = 0
    - Speed Index = 1.3 s
      ![fork button](assets/after.png)
    - ![fork button](assets/after2.png)

  - what could be done in the future to improve the performances again:
    - Stocker les assets sur un CDN et faire du dns-prefetch sur les assets
    - Re-localiser le VPS du Canada vers Francfort car site francais (même si potentiellement canadien francais)
    - Augmenter la ram pour 2GB a 4GB (Hetzner)

#### Programming fixes /10

The pull request containing the programming solutions you chose to do in your analysis document. 

## Installation

```bash
# Step 1 : download the project

git clone https://github.com/<your-username>/optimization-php

cd optimization-php

# Step 2 : initialize the docker containers

docker compose up -d --build

docker compose exec optimization-php composer install

# Step 3 : initialize the database

docker compose exec optimization-php bin/console d:d:c

psql postgres://postgres:password@localhost/guitareboissieres -f app/var/db.sql

# Step 4 : start the web server

docker compose exec optimization-php php -s 0.0.0.0:8000 -t public/
```

Your application should now be live at `http://127.0.0.1:8888/carousel`

## How to submit

Fork this project by clicking on this button :

![fork button](assets/fork.png)

Github will clone this repository on your account so you won't modify this template.

Once the execice is done, you will do a Pull Request from the Github page of your repository

![pull request](assets/PR.png)

The title of your Pull Request must contain your name, you firstname and you class.
