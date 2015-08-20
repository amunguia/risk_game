 module Risk

  module Game

    module Board

      def self.adjacent_to country
        if @adjacent_map.keys.include? country
          (@adjacent_map[country]).map { |c| c } # copy the array0
        else
          raise CountryDoesNotExist
        end
      end

      def self.are_adjacent?(country1, country2)
        if !@adjacent_map.keys.include?(country1) || 
            !@adjacent_map.keys.include?(country2)
          raise CountryDoesNotExist
        end

        @adjacent_map[country1].include? country2
      end 

      def self.continents
        [Board.north_america, Board.south_america, Board.europe, Board.africa,
         Board.asia, Board.australia].zip(["North America", "South America",
          "Europe", "Africa", "Asia", "Australia"])
      end

      def self.continent_points(countries)
        points  = 0
        points += (africa - countries).empty? ? 3 : 0
        points += (asia - countries).empty? ? 7 : 0
        points += (australia - countries).empty? ? 2 : 0
        points += (europe - countries).empty? ? 5 : 0
        points += (north_america - countries).empty? ? 5 : 0
        points += (south_america - countries).empty? ? 2 : 0
        points
      end

      def self.countries
        @adjacent_map.keys
      end

      def self.name_for(country)
        if @name_map.keys.include? country 
          @name_map[country]
        else
          raise CountryDoesNotExist
        end
      end

      def self.points_for(countries)
        points = countries.length / 3
        points = points < 3 ? 3 : points
        points += continent_points countries

        points
      end

      def self.africa 
        [:congo, :east_af, :egypt, :madagascar, :north_af, :south_af]
      end

      def self.asia 
        [:afghanistan, :china, :india, :irkutsk, :japan, :kamchatka, :middle_ea, :mongolia, :siam, :siberia, :ural, :yakutsk]
      end

      def self.australia 
        [:eastern_au, :indonesia, :new_guinea, :western_au]
      end

      def self.europe 
        [:great_br, :iceland, :northern_eu, :scandanavia, :southern_eu, :ukraine, :western_eu]
      end

      def self.north_america
        [:alaska, :alberta, :central_am, :eastern_us, :greenland, :northwest_te, :ontario, :quebec, :western_us]
      end

      def self.south_america
        [:argentina, :brazil, :peru, :venezuela]
      end

      private 

      def self.build_adjacent_map
        @adjacent_map = {
            :alaska => [:kamchatka, :northwest_te, :alberta],
            :alberta => [:alaska, :northwest_te, :western_us, :ontario],
            :central_am => [:western_us, :eastern_us, :venezuela],
            :eastern_us => [:western_us, :central_am, :quebec, :ontario],
            :northwest_te => [:alaska, :alberta, :ontario, :greenland],
            :ontario => [:northwest_te, :alberta, :western_us, :eastern_us, :quebec, :greenland],
            :quebec => [:ontario, :eastern_us, :greenland],
            :western_us => [:alberta, :central_am, :eastern_us, :ontario],
            :greenland => [:northwest_te, :ontario, :quebec, :iceland],

            :argentina => [:peru, :brazil],
            :brazil => [:venezuela, :peru, :argentina, :north_af],
            :peru => [:venezuela, :argentina, :brazil],
            :venezuela => [:central_am, :peru, :brazil],

            :great_br => [:iceland, :western_eu, :northern_eu, :scandanavia],
            :iceland => [:greenland, :great_br, :scandanavia],
            :northern_eu => [:great_br, :western_eu, :southern_eu, :ukraine, :scandanavia],
            :scandanavia => [:iceland, :great_br, :northern_eu, :ukraine],
            :southern_eu => [:northern_eu, :western_eu, :north_af, :egypt, :middle_ea, :ukraine],
            :ukraine => [:scandanavia, :northern_eu, :southern_eu, :middle_ea, :afghanistan, :ural],
            :western_eu => [:great_br, :north_af, :southern_eu, :northern_eu],

            :congo => [:north_af, :south_af, :east_af],
            :east_af => [:north_af, :congo, :south_af, :madagascar, :middle_ea, :egypt],
            :egypt => [:north_af, :east_af, :middle_ea, :southern_eu],
            :north_af => [:brazil, :congo, :east_af, :egypt, :southern_eu, :western_eu],
            :south_af => [:congo, :madagascar, :east_af],
            :madagascar => [:south_af, :east_af],

            :afghanistan => [:ukraine, :middle_ea, :india, :china, :ural],
            :china => [:afghanistan, :india, :siam, :mongolia, :siberia, :ural],
            :india => [:middle_ea, :siam, :china, :afghanistan],
            :irkutsk => [:siberia, :mongolia, :kamchatka, :yakutsk],
            :japan => [:kamchatka, :mongolia],
            :kamchatka => [:yakutsk, :irkutsk, :mongolia, :japan, :alaska],
            :middle_ea => [:southern_eu, :egypt, :east_af, :india, :afghanistan, :ukraine],
            :mongolia => [:china, :japan, :kamchatka, :irkutsk, :siberia],
            :siam => [:india, :indonesia, :china],
            :siberia => [:ural, :china, :mongolia, :irkutsk, :yakutsk],
            :ural => [:ukraine, :afghanistan, :china, :siberia],
            :yakutsk => [:siberia, :irkutsk, :kamchatka],

            :eastern_au => [:western_au, :new_guinea],
            :indonesia => [:siam, :western_au, :new_guinea],
            :new_guinea => [:indonesia, :eastern_au, :western_au],
            :western_au => [:eastern_au, :new_guinea, :indonesia]
        }
      end

      def self.build_name_map
        @name_map = {
            :alaska => "Alaska",
            :alberta => "Alberta",
            :central_am => "Central America",
            :eastern_us => "Eastern US",
            :northwest_te => "Northwest Territory",
            :ontario => "Ontario",
            :quebec => "Quebec",
            :western_us => "Western US",
            :greenland => "Greenland",

            :argentina => "Argentina",
            :brazil => "Brazil",
            :peru => "Peru",
            :venezuela => "Venezuela",

            :great_br => "Great Britain",
            :iceland => "Iceland",
            :northern_eu => "Northern Europe",
            :scandanavia => "Scandanavia",
            :southern_eu => "Southern Europe",
            :ukraine => "Ukraine",
            :western_eu => "Western Europe",

            :congo => "Congo",
            :east_af => "East Africa",
            :egypt => "Egypt",
            :north_af => "North Africa",
            :south_af => "South Africa",
            :madagascar => "Madagascar",

            :afghanistan => "Afghanistan",
            :china => "China",
            :india => "India",
            :irkutsk => "Irkutsk",
            :japan => "Japan",
            :kamchatka => "Kamchatka",
            :middle_ea => "Middle East",
            :mongolia => "Mongolia",
            :siam => "Siam",
            :siberia => "Siberia",
            :ural => "Ural",
            :yakutsk => "Yakutsk",

            :eastern_au => "Eastern Australia",
            :indonesia => "Indonesia",
            :new_guinea => "New Guinea",
            :western_au => "Western Australia"
        }
      end

      build_name_map
      build_adjacent_map

    end

  end

end