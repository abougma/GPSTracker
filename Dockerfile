# Utiliser une image Node.js officielle comme image de base (choisissez une version LTS)
FROM node:18-alpine

# Définir le répertoire de travail dans le conteneur
WORKDIR /usr/src/app

# Installer expo-cli globalement
# Note: Si expo-cli est déjà une dépendance de développement de votre projet,
# cette étape globale pourrait ne pas être nécessaire si vous l'appelez via npx ou scripts npm.
# Cependant, pour un environnement de dev dédié, l'avoir globalement est courant.
RUN npm install -g expo-cli

# Copier package.json et package-lock.json (ou yarn.lock si vous utilisez yarn)
COPY package*.json ./

# Installer les dépendances du projet
RUN npm install

# Copier le reste des fichiers du projet dans le répertoire de travail
COPY . .

# Exposer les ports standard utilisés par Expo et Metro Bundler
EXPOSE 19000
EXPOSE 19001
EXPOSE 19002
# EXPOSE 8081 # Port de Metro Bundler, souvent géré par Expo CLI et accessible via les ports ci-dessus

# La commande par défaut pour démarrer l'application Expo.
# L'option --tunnel est fortement recommandée pour faciliter l'accès depuis un appareil mobile
# sans configuration réseau complexe lorsque l'on utilise Docker.
CMD ["expo", "start", "--tunnel"]