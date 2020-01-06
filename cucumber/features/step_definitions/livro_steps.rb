Dado("que eu busco o primeiro livro que aparece no site da Submarino") do
  visit "https://www.submarino.com.br/"
  find("a", text: "Livros").click
  all(".cYXniE").first.click
  tabela = all("table tbody tr")
  @autor = tabela.detect { |nome| nome.text.include?("Autor") }
  $nome = @autor.text.delete_prefix("Autor ")
  puts $nome
  @a = tabela.detect { |isbn10| isbn10.text.include?("ISBN-13") }
end

Quando("eu salvo o nome do autor e o ISBN") do
  $isbn = @a.text.delete_prefix("ISBN-13 ")
  $isbn2 = @a.text.delete_prefix("ISBN-13 ").insert(3, "-")
  puts $isbn #numero corrido
  puts $isbn2 #numero com traço
end

Então("eu confiro se o ISBN bate na Amazon") do
  visit "https://www.amazon.com/"
  fill_in "twotabsearchtextbox", with: $isbn
  all("input[class='nav-input']").first.click
  all(".aok-relative").first.click
  expect(page).to have_content $isbn2
  expect(page).to have_content $nome
end

Então("eu confiro se o ISBN bate nas Americanas") do
  visit "https://www.americanas.com.br/"
  find(".src-input-wpr #h_search-input").set $isbn
  click_button "h_search-btn"
  all(".jMrcKt .iXIDWU").first.click
  expect(page).to have_content $isbn
  expect(page).to have_content $nome
end
