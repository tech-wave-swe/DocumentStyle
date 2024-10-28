# Template Latex TechWave

Questa repository contiene tutte le classi necessarie per la creazione di documenti per il team TechWave in rispetto delle linee guida stabilite all'interno del documento "Norme di Progetto".

## Classi disponibili

-   **TWDocumentFull**: Documento completo con Frontpage.
-   **TWReport**: Classe che definisce un template per un report di riunione Interna o Esterna.

## Installazione

Per poter utilizzare le classi presenti è necessario installare LaTex all'interno del dispositivo.
Per accedere globalmente al template qui definito:

1. Spostarsi nella cartella ( o crearla se non disponibile ):

```bash
~\texmf\tex\latex\commonstuff\
```

2. Clonare la repo in questa cartella:

```bash
git clone ...
```

## Utilizzare il template

### TWReport

```latex
\documentclass{TWReport}

\title{Titolo Documento}

\author{Autore}
\participant[present]{Partecipante Presente}
\participant[absent]{Partecipante Assente}

\editor{Authore del verbale}

\reviewer{Revisore}
\classification{Interno|Esterno}
\version{1.0}

\begin{document}

\frontmatter

\showPartecipants

\section*{Ordine del giorno}
\begin{itemize}
    \item Lista di argomenti da trattare durante il meeting
\end{itemize}

\section*{Resaconto}
\begin{itemize}
    \item Resoconto del meeting
\end{itemize}

\section*{Decisioni Prese}
\begin{itemize}
    \item Lista delle decisioni prese
\end{itemize}

\task{Descrizione task}{Responsabile}{DueDate}

\tasklist

\end{document}
```
