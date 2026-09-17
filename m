Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9443746C;
	Thu, 17 Sep 2026 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678203; cv=none; b=XR46o/FyZ3fvRfz4Jp1lJQA5rq6QSeQ1jgHBS9HUJ9lnvHkh39A/q9Tix5W1l+VvjR1Fqiz415HOAXvgUCcm0bSbxkXQmNsWUbq6dFkRBNPpZ5JcDSvyrrOXgNuG3U9hFkkO6TwYEHZyqLppsV7PtqznCAXaYrwehwdRPVZK6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678203; c=relaxed/simple;
	bh=fuQco83bl15CfDy1wpQJvOT5+FtZheSGX0bXdxOD9U0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=seVxKAp5cu65oR8OoQvbItm/rnM/d4LH0Esirr5aJv1IsBgua0e8GrOuGJBOAfaa4eQeIm7F3aCTgf9Qw04WenywHjAmc0A28AHnW9n0B32XU9ls8XBvdgwrrJKs1xfMp/UcbnorbFd+qnjhnh/WmDd6jv7OhCwMdIIUdmxVFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixvWSlaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixvWSlaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A071F00893;
	Thu, 17 Sep 2026 20:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678200;
	bh=iuoGPrrZdOKTVtHeSmHr2Z1LALwPrg6c5CLObaN4P0g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ixvWSlaMzecyaxyEAHkILlW8Xdtai6VLclFxY0CbrlWMfFGLFHlz1upcytsMAwEDF
	 1kFwiIWZ/NgxnbZt1L75ByYl9KkifTUr+PnbMGXJLlEQEgzPgciQhqreqMsb8hBpIN
	 M2J7AVRV0GHXrizzObt2BBH6yYwUXU9PrJMLfy34G/B+dxqCq6OFlvhSInUpSHGCfK
	 0/5Gh472d18pKwPSf19lWQLKcDv/EenXnEwrx3CNc6f2jrvOEcYcJk9w+AL7i0dLOz
	 cAski/L4f+2WEPs7uBlpdR7aSu+GkA3GDt5V4raytFMQWgNbulTqbFhxC5eDb6V88y
	 q5fZYRdR2RNog==
Subject: Re: [PATCH v2 net-next 5/7] net: dsa: mediatek: support MDIO switch
 downstream of MMIO switch
From: netdev-bot+sashiko@kernel.org
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, linux@armlinux.org.uk,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, naseefkm@gmail.com, b.larsson@gmx.com
Date: Thu, 17 Sep 2026 20:49:58 +0000
Message-ID: <178967819865.22033.9450437798313929397@kernel.org>
In-Reply-To: <20260915174643.253660-6-cjd@cjdns.fr>
References: <20260915174643.253660-6-cjd@cjdns.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 3 · Medium: 3 · Low: 1

- [High] Moving mt7530_setup_mdio_irq() from mt7530_setup_mdio() (where
  it ran *before* devm_of_mdiobus_register()) to mt753x_setup()…
- [High] mt7988_probe() (drivers/net/dsa/mt7530-mmio.c:69-71) calls
  mt7530_setup_mdio(priv) and discards its int return value, then…
- [High] The early MDIO enumeration added to mt7988_probe() still cannot
  reach a downstream switch when any preceding PHY child of the switch's…
- [Medium] mt7530_setup_mdio() is now invoked from mt7988_probe() right
  after dsa_register_switch().
- [Medium] mt7530_setup_mdio() is now reachable from mt7988_probe() with
  no lock held, whereas every previous invocation ran from…
- [Medium] mt7988_probe() now registers the switch's MDIO bus - and
  therefore probes the PHYs/devices on it - before mt753x_setup() ->…
- [Low] The submission has no Fixes: tag although it removes a user-
  visible limitation of the MMIO switch driver introduced by commit…

--

net: dsa: mediatek: support MDIO switch downstream of MMIO switch

This makes mt7530_setup_mdio() idempotent, exports it, and calls it from
mt7988_probe() right after dsa_register_switch() so that a switch sitting
on the MMIO switch's own MDIO bus can register and complete the DSA tree.
The PHY interrupt setup previously done inside mt7530_setup_mdio() is moved
to mt753x_setup().

No Link: tags in the commit header.

[Severity: Low]
This isn't a bug, but there is no Fixes: tag on the submission even though
it lifts a user-visible limitation of the MMIO path added by commit
110c18bfed41 ("net: dsa: mt7530: introduce driver for MT7988 built-in
switch").  Is a Fixes: tag intended here, or is this considered new
functionality rather than a fix (the MMIO driver never claimed to support a
switch behind the switch's own MDIO bus)?

> diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
> index cf3bdb23a2d54..f387190a95391 100644
> --- a/drivers/net/dsa/mt7530-mmio.c
> +++ b/drivers/net/dsa/mt7530-mmio.c
> @@ -61,7 +61,14 @@ mt7988_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  
> -	return dsa_register_switch(priv->ds);
> +	ret = dsa_register_switch(priv->ds);
> +
> +	if (ret)
> +		return ret;
> +
> +	mt7530_setup_mdio(priv);
> +
> +	return 0;
>  }

[Severity: High]
Should the return value of mt7530_setup_mdio() be checked here?

mt7530_setup_mdio() returns -ENOMEM from devm_mdiobus_alloc() and
propagates devm_of_mdiobus_register() failures, including -EPROBE_DEFER,
after clearing priv->child_bus:

drivers/net/dsa/mt7530.c:mt7530_setup_mdio() {
	ret = devm_of_mdiobus_register(dev, bus, mnp);
	if (ret) {
		priv->child_bus = NULL;
		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
		...
	}
}

The other caller, mt753x_setup(), propagates that value:

	ret = mt7530_setup_mdio(priv);
	if (ret)
		return ret;

With the error dropped, mt7988_probe() returns 0 while no child MDIO bus
exists.  Since the DSA tree can only be completed once that bus registers
the downstream switch, mt753x_setup() never runs and nothing retries the
bus, so the board stays without networking.  Note also that the failure
path clears priv->child_bus but leaves ds->user_mii_bus pointing at the
never-registered devm bus, so a later mt753x_setup() would allocate a
second mii_bus.

[Severity: High]
Can this call actually reach the downstream switch node on a DT shaped like
arch/arm64/boot/dts/mediatek/mt7988a.dtsi, where the PHY children of the
switch's mdio node use the switch itself as their interrupt provider?

	switch@15020000 {
		interrupt-controller;
		#interrupt-cells = <1>;
		mdio {
			gsw_phy0: ethernet-phy@0 {
				reg = <0>;
				interrupts = <0>;

At probe time priv->irq_domain does not exist yet, because
mt7530_setup_irq() only runs from mt753x_setup():

mt753x_setup()
    mt7530_setup_irq()		<- creates priv->irq_domain
    mt7530_setup_mdio()

so of_irq_get() on gsw_phy0 finds no host for the switch node and returns
-EPROBE_DEFER, which is forwarded during boot:

drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_phy_device_register() {
	rc = fwnode_irq_get(child, 0);
	if (rc == -EPROBE_DEFER)
		rc = driver_deferred_probe_check_state(&phy->mdio.dev);
	if (rc == -EPROBE_DEFER)
		return rc;
}

and __of_mdiobus_parse_phys() then aborts child enumeration on that error,
after which __of_mdiobus_register() unregisters the bus.  Wouldn't that
mean the downstream switch node is never registered, the tree never
completes, and the IRQ domain that the PHY children need is never created,
i.e. the prerequisite loop the patch aims to break is still there?

[Severity: Medium]
Is it safe to probe the MDIO bus here, before the switch bring-up in
mt7988_setup() has run?

In the incomplete-tree case this patch targets, dsa_register_switch()
returns without invoking ds->ops->setup, so the reset and PHY power-up
sequence has not executed when devm_of_mdiobus_register() synchronously
probes the MDIO children:

drivers/net/dsa/mt7530.c:mt7988_setup() {
	/* Reset the switch */
	reset_control_assert(priv->rstc);
	usleep_range(20, 50);
	reset_control_deassert(priv->rstc);
	usleep_range(20, 50);
	...
	/* Reset the switch PHYs */
	regmap_write(priv->regmap, MT7530_SYS_CTRL, SYS_CTRL_PHY_RST);
}

Can the PHY ID reads issued from probe through mt7531_ind_c22_phy_read()
return 0xffff or time out in the MT7531_PHY_IAC poll loop on an un-reset
and (on AN7583, before the AN7583_CSR_PHY_CORE_REG_CLK_SEL /
AN7583_CSR_ETHER_AFE_PWD handling) unclocked block?  And when the reads do
succeed, does the later reset_control_assert()/deassert() plus
SYS_CTRL_PHY_RST reset the MDIO master and integrated PHYs underneath the
mdio/phy devices that were already bound during probe, including any
transaction in flight from the freshly probed downstream switch?

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b152b73315d50..fe93be1ece7d7 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c

[ ... ]

> @@ -2414,6 +2414,10 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	static int idx;
>  	int ret = 0;
>  
> +	/* Already done */
> +	if (priv->child_bus)
> +		return 0;
> +
>  	mnp = of_get_child_by_name(np, "mdio");

[Severity: Medium]
What serializes this check now that mt7530_setup_mdio() is also reachable
from mt7988_probe()?

Every previous invocation came from mt753x_setup() under dsa2_mutex, but
the new call runs after the lock has been dropped:

net/dsa/dsa.c:dsa_register_switch() {
	mutex_lock(&dsa2_mutex);
	err = dsa_switch_probe(ds);
	dsa_tree_put(ds->dst);
	mutex_unlock(&dsa2_mutex);
}

So the probe thread can run mt7530_setup_mdio(priv) unlocked while another
switch of the same tree drives, under dsa2_mutex:

dsa_register_switch()
    dsa_tree_setup()
        dsa_tree_setup_switches()
            dsa_switch_setup(this ds)
                mt753x_setup()
                    mt7530_setup_mdio(same priv)

Can both observe priv->child_bus == NULL and both allocate and register an
mii_bus for the same switch?  priv->child_bus is only published just before
devm_of_mdiobus_register() and unconditionally cleared on failure, so a
losing racer can clear a pointer that mt753x_phy_read_c22() and
mt753x_phy_write_c22() dereference.  The non-atomic "static int idx"
increment used for bus->id is also no longer under any lock, so can two
buses end up with the same KBUILD_MODNAME-%d id?

Related, in the single-threaded case: the downstream switch probed from
inside devm_of_mdiobus_register() completes the tree and re-enters
mt753x_setup() for this same priv, where this guard returns 0 while the
outer registration is still in flight further down the stack.  Is that
intended?

> @@ -2438,9 +2442,6 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	bus->parent = dev;
>  	bus->phy_mask = ~ds->phys_mii_mask;
        ^^^^^^^^^^^^^^

[Severity: Medium]
When called from mt7988_probe(), is ds->phys_mii_mask initialized yet?

The mask is set by the DSA core, and it is skipped entirely for an
incomplete tree:

net/dsa/dsa.c:dsa_tree_setup() {
	complete = dsa_tree_setup_routing_table(dst);
	if (!complete)
		return 0;
	...
}

net/dsa/dsa.c:dsa_switch_setup() {
	/* Initialize ds->phys_mii_mask before registering the user MDIO bus
	 * driver and before ops->setup() has run, ...
	 */
	ds->phys_mii_mask |= dsa_user_ports(ds);
}

With phys_mii_mask still 0, bus->phy_mask becomes ~0.  If the switch node
has no "mdio" child, devm_of_mdiobus_register() does not override the mask:

drivers/net/mdio/of_mdio.c:__of_mdiobus_register() {
	if (!np)
		return __mdiobus_register(mdio, owner);
	...
}

so does __mdiobus_register() end up skipping every address, leaving
ds->user_mii_bus pointing at a bus with no PHYs?  The new
"if (priv->child_bus) return 0;" guard then makes the later call from
mt753x_setup(), where phys_mii_mask is correct, a no-op, so the ~0 mask
looks permanent, and dsa_switch_setup() will not build its own user mii bus
either because ds->user_mii_bus is already set.

> -	if (priv->irq_domain && !mnp)
> -		mt7530_setup_mdio_irq(priv);
> -
>  	priv->child_bus = bus;
>  
>  	ret = devm_of_mdiobus_register(dev, bus, mnp);

[Severity: High]
Does moving this to mt753x_setup() make the per-PHY IRQ assignment take
effect too late?

Before the change the order was:

mt7530_setup_mdio()
    mt7530_setup_mdio_irq()		<- fills ds->user_mii_bus->irq[p]
    devm_of_mdiobus_register()
        __mdiobus_register()
            phy_device_create()
                dev->irq = bus->irq[addr];

After the change, mt753x_setup() calls mt7530_setup_mdio() first and only
then mt7530_setup_mdio_irq(), so the writes in

	irq = irq_create_mapping(priv->irq_domain, p);
	ds->user_mii_bus->irq[p] = irq;

happen after phy_device_create() has already latched phydev->irq from
bus->irq[addr], which mdiobus_alloc_size() initialized to PHY_POLL.
Nothing re-reads bus->irq[] afterwards, so do the internal PHYs silently
fall back to polling while the virqs from irq_create_mapping() end up
referenced by nothing?

This is the case the old "priv->irq_domain && !mnp" condition selected, and
it matches in-tree DTs that have "interrupt-controller" on the switch node
and no "mdio" child, for example switch@1f in
arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts and switch@31 in
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts.  The commit
message does not mention this behaviour change; is it intended?

> @@ -3285,6 +3287,9 @@ mt753x_setup(struct dsa_switch *ds)
>  	if (ret)
>  		return ret;
>  
> +	if (priv->irq_domain && ds->user_mii_bus)
> +		mt7530_setup_mdio_irq(priv);
> +
>  	/* Initialise the PCS devices */
>  	for (i = 0; i < priv->ds->num_ports; i++) {
>  		priv->pcs[i].pcs.ops = priv->info->pcs_ops;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915174643.253660-1-cjd%40cjdns.fr
