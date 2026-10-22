Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792646451;
	b=a7KzYs9is+w66XJ1eoBHt4li2oWKejLMob2MSJFwC/njreNqkDEmXBr40ZEB3pSbzvll
	 w6/zcN4BKX8zd9yFhX/nhxZTHqc8gO6tkRptu7QloKfVGAeSsKA/UBvv8xiDBMdXRswEA
	 4IjJwaTjFF1+1WIojp57cymdOw+LN0EXv8u98iJ/hoWN2dXEUvpwMcVDVv5FYyPZXp7lk
	 6z+hw0m1axp5fMECznCjszkNO12ZppOOQBrey4w/DKB1HebxkNa7BnIWWow0glNZl6O1r
	 Vgz2rBcQoX9blMG86gZ12cJhDXOItPiB9twNxWFpkGJJ75KZpRdugjfizUk0xkJCPrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646451;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Sent-From:X-URL:X-Accept-Language:
	 X-Accept-Content-Type;
	bh=NQGD0qfscRrFswdmrZ7wBUXG+FDtegg7roj0OrW3evk=;
	b=0MdEiTsYlpW0pQ0/NzhPZVrMEuWuCIHzahA+83vWwDGvam6+nZwjosv5soXoT0r6GYnm
	 SRgU8A23NvTaXFEaOH0n2UbTh1yOvm1mGqAuYhlt7GWCd4s5yyU7m3CGo6RaPwXewCwqL
	 hlDbaWeONNJMy00DZviiwJp3UFg8J00emEHW89w8ysastk4p4b4cKuwCajZ3jkDceS6df
	 c4NX6pjxfYHjkuu3pqB+brOLl7aQu0vdBjD0+Y/ZQbTRwonQZxr1fIkLZJshqg7h4WWXk
	 VMCN9rDs3nxpOOgr1Fzb9CYxcdiW9cBtWcE9bYgtpTJ96RF2yDauHRfdiw04jkOsz9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DrZEJN6d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA46606A319;
	Thu, 22 Oct 2026 05:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EA46606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DrZEJN6d
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E38C32008E4;
	Thu, 22 Oct 2026 07:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792646441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQGD0qfscRrFswdmrZ7wBUXG+FDtegg7roj0OrW3evk=;
	b=DrZEJN6d6YhT035oVTbH2tOPFnADJL2K7u8txVruSYNuM2QSD/tARbFkfcrZMnyr5Jgtsq
	8SnHyzNTE9bs92/HSJJRAi60WduyjKyxOVOlyImbM7VU3O5zdNYUiIeZRF6JsDhnUCp93d
	EiTDqSAF/hk/tIO5035GGG7rlEpLqdXlaNnZ4Q1uMVHo3ZGaP0fDmqCSBWTcpB5ZU8ooKn
	xlTRmRWmd3ydPjtZhlSAnyB2Yk/7W73R1Mm+/4Up5HLz4OLeeyr9fQtd3Q0ND+wR0/FZs2
	DXmhqGxXHt13kRwLYT0rlnb/G94YHyzI7jhdYHrUws3037MOTMODzSY+lsyu4A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792646441; a=rsa-sha256;
	cv=none;
	b=WeL/1KQVW5Csew3sJgzXJQAhd07r5XXlYBPleuHgR5kB4Dzl0F5zhHq0/2d33Pc7+JfKnL
	POK7E8s/kgqdnUkgmB89rh4tgN4l+GwiGvgJCtTkdgbALJ60yhYMicQJXIyqqiVcQ0d45c
	yJc5Fi6kJKVLGybhpMxrQpT8LyYhSeU9TDMpQZ1T/jX4a9OLdJi7qvWPWNGluqOAR9xO5W
	Bh67L3s5DGUtsKVZ3TW71dSiADFUbxc1Ri7KFsO1Hdb24+SP2BRetJgQUxdyQ3NzjKrCX5
	Wx9rM71RvxpLuZpGX4mbwbU5RGTrd9lZQxEhdJzU95pHJaCMbfCNlP94JXv4kQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792646441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQGD0qfscRrFswdmrZ7wBUXG+FDtegg7roj0OrW3evk=;
	b=hDyjYvm5guN3ZbCujP4BArHQfLLGv0CIOZHYgEZ8NXIWXy2OgN4TU++eUZp6jmR/u2s5nU
	jLgh8L4nzrn/5Way1p7uhmwbHiA6AuCNQ+KY+LECxazxxUAFDdCcVYjiF611cZ4MqZxO+l
	q2pGxgf8hfPIcmaFv9zz8yUSQFVj+OyPhO67w04QYNXcrkpSSQQckmqHrnyjfWbf6lCig/
	nFRP3Vxr6G+UZw15BS0Lo79MDxRuXucssKzChGFrbdgkuvBD0GWmk6V97Kkgljj4Bkqe2z
	Z/JaLjxDlB8GEARzn/OlQRwvLhOBb3QhW2/CGcHF2p4Xd3KO0MagFTAqt+R9ZA==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xJlEH-000ewI-2d;
	Thu, 22 Oct 2026 07:20:41 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xJlEH-00000009PqR-2aLY;
	Thu, 22 Oct 2026 07:20:41 +0200
Date: Thu, 22 Oct 2026 07:20:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 08/14] net: pse-pd: stop async event sources
 before freeing PI data in unregister
Message-ID: <atmdKXGU3jMOKB91@pengutronix.de>
References: <20261020171249.853085-1-github@szelinsky.de>
 <20261020171249.853085-9-github@szelinsky.de>
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
In-Reply-To: <20261020171249.853085-9-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Tue, Oct 20, 2026 at 07:12:43PM +0200, Carlo Szelinsky wrote:
> pse_controller_unregister() flushes the power domains and frees the PI
> array before it disables the IRQ, while pse_isr() uses both. No in-tree
> driver hits this: tps23881, the only user of devm_pse_irq_helper(),
> requests its IRQ after it registers the controller, so devres frees
> the IRQ before unregister runs. A driver that keeps its IRQ across
> unregister would read freed memory.
> 
> Disable the IRQ and drain the notification worker first, and only then
> flush the power domains and release the PI array. The next patches in
> this series build on this order.
> 
> Found by code inspection. Not reproduced.
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
