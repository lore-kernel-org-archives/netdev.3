Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E9B3D8127;
	Mon, 12 Oct 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833750; cv=none; b=HwEC286YOIG4Etk9x5XSrwK53nnXwCAdWkgVvJdxkAuOqW0dxe4rkq76hV0T8SkaRfsFGwklw0bgcAkeas1eopYqMFPq0CjMq8IVqQ72CMvPYcDb/0blnGE+OPmVl45BZfscL6SI8OJzadQw9qs1nk8K9Hqg/5CPqWouAsxwx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833750; c=relaxed/simple;
	bh=R8q/CVxg39d4TdckOQsEKL3d35bhQoZkiqJfYJn/BUU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ls1IDfjvQeaWClbcEEtk+bhev2AX8ORPanXV3d90i0yZHYGNMGs5tzsyUfsJgN/I7J/P/ycZNelQPzvX2UT/mQMIRHEKEEe4GTpcT498AfONMY8kVuI3eKy6i1Jdn+V1ND72LsE8V0AbpX8Lzg+rZx4FJtUU/FyEgpF3CW8pXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDPEdGXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDPEdGXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A5B1F0089B;
	Mon, 12 Oct 2026 19:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791833749;
	bh=DMKUIq2evMqbV9iZZVZrgW3vUtUC3TC5DJ5ooCvuKew=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RDPEdGXeei8e7Azd26bOsJ2oUy+7x3jjeWxt+KQYGWn50Q6CxGnSmhPauR7UuBv5h
	 kzrPs3FA/0MSVBUun25XjPgG29jUjNZhK3nw2PHbop6V4Vjt4K6ljIMEjguYyh8CFa
	 u3F/MeKcOnbK3u6JW3Pg24JgRS3l8KE0XcJt77HGvWf5l+oOgrg0Qn25N5WLgP7v1G
	 fxi9gN95EOoefQ4Ft99HnIvrb0A+r9DCJQI8CBUXkrXvxCkf9RDam3pGmnGJxDMX3L
	 fhWkdZlIa92vTnLPS0pKeOjRZVOk/HCrUwK7cric+t5GF+nE9nIBinsRX7xwvnG901
	 T3NQnrLTyFD3w==
Subject:
 Re: [PATCH net v4] net: phy: qca83xx: read resolved QCA8337 link status
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 19:35:48 +0000
Message-ID: <179183374827.434549.12054936309141943394@kernel.org>
In-Reply-To: <20261008193515.14880-1-yongzhao.derek@gmail.com>
References: <20261008193515.14880-1-yongzhao.derek@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix covers only the QCA8337 entry of qca83xx_driver[] in
  drivers/net/phy/qcom/qca83xx.c.
- [Low] In qca8337_read_status() (drivers/net/phy/qcom/qca83xx.c), the
  link is forced down when at803x_read_specific_status() leaves speed or…

--

net: phy: qca83xx: read resolved QCA8337 link status

This adds a read_status callback for the QCA8337 internal PHY. It wraps
genphy_read_status() and, when an autonegotiated link comes up, replaces
speed and duplex with the values from at803x_read_specific_status(). It
also reports the link as down until the PHY-specific status says it is
resolved.

> diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
> index bc70ed8efd86a..be00bc7cda0b9 100644
> --- a/drivers/net/phy/qcom/qca83xx.c
> +++ b/drivers/net/phy/qcom/qca83xx.c
> @@ -92,6 +92,58 @@ static int qca83xx_probe(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int qca8337_read_status(struct phy_device *phydev)
> +{

[ ... ]

> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete &&
> +	    phydev->link) {
> +		phydev->speed = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		phydev->pause = false;
> +		phydev->asym_pause = false;
> +
> +		ret = at803x_read_specific_status(phydev, ss_mask);
> +		if (ret)
> +			return ret;
> +
> +		/* Report the link down until speed and duplex are resolved,
> +		 * so that the next poll reads them again.
> +		 */
> +		if (phydev->speed == SPEED_UNKNOWN ||
> +		    phydev->duplex == DUPLEX_UNKNOWN) {
> +			phydev->link = 0;
> +			phydev->mdix = ETH_TP_MDI_INVALID;

[Severity: Low]
Should more of the link-up state be cleared here?

By the time qca8337_read_status() forces link to 0, genphy_read_status()
has already run with link=1 and autoneg_complete=1. That means:

  genphy_read_master_slave() has set master_slave_state to MASTER or SLAVE
  genphy_read_lpa() has filled lp_advertising

There is also the case where the 2-bit speed field holds the reserved
value 3. There, at803x_read_specific_status() leaves speed as
SPEED_UNKNOWN but still sets duplex to DUPLEX_FULL or DUPLEX_HALF.

Only link and mdix are reset. Until the next poll, could ethtool report
"Link detected: no" together with a master/slave state, a link partner
advertisement and possibly a concrete duplex?

The commit message names marvell_read_status_page_an() as the model. Its
caller, marvell_read_status_page(), clears lp_advertising first:

drivers/net/phy/marvell.c:marvell_read_status_page() {
    ...
	linkmode_zero(phydev->lp_advertising);
	phydev->pause = 0;
	phydev->asym_pause = 0;
	phydev->speed = SPEED_UNKNOWN;
	phydev->duplex = DUPLEX_UNKNOWN;
    ...
}

The PHY_HALTED path in _phy_state_machine() also resets
master_slave_state, mdix and lp_advertising together when it forces the
link down.

> +		} else {
> +			phy_resolve_aneg_pause(phydev);
> +		}
> +	}

[ ... ]

> @@ -220,6 +272,7 @@ static struct phy_driver qca83xx_driver[] = {
>  	.flags			= PHY_IS_INTERNAL,
>  	.config_init		= qca83xx_config_init,
>  	.soft_reset		= genphy_soft_reset,
> +	.read_status		= qca8337_read_status,

[Severity: Medium]
Does the QCA8327 internal PHY need the same fix?

In the same qca83xx_driver[] table, the QCA8327-A and QCA8327-B entries
still have no .read_status, so phylib uses genphy_read_status() for them.

If those PHYs can also do a SmartSpeed downshift, the same path would
report 1000 Mbit/s while the PHY runs at 100 Mbit/s:

genphy_read_status()
  phy_resolve_aneg_linkmode()     picks 1000
phylink
  qca8k_phylink_mac_link_up()
    case SPEED_1000:
        reg = QCA8K_PORT_STATUS_SPEED_1000;

The Fixes: commit (the qca8k switch to phylink) covers every qca8k
switch, not only QCA8337.

On QCA8327 the wrong speed has a second user.
qca83xx_link_change_notify() only applies the 100M DAC amplitude
adjustment when phydev->speed is SPEED_100:

drivers/net/phy/qcom/qca83xx.c:qca83xx_link_change_notify() {
	if (phydev->state == PHY_RUNNING) {
		if (phydev->speed == SPEED_100)
			at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
					      QCA8327_DEBUG_MANU_CTRL_EN,
					      QCA8327_DEBUG_MANU_CTRL_EN);
    ...
}

If the link is misreported as 1000, would that adjustment be skipped?

The commit message does not mention QCA8327. Could it say whether these
PHYs can downshift, or why they were left out?

>  	.get_sset_count		= qca83xx_get_sset_count,
>  	.get_strings		= qca83xx_get_strings,
>  	.get_stats		= qca83xx_get_stats,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008193515.14880-1-yongzhao.derek%40gmail.com
