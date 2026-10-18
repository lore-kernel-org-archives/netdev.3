Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08054A64CC;
	Sun, 18 Oct 2026 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328459; cv=none; b=pVUTSKP8uLa0jnizgDp6zhhe0oHI6dzo4lTU6ujVfNeQjrPemAT/5APbHXkdud/epe+Oqjkle9rdUTBDjNpghZJ44GYNi/OIxCqRPrb5DLSrJD0J1EHAlO2cejre5LElNhga5CItzZCwJVcCantF3niBPmLQQmz2ikdJx5tboe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328459; c=relaxed/simple;
	bh=Hq5P//drtWzP13rnoFhV6usVgNxiwWM6U4ey0h4Ep6U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0ya3G9KQk0WSN2Y0SsTeJh8VWi8dRChmy+yrZ8LPsmlXYtRyGQoU6aBC2QctYfylxT/l/U/zmWAa1durh77Mx3fDfgMcHj86nEzllXtQ2lcVR3qHLoGXO5xHaS/gposIaizIwdAvODxzzFQ14MfBk3TGnginAE+UMEc8wIjoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKulihZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKulihZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DD61F000C5;
	Sun, 18 Oct 2026 13:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792328455;
	bh=oWD1V8nFkOwdAoYmmdjJip/xy6ceeOUIH/AVoBi6FoI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RKulihZwsE/dxlwQ5NH8MdIdDtU7IYN9MWriXzySBhtrMxBgziuVXh46g9LbzsrpY
	 BDjtQQBwG8TeWe44ZGTkZK/7vrYJSuBy/ArXOxMZw2ddujlrwfUVavKRUXrHhltNff
	 oZFus0OLTVx+t4ktXpMjKB46qzs/b/LFZJtVhgrt9vb3qhwmXO3+SZ+6bLD3y2Z2k5
	 mB+eAUUJz6ppeJVCJG7TyGVWoJbYkVRVQNnbVij128e75zJndpyyWUhZ3CrTCZO+15
	 FHg2vcHMwJQNEzKGwHucjKbO50g8cu+TbYisHGarpLIwiaJw0TJt/IeRv6YaYghpDu
	 xELREH+W63/SQ==
Subject: Re: [PATCH net-next 1/2] net: pcs: xpcs: re-order xpcs_pre_config()
 to update after the reset
From: netdev-bot+sashiko@kernel.org
To: elder@riscstar.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 daniel@riscstar.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 13:00:54 +0000
Message-ID: <179232845425.3135.8614802619087243641@kernel.org>
In-Reply-To: <20261014223100.304486-2-elder@riscstar.com>
References: <20261014223100.304486-2-elder@riscstar.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds a generic XPCS soft reset on Wangxun TXGBE
  parts every time SGMII is configured.
- [Medium] The patch drops the interface-change check that gated the
  SGMII reset, while the new comment still says the reset happens on a…
- [Medium] The commit message describes a preparatory reorder that just
  'hoist[s] the special case logic for SGMII into the parent function',…
- [Low] The error handling in xpcs_pre_config() now behaves differently,
  and the commit message does not mention it.

--

net: pcs: xpcs: re-order xpcs_pre_config() to update after the reset

This commit reorders xpcs_pre_config() so that the XPCS soft reset runs
before xpcs_switch_interface_mode(). The SGMII reset trigger moves out of
xpcs_switch_interface_mode() and into xpcs_pre_config().

> Currently, on Wangxun platforms, the XPCS is configured during the call
> to xpcs_switch_interface_mode() and, if the need_reset flag is set, the
> XPCS is reset and the configuration will be lost. This is harmless at
> present because need_reset will never actually be set on these platforms.

[ ... ]

> Reorder xpcs_pre_config() so the reset can happen before we switch
> interface mode. To make this work we have to hoist the special case
> logic for SGMII into the parent function.

[Severity: Medium]
Is this description complete? The patch seems to widen the reset policy,
not just move it.

The old SGMII branch ran only when xpcs->interface != interface. It also
sat in the else branch of the WX_TXGBE_XPCS_PMA_10G_ID check.

The new force_reset condition in xpcs_pre_config() keeps neither of those
checks. Every SGMII pcs_pre_config() now does a real BMCR_RESET write and
poll on every XPCS, Wangxun included (see the inline comments below).

The commit message says Wangxun is safe because need_reset is never set
there, but that doesn't cover the new force_reset path. The last patch in
the series doesn't touch xpcs_pre_config(), so this is still the case at
the end of the series.

Could the commit message describe this change in runtime behaviour?

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index b415b93d77c15..49abf5ea6f5cc 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -705,46 +705,49 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
>  static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
>  				      phy_interface_t interface)
>  {
> -	int ret = 0;
> +	/* Wangxun provides a full alternative implementation to handle quirks */
> +	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
> +		return txgbe_xpcs_switch_mode(xpcs, interface);
>  
> -	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
> -		ret = txgbe_xpcs_switch_mode(xpcs, interface);
> -	} else if (xpcs->interface != interface) {
> -		if (interface == PHY_INTERFACE_MODE_SGMII)
> -			xpcs->need_reset = true;
> -		xpcs->interface = interface;
> -	}
> +	xpcs->interface = interface;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
>  {

[ ... ]

> -	ret = xpcs_switch_interface_mode(xpcs, interface);
> -	if (ret)
> -		dev_err(&xpcs->mdiodev->dev, "switch interface failed: %pe\n",
> -			ERR_PTR(ret));
> +	/*
> +	 * According to the XPCS datasheet, a soft reset is required to initiate
> +	 * Clause 37 auto-negotiation when the XPCS switches interface modes.
> +	 */
> +	force_reset = interface == PHY_INTERFACE_MODE_SGMII;

[Severity: Medium]
Does this now send a generic soft reset to Wangxun TXGBE parts every time
SGMII is configured?

Nothing here excludes WX_TXGBE_XPCS_PMA_10G_ID. Wangxun uses
synopsys_xpcs_compat, so xpcs_find_compat() returns the DW_AN_C37_SGMII
entry. xpcs_soft_reset() then writes BMCR_RESET to MDIO_MMD_VEND2 and
polls in xpcs_poll_reset(), with a 50 ms initial sleep and a 600 ms
timeout.

Until now Wangxun was kept out of the generic reset. xpcs_create() never
sets need_reset for it:

	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID ||
	    xpcs->info.pma == MP_FBNIC_XPCS_PMA_100G_ID)
		xpcs->pcs.poll = false;
	else
		xpcs->need_reset = true;

Wangxun also has its own sequence in txgbe_xpcs_switch_mode(). It first
waits for power-up-good in txgbe_pcs_poll_power_up(), then programs the
PCS type, PMA and MPLL. It ends with its own DW_VR_RST in
txgbe_pma_init_done().

The new reset now runs before that power-up-good wait. If it fails or
times out, xpcs_pre_config() returns without calling
txgbe_xpcs_switch_mode(). The SerDes could then keep its old
programming, for example the 10GBASE-R PCS type and 10G MPLL values that
txgbe_xpcs_mode_quirk() describes. phylink still goes on to pcs_config
for SGMII.

This path is reachable because txgbe_phylink_init() adds
PHY_INTERFACE_MODE_SGMII to supported_interfaces for SFP media, for
example with a copper SFP module:

phylink_start()
  phylink_mac_initial_config()
    phylink_major_config()
      phylink_pcs_pre_config()
        xpcs_pre_config()
          xpcs_soft_reset()

Should force_reset exclude WX_TXGBE_XPCS_PMA_10G_ID? The final patch in
the series ("select operating mode for 10G-baseR capable PCS") leaves
xpcs_pre_config() unchanged, so this seems to remain at the end of the
series.

[Severity: Medium]
The comment says the reset is needed when the XPCS switches interface
modes. Does the code still check for an actual switch?

Commit 065d3cef99a1 ("net: pcs: xpcs: re-initiate clause 37
Auto-negotiation") set need_reset only inside this check:

	} else if (xpcs->interface != interface) {

After this patch, the generic path writes xpcs->interface but never
compares it. Every phylink_major_config() that requests SGMII now does a
VEND2 BMCR_RESET plus at least a 50 ms sleep in xpcs_poll_reset(), even
when the interface hasn't changed.

That covers phylink_start() and phylink_resume() through
phylink_mac_initial_config(), and phylink_resolve() with
force_major_config. Non-Wangxun SGMII users are affected, for example
stmmac based Intel mGbE and SJA1105/SJA1110.

Was this intended? If so, should the comment be updated? If not, should
force_reset also check xpcs->interface != interface? The last patch in
the series doesn't change this.

>  
> -	if (!xpcs->need_reset)
> -		return;
> +	if (force_reset || xpcs->need_reset) {
> +		compat = xpcs_find_compat(xpcs, interface);
> +		if (!compat) {
> +			dev_err(dev, "unsupported interface %s\n",
> +				phy_modes(interface));
> +			return;
> +		}
>  
> -	compat = xpcs_find_compat(xpcs, interface);
> -	if (!compat) {
> -		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
> -			phy_modes(interface));
> -		return;
> +		ret = xpcs_soft_reset(xpcs, compat);
> +		if (ret) {
> +			dev_err(dev, "soft reset failed: %pe\n", ERR_PTR(ret));
> +			return;
> +		}

[Severity: Low]
Is this early return intended? Before, xpcs_switch_interface_mode()
always ran, and need_reset was cleared even when the reset failed.

Now, if xpcs_find_compat() or xpcs_soft_reset() fails,
xpcs_switch_interface_mode() is skipped and need_reset stays set.
pcs_pre_config returns void, so phylink still continues into pcs_config.

On Wangxun this means txgbe_xpcs_switch_mode() is skipped. By the end of
the series ("net: pcs: xpcs: select operating mode for 10G-baseR capable
PCS"), xpcs_switch_interface_mode() also writes the MDIO_CTRL2 PCS type.
A failed reset would then leave a 10GBASE-R capable PCS in its default
type.

need_reset is no longer cleared on failure, so every later pre_config
also retries the reset. Should the commit message mention this change in
error handling?

> +
> +		xpcs->need_reset = false;
>  	}
>  
> -	ret = xpcs_soft_reset(xpcs, compat);
> +	ret = xpcs_switch_interface_mode(xpcs, interface);
>  	if (ret)
> -		dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
> -			ERR_PTR(ret));
> -
> -	xpcs->need_reset = false;
> +		dev_err(dev, "switch interface failed: %pe\n", ERR_PTR(ret));
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014223100.304486-1-elder%40riscstar.com
