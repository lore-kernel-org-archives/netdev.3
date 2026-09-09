Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016801DA62E;
	Wed,  9 Sep 2026 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921640; cv=none; b=T2pyl73FQI+tJRb3rOpqKBrIrxSr8IiKT+Ps4Ehts5rTp6UqWLw+Dm3H9DWU+BnrDSJKXSx4CjU/g4n82H6nlYiy14BC1O1DiRshXOgD3ezZH4mDGHK2b0suwqTJyq3e57yAgnf69Gd6OEzca9mgxbD5WYpqjrjpIVXRu3IDrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921640; c=relaxed/simple;
	bh=Y4/uvQfaNAaeaQy49shc2raTT0F4gsY2zjvtCAIUsnA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sXLVfMTFKTPMWcAcO8BqkGLrZ5ZJk8AZiDpR4DR3i2iv+4wmsCaLLYM13xGzm+71YDYN2zexfIBu8bB3hMAD3HuUh2cgHyc8iBfarNlAVbg02phBpmsASTlhD9IZiHkvORgsgoLf9y7o5VIVTeU0gDSiS7eAvMVAsitFBjM8im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVrytb68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVrytb68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03C81F00A3A;
	Wed,  9 Sep 2026 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788921638;
	bh=MBhd9VYr8BvFFmih3TusNdRdgJdW9WFWWU89XE2/9M8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YVrytb68HDpOPc5HN9rZxsdWN3ycTC+35Y1lcRH/SXxUktFtTf/XkF86A+AuFR1zw
	 Dy2ziTwQoyHQqhGWgljtEY7rRcYO2UElCS83dUJO5wCNL+Kcba+lhAPUa9eZaoZjws
	 sjabJQu/oXbxMNwtNk+q9BEWqNPa/3w/kz9LzUh8tVRuNkqzuyD6SiKkaOD/+J35t4
	 Kh6P1Nrl8Yzb+aLBk8EbzQKnKicnK6ed8zwwtbrmqQNs67OnzpGXn3IC3Yp0Yjaf9P
	 ilU2DH0NirQX138RBFVOQIK45YGgcZqPPpAiK2mBqZXj6RTnBXw1kXigqrONT9dr6Z
	 YTTNBWRwj4rug==
Subject: Re: [PATCH net] octeontx2-pf: fix invalid aura pointer free
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gakula@marvell.com,
 sgoutham@marvell.com, rkannoth@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 09 Sep 2026 02:40:37 +0000
Message-ID: <178892163740.219967.5154070424316445732@kernel.org>
In-Reply-To: <20260903143941.2698880-1-nshettyj@marvell.com>
References: <20260903143941.2698880-1-nshettyj@marvell.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

- [High] The patch is a no-op: it changes `u64 ptrs[2];` to `u64 ptrs[2]
  = {0};` in `cn10k_aura_freeptr()`…
- [High] `cn10k_refill_pool_ptrs()`
  (drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c:136-142) uses `if…

Pre-existing issues:
- [High] `cn10k_aura_freeptr()` protects the shared per-CPU LMTST line
  only with `get_cpu()`/`put_cpu()` (preempt_disable), but the very same…

--

octeontx2-pf: fix invalid aura pointer free

This changes the local ptrs[2] array in cn10k_aura_freeptr() to be
zero-initialized, with the stated intent of not freeing empty or
uninitialized buffer addresses to the aura during receive buffer cleanup.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index eecee612b7b2..231fd8586b42 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -845,7 +845,7 @@ static inline void __cn10k_aura_freeptr(struct otx2_nic *pfvf, u64 aura,
>  static inline void cn10k_aura_freeptr(void *dev, int aura, u64 buf)
>  {
>  	struct otx2_nic *pfvf = dev;
> -	u64 ptrs[2];
> +	u64 ptrs[2] = {0};
>  
>  	ptrs[1] = buf;
>  	get_cpu();

[Severity: High]
Does this change have any effect on what is submitted to hardware?  Both
words of ptrs[] look like they are overwritten before they are consumed.
cn10k_aura_freeptr() assigns ptrs[1] right after the declaration:

	u64 ptrs[2] = {0};

	ptrs[1] = buf;
	get_cpu();
	/* Free only one buffer at time during init and teardown */
	__cn10k_aura_freeptr(pfvf, aura, ptrs, 2);
	put_cpu();

and __cn10k_aura_freeptr() assigns ptrs[0] unconditionally, then copies
exactly sizeof(u64) * num_ptrs (16 bytes for num_ptrs == 2) into the LMT
line before the flush:

	count_eot = (num_ptrs - 1) & 0x3ULL;
	/* Set AURA ID to free pointer */
	ptrs[0] = (count_eot << 32) | (aura & 0xFFFFF);
	...
	memcpy((u64 *)lmt_info->lmt_addr, ptrs, sizeof(u64) * num_ptrs);
	/* Perform LMTST flush */
	cn10k_lmt_flush(val, tar_addr);

So the LMTST payload appears bit-identical with and without the patch.

The commit message says "Do not free empty or uninitialized buffer addresses
to the aura.  This avoids freeing bad pointers during receive buffer
cleanup."  Where is that filtering done?  No check on buf was added, and the
receive cleanup callers still hand raw hardware-supplied addresses straight
to the aura:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:otx2_free_rcv_seg() {
	for (seg = 0; seg < sg->segs; seg++, seg_addr++)
		pfvf->hw_ops->aura_freeptr(pfvf, qidx,
					   *seg_addr & ~0x07ULL);
}

drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c:otx2_skb_add_frag() {
	pfvf->hw_ops->aura_freeptr(pfvf, qidx, iova & ~0x07ULL);
}

The other implementation of the same dev_hw_ops.aura_freeptr slot,
otx2_aura_freeptr(), is not touched either and does no validation:

	otx2_write128(buf, (u64)aura | BIT_ULL(63), addr);

Should the pointer validation live in the shared callers, or in both
freeptr implementations, instead?  As it stands the Fixes: tag and the
resulting stable backport would suggest a pointer-corruption fix landed
where the generated code is unchanged.

[Severity: High]
If the intent is to stop empty pointers reaching the aura, is
cn10k_refill_pool_ptrs() in cn10k.c the place that needs the guard?  The
num_ptrs contract of __cn10k_aura_freeptr() is one header word plus one word
per pointer, but the allocation failure path decrements it:

	int num_ptrs = 1;
	...
	while (cq->pool_ptrs) {
		if (otx2_alloc_buffer(pfvf, cq, &bufptr)) {
			if (num_ptrs--)
				__cn10k_aura_freeptr(pfvf, cq->cq_idx, ptrs,
						     num_ptrs);
			break;
		}
		...
		num_ptrs++;
		if (num_ptrs == NPA_MAX_BURST || cq->pool_ptrs == 0) {
			__cn10k_aura_freeptr(pfvf, cq->cq_idx, ptrs,
					     num_ptrs);
			num_ptrs = 1;
		}
	}

num_ptrs is never 0 there: it starts at 1 and is reset to 1 after every
burst flush, so if (num_ptrs--) is always true.  When the allocation fails
with nothing pending, __cn10k_aura_freeptr() is called with num_ptrs == 0,
which in the helper gives count_eot = (0 - 1) & 0x3 == 3, skips the
if (num_ptrs > 2) sizing block so tar_addr[6:4] stays 0 (one valid 128-bit
word announced), performs a zero-byte memcpy, and still flushes:

	memcpy((u64 *)lmt_info->lmt_addr, ptrs, sizeof(u64) * num_ptrs);
	cn10k_lmt_flush(val, tar_addr);

Since cn10k_lmt_flush() is a steorl that makes hardware read the per-CPU
LMT line at flush time, does this re-publish whatever was left in that line
by the previous flush (the previous burst's first pointer, or a stale SQE
word from cn10k_sqe_flush())?

And when the failure happens mid-burst with k pointers already stored
(num_ptrs == k + 1), the decrement makes the flush describe only k - 1
pointers, so ptrs[k] is never returned to the aura even though
cq->pool_ptrs was already decremented for it.  Is that buffer leaked?

A duplicate or stale pointer in the aura also matters at teardown, where
otx2_free_aura_ptr() drains it:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c {
		iova = otx2_aura_allocptr(pfvf, pool_id);
		while (iova) {
			if (type == AURA_NIX_RQ)
				iova -= OTX2_HEAD_ROOM;
			otx2_free_bufs(pfvf, pool, iova, size);
}

so a duplicate becomes a second put_page()/page_pool_put_full_page(), and a
zero pointer ends the while (iova) drain early, leaving the rest of the
buffers behind.  Would something like
if (num_ptrs > 1) __cn10k_aura_freeptr(pfvf, cq->cq_idx, ptrs, num_ptrs);
be closer to the intent?

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but since the
touched function is the one publishing to the shared per-CPU LMT line: is
get_cpu()/put_cpu() sufficient serialization here?  preempt_disable() does
not mask softirqs, and the same line is written and flushed from softirq
context by cn10k_refill_pool_ptrs() (NAPI), cn10k_sqe_flush()
(ndo_start_xmit) and the cn10k_ipsec transmit path.

The critical region in __cn10k_aura_freeptr() is not atomic:

	dma_wmb();
	memcpy((u64 *)lmt_info->lmt_addr, ptrs, sizeof(u64) * num_ptrs);
	/* Perform LMTST flush */
	cn10k_lmt_flush(val, tar_addr);

A process-context caller reached while the interface is up is
otx2_qos_sq_aura_pool_init() in qos_sq.c:

		err = otx2_alloc_rbuf(pfvf, pool, &bufptr, pool_id, ptr);
		if (err)
			goto sqb_free;
		pfvf->hw_ops->aura_freeptr(pfvf, pool_id, bufptr);

It is called from otx2_qos_enable_sq() via TC htb offload, which only
refuses OTX2_FLAG_INTF_DOWN, and it holds the sleeping pfvf->mbox.lock, so
BH is enabled.  If a NET_RX or NET_TX softirq lands on the same CPU between
the memcpy and the flush, does the process-context flush end up publishing
the softirq's aura/pointer pair (a duplicate free into that aura, or a stale
SQE word read as an aura plus pointer) while its own buf is never freed?

Worth noting that otx2_alloc_rbuf() immediately above wraps its work in
local_bh_disable()/local_bh_enable(), while the aura_freeptr() call right
after it runs with preempt_disable() only.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903143941.2698880-1-nshettyj%40marvell.com
