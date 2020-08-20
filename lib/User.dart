class User {
  final int id;
  final String fullName;
  final String userName;
  final String address;
  final String phone;
  final String website;
  final String company;

  User(
      {this.id,
      this.fullName,
      this.userName,
      this.address,
      this.phone,
      this.website,
      this.company});

  static List<User> fetchAllUsers() {
    return [
      User(
          id: 1,
          fullName: "Leanne Graham",
          userName: "Bret",
          address: "Apt. 556, Kulas Light,Gwenborough (zip-92998-3874)",
          phone: "1-770-736-8031 x56442",
          website: "hildegard.org",
          company: "Romaguera-Crona"),
      User(
          id: 2,
          fullName: "Ervin Howell",
          userName: "Antonette",
          address: "Suite 879, Victor Plains, Wisokyburgh (zip-90566-7771)",
          phone: "010-692-6593 x09125",
          website: "anastasia.net",
          company: "Deckow-Crist"),
      User(
          id: 3,
          fullName: "Clementine Bauch",
          userName: "Samantha",
          address: "Suite 847, Douglas Extension, McKenziehaven (zip-59590-4157)",
          phone: "1-463-123-4447",
          website: "ramiro.info",
          company: "Romaguera-Jacobson")
    ];
  }
}
