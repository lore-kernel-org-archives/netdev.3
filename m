Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071148DB21;
	Mon, 19 Oct 2026 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394837; cv=none; b=JGpqrwTRC35BSdFbQUJytOSRUWZNgbLdibV/Y5DWSo7f2SajLNZJotIHqrcO4k+aV4Essi2HpUZpX7BlDVCmVXEa3MsydDeM2GeIeCq9dmJkQz40amKMrmiWGTNPLnc17cISkOEXpH2AHK77PBv3OgaKiEx2xrtRpRt1HchCf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394837; c=relaxed/simple;
	bh=S96ESlRlb/3Q/5kQGwrxP09f2vEb8IHYk2k9L9JwXJE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gy7amtJdDKmg3z64RDpOp0db1/Yh3Gb4PGVtKzyrMO5s7ik4qmYIKMZQhrs4ZGJpDRnkgGlr0IPQosqVOmlenQCzHjIb+f8PQRq8MsER+4mKoDbNo9Pin252Yi3WTw0A55XhEM0e9XatstreIYWtr7h7hDGJ+KSu0kWVU8Y3joc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmWNjKWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmWNjKWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90C81F000C4;
	Mon, 19 Oct 2026 07:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394835;
	bh=5NaDqhThLEH8QW2uNs+kUXpY3WKRDv1cM3Y08+E496c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WmWNjKWulSqcqtpc7x8V46LmAv7ncFiA8GdWnpXan/pUlPvwgKhSFB+krEpdyjKw6
	 yFXeDMM1kYbKJyRyfMWJAX/qzC2apeEFgiVqVZUecWhtaS++fvAN01aAJ3awQFgwrV
	 lxbjlmKgCxJsI+TYVU2wp6tvYrqa3ptXROnqskrvN3v5MTgdjuW9aOVtjk+Z7FzrpB
	 7zvBDKyC3pq71OI+pBG8711j6EWo1bsUUCCq/TKBUPpYmZ7G50v/imt06c2bM61Z49
	 VT2u8IxTJ71N5gqEfYEbtioifMTSpc3v2tdrSVFMp/PZBzq1qjB47l05nbbl9uXHi8
	 IAyo8qPFuVsOA==
Subject:
 Re: [PATCH net-next v3 3/6] net: ftgmac100: Enable AST2700 RMII support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 07:27:14 +0000
Message-ID: <179239483424.3135.16224025989668048488@kernel.org>
In-Reply-To: <20261015-support_ast2700-v3-3-8d7999171ac4@aspeedtech.com>
References: <20261015-support_ast2700-v3-3-8d7999171ac4@aspeedtech.com>
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

- [Medium] The commit message and the new comment in ftgmac100_start_hw()
  say a phy_device is always attached once the netdev is open.
- [Low] The struct ftgmac100 field comment above `struct clk *rclk;`
  still reads "AST2500/AST2600 RMII ref clock gate".

--

net: ftgmac100: Enable AST2700 RMII support

This commit adds a match-data quirk, FTGMAC100_QUIRK_RMII_ENABLE, for
AST2700. With the quirk set, ftgmac100_start_hw() sets
FTGMAC100_MACCR_RMII_ENABLE when the attached PHY uses RMII. The commit
message says netdev->phydev is always populated once the device is open.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 67b1fa464a42..9b7becb01726 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -79,6 +82,7 @@ struct ftgmac100 {
>  	void __iomem *base;
>  
>  	enum ftgmac100_mac_id mac_id;
> +	u32 quirks;
>  
>  	/* Rx ring */
>  	unsigned int rx_q_entries;

[Severity: Low]
This isn't a bug, but this patch enables RMII on AST2700. Should the
comment on the rclk field further down in struct ftgmac100 mention
AST2700 too?

	/* AST2500/AST2600 RMII ref clock gate */
	struct clk *rclk;

ftgmac100_setup_clk() requests the optional "RCLK" clock for every
is_aspeed device, and that includes AST2700. The binding also describes
it as "RMII RCLK gate for AST2500/2600/2700".

> @@ -355,6 +359,12 @@ static void ftgmac100_init_hw(struct ftgmac100 *priv)
>  static void ftgmac100_start_hw(struct ftgmac100 *priv)
>  {
>  	u32 maccr = ioread32(priv->base + FTGMAC100_OFFSET_MACCR);
> +	/*
> +	 * Only reached once the device is open, so a phy_device is already
> +	 * attached: a discrete PHY via "phy-handle", a "fixed-link" node, or
> +	 * NC-SI's internal fixed 100M PHY.
> +	 */
> +	struct phy_device *phydev = priv->netdev->phydev;
>  
>  	/* Keep the original GMAC and FAST bits */
>  	maccr &= (FTGMAC100_MACCR_FAST_MODE | FTGMAC100_MACCR_GIGA_MODE);

[ ... ]

> @@ -383,6 +393,11 @@ static void ftgmac100_start_hw(struct ftgmac100 *priv)
>  	if (priv->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
>  		maccr |= FTGMAC100_MACCR_RM_VLAN;
>  
> +	if ((priv->quirks & FTGMAC100_QUIRK_RMII_ENABLE) &&
> +	    phydev->interface == PHY_INTERFACE_MODE_RMII) {
> +		maccr |= FTGMAC100_MACCR_RMII_ENABLE;
> +	}

[Severity: Medium]
Is phydev guaranteed to be non-NULL here? The commit message says:

  ftgmac100_probe_dt() always attaches a phy_device before
  register_netdev() can succeed -- via a discrete PHY ("phy-handle"), a
  "fixed-link" node, or NC-SI's internal fixed 100Mbit PHY

Take a node that has an "mdio" child but no "use-ncsi", no "fixed-link"
and no "phy-handle". It reaches the legacy branch in
ftgmac100_probe_dt():

	if (!ftgmac100_has_child_node(np, "mdio")) {
		...
		err = ftgmac100_mii_probe(netdev);
		...
	}

	return 0;

Probe then succeeds, and register_netdev() is called with
netdev->phydev == NULL. ftgmac100_setup_mdio() is not called for
AST2700, so the mdio child is simply ignored.

The binding appears to allow this setup. mdio is allowed for every
compatible, and AST2700 only adds phy-mode to the required list. It does
not require phy-handle, fixed-link or use-ncsi.

When such a netdev is opened, the path
ftgmac100_open()->ftgmac100_reset_and_config_mac() would oops first, on
the same dereference the commit message cites as precedent:

	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {

The new phydev->interface check in ftgmac100_start_hw() has the same
problem.

Other parts of the driver treat a NULL phydev as valid, for example
ftgmac100_open():

	if (netdev->phydev) {
		/* If we have a PHY, start polling */
		phy_start(netdev->phydev);

ftgmac100_stop(), ftgmac100_phy_disconnect(), ftgmac100_set_pauseparam()
and the reset task also check for NULL.

The later patch in this series, "Require phy-mode for AST2700", only
adds a check inside ftgmac100_mii_probe(). That function isn't reached
on the mdio-child path, so both unchecked dereferences are still there
at the end of the series.

Would it make sense to fail probe on Aspeed when no PHY gets attached,
to guard the check with phydev && ..., or to cache the phy-mode at probe
time? At minimum, could the new comment and the commit message be
corrected?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-support_ast2700-v3-0-8d7999171ac4%40aspeedtech.com
