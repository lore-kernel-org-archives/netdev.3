Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385360;
	b=Ctv+1uxWAHkwxZna5fn7QHoWfHLUJMM5aEVKON+HrlexOo7QChuTJQCkoHSXOmJ/ITNu
	 rcSGdtF2Zu77F6UYw+vvARdDaWtYRUKrP4LjPdDzyz6B1NFTp2WxdI5e/gHDqp16llaCJ
	 nkdAkk870jHQIIkrsIr2IQSMDHrVQgev/HYpraxP+Hxi2W/hOccioY5kZ86iCIrTavIZr
	 u786vWThsCQ+egQHTpHWM5Iqjyz2WtWcEecRjsxb6ADR4nBVXpTHa0y7bxb6rqKfsDl71
	 X5zUAuedJV4wqG/vbIXEm0335SCdzjXOC2iLS2MG8z8jhuGjjDXeWpQ7w6B1WCtMSbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385360;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=v1FQrKsL5f19EKemgEuMcNZOXhqO95k4RyWWOAZDF0E=;
	b=Sd2IAT2jZwN4jDCdSlr9aa/SJYTeO4SdQ9CfOk/+oFjOTIw9eLpTxu29sA0diBqO3ZKs
	 1oxEY8X9tSnPXoos6fQIjbq01BknTw5n0kN4f4HBZOVk9XeBdJcDuAZu7nIUAZUCFkxFs
	 bDZ2BfAAr68HfwnD8iwzBT9T4EyaLL/QJHAvcesDBlc/QgGhwLc7vBGX1gn1k8poHLh95
	 o09HCCWiJxqWcHgCfEpl2C78yBvZVGsv2cKp8byocHT3fZfNq1HuWzYjJ77caW5+xt/Lq
	 TznMUcstcjV0XcndxTebbJpcj2aFWtnTYw9YAh6xvr9FmTQ8yNljEy7kiqBoy64L4jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Du1c83Xm;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF981606A32E;
	Wed, 11 Nov 2026 08:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF981606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Du1c83Xm
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 14EF71A1604;
	Wed, 11 Nov 2026 08:22:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D65FA6017E;
	Wed, 11 Nov 2026 08:22:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 363D511BC1818;
	Wed, 11 Nov 2026 09:22:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794385355; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=v1FQrKsL5f19EKemgEuMcNZOXhqO95k4RyWWOAZDF0E=;
	b=Du1c83XmXW4RTimL6RazFjOTZSXCRppgWXP+IdIvbn/X2D4IBE0iiaUsR3hh8xqLynNr9O
	lJN+MWtFrgRQ2HbY5V85hhJrn4QiBS63udBRm9KPD/dzTEf07yMMw3MlIbrYpufi0UQKR0
	5VkOJ+BbsNdT8upae4Ljl5ggK6neDz0ThfitQpvaQSnePUULFr9rp23f0Mz/fUN+Tq02Wo
	awcfcNdE0WGdpQ0yWSFbTZuJB3VAbIi5+E0NBYPc050nLuxflJnLQbqSjIPTXtzbRokQI7
	K6f7lgqYji2FffX9R/G0xRUPexgvQziDmVplapkl3keH32raQu2JRy3CJvDRMw==
Message-ID: <d3ba44a2-1692-4c18-a297-b04bf82c18d0@bootlin.com>
Date: Wed, 11 Nov 2026 09:22:17 +0100
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
Subject: Re: [PATCH net v2] net: stmmac: Clear DMA errors for multi-channel
 interrupts
To: Magnus Leatti <magnusleatti@kernelriot.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Nicolai Buchwitz <nb@tipi-net.de>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
 <179379704484.488856.2140619507341432623@kernel.org>
 <20261110091901.7080-1-magnusleatti@kernelriot.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261110091901.7080-1-magnusleatti@kernelriot.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/10/26 10:19, Magnus Leatti wrote:
>> Since RBU and RPS were enabled only for statistics, was masking them in
>> multi-MSI mode considered as an alternative?
> 
> Hi Maxime,
> 
> Tested that route on dwmac4 (YT6801, 7.3.3) next to v2.

Sorry I was away for the past days.

Thanks for testing,

RBU exposes the problem, but it's still lurking even if we mask it, it's only
a matter of another interrupt being enabled and we hit that again...

Let's deal with RBU separately, I'm still not clear wether re-masking it is
the right call, now that the counter works, people may want to use that :(

I'll send a V3 shortly

Maxime
