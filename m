Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC09247291;
	Wed, 23 Sep 2026 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123895; cv=none; b=h97K0JCSsehYLWjLjoBaroHxTc+qzw+ZiS4SL7zjZfFL0fZSW6xDMxvZ9r5qskdMCd7dSNEgQl6CxPjmSBKxAyFbnqIYV5Y2JjBOhDE+6FKi0F0OWYbn63433LnI6u/FKBL8kEqHktb0uApIMp8v+7R60w35r0loUXR5kJ74jjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123895; c=relaxed/simple;
	bh=WZvOHN2BoRZU0JtgBpgx729kn4vYBJ9Kbwjfd8dznt8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PE0YJtqPKXhGPS2bEyIoigC+9J67aW0N4DouD9mfw/LDDAbc4TLOGMR0WQCrgOZ9s9VjAoadoTC1zIRoshXinr/Nz46QKZQnmvFDKkiEKnx38NgfvwtSaVAvsp7iQu8gdtyIlsCPH0G6jjAAh5a6xvOuxZcbwQaR1DShU6pf/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+dJJbe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+dJJbe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B321F00893;
	Wed, 23 Sep 2026 00:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790123894;
	bh=0aTVnbzWJPeYud3EsdtKRiqfTLJlt87bivImwnDk6sk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B+dJJbe7Z4y6LtkqSMz3DZYvoUQb1Herkz59MJw03FU9B9AZ9lyl4BBw6qUYgW62N
	 UbTiQLp6levyjE/BFt1i0ClXroPXAPTKrqqM9MSCpOE0oK8LC9Vn86PbewIJgpK6TN
	 6uNTQiDwDi6qDcy6b/WnU56pla+kzcydaQsRubrQHITfPKhFu7TjviNUGju9f+hHPf
	 g3S5NTapcFr2GEwZ/DGXQSjsq28qR+SmdVgjJav/sH7XDtaOITxOUxwgEPU9l0AWt7
	 vEF8F0aE5JY8bwpCgAk7RX1NKFFYFXm80zhMn6W8f+5EwZ8bbh6uLGCDItVeUNHZMu
	 3RUMZWBFgsXUQ==
Subject: Re: [PATCH net-next v4 3/7] net: dsa: motorcomm: Split MIB buffers
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 00:38:12 +0000
Message-ID: <179012389290.2160803.2436755196475374007@kernel.org>
In-Reply-To: <20260921203040.1203911-4-mmyangfl@gmail.com>
References: <20260921203040.1203911-4-mmyangfl@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Unbalanced `enable_delayed_work()` in
  `yt921x_dsa_port_setup()` (drivers/net/dsa/motorcomm/chip.c:4171-4172)…
- [Low] Commit message describes only a memory-layout optimisation, but
  the patch also reworks the MIB work lifecycle: it adds a new…

--

net: dsa: motorcomm: Split MIB buffers

The MIB statistics buffers and the polling work are moved out of struct
yt921x_port into a separate struct yt921x_mib that is allocated per port
with devm_kzalloc().  Allocation happens in the DSA .port_setup callback,
and a new .port_teardown callback is added.

> With MIB improvement introduced later, struct yt921x_priv will be over
> 20k which is not very good for a single kmalloc(). Dynamically allocate
> the MIB structures to reduce the size of struct yt921x_priv, and do not
> waste memory on dummy ports.

[Severity: Low]
The changelog only mentions the memory layout change, but the patch also
reworks the MIB work lifecycle.  Could the description also cover that:

- a new .port_teardown op is added to yt921x_dsa_switch_ops,
- the unconditional per-port disable_delayed_work_sync() loop in
  yt921x_mdio_remove() is removed, so cancellation now depends on DSA
  calling yt921x_dsa_port_teardown(),
- enable_delayed_work() / disable_delayed_work_sync() become a counted
  pair across DSA port setup/teardown cycles,
- the six stats callbacks (yt921x_dsa_get_ethtool_stats,
  yt921x_dsa_get_eth_mac_stats, yt921x_dsa_get_eth_ctrl_stats,
  yt921x_dsa_get_rmon_stats, yt921x_dsa_get_stats64,
  yt921x_dsa_get_pause_stats) now return silently for any port outside
  info->internal_mask | info->external_mask?

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index d0b25ded24478..ad06d894b0015 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -4107,11 +4147,40 @@ yt921x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
>  	return DSA_TAG_PROTO_YT921X;
>  }
>  
> +static void yt921x_dsa_port_teardown(struct dsa_switch *ds, int port)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct yt921x_port *pp = &priv->ports[port];
> +	struct yt921x_mib *pm = pp->mib;
> +
> +	/* get_stats64() might not be synchronized with port_teardown(), hold
> +	 * the MIB block till the device teardown
> +	 */
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
> +	if (pm) {
> +		enable_delayed_work(&pm->work);
> +	} else if (BIT(port) & (priv->info->internal_mask |
> +				priv->info->external_mask)) {
> +		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
> +		if (!pm)
> +			return -ENOMEM;
> +		pp->mib = pm;
> +
> +		pm->port = pp;
> +		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
> +	}
> +
>  	mutex_lock(&priv->reg_lock);
>  	res = yt921x_port_setup(priv, port);
>  	mutex_unlock(&priv->reg_lock);

[Severity: Medium]
Can this enable_delayed_work() run without a matching
disable_delayed_work_sync() and trip the workqueue disable count
underflow warning?

The first .port_setup for a port allocates pm, runs INIT_DELAYED_WORK()
(disable count 0) and publishes pp->mib before the fallible
yt921x_port_setup() call.  If yt921x_port_setup() fails on a register
access, .port_setup returns an error and DSA does not call
.port_teardown for that port:

net/dsa/devlink.c:dsa_port_devlink_setup() {
	if (ds->ops->port_setup) {
		err = ds->ops->port_setup(ds, dp->index);
		if (err)
			return err;
	}
}

net/dsa/dsa.c:dsa_port_setup() {
	err = dsa_port_devlink_setup(dp);
	if (err)
		return err;
}

dp->setup stays false, and dsa_tree_setup_ports() then retries the same
port:

net/dsa/dsa.c:dsa_tree_setup_ports() {
			err = dsa_port_setup(dp);
			if (err) {
				err = dsa_port_setup_as_unused(dp);
}

On the retry pp->mib is non-NULL, so enable_delayed_work() runs with the
disable count still at 0:

kernel/workqueue.c:work_offqd_enable() {
	if (likely(offqd->disable > 0))
		offqd->disable--;
	else
		WARN_ONCE(true, "workqueue: work disable count underflowed\n");
}

Would it be better to only call enable_delayed_work() when a previous
teardown actually disabled the work, or to undo the enable/init state on
the yt921x_port_setup() failure path?

> @@ -4666,6 +4735,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
>  	/* port */
>  	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
>  	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
> +	.port_teardown		= yt921x_dsa_port_teardown,
>  	.port_setup		= yt921x_dsa_port_setup,
>  #if IS_ENABLED(CONFIG_DCB)
>  	/* dscp */
> @@ -4695,12 +4765,6 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
>  	if (!priv)
>  		return;
>  
> -	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
> -		struct yt921x_port *pp = &priv->ports[i];
> -
> -		disable_delayed_work_sync(&pp->mib_read);
> -	}
> -
>  	dsa_unregister_switch(&priv->ds);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921203040.1203911-1-mmyangfl%40gmail.com
