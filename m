Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F0392C21
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663499; cv=none; b=Pk7KiFMW48zT/hM7lQmncqsd3M6t4DmS3BhT/VSE7YK4DSzkAZoZmkpdQGGrNnbysTx4DPlcE0ah9NvjpL68bSHkO/SnM6gShLjGXt7ibfNgYJjXbmED8qrQG4KJEgpOv8VMMHwAIcP/cIIrkXx0sYbkcJwZ3aGTCiltUyTpLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663499; c=relaxed/simple;
	bh=W9XsTwJzp2b5zdMwuN9ZBm+/RCdLWXeEiFd5SUW/SMc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dF+X3+1ET95MHdWJmaaRNqOB7sU2yljvyaCy0FIs8mkTyjk3P/3OKHLuoZzRaULJrYqOaZsftz8oiadyLALGIsl4251Lt8oqjgkN/jeVhorEHc/BF8oZhVG1Q9fz/D7nUYb2/9Lz1C9lC7VwTPdeeXaazVxpuuGmRF8/Qzrag9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=XgUN8Nul; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="XgUN8Nul"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84B64A22FD;
	Mon, 16 Mar 2026 13:18:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773663495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5H1Aaqvxc0Fxsx9kvGJ03wnGg2Cn8pRBnAes0ki/aps=;
	b=XgUN8NulR6COkmsRDUs4j45ZXn3ipPFezemfDBCQo5HPFGuu5gLwL/D3oP9LIVZtpJ40oG
	NTiwn0A1Q8jgNnYARqvGTHvyyCQxaiatpjnNzTbo7AudAs7Ap2ACK1Vc3t6LkJfE0HHaMI
	0EsYvk2TeEX6vaD+EedRlvpJYZMoUkc5QmpjtDrbkOl27zxdjWXeJPWa8rv4yv6Fr82BN0
	N4qA1n33cYIZy17l5inGFiIkl19zH0pPyv+HVA9UQc3g6ruK9Emg98hIQGekVMFGgb60F4
	sqVOb1V6fY1BXKwD0Wda0A5Pe3bXKjBWhaSGNYuORuCPr2wkFw/yjd05e78s6Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 13:18:14 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Paolo Valerio <pvalerio@redhat.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 6/8] net: macb: generalize tx buffer handling
In-Reply-To: <20260313201433.2346119-7-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
 <20260313201433.2346119-7-pvalerio@redhat.com>
Message-ID: <b9db5e942faf2470b3d803f19e723f1c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 13.3.2026 21:14, Paolo Valerio wrote:
> [...]
> 
>  			/* ctrl still refers to the first buffer descriptor
> @@ -1396,20 +1397,22 @@ static bool ptp_one_step_sync(struct sk_buff 
> *skb)
>  static int macb_tx_complete(struct macb_queue *queue, int budget)
>  {
>  	struct macb *bp = queue->bp;
> -	u16 queue_index = queue - bp->queues;
>  	unsigned long flags;
>  	unsigned int tail;
>  	unsigned int head;
> +	u16 queue_index;
>  	int packets = 0;
>  	u32 bytes = 0;
> 
> +	queue_index  = queue - bp->queues;

nit: remove double space before =

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
