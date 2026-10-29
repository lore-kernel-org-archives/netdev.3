Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239366;
	b=y9bO1pWSExfG/n0gQ7gH0ZoybWFn6jX5dY/tZqJ9EtYeWNNmDazEprKyavGvcYQ9sbjR
	 wbBzXJe+k2fwqwm0THzNXBfdqret3hUvoC44gEU5gFJD3oIUKVDSD13Qu7SqU61OZltR9
	 IJwMWt8u+Utatg6bF40AxXj0XysPvIUMV+GbKNCTaxy/CxN3Z2WN7mrnrqC4mG2TbcnGF
	 XWwiGgx0rsQKKeLQflLM9QnMyaXkqFPitx+9Tewu3lgdVYzheQmul1pGtEOxdRixaT1Pu
	 d+QkRkCfNlYmFGar54orZMsfUufG/BgPUvNW9cRqAF3kouVNEW64b4LopcmL/d0hBvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239366;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jvFw5HrlIv7l7uFCZb/W0oMDQkrDlvWg/SYM7bb8XNw=;
	b=p7kjbtCeYz7/l6xHLDbnmWw3JGIbThseyMM68/IvcqCAhPix5MvC2lolvNenFkKIRZYj
	 gshZD+L9CZzGNGzrLcIy+TrHguD7kUsh9OizB6tXgh/KFARAQpc2bymxi06JqH/4YrtHz
	 iYMPWa4OaHhW+dd4HtEwqqB04tWTaljrL+Ggu5ELnLREklM5Fhg2BI2spWCAvg/0p/vjA
	 EkfmDOkspKjEu/GMEQBIs2skxE8vtRViNi+IhPJSeuUSmqBVYVzB3vRJLRQPGXe2kQOB3
	 8ZDENRkcPo5yUFvBvRtObDANN4gNCXWsizw9h7M21TCzs2havoKGET46bIXj3i/gXsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTijfR6j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67C606A33E;
	Thu, 29 Oct 2026 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTijfR6j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ECF1F01828;
	Thu, 29 Oct 2026 02:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793239365;
	bh=jvFw5HrlIv7l7uFCZb/W0oMDQkrDlvWg/SYM7bb8XNw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LTijfR6jX1dhi7wlarDD++v1qx7NQeobuzAJQLQVBzC9tYBzyMTeqhJKPSSbwGdv2
	 1dDCxDw9nowWrhiuoZ/RhPDIMpvPiXejmM8oK9fhZuESdYcikPuoj/8BQ/qDX6dNJW
	 TgKnypjWW1kf2GtTRQbvfLDAar2o29iKH5JfFWN/iJWzqoRCPXACduaFvqnf32Fln7
	 NRQVsvUuWQW8X53TUbm4YYmYjaD5+gbo7JRlFdRPyWrwBtTeOG1wxpZN1eebgAOlNj
	 1tAtKYqeNk+aMC1DeGgWYwOIheIFGwYsnPVS46ZSp7ZqYCBL8KuH2TOgt91Qw4U3KL
	 OVmsT0ySqplvg==
Subject: Re: [PATCH v3 5/7] net: dsa: mediatek: support MDIO switch downstream
 of MMIO switch
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
Date: Thu, 29 Oct 2026 02:02:43 +0000
Message-ID: <179323936361.3134.12891112792195028104@kernel.org>
In-Reply-To: <20261028011317.1557238-6-cjd@cjdns.fr>
References: <20261028011317.1557238-6-cjd@cjdns.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 7 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: dsa: mt7530: recursive reg_mutex lockdep class on
  downstream switch
- [Medium] The patch moves mt7530_setup_mdio_irq() out of
  mt7530_setup_mdio(), where it ran just before…
- [Medium] In exactly the case the patch targets (the DSA tree is
  incomplete when dsa_register_switch() returns), mt7988_probe() calls…
- [Medium] mt7988_probe() ignores the return value of the newly exported
  mt7530_setup_mdio() and always returns 0.
- [Medium] mt7530_setup_mdio() can now run from mt7988_probe() before DSA
  has set the switch up.
- [Medium] The early MDIO registration cannot complete when the upstream
  switch's 'mdio' node has PHY children whose interrupts come from the…
- [Medium] The new 'Already done' check (if (priv->child_bus) return 0;)
  in mt7530_setup_mdio() is an unlocked flag used as an initialisation…
- [Medium] Because the MDIO bus is now registered in probe, before the
  tree is set up, the later mt7988_setup() (run from mt753x_setup()…
- [Low] The commit message says "In MMIO mode the switch provides its own
  MDIO bus which connects to its integrated PHYs".

--

net: dsa: mediatek: support MDIO switch downstream of MMIO switch

This patch lets an MDIO-attached switch sit on the child MDIO bus of an
MMIO MT753x switch. mt7530_setup_mdio() is made safe to call more than
once, it is exported, and mt7988_probe() now calls it right after
dsa_register_switch(). The mt7530_setup_mdio_irq() call also moves out of
mt7530_setup_mdio() and into mt753x_setup().

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

[Severity: High]
Will the cascade this enables trip lockdep on the shared reg_mutex
class?

Both switches initialize priv->reg_mutex at the same mutex_init() call
site in mt7530_probe_common(), so the upstream MMIO switch and the
downstream MDIO switch share one lockdep class.

Once an MDIO-attached MT7530/MT7531 sits on the upstream switch's
child_bus, every regmap access on the downstream switch first goes
through mt7530_mdio_regmap_lock(). That takes
up->child_bus->mdio_lock with MDIO_MUTEX_NESTED. It then calls the
upstream bus callbacks, which take the upstream priv->reg_mutex at
subclass 0.

The downstream driver also holds its own reg_mutex across regmap
accesses. The first such access during setup is mt7530_port_disable():

mt7530_port_disable()               down->reg_mutex (0)
  regmap_update_bits(priv->regmap, MT7530_PCR_P(port), ...)
    mt7530_mdio_regmap_lock()       up->child_bus->mdio_lock (1)
    bus->write()
      mt753x_phy_write_c22()
        mt7531_ind_c22_phy_write()  up->reg_mutex (0)

The unguarded regmap accesses earlier in mt7530_setup() and
mt7531_setup() already record mdio_lock:1 -> reg_mutex:0. Taking the
upstream reg_mutex while the downstream one is held then looks to
lockdep like recursive locking of a single class.

The instances are different, and the order is always downstream
before upstream, so this is probably not a real deadlock. Under
CONFIG_PROVE_LOCKING, though, the splat would fire deterministically
during setup. Lockdep would then be disabled for everything else on
the system. The same pattern repeats on the port, VLAN and FDB paths
that hold reg_mutex around regmap calls.

Before this patch the tree never completed in this topology, so this
pairing was never reachable.

How would you like to annotate this? One option is a per-instance
lock class key for reg_mutex, using lockdep_register_key() with
__mutex_init(). Another is mutex_lock_nested() on the upstream
indirect PHY access path. Or is there a different approach you would
prefer?

[Severity: Medium]
Should the return value of mt7530_setup_mdio() be passed back here?

mt7530_setup_mdio() can fail with -ENOMEM from devm_mdiobus_alloc(). It
can also return any error from devm_of_mdiobus_register(). That includes
-EPROBE_DEFER, which fwnode_mdiobus_phy_device_register() passes up when a
PHY's interrupt provider is not ready yet.

On failure priv->child_bus goes back to NULL, but probe still returns 0,
so the driver core never re-probes this device. In the cascade topology
the only other caller is mt753x_setup(). That runs only once the tree is
complete, and completing the tree needs the downstream switch on this
same bus.

Wouldn't the tree then never complete, with nothing logged except the
dev_err()?

In the !mnp case, ds->user_mii_bus is also left pointing at a bus that
was allocated but never registered.

[Severity: Medium]
Is there a dependency cycle when the PHYs under the "mdio" node get their
interrupts from this switch?

arch/arm64/boot/dts/mediatek/mt7988a.dtsi uses that layout. The switch
node is the interrupt-controller, and the PHYs use "interrupts = <N>"
with the switch as their interrupt parent.

mt7530_setup_irq() is still only called from mt753x_setup(), so
priv->irq_domain does not exist yet at this point. The registration path
would be:

mt7988_probe()
  mt7530_setup_mdio()
    devm_of_mdiobus_register()
      __of_mdiobus_parse_phys()
        fwnode_mdiobus_phy_device_register()
          fwnode_irq_get() -> -EPROBE_DEFER

drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_phy_device_register() {
    ...
	if (rc == -EPROBE_DEFER)
		return rc;
    ...
}

__of_mdiobus_parse_phys() aborts on that error. __of_mdiobus_register()
then unregisters the whole bus, including the downstream switch device.

The IRQ domain cannot exist until the tree completes, and the tree cannot
complete until this bus registers. Propagating the error would not break
that cycle by itself. Does the IRQ domain need to be created before this
early registration?

[Severity: Medium]
Does this probe the PHYs before the switch has been reset and set up?

This patch targets the case where the tree is still incomplete after
dsa_register_switch(). There, the "mdio" bus is registered and every PHY
child is probed before mt753x_setup() and its sw_setup callback,
mt7988_setup(), have run. When the downstream switch completes the tree,
mt7988_setup() does this:

drivers/net/dsa/mt7530.c:mt7988_setup() {
	/* Reset the switch */
	reset_control_assert(priv->rstc);
	usleep_range(20, 50);
	reset_control_deassert(priv->rstc);
	usleep_range(20, 50);
    ...
	/* Reset the switch PHYs */
	regmap_write(priv->regmap, MT7530_SYS_CTRL, SYS_CTRL_PHY_RST);
    ...
}

For the MT7988/EN7581 class GEPHYs, mt7988_phy_probe() in
drivers/net/phy/mediatek/mtk-ge-soc.c applies three things only at probe
time: the LED polarity fixups, the MTK_PHY_RXADC_CTRL_RG7 TX power-saving
disable, and mt798x_phy_calibration().

If SYS_CTRL_PHY_RST clears those registers, does anything apply them
again?

On AN7583, the early PHY ID reads and the probe also run before
mt7988_setup() programs AN7583_GEPHY_CONN_CFG (PHY core register clock
select and the ETHER_AFE power-down clear).

All the MMIO variants use mt7988_setup. That includes EN751221, which the
later patch "net: dsa: mediatek: support EN751221 switch" adds, and that
patch does not change this ordering.

[Severity: Medium]
Related to the above, what keeps the reset in mt7988_setup() from
overlapping with MDIO users of child_bus?

The bus is now registered at probe time. mt7988_setup() runs later, from
mt753x_setup() during tree setup on the downstream switch's probe thread.
By then child_bus and its PHY and downstream devices are already
registered.

mt7988_setup() does not take child_bus->mdio_lock. For MMIO,
mt7530_mutex_lock() takes no lock either, because priv->bus is NULL:

	if (priv->bus)
		mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);

Two MDIO users could be active at that moment: a PHY driver probing
asynchronously after module autoload, or userspace touching the PHY LED
class devices. Could reset_control_assert() or SYS_CTRL_PHY_RST cut
their transactions short?

Before this patch the reset always ran before the bus existed.

> +
> +	return 0;
>  }

[ ... ]

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index d09ff207e2dfc..dbe3887097dbc 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c

[ ... ]

> @@ -2457,6 +2457,10 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	static int idx;
>  	int ret = 0;
>  
> +	/* Already done */
> +	if (priv->child_bus)
> +		return 0;
> +

[Severity: Medium]
Is this unlocked check enough to make mt7530_setup_mdio() safe to call
from two places?

The new caller in mt7988_probe() runs after dsa_register_switch() has
dropped dsa2_mutex. The other caller, mt753x_setup(), runs from
dsa_tree_setup() with dsa2_mutex held, triggered by whichever tree member
completes the tree.

If that member is not on this switch's own MDIO bus, it can probe at the
same time on another thread, such as the deferred-probe worker or a
module load:

CPU1 (mt7988_probe)           CPU2 (dsa_tree_setup->mt753x_setup)
mt7530_setup_mdio()           mt7530_setup_mdio()
  priv->child_bus == NULL       priv->child_bus == NULL
  devm_mdiobus_alloc()          devm_mdiobus_alloc()
  devm_of_mdiobus_register()    devm_of_mdiobus_register()

Both would register a bus for the same OF "mdio" node and create
duplicate mdio and phy devices. priv->child_bus and ds->user_mii_bus
could also end up pointing at different buses.

priv->child_bus is also set before devm_of_mdiobus_register() finishes,
and cleared again on failure. A concurrent mt753x_setup() could therefore
treat a bus that later fails to register as already done. On MMIO,
core_write() and core_rmw() use child_bus whenever priv->bus is NULL.

Would a real lock, or doing the early registration in one well-defined
place, be more robust than using child_bus as a gate?

>  	mnp = of_get_child_by_name(np, "mdio");
>  
>  	if (mnp && !of_device_is_available(mnp))
> @@ -2481,9 +2485,6 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	bus->parent = dev;
>  	bus->phy_mask = ~ds->phys_mii_mask;

[Severity: Medium]
When this runs from mt7988_probe(), is ds->phys_mii_mask set yet?

The DSA core fills it in only in dsa_switch_setup(), once the tree is
complete:

net/dsa/dsa.c:dsa_switch_setup() {
    ...
	ds->phys_mii_mask |= dsa_user_ports(ds);
    ...
}

mt7530.c never sets it itself.

Take an MMIO switch with no "mdio" DT node whose tree is still incomplete
when dsa_register_switch() returns, for example because another tree
member probes later. The probe-time call sets ds->user_mii_bus and
registers the bus with phy_mask = ~0, so none of the internal PHYs are
scanned.

When the tree later completes, mt753x_setup() calls mt7530_setup_mdio()
again. That call returns 0 straight away because priv->child_bus is set.

Wouldn't dsa_user_phy_connect() then fail with "no phy at %d" for user
ports that have no phy-handle?

>  
> -	if (priv->irq_domain && !mnp)
> -		mt7530_setup_mdio_irq(priv);
> -
>  	priv->child_bus = bus;
>  
>  	ret = devm_of_mdiobus_register(dev, bus, mnp);

[ ... ]

> @@ -3328,6 +3330,9 @@ mt753x_setup(struct dsa_switch *ds)
>  	if (ret)
>  		return ret;
>  
> +	if (priv->irq_domain && ds->user_mii_bus)
> +		mt7530_setup_mdio_irq(priv);
> +

[Severity: Medium]
Is mt7530_setup_mdio_irq() now called too late to have any effect?

In the !mnp case, mt7530_setup_mdio() has already registered and scanned
ds->user_mii_bus by the time this runs. mdiobus_alloc_size() set every
bus->irq[] entry to PHY_POLL, and phy_device_create() copied that value
into each PHY during the scan:

	dev->irq = bus->irq[addr];

mt7530_setup_mdio_irq() then updates only the bus array, which no
existing phy_device reads again:

	ds->user_mii_bus->irq[p] = irq;

Wouldn't the internal PHYs keep phydev->irq == PHY_POLL? Then the PHYn_LC
link-change interrupts would never be requested, and link detection would
fall back to polling.

This looks like it affects every MT7530/MT7531/MMIO switch with
"interrupt-controller" and no "mdio" subnode. That includes the ordinary
single-switch MDIO-attached setup, not just the cascade case. The commit
message does not mention this move.

>  	/* Initialise the PCS devices */
>  	for (i = 0; i < priv->ds->num_ports; i++) {
>  		priv->pcs[i].pcs.ops = priv->info->pcs_ops;
> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 5b7394f6383c7..c86bc4bca29b9 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -969,6 +969,16 @@ struct mt7530_hw_stats {
>  int mt7530_probe_common(struct mt7530_priv *priv);
>  void mt7530_remove_common(struct mt7530_priv *priv);
>  
> +/*
> + * When an MMIO based switch has an MDIO bus which contains a downstream MDIO
> + * switch, the MDIO bus is not normally setup until mt753x_setup() has been
> + * called. But mt753x_setup() is not called until DSA sees that every switch in
> + * the tree has been probed. Calling mt7530_setup_mdio() after at the end of

[Severity: Low]
This isn't a bug, but there's a typo here: "after at the end of".

The commit message also says:

  In MMIO mode
  the switch provides its own MDIO bus which connects to its integrated
  PHYs, but also can be connected to other things, such as another
  switch.

mt7530_setup_mdio() is common code, and it also creates a child bus for
MDIO-attached MT7530/MT7531 (mt7530-mdio.c). An MDIO-attached MT753x with
a switch on its child bus would hit the same problem, but only
mt7988_probe() gets the workaround.

Could the commit message explain why this is MMIO-specific?

> + * the MMIO probe function allows the downstream switch to register, completing
> + * the tree.
> + */
> +int mt7530_setup_mdio(struct mt7530_priv *priv);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028011317.1557238-1-cjd%40cjdns.fr
