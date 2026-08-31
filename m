Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338233985A;
	Mon, 31 Aug 2026 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178106; cv=none; b=bzFe5IMZepdy4RQOnWV+k/zUWV5U/RHsy1nHiCSRw2+OSadUYLfFwnoDRi2nME68Lj1vYXNSdhG1grO2vecbNu9nA7185PVhH1GTuIQYpG1o1nHSH/+GYcUvtdFilpRE2Yt4K5KZDeTkjheri3/Exdr/s/odCqoGVaA7cMpdmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178106; c=relaxed/simple;
	bh=bfKvOVJnh+gqcTLgTc3sL898dxN096IjlFy++ooTqTc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QujXF9vLpAZXUOfj52TV5KpSOAL8KOAxHyfimF3Yq5Sr2eWMnZccWTHX/d1V/oJRHWHEH78VB62p6+wBo5UKuzLjZ6pr3epgufnqIoRR0ph+D/Krtw1o6wvrJxKt2ReT922+e40Enuic7iKJnfEe1uTlXS65wZrapFptL6XNe3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=kV/L8QR3; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="kV/L8QR3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55126A418E;
	Mon, 31 Aug 2026 14:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788178101; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ceJ0urgjIvM+xk4P3r/siRK7ffCtzDxlqr54gAHNC3k=;
	b=kV/L8QR3myytINkq9yVmoxKTh+Q1iiB1ehv2mLOuNyn6sgVyOXlD2c1thrGR2RxcmUFMmh
	ZgQqWOCZvqK+nxbBttrL8wfBzeT3F5ai5Tl4VhEt1r3MuasSM7DvJfrMrvNYHFDM0E5Qb+
	U1M6Za8xuyrDsyzl6K7B1Y/8+P6BdyQGA7nEUsnJrY/SkLMB/fB3DJVwRVqZapDooRLgHN
	3ARGMlsuzkLSQ2kW76iLsY5tJpqUdl3I2e2AZhGoqDrUgOok5w2VKX0Uc1bkL7ZzjCD5bV
	p4dqgLZV+L0eBZCAnhsbfcuBzywkaHrQVadmEGplH4nhujTOQ9mEZ96cXrvpAQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 14:08:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next] net: stmmac: Remove ARP offload code
In-Reply-To: <20260831071351.354255-1-maxime.chevallier@bootlin.com>
References: <20260831071351.354255-1-maxime.chevallier@bootlin.com>
Message-ID: <adff6dc3cc322d52b1c1ba9c3176b433@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maxime

On 31.8.2026 09:13, Maxime Chevallier wrote:
> dwmac can do ARP offloading, where the HW replies to incoming ARP
> requests. This requires multiple steps to work well :
>  - Program the local IP address in a dedicated register
>  - Enable ARP offloading
> 
> This is halfway implemented in stmmac, as it's only ever used by
> selftests, and these selftests are failing on at least 2 platforms :
> stm32mp1, and jh7110.
> 
> There have been some attempts in the past to support this feature, but
> this never made it upstream. Let's just remove the test and that code,
> until someone actually wants that to work. We should likely have a
> proper API for that so that drivers can use it.
> 
> Let's also not mention ARP offload in the stmmac documentation.
> 
> Leave the defines in place and the capability detection, this doesn't
> hurt and gives some information about how the IP is synthesized.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
