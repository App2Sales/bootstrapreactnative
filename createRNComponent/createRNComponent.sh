#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Passe o nome do seu componente como parâmetro!"
    exit 1
fi

if [ ! -d "App" ]; then
    echo "Diretório 'App' não encontrado. Você precisa estar na raiz do projeto!"
    exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir App/components/$* 
cd App/components/$* 
cp $DIR/componentTemplate.js ../$*
cp $DIR/index.js ../$*
cp $DIR/styles.js ../$*
mv componentTemplate.js $*.js
sed -i "s/componentTemplate/$*/g" $*.js 
sed -i "s/componentTemplate/$*/g" index.js
cd ../
sed -i "1 i\import $* from './$*';" index.js
sed -i "/\export {/a\    $*," index.js
echo "Componente criado com sucesso!"