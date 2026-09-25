Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84747ECC8;
	Fri, 25 Sep 2026 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344040; cv=none; b=pF0RmvOsodpRxSjk17zp3w40Cz9cxQKReaJ9fg8xHQ+J6EYw4kRtB7z5IKBEqvyoStB2Aqdbt1xtG77l75ZaS9kTdn/81ZF8hGyTRxiRGgzFOg0tD9pdec6Cjdg3qBrMe3fzafeTFZ1y9ehSnElHHNqLzh98f4LNQTbwJfJbDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344040; c=relaxed/simple;
	bh=F7NqRQh6Iqu9662fFFUXc6ZTQjcakCemsHwCU8vyQqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGGWJmKYn192U025bwqoGNwUbQZt5pbtiuiIcd42XsWVYriGkmCEM2rcescZZwuq74KSiyAEsr1rkGT4PDV50gByx2wWcsq5jutkbuWsdIgFJQ0nRlQNWB25Q4l3svmqpzwNpxwxAhdKxTlRYtWxxIngZuhHBxnLaSdYnXwZXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErI23zIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErI23zIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B6B1F000FF;
	Fri, 25 Sep 2026 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344039;
	bh=R3hsk3Eb5fjuVF/d97+eog9UgG37J77aZb9c19pgAA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ErI23zIEm3VBF8axMd3vcbrkD7GnIdKBCQeV7StoMbuP6Pja2cZGHntUcy7hoJao5
	 MeK78fycmSzbsNzJ4akgzj72+off9h5q/sLveZklI7Zc++kkSZCd+2ofvURFilNM/o
	 5x/h+bUnqWlCsP0Kxun6phVnZKRK6HbmUzNbZHJBU0OofT00wRuJdmUONdgHApQkV5
	 CMq68fgcZS4HRmuqeB6xA4jhl8OmokKHPaoIg0HQcZYixdWZ3VoLQNnhz/+7r3ixxp
	 5k1jWUYf56ywmIfCqu7FWthKHS1gpE/mFngKhifWt6f+P8MNv301h2KHJAXo4HWF9j
	 bxN/fDmj34H8w==
Date: Fri, 25 Sep 2026 14:47:14 +0100
From: Simon Horman <horms@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Justin Chen <justin.chen@broadcom.com>, kmehltretter@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: allocate RX buffers as page fragments
Message-ID: <20260925134714.GM13925@horms.kernel.org>
References: <20260924101922.2675127-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924101922.2675127-1-nb@tipi-net.de>

On Thu, Sep 24, 2026 at 12:19:21PM +0200, Nicolai Buchwitz wrote:
> Since the page_pool conversion every RX buffer is a whole page and the
> skb truesize is the page, although the hardware writes at most 2 KiB of
> it. On 64 KiB pages a packet therefore counts 65792 bytes against the
> socket buffer where it used to count 2752. As a result a UDP socket
> with the default buffer starts to drop after three packets, and the RX
> rings pin 16 MiB for 512 KiB of buffers.
> 
> Fix this and allocate the buffers as page fragments, so the truesize is
> what a packet occupies. 4 KiB pages stay one buffer per page.
> 
> Sync each buffer in the refill path, as page_pool can only sync a whole
> page on recycle. On 4 KiB pages that is twice what the hardware wrote.
> 
> Fixes: 7bc054c2d4ed ("net: bcmgenet: convert RX path to page_pool")
> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> Closes: https://lore.kernel.org/all/20260924065839.56793-1-kmehltretter@gmail.com/
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

...

> @@ -2254,11 +2257,12 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
>  			      struct enet_cb *cb)
>  {
>  	struct bcmgenet_priv *priv = ring->priv;
> +	unsigned int size = GENET_RX_BUF_SIZE;
> +	unsigned int offset;
>  	dma_addr_t mapping;
>  	struct page *page;
>  
> -	page = page_pool_alloc_pages(ring->page_pool,
> -				     GFP_ATOMIC);
> +	page = page_pool_dev_alloc(ring->page_pool, &offset, &size);

I think it is not so important either way, but I'm wondering
if you considered using page_pool_alloc_frag() here.

>  	if (!page) {
>  		priv->mib.alloc_rx_buff_failed++;
>  		netif_err(priv, rx_err, priv->dev,

...
