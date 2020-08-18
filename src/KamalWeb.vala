using WebKit;

public class Main : Gtk.Application {

    protected override void activate () {
        var mainWindow = new Gtk.ApplicationWindow (this) {
            default_height = 720,
            default_width = 1280
        };
        
        //Web View
        var webView = new WebView();
        //Header bar
        var headerBar = new Gtk.HeaderBar();
        //Pack Start
        var backButton = new Gtk.Button.from_icon_name("go-previous");
        var forwardButton = new Gtk.Button.from_icon_name("go-next");
        var refreshButton = new Gtk.Button.from_icon_name("view-refresh") {margin_start = 5};
        //Pack End
        var propertiesButton = new Gtk.Button.from_icon_name("open-menu");
        //Search bar in middle of header
        var url_bar = new Gtk.SearchEntry() { margin_start = 40, margin_end = 40 };
        url_bar.set_hexpand(true);
        
        webView.load_uri("https://www.duckduckgo.com");
        url_bar.set_text(webView.get_uri());

        headerBar.show_close_button = true;
        headerBar.set_title("KamalWeb");
        headerBar.set_custom_title(url_bar);
        mainWindow.set_titlebar(headerBar);

        headerBar.pack_start(backButton);
        headerBar.pack_start(forwardButton);
        headerBar.pack_start(refreshButton);
        headerBar.pack_end(propertiesButton);
        mainWindow.add(webView);
        mainWindow.show_all();
    }

    public static int main (string[] args) {
        return new Main().run (args);
    }
}