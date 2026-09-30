Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B747519DEA;
	Wed, 30 Sep 2026 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803083; cv=none; b=c6o3jSuXjsOc4z9YsLI9mwqzH3ULmHFXfnfgQQWVi9SOUFsxsoIluNUo5giYMsXtb9jyW4HOO0Vv195OwgP+UZaWcSizsZbHV3irkGa4ts13lk4+WRCudgdQQgI8dqrd0Moe1OUQvS0p1Ol5UKwHnQPB94v3yTZP8TTDHvRVGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803083; c=relaxed/simple;
	bh=95yomqEfUPyRphh0CvFZ9aTa+4zl1Qq+TbDCJPOOfSc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EoIKArHUhJfXEgWMkPv0ieTLiKeD2gD7FOnrC/6/O8wIG5YY+AdOMi+lRHdYIAnq/shIz6VA5S2YDXX47aPENzxJcj9uGLrJJNEVUs1NfHAvPVO+T4pbb7SLftscf4vN+uUhS/+wqIMk+0um1fCYPsL+F0ZJFI2jgn8gfmL6YzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP1Rwl8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP1Rwl8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127911F000FF;
	Wed, 30 Sep 2026 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803081;
	bh=Myf6uj7l692htAWvGCAgpMmM6IZtLDuExf3bUQSY+PE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FP1Rwl8BzHobZL5Lx9ocA8y9Mkl8n4VomARJvHekUIOafLH3TwtwIuEIDmETGQo9u
	 +KVTbeVpj1zfZGY18ZgA2sXnMnzSjaJ476PpMq4fL02QBHNbLeG+wKI763Y3OhRt4i
	 gwTFkRomHaW9oHTaEGs91jrT3sJad4MIsLSQ863BOVv9rq/BSAzQfILkpwpbuC7x30
	 uqtym/EGf9RxLvDJRNivsKE/yX3dfllGaDKgYQcIKeFdudAyi0tZgpZasG0IQPoqas
	 /mavetWueA5351UxKdk0w/tECbjGLTURv0cUs+a4qtlW3DRLw+U13AurWYieVGO2t4
	 jK8Xyzj+1wMRQ==
Subject: Re: [PATCH 3/5] net: ftgmac100: Enable AST2700 RMII support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ratbert@faraday-tech.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 21:18:00 +0000
Message-ID: <179080308062.434549.1954348946284736588@kernel.org>
In-Reply-To: <20260927-support_ast2700-v1-3-9f03f29d2c82@aspeedtech.com>
References: <20260927-support_ast2700-v1-3-9f03f29d2c82@aspeedtech.com>
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

Pre-existing issues:
- [High] An Aspeed MAC (AST2400/2500/2600, and AST2700 once the series
  adds it) can probe successfully with no PHY attached, and opening it…

--

net: ftgmac100: Enable AST2700 RMII support

This commit adds an FTGMAC100_QUIRK_RMII_ENABLE match-data quirk and sets
it for AST2700. When the quirk is set and the attached PHY uses RMII,
ftgmac100_start_hw() sets the new FTGMAC100_MACCR_RMII_ENABLE bit in
MACCR.

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
> +		maccr |= FTGMAC100_MACCR_RMII_ENABLE;
> +	}

[Severity: High]
Can phydev be NULL here on AST2700?

ftgmac100_probe_dt() can return 0 without connecting a PHY. That
happens when the MAC node has an "mdio" child node but no "use-ncsi",
"fixed-link" or "phy-handle" property. The mdio child check only
skips the legacy ftgmac100_mii_probe() scan, so nothing sets
netdev->phydev and register_netdev() still succeeds.

When the interface is later brought up, ftgmac100_open() reaches
ftgmac100_start_hw() through ftgmac100_init_all(). Because
FTGMAC100_QUIRK_RMII_ENABLE is set for AST2700, the new check reads
phydev->interface without testing phydev first. The same applies to
the other callers of ftgmac100_start_hw(): ftgmac100_set_rx_mode() and
the need_mac_restart path in ftgmac100_poll().

The rest of the driver treats a missing PHY as a valid state.
ftgmac100_open() calls phy_start() only when netdev->phydev is set, and
ftgmac100_reset() and ftgmac100_phy_disconnect() also check for NULL.
A devicetree mistake like this should either fail probe or be handled.
It should not oops the kernel with rtnl_lock held from dev_open().

The is_aspeed RMII check in ftgmac100_reset_and_config_mac() makes the
same assumption, so guarding only this spot may not be enough.

Would it make sense to reject the PHY-less configuration in
ftgmac100_probe_dt() when neither NCSI nor a PHY is present? Another
option is to cache the interface mode when the PHY is connected and
use the cached value in both places.

[Severity: High]
This isn't a bug introduced by this patch, but can phydev be NULL here?

ftgmac100_probe_dt() can return 0 without attaching a PHY. This happens
when the MAC node has an "mdio" child but no use-ncsi, fixed-link or
phy-handle property:

ftgmac100_probe_dt() {
    ...
	if (!ftgmac100_has_child_node(np, "mdio")) {
		...
		err = ftgmac100_mii_probe(netdev);
		...
	}

	return 0;
}

In that case register_netdev() succeeds and netdev->phydev is NULL.

The existing check in ftgmac100_reset_and_config_mac() already
dereferences the pointer without a NULL check:

ftgmac100_reset_and_config_mac() {
    ...
	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {
    ...
}

On every path that reaches ftgmac100_start_hw() (ftgmac100_init_all() on
open and reset, ftgmac100_set_rx_mode(), and the need_mac_restart path in
ftgmac100_poll()), ftgmac100_reset_and_config_mac() either runs first or
has already succeeded. This means the NULL dereference is already
reachable on AST2400/2500/2600 through
ftgmac100_open()->ftgmac100_reset_and_config_mac(). The new check in
ftgmac100_start_hw() makes the same assumption for AST2700.

Elsewhere the driver treats a NULL phydev as valid. ftgmac100_open()
calls phy_start() only when netdev->phydev is set, and ftgmac100_reset()
and ftgmac100_phy_disconnect() also check for NULL.

dev_open() holds rtnl_lock, so an oops here would leave RTNL held.

Could probe reject PHY-less configurations instead? Another option is to
guard both dereferences, or to cache the interface mode when the PHY is
connected.

> +
>  	/* Hit the HW */
>  	iowrite32(maccr, priv->base + FTGMAC100_OFFSET_MACCR);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927-support_ast2700-v1-0-9f03f29d2c82%40aspeedtech.com
