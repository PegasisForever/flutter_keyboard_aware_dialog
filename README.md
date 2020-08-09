# Keyboard Aware Dialog

This package is created to solve the issue where dialogs won't move upwards when soft keyboard shows. (See [#27629](https://github.com/flutter/flutter/issues/27629))

## Usage

Just replace your `Dialog` with `KeyboardAwareDialog` provided by this package.

## Class Mapping

| Flutter | Keyboard aware      |
| ------- | ------------------- |
| `Dialog`  | `KeyboardAwareDialog` |
| `AlertDialog`  | `KeyboardAwareAlertDialog` |
| `SimpleDialog`  | `KeyboardAwareSimpleDialog` |

## Caveats

1. `barrierDismissible` will have no effect, you can't dismiss dialog by clicking the outside of the dialog.
