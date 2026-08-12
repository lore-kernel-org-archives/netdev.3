Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B487371D01
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499676; cv=none; b=dMoSq9QHnhGN/CotAPWZGJkzbfAr8XAhrpu1qqcX5AvABuNqrTGF0guttvH8Qsdpyq6OqRnp6OaXLVhPSlW5dJGi++0+pZdsZL/9Q0fkTg81WKHpFe0NSrfvHHeCMj4Yvv00VwjDIX7kWEhc+lI5DsiARw9MH97Kt/5HgUEuZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499676; c=relaxed/simple;
	bh=/qxW5CqpBbC2T8jkNTqbKvDqzXVUFoXCNz6MqiHCaYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYccpS5GM71AcY2mvC2c9IOwCFlfWXEpOXMmUpZQE1sO0voRz1cCW+E9TZoQTXLvWP7/+ToCyQ8N9eY7Yqa133RR6ckRdMgQv/Mc3OjOZHme839qF5Tqa1WKVsaa10VBGODl8W+ALaSGv430xu6pvxs/WvYkFjee3En32zneNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzWYtPW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzWYtPW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15261F000E9;
	Wed, 12 Aug 2026 01:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786499675;
	bh=QYpurIdR8EMwlB9YoTx/MMgHHyEnSljqX6b9uD6YZHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzWYtPW9m3zdXDq9+KvIvWc5zFRctn1gFLWDiEoxyEE8sZW6dmkjMe+MNz/gZK9hS
	 V9IAaU7CPleexhW5FouJyD1KdG5lgZmQp2a63y2OXBlokBgn17rtbslwFB8CeyBOeD
	 1nZTvHfCtNOzgDBVfxhwqu1kypYJCqKJqfAxMh5+goVMqZGvoXGpptX9itCdu1EuM+
	 xoEcYbeo3ge1z1dopDlR/Kv9l6W8I+w9h7hZU3MROeJ6JAPuF5yU2MhHCRKCbov4gh
	 RxYLaCBQ+osGPHfJ7RW6nZ7sJlkQMySwBN3fiStur4hfaIxAqW31wFl2sp51rWulYw
	 zcpFqsGAp3atA==
From: Jakub Kicinski <kuba@kernel.org>
To: nwhitehorn@pa.msu.edu
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch
Subject: Re: [PATCH net-next v4 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS
Date: Tue, 11 Aug 2026 18:54:34 -0700
Message-ID: <20260812015434.1687294-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807201741.3275-3-nwhitehorn@pa.msu.edu>
References: <20260807201741.3275-3-nwhitehorn@pa.msu.edu>
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
net: macb: add support for 1000BASE-X autonegotiation to PCS

This decouples PCS enablement from SGMII mode selection so the macb PCS
can also be used in 1000BASE-X mode, advertises 1000BASE-X to phylink,
and adds an autonegotiation restart implementation for the PCS.

A few questions on the changes below.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index c15a9c7e69d3..2252e6a55072 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -583,7 +583,12 @@ static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>  
>  static void macb_pcs_an_restart(struct phylink_pcs *pcs)
>  {
> -	/* Not supported */
> +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
> +	u32 old, new;
> +
> +	old = gem_readl(bp, PCSCNTRL);
> +	new = old | BMCR_ANRESTART;
> +	gem_writel(bp, PCSCNTRL, new);
>  }
>  
>  static int macb_pcs_config(struct phylink_pcs *pcs,
> @@ -609,8 +614,10 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
>  		new = old | BMCR_ANENABLE;
>  	else
>  		new = old & ~BMCR_ANENABLE;
> -	if (old != new)
> +	if (old != new) {
>  		gem_writel(bp, PCSCNTRL, new);
> +		return 1;
> +	}
>  
>  	return 0;
>  }

[Severity: Medium]
Is the positive return here attached to the right register write?  The
kernel-doc for .pcs_config() in include/linux/phylink.h says:

  * When an autonegotiation restart is required for 802.3z modes, .pcs_config()
  * should return a positive non-zero integer (e.g. 1) to indicate to phylink
  * to call the pcs_an_restart() method.

and phylink_mii_c22_pcs_config() derives that value from the advertisement
write, not from the BMCR autonegotiation-enable write:

	ret = mdiobus_modify_changed(pcs->bus, pcs->addr,
				     MII_ADVERTISE, 0xffff, adv);
	if (ret < 0)
		return ret;
	changed = ret;

In macb_pcs_config() the earlier PCSANADV (clause 37 base page) write result
is discarded:

	old = gem_readl(bp, PCSANADV);
	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
	if (new != -EINVAL && old != new)
		gem_writel(bp, PCSANADV, new);

and 1 is returned only when the BMCR_ANENABLE bit in PCSCNTRL toggles.

Does that mean an advertisement-only change never restarts autonegotiation?
On an established in-band 1000BASE-X link, ethtool -A or ethtool -s ...
advertise ... reaches phylink_change_inband_advert(), whose only trigger for
the restart is the positive return:

	ret = phylink_pcs_config(pl->pcs, pl->pcs_neg_mode, &pl->link_config,
				 !!(pl->link_config.pause & MLO_PAUSE_AN));
	if (ret < 0)
		return ret;

	if (ret > 0)
		phylink_pcs_an_restart(pl);

Since PCSAUTONEG is on out of reset and phylink keeps it on for in-band mode
(default_an_inband is set in macb_mii_probe()), PCSCNTRL is unchanged, 0 is
returned, and the freshly written base page is never put on the wire until a
link bounce or a larger reconfiguration.  The newly added
macb_pcs_an_restart() would then not be reached for the advertisement case
the ops contract describes, while the case that does return 1 (the
autonegotiation enable/disable toggle) is not the case a restart is asked
for.

Would recording a changed flag in the PCSANADV branch and returning that,
as phylink_mii_c22_pcs_config() does, be more in line with the contract?

Also, could the commit message mention the change of pcs_config() return
semantics?

[ ... ]

> @@ -957,7 +966,8 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
>  
>  	if (interface == PHY_INTERFACE_MODE_10GBASER)
>  		return &bp->phylink_usx_pcs;
> -	else if (interface == PHY_INTERFACE_MODE_SGMII)
> +	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
> +	         interface == PHY_INTERFACE_MODE_SGMII)
                 ^^^^^^^^^

[Severity: Low]
This isn't a bug, but the continuation line in macb_mac_select_pcs() is
indented with a tab followed by spaces, which checkpatch.pl flags as "code
indent should use tabs where possible".

>  		return &bp->phylink_sgmii_pcs;
>  	else
>  		return NULL;

[ ... ]

> @@ -1061,9 +1072,12 @@ static int macb_mii_probe(struct net_device *dev)
>  			  bp->phylink_config.supported_interfaces);
>  		phy_interface_set_rgmii(bp->phylink_config.supported_interfaces);
>  
> -		if (bp->caps & MACB_CAPS_PCS)
> +		if (bp->caps & MACB_CAPS_PCS) {
> +			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +				  bp->phylink_config.supported_interfaces);
>  			__set_bit(PHY_INTERFACE_MODE_SGMII,
>  				  bp->phylink_config.supported_interfaces);
> +		}
>  
>  		if (bp->caps & MACB_CAPS_HIGH_SPEED) {
>  			__set_bit(PHY_INTERFACE_MODE_10GBASER,
> @@ -4932,7 +4946,9 @@ static int macb_init_dflt(struct platform_device *pdev)
>  	/* Set MII management clock divider */
>  	val = macb_mdc_clk_div(bp);
>  	val |= macb_dbw(bp);
> -	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
> +	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
> +		val |= GEM_BIT(PCSSEL);
> +	else if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
>  		val |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
>  	macb_writel(bp, NCFGR, val);

[Severity: Medium]
Does the serdes get brought up when phy-mode is "1000base-x"?
init_reset_optional() still gates the serdes and ZynqMP GEM power-management
setup on SGMII only:

	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
		/* Ensure PHY device used in SGMII mode is ready */
		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
		...
			ret = zynqmp_pm_set_gem_config(pm_info[1], GEM_CONFIG_SGMII_MODE, 1);

With phy-mode = "1000base-x" on a part with MACB_CAPS_PCS that uses
init_reset_optional(), bp->phy stays NULL, so the later
phy_set_mode_ext(bp->phy, ...) and phy_power_on(bp->phy) calls in
macb_open() are no-ops, while macb_init_dflt() and macb_mac_config() still
set GEM_BIT(PCSSEL) and macb_mii_probe() advertises 1000BASE-X.  Would that
leave the interface up with an unconfigured, unpowered serdes and no
diagnostic?

I could not determine from the tree whether the GT serdes and the
GEM_CONFIG_SGMII_MODE firmware call are strictly required for 1000BASE-X on
those parts, so this may be fine on the affected hardware.  Should
init_reset_optional() cover PHY_INTERFACE_MODE_1000BASEX as well, for
consistency with the four sites updated here?
