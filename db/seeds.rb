# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Log.create([
    {
        dia: '01/02/1991',
        hora: '00:09',
        contexto:'errado',
        tipo:1,
        mensagem: 'tudo errado'
    },
    {
        dia: '11/05/2017',
        hora: '13:49',
        contexto:'certo',
        tipo:2,
        mensagem: 'tudo certo'
    }



    ])
