Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A043F0B6;
	Thu, 17 Sep 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633577; cv=none; b=PVT5dNhpdkrqqs/YnG5t+h8BThwF3Qd06ph3psuN/vITOFs9sgqEy8y0jes4OLkn+MuMjZNPl+h/otmxOotv2rMiHzH3ZNPCUC0Yhh+NyIFO5NHfnrOA9yeBs02BdAkGRmNWQGbTImIu96UNZ6Omcr6r3Mirl+gVDasF14+4GKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633577; c=relaxed/simple;
	bh=MVkmT+jinZBaMHn88zFFWa77kELwv/RcQz6CJnll7hY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZD2OUsB+fmnMCOrGBk1u10JUZfNBE+N9M6clJvsZ0rm1rytSXlbl0LCYm6WrD2vx1IyzRVgHZA8Z0dxebCMwtO3xA9fu7zZC9t8WRyNAyj8dEOZoZxIc0Py6+SMWNHgrl0vow9P9JcXTJadxN2Zybv6mBMwiaxhQO7auFM+4nZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdNRKdw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdNRKdw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D30A1F00898;
	Thu, 17 Sep 2026 08:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789633559;
	bh=mQHMw6r6nqwobnl9nv1snvYpl3KQBT9u5YNt9xRmdv4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cdNRKdw15K5pQanHCrNPdxNthlj1Wz1E7eRdhwDsu+dg5M4IqH7Ut6mgSe0GKuW5i
	 YhJJjlq15CyKVda7Vh3xhD8QY/S0oKPif8dn4HSfc1TdH5s235WOGP525F+m8Etvia
	 kQpY17cfhtSebIklwbVJV/t/35NjQuaohRy5fSs12+0xirreM5aORYHWofIDW37S46
	 xEkC8NeDd5JQrBMMpPbMTJ6N0IoXUe++s0kowXwIQdUnxbHwK0zpCm0ko5q5TeDwUw
	 oeq+SB1KjqyZq8enUKaobM1YDqbGmkzGi/aI0djQl1Y4oneNqxopdJYKKrBrDAsUah
	 VOi/JAzMex0TA==
Subject: Re: [PATCH net 2/2] net: dsa: mt7530: unregister the switch before
 freeing its MDIO IRQs
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, chester.a.unal@arinc9.com, daniel@makrotopia.org,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Thu, 17 Sep 2026 08:25:57 +0000
Message-ID: <178963355760.22033.11986863924471016494@kernel.org>
In-Reply-To: <20260914202421.2737079-3-f@lex.la>
References: <20260914202421.2737079-3-f@lex.la>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

- [High] Incomplete fix: mt7530_remove_common()
  (drivers/net/dsa/mt7530.c:3593-3602) still calls…

Pre-existing issues:
- [Medium] Power-sequencing ordering on the MDIO front end:
  mt7530_remove() in drivers/net/dsa/mt7530-mdio.c disables…

--

net: dsa: mt7530: unregister the switch before freeing its MDIO IRQs

This moves dsa_unregister_switch() ahead of the per-PHY interrupt
disposal in mt7530_remove_common(), so that phylib frees the nested PHY
interrupts before their mappings are destroyed. The reported symptom is a
remove_proc_entry() warning from irq_free_descs() followed by a NULL
dereference in handle_nested_irq().

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 3e61eb3c2b1e2..90fd04665ebf1 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -3593,11 +3593,11 @@ EXPORT_SYMBOL_GPL(mt7530_probe_common);
>  void
>  mt7530_remove_common(struct mt7530_priv *priv)
>  {
> +	dsa_unregister_switch(priv->ds);
> +
>  	if (priv->irq_domain)
>  		mt7530_free_mdio_irq(priv);

[Severity: High]
Does this reorder actually close the handle_nested_irq() fault described
in the changelog, or does it only close the phylib half of it?

The parent threaded interrupt is owned by devres.  mt7530_setup_irq()
registers the chip with devm_regmap_add_irq_chip_fwnode() and keeps only
the domain pointer:

drivers/net/dsa/mt7530.c:mt7530_setup_irq() {
	ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
					      priv->regmap, irq,
					      IRQF_ONESHOT,
					      0, chip,
					      &irq_data);
	...
	priv->irq_domain = regmap_irq_get_domain(irq_data);
}

so free_irq() on the parent and irq_domain_remove() happen only from the
devres release, devm_regmap_irq_chip_release() -> regmap_del_irq_chip(),
which runs after mt7530_remove() has returned.  Nothing in
mt7530_remove_common() disables, frees or synchronizes against that
parent IRQ, so the regmap-irq thread is still live while
mt7530_free_mdio_irq() destroys the mappings.

On the thread side there is no zero check on the lookup:

drivers/base/regmap/regmap-irq.c:regmap_irq_thread() {
	...
		data->status_buf[i] &= ~data->mask_buf[i];
	...
			handle_nested_irq(irq_find_mapping(data->domain, i));
}

mask_buf is read there without data->lock, so the thread can carry a
pre-mask snapshot past the filter.  Can the following still happen with
this patch applied, on a part with a PHY_LC bit latched?

  regmap_irq_thread()			mt7530_remove_common()
    read_irq_data(), PHY0_LC set
    passes the mask_buf filter
					dsa_unregister_switch()
					  phy_disconnect()
					    phy_free_interrupt()
					      free_irq(nested virq)
					mt7530_free_mdio_irq()
					  irq_dispose_mapping()
    irq_find_mapping() -> 0
    handle_nested_irq(0)

kernel/irq/chip.c:handle_nested_irq() has no NULL check:

	struct irq_desc *desc = irq_to_desc(irq);
	...
	scoped_guard(raw_spinlock_irq, &desc->lock) {

which is the read at handle_nested_irq+0xac quoted in the changelog.

Is the driver-side disposal loop needed at all?  regmap_del_irq_chip()
already walks the domain and disposes every mapping, and it does so in
the safe order:

drivers/base/regmap/regmap-irq.c:regmap_del_irq_chip() {
	free_irq(irq, d);

	/* Dispose all virtual irq from irq domain before removing it */
	...
}

Would dropping mt7530_free_mdio_irq() from the remove path (leaving the
disposal to regmap_del_irq_chip(), which runs after the parent IRQ is
freed) be a better fix than moving it after dsa_unregister_switch()?

> -	dsa_unregister_switch(priv->ds);
> -
>  	mutex_destroy(&priv->reg_mutex);
>  }
>  EXPORT_SYMBOL_GPL(mt7530_remove_common);

[Severity: Medium]
This is a pre-existing ordering problem and not something this patch
introduces, but it interacts with the new placement of
dsa_unregister_switch(), so it may be worth mentioning.

On the MDIO front end the supplies are dropped before any of this runs:

drivers/net/dsa/mt7530-mdio.c:mt7530_remove() {
	if (priv->id == ID_MT7530) {
		ret = regulator_disable(priv->core_pwr);
		...
		ret = regulator_disable(priv->io_pwr);
		...
	}

	mt7530_remove_common(priv);
}

After this patch the whole register-level teardown reached from
dsa_unregister_switch() - internal PHY power-down, port disable writes,
and the regmap-irq mask sync that clears the PHY_LC bits through
mt7530_irq_mask_sync() - is the first thing mt7530_remove_common() does,
i.e. entirely after core_pwr and io_pwr were released on ID_MT7530.

Can those writes still reach the chip?  MDIO writes are unacknowledged,
and regmap-irq updates its mask_buf shadow regardless of what
handle_mask_sync() returns:

drivers/net/dsa/mt7530.c:mt7530_irq_mask_sync() {
	ret = regmap_update_bits(priv->regmap, MT7530_SYS_INT_EN,
				 mask_buf_def, ~mask_buf);
	...
}

so MT7530_SYS_INT_EN can be left armed and MT7530_SYS_INT_STS latched
while software believes they are masked.  MT7530_TOP_SIG_CTRL's
TOP_SIG_CTRL_NORMAL bit, set in mt7530_setup_irq(), likewise has no
teardown counterpart.  Should the regulator_disable() calls move after
mt7530_remove_common() instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914202421.2737079-1-f%40lex.la
