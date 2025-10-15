# Continue.dev Global Rules for Quarto Julia Notebooks

## Project Context
You are working exclusively on Quarto notebooks (.qmd files) using the Julia engine for computation and analysis.

## Core Principles

### 1. Quarto Document Structure 
- Use markdown for narrative text and `{julia}` code blocks for computation
- Leverage Quarto's cross-referencing, callouts, and layout features

### 2. Julia Code Style
- Follow Julia naming conventions: lowercase with underscores for functions/variables, PascalCase for types
- Write idiomatic Julia code using multiple dispatch and type stability
- Prefer broadcasting (`.`) operators for vectorized operations
- Use `begin...end` blocks for multi-line expressions in notebooks
- Keep code blocks focused and modular for better notebook readability

### 3. Code Block Organization
```julia
#| label: descriptive-name
#| echo: true
#| warning: false
#| message: false
```
- Always use `#|` for Quarto cell options
- Label significant code chunks for cross-referencing
- Set appropriate display options (echo, warning, message, output)
- Use `#| include: false` for setup chunks

### 4. Package Management
- Load packages at the beginning of the notebook in a setup chunk
- Use `using` for frequently used functions, `import` for selective imports
- Document package versions when reproducibility is critical
- Consider using Project.toml for project-specific dependencies

### 5. Output and Visualization
- Use Plots.jl plotting libraries
- Set figure dimensions and captions using Quarto options:
  ```julia
  #| fig-cap: "Description"
  #| label: "some label"
  ```
- Format tables using DataFrames.jl and Quarto's table features
- Use `display()` explicitly when needed for proper rendering

### 6. Data Analysis Best Practices
- Use DataFrames.jl for tabular data manipulation
- Leverage pipe operators (`|>`) for readable data transformations
- Handle missing data appropriately with `missing` and `skipmissing()`
- Document data sources and preprocessing steps clearly

### 7. Reproducibility
- Document the Julia version and key package versions
- Include a setup chunk that installs/loads all required packages
- Use relative paths for data files

### 8. Documentation
- Write clear markdown explanations between code chunks
- Use inline code with backticks for referencing variables and functions
- Include mathematical notation using LaTeX syntax ($...$)
- Add comments within Julia code for complex logic

### 9. Performance Considerations
- Avoid global variables in functions; pass arguments explicitly
- Use type annotations judiciously to aid inference
<!-- - Profile code when performance matters using `@time` or BenchmarkTools.jl -->
- Consider pre-allocating arrays for intensive computations

### 10. Error Handling
- Use try-catch blocks for operations that might fail
- Provide informative error messages
- Validate inputs at the start of analysis sections
- Test edge cases in separate code chunks

## Common Quarto-Julia Patterns

### Inline Code Reference
Use inline Julia expressions with `{julia} variablename` to display computed values in text.

## Things to Avoid
- Don't use Jupyter-specific magic commands
- Avoid mixing Python/R code unless explicitly using multi-language features
- Don't create overly long code chunks; break them up for readability
- Avoid hardcoded absolute paths
- Don't forget to specify output options for plots and tables

## When Suggesting Code
- Always provide complete, runnable code blocks
- Include necessary package imports
- Show example data when demonstrating data manipulation
- Explain trade-offs between different approaches
- Suggest Quarto-specific features that enhance presentation