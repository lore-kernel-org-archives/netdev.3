Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909587;
	b=Z65WX1WJ1kdIpH1ibPXW5ug9mgiKKRV6iUjbLEH7nSIkFuRqseALHml1SeH+XmMgSpFQ
	 cXPEGqB1ShxfXs1Ae0x+8ZItf4uB3IRVHj9mZUbjCM8yA/ElaNmCA1b5igkkYldDaGCOc
	 5N8fkQsA7YFyY2FThDBKMKSFq/kBmpxyKckXb8S1FXOvhTrTKNrY8QTnzzChY09O8HXsb
	 qw+oNoZ4JyCyoFyKVsM6yOHYQ4jiPVk9Q38adBlEJdlvATpyn8xc43VyNFgh9wbVMBVV5
	 jmTtmYl9uylZADjyULUOQ4EuORboXkLrYtTWPR6h74QF70bRd4EhoYrs5uT1Oe0Hopw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909587;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Y2Heru+krAQjJgkVwe3kW1L+yzEzbjyvlLhz+JHeGcU=;
	b=cG21UZGnfY1PuVhLE/yU1n7bcTCx128nJB6r3dtUZNtLvvVIAMe8U+y4wfnKF2mVxxoX
	 hnhggbxJ5IZatIKLy3XkF9aiuLVnCCspcmQVCEXiP5fphYqTidNcF7B/yv8dBuw5Jv1iv
	 Y3nJop5Z8NGdXOv8hNkKb2LYFfZ5Jq+iY1k2kL9q+f9SRnAr/P3O88YAKcNBG0r3cwBL9
	 vYsd3HVq3j1cPgakfPYwJRgWtlovMOa0TUrrciceJ9m+g8kPjyw2MkP9us2I6rrkJ0Mi8
	 RBSJsrXJyzij+YpNteupZvTgJkEcGkbOzMn1f+umX/LwjcpHXBNlOi+1KsO/wSGKZ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4czUsrp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1940606A31B;
	Thu,  5 Nov 2026 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4czUsrp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CB91F0089F;
	Thu,  5 Nov 2026 20:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793909586;
	bh=Y2Heru+krAQjJgkVwe3kW1L+yzEzbjyvlLhz+JHeGcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T4czUsrpmFYecGSDy2nnUGHgt1y0+xQdOH+e5ezZUSYPGXYkQjUKBmS96pw9V3ofH
	 p5rZgvFeqoiZnJ6LOqQEEpxw7nKJoUOiZ67rm4WxivavU8DAnpjGeuHpWUWj69DaYS
	 91kPXhZaxFvw6VkFLVkVjDHua1oPPuWaJgVQAz2vJDxBRmfhFmkdvHKLrjbyAZCosF
	 w32yCOC51P1OW7etuuPZ1W2ng/id33DHCknSXq4LZ6sXZNK23QUZ26RjMhmqjsyaW9
	 +3UagrnkT/UmP4wskp7J89AK7nD2Gqi7gCA8vlL9ripSWnv4FM1gKMtlJaZhgj8o9d
	 5VPA2faytQyJg==
Date: Thu, 5 Nov 2026 20:13:02 +0000
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ibm: emac: use page_pool for RX buffers
Message-ID: <20261105201302.GY865646@horms.kernel.org>
References: <20261102034806.190498-1-rosenp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102034806.190498-1-rosenp@gmail.com>

On Sun, Nov 01, 2026 at 07:48:06PM -0800, Rosen Penev wrote:
> The RX ring held skbs that were allocated and DMA mapped when a slot was
> refilled. By the time a frame arrived in that slot the skb was cold, and
> every refill paid for a full skb allocation and a dma_map_single().
> 
> Take the RX buffers from a page_pool instead and build the skb with
> napi_build_skb() once a frame has arrived. Frames spanning several BDs
> get the following buffers attached as page fragments instead of being
> copied into one large skb. The BD size is capped so that a buffer always
> fits into a page. The driver now syncs the received data for the CPU
> before reading it.
> 
> The pool recycles directly into the MAL NAPI instance, so it is
> destroyed while that instance is disabled.
> 
> Routing a single TCP stream through the qca8k switch of a Meraki MX60
> (iperf3 median of 3):
> 
>           LAN->WAN   WAN->LAN  (Mbit/s)
>   before  588        508
>   after   614        528
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

...

> @@ -1661,17 +1667,23 @@ static void emac_poll_tx(void *param)
>  	netif_tx_unlock_bh(dev->ndev);
>  }
>  
> +static inline void emac_rx_sync_for_cpu(struct emac_instance *dev, int slot,
> +					int len)
> +{
> +	dma_sync_single_for_cpu(&dev->ofdev->dev, dev->rx_dma[slot],
> +				SKB_DATA_ALIGN(len + NET_IP_ALIGN),
> +				DMA_FROM_DEVICE);
> +}
> +

Hi Rosen,

I realise this is pattern already pervasive in this file.
But please do not add new instances of the inline keyword
in C files unless there is a demonstrable reason to do so -
usually performance.

Instead, please let the compiler do it's thing.

Otherwise this patch looks good to me.

-- 
pw-bot: changes-requested

...
