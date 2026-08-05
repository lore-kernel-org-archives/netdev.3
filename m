Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167293839B9
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946986; cv=none; b=BQK/Ac6bGndDfar3WODtG20ncLDYbDPX1dJ1CrL+9w8c4deLMSbsp4YZj/jtyrfb68d0VCqVD1br9eVrkIU5okktJcVhZsDpLfOksqjpFvjB/r0+C2555YxMla0StsRPe2abxD3Bcu8AM1syCA6Um98PVHNgiNuaGei7qi4Ou0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946986; c=relaxed/simple;
	bh=EFi9QMbmcbmStt0mvxapXfmtUjdOyVn89L+AKs9smyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTHVgQaw9IKdn3dCdupjNh6Mk6yZ7+9YmkARxRqwRttmuRTaD/LMPR6EhfThhwGrfplPgDnotRdQFJFDqmM5auTy0rHgsKjp6TgcWsDZ/37iwIII9iQPeEBtNXjmXUUj/twnSZgAHzrphNXCBhLbNxS5OHGX7FfLmru4wNtkKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vnkBKnvs; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vnkBKnvs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 575EE4E410F6;
	Wed,  5 Aug 2026 16:23:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0F3E9602AB;
	Wed,  5 Aug 2026 16:23:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A5C511C34EB3;
	Wed,  5 Aug 2026 18:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785946977; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zhiH3C8YzyGImWWnb0luRlvAbHRzG52M91VSHkIhB9k=;
	b=vnkBKnvsArY36bculXEhMf0GedgZpedCy1oYh7aOEiQ+tU7rjMxtw4bLVlqIGKVpNOhx7u
	k45ukAfhiNRahYUCAIFrZmiiv2fLgm0faSUDdlb35Rir+pXyglmi+ta6qo/AKwfpFyXZ3C
	w8+LZ661EnXMT/FczN313Eysg1feqmswUcTQlf29wransnRDTm4b+8oUzm1J8LrL/aKCK5
	Bq3TmSA6yRHUHdQ420/YW2qQv6ipTaFFy00ahQB8V7oUHJ5xIBhEgGE+vUvoNE/Rvg+t7p
	X3jVw0EJ90l+am1moQc5CrLbnYY0ehcJvT4TtggFRaWYLszulkYKcSmoxmso8Q==
Message-ID: <8e62565e-6292-40d8-bc05-a36869305a79@bootlin.com>
Date: Wed, 5 Aug 2026 18:22:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: add tc-ets qdisc offload
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Daniel Thompson <daniel@riscstar.com>, Alex Elder <elder@riscstar.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 8/4/26 20:17, Lorenzo Bianconi wrote:
> Implement offload of the tc-ets qdisc in the stmmac driver. The number
> of ETS bands cannot exceed the number of TX queues, and mixing strict
> priority bands (zero quanta) with weighted bands is rejected.
> 
> When all bands are strict priority, the MTL scheduler is programmed with
> SP scheduling; otherwise the requested weights are applied to the TX
> queues and the scheduler is switched to DWRR. The TC_ETS_STATS command
> is accepted and handled.
> 
> Export stmmac_set_tx_queue_weight() so the ETS path can reprogram queue
> weights, and wire TC_SETUP_QDISC_ETS into stmmac_setup_tc().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

From my very small understanding of ETS, this looks good to me.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

