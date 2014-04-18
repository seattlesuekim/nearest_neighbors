describe 'Neighbor' do
  it 'finds Linus Torvalds on Wikipedia' do
    expect Neighbor.find_vip('Linus Torvalds').to eq('http://en.wikipedia.org/wiki/Linus_Torvalds')
  end

  it 'finds the sigs on my key' do
    expect Neighbor.nearest_neighbors('bf392c79e90efce5', 1).to eq(['', ''])
  end

  it 'finds a name by keyid' do
    expect Neghbor.to_name('BF392C79E90EFCE5').to eq('Sue Ann White')
  end

end