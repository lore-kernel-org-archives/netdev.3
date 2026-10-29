Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239363;
	b=lDINTdxQWhsuiv9OP+gK1kzQEcNnl+b7tyfUkOWoVxTMnUZ7aJz236hOJDQoeySTdeEc
	 UMqh9ioveLuJe7EL3s3IV68vtEVX4o701C0YGdkkUTRAgIsFuwSLCK05sIjsaBdly4HtA
	 og/YFiG4swnYXHiuyJcr1xtLw2JtAyXq/ozf5LtQd1HQy03ymzjeqJO85S8g700gGEwdD
	 tfGkGLaI0opcyMlM+eCqjQQDU2P6xu1F/pzrYqCE6ok1r8xXLcAxC4oM1uL/qA7uHNpNJ
	 CFZ1ecwsKA61NkF9hCpuBZ59bBjTSYzG45kUbNomx8P7Uf9pWQKGfGOPgqv3p74IFTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239363;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sCMSQ9Lepa3mXHoZTqA3z+QNJhLXDNrrQbFhzlyKoj0=;
	b=2Bxqem58qAAucOrpa2b/toAEeeaEwU9+09Z0o8oNjWSVlLse4d7vyFdhUzY03843P681
	 mHq+/aQ7ll+XxA8xFBuHGavIPncSx2kzkLGMJ9JpGGuqHGdVOqO3UUgWf18KqZv85e4Z0
	 QvfpZqgXXLJ3JRRp8nzl5iwPc0Vwi+9kPpDb8j8ETWw3TfhL5/uz2Sd9sK4onI5nN63qk
	 kDlXevc/53IszmC7syiDBEv/qyixWlU9qeKk0XxbpK4zhtra+uZtZ+ZeIARBgW9Cpwi9F
	 iKD+N4d/KK53fXjCwMluL/cXdREKlTTmu6Lqk4sTta2/aGch34sUQj0X2KdNVojf4Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFrXGEDq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158B606A332;
	Thu, 29 Oct 2026 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFrXGEDq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135161F01828;
	Thu, 29 Oct 2026 02:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793239363;
	bh=sCMSQ9Lepa3mXHoZTqA3z+QNJhLXDNrrQbFhzlyKoj0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mFrXGEDqrxCMdlKMMIPUBS3+KhR5D94LDguotWnA9Xq2I+zccddxl3p++pwtl8SFe
	 zNicYoNC19FhCJd+k2Ap99sWTQ9wiqVA4fNPJ3TFLz2Sv78MKJomMexLItSKZjM5+M
	 e20BsbkfvYlf/2exTlzcKcfOcKrk1UAuB2IAv+PKhk4lmnjYVae4DjL0AdXsPYN8Lk
	 510HQRn6o4495YvWX04cYR8gyvpj81DzvWC2qcqVpHoxQOC1Gf8IqHsBIDQSapLgPk
	 Ujs2q8bXOxMnnkk5Xo6yp34SabFkhwLg57iUp871Nzb0vXugN7XD4LVH+4RZ3jhm6j
	 iLIuSUHkwX28g==
Subject:
 Re: [PATCH v3 4/7] net: dsa: mediatek: support PLL setup on MMIO MT7530
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
Date: Thu, 29 Oct 2026 02:02:41 +0000
Message-ID: <179323936162.3134.6314802280650738010@kernel.org>
In-Reply-To: <20261028011317.1557238-5-cjd@cjdns.fr>
References: <20261028011317.1557238-5-cjd@cjdns.fr>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] core_write()/core_rmw() in drivers/net/dsa/mt7530.c now fall
  back to priv->child_bus when priv->bus is NULL.
- [Low] The new @child_bus kernel-doc in struct mt7530_priv
  (drivers/net/dsa/mt7530.h) reads: 'The bus created by the device, on…
- [Low] Claim: mt753x_setup() calls priv->info->sw_setup() (mt7530_setup
  -> mt7530_pll_setup -> core_clear/core_write/core_set) before…
- [Low] Claim: on MMIO, core_write()/core_rmw() call
  mt753x_ctrl_phy_addr() while priv->mdiodev is NULL, so they WARN and…

--

net: dsa: mediatek: support PLL setup on MMIO MT7530

This commit adds a child_bus pointer to struct mt7530_priv. It is set to
the MDIO bus registered in mt7530_setup_mdio(). When priv->bus is NULL,
which is the MMIO case, core_write() and core_rmw() now use child_bus
instead, so core PLL registers can be reached on MMIO switches.

> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 3eb2e11d69856..d09ff207e2dfc 100644
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
>  	mt7530_mutex_lock(priv);

[Severity: Medium]
Is anything serializing the MMD indirect sequence when the code falls
back to child_bus here?

mt7530_mutex_lock() only takes a lock when priv->bus is set:

static void
mt7530_mutex_lock(struct mt7530_priv *priv)
{
	if (priv->bus)
		mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
}

On MMIO, mt7988_probe() sets priv->bus = NULL, so this lock does nothing.
The steps then call bus->write() and bus->read() directly, so
child_bus->mdio_lock is never taken either.

Each step ends up in mt7531_ind_c22_phy_write(), which holds
priv->reg_mutex for a single IAC transfer and releases it between steps.
The sequence is MII_MMD_CTRL, then MII_MMD_DATA=reg, then
MII_MMD_CTRL|NOINCR, then MII_MMD_DATA=val, with a read in core_rmw().

Other users of the same PHY address on child_bus hold
child_bus->mdio_lock. That includes phylib's phy_read_mmd() and
phy_write_mmd(), e.g. genphy_c45_read_eee_abilities() from phy_probe() or
genphy_c45_eee_is_active() from the state machine, and SIOCSMIIREG via
phy_mii_ioctl().

Can one of them re-target the MMD address latch partway through
core_write() or core_rmw()? If so, the PLL value would land in the wrong
MMD register, or core_rmw() would read one register and write the merged
value back to it.

In the MDIO variant, priv->bus->mdio_lock is held for the whole sequence,
and child bus accesses take that same lock, so this cannot happen there.

Later in the series, "net: dsa: mediatek: support EN751221 switch" makes
the on-die EN751221 (MMIO) reach this path:

mt7530_mac_config()->mt7530_setup_port6()->core_write()/core_rmw()

mt7530_mutex_lock() is still unchanged at the end of the series. Should
core_write() and core_rmw() lock child_bus->mdio_lock when they fall back
to child_bus?

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

[Severity: Low]
On the MMIO path priv->mdiodev is NULL as well. At this commit,
core_write() and core_rmw() get ctl_phy from:

static int
mt753x_ctrl_phy_addr(struct mt7530_priv *priv)
{
	if (WARN_ON_ONCE(!priv->mdiodev))
		return 0;
	...
}

Wouldn't a core_* call through child_bus therefore WARN and target PHY
address 0?

No MMIO variant reaches core_* at this commit. The later commit "net: dsa:
mediatek: support EN751221 switch" adds an ID_EN751221 case that returns
12 before the WARN. So this looks resolved by the end of the series. Is
it worth noting that dependency in this commit message?

>  	mt7530_mutex_lock(priv);
>  
>  	/* Write the desired MMD Devad */

[ ... ]

> @@ -2472,8 +2484,11 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	if (priv->irq_domain && !mnp)
>  		mt7530_setup_mdio_irq(priv);
>  
> +	priv->child_bus = bus;
> +

[Severity: Low]
This is the only place child_bus is assigned. mt753x_setup() calls
priv->info->sw_setup() before mt7530_setup_mdio(). Could a core_* call
from sw_setup run before child_bus is set?

That ordering would only matter if an MMIO variant used mt7530_setup(),
which calls mt7530_pll_setup(). None does: the MMIO entries all use
mt7988_setup, and ID_EN751221_EXT is probed through mt7530-mdio.c. So the
ordering on its own does not look like a problem.

There is still a corner case. If the DT has an mdio node that is present
but disabled, mt7530_setup_mdio() returns early:

	if (mnp && !of_device_is_available(mnp))
		goto out;

That path returns success and leaves child_bus NULL. For EN751221 later
in the series, mt7530_setup_port6() would then hit WARN_ON_ONCE(!bus) and
skip the TRGMII PLL writes. Is that the intended behaviour for that
configuration?

>  	ret = devm_of_mdiobus_register(dev, bus, mnp);
>  	if (ret) {
> +		priv->child_bus = NULL;
>  		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
>  		if (priv->irq_domain && !mnp)
>  			mt7530_free_mdio_irq(priv);
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
This isn't a bug, but "this is bus indirectly accesses" reads garbled.

The comment also suggests child_bus is always valid on MMIO. It is NULL
until mt7530_setup_mdio() runs, when the mdio node is disabled, and after
devm_of_mdiobus_register() fails. Could the comment mention those cases,
and that core_write() and core_rmw() only use child_bus as a fallback
when bus is NULL?

>   * @regmap:		The regmap instance representing all switch registers
>   * @rstc:		The pointer to reset control used by MCM
>   * @core_pwr:		The power supplied into the core

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028011317.1557238-1-cjd%40cjdns.fr
