# R Crash Course

## Why R?
- Open-source, cross-platform, great for statistics and data analysis.  
- Expressive, strong graphics, large community.  
- Steep learning curve, documentation for statisticians.

---

## Setup
```bash
sudo apt-get install r-base
```
Install packages in R:
```r
install.packages(c("dplyr","tidyr","ggplot2","knitr"))
```
Use **RStudio** or **Emacs+ESS** as IDEs.

---

## Reproducible Documents
- **R Markdown (`.Rmd`)** → integrates R and Markdown.  
- **Sweave (`.Rnw`)** → integrates R and LaTeX.  
- Enables reproducible analysis and reports.

---

## R Basics
```r
head(mtcars)
summary(mtcars)
mtcars$cost <- log(mtcars$hp)*atan(mtcars$disp)
```
- Data frames = tables of observations and variables.  
- Use `$`, logical filters, and simple vector operations.

---

## Key Packages
### dplyr
```r
mtcars %>% group_by(cyl) %>% summarise(mean_wt=mean(wt))
```
Fast, readable data manipulation.

### ggplot2
```r
ggplot(mtcars, aes(wt, qsec, color=factor(cyl))) + geom_point()
```
Layered grammar of graphics for flexible plots.

### tidyr
```r
messy %>% gather(drug, heartrate, -name)
```
Reshape wide ↔ long data.

---

## Takeaways
- R is powerful but requires statistical understanding.  
- Use R + knitr for reproducible research.  
- Learn ggplot2 and dplyr for efficient workflows.  
- Always interpret plots critically.
