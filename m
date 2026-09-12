Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA583CA4AD;
	Sat, 12 Sep 2026 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244012; cv=none; b=gcNL/UO/bxteLODemxDTHvIsFM2E+icvViFiMDcsY9IVEcnxfo9sJr3vDBPXlgmGozmfndnon+lHyOPYxLmgcu9sljPJZj/97P+xsxXRFJIoPwb02E5SJyj1wh+Iv4p6spW8X2rU45p85tcWxm47f8ZBR7ke2v6w27JZcqMFafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244012; c=relaxed/simple;
	bh=H6QupJRhkEkWeclwTObc5qguppRrS3TucJ8eGNe8CH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZARKIoEkJP6tLIPcjawjhk3tu79MaTgadoQ7umjCDNAbv+0TU6CBEHwhK9p3pfsAWgSK8Q5RD4isD6M/4oum9ts/FQ6gE2xDRM7FOtNtrmkceXvKj5Fla6f0AwE8f71d+6k4juGtYzn15Db9WwsXcaR2WJgCU26ubzTSskkO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk6mlEAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk6mlEAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143511F0089A;
	Sat, 12 Sep 2026 20:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244008;
	bh=9vpbPu9jcQEsTCTK7x4pEBBMtkMi3dU8hXU1oyt9GVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rk6mlEAeaZM8mmVSYk0pcBV5CodH80Ur56P9YjthcxVPSIUrLewhHLN7mR/woE343
	 M+6B+UIKBfo+nVIdvzK74bm4ZnYYiK+gYgxzRGZC+GfQDVWTkZz9xqe9ZzrD3n7Fni
	 9sbI0wXWQJlCazp4hw8iXY3Ba5OvY353yjUVCR3rMQiyymGAKsndO3wnlZk1CLTk74
	 gULzpAvu1HpFLfvkgJQ55r9/0bV0uwBgplNcgUbvElyjxX1pGDT8ynZ3QpXY1QZwXi
	 m78Ue7X679q+qpQW7CfmDHwIyx2pF88Ac++KlhJf281tQXStKliYoQ4J4smoA7kaGB
	 K4dHtNZ7ar3+w==
From: Jakub Kicinski <kuba@kernel.org>
To: coiaprant@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	vkoul@kernel.org,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	romain.gantois@bootlin.com,
	hkallweit1@gmail.com,
	neil.armstrong@linaro.org,
	linux@armlinux.org.uk,
	shawn.lin@rock-chips.com,
	david@ixit.cz,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v4 06/10] net: pcs: xpcs: add ANRESTART support for SGMII link recovery
Date: Sat, 12 Sep 2026 13:13:27 -0700
Message-ID: <20260912201327.127042-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907153713.2572547-8-coiaprant@gmail.com>
References: <20260907153713.2572547-8-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: pcs: xpcs: add ANRESTART support for SGMII link recovery

The patch sets BMCR_ANRESTART together with BMCR_ANENABLE when configuring
C37 SGMII in-band negotiation, and clears the latched CL37 AN complete
status before doing so.  It also restarts negotiation from
xpcs_get_state_c37_sgmii() when AN completion is latched but the link is
reported down.

>     On some hardware using the DesignWare XPCS IP (e.g., RK3568 MAC side
>     SGMII), the PCS does not automatically restart auto-negotiation when the
>     link goes down and comes back up. Without an explicit ANRESTART, the link
>     stays down forever.

[Severity: Low]
The changelog describes a user visible failure ("the link stays down
forever") in long standing shared code, but there is no Fixes: tag and no
statement about which histories are affected.

The only hardware named here, RK3568 XPCS, does not exist in the baseline
tree: searching for xpcs_rk, rk3568-xpcs or pcs-xpcs-rk under drivers/net at
879e280b8486 returns nothing, and the glue driver arrives later in this
series ("net: pcs: xpcs: add Rockchip RK3568 platform glue driver").

Could the changelog either name the pre-existing commit being fixed, or say
explicitly that the affected platform is introduced later in the same
series, so that stable tooling does not have to guess?

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 0337e2bcc0125..50b9cdf94fdaa 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -816,9 +816,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
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

[Severity: Medium]
Should the comment at the top of xpcs_config_aneg_c37_sgmii() be updated
along with this change?  It still says the opposite of what the code now
does:

drivers/net/pcs/pcs-xpcs.c:xpcs_config_aneg_c37_sgmii() {
	/* For AN for C37 SGMII mode, the settings are :-
	 ...
	 * 5) VR_MII_MMD_CTRL Bit(12) [AN_ENABLE] = 1b (Enable SGMII AN)
	 *
	 * Note that VR_MII_MMD_CTRL is MII_BMCR.
	 *
	 * Note: Since it is MAC side SGMII, there is no need to set
	 *	 SR_MII_AN_ADV. ... There is also no need to
	 *	 trigger AN restart for MAC-side SGMII.
	 */

On the default path this same function selects MAC side SGMII:

	} else {
		tx_conf = DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII;
	}

so the restart is now issued for exactly the case the comment says does not
need it.  The new DW_VR_MII_AN_INTR_STS write is also a sixth step that the
enumerated sequence does not mention.

If the databook statement no longer holds for these parts, could the
comment be corrected, so that a later reader does not remove the ANRESTART
bit as a mistake?

> @@ -1093,10 +1098,15 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
>  		return 0;
>  	}
>  
> -	/* Clear AN complete status or interrupt */
> -	if (state->an_complete)
> +	if (state->an_complete) {
> +		/* Clear AN complete status or interrupt */
>  		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
>  
> +		/* Initiate the next round of AN */
> +		xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
> +			    BMCR_ANRESTART);
> +	}
> +
>  	return 0;
>  }

[Severity: Medium]
Can this sequence get stuck if the xpcs_modify() fails?

The latched status is cleared first, and DW_VR_MII_AN_STS_C37_ANCMPLT_INTR
is the only thing that brings execution back into this branch:

	state->an_complete = ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;

So if the clear succeeds but the restart does not, every later poll reads
ANCMPLT as 0, state->an_complete stays false, and the restart is never
retried, leaving the port down with AN idle until something calls
pcs_config again.

mdiodev_c45_modify() does a read followed by a write, so there are two
places it can return an error, for example a bus -ETIMEDOUT, or with the
Rockchip glue added later in this series the pm_runtime_resume_and_get()
error path in xpcs_rk_read_reg() / xpcs_rk_write_reg().

Both return values are also discarded and the function still ends with
return 0, so the diagnostic in the caller can never fire for them:

	case DW_AN_C37_SGMII:
		ret = xpcs_get_state_c37_sgmii(xpcs, state);
		if (ret)
			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
				"xpcs_get_state_c37_sgmii", ERR_PTR(ret));

Would it be better to assert BMCR_ANRESTART before clearing the latched
status, and to propagate both return codes to xpcs_get_state()?
