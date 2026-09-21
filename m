Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F944FDA6C;
	Mon, 21 Sep 2026 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034230; cv=none; b=MG34RQaIWryFu8cSoQZNxIr9BP4f4+8kehw4Xas3OYB/inrSpw4Xwt7tVDB2EKKhjv/ExpBJt12Evq6MhjXzNx+EyeaBlkzzdYmLamguIN5wQvqKIkukAQ4pndbKx8Cxm0hh4x+jRSe2SSVACD4F5vswdeE6JucdpV8E1tVlpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034230; c=relaxed/simple;
	bh=Elxr4dK2+aiB4qgEVdRJzUUK+KFzId0SWdwT6LIwj7o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SW+b7DroCbFP7OEv+M/gE+Dxy2aqPTFNCvdsBASazB7d3WxY88aJ+Acw6qIWdZq3IxzQLewyzfpEkRG3Gl/+yWiKy3DR9o/xkndXK82Ik2mcNp/dELfPgi7XK+i/ceTf/6DsWnhG8wMGkLagtgwVh2v5XOLR2u9D9rDkG81Tr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmXgLRbQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmXgLRbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D32F1F000FF;
	Mon, 21 Sep 2026 23:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034228;
	bh=Zl7eC8lMz4Pjw1I1o2N00til9DTBdWZKgKdDutJ66sY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YmXgLRbQFuCXw5d0EwgEbchKj4+EcLd4fsPiCuF3wrMwpsZCyG23IZfJK8gwJ/xD1
	 /0hB5qDTqqDsQa+fOa79OY/xk29RnT4rhbXnnOnn+8nOKdMDQpa/0Kr3RwExoLfHSV
	 y3zeDAYyuJDNDWmcRg5OW9+FnnrrRi39s/Pggr8p/eTdT07y6xDV51m+OIzRGnqYz7
	 lh+vlxYZSqTVrPZkG/F9qCw4BGbjNUVv1Uq0eggSYx5Ehw3Gtwic/kQeQ8sNjGqDLQ
	 Ddn5nCkwcHw1Hkq7FyY8Vjk/bKVdnvxeLf/IAULLZvW9hR9nJnJpHzOEOBRU6Qfbgv
	 9iDfjJ3Z8OG0A==
Subject: Re: [PATCH net-next v7 06/11] net: pcs: xpcs: add ANRESTART support
 for SGMII link recovery
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org,
 linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Date: Mon, 21 Sep 2026 23:43:45 +0000
Message-ID: <179003422590.2160803.6200112625831511615@kernel.org>
In-Reply-To: <20260917204624.2427486-7-coiaprant@gmail.com>
References: <20260917204624.2427486-7-coiaprant@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The recovery sequence in xpcs_get_state_c37_sgmii() consumes
  the only evidence that an SGMII AN cycle completed (writes 0 to…
- [Medium] The new AN-register mutations in xpcs_get_state_c37_sgmii()
  (latch clear + BMCR_ANRESTART, pcs-xpcs.c:1110-1121) are performed…

--

net: pcs: xpcs: add ANRESTART support for SGMII link recovery

This adds BMCR_ANRESTART to the C37 SGMII paths of pcs-xpcs: the config
path now clears DW_VR_MII_AN_INTR_STS and sets ANRESTART together with
ANENABLE, and xpcs_get_state_c37_sgmii() clears the AN complete latch and
issues an ANRESTART when the link is down but AN completion was latched.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 0337e2bcc0125..8c3875b6985b9 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c

[ ... ]

> @@ -816,9 +825,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Clear CL37 AN complete status */
> +	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +	if (ret < 0)
> +		return ret;
> +
>  	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
>  		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
> -				 mdio_ctrl | BMCR_ANENABLE);
> +				 mdio_ctrl | BMCR_ANENABLE | BMCR_ANRESTART);
>  
>  	return ret;
>  }

[Severity: Medium]
Is there anything serializing xpcs_config_aneg_c37_sgmii() against
xpcs_get_state_c37_sgmii() now that both mutate the AN registers?

xpcs_config_aneg_c37_sgmii() reads MII_BMCR at function entry, clears
BMCR_ANENABLE, reprograms DW_VR_MII_AN_CTRL and DW_VR_MII_DIG_CTRL1,
writes AN_INTR_STS = 0, and then writes back the value it read at entry:

	mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
	...
	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
			 mdio_ctrl | BMCR_ANENABLE | BMCR_ANRESTART);

xpcs_modify() only holds bus->mdio_lock for a single register
read-modify-write, not for the whole sequence, so can these interleave?

	thread A: phylink_resolve() -> phylink_mac_pcs_get_state() ->
		  xpcs_get_state_c37_sgmii()   (pl->state_mutex, no rtnl)
	thread B: ETHTOOL_GLINKSETTINGS / SIOCGMIIREG ->
		  phylink_ethtool_ksettings_get() / phylink_mii_read() ->
		  phylink_mac_pcs_get_state()  (rtnl only)
	thread C: phylink_major_config() -> xpcs_config() ->
		  xpcs_config_aneg_c37_sgmii()

phylink_resolve() takes pl->phydev_mutex, phy->lock and pl->state_mutex but
not rtnl, while the ethtool and ioctl query paths reach the same op under
rtnl only, so the lock sets do not appear to intersect.

If a get_state() sets BMCR_ANRESTART while the config path has ANENABLE
cleared, is that restart request simply lost?  And can the final blind
write of the stale mdio_ctrl above discard BMCR bits set by a concurrent
get_state()?  Similarly, two concurrent get_state() calls can both observe
the same latched ANCMPLT and both issue a restart, with the second
aborting the negotiation the first started.

Note that the pre-patch code already wrote the AN_INTR_STS latch from the
get_state() path; it is the newly added BMCR read-modify-write that makes
the interleaving change hardware state.

> @@ -1093,9 +1107,18 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
>  		return 0;
>  	}
>  
> -	/* Clear AN complete status or interrupt */
> -	if (state->an_complete)
> -		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +	if (state->an_complete) {
> +		/* Clear AN complete status or interrupt */
> +		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Initiate the next round of AN */
> +		ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
> +				  BMCR_ANRESTART);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: Medium]
Can this sequence permanently disable the recovery it adds?

The write of 0 to DW_VR_MII_AN_INTR_STS consumes the only record that an
SGMII AN cycle completed, and the restart is then a separate fallible MDIO
read-modify-write:

drivers/net/pcs/pcs-xpcs.c:
int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set)
{
	return mdiodev_c45_modify(xpcs->mdiodev, dev, reg, mask, set);
}

If the latch clear succeeds but the xpcs_modify() fails, the PCS is left
with AN neither complete nor restarted.  The re-entry gate is
if (state->an_complete), and AN_INTR_STS is now 0, so every later poll
reads 0 and never retries.

The caller only logs the error:

	ret = xpcs_get_state_c37_sgmii(xpcs, state);
	if (ret)
		dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
			"xpcs_get_state_c37_sgmii", ERR_PTR(ret));

so no pending-restart state is kept anywhere.  Would clearing the latch
only after a successful restart write, or keeping a flag that forces a
retry on the next poll, be preferable here?

Related to this, the commit message says:

    If an MDIO access fails at this point, it indicates an
    unrecoverable hardware condition until reset.

Is that accurate?  -ETIMEDOUT or -EBUSY on a busy MDIO bus is transient,
and for the Rockchip glue added later in the series a
pm_runtime_resume_and_get() failure in xpcs_rk_read_reg() /
xpcs_rk_write_reg() would also surface here without implying the PCS needs
a reset.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204624.2427486-1-coiaprant%40gmail.com
