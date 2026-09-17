Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25E3812C2
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613796; cv=none; b=DnjRa+Gv5IudB+RedZd4RwS95qtb/zVrz8JHVNtZMNSVy8SI1KOOZ3USuOTtlCxB+tDkToi1cE4DYm+0VrUORIQwjcYCV0lji3KdheiXIqMlLGzCv23q6r4snov+0I0BLn61nNkVCkLmejZi4ENzc0VxusKgYPzbOzzyeD7A2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613796; c=relaxed/simple;
	bh=bXxCQGcGovVn8WByrzzWlq49CDTKp9cOUiRSBrNl0O0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k58tULj5pRfsnovZBCXlRC0itK121+oUVB7S6ctjm2rX2LJDgG6tNCHh2o6SmFOqMogsmzeOuzdOc4JoRx7FSbNmFlC+LVLl1HBYU+/hfsVxEyWUcXs8+yNsuMj2C2N73dHZNS4BhhQXoYWCUJeirjFfS04rzDoBlt2+m08ACz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKqgXdXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKqgXdXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405B21F00893;
	Thu, 17 Sep 2026 02:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613779;
	bh=PlxdZwn3dGvCRHBFi918nyVCxOCih4gLhx4UesPs00Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dKqgXdXq80kwgRsPJ2hBduTWjA77UVdMxI72j5o9L8GbuzPKw2myBCUFiXnBcr1Cs
	 g8W/ppCdhTZMy/CydXNfjTbsGLS0PcDGt+2/i4AVFF39FrmkB2O5UFjJjxn5WqqoFa
	 TXTthNsavESd4HoUnmcd0nTsrV5IxNufaWV/QZi4clVpZTLYYmVV3+JnZmQ6qOUHf4
	 EYkqF/73/lBtjBG1RaDGOxEaQm/95Ukta6ywDM3gGi4Hinx/XbW76e1cU4rgUM1Mca
	 KfUndbRzc97h5vfv2xcAO92VQEc7RJjmQH3lQlVvlew6wsvD9KPXTlG0G4X5jO4ve6
	 xcxoQGhTE7Y/Q==
Subject:
 Re: [PATCH net v2 2/3] net/mlx5: LAG, check if vport exists on br_offloads
From: netdev-bot+sashiko@kernel.org
To: bsoares.it@gmail.com
Cc: mbloch@nvidia.com, daniel@iogearbox.net, netdev@vger.kernel.org,
 saeedm@nvidia.com, vladbu@nvidia.com, bersoare@isovalent.com, kuba@kernel.org
Date: Thu, 17 Sep 2026 02:56:18 +0000
Message-ID: <178961377880.22033.3205519078828876782@kernel.org>
In-Reply-To: <20260914085430.18694-3-bersoare@isovalent.com>
References: <20260914085430.18694-3-bersoare@isovalent.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] The commit message describes a bug that the code cannot exhibit,
  and the patch is a functional no-op for the scenario it names.
- [Low] The commit asserts a user-visible functional defect ('a bridge
  attribute change on a bonded uplink can silently no-op on the right…

--

net/mlx5: LAG, check if vport exists on br_offloads

This adds a mlx5_esw_bridge_port_exists() check to the LAG-master/rep
branch of mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(), so that a
rep which is not tracked by the calling instance's br_offloads is
rejected instead of returned.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> index 56592e2e6b9b8..4b7b0a0fc2b2f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> @@ -85,9 +85,16 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
>  	struct net_device *lower_dev;
>  	struct list_head *iter;
>  
> -	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev))
> -		return mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
> -								 esw_owner_vhca_id);
> +	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev)) {
> +		struct net_device *rep;
> +
> +		rep = mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
> +								esw_owner_vhca_id);
> +		if (rep && !mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id,
> +							esw->br_offloads))
> +			return NULL;
> +		return rep;
> +	}

[Severity: High]
Does this hunk change anything for the bonded-uplink case the changelog
describes?

The changelog says:

    mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() walks a LAG bond's
    lower devices and returns the first rep that's structurally eligible
    (same HCA, is a rep), without checking it's tracked by the calling
    instance's br_offloads. On a merged-eswitch HCA where a bond spans
    reps of more than one eswitch instance, this can return a sibling's
    rep instead of continuing to the one this instance actually owns

For dev being the LAG master, the bond walk happens in
mlx5_esw_bridge_lag_rep_get(), reached via
mlx5_esw_bridge_rep_vport_num_vhca_id_get():

	if (netif_is_lag_master(dev))
		dev = mlx5_esw_bridge_lag_rep_get(dev, esw);

and that walk already filters on the eswitch instance:

	netdev_for_each_lower_dev(dev, lower, iter) {
		if (!mlx5e_eswitch_rep(lower))
			continue;

		if (mlx5_esw_bridge_dev_same_esw(lower, esw))
			return lower;
	}

So can it actually return a sibling instance's rep here?  It looks like
only lowers satisfying mlx5_esw_bridge_dev_same_esw(lower, esw) are
accepted, which would make the "same HCA, is a rep" description apply to
mlx5_esw_bridge_rep_vport_num_vhca_id_get()'s non-LAG path rather than to
the bond walk.

The new branch is also terminal - on rejection it returns NULL and no
other bond member is examined - so what is "continued to" in the LAG case?

There is a second question about the result being identical before and
after.  The only caller is mlx5_esw_bridge_lower_rep_port_lookup(), which
repeats the same test on the same br_offloads:

	if (!mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(dev, br_offloads->esw, vport_num,
							     esw_owner_vhca_id))
		return false;

	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);

With esw->br_offloads and br_offloads being the same object, a dev that is
a LAG master ends up with the same verdict either way, and
mlx5_esw_bridge_port_obj_attr_set() still returns 0 without applying the
attribute:

	if (!mlx5_esw_bridge_lower_rep_port_lookup(dev, br_offloads, &vport_num,
						   &esw_owner_vhca_id))
		return 0;

The behaviour that does change is the recursive lower-device walk further
down, for a dev that is neither a LAG master nor a rep (the bridge
netdevice itself, for bridge-wide attributes such as ageing time, VLAN
filtering, VLAN protocol and MC-disabled): an untracked sibling lower rep
no longer terminates the walk, so the walk can reach the lower rep this
instance does track.  Would it be clearer to describe that path in the
subject and changelog instead of the LAG bond?

[Severity: Low]
Should this patch carry a Fixes: tag?

The changelog claims a user-visible effect ("a bridge attribute change on
a bonded uplink can silently no-op on the right instance"), but there is
no Fixes: line, while the two sibling patches in the series both tag
Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch
connectivity").

The behaviour actually changed here (the recursive lower-device walk in
mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() stopping on an untracked
sibling rep) is a merged-eswitch bug too, so either adding the matching
Fixes: tag or rewording the message to say this is follow-up hardening of
the preceding patch with no independent user-visible effect would remove
the ambiguity.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914085430.18694-1-bersoare%40isovalent.com
