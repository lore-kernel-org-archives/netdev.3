Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1AA36E477
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613786; cv=none; b=SGWs8SaMwboN1nu1vTEXK/qqmLvxX+W0KeF7zP8VPPpUBo5pGSgT7+/WlfLY1grYTmysDZmdY9i6ahgPpXfIOH3S1DnCRkU3PBwPM3K1tZbkNPUM7vtSf4A7r85gMoWqRtTorJkjCqVKg9DNpXAo7yLqPlSbkxS2gDQQnCornTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613786; c=relaxed/simple;
	bh=IKyyPu6xARtJ/cf1hQSM0JFq8CAIbRcdL/i/6h7xTQQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iHzLga7gMBtt4XxzgVYynf4E6G9Hp5qUXnoz4tEslJWAu+WfF5vnnIxdZZBxloJYOQdt+Ax/D/vo7yNZ5XGwo3B1f7yTLUBbCmz11LMp7RXdGvSHKw/N0K3ULziCTX5VR/wqwZw91llkndFsWtUG+NwadUbIP7KQcJg/AHUYOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7YRNMtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7YRNMtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4C51F000FF;
	Thu, 17 Sep 2026 02:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613778;
	bh=S+gUhDRB6UlV8/N9lVcC4vXWHkEZyx256VbpHh5glBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H7YRNMtKgfithH8N0qiEESvYW1SqBcZZg8nNCrta/9bchmotdYNN41dTK6Kcx1lq+
	 Q1/1MHpUDOInDfwPhlbF9KRcZnsaPUWjc8rRNgIW+S1f04825zOXsYm/cEmID3ri/y
	 OLaoRENFbwZvzt+XcmYt4NDdoUv/cOHVHOh1oLSZANwUMU8pBkB3fjxNc7MB8Kv0WX
	 uyZ0Nqe1gvvU55M/28cHBIBIiqlHPnBa8JzYrzrJwMQECMbBMlwcs+xlQkya7/IVKa
	 w1PLk3YrMGvdaQCP067EGj8ZCQseUyc30hNbjNOH7obGM0HHe/g1pbGYKsXAc+Krg6
	 MMO61Lsv7ctsw==
Subject: Re: [PATCH net v2 1/3] net/mlx5: Bridge, don't fail switchdev events
 of sibling eswitch ports
From: netdev-bot+sashiko@kernel.org
To: bsoares.it@gmail.com
Cc: mbloch@nvidia.com, daniel@iogearbox.net, netdev@vger.kernel.org,
 saeedm@nvidia.com, vladbu@nvidia.com, bersoare@isovalent.com, kuba@kernel.org
Date: Thu, 17 Sep 2026 02:56:17 +0000
Message-ID: <178961377777.22033.15087521444698899344@kernel.org>
In-Reply-To: <20260914085430.18694-2-bersoare@isovalent.com>
References: <20260914085430.18694-2-bersoare@isovalent.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] In this commit, mlx5_esw_bridge_lower_rep_port_lookup()
  (drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c:116-126)…

--

net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports

The mlx5 bridge offload registers switchdev notifiers per eswitch instance
while the notifier chains are global, so each instance must filter events
that aren't its own. This patch replaces the same-HW filter in the port
object and attribute handlers with a check that the instance actually
tracks the port, so sibling eswitch events no longer return -EINVAL to
user space.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> index baac38bece14a..56592e2e6b9b8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> @@ -104,6 +104,28 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
>  	return NULL;
>  }
>  
> +static bool mlx5_esw_bridge_rep_port_lookup(struct net_device *dev,
> +					    struct mlx5_esw_bridge_offloads *br_offloads,
> +					    u16 *vport_num, u16 *esw_owner_vhca_id)
> +{
> +	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, vport_num,
> +						       esw_owner_vhca_id))
> +		return false;
> +
> +	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);
> +}
> +
> +static bool mlx5_esw_bridge_lower_rep_port_lookup(struct net_device *dev,
> +						  struct mlx5_esw_bridge_offloads *br_offloads,
> +						  u16 *vport_num, u16 *esw_owner_vhca_id)
> +{
> +	if (!mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(dev, br_offloads->esw, vport_num,
> +							     esw_owner_vhca_id))
> +		return false;
> +
> +	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);
> +}
> +

[Severity: Low]
Should the tracked-port test happen inside the lower device walk rather
than after it?

mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() stops at the first
same-HCA representor it finds while walking the bridge's lower devices:

	netdev_for_each_lower_dev(dev, lower_dev, iter) {
		struct net_device *rep;

		if (netif_is_bridge_master(lower_dev))
			continue;

		rep = mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(lower_dev, esw, vport_num,
								      esw_owner_vhca_id);
		if (rep)
			return rep;
	}

Bridge-level attributes are notified with dev == the bridge netdevice, so
on a merged-eswitch HCA whose bridge holds representors of two eswitch
instances, the walk can return the sibling's representor first. If the
calling instance has no peer port for that representor - the late-start
case described in the commit message - mlx5_esw_bridge_port_exists()
fails and the whole lookup returns false, even though a later lower
device is a port this instance does track.

> @@ -283,8 +303,8 @@ mlx5_esw_bridge_port_obj_attr_set(struct net_device *dev,
>  	u16 vport_num, esw_owner_vhca_id;
>  	int err = 0;
>  
> -	if (!mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
> -							     &esw_owner_vhca_id))
> +	if (!mlx5_esw_bridge_lower_rep_port_lookup(dev, br_offloads, &vport_num,
> +						   &esw_owner_vhca_id))
>  		return 0;
>  
>  	port_attr_info->handled = true;

Can this turn the previous -EINVAL into a silently dropped attribute
update for that instance?  mlx5_esw_bridge_port_obj_attr_set() returns 0
with port_attr_info->handled left false, so the ageing time, VLAN
filtering, VLAN protocol and MC-disabled updates never reach that
instance's own bridge object.  Each instance resolves its bridge through
the port, for example:

drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c:mlx5_esw_bridge_vlan_filtering_set() {
	bridge = mlx5_esw_bridge_from_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
	if (!bridge)
		return -EINVAL;
	...
}

so after e.g. "ip link set br0 type bridge vlan_filtering 1" the software
bridge would have filtering enabled while that instance's hardware bridge
keeps MLX5_ESW_BRIDGE_VLAN_FILTERING_FLAG clear, with no error reported.

The follow-up patch in this series, "net/mlx5: LAG, check if vport exists
on br_offloads", moves the mlx5_esw_bridge_port_exists() test into the
leaf of the recursive walk so an untracked representor returns NULL and
netdev_for_each_lower_dev() continues to the next lower device, which
removes this behaviour at the end of the series.  Would it make sense to
fold that change into this patch, or to note that this patch alone is not
suitable for backporting without it?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914085430.18694-1-bersoare%40isovalent.com
