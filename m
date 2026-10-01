Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C03E5A14;
	Thu,  1 Oct 2026 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845023; cv=none; b=O76QDv+cuY4EueuDyFBwozsJE5KInJJi7HI7E48pSVaiqTP2R0XR464/pM24Tnzb4H6TXVIXRr/46Q25YVS9eyPcW+8eBnR78FGppKdergXIz+COvX2ip8zOIeF8Zqc9ZZWG1yR8hyerUZsi+c0Q7JaToxuSTjrq8XQH1CxX+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845023; c=relaxed/simple;
	bh=JoFew057PuzU0ph8FIr5DsGDwT4pUJr0cpME1e+zYP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTjIpB4RjS4lfHwDfGnVDGGG1zc8kOsCwqgnhaXODigfmtbNNMOc7wjzLfdnGIzNEvPjZcq+nqlyo9vm7kdRtsCMl8Jlsq6uR8tYMEdWnNggVEmf574Be5kPzFgn52L65mzY/kGSEDNu2ZY2dkfqKdazNyuVq4qvLfEF4zhQ3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1790844949te404f0d5
X-QQ-Originating-IP: Ur+qcImwGIaLUaNXdnVX1kHlW8PJN4Dd7ndD7hyfDPQ=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 01 Oct 2026 16:55:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11498237876710437392
EX-QQ-RecipientCnt: 11
Date: Thu, 1 Oct 2026 16:55:46 +0800
From: Yibo Dong <dong100@mucse.com>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v14 4/5] net: rnpgbe: Add receive mode support
Message-ID: <DF32907A86CC02AB+20261001085546.GA53018@nic-Precision-5820-Tower>
References: <6E780505C6AAB4EB+20260928033859.1033428-1-dong100@mucse.com>
 <179082598968.434549.661297948869820884@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179082598968.434549.661297948869820884@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OD8m5i3ZB26dIgQqxgwh0j3oKGA/PR6DjYwMz4g8QkO4myW8wrUEAsoP
	zgRZ0V2jfU/KbMcRu/D2awTQGwTtQzn8VoWq7OHWmn0B0PfmqjgzCjNwTLrWRx/cQNicm7D
	26pHa+RSLNdCxKgEEq05yLxgjSK4Uq9pvj7l7qAPrWzoM33y43hN9QFNf2v3S9Civp6DBlo
	lxjlxjmLVuSaIZW2RCBF63hqUnAg85+AmEW8P1DQeBkedFIJkNj1ToLDA5NoziCkKNXI+Gg
	L684AzqRfIAlWBxLqBEx09ITqifXmnGrlkuL6C+EHvYESfP6EF0nEIz48EBEbMlO/0M1jqV
	u93bRKiysv4n7U/37lX8HykBeXcTYWnOkIZXXTjgFpCwfLSvCNijaG9shkwLHEfM5SfKvUz
	GhTTcae+UjDrUqdwvtZXW+WXE3WwnYXf15UY2I0i0PWw1xsKknxbPa9oOAr8jUlT8JHSpjF
	19xpeHyw+tiZD1fv5UzhsnphF3rglT7l1kK5DeH5roYv86XgeckfSlntHSVim2fOSiQ7XlQ
	xsysU9/rHzKfCG+ZWWswhGDT5DRp/Sf5QQA0WGIadFErFIObpGjXxxZwJy+rhL27GAvd6K3
	KJ4VTdbui/A7tP9avBo4AEoYjuvCa51+6Yijt7uaixqfyVuH5MYocjxpHaQ82clgjq8msrg
	tbxz+zHQ45g7651syQBs6MAiy91zTNQF9Yd/8IE/AlWndKxMqMXDQ1O+uJcfMIUfQD+UDTD
	jNc968MbZBluDsiPmYbmFjEw8KwF17cONdh4klQHPwJd5kKUhraqNSOBPlumCQ6xcj7kO0c
	SRmvegu9+y5FegxaNywES93rCFNbP/yQJhzzckBhsfqFOuC83148x75TvXGmbd42cVguSVw
	neYc+YuuSLCQUpHXE7vOBs4jqRZP7NHiHdJ61YR/2Ii9knuOG1j/eQjeIz6kdlvPmdkulym
	cB0mo8OXYM8LY77mXZzECiWwJSlDtyOoSP8kYwLyEQzGrMN04zS5ZlM2WwS+AXglRnJBD4X
	1ONBbnldA3+EAAqXrfR/hjvwsCcMLt4VF4txch4GmA5W3vkqCys48DnkOD4TMOKgygJaf6i
	vZvXoV2AanrX8GN/g6z54TqTo9P9XPQCmjtsTTkyFIH
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On Thu, Oct 01, 2026 at 03:39:49AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Every call to `rnpgbe_set_rx_mode()` in
>   `drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c` briefly disables the…
> - [Low] This new driver adds its receive filtering on `.ndo_set_rx_mode`,
>   which the in-tree API docs mark as deprecated.
> 
> --
> 
> net: rnpgbe: Add receive mode support
> 
> This adds chip-level receive filtering for rnpgbe through ndo_set_rx_mode.
> Unicast addresses go into RAR entries and multicast addresses into a
> 4096-bit hash table. IFF_UNICAST_FLT is advertised, with a fallback to
> accept-all unicast when the RAR table is full, and IFF_PROMISC and
> IFF_ALLMULTI are handled through the filter control register.
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 291e77d573fe6..4e2835b71f322 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -149,3 +149,78 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
> >  
> >  	return 0;
> >  }
> > +
> > +static void rnpgbe_set_rar(struct mucse_hw *hw, u32 index, const u8 *addr)
> > +{
> > +	u32 rar_low, rar_high;
> > +
> > +	/* The RAR stores the Ethernet address in reverse byte order. */
> > +	rar_low = (u32)addr[5] | ((u32)addr[4] << 8) |
> > +		  ((u32)addr[3] << 16) | ((u32)addr[2] << 24);
> > +	rar_high = (u32)addr[1] | ((u32)addr[0] << 8) |
> > +		   RNPGBE_RX_RAR_VALID;
> > +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index),
> > +		      rar_high & ~RNPGBE_RX_RAR_VALID);
> > +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), rar_low);
> > +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), rar_high);
> > +}
> 
> [ ... ]
> 
> > +void rnpgbe_set_rx_mode(struct net_device *netdev)
> > +{
> 
> [ ... ]
> 
> > +	/* RAR 0 always holds the interface's primary unicast address. */
> > +	rnpgbe_set_rar(hw, 0, netdev->dev_addr);
> 
> [Severity: Medium]
> Can this drop unicast frames sent to the station's own MAC on every
> rx_mode update?
> 
> rnpgbe_set_rx_mode() always calls rnpgbe_set_rar() for RAR 0, and
> rnpgbe_set_rar() writes RAR_HIGH with RNPGBE_RX_RAR_VALID cleared before it
> rewrites the entry. RNPGBE_RX_UCAST_TABLE_EN is set in mcast_ctrl, and
> filter_ctrl normally does not have RNPGBE_RX_FILTER_UCAST_ALL. So a frame
> that is filtered while RAR 0 is invalid would not match. The same applies
> to each secondary unicast entry in the netdev_for_each_uc_addr() loop.
> 
> This runs for every rx_mode change, including multicast join and leave,
> which don't change the unicast table. IP_ADD_MEMBERSHIP and
> IP_DROP_MEMBERSHIP need no capability and get here through:
> 
>   dev_mc_add() / dev_mc_del()
>     -> __dev_set_rx_mode()
>       -> rnpgbe_set_rx_mode()
>         -> rnpgbe_set_rar(hw, 0, ...)
> 
> So an unprivileged user can open this window over and over. Could entries
> whose contents have not changed be skipped, or updated without clearing the
> valid bit first?
> 
> There also seems to be a similar window when the device enters
> IFF_ALLMULTI or IFF_PROMISC. The end of the function does:
> 
> 	for (i = 0; i < RNPGBE_RX_MCAST_HASH_ENTRIES; i++)
> 		mucse_hw_wr32(hw, RNPGBE_RX_MCAST_HASH(i), mcast_hash[i]);
> 
> 	mucse_hw_wr32(hw, RNPGBE_RX_MCAST_CTRL, mcast_ctrl);
> 	mucse_hw_wr32(hw, RNPGBE_RX_FILTER_CTRL, filter_ctrl);
> 
> All 128 hash words are zeroed, and RNPGBE_RX_MCAST_HASH_EN is cleared,
> before FILTER_CTRL gets RNPGBE_RX_FILTER_MCAST_ALL. Can traffic for
> multicast groups that are already subscribed be dropped during those
> writes? Writing FILTER_CTRL first for this transition might avoid that.
> 
A short transition window is expected when an address actually changes,
but I agree that the current code unnecessarily invalidates unchanged RAR
entries even for multicast-only updates. I will keep the invalidate-before-update
ordering for genuinely changed entries, while skipping entries whose current
contents already match the requested address.
I will also enable multicast accept-all before clearing the hash table when
entering IFF_ALLMULTI or IFF_PROMISC, and program the hash table before disabling
accept-all when leaving those modes.
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > index 21fa78c59e5b0..73ee81f8b516b 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > @@ -43,6 +43,10 @@ static int rnpgbe_configure(struct mucse *mucse)
> >  	if (err)
> >  		return err;
> >  
> > +	netif_addr_lock_bh(mucse->netdev);
> > +	rnpgbe_set_rx_mode(mucse->netdev);
> > +	netif_addr_unlock_bh(mucse->netdev);
> > +
> >  	return rnpgbe_configure_rx(mucse);
> >  }
> >  
> > @@ -140,9 +144,10 @@ static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
> >  }
> >  
> >  static const struct net_device_ops rnpgbe_netdev_ops = {
> > -	.ndo_open       = rnpgbe_open,
> > -	.ndo_stop       = rnpgbe_close,
> > -	.ndo_start_xmit = rnpgbe_xmit_frame,
> > +	.ndo_open        = rnpgbe_open,
> > +	.ndo_stop        = rnpgbe_close,
> > +	.ndo_start_xmit  = rnpgbe_xmit_frame,
> > +	.ndo_set_rx_mode = rnpgbe_set_rx_mode,
> 
> [Severity: Low]
> This isn't a bug, but the ndo_set_rx_mode documentation in
> include/linux/netdevice.h marks this callback as deprecated:
> 
>  *	Cannot sleep, called with netif_addr_lock_bh held.
>  *	Deprecated in favor of ndo_set_rx_mode_async.
> 
> Should a new driver use ndo_set_rx_mode_async instead? Several drivers
> already use it, for example bnxt, mlx5, fbnic and iavf.
> 
> Nothing breaks today. rnpgbe is not ops-locked, so __dev_set_rx_mode()
> still takes the legacy path, and the check in register_netdevice() for
> ops-locked drivers that lack ndo_set_rx_mode_async does not warn.
> 
> Converting later would take more than a one-line change, though (for
> example, if request_ops_lock or queue_mgmt_ops is added):
> 
> - rnpgbe_set_rx_mode() returns void and walks the live dev->uc and dev->mc
>   lists instead of the lists passed to the async callback.
> - rnpgbe_configure() calls it directly under netif_addr_lock_bh().
> 
> The commit message only says it adds "the ndo_set_rx_mode callback" and
> does not mention the deprecation. The later patch in this series, "net:
> rnpgbe: Add link status handling support", keeps this design.
> 
Agreed. I will switch the driver to ndo_set_rx_mode_async.
> [ ... ]
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0A4D45AD9F6A0F14%2B20260928033701.1033196-1-dong100%40mucse.com
> 
