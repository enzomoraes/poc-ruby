# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# db/seeds.rb

# Cria as marcas
nvidia = Brand.create(name: "NVIDIA", description: "Empresa líder em placas de vídeo.", active: true)
amd = Brand.create(name: "AMD", description: "Fabricante de processadores e placas de vídeo.", active: true)
intel = Brand.create(name: "Intel", description: "Principal fabricante de processadores.", active: true)

# Cria os produtos com a associação à marca
Product.create([
  {
    name: "NVIDIA GeForce RTX 4090",
    description: "Placa de vídeo de alto desempenho para jogos com suporte a ray tracing e DLSS.",
    price: 15990000, # R$ 15.990,00
    model: "RTX 4090",
    active: true,
    brand: nvidia
  },
  {
    name: "AMD Ryzen 9 7950X",
    description: "Processador com 16 núcleos e 32 threads, ideal para multitarefas pesadas.",
    price: 7990000, # R$ 7.990,00
    model: "Ryzen 9 7950X",
    active: true,
    brand: amd
  },
  {
    name: "Intel Core i9-13900K",
    description: "CPU de alto desempenho para jogos e cargas de trabalho criativas.",
    price: 6990000, # R$ 6.990,00
    model: "i9-13900K",
    active: true,
    brand: intel
  },
  {
    name: "NVIDIA GeForce RTX 3080 Ti",
    description: "Placa de vídeo para jogos de última geração com soluções de resfriamento avançadas.",
    price: 11990000, # R$ 11.990,00
    model: "RTX 3080 Ti",
    active: true,
    brand: nvidia
  },
  {
    name: "AMD Ryzen 7 5800X",
    description: "Processador com 8 núcleos e 16 threads, ideal para jogos e multitarefa.",
    price: 2899000, # R$ 2.899,00
    model: "Ryzen 7 5800X",
    active: true,
    brand: amd
  },
  {
    name: "Intel Core i7-12700K",
    description: "Processador de alto desempenho para gamers e criadores de conteúdo.",
    price: 3990000, # R$ 3.990,00
    model: "i7-12700K",
    active: true,
    brand: intel
  },
  {
    name: "NVIDIA GeForce RTX 3060",
    description: "Placa de vídeo de médio alcance para jogos com excelente custo-benefício.",
    price: 2599000, # R$ 2.599,00
    model: "RTX 3060",
    active: true,
    brand: nvidia
  },
  {
    name: "AMD Ryzen 5 5600X",
    description: "Processador com 6 núcleos e 12 threads, ideal para jogos e tarefas diárias.",
    price: 1499000, # R$ 1.499,00
    model: "Ryzen 5 5600X",
    active: true,
    brand: amd
  },
  {
    name: "Intel Core i5-12600K",
    description: "Processador de alto desempenho com excelente eficiência energética.",
    price: 2299000, # R$ 2.299,00
    model: "i5-12600K",
    active: true,
    brand: intel
  },
  {
    name: "NVIDIA GeForce RTX 3070",
    description: "Placa de vídeo de alto desempenho para jogos com suporte a ray tracing.",
    price: 4399000, # R$ 4.399,00
    model: "RTX 3070",
    active: true,
    brand: nvidia
  },
  {
    name: "AMD Ryzen 9 5900X",
    description: "Processador com 12 núcleos e 24 threads, ideal para multitarefas e jogos.",
    price: 3499000, # R$ 3.499,00
    model: "Ryzen 9 5900X",
    active: true,
    brand: amd
  },
  {
    name: "Intel Core i3-12100F",
    description: "Processador de entrada com 4 núcleos e 8 threads, ideal para tarefas do dia a dia.",
    price: 899000, # R$ 899,00
    model: "i3-12100F",
    active: true,
    brand: intel
  },
  {
    name: "NVIDIA GeForce GTX 1660 Super",
    description: "Placa de vídeo de nível intermediário com ótimo desempenho em jogos.",
    price: 1899000, # R$ 1.899,00
    model: "GTX 1660 Super",
    active: true,
    brand: nvidia
  },
  {
    name: "AMD Ryzen 3 3300X",
    description: "Processador de 4 núcleos e 8 threads, ideal para jogos e multitarefas leves.",
    price: 1299000, # R$ 1.299,00
    model: "Ryzen 3 3300X",
    active: true,
    brand: amd
  },
  {
    name: "Intel Core i9-11900K",
    description: "Processador de alto desempenho para gamers e criadores de conteúdo exigentes.",
    price: 5799000, # R$ 5.799,00
    model: "i9-11900K",
    active: true,
    brand: intel
  }
])
