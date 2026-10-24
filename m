Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844093;
	b=yslnA0pXqP7N41J8pgUVGOeDcbXS3cpmj/u6Mly2rKOlvRsZBN55OKgJH09RyJn4qWrX
	 9c3PjwQSyMSOmru8CWBJL64CGxGKQxq6D1YJaFB5meQydnR3UoY5/LqD6AnGzSKWwY8xv
	 b7ucbQDWN5fyvBYPfwMSgCE7JLXxEIULvhujawwcH1P3tTIJMgK/Cm6mnrj/rKR6OP+JV
	 kQGjCL+PeC5WPeEY66KEoLrWlQgcbMRM9ly7AaqCJ+pSI1s56+kao51Vk/6HUPogyi/u8
	 eRaG4C/TxP72uWFVVFKN2ubzcU3LQVFCl67TKWNpu4Mz25Po+faDPZCBZh/86G9TYQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844093;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=k+xY6wjN669G76yFjea0bngxD4QytUquknD9Cl1+FpI=;
	b=ohtZ3AslyVliiPxbCdmVoBBOyDJYQa1Hm0I928J6UGkDeJugZHtonFlXnuJ6jqU0adfa
	 ltge6lwfK/Rjgldh0VF3Fba4VfFyPtiwa2vSk5WrWJ5GVc3LMCUqPDXh89IM+C8n1oKWF
	 YQWd7iSMHNshCiTJfbBCfxihYxiFJCCiouh82ieVzI2DpZy0NNZ2HaRwrf+aGeKLKRqMO
	 /SnqYrLlqNnc7LZxrXJ5JFVtLTbOxyxa+/G5hApA5SbVc9cjP04dDi9Mki+iP6zEbekby
	 p3Lk2ImUAv/5KfhqWGPzgrtudDYzmm/KbFI+endx46c8xzd/g6lR4CYPr1Y7ihtdtJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+9quHwQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874E606A32F;
	Sat, 24 Oct 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+9quHwQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34D51F01825;
	Sat, 24 Oct 2026 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792844092;
	bh=k+xY6wjN669G76yFjea0bngxD4QytUquknD9Cl1+FpI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d+9quHwQ6MSN9NYNH4bNTx9Jv2e7DTkYGwNr7wstdf1yZ+vMp0WCzEWrPOoi6TvJB
	 lBeGTapWoeZJkyhKwK1BqXoHbgOMeKNe7zKasYoXwl8U8fmSfBFEqYCxR6dYgR8ibn
	 PZmEWi8J0Zxgeh+c0xiXowcc3QKyTFU6jDc8bb7+3hsFGlf4VBkOZBwSF0z1pHOJG/
	 1a6f7S13Dsim3SAD826Gm8QVpfwyF0vLKlJ4jJOIow0l2xTyIazCwNWYmG1tlpDPbq
	 gKFd0fH33zmBwXOl1CeZg/qYXALimJNjpEi6UghZgxGGrgNcl1HAtKuh+550rgH8Sw
	 Js29g4YRTcJew==
Subject:
 Re: [PATCH net-next v4 5/7] net: ftgmac100: Require phy-mode for AST2700
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch
Date: Sat, 24 Oct 2026 12:14:51 +0000
Message-ID: <179284409138.3134.17526077074509394471@kernel.org>
In-Reply-To: <20261020-support_ast2700-v4-5-4d36b40939b3@aspeedtech.com>
References: <20261020-support_ast2700-v4-5-4d36b40939b3@aspeedtech.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new AST2700 "phy-mode is required" check in
  ftgmac100_mii_probe() (drivers/net/ethernet/faraday/ftgmac100.c) can…
- [High] The commit message says that on AST2700 the driver will "fail
  probe with an error message if [phy-mode] is not specified", and the…

Pre-existing issues:
- [High] NULL pointer dereference in ftgmac100_reset_and_config_mac() on
  ndo_open for an Aspeed MAC with no PHY attached.

--

net: ftgmac100: Require phy-mode for AST2700

This patch changes ftgmac100_mii_probe() so that on AST2700 a missing
phy-mode property returns -EINVAL. Previously the driver fell back to
RGMII. The goal is to make phy-mode a required property for AST2700,
because that SoC also supports RMII.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 9b7becb017262..5a578a62df673 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1526,8 +1526,13 @@ static int ftgmac100_mii_probe(struct net_device *netdev)
>  
>  	/* Default to RGMII. It's a gigabit part after all */
>  	err = of_get_phy_mode(np, &phy_intf);
> -	if (err)
> +	if (err) {
> +		if (priv->mac_id == FTGMAC100_AST2700) {
> +			dev_err(priv->dev, "phy-mode is required for this SoC\n");
> +			return -EINVAL;
> +		}

[Severity: High]
Can AST2700 ever reach this check? Earlier in ftgmac100_mii_probe()
there is:

	if (!priv->mii_bus) {
		dev_err(priv->dev, "No MDIO bus available\n");
		return -ENODEV;
	}

priv->mii_bus is only set in ftgmac100_setup_mdio(). ftgmac100_probe()
only calls that function for FARADAY, AST2400 and AST2500:

	if (priv->mac_id == FTGMAC100_FARADAY ||
	    priv->mac_id == FTGMAC100_AST2400 ||
	    priv->mac_id == FTGMAC100_AST2500) {
		err = ftgmac100_setup_mdio(netdev);
		...
	}

On AST2700, ftgmac100_probe()->ftgmac100_probe_dt()->ftgmac100_mii_probe()
returns -ENODEV before of_get_phy_mode() is called. That makes the new
branch look like dead code.

The phy-handle and fixed-link paths go through of_phy_get_and_connect().
That function already returns NULL when phy-mode is missing:

drivers/net/mdio/of_mdio.c:of_phy_get_and_connect() {
	...
	ret = of_get_phy_mode(np, &iface);
	if (ret)
		return NULL;
	...
}

Given that, is this part of the commit message accurate?

  The driver currently defaults to RGMII when the "phy-mode" property
  is missing from the device tree. This default is no longer valid for
  AST2700

As far as I can tell, AST2700 never reaches the RGMII fallback, and this
patch does not change how AST2700 probes. The companion patch
"dt-bindings: net: ftgmac100: Add AST2700 compatible" says the binding
matches "the driver's probe-time requirement", so it depends on this
check working.

Could the check move somewhere AST2700 actually reaches, such as the
start of ftgmac100_probe_dt() or ftgmac100_probe()? The later patches in
the series, "net: ftgmac100: Add AST2700 upper DMA address support" and
"net: ftgmac100: Allow building on ARM64", don't seem to touch this logic.

[Severity: High]
Two other AST2700 probe paths in ftgmac100_probe_dt() still succeed
without phy-mode.

The first is use-ncsi:

	if (of_get_property(np, "use-ncsi", NULL))
		return ftgmac100_probe_ncsi(netdev, priv, pdev);

ftgmac100_probe_ncsi() never reads phy-mode and always connects with
RMII:

	err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
				 PHY_INTERFACE_MODE_RMII);

An AST2700 NC-SI node without phy-mode therefore probes successfully. A
node with phy-mode = "rgmii" passes binding validation, but the driver
ignores that value and runs in RMII.

The second is a node with an mdio child but no phy-handle, fixed-link or
use-ncsi. ftgmac100_probe_dt() skips the ftgmac100_mii_probe() block and
returns 0 without reading phy-mode:

	if (!ftgmac100_has_child_node(np, "mdio")) {
		...
		err = ftgmac100_mii_probe(netdev);
		...
	}

	return 0;

Doesn't this conflict with "fail probe with an error message if it is
not specified" in the commit message? The binding also requires phy-mode
for every aspeed,ast2700-mac node.

Should the binding allow a use-ncsi exception, or should the driver check
phy-mode on all of these paths?

>  		phy_intf = PHY_INTERFACE_MODE_RGMII;
> +	}
>  
>  	/* Aspeed only supports these. I don't know about other IP
>  	 * block vendors so I'm going to just let them through for

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can
ftgmac100_open() dereference a NULL phydev on the mdio child path
described above?

Take an Aspeed node with an mdio child but no phy-handle, fixed-link or
use-ncsi. ftgmac100_probe_dt() returns 0 without connecting a PHY, so the
netdev is registered with netdev->phydev == NULL.

On ip link set up, ftgmac100_open()->ftgmac100_reset_and_config_mac()
does:

	/* Aspeed RMII needs SCU reset to clear status */
	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {

is_aspeed is true for every Aspeed MAC. ftgmac100_open() only checks
netdev->phydev later, just before phy_start().

This dereference came from commit af350ee72e9dda, before this series.
The series extends it to AST2700.

The earlier patch "net: ftgmac100: Enable AST2700 RMII support" adds
another unguarded read in ftgmac100_start_hw():

	if ((priv->quirks & FTGMAC100_QUIRK_RMII_ENABLE) &&
	    phydev->interface == PHY_INTERFACE_MODE_RMII) {

That patch's comment says ftgmac100_probe_dt() always attaches a
phy_device, but this path shows it doesn't. The phy-mode check added
here doesn't cover this path either.

Should these reads check for a NULL phydev, or should
ftgmac100_probe_dt() fail when no PHY is attached?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-support_ast2700-v4-0-4d36b40939b3%40aspeedtech.com
