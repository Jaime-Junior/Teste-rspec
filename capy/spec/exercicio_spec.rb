# Você precisa pegar o primeiro livro que aparece no site da Submarino,
# salvar o nome do autor e o número ISBN.
# Depois você precisa ir em mais dois sites que vendam
# livros e fazer uma busca pelo número ISBN guardado.
# Após localizar o livro, clicar nele e verificar se o
# nome do autor é o mesmo que foi salvo no livro da Submarino.

describe "exercicio sub" do
  it "clicando em link" do
    visit "https://www.submarino.com.br/"
    find("a", text: "Livros").click
    all(".cYXniE").first.click
    tabela = all("table tbody tr")
    @autor = tabela.detect { |nome| nome.text.include?("Autor") }
    $nome = @autor.text.delete_prefix("Autor ")
    puts $nome
    @a = tabela.detect { |isbn10| isbn10.text.include?("ISBN-13") }
    $isbn = @a.text.delete_prefix("ISBN-13 ")
    $isbn2 = @a.text.delete_prefix("ISBN-13 ").insert(3, "-")
    puts $isbn #numero corrido
    puts $isbn2 #numero com traço
  end
  it "checando na amazon" do
    visit "https://www.amazon.com/"
    fill_in "twotabsearchtextbox", with: $isbn
    all("input[class='nav-input']").first.click
    all(".aok-relative").first.click
    expect(page).to have_content $isbn2
    expect(page).to have_content $nome
  end
  it "checando nas americanas" do
    visit "https://www.americanas.com.br/"
    find(".src-input-wpr #h_search-input").set $isbn
    click_button "h_search-btn"
    all(".jMrcKt .iXIDWU").first.click
    expect(page).to have_content $isbn
    expect(page).to have_content $nome
  end
end
