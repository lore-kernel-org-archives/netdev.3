Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207C3161A2;
	Sat,  3 Oct 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034564; cv=none; b=HstYMjDIDcRNxWeACcb8AEufykfrlhksBfaOGsFsf5K3FfVzpZ7jY15/eNLaRg3VI88b1dgWNeMT2trMJ/i3rEHI7yKu7/lmkQWRH4q7sPeKK8Fi0Kry5hjExJD/iw1XVRe9vqmLHmZELbN+P0qavF59jhbg7Z4BeYEjJfCGdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034564; c=relaxed/simple;
	bh=D1IMWS4NlvyL61u7PsL/Rjlj9/tibH7i19YT51ooD/U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otFSjqQiI52JsLTY4F34w/Qt6MWh+fbH+K+0JJVoBiAx9x/6niZPcVS9wbM8q13otIn4TebnJZAIe1E3acs2/v52rp4pqff4jiqXHsiYs0Pdy/yULJ2JHdOo5pOSBHhpIpGI5Hb6usB5j5Gj6qM6feoaXjdfX+fDRWC8mqgfgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrQSwNCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrQSwNCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0A61F0089B;
	Sat,  3 Oct 2026 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791034562;
	bh=N9bLhJAaRjLMHJ2t1wQDqGKkxSiNRw7nnJkH9dboKPU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NrQSwNClP9761Mfc0eYOTkVt5deD6fkPk1mKMn0gXFBN87YlItrIuA8/dXP53BSBh
	 1Uitf20tSGnhoNEpjS5KXi5KjWOWfQEQnGvnh+jmTRmP2lfD7uGHBe7vwzO3MhXDpB
	 SnBIOq4C+fPZe7dj/BMldDAkaMxgGc0xJI+f0WIzZFVv0Lw7F/k7ElTc1ZgKn8d+Be
	 rYVTlr8g/Hge2v2Tssx3MH71WOGnC64OCAiSM8MEAxcWuV6XY23ipFygrsJrHWlHhM
	 CGjqjxdXPn0DvktgHd/JNYh9G0+/Re35AlP7NnoSVpse1dvGsF9h2pwN7bDafviCHe
	 xJfx8erlGMlUA==
Subject: Re: [PATCH net-next v4 1/4] net: phy: microchip_t1s: fix collision
 detection on PLCA status change
From: netdev-bot+sashiko@kernel.org
To: parthiban.veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com
Date: Sat, 03 Oct 2026 13:36:01 +0000
Message-ID: <179103456181.434549.13678740418494545404@kernel.org>
In-Reply-To: <20260929125928.611784-2-parthiban.veerasooran@microchip.com>
References: <20260929125928.611784-2-parthiban.veerasooran@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The collision-detect (CDEN) setting is chosen from a software
  copy of the PLCA enable state (priv->plca_enabled), not from the PHY's…
- [Low] [Baseline decision: false.
- [Low] [Baseline decision: false.

--

net: phy: microchip_t1s: fix collision detection on PLCA status change

This patch makes the collision detection enable bit (CDEN) follow
autonomous PLCA/CSMA-CD transitions. It adds a PLCA status change
interrupt and a resync in read_status(), and it takes the PRSCTL1
fallback bit into account. It also adds a probe routine that allocates
a per-PHY mutex and a cached plca_enabled value, and it treats
plca_cfg->enabled as tri-state.

> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> index 73c23d311d72a..5ce0304bf0952 100644
> --- a/drivers/net/phy/microchip_t1s.c
> +++ b/drivers/net/phy/microchip_t1s.c

[ ... ]

> @@ -430,6 +469,57 @@ static int lan867x_revd0_link_active_selection(struct phy_device *phydev,

[ ... ]

> +static int lan86xx_update_cden(struct phy_device *phydev)
> +{
> +	struct lan86xx_priv *priv = phydev->priv;
> +	struct phy_plca_status plca_st;
> +	int fallback, ret;
> +	u16 cden;
> +
> +	fallback = lan86xx_fallback_to_csmacd(phydev);
> +	if (fallback < 0)
> +		return fallback;
> +
> +	ret = genphy_c45_plca_get_status(phydev, &plca_st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* PLCA disabled                          -> CDEN enabled
> +	 * PLCA enabled + BEACON                  -> CDEN disabled
> +	 * PLCA enabled + no BEACON + fallback    -> CDEN enabled
> +	 * PLCA enabled + no BEACON + no fallback -> CDEN disabled
> +	 */
> +	if (!priv->plca_enabled)
> +		cden = COL_DET_ENABLE;
> +	else if (plca_st.pst)
> +		cden = COL_DET_DISABLE;
> +	else if (fallback)
> +		cden = COL_DET_ENABLE;
> +	else
> +		cden = COL_DET_DISABLE;

[Severity: Medium]
Can priv->plca_enabled get out of sync with the PLCA_CTRL0 enable bit in
the hardware? This decision uses the cached copy. read_status(),
config_intr() and the PSTC handler all rewrite CDEN from it, so a
mismatch gets written back on every poll.

The copy is only updated in lan86xx_plca_set_cfg(), and only after
genphy_c45_plca_set_cfg() fully succeeds. When enabled == 0, the generic
helper clears PLCA_EN first and then does more MDIO accesses that can
fail:

drivers/net/phy/phy-c45.c:genphy_c45_plca_set_cfg() {
    ...
	if (plca_cfg->enabled == 0) {
		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
					 MDIO_OATC14_PLCA_CTRL0,
					 MDIO_OATC14_PLCA_EN);
    ...
		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
				    MDIO_OATC14_PLCA_CTRL1, val);

		if (ret < 0)
			return ret;
    ...
}

If one of the later writes fails, PLCA is off in the hardware but
plca_enabled is still 1.

A PHY reset while the driver stays bound has the same effect. For MACs
that connect the PHY in ndo_open and have a reset GPIO or reset
controller, ifdown goes through:

drivers/net/phy/phy_device.c:phy_detach() {
    ...
	/* Assert the reset signal */
	phy_device_reset(phydev, 1);
    ...
}

A resume after the PHY lost power has the same effect. PLCA_CTRL0 goes
back to its default, but priv is devm-allocated at probe, so it keeps
plca_enabled = 1. lan867x_revc_config_init() does not touch PLCA_CTRL0.

In both cases this function sees plca_enabled = 1 and pst = 0. If
PRSCTL1 bit 10 (fallback) is clear, it writes COL_DET_DISABLE while the
PHY is actually running CSMA/CD. That is the situation the commit
message says it fixes.

The opposite can happen at probe. lan86xx_probe() zero-allocates priv
without reading PLCA_CTRL0. If PLCA is already enabled in the hardware
(for example, a module reload with no reset line), read_status() forces
CDEN on in PLCA mode, even though genphy_c45_plca_get_cfg() reports PLCA
as enabled.

The same logic is still there at the end of the series. Would it be
more robust for lan86xx_update_cden() to read the PLCA_CTRL0 enable bit
directly, instead of using the cached value?

> +
> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
> +			      COL_DET_CTRL0_ENABLE_BIT_MASK, cden);
> +}

[ ... ]

> @@ -458,14 +552,18 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
>  	if (ret)
>  		return ret;
>  
> -	if (plca_cfg->enabled)
> -		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> -				      LAN86XX_REG_COL_DET_CTRL0,
> -				      COL_DET_CTRL0_ENABLE_BIT_MASK,
> -				      COL_DET_DISABLE);
> +	if (plca_cfg->enabled != -1)
> +		priv->plca_enabled = plca_cfg->enabled;

[Severity: Low]
This isn't a bug, but priv->plca_enabled is written here under
phydev->lock only. lan86xx_config_intr() reads it through
lan86xx_update_cden() under cden_lock only.

In practice, the ethtool path (rtnl or the netdev instance lock) and
the config_intr() callers that reach lan86xx_update_cden() are
serialized. Also, the locked lan86xx_update_cden() call below writes
CDEN last using the new value.

Would it be cleaner to do this store inside the cden_lock section, so
that the lock covers both the cached state and the register update?

>  
> -	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
> -			      COL_DET_CTRL0_ENABLE_BIT_MASK, COL_DET_ENABLE);
> +	if (plca_cfg->enabled != -1) {
> +		mutex_lock(&priv->cden_lock);
> +		ret = lan86xx_update_cden(phydev);
> +		mutex_unlock(&priv->cden_lock);
> +		if (ret)
> +			return ret;
> +	}

[Severity: Low]
The commit message says:

    Rev.D0 is handled separately (follow-on patch).

At this commit, though, LAN867X Rev.D0 also uses lan86xx_plca_set_cfg(),
and this block calls lan86xx_update_cden() for it too. The Rev.D0 entry
in microchip_t1s_driver[] also gets .probe = lan86xx_probe in this
patch.

Rev.D0 has no read_status, config_intr or handle_interrupt at this
point. Enabling PLCA while pst reads 0 and the PRSCTL1 fallback bit is
set would therefore leave CDEN enabled after PLCA comes up. Is that
expected for this intermediate commit?

The follow-on patch, "net: phy: microchip_t1s: fix collision detection
for LAN867X Rev.D0", adds an early return for PHY_ID_LAN867X_REVD0
before the CDEN update, so this only affects bisection.

Rev.D0 does need .probe here, because the shared setter now dereferences
phydev->priv. Could the commit message mention this Rev.D0 change?

> +
> +	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929125928.611784-1-parthiban.veerasooran%40microchip.com
