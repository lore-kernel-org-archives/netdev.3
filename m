Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080A3DD871;
	Sun, 20 Sep 2026 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892787; cv=none; b=IQszg/OEJgBg7KYXDpav0dtywDU62FDMK86UR8km70kiUTXBPKevY+Xw5quUGVQMLLJaC/z086UwcMUgcvPC7wQVQs7GYvH7qaw1wnPCcgkS3QRnZQcw4SJkDwR5fGVSHOiU/3rfUyphSYZG0iKuhu52x2MMeIxje6UhnX53do0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892787; c=relaxed/simple;
	bh=yz2MNu8D97h1xbrFTrFgFbC41kjeG+AXX5de/XFIPU0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4tJ5sWTo7syInMoL+wtZ0Jn4uRADpNVYJCERZkVJhhy/E2I6kidnfABsk2zyIIlFo6jqnOUZlo3Sl1q+q86YDXWlYcxWS7xi1YyDXcQV+31lFCz2c1eoKyjtd6v9e4uotKXOC0wXsDm+5WPBYsxEUZwAfrWCDQ3PCd+PTBpsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZkRCRD6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZkRCRD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0989F1F00893;
	Sun, 20 Sep 2026 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789892785;
	bh=sFpJA7YW7Ma8P/oP29AIm74QgZ0PTVMM0Y0QP5663ZA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XZkRCRD6ZOwKy/Ve/4LJRiMZaXWPkFP6unWrlX2xVJdHyyHsukK8ByDsPzkHqYsoJ
	 ALkdiim2oYBYe1E0pxjg1KHaBpwq4BINFIjNvpyUQgTQBBqmd5rRDDW5DmhxmWYTZm
	 e2xiTaSQnAgsYWwx5RAtQHC0WSz65QMMAlNsJskJez7+PCtVm2PbcV+Xu7bE7/ncuo
	 IcVjFYnzZc5oOi9qyKSM1Wlgv5NMNwjOs7FucwXdpLfEpCQHT2NsHMdd20E6j10TMX
	 05+yTTGEpOnMONpQOMcM+b9/cZt6B7RnhhvfdeIfp3ykC3ffiElm1c7O2yVD0UgbWK
	 pnXfNWmiPN4eQ==
Subject: Re: [PATCH net-next v1] r8169: set eee_enable_default base on LPI cap
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, linux@armlinux.org.uk,
 enelsonmoore@gmail.com, daniel@thingy.jp
Date: Sun, 20 Sep 2026 08:26:24 +0000
Message-ID: <178989278453.2160803.381463656720348350@kernel.org>
In-Reply-To: <20260916081306.184-1-javen_xu@realsil.com.cn>
References: <20260916081306.184-1-javen_xu@realsil.com.cn>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Undisclosed regression fix: the commit message describes the
  change as a new capability-derived default ("if LPI capabilities is…

--

r8169: set eee_enable_default base on LPI cap

This sets phylink_config.eee_enabled_default in rtl_init_phylink() when
rtl8169_get_lpi_caps() returns a non-zero LPI capability mask, so phylink
starts with EEE enabled on hardware that supports it.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5415ff62a2869..1d06ddff98327 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5945,6 +5945,7 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
>  	tp->phylink_config.type = PHYLINK_NETDEV;
>  	tp->phylink_config.mac_managed_pm = true;
>  	tp->phylink_config.lpi_capabilities = rtl8169_get_lpi_caps(tp);
> +	tp->phylink_config.eee_enabled_default = !!tp->phylink_config.lpi_capabilities;

[Severity: Medium]

Is this actually restoring a default that was lost in 8a3c76523e44
("r8169: add support for phylink") rather than introducing a new one?

Before the phylink conversion, r8169_mdio_register() did:

drivers/net/ethernet/realtek/r8169_main.c:r8169_mdio_register() {
	...
	tp->phydev->mac_managed_pm = true;
	if (rtl_supports_eee(tp))
		phy_support_eee(tp->phydev);
	...
}

and phy_support_eee() sets both eee_enabled and tx_lpi_enabled to true,
so EEE was on by default on every EEE-capable part. Commit 8a3c76523e44
removed that call and added rtl_init_phylink() without setting
eee_enabled_default, and phylink_create() derives its initial state from
that field:

drivers/net/phy/phylink.c:phylink_create() {
	...
	/* Set the default EEE configuration */
	pl->eee_cfg.eee_enabled = pl->config->eee_enabled_default;
	pl->eee_cfg.tx_lpi_enabled = pl->eee_cfg.eee_enabled;
	...
}

with phylink_bringup_phy() only calling phy_support_eee(phy) when
pl->eee_cfg.eee_enabled is set.

So between the two commits EEE/LPI is off by default and ethtool
--show-eee reports it disabled until userspace turns it back on.

Should this carry Fixes: 8a3c76523e44 ("r8169: add support for phylink"),
and should the changelog say that the phylink conversion dropped the
EEE-enabled-by-default behaviour instead of describing this as a new
capability-derived default? Without the tag, a tree that picks up the
conversion alone keeps the changed default.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916081306.184-1-javen_xu%40realsil.com.cn
