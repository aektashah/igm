export MIX_ENV=prod

echo "Generating release..."

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

echo "Deploying..."

rm ../..twim.tar.gz
cp _build/prod/rel/twim/releases/0.0.1/twim.tar.gz ../../
cd ../..
rm -R twim
mkdir twim
cd twim
tar xzvf ../twim.tar.gz
rm ../twim.tar.gz
PORT=9000 ./bin/twim start

echo "You're all set!"
