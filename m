Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B52E1F06
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408524; cv=none; b=V35cuvT54w9qkct7FF9iYx3ZK1snJoRbpwq0WZaXQDTBW1XWAGCeumtVEEbuDOE8RZCR3vIRbzHU0tuCnvATHJVQIy+fwacNJGpJd32YP0nbpJ8N9CkOiWVb0EUg/Jx6kdK+pmFjjs7/yjhpO1oXLSfyqBrnoJWRpEFlZ0/mm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408524; c=relaxed/simple;
	bh=4QLdm9O7kl6OeIHf1D7vu8J6kCt7jTEZj4tm0gcjSs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkaP5XT1kFfq/gx3SVlAs4KERk673Ynv82hvzdJJBi4EDeFCUZctq9BSadUR1ScVrUQlkDkCshmIEHtvdiMpvuum7gtPAoQJcri8gcqAa4p0hyCnNoIYOCaHTQu/hqYcPMTP3cpB8TfxBHpTBO1CFNeoLk0XdT4x60E/8d3a/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nq/ILpoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nq/ILpoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A6C1F00A3D;
	Tue, 11 Aug 2026 00:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408522;
	bh=FfywaJ7BIxWyOhQir5skv4TtdmyZV8iRpmwEb3E5p3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nq/ILpoIYAXU4674XD+LqqSyInq59TZrYTSgyhrQ/O2YEpb3UaiIxxSRr4zJskmpq
	 N3wC4lviWRnl5FAgzplRyom8ULyZvJFLp6mxBr1BMTlisIXxVA/H+KYGk0h8FIVXij
	 Qglqri8tEToPAwC0R45bhY5RticYvhGVr50ubzu5XYlRwYX3UPm8znn9c0ev4KFHC/
	 glpvme63CUQfzhnYRQcTo2haZBN3bqeuWUJKI/nnWWM+PuVGdH9kiJ5RprVeNIxjFw
	 c3J540QNGKMwW/BmeZHSStZwHzcmUoy27fWNbxDyULw80X4R/omwDE83tgYJCv3/RO
	 hl6UWZzPHBd9g==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	tactii@gmail.com,
	dima.ruinskiy@intel.com,
	aleksandr.loktionov@intel.com,
	pmenzel@molgen.mpg.de,
	michalx.cohen@intel.com
Subject: Re: [PATCH net-next 15/15] e1000e: Avoid DMA re-mapping on RX copybreak
Date: Mon, 10 Aug 2026 17:35:20 -0700
Message-ID: <20260811003520.1057053-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805213541.2281287-16-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-16-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
e1000e: Avoid DMA re-mapping on RX copybreak

The patch stops unmapping the RX buffer before the copybreak and error
checks, so recycled skbs keep their DMA mapping and only the consumed path
unmaps. The refill loop is adjusted to skip mapping when buffer_info->dma is
already set, and the copybreak path now uses dma_sync_single_for_cpu() /
dma_sync_single_for_device() around the copy.

No Link: tags are present in the commit header.

> e1000e: Avoid DMA re-mapping on RX copybreak
>
>     The buffer allocation loop is adjusted to not assume that DMA is
>     unmapped, handling mapping errors gracefully.

[Severity: Low]
Is "handling mapping errors gracefully" the whole story for the new
buffer_info->dma = 0 assignment in e1000_alloc_rx_buffers()?

Before this patch, a failed dma_map_single() there left DMA_MAPPING_ERROR
(~(dma_addr_t)0) in buffer_info->dma and broke out of the loop.
e1000_clean_rx_ring() gates its unmap on a non-zero value:

	if (buffer_info->dma) {
		if (adapter->clean_rx == e1000_clean_rx_irq)
			dma_unmap_single(&pdev->dev, buffer_info->dma,
					 adapter->rx_buffer_len,
					 DMA_FROM_DEVICE);

so a down or reset before the next refill unmapped an address that was never
mapped. The new assignment closes that, which makes this hunk a bug fix on
top of the performance work.

Would it make sense to split that one line out with a Fixes: bc7f75fa9788
tag (and possibly Cc: stable), so stable triage can see it separately from
the rest of the change?

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad4..b08bcbdb19d97 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -675,6 +675,8 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
>  		skb = buffer_info->skb;
>  		if (skb) {
>  			skb_trim(skb, 0);
> +			if (likely(buffer_info->dma))
> +				goto write_desc;
>  			goto map_skb;
>  		}
>  
> @@ -692,10 +694,12 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
>  						  DMA_FROM_DEVICE);
>  		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
>  			dev_err(&pdev->dev, "Rx DMA map failed\n");
> +			buffer_info->dma = 0;
>  			adapter->rx_dma_failed++;
>  			break;
>  		}
>  
> +write_desc:
>  		rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
>  		rx_desc->read.buffer_addr = cpu_to_le64(buffer_info->dma);
>  

[Severity: High]
This isn't a bug introduced by this patch, but should the two sibling
refill routines in the same file be brought in line with the
"buffer_info->dma == 0 means not mapped" contract this hunk makes explicit?

e1000_alloc_rx_buffers_ps() still leaves the error cookie behind:

		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
			dev_err(&pdev->dev, "Rx DMA map failed\n");
			adapter->rx_dma_failed++;
			/* cleanup skb */
			dev_kfree_skb_any(skb);
			buffer_info->skb = NULL;
			break;
		}

buffer_info->skb is cleared but buffer_info->dma keeps DMA_MAPPING_ERROR,
which is non-zero, so e1000_clean_rx_ring() on a subsequent down or reset
calls dma_unmap_single() on an address that was never mapped.

e1000_alloc_jumbo_rx_buffers() already uses the same map-skip idiom this
patch adopts, and also skips the zeroing:

		if (!buffer_info->dma) {
			buffer_info->dma = dma_map_page(&pdev->dev,
							buffer_info->page, 0,
							PAGE_SIZE,
							DMA_FROM_DEVICE);
			if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
				adapter->alloc_rx_buff_failed++;
				break;
			}
		}

After that break, rx_ring->next_to_use points at the failed entry, so the
next refill finds buffer_info->skb and buffer_info->page set, evaluates
!buffer_info->dma as false, skips the mapping and programs the descriptor:

		rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
		rx_desc->read.buffer_addr = cpu_to_le64(buffer_info->dma);

Can that arm a hardware RX descriptor with the DMA_MAPPING_ERROR cookie as
the bus address after the tail write, and is the same cookie later passed to
dma_unmap_page() from e1000_clean_rx_ring()?

> @@ -967,9 +970,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>  
>  		cleaned = true;
>  		cleaned_count++;
> -		dma_unmap_single(&pdev->dev, buffer_info->dma,
> -				 adapter->rx_buffer_len, DMA_FROM_DEVICE);
> -		buffer_info->dma = 0;
>  
>  		length = le16_to_cpu(rx_desc->wb.upper.length);
>  

[ ... ]

> @@ -994,8 +992,6 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>  
>  		if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
>  			     !(netdev->features & NETIF_F_RXALL))) {
> -			/* recycle */
> -			buffer_info->skb = skb;
>  			goto next_desc;
>  		}
>  
> @@ -1022,19 +1018,33 @@ static bool e1000_clean_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>  			struct sk_buff *new_skb =
>  				napi_alloc_skb(&adapter->napi, length);
>  			if (new_skb) {
> +				dma_sync_single_for_cpu(&pdev->dev,
> +							buffer_info->dma,
> +							adapter->rx_buffer_len,
> +							DMA_FROM_DEVICE);
>  				skb_copy_to_linear_data_offset(new_skb,
>  							       -NET_IP_ALIGN,
>  							       (skb->data -
>  								NET_IP_ALIGN),
>  							       (length +
>  								NET_IP_ALIGN));

[Severity: High]
This is a pre-existing issue, but since this hunk rewrites the block, is
this a good place to bound length against adapter->rx_buffer_len?

length comes straight from the descriptor written by the NIC:

		length = le16_to_cpu(rx_desc->wb.upper.length);

The new sync window is adapter->rx_buffer_len, while the copy source is the
ring skb and the copy size is length + NET_IP_ALIGN. Can this read past the
end of the RX buffer allocation and hand those bytes to the stack via
e1000_receive_skb() when length exceeds adapter->rx_buffer_len?

The precondition seems to be documented in the driver itself.
e1000_change_mtu() shrinks the allocation to 1522 bytes:

	/* adjust allocation if LPE protects us, and we aren't using SBP */
	if (max_frame <= (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN))
		adapter->rx_buffer_len = VLAN_ETH_FRAME_LEN + ETH_FCS_LEN;

but e1000_setup_rctl() programs the hardware size from the default case:

	switch (adapter->rx_buffer_len) {
	case 2048:
	default:
		rctl |= E1000_RCTL_SZ_2048;
		rctl &= ~E1000_RCTL_BSEX;
		break;

and sets E1000_RCTL_SBP when NETIF_F_RXALL is enabled, which is user
settable through hw_features. With rx-all on, the frame error drop above is
also bypassed, so an oversize single-descriptor frame reaches this copy.

Note the copybreak=2048 setting recommended in the commit message puts a
1523..2048 byte length inside the length < copybreak window.

The sibling e1000 driver took the corresponding fix in commit 9c72a5182ed9
("e1000: fix OOB in e1000_tbi_should_accept()"), which added:

	if (unlikely(length > adapter->rx_buffer_len))
		return false;

> +				dma_sync_single_for_device(&pdev->dev,
> +							   buffer_info->dma,
> +							   adapter->rx_buffer_len,
> +							   DMA_FROM_DEVICE);
> -				/* save the skb in buffer_info as good */
> -				buffer_info->skb = skb;
>  				skb = new_skb;
> +				goto copybreak_done;
>  			}
>  			/* else just continue with the old one */
>  		}
> -		/* end copybreak code */
> +
> +		buffer_info->skb = NULL;
> +		dma_unmap_single(&pdev->dev, buffer_info->dma,
> +				 adapter->rx_buffer_len,
> +				 DMA_FROM_DEVICE);
> +		buffer_info->dma = 0;
> +
> +copybreak_done:
>  		skb_put(skb, length);

[Severity: High]
Same unvalidated length on the fall-through path: the ring skb was allocated
with bufsz = adapter->rx_buffer_len, so can skb_put(skb, length) push
skb->tail past skb->end and reach skb_over_panic() for the oversize case
described above?

[ ... ]
