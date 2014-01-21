ImageViewer
===========
iOS  App    Test:    Image    Viewer 


Create  a    simple    image    viewer    app:    

•   Retrieve  the    list    of    images    from    here:    
http://dl.dropbox.com/u/89445730/images.json  
The  data    is    formatted    as    a    json-­‐encoded    string.   The    data    is    an    array    of    images.       Each    image    is    
represented  as    a    dictionary    with    three    elements:    “original”    the    url    for    the    original    image    
“thumbnail”    the    url    for    a    smaller    version    of    the    image    
“caption”    a    short    string    describing    the    image.        
•   The  original    and    thumbnail    images    may    have    various    aspect    ratios    and    widths    and    heights.    
•   Display  the    list    of    thumbnails    and    captions    in    a    TableView    
o Each  cell    should    contain    a    thumbnail    and    its    caption.    
o The  image    and    caption    should    both    be    left    aligned.    
o The  image    should    be    on    the    left,    the    caption    on    the    right.    
o The  thumbnail    should    be    resized    and    cropped    to    a    square    of    reasonable    size.       Either    the    
full  width    or    the    full    height    of    the    image    must    be    visible.    
o       There    should    be    reasonable    padding    among    the    image,    caption,    and    cell    boundaries.    
•   When  you    tap    on    a    cell    in    the    TableView,    a    new    View    should    appear    containing    the    original    
image  
o The  image    should    be    displayed    at    actual    size,    centered    on    the    screen    both    vertically    and    
horizontally.  
o If  the    image    is    larger    than    the    screen,    allow    the    user    to    scroll.    
o If  the    image    is   smaller    than    the    screen,    scrolling    should    be    disabled.    
o The  user    should    not    be    able    to    scroll    past    the    image    boundaries.    
o Initially,   do    not    display    the    Status    Bar    or    Navigation    Bar    
o When  the    user    taps    the    screen,    toggle    the    display    of    the    Status    and    Navigation    Bar.    
•   From  the    single    image    view,    make    sure    there    is    a    back    button    in    the    Navigation    Bar    so    users    can    
return  to    the    list    view.    
