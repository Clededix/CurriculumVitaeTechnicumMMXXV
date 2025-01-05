FROM ruby:3.2

# Mise à jour et installation des dépendances de base
# la plupart seront déjà installées sur W
RUN apt-get update -y && \
    apt-get install -y \
    build-essential \
    nodejs \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Définition du répertoire de travail
WORKDIR /usr/src/app

# Copier le Gemfile et Gemfile.lock pour tirer parti du cache Docker
COPY Gemfile Gemfile.lock ./

# Installation de Bundler et des gems
RUN gem install bundler && \
    bundle install

# Exposition du port utilisé par Jekyll
EXPOSE 4000

# Commande pour démarrer Jekyll
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]

# \ : pour continuer sur la ligne suivante lorsqu une cmde est trop longue
# aide la lisibilité