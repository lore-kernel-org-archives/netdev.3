Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8EA4DA9A8;
	Mon, 19 Oct 2026 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406079; cv=none; b=HVV5+Nk/0U0Zo7yUxY2Yv3TMvJJcJ45toN5aKrKYZLeLn/W6yzSHgX372nUQjpXzKStn0qDnJcpEVciwCbvqq0ja0ub9uMULBbsBTD9alNo0ElwML0cSeZA0+Q6xnNQumeIZpUL+F5eN3TYqEaZh+y2UvKdW4ts8a2XsxRJI4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406079; c=relaxed/simple;
	bh=1q0W2XwPkBes4wfQ2gLch9Q03IGkWQgB5t30q/shtWI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqjZgQD1o8H7BrHZuwSJcCdhVnETpQYg656iugafAijmjEXivQAMfhR3s82N2YWGpyKdR9PwYpLmujgWciGlM5ph0cwt+9tJhSTGvB2N7z49Kyl9/RkGkAVce8ZAeNgb9di60Ir0MoWDjTYn36tK44c5BG9agiUZqZNIqBunec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7mq3wxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7mq3wxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA601F000C4;
	Mon, 19 Oct 2026 10:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792406077;
	bh=ozaadMiWrGlvuHxC/GhdQnHmb4OFnlsZC/fVoaaNGUs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c7mq3wxY0F5KFxsQCt+JXeAtfWPNLVD3oUDNZkTO/ZqeyE3AzRAH24mV6NgvS+lzY
	 V+Ju8ybiIjVBEKYED4KPbVkbsatxkMoHac/Ebn+Pzg+59P1HxBemb22NLiJAZDxmTf
	 DDjF0kvVDVZ4xyBiCSOeGp4INr5wmTckse3JyCS+u9lU7zK8ZeSBLngNPxBi7ycG1s
	 p2hGuDYKjqujC2wB6z3q5jGHYWNh//JniHdFMvg2m3BMz8+7ox6zbmo/IcgFNplMX8
	 GUPP3i2kxIgXBkWF0QBSq0vb7wJ6H82dZ629ryN7Q0ATmr2hsMPGZxDRCCyXfzVD/h
	 KXm4ePQ/X6emg==
Subject: Re: [PATCH net-next v2 6/6] net: mdio: bcm-unimac: implement
 timestamped MDIO writes
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 richardcochran@gmail.com, florian.fainelli@broadcom.com, opendmb@gmail.com,
 nb@tipi-net.de, theo.lebrun@bootlin.com, andrew@lunn.ch,
 linux@armlinux.org.uk, conor.dooley@microchip.com,
 bcm-kernel-feedback-list@broadcom.com, tglx@kernel.org, jstultz@google.com,
 sboyd@kernel.org, mlichvar@redhat.com, olteanv@gmail.com,
 h.feurstein@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 10:34:35 +0000
Message-ID: <179240607580.3135.9897216542640862141@kernel.org>
In-Reply-To: <20261018100257.566267-7-jjc@jclark.com>
References: <20261018100257.566267-7-jjc@jclark.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] unimac_mdio_init_sts() reads the MDC reference rate once at
  probe (`priv->mdio_ref_rate = clk_get_rate(ref_clk)`) and caches it…
- [Medium] net: mdio: bcm-unimac: broken probe deferral in
  unimac_mdio_probe() for GENET
- [Low] The patch gives the mdio node's `clocks` property a new driver-
  side meaning but does not update…
- [Low] On the GENET path, unimac_mdio_probe() gets ref_clk from the mdio
  node with devm_clk_get_optional() but never prepares or enables it.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  makes it visible.

--

net: mdio: bcm-unimac: implement timestamped MDIO writes

This patch adds a write_sts callback to the UniMAC MDIO driver. The callback
takes system timestamps around the MDIO command start and shifts them by
the computed time to the MDC edge that clocks the last data bit. The MDC
reference rate comes from a clock on the mdio node, and write_sts is only
offered when that clock reports a non-zero rate.

> diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
> index 31e396cc9fbf2..a18e213e3832a 100644
> --- a/drivers/net/mdio/mdio-bcm-unimac.c
> +++ b/drivers/net/mdio/mdio-bcm-unimac.c

[ ... ]

> @@ -234,11 +333,21 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
>  	return ret;
>  }
>  
> +static bool unimac_mdio_init_sts(struct unimac_mdio_priv *priv,
> +				 struct clk *ref_clk)
> +{
> +	/* The reference rate is taken to be fixed, so read it once. */
> +	priv->mdio_ref_rate = clk_get_rate(ref_clk);

[Severity: Medium]
The comment says the reference rate is taken to be fixed. Is anything
actually keeping it fixed? There is no clk_rate_exclusive_get() and no clk
notifier, so the rate cached at probe can go stale if another consumer or a
parent change alters it later.

unimac_mdio_sts_delays() combines the live MDIO_CFG divider with this
cached value:

	*pre_ns = div64_u64((2ULL * bits - 1) * divisor * NSEC_PER_SEC,
			    ref_rate2);

The window between the pre and post timestamps is only about one MDC period
wide (two with MDIO_SUPP_PREAMBLE), but the offsets span about 64 periods.
At 2.5 MHz MDC, a 1% rate change moves the edge by about 256 ns, while the
period is 400 ns.

Would unimac_mdio_write_sts() then give __mdiobus_write_sts() bounds that
silently miss the real MDC edge? The struct mii_bus documentation says
write_sts should be set "only if timestamps can always be provided".

Could the driver take clk_rate_exclusive_get() at probe to enforce this
assumption? Calling clk_get_rate() from write_sts instead runs into the
prepare_lock vs mdio_lock ordering noted in macb_main.c.

> +
> +	return priv->mdio_ref_rate != 0;
> +}

[ ... ]

> @@ -277,11 +386,23 @@ static int unimac_mdio_probe(struct platform_device *pdev)
>  		priv->wait_func_data = pdata->wait_func_data;
>  		bus->phy_mask = ~pdata->phy_mask;
>  		priv->clk = pdata->clk;
> +		/* priv->clk is GENET's main clock, which gates register
> +		 * access. ref_clk is the clock used as the MDC reference,
> +		 * which we get from the MDIO node. The presence of this
> +		 * clock enables write_sts.
> +		 */
> +		ref_clk = devm_clk_get_optional(&pdev->dev, NULL);
> +		if (IS_ERR(ref_clk) && PTR_ERR(ref_clk) != -EPROBE_DEFER) {
> +			dev_warn(&pdev->dev, "no MDC reference clock: %pe\n",
> +				 ref_clk);
> +			ref_clk = NULL;
> +		}

[Severity: Medium]
The commit message says a deferral of the clock lookup is passed on
so the MDIO bus waits for the clock's provider. Does that work on the
GENET path?

There the UniMAC device is not bound from DT. bcmgenet_mii_register()
creates it and calls platform_device_add(ppdev), and the probe result
of unimac_mdio_probe() is not propagated back through device_add().
If the mdio node's clock provider is not ready yet, the device is put
on the deferred probe list and platform_device_add() still returns 0.

The clocks property is on the mdio child node, not on the genet node,
so fw_devlink does not hold off bcmgenet_probe() either. It only adds
a sync-state-only proxy link to the parent.

bcmgenet_probe() then carries on as if the bus existed.
bcmgenet_mii_of_init() cannot find MoCA PHYs with
of_phy_find_device(), and register_netdev() runs with no MDIO bus or
PHY registered. Bringing the interface up before the deferred probe
completes would fail with "could not attach to PHY".

When the deferred unimac_mdio_probe() does run, could it race with
bcmgenet_open()? bcmgenet_open() resets the UMAC through
bcmgenet_umac_reset() and init_umac(), and that could happen while
of_mdiobus_register() is scanning the bus.

No in-tree DT gives a GENET mdio node a clock today, so this becomes
reachable only once the BCM2711 GISB clock is wired up. That is the
case this patch is preparing for.

write_sts is optional, so would it be simpler to treat -EPROBE_DEFER
like any other error on the pdata path and not offer write_sts? The
cost is that write_sts would then depend on probe order.

Alternatively, bcmgenet could look up the MDC reference clock itself
and pass it in struct unimac_mdio_pdata. A deferral would then happen
in bcmgenet_probe(), where it is actually honoured.

[Severity: Low]
On the GENET path, ref_clk is obtained here but never prepared or enabled.
Its only use is the clk_get_rate() call in unimac_mdio_init_sts(), and
unimac_mdio_write_sts() enables only priv->clk. That is GENET's main clock,
not the clock MDC is divided from.

The standalone path reads the same clocks property and calls
clk_prepare_enable() on that clock around every transfer.

The GENET path therefore relies on the provider marking the clock critical,
as the commit message says the BCM2711 GISB clock will. Neither the driver
nor the binding requires that.

If a DT gives a GENET mdio node a gateable, non-critical clock, can
clk_disable_unused gate it and stop MDIO? Would
devm_clk_get_optional_enabled() remove that dependency?

A smaller point: clk.h documents clk_get_rate() as "only valid once the
clock source has been enabled". unimac_mdio_init_sts() reads the rate before
any enable on both paths. Under the common clock framework the returned rate
does not depend on the enable state, so this is only a mismatch with the
documented contract.

[Severity: Medium]
This isn't a bug introduced by this patch, but the new comment makes it
more visible. unimac_mdio_clk_set() still computes the MDC divider from
priv->clk, falling back to 250 MHz:

	rate = clk_get_rate(priv->clk);
	if (!rate)
		rate = 250000000;

	div = (rate / (2 * priv->clk_freq)) - 1;

On the GENET path, priv->clk is pdata->clk. bcmgenet_mii_register() fills
that in with GENET's own clock (ppd.clk = priv->clk), which the comment
above says is not the MDC reference.

Now that ref_clk is available, should unimac_mdio_clk_set() use its rate
for the divider too?

For example, the BCM2711 genet node has no clocks, so the divider uses the
250 MHz fallback. A clock-frequency property on the mdio node would then
produce an MDC of about 200/250 of the requested frequency.

The new write_sts bounds are not affected, because
unimac_mdio_sts_delays() reads the divider back from MDIO_CFG.

>  	} else {
>  		bus->name = "unimac MII bus";
>  		priv->wait_func_data = priv;
>  		priv->wait_func = unimac_mdio_poll;
>  		priv->clk = devm_clk_get_optional(&pdev->dev, NULL);
> +		ref_clk = priv->clk;
>  	}

[ ... ]

> @@ -289,9 +410,16 @@ static int unimac_mdio_probe(struct platform_device *pdev)

[ ... ]

>  	bus->parent = &pdev->dev;
>  	bus->read = unimac_mdio_read;
>  	bus->write = unimac_mdio_write;
> +	if (unimac_mdio_init_sts(priv, ref_clk))
> +		bus->write_sts = unimac_mdio_write_sts;

[Severity: Low]
On the GENET compatibles, the mdio node's clocks property now has a new
meaning. The binding in
Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml still only
describes it like this:

  clocks:
    description: A reference to the clock supplying the MDIO bus controller

Should the binding say that the clock's rate must be the MDC reference
rate, that the clock enables timestamped writes, and that the driver does
not enable it on the GENET path?

The current text would also allow a DT to point a GENET mdio node's clocks
at another clock that supplies the controller, such as GENET's main clock.
unimac_mdio_init_sts() accepts any non-zero rate. Would a consumer such as
bcm_phy_write_exp_sts() then get bounds that do not contain the real MDC
edge?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018100257.566267-1-jjc%40jclark.com
