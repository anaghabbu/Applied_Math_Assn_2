function v_error = traj_error(X)

    theta = X(1);
    t = X(2);

    v_projectile = projectile_traj(theta, t);
    v_target = target_traj(t);

    v_error = v_projectile - v_target;

end