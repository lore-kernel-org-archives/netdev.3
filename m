Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48668303A35
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790297600; cv=none; b=XUH8G3yGL8RQ+l1dDmAKKTSUI6MYCHGdowfLOibjOvnCwrgjDSmN4ROSP123xrT+rHOQQZf0pU0D+mqKEw3jGn6elvnB33atcN86tIWzoscCI4Y5aShFJicM4UNWX5HL3AEie/pjfgSvBxDVSSlTnNjCUYgC/zvAYEYOHq/7aww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790297600; c=relaxed/simple;
	bh=BUDvs+2mWZhLt4YuVtlFcW28eAOUo7O3t/YPDybBfcc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJk0OYPgYGRGFvuRgdA3+34eog8W9zMqkJ18yc55ZRsBK3oFfwMBZdsIV9J8j71pjfLUv75ALF6as6xg0yFGMipTHY2Wa9QySEpvvtgo1uxTB4qF1uv/7nlBm7iCDxVCpVYjUfJZRnQpr7wMshiykrJ+We+yeXZaIsYJjXKXcVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWmcB7n+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWmcB7n+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63EB1F00893;
	Fri, 25 Sep 2026 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790297599;
	bh=vY5V+XrExIxyzgHb40ciyd+S3DrX5k0gaok6OCgvQ/k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SWmcB7n+2/EvwghqCe7jXyfdoQoAWa6umy7R4Hfk0gVWinPB4h2K6LBdXGbwXcH3x
	 XSddfR30kFb+bArQNry+rEwfHvspFACHmZyzFtyiiyzJa7/wG32Z7dYdjNhckZ1Of1
	 ssP7JuvOmOXWU5EkmBsH/VUpvzpMckkh0OwRgoKQglF7afeNOPkLNpGcqutZYzzckf
	 +w8/dPESu4ywe9Xc1wblxYMuSG8QVTj+ZTW1vqBJ0Rl7+vejDW+h3rgcsHoBVP8yns
	 qMHaNwH+leVNid4jcDUnLU0Qgbal+NvUK7j1/vusmpv5fN3pPnscqmSCYdsDfEpdb8
	 3FxWtuTDIatOg==
Subject: Re: [PATCH net-next v5] Add config phase for dp83td510e phy
From: netdev-bot+sashiko@kernel.org
To: julien.blanc@sprinte.eu
Cc: netdev@vger.kernel.org, o.rempel@pengutronix.de, hkallweit1@gmail.com,
 kuba@kernel.org, andrew@lunn.ch
Date: Fri, 25 Sep 2026 00:53:18 +0000
Message-ID: <179029759826.2160803.13747337609737038966@kernel.org>
In-Reply-To: <30be27333dbf1a83efbe20e7b07acc6290805d65.camel@sprinte.eu>
References: <30be27333dbf1a83efbe20e7b07acc6290805d65.camel@sprinte.eu>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The TX delay may be programmed with the wrong polarity.
- [Medium] net: phy: dp83td510: fail to clear RMII mode when enabling
  RGMII
- [Low] There are three commit message problems.

--

Add config phase for dp83td510e phy

This adds a config_init callback to the TI DP83TD510E PHY driver. The
callback programs the RCSR register to choose RMII or RGMII mode from
phy-mode, and it turns the RGMII RX/TX internal clock shifts on or off to
match rgmii-id, rgmii-rxid and rgmii-txid. Any other interface mode is
left alone.

> Add config phase for dp83td510e phy

[Severity: Low]
This isn't a bug, but the subject has no subsystem prefix. netdev usually
expects something like:

  net: phy: dp83td510: add config_init to set MII mode and RGMII delays

> Add a config phase for the Texas Instruments DP83TD510E ethenet PHY

There's a typo here: "ethenet" should be "ethernet".

> Signed-off-by: Julien Blanc <julien.blanc@sprinte.eu>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

A blank line sits between Signed-off-by and Reviewed-by, which splits the
trailer block. Because of that, git interpret-trailers and b4 won't treat
Signed-off-by as a trailer. Could the blank line be removed?

> diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
> index 9e9a41bf64574..aa61220dbce36 100644
> --- a/drivers/net/phy/dp83td510.c
> +++ b/drivers/net/phy/dp83td510.c
> @@ -30,6 +30,12 @@
>  #define DP83TD510E_INT1_LINK			BIT(13)
>  #define DP83TD510E_INT1_LINK_EN			BIT(5)
>  
> +#define DP83TD510E_RCSR				0x17
> +#define DP83TD510E_RMII_MODE_EN			BIT(5)
> +#define DP83TD510E_RGMII_MODE_EN		BIT(9)
> +#define DP83TD510E_TX_CLK_SHIFT			BIT(11)
> +#define DP83TD510E_RX_CLK_SHIFT			BIT(12)

[ ... ]

> +static int dp83td510_config_init(struct phy_device *phydev)
> +{
> +	int rgmii_delay = 0;
> +	bool rx_int_delay;
> +	bool tx_int_delay;
> +	int ret;
> +
> +	if (phy_interface_is_rgmii(phydev)) {
> +		rx_int_delay = dp83td510_config_rgmii_rx_delay(phydev);
> +		if (rx_int_delay)
> +			rgmii_delay |= DP83TD510E_RX_CLK_SHIFT;
> +
> +		tx_int_delay = dp83td510_config_rgmii_tx_delay(phydev);
> +
> +		if (tx_int_delay)
> +			rgmii_delay |= DP83TD510E_TX_CLK_SHIFT;

[Severity: Medium]
Does DP83TD510E_TX_CLK_SHIFT have the same polarity as
DP83TD510E_RX_CLK_SHIFT?

This RCSR layout is identical to the DP83822 one: register 0x17,
RMII_MODE_EN at BIT(5), RGMII_MODE_EN at BIT(9), TX_CLK_SHIFT at BIT(11)
and RX_CLK_SHIFT at BIT(12). On the DP83822, setting the TX shift bit
turns the TX internal delay off:

drivers/net/phy/dp83822.c:dp83822_config_init() {
    ...
		/* Set DP83822_TX_CLK_SHIFT to disable tx clk internal delay */
		if (tx_int_delay <= 0)
			rgmii_delay |= DP83822_TX_CLK_SHIFT;
    ...
}

The DP83822 driver used to get this backwards, and it was fixed in commit
c8a5c731fd12 ("net: phy: dp83822: Fix RGMII TX delay configuration"). That
commit cites the DP83822 datasheet and says the TX clock shift is disabled
when the bit is set.

If bit 11 of the DP83TD510E register works the same way, every RGMII mode
would get the wrong TX delay:

- Plain rgmii would get a PHY TX delay, on top of any MAC or PCB delay.
- rgmii-id and rgmii-txid would get no TX delay at all.

Does the DP83TD510E datasheet confirm that this bit is active-high for the
TX delay? It might be worth citing the datasheet description in the commit
message.

> +
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_RCSR,
> +				     DP83TD510E_RX_CLK_SHIFT |
> +				     DP83TD510E_TX_CLK_SHIFT,
> +				     rgmii_delay);
> +		if (ret)
> +			return ret;

[Severity: Medium]
In the RGMII branch, dp83td510_config_init() uses phy_set_bits_mmd()
to set DP83TD510E_RGMII_MODE_EN. That leaves DP83TD510E_RMII_MODE_EN
as it was.

The RMII branch just below treats the two bits as mutually exclusive.
Its comment says so, and it clears RGMII_MODE_EN when it sets
RMII_MODE_EN. The RGMII branch doesn't do the reverse.

Suppose the straps or the bootloader left RMII_MODE_EN set in RCSR,
and the device tree says phy-mode = "rgmii*". Then the PHY ends up
with both mode bits set. By the patch's own reasoning that is not a
valid state, and the MAC interface may never come up.

Could this use phy_modify_mmd() instead? The mask would be
DP83TD510E_RMII_MODE_EN | DP83TD510E_RGMII_MODE_EN and the value
DP83TD510E_RGMII_MODE_EN, mirroring the RMII branch. The RX/TX clock
shift bits could be folded into the same read-modify-write, so RCSR is
only written once.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/30be27333dbf1a83efbe20e7b07acc6290805d65.camel%40sprinte.eu
