#language: pt


# Você precisa pegar o primeiro livro que aparece no site da Submarino,
# salvar o nome do autor e o número ISBN.
# Depois você precisa ir em mais dois sites que vendam
# livros e fazer uma busca pelo número ISBN guardado.
# Após localizar o livro, clicar nele e verificar se o
# nome do autor é o mesmo que foi salvo no livro da Submarino.

Funcionalidade: Livro mais vendido
    Escolho o livro mais vendido
    Busco o ISBN
    Comparo com Amazon e Americanas

    Cenario: Livro

        Dado que eu busco o primeiro livro que aparece no site da Submarino
        Quando eu salvo o nome do autor e o ISBN
        Então eu confiro se o ISBN bate na Amazon
        E eu confiro se o ISBN bate nas Americanas