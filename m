Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B048125E;
	Mon,  5 Oct 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207369; cv=none; b=lQzcw/s3ETZFv5pja8wVDenxK0YXR0Ypj5rPeTk6hG8Kpz6CSl/mtrItZ7ZiKSDWc6oJ4U1UxUuj7K5WK+u8Ia5Nd0Cw42w9Xz4q7K49yHlSI7qYgh9DMsA0mldJ6ePpJSPAsKt5GIlkMs9UE4cA0Pvocu4r4ZJZhwrCh2SGas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207369; c=relaxed/simple;
	bh=D755r6xXb/wyK9M9P2atlpPVB8X5t5vPoEEjbvY12oc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=or+7QNAPMQ/+9oCpbsQIPinr8wZpD9RCzKfLE4YMLKqnnTcg2dwuHVUTwNI80mut4AyTJEACvhVC4u7xI3ofNseWQNcxxlJph5gPVWbtmjZ60eiBKNv/Me515+6o7UnBnnIr9KMqCtGJecOgxzYq742tyfoJ/03/Ulk5iSynvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB/Kis31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB/Kis31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D251F00898;
	Mon,  5 Oct 2026 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207367;
	bh=Or8bGKd328cjwT8opyEZlfDyIVPvTUBoe+zbP1elmYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VB/Kis31yp9kknyjWLppXvf5/9uVnI20+ZnC5JqOwjgd5VGolKJLtr4GgX5A0aK3F
	 5qi3AJiSmy/cyjYXOeisSUjtYRLXbkxwYLxQxHzQodNVnJs5xVyHf/dsgoW8HuqtTM
	 GGZ8l2+v4yS+4BY3d/+yGLOv/BFO9nfaWi8OdxsvEqjTYqcIKEgtKrACvQIA9LTDQl
	 t0jz5KHyRfdRsz+zTzKFZePwb9T9iLYJpmJSzePfG7G2oLCvWWIyo9clqU3jkO/Haa
	 A3ZNYY4VMjR00Iq3ewzfo4unC2yhW7GhATyhFqoIxDXo+oRvyMF+2JnUWkSCbQT7UU
	 XBXVWO5Dmiz0w==
Subject: Re: [PATCH net-next v5 3/3] net: dsa: let user ports wait for a PHY
 that probes late
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Mon, 05 Oct 2026 13:36:06 +0000
Message-ID: <179120736615.434549.15639450340100893930@kernel.org>
In-Reply-To: <20261001130208.105558-4-f@lex.la>
References: <20261001130208.105558-4-f@lex.la>
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

- [Medium] This patch arms phylink's self-requeueing late-PHY poller
  (pl->late_phy_poll on system_freezable_power_efficient_wq) for…
- [Low] The comment this patch adds on struct
  dsa_switch::phy_may_probe_late (include/net/dsa.h:458-460) says a…

--

net: dsa: let user ports wait for a PHY that probes late

This adds a phy_may_probe_late bit to struct dsa_switch. dsa_user_phy_setup()
passes it to phylink so that a user port can wait for a PHY whose driver
needs host firmware and probes late. mt7530 opts in.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 7781a63b4e6fd..e4c155605e27f 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -3548,6 +3548,7 @@ mt7530_probe_common(struct mt7530_priv *priv)
>  	priv->ds->priv = priv;
>  	priv->ds->ops = &mt7530_switch_ops;
>  	priv->ds->phylink_mac_ops = &mt753x_phylink_mac_ops;
> +	priv->ds->phy_may_probe_late = true;

[Severity: Medium]

With this opt-in, phylink's late PHY poller (pl->late_phy_poll) can be
pending on mt7530 user ports. Does anything on the switch shutdown path
cancel it?

mt7530_shutdown() and the mmio shutdown handler both call
dsa_switch_shutdown(). That function closes the conduits, detaches and
unlinks the user netdevs, and clears conduit->dsa_ptr:

net/dsa/dsa.c:dsa_switch_shutdown() {
    ...
	dsa_switch_for_each_user_port(dp, ds) {
		conduit = dsa_port_to_conduit(dp);
		user_dev = dp->user;

		netif_device_detach(user_dev);
		netdev_upper_dev_unlink(conduit, user_dev);
	}
    ...
}

It never calls phylink_disconnect_phy() or phylink_destroy(). Those two
functions and phylink_fwnode_phy_connect() are the only callers of
phylink_late_phy_cancel(). phylink_stop() does not cancel the work either.

Suppose the PHY driver binds shortly before a reboot or kexec. A poll that
is still queued (up to 30 seconds out after backoff) can then run after
.shutdown has returned:

phylink_late_phy_poll()
    phylink_attach_phy()
        phy_attach_direct()
            phy_init_hw()
            phy_resume()
    phylink_bringup_phy()
        phy_request_interrupt()

Could this cause MDIO traffic, a PHY soft reset and config_init, and an
IRQ request on hardware that has already been shut down? Could it also
leave that interrupt enabled for a kexec'd kernel?

For comparison, sfp_shutdown() calls cancel_delayed_work_sync() on
sfp->poll and sfp->timeout.

>  	mutex_init(&priv->reg_mutex);
>  	spin_lock_init(&priv->stats_lock);
>  	INIT_DELAYED_WORK(&priv->stats_work, mt7530_stats_poll);
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 5d12191b6f6f5..f7e78c3a123d3 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -455,6 +455,11 @@ struct dsa_switch {
>  	 */
>  	u32			dscp_prio_mapping_is_global:1;
>  
> +	/* Drivers whose .port_enable copes with a NULL phy may set this to
> +	 * let user ports wait for a PHY that needs host firmware.
> +	 */
> +	u32			phy_may_probe_late:1;

[Severity: Low]

Is "copes with a NULL phy" the whole requirement for opting in?

The only caller of .port_enable is dsa_user_open() ->
dsa_port_enable_rt(dp, dev->phydev). When phylink_late_phy_poll() attaches
the PHY later, it forces a major config and calls phy_start(). It does not
call .port_enable again with the new phy.

gswip_port_enable() already handles a NULL phy:

	if (phydev)
		mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;

So gswip meets the rule as written. Yet the commit message says gswip must
not opt in, because the PHY address would stay wrong until the next open.

The same applies to qca8k. Adding an if (phy) check around
phy_support_asym_pause(phy) in qca8k_port_enable() would satisfy this
comment. A PHY that attaches late would then never advertise asym pause.

Should the comment say that the driver must not depend on the phy argument
of .port_enable at all? That would match the reasoning in the commit
message.

> +
>  	/* Listener for switch fabric events */
>  	struct notifier_block	nb;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001130208.105558-1-f%40lex.la
