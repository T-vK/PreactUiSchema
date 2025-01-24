## UI

### Prerequisites
Generating the html.h file requires that you have the `brotli` cli installed.

### Generate the html.h file

```bash
cd frontend
npm run build
```

The file will be written to `frontend/dist/html.h`.

### Verify the generated html.h file

```bash
cd frontend
npm run test
```

### For testing durching development use

```bash
cd frontend
npm run dev
```


## Advanced


### Generate the html.h file for a custom Entity

```bash
cd frontend
ENTITY=OtherSettings npm run build
```

`ENTITY` defaults to `Settings` if not set.

## How to use the generated html.h file

```C++
#include "dist/html.h"

for (int i = 0; i < dist_index_html_br_len; i++) {
    Serial.print(dist_index_html_br[i], HEX);
}
```