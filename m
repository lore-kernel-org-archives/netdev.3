Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607787;
	b=wIKfkyRowQvca3/RUwbuIiRoJGoj4e0lwFeWthA61HivqCEnFJbi1W3hwOQsNze0IF/w
	 pHF5s2CZnG1VY7BX8ZSFWO3jRmmEMSUc7IcfN/kkdNx8iVUaMproV0y3fF4DslFXPTwnC
	 dWlJ/SBvuGQzSKe+QdvC+1pQSTxnqYdCEIXtB+f/jwHbeeQVVTFczKu/3D2UqC/I7+m9X
	 2ev5VqycUidMn+d5VD2lB8TrTa+st0PT+pFtxkD4u/qgy5OR9oAfKEZKEJfdjaH5ipGcu
	 +h8bDURnk31b9+VzLr/GJWJArtteP2EejAgt/OHTqbS7A81qrR6wNfbxlFMN/qboquA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607787;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=kaKlAjkcc4R8jkpGOd7sZb4iaQO79DTZVsVAMxaaeHo=;
	b=vBHm4wMxqGJqAC3CScsOciXAk4b8XWLMfBcpif9Nvz53a2ItXgNcuqkibWtdQGX6hnia
	 8AGoQOXvL7ZDPfEWeuRMA4k0zqSVgfRr6cJX2BjkWeO7uSrvgZuk2bWjOWSfVrRy1m5Xp
	 6HSz8nHZpdkU0SXn6jpdINtEG9l5q3X3F838kwTYkpCTvEUSoYgRBtV3oxzZA4Wjzbd4X
	 ytKcn6Ug9li/yyQO/uEUuN6eiOD0q9JHSgja8DwbJMFgUdkMXkOMTrduh249pX52i7X62
	 SC26TepfNE1viN2bhGC8XhdpIOTQIHbJacu/dCdxhErMTrU90ryShgF7EUJjJGNLq4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ThPIICXA;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFA606A324;
	Mon,  2 Nov 2026 08:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4FFA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ThPIICXA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 04286C8F446;
	Mon,  2 Nov 2026 08:24:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E738960750;
	Mon,  2 Nov 2026 08:22:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B721B103290E8;
	Mon,  2 Nov 2026 09:22:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793607774; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kaKlAjkcc4R8jkpGOd7sZb4iaQO79DTZVsVAMxaaeHo=;
	b=ThPIICXArd8S5NyDuuRcKMV0Lsi9+AnvaGdvpt3by5ofB9et56fu3HDKIV6caTM/GJVfNW
	da8nsHRruxuewWrXN2tP81B+0b/ZoQnsEDgIfZNDhZyxwTS1WTES2j+dPD4m1/+AscmLiR
	ZoM58yz6YOjsz+A16VqzrvX1M+JrNQLpmFQUjfVkppU7i5kfrUVZjg8nZFPRc1C74ooZDQ
	K1JfYDRvxod1V2fuVkpfum9JRa95D1jQ4nxFJc35aLtuJcZKX9e9B9EfYemo+rxjf/utWW
	NUmUNJwLZawSHR8aq01ldEsn3TGdHGvHXXA3U9uXpIpKjOBFr+dHv6G3LQzOZg==
Message-ID: <20d4a3c3-99fa-4659-8d5d-eb5eefcf6545@bootlin.com>
Date: Mon, 2 Nov 2026 09:22:45 +0100
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
To: Magnus Leatti <magnusleatti@kernelriot.com>, Yao Zi <me@ziyao.cc>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261102080938.2955-1-magnusleatti@kernelriot.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261102080938.2955-1-magnusleatti@kernelriot.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Magnus,

On 11/2/26 09:09, Magnus Leatti wrote:
> motorcomm_init() writes 0 to MGMT_INT_CTRL0, which unmasks the MISC
> interrupt. MISC arrives on MSI-X vector 5, which stmmac requests as its
> MAC interrupt, and nothing in stmmac clears it. The vendor driver masks
> it.
> 
> Since commit 1b9707e6f1a9 ("net: stmmac: enable RPS and RBU interrupts"),
> heavy RX load sets MISC and it never clears again, even though every
> status register I could find reads zero. Vector 5 then fires about 120k
> times per second and the machine stops responding until the TX watchdog
> resets the adapter, or does not recover at all. A 64-byte UDP flood
> from another host is enough:
> 
>   iperf3 -c <host> -u -b 0 -l 64 -R -P 4 -t 10
> 
> Mask MISC, as the vendor driver does. I could not find anything else
> that depends on it here: EEE is not supported, and Wake-on-LAN uses PME.
> 
> Tested on one YT6801 board with net at cb284914e749. Without this
> patch the flood above hangs the board within a second. With it, no MAC
> interrupt fires under that flood or heavier ones, including after link,
> ring, MTU and speed changes and a module reload, and throughput is
> unchanged. Suspend could not be tested. The register values were read
> with a debug build of stmmac.
> 
> Fixes: 02ff155ea281 ("net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller")
> Signed-off-by: Magnus Leatti <magnusleatti@kernelriot.com>

Can you test this, sent a few days ago ? I also saw that storm, but it didn't
seem to be motorcomm specific :

https://lore.kernel.org/r/20261030102251.208929-1-maxime.chevallier@bootlin.com

It should address the issue, doesn't require masking MISC entirely,
and isn't motorcomm specific (this storm will happen on all dwmac4 multi-MSI
glues).


> ---
> Russell, d3265c19b35d ("net: stmmac: xgmac2: disable RBUE in default RX
> interrupt mask") describes a similar storm on xgmac2. Should dwmac4 do
> the same? I have only tested the glue change.

The above patch should handle these too on dwmac4 :)

Thanks,

Maxime

