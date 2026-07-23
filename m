Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B041D223;
	Thu, 23 Jul 2026 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814660; cv=none; b=ZX7vzRjZ5YETlIKvufLLMfUH5KlPWy6ZPb4z58QIk4ljfHQvpC/UzQAk2IyMVf6umTwf8OroKTbNVAOsKGvcBThd6fPSpUyzIwbB0nNTyU2LTy5UjevY5xlRyOpGWI1s8KHd1VGkgFMpEmPZ8Tckk18ONfhW0JgVWrIUK5knAso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814660; c=relaxed/simple;
	bh=NpEdA24+3neR/QPLWIzPRHER7UTlUX4EjHDjSQi5ISM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hM7F719wTEinj9J8RUVxPvQaTFQbOtmHqNoQEMAKABMxiDCN77zew3XE/QxhYYDcXlJqwmb+aC4UWr/dBZuY4/00F36/U0yXjU/F+WnAxk7djNnug0oc7KRAiY54yWLG5UTcSYqV7fjYT53DfwwZEcBKYhE+NG285xRXYwxgg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A7KGBBGY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A7KGBBGY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4A8664E40F09;
	Thu, 23 Jul 2026 13:50:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 00B66602B8;
	Thu, 23 Jul 2026 13:50:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1352B11C10ECC;
	Thu, 23 Jul 2026 15:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784814655; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=v8GlylfMh56lSH0MmJr4csaHcuWkam1QB5X0FqSvV7A=;
	b=A7KGBBGYy3n9pJkxfsWBfVjnRhgmh1GJA6tTN/o9At4egKV/WSrjcRiiIJ8K/ThQ4/2RJ0
	U7ZpXsD/YrckZnoV8dcpoWenZcZcRoo1FftjwYu3PH0tL0xaMbjfeVWJku2EhGHl6zzDW2
	TJRyvVfTlVzR/DlQigZcFtd5VjuipZbAnYQxAbFsLSjjGOcnQGoYjU4+SOOEkzvPu3nbVs
	JBz2Ha3VXnCyhlTRa+mKLeYwkSLeArfQhNLbiHu+mrK5MYWwtgQgryax+qQIhQ7szZvXik
	drw9WqeHHzIW1uTNLqh6VaPzQkZjGXp2ZaSY/vJjcpArRHfcmQCVBlz7UkZj3A==
Message-ID: <f979a974-a9ad-4f4d-9e57-9f88900298a2@bootlin.com>
Date: Thu, 23 Jul 2026 15:50:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwxgmac2: configure INTM for
 per-channel interrupt routing
To: Zxyan Zhu <zxyan0222@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723132457.3061337-1-zxyan0222@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260723132457.3061337-1-zxyan0222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/23/26 15:24, Zxyan Zhu wrote:
> The XGMAC DMA_MODE register has an INTM field (bits 13:12) that
> controls interrupt routing behavior for DMA transfer completion
> events:
> 
>   00 (default): sbd_perch_* are pulse signals, sbd_intr_o is also
>                 asserted for each completion event.
>   01:          sbd_perch_* are level signals, sbd_intr_o is NOT
>                 asserted for packet transfer completion events.
> 
> When multi-MSI is enabled (dma_cfg->multi_msi_en), per-channel TX/RX
> interrupts are expected to arrive on their dedicated lines
> (sbd_perch_tx_intr_o / sbd_perch_rx_intr_o).  In the default INTM=00
> mode, sbd_intr_o also fires for DMA completion events, but the
> multi-MSI handler stmmac_mac_interrupt() only processes MAC-layer
> events (LPI, PMT, timestamps) and does not service DMA channels,
> silently dropping the interrupt.
> 
> Set INTM to mode 1 when multi-MSI is enabled, following the same
> pattern as the GMAC4 DMA_BUS_MODE_INTM configuration in commit
> 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for multi-MSI").
> 
> Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>

Same logic as in dwmac4, this looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

