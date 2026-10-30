Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388812;
	b=nhPe8+QLhyWk7CeWuoNkD7iqLG+vao4UgdzE9UgY2ZwDU6Iv4xvipR/YkhSohV3Scs1J
	 T+aco+ucT2UisW7c4+0e2YUHArIgMVHd2VDUzH+ONZ5F+b9SsQKdXRounA2BanZc1adPZ
	 Dw0oLQn5rCIsla+1flUwID+vTbqL52QeT68G1keNacsNe2Sj2eB6BHaxxtM7oxFxl3Pcr
	 8wtoJVJE5FLQC9P5zgsQu7X4qdNgVGrx2GpKkL89ctpfQjkhQtIAwPPOo4wR6vTcA7/eM
	 bFjnzOGDBmxgNKGtjE0BR5AbteIV7O4PojXaAI/gAtIZmg7ElawWFONqVDrYeYiw2pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388812;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-Last-TLS-Session-Version;
	bh=QtGA4oygWFl5CX8vg4imBuTm2I065I8hD6TIKVaKg5Q=;
	b=UOrDTrosYaaGYxVWDkuNzuxP1syHdvMqbe9q7fQnqKJgXma572G/mEnvQQN9ksk0NGAu
	 D3YwFQkY+5aZdTqWMjik2N3FerdFisFqNJ6GD0pKuyA6iHyJWxpdKnyPmelnbYdH2fmw8
	 lXJwvYPmsk1HDCouFqr1/TxPJ3wiY25kjafHveXe1C/qh6Hi+DWq1P1ScCNORqjLU17ba
	 3o33rohoFYBwCfm2RZpzstl7fxdH4kBsCddux8LEh6bt8rLuXy0W9xIyAz7PAL6S0dbkh
	 LMeysCyUJ1vBH1vUYGpP+WhZTUY8JOxnOFplw9Opr4IhkN+93U8Y5f2Wici8ZmFM+iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=oN0n3S4G;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57B606A31A;
	Fri, 30 Oct 2026 19:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C57B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=oN0n3S4G
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6F0BA12EB;
	Fri, 30 Oct 2026 20:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793388800; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QtGA4oygWFl5CX8vg4imBuTm2I065I8hD6TIKVaKg5Q=;
	b=oN0n3S4Gd2LVGtKCDgtH54i2pOhilG/jMIpjCCAbd3+LpXofGFf61vIwpzBwcPREbEm7an
	p36ug+Vmik11e0AUTxf2NB1yqnHB4rwsnODkaL8EL2UbcvZU3CHWaxhC+neli9Zp9dfxlD
	btxU5LaG2pvvU9A8D7RiZyM3xNlZHkH9KfGP8aI4/N6owHRlg2hxePioLhy5eoVvTdabdE
	bK0stGfaC953F3oRg4QwmORBbTF4u/pCuXaBsSo5tYEXb6scv2o3bpyqX4lzrM+lIAeRpy
	aCYoEn1Hu6NiXRxuyfTYeH0C9anNwX5JSuXWI5QjsnWeABE2TksgvkP93INtIQ==
Message-ID: <3eb9f731c0facedbadfcba6ae490862e7f6e3fd1.camel@tipi-net.de>
Subject: Re: [PATCH net] net: stmmac: Clear DMA errors for multi-channel
 interrupts
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King	 <linux@armlinux.org.uk>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,  Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>
Cc: thomas.petazzoni@bootlin.com, Alexis =?ISO-8859-1?Q?Lothor=E9?=
	 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 30 Oct 2026 20:33:12 +0100
In-Reply-To: <20261030102251.208929-1-maxime.chevallier@bootlin.com>
References: <20261030102251.208929-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 2026-10-30 at 11:22 +0100, Maxime Chevallier wrote:
> The Multi-MSI interrupt handler doesn't clear the DMA error
> interrupts,
> and this leads to interrupt storms when one of these interrupts
> starts
> firing :
>=20
> =C2=A0- The RBU (rx buff unav) which triggers under high traffic load
>=20
> =C2=A0=C2=A0 This triggers easily with iperf3 and small udp packets, and =
shows
> =C2=A0=C2=A0 when running the netpoll kselftest
>=20
> =C2=A0- The RPS (rx process stop) which triggers when we stop the DMA RX.
>=20
> =C2=A0=C2=A0 This one shows when restarting the RX logic without doing a
> down/up
> =C2=A0=C2=A0 cycle, like when attaching an XDP program. The XSK kselftest=
s
> =C2=A0=C2=A0 triggers it.
>=20
> Let's make sure we clear these interrupts for multi-MSI cases. It's
> already properly done for the single-chan interrupt, and for that
> introduce an "ERR" DMA dir, as we don't want to touch the RI/TI bits
> when handling these interrupts.
>=20
> To avoid duplication, the DMA TX error handling is factored out in a
> dedicated helper (in the same commit to ease backporting).
>=20
> Both of the above storms have been found on dwmac-motorcomm (YT8601),
> and are triggered by the xdp.py, xsk_reconfig.py, xdp_features.py,
> ring_reconfig.py and netpoll_basic kernel selftests.
>=20
> This seems to only affect dwmac4, there's no multi-msi mode on
> dwmac1000, and on dwxgmac these interrupts are masked as of today.
>=20
> Fixes: 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=3D1 for
> multi-MSI")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

> [..,]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

thanks,
Nicolai

--=20
Nicolai Buchwitz <nb@tipi-net.de>
