Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B435379EE0;
	Fri, 25 Sep 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301825; cv=none; b=Cy3m3o30KUe+TRCZp96/j/Tp+eje7KqV1p+rRCM5/yE5X+bfRy1eDEBBC5Tr76no5XvyYcOeVIKSWGddDxCOsOcAtvBDR8ZfznHSdmIRpBh3mJb4itR9fCkTJts9ewmt8VHFNL4xwiywCr3cYoyqx94ktstuduEMYCOZctiswto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301825; c=relaxed/simple;
	bh=L2jxpd4KORfYSgHvdRV9xKv/h+duqG6ooiSRyMSynYY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8sSzzCrc7sDs3LlUZAqNUr4wEsQId45rx6lQLhuJYELfD56tT+f8Nkgbrf8IMJcOP0PUJEL+MgLfSHYIYoAZsKOM1STgHcqwxaPDJyz4OmUFtAGZpSeGFOaxc/mp5hSXX8ryrvUQNp6zg79PFAUJ26sy81+sxVa82OiPR8M2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2eYEdLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2eYEdLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F111F00898;
	Fri, 25 Sep 2026 02:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301823;
	bh=Onm061uyZBZ6jk/XlnSGK29UlUQPLuEGtTxsmYUpuT8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M2eYEdLuUcb+C96LVFVRHO6lU0WuUABDd/6eda+sMlv6S2mdAbIP8kJMRY7+v9veI
	 sKQzI7EWmlp44LMD42zzzCf1bb08l6EedRWjeRtJaVRP2m8UMZcVn+hMQVv33TciGy
	 9ajXZFWVbTBZTB/0MlXlcD2rhyU2ojVJHt8Y/Z0yf5IZRWl6yPxZIOklYDJkZuUHdJ
	 UJCZT//s2z8uwqrMVS4sfC9BruK0m8CIhokBqPAy1TJueKBaAOf0nch+S0vHG8zq6B
	 Vwgevm3DTWEzpE9EsnDwgF7GjnKkEkAcBaPSnp1twV2kAe+inoN1F4C97bVp34drRF
	 C19YS3EzQpSFw==
Subject: Re: [PATCH net-next v10 06/11] net: pcs: xpcs: add ANRESTART support
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
 linux-renesas-soc@vger.kernel.org
Date: Fri, 25 Sep 2026 02:03:41 +0000
Message-ID: <179030182177.2160803.5520238845817839542@kernel.org>
In-Reply-To: <20260922200336.2201212-7-coiaprant@gmail.com>
References: <20260922200336.2201212-7-coiaprant@gmail.com>
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

- [Medium] In xpcs_get_state_c37_sgmii() (drivers/net/pcs/pcs-
  xpcs.c:1110-1121) the ANCMPLT latch is cleared first…
- [Medium] xpcs_get_state_c37_sgmii() now mutates PCS hardware state
  (write-0-to-clear of DW_VR_MII_AN_INTR_STS and the BMCR_ANRESTART…

--

net: pcs: xpcs: add ANRESTART support for SGMII link recovery

This adds BMCR_ANRESTART to the C37 SGMII paths: xpcs_config_aneg_c37_sgmii()
now clears DW_VR_MII_AN_INTR_STS and sets ANRESTART together with ANENABLE,
and xpcs_get_state_c37_sgmii() clears the AN latch and issues an AN restart
when the link is down but AN completion was latched.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 0337e2bcc0125..8c3875b6985b9 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c

[ ... ]

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
Can this ordering leave the restart permanently disarmed if the xpcs_modify()
fails?

The latched ANCMPLT bit is the only piece of hardware state this code uses to
decide that a restart is needed, and it is destroyed before the restart is
actually requested.  xpcs_modify() is a real read-modify-write:

xpcs_modify() -> mdiodev_c45_modify() -> mdiobus_c45_modify() ->
__mdiobus_c45_modify_changed()

and that last function returns the read error before issuing any write:

drivers/net/phy/mdio_bus.c:__mdiobus_c45_modify_changed() {
	...
	ret = __mdiobus_c45_read(bus, addr, devad, regnum);
	if (ret < 0)
		return ret;
	...
}

So on a transient register read error the PCS stays AN-complete and link-down
with no negotiation started, while the latch that would have re-triggered this
branch has already been cleared.  Every later poll then sees an_complete == 0
and never re-enters the branch, which is the "link stays down forever" case the
commit message describes.

The commit message says:

	"If an MDIO access fails at this point, it indicates an
	 unrecoverable hardware condition until reset."

Where does that reset happen?  .pcs_get_state is void, and the caller only
logs the value:

drivers/net/pcs/pcs-xpcs.c:xpcs_get_state() {
	...
	case DW_AN_C37_SGMII:
		ret = xpcs_get_state_c37_sgmii(xpcs, state);
		if (ret)
			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
				"xpcs_get_state_c37_sgmii", ERR_PTR(ret));
		break;
	...
}

Nothing sets xpcs->need_reset, resets the PCS or re-arms the restart, so
recovery seems to require an administrative down/up to re-run
xpcs_config_aneg_c37_sgmii().  Would it be safer to issue the ANRESTART first
and only clear the latch once the restart write succeeded, or to set
xpcs->need_reset on failure?

[Severity: Medium]
What serializes this new register write against a concurrent
.pcs_get_state call?

phylink reaches this callback from two paths that share no lock:

drivers/net/phy/phylink.c:phylink_resolve() {
	mutex_lock(&pl->state_mutex);
	...
		phylink_mac_pcs_get_state(pl, &link_state);
	...
}

drivers/net/phy/phylink.c:phylink_ethtool_ksettings_get() {
	ASSERT_RTNL();
	...
		phylink_mac_pcs_get_state(pl, &link_state);
	...
}

phylink_mii_read() via phylink_mii_ioctl() is in the same ASSERT_RTNL()-only
category.  struct dw_xpcs in drivers/net/pcs/pcs-xpcs.h has no lock of its own,
and the MDIO bus mutex only makes each individual transaction atomic, not the
read of DW_VR_MII_AN_INTR_STS followed by the clear and the ANRESTART.

So can an unprivileged ETHTOOL_GLINKSETTINGS query (or SIOCGMIIREG) racing with
phylink_resolve() clear a latch belonging to a negotiation the other caller just
started, and then issue a second BMCR_ANRESTART that aborts that in-flight
negotiation?

Even without a race, the read of DW_VR_MII_AN_INTR_STS and the subsequent blind
write of 0 are not atomic with respect to the hardware latch, so is an AN
completion latched between those two accesses silently dropped?

Before this patch the callback only cleared the latch, so the state-changing
write is new here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922200336.2201212-1-coiaprant%40gmail.com
