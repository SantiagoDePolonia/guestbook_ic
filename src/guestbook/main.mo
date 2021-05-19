import Array "mo:base/Array";
import Nat "mo:base/Nat";

actor {
  var Guestbook : [Text] = [];

  private func arrayToStringReducer(agg : Text, el : Text) : Text {
    return agg # ", \"" # el # "\"";
  };

  private func arrayShiftFilter(a : Text) : Bool {
    return a != Guestbook[0];
  };

  private func arrayToJson() : Text {
    var guestbook_response : Text = "";
    if(Guestbook.size() > 0) {
      guestbook_response := "\"" # Guestbook[0] # "\"";
    };

    if(Guestbook.size() > 1) {
      let arr_shifted = Array.filter(Guestbook, arrayShiftFilter);
      guestbook_response := Array.foldLeft(arr_shifted, guestbook_response, arrayToStringReducer);
    };

    return "[" # guestbook_response # "]";
  };

  public func getJson() : async Text {
    // let gb_size_nat : Nat = Guestbook.size();
    // let gb_size : Text = Nat.toText( gb_size_nat );

    return arrayToJson();
  };

  public func insert(name : Text) : async Text {
    Guestbook := Array.append(Guestbook, [name]);

    // @TODO: validation
    // no " characters allowed

    let gb_response = await getJson();
    return gb_response;
  };
};
