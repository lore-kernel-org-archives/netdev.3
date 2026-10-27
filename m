Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103433;
	b=qnIgAjBO0TmzuA7tiJpiu5j/bgvntFxdemJgLA94xwomRaxaKBylrkdky8jeuk9HYgyR
	 6lQM4JQSkYYZ2AOE7kYd6l5g9ekYM7KKc2uAaWZZp4z5ojHa4OHt8s/joupDF8w+9IFqM
	 C10wtc5zZAjCk5rLibxD1OAVIKIQ9Lz+UMwOihaqEGUys1jo5jRNi/YOQS6Na7LIbfzfw
	 Nf87CS3N/niUKl9bzORp/6JQWi5RfCcvlW7dynL3K6mc+CQXQVLmI1/cDkzgSBZjavttf
	 Z/BEqifwUcDgW8Kyeg6G3U7DhhQH95AJQ8a6p27Iw2V7cThRpOLW3/N373s7CEYX6OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103433;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zhLcwSooW/Zl3/4kxoQ1C8DWBsgBlBQ47JW1CBaiEPo=;
	b=S8FEnqC/r7FmEgYeQQyYQpF7o4QekuMsRKWP+f7/HLYwdljHWHo1+/LOGseuRfQ9/2az
	 QyIHm3ILTYazx0GmW5dKCe4T3KMD9xv90vS3+pgq9vOaFRj8Q3htMzkk0nMi3Ax5UNG82
	 KpvnAozUzsoKo0za/ry9sKSQ2X5ZolpAtS525SBGaW6UVT58U2HSMOhJsrYLN+Mx3BuOa
	 eK+AoDbRr24+ImmzDVUMnvoigQvVXiXifFsCE5u4TOJ7GPrILXx/IUH8nGn0luqtZ+gHi
	 Wfdz65UFjr2G6/BjE+/APXTX8sHlOh1J97GcjAgmHDCkyIUaREGLZdhXAHji7NbCjwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3ncMLtN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6416606A9C9;
	Tue, 27 Oct 2026 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3ncMLtN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A7A1F031E1;
	Tue, 27 Oct 2026 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793103432;
	bh=zhLcwSooW/Zl3/4kxoQ1C8DWBsgBlBQ47JW1CBaiEPo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S3ncMLtNu4FMHy2PpFAjdjOCUSrJb2RF3maO6lPfRtSaOva6SVFNNs7XKxenyjyp0
	 YeB6odigs4l6WHBhzKULdaiTUSAeUGwV+PTsT8084GG1oOLNVRHoK9cEFWfBXAqXAg
	 Ri0kqjOCbZ0uXwBH4hm856pkXOr+182RePhWqNvEHykUzLLQYU1aFFiCj8h21kG9fi
	 H6B5b/yfFbdvfcLvHJsrRE0HYlgtTcXc7lvV18GynSnGDtHd0+3xmbrEjI83dqBbJ3
	 tPC8zXnO6v1M5RlKUS4UJ3txp515dtBJzFN7jWNfLyi4liejTBtjejQxQK5mv6jv/A
	 wU7IzFb1e/pKw==
Subject: Re: [PATCH net 3/3] igb: prepare TSO and checksum offloads before TX
 timestamps
From: netdev-bot+sashiko@kernel.org
To: p@1g4.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org,
 vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com,
 aduyck@mirantis.com
Date: Tue, 27 Oct 2026 12:17:11 +0000
Message-ID: <179310343105.3134.12907560938189136535@kernel.org>
In-Reply-To: <20261026091549.605810-3-p@1g4.org>
References: <20261026091549.605810-3-p@1g4.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] igb_tx_csum() still ignores the return value of
  skb_checksum_help() (igb_main.c:6170, `default:…
- [Low] The commit message says the bug's effect is a dropped packet (TSO
  path) or an incomplete checksum (csum path), because commit…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  ixgbe_xmit_frame_ring() has the same ordering bug this series fixes in…
- [Medium] This problem wasn't introduced by this patch, but on the
  igb_tx_map() failure path, cleanup_tx_tstamp in igb_xmit_frame_ring()…
- [Medium] This problem wasn't introduced by this patch, but the
  cleanup_tx_tstamp path in igb_xmit_frame_ring() calls…

--

igb: prepare TSO and checksum offloads before TX timestamps

This patch moves the VLAN flag setup, igb_tso() and igb_tx_csum() in
igb_xmit_frame_ring() ahead of the skb_get() taken for hardware TX
timestamping. Offload preparation therefore no longer runs on a shared skb.
The timestamp flag is then ORed into first->tx_flags so the offload flags
are kept.

> igb_xmit_frame_ring() takes an extra skb reference for TX timestamping
> before transmit preparation. For GSO packets, igb_tso() calls
> skb_cow_head(), which can reach pskb_expand_head() with a shared skb
> when the header is cloned. Commit c7d8bc3dd511 ("net: skbuff: don't BUG()
> on bad arguments to pskb_expand_head()") replaced the BUG_ON() with
> -EINVAL, causing TSO preparation to fail and the packet to be dropped.

[Severity: Low]
Does this description match the tree this patch applies to?

Commit c7d8bc3dd511 doesn't appear to be an ancestor of this patch.
pskb_expand_head() here still has:

net/core/skbuff.c:pskb_expand_head() {
    ...
	BUG_ON(skb_shared(skb));
    ...
}

The same is true for the stable kernels the Fixes: tags point at.

So before this patch, both paths described in the message would hit BUG().
They would not drop the packet or skip the checksum:

igb_xmit_frame_ring() /* skb_get() */
  igb_tso()->skb_cow_head()->__skb_cow()->pskb_expand_head()

igb_xmit_frame_ring() /* skb_get() */
  igb_tx_csum()->skb_checksum_help()->skb_ensure_writable()
    ->pskb_expand_head()

The code change looks right. Could the message say that the effect is a
BUG()? Once hardware TX timestamping is enabled, an SO_TIMESTAMPING sender
can trigger it.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index d4a897a8c82c6..04c0053dbaae8 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -6559,6 +6559,21 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
>  	first->bytecount = skb->len;
>  	first->gso_segs = 1;
>  
> +	if (skb_vlan_tag_present(skb)) {
> +		tx_flags |= IGB_TX_FLAGS_VLAN;
> +		tx_flags |= (skb_vlan_tag_get(skb) << IGB_TX_FLAGS_VLAN_SHIFT);
> +	}
> +
> +	/* record initial flags and protocol */
> +	first->tx_flags = tx_flags;
> +	first->protocol = protocol;
> +
> +	tso = igb_tso(tx_ring, first, &hdr_len);
> +	if (tso < 0)
> +		goto out_drop;
> +	else if (!tso)
> +		igb_tx_csum(tx_ring, first);

[Severity: Medium]
The commit message says igb_tx_csum() ignores the error from
skb_checksum_help(). This patch removes the shared skb trigger, but can
that ignored error still happen?

igb_tx_csum() still does:

	default:
		skb_checksum_help(skb);
		goto csum_failed;

igb advertises NETIF_F_HW_CSUM. A non-GSO CHECKSUM_PARTIAL skb with an
unusual csum_offset therefore ends up here, for example one sent through
AF_PACKET or tun with a vnet_hdr.

skb_checksum_help() can still return early without writing the checksum or
setting CHECKSUM_NONE:

skb_checksum_help()
  skb_ensure_writable()
    pskb_expand_head(skb, 0, 0, GFP_ATOMIC)  /* -ENOMEM, cloned header */

The other early returns are a __skb_linearize() failure, the -EINVAL
headlen offset checks, and !skb_frags_readable().

On failure igb_tx_csum() jumps to csum_failed. Because igb_tx_csum() returns
void, igb_xmit_frame_ring() cannot drop the packet. igb_tx_map() then sends
a frame whose L4 checksum field holds only the pseudo-header partial sum.

Could igb_tx_csum() return an error so the caller can goto out_drop? That
would match how an igb_tso() failure is handled here, and what
validate_xmit_skb() does when skb_checksum_help() fails.

> +
>  	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
>  		struct igb_adapter *adapter = netdev_priv(tx_ring->netdev);
>  
> @@ -6567,6 +6582,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
>  					   &adapter->state)) {
>  			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>  			tx_flags |= IGB_TX_FLAGS_TSTAMP;
> +			first->tx_flags |= IGB_TX_FLAGS_TSTAMP;
>  
>  			adapter->ptp_tx_skb = skb_get(skb);
>  			adapter->ptp_tx_start = jiffies;

[Severity: High]
This isn't a bug introduced by this patch, but does ixgbe_xmit_frame_ring()
have the same ordering problem that this series fixes in igb and igc?

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_xmit_frame_ring() {
    ...
			adapter->ptp_tx_skb = skb_get(skb);
			adapter->ptp_tx_start = jiffies;
			schedule_work(&adapter->ptp_tx_work);
    ...
			if (skb_cow_head(skb, 0))
				goto out_drop;
    ...
	tso = ixgbe_tso(tx_ring, first, &hdr_len, &ipsec_tx);
	if (tso < 0)
		goto out_drop;
	else if (!tso)
		ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
    ...
}

After skb_get(), three paths can call pskb_expand_head() on the now shared
skb when its header is cloned:

  the DCB software VLAN skb_cow_head()
  ixgbe_tso()->skb_cow_head()->__skb_cow()
  ixgbe_tx_csum()->skb_checksum_help()->skb_ensure_writable()

In this tree that hits BUG_ON(skb_shared(skb)) in pskb_expand_head(). Once
c7d8bc3dd511 is applied, it becomes a dropped TSO packet or an ignored
checksum failure instead.

The series doesn't touch ixgbe. Should ixgbe get the same reordering?

[ ... ]

> @@ -6577,21 +6593,6 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,

[ ... ]

>  	if (igb_tx_map(tx_ring, first, hdr_len))
>  		goto cleanup_tx_tstamp;

[Severity: Medium]
This is a pre-existing issue, but on 82576 can the cleanup_tx_tstamp path
race with igb_ptp_tx_work()?

igb_xmit_frame_ring() {
    ...
cleanup_tx_tstamp:
	if (unlikely(tx_flags & IGB_TX_FLAGS_TSTAMP)) {
		...
		dev_kfree_skb_any(adapter->ptp_tx_skb);
		adapter->ptp_tx_skb = NULL;
		if (adapter->hw.mac.type == e1000_82576)
			cancel_work_sync(&adapter->ptp_tx_work);
    ...
}

The skb is freed before the work is synchronized. igb_ptp_tx_work() checks
and uses the same pointer without a lock:

igb_ptp_tx_work() {
	if (!adapter->ptp_tx_skb)
		return;

	if (time_is_before_jiffies(adapter->ptp_tx_start +
				   IGB_PTP_TX_TIMEOUT)) {
		dev_kfree_skb_any(adapter->ptp_tx_skb);
    ...
	tsynctxctl = rd32(E1000_TSYNCTXCTL);
	if (tsynctxctl & E1000_TSYNCTXCTL_VALID)
		igb_ptp_tx_hwtstamp(adapter);
    ...
}

igb_ptp_tx_hwtstamp() copies adapter->ptp_tx_skb and later calls
skb_tstamp_tx() and dev_kfree_skb_any() on that copy.

The work can be running on another CPU, either scheduled by
igb_tsync_interrupt() on E1000_TSICR_TXTS or rescheduled by itself. If it
passes the NULL check before the xmit CPU frees the skb, could it use or
free an skb that has already been freed?

To hit this, the worker would need a stale TSYNCTXCTL_VALID bit or a stale
ptp_tx_start, so it may be hard to trigger. The code comes from commit
74344e32fcc0. This patch makes it harder to reach, because igb_tso()
failures now return before IGB_TX_FLAGS_TSTAMP is set.

[Severity: Medium]
This is also pre-existing and not introduced by this patch, but is
cancel_work_sync() safe to call in this path?

igb_xmit_frame_ring() runs as ndo_start_xmit. BH is disabled under
rcu_read_lock_bh(), and the txq _xmit_lock is held. ptp_tx_work is a regular
work item, so __cancel_work_sync() calls might_sleep(). It can also block in
__flush_work() if the work is running.

With CONFIG_DEBUG_ATOMIC_SLEEP, each igb_tx_map() DMA mapping failure on a
timestamped 82576 packet would print a "sleeping function called from
invalid context" splat.

If the work is running at that moment, the xmit path would really sleep in
atomic context. That can happen because igb_ptp_tx_hwtstamp() clears
__IGB_PTP_TX_IN_PROGRESS before it calls skb_tstamp_tx(). A new timestamp
request can then start while the previous worker is still running.

After this patch, only an igb_tx_map() failure reaches this path. This code
also comes from commit 74344e32fcc0.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026091549.605810-1-p%401g4.org
