Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32838A706
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505468; cv=none; b=bdjay3KOaIfxoEc4kiLdUmi261UK8/NGKC8TyfqV2hbLWnxkre1jIse2U58+cK/maAmdNdkDMajeyoFmEPFq9soNc4KjacI8qeUUTqC/zZ/ZsX92lwfVAqcTNUIXiC0HTR1gY0IXJlxUquARyeZk89WU/OAFjxYm8ITBt4Irr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505468; c=relaxed/simple;
	bh=gzILTZ43nCE5KEXkMynV8fHIcD8UPycPKIJZXfB8tZY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jS21JlnT8/WL2bW92EyOFheshnEXie0jxlbcH8FsqulFKVKtlxf1vBl3wuwzrvbFgBHN+3tWwUHdnA3q/nKm2vzZrnrwby/EI5Igaj1dBuqjTOIkYUHmrJSOcFv4uJ95oaZ++Y3j0QEsBRK84wjLlSyiLmRNNawEZV68S2z46AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCBDXA9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCBDXA9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED65F1F00A3E;
	Fri,  4 Sep 2026 07:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788505466;
	bh=XK1IhRUr6weBmgzFWBwWIhanPrYlNuhTTYnaleGJBz0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eCBDXA9eMdrndwuY+dyOdn6jDbJGkgvFga/ymUlUUxW5iijSJT6NVovAUKU7e+ef3
	 /RjKH/VZM1xGeDuev6SR5A6hLbaP88uxshRw59aB+M1avueh039fieeaJhQpjXZHXk
	 d/CYcYzr5dz7QJog5BjjKeshiSV6iFU0r99zcNC0pf7RN/6pcjbi4ggEtUPQi+/er3
	 9cvj3lw+Y7Kaq1waZ19pGR1sO7p7FHSivHlhtwUi6kfA+VmRncfCnoM5r35L1iTZ8p
	 Z6B2lt/j6swB1mm5UGyy4hD9Qdx4PWrXnRTUGCFjV5IW3ZJ06mXsC0Ls/yCysZJhRI
	 JXxskLSNFj4/Q==
Subject: Re: [RESEND PATCH net-next] net: wangxun: refactor NCSI and WOL
 capability checks
From: netdev-bot+sashiko@kernel.org
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, horms@kernel.org, kees@kernel.org,
 aleksandr.loktionov@intel.com, weirongguang@kylinos.cn,
 zhaochenguang@kylinos.cn, u.kleine-koenig@baylibre.com
Date: Fri, 04 Sep 2026 07:04:25 +0000
Message-ID: <178850546547.4131868.7297006717950754856@kernel.org>
In-Reply-To: <95D34449BA183C54+20260901070238.78509-1-jiawenwu@trustnetic.com>
References: <95D34449BA183C54+20260901070238.78509-1-jiawenwu@trustnetic.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] Non-equivalent refactor: the shared libwx helper
  wx_disable_rx() (drivers/net/ethernet/wangxun/libwx/wx_hw.c:1316) now…
- [Low] Style/readability nit in the new code in txgbe_init_type_code()
  (drivers/net/ethernet/wangxun/txgbe/txgbe_main.c:386-387): the…

--

net: wangxun: refactor NCSI and WOL capability checks

This replaces the inline subsystem-ID bit tests for NCSI and WOL support in
wx_disable_rx() and txgbe_disable_device() with the precomputed booleans
wx->ncsi_enabled and wx->wol_hw_supported, and adds the assignment of those
two fields to txgbe_init_type_code().

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 122c4952d203f..f0046dcb54962 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -1313,8 +1313,7 @@ void wx_disable_rx(struct wx *wx)
>  		rxctrl &= ~WX_RDB_PB_CTL_RXEN;
>  		wr32(wx, WX_RDB_PB_CTL, rxctrl);
>  
> -		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
> -		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
> +		if (!(wx->ncsi_enabled || wx->wol_hw_supported)) {
>  			/* disable mac receiver */
>  			wr32m(wx, WX_MAC_RX_CFG,
>  			      WX_MAC_RX_CFG_RE, 0);

[Severity: Medium]
wx_disable_rx() is shared libwx code, so ngbe reaches this too.  Is the new
condition still equivalent for ngbe?

ngbe_init_type_code() sets ncsi_enabled with an extra OCP term:

drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:
	type_mask = (u16)(wx->subsystem_device_id & NGBE_OEM_MASK);
	ncsi_mask = wx->subsystem_device_id & WX_NCSI_MASK;
	...
	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP ||
			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;

NGBE_OEM_MASK is 0x00FF and NGBE_SUBID_OCP_CARD is 0x0040, while
WX_NCSI_MASK is 0x8000 and WX_WOL_MASK is 0x4000, so the OCP term is
independent of the two bits the old expression tested.

For an ngbe adapter with (subsystem_device_id & 0x00FF) == 0x0040 and bits
15 and 14 clear, the pre-patch expression evaluated false and the driver
cleared WX_MAC_RX_CFG_RE; after this patch ncsi_enabled is true and the
write is skipped, so WX_RDB_PB_CTL_RXEN is cleared but the MAC receiver
stays enabled.  That affects the ngbe down/reset paths that call
wx_disable_rx(): ngbe_disable_device()->wx_disable_rx(),
ngbe_reset_hw()->wx_stop_adapter()->wx_disable_rx(), and
wx_configure_rx()->wx_disable_rx().  wx_enable_rx() still sets
WX_MAC_RX_CFG_RE, so on those SKUs the enable would no longer have a
matching disable.

Also, at the baseline wx->ncsi_enabled had no readers anywhere in the
wangxun tree, so this patch gives it its first reader inside code ngbe uses,
without the patch touching ngbe.

Is the OCP term intended to apply to wx_disable_rx() as well?  If not, would
a separate strict capability field (for example ncsi_hw_supported) used by
wx_disable_rx() keep the behaviour unchanged?

The commit message says:

    There is a clean refactoring that replaces inline bitwise checks with
    precomputed boolean fields. The hardware capability of NCSI and WOL is
    obtained from the sub-system ID and do not change.

Given the ngbe OCP term, is "do not change" accurate for all wangxun
devices, and could the message spell out the ngbe behaviour change?

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index eb91c4f28ecd4..8c508aa3ce62e 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c

[ ... ]

> @@ -336,6 +335,8 @@ static void txgbe_down_suspend(struct wx *wx)
>   **/
>  static void txgbe_init_type_code(struct wx *wx)
>  {
> +	u16 ncsi_mask = wx->subsystem_device_id & WX_NCSI_MASK;
> +	u16 wol_mask = wx->subsystem_device_id & WX_WOL_MASK;
>  	u8 device_type = wx->subsystem_device_id & 0xF0;
>  
>  	switch (wx->device_id) {

[ ... ]

> @@ -381,6 +382,9 @@ static void txgbe_init_type_code(struct wx *wx)
>  		wx->media_type = wx_media_unknown;
>  		break;
>  	}
> +
> +	wx->wol_hw_supported = ((wol_mask) == WX_WOL_SUP);
> +	wx->ncsi_enabled = ((ncsi_mask) == WX_NCSI_SUP);
>  }

[Severity: Low]
This isn't a bug, but the inner parentheses around the plain locals wol_mask
and ncsi_mask in txgbe_init_type_code() are redundant:

	wx->wol_hw_supported = (wol_mask == WX_WOL_SUP);
	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP);

The two single-use locals are also declared at the top of
txgbe_init_type_code() but only consumed after both switch statements.
Would assigning the booleans directly from wx->subsystem_device_id at the
point of use, as ngbe_init_type_code() does inline, drop both locals?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/95D34449BA183C54%2B20260901070238.78509-1-jiawenwu%40trustnetic.com
