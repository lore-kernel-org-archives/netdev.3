Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325120C029;
	Sun, 19 Jul 2026 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784457534; cv=none; b=WRjXiV6jBZUgoftRnNhAK1sJMZsxWVrUDr/PDUdfdWKi26DfF6U/VDuDUuRK3QM6CXnW7cUBITG3KHPnyDedSkRrlSOhcHeLrqlocz4nwrj+TXGrHD9bBCj954isL64lVGcYjeRbKhgY3GpJl3hbAnlX/epcEzXu3oN49so9yMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784457534; c=relaxed/simple;
	bh=25mgvSnDF2cSVXYE0FGpBzN9TWyAo+4nJmknptbRSCc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=O5y6bQ3/7skEOcMevLMApHVhm4bSSR1oE251tRoUyw8+SEHeY2UDi1+7P8Eu3G3xnE9RqZFIVkJskpTvWJtfXjfC2BrLDuWbgV/5fuvuTpprkBc/EsSA2yC/SJEcwTLBAE3+cvi0+JYmyMRlep77shMB1qdtAIA8lrMQAg8ih/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=xtExtWHe; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="xtExtWHe"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90E8DA47FA;
	Sun, 19 Jul 2026 12:38:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784457528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WqyJ4M6fe+rIhhJJRak36w11BFDbAvPZaK8NjnHUhKo=;
	b=xtExtWHeQ37T4+7pUueirkb7bvuUrRIKqC27Fw+56NcblOdI/UMictQz1FUaf2ZHYsIm4L
	prs7QRkWmMzRyyyLj0ELCJfttsJJRzxitegWJfktEYK01z3Q1aoi6VN81RRA0mvHcu9tWv
	LpWPGpoAM/Dxgazb/xfJUMC7X5ofrtLm0RwqMe/oYrTuJAJgEDjGx3vYB7IvCfyVKkhzuP
	3txl6JwL0Ra+6Gn4iRetYJQYjWdcXzcwuHS+EjNeArvhKy/hu+GdxaTaoyhN62xBmFctZe
	iKjcXCn0xz54Ymun08Vk6TcBrqR7TCgRGwHYNb2IwL1TFIGF7rc0F26KtfQtcQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jul 2026 12:38:46 +0200
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
Subject: Re: [PATCH net-next v4 07/15] net: macb: introduce macb_context
 struct for buffer management
In-Reply-To: <20260717-macb-context-v4-7-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
 <20260717-macb-context-v4-7-0acbe7f10cdb@bootlin.com>
Message-ID: <06571ee60d158eb661ab72d577864321@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 17.7.2026 21:48, Théo Lebrun wrote:
> Whenever an operation requires buffer realloc, we close the interface,
> update parameters and reopen. To improve reliability under memory
> pressure, we should rather alloc new buffers, reconfigure HW and free
> old buffers. This requires MACB to support having multiple "contexts"
> in parallel.
> 
> Introduce this concept by adding the macb_context struct, which owns 
> all
> queue buffers and the parameters associated. We do not yet support
> multiple contexts in parallel, because all functions access bp->ctx
> (the currently active context) directly.
> 
> Steps:
> 
>  - Introduce `struct macb_context` and its children `struct macb_rxq`
>    and `struct macb_txq`. Context fields are stolen from `struct macb`
>    and rxq/txq fields are from `struct macb_queue`.
> 
>    Making it two separate structs per queue simplifies accesses: we 
> grab
>    a txq/rxq local variable and access fields like txq->head instead of
>    queue->tx_head. It also anecdotally improves data locality.
> 
>  - macb_init_dflt() / macb_get_ringparam() do not access
>    bp->ctx->{rx,tx}_ring_size as they will/might run while interface is
>    offline and ctx is not NULL. Instead, introduce
>    bp->configured_{rx,tx}_ring_size which get updated on user requests.

nit: In the commit message: "ctx is not NULL" should be "ctx is NULL".

> 
>  - macb_open() starts by allocating bp->ctx. It gets freed in the
>    open error codepath or by macb_close().
> 
>  - Guided by compile errors, update all codepaths. Most diff is 
> changing
>    `queue->tx_*` to `txq->*` and `queue->rx_*` to `rxq->*`, with a new
>    local variable. Also rx_buffer_size / rx_ring_size / tx_ring_size
>    move from bp to bp->ctx.
> 
>    Introduce two helpers macb_txq|rxq() functions to convert macb_queue
>    pointers.
> 
>  - macb_get_regs() is tweaked to support being ran while interface is
>    offline (and context is NULL). Use default values at zero and
>    override them only if context is present.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
