class Book {
  int id = 0; 
  String title = ''; 
  String author = ''; 
  String description = ''; 
  String publish_date = ''; 
  String major = ''; 
  int quantity = 0;
  String cover = ''; 

  Book(this.id, this.title, this.author, this.major,
      this.description, this.publish_date, this.quantity, this.cover);
}
