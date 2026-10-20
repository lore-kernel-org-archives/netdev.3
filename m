Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488795;
	b=5T5nLaBFLubgT2BsDtmXsSPK573XG6gmf069dIy66yUX6Ih0h0bppAzRRp331a4IXOAI
	 dygtO/d/84iCl6WxbJMUx0sVqiAw5rqCQb6szz27fVXYjsk6KFIOQuUfm/dGVr4qkYmTG
	 6u/y+V4mJsmnbBjCskIqSkGyaoFhGXdBYDLGkjE80aZ/Rdx5xShkxOcjXewdKOIPdf6JM
	 GuvlOCV54YlcHYHQikKVGLaXZtFOZ57AoCFWnsjFSHsa4WQvSTgZUL7/4ipOskh4Pd4Rd
	 Wu/0235cqEiI/ccIh18rRJDaTyF/wTo1Sg/fiQHdu/UCu2YERhD8QqfYztB7+fRC2pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488795;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=dZoTt4H1bkHJ1iFFezg2ia6GW7SdKnykrK0ER0bdGsc=;
	b=aqlJR3oojV85QKUCycfkFbFu5VRcp8/5t671nwabZ5dpt4t5RtzlejkQUrE8wpB7ZeU+
	 lUuwf5nDar92fuvavWkdw2DZ9S6aoxdLHokh2hCgW37DmBtlbAkjqfn1khOgSWzm19UeO
	 PHCwM6nPHSOLwrVA16/gfWIs/ckNbYY+GRb0eaJDP5RMQNwEj9tUFBpgMLhren1Cgzm0H
	 Ou27v0GBJqOmrZh8RNEUkx5ua3eIvcFf8qs76/gU5F1Tw652MY5fbz5dEv7Z1FHcitImY
	 zDqEQC/kEgAY890Mgvx6m3jUWRCDuh15K2kxIdfkANEhLx/z/uIGGTvD87zxO/bWqcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vbhWYMIo;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C52606A319;
	Tue, 20 Oct 2026 09:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2C52606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vbhWYMIo
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4AB5B4E4128D;
	Tue, 20 Oct 2026 09:33:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17FAE60393;
	Tue, 20 Oct 2026 09:33:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EE1710328D1B;
	Tue, 20 Oct 2026 11:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792488791; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dZoTt4H1bkHJ1iFFezg2ia6GW7SdKnykrK0ER0bdGsc=;
	b=vbhWYMIoLd5Mn/nP4oRxLuUdxGbpgKYYyEd+/yUjHW8cWY4yBVf7sC/3Bax08gNW4B9mX2
	HS42Y57YrGqO4D2rzTDrcA+NJJkWg6LVreDQfvfRs60hbw47hSIIgBQUUxrEhRtOg7guFM
	vxM1Raqyl9EVjNE8QLzKzpeH01czxGo8g7vMb4+RUKzEyXMMjQPxT9s+olYKDsXhu5en0L
	rI1UbfMjk219FFdbeNgabAXddHAjApxBHiZ0AOp8cWgekKRUNuyok8f/qViOUxvyfB05CO
	7s4tNgtI+0Vi0+yPp0g0ifoEgWH0gf8N53mjXT0cU7+11qVkJuLw9ILmGQezuQ==
Message-ID: <72715cc7-da78-4ff6-a22d-f81ea8235b74@bootlin.com>
Date: Tue, 20 Oct 2026 11:33:06 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net 2/2] net: pse-pd: si3474: validate the channels of a
 PI
To: Piotr Kubik <piotr@kubik.pl>, netdev@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, Carlo Szelinsky <github@szelinsky.de>
References: <20261019162453.1244120-1-piotr@kubik.pl>
 <20261019162453.1244120-3-piotr@kubik.pl>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261019162453.1244120-3-piotr@kubik.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/19/26 18:24, Piotr Kubik wrote:
> si3474_get_of_channels() accepted channel 8, one past the last channel.
> The driver then accessed channel 4 instead: quad 1, channel index 0.
> 
> It also accepted a 4-pair PI whose two channels are not a channel pair
> of one quad. The chip forms a 4-pair port only from channels 0+1 or 2+3
> of a quad (2P/4P mode bit in POWER_ALLOCATION, PORT_REMAP default), and
> the driver sends every register access of a PI to the quad of its first
> channel, so such a PI enabled and measured the wrong channels.
> 
> Reject both at probe.
> 
> Discovered by an AI code review agent; no shipped device tree triggers
> it. Validated and tested on an SDG-9000 board (MediaTek MT7988A, two
> Si3474) with Linux 6.18 and a modified device tree: one chip with a
> channel at reg 8, the other with a 4-pair PI on channels 1 and 2. The
> driver now rejects both at probe, and the unmodified device tree still
> probes all eight PIs. No kernel selftest covers PSE hardware.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

