Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779152;
	b=Q5D2L1IXJLHRnJPHOLD/+MelUJNN7GoiaisM3pA3znjjlbM9AcS4qffbudpz8RRDdpLM
	 hb0F7b5jTOes6qBqRUQIpT+3/iOC7WiaAYUvvgkFVNjPBqsNhHTvqgk2xoe7Uw6VUYQFQ
	 CA0bP27ItvkQ+CgI/NV/+rK/1pEcHMHQxiWXaU/cFoerNlXw4vO/wGtWOmOe+RbmycB1n
	 sy9iSR+P1wBkaodWUe+qB+VYdQLBRQptt+BsOTT6gbVEVN2kVLS4wsMPKWUEllL8Ee+il
	 exStWaHNWDcvQIHC9z0l0398LfAspAnF9ORkhUkAENPJwIUCrskLwMEDOTIieLKf6Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779152;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=FwddSV8gjKPLCgQSFLRj949WDVGR/jN2Co6X4wj9CHE=;
	b=dfbMLOJ2jgVlpl+475G+jXJzdz40Y281G6Ra7TCOCY2FKJA3OmITJw7Uk+Yk2eJ5XRxo
	 vbgK53vPL/JDFTkMMJdDJsrJ+7vpr8vBGSZMtnHvo7CYbG4E/68RP+FtQISBe3HM5BDZY
	 229+/B8KSy3RSS/fjPsZe4irlCJsjQbh4gEHjqZJjFXqpL9BIOuhAfvKdtFk414npEspo
	 rTdz3gGvVRB86iOJXhdmUW1Lw7qSYdrSXJCkh5bL2ZIC6qwf3pg3Cq7aul/vhir+4EgiO
	 aWbZhGvKjsuDo8P+5458DoWfSMGHG8C0wUk5g0cuH66hKU3RFd864BzKSGn/qwu0gcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lVsptOrK;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67A606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 07:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D67A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lVsptOrK
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 924BF4E413F5;
	Wed,  4 Nov 2026 07:59:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E22460770;
	Wed,  4 Nov 2026 07:59:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D3A9103291CE;
	Wed,  4 Nov 2026 08:59:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793779146; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FwddSV8gjKPLCgQSFLRj949WDVGR/jN2Co6X4wj9CHE=;
	b=lVsptOrK1Zz3jAzDZnQknIIQ56jf3OxAnl47CL/Gf9A13kNPIuuNDyelE8xn4n3Bftm/gv
	tjvzyR38gj0OTgMwS4euoaQnuomvxU4awLnb7fWIDD0EacgP1pMsB2NGTQf1xKEasEmPAx
	PPzgqj+y4UkXegTSv4jx9a3g2KHqnBwWBMVATy4dLXlkqNzqbO9UA+wtUngiIhZr5CvaRa
	JOIBTpQ9zbbSYQspKcWXrEHkyhdLOuLtllkGbbh9PSpgpvoZBU8/O1Xma/2+cVLl7Nzz7j
	XqS6Kyjs+/f/ZMIBC0/AkVlLGwlnJAthIvt2/Q1HoCIowxMa6YJwF9W3BJ81iw==
Message-ID: <963ddb89-fada-4340-b767-285ce9362d1e@bootlin.com>
Date: Wed, 4 Nov 2026 08:58:59 +0100
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
Subject: Re: [PATCH net-next 0/2] net: stmmac: Add the Siflower SF19A2890 glue
To: joseph@telaak.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Chuanhong Guo <gch981213@gmail.com>, Russell King
 <linux@armlinux.org.uk>, linux-mips@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261104-sf19a2890-gmac-v1-0-a15965a49574@telaak.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Joseph,

On 11/4/26 08:22, Joseph Telaak via B4 Relay wrote:
> The Siflower SF19A2890, a MIPS SoC for home routers, has a DesignWare
> GMAC 3.73a. Its interface type and RGMII clock delays are set in a
> small configuration block next to its clock and reset manager. This
> series adds a binding and the glue.
> 
> The glue is based on Chuanhong Guo's driver, which read the RGMII delays
> from a factory flash cell in the delay line's own units and always
> applied them. Here the delays come from rx-internal-delay-ps and
> tx-internal-delay-ps and are applied only when those are present. The
> interface type is set through set_phy_intf_sel.
> 
> The delay line's step is not documented, so I measured it: sweeping
> each delay register over 0-255 with the link at 1000 Mb/s, the working
> windows repeat every 145 steps (TX) and 144.5 steps (RX), which is one
> 8 ns period of the 125 MHz RGMII clock. So a step is about 55 ps. The
> TX eye is about 3.1 ns wide and the RX eye about 1.75 ns; the delays the
> bootloader programs, 17 and 10 steps (935 and 550 ps), sit inside both.
> 
> On the GL.iNet GL-SFT1200 the GMAC is the CPU port of a MaxLinear GSW150
> switch over RGMII with no delays on the board; the GMAC adds both.
> 
> The MAINTAINERS entry that covers these files comes with the MIPS series
> "MIPS: Add support for the Siflower SF19A2890"; this series applies on
> its own. That entry is also why checkpatch's question about updating
> MAINTAINERS for the new files is left unanswered here.

hmm not sure this is the common practice, usually you update MAINTAINERS
along with the driver introduction. This should be part of this series.

> 
> Tested on a GL-SFT1200 with the GSW150 driver:
> - each of WAN, LAN 1 and LAN 2 links at 1000 Mb/s full duplex and
>   passes iperf3 both ways (160-205 Mb/s out, 262-273 Mb/s in, well
>   under line rate; I have not looked into where the limit is);
> - 10 GB each way through LAN 1, after which every CRC, alignment,
>   error, drop, overflow and underflow counter on eth0 and lan1 is 0;
> - 50 link down/up cycles, after which the link and traffic recover;
> - the MAC address from the factory partition, and ethtool reporting the
>   link with no PCS workaround.

no PCS workaround ? what's that about ?

Besides that, nice and simple glue, thanks ! :)

Maxime

> 
> ---
> Joseph Telaak (2):
>       dt-bindings: net: Add Siflower SF19A2890 GMAC
>       net: stmmac: Add Siflower SF19A2890 glue
> 
>  .../bindings/net/siflower,sf19a2890-gmac.yaml      | 110 ++++++++++++++
>  .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig        |  11 ++
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-sf19a2890.c  | 158 +++++++++++++++++++++
>  5 files changed, 281 insertions(+)
> ---
> base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
> change-id: 20261102-sf19a2890-gmac-4fb4808f869c
> 
> Best regards,
> --  
> Joseph Telaak <joseph@telaak.dev>

