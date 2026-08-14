Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319830594E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737663; cv=none; b=AYpGZShNscyao52M3bp3OBwzma9hzIMq9+NXQRKCxzSfWYpGb79TvaJBjpfeAP/RbmTr8sX72TlzwCaLLaJ0gCo5zakcRxgVIUqShcSZvuoYDoOH3zZ4NjT5xHQ9hGFfInN8jonviglobKa5hIQ78rROvE6UTMAz36ZocOdESPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737663; c=relaxed/simple;
	bh=wTbyYVm20xFpL1eE9N0P4hCI3XhjJsLIb+mTbuYr9Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvbHBcqiWDCMRlAE+sl14ShaIHSO7/tFMP/qV1IzmzPq8dxxV+4CBhiqFWmrIPJ8NA7zIXaqIgCu/wOlaiqagRDJ/nwxxkDsgsBNHsZ9TVZFhnNVGN2pQiSINwa0rbzhTN1MPJmOZvGJtS+Yrx9OI077dH5xqT2OcJVKhA1LStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcKUtAcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcKUtAcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505BA1F000E9;
	Fri, 14 Aug 2026 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737661;
	bh=rr50PdXiSMwjkX0ZulbE9Lzk/+vx3f75lp+ecBp/Z4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcKUtAcwzfG4WJYCc45yqRFnilVN/Xom7Bv0dENuoK42piTYKMkwoPbQTkIE0GfZG
	 HypMG/Z1f3BuGnGqIYAuYeeHmQ6ikS53s5w3+sC8+Fnoil7jHAZILFcfHgJ27HCWb6
	 BH7C3XT7WOTP1XDgXR5Pi9gCPlWkSwoczPqeLdxPsMd+mymsZdu1DNrBt5xJg/h63q
	 hgrjrpB9hi0Is9HzyOriGnhCD9cVJmBffA4AND6BmGRtmuQSTfYNewWRxhRqbQ60VY
	 gE8Yogg/AyCOzxNiiSHYtnPbQvZ6lJk+0B/m2GxVAKJBh9YMPlQMxt7DbgZuXGG9/+
	 L3hVoi4I6mysA==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	kees@kernel.org,
	aleksandr.loktionov@intel.com,
	larysa.zaremba@intel.com,
	leitao@debian.org
Subject: Re: [PATCH net-next] net: libwx: rename wx_pf_flags to wx_flags
Date: Fri, 14 Aug 2026 13:00:53 -0700
Message-ID: <20260814200052.3211538-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <D43B3418D188B057+20260811065038.58345-1-jiawenwu@trustnetic.com>
References: <D43B3418D188B057+20260811065038.58345-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Sashiko points out a pre-existing issue. Let's fix it
first since the rename will conflict with the fix?"
---
net: libwx: rename wx_pf_flags to wx_flags

This renames enum wx_pf_flags to enum wx_flags and its terminator
WX_PF_FLAGS_NBITS to WX_FLAGS_NBITS, since the flags are used by both the
PF and VF drivers.  The three users of the old terminator name in wx_hw.c,
wx_ptp.c and wx_type.h are updated accordingly.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 3eea647c4742c..e35e854652ece 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -558,7 +558,7 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
>  {
>  	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
>  	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
> -	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
> +	DECLARE_BITMAP(flags, WX_FLAGS_NBITS);
>  	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
>  	bool is_l2 = false;
>  	u32 regval;

[Severity: Medium]
This isn't a bug introduced by this patch, but while this local bitmap is
being touched by the rename: can the copy-in/copy-out of wx->flags in
wx_ptp_set_timestamp_mode() drop bits that another CPU sets atomically?

The function snapshots the whole bitmap, changes only the two
WX_FLAG_RX_HWTSTAMP_* bits in the local copy, programs several registers,
and then writes the entire bitmap back:

drivers/net/ethernet/wangxun/libwx/wx_ptp.c:wx_ptp_set_timestamp_mode() {
	DECLARE_BITMAP(flags, WX_FLAGS_NBITS);
	...
	memcpy(flags, wx->flags, sizeof(wx->flags));
	...
	set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
	set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
	...
	WX_WRITE_FLUSH(wx);

	/* configure adapter flags only when HW is actually configured */
	memcpy(wx->flags, flags, sizeof(wx->flags));
}

All WX_FLAG_* bits fit in one unsigned long, and every other user in the
driver updates individual bits with atomic bitops.  Some of those writers do
not take rtnl, so they are not serialized against the ndo_hwtstamp_set path:

drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c:txgbe_gpio_irq_handler_aml()
	set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);

drivers/net/ethernet/wangxun/libwx/wx_err.c:wx_tx_timeout_reset()
	set_bit(WX_FLAG_NEED_DO_RESET, wx->flags);

drivers/net/ethernet/wangxun/libwx/wx_err.c:wx_tx_timeout_recovery()
	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);

So a request set between the two memcpy calls would be overwritten by the
write-back, and the service task would then find nothing to do:

drivers/net/ethernet/wangxun/txgbe/txgbe_main.c:txgbe_service_event_sfp() {
	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
		return;
	...
}

The mirror case is a bit another CPU has just cleared being restored by the
write-back, for example the clear in wx_err.c:

	if (!test_and_clear_bit(WX_FLAG_NEED_DO_RESET, wx->flags))

which would then look like a fresh reset request.

Would applying the two bit changes directly to wx->flags with set_bit() and
clear_bit() after the registers are programmed, instead of copying the whole
bitmap in and out, work here?
-- 
pw-bot: cr
