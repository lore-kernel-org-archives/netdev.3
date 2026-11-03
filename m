Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712754;
	b=Nkh8U7lE9sGd/Mz9aMHw9owzoUFTP88Fh4dFldLQAKJeCdYNRWMph1Sjxx0HQgwm1W1g
	 7UTa+yTQEOhe/cI3Uw1G8FOcFU96S5CBw1yUx/kyKnlFViATaRSyYhprnrAPz3InsQKo3
	 Bx5qMd8jwxr9ywG+K31BZPJrDi0w4wtVIjmJl/aRsSlXt4O6YFqswUHe//My/Mcm1Jz3q
	 kc4CK/391olzwKidPPca0+VbpZDaTeotfTc6VUlpDi3pmJ98I9NHtFojN6PPQHcuX79/U
	 5qp1W6rXP94KHUMOv1k4S5kOwaA/u15ZhlMCTZcgMla24YCNZ8Y9Adycd1ula+IME4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712754;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8tDggdVuMPLu0Nm/86h9JleWgGpstPouwzTKbHD6oYw=;
	b=DrfxYs0V3oRA92BnveN2xlaksQxUcpjrDb7xcoPr3BmTnNH1y8OkLWGO6+Tb2MKmlMxZ
	 nadTttfWPykPgfLppff6BYozV1olVDCvmPbBtJtgsZZu47bKCeIJhBVotxEtWZFYAvFB+
	 r6hJZbdnheqKaV1UWngfNfuYHffY/dkmNzAIImkxvLgyeXIKQ+e7Yk9WqbVu3AhcFQ2PE
	 U09DRza2GU6IJwcftkbBDngOVTJEgEEE8pNFn2vgFs7j6pOp85DSLei3JDet4InI+9GFa
	 OO3SgL4CnSjr7OFclyzd8XLRnKUreKzloUZMkEy9leLuGLoo6YvZfyfAuvhBjHjKpVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlahXMfV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EB606D805
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlahXMfV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051A01F000C1;
	Tue,  3 Nov 2026 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712753;
	bh=8tDggdVuMPLu0Nm/86h9JleWgGpstPouwzTKbHD6oYw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BlahXMfVYF59CH/HvDvTllQ/rRRp/qVDEyp/VbWi7KiYjEwKkntLcjGbDCjWvLRGM
	 wafVsTaZ1O/plBcmLBZipYjeGBGx+tqqqAyYzp/k6VRJX4ir5ITWOTrUwr0knotv2H
	 vo4p1v0EQ3f7I21pkVqFDbPklDq1VJMFbNnFNiH35lF8OnrCQea2wxeUu2Xf4iKzZL
	 H9AhIf5FpnLcJKAxOdmdiKm8uYq0UoH+sDs5mSE/xE6uOa89bpZrbA29zOoXESQQna
	 +cDMQr3Xa43Xg93rJCvXGYVKm2SIQdIDHAzgnj/3NJGtb9MlDuMvD2hc3PDHDOkq0e
	 cEua3TZRsAYDw==
Subject: Re: [PATCH net 5/9] libeth: xsk: do not free in-flight frags on
 XDP_TX completion
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org, zuomao338@gmail.com
Date: Tue, 03 Nov 2026 13:32:32 +0000
Message-ID: <179371275260.488856.17148021732889510022@kernel.org>
In-Reply-To: <20261102124950.958345-6-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-6-maciej.fijalkowski@intel.com>
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

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: when the flush inside the frag loop
  fails, XDP_FLAGS_HAS_FRAGS is never cleared.
- [Medium] With a shared XDPSQ, the late flag clear still leaves a window
  in which the current frame's own head can be completed while its frags…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits on the
  same error path the patch changes.
- [Medium] This problem wasn't introduced by this patch, but
  libeth_xdp_tx_xmit_bulk() (include/net/libeth/xdp.h) trims the number…

--

libeth: xsk: do not free in-flight frags on XDP_TX completion

This patch clears XDP_FLAGS_HAS_FRAGS on the head of a multi-buffer XSk
XDP_TX frame in libeth_xsk_tx_queue_bulk(), once all of the frame's frags
are queued. Completing the head then no longer frees whatever is on
pool->xskb_list at that moment, such as frags of a frame still being
queued or of a stashed partial Rx frame.

> diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
> index a452b7828ce4e..249b1c7407881 100644
> --- a/include/net/libeth/xsk.h
> +++ b/include/net/libeth/xsk.h
> @@ -77,11 +77,17 @@ libeth_xsk_tx_queue_bulk(struct libeth_xdp_tx_bulk *bq,
>  	if (!libeth_xsk_tx_queue_head(bq, xdp))
>  		goto out;
>  
> -	for (const struct libeth_xdp_buff *head = xdp; ; ) {
> +	for (struct libeth_xdp_buff *head = xdp; ; ) {
>  		xdp = container_of(xsk_buff_get_frag(&head->base),
>  				   typeof(*xdp), base);
> -		if (!xdp)
> +		if (!xdp) {
> +			/* Each frag is now freed via its own SQE. Freeing
> +			 * the head must not release what is on the pool's
> +			 * frag list at that time.
> +			 */
> +			xdp_buff_clear_frags_flag(&head->base);

[Severity: Medium]
With a shared XDPSQ, is the flag cleared too late here, leaving a window
open?

If the frame doesn't fit in the remaining bulk space, the in-loop
flush_bulk() writes the head into the SQ through libeth_xsk_tx_fill_buf()
(sqe->xsk = xdp; sqe->type = LIBETH_SQE_XSK_TX). It then drops the xdpsq
lock in libeth_xdp_tx_xmit_bulk() while HAS_FRAGS is still set.

After that, this CPU keeps calling xsk_buff_get_frag() without a lock, and
it clears the flag only once the list is empty.

libeth_xdpsq_id() can map several CPUs to one XDPSQ (ret %= num). In that
case the other sharer could do this:

CPU A                                  CPU B (same XDPSQ)
libeth_xsk_tx_queue_bulk()
  flush_bulk() publishes head
  xsk_buff_get_frag()                  idpf_xdp_tx_finalize()
                                         set RS, bump tail
                                       idpf_xsk_tx_prep()
                                         idpf_xsksq_complete()
                                           xsk_buff_free(head)
                                             walks pool->xskb_list
  xsk_buff_get_frag()
  xdp_buff_clear_frags_flag()

The cleanup timer could run the same completion in place of CPU B.

Could this corrupt pool->xskb_list, or free frags that CPU A then queues?

It needs the HW to complete the head before CPU A has posted the frame's
EOP descriptor, so it may be hard to hit. Still, it matches the "XDPSQ can
be completed by a bulk flush while the frags of a frame are being queued"
case in the commit message.

Would clearing the flag before the head can be published close this
window? One option is to clear it when the head is queued with
LIBETH_XDP_TX_MULTI.

>  			break;
> +		}
>  
>  		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
>  		    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_XSK))) {

[Severity: High]
Is the flag still left set when this in-loop flush fails? The new
xdp_buff_clear_frags_flag() runs only when xsk_buff_get_frag() returns
NULL, and the failure exit skips it:

	if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
	    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_XSK))) {
		ret = false;
		break;
	}

flush_bulk() returns false here when prep() reports no free descriptors
in libeth_xdp_tx_xmit_bulk():

	n = min(n, prep(xdpsq, &sq));
	if (unlikely(!n))
		goto unlock;

This flush has no LIBETH_XDP_TX_DROP, so libeth_xdp_tx_exception() keeps
the unsent entries in bq->bulk. The head therefore stays queued with
XDP_FLAGS_HAS_FRAGS set.

The frame's remaining frags stay on pool->xskb_list, and the out: label
sets LIBETH_XDP_TX_LAST on a middle frag.

At the end of the poll, __libeth_xdp_finalize_rx() calls
flush_bulk(bq, flags | LIBETH_XDP_TX_DROP). One of two things follows:

(a) The head is sent as LIBETH_SQE_XSK_TX. When it completes later (next
prep or the cleanup timer), xsk_buff_free() sees HAS_FRAGS and frees
everything on pool->xskb_list at that point. That can include the frags
of a partial Rx frame stashed in rxq->xsk. The frame is also sent
truncated, with EOP on a middle frag.

(b) The send fails and libeth_xsk_tx_return_bulk() frees the head right
away. In idpf_xskrq_poll(), idpf_xsk_finalize_rx() runs before
rxq->xsk = xdp. The frags of the frame still being assembled are on
pool->xskb_list and get freed while that frame still references them.

Isn't this the same "frags are then freed while in use ... while a
partial Rx frame is stashed" case from the commit message, still
reachable whenever the XDPSQ is full?

The orphaned frags left on pool->xskb_list would also be picked up by the
next multi-buffer frame. On XDP_TX, xsk_buff_get_frag() pops them first.
On redirect, xsk_rcv_zc() walks the list. Either way, that frame would
carry another frame's data.

Later patches in the series don't seem to touch this function.

Does this error path also need to clear the flag and free or return the
frags of this frame that were not queued?

[Severity: High]
This is a pre-existing issue, but it sits on the same error path. Each
iteration first pops a frag with xsk_buff_get_frag(), which does
list_del_init(&frag->list_node). Only then does it check whether the bulk
needs flushing.

If that flush fails, the code runs ret = false; break;. The frag that was
just popped is never passed to libeth_xsk_tx_queue_frag(), never freed,
and never put back on pool->xskb_list.

xsk_buff_free() on the head walks only pool->xskb_list, so nothing
reclaims this frag.

Does this leak one UMEM buffer each time the XDPSQ is full mid-frame?

Under sustained TX congestion with XDP_TX, the leaks would add up. That
could exhaust the buffers of the AF_XDP queue and stall Rx. A fix for the
flag handling above would probably need to cover this frag as well.

[Severity: Medium]
This isn't a bug introduced by this patch, but there is a related one in
libeth_xdp_tx_xmit_bulk(). It cuts the number of descriptors written to
the free count without rounding down to a frame boundary:

	n = min(n, prep(xdpsq, &sq));
	if (unlikely(!n))
		goto unlock;

libeth_xsk_tx_fill_buf() writes one descriptor per bulk entry, and
idpf_xdp_tx_xmit() sets EOP only on the LIBETH_XDP_TX_LAST entry:

	if (desc.flags & LIBETH_XDP_TX_LAST)
		cmd |= FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M,
				  IDPF_TX_DESC_CMD_EOP);

Suppose the cut falls inside a multi-buffer frame during the DROP flush
in __libeth_xdp_finalize_rx(). The head and earlier frags are then left
on the ring without EOP.

libeth_xdp_tx_exception() frees the rest of the frame, including the LAST
frag, through libeth_xsk_tx_return_bulk(). idpf_xdp_tx_finalize() then
sets RS and bumps the tail.

Can this hand the device an unterminated descriptor chain, with the next
frame's descriptors appended to it?

Without DROP, the frame is split across releases of the xdpsq lock. With
shared XDPSQs, another CPU could insert its own descriptors or bump the
tail in between.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102124950.958345-1-maciej.fijalkowski%40intel.com
