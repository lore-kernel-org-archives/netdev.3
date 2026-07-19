Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DF02DE70D;
	Sun, 19 Jul 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784457583; cv=none; b=gTUW+p3wuUSu99OlszF9ZdHgwAJRPDcX8/z/Bp7TKTPXdGSgg0pg58m4ekAmJu7nesJaZU2Rb03mJRNsMd7/WkmfvbIlOKvGCr4ZH8tBaDCnf2Kdr7YjJk538LxuE2FyBbVyx2k32N/eXWLVDythD2KtB0yxQY5Nc9QXEs+0GMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784457583; c=relaxed/simple;
	bh=IkdW1OOeWRNjr0aosTh3TY88VsFRtra7Q28UaB+1Njw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ANhvm8g9knIEFnsnsL4z60mDJvLuW4xNMR3wwHjj94TYMiKgPUr3q0iiBNyf4fPGX2Zq97YWTJ2GOqjiBWtL1mzg8T3qAb8bp+6uPumNSeZPca4xAVl/5ird7cQgkfajxAiA/JUVInuQwSTGDJS+HH9JdGcHti6OXPX3h3/zXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=M8pSuMZl; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="M8pSuMZl"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E8EFA47FA;
	Sun, 19 Jul 2026 12:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784457579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rud6A6l9YqEn6ZD31SAFWbw2qkblUeelenmP91fI9N4=;
	b=M8pSuMZlsXjUCktaAY1flnimWPJrxZN4gv+iVhPqQf/haqNgp307ERRR+WRIa0OsgnF+Zq
	1yPzQVdB8UoVyxa07P13xA1kIllvJYS6EVxK0VKAHDSwKal0r10rI4IubBGF8jyyGFdi6S
	MTjkV5+rnRSgKPo8s/xIO2ywxBmug8lwEwDHpgBQ3xFBaTF8IQlca9iFnFSqGijwJYjAAl
	SM/JCUmBfPcNKJobzXtgyOzE9ngb309gyZzFwExs7BpSysJMm7IUon88cIN5SnPFK4eup5
	4FyUmeTDqZAv5a1YkfRV04icSsXf7MvXpNftODzy1eT8l1c2BIU+AHF/99xVsw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 12:39:39 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Russell
 King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Paolo Valerio
 <pvalerio@redhat.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v4 08/15] net: macb: avoid
 macb_init_rx_buffer_size() modifying state
In-Reply-To: <20260717-macb-context-v4-8-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-8-0acbe7f10cdb@bootlin.com>
Message-ID: <06a72a98edcdae8d5196a8a4a88a47bf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 17.7.2026 21:48, Théo Lebrun wrote:
> macb_init_rx_buffer_size() takes the macb private data struct and
> overrides its bp->ctx->rx_buffer_size. To make it usable with multiple
> contexts, make it return its value.
> 
> Also, move the `bufsz` computation into it. The value is only used if
> GEM, and for historical reason it currently lives in macb_open().
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 26 
> +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index d50d8520231c..29bf3c497f2a 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2615,25 +2615,26 @@ static netdev_tx_t macb_start_xmit(struct 
> sk_buff *skb,
>  	return ret;
>  }
> 
> -static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
> +static unsigned int macb_rx_buffer_size(struct macb *bp, unsigned int 
> mtu)
>  {
> -	if (!macb_is_gem(bp)) {
> -		bp->ctx->rx_buffer_size = MACB_RX_BUFFER_SIZE;
> -	} else {
> -		bp->ctx->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
> +	unsigned int size;
> 
> -		if (bp->ctx->rx_buffer_size % RX_BUFFER_MULTIPLE) {
> +	if (!macb_is_gem(bp)) {
> +		size = MACB_RX_BUFFER_SIZE;
> +	} else {
> +		size = mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
> +		size = MIN(size, RX_BUFFER_MAX);
> +
> +		if (size % RX_BUFFER_MULTIPLE) {
>  			netdev_dbg(bp->netdev,
>  				   "RX buffer must be multiple of %d bytes, expanding\n",
>  				   RX_BUFFER_MULTIPLE);
> -			bp->ctx->rx_buffer_size =
> -				roundup(bp->ctx->rx_buffer_size,
> -					RX_BUFFER_MULTIPLE);
> +			size = roundup(size, RX_BUFFER_MULTIPLE);
>  		}
>  	}
> 
> -	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%u]\n",
> -		   bp->netdev->mtu, bp->ctx->rx_buffer_size);
> +	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%u]\n", mtu, size);
> +	return size;
>  }
> 
>  static void gem_free_rx_buffers(struct macb *bp)
> @@ -3193,7 +3194,6 @@ static void macb_set_rx_mode(struct net_device 
> *netdev)
> 
>  static int macb_open(struct net_device *netdev)
>  {
> -	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
>  	struct macb *bp = netdev_priv(netdev);
>  	struct macb_queue *queue;
>  	unsigned int q;
> @@ -3212,7 +3212,7 @@ static int macb_open(struct net_device *netdev)
>  	}
> 
>  	/* RX buffers initialization */
> -	macb_init_rx_buffer_size(bp, bufsz);
> +	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
>  	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
>  	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
