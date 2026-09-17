Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4034D17A2;
	Thu, 17 Sep 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670299; cv=none; b=NOYD9HcctPeBLC6tllWGNQpYVbZppneLAQ+8I/q2Q7yHWye6O5HYBJNdzob+QyQvEvoBM54yM17B0dgFiKxYSiWArApOz51TzuRT8MPSzQCSb2bLpua8kbFzW+5z3VevnFu1vSD8mv/Eo+Ayh3EgxbmaECoHFoe/8zDgnUh7gIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670299; c=relaxed/simple;
	bh=yr7AIPhgcB6C1r/uWMJ1QqNFi4/qtjJRl94HVsqHz2I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3+38+1cIMAgzZhZmx1h/FlZTZr1WCj3eBG8MVGxszlgsI6iIZ128DosU/HiyQRarDeLa+LIL9j7R7Pif4mGFYw0/gh3CypE9Y97cfzYstJqfvwAtN6cENAkiwoR9kTXUHeW9LLrz6t4oMk95iEKfJRl1A5evKYauIduf/z3e3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGYuVqZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGYuVqZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA1B1F00898;
	Thu, 17 Sep 2026 18:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670297;
	bh=bmXke02eLyEimoYDRxYaM6VBAAJN5fHFcFdIdY6gQrE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LGYuVqZC5ogJZ83YyAvhfE5/mqHlHm0rxYMLNccSRrcFH+M0Qa6TmluiEyC8QIJXo
	 mxxZxpt5ZmTAIReuVKatcFZLVojg2KDKAjUWTJCh7wUjbCW5kNQdg2VM9Vvx7ITf3o
	 whlktWKC/EYNU7Maahh1/YqqYyaiRCLrq3ri/EeshROKfibZczFe2E5NrHuut6jQRV
	 us9hs0KZw0+jrsgQw9c36WI8TUL4soTukwXONv/a8xmjx+bucmI6AePVxs/pl5Mm7f
	 UGJJR6PPuTSUKU6hmWMnkbErtGyJR7SwvhgigkeYvCKI3fzSBigIUMJu0M/1uXLCjD
	 bzuHQQK1oiYlQ==
Subject: Re: [PATCH net-next v6 06/11] net: pcs: xpcs: add ANRESTART support
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
Date: Thu, 17 Sep 2026 18:38:15 +0000
Message-ID: <178967029584.22033.13072734956170022047@kernel.org>
In-Reply-To: <20260915123802.1561724-7-coiaprant@gmail.com>
References: <20260915123802.1561724-7-coiaprant@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] In xpcs_get_state_c37_sgmii() (drivers/net/pcs/pcs-
  xpcs.c:1110-1121) the AN-complete latch is destroyed before the…
- [Medium] The patch turns the pcs_get_state callback into a writer of
  MII_BMCR without any serialization.

--

net: pcs: xpcs: add ANRESTART support for SGMII link recovery

This adds an explicit BMCR_ANRESTART when starting C37 SGMII
auto-negotiation, and also clears DW_VR_MII_AN_INTR_STS plus triggers an
AN restart from the link status path when the link is down but AN
completion is latched.  The stated motivation is RK3568 MAC side SGMII,
which does not re-arm AN by itself after a link drop.

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

[Severity: Medium]
Can the link stay down permanently here if the restart below fails?

The only condition that lets xpcs_get_state_c37_sgmii() enter this branch is
the latched AN complete bit:

	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS);
	...
	state->an_complete = ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;

The latch is destroyed by the write above before the restart is attempted.

The restart itself can fail before touching the hardware, because
xpcs_modify() -> mdiodev_c45_modify() -> __mdiobus_c45_modify_changed() does
a read first and bails out on a read error:

	ret = __mdiobus_c45_read(bus, addr, devad, regnum);
	if (ret < 0)
		return ret;

So on a transient bus or CSR access error the sequence is: latch cleared,
restart never issued.  On the next poll DW_VR_MII_AN_STS_C37_ANCMPLT_INTR
reads as 0, state->an_complete is false, and this branch is not re-entered.

xpcs_get_state() can only log the error, since the phylink pcs_get_state op
returns void:

	if (ret)
		dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
			"xpcs_get_state_c37_sgmii", ERR_PTR(ret));

No pending-restart state is recorded, and phylink_resolve() will not re-run
pcs_config() while the interface is unchanged.  Given the premise of this
patch, that this hardware does not restart AN on its own, would it be better
to issue the ANRESTART before clearing the latch, or to leave the latch
intact (or set a pending-restart flag) when the restart fails so later polls
retry?

> +		/* Initiate the next round of AN */
> +		ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
> +				  BMCR_ANRESTART);
> +		if (ret < 0)
> +			return ret;
> +	}

[Severity: Medium]
Is the pcs_get_state callback allowed to write MII_BMCR without any
serialization against pcs_config?

phylink reaches pcs_get_state from paths with disjoint locks.
phylink_resolve() calls phylink_mac_pcs_get_state() while holding
pl->state_mutex and not RTNL, and in the same section can call
phylink_major_config() -> phylink_pcs_config() -> xpcs_config_aneg_c37_sgmii():

drivers/net/phy/phylink.c:phylink_resolve() {
	mutex_lock(&pl->state_mutex);
	...
		phylink_mac_pcs_get_state(pl, &link_state);
	...
			phylink_major_config(pl, false, &link_state);
}

While phylink_ethtool_ksettings_get() and phylink_mii_read() reach it with
RTNL only and no state_mutex:

drivers/net/phy/phylink.c:phylink_ethtool_ksettings_get() {
	case MLO_AN_INBAND:
		if (pl->phydev)
			break;

		phylink_mac_pcs_get_state(pl, &link_state);
}

struct dw_xpcs has no mutex or spinlock, and mdiodev_c45_modify() only makes
a single register read-modify-write atomic on the bus, so can one CPU be
part-way through the multi-register sequence in xpcs_config_aneg_c37_sgmii():

	mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
	...
		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
				 mdio_ctrl & ~BMCR_ANENABLE);
	/* reprogram DW_VR_MII_AN_CTRL, DW_VR_MII_DIG_CTRL1, clear AN_INTR_STS */
	...
		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
				 mdio_ctrl | BMCR_ANENABLE | BMCR_ANRESTART);

while the other CPU, in the ethtool or ioctl query path, clears
DW_VR_MII_AN_INTR_STS and sets BMCR_ANRESTART?  That would kick the AN state
machine while PCS_MODE/TX_CONFIG are half reprogrammed and AN is
deliberately disabled.

A second variant: both paths read link-down plus AN-complete, and the one
that was descheduled then issues ANRESTART from a stale snapshot, restarting
negotiation on a link that has meanwhile come back up.

The driver already exposes .pcs_an_restart = xpcs_an_restart(), which phylink
calls under state_mutex:

	xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
		    BMCR_ANRESTART);

Could the restart be driven through that callback instead of open-coding the
same register write in the status path?

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915123802.1561724-1-coiaprant%40gmail.com
