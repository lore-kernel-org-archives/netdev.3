Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D03932F9;
	Sat, 10 Oct 2026 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619126; cv=none; b=g6iJvmj5f1N32ocXTfqMme1mzRNEWddt//cj36Jkj/8hL+Jea1Es5ZBiu7dAz/aG7W0MeHkQnIFfLLgk1/4Tf7egPiKpWPDpkMQfxMpLkPzyVlrH6XaIrcukP0Bc2/Igk/AXZ+j7A/6cy/4bJlwBlMPANMc4voawMP2KksgYKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619126; c=relaxed/simple;
	bh=XIdCPeDewN10SKO1C0TQYrubUpPucOgza8+GjWkQ/sU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=loEeIkl82aUPBsp1NY9XFm1qjjwo+iFK9AOxC/fhFQcRNtDVtuTJLBaVaHfFkSUWDGAmkdbGHiNO2Th7MfxXZhW0vMy0djw+GTNLzo1ZeLt2ru35MxN1XDZrEh5CFUIrB77oBDzoeQccWl0hGWY+pJEtJkfPfAWYkbRkJoSwiRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTFPKEwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTFPKEwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756691F00893;
	Sat, 10 Oct 2026 07:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619124;
	bh=flQcx5gSOoKvqu5wM1mUsERFuY2KFXUokmPdWLYRZvI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lTFPKEwHj1hxea52PIFAL/dfHeJPnoFXv9obCF4omjMizvDE1qDk8vBiCWzMowqRS
	 Bblb8rXAMYMm2+KZ6XntX1TJScecY3y3wp86NcnlxIL+GEATlfqta06IU19JRldoJu
	 h799zhmk+/3MlpuUtxNAz9wl/2+YaB/UlAX7APQAF6+NGnS1OBhq6CmO5or6cpN24v
	 MKyhRBd4GRI634X56g5Z8enJTrXskQUmP//gpt496taPLGO9nS9ZTVgKe/utjVWUd6
	 OKtfuaiVTrlWT53YQ/qcnrB+8rFaiR8JyKAavumQLAff0aOBTmjTyu9b9WIOjkHIem
	 Ypo0/dY6tfMoQ==
Subject:
 Re: [PATCH net-next v2 4/6] net: ftgmac100: Require phy-mode for AST2700
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 07:58:42 +0000
Message-ID: <179161912299.434549.18172761836430196404@kernel.org>
In-Reply-To: <20261006-support_ast2700-v2-4-36de51fb8066@aspeedtech.com>
References: <20261006-support_ast2700-v2-4-36de51fb8066@aspeedtech.com>
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

- [Medium] The new AST2700 check in ftgmac100_mii_probe() can never run,
  and the commit message describes behaviour that does not exist.
- [Low] The commit says it makes 'phy-mode' a required property for
  AST2700, but the DT binding in the same series does not say so.

--

net: ftgmac100: Require phy-mode for AST2700

This patch makes ftgmac100_mii_probe() return -EINVAL on AST2700 when
the phy-mode property is missing, instead of falling back to RGMII. The
commit message says the RGMII default is no longer valid because
AST2700 also supports RMII.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index b835472da3604..2d029d1262e6f 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1521,8 +1521,13 @@ static int ftgmac100_mii_probe(struct net_device *netdev)
>  
>  	/* Default to RGMII. It's a gigabit part after all */
>  	err = of_get_phy_mode(np, &phy_intf);
> -	if (err)
> +	if (err) {
> +		if (priv->mac_id == FTGMAC100_AST2700) {
> +			dev_err(priv->dev, "phy-mode is required for this SoC\n");
> +			return -EINVAL;
> +		}

[Severity: Medium]
Can this check ever run on AST2700?

priv->mii_bus is set in only one place, ftgmac100_setup_mdio(). That
function is called from ftgmac100_probe() only for the Faraday, AST2400
and AST2500 variants:

ftgmac100_probe() {
    ...
	if (priv->mac_id == FTGMAC100_FARADAY ||
	    priv->mac_id == FTGMAC100_AST2400 ||
	    priv->mac_id == FTGMAC100_AST2500) {
		err = ftgmac100_setup_mdio(netdev);
    ...
}

So on AST2700 priv->mii_bus stays NULL, and ftgmac100_mii_probe()
returns before it reaches of_get_phy_mode():

ftgmac100_mii_probe() {
    ...
	if (!priv->mii_bus) {
		dev_err(priv->dev, "No MDIO bus available\n");
		return -ENODEV;
	}
    ...
}

That leaves the new dev_err() and -EINVAL return unreachable on AST2700.

The other AST2700 PHY path is phy-handle or fixed-link in
ftgmac100_probe_dt(). It goes through of_phy_get_and_connect(), which
already returns NULL when phy-mode is missing:

of_phy_get_and_connect() {
    ...
	ret = of_get_phy_mode(np, &iface);
	if (ret)
		return NULL;
    ...
}

Probe then fails with "Failed to connect to phy" and never uses an RGMII
default.

Given that, is this part of the commit message accurate for AST2700?

  "The driver currently defaults to RGMII when the "phy-mode" property
  is missing from the device tree."

  "... fail probe with an error message if it is not specified, instead
  of silently defaulting to RGMII."

One AST2700 configuration can still probe without phy-mode: an mdio child
node with no phy-handle. The requirement the commit describes is not
enforced there either.

The end of the series ("net: ftgmac100: Allow building on ARM64") has the
same layout. ftgmac100_setup_mdio() is still skipped for AST2700, and the
mii_bus check still comes before the new AST2700 check.

Would it make sense to move this check somewhere reachable, such as
ftgmac100_probe_dt(), and update the commit message to match? Or should
the patch be dropped?

> +		phy_intf = PHY_INTERFACE_MODE_RGMII;
> +	}

[Severity: Low]
The commit message says:

  "Make "phy-mode" a required property for AST2700"

The binding doesn't seem to say that. The top-level required list in
Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml is:

required:
  - compatible
  - reg
  - interrupts

The allOf if/then block for aspeed,ast2600-mac and aspeed,ast2700-mac only
covers resets. That means dtbs_check still accepts an AST2700 node with
no phy-mode.

The series already adds the AST2700 compatible in "dt-bindings: net:
ftgmac100: Add AST2700 compatible". Could the requirement go in that
patch, as an if/then for aspeed,ast2700-mac with required: [phy-mode]?

It would need to exclude use-ncsi nodes. ftgmac100_probe_ncsi() hardcodes
PHY_INTERFACE_MODE_RMII and never reads phy-mode.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-support_ast2700-v2-0-36de51fb8066%40aspeedtech.com
