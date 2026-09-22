Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD01B4F09
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113314; cv=none; b=S17DUuOPd/AKT3tyq+xW2QpKqfTaKxI6yp9qAIgVxDDcmlSKF/MrPxV+O9kem9cWxhnamO9RfTz/R/SvWPYAYToYCNo5yeOXivYzx0Or80EcFPtq/D0rlR2a5wmfzeB1Hd4r2GYT0g8iYRtxvrykoELAw0MR6CeBdVxVFcxjFB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113314; c=relaxed/simple;
	bh=4wCvSS5ujns2r3N0YelOn5oiXpwDkm+aZgMGg3K4gmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOVcR5N5sv2GJcaH/RWeEGjyQnjGsvtQZBh5w+2GmndmUzb9hyseJQQU5yuuDQa8ITsSmcrh5vThE0D6NWOZVMv/rN182Imgl90mr6UyTvpt9E6km1t9FFJw2uQcuZ5uBViCP0J+Lh2rk2+tNJ/mohnC0NQwv+bhCtKQ4LueBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KMiykFuY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KMiykFuY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B0F284E41030;
	Tue, 22 Sep 2026 21:41:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8312060580;
	Tue, 22 Sep 2026 21:41:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25E371032802B;
	Tue, 22 Sep 2026 23:41:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790113296; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aegPoYsp2AnoEEWdjQn2RZBVdKkWUQvus+hn1ZEnwSM=;
	b=KMiykFuYrNaFvXZEd7Sbft6hBWsxxzytH0Ys/Xhr0z3bOKFcnVuSdfYw7bD+naDWkWNhYJ
	n84P5TUGvw1scqI8EfPzuV479LYCgGGk5GUJnCRbY9dUzSaIWb5FipKg7E055phzyBOiqt
	LhEnakyQ+kOhCC9IEF6I8f7As5nysxntEIyFFryiSBByWYFj+4eQP/+ULmYJd3jCrrk83t
	VWoU3HBXXQ/MgHCVyvsb91QAmJ0aVtjs2nNRXx4r0b7/KiZxBYgjsyQi1ginViGeLbb4Zz
	SjyxzOUNbE8xN/WAv+8dtpz6O7eEZSjcMKQ78BKWIs+qjLgCLgaePW0f7Z7z/A==
Message-ID: <76dafa51-b20a-4bb1-9c2b-38f2a7d83dab@bootlin.com>
Date: Tue, 22 Sep 2026 23:41:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: clear stale buf->page after recycling on
 skb build failure
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Yanteng Si <si.yanteng@linux.dev>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Furong Xu <0x1207@gmail.com>, Larysa Zaremba <larysa.zaremba@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260921-stmmac-fix-napi-build-skb-error-v1-1-3d54bf6d9bb6@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260921-stmmac-fix-napi-build-skb-error-v1-1-3d54bf6d9bb6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/21/26 16:46, Lorenzo Bianconi wrote:
> In stmmac_rx(), when napi_build_skb() fails the descriptor page is
> recycled back to the page pool with page_pool_recycle_direct(), but
> buf->page is left pointing at the recycled page, unlike every other
> consumption site in the function which clears the pointer after handing
> the page away.
> 
> With the stale pointer stmmac_rx_refill() skips the replacement
> allocation and programs the already-recycled page back into the RX
> descriptor.
> 
> Clear buf->page on the napi_build_skb() failure path to keep the buffer
> lifecycle consistent with the other consumption sites.
> 
> Fixes: df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX path")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea23..11035b7d944e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5887,6 +5887,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			if (!skb) {
>  				page_pool_recycle_direct(rx_q->page_pool,
>  							 buf->page);
> +				buf->page = NULL;
>  				rx_dropped++;
>  				count++;
>  				goto drain_data;

I'm not expert in the page_pool API, but this seems correct to me, the
doc says :

page_pool_recycle_direct() - release a reference on a page pool page

Seems to make sense to cleare the ref from buf->then ?

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> 
> ---
> base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
> change-id: 20260921-stmmac-fix-napi-build-skb-error-a02a3e839bd9
> 
> Best regards,

