Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608626;
	b=Tcmb6MDJtwmaKfGv+5+Yb9MaZowNrue2BUHSRRCkDBT0zPsppoTkreXob22im4vTe+0T
	 /f0f9f2L2G2vXx0keECcHr/CfZ+z/4JUbjmpagkSNRy2FKWBwK+5gSTr7no/VHauTShFV
	 oFEXistRb2XKdZZC6fdChxAneiF1MZNK0jhPKeT9ghoyFcOWVxlFi35XKsz/r0mVSm8p9
	 IDQGQe40QDzXtwO5LIVtJ7+Pf95H5qrs5mVKgOdnwqYyUjbNa8VI0h0OHkFngfPOZ0Ayt
	 PDpW6wnebx4sYeVOb5f0Wkb6atfOTDSONlfaOvPL/+RH2fdcg1scTCAq06ZriwQSzSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608626;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=lfr+9f3d0uSXwEEu6qQaZk27BopGzDyuDbKtBIZ0OVU=;
	b=uKTNxmdg1vs4+FNo9WctF6HWf7Uz2NvEuVL4QNKpYU5YqxAqjdKmBZSB0Qha2Cu07H3A
	 dJa5mka3T0H40MoEDzbL3TMLJ3yBK2wvmpaJ8/ff0BirDaUFT4LF6/HROoVFmUqbb9sNJ
	 yNxOYP8dXHTPAumQFEJ5o9Pog32iVfHeFv6JEySfYNQrVZ+0pJBAqSs1Ec0tQoFHbyKww
	 m15wYYQ0wfw5o0tgmkE8Ut7Z+N6LUjHuKsgPSP8V16vcQc5QhThwxt1+oGpTGVFezmEAK
	 CWeFvIWIuNlA2B52Wb94HhVypqUL9yMGSga/be8ZGFI0NDnVy56QCD+r/w0cdFwyh2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TCaSoz+D;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8678606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8678606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TCaSoz+D
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C26F9C8F447;
	Mon,  2 Nov 2026 08:38:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE76B60750;
	Mon,  2 Nov 2026 08:37:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6286910329123;
	Mon,  2 Nov 2026 09:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793608620; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lfr+9f3d0uSXwEEu6qQaZk27BopGzDyuDbKtBIZ0OVU=;
	b=TCaSoz+DO/wzRp2Sz1lkU5w0pxuYwycMzx9SH1Wr7XPr0oGIz5YdiRmVsK2OlSyy3J2Iaq
	u6LWiI7sNn1oAwOCtJ9Dtlg+QXv1it/jJANgVoc1F4b2pWU1cIZ+bu/kbBrrm3batPP82X
	sJkpkvdsXBazNjL3e/tdhA7F1Ij8IVWluJ7WxtrY7kyN7yGACRSQIYwdMa55LZaDmOSFG9
	1xQ09j4chDBGdeVw1YK1EMJa7fgJKz5beObCjMYp9sB9hQ40kDfFs/jMh7zi+rkJMGlF1S
	Ao9AjHJOYlDnyVpu4NyOqByLuIaLAqqpgVkrvXCtXGQa4diXJOPaThYcDhoBJw==
Message-ID: <f5a88825-2d0b-4f5f-863b-e2369d009d24@bootlin.com>
Date: Mon, 2 Nov 2026 09:36:54 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: dwmac-motorcomm: mask the MISC interrupt
To: Nicolai Buchwitz <nb@tipi-net.de>,
 Magnus Leatti <magnusleatti@kernelriot.com>
Cc: Yao Zi <me@ziyao.cc>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261102080938.2955-1-magnusleatti@kernelriot.com>
 <805aeb73d9e32b237bcb30c8fd44ffed@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <805aeb73d9e32b237bcb30c8fd44ffed@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/2/26 09:29, Nicolai Buchwitz wrote:
> Hi Magnus
> 
> On 2.11.2026 09:09, Magnus Leatti wrote:
> 
>> [...]
> 
>> Russell, d3265c19b35d ("net: stmmac: xgmac2: disable RBUE in default RX
>> interrupt mask") describes a similar storm on xgmac2. Should dwmac4 do
>> the same? I have only tested the glue change.
> 
> AFAIU RBU is the cause. Dropping it in dwmac4, as Russel did in  d3265c19b35d,
> would cover all multi-MSI users.

As I commented, the other solution is to properly ack it. I'm not convinced about
the RBU interrupt's usefulness TBH, even when ack'd it makes a bad situation even
worse, but it does have the nice effect of making this visible by incrementing the
associated counter.

Anyway, this issue should be covered by this :

https://lore.kernel.org/all/20261030102251.208929-1-maxime.chevallier@bootlin.com/

Maxime

