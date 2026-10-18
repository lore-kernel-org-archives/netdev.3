Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD93537D2;
	Sun, 18 Oct 2026 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792305930; cv=none; b=JNy1y5UPUlsyapPHXJ8zbeMURzbAnooOrFwFSmK2/Sg2pnA4wuke8Z2n9Mp4wJgZAWxNfyLBN4xt8KkC9Pdvcz6A6egf//Emqm/vPrBSOfedtYcekO/57vtUfx3uWPP1osYF+aEljLv1OFbT512+vnFvfT65P/9MkjwYANHid44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792305930; c=relaxed/simple;
	bh=pODsZdTPXyYXjENjz4LTJ9QnCptMw/8sH91qooE0a0o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5SeaLmas6oHfgqxjp2V+yi+iZNg/cvnEjz4KIJd1PLrRDdF2uk0em6SiE4FReSeVNMy9/QTyDNw6z0PmGn120YDgAnsFwtBMprYld1LYtl78E/nre+QQoDT3IbTR0409sXa2yQXpo1ejqgpdC4oVpUMvziqI2YVCN5YWrUym54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1d6mYdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1d6mYdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C781F000C4;
	Sun, 18 Oct 2026 06:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792305928;
	bh=GmrzgKuxZvWAxQ2tnujHlgWERhtGHR5yo6rInNCm21o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g1d6mYdEYS97TBYvK7eQHXHGgzLs+KxzxHuk5iKkkjJ/GTCq0odOJzSVH+X/ykvkD
	 yVcQqZ4Yre6GfADEMX/WVtSnyKAYLO1RIPFWr6qVdF34RC6qA6Df1s2F81ImJLrOgT
	 iDCFwv0khYsGH1DWZNX/X8KOcQVF7z+rDmYh/5RMUVxaeK/Mqvgpd6APyAkcctCAk1
	 A3I4m0RwEb5wNxN95cxidm3nQOGPZGWBHQtyI3onaWzTM96ulhbk9udk2RvYQiGWTv
	 mtmg5rNjDIif+ZJYDEZ7Vl5jr5n2zNBL6fQkx/SksxrnRJDP0dSUByDnFoTAkTQT+r
	 GADRjPZvBtTlw==
Subject: Re: [PATCH net-next v12 1/6] net: pcs: xpcs: add ANRESTART support
 for SGMII link recovery
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 david.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 06:45:26 +0000
Message-ID: <179230592697.3135.6932872951523750096@kernel.org>
In-Reply-To: <20261017054406.1828061-2-coiaprant@gmail.com>
References: <20261017054406.1828061-2-coiaprant@gmail.com>
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

- [Low] In xpcs_get_state_c37_sgmii() (drivers/net/pcs/pcs-xpcs.c lines
  1110-1121), the ANCMPLT latch is cleared with…

--

net: pcs: xpcs: add ANRESTART support for SGMII link recovery

This commit sets BMCR_ANRESTART along with BMCR_ANENABLE in
xpcs_config_aneg_c37_sgmii() and clears DW_VR_MII_AN_INTR_STS before
starting AN. It also makes xpcs_get_state_c37_sgmii() clear the ANCMPLT
latch and trigger an AN restart when the link is down and AN complete is
latched. This works around RK3568 XPCS, which does not restart AN on its
own.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index b415b93d77c15..6466e0ff2a98b 100644
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

[Severity: Low]
What happens if the DW_VR_MII_AN_INTR_STS write succeeds but the
xpcs_modify() of MII_BMCR fails?

At that point the ANCMPLT latch is already cleared. If the read fails,
__mdiobus_c45_modify_changed() returns without writing anything:

drivers/net/phy/mdio_bus.c:__mdiobus_c45_modify_changed() {
    ...
	ret = __mdiobus_c45_read(bus, addr, devad, regnum);
	if (ret < 0)
		return ret;
    ...
}

On hardware that needs this workaround, the latched ANCMPLT seems to be
the only thing that triggers the restart. Later calls to
xpcs_get_state_c37_sgmii() would see the link down with no ANCMPLT, so
the restart would never be retried.

xpcs_get_state() only logs the error:

	case DW_AN_C37_SGMII:
		ret = xpcs_get_state_c37_sgmii(xpcs, state);
		if (ret)
			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
				"xpcs_get_state_c37_sgmii", ERR_PTR(ret));
		break;

phylink_resolve() only reconfigures the PCS when the interface changes
or force_major_config is set:

	if ((mac_config && link_state.interface != pl->link_config.interface) ||
	    pl->force_major_config) {

Would the link then stay down until pcs_config runs again, for example
after an interface down/up?

The commit message says:

    If an MDIO access fails at this point, it indicates an
    unrecoverable hardware condition until reset.

Does that hold for RK3568? In the later patch "net: pcs: xpcs: add
Rockchip RK3568 platform glue driver", xpcs_rk_read_reg() and
xpcs_rk_write_reg() appear to fail only through
pm_runtime_resume_and_get(). A failed runtime resume callback does not
set the sticky power.runtime_error, so the failure could be transient
rather than permanent.

> +	}
>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017054406.1828061-1-coiaprant%40gmail.com
