Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBA2F0C62
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106174; cv=none; b=uR6kknQ2Zx1BXEaSggKKrucAVVjbJGoMze0sokMRu4byKYvvZ3SxPzdZ2KgOiDC69VZaGOwQ9LoHhTKIDh616NjE8ABPcneBtxjqUASt3YcveYiyIV3TMt2uyaNDkl2iS1jh0mTXvRuFcx/BouhoUMIf2hthiRotxb8HcPChTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106174; c=relaxed/simple;
	bh=glYDxczv2lzsedeFr6XM7xe0+caLdJZ1maGin78nUgw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9rSpJZV7qEfl4B72T2fjV0s8G0TdB5l3zYIGOMro0MzKrcJHGxdzvthClhVaVkOCbMyRdw/86oy9Wg/4Ecmhl28nNK2Bfm0YwY8RfVZ36DCNTRH3h/iLQ5ChWiMiNtZaL4nSi75qDtvyTnpM6jk79OjiuAdFnWwLJq5eFpyByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzcml/zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzcml/zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAB61F000FF;
	Fri, 11 Sep 2026 05:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789106172;
	bh=N2bp5REWqoBB2Ni1J3RgMgEqh9sXVi17/sXVloem1jo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jzcml/zrFx7hcAGZBc9Z4ZQ+zHbAWJhejrd+l0TjmHqr0Ss+jvSnSk4JL6sStxRH+
	 mmVKrPGG612VHHx6JdQqurIawoo9DdnZlf+rFRWfMok5b6EnuDnrKiSKkONpF9++8i
	 QhsNAF2gyMXgLxLTv4aWF6Uy5TSeR2iiAdZklS9s0cd6qTLmNP34SqkVH9H1v8jp55
	 ua1l1SEOdDt+IqHITkIbTW6qr92y3yztQSuxMeqyoEykzRtJaIsdsCeGAqobkhslci
	 HRRqaPAqRAM0HvsBFJxpBz+n272vStf1OMc3CyqaWvey723MatDpMblYzEwmcla6Zh
	 972r/m17smoUQ==
Subject:
 Re: [PATCH net-next v2] net: wangxun: refactor NCSI and WOL capability checks
From: netdev-bot+sashiko@kernel.org
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jacob.e.keller@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 zhaochenguang@kylinos.cn, u.kleine-koenig@baylibre.com,
 weirongguang@kylinos.cn
Date: Fri, 11 Sep 2026 05:56:11 +0000
Message-ID: <178910617117.219967.16402119527549649798@kernel.org>
In-Reply-To: <F76F75E3FFF42A39+20260908025416.42250-1-jiawenwu@trustnetic.com>
References: <F76F75E3FFF42A39+20260908025416.42250-1-jiawenwu@trustnetic.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The patch is presented as a pure refactor (subject "refactor
  NCSI and WOL capability checks"; body: "single source of truth",…

--

net: wangxun: refactor NCSI and WOL capability checks

This replaces the inline subsystem device ID tests in wx_disable_rx() and
txgbe_disable_device() with the cached wx->ncsi_enabled and
wx->wol_hw_supported fields, and adds initialization of those two fields
to txgbe_init_type_code().

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
>  		}

[Severity: Medium]
Is this hunk really equivalent for ngbe?  Before this change wx->ncsi_enabled
was never read anywhere in the tree, it was only assigned in
ngbe_init_type_code(), and that assignment is broader than the expression
being removed here:

drivers/net/ethernet/wangxun/ngbe/ngbe_main.c:ngbe_init_type_code() {
	type_mask = (u16)(wx->subsystem_device_id & NGBE_OEM_MASK);
	ncsi_mask = wx->subsystem_device_id & WX_NCSI_MASK;
	...
	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP ||
			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
}

So for an ngbe OCP mezzanine card (low byte of the subsystem device ID equal
to NGBE_SUBID_OCP_CARD) that has neither the NCSI nor the WOL bit set,
WX_MAC_RX_CFG_RE is no longer cleared on the paths that reach
wx_disable_rx(), namely ngbe_disable_device() on ifdown, wx_stop_adapter()
from ngbe_reset_hw(), and wx_configure_rx().

The commit message says this is intended:

    It also handles ngbe OCP mezzanine cards consistently.
    ngbe_init_type_code() sets ncsi_enabled for these cards because they
    require the MAC receiver to remain operational for out-of-band
    management, while the inline subsystem ID check does not cover the OCP
    card type.

If OCP cards do need the receiver kept alive for out-of-band management,
then current mainline drops that management traffic on every ifdown, which
would be a fix rather than a refactor.  Should that part be split into its
own patch against net with a Fixes: tag so stable can pick it up?

If OCP cards do not need it, what justifies leaving the MAC receiver enabled
after the device is brought down?

The other claim is:

    This provides a single source of truth for the capability checks and
    removes the duplicated bitwise expressions.

After this patch, ngbe_init_type_code() still computes its own values and
txgbe_init_type_code() adds a second copy of the same two bit tests:

	wx->wol_hw_supported = ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP);
	wx->ncsi_enabled = ((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP);

Isn't the duplication moved rather than removed, and doesn't ncsi_enabled now
mean two different things (NCSI bit or OCP card type in ngbe, NCSI bit only
in txgbe) for the shared wx_disable_rx() consumer?  Would a single helper in
libwx that both drivers call be closer to the stated goal?

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index eb91c4f28ecd4..0ecbd1c0e5532 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c

[ ... ]

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
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/F76F75E3FFF42A39%2B20260908025416.42250-1-jiawenwu%40trustnetic.com
