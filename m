Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90193A7F57;
	Thu,  8 Oct 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477175; cv=none; b=CWM0RCvvSVVNpkDUN+fkL7Pd0cRAIprC0pvLv6TyrdnZdtKeDGJ9TyuyeCV569AJbervvJ2lIrqUvQavjdcjsdqxug+d//kN6J5BGfKkVoIlD4AVXxbEDD51e+43Vw4amGE5KoWR4fWKzMtYuK7n7XNH2QzuHvSdpPAkyxwBWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477175; c=relaxed/simple;
	bh=2kJIK7S6p7m76r7AeJqzFn6BWyXYVTVHuzzbpoTpp8E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CcWlxNZNDBanojQU7dkWSVLjJdmR3fJ8LFm/Udh8DVFsPtR2hxctiV3kBgFcmcNpKdR4hYJbKUX45HBvAU3T7XEIBnWsjSvf3wwYAqgi5er8mBPsYpWnW4MqpHusP2aozIVHcKoyvtm8DgYHHp4swwXR0QPjI4b6+sEonG8J8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiQKgjxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiQKgjxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3241F00893;
	Thu,  8 Oct 2026 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791477174;
	bh=uaNaa9Tn58yyTSAMBp+pidOqkG6cVxAP3V+r3sTN9A0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QiQKgjxRRf9tJvBoefNoxF5aewDt6d/O2/i/GA1w4yFcMQfSYI16bB0123CNEB257
	 Ac/xfEMnbG1/OouPWijBVSRMyBHljsnLxf0vZyRGEIBiQXr+CB9WuAcD5/cYIt3quz
	 PrJhnTKJiOVIJfBP5MItzIcWlafYCLB93hQ+0omLNVJt6648g7+g8oljTvhmIljAvD
	 PpGnXHnR9OklzP+F76H5pZFKVmCVQLp+X49gSZMuK3T1fv8fgoWTwuJh/L7GamgEby
	 b8OkneTI6PDBPNV607dsdx7H157TR7s3893UdXOJRdCSe8ALOwfVAVIiXhN6QWo13X
	 nJOmSZYe5Dmcw==
Subject: Re: [PATCH net-next v10 2/6] net: pcs: xpcs: add ANRESTART support
 for SGMII link recovery
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, maxime.chevallier@bootlin.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, david.wu@rock-chips.com,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 16:32:52 +0000
Message-ID: <179147717283.434549.13991419652494046497@kernel.org>
In-Reply-To: <20261005223011.1124347-3-coiaprant@gmail.com>
References: <20261005223011.1124347-3-coiaprant@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Concern: the patch goes against the phylink_pcs_ops contract.
- [Low] Race between concurrent pcs_get_state() callers.

--

net: pcs: xpcs: add ANRESTART support for SGMII link recovery

This patch sets BMCR_ANRESTART together with BMCR_ANENABLE in
xpcs_config_aneg_c37_sgmii(), and clears DW_VR_MII_AN_INTR_STS there as
well. It also restarts AN from xpcs_get_state_c37_sgmii() when the link is
down and AN completion is latched. The goal is to recover the link on
RK3568 XPCS hardware, which does not restart SGMII AN by itself after a
disconnect.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index b415b93d77c15..6466e0ff2a98b 100644
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

[Severity: Low]
This is a small question about the phylink_pcs_ops contract, not a
functional regression. The pcs_config() kernel-doc in
include/linux/phylink.h says:

 * pcs_config() will be called when configuration of the PCS is required
 * or when the advertisement is possibly updated. It must not unnecessarily
 * disrupt an established link.

As far as I can tell, the existing code earlier in
xpcs_config_aneg_c37_sgmii() already clears BMCR_ANENABLE and sets it again
on every in-band call, and that alone restarts CL37 AN:

	if (mdio_ctrl & BMCR_ANENABLE) {
		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
				 mdio_ctrl & ~BMCR_ANENABLE);

Returning a positive value from pcs_config() to request a restart is also
not an option for SGMII. phylink_pcs_an_restart() only calls
pcs_an_restart() when phy_interface_mode_is_8023z() is true.

So the added BMCR_ANRESTART should not disrupt an established link any more
than before. Is the extra bit expected to have an effect beyond the
existing ANENABLE toggle on RK3568? If so, would it help to say so in the
comment above?

>
>  	return ret;
>  }
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

[Severity: Low]
Can two pcs_get_state() callers running at the same time race on this
sequence?

xpcs_get_state_c37_sgmii() reads DW_VR_MII_AN_INTR_STS to compute
an_complete. It then clears the register and sets BMCR_ANRESTART, each in
its own MDIO transaction. The MDIO bus lock only covers one access at a
time.

Nothing serialises the callers against each other:

  phylink_resolve() -> phylink_mac_pcs_get_state()
    holds pl->state_mutex but not RTNL

  phylink_ethtool_ksettings_get() -> phylink_mac_pcs_get_state()
    holds only RTNL (MLO_AN_INBAND with no pl->phydev)

  phylink_mii_ioctl() -> phylink_mii_read() -> phylink_mac_pcs_get_state()
    holds only RTNL

One possible interleaving:

ethtool path                            phylink_resolve()
xpcs_get_state_c37_sgmii()
  read AN_INTR_STS: ANCMPLT, no link
  <delayed>
                                        xpcs_get_state_c37_sgmii()
                                          read AN_INTR_STS: ANCMPLT
                                          write AN_INTR_STS = 0
                                          set BMCR_ANRESTART
                                        new AN completes, link up
  write AN_INTR_STS = 0
  set BMCR_ANRESTART

Here, would the late write from the ethtool path discard the newly latched
ANCMPLT? Would its ANRESTART then abort the negotiation that just
succeeded?

The same interleaving looks possible against xpcs_config_aneg_c37_sgmii().
That function now also clears DW_VR_MII_AN_INTR_STS and sets
BMCR_ANENABLE | BMCR_ANRESTART while holding only state_mutex.

The commit message says:

    The latch is cleared before issuing the restart, not after: clearing it
    afterwards would discard a freshly latched ANCMPLT from the new
    negotiation.

Doesn't that reasoning assume a single caller? Before this patch, the clear
in get_state was not followed by a restart, so this race had no visible
effect.

With the restart, the result would be a spurious AN restart. That can delay
link-up, or briefly flap a link that was just reported up, until the next
negotiation completes.

>
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005223011.1124347-1-coiaprant%40gmail.com
