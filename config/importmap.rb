# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin '@rails/activestorage', to: 'activestorage.esm.js'
pin 'flowbite', to: 'https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.turbo.min.js'
