Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712752;
	b=UmU/1ZQ6Mt/H6cCKnE1js0amU16AxQWYjN3OL/RaXH70AoFM60ZXGC28F2PFFWBzsEgn
	 MlXV8QaK8ZckvSDvaYO4QS1dOFudqLZhoc6JeOitdLoEvn2l1ebiJ8rm4heZ5ewzTU8Xm
	 LD14Y5wFkjEnVvuuFyyBHS5281XElHiI20GsvW9lOrFFSeN7z56EbnW4YS6a9pqoVtsBZ
	 sq9Z+bjDIluSZLYXBZMCP4EYkNDX4jYz4TUapESdbytzjH4ZXxy/HCYjMNA6rTfQuaK9+
	 z3o2pe3Yur2CqS4wE9sakNF1J4dmdZlqOqyizrSqZ5xL2lLQYmTUJSRrpR8Y/j/lxww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712752;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kifEBQxt1R1Qa41zx/9bxXDWa/RxanM2HYjLF8TU7JI=;
	b=m9bw8K/OjJgHVoU1dPAVdEUCGwkuEvgAzG9kjEb2j4q5K35q7VyI32Itju9aeTkY3wF8
	 Idwmc5VQVUZTVs33NKI1eCewwhuUbkSCq6HLv/PsOvu7X1MgwNuRpI494E7/t4bicKCi5
	 PSnWBsjCsdY2n1B8PKiJmObQ54kcNR5+sk/qkVFqovXjMY8ofQjUxoLMLXOiBlkzqCaIe
	 8VDvtEnpJWI70TbvpknBwfuMp2J+EX/Tvwzkofe8RVvRZYin+I4CLtQm0gtrhO49QVz9m
	 jOnbqFSI+lR9wSNMX84ORfP577JkQ9BoCubir483bgNOo+JbSbY1hulgwqbdCJiJqDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dn1oYpt4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B68606A32C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dn1oYpt4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1C31F00919;
	Tue,  3 Nov 2026 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712751;
	bh=kifEBQxt1R1Qa41zx/9bxXDWa/RxanM2HYjLF8TU7JI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dn1oYpt4RHvXdj4WVIHVMxGKNGz1mRkySyhNpR0n2x3ceqc0hOulm03KGmUV8+Y1Y
	 9h90YGyGugKGLKVl56ZCEeBTjRz4GtUrotRh2V8Nxp74Vvqv2Xr3ZZVeET1uaFXWZy
	 KWGj9W5G5UUwSJ7Y8GgI6A/NGmYfYkugA9ET9SNQKy69+D/yTc86zi/FM8hQLyqG37
	 FHPmL7YF7a1bCQ6xfJGLeHHQ2JNsZCgtmrsi9J/Cd1ez2rQXtf58oMeKlYiRrD8HOo
	 rYZJGbpSspxyPHr5v/qJWD091nMsYBu8ObrMSD/W34sM6hkAfVzFWwyAUrSAJX9BLJ
	 8KYRPNgZ5LYEw==
Subject:
 Re: [PATCH net 2/9] i40e: xsk: fix xsk_buff_add_frag() error handling in Rx
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org, zuomao338@gmail.com
Date: Tue, 03 Nov 2026 13:32:30 +0000
Message-ID: <179371275039.488856.8029321276858150483@kernel.org>
In-Reply-To: <20261102124950.958345-3-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-3-maciej.fijalkowski@intel.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In i40e_clean_rx_irq_zc()
  (drivers/net/ethernet/intel/i40e/i40e_xsk.c), the new error path for a…
- [Medium] When xsk_buff_add_frag() fails on a non-EOP descriptor, the
  new drop path in i40e_clean_rx_irq_zc() frees the frame, sets `first =…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a high-
  severity issue in the same ntc/ntp bookkeeping.
- [Low] Claim: the struct i40e_ring comment 'next_to_clean is updated
  only on processing EOP descriptor' (i40e_txrx.h:354-356) is now stale,…

--

i40e: xsk: fix xsk_buff_add_frag() error handling in Rx

When xsk_buff_add_frag() fails, i40e_clean_rx_irq_zc() used to free the
frame but stay on the current descriptor, which could lead to retrying a
broken frame or stalling the queue. This patch frees the current buffer
along with the frame, advances next_to_clean past the failing descriptor
and treats the remaining buffers as a new frame, as ice does.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 51a05ce4c7ce8..e6ae4c7a5cb39 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -469,16 +469,24 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>  		xsk_buff_set_size(bi, size);
>  		xsk_buff_dma_sync_for_cpu(bi);
>  
> -		if (!first)
> +		if (++next_to_process == count)
> +			next_to_process = 0;
> +
> +		if (!first) {
>  			first = bi;
> -		else if (!xsk_buff_add_frag(first, bi)) {
> +		} else if (!xsk_buff_add_frag(first, bi)) {
> +			/* Drop what has been gathered so far. xp_free() skips
> +			 * @bi if it duplicates a buffer that is already on a
> +			 * pool list. Remaining buffers of this packet, if any,
> +			 * will be processed as a new packet.
> +			 */
>  			xsk_buff_free(first);

[Severity: High]
Does this drop the whole frame when the duplicate is the head itself
(bi == first) and frags are already attached?

Earlier in the loop, xsk_buff_set_size(bi, size) runs, and at this commit
it does:

include/net/xdp_sock_drv.h:xsk_buff_set_size() {
    ...
	xdp->flags = 0;
}

When bi == first, this clears XDP_FLAGS_HAS_FRAGS on the head before
xsk_buff_add_frag(first, first) returns false. xsk_buff_free(first) then
goes down the fast path:

	if (likely(!xdp_buff_has_frags(xdp)))
		goto out;

So pool->xskb_list is never drained, and only the head goes to xp_free().

With an aligned-mode fill ring such as A, B, A, wouldn't B stay on
pool->xskb_list? xsk_rcv_zc() walks the whole list:

	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {

That would emit the leftover frags with the next unrelated frame. It would
also write more descriptors than the nr_frags + 1 that were reserved.

This looks to be fixed later in the series by "xsk: do not clear frags
flag when acquiring a buffer". That patch changes xsk_buff_set_size() and
xp_alloc() to do xdp->flags &= XDP_FLAGS_HAS_FRAGS, and makes
xsk_buff_free() clear the flag. At this commit, though, the new comment's
claim that the gathered frame is dropped does not hold for this case.
Would it make sense to put that patch before this one, so bisection does
not land on this state?

> -			break;
> +			xsk_buff_free(bi);
> +			next_to_clean = next_to_process;

[Severity: Low]
This isn't a bug introduced by this patch, but the struct i40e_ring
comment in i40e_txrx.h says:

	/* Next descriptor to be processed; next_to_clean is updated only on
	 * processing EOP descriptor
	 */

This assignment now moves next_to_clean forward on a descriptor that may
not be EOP. The comment was already inaccurate before this patch, because
the non-ZC i40e_clean_rx_irq() also moves next_to_clean forward on
programming-status descriptors. Should the comment be updated?

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. It is
in the same next_to_clean/next_to_process bookkeeping. The
programming-status branch earlier in i40e_clean_rx_irq_zc() frees the
buffer but only advances next_to_process:

		if (i40e_rx_is_programming_status(qword)) {
			...
			bi = *i40e_rx_bi(rx_ring, next_to_process);
			xsk_buff_free(bi);
			if (++next_to_process == count)
				next_to_process = 0;
			continue;
		}

Suppose no frame is in progress, and the loop then exits through the
!size break. The ring is left with next_to_clean == X and
next_to_process == X + 1. On the next poll, the entry code treats this as
a partial frame:

	if (next_to_process != next_to_clean)
		first = *i40e_rx_bi(rx_ring, next_to_clean);

Can this make the freed programming-status buffer the head of the next
frame?

In the meantime, I40E_DESC_UNUSED() is based on next_to_clean, so slot X
is not refilled. The freed xskb sits on pool->free_list, though, and the
refill at the end of the poll can post it to hardware in another slot
through xp_alloc_batch()->xp_alloc_reused().

On XDP_REDIRECT, that UMEM address would go to user space while hardware
can still DMA into it. On XDP_DROP, it would be freed again while hardware
still owns it.

The non-ZC i40e_clean_rx_irq() handles this case:

			if (rx_ring->next_to_clean == ntp) {
				rx_ring->next_to_clean =
					rx_ring->next_to_process;
				cleaned_count++;
			}

Should the ZC path do the same?

> +			first = NULL;
> +			continue;
>  		}

[Severity: Medium]
What happens to the rest of the hardware frame when the failing
descriptor is not EOP?

After first = NULL and continue, the next descriptor of the same frame
becomes the head of a new packet. i40e only marks the last descriptor
(EOF), so this new packet starts in the middle of the original payload.

The hardware limits a frame to I40E_MAX_CHAINED_RX_BUFFERS, so a full
frags array cannot happen. The remaining trigger is a duplicate fill ring
address in a non-final slot, for example A, A, C with jumbo frames.

At the original frame's EOP, that descriptor goes to
i40e_handle_xdp_result_zc(). On XDP_PASS, that calls:

	i40e_process_skb_fields(rx_ring, rx_desc, skb);

This applies the original frame's ptype, checksum verdict, RSS hash and
VLAN to bytes the hardware never parsed as headers. On XDP_TX or
XDP_REDIRECT, a tail fragment would be sent out, or delivered to the
AF_XDP socket as a complete packet.

Documentation/networking/af_xdp.rst says:

  AF_XDP guarantees that only a complete packet (all frames in the
  packet) is sent to the application.

The non-ZC path in i40e_clean_rx_irq() keeps the hardware frame boundary:

		} else if (i40e_add_xdp_frag(xdp, &nfrags, rx_buffer, size) &&
			   !neop) {
			/* Overflowing packet: Drop all frags on EOP */

The commit message says this matches ice, and ice does behave the same
way. Even so, could the ZC drop path consume descriptors up to EOP before
starting a new frame?

>  
> -		if (++next_to_process == count)
> -			next_to_process = 0;
> -
>  		if (i40e_is_non_eop(rx_ring, rx_desc))
>  			continue;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102124950.958345-1-maciej.fijalkowski%40intel.com
