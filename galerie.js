// Generated by CoffeeScript 1.7.1
(function() {
  var Bild, bild, bilder, bilderDir, bilderEndung, urlPrefix, _i, _len, _ref;

  bilderDir = 'pixel/';

  bilderEndung = '.jpg';

  urlPrefix = 'http://www.heise.de/artikel-archiv/ct/';

  bilder = [
    {
      id: 201319172,
      name: 'Telefonbau'
    }, {
      id: 201320132,
      name: 'Browser-Feuerwerk'
    }, {
      id: 201321108,
      name: 'Soziales privatisieren'
    }, {
      id: 201326182,
      name: 'HTML maßgeschneidert'
    }, {
      id: 201326186,
      name: 'Rock\'n\'Scroll'
    }
  ];

  Bild = (function() {
    Bild.prototype.regex = /(^\d{4})(\d{2})0*(\d{1,3}$)/;

    Bild.prototype.counterAdd = function() {
      return Bild.counter++;
    };

    function Bild(params) {
      var treffer;
      this.name = params.name, this.id = params.id;
      this.nummer = this.counterAdd;
      this.bild = "" + bilderDir + this.id + bilderEndung;
      treffer = ("" + this.id).match(this.regex);
      if (treffer == null) {
        treffer = (function() {
          var _i, _results;
          _results = [];
          for (_i = 0; _i <= 3; _i++) {
            _results.push('unbekannt');
          }
          return _results;
        })();
      }
      this.ausgabe = "c't " + treffer[2] + "/" + treffer[1] + ", Seite " + treffer[3];
      this.url = urlPrefix + treffer.slice(1, 4).join('/');
    }

    return Bild;

  })();

  window.cs = {
    bilder: [],
    galerie: function(bildnr) {
      var container, next, prev;
      if (bildnr == null) {
        bildnr = 0;
      }
      container = document.getElementById('galerie');
      prev = bildnr < 1 ? this.bilder.length - 1 : bildnr - 1;
      next = bildnr + 1 >= this.bilder.length ? 0 : bildnr + 1;
      return container.innerHTML = "<figcaption>\n	<h3>Bild " + (bildnr + 1) + " von " + this.bilder.length + ":</h3>\n	<h2>" + this.bilder[bildnr].name + "</h2>\n	<small>erschienen in: <a href='" + this.bilder[bildnr].url + "'>" + this.bilder[bildnr].ausgabe + "</a></small>\n</figcaption>\n<div>\n	<span onclick='window.cs.galerie(" + prev + ")' title='Bild " + (prev + 1) + "'>Zurück</span>\n	<img src='" + this.bilder[bildnr].bild + "' alt=\"" + this.bilder[bildnr].name + "\"/>\n	<span onclick='window.cs.galerie(" + next + ")' title='Bild " + (next + 1) + "'>Weiter</span>\n</div>";
    }
  };

  for (_i = 0, _len = bilder.length; _i < _len; _i++) {
    bild = bilder[_i];
    window.cs.bilder.push(new Bild({
      name: bild.name,
      id: bild.id
    }));
  }

  if ((_ref = window.cs) != null) {
    _ref.galerie(0);
  }

}).call(this);

//# sourceMappingURL=galerie.map