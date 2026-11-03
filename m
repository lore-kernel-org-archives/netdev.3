Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712756;
	b=Cm6IO4c00qu/cHPs+L9+SFW2JJeGPGu+XrqfqJSy7jFkq49Am1/J1Cq5BWx/igMVdMVZ
	 aUmVeDr5FTcZxUD/SafZ/9wnPLwpCBUZaNk/NR3vVPJf0ihqxstUK7MbfQBvSNDhBl9P7
	 t5x8a1Z5XNZtji46cm3+YKOkkHXHigQNik4LG4sd9f9tKbN6KOjR36G+f+1aULbzsPZh2
	 bPgf4Esbr0W7nkE5Bafr1n/luLU33xv9AMnFvEnAfqyV2WvGgtjQmDynEg9KLEiVZgoRd
	 akskg8l4vi3XQOsAMoND8gmwA7pmnTF2kqNOHIchPj/FDWkBsGonPxeyV5UbGDJDv0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712756;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=s7kzM1NgivgKy75ap7CyzzAw7v9/fdnoZtZt8pUG678=;
	b=whKT0p71AZq5jNmWY881+oKYuE9X9YXVPA9L25KvNmphp5gpmBfVSCMrvTcm3F8ar2Pu
	 c9IMwCQsecm5Xsp131Dpq066n+2GxKiuCe+dUwle+b6y6vY5RxA0w8/n9gmf5Ozm6exTz
	 CZFgDLn1Km4f/jtYiIF/4NKUuz94fB/M4QWlRq/0IpK1RNkMm+hZsysrceseL/vKiZwCI
	 QRSq9sMHAAdfN3ytRt+AaJ+QJrlI0AxRidKYcpxCLx4TjWlhJ/cPsC/UAAspYLcGqVIfH
	 AwPmEWhfLVMgXq6C6ivFK712fLF5WlgHhZo/NF5Tjc6ussCuAQnB5+n20YQDTj8N83g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igQdz32+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703C606D816
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igQdz32+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4C51F00A1A;
	Tue,  3 Nov 2026 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712755;
	bh=s7kzM1NgivgKy75ap7CyzzAw7v9/fdnoZtZt8pUG678=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=igQdz32+z5XiC+IDOqy+jfooxGH15ocFVyoFupURCYYQ0AkICj/X+dJsFrldaOs4u
	 HFM5WSR24cMjY1G+gRYWtWYIyT8t7B+jpo56ci7F2bNN1a4gC7cfQ64eXrhscijp4J
	 tRqn/AwUd4FJUfJo/UZbF5ouKoTqQgEt1z03NTunUS3EGEbl45KaEMOOCzbmMHjTgy
	 4OcX6PN3A09cwgIvZ2oMg0zzCCq6Q5zfQd0qbk/Pf9d+kHjQy3efdBHXfq0wv9rI/G
	 XCA3VceWHSMokufCq18Qpok8b5NkAYyfaXhE0yQKjsZq5rAb0dGRHigE3DTCYaP2tM
	 uVwpvwF1vbDxQ==
Subject:
 Re: [PATCH net 9/9] idpf: free stashed XSk Rx frame when releasing the queue
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org, zuomao338@gmail.com
Date: Tue, 03 Nov 2026 13:32:34 +0000
Message-ID: <179371275474.488856.9671318055273428947@kernel.org>
In-Reply-To: <20261102124950.958345-10-maciej.fijalkowski@intel.com>
References: <20261102124950.958345-10-maciej.fijalkowski@intel.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] During a live XSk pool disable (idpf_xsk_pool_setup →
  idpf_qp_switch(false) → idpf_qp_disable → idpf_clean_queue_set), the…

Pre-existing issues:
- [High] The patch now returns the stashed partial frame (rxq->xsk) to
  the XSk pool on queue release.

--

idpf: free stashed XSk Rx frame when releasing the queue

This commit frees the partial multi-buffer XSk frame stashed in rxq->xsk
and clears the pointer in idpf_xsk_clear_queue(), while the pool is still
attached. This keeps the buffers from being lost on ifdown, and keeps the
page path from reusing a stale xskb after the pool is disabled.

> diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
> index d95d3efdfd36f..5a0a1d8a7a866 100644
> --- a/drivers/net/ethernet/intel/idpf/xsk.c
> +++ b/drivers/net/ethernet/intel/idpf/xsk.c
> @@ -134,6 +134,11 @@ void idpf_xsk_clear_queue(void *q, enum virtchnl2_queue_type type)
>  		if (!idpf_queue_has_clear(XSK, rxq))
>  			return;
>  
> +		if (rxq->xsk) {
> +			libeth_xsk_buff_free_slow(rxq->xsk);

[Severity: Low]
Can this free race with the XSk SQ cleanup timer when the pool is disabled
on a running interface?

On the pool disable path:

idpf_xsk_pool_setup()
  idpf_qp_switch(false)
    idpf_qp_disable()
      idpf_clean_queue_set()

idpf_vector_to_queue_set() places the RX queues before the xsksq TX and
COMPLQ entries. So this code runs before the timer is cancelled. The only
synchronous cancel happens later, in idpf_tx_desc_rel():

	if (xdp)
		libeth_xdpsq_deinit_timer(txq->timer);

The timer runs as BH work on system_bh_highpri_wq and can return XSk
buffers to the same pool:

idpf_xsk_tx_timer()
  libeth_xdpsq_run_timer()
    idpf_xsksq_complete()
      idpf_xsksq_complete_slow()
        libeth_xdp_complete_tx()
          libeth_xsk_buff_free_slow()
            xp_free()

The timer holds only the xdpsq lock, and the Rx release path here does not
take it. xp_free() updates the pool without any locking:

	xskb->pool->free_list_cnt++;
	list_add(&xskb->list_node, &xskb->pool->free_list);

Suppose the timer is still inside idpf_xsksq_complete_slow() when
idpf_rx_desc_rel() gets here. Could both contexts then call list_add() on
pool->free_list at the same time?

The window looks narrow, since the SW marker wait drains the completion
queue first. Also, the pool is being destroyed or detached at that point.

Would it avoid this to free the stash after the xsksq timer is cancelled,
or after the Tx queues in the set are cleaned?

> +			rxq->xsk = NULL;
> +		}
> +
>  		rxq->pool = NULL;
>  		break;
>  	case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:

[Severity: High]
This isn't a bug introduced by this patch. However, the buffers still
posted on the buffer queue seem to have the same problem as the stash
fixed here. Are the xskbs in bufq->xsk_buf[] between next_to_clean and
next_to_use ever returned to the pool?

The RX_BUFFER case only clears bufq->pool. The XSK branch of
idpf_rx_buf_rel_bufq() returns early:

	if (idpf_queue_has(XSK, bufq)) {
		idpf_xskfq_rel(bufq);
		return;
	}

idpf_xskfq_rel() only calls libeth_xskfq_destroy(), which resets some
counters and then does:

	kvfree(fq->fqes);

xsk_buff_free() is never called on the buffers that libeth_xskfqe_alloc()
got from xsk_buff_alloc_batch().

For comparison, ice_xsk_clean_rx_ring() frees the stash and also every
posted buffer:

	if (rx_ring->xsk) {
		xsk_buff_free(&rx_ring->xsk->base);
		rx_ring->xsk = NULL;
	}

	while (ntc != ntu) { ... xsk_buff_free(xdp); ... }

With an AF_XDP zero-copy socket bound, wouldn't every ifdown/ifup or soft
reset (ring resize, MTU change and so on) leak up to desc_count umem frames
per buffer queue through this path?

idpf_vport_stop()
  idpf_vport_queues_rel()
    idpf_rx_desc_rel_all()
      idpf_rx_desc_rel_bufq()
        idpf_rx_buf_rel_bufq()
          idpf_xskfq_rel()
            libeth_xskfq_destroy()

The fill ring consumer has already moved past these frames. So they never
reach the Rx ring or pool->free_list. After a few resets the application
could run out of frames to post, and Rx on that queue would stop. In
unaligned mode the leaked heads also reduce pool->free_heads_cnt.

These are the same buffers "lost to user space" that the commit message
describes. Should they be released along with the stash, as
ice_xsk_clean_rx_ring() does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102124950.958345-1-maciej.fijalkowski%40intel.com
