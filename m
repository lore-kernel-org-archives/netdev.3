Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17A1862;
	Wed, 13 May 2026 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636151; cv=none; b=BeOXuJqVx4nBcu3YIFvBCrHMl9BvL6STOs8J3RF09lkIbdcKTNoNu3wcUbQteDtwiWZeIJr5WiVHuiLAPTszrggtUK+kxM2KJwv5FuMdxPy4gruJ+JSQ2WUeoEkJPzZAHwdwaNTMJ3Ek3sxYJRSGQuAshB0IeU9Z6amzCwoK1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636151; c=relaxed/simple;
	bh=kB6TnAIN5mJCoz/KH2RiBztUWP5vpAlAUsa+3lLOSMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwdYf6kPjZ7bXLVZN6sUk+5n1uXeUsqvDW+uW2DRTIYvjaC1e3KbXCRq7KVoGBh8NKz3S64F5nDgCEqWf0boVta0JaiOFldXtAsEIyw3qD6xW52UgUg/OsWEb4ypIMqpPqTFOXv2mUfJrVHF1RHBrnHDjtYu9oMaOS0c2inPX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6zXZ3rU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6zXZ3rU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E11C2BCB8;
	Wed, 13 May 2026 01:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636151;
	bh=kB6TnAIN5mJCoz/KH2RiBztUWP5vpAlAUsa+3lLOSMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6zXZ3rU4hrorSzVuLGhpDe7tNF6wIPkr09Dxt/X8B06VmI3y3UOh4DASAX6NBXGv
	 68XqbaR/BsDILyVks1tr/bUDJP3E3qg2Em361QSaa2tueiMzjDCR4H2xRXxlAr1rYA
	 I2EYuTpk25pZaxFuVuJuORs/OW7ZcZfwy2KOOTPXDTVicY7c8uAavE155dQzPIMhi6
	 CReUX9N3ghKnRr87teVuoRI6szzN0CgsufRr9DzupBgs0jLkg/4r0EFtAfFRiHB9dV
	 Up4kNKsoM7FQlLatZXMHO9swJTVyFKebD0Qek9+6aC8opONHyddJCt9JlJ09JLXFFY
	 t3DypqE6yQMSw==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.dege@renesas.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	yoshihiro.shimoda.uh@renesas.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	niklas.soderlund@ragnatech.se,
	paul@pbarker.dev,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/13] net: renesas: rswitch: use device instead of net_device
Date: Tue, 12 May 2026 18:35:49 -0700
Message-ID: <20260513013549.1408370-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511-rswitch_add_vlans-v4-2-a5a225f8faae@renesas.com>
References: <20260511-rswitch_add_vlans-v4-2-a5a225f8faae@renesas.com>
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
net: renesas: rswitch: use device instead of net_device

This commit updates the driver to use struct device instead of struct
net_device for queue allocation and freeing. This prepares the code for
upcoming VLAN support where the net_device might not always be available.

> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -304,13 +304,13 @@ static int rswitch_gwca_queue_alloc_rx_buf(struct rswitch_gwca_queue *gq,
>  	return -ENOMEM;
>  }
>  
> -static void rswitch_gwca_queue_free(struct net_device *ndev,
> +static void rswitch_gwca_queue_free(struct device *dev,
>  				    struct rswitch_gwca_queue *gq)
>  {
>  	unsigned int i;
>  
>  	if (!gq->dir_tx) {
> -		dma_free_coherent(ndev->dev.parent,
> +		dma_free_coherent(dev,
>  				  sizeof(struct rswitch_ext_ts_desc) *
>  				  (gq->ring_size + 1), gq->rx_ring, gq->ring_dma);

This wasn't introduced by this patch, but if rswitch_gwca_queue_alloc()
fails during or before the dma_alloc_coherent() step, gq->rx_ring will
remain NULL.

Since dma_free_coherent() is not guaranteed to handle NULL virtual
addresses safely across all architectures, could this pass a NULL pointer
and cause a crash? Does it make sense to conditionalize the frees here
and in the tx path?

>  		gq->rx_ring = NULL;

I notice another pre-existing issue in the unquoted context just below
this. When rswitch_gwca_queue_alloc() fails, gq->rx_bufs can contain NULL
pointers.

Since the loop calls skb_free_frag(gq->rx_bufs[i]), and skb_free_frag()
wraps page_frag_free() which does not check for NULL, would this result
in an out-of-bounds page struct dereference and a kernel panic?

Would it be safer to add a NULL check before calling skb_free_frag()?

[ ... ]

> @@ -508,7 +506,7 @@ static int rswitch_gwca_queue_ext_ts_fill(struct net_device *ndev,
>  			index = (i + start_index) % gq->ring_size;
>  			desc = &gq->rx_ring[index];
>  			dma_addr = rswitch_desc_get_dptr(&desc->desc);
> -			dma_unmap_single(ndev->dev.parent, dma_addr,
> +			dma_unmap_single(dev, dma_addr,
>  					 RSWITCH_MAP_BUF_SIZE, DMA_FROM_DEVICE);
>  		}
>  	}

I noticed a concurrency issue in this pre-existing error path. Earlier in
this function, the driver transfers ownership of each descriptor to the
hardware by setting desc->desc.die_dt and executing a dma_wmb().

If a subsequent dma_map_single() fails, this error path unmaps the
previously mapped buffers but does not revoke hardware ownership by
clearing desc->desc.die_dt.

Because the hardware was already granted ownership, could it actively DMA
incoming packets into the unmapped memory before the device is finally
halted? Would it be safer to clear the ownership flag and issue a memory
barrier before unmapping the buffers?
-- 
pw-bot: cr
