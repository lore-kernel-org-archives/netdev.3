Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36200374E45;
	Sat, 10 Oct 2026 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619125; cv=none; b=QjauhwAmqs3u7C6N4vH2lDP1onXWEH7cLi5eEhEijbkIGw/4OP3u+D/AW2n8nZeBm1DUe/jLsXUxlnR5ufv7jCZMoNS9/RrNqmuglKnbDOaQgEnybiuf+oDxTycfqXWK8vRXZ8kZ+xkuI32fMMs+eVYS8jzKLkHzhZMEpv6NnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619125; c=relaxed/simple;
	bh=gaodNQ6TZpIzPXXdpEG/fED04Bq2L2tZ5OM+UFFzmXM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o8JKb5k2GPHfP5p3qFLbxCSMF2mxfD9PCTuLwMt4UKOuwxeWqkBRSCRVnpbPosZAdzz3W2SNGPxO9nU5MUVhnpwjxc2jymZgEzp0mILXoAgj2vDFMeHiWHkgEfmzdr+ZalVrZTOyUFyia2zl2x1MHPKbQb+Kj3H9bKzc9d/KvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymhybdta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymhybdta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7E91F0089C;
	Sat, 10 Oct 2026 07:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791619122;
	bh=rXXN7CZA9gj1tcxRjpkZYvL+dI2FoEDYFptk7kHaLZA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YmhybdtaRUIHbIb5vD9pHxA0xsZ4prl8WULoMJWmNXsdb9birad1LjABETHldC5/9
	 +SPRqFRggsfu/U0vG86OdoyBIaK/rSDU8oCdEWYumxaUZrX8xajLBVieJsSbbPPqKT
	 QSBSSw7UkITx5pLTWf1T4iweiR/9sgDcjzqFfd+PJwlYKHUC4NXd4xnX3zwn6+HFgQ
	 vYIMRU+fVqnDN+mil7m0BtkHokHD/RBgYEnn6tYss3ZgI+YA3DwyUgv3BdGcsvNQyM
	 PHvmNCSEjsfzY81d/pru4JNV78HUGwCiL05Cv8pys3v/KHszNqLJR51n2Gl+Siattm
	 MrDTFamDdJUzQ==
Subject:
 Re: [PATCH net-next v2 3/6] net: ftgmac100: Enable AST2700 RMII support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 07:58:41 +0000
Message-ID: <179161912142.434549.11654088107444095991@kernel.org>
In-Reply-To: <20261006-support_ast2700-v2-3-36de51fb8066@aspeedtech.com>
References: <20261006-support_ast2700-v2-3-36de51fb8066@aspeedtech.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: ftgmac100: NULL pointer dereference in ftgmac100_start_hw()
  on missing PHY

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  copies it.

--

net: ftgmac100: Enable AST2700 RMII support

This commit adds a FTGMAC100_QUIRK_RMII_ENABLE match-data quirk for
AST2700. ftgmac100_start_hw() uses the quirk to set the new
FTGMAC100_MACCR_RMII_ENABLE bit when the attached PHY uses RMII.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 67b1fa464a421..b835472da3604 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -355,6 +359,7 @@ static void ftgmac100_init_hw(struct ftgmac100 *priv)
>  static void ftgmac100_start_hw(struct ftgmac100 *priv)
>  {
>  	u32 maccr = ioread32(priv->base + FTGMAC100_OFFSET_MACCR);
> +	struct phy_device *phydev = priv->netdev->phydev;
>  
>  	/* Keep the original GMAC and FAST bits */
>  	maccr &= (FTGMAC100_MACCR_FAST_MODE | FTGMAC100_MACCR_GIGA_MODE);
> @@ -383,6 +388,11 @@ static void ftgmac100_start_hw(struct ftgmac100 *priv)
>  	if (priv->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
>  		maccr |= FTGMAC100_MACCR_RM_VLAN;
>  
> +	if ((priv->quirks & FTGMAC100_QUIRK_RMII_ENABLE) &&
> +	    phydev->interface == PHY_INTERFACE_MODE_RMII) {

[Severity: High]
Can phydev be NULL here?

ftgmac100_probe_dt() returns 0 without attaching a PHY when the node
has an mdio child but no phy-handle, fixed-link or use-ncsi property.
of_phy_get_and_connect() is skipped in that case. The
ftgmac100_mii_probe() fallback is skipped too, because the mdio child
exists. Probe then registers the netdev with netdev->phydev still NULL.

The rest of the driver treats a missing PHY as a valid state. For
example, ftgmac100_open() and ftgmac100_stop() test netdev->phydev
before using it. This check reads phydev->interface whenever the quirk
is set, and ftgmac100_match_data_ast2700 always sets it. On such a
board, bringing the interface up would oops via ftgmac100_init_all()
-> ftgmac100_start_hw(). The MAC restart in ftgmac100_poll() and
ftgmac100_set_rx_mode() reach the same code.

ftgmac100_reset_and_config_mac() already does the same unchecked
priv->netdev->phydev->interface read on Aspeed parts. It runs before
ftgmac100_start_hw() on open, so that site may oops first today. This
is still a second dereference that depends only on the quirk bit. The
quirk is meant to be reused by later controllers, which may not set
is_aspeed.

The later patch requiring phy-mode on AST2700 only changes
ftgmac100_mii_probe(). This path never reaches that function, so
nothing in the series closes the gap.

Could phydev be checked for NULL here and in
ftgmac100_reset_and_config_mac()? Or should probe fail on AST2700 when
no PHY ends up attached?

[Severity: High]
This is a pre-existing issue, but this new check repeats it. Can phydev be
NULL here?

ftgmac100_reset_and_config_mac() already dereferences phydev the same way,
without a check, for every Aspeed MAC. That code came from commit
af350ee72e9dda:

    if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {

The faraday,ftgmac100.yaml schema seems to allow a node that has an mdio
child but no phy-handle, fixed-link or use-ncsi. For such a node,
ftgmac100_probe_dt() skips of_phy_get_and_connect(). Because the mdio child
is present, it also skips the ftgmac100_mii_probe() fallback:

    if (!ftgmac100_has_child_node(np, "mdio")) {
        ...
        err = ftgmac100_mii_probe(netdev);
        ...
    }

    return 0;

Probe then registers the netdev with no PHY attached.

Other parts of the driver accept a NULL phydev, for example
ftgmac100_open():

    if (netdev->phydev) {
        /* If we have a PHY, start polling */
        phy_start(netdev->phydev);

ftgmac100_open()->ftgmac100_reset_and_config_mac() dereferences phydev
before that check, though, so the oops happens there on ndo_open.
ftgmac100_reset() takes the same path.

On AST2700, every caller of ftgmac100_start_hw() runs after
ftgmac100_reset_and_config_mac(). That covers ftgmac100_init_all(),
ftgmac100_poll() via need_mac_restart, and ftgmac100_set_rx_mode(). So the
new site does not add a crash on its own.

It does add a second unchecked read that depends only on the quirk bit, and
AST2700 always sets that bit. A future controller that sets the quirk
without is_aspeed would crash here.

Later patches in the series leave both sites unchecked. "net: ftgmac100:
Require phy-mode for AST2700" only changes ftgmac100_mii_probe(), and this
path never reaches that function.

Could phydev be checked for NULL at both sites? Another option would be to
fail probe on Aspeed parts when no PHY gets attached.

> +		maccr |= FTGMAC100_MACCR_RMII_ENABLE;
> +	}
> +
>  	/* Hit the HW */
>  	iowrite32(maccr, priv->base + FTGMAC100_OFFSET_MACCR);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-support_ast2700-v2-0-36de51fb8066%40aspeedtech.com
