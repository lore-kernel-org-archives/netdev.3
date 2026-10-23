Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748996;
	b=yIxpSvCYdXKCUdOix+y4fKthNgrk8Pqdaq4b46aXiBsMr7N3KzE+a2776ucha/BQn6L3
	 nitF6EYeKHbi9iROu4nQR5f6DGAh0kch0PFOUbvCsDq4BP9xdbpJUOlgotZquz2G7W1Ig
	 9dpFjJUZeHdux/hAL1LBjpVDT1h/pEyk0hMZVWS2HiInLfurRIHyqoGOu6i797NhTcFHr
	 a2U4CuAZ/3zWo7mG/1xjiks7MtM3Af1zff7gLfIrTiax3067lq1j8sscXO+/9qUjDY08H
	 fShuuAhgP/yvZrlrf5czop/Lgw6fIFveSb9bkT6ZJvNLL6aTkGX+C7Cw0i/8z32GNvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748996;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MZSppzeOjSzp/2G1hrnHubj44+dbtoGWV37pcWW8TSU=;
	b=hmRIwNFFsH+Xo7PMSCdwHZuPbsu0Oq0FgcyiymPypqVSG0akQTWxu/zdNMQy233CKWOH
	 xp1jnkHMlypwLGSXJRj3I8F7fHA/l+gi+6u6v8IT/ThEAdm6kFTDakybZ812D6fF30XxN
	 DbDC9yTQJDpOzX3f0LcI3UOftf2BJQNHpemJT2f6otEqlJFqL7sTsLd7NHcF8RTyLjlJc
	 g6sN4EI8G+Rfif1UYj8rIKI5vqGnbjkTCdDWgDNI9zt4/6HthubvVm1lmRHJmdswggglh
	 i3LcEuPzgAMDR0AWIiOmY2gikgx8tekgsNEshJ/enq79KSD6v/R0aDHLo3862cA6k8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSGBUPOP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF20606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSGBUPOP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90491F01825;
	Fri, 23 Oct 2026 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748996;
	bh=MZSppzeOjSzp/2G1hrnHubj44+dbtoGWV37pcWW8TSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TSGBUPOP5z9ltW8KQDBXPe+YNugNY15rAfSozG/P7MIFDkBrz/c7Ddxj7OF2Ggl69
	 higO7q7eYnrKs3GXhRuTnNDwFLsBw9zb3Iyym4DvybCM/hx+sHVYqhwOkllrqDrbB8
	 yXAxTi4E9cH3saBDE61a7rinGxUHx+NMjVOn5byWNLm4CQCz/3PdZhezBEA2KRCFiz
	 D/tHPEgA4n3VuLiq3TpCEQDAJ3lNdEa52t9Q65mWtkiTEVPFRWdpkP6dZlWKK17z8M
	 9nc75ij5n89Q2ObJN4oWNwPp+0DkFZY9EIzBYbFl1XsUcQxq+DDFkKYPb24bm2D8lY
	 GCZgW2JEDf2AQ==
Date: Fri, 23 Oct 2026 11:49:53 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Dudu Lu <phx0fer@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: xps: re-validate the queue index after
 switching to the subordinate device
Message-ID: <atsptRW6mM-JBxhE@kwain>
References: <20261021155555.68167-1-phx0fer@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021155555.68167-1-phx0fer@gmail.com>

On Wed, Oct 21, 2026 at 11:55:55PM +0800, Dudu Lu wrote:
> __netif_set_xps_queue() reassigns dev to the subordinate device
> (netdev_get_tx_queue(dev, index)->sb_dev) but keeps using index, which
> was only validated against the ORIGINAL device's queue count.  A
> subordinate with fewer TX queues than the parent's index then overflows
> sb_dev->_tx[] / the XPS map:
> 
>   BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue+0x178c/0x1ee8
>   Write of size 4 at addr ffff000005d3fae0 by task A-26-F1-S2/162
>    __netif_set_xps_queue+0x178c/0x1ee8
>    netif_set_xps_queue+0x38/0x58
>    xps_cpus_store+0x1dc/0x2b8
> 
> The store is netdev_queue_numa_node_write() on sub->_tx[index].  The
> top-of-function WARN_ON_ONCE(index >= dev->num_tx_queues) only checks the
> parent and is a debug assertion.  Re-check index against the device that
> is actually indexed once dev has been rebound.
> 
> Note this is a different defect from the "reject an out of range traffic
> class" guard (4da3b7b8b50f), which bounds tc, not index.
> 
> Fixes: ffcfe25bb50f ("net: Add support for subordinate device traffic classes")
> Assisted-by: LLM
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
> Tested base
> -----------
> Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
> Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
> is unchanged between the two, so the bug is still present there.
> Checked against linux-next next-20261021 (commit 9a482184d910): the
> affected code is unchanged there as well, so the bug is still present in
> linux-next too.
> 
> Reproducer status
> -----------------
> A reproducer was written and executed on an arm64 QEMU guest (KASAN); it
> fires at the claimed sink, and still fires on a kernel built with 4da3b7b8b50f
> applied (identity established by disassembling both kernels: same store, same
> target offset #0x160).  The guest has no SR-IOV NIC, so the reproducer stands
> in for that hardware with a small module that binds an sb_dev the same way
> netdev_bind_sb_channel_queue() does for i40e/ixgbe.  The reproducer source is
> not posted here per Documentation/process/security-bugs.rst; it is available on
> request.
> 
> Triggering conditions
> ---------------------
> CAP_NET_ADMIN to set the XPS mask.  An sb_dev is bound in-tree by
> netdev_bind_sb_channel_queue(), which the i40e and ixgbe SR-IOV paths call
> when a VF's channel is bound to the PF.  The QEMU guest used for the
> reproducer has no SR-IOV NIC, so the sb_dev binding was set up through a
> small module; the defect itself is reached in-tree on that hardware.
> 
> Notes
> -----
> Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
> (commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
> it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
> 0 warnings.
> 
>  net/core/dev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360..d5ce25144806 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2900,6 +2900,14 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
>  		/* If queue belongs to subordinate dev use its map */
>  		dev = netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
>  
> +		/* dev may now be the subordinate device, whose queue
> +		 * count can be smaller than the parent's.  index was only
> +		 * validated against the parent above, so re-check it before

The check is a WARN, not really validating against oob.

> +		 * it is used to index the (possibly different) dev->_tx[].
> +		 */
> +		if (index >= dev->real_num_tx_queues)
> +			return -EINVAL;

I don't know that area well but my understanding is while the mapping is
stored on the sb_dev, it points to queues on the dev; this would reject
valid configurations.

> +
>  		tc = netdev_txq_to_tc(dev, index);
>  		if (tc < 0 || tc >= num_tc)
>  			return -EINVAL;

Shouldn't netdev_queue_numa_node_write operate on the dev txqs instead
of the sb_dev ones?
