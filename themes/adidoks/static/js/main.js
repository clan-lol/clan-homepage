// Set darkmode
document.getElementById('mode').addEventListener('click', () => {
  let isDarkTheme = document.body.classList.contains('dark');
  setColorTheme(!isDarkTheme ? "dark" : "light");
});


let preferDarkTheme = prefersDarkMode();
let theme = localStorage.getItem('theme');
if (theme !== null) {
  setColorTheme(theme);
} else {
  setColorTheme(preferDarkTheme ? "dark" : "light");
}

// Get the media query list object for the prefers-color-scheme media feature
const colorSchemeQueryList = window.matchMedia("(prefers-color-scheme: dark)");
// Add an event listener for the change event
colorSchemeQueryList.addEventListener("change", handleColorSchemeChange);


function setColorTheme(theme) {
  if (theme === "dark") {
    document.body.classList.add('dark');
    switchClanLogo("white");
    localStorage.setItem('theme', 'dark');
  } else {
    document.body.classList.remove('dark');
    switchClanLogo("dark");
    localStorage.setItem('theme', 'light');
  }
}

// A function that returns true if the user prefers dark mode, false otherwise
function prefersDarkMode() {
  // Check if the browser supports the prefers-color-scheme media query
  if (window.matchMedia) {
    // Get the current value of the media query
    let colorScheme = window.matchMedia("(prefers-color-scheme: dark)");
    // Return true if the media query matches, false otherwise
    return colorScheme.matches;
  } else {
    // If the browser does not support the media query, return false by default
    return false;
  }
}

function switchClanLogo(theme) {
  let favs = document.getElementsByClassName("favicon");
  for (item of favs) {
    if (theme === "white")
    {
      item.href = item.href.replace("dark-favicon", "white-favicon")
    } else {
      item.href = item.href.replace("white-favicon", "dark-favicon")
    }
  }
  let clogos = document.getElementsByClassName("clogo");
  for (item of clogos) {
    if (theme === "white")
    {
      item.src = item.src.replace("dark", "white")
    } else {
      item.src = item.src.replace("white", "dark")
    }
  }
}



// A function that executes some logic based on the color scheme preference
function handleColorSchemeChange(e) {
  if (e.matches) {
    // The user prefers dark mode
    setColorTheme("dark");
  } else {
    // The user prefers light mode
    setColorTheme("light");
  }
}
