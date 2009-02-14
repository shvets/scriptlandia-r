f = new File('inventory-tmp.xml').newWriter()
builder = new groovy.xml.MarkupBuilder(f)
builder.albums(owner:'James') {
        album(name:'Flowers') {
                photo(name:'rose.jpg')
        }
        album(name:'people') {
                photo(name:'john.jpg', desc:'picture of John')
        }
}
f.close()