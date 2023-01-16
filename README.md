# Fam CLI

Automate family team processes.

## Install

```bash
npm install git+<REPO_URL>
```

## Commands

```bash
fam --help
```

## Develop

1. Clone repo
2. `npm i` or `yarn`
3. `spago install`
4. `npm run dev` or `yarn dev`
5. `npm link``
6. Use as `fam <COMMAND>`

## Deploy

1. `npm run build` or `yarn build`
2. `npm run release` or `yarn release`

## How install purescript and spago?
1. `npm install -g purescript` or `yar add -g purescript`
2. `npm install -g spago` or `yarn add -g spago`

## Todo

1. Automate the creation of the changelog, it is already implemented but currently it is not using a universal convention due to the JIRA tag as a prefix.
