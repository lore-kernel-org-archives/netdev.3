Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844090;
	b=lmViei1S6j18Czd/HQlDFLC4WNOIU8PfoAsQsJutx4kZLZXcjz0w6w9kqXzVW5pG166c
	 OejL4HL1KPuroXT4fnPMUO6n53RfMp6+QN++eLzck/m3TzIaLVfamZwlYRhsGJyWh1CrK
	 0Z9pd0fM4Y4dxu/IDwPotctZAn297OJT+0hkrv6avNH/dDbZMm/XmqPrHooG/SkfqNco2
	 hHpfRZWPGN4QOhcFdp8m6ASvya6bzWaM5rGCklTd7IALcH3kviTc564kvNuuhZlmVdQhr
	 mU5ziEy+DOPqx1GxmmPn/ZjaXfwLWFuCRWPIX4zuvgs1oR57PAWqyFjcHYiN41bUUaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844090;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=l9drRP4ogNwZY1fXyOU8/7fqkPyOhsgQe3h8/QvqHUk=;
	b=mWxMCdT9nrzY5oh3Ujq1UyxxUDlJ5syIYo6i4zqBC2bAUOkjaIXudjSB0LJz7fonoS8b
	 JhshfepmplTPbqHaA1cT4YBf7eGBt016Gh2HV51v+kMMR+lMoiHT8C+tOrgMVfROmZF5/
	 oI9PYXnaTZ2g8Yq3r4hM1v/hlnUflgKdUC3ttoP1+gfg/M83ieqEawk230jXGjwPnq4D6
	 kTheTR+9D4KGs+QZ7U9Xb8co7JajQrJWDNwgZpDPaMp3uJp0x/+VuXe0ggZpr7cuhUBai
	 FgCJFV7CeJVAf44SX7jadCKA9vrYEDZx12p4MZVG1t0PKcoINjwemzYSMcTGHcfnwZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fh9SYveK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B2606A32E;
	Sat, 24 Oct 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fh9SYveK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1408B1F01825;
	Sat, 24 Oct 2026 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792844089;
	bh=l9drRP4ogNwZY1fXyOU8/7fqkPyOhsgQe3h8/QvqHUk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fh9SYveKEkrqvV5IwkB9ez7/JZbcSuuaAMQvapL173tqbXoWLhojnl/eqdLptZ5IW
	 e2Q1s4FlUQME4ME7hwIS9c5/1qBahgf/CsUJBHpqAEMADXErnx9lh2Y8mnbJtZWSZI
	 HK7oPcIujNG+JXFPDPE4xqCsBMA+Hp58cDRTCMNuWNhP1Yiele2KyXsPsj7mLH0S5n
	 7m1j21xkBN+uHyi/RJbwepaYTY0PFvk5gHRjJRw9tLjqB6a2mPI85NnPWN3d0vNWVr
	 lAiO5Bep+R2Ko8J3eZKPvdxdZ7kDK6mVLYLbbCtmKH+Q1lEdRoC6p7xo2dJbPShEzY
	 yxuiX50+w/ExA==
Subject:
 Re: [PATCH net-next v4 3/7] net: ftgmac100: Add AST2700 compatible support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch
Date: Sat, 24 Oct 2026 12:14:48 +0000
Message-ID: <179284408866.3134.6034101775210393444@kernel.org>
In-Reply-To: <20261020-support_ast2700-v4-3-4d36b40939b3@aspeedtech.com>
References: <20261020-support_ast2700-v4-3-4d36b40939b3@aspeedtech.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] (Baseline decision: false positive.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  exposes it on AST2700.

--

net: ftgmac100: Add AST2700 compatible support

This patch adds an FTGMAC100_AST2700 mac_id, match data for it, and an
"aspeed,ast2700-mac" entry in ftgmac100_of_match. In ftgmac100_probe(),
AST2700 is handled like the other Aspeed variants: is_aspeed is set and the
BIT(30) end-of-ring masks are used.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 6d2fe5c2f3903..67b1fa464a421 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -2017,7 +2018,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  
>  	if (priv->mac_id == FTGMAC100_AST2400 ||
>  	    priv->mac_id == FTGMAC100_AST2500 ||
> -	    priv->mac_id == FTGMAC100_AST2600) {
> +	    priv->mac_id == FTGMAC100_AST2600 ||
> +	    priv->mac_id == FTGMAC100_AST2700) {
>  		priv->rxdes0_edorr_mask = BIT(30);
>  		priv->txdes0_edotr_mask = BIT(30);
>  		priv->is_aspeed = true;

[Severity: High]
This isn't a bug introduced by this patch, but setting is_aspeed for
AST2700 exposes an existing NULL phydev dereference on this variant.

Suppose an aspeed,ast2700-mac node has an mdio child but no phy-handle,
fixed-link or use-ncsi. In that case ftgmac100_probe_dt() skips both PHY
paths and returns success with netdev->phydev still NULL:

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_probe_dt() {
    ...
	if (!ftgmac100_has_child_node(np, "mdio")) {
		...
		err = ftgmac100_mii_probe(netdev);
		...
	}

	return 0;
}

ftgmac100_probe() only calls ftgmac100_setup_mdio() for FARADAY, AST2400
and AST2500, so on AST2700 the mdio child is ignored entirely.

register_netdev() then succeeds. When the interface comes up,
ftgmac100_open() calls ftgmac100_reset_and_config_mac() before it checks
phydev:

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_reset_and_config_mac() {
	...
	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {
	...
}

Can this oops in ndo_open with RTNL held? The binding only requires
phy-mode for ast2700-mac and doesn't restrict mdio, so a DT like this
passes dt_binding_check. The same path already exists for AST2600.

The later patch "net: ftgmac100: Enable AST2700 RMII support" makes the
same assumption in ftgmac100_start_hw(). Its commit message says
"ftgmac100_probe_dt() always attaches a phy_device before register_netdev()
can succeed", but that does not hold for this configuration.

Could ftgmac100_probe_dt() reject the case with no PHY and no NC-SI before
register_netdev()? Alternatively, or in addition, the binding could forbid
mdio and require a PHY source for ast2600/ast2700.

[ ... ]

> @@ -2131,6 +2133,10 @@ static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
>  	.mac_id = FTGMAC100_AST2600
>  };
>  
> +static const struct ftgmac100_match_data ftgmac100_match_data_ast2700 = {
> +	.mac_id = FTGMAC100_AST2700
> +};
> +

[Severity: Low]
Once aspeed,ast2700-mac binds here, AST2700 uses a datapath that only
handles 32-bit DMA addresses.

ftgmac100_match_data_ast2700 has no FTGMAC100_QUIRK_DMA_35BIT, so
ftgmac100_probe() never widens the DMA mask. ftgmac100_init_hw() also
writes only the low 32 bits of the ring bases:

	iowrite32(priv->rxdes_dma, priv->base + FTGMAC100_OFFSET_RXR_BADR);
	...
	iowrite32(priv->txdes_dma, priv->base + FTGMAC100_OFFSET_NPTXR_BADR);

Buffer addresses are likewise written into the descriptors with
cpu_to_le32(map).

As far as I can tell, this can't be reached at this commit. The FTGMAC100
Kconfig entry still has "depends on ARM || COMPILE_TEST" and "depends on
!64BIT || BROKEN", so the driver can't be built for the arm64 AST2700.

Later in the series, "net: ftgmac100: Add AST2700 upper DMA address
support" adds the 35-bit quirk, programs the RXR/TXR BADDR_HIGH registers
and fills in the upper descriptor bits. "net: ftgmac100: Allow building on
ARM64" enables arm64 only after that, so the final state of the series
looks fine.

Is it intended that AST2700 binds to the driver before the upper DMA
address support is in place?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-support_ast2700-v4-0-4d36b40939b3%40aspeedtech.com
