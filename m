Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5718DB26
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 02:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790562488; cv=none; b=rDwgjQV5oELGfeDbi9YBu0kIkBkUN2W9PmWOIY6cHI/cWhbQFjE9zNSPWq0KPhqtYlC3v6PrqBicfg92PEYIgnvdV0b9jZavDEJbazYwv9NAZxucjbISH/tUSYt+BTG4brwTZ1MlLd5oN5YLLj1NnifE4fHANKwVH6xnGHTk0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790562488; c=relaxed/simple;
	bh=my6EIw6fL2RHtoLtIdGP5Xm3Wi74xrrvGHpEPMeYYus=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igSGWAYKDbRfY6Zahs8vuU096gvB4XLKbnF1YE/j/LV/TV+eENA4+JU8OW8bnvhrCwvB+RUh/GappD9LeNNNEPBJ7KpafLfjWPeiEXnBGwg3SjB4WrAOj68ovhaYjsGxmTq13SKFrBClfzYEDgEW0TFcoUhTotA0UeeD8KiTDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLO5GoXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLO5GoXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA041F000FF;
	Mon, 28 Sep 2026 02:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790562486;
	bh=WiZ7abzepVt4mwOrWBfGnoXCLdutKeB1HXhjf7h70YY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CLO5GoXb9G9yOfJLcnnhac+j8UPv5fAw9egA5uuke9Wji/46vS/Lp1beudvpRNCAO
	 pXQJ43w5CorC/p+0ufMmhs0pcsO71XxFAoy9VBSJtGxdB0rNIAq9b4eP8PJbQ6Z0xK
	 OjfB2a7TlQQQ1qja30gIdWMdHXgZQqPW5mhgkfws7/84fMjKkkoGIugkKNIaDwgQRE
	 GZiQ5/xnFMSYEqEI9iYuVH/dq+3dbjeDxSo4H0Z/HOngY/T0BDYenYakx37a7Bj1UL
	 /5Fqjw2vRJBocyBA2F7Yu6PgxUyjL5d94I3h4XMCxqywNBiRSoork23E1KXaJeG+Kw
	 +L8w/2VlCISUA==
Subject: Re: [PATCH net v2 2/3] net: txgbe: keep MAC enabled for SP devices
 that support NCSI
From: netdev-bot+sashiko@kernel.org
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, kees@kernel.org, zhaochenguang@kylinos.cn,
 rmk+kernel@armlinux.org.uk, maciej.fijalkowski@intel.com, horms@kernel.org
Date: Mon, 28 Sep 2026 02:28:05 +0000
Message-ID: <179056248542.3145.695648739378132787@kernel.org>
In-Reply-To: <20260924020149.30800-3-jiawenwu@trustnetic.com>
References: <20260924020149.30800-3-jiawenwu@trustnetic.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix covers only one of the phylink callbacks that turn off
  the MAC transmitter.

Pre-existing issues:
- [Low] At this patch, txgbe_mac_link_down_aml() in
  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c (lines 455-468) still…
- [Low] The new condition in txgbe_mac_link_down() (txgbe_phy.c:185)
  exempts only NCSI devices.

--

net: txgbe: keep MAC enabled for SP devices that support NCSI

This patch makes txgbe_mac_link_down() stop clearing WX_MAC_TX_CFG_TE when
the subsystem device ID shows NCSI support. The aim is to keep the MAC
transmitter on after link-down on SP devices, so NCSI keeps working.
Other devices keep the existing link-down handling.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index dc9f243146580..d11f26dc13e92 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -182,7 +182,8 @@ static void txgbe_mac_link_down(struct phylink_config *config,
>  {
>  	struct wx *wx = phylink_to_wx(config);
>  
> -	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
> +	if (!((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP))
> +		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);

[Severity: Medium]
Does this keep the transmitter on for NCSI boards in all cases? Another
callback in the same txgbe_mac_ops still clears TE with no NCSI check:

drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c:txgbe_mac_prepare() {
    ...
	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
    ...
}

txgbe_mac_finish() turns the SEC TX path and MAC RX back on, but not TE:

drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c:txgbe_mac_finish() {
    ...
	txgbe_enable_sec_tx_path(wx);
	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, WX_MAC_RX_CFG_RE);
    ...
}

So TE is only set again in txgbe_mac_link_up().

mac_prepare runs on every major config, before any link is resolved:

phylink_start()
  phylink_mac_initial_config()
    phylink_major_config()
      txgbe_mac_prepare()

Resume and SFP interface changes also reach this path.

Here is a sequence on an NCSI SP board:

1. ifup with no cable. txgbe_mac_prepare() clears TE. The link never
   comes up, so txgbe_mac_link_up() never runs.

2. ifdown. phylink_stop() only calls mac_link_down if the link was up,
   so it isn't called. txgbe_disable_device() skips clearing TE for NCSI,
   but it doesn't set TE either:

	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
		/* disable mac transmiter */
		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
	}

3. The host interface stays down with TE=0. If a cable is plugged in
   later, BMC pass-through transmit would still be blocked.

Even on a normal ifup, BMC transmit appears to be blocked from
mac_prepare until link-up.

I couldn't tell from the code whether firmware or a hardware reset turns
TE back on in this state. On copper, txgbe_reset_hw() doesn't issue a
LAN reset.

The follow-up patch "net: txgbe: keep MAC enabled for AML devices that
support NCSI" only touches txgbe_aml.c. That means txgbe_mac_prepare()
and txgbe_mac_finish() are still unchanged at the end of the series.

When (subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP, should
txgbe_mac_prepare() leave TE set, or should txgbe_mac_finish() set it
again?

[Severity: Low]
This isn't a bug introduced by this patch. At this point in the series,
the AML link-down callback still clears both TX and RX on NCSI devices:

drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c:txgbe_mac_link_down_aml() {
    ...
	wr32m(wx, TXGBE_AML_MAC_TX_CFG, TXGBE_AML_MAC_TX_CFG_TE, 0);
	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
    ...
}

The next patch in the series, "net: txgbe: keep MAC enabled for AML
devices that support NCSI", wraps both writes in the same NCSI check.
This looks resolved once the whole series is applied.

[Severity: Low]
This is a pre-existing inconsistency, not something this patch
introduced. The new check only tests WX_NCSI_SUP. txgbe_disable_device()
exempts both NCSI and WOL boards from clearing the same TE bit (see the
snippet above).

This patch doesn't change anything for WOL-only boards. WOL relies on
MAC RX, which wx_disable_rx() keeps on, and txgbe doesn't implement WOL.
So I don't see a functional effect.

Is the difference between the two conditions intentional?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924020149.30800-1-jiawenwu%40trustnetic.com
