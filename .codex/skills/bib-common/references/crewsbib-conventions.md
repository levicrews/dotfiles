# crewsbib conventions

Observed from `crewsbib.bib` (17 entry types, 136k lines) and the local `pdf/` directory. When an existing entry conflicts with this summary, inspect comparable records and preserve the dominant local pattern.

## Cite keys and names

- Keys are generally concatenated author surnames plus year: `CostinotLorenzoniWerning2014`.
- Preserve surname hyphens in keys: `Rossi-Hansberg`, `Mas-Colell`, `Fernandez-Villaverde`, `Dix-Carneiro`, and `Rodriguez-Clare` remain hyphenated.
- For same-author/year collisions, use lowercase letter suffixes (`...2014a`, `...2014b`), checking all existing keys before assigning one.
- Store authors as `Surname, Given names` joined with ` and `. Protect unusual capitalization or names with braces when needed.

## File and PDF convention

- BibTeX file links use JabRef syntax: `file = {:pdf/Citekey.pdf:PDF}`.
- The ordinary local copy is `pdf/[citekey].pdf`.
- A separate appendix is `pdf/[citekey]_Appendix.pdf` and is referenced the same way in `file`.
- Existing suffixes include `_Comment`, `_Slides`, `_OldVersion`, `_UpdatedVersion`, and occasional descriptive correction names. Use a descriptive suffix only when it identifies a genuinely distinct local file.
- Do not add a `file` field for a file that is not present.

## Keywords

- New entries should use `keywords` only for JEL classification codes, e.g. `keywords = {F14, F63, O13, Q17}`.
- Do not add topical phrases, free-text tags, group names, or database labels. The legacy bibliography contains exceptions and malformed codes; those are not templates for new entries.
- Preserve JEL codes as supplied by a reliable source, normalizing only obvious separators/whitespace.

## Entry-type field guidance

The bibliography uses `Article` (5,573), `Book` (774), `TechReport` (1,515), `Unpublished` (662), `InCollection` (388), `InBook` (78), `InProceedings` (34), `Manual` (14), `PhdThesis` (11), `Misc` (104), `MastersThesis` (4), `Proceedings` (2), `Conference` (2), `Booklet` (1), `Software` (1), and one lowercase legacy `comment` entry. Use the type matching the actual source, not the type of an earlier working-paper version.

Typical required/core fields:

| Type | Core fields and local publisher rule |
| --- | --- |
| `Article` | `author`, `journal`, `title`, `year`; add `volume`, `number`, `pages`, DOI/URL. Usually omit `publisher`; preserve it only when the authoritative record and comparable local entries include it. |
| `Book` | `author` or `editor`, `publisher`, `title`, `year`; add `address`, `edition`, `isbn`, `series`, `volume`, DOI/URL when verified. |
| `InBook` | Chapter in an edited book, usually `author`, `title`, `booktitle`, `publisher`, `year`; add `editor`, `chapter`, `pages`, `series`, DOI/URL. Publisher is normally retained. |
| `InCollection` | `author`, `booktitle`, `publisher`, `title`, `year`; add `editor`, `chapter`, `pages`, `series`, `volume`, DOI/URL. Publisher is normally retained. |
| `InProceedings` | `author`, `booktitle`, `title`, `year`; add `editor`, `pages`, `publisher`, `organization`, `location`, DOI/URL only when verified. Publisher is retained when the proceedings source gives one. |
| `TechReport` | `author`, `title`, `year`, usually `number`, `type`, `institution`/`school`, DOI/URL. NBER records commonly use `type = {Working Paper}`, `number`, `doi`, `school = {National Bureau of Economic Research}`, `series = {Working Paper Series}`; do not add a publisher by default. |
| `Unpublished` | `author`, `title`, `year`, plus URL/file and JEL keywords when available. Do not add `publisher`. Use for genuine unpublished manuscripts, not an available NBER paper. |
| `PhdThesis` / `MastersThesis` | `author`, `school`, `title`, `year`; add `type` for the degree and URL/file when available. Do not add `publisher`. |
| `Manual` | `title`, `author` or `organization`, `year`; add `edition`, DOI/URL/file as available. Do not add `publisher` by default. |
| `Misc` | Use only when no more specific type fits; include verified `author`, `title`, `year`, `howpublished`/URL/file and avoid publisher unless the source is explicitly publisher-issued. |
| `Proceedings` | `title`, `year`, usually `editor`; add `publisher`, `volume`, `number`, DOI/URL as verified. |
| `Conference` / `Booklet` / `Software` | Rare; inspect the nearest existing example before using. Preserve publisher only when it is a real bibliographic publisher field in the source. |

## Publication priority

For economics papers, search for the final published article or chapter before considering a working paper. If no published version can be verified, an NBER `TechReport` is preferred to a generic `Unpublished` entry. Use the NBER record’s working-paper number, DOI, URL, institution, and series when available. A gated final paper is still the preferred record; request university VPN login if the metadata or PDF cannot be verified without it.
