Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C053FD5C;
	Wed,  9 Sep 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966976; cv=none; b=J7t/m2gHUMD3gr9l39+Fnzx6LQUC3UWrRoFg+jY7iNIdC8IkSKZmVe1SjOvQ9011omswa4zYrI+BCLNjjfIf/w52I2m7piXEyffw+0qsBBv3GbLh0FBtX7MzBZZbSXLEhfgiEca4H27CfCgRkfftPRQoS5wlvWLoV8DOq3elvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966976; c=relaxed/simple;
	bh=N2OHMkg6LERKRgoKvP1UsRXdYcwY2AEQFcSv7OGmjZs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JLLdLzXc8sqU/qRMWJcSekPJjtjTxgF0+gXTCO4UtEbBsdWl43D+FvWbso70xcRqRkHJ2jjJh1mgehbpLMEhpaWI/mBygvvWxpvLOJJqVPB1AIgSTDuC3uQSvDkFTCn8IOHqKqj6gVyoQG9FIbA2e1TxMWVo+WP7sPjxhDypcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/AMLb0D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/AMLb0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E1B1F00A3D;
	Wed,  9 Sep 2026 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966974;
	bh=TCe9d7CbBS7ZUrrks/Db2Zz5HUpxhow2pCQbfMdvO2w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n/AMLb0DDJ2rG18OroBK7s8u3ZhRAuQqwLqw9r8PvNPfh+HLpGV1jW4w918ZdGlcA
	 rI2ERfMr7o6wrLKJCOnHjLKKqPL2EUOQFI/3+3SqmyldnIzr7R/w9EXo1floKUf55X
	 LOlBzZyPhtDnHK3d3ewF7j11zsY9QYxhhJ88IBuk4/29wxe6ny2HroeVlqIMJuU7P5
	 d/IFHwzyUFdjx8mevWJLsQ/v4POlzErMiLpw98ZDjwjOrjIgmgVRbW+Iec75y4jaUU
	 LP2e01WwW199a73hVHgA6+++gbYVthYSm0e8im8s3JDusWV4Z/azTjoQXxqDmkat0d
	 x9cwlX92vEIEg==
Subject: Re: [PATCH net-next v3 2/6] net: dsa: motorcomm: Split MIB buffers
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 15:16:13 +0000
Message-ID: <178896697363.219967.5664786879390405949@kernel.org>
In-Reply-To: <20260906131414.2683362-3-mmyangfl@gmail.com>
References: <20260906131414.2683362-3-mmyangfl@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1 (1)

- [Medium] Asymmetric use of the counted workqueue disable API: the new
  .port_teardown callback yt921x_dsa_port_teardown()…
- [Low] The descriptor-table comment above yt921x_mib_descs[] says 'Must
  agree with yt921x_mib', but after this patch `struct yt921x_mib`…

Pre-existing issues:
- [Medium] The software MIB shadow is not re-zeroed when the hardware MIB
  counters are cleared: yt921x_chip_setup() issues YT921X_MIB_CTRL_CLEAN…
- [Low] Unsynchronized 64-bit statistics: the MIB counters are written by
  yt921x_mib_read() from the poll worker under priv->reg_lock (plain…

--

net: dsa: motorcomm: Split MIB buffers

This moves the per-port MIB statistics, the derived rx/tx frame counters
and the MIB poll delayed_work out of struct yt921x_port into a new
struct yt921x_mib, allocated with devm_kzalloc() from .port_setup() only
for internal/external ports.  A new .port_teardown() callback replaces
the disable loop that used to live in yt921x_mdio_remove().

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index ad5fe1ccb1d71..95041a2fb0ecc 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -549,9 +549,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
>  {
>  	struct yt921x_port *pp = &priv->ports[port];
>  	struct device *dev = to_device(priv);
> -	struct yt921x_mib_stats *mib = &pp->mib;
> +	struct yt921x_mib *pm = pp->mib;
> +	struct yt921x_mib_stats *mib;
>  	int res = 0;
>  
> +	mib = &pm->stats;
> +
>  	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
>  	 * to keep its consistency, since we have to read registers one by one
>  	 * and there is no way to make a snapshot of MIB stats.

[Severity: Low]
Two comments look stale after the split.

The header comment above yt921x_mib_descs[] says "Must agree with
yt921x_mib", but struct yt921x_mib is now the wrapper holding the port
back pointer, the delayed work and the two derived counters.  The
descriptor offsets are applied to the flat counter layout instead:

	mib = &pm->stats;
	...
		u64 *valp = &((u64 *)mib)[i];

Should that comment name yt921x_mib_stats now?

The comment kept here still says "Reading of yt921x_port::mib is not
protected by a lock", although that member is only a pointer after this
patch and the lockless data lives in yt921x_mib::stats, rx_frames and
tx_frames.  This second half is removed later in the series by "net: dsa:
motorcomm: Fix MIB synchronization", but the yt921x_mib_descs comment
still reads "Must agree with yt921x_mib" at the end of the series.

[ ... ]

> @@ -786,7 +810,12 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  {
>  	struct yt921x_priv *priv = to_yt921x_priv(ds);
>  	struct yt921x_port *pp = &priv->ports[port];
> -	struct yt921x_mib_stats *mib = &pp->mib;
> +	struct yt921x_mib *pm = pp->mib;
> +	struct yt921x_mib_stats *mib;
> +
> +	if (!pm)
> +		return;
> +	mib = &pm->stats;
>  
>  	stats->rx_length_errors = mib->rx_undersize_errors +
>  				  mib->rx_fragment_errors;
> @@ -802,8 +831,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  	/* stats->tx_heartbeat_errors */
>  	stats->tx_window_errors = mib->tx_late_collisions;
>  
> -	stats->rx_packets = pp->rx_frames;
> -	stats->tx_packets = pp->tx_frames;
> +	stats->rx_packets = pm->rx_frames;
> +	stats->tx_packets = pm->tx_frames;
>  	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
>  	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;

[Severity: Low]
This isn't a bug introduced by this patch, but can these u64 reads tear on
32-bit?  yt921x_mib_read() stores pm->rx_frames and pm->tx_frames with
plain assignments from the poll worker, and yt921x_dsa_get_stats64() reads
them with neither priv->reg_lock nor a u64_stats_sync retry loop, so a
reader can observe halves from two different updates.  The subtraction

	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;

can then underflow.

The baseline had the same lockless read of pp->rx_frames/pp->tx_frames, and
later patches in this series ("net: dsa: motorcomm: Use u64_stats_t for MIB
stats" and "net: dsa: motorcomm: Fix MIB synchronization") wrap the writer
in u64_stats_update_begin()/end() and the reader in
u64_stats_fetch_begin()/u64_stats_fetch_retry(), so this is only noted for
completeness.

[ ... ]

> @@ -3988,7 +4026,9 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
>  		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
>  			port, res);
>  
> -	schedule_delayed_work(&priv->ports[port].mib_read, 0);
> +	pm = priv->ports[port].mib;
> +	if (pm)
> +		schedule_delayed_work(&pm->work, 0);
>  }
>  
>  static void
> @@ -4108,11 +4148,35 @@ yt921x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
>  	return DSA_TAG_PROTO_YT921X;
>  }
>  
> +static void yt921x_dsa_port_teardown(struct dsa_switch *ds, int port)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct yt921x_port *pp = &priv->ports[port];
> +	struct yt921x_mib *pm = pp->mib;
> +
> +	if (pm)
> +		disable_delayed_work_sync(&pm->work);
> +}
> +
>  static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
>  {
>  	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct yt921x_port *pp = &priv->ports[port];
> +	struct device *dev = to_device(priv);
> +	struct yt921x_mib *pm = pp->mib;
>  	int res;
>  
> +	if (!pm && (BIT(port) & (priv->info->internal_mask |
> +		    priv->info->external_mask))) {
> +		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
> +		if (!pm)
> +			return -ENOMEM;
> +		pp->mib = pm;
> +
> +		pm->port = pp;
> +		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
> +	}
> +

[Severity: Medium]
Is the disable/enable pair here asymmetric?  yt921x_dsa_port_teardown()
calls disable_delayed_work_sync(&pm->work), but yt921x_dsa_port_setup() has
no matching enable_delayed_work(), and the "if (!pm && ...)" gate means an
already allocated pm (and its work item, including the disable counter) is
reused untouched.

The disable count is a plain counter in the work data, documented in
kernel/workqueue.c as:

 * Disable @work by incrementing its disable count and cancel it if currently
 * pending. As long as the disable count is non-zero, any attempt to queue @work
 * will fail and return %false.

with work_offqd_disable()/work_offqd_enable() incrementing/decrementing it
and enable_delayed_work() being the only decrement.  So after a single
teardown/setup cycle on a still-live switch:

yt921x_phylink_mac_link_up()
	schedule_delayed_work(&pm->work, 0);	/* returns false, forever */

yt921x_mib_poll() never runs again and the cached counters read by
yt921x_dsa_get_stats64() and the ethtool callbacks stay frozen, including
the 32-bit wrap accumulation done in yt921x_mib_read().

Two paths where DSA runs port_setup again for the same priv:

net/dsa/dsa.c:dsa_tree_setup_ports() {
	...
			err = dsa_port_setup(dp);
			if (err) {
				err = dsa_port_setup_as_unused(dp);
	...
}

dsa_port_setup() already ran the driver's port_teardown on its error path
(dsa_port_devlink_setup() calls dsa_port_devlink_teardown() when
devlink_port_register() fails), and then port_setup is called again.

In a multi-switch tree, dsa_switch_remove() -> dsa_tree_teardown() tears
down the ports of the surviving switches too, and a later re-probe runs
dsa_tree_setup() again, calling port_setup() for a port whose pp->mib is
already non-NULL.

Should port_setup() call enable_delayed_work(&pm->work) when it reuses an
existing pm?  As written, each cycle also bumps the disable depth
monotonically until it hits WORK_OFFQ_DISABLE_BITS and WARN_ONCE fires.

[Severity: Medium]
This is a pre-existing issue, but should the shadow counters be re-zeroed
here rather than only on first allocation?  yt921x_chip_setup() clears the
hardware MIB on every .setup():

	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);

while pm->stats is zeroed only by the devm_kzalloc() inside the
"if (!pm && ...)" branch.  dsa_switch_teardown() clears ds->setup, so a
second dsa_tree_setup() can call ds->ops->setup again for the same priv (for
example when a sibling switch in the tree is removed and re-probed).  The
retained shadow then holds pre-clean values while the hardware restarts at
zero, and the first read applies the wrap correction:

drivers/net/dsa/motorcomm/chip.c:yt921x_mib_read() {
	...
			val = (old_val & ~(u64)U32_MAX) | val0;
			if (val < old_val)
				val += 1ull << 32;
	...
}

adding a spurious 2^32 to every affected counter.  The baseline had the same
behaviour with the shadow embedded in priv.

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index 805febb486838..5bf2d3409f4bb 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h
> @@ -913,6 +913,15 @@ struct yt921x_mib_stats {
>  	u64 tx_oam;
>  };
>  
> +struct yt921x_mib {
> +	struct yt921x_port *port;
> +
> +	struct delayed_work work;
> +	struct yt921x_mib_stats stats;
> +	u64 rx_frames;
> +	u64 tx_frames;
> +};
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906131414.2683362-1-mmyangfl%40gmail.com
