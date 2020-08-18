using WebKit;

private WebKit.WebView webView;
private Gtk.HeaderBar headerBar;
private Gtk.Button backButton;
private Gtk.Button forwardButton;
private Gtk.Button refreshButton;
private Gtk.Button propertiesButton;
private Gtk.Button addTabButton;
private Gtk.SearchEntry url_bar;

private WebKit.WebContext webContext;
private WebKit.CookieManager cookieManager;

int main (string[] args) {
    Gtk.init(ref args);
        
    //Web View
    webContext = new WebKit.WebContext();
    cookieManager = webContext.get_cookie_manager();
    cookieManager.set_persistent_storage("cookies.txt", CookiePersistentStorage.TEXT);
    //Header bar
    headerBar = new Gtk.HeaderBar();
    //Main Window
    var mainWindow = new Gtk.Window(); mainWindow.destroy.connect(Gtk.main_quit);
    mainWindow.set_default_size(1280, 720);
    //Pack Start
    backButton = new Gtk.Button.from_icon_name("go-previous"); backButton.clicked.connect(webView.go_back);
    forwardButton = new Gtk.Button.from_icon_name("go-next"); forwardButton.clicked.connect(webView.go_forward);
    refreshButton = new Gtk.Button.from_icon_name("view-refresh") {margin_start = 5}; refreshButton.clicked.connect(webView.reload);
    //Pack End
    propertiesButton = new Gtk.Button.from_icon_name("open-menu");
    addTabButton = new Gtk.Button.from_icon_name("tab-new") {margin_end = 20};
    //Search bar in middle of header
    url_bar = new Gtk.SearchEntry() { margin_start = 40, margin_end = 5}; url_bar.activate.connect(url_search);
    url_bar.set_hexpand(true);

    var child1 = create_tabview_child();
    var child2 = create_tabview_child();

    var tabview = new Gtk.Notebook();
    tabview.append_page(child1, create_tabview_child_label("Tab 1"));
    tabview.append_page(child2, create_tabview_child_label("Tab 2"));

    //url_bar.set_text(webView.get_uri());

    headerBar.show_close_button = true;
    headerBar.set_title("KamalWeb");
    headerBar.set_custom_title(url_bar);
    mainWindow.set_titlebar(headerBar);

    headerBar.pack_start(backButton);
    headerBar.pack_start(forwardButton);
    headerBar.pack_start(refreshButton);
    headerBar.pack_end(propertiesButton);
    headerBar.pack_end(addTabButton);

    mainWindow.add(tabview);
    //mainWindow.add(webView);
    mainWindow.show_all();

    Gtk.main();

    return 0;
}

void url_search() {
    webView.load_uri(url_bar.get_text());
}

Gtk.Widget create_tabview_child()
{
    var child = new Gtk.ScrolledWindow (null, null);
    var webView = new WebKit.WebView.with_context(webContext);
    webView.load_uri("https://www.duckduckgo.com");
    child.add(webView);
    return child;
}

Gtk.Widget create_tabview_child_label(string text)
{
    var label = new Gtk.Label(text);
    var image = new Gtk.Image.from_icon_name("gtk-close", Gtk.IconSize.MENU);

    var button = new Gtk.Button();
    button.relief = Gtk.ReliefStyle.NONE;
    button.name = "close-tab-button";
    button.add(image);


    var box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 2);
    box.pack_start(label);
    box.pack_end(button);
    box.show_all();

    return box;
}