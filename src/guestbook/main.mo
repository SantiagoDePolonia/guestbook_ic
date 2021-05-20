import Array "mo:base/Array";
import Text "mo:base/Text";
import Char "mo:base/Char";
import Nat "mo:base/Nat";

actor {
  stable var Guestbook : [Text] = [];

  private func arrayToStringReducer(agg : Text, el : Text) : Text {
    return agg # ", \"" # el # "\"";
  };

  private func arrayShiftFilter(str : Text) : Bool {
    return str != Guestbook[0];
  };

  private func translateSanitize(ch : Char) : Text {
    var text : Text = Text.fromChar(ch);
    if(Text.equal(text, "<")) {
      return "";
    };

    if(Text.equal(text, ">")) {
      return "";
    };

    if(Text.equal(text, "\"")) {
      return "";
    };

    return text;
  };

  private func sanitize(str : Text) : Text {
    var response : Text = Text.translate(str, translateSanitize);
    return response;
  };

  public func getJson() : async Text {
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

  public func insert(name : Text) : async Text {
    let cleanName = sanitize(name);
    Guestbook := Array.append(Guestbook, [cleanName]);
    
    let gb_response = await getJson();
    return gb_response;
  };
};
