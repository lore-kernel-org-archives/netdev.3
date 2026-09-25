Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9664A499F;
	Fri, 25 Sep 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344808; cv=none; b=mdQ58yfHP1y7S2t6vt0oMLdoRlP/n/BZMc9udobqk1jbtCKLNZ+qjjEEJQGNNM9E1Sl4XRiV6mziQ4rffeKMIJD7OaPRotMczOALhKYfOLDO3RNEMG9N8c0iKd+RwnUD8AnI10nHHmMYkpct4rIN7Xm+MZR55sKj+hw0cj0K46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344808; c=relaxed/simple;
	bh=DSsN29zsR9j+WvGBTcHDFWJGzb4OLJvGW5VKqI8X3DA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=D+0sfddV6PW1hUmYIQSvLK5D7ThOvp7akVxOiO4bdHXgSaXnNTEBqufDtbOJYR8wvRnTYZ/f7rvy2wpLEZfIVoJmLRkvdYTU7X+K9Zs6XHBxdvDVKX5OEOehZSTmwSp5IsSRnrIM3GaW9Iklv6vHlgV1BIrih7V4d/anOUrTX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=I7Bd/HXt; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="I7Bd/HXt"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27297A4AA6;
	Fri, 25 Sep 2026 15:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790344799; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MTd0EMu7doAmdq2HppZdrUCkOm/ba6fvHRPuYn3MCJo=;
	b=I7Bd/HXtFzYU78wNTTbWozPADgcLkY0cIW4cbpOipMGwkk7W/grP6FTidrblJUt5+xobHU
	1JlWBkuzdNMc+DUrp//7RXKWTJV/Ugf0ZtcFqHdygyHE8l6CHQw5xR0Jbr/wiIzydc+Hjk
	w/l4Thui96nGT6JrvYdLf03SzAzOq0DPZoFmrUiKlusQ0cOcCZwCN6dZeauPan9Kx3eMHP
	B/Gy1Q9Z4F3/+IPU2geQzSb+fVRvDobMK2i08QMRDH42WYVwKNehngjyrtuR/oPVamSXxY
	Svvk4ZKZ8tGKQHaacye6nAsGTRu9oePb/fZ0O++UsJIQQs/cNlaubBeVVmeGwg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 15:59:57 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Simon Horman <horms@kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Justin Chen <justin.chen@broadcom.com>,
 kmehltretter@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: allocate RX buffers as page fragments
In-Reply-To: <20260925134714.GM13925@horms.kernel.org>
References: <20260924101922.2675127-1-nb@tipi-net.de>
 <20260925134714.GM13925@horms.kernel.org>
Message-ID: <890feb51a8204e6e9f486bcee8e4f819@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Simon

On 25.9.2026 15:47, Simon Horman wrote:
> On Thu, Sep 24, 2026 at 12:19:21PM +0200, Nicolai Buchwitz wrote:
>> Since the page_pool conversion every RX buffer is a whole page and the
>> skb truesize is the page, although the hardware writes at most 2 KiB 
>> of
>> it. On 64 KiB pages a packet therefore counts 65792 bytes against the
>> socket buffer where it used to count 2752. As a result a UDP socket
>> with the default buffer starts to drop after three packets, and the RX
>> rings pin 16 MiB for 512 KiB of buffers.
>> 
>> Fix this and allocate the buffers as page fragments, so the truesize 
>> is
>> what a packet occupies. 4 KiB pages stay one buffer per page.
>> 
>> Sync each buffer in the refill path, as page_pool can only sync a 
>> whole
>> page on recycle. On 4 KiB pages that is twice what the hardware wrote.
>> 
>> Fixes: 7bc054c2d4ed ("net: bcmgenet: convert RX path to page_pool")
>> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
>> Closes: 
>> https://lore.kernel.org/all/20260924065839.56793-1-kmehltretter@gmail.com/
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> ...
> 
>> @@ -2254,11 +2257,12 @@ static int bcmgenet_rx_refill(struct 
>> bcmgenet_rx_ring *ring,
>>  			      struct enet_cb *cb)
>>  {
>>  	struct bcmgenet_priv *priv = ring->priv;
>> +	unsigned int size = GENET_RX_BUF_SIZE;
>> +	unsigned int offset;
>>  	dma_addr_t mapping;
>>  	struct page *page;
>> 
>> -	page = page_pool_alloc_pages(ring->page_pool,
>> -				     GFP_ATOMIC);
>> +	page = page_pool_dev_alloc(ring->page_pool, &offset, &size);
> 
> I think it is not so important either way, but I'm wondering
> if you considered using page_pool_alloc_frag() here.

Yes, I did, but page_pool_alloc() seemed a better fit as it hands back 
the usable
size in *size. Also it falls back to a whole page above half a page and 
avoids an
underestimate at the end of a page.

> 
>>  	if (!page) {
>>  		priv->mib.alloc_rx_buff_failed++;
>>  		netif_err(priv, rx_err, priv->dev,
> 
> ...

Thanks,
Nicolai
