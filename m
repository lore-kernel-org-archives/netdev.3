Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8334FC32F;
	Tue, 13 Oct 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895497; cv=none; b=mXC8EWvVRKSt6XMUwhxNaNVo7nmubAAHdb0He+hblDTL+m03+MrNGhixBfUn+rJJoBfOvoIB1tCyFnpQrOUnDn7aC3ivpWaWs8JNjtlR1tox4BpAOqNOHpAAswfhrYqRo/A2v6UZVH/D2DSXUJBYWIneP2O2B2Bm7pKYl6QXrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895497; c=relaxed/simple;
	bh=rwimsV7WWfqay6PjkWdOjkxAMwIkAcRuabH+7MQne5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaBgYN5C/gYl74X8A0W5irp77pg1mbnpq3I3VElMOQth6227GdjB363N6GVnuwxG4M/dYN2o+0J9kb0P+UZT4mcU2SgAlVrBJM7DDcDExC8gTFE/A9Vu0qLMU/K+gZ5wk9V6OndB0cR1JzK0v4AcWx5OhcyxYAJ3grCBvNUYnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B3sUm9Tw; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B3sUm9Tw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F3C0EC653E9;
	Tue, 13 Oct 2026 12:45:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E83760362;
	Tue, 13 Oct 2026 12:44:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5249811D71222;
	Tue, 13 Oct 2026 14:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791895491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=voXwZ9GHELmdvfKeQdsY789oye86zxpZWfwrsUceQ0A=;
	b=B3sUm9TwgIx8zQVOu4RffReXIr80NLD8nNv0kqomZGwBCtHfHil5I+1reMgrb5UWlKEZQN
	AJNa9S9bZ519Mi+BLt6S33dLQU1qXUgZAxuTSGXaMQhDiPj6sC8qOo5GxTVQwlEBB1OwMX
	8rNiKZfJYkHASy38FTN6JRZ/MFaMnZJNHbKwl10PIMdJ1XLktrbzMyM9pK+LeiYgsctnvq
	oM7l4qmK9CuSR+M0RZD9+EVcvheewhUBaXeK0a9P3ZiMBlunTIEI0DPL3Pf8r53NWrUh2R
	igVVTPwmwHjTARPRaXVWPSNy0uRFegT5QLCUgawMJkJQze4lABxUThtV3cF0og==
Message-ID: <466cff3f-e3bb-4581-9e79-f4a980570244@bootlin.com>
Date: Tue, 13 Oct 2026 14:44:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net: stmmac: Track and report the TX DMA
 threshold per queue
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 xiaoliang.yang_1@nxp.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ovidiu,

On 10/13/26 13:45, Ovidiu Panait wrote:
> On the Renesas RZ/V2H platform, which has two dwmac4 controllers, we
> observed sporadic iperf3 TCP TX failures on one of the controllers, with
> throughput dropping from >900Mbit/s to ~1Mbit/s due to TX underflows and
> the resulting retransmissions.
> 
> Commit 3a6c12a0c6c3 ("net: stmmac: bump tc when get underflow error from
> DMA descriptor") made dwmac4 raise the DMA threshold of the queues that
> report TX underflows, by increasing a global module parameter 'tc'.
> However, this logic does not work correctly across multiple queues and
> controllers, and can leave the TX DMA threshold stuck at 64 bytes.
> 
> This series fixes that logic to track and report the TX DMA threshold per
> queue for each controller.

That's a nice cleanup, thanks for addressing it :)

Patch 2 belongs to net-next though, it's not a fix and it brings some user-visible
changes in the stats.

Thanks,

Maxime

