Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793366765;
	b=gKQ0lGMRzEfTJ3eFrjR84r/NfTfrVjCKdRvl+7/wNiuP98UK+1AZdn1BNlPOsxL7Cy+b
	 SyD0TvA3T1J4nnYjsFKFRPDG7ckEIT4DEuCxjmLi/plfFvcd+Jq8nCDcr+7tkSxW/BDLb
	 CmKJXP8deaLQH1MIbK+rx7OAdRxQQbp1senTShsbs/6ojs0doPzWuDwKgrmQgCXHBA6r3
	 8R4AwvB98dNJ4Eqw5HJO2vLDI1cYVDc3cuPgvOtQ+vlLvmbpjzhtQRw9R9lu0l8EdnAU+
	 /aZ5lcDXy1yggavS4Ml4b3SxyUY9N/rceIWmRbzcKZmo1TMSd01qKIoYqB1HlapPXaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793366765;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=AuxF/+sQ/UQdcElAHk0l9a9PKIVFoZySrr11hiSSgY0=;
	b=HExhM61PHgv3sOjVNZ+0Kh/M0Xvau9F63PI3TsDf+j5cnZ3NQSGpx2Rp+g7o2pDerVup
	 HREHGhJSAhZKDwNHA5E/1iJUD9H/9mhPN6er6VLUeXAEdVz+enMuWs0tA+btvmvNqBL2J
	 d5w84VscR4jKGtnyDzbGY8eZKj9tD9aKgCgDCYUlUl7WsaoiQ+x0QQzoxvBWyUQfWc0Cr
	 vd56uQLKerpVeDWMTHt5WcMI+PGYrnzYfvnOVkM3DyF6rzag1mGA/Zta+5GWnZoO5T4jp
	 Y+mc1ma9rmS0ObwFD6lbBntZrM6mms20dkVZk5HQPIB/oA/CRUw79AAwHj3JlFmr+hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Pd8/w+3+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8E8606A31A;
	Fri, 30 Oct 2026 13:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C8E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Pd8/w+3+
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0177F200AD7;
	Fri, 30 Oct 2026 14:26:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793366761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuxF/+sQ/UQdcElAHk0l9a9PKIVFoZySrr11hiSSgY0=;
	b=Pd8/w+3++qktJlDCj+45w8dcKN1gf65UBEJH4hTwwlixCRfLVc9X0cMzhvm56iwGU8wKnh
	FekeJAIFVNleQ7iVawkipxia4OT8ka3FfAs7oHhOTlkX/uUgWvcicfFaQ3C8nJk9fuKMmR
	KHdJ06Hc7vczmcfKrR9Jxnvy7G8BjOJdZDTsGT/Gli5hOe8HRmhNu4AUTPTJCDGGB4Xg/W
	Pksy4phJBr+akdkUrGVBajKqdAwr0zXCqX3BqBm44LJ20A7hJZhndAcZZHyFSkrg/cyd1n
	p8B0oQgoBu7aJnWTNBBCl4oA4q1+JR/yTqttec+YNz+UgCOoUySDn3naBYkp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793366761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuxF/+sQ/UQdcElAHk0l9a9PKIVFoZySrr11hiSSgY0=;
	b=LrsQYzRF0mmijGfs7U8wkqhK+f6wnFxsIFrQeVKL2YVBIfcZdIViQDtPlzBnzaveJ7hHiT
	Sv7gVTIOzTYpgeDPyidhBzfxwBrwmUADoLcvnaXNzXh2Tg8Or1jdtv/STuWBwvP9OgSEEp
	ojfzYdVt2mhbHtvtyx0gZBPR/5iQQNx3HVINmx+x8Jm4OUht+Xw7mt/cufVz1XdJndHwrB
	e5hzbGLlK/eaETrYvVXxzITsU0deEIxBNh9Lq3TUcxJOSHap8k5iXlh5SsM+poMTjCrgnV
	SQKWGNgo1PS5IBY6BP1ZTXoEBVEQi6FIGoRxHv6wNcLl33RNleUcD4LZfDgO/Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793366761; a=rsa-sha256;
	cv=none;
	b=AUoLDpzSx7dVznQ2eTsOVIFP1aitg4Uc6EbxWFwF60a9bEAsjaMr9MPErSUx/7MDJ7nW0a
	Jbn/O+CwWWpfNevxgEv5ma36XlSzLhwOzP8KpT1eGMQ7O7cFm4+dRxQl4rQ07w3RYNHpjZ
	2gx//odRjPl51osC07cBomL8s805znA0w+eFQ+sGl7XaAjmk0FrhGTSGLYgZDpoj+EmU5k
	IeD0/00+H2JvYLWOTHJ7yMeIWjBtX2poLPB1sBA8yrE3AufWV5KDaYrBpKcNLNVhEXV2FW
	UBJfYJYWI9KuF1Y6soiV1GnSJ85+0WqcGBsVs+v8+gsg2Z6vD0tXUdg1RyYRTw==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xMmcK-001sVU-2y;
	Fri, 30 Oct 2026 14:26:00 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xMmcK-0000000Epla-3Jyj;
	Fri, 30 Oct 2026 14:26:00 +0100
Date: Fri, 30 Oct 2026 14:26:00 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Carlo Szelinsky <github@szelinsky.de>, netdev-bot+sashiko@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 06/14] net: pse-pd: check the PI state under the
 lock when setting a power limit
Message-ID: <auSa6OHeftNNLBKE@pengutronix.de>
References: <179274321449.3134.2737207729630977183@kernel.org>
 <20261023215441.1087277-1-github@szelinsky.de>
 <3b37693b-bc91-4c76-8df3-7e66743b156b@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b37693b-bc91-4c76-8df3-7e66743b156b@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Fri, Oct 30, 2026 at 12:30:16PM +0100, Kory Maincent wrote:
> 
> 
> On 10/23/26 23:54, Carlo Szelinsky wrote:
> > On Fri, 23 Oct 2026 08:13:34 +0000, netdev-bot+sashiko@kernel.org wrote:
> > > [Severity: High]
> > > Do admin_state_enabled and isr_pd_detected really mean the PI is powered?
> > 
> > Kory, a question about pending PIs. A PI can be admin enabled with a
> > PD detected but without power: when there was not enough budget when
> > it was enabled or when the PD was detected, or when a PI with higher
> > priority took its budget. Such a PI passes the check in
> > pse_pi_update_pw_budget(), so setting a power limit reserves budget
> > for it if the limit fits. When the PI is powered later,
> > pse_pi_allocate_pw_budget_static_prio() sets pw_allocated_mW again,
> > and the budget reserved before is never freed.
> > 
> > This was the same before my patch. Should set_pw_limit skip a pending
> > PI, for example with pse_pi_is_admin_enable_pending()? If yes, I would
> > send that as a separate patch.
> 
> Sorry for the late reply.
> No, I don't think we should skip setting power limit for a pending PI.
> Lowering the power limit of a PI could allow this pending PI to be powered
> again with a smaller power budget.

Ack, makes sense.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
