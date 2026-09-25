Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9B392C21;
	Fri, 25 Sep 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790334672; cv=none; b=Y7S0XToYT4sNQAYeM3mwZHbnpJ19LjmO8QMMUVorXaQ0rravsA9/3lo8d22Mgh/lv3twntSVVKocIwmrB6r+1rv5R7/KdlW0hiPnxYxGjbzVGEQOpzBwQiZhx6YFbjTFdrLCCacw9yPjikfZt6t/i7kpWpwb7N4YfYwsEIeBlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790334672; c=relaxed/simple;
	bh=w93rGZ1go/25rDuElHfHJ2CT6g2Nm4GU5rJ9wYbXusU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hf9vJnjAFARnx8WIlxvPZy7Xwu8cj9+DdKN/s0ljZfwIU1SxQuTstvjDxQ0amPWrM4Ncrb2i0x61QjlkdXBEKQTZQXg49Mp7cU3vmBAQBfZqp7DNbfeBcAM9JGiyQXy43pBUen1TeMJHKOT+jbgcLN1y/3cGq95DAHE5hlit/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=d1DH2GRT; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="d1DH2GRT"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D783FA02D8;
	Fri, 25 Sep 2026 13:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790334658; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=so+Hf2voybDCl/egSzR3Yqh3kdtwlpU35/Jz4+SWF1o=;
	b=d1DH2GRTY+fQ0xDeAZxJ2Wjy2gPySmWtQbz3geYoIDDAeuUAdtIjQa7q84L9LcZWV7QrNS
	fQbwuFQGMvOa8Lu3QN8WpLZ5RT+lrt7wSkc0BXb9PX0iQ0Ufw63l5QNn3+5A5KmR/Y4C4j
	slnT7CFggNCimbf+rFAKGlphdxPMeLXc5BJpcQmBTKGNATNeZEgaWwUIb7v+0e7vpE7gY+
	N4OyYqd+NKlg58qTzGG4POJP98KSCWskqHPSLakHB/CRfYZJLVXuL2jRTNkbUxmgoUlUEj
	QZgOqrGAvi09a4N3+/1ocXuidUqTMkFeLj2CFmT3gRIJ2GVJx8dZ+9//VmfCkQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 13:10:55 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/6] net: bcmasp: unmap previous DMA mappings on TX
 map failure
In-Reply-To: <20260922221630.3864427-3-florian.fainelli@broadcom.com>
References: <20260922221630.3864427-1-florian.fainelli@broadcom.com>
 <20260922221630.3864427-3-florian.fainelli@broadcom.com>
Message-ID: <dd3f211964a80584ad9ea764e5f6f2e7@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 23.9.2026 00:16, Florian Fainelli wrote:
> When mapping an skb with fragments for transmission in bcmasp_xmit(),
> if mapping fails on fragment i > 0, the error handler calls
> bcmasp_clean_txcb() for previous iterations j < i. However,
> bcmasp_clean_txcb() only zeroes the control block fields without
> unmapping the DMA buffers, leaking the DMA mappings allocated for the
> head and earlier fragments.
> 
> Call dma_unmap_single() before calling bcmasp_clean_txcb() in the error
> cleanup loop.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet 
> controller")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c 
> b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index f2176ef3a127..9ad5a982542f 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> @@ -285,6 +285,11 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff 
> *skb, struct net_device *dev)
>  			intf->mib.tx_dma_failed++;
>  			spb_index = intf->tx_spb_index;
>  			for (j = 0; j < i; j++) {
> +				txcb = &intf->tx_cbs[spb_index];
> +				dma_unmap_single(kdev,
> +						 dma_unmap_addr(txcb, dma_addr),
> +						 dma_unmap_len(txcb, dma_len),
> +						 DMA_TO_DEVICE);
>  				bcmasp_clean_txcb(intf, spb_index);
>  				spb_index = incr_ring(spb_index,
>  						      DESC_RING_COUNT);

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
