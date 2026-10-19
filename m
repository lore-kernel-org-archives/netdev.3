Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6648AE0F;
	Mon, 19 Oct 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394838; cv=none; b=S8eiVkrwY7VnlKMT4b5tYTKQStmY3XcGHH9OxHy0hdm2qLbsRqcnKP8Gr6XTDeEsfEe2pf2HARCFCnpWykEaAZnUkm2WxCLR7RaRQn/U7zKFsN88S0iUjUF7VX71vR1CK5Gum3DIV/J7iPevZXfsaAPeWwz36AaEA2RzWobrv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394838; c=relaxed/simple;
	bh=t69D2YbH/0DAr8TPdcLx1g8raDPwT1e7f6Br0a3akzw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjaoHT/TIqxNPAieRcQnqGDShVIZzFQtdOHosGtzIxcZJW+A0UNrEr03ESJVm3u32mSoi9n7JCSrLpgSeQWkSvtn1kLd05NptJakJ59f2Gt8P4T8Sv4oGqhapagyq1nLLGPLeqQkyPw4NcakbtjsSMPcFNYgDBKCla6s4015Sgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMBklAwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMBklAwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2631F000C5;
	Mon, 19 Oct 2026 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394836;
	bh=mvOyC0WrLpmXFwIyo6bA31Kb3kOkdKbf9e2ic40ZmVc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cMBklAwD1nkgVw8zCta9EXKYo1WG5Z17J0DRoTtg3ahjkRmnKEGY47FKd3/UpQ7ow
	 mff1/TblVBbMZDdVQEW4ZPjgHZYsTm7HV3UkAxJxBc2+75JjTlZ181aSCS2f/Md5J7
	 mvVQlmv2yC1ZnbtVYRwxuf6Pxf5xJsrWHHQljHEB0leaAY1c+qBJXs19wZc/2Zex7m
	 ehEx5X8Z+jVNLF+y44aNVTuMVeCGoPaMUNrUHMqtSosk4svX4e27+wJHOScVVMg2m+
	 6+nfABotVakyoiVcAi3Xs5aU0Z+ixk26JPfM+RNa7eGmoaG1bzXGXBd2qmh0sk6e9v
	 DV7i9VH7LoNNw==
Subject:
 Re: [PATCH net-next v3 4/6] net: ftgmac100: Require phy-mode for AST2700
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 07:27:15 +0000
Message-ID: <179239483566.3135.3971594681271482393@kernel.org>
In-Reply-To: <20261015-support_ast2700-v3-4-8d7999171ac4@aspeedtech.com>
References: <20261015-support_ast2700-v3-4-8d7999171ac4@aspeedtech.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new AST2700 phy-mode check in ftgmac100_mii_probe() can
  never run, so the patch has no effect.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a
  reachable kernel oops.
- [Low] The AST2700 binding requires phy-mode in every configuration,
  including use-ncsi.
- [Low] In ftgmac100_mii_probe(), the comment "Aspeed only supports
  these" and the netdev_warn("Unsupported PHY mode %s !") fire for any…

--

net: ftgmac100: Require phy-mode for AST2700

This patch changes ftgmac100_mii_probe() so that on AST2700 it fails
with -EINVAL when the phy-mode property is missing, instead of falling
back to RGMII. The goal is to make phy-mode a required property for
AST2700, since that SoC also supports RMII.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 9b7becb01726..5a578a62df67 100644
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
Can this new check ever be reached on AST2700?

ftgmac100_setup_mdio() is the only function that assigns priv->mii_bus.
ftgmac100_probe() calls it only for FARADAY, AST2400 and AST2500:

ftgmac100_probe() {
    ...
	if (priv->mac_id == FTGMAC100_FARADAY ||
	    priv->mac_id == FTGMAC100_AST2400 ||
	    priv->mac_id == FTGMAC100_AST2500) {
		err = ftgmac100_setup_mdio(netdev);
    ...
}

On AST2700, priv->mii_bus is therefore always NULL. ftgmac100_mii_probe()
returns at this check before it ever calls of_get_phy_mode():

	if (!priv->mii_bus) {
		dev_err(priv->dev, "No MDIO bus available\n");
		return -ENODEV;
	}

That leaves the "phy-mode is required for this SoC" message unreachable.

The commit message says:

  "The driver currently defaults to RGMII when the "phy-mode" property
  is missing from the device tree."

Is that true for AST2700? These are the probe paths in
ftgmac100_probe_dt():

- phy-handle or fixed-link: of_phy_get_and_connect() already returns
  NULL when of_get_phy_mode() fails, so probe fails with "Failed to
  connect to phy".
- use-ncsi: phy-mode is ignored and RMII is hardcoded.
- no mdio child: ftgmac100_mii_probe() fails with "No MDIO bus
  available".
- an mdio child with no phy-handle, fixed-link or use-ncsi:
  ftgmac100_probe_dt() returns 0 and phy-mode is never checked.

In that last case AST2700 still probes successfully without phy-mode.
That does not match "fail probe with an error message if it is not
specified".

The dt-binding patch in this series, "dt-bindings: net: ftgmac100: Add
AST2700 compatible", justifies required: phy-mode by saying it matches
the driver's probe-time requirement. This patch does not create that
requirement, and no later patch in the series changes
ftgmac100_mii_probe() or ftgmac100_probe_dt().

Would it work better to put the check in ftgmac100_probe_dt() (or
ftgmac100_probe())? It would need to run before the
fixed-link/phy-handle/mdio-child dispatch and outside the use-ncsi path.

>  		phy_intf = PHY_INTERFACE_MODE_RGMII;
> +	}
>  
>  	/* Aspeed only supports these. I don't know about other IP
>  	 * block vendors so I'm going to just let them through for

[Severity: Low]
This isn't a bug introduced by this patch, but the comment and the
warning that follow it in ftgmac100_mii_probe() look out of date:

	if (priv->is_aspeed && !(phy_interface_mode_is_rgmii(phy_intf))) {
		netdev_warn(netdev,
			    "Unsupported PHY mode %s !\n",
			    phy_modes(phy_intf));
	}

The driver handles Aspeed RMII in two places: the SCU reset in
ftgmac100_reset_and_config_mac(), and FTGMAC100_QUIRK_RMII_ENABLE in
ftgmac100_start_hw(). The binding's phy-mode enum also allows rmii.

Do legacy AST2400/AST2500 RMII device trees with no mdio child get a
spurious "Unsupported PHY mode rmii !" warning here? phy_connect() still
gets the RMII mode, so the warning has no functional effect. This path
is not reachable on AST2700.

[Severity: High]
This isn't a bug introduced by this patch, but the mdio child path in
ftgmac100_probe_dt() can also lead to a NULL pointer dereference.

If an Aspeed DT node has an mdio child but no phy-handle, fixed-link or
use-ncsi, ftgmac100_probe_dt() returns 0 without attaching a PHY:

ftgmac100_probe_dt() {
    ...
	if (!ftgmac100_has_child_node(np, "mdio")) {
		...
	}

	return 0;
}

The netdev is then registered with netdev->phydev == NULL. On interface
up:

ftgmac100_open()
  ftgmac100_reset_and_config_mac()
    if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII)

Can this oops in ndo_open while rtnl_lock is held? ftgmac100_reset_task()
reaches the same dereference. ftgmac100_open() checks
if (netdev->phydev) later on, so a NULL phydev looks like an expected
state.

The series patch "net: ftgmac100: Enable AST2700 RMII support" adds a
second unguarded dereference in ftgmac100_start_hw():

	if ((priv->quirks & FTGMAC100_QUIRK_RMII_ENABLE) &&
	    phydev->interface == PHY_INTERFACE_MODE_RMII) {

That patch justifies the dereference with "ftgmac100_probe_dt() always
attaches a phy_device before register_netdev() can succeed". The mdio
child path above contradicts that.

In practice the crash would happen first in
ftgmac100_reset_and_config_mac(), because it runs before
ftgmac100_init_all()->ftgmac100_start_hw(). The phy-mode check in this
patch does not cover this path either.

[Severity: Low]
This is a pre-existing issue, but it bears on the binding requirement
this series adds. The AST2700 binding requires phy-mode in every
configuration, including use-ncsi, yet ftgmac100_probe_ncsi() never
reads phy-mode:

ftgmac100_probe_ncsi() {
    ...
	err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
				 PHY_INTERFACE_MODE_RMII);
    ...
}

A DT with use-ncsi and phy-mode = "rgmii" would pass the schema, and the
driver would silently use RMII. The binding documents use-ncsi as
"Currently assumes rmii (100bT)", so the driver's behaviour matches the
documentation.

Should the binding exempt use-ncsi configurations from the phy-mode
requirement?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-support_ast2700-v3-0-8d7999171ac4%40aspeedtech.com
