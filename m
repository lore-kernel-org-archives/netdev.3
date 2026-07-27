Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7F3CB548
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139231; cv=none; b=Ji4pfmBdhvmA4cBjpsPfgAN9HtRpGmCtrYLs/UNhyrstIiVHgJhS6tftUdH+8uGNGs4p+/MUdtc4KnahdNGHwOltXo9D8243d+JzfQR0T9y67MZfGiw8AIXqE5Jk2W6X3dgibq+xFubWpj8OXpU88/5X+H8ZR637teLDCLHYhsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139231; c=relaxed/simple;
	bh=F6fhJknoV480uTIxhupKlRyYkkjfnvWzDXem+GlFXF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGjlY1NXmNdHWG4JJ7/SidXGJTGjZSI8MNz330x9RODWuYYvjTbcyNjDbWGC7znFbtRU0SIV2Ksvr5mxo7ZUlrFmwwjY7oWb/EWlpoawzCpU0yHvINVGwGSVCgZtBkga7Ln8G6PW2oDk4TdT/TSawdAC+t7TUMrgZgy7RWAq19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p58xJv/U; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p58xJv/U"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8738C4E40F93;
	Mon, 27 Jul 2026 08:00:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5483E601BE;
	Mon, 27 Jul 2026 08:00:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E64E511C11D0B;
	Mon, 27 Jul 2026 10:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785139222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TCgAr++ZKTBKmHy6N3VhDAe8aZilNVKvNvH0soTVb1M=;
	b=p58xJv/UlTaDCatpEbF60gVDBUMZIm36zbgwWttdW0gv1Owqma5wAVtIWEcOowNQPypgrl
	cOlhVAGCjWH+8CA2D92peEJaFY3kXXIXpm8Ri+eLcFKsn3lsUhC+hf6ObSizeFMsCG1/kk
	w4v4jBljCNPzF7RZsPAnjKXYuQY+e75g0CrAiTS9zlZD/8xHfwo//K6h/gygrjF/Py5lmU
	mL0pRuASO2Fx5H25C1BSwyFn6Clv/tgyLLSBhOz3VVaIGqrJVWJyef+X4WgVzHYJx3T42D
	2XPzz8q7HtVtTSZI6qKlRBWXXfSnPuA3nmTaWmtGY5aFjhXWVEHV29bZKQXvHQ==
Message-ID: <1e258c0f-8663-4dfe-a0aa-7c8be67d6afe@bootlin.com>
Date: Mon, 27 Jul 2026 10:00:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Disable queues before netif_tx_disable
 in xdp_release
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: ansuelsmth@gmail.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org
References: <20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/27/26 05:06, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> stmmac_xdp_release() calls netif_tx_disable() before
> stmmac_disable_all_queues(), which creates a race window where NAPI
> is still running while TX is being disabled. If a packet is still
> queued at that point, it can be processed after TX is stopped,
> leading to a kernel panic.
> 
> Fix this by calling stmmac_disable_all_queues() first to stop NAPI
> processing before disabling TX, matching the order already used in
> stmmac_release() since 7028471edb64.
> 
> Fixes: 7028471edb64 ("net: ethernet: stmicro: stmmac: first disable all queues and disconnect in release")
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


