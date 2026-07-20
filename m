Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0A30676E;
	Mon, 20 Jul 2026 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591397; cv=none; b=MzEMEelxqWFLDizrISGEwUR6df9rBGJBuy4bPFPX1Prg2FMZNdqLevdRN+XbVEA/2rG6uphKEFp+0PjvTSBi9eohZY/L+ChMt4WMn0q8VNAvwK3CUaODb9LEp1OpJP2rp3HfBftL6qTiDd6GbEsgU0LmMkHv4nA5gTnwPg5JIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591397; c=relaxed/simple;
	bh=TgEDhhxTEXPqrfT12bu74Qeaflz8pu7iXEc2m34wdOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIUcQ0P/n6ofI+hIUUZ9N6CiyQKs/nThGEeTQ8bdZ1djbb3ppqDdhwiJygBddACdrA6+Ovy7umwcl+80a+rsxNdbwKj5fWqTcnhRjaQ9BVZ/lWPF1V3dL5U6exPKLBrqNt0YO+zRxippPfFDKEkwh4Vq7B0scRWsCxZ3YgWLJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGNdrFFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGNdrFFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A6D1F000E9;
	Mon, 20 Jul 2026 23:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591396;
	bh=MklBOiX3ojrdi7L6kKSHKf3IgZPr5Tau2Nw5v/s3OlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KGNdrFFbN3XSYxiDYAqWCZsmExhcXxWEQojwUBLvzbsp18RELJ8H4h0S5PcEZdRKb
	 LRHSXsciilnJwBNBPxWGb7mBZhnvrgdCmOMXECInWsHi9adlrEebdVSyTjvz0NTrf7
	 088QlFw/FP2fJRpKL6vDWkcn+v8R+VeIENpvu1sYuKGjYPDawPhdBXbEvhtHbC40xD
	 Q/STqr0s3e/A/ANUwBYLmtom2JBbsndNiCrVeZgYvyGW03rKs1L+EwsHYbCFks2vSY
	 MeImw1XFgt7EPMU+x97dfyr8LfVrbhhR0EVxmXtOVJICnTCBl+nhcLru5KCpT2R1gG
	 J78esOHEr3g8g==
From: Jakub Kicinski <kuba@kernel.org>
To: maoyixie.tju@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	vburru@marvell.com,
	sedara@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] octeon_ep: fix skb frags overflow in the RX path
Date: Mon, 20 Jul 2026 16:49:54 -0700
Message-ID: <20260720234955.464082-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704061511.2350737-2-maoyixie.tju@gmail.com>
References: <20260704061511.2350737-2-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeon_ep: fix skb frags overflow in the RX path

This change adds a check in __octep_oq_process_rx() so that packets whose
fragment count would exceed MAX_SKB_FRAGS are dropped before build_skb()
via octep_oq_drop_rx(), mirroring the existing build_skb-failure path.

> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index e6ebc7e44a00..bdbed58c7b2a 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -453,6 +453,15 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>  
>  		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);
>  
> +		if (buff_info->len > oq->max_single_buffer_size) {
> +			u16 data_len = buff_info->len - oq->max_single_buffer_size;
> +
> +			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
> +				octep_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
> +				continue;
> +			}
> +		}
> +

[High]
Before this new check runs, the outer octep_oq_next_pkt() has already
processed the head descriptor:

    static void octep_oq_next_pkt(struct octep_oq *oq,
                                  struct octep_rx_buffer *buff_info,
                                  u32 *read_idx, u32 *desc_used)
    {
            dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
                           PAGE_SIZE, DMA_FROM_DEVICE);
            buff_info->page = NULL;
            ...
    }

At that point the head page has refcount 1 from dev_alloc_page() and no
struct sk_buff owns it yet, because build_skb() has not been called. resp_hw
is only a virtual pointer, so nothing else holds a reference to the page.

When this new path takes the continue via octep_oq_drop_rx(), the head
page is never freed — octep_oq_drop_rx() only walks fragment descriptors.

Does this drop path leak the head Rx page? The same question applies to
the pre-existing build_skb() failure path just below, but the new path
is device-triggerable in normal operation (packets larger than ~66 KB on
4 KB pages, which the commit message notes is reachable with data_len
close to 65535).

[High]
octep_oq_drop_rx() also appears to reuse the same head buff_info pointer
for every fragment descriptor:

    static void octep_oq_drop_rx(struct octep_oq *oq,
                                 struct octep_rx_buffer *buff_info,
                                 u32 *read_idx, u32 *desc_used)
    {
            int data_len = buff_info->len - oq->max_single_buffer_size;

            while (data_len > 0) {
                    octep_oq_next_pkt(oq, buff_info, read_idx, desc_used);
                    data_len -= oq->buffer_size;
            }
    }

The passed-in buff_info is the head slot's buff_info, not
&oq->buff_info[*read_idx] for each fragment. As a result
octep_oq_next_pkt() only clears the head slot's page pointer and never
NULLs the fragment slots' oq->buff_info[i].page.

Does this cause the fragment pages to be leaked on the next
octep_oq_refill(), where those non-NULL page pointers get overwritten
with a fresh dev_alloc_page() reference?

And if octep_oq_free_ring_buffers() runs before refill (netdev close or
reset), does it observe those stale page pointers and call
dma_unmap_page() on descriptor addresses that octep_oq_next_pkt() has
already unmapped inside drop_rx?

This defect predates this patch (it appears to come from the commit
that introduced octep_oq_drop_rx()), but this patch adds a new
device-triggerable call site (fragment count above MAX_SKB_FRAGS) that
would exercise it under normal jumbo Rx.

[Medium]
The new drop path silently discards the packet without updating any
counter:

> +			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
> +				octep_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
> +				continue;
> +			}

The commit message states:

    octep_oq_drop_rx() consumes its descriptors like the build_skb failure
    path.

The sibling build_skb() failure path increments oq->stats->alloc_failures,
but this new path does not, and ndo_get_stats64 (octep_get_stats64) is
not updated to bump rx_dropped either.

Should this drop bump a counter visible in ip -s link show or ethtool -S
so the loss is observable?
