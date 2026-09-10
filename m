Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0FB3D8909;
	Thu, 10 Sep 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033038; cv=none; b=h26rjW2l4AuX1gBcIB0ezqbgaP5/VrrgKhgG1cYbaZmj6NP7iDUkV8n4vPH6E5Hi1FBObcmetGAiYQiMyzeaOBGl08sBS0v8w14E/DARnhjXpgzf1C4CNNIIymgwhVXtA7so19GgsRfm7DJZTsfp5eeJ4WjDoy1Q2QRrrs8vnec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033038; c=relaxed/simple;
	bh=DKpcrq3Nylpvhh//ElNeHV0Opd2RZztiHaNMAK0hqHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=an2eRhPVPkIimnwXRD0iOuQbPYfVe9aOd0F5wfRq/deVWW49tU32ZUBRrN6H1Bnb+0a/fmpRt2eCqbuTC0hRC1HQHl63BKE5NNITHoEObviOiOpAWl54l9/N8ECKo22HGCcc1yXWg4bd3en0LRWukjj/sA8+6oL92VHqDs8rdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XtuDuCsz; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XtuDuCsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lD
	zXZ6piB7j2cN4Fr0TwgWJ5tKy/80ymXysWPI+rShA=; b=XtuDuCszsJmOJcBzL9
	YGeyAEPFHOf3H0/8OvUmuAqehEEOebxMPdOtY8E4MbKm+Q2d56GWWQ9nMf76IAD9
	pKWGmBKRgKvaJzyK4f4NmdkOf/cEIDmpr2uj6iVUCoibFjHa/urcoifcckjKSe/h
	poGYcPn9dDz78LB21sreilXnA=
Received: from 4CV529F122.company.local (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBXQmrweaJqFDQnOg--.33175S2;
	Thu, 10 Sep 2026 17:35:54 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: lorenzo.bianconi@oss.qualcomm.com
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dinghui1111@163.com,
	dinghui@lixiang.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	liuxuanjun@lixiang.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com
Subject: Re:Re: [PATCH net-next v2] net: stmmac: fix error path cleanup in DMA descriptor ring allocation
Date: Thu, 10 Sep 2026 17:35:44 +0800
Message-Id: <20260910093544.411975-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ap09hwoKJjqQWIrB@lore-desk>
References: <ap09hwoKJjqQWIrB@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBXQmrweaJqFDQnOg--.33175S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4rAFy5Gr4fWw4kZF4kCrg_yoWrJry8pr
	48CayjyFyUtr13GwnxAr4UXa45J3yrtF4Ygw43Cw12vFnFkr9YqFyjyryjkry8Cr9ruF4S
	g34DCFnxCF18JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi-eOAUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC0hvfDGqiefvSpwAA3l

Hi Lorenzo,

Thanks for your review comments.

At 2026-09-06 18:16:39, "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com> wrote:
>> From: Ding Hui <dinghui@lixiang.com>
>
>Hi Ding Hui,
>
>just a couple of nits inline.
>
>Regards,
>Lorenzo
>
>[...]
>
>>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 59 ++++++++++++++++---
>>  1 file changed, 50 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index f2fc89176654..f0e06c011b8d 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -1728,7 +1728,7 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
>>  					 DMA_TO_DEVICE);
>>  	}
>>  
>
>Is it more appropriate to move the tx_q->tx_skbuff_dma check here from
>dma_free_tx_skbufs()?
>

tx_skbuff_dma is a per-queue resource, and stmmac_free_tx_buffer()
references it in multiple places across the function body. Moving the
NULL check into stmmac_free_tx_buffer() would require repeating it on
every call, introducing O(n) overhead proportional to dma_tx_size.
So I put it at the entry of dma_free_tx_skbufs().

>> -	if (tx_q->xdpf[i] &&
>> +	if (tx_q->xdpf && tx_q->xdpf[i] &&
>>  	    (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_TX ||
>>  	     tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_NDO)) {
>>  		xdp_return_frame(tx_q->xdpf[i]);
>> @@ -1738,7 +1738,7 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
>>  	if (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XSK_TX)
>>  		tx_q->xsk_frames_done++;
>>  
>> -	if (tx_q->tx_skbuff[i] &&
>> +	if (tx_q->tx_skbuff && tx_q->tx_skbuff[i] &&
>>  	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_SKB) {
>>  		dev_kfree_skb_any(tx_q->tx_skbuff[i]);
>>  		tx_q->tx_skbuff[i] = NULL;
>> @@ -1761,6 +1761,10 @@ static void dma_free_rx_skbufs(struct stmmac_priv *priv,
>>  	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
>>  	int i;
>>  
>> +	/* buf_pool may not be allocated if alloc failed early */
>> +	if (!rx_q->buf_pool)
>> +		return;
>> +
>>  	for (i = 0; i < dma_conf->dma_rx_size; i++)
>>  		stmmac_free_rx_buffer(priv, rx_q, i);
>>  }

>> @@ -2272,15 +2284,19 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>>  	}
>>  
>>  	rx_q->buf_pool = kzalloc_objs(*rx_q->buf_pool, dma_conf->dma_rx_size);
>> -	if (!rx_q->buf_pool)
>> -		return -ENOMEM;
>> +	if (!rx_q->buf_pool) {
>> +		ret = -ENOMEM;
>> +		goto err_destroy_pool;
>> +	}
>>  
>>  	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
>>  
>>  	addr = dma_alloc_coherent(priv->device, size, &rx_q->dma_rx_phy,
>>  				  GFP_KERNEL);
>> -	if (!addr)
>> -		return -ENOMEM;
>> +	if (!addr) {
>> +		ret = -ENOMEM;
>> +		goto err_free_buf_pool;
>> +	}
>>  
>>  	if (priv->extend_desc)
>>  		rx_q->dma_erx = addr;
>> @@ -2296,10 +2312,27 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>>  	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
>>  	if (ret) {
>>  		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
>> -		return -EINVAL;
>> +		goto err_free_dma;
>>  	}
>>  
>>  	return 0;
>> +
>> +err_free_dma:
>> +	if (priv->extend_desc)
>> +		dma_free_coherent(priv->device, size, rx_q->dma_erx,
>> +				  rx_q->dma_rx_phy);
>> +	else
>> +		dma_free_coherent(priv->device, size, rx_q->dma_rx,
>> +				  rx_q->dma_rx_phy);
>
>I guess you can use addr here and remove the if/else block
>
Excellent suggestion, will use addr directly in v3.

Thanks,
Ding Hui

