Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED044F560;
	Mon, 12 Oct 2026 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804289; cv=none; b=AHAOKH5A8TeUyDiIKa9pPyzToY0qEqysxzmBQsz8EpwJ9pEq0eel0uIYkMtHKn6XzWtYKFMhFkC/yANIVFhG6xRpFYIwKCcs4LD7m5JS9TpCGK9V33cle42YeaKmoQkFNeahH9qupjHZ1zSAsye/NuJtFmf3y5qAZscBrhbe6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804289; c=relaxed/simple;
	bh=B38smwblruWXCvJoUx6OXaz/01bEA2GO33Qy6S+3Xmc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhMcs/Z9gWZp/1J93nkOz7HX4I8qzkJSfTNa4TJruUeXDRh9sXNBTFx1/h/ics4hCMdQw8CusnSowGjAT6KNzmqfq637TQmLEauUIZFv/6chOgdGOibSw+vFVfnHTFj12POUyAEupIqpsO8b8aETMb6gZmrXgGAXqxlFCNhmRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfTFIKkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfTFIKkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9BB1F0089C;
	Mon, 12 Oct 2026 11:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791804287;
	bh=ZZF0VsQlliE8ftBpHaOqIBhgbCxZAYs8JB6TOzbqebg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bfTFIKkSTiM7RpwO6vRWlJu2DV7gRuwr4No4/sX7KfOZLzc1uVUliA0PVhkmpJqDJ
	 Ti/ugc80UlrlowcSa+equRLDudH+9+d9g8HxuWMEjIrQdcZJs0eq6gPWIx6OPYh4bm
	 rdOL1oSoz5KFqVdVCpDCyfloZ3iF+1Slwcffq/3AVJ1nAOASQN5qbFx63+HGxQUpYr
	 Nc+cM3zsZb3WDzEPba+1iRUvRal5tiQWSfmarBcj/ECbujL2PIyXN0Q646LyAJeGlE
	 9cO3hvZPnsgswbrRwDEOWxCFnE6eUHYNilgqO3zcr8f68YDELlhm53MUISFxjxyxq4
	 LhfLRSkXNLtdg==
Subject: Re: [PATCH net-next v14 8/9] net: dsa: lan9645x: add bridge support
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, edumazet@kernel.org,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Mon, 12 Oct 2026 11:24:46 +0000
Message-ID: <179180428624.434549.14425623884223795761@kernel.org>
In-Reply-To:
 <20261008-dsa_lan9645x_switch_driver_base-v14-8-3d2a72661213@microchip.com>
References:
 <20261008-dsa_lan9645x_switch_driver_base-v14-8-3d2a72661213@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the general-purpose PGIDs run out, L2 multicast groups
  fall back to PGID_MC.
- [Medium] Setting ds->ageing_time_min/max makes a bridge join fail late,
  and the failed join leaves DSA's dp->vlan_filtering out of step with…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the new
  lan9645x_set_ageing_time() is affected by it.

--

net: dsa: lan9645x: add bridge support

This adds hardware bridge offload to the lan9645x DSA driver for a single
bridge. It adds ageing time configuration with min/max limits enforced by
the DSA core, plus bridge port flags and STP state handling. Host flooding
is done by adding the CPU port module to the global flood masks.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> index a0f48f3ad9aff..cefe643fce182 100644
> --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c

[ ... ]

> @@ -306,6 +302,19 @@ static int lan9645x_setup(struct dsa_switch *ds)
>  	ds->fdb_isolation = true;
>  	ds->max_num_bridges = 1;
>  
> +	/* ANA_AUTOAGE_AGE_PERIOD is a seconds-based field and entries are
> +	 * aged after 2 * AGE_PERIOD, giving (2 * FIELD_MAX) seconds of
> +	 * maximum aging and 2 seconds of minimum aging.
> +	 *
> +	 * An AGE_PERIOD of 0 stops the analyzer from aging at all, which is
> +	 * the opposite of what a bridge ageing_time of 0 asks for. The bridge
> +	 * expires every dynamic entry immediately in that case and floods, so
> +	 * reject it rather than keep learned addresses forever.
> +	 */
> +	ds->ageing_time_min = 2U * MSEC_PER_SEC;
> +	ds->ageing_time_max = 2U * MSEC_PER_SEC *
> +			      FIELD_MAX(ANA_AUTOAGE_AGE_PERIOD);

[Severity: Medium]
Can a bridge join that fails on these limits leave the port VLAN-unaware
in hardware after the next successful join?

With ageing_time_min set, dsa_switch_ageing_time() returns -ERANGE for any
bridge ageing_time below 2s, including 0. For example:

  ip link add br0 type bridge vlan_filtering 1 ageing_time 0

dsa_port_switchdev_sync_attrs() applies the ageing time last. By then,
dsa_port_vlan_filtering(dp, br_vlan_enabled(br)) has already called
lan9645x_port_vlan_filtering(true) and set dp->vlan_filtering = true.

The rollback in dsa_port_bridge_join() then does:

net/dsa/port.c:dsa_port_bridge_join() {
    ...
out_rollback_unoffload:
	switchdev_bridge_port_unoffload(...);
	dsa_flush_workqueue();
out_rollback_unbridge:
	dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
out_rollback:
	dsa_port_bridge_destroy(dp, br);
    ...
}

This path never calls dsa_port_switchdev_unsync_attrs() or
dsa_port_reset_vlan_filtering(), so dp->vlan_filtering stays true.

Meanwhile the BRIDGE_LEAVE notifier reaches lan9645x_port_bridge_leave().
That function calls lan9645x_vlan_set_hostmode(), which sets
p->vlan_aware = false.

Now suppose the ageing time is fixed and the port is added to a
vlan_filtering=1 bridge again. dsa_port_vlan_filtering() returns early:

	if (dsa_port_is_vlan_filtering(dp) == vlan_filtering)
		return 0;

So .port_vlan_filtering is never called. Neither
lan9645x_port_bridge_join() nor lan9645x_vlan_clear_hostmode() restores
p->vlan_aware.

Would the port then stay at VLAN_AWARE_ENA=0 in ANA_VLAN_CFG while it is
in a VLAN-aware bridge? That would give wrong ingress VLAN classification
and filtering.

The incomplete rollback is in the DSA core. This patch makes it reachable
through the new ageing limits, and the new bridge_leave creates the
mismatch on the driver side. The issue still seems to be there at the end
of the series.

[ ... ]

> @@ -324,6 +333,246 @@ static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
>  	lan9645x_phylink_get_caps(ds->priv, port, config);
>  }
>  
> +static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +
> +	/* Entry must suffer two aging scans before it is removed, so it is
> +	 * aged after 2*AGE_PERIOD, and the unit is in seconds.
> +	 */
> +	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(msecs / (2 * MSEC_PER_SEC)),
> +		ANA_AUTOAGE_AGE_PERIOD,
> +		lan9645x, ANA_AUTOAGE);
> +
> +	return 0;
> +}

[Severity: Medium]
This is a pre-existing issue in the DSA core and was not introduced by
this patch, but it affects the new lan9645x_set_ageing_time(). Does
raising the bridge ageing time ever reach the hardware?

dsa_port_ageing_time() sends the notifier before it updates the cached
value:

net/dsa/port.c:dsa_port_ageing_time() {
    ...
	err = dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
	if (err)
		return err;

	dp->ageing_time = ageing_time;
    ...
}

dsa_switch_fastest_ageing_time() then takes the minimum over all ports,
including the old value of the requesting port:

	dsa_switch_for_each_port(dp, ds)
		if (dp->ageing_time && dp->ageing_time < ageing_time)
			ageing_time = dp->ageing_time;

So a change from 300000 ms to 600000 ms programs 300000 ms through
lan9645x_set_ageing_time() and returns success. 600000 ms is then cached
in dp->ageing_time, with no further hardware write.

The fix probably belongs in the DSA core rather than in this driver: the
requester's cached value could be updated, or left out, before the
minimum is computed.

[ ... ]

> +static int lan9645x_port_bridge_flags(struct dsa_switch *ds, int port,
> +				      struct switchdev_brport_flags f,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +

[ ... ]

> +	if (f.mask & BR_MCAST_FLOOD) {
> +		bool ena = !!(f.val & BR_MCAST_FLOOD);
> +
> +		lan9645x_port_pgid_set(lan9645x, PGID_MC, port, ena);
> +		lan9645x_port_pgid_set(lan9645x, PGID_MCIPV4, port, ena);
> +		lan9645x_port_pgid_set(lan9645x, PGID_MCIPV6, port, ena);
> +	}

[Severity: Medium]
Does this break the PGID_MC fallback that the mdb code uses when the
general-purpose PGIDs run out?

When a group's PGID is shared or no PGID is free, __lan9645x_mdb_del()
points the L2 group at PGID_MC:

drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c:__lan9645x_mdb_del() {
    ...
	/* Shared PGID or on flood mask. Point the entry at the L2 MC flood mask
	 * instead. This way our mac table entry survives and MAC_CPU_COPY
	 * keeps host membership working.
	 */
    ...
	lan9645x_mdb_narrow_dest(lan9645x, mdb_entry, type, NULL, PGID_MC,
				 new_ports);
    ...
}

__lan9645x_mdb_add() also keeps a group that is already on the flood mask
pointed at PGID_MC:

		/* For a L2 MC group already on the flood mask, we keep it there
		 * so that the host can still join/leave a group we had to give
		 * up offloading. A front port that joins forwards according to
		 * the flood masks, like the other members.
		 */
		if (lan9645x_mdb_on_flood_mask(mdb_entry, type))
			return lan9645x_mdb_widen_dest(lan9645x, mdb_entry,
						       type, NULL, PGID_MC,
						       new_ports);

This fallback depended on PGID_MC holding every front port, as
lan9645x_setup() sets it. With this change, a port configured with:

  bridge link set dev swpN mcast_flood off

is removed from PGID_MC. If that port is also a registered member of an
L2 group in the fallback state, will it stop receiving that group's
traffic?

The software bridge still delivers registered groups to their members
whatever their mcast_flood setting, so hardware forwarding would no
longer match it. Also, when such a port joins through
__lan9645x_mdb_add(), the join reports success but the port gets no
traffic. The issue still seems to be there at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip.com
