double percentage(bool bool1, bool bool2, bool bool3) {
  if (bool1 && bool2 && bool3) {
    return 1.0;
  } else if (bool1 && bool2) {
    return 0.68;
  } else if (bool1 || bool2 || bool3) {
    return 0.34;
  } else {
    return 0.0;
  }
}

String percentageText(bool bool1, bool bool2, bool bool3) {
  if (bool1 && bool2 && bool3) {
    return '3/3';
  } else if (bool1 && bool2) {
    return '2/3';
  } else if (bool1 || bool2 || bool3) {
    return '1/3';
  } else {
    return '0/3';
  }
}

    // double percentage(bool bool1, bool bool2, bool bool3) {
    //   if (bool1 && bool2 && bool3) {
    //     return 1.0;
    //   } else if (bool1 && bool2) {
    //     return 0.68;
    //   } else if (bool1 || bool2 || bool3) {
    //     return 0.34;
    //   } else {
    //     return 0.0;
    //   }
    // }

    // String percentageText(bool bool1, bool bool2, bool bool3) {
    //   if (bool1 && bool2 && bool3) {
    //     return '3/3';
    //   } else if (bool1 && bool2) {
    //     return '2/3';
    //   } else if (bool1 || bool2 || bool3) {
    //     return '1/3';
    //   } else {
    //     return '0/3';
    //   }
    // }
