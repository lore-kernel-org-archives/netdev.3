Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DB46F498
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935572; cv=none; b=oOK+am8hGSVMfR0Ml7CVivFMNGFs2Uq1IG+nmSZ8x17qS8IJwEt72xqqHlVsfIchP9BVhf9F32xUfZhty+pSFEPjJ1LgG+vvs1Mi8gH413Csu1noFbW6Wf0kAyDzZbDi4qT106D9UFcdmLx9U0J16pbcGwXKrAgY+iL+wnJTPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935572; c=relaxed/simple;
	bh=bonqN9UVCPfeSMiJFCTD+EutB8dOoMtdO8HdDl9y7M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI/nasamaD8VaLztU6xB6KiMGEp5TMTTt+sz3+UKHBvriNSJ5kURZS0uV6jheT5+FquXkDqjelf8PsefdlrO5FMvzn28b2V72OgIcBpvoxVCD6wIFIwLwGOXBUO9Pstc+oVWx05r8zzKgGUDEmrA1VoRcv7NNzc71gHNvD7axSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B2bNw1dt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B2bNw1dt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+yVUWaotaWz+Aw1Bt6nhWIaC+D+5wUjlECZ1SkLRUGU=; b=B2bNw1dtesOek+ixIZCEEC+MiQ
	k0kdcTI2ytdCQBIYyBirvw7u21v4LPY1JgUg5uskD6cYzcZEtFxxXiqIWj/aqNTfFC+tseWGBDfOk
	SUzlF0X26bbW/pSKGpMcf+X0uI/iNTdvLtfZFRaj3sGKymijUVtk9zVKKcvv0/JkYyVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrbQH-00GAku-Jv; Wed, 05 Aug 2026 15:12:41 +0200
Date: Wed, 5 Aug 2026 15:12:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH net] net: mvneta_bm: fix gen_pool_free address for BPPI
Message-ID: <8a46fda8-79a7-44c6-b4ef-2ca66c4dc3c0@lunn.ch>
References: <20260805061438.955717-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805061438.955717-1-chenguang.zhao@linux.dev>

On Wed, Aug 05, 2026 at 02:14:38PM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> gen_pool_free() expects the virtual address returned by
> gen_pool_dma_alloc(), not the physical address. Passing phys can miss
> the chunk and trigger BUG() on remove or probe rollback.
> 
> Fixes: dc35a10f68d3 ("net: mvneta: bm: add support for hardware buffer management")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  drivers/net/ethernet/marvell/mvneta_bm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
> index 6bb380494919..2a114a69a0ab 100644
> --- a/drivers/net/ethernet/marvell/mvneta_bm.c
> +++ b/drivers/net/ethernet/marvell/mvneta_bm.c
> @@ -389,7 +389,7 @@ static int mvneta_bm_get_sram(struct device_node *dn,
>  
>  static void mvneta_bm_put_sram(struct mvneta_bm *priv)
>  {
> -	gen_pool_free(priv->bppi_pool, priv->bppi_phys_addr,
> +	gen_pool_free(priv->bppi_pool, (unsigned long)priv->bppi_virt_addr,

The cast is ugly, but it also seems correct. However, can the API be
improved. If the intention is

gen_pool_free(priv->bppi_pool,
              gen_pool_dma_alloc(priv->bppi_pool,
                                 MVNETA_BM_BPPI_SIZE,
                                 &priv->bppi_phys_addr),
              MVNETA_BM_BPPI_SIZE);

maybe gen_pool_free() should be changed to take a void *?

      Andrew
