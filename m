Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78673C0A09
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111321; cv=none; b=ceTQ0p5utKuczGZfAW5eHolvzeNkbeWMgJ+4rj2hslP19XuJe3UYZVMPeVb6Y2pCvXI9tplVtFSuK7sIM5kFxOTSaJReAQVJ1U624SPsIlhYRfbRtjW6V/0Kh1ztoePIpn+isAw2Rcq+W/4q9FSF4b7EJxWqOT5Jjgmug2P/ZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111321; c=relaxed/simple;
	bh=EsMKix6knlG5ZgL4IaqNkvnPnAfqWll82QO/o9v32MI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCw+4LHe0P70FoKx1JsH1db2rcpeBNzYjVRmXav2d6zaKy2zkc8bwiwQHBTKRNAkP5bYV8SocAt2na+qYK+j8oeS/lBqaoWw9BXFAQMtOHmbURYDjkvtT1wJzAB3Ihaa8w3N572S82DlCgdJl/J4G8PU+/OFZIMnnmqGVqUHSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7aNQ0m4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7aNQ0m4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9341F000FF;
	Fri, 11 Sep 2026 07:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789111315;
	bh=pMdIl92KJLSEPXbbGjwc4C9dx2NNcBUK2iZdoMvx7dQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N7aNQ0m4oQVAkL3suo15jwguteDhuXZOQq4HFOA17JRt0Q/9zkpQNGV1I2xvsfaqz
	 foNpIut605hIB4CiyK21u/ec2bybSRSRalA5KDIdaTnQkiYDkj0x19bF9cYmPEeVMg
	 2FDq68t5OhHWmVDBIWyDPEbxXP5Uv7x9fiaY9rAcGW6PfDHbcQXtGnbLTjya/cMhQn
	 mTcMJbVD5RxYd8YDfCR8KPcBqyCnTdqoHVnF85qavp9RUlQnmPxuc2ror0KO4hNuWU
	 fzn7b7T0wp5+CSnr+EONDzQmEBzXAZmIOlXGjvWngKZ4H0oU6/LC/wbZRzwQl1iFen
	 oZkX0AZIuidXQ==
Subject: Re: [PATCH net] net/mlx5: Bridge, don't fail switchdev events of
 sibling eswitch ports
From: netdev-bot+sashiko@kernel.org
To: daniel@iogearbox.net
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, bersoare@isovalent.com,
 vladbu@nvidia.com, kuba@kernel.org
Date: Fri, 11 Sep 2026 07:21:55 +0000
Message-ID: <178911131518.219967.12804690889751793108@kernel.org>
In-Reply-To: =?utf-8?q?=3Cf26aa63abf085a087f7ed1df9080f9f0982bb311=2E1788884?=
 =?utf-8?q?253=2Egit=2Edaniel=40iogearbox=2Enet=3E?=
References: =?utf-8?q?=3Cf26aa63abf085a087f7ed1df9080f9f0982bb311=2E17888842?=
 =?utf-8?q?53=2Egit=2Edaniel=40iogearbox=2Enet=3E?=
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

- [High] Incomplete fix: the new port-presence filter is applied only to
  the *first* representor returned by…

Pre-existing issues:
- [High] The NETDEV_CHANGEUPPER path was not converted to a port-presence
  filter, so the same "instance does not own the port" condition still…

--

net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports

The mlx5 bridge offload registers its switchdev notifiers once per eswitch
instance while the switchdev chains are global, so every instance sees every
event and filters it with mlx5_esw_bridge_dev_same_hw(). This patch adds
mlx5_esw_bridge_port_exists() and makes the port object and port attribute
handlers filter on the presence of the port in the instance instead, so an
instance that does not track the port no longer claims the event and returns
-EINVAL.

No Link: tags in the commit header.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> index baac38bece14..56592e2e6b9b 100644
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

[Severity: High]
In mlx5_esw_bridge_lower_rep_port_lookup(), the port presence test runs only
on the single representor that the traversal already picked, so should the
check instead be folded into the walk over the bridge's lower devices?

mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() returns the first same-HCA
representor it finds:

	netdev_for_each_lower_dev(dev, lower_dev, iter) {
		...
		rep = mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(lower_dev, esw, vport_num,
								      esw_owner_vhca_id);
		if (rep)
			return rep;
	}

Lower adjacencies are appended in enslavement order by
__netdev_adjacent_dev_insert() (list_add_tail_rcu() for the down list), so in
the very scenario from the commit message - PF0's uplink rep enslaved to br0
first, then PF1 put in switchdev mode and its rep enslaved to the same br0 -
the first lower rep is PF0's uplink. PF1's br_offloads instance has no port
for it, so mlx5_esw_bridge_port_exists() is false and the new helper returns
false, even though PF1's instance does own the local port for its own rep on
that same bridge.

Since the remaining lower devices are never examined, does
mlx5_esw_bridge_port_obj_attr_set() then skip the attribute for PF1's own
bridge object?

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

[Severity: High]
The bridge-global attributes are emitted against the bridge master netdev,
for example br_vlan_filter_toggle() calls switchdev_port_attr_set(br->dev,
&attr, extack), and __set_ageing_time() and the MC_DISABLED path do the same.
That is why the driver resolves a vport through the lower-device walk here.

With this change, returning 0 leaves handled false, so the sibling instance
applies nothing to its own struct mlx5_esw_bridge, which
mlx5_esw_bridge_create() initialises with hard-coded defaults:

	bridge->ageing_time = clock_t_to_jiffies(BR_DEFAULT_AGEING_TIME);
	bridge->vlan_proto = ETH_P_8021Q;

and a zeroed flags field, i.e. no MLX5_ESW_BRIDGE_VLAN_FILTERING_FLAG and
mcast off.

mlx5 never calls switchdev_bridge_port_offload() (no occurrences under
drivers/net/ethernet/mellanox/mlx5/), so br_switchdev_vlan_attr_replay() does
not run for it and the skipped attribute is never recovered.

Before this patch the same case returned -EINVAL and br_vlan_filter_toggle()
/ __br_vlan_set_proto() rolled the software state back, so software and
hardware stayed in agreement. Afterwards, does

	ip link set br0 type bridge vlan_filtering 1

succeed in software and on the first instance while the sibling instance keeps
offloading its own ports with vlan filtering disabled, the default ageing time
and ETH_P_8021Q, i.e. a divergence that depends on enslavement order?

Note that all four setters resolve the per-instance bridge object through a
port owned by that instance, e.g. mlx5_esw_bridge_vlan_filtering_set():

	bridge = mlx5_esw_bridge_from_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
	if (!bridge)
		return -EINVAL;

so each registered instance needs to receive the attribute for its own
offload state to match the software bridge.

[ ... ]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> index 87b5fd349594..ac90ccda1272 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> @@ -1686,6 +1686,12 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
>  					    extack);
>  }
>  
> +bool mlx5_esw_bridge_port_exists(u16 vport_num, u16 esw_owner_vhca_id,
> +				 struct mlx5_esw_bridge_offloads *br_offloads)
> +{
> +	return mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
> +}
> +

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but should
the new port-presence filter also be applied to the NETDEV_CHANGEUPPER path,
which hits the same "instance does not own the port" condition?

mlx5_esw_bridge_port_changeupper() still filters only with the same-HCA test:

	rep = mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, &vport_num, &esw_owner_vhca_id);
	if (!rep)
		return 0;
	...
	else if (mlx5_esw_bridge_dev_same_hw(rep, esw))
		err = info->linking ?
			mlx5_esw_bridge_vport_peer_link(...) :
			mlx5_esw_bridge_vport_peer_unlink(upper, vport_num, esw_owner_vhca_id,
							  br_offloads, extack);

Unlike mlx5_esw_bridge_vport_peer_link(), mlx5_esw_bridge_vport_peer_unlink()
has no merged_eswitch / port-absent early return and goes straight to
mlx5_esw_bridge_vport_unlink(), which returns -EINVAL:

	port = mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
	if (!port) {
		NL_SET_ERR_MSG_MOD(extack, "Port is not attached to any bridge");
		return -EINVAL;
	}

mlx5_esw_bridge_switchdev_port_event() turns that into
notifier_from_errno(-EINVAL), which sets NOTIFY_STOP_MASK. The notifier is
registered with register_netdevice_notifier_net(&init_net,
&br_offloads->netdev_nb), so the stop verdict on the per-netns chain also
suppresses the global chain in call_netdevice_notifiers_info():

	ret = raw_notifier_call_chain(&net->netdev_chain, val, info);
	if (ret & NOTIFY_STOP_MASK)
		return ret;
	return raw_notifier_call_chain(&netdev_chain, val, info);

Does one un-enslave of a sibling PF's representor then drop
NETDEV_CHANGEUPPER for every global listener, including rtnetlink_event(),
fib_netdev_event(), addrconf_notify() and dsa_user_netdevice_event(), plus any
per-netns block registered after this one (a third PF's bridge-offload
instance would keep a stale peer port and FDB entries pointing at a vport that
has left the bridge)?

__netdev_upper_dev_unlink() discards the verdict:

	call_netdevice_notifiers_info(NETDEV_CHANGEUPPER,
				      &changeupper_info.info);

so nothing is reported to user space.

The trigger is the same one the commit message describes: the last-registered
instance never saw the CHANGEUPPER that would have created the peer port, then
ip link set <earlier PF's rep> nomaster hits the -EINVAL. It also looks
reachable on HCAs without merged_eswitch, where
mlx5_esw_bridge_vport_peer_link() returns 0 without creating a port while the
unlink side still fails.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/f26aa63abf085a087f7ed1df9080f9f0982bb311.1788884253.git.daniel%40iogearbox.net
