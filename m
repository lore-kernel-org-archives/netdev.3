Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81862418340;
	Thu,  1 Oct 2026 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790826006; cv=none; b=EBMD0LZYTEKWT8wdh/jR2y23zJHx+cOxx6uUrXfyIwXfO5I0mIalbFQih8cCw95Q7oK/L01W0gGYI0uFAyW0Htpcs4JAOo4fKfoBlSiKH0/8l44++0Lhvyv5riNbHQ6UC6jYILIpf6BW2xwZRlW3VY+foGVPyvEqMmQ4HjxL8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790826006; c=relaxed/simple;
	bh=C81l+ZldJyuxoaxDB7qf5qOQb/sW2lZBjDwfI7P3Gws=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fFnEz1Lk+0CQzPfPIr4puzV5j/a9zWt20SAv7LWozQtBaoE8BeZgkJnX3Gggg+kuAjk+AAhSOTSVPLbo9tlUfgWLI+vi1aLHoeOSeXgxlueVqNWUKcRUX+PZory3dQvvfizGWMrWI8FDD7R8/D+pVhljGqcLbEgpstxwZcmRm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOw6B3oi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOw6B3oi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C821F0089A;
	Thu,  1 Oct 2026 03:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790825990;
	bh=b+xmzdMuRxuEsQgE+wnQt7S7eRYbYqHz6e/Q5CMj6AI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JOw6B3oi0y2NvIqK78bnVvpoYbTtOlX9CvMREstH1qBkiKC8unJYjM+IXAgFYVVCV
	 a4Q6+4ar0TwhqI+EBRTi1LJrZGGlaBUtn81lbcO487zBeQ0BJYsWMouydNQWxMpfvv
	 rcLMCvIrp6PBKs4tyCLRxQC0/yvlznzk7tBnij6u7eTTwyETYhiwE81tmDsRNlH1vJ
	 PcnkfBG5L8WXGLzdK174n4QV28zKsKEKV3aKUTz+WZ/uaKy9EGA1bGlOhe8SGW931O
	 lVo6rDqs7OG7krPnSU4PkX9OwPb021hHKdB0XTRW6QT8pPHuTHXHZ4wnBSJHOCsEYE
	 ypp5zPCGH9lWw==
Subject: Re: [PATCH net-next v14 4/5] net: rnpgbe: Add receive mode support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Thu, 01 Oct 2026 03:39:49 +0000
Message-ID: <179082598968.434549.661297948869820884@kernel.org>
In-Reply-To: <6E780505C6AAB4EB+20260928033859.1033428-1-dong100@mucse.com>
References: <6E780505C6AAB4EB+20260928033859.1033428-1-dong100@mucse.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Every call to `rnpgbe_set_rx_mode()` in
  `drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c` briefly disables the…
- [Low] This new driver adds its receive filtering on `.ndo_set_rx_mode`,
  which the in-tree API docs mark as deprecated.

--

net: rnpgbe: Add receive mode support

This adds chip-level receive filtering for rnpgbe through ndo_set_rx_mode.
Unicast addresses go into RAR entries and multicast addresses into a
4096-bit hash table. IFF_UNICAST_FLT is advertised, with a fallback to
accept-all unicast when the RAR table is full, and IFF_PROMISC and
IFF_ALLMULTI are handled through the filter control register.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 291e77d573fe6..4e2835b71f322 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -149,3 +149,78 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
>  
>  	return 0;
>  }
> +
> +static void rnpgbe_set_rar(struct mucse_hw *hw, u32 index, const u8 *addr)
> +{
> +	u32 rar_low, rar_high;
> +
> +	/* The RAR stores the Ethernet address in reverse byte order. */
> +	rar_low = (u32)addr[5] | ((u32)addr[4] << 8) |
> +		  ((u32)addr[3] << 16) | ((u32)addr[2] << 24);
> +	rar_high = (u32)addr[1] | ((u32)addr[0] << 8) |
> +		   RNPGBE_RX_RAR_VALID;
> +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index),
> +		      rar_high & ~RNPGBE_RX_RAR_VALID);
> +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), rar_low);
> +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), rar_high);
> +}

[ ... ]

> +void rnpgbe_set_rx_mode(struct net_device *netdev)
> +{

[ ... ]

> +	/* RAR 0 always holds the interface's primary unicast address. */
> +	rnpgbe_set_rar(hw, 0, netdev->dev_addr);

[Severity: Medium]
Can this drop unicast frames sent to the station's own MAC on every
rx_mode update?

rnpgbe_set_rx_mode() always calls rnpgbe_set_rar() for RAR 0, and
rnpgbe_set_rar() writes RAR_HIGH with RNPGBE_RX_RAR_VALID cleared before it
rewrites the entry. RNPGBE_RX_UCAST_TABLE_EN is set in mcast_ctrl, and
filter_ctrl normally does not have RNPGBE_RX_FILTER_UCAST_ALL. So a frame
that is filtered while RAR 0 is invalid would not match. The same applies
to each secondary unicast entry in the netdev_for_each_uc_addr() loop.

This runs for every rx_mode change, including multicast join and leave,
which don't change the unicast table. IP_ADD_MEMBERSHIP and
IP_DROP_MEMBERSHIP need no capability and get here through:

  dev_mc_add() / dev_mc_del()
    -> __dev_set_rx_mode()
      -> rnpgbe_set_rx_mode()
        -> rnpgbe_set_rar(hw, 0, ...)

So an unprivileged user can open this window over and over. Could entries
whose contents have not changed be skipped, or updated without clearing the
valid bit first?

There also seems to be a similar window when the device enters
IFF_ALLMULTI or IFF_PROMISC. The end of the function does:

	for (i = 0; i < RNPGBE_RX_MCAST_HASH_ENTRIES; i++)
		mucse_hw_wr32(hw, RNPGBE_RX_MCAST_HASH(i), mcast_hash[i]);

	mucse_hw_wr32(hw, RNPGBE_RX_MCAST_CTRL, mcast_ctrl);
	mucse_hw_wr32(hw, RNPGBE_RX_FILTER_CTRL, filter_ctrl);

All 128 hash words are zeroed, and RNPGBE_RX_MCAST_HASH_EN is cleared,
before FILTER_CTRL gets RNPGBE_RX_FILTER_MCAST_ALL. Can traffic for
multicast groups that are already subscribed be dropped during those
writes? Writing FILTER_CTRL first for this transition might avoid that.

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 21fa78c59e5b0..73ee81f8b516b 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -43,6 +43,10 @@ static int rnpgbe_configure(struct mucse *mucse)
>  	if (err)
>  		return err;
>  
> +	netif_addr_lock_bh(mucse->netdev);
> +	rnpgbe_set_rx_mode(mucse->netdev);
> +	netif_addr_unlock_bh(mucse->netdev);
> +
>  	return rnpgbe_configure_rx(mucse);
>  }
>  
> @@ -140,9 +144,10 @@ static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
>  }
>  
>  static const struct net_device_ops rnpgbe_netdev_ops = {
> -	.ndo_open       = rnpgbe_open,
> -	.ndo_stop       = rnpgbe_close,
> -	.ndo_start_xmit = rnpgbe_xmit_frame,
> +	.ndo_open        = rnpgbe_open,
> +	.ndo_stop        = rnpgbe_close,
> +	.ndo_start_xmit  = rnpgbe_xmit_frame,
> +	.ndo_set_rx_mode = rnpgbe_set_rx_mode,

[Severity: Low]
This isn't a bug, but the ndo_set_rx_mode documentation in
include/linux/netdevice.h marks this callback as deprecated:

 *	Cannot sleep, called with netif_addr_lock_bh held.
 *	Deprecated in favor of ndo_set_rx_mode_async.

Should a new driver use ndo_set_rx_mode_async instead? Several drivers
already use it, for example bnxt, mlx5, fbnic and iavf.

Nothing breaks today. rnpgbe is not ops-locked, so __dev_set_rx_mode()
still takes the legacy path, and the check in register_netdevice() for
ops-locked drivers that lack ndo_set_rx_mode_async does not warn.

Converting later would take more than a one-line change, though (for
example, if request_ops_lock or queue_mgmt_ops is added):

- rnpgbe_set_rx_mode() returns void and walks the live dev->uc and dev->mc
  lists instead of the lists passed to the async callback.
- rnpgbe_configure() calls it directly under netif_addr_lock_bh().

The commit message only says it adds "the ndo_set_rx_mode callback" and
does not mention the deprecation. The later patch in this series, "net:
rnpgbe: Add link status handling support", keeps this design.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0A4D45AD9F6A0F14%2B20260928033701.1033196-1-dong100%40mucse.com
