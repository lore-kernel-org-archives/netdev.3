Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D803B27F1;
	Thu, 17 Sep 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678200; cv=none; b=W/XUNM92+A34H8X9jwFVB2q54ctjZ5zXh8S7qXU5Eo4pTW/OUxLc47cVQtOF1aw1XMupk67gayFZK3w542HR2YMWWqLR4hee2y8e74PgVeNqHgjcnGx+lshSDrxjEmgoMW040bcWWKm8F+13DGy1IBC7GGQJvvPpVo+SMQZ6688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678200; c=relaxed/simple;
	bh=EhbLkmj3zmcXJLTSDKN+z4QoX6PszaZ8gj8BytgLvTU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyuBCMff1RPz0sI3dfIwVDVhJfOgBO1IMUWIz1SkLSFbuD0gymG/YfOP0Ykfv0RC4dHpB5XjGTpJ2JL81wYJSj0adt2LUvd4dSyP9LxthFM/+Rdn5Y0MDERyOdcQmLQc1Gl3yYCsz08FbeUarkDG/zyeIaZjOTiLD3bJJWZdckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGyTtU15; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGyTtU15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384F71F000FF;
	Thu, 17 Sep 2026 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789678198;
	bh=FQYui3tcZfq2ROydeSxtp6DoWZ2zeLb2aIsISm8zZFo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HGyTtU15OsNrSwU5EKZoLydiVN40Ndey/x/8y+JVP2oW+Rvyat5m0yP9puFspzlKi
	 kUaFWt6IOceemvTReDZhOuKb1x8Vqf7944OW7EWyZ5J+0hB39gAfXLPbmkcllreAiB
	 BMY+/2PBh6i9zBJ8Auo/0P+FW6HvDXo+Ys0eWcSqTkHF1I9t6Qgd8drvfIEi4eoRqX
	 XrAREWaWSqc2LRB3A4lMWPP91BocRn3v0q6lGyijhbRGLaEokvVhr7F4OMI4wN91hG
	 ubbJJNibvAyBA7448FAPL3S9AwpjpZ94YuJviPk4QJ4TP+HBN73KhLUa334KFSuGeD
	 qEMCGcrIvxObQ==
Subject: Re: [PATCH v2 net-next 4/7] net: dsa: mediatek: support PLL setup on
 MMIO MT7530
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
Date: Thu, 17 Sep 2026 20:49:56 +0000
Message-ID: <178967819681.22033.1534914600402935907@kernel.org>
In-Reply-To: <20260915174643.253660-5-cjd@cjdns.fr>
References: <20260915174643.253660-5-cjd@cjdns.fr>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 4

- [Medium] On the path this patch newly enables (priv->bus == NULL, so
  bus = priv->child_bus), core_write() and core_rmw() execute a 4-5…
- [Low] Ordering of the new priv->child_bus producer vs. its consumers:
  priv->child_bus is assigned only in mt7530_setup_mdio()…
- [Low] The commit subject/message ('net: dsa: mediatek: support PLL
  setup on MMIO MT7530', 'begin using it for core switch PLL setup')…
- [Low] core_write() and core_rmw() compute `int ctl_phy =
  mt753x_ctrl_phy_addr(priv);` in the declaration initializer, before…
- [Low] The new kernel-doc for the @child_bus member of struct
  mt7530_priv is ungrammatical and does not describe the field's actual…

Pre-existing issues:
- [High] Pre-existing race on the MDIO path that this patch extends
  without addressing: core_write()/core_rmw() drive the control PHY's…

--

net: dsa: mediatek: support PLL setup on MMIO MT7530

This patch adds a new priv->child_bus pointer that records the MDIO bus
the switch driver itself creates in mt7530_setup_mdio(), and makes
core_write() and core_rmw() fall back to it when priv->bus is NULL, so
core (PLL) register access can work on MMIO-probed switches.

No Link: tags are present in the commit header.

The commit message says:

  In an MMIO implementation, the MDIO bus is part of the switch itself.
  This bus is already setup for PHY calibration so begin using it for
  core switch PLL setup.

[Severity: Low]
Is there any device in the tree at this commit that can reach the new
fallback?  mt7530-mmio.c matches airoha,an7583-switch,
airoha,en7581-switch, econet,en7528-switch and mediatek,mt7988-switch,
and all of those IDs use .sw_setup = mt7988_setup, which contains no
core_write()/core_rmw() call, and none of them has a .mac_port_config
that reaches mt7530_setup_port5()/mt7530_setup_port6().

The first MMIO consumer appears only with the later patch
"net: dsa: mediatek: support EN751221 switch", which adds ID_EN751221
with .mac_port_config = mt7530_mac_config and the control PHY address
for MMIO (if (priv->id == ID_EN751221) return 12;).

Would it be clearer to state in the message that this is a prerequisite
for the EN751221 MMIO variant, and that the MMIO control PHY address is
still missing here?

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b2344808457cb..b152b73315d50 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -77,6 +77,12 @@ core_write(struct mt7530_priv *priv, u32 reg, u32 val)
>  	struct mii_bus *bus = priv->bus;
>  	int ret;
>  
> +	if (!bus)
> +		bus = priv->child_bus;
> +
> +	if (WARN_ON_ONCE(!bus))
> +		return;
> +

[Severity: Low]
On the instances this fallback newly enables, what PHY address does the
MMD sequence end up using?  core_write() computes ctl_phy in the
declaration initializer, before the fallback runs:

	int ctl_phy = mt753x_ctrl_phy_addr(priv);
	struct mii_bus *bus = priv->bus;

and at this commit mt753x_ctrl_phy_addr() has no MMIO case:

	if (WARN_ON_ONCE(!priv->mdiodev))
		return 0;

	/* Default is 1st PHY */
	return (priv->mdiodev->addr + 1) & (PHY_MAX_ADDR - 1);

mt7988_probe() in mt7530-mmio.c sets priv->bus = NULL and never sets
priv->mdiodev, so an MMIO caller would hit that WARN and then issue the
whole vendor MMD sequence to child bus address 0, which is an ordinary
port PHY rather than the control PHY.

This is not reachable at this commit (no MMIO ID calls core_write() or
core_rmw()), and the later patch "net: dsa: mediatek: support EN751221
switch" adds the missing case for the only MMIO consumer.  Would it be
worth adding the MMIO control PHY handling in the same patch that adds
the bus fallback, so the two never appear apart?

[Severity: High]
This isn't a bug introduced by this patch, but since the same helper is
now extended to a second bus, would it make sense to fix the locking
once for both paths?

On the existing MDIO path, core_write() drives the control PHY MMD
window while holding only the parent bus lock:

	mt7530_mutex_lock(priv);   /* priv->bus->mdio_lock */
	ret = bus->write(bus, ctl_phy, MII_MMD_CTRL, MDIO_MMD_VEND2);
	ret = bus->write(bus, ctl_phy, MII_MMD_DATA, reg);
	ret = bus->write(bus, ctl_phy, MII_MMD_CTRL,
			 MDIO_MMD_VEND2 | MII_MMD_CTRL_NOINCR);
	ret = bus->write(bus, ctl_phy, MII_MMD_DATA, val);

That address, (priv->mdiodev->addr + 1) & (PHY_MAX_ADDR - 1), is the
same physical PHY that phylib manages as user port 0.  phylib's own
indirect MMD access in mmd_phy_indirect() holds the child bus lock, and
picks up the parent lock only per transfer, because the child bus ops go
through mt7530_phy_read_c22()/mt7530_phy_write_c22() ->
mdiobus_read_nested()/mdiobus_write_nested(priv->bus, ...).

Can the whole core_write() sequence then land between two steps of
phylib's sequence?  It leaves MII_MMD_CTRL set to
MDIO_MMD_VEND2 | MII_MMD_CTRL_NOINCR with a CORE_* register latched in
MII_MMD_DATA, so phylib's next MII_MMD_DATA access would write its own
value into that CORE_* register (CORE_PLL_GROUP7 or
CORE_TRGMII_GSW_CLK_CG, for example), or read switch PLL state instead
of EEE ability.

Both contexts run concurrently: mt7530_setup_port6() is reached from
mt753x_phylink_mac_config() in the phylink resolve worker, which holds
only pl->phydev_mutex and pl->state_mutex, while phy_check_link_status()
issues genphy_c45_eee_is_active() -> phy_read_mmd() on link up.

Would taking the PHY's own bus lock (the child bus mdio_lock) around the
MMD sequence, before the nested parent lock, be the right fix here?

>  	mt7530_mutex_lock(priv);
>  
>  	/* Write the desired MMD Devad */
> @@ -112,6 +118,12 @@ core_rmw(struct mt7530_priv *priv, u32 reg, u32 mask, u32 set)
>  	u32 val;
>  	int ret;
>  
> +	if (!bus)
> +		bus = priv->child_bus;
> +
> +	if (WARN_ON_ONCE(!bus))
> +		return;
> +
>  	mt7530_mutex_lock(priv);

[Severity: Medium]
When the child bus is used, is anything serializing the multi-step MMD
window?  mt7530_mutex_lock()/mt7530_mutex_unlock() are no-ops in exactly
that case:

static void
mt7530_mutex_lock(struct mt7530_priv *priv)
{
	if (priv->bus)
		mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
}

So with priv->bus == NULL the four writes in core_write(), and the five
transactions of the core_rmw() read-modify-write:

	ret = bus->read(bus, ctl_phy, MII_MMD_DATA);
	...
	val &= ~mask;
	val |= set;
	ret = bus->write(bus, ctl_phy, MII_MMD_DATA, val);

run with no lock covering the sequence, and the direct bus->write() /
bus->read() calls also bypass child_bus->mdio_lock, so the
lockdep_assert_held_once(&bus->mdio_lock) in __mdiobus_write() cannot
flag it.  The atomicity the MDIO path got from holding the parent bus
lock across the whole sequence is dropped for the MMIO path.

Individual transfers do stay atomic on MMIO (mt7531_ind_c22_phy_read()
and mt7531_ind_c22_phy_write() take priv->reg_mutex), so what is exposed
is the multi-step window on the control PHY: a second accessor of that
PHY address would see a read return, or a write land in, the wrong
CORE_* register.  I could not find such a second accessor for the
in-series EN751221 consumer, so the corruption itself is speculative,
but the dropped lock is not.

Would locking the bus that was actually selected work here, that is
mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED) plus
__mdiobus_read()/__mdiobus_write(), the way other DSA drivers do it?

>  
>  	/* Write the desired MMD Devad */
> @@ -2429,8 +2441,11 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	if (priv->irq_domain && !mnp)
>  		mt7530_setup_mdio_irq(priv);
>  
> +	priv->child_bus = bus;
> +
>  	ret = devm_of_mdiobus_register(dev, bus, mnp);
>  	if (ret) {
> +		priv->child_bus = NULL;
>  		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
>  		if (priv->irq_domain && !mnp)
>  			mt7530_free_mdio_irq(priv);

[Severity: Low]
Is the producer of priv->child_bus ordered ahead of its consumers?
mt753x_setup() runs the switch specific setup first and only afterwards
creates the bus:

	int ret = priv->info->sw_setup(ds);
	...
	ret = mt7530_setup_mdio(priv);

So any core_write()/core_rmw() issued from an sw_setup callback on an
instance where priv->bus is NULL (mt7988_probe() sets priv->bus = NULL)
finds both pointers NULL, trips the new WARN_ON_ONCE(!bus) and returns
without performing the MMD sequence.  Should the bus be created before
sw_setup(), or should core_* return an error the caller can act on?

There is also a case where the pointer stays NULL for the whole device
lifetime.  mt7530_setup_mdio() returns 0 without allocating a bus when a
disabled mdio child node is present:

	if (mnp && !of_device_is_available(mnp))
		goto out;

After that, every runtime core_* access (the CORE_PLL_GROUP* and
CORE_TRGMII_GSW_CLK_CG programming in mt7530_setup_port6(), for example)
becomes a warning plus a no-op rather than a probe failure.  Is silently
skipping the clock programming the intended behaviour there?

For completeness, the path named in the commit message,
mt7530_setup() -> mt7530_pll_setup() -> core_clear()/core_write(), is
not reachable on a bus-less instance in this tree: mt7530_setup() is
.sw_setup only for the MDIO probed IDs, where priv->bus is a real parent
bus.  So this reads as a latent ordering trap plus the disabled mdio node
corner case rather than a failure any current board hits.

> diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
> index 108c831dd0120..5b7394f6383c7 100644
> --- a/drivers/net/dsa/mt7530.h
> +++ b/drivers/net/dsa/mt7530.h
> @@ -886,6 +886,9 @@ struct mt753x_info {
>   * @dev:		The device pointer
>   * @ds:			The pointer to the dsa core structure
>   * @bus:		The bus used for the device and built-in PHY
> + * @child_bus:		The bus created by the device, on MDIO implementations
> + *			this is bus indirectly accesses `bus`, on MMIO
> + *			implementations this bus is part of the switch.

[Severity: Low]
The middle clause, "this is bus indirectly accesses `bus`", looks like it
is missing a word or two.

Also, "The bus created by the device" does not match the code:
mt7530_setup_mdio() returns 0 without allocating a bus when a disabled
mdio child node exists, and it resets the pointer back to NULL on
registration failure, so the field can legitimately be NULL for the
whole device lifetime.

Could the doc state when the field may be NULL, and which of priv->bus,
priv->child_bus and ds->user_mii_bus the core_* helpers are expected to
use?  The selection rule (if (!bus) bus = priv->child_bus;) is currently
copy-pasted into core_write() and core_rmw(), so every future core_*
helper has to remember to repeat it.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915174643.253660-1-cjd%40cjdns.fr
