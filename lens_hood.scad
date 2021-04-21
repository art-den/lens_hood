// Canon 200mm L II config

d1 = 83.4;
h1 = 5;
h2 = 7;

d4 = 81;
l_cnt = 2;
l_a = 80;
h6 = 1.3;

d2 = 85;
d3 = 100;
l1 = 0.8;
h3 = 120;

l2 = 2;
h4 = 1.6;
h5 = 4;

$fn = 128;

module figure_2d()
{
    a = atan2(d3/2 - d2/2, h3 - h2);
    w = l1*cos(a);
    
    polygon([
        [d1/2, 0],
        [d1/2, h1],
        [d2/2, h1],
        [d2/2, h2],
        
        [d2/2+l2, h2],
        
        [d3/2+l2, h3],
        [d3/2+l2+w, h3],
        
        [d2/2+l2+w, h2],
        [d2/2+l2+w, 0],
    ]);

    y1 = h2+h5;
    y2 = h3;
    x1 = d2/2;
    x2 = d3/2;
    for (y = [y1:h5:y2])
    {
        x = (y - y1) * (x2 - x1) / (y2 - y1) + x1;
        
        polygon([
            [x, y],
            [x+l2+0.3, y],
            [x+l2+0.2, y-h4]
        ]);
    }
}

module lens_hood()
{
    rotate_extrude() 
        figure_2d();
    
    for (i = [0:l_cnt-1])
    {
        angle = i * 360 / l_cnt;
        
        rotate([0, 0, angle])
            rotate_extrude(angle = l_a)
                translate([d4/2, 0])
                    square([(d1-d4)/2+0.5, h6]);
    }
    
    for (i = [0 : 29])
        rotate([0, 0, 360*i/30])
            translate([d2/2+l2+l1, 0, 0])
                cylinder(d = 4, h = h2, $fn = 16);
}

lens_hood();