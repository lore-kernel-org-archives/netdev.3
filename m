Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B22E0B5C
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886852; cv=none; b=ApwbBAoFFtRDdxFGCSBK89iJORe6qoiGyo5JvNvQUZ7Kvh5d3GgsneaLwTUq09ZLsfgqdE189CKGP2VCfbC9BCtXA+k327CGzRmtZY/n+eD0mZGSOTDBTv44Be5yVqKqnmCA++zYyPdWyD3hlS9jAyUBnNEa1LiEL+0CPP0+1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886852; c=relaxed/simple;
	bh=YrSRwP2s1pmuAOrFBxHmpaZhHn2RRTZLIe91CofBOQI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEqPq6dh+LvQviMIYkZ+qXU7687BUfd58sO9MiP/0aVRAXmuOeHxJTMR35xqGDS5Qm5jwbok4Bywmb27BEWz9nmySLmuzz7l7c32Yioo6YVv5htCzxpuLFV9uYskG8+yHVLsipNLW6rzKzpCExzZNZCohcxlZxMdX+wnuvioQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdQpwkQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdQpwkQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBA61F000FF;
	Sun, 20 Sep 2026 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789886851;
	bh=ZFKMIOR038m40L7CV58QbazcC5zt6f09quaRPy61SMY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VdQpwkQ6kIkRI0r2Ngups+7I02Hfk5u+8IIlZQJX1g/Z/p0e1nrUBKghIKs0XyRx+
	 wxoh2f14FQKyrAUYTqSsqWJSbczuRMu728c6pWM+cUmlbO5oJ4nKIStG1ROs9jIp+B
	 J+t5Fg/NyQqCiYO11HYwAFqw5dvjzpNG30IQgzR0EaLWtQt5X9oEwVt6Vxf1FZ0Uau
	 6P+FQpsvURNn99erYN5oGTaSgrkVR0+KP62b0AsfOo/2+392hA9AGlBHB0R/0VY7/F
	 DD29RXAvprvktCo3xREbZ1sPT/A2tJMlXfe65PqluAiuzhg+nLedXrE5oQ5sGHr1Q3
	 LIUv4PKeUbb3A==
Subject: Re: [PATCH net-next v3] net: wangxun: use cached NCSI and WOL
 capability flags
From: netdev-bot+sashiko@kernel.org
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
 zhaochenguang@kylinos.cn
Date: Sun, 20 Sep 2026 06:47:30 +0000
Message-ID: <178988685001.2160803.3396392479402996467@kernel.org>
In-Reply-To:
 <E5215E3514E295BA+20260916063312.203457-1-jiawenwu@trustnetic.com>
References: <E5215E3514E295BA+20260916063312.203457-1-jiawenwu@trustnetic.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is submitted as a mechanical cleanup ("use cached
  NCSI and WOL capability flags") but carries a real, user-visible…

Pre-existing issues:
- [Low] Semantic overload of wx->wol_hw_supported: two libwx consumers
  now read the same field with different meanings.

--

net: wangxun: use cached NCSI and WOL capability flags

This replaces the open-coded subsystem device ID tests in wx_disable_rx()
and txgbe_disable_device() with the cached wx->ncsi_enabled and
wx->wol_hw_supported flags, and initializes both flags in
txgbe_init_type_code().  For ngbe this changes behaviour, because
ngbe_init_type_code() also sets ncsi_enabled for OCP cards.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 59cdd7d71e446..6fbfbb77646c0 100644
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
Should the ngbe behaviour change here be a separate patch with a Fixes:
tag, rather than part of a patch whose subject describes a cleanup?

For txgbe the conversion looks bit-for-bit equivalent: WX_NCSI_SUP ==
WX_NCSI_MASK == 0x8000 and WX_WOL_SUP == WX_WOL_MASK == 0x4000 in
libwx/wx_type.h, and txgbe_init_type_code() runs from txgbe_sw_init()
before the first txgbe_reset_hw() and before any
txgbe_disable_device()/wx_disable_rx() call.

The whole functional delta comes from ngbe, where ncsi_enabled covers an
extra card type:

drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_init_type_code() {
	...
	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP ||
			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
	...
}

So on an OCP card with the 0x8000 NCSI bit clear, WX_MAC_RX_CFG_RE is no
longer cleared on the paths reaching wx_disable_rx():

  ngbe_close() -> ngbe_down() -> ngbe_disable_device() -> wx_disable_rx()
  ngbe_reset_hw() -> wx_stop_adapter() -> wx_disable_rx()
  wx_configure_rx() -> wx_disable_rx()

That is a user-visible fix for dropped out-of-band management traffic.
Could it be split out and carry a Fixes: tag identifying the introducing
commit, with the stable exclusion expressed separately (for example
Cc: stable+noautosel) instead of by omitting the tag?  The commit message
says:

	No Fixes: tag is added on purpose. The broken behaviour goes back to
	the initial ngbe support in v6.2, and wx_disable_rx() has since been
	moved into libwx and reworked several times, so this does not
	cherry-pick into stable kernels in any useful form.

Without the tag, does the provenance of the fix become hard to recover,
and does bundling it with the refactor make it hard to revert or bisect
the two changes independently?

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index eb91c4f28ecd4..0ecbd1c0e5532 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -267,8 +267,7 @@ static void txgbe_disable_device(struct wx *wx)
>  		wx_set_all_vfs(wx);
>  	}
>  
> -	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
> -	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
> +	if (!(wx->ncsi_enabled || wx->wol_hw_supported)) {
>  		/* disable mac transmiter */
>  		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
>  	}

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but is
wol_hw_supported now being read with two different meanings in libwx?

In wx_get_wol()/wx_set_wol() (libwx/wx_ethtool.c) it is strictly a
hardware capability gate, with the armed state kept in wx->wol:

	if (!wx->wol_hw_supported)
		return -EOPNOTSUPP;

	wx->wol = 0;
	if (wol->wolopts & WAKE_MAGIC)
		wx->wol = WX_PSR_WKUP_CTL_MAG;

The new tests in wx_disable_rx() and txgbe_disable_device() read the same
capability flag as "the MAC has to stay alive", so after
"ethtool -s ethX wol d" leaves wx->wol == 0, the MAC receiver (and the
txgbe transmitter) is still kept enabled on any WoL-capable board.  This
matches the removed open-coded test exactly, since WX_WOL_SUP ==
WX_WOL_MASK == 0x4000, so nothing changes at runtime today.

Would testing wx->ncsi_enabled || wx->wol, or introducing a flag named
for the actual decision (keep the MAC alive for out-of-band management),
make the shared-code contract explicit?  Otherwise, narrowing
wol_hw_supported later, or wiring the WoL ethtool ops into txgbe, would
silently change whether the MAC stays enabled.

> @@ -381,6 +380,9 @@ static void txgbe_init_type_code(struct wx *wx)
>  		wx->media_type = wx_media_unknown;
>  		break;
>  	}
> +
> +	wx->wol_hw_supported = ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP);
> +	wx->ncsi_enabled = ((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP);
>  }
>  
>  /**

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/E5215E3514E295BA%2B20260916063312.203457-1-jiawenwu%40trustnetic.com
