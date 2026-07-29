Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972844E02A;
	Wed, 29 Jul 2026 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324562; cv=none; b=COnSJXwwU/Ugn2NGbxn46ppuBPOGmNgy7x4YxXf31g0rWGWyzB27oL/byc6kOOU3uBRuQWhmB8KqKD8uvMl5EaFJP/GZl5aBygEXay+pqPCLhVNdTbpzP/ZmKKEfUncfi+Bw2415vtMWPYdsCXZwJQREfB6WpXE13FFKt2tf8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324562; c=relaxed/simple;
	bh=3a4gaf9P7zzOuitlGJ+efD51ue889tzYCnn0fws8GD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoW5+Wg42+RH2ZsDrSlsnqqzjNBNSQg8o6y3t8mmoQLydQgQYskA8eDm7R9po1UYg6QZ1cnZRLvpHhfA+5zx8rtdHexxGNzsLQp10NLcnUU9LY6i3hg7WPWc2mUhV1juwDFb/F6tcHOaELwUgyy6fpPOL2yNNp4RA4BYxgRO4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HmE6icOX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HmE6icOX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3CFF91A12E4;
	Wed, 29 Jul 2026 11:29:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0704C6039A;
	Wed, 29 Jul 2026 11:29:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2B6E11C14D0B;
	Wed, 29 Jul 2026 13:29:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785324555; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Y4GaCzJfKdWPEQK8WoFLpEX3LNefX5WnGnSukVLLsxU=;
	b=HmE6icOXq2SlGAWTVfNoPO/Q9lYUr1b4nFdJySBT8J479G01gHRw4g1oOGLNuP/6OMUBVR
	8Mrfz2mEonjxMfUFduPnk928FOV25Sa6J8nyXmlPUdZlWwMjTuYWrehDgUJrRdIapMj/4S
	JiHTJWjgtAtMrxK8j0UapeuNcir3+EpuriT7zMOFXRgp24H7OJ0/pZCqbJMcZoy6c5k9/E
	wlhWAelfoFuYFXAMJcZ8JxhRdTkIQDfKEUN2W2kSjemSY8MIX/m1M6fgZZWICLb6NRBDoh
	ILPdKvBHWb73oOf/PFaJ8gq+AWQPJ87up45f756XzQMwyRxLrBAqzZJsSIxjGQ==
Message-ID: <dfe9ee00-6a8a-418d-9440-339631b31e52@bootlin.com>
Date: Wed, 29 Jul 2026 13:29:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] net: stmmac: Remove VLAN perfect matching dead
 code
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, jun.ann.lai@intel.com, yi.fang.gan@intel.com,
 boon.khai.ng@altera.com, matthew.gerlach@altera.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
 <20260729095110.164157-2-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260729095110.164157-2-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Ovidiu,

On 7/29/26 11:51, Ovidiu Panait wrote:
> stmmac_vlan_update() falls back to "perfect matching" when the VLAN hash
> filter is unavailable (!priv->dma_cap.vlhash). This fallback has been
> unreachable in normal operation since its introduction in
> commit c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if
> HASH is not available") because the NETIF_F_HW_VLAN_{CTAG,STAG}_FILTER
> features are advertised only when priv->dma_cap.vlhash is true.
> 
> The fallback is also duplicating the code in vlan_add_hw_rx_fltr(), which
> is always available since stmmac_get_num_vlan() returns at least 1.

It's not exactly dead code, there's an stmmac selftest for that, see :

https://elixir.bootlin.com/linux/v7.2-rc4/source/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c#L973

It does exactly what you say, it fakes the fact that we don't support vlhash,
then exercise the perfect matching path.

But is it correct to drop that feature altogether ? Or should we just
relax the conditions for NETIF_F_HW_VLAN_{CTAG,STAG}_FILTER to be
advertised ?

Maxime
