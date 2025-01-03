const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  darkMode: 'selector',
  content: [
    './app/**/*.{html,erb,js,css}',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './node_modules/flowbite/**/*.js',
  ],
  theme: {
    extend: {
      screens: {
        "smd": {"min": "489px"}
      },
      colors: {
        blue: {
          50:"#E5E7FF",
          100:"#D2D6FF",
          200:"#ACB3FF",
          300:"#8791FF",
          400:"#616EFF",
          500:"#3B4CFF",
          600:"#2F3FE5",
          700:"#2332CB",
          800:"#1825B1",
          900:"#0C1897"
        },
        gray: {
          50:"#F2F2F2",
          100:"#E4E4E4",
          200:"#CACACA",
          300:"#AFAFAF",
          400:"#959595",
          500:"#7A7A7A",
          600:"#626262",
          700:"#494949",
          800:"#222222",
          900:"#121212"
        },
        red: {
          50:"#FEF1EF",
          100:"#FEE4E0",
          200:"#FCC9C1",
          300:"#FBAEA2",
          400:"#F99383",
          500:"#F87864",
          600:"#FF4C4C",
          700:"#CC3D3D",
          800:"#992E2E",
          900:"#661E1E"
        },
        yellow: {
          50:"#FDF7DB",
          100:"#FCF3C9",
          200:"#FBEBA4",
          300:"#F9E47E",
          400:"#F6D434",
          500:"#D9BA2A",
          600:"#BCA021",
          700:"#9E8717",
          800:"#816D0E",
          900:"#736009"
        },
        green: {
          50:"#ECFAF3",
          100:"#DAF5E8",
          200:"#B5EBD1",
          300:"#8FE1BA",
          400:"#6AD7A3",
          500:"#45CD8C",
          600:"#37A470",
          700:"#297B54",
          800:"#1C5238",
          900:"#0E291C"
        },
        teal: {
          50:"#F6FDFE",
          100:"#EDFBFC",
          200:"#DCF6F9",
          300:"#CAF2F7",
          400:"#B9EDF4",
          500:"#A7E9F1",
          600:"#89CCD4",
          700:"#6AAFB7",
          800:"#4C929B",
          900:"#2D757E"
        },
        indigo: {
          50:"#F5F6FF",
          100:"#EAECFF",
          200:"#D6DAFF",
          300:"#C1C7FF",
          400:"#ADB5FF",
          500:"#98A2FF",
          600:"#7A84E2",
          700:"#5B66C5",
          800:"#3D47A9",
          900:"#1E298C"
        },
        pink: {
          50:"#FBF1FF",
          100:"#F7E2FF",
          200:"#F1CBFF",
          300:"#E8A9FF",
          400:"#E18DFF",
          500:"#D970FF",
          600:"#B85ADA",
          700:"#9743B5",
          800:"#762D91",
          900:"#55166C"
        },
      },
    },
    fontFamily: {
      sans: ['Roobert', 'sans-serif'],
    },
    backgroundImage: {
      'honey-comb': "url('/assets/images/honey-comb.png')",
    }
  },
  plugins: [
    require('flowbite/plugin')
  ]
}
