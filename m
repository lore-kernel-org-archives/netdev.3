Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B62931FB
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118929; cv=none; b=MtaQELpE/lu7h9qs7jHlag3kZ5C2KpugzDztlZBtJa+/5MqDZL6zQbf38nL1WypwRhzc5G87S1uheSdO5AFMlO63D6HXIZbYycEYGNuUHQiYRmD8f1enZ2Tm3PxvqLpokn87mFDKqhkVOPb2Oz2JcvvO/bPNRsVdiB348kXVsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118929; c=relaxed/simple;
	bh=D8G/DxC3sbFcmkdTEMWDDM3Z8rtxRaOgeznM3s8ryoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMzWqgoBBzWvVIYYrgqLxqmizKgtz4VFuPlWqf/GenUhMruKN5Fh65j2IBNYFyZBVdLyWsdF6tiTvZVVJcnDfnV3Is/HACHPgVHpjJ4TRswXg+23Obr4sAuVOalASbWGYL1DmoeEUaH0P+2+DMVyzaPFWikdSgVKkL4ZkgCOwrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aD5Jiji/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aD5Jiji/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C23BE1A01AD;
	Fri, 11 Sep 2026 09:28:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92144601DE;
	Fri, 11 Sep 2026 09:28:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 286D611C7AF8E;
	Fri, 11 Sep 2026 11:28:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789118923; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZOCOVInC775WiBtqQH5pSV36SDX5kInkJA9FSrFvl/M=;
	b=aD5Jiji/jcKYCmhgOG4txZ+FrxgDrogxM96MJW4fmpStxLY0A/quwGPuuDjd/UlC92cMGi
	AubQsBFwmOpM6eGZAqzKcAZJ/hwDVd8ZBW3txW0Auklp/hbx3H4yaGeRHqpvxF3ooeBPVH
	1xhLLFy2DgZuz88GxSBd/9dW86YtzBwtPUR6coTJviNJRhzUjgQb5EILDXj9rGLXpj974j
	STNu3HlOYVismUbumDR9++8TZolCUGboEvZZJhCFG/AV6C1i8Ou/EWiHe6X2WzQ8+HcFpZ
	TASjWnYLTAU79cEyDEPvvuyq/RQ1BI3kViE1Wo00vXNVuJCDv51zSiCXAzxoOw==
Message-ID: <476761e1-81f1-48d8-9946-0f0696ce26a8@bootlin.com>
Date: Fri, 11 Sep 2026 11:28:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: fix TSO header length truncation
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Niklas Cassel <niklas.cassel@axis.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260911-stmmac-fix-header-length-v1-1-8fc103334327@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260911-stmmac-fix-header-length-v1-1-8fc103334327@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 9/11/26 11:20, Lorenzo Bianconi wrote:
> stmmac_tso_xmit() stores the protocol header length returned by
> stmmac_tso_header_size() in a u8. stmmac_tso_valid_packet() admits
> headers up to 1023 bytes, so a header longer than 255 bytes wraps modulo
> 256 (486 becomes 230, 256 becomes 0).
> 
> A TCP over IPv6 socket carrying a few hundred bytes of sticky
> destination/hop-by-hop options makes skb_tcp_all_headers() exceed 255
> while staying below the 1023-byte limit, so such an skb reaches
> stmmac_tso_xmit().
> 
> Widen proto_hdr_len to unsigned int, which is sufficient since the value
> is bounded by the hardware limit, and adjust the debug print specifier
> accordingly.
> 
> Fixes: 9edfa7dab811 ("net: stmmac: enable TSO for IPv6")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

