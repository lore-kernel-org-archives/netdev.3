Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844091;
	b=OmWz5U6/DhnjMhptMgOLHkCedUx5b0TX01r6o7Bu9DTz40MOd1Vxbv6PNhbywnHZmlZI
	 fRFASuyskgkDexH3EJTgiGfQGM0NUU3PKGOmKP2iDfX6owFeHzh9v2SQol1206Zd3eSWD
	 34IpvWia/jYLw0q1qgCqOxpWAp24inFgJCLsytO74IBd8IDW6nUa/hXW2NegZSI+H9GDa
	 8wU4Z4cbkG8dIxefp4QN05xsWSDapHbw2GWoxeassvJAgHbJ6w8et2lqQy2SklTQgbR6j
	 d462GPVaIw/3ZRFRp5wmyU7+7Y4JYNn+rmVUZ3zqeZVdzU1cUJI/7ZWZ/7EBkcv53pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844091;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gv1Nsn/K7ceq6TEu2FDszmP1j2tqBfoTAr5bozMOl74=;
	b=nVTRy8lD/lL14hZncQuk2GZQR2/tIg7Qbe5gz6RPBlXEd59IukLM4xF53IgJIrFgRxqQ
	 0l7qrJnJ9ScQWA1BWsGL5oa31drDeflzrTIEtRh0zeMJSy/tDvMewWckaRDfYmk3NBesO
	 t/eSLhiPKCzJp0SKsavtdr88kHVCS5XGVksShulJpHD97FGGruwTl8WB2Z+it3DbYOiMh
	 RPHh9LSzBDXYus907Nmix4PnJtX5R8jKsFMqcRBk1RkCn+X5P5dDqtgjBYvZkLFwYB3a8
	 /5Bf5tmbVW8LueFSxxEcLlH+QlJyAyyn4mr+8BJkK+HGeOTsuDntThD0q9+PyQvXkPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xhxv16cU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED9606A33E;
	Sat, 24 Oct 2026 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xhxv16cU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA0B1F031E6;
	Sat, 24 Oct 2026 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792844091;
	bh=gv1Nsn/K7ceq6TEu2FDszmP1j2tqBfoTAr5bozMOl74=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xhxv16cU1Nb1Ra7vm0amkDFzWQvQiSdbLn7iYl6I7MoIhRCzrdodyccBZk3E9YDPu
	 G+RzoKFbU4hkxWHHIx2naXRGG5H1ov2oPxfSjUXLwj4IaF4kP23wBItZV4Qx+8Gz73
	 q4kx4FRLBGn+axmVRmzDHrkZsgNPZvx1pJcux0/zHKwAhzb8ZbomiEJ67z0a7Woj9M
	 tOpq3DryWR3OqoOGwlLltKtawuQllEKUEPylb1Xr2SrJqgr0vltUNP5z4PRfk32Vyf
	 21CwzCWWN2R5I7SWNqAnuaUuLyXlJ7nITgziK9lL9i1EUWVM6ny/Inb5WvhvU5d7EF
	 zI3sCmwgK5+pw==
Subject:
 Re: [PATCH net-next v4 4/7] net: ftgmac100: Enable AST2700 RMII support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch
Date: Sat, 24 Oct 2026 12:14:50 +0000
Message-ID: <179284409002.3134.6819446843199664774@kernel.org>
In-Reply-To: <20261020-support_ast2700-v4-4-4d36b40939b3@aspeedtech.com>
References: <20261020-support_ast2700-v4-4-4d36b40939b3@aspeedtech.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message and the new comment in ftgmac100_start_hw()
  (drivers/net/ethernet/faraday/ftgmac100.c) both say that an opened…

--

net: ftgmac100: Enable AST2700 RMII support

This patch adds a FTGMAC100_QUIRK_RMII_ENABLE match-data quirk for
AST2700. When the attached PHY uses RMII, ftgmac100_start_hw() now sets
FTGMAC100_MACCR_RMII_ENABLE. The commit message argues that
netdev->phydev is always populated by the time ftgmac100_start_hw() runs.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 67b1fa464a421..9b7becb017262 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

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
Can phydev be NULL here on AST2700?

The commit message says:

  ftgmac100_probe_dt() always attaches a phy_device before
  register_netdev() can succeed -- via a discrete PHY ("phy-handle"), a
  "fixed-link" node, or NC-SI's internal fixed 100Mbit PHY

ftgmac100_probe_dt() also has a fallback path. If the node has an "mdio"
child and no use-ncsi, fixed-link or phy-handle property, it returns
success without connecting a PHY:

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_probe_dt() {
    ...
	if (!ftgmac100_has_child_node(np, "mdio")) {
		...
		err = ftgmac100_mii_probe(netdev);
		...
	}

	return 0;
}

ftgmac100_probe() then calls register_netdev() with netdev->phydev ==
NULL. The aspeed,ast2700-mac binding in faraday,ftgmac100.yaml appears to
allow this layout. phy-handle is optional, an mdio child is allowed, and
only phy-mode is required.

The rest of the driver also seems to treat phydev as optional. For
example, ftgmac100_open() does:

	if (netdev->phydev) {
		/* If we have a PHY, start polling */
		phy_start(netdev->phydev);
	}

ftgmac100_stop(), ftgmac100_reset_task(), ftgmac100_set_pauseparam() and
ftgmac100_phy_disconnect() check for NULL in the same way.

The quirk bit is always set for AST2700, so the && does not
short-circuit. With such a DT, this path would dereference a NULL phydev:

ftgmac100_open()
  ftgmac100_init_all()
    ftgmac100_start_hw()
      phydev->interface

Today the same open path oopses earlier. It hits the unguarded check in
ftgmac100_reset_and_config_mac() that the commit message cites as
precedent:

	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {

That existing check looks like a latent NULL dereference itself, so it
doesn't prove the invariant. This patch adds a second dereference, which
would become the crash point if the earlier check were fixed or
reordered.

The later patch in this series, "net: ftgmac100: Require phy-mode for
AST2700", only changes ftgmac100_mii_probe(). That function isn't called
when an mdio child exists, so the gap seems to remain at the end of the
series.

Would it make sense to check phydev && phydev->interface ==
PHY_INTERFACE_MODE_RMII here? Another option is to have probe fail when
no PHY is attached on Aspeed MACs, which would also cover
ftgmac100_reset_and_config_mac(). Either way, the new comment above the
phydev declaration and the commit message would need updating to match.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-support_ast2700-v4-0-4d36b40939b3%40aspeedtech.com
