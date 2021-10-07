String upperCaseFirst(String s) =>
    (s ?? '').length < 1 ? '' : s[0].toUpperCase() + s.substring(1);
