Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A630C148;
	Mon, 20 Jul 2026 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591399; cv=none; b=DS3GB+3q3N8Cf1CoM0Mk06vf2S9wvfuQF38y764oPwrAGQptVXdYuJCvBE4hDQp3jdr/k4dSkZnqaIZMZnfF6r9hcsWnuCPjE8+dS0OacmlkAOhnT2ptMwDqmuarppasnWh4Wj+83nOMkNrkCLGLvplUgauf2sgPrUh7mTL9Nag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591399; c=relaxed/simple;
	bh=UeEg5+4PGYmbkIOahJ6MkJSB/TcW7tHEXrIR/tB8N1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv2heRZ3+yOmOv2hf5N2uUtEbsD8+NLGwqZYg28DXavT8oH9td+hKfZkWZvP4s5wK9/Zqrm3TTbzWvs53oSOntaWraZLsp0t6WSYEBglauduATVACX6REqIcx91XV2t1Az7ADm+hnPXzHzC1A342nxqPtgrComHoIiQqFiPEu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDR+IjZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDR+IjZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8011F00A3A;
	Mon, 20 Jul 2026 23:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591397;
	bh=orvvw69VTVa6x9PGubwGUgGzG8A8iW7BvgJAaop1qPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UDR+IjZFTu5nX2oZoU/lsdcC2vL1a4VYWHSFCfQkhJ3/7RrtPQ7OFolntVsMSuVgE
	 C8UWphZc7hNPgye6YNY9sQzVZKRs9GVs+NfLvyQv5Q/Wiebpam0P7IrNvYmJRj7eXV
	 5y3gfUE5Tnda9sTCDFsh+gqVah27eP8d3hR2HiI+ycCFPu8n4qlXrxCrQKLUyMr32t
	 Puk7JYc2BLXratWMuQaaUJGv0VXPCcoO61m3ROxIwYUST6YpAQcuzzrgTlsnT1finB
	 2/Zd4/QZEjsJhImLmxBqoR1G45Dio6LKFLvHNGS6xqFVNmxKHfiFsRH9nc69yrKDB7
	 nOjEu5ZvMmvww==
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
Subject: Re: [PATCH net v3 2/2] octeon_ep_vf: fix skb frags overflow in the RX path
Date: Mon, 20 Jul 2026 16:49:56 -0700
Message-ID: <20260720234956.464154-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704061511.2350737-3-maoyixie.tju@gmail.com>
References: <20260704061511.2350737-3-maoyixie.tju@gmail.com>
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
octeon_ep_vf: fix skb frags overflow in the RX path

This patch adds a MAX_SKB_FRAGS check in __octep_vf_oq_process_rx() so
packets that would require more fragments than the skb can hold are
dropped, and factors the descriptor-drain loop into a new
octep_vf_oq_drop_rx() helper that is shared with the napi_build_skb()
failure path.

> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> index d98247408242..aa77b673ae3e 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> @@ -357,6 +357,29 @@ static inline u32 octep_vf_oq_next_idx(struct octep_vf_oq *oq, u32 idx)
>  	return (idx + 1 == oq->max_count) ? 0 : idx + 1;
>  }
>  
> +static void octep_vf_oq_drop_rx(struct octep_vf_oq *oq,
> +				struct octep_vf_rx_buffer *buff_info,
> +				u32 *read_idx, u32 *desc_used)
> +{
> +	u16 data_len = buff_info->len - oq->max_single_buffer_size;
> +
> +	(*desc_used)++;
> +	*read_idx = octep_vf_oq_next_idx(oq, *read_idx);
> +	while (data_len) {
> +		dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
> +			       PAGE_SIZE, DMA_FROM_DEVICE);
> +		buff_info = (struct octep_vf_rx_buffer *)
> +			    &oq->buff_info[*read_idx];
> +		buff_info->page = NULL;
> +		if (data_len < oq->buffer_size)
> +			data_len = 0;
> +		else
> +			data_len -= oq->buffer_size;
> +		(*desc_used)++;
> +		*read_idx = octep_vf_oq_next_idx(oq, *read_idx);
> +	}
> +}

[High]
Does octep_vf_oq_drop_rx() leak the pages backing the dropped
descriptors?

The helper dma_unmap_page()s each fragment descriptor and then just sets
buff_info->page = NULL, without ever calling put_page() on the page that
was allocated by dev_alloc_page() in octep_vf_oq_fill_ring_buffers() or
octep_vf_oq_refill().

Compare with octep_vf_oq_free_ring_buffers() in the same file, which
appears to be the intended release pattern:

    for (i = 0; i < oq->max_count; i++)  {
        if (oq->buff_info[i].page) {
            dma_unmap_page(oq->dev, desc_ring[i].buffer_ptr,
                           PAGE_SIZE, DMA_FROM_DEVICE);
            put_page(oq->buff_info[i].page);
            oq->buff_info[i].page = NULL;
            desc_ring[i].buffer_ptr = 0;
        }
    }

After octep_vf_oq_drop_rx() returns, octep_vf_oq_refill() will overwrite
buff_info[refill_idx].page with a freshly allocated page from
dev_alloc_page(), so the previously-mapped page pointer is lost without
a matching put_page(), isn't it?

The head descriptor of the dropped packet looks affected too. The caller
in __octep_vf_oq_process_rx() has already stashed the head page's kernel
address into resp_hw and cleared buff_info->page:

    resp_hw = page_address(buff_info->page);
    buff_info->page = NULL;

On the two paths that now call octep_vf_oq_drop_rx() (the new
MAX_SKB_FRAGS-exceeded branch and the napi_build_skb() failure branch),
napi_build_skb() is either never called or returned NULL, so no skb has
taken ownership of resp_hw. Is the head page also leaked in these cases?

> @@ -431,25 +454,16 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
>  			struct skb_shared_info *shinfo;
>  			u16 data_len;
>  
> +			data_len = buff_info->len - oq->max_single_buffer_size;
> +			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
> +				octep_vf_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
> +				continue;
> +			}
> +
>  			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
>  			if (!skb) {
>  				oq->stats->alloc_failures++;
> -				desc_used++;
> -				read_idx = octep_vf_oq_next_idx(oq, read_idx);
> -				data_len = buff_info->len - oq->max_single_buffer_size;
> -				while (data_len) {
> -					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
> -						       PAGE_SIZE, DMA_FROM_DEVICE);
> -					buff_info = (struct octep_vf_rx_buffer *)
> -						    &oq->buff_info[read_idx];
> -					buff_info->page = NULL;
> -					if (data_len < oq->buffer_size)
> -						data_len = 0;
> -					else
> -						data_len -= oq->buffer_size;
> -					desc_used++;
> -					read_idx = octep_vf_oq_next_idx(oq, read_idx);
> -				}
> +				octep_vf_oq_drop_rx(oq, buff_info, &read_idx, &desc_used);
>  				continue;
>  			}

[High]
The napi_build_skb() failure path had the same missing put_page() before
this patch, so that part is a pre-existing issue.

The newly added MAX_SKB_FRAGS check reaches octep_vf_oq_drop_rx() on a
device-triggered path (buff_info->len comes from the response header),
so a misbehaving or malicious device that repeatedly sends packets whose
fragment count exceeds MAX_SKB_FRAGS would drop roughly 18 pages per
packet with no accounting.

Would it be reasonable to have octep_vf_oq_drop_rx() put_page() the head
page (or have the caller do so before invoking it) and put_page() each
fragment page after dma_unmap_page(), mirroring the release sequence in
octep_vf_oq_free_ring_buffers()?
