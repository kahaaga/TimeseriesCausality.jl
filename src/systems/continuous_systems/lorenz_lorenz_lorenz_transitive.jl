@inline @inbounds function eom_lorenz_lorenz_lorenz_transitive(u, p, t)
    x₁, y₁, z₁, x₂, y₂, z₂, x₃, y₃, z₃ = (u...,)
    σ₁, σ₂, σ₃, ρ₁, ρ₂, ρ₃, β₁, β₂, β₃, c₁₂, c₂₃ = (p...,)

    # Subsystem 1
    dx₁ = σ₁*(y₁-x₁)
    dy₁ = ρ₁*x₁ - y₁ - x₁*z₁
    dz₁ = x₁*y₁ - β₁*z₁

    # Subsystem 2
    dx₂ = σ₂*(y₂-x₂) + c₁₂*(x₁ - x₂)
    dy₂ = ρ₂*x₂ - y₂ - x₂*z₂
    dz₂ = x₂*y₂ - β₂*z₂

    # Subsystem 3
    dx₃ = σ₃*(y₃-x₃) + c₂₃*(x₂ - x₃)
    dy₃ = ρ₃*x₃ - y₃ - x₃*z₃
    dz₃ = x₃*y₃ - β₃*z₃
    return SVector{9}(dx₁, dy₁, dz₁, dx₂, dy₂,dz₂, dx₃, dy₃, dz₃)
end

function lorenz_lorenz_lorenz_transitive(uᵢ, σ₁, σ₂, σ₃, ρ₁, ρ₂, ρ₃, β₁, β₂, β₃, c₁₂, c₂₃)
    p = [σ₁, σ₂, σ₃, ρ₁, ρ₂, ρ₃, β₁, β₂, β₃, c₁₂, c₂₃]
    ContinuousDynamicalSystem(eom_lorenz_lorenz_lorenz_transitive, uᵢ, p)
end

"""
    lorenz_lorenz_lorenz_transitive(;uᵢ=rand(9),
                σ₁ = 10.0, σ₂ = 10.0, σ₃ = 10.0,
                ρ₁ = 28.0, ρ₂ = 28.0, ρ₃ = 28.0,
                β₁ = 8/3,  β₂ = 8/3,  β₃ = 8.3,
                c₁₂ = 1.0, c₂₃ = 1.0) -> ContinuousDynamicalSystem

Initalise a dynamical system consisting of three coupled Lorenz attractors with
a transitive causality chain where X₁ → X₂ and X₂ → X₃. In total, the three
3D-subsystems create a 9-dimensional dynamical system.

The strength of the forcing X₁ → X₂ is controlled by the parameter `c₁`, and
the forcing from X₂ → X₃ by `c₂`. The remaining parameters are the usual
parameters for the Lorenz system, where the subscript `i` refers to the
subsystem Xᵢ. 

## Equations of motion 

```math 
\\begin{aligned}
\\dot{x_1} &= \\sigma_1(y_1 - x_1) \\\\
\\dot{y_1} &= \\rho_1 x_1 - y_1 - x_1 z_1 \\\\
\\dot{z_1} &= x_1 y_1 - \\beta_1 z_1 \\\\
\\dot{x_2} &=  \\sigma_2 (y_2 - x_2) + c_{12}(x_1 - x_2) \\\\
\\dot{y_2} &= \\rho_2 x_2 - y_2 - x_2 z_2 \\\\
\\dot{z_2} &= x_2 y_2 - \\beta_2 z_2 \\\\
\\dot{x_3} &= \\sigma_3 (y_3 - x_3) + c_{23} (x_2 - x_3) \\\\
\\dot{y_3} &= \\rho_3 x_3 - y_3 - x_3 z_3 \\\\
\\dot{z_3} &= x_3 y_3 - \\beta_3 z_3
\\end{aligned}
```

## Usage in literature

This system was studied by Papana et al. (2013) for coupling strengths 
``c_{12} = 0, 1, 3, 5`` and ``c_{23} = 0, 1, 3, 5``.

## References

1. Papana et al., Simulation Study of Direct Causality Measures in Multivariate 
    Time Series. Entropy 2013, 15(7), 2635-2661; doi:10.3390/e15072635
"""
lorenz_lorenz_lorenz_transitive(;uᵢ=rand(9),
            σ₁ = 10.0, σ₂ = 10.0, σ₃ = 10.0,
            ρ₁ = 28.0, ρ₂ = 28.0, ρ₃ = 28.0,
            β₁ = 8/3,  β₂ = 8/3,  β₃ = 8.3,
            c₁₂ = 1.0, c₂₃ = 1.0) =
    lorenz_lorenz_lorenz_transitive(uᵢ, σ₁, σ₂, σ₃, ρ₁, ρ₂, ρ₃, β₁, β₂, β₃, c₁₂, c₂₃)
