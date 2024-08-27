require "spec_helper"
require "australia/postcode"

RSpec.describe Australia::Postcode do
  describe ".find" do
    it "finds the postcode" do
      postcodes = Australia::Postcode.find(4000)
      expect(postcodes.size).to eq(3)

      postcode = postcodes.first
      expect(postcode.suburb).to eq("BRISBANE")
      expect(postcode.latitude).to eq(-27.46758)
      expect(postcode.longitude).to eq(153.027892)
    end
  end

  describe "#nearby" do
    let(:postcode) { Australia::Postcode.find(4000).first }

    it "finds all postcodes within 3 km" do
      others = postcode.nearby(distance: 3)
      expect(others.map(&:suburb)).to eq(["BRISBANE", "BRISBANE ADELAIDE STREET", "SPRING HILL", "NEW FARM", "BOWEN HILLS", "FORTITUDE VALLEY", "HERSTON", "NEWSTEAD", "KELVIN GROVE", "RED HILL", "MILTON", "PADDINGTON", "HIGHGATE HILL", "SOUTH BRISBANE", "WEST END", "WOOLLOONGABBA", "EAST BRISBANE", "KANGAROO POINT"])
    end

    it "finds all postcodes within 5 km" do
      others = postcode.nearby(distance: 5)
      expect(others.map(&:suburb)).to eq(["BRISBANE", "BRISBANE ADELAIDE STREET", "SPRING HILL", "NEW FARM", "BOWEN HILLS", "FORTITUDE VALLEY", "HERSTON", "NEWSTEAD", "HAMILTON", "ALBION", "WINDSOR", "GRANGE", "NEWMARKET", "WILSTON", "KELVIN GROVE", "RED HILL", "ASHGROVE", "MILTON", "PADDINGTON", "BARDON", "AUCHENFLOWER", "TOOWONG", "ST LUCIA", "ST LUCIA SOUTH", "HIGHGATE HILL", "SOUTH BRISBANE", "WEST END", "BURANDA", "DUTTON PARK", "WOOLLOONGABBA", "ANNERLEY", "FAIRFIELD", "FAIRFIELD GARDENS", "STONES CORNER", "COORPAROO", "EAST BRISBANE", "KANGAROO POINT", "MORNINGSIDE", "NORMAN PARK", "BALMORAL", "BULIMBA", "HAWTHORNE"])
    end

    it "finds all postcodes within 10 km" do
      others = postcode.nearby(distance: 10)
      expect(others.map(&:suburb)).to eq(["BRISBANE", "BRISBANE ADELAIDE STREET", "SPRING HILL", "NEW FARM", "BOWEN HILLS", "FORTITUDE VALLEY", "HERSTON", "NEWSTEAD", "ASCOT", "HAMILTON", "EAGLE FARM", "ALBION", "CLAYFIELD", "HENDRA", "NUNDAH", "TOOMBUL", "WAVELL HEIGHTS", "WAVELL HEIGHTS NORTH", "NORTHGATE", "LUTWYCHE", "WINDSOR", "WOOLOOWIN", "GORDON PARK", "KEDRON", "CHERMSIDE", "CHERMSIDE CENTRE", "CHERMSIDE SOUTH", "CHERMSIDE WEST", "ALDERLEY", "ENOGGERA", "GAYTHORNE", "GRANGE", "NEWMARKET", "WILSTON", "BROOKSIDE CENTRE", "EVERTON PARK", "MITCHELTON", "STAFFORD", "STAFFORD HEIGHTS", "KEPERRA", "KELVIN GROVE", "RED HILL", "ASHGROVE", "ASHGROVE WEST", "THE GAP", "MILTON", "PADDINGTON", "BARDON", "AUCHENFLOWER", "MOUNT COOT-THA", "TOOWONG", "ST LUCIA", "ST LUCIA SOUTH", "CHELMER", "INDOOROOPILLY", "INDOOROOPILLY CENTRE", "TARINGA", "CHAPEL HILL", "FIG TREE POCKET", "KENMORE", "KENMORE EAST", "CORINDA", "GRACEVILLE", "GRACEVILLE EAST", "SHERWOOD", "HIGHGATE HILL", "SOUTH BRISBANE", "WEST END", "BURANDA", "DUTTON PARK", "WOOLLOONGABBA", "ANNERLEY", "FAIRFIELD", "FAIRFIELD GARDENS", "YERONGA", "MOOROOKA", "TENNYSON", "YEERONGPILLY", "BRISBANE MARKET", "ROCKLEA", "SALISBURY", "SALISBURY EAST", "NATHAN", "GREENSLOPES", "STONES CORNER", "HOLLAND PARK", "HOLLAND PARK EAST", "HOLLAND PARK WEST", "TARRAGINDI", "WELLERS HILL", "MOUNT GRAVATT", "MOUNT GRAVATT EAST", "COORPAROO", "CAMP HILL", "CARINA", "CARINA HEIGHTS", "CARINDALE", "EAST BRISBANE", "KANGAROO POINT", "CANNON HILL", "MORNINGSIDE", "NORMAN PARK", "SEVEN HILLS", "BALMORAL", "BULIMBA", "HAWTHORNE", "MURARRIE"])
    end

    it "finds all postcodes within 20 km" do
      others = postcode.nearby(distance: 20)
      expect(others.map(&:suburb)).to eq(["BRISBANE", "BRISBANE ADELAIDE STREET", "SPRING HILL", "NEW FARM", "BOWEN HILLS", "FORTITUDE VALLEY", "HERSTON", "NEWSTEAD", "ASCOT", "HAMILTON", "PINKENBA", "EAGLE FARM", "ALBION", "CLAYFIELD", "HENDRA", "NUNDAH", "TOOMBUL", "WAVELL HEIGHTS", "WAVELL HEIGHTS NORTH", "NORTHGATE", "BANYO", "NUDGEE", "NUDGEE BEACH", "VIRGINIA", "BRACKEN RIDGE", "BRIGHTON", "BRIGHTON NATHAN STREET", "DEAGON", "SANDGATE", "SHORNCLIFFE", "FITZGIBBON", "TAIGUM", "LUTWYCHE", "WINDSOR", "WOOLOOWIN", "GORDON PARK", "KEDRON", "CHERMSIDE", "CHERMSIDE CENTRE", "CHERMSIDE SOUTH", "CHERMSIDE WEST", "ASPLEY", "BOONDALL", "CARSELDINE", "GEEBUNG", "ZILLMERE", "ALBANY CREEK", "BRIDGEMAN DOWNS", "BALD HILLS", "EATONS HILL", "ALDERLEY", "ENOGGERA", "GAYTHORNE", "GRANGE", "NEWMARKET", "WILSTON", "BROOKSIDE CENTRE", "EVERTON HILLS", "EVERTON PARK", "MCDOWALL", "MITCHELTON", "STAFFORD", "STAFFORD HEIGHTS", "ARANA HILLS", "KEPERRA", "BUNYA", "FERNY GROVE", "FERNY HILLS", "UPPER KEDRON", "KELVIN GROVE", "RED HILL", "ASHGROVE", "ASHGROVE WEST", "THE GAP", "MILTON", "PADDINGTON", "BARDON", "AUCHENFLOWER", "MOUNT COOT-THA", "TOOWONG", "ST LUCIA", "ST LUCIA SOUTH", "CHELMER", "INDOOROOPILLY", "INDOOROOPILLY CENTRE", "TARINGA", "BROOKFIELD", "CHAPEL HILL", "FIG TREE POCKET", "KENMORE", "KENMORE EAST", "KENMORE HILLS", "PINJARRA HILLS", "PULLENVALE", "UPPER BROOKFIELD", "ANSTEAD", "BELLBOWRIE", "MOGGILL", "SEVENTEEN MILE ROCKS", "SINNAMON PARK", "JAMBOREE HEIGHTS", "JINDALEE", "MIDDLE PARK", "MOUNT OMMANEY", "RIVERHILLS", "SUMNER", "WESTLAKE", "CORINDA", "GRACEVILLE", "GRACEVILLE EAST", "OXLEY", "SHERWOOD", "DARRA", "WACOL", "DOOLANDELLA", "DURACK", "INALA", "INALA EAST", "INALA HEIGHTS", "RICHLANDS", "ELLEN GROVE", "FOREST LAKE", "HIGHGATE HILL", "SOUTH BRISBANE", "WEST END", "BURANDA", "DUTTON PARK", "WOOLLOONGABBA", "ANNERLEY", "FAIRFIELD", "FAIRFIELD GARDENS", "YERONGA", "MOOROOKA", "TENNYSON", "YEERONGPILLY", "BRISBANE MARKET", "ROCKLEA", "SALISBURY", "SALISBURY EAST", "ARCHERFIELD", "COOPERS PLAINS", "MACGREGOR", "ROBERTSON", "SUNNYBANK", "SUNNYBANK HILLS", "SUNNYBANK SOUTH", "ACACIA RIDGE", "HEATHWOOD", "LARAPINTA", "PALLARA", "WILLAWONG", "NATHAN", "KURABY", "EIGHT MILE PLAINS", "RUNCORN", "WOODRIDGE", "ALGESTER", "PARKINSON", "CALAMVALE", "DREWVALE", "STRETTON", "BERRINBA", "KARAWATHA", "UNDERWOOD", "GREENSLOPES", "STONES CORNER", "HOLLAND PARK", "HOLLAND PARK EAST", "HOLLAND PARK WEST", "TARRAGINDI", "WELLERS HILL", "MANSFIELD", "MOUNT GRAVATT", "MOUNT GRAVATT EAST", "UPPER MOUNT GRAVATT", "WISHART", "ROCHEDALE", "ROCHEDALE SOUTH", "PRIESTDALE", "SLACKS CREEK", "SPRINGWOOD", "COORPAROO", "CAMP HILL", "CARINA", "CARINA HEIGHTS", "CARINDALE", "BELMONT", "GUMDALE", "RANSOME", "WAKERLEY", "BURBANK", "MACKENZIE", "CAPALABA", "CAPALABA WEST", "THORNESIDE", "BIRKDALE", "ALEXANDRA HILLS", "EAST BRISBANE", "KANGAROO POINT", "CANNON HILL", "MORNINGSIDE", "NORMAN PARK", "SEVEN HILLS", "BALMORAL", "BULIMBA", "HAWTHORNE", "MURARRIE", "TINGALPA", "HEMMANT", "LYTTON", "PORT OF BRISBANE", "WYNNUM", "WYNNUM NORTH", "WYNNUM PLAZA", "WYNNUM WEST", "LOTA", "MANLY", "MANLY WEST", "CAROLE PARK", "GAILES", "BRENDALE", "STRATHPINE", "STRATHPINE CENTRE", "CAMP MOUNTAIN", "DRAPER", "ENOGGERA RESERVOIR", "SAMFORD VILLAGE", "WIGHTS MOUNTAIN"])
    end
  end
end
