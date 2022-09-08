class ModelPaltes 
{
  double Num ;
  String image;
  String location ;
  String name ;
  ModelPaltes({ required this.name,required this.Num, required this.image,this.location= 'Nasser Shop'});
  
}
List<ModelPaltes>plantess = 
    [
      ModelPaltes(
        name : 'Product 1 ',
        Num: 12.99,
        image: 'assets/image/p.webp',
        location: 'cairo shop',
        ),
        ModelPaltes(
          name : 'Product 2 ',
        Num: 13.99,
        image:'assets/image/pp.webp',
        ),
        ModelPaltes(
          name : 'Product 3 ',
        Num: 14.99,
        image:'assets/image/ppp.webp',
        ),
        ModelPaltes(
          name : 'Product 4 ',
        Num: 15.99,
        image: 'assets/image/pppp.webp'
        ),
        ModelPaltes(
          name : 'Product 5 ',
        Num: 16.99,
        image: 'assets/image/ppppp.webp'
        ),
        ModelPaltes(
          name : 'Product 6 ',
        Num: 18.99,
        image:'assets/image/pppppp.webp'
        ),
        ModelPaltes(
          name : 'Product 7 ',
        Num: 19.99,
        image:'assets/image/ppppppp.webp'
        ),
        ModelPaltes(
          name : 'Product 8 ',
        Num: 33.99,
        image: 'assets/image/pppppppp.webp'
        ),
    ];