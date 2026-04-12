Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FCC362156;
	Sun, 12 Apr 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021047; cv=none; b=iulBl1AU+uMUvJDmxnOcOjGJ791vV5660+8I9SPD11u/UvFZeCEmp2uxqMP1Z3ZBgplQVoJ48UZWs+cki3iHy+PPttyFjwaMAHvbB4xOY7rMAIeSdd7ljf6oLtmLKtb+jYPEc0UJlbJ0riDsCyyCGaBRQxiMYPyygC5Wdj7qwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021047; c=relaxed/simple;
	bh=Kc0kQATl+d9594mejcm7bbetw3M59+rLgfzTYHRikKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SH4cxVxAbOcTveqaIoCbEUw7PA2Z9mni+rbr+jDhN3zHc9eCN7ynMZwS+NOiTpxSkT7hdO8vWESZxPPSKU8bBSvBGC30wJ3VRTaLNV3D10HOo3+vWgH3E2ER+/GvnuWy09Zt/lSk6Ufveuv735kRYZQb13EfUkUD/RHT6v6j0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDqZ6zhK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDqZ6zhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7137EC19424;
	Sun, 12 Apr 2026 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776021046;
	bh=Kc0kQATl+d9594mejcm7bbetw3M59+rLgfzTYHRikKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDqZ6zhKDmAZ0lD5ailhlm/73uT+Dif+w6H7eqZGKbYgI4saygeQYhuI/4pNO/YEI
	 KWq6s+B8pBFw7J4pSb05MV4DOZEiN6NgFacOGouWHeTfAMeDxwuqIaiiP1IZmdsrhe
	 d3hAHIbiwdJPCknlob2WoBNG8ur2D3yqxWHuqzGXwa6wjCqREkB9f6jnbbn1S7QIiK
	 JU7FedDduXYmkOfdNZ0orQSbgHIq/JPhoSDs1+QCDrG2ieqOBIzNsnAVckgqifJJ26
	 egI8krjA9Qnsazdzw6n4sX4K0erb2OgQ9atbBnctgOpzWY+mquAnMM5HfuetvLAk4e
	 2FoZMpmW2pDCw==
Date: Sun, 12 Apr 2026 12:10:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, Simon
 Horman <horms@kernel.org>, Mohsin Bashir <mohsin.bashr@gmail.com>, Doug
 Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Fernando
 Fernandez Mancera <fmancera@suse.de>, Markus =?UTF-8?B?QmzDtmNobA==?=
 <markus@blochl.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/7] net: bcmgenet: convert RX path to
 page_pool
Message-ID: <20260412121044.4dbd4869@kernel.org>
In-Reply-To: <20260406083536.839517-2-nb@tipi-net.de>
References: <20260406083536.839517-1-nb@tipi-net.de>
	<20260406083536.839517-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Apr 2026 10:35:25 +0200 Nicolai Buchwitz wrote:
> Replace the per-packet __netdev_alloc_skb() + dma_map_single() in the
> RX path with page_pool, which provides efficient page recycling and
> DMA mapping management. This is a prerequisite for XDP support (which
> requires stable page-backed buffers rather than SKB linear data).
> 
> Key changes:
> - Create a page_pool per RX ring (PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
> - bcmgenet_rx_refill() allocates pages via page_pool_alloc_pages()
> - bcmgenet_desc_rx() builds SKBs from pages via napi_build_skb() with
>   skb_mark_for_recycle() for automatic page_pool return
> - Buffer layout reserves XDP_PACKET_HEADROOM (256 bytes) before the HW
>   RSB (64 bytes) + alignment pad (2 bytes) for future XDP headroom

some nits here, since I have more "real" comments on later patches

> +/* Page pool RX buffer layout:
> + * XDP_PACKET_HEADROOM | RSB(64) + pad(2) | frame data | skb_shared_info
> + * The HW writes the 64B RSB + 2B alignment padding before the frame.
> + */
> +#define GENET_XDP_HEADROOM	XDP_PACKET_HEADROOM

subjective but IDK what value this define adds vs using
XDP_PACKET_HEADROOM directly.

> +#define GENET_RSB_PAD		(sizeof(struct status_64) + 2)
> +#define GENET_RX_HEADROOM	(GENET_XDP_HEADROOM + GENET_RSB_PAD)

> +static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
> +			      struct enet_cb *cb)
>  {
> -	struct device *kdev = &priv->pdev->dev;
> -	struct sk_buff *skb;
> -	struct sk_buff *rx_skb;
> +	struct bcmgenet_priv *priv = ring->priv;
>  	dma_addr_t mapping;
> +	struct page *page;
>  
> -	/* Allocate a new Rx skb */
> -	skb = __netdev_alloc_skb(priv->dev, priv->rx_buf_len + SKB_ALIGNMENT,
> -				 GFP_ATOMIC | __GFP_NOWARN);

page pool adds __GFP_NOWARN automatically, you can drop it now

> -	if (!skb) {
> +	page = page_pool_alloc_pages(ring->page_pool,
> +				     GFP_ATOMIC | __GFP_NOWARN);
> +	if (!page) {
>  		priv->mib.alloc_rx_buff_failed++;
>  		netif_err(priv, rx_err, priv->dev,
> -			  "%s: Rx skb allocation failed\n", __func__);
> -		return NULL;
> -	}


