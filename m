Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF031B828
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430304; cv=none; b=O40hQHSAB8ZmsdM8CO6qtv+EZf9+RqQH9kx7wF9bLrkVljBNbVu5eFKfynn2lN1mR+4+g0x2O7hJ8OCWVr4ztGL0pXKKwDz6POZhe20SaXIC59ee3ht8u5X2/uoZMwosSKEkZJPpfOEzbDCVvYIkjADyArzgjC2PdSfK3mNAuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430304; c=relaxed/simple;
	bh=sSQveQgUSqkeb+MrPoWVNuPClokntRam/Kg5NcDb4hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRJgmiOzFb8Rd77eW6GtvXhC2ZGLKz2gMXxnzlt1GEuyxzDNxDzSU4NihhfWJ5YGxKNfcTE/MFFQP/HZm5H2TBLHFXAo0ekAHtDStWZiIYWp24omlrhgPKCWNuN5pthOrGFCac8nlF+Spz0TboMwN2KHD4iQ9+HgbZ0wBfvA0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H09bW9EA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H09bW9EA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FB61F000E9;
	Sat, 22 Aug 2026 20:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430303;
	bh=Z08u8d0/BvJtB3NN+tNRXqpnjPeVHnW1c3EZSuO391Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H09bW9EAKRpNmHgWPubsm+/gzoVOLmDEVXN9QRlKtA2URk63t9gMhC/9fRkRoqJdP
	 R09kTielDG+sn5vQHJQzvuiIm+fca0QnCmFMk9TsNL700Y9oLuaVrDXg1Zd4fWs4mX
	 C46fw784hcagE+RqXjHcAJAK2L8JA2Bh+4MBMJAjkxBtVEWXW5bQ+QvBzU+w8d71uM
	 5yUQuXa7hlbxN2PfKOugPpZ+tV4xeTd5URT+BOgrKRldMa6YwHlb1V+rNhKG006UiH
	 b8bnXJ09JVbQLGNkS9ck/zpRfucADea2w4/hGMVtGNx6AVoAjPFuQdE6Gss50MvqIA
	 QL2pYR+2njNwQ==
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
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2] net: libwx: fix concurrent bitmap overwrite in PTP setup
Date: Sat, 22 Aug 2026 13:25:02 -0700
Message-ID: <20260822202502.2238154-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <6C7EC12D69217315+20260818074721.45536-1-jiawenwu@trustnetic.com>
References: <6C7EC12D69217315+20260818074721.45536-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email says "Looks unrelated enough to apply this patch but also
needs fixing"
---
net: libwx: fix concurrent bitmap overwrite in PTP setup

This replaces the read-copy-writeback of wx->flags in
wx_ptp_set_timestamp_mode() with direct atomic updates of the two PTP Rx
timestamp bits, so concurrent set_bit()/clear_bit() users of wx->flags are
no longer clobbered by the memcpy() write-back.

Link: https://lore.kernel.org/all/F97867A3AA2696FD+20260817021708.37975-1-jiawenwu@trustnetic.com

Two questions below, one on the changelog and one on the code the last
hunk touches.

> This Read-Copy-Update pattern is unsafe and introduces a critical race
> condition. Other asynchronous contexts (such as Tx timeout routines or
> GPIO IRQ handlers) update individual bits in `wx->flags` concurrently
> using atomic bitops like set_bit() or clear_bit(). The memcpy() write-back
> can silently overwrite and drop these concurrent changes, potentially
> causing the driver to miss critical module reset or PCIe recovery requests.

[Severity: Low]
Could this impact description be narrowed to what exists in the driver?

A grep for tx_timeout under drivers/net/ethernet/wangxun/ finds nothing,
and the reset entry points txgbe_do_reset()/txgbe_reinit_locked() are
reached from ethtool and ndo_set_features under rtnl and operate on
wx->state, not wx->flags:

drivers/net/ethernet/wangxun/txgbe/txgbe_main.c:txgbe_reinit_locked() {
	netif_trans_update(wx->netdev);

	mutex_lock(&wx->reset_lock);
	set_bit(WX_STATE_RESETTING, wx->state);
	...
}

Similarly, there is no pci_error_handlers / io_error_detected / slot_reset
in the driver, and enum wx_pf_flags in wx_type.h has no PCIe recovery
request bit, so which flag would carry a lost "PCIe recovery request"?

The one asynchronous producer that does match the description is the hard
IRQ handler in txgbe_aml.c:

drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c:txgbe_gpio_irq_handler_aml() {
		set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
}

consumed by txgbe_module_detection_subtask() with test_and_clear_bit().
Would it be more accurate to reference only that path?

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 44f3e6505246..1165518d5522 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c

[ ... ]

> @@ -643,7 +636,8 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
>  	WX_WRITE_FLUSH(wx);
>  
>  	/* configure adapter flags only when HW is actually configured */
> -	memcpy(wx->flags, flags, sizeof(wx->flags));
> +	assign_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags, rx_tstamp);
> +	assign_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, wx->flags, rx_tstamp);
>  
>  	/* clear TX/RX timestamp state, just to be sure */
>  	wx_ptp_clear_tx_timestamp(wx);

[Severity: High]
This isn't a bug introduced by this patch, but while the flags handling in
wx_ptp_set_timestamp_mode() is being cleaned up, can the trailing
wx_ptp_clear_tx_timestamp(wx) call race with the ptp aux worker over
wx->ptp_tx_skb?

wx_ptp_set_timestamp_mode() runs from wx_hwtstamp_set() under rtnl only,
while wx_ptp_do_aux_work() -> wx_ptp_tx_hwtstamp_work() ->
wx_ptp_tx_hwtstamp() runs in the ptp kthread armed by
ptp_schedule_worker() in wx_ptp_reset() and takes no lock:

drivers/net/ethernet/wangxun/libwx/wx_ptp.c:wx_ptp_tx_hwtstamp() {
	struct sk_buff *skb = wx->ptp_tx_skb;
	...
	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPL);
	regval |= (u64)rd32ptp(wx, WX_TSC_1588_STMPH) << 32;

	wx_ptp_convert_to_hwtstamp(wx, &shhwtstamps, regval);

	wx->ptp_tx_skb = NULL;
	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
	skb_tstamp_tx(skb, &shhwtstamps);
	dev_kfree_skb_any(skb);
}

In the window after skb is cached and before wx->ptp_tx_skb is cleared, the
configuration path can free the same pointer:

drivers/net/ethernet/wangxun/libwx/wx_ptp.c:wx_ptp_clear_tx_timestamp() {
	rd32ptp(wx, WX_TSC_1588_STMPH);
	if (wx->ptp_tx_skb) {
		dev_kfree_skb_any(wx->ptp_tx_skb);
		wx->ptp_tx_skb = NULL;
	}
	clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
}

Only one reference exists, taken in wx_lib.c:wx_xmit_frame_ring():

		wx->ptp_tx_skb = skb_get(skb);
		wx->ptp_tx_start = jiffies;

so does an SIOCSHWTSTAMP or ethtool TSCONFIG_SET while a Tx timestamp is
outstanding lead to two dev_kfree_skb_any() calls on that single
reference, with skb_tstamp_tx() then touching freed memory?

There is a second ordering concern in the same area: since
wx_ptp_clear_tx_timestamp() drops WX_STATE_PTP_TX_IN_PROGRESS while the
worker is still using the old skb, can wx_xmit_frame_ring() publish a new
wx->ptp_tx_skb that the worker then overwrites with NULL, leaking it?
WX_STATE_PTP_TX_IN_PROGRESS is set on entry and cleared on exit rather
than being a lock, so it does not appear to provide mutual exclusion
between the rtnl path and the ptp kthread. Would a lock (or cancelling
the aux work before reconfiguring) be a better fit here?
