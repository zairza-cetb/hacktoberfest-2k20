// pos is position of where the user in the test
var pos = 0, test, test_status, question, choice, choices, chA, chB, chC, correct = 0;

var questions = [
  {
      question: "What is the keyword do declare a JavaScript <span>variable</span>?",
      a: "variable",
      b: "var",
      c: "vrb",
      answer: "B"
    },
  {
      question: "What is the correct way to <span>set a variable</span>?",
      a: "var name = 'Joe';",
      b: "variable name = 'Joe;",
      c: "var name : 'Joe';",
      answer: "A"
    },
  {
      question: "Which <span>data types</span> can we give variables?",
      a: "Strings, booleans, numbers",
      b: "Only strings",
      c: "Strings and numbers",
      answer: "A"
    },
  {
      question: "How can we <span>change</span> the 'name' variable <span>value</span>?",
      a: "var name = 'Martin';",
      b: "change name = 'Martin';",
      c: "name = 'Martin';",
      answer: "C"
    }
  ];
 
function get(x){
  return document.getElementById(x);
}

function renderQuestion(){
  test = get("test");
  if(pos >= questions.length){
    //test.innerHTML = "<h2>You got "+correct+" of "+questions.length+" questions correct</h2>";
    var correctPercent = correct / questions.length * 100;
    test.innerHTML = correctPercent + "% correct!";
    get("test_status").innerHTML = "Test completed";
    pos = 0;
    correct = 0;
    return false;
  }
  get("test_status").innerHTML = "Question "+(pos+1)+" of "+questions.length;
  
  question = questions[pos].question;
  chA = questions[pos].a;
  chB = questions[pos].b;
  chC = questions[pos].c;
  test.innerHTML = "<h3>"+question+"</h3>";
  test.innerHTML += "<input type='radio' name='choices' value='A' id='radioa'><label for='radioa'>"+chA+"</label><br><br>";
  test.innerHTML += "<input type='radio' name='choices' value='B' id='radiob'><label for='radiob'>"+chB+"</label><br><br>";
  test.innerHTML += "<input type='radio' name='choices' value='C' id='radioc'><label for='radioc'>"+chC+"</label><br><br>";
  test.innerHTML += "<button onclick='checkAnswer()'>Submit Answer</button>";
}
function checkAnswer(){
  choices = document.getElementsByName("choices");
  for(var i=0; i<choices.length; i++){
    if(choices[i].checked){
      choice = choices[i].value;
    }
  }
  if(choice == questions[pos].answer){
    correct++;
  }
  pos++;
  renderQuestion();
}
// Add event listener to call renderQuestion on page load event
window.addEventListener("load", renderQuestion);