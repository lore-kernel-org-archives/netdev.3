Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712102;
	b=ld/p99km7FyuEUa3mG6WLK+hr5iI/3+uj/sEvMzX58Q2Irp3L+oQmifuvhl7Z8X+QO69
	 nVbJsuSDioY4+rzhhFKTD7oBxFuIsA0dgpV7Mb79Coaq9q37fHTu62z9ggumlYoq3I/59
	 vCGOPxxVf9Ea5QJjuVvoUi8eJFD+NVsejabyMVH00HBC9pfcq9aX/9tvLdcxr1oXQdUIZ
	 NroAoH5cEPOSbopXpHCW93zUd8zPdc//D1bXHsrryO8q3/OZke9C46Au1AnqBX3nnRDaM
	 CT00r7mosi5topudgPcgYZ4SSaj9XgUvie7KqAqh7Il55Z/nDtmIdxzM2WqjudX52sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712102;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=4i7JeNgS3PqRN89dO+cpnOVMM3es4j1AZjQVBIQdGUs=;
	b=Ch7wppAAi3tPECy0zVGzjawA7z0tnN4bb9vPi29mp0CMFE+dBZi/1IQC2ZPYfkhQ0/kH
	 OG5H2G8Cjxe1qrk5K0wPX9AFtiDy/j6S/PYHSxjB1tCenbDH7vGhu0iuQewDYuPx0CChp
	 LeTqZOjZJBe4CNVzzeifIgVaGWgRIriBf93B/PZW5VhAL/G840bCAPtdg/wxp8dH0J7SV
	 q+HzcR/xoli7nyiAfU3CKk81fF+V1RkNtNrhhRunT8ylSkZ6rIDLEiIASq6NoZh1R/bF1
	 BXISdUNVWOjX4Bf1Npu41lzRIZDVZMm3JgO5W+SSN18bGBBPK8DzY88f4C1y/3+GWlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="t+URNc/r";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630E606A32F;
	Tue,  3 Nov 2026 13:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D630E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=t+URNc/r
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12ECFA1648;
	Tue, 03 Nov 2026 14:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793712097; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4i7JeNgS3PqRN89dO+cpnOVMM3es4j1AZjQVBIQdGUs=;
	b=t+URNc/r60MoZy96AxoqAKxv0aiqloRdmJ8e59KAjvzK44rrpCrCXMkv5SoSrCNrtzbeAa
	Vks8GVOW6j9f+vuuDEjqctWXcvSomv0vXToVIMFyptKvJQtvox49KLs9kRYFh42UsWAfSp
	Rj86BtBBuyrn1m8O29j/zUEqPgfCN/CS0yT1ia1e7HiiXMl0vlEcOs8Th2kR1Ok+sOwDnv
	BQrsLKs0luXhMQIqI3NqcpJjWvrR7fFScABtyplK2GhaWDrJ3LFYf9ikDPWcXjYQpQqKxN
	zxHfBgs9QdAF+cA+KtBYYIQtxg7o2WIATF4bMlBoejUxDN2a9ymII9qqmRRdtg==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 14:21:32 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Magnus Leatti
 <magnusleatti@kernelriot.com>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: Clear DMA errors for multi-channel
 interrupts
In-Reply-To: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
References: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
Message-ID: <4ae868bcfbdbc0f74ea5a9d57094e7fe@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime

On 3.11.2026 13:54, Maxime Chevallier wrote:
> The Multi-MSI interrupt handler doesn't clear the DMA error interrupts,
> and this leads to interrupt storms when one of these interrupts starts
> firing :
> 
>  - The RBU (rx buff unav) which triggers under high traffic load
> 
>    This triggers easily with iperf3 and small udp packets, and shows
>    when running the netpoll kselftest
> 
>  - The RPS (rx process stop) which triggers when we stop the DMA RX.
> 
>    This one shows when restarting the RX logic without doing a down/up
>    cycle, like when attaching an XDP program. The XSK kselftests
>    triggers it.
> 
> Let's make sure we clear these interrupts for multi-MSI cases, and call
> stmmac_global_err() upon tx_hard_error to avoid possible races with
> other interrupts/napi.
> 
> For that introduce an "ERR" DMA dir, as we don't want to touch the
> RI/TI bits when handling these interrupts.
> 
> Both of the above storms have been found on dwmac-motorcomm (YT6801),
> and are triggered by the xdp.py, xsk_reconfig.py, xdp_features.py,
> ring_reconfig.py and netpoll_basic kernel selftests.
> 
> This seems to only affect dwmac4, there's no multi-msi mode on
> dwmac1000, and on dwxgmac these interrupts are masked as of today.
> 
> Fixes: 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for 
> multi-MSI")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
