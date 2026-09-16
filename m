Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409237204D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574763; cv=none; b=eB3WhhcfmaXB2VFv8afyj4N0gD6OyuPPOa+1+sU1lVDjzBTBV4HFxaICVEmaVoLGjeAYJ8pCWZt23s6zrK6Pc7SFCjEIbrm+XI2XPSD3ykGjddWF1MeT3kJRgXJIyivhO35bdOUYZ2sr/ukY4gDKBeHlLXdUrBalUHNVX6iMSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574763; c=relaxed/simple;
	bh=DAmOyyOL67Q3p+/zJp2cf45Jt7Qzf4GmkAqT8JzhVxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hckdbdwtLf2R2+4nQgaq7txnPoWKOTuu1aMWVrdPnlbuX83m92Xp/va4oF2yPhTYuIFKEhXLWMf8/lJgo0ta+p24ty47V+cvbdXQlCYUov10dG0cTkW5iDq2KHd8HxZ/UAFGjopfjDZMUsLRgakctMTWmcKGZYem1ieIni7nXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=la3DREcB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="la3DREcB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1E0E9C653F6;
	Wed, 16 Sep 2026 16:06:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0668B60337;
	Wed, 16 Sep 2026 16:05:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02D3C11C7B053;
	Wed, 16 Sep 2026 18:05:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789574755; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=bnWAq69vwGAi5ud+TrWqWhxgVm98sUaSZ8rWU2iShco=;
	b=la3DREcByALAvaeKzr1rFNUAZMu7d6ehHOEwFB8PqZLPg+C5yxIZCuckD4uYQY8hWtCvhF
	qwQdrEOhmvUMGb/pleBm+Lx+roDm/h8woj0hHnTYUD47MQ0/ftpNxPVxJRBuGomMoNuwev
	7pxWTH6Pq0NMb+fF9UAWpgshe5uT7C7KuGxydpSJiEtVN5N75YNL70OiIobLQak+20LgLT
	rIxYv0ve7mJXnTkUZsxCzTkaAZYp5IkSwhd84vtY/TP6X1S3tjt8wlJSjNbJX46susGfI2
	6rC0D4LUzol7N4ZpXxnuXyGQ8kJtNGF+kSXVo4wNJ6andpHm9+ynM0ql9bkcQw==
Message-ID: <2ec95f84-2eaf-407f-8372-6f6e89eb1e3b@bootlin.com>
Date: Wed, 16 Sep 2026 18:05:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: fix rx Scatter-Gather support
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo

On 9/16/26 17:25, Lorenzo Bianconi wrote:
> When a received frame is larger than dma_buf_sz, the DMA scatters it
> across multiple RX descriptors (rx Scatter-Gather). The secondary RX
> buffer (sec_page) was only allocated and programmed when split-header
> (SPH) was active, so for regular frames buffer2 was neither allocated
> nor backed by a valid mapping. As soon as an incoming frame overflowed
> buffer1, the DMA wrote the overflow into the unmapped secondary-buffer
> address, triggering an SMMU translation fault on IOMMU-based platforms:
> 
> arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x00000000, fsynr=0x7f0011, cbfrsynra=0x1c90, cb=11
> arm-smmu 15000000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x1c90
> arm-smmu 15000000.iommu: FSYNR0 = 007f0011 [S1CBNDX=127 WNR PLVL=1]
> 
> Enable scatter-gather for non-SPH frames: always allocate the secondary
> RX buffer and always mark buffer2 as valid in stmmac_init_rx_buffers()
> and stmmac_rx_refill(), and account for it in the buffer length
> computation. stmmac_rx_buf1_len() now returns min(dma_buf_sz, plen - len)
> on the last descriptor, while stmmac_rx_buf2_len() returns the remaining
> bytes on the last descriptor and dma_buf_sz on the intermediate ones. The
> GMAC4 + split-header path keeps using the accumulated payload length
> semantics, since there an intermediate descriptor's buffer2 can be only
> partially filled.
> 
> Fixes: 88ebe2cf7f3f ("net: stmmac: Rework stmmac_rx()")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Ah this is also nice ! Ran into that with the Jumbo Frame selftest, it
spills into the next desc and it doesn't end well (at least on dwmac1000).

I don't know how you've tested that, can you test it in conjunction with
this patch too ?

https://lore.kernel.org/netdev/20260911212028.1497613-6-maxime.chevallier@bootlin.com/

It changes the way we select the dma_buf_sz based on the MTU.

I'll run your series on the boards I have and report if anything weird happens,
but if you have some testing commands to share that would be awesome :)

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++---------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea23..be7cb0cafeb5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1659,17 +1659,14 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
>  		buf->page_offset = stmmac_rx_offset(priv);
>  	}
>  
> -	if (priv->sph_active && !buf->sec_page) {
> +	if (!buf->sec_page) {
>  		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
>  		if (!buf->sec_page)
>  			return -ENOMEM;
>  
>  		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
> -		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> -	} else {
> -		buf->sec_page = NULL;
> -		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
>  	}
> +	stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
>  
>  	buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
>  
> @@ -5097,7 +5094,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>  				break;
>  		}
>  
> -		if (priv->sph_active && !buf->sec_page) {
> +		if (!buf->sec_page) {
>  			buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
>  			if (!buf->sec_page)
>  				break;
> @@ -5108,10 +5105,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>  		buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
>  
>  		stmmac_set_desc_addr(priv, p, buf->addr);
> -		if (priv->sph_active)
> -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
> -		else
> -			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
> +		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
>  		stmmac_refill_desc3(priv, rx_q, p);
>  
>  		rx_q->rx_count_frames++;
> @@ -5160,7 +5154,7 @@ static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
>  	plen = stmmac_get_rx_frame_len(priv, p, coe);
>  
>  	/* First descriptor and last descriptor and not split header */
> -	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen);
> +	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);
>  }
>  
>  static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
> @@ -5170,10 +5164,6 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
>  	int coe = priv->hw->rx_csum;
>  	unsigned int plen = 0;
>  
> -	/* Not split header, buffer is not available */
> -	if (!priv->sph_active)
> -		return 0;
> -
>  	/* For GMAC4, when split header is enabled, in some rare cases, the
>  	 * hardware does not fill buf2 of the first descriptor with payload.
>  	 * Thus we cannot assume buf2 is always fully filled if it is not
> @@ -5188,8 +5178,9 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
>  	 * Thus 'plen - len' always gives the correct length of buf2.
>  	 */
>  
> -	/* Not GMAC4 and not last descriptor */
> -	if (priv->plat->core_type != DWMAC_CORE_GMAC4 && (status & rx_not_ls))
> +	/* Not GMAC4, or non-SPH and not last descriptor */
> +	if ((priv->plat->core_type != DWMAC_CORE_GMAC4 || !priv->sph_active) &&
> +	    (status & rx_not_ls))
>  		return priv->dma_conf.dma_buf_sz;
>  
>  	/* GMAC4 or last descriptor */
> 
> ---
> base-commit: ceac0de741bfb47ca255eee075257b3bb31f0651
> change-id: 20260916-stmmac-rx-sg-fix-a8d2d8a3ba01
> 
> Best regards,

