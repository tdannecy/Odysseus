/**
* This file is part of Odysseus Web Browser (Copyright Adrian Cochrane 2018).
*
* Odysseus is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Odysseus is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.

* You should have received a copy of the GNU General Public License
* along with Odysseus.  If not, see <http://www.gnu.org/licenses/>.
*/
public void gtk_module_init ([CCode (array_length_cname = "argc", array_length_pos = 0.5)] ref unowned string[]? argv) {
    // Make sure that the Soup.Session class is available.
    (typeof(Soup.Session)).class_ref();

    // For each new Soup.Session, give it cookies. 
    var signal_id = Signal.lookup("connection-created", typeof(Soup.Session));
    Signal.add_emission_hook(signal_id, 0, (ihint, param_values) => {
        var self = (Soup.Session) param_values[0];
        var cookie_trail = Path.build_path(Path.DIR_SEPARATOR_S,
                Environment.get_user_config_dir(), "com.github.alcinnz.odysseus", "ui.sqlite");
        self.add_feature(new CookieJarDB(cookie_trail, true));
    });
}
