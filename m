Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEB38C40E;
	Tue, 22 Sep 2026 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043356; cv=none; b=FoFaLMRKxV0hbLaZlhNgyEtGyuGKuR3InHCCQgJCvLUjqRtTs9hMbEUNg6ZNj8ee0CmmffBV3ODUB8SCTfUYCXhJt4k7OM2TOyQQYDBmDRc8IIjy3lfGTkmiKH+zZw7ShLRou8yxsQDNcvQwi1aDS0TQz0KtMRECjhi1T9jDkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043356; c=relaxed/simple;
	bh=v2tYyLwKPZEXHdgRYLKuFwtXABUV6GEJawzCA5QvXSk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtLhjltusVbllqmGPZYIPs2z0NpPdg0UmtF19vPDXgBke91RBxZlcoKacxcvBRnd+NbYBKiP9u/6hbmKS6vOl8kXdoAj2cWE7WdDJgGZF5z3pQ6Yldo7H22TQxhmBE39+E2fTtIREP1thaIL8WJK86WRIWhmevT0Q57cnZ4uRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfUGiGY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfUGiGY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E991F000FF;
	Tue, 22 Sep 2026 02:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790043354;
	bh=0ASA5JW6b5bnDhsby8kSTB9776aPdBxV6ZarEwfGUYA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PfUGiGY6exW5Q7gji0YFSkvi13LVMyGzTvOjVsTxfVtzbGXGK+rRzSL28X9Wndv0i
	 C6adaZKgC6jHsvjI1OxafymgqF42Ap5wxVQDJaBqU+oN5IMp0ue/GgFgnva8ya721p
	 GzmG6hOSdv2AIRKesaUdDG1Abw53zGJeYPNeOgrbWD1GgVSU8OmrmPo2Vh49GdcTJx
	 fJo1HQ5B60ixEAJihe6wqxxhR6UjIGAVumnoL6IugL5u3vZ/8R2orpkU7C/xvvzP5g
	 VleMGt9tx2VOUfCdaZqfFbfZbxdWp3i5jwSveShtQpQ9EGMBUFIlzoW9f/SkaaJNJx
	 ixp+W8dl01Q7g==
Subject: Re: [PATCH net v2 1/2] net: dsa: mt7530: fix NULL dereference on
 unbind of MT7531 and MT7621
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, chester.a.unal@arinc9.com, daniel@makrotopia.org,
 andrew@lunn.ch, olteanv@gmail.com, gerg@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Tue, 22 Sep 2026 02:15:52 +0000
Message-ID: <179004335292.2160803.1657607362233554719@kernel.org>
In-Reply-To: <20260918015020.2518315-2-f@lex.la>
References: <20260918015020.2518315-2-f@lex.la>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The regulator enable reference is taken in the DSA `.setup`
  callback (mt7530_setup(), drivers/net/dsa/mt7530.c:2493-2509) but…

Pre-existing issues:
- [Medium] On the ID_MT7530 path the patch keeps
  regulator_disable(core_pwr)/regulator_disable(io_pwr) ahead of…
- [Medium] In mt7530_setup() (drivers/net/dsa/mt7530.c:2494 and :2502)
  the return values of `regulator_set_voltage(priv->core_pwr, 1000000,…
- [Low] Binding/driver disagreement about which compatibles the `core-
  supply`/`io-supply` properties apply to.

--

net: dsa: mt7530: fix NULL dereference on unbind of MT7531 and MT7621

The core and io supplies are only requested for ID_MT7530, but
mt7530_remove() disabled them unconditionally, so unbinding an MT7531 or
MT7621 called regulator_disable() on a NULL pointer.  The patch gates the
two regulator_disable() calls on priv->id == ID_MT7530.

> diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
> index 784dd58a71589..de42f70afcfa1 100644
> --- a/drivers/net/dsa/mt7530-mdio.c
> +++ b/drivers/net/dsa/mt7530-mdio.c
> @@ -227,15 +227,17 @@ mt7530_remove(struct mdio_device *mdiodev)
>  	if (!priv)
>  		return;
>  
> -	ret = regulator_disable(priv->core_pwr);
> -	if (ret < 0)
> -		dev_err(priv->dev,
> -			"Failed to disable core power: %d\n", ret);
> -
> -	ret = regulator_disable(priv->io_pwr);
> -	if (ret < 0)
> -		dev_err(priv->dev, "Failed to disable io pwr: %d\n",
> -			ret);
> +	if (priv->id == ID_MT7530) {

[Severity: Low]
This isn't a bug introduced by this patch, but the id test here is now the
third place that encodes "these supplies belong to ID_MT7530", while the
binding does not say that.

In Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml both
core-supply and io-supply are defined as generic top-level properties and
are only listed under required: for the mediatek,mt7530 branch.  The
mediatek,mt7531 branch disallows other properties explicitly:

      properties:
        gpio-controller: false
        mediatek,mcm: false

but leaves the two supplies permitted, and the mediatek,mt7621 branch only
adds mediatek,mcm to required:.

So a schema-valid DT with core-supply on compatible = "mediatek,mt7531" has
that phandle silently ignored, since mt7530_probe() never calls
devm_regulator_get() for any other id:

	if (priv->id == ID_MT7530) {
		priv->core_pwr = devm_regulator_get(&mdiodev->dev, "core");
		...
	}

Should the binding set core-supply: false / io-supply: false on the
mt7531 and mt7621 branches so the two sides agree?

> +		ret = regulator_disable(priv->core_pwr);
> +		if (ret < 0)
> +			dev_err(priv->dev,
> +				"Failed to disable core power: %d\n", ret);
> +
> +		ret = regulator_disable(priv->io_pwr);
> +		if (ret < 0)
> +			dev_err(priv->dev, "Failed to disable io pwr: %d\n",
> +				ret);
> +	}

[Severity: Medium]
Is priv->id the right condition for the disable side?  It records that the
supplies were requested in mt7530_probe(), not that they were ever enabled.
The enable happens in a different callback, mt7530_setup() in mt7530.c,
reached through ds->ops->setup.

Can this produce an unbalanced disable on an ID_MT7530 board?
mt7530_probe() -> dsa_register_switch() -> dsa_tree_setup() can return
success without ever running ds->ops->setup:

net/dsa/dsa.c:dsa_tree_setup() {
	...
	complete = dsa_tree_setup_routing_table(dst);
	if (!complete)
		return 0;
	...
}

A later unbind then takes this new ID_MT7530 branch with
regulator->enable_count still zero:

drivers/regulator/core.c:_regulator_disable() {
	if (WARN(regulator->enable_count == 0,
		 "unbalanced disables for %s\n", rdev_get_name(rdev)))
		return -EIO;
	...
}

which also means the dev_err() above prints -EIO.  A tree teardown and
re-setup cycle, e.g. a peer switch in the same tree unbinding and binding
again, runs mt7530_setup() and therefore regulator_enable() more than once
against this single disable.

Does the opposite direction leak the enable reference?  Every error return
in mt7530_setup() after the core rail is up:

	if (priv->id == ID_MT7530) {
		regulator_set_voltage(priv->core_pwr, 1000000, 1000000);
		ret = regulator_enable(priv->core_pwr);
		...
		regulator_set_voltage(priv->io_pwr, 3300000, 3300000);
		ret = regulator_enable(priv->io_pwr);
		if (ret < 0) {
			dev_err(priv->dev, "Failed to enable io pwr: %d\n",
				ret);
			return ret;
		}
	}

	/* Waiting for MT7530 got to stable */
	INIT_MT7530_DUMMY_POLL(&p, priv, MT753X_TRAP);
	ret = readx_poll_timeout(_mt7530_read, &p, val, val != 0,
				 20, 1000000);
	if (ret < 0) {
		dev_err(priv->dev, "reset timeout\n");
		return ret;

propagates out through mt753x_setup() and dsa_register_switch() to
mt7530_probe(), so .remove is never called.  The devm release path only
puts the regulator:

drivers/regulator/core.c:_regulator_put() {
	...
	/* Docs say you must disable before calling regulator_put() */
	WARN_ON(regulator->enable_count);
	...
}

so the 1.0 V core and 3.3 V I/O rails stay enabled for the lifetime of the
system, with a WARN.  The MT7530_CREV id mismatch and the 20 MHz XTAL
rejection reach the same point.

Would pairing the enable with the existing symmetric hook,
mt753x_teardown() in mt7530.c, or tracking an explicit "enabled" flag and
unwinding the mt7530_setup() error paths, cover the NULL case this patch
targets as well as these two?

>  
>  	mt7530_remove_common(priv);
>  

[Severity: Medium]
This is a pre-existing ordering issue rather than something this patch
introduces, and the cover text says as much, but it may be worth recording
here since the ID_MT7530 path keeps it.

Everything mt7530_remove_common() still does runs against a die whose rails
have just been switched off:

drivers/net/dsa/mt7530.c:mt7530_remove_common() {
	dsa_unregister_switch(priv->ds);

	mutex_destroy(&priv->reg_mutex);
}

dsa_unregister_switch() reaches mt753x_teardown(), the per-port
mt7530_port_disable() PCR read-modify-writes such as

	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK, PCR_MATRIX_CLR);

the mac_link_down() PMCR writes and the internal-PHY suspend writes that go
through the switch's own MDIO bus.  Are those writes simply lost at that
point, leaving the driver's bookkeeping describing a state the hardware
never reached?

Can the MIB poller also read an unpowered die?  mt753x_teardown() is the
only place the self-rearming stats work is cancelled:

drivers/net/dsa/mt7530.c:mt753x_teardown() {
	struct mt7530_priv *priv = ds->priv;

	if (priv->bus)
		cancel_delayed_work_sync(&priv->stats_work);
}

and it runs from inside dsa_unregister_switch(), i.e. after the disables
above.  mt7530_stats_poll() re-arms itself unconditionally:

		mt7530_stats_refresh(priv);
		schedule_delayed_work(&priv->stats_work,
				      MT7530_STATS_POLL_INTERVAL);

so it can be doing MDIO reads while mt7530_remove() drops the rails,
folding all-ones reads into the cached per-port counters.

[Severity: Medium]
This is also pre-existing and untouched by the patch, but while in this
area: mt7530_setup() in drivers/net/dsa/mt7530.c discards the return value
of both regulator_set_voltage() calls:

	if (priv->id == ID_MT7530) {
		regulator_set_voltage(priv->core_pwr, 1000000, 1000000);
		ret = regulator_enable(priv->core_pwr);
		...
		regulator_set_voltage(priv->io_pwr, 3300000, 3300000);
		ret = regulator_enable(priv->io_pwr);

If machine constraints do not permit the requested range, or
REGULATOR_CHANGE_VOLTAGE is not allowed, or a second consumer holds a
shared rail at another voltage, the rail is still enabled and the driver
goes on to reset the die, poll MT753X_TRAP and read MT7530_CREV as if the
1.0 V core / 3.3 V I/O operating points had been applied.  Should these two
calls be checked so the failure surfaces as an error instead of as
intermittent register access failures?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918015020.2518315-1-f%40lex.la
