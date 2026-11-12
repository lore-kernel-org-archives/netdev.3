Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443797;
	b=jaikbc6BbUTOs9IAlxw0PDewXFbFAvc2FovE90O/HqyK1bU8sDtvJzzlvgWDHevURQk4
	 I7glnxJ5qtYipt67eP3ZwcyTKMD6s8QqjKtpctXJ3S7mK59eR3McYrAMdS9kLKEUNiuLI
	 5ppCdFkWEEYOyjXX8tvHGMLjg1AYCZWH5G3ct4iVLXJd1tzacugu2GKqOt7RiQy2y4/x1
	 Q2rKWgT6BVTdXCUVOo3sPR57LZp2oQZdhsNmJv2Bk8hCXbo0hYMNup42/hiXDQi/pJVtl
	 LT9LZSbgBzja9AEf7VRK8oESal300KVlWWxm9OzaJmdxoG9nFW7frslAHizF3CxkpuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443797;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iV+es/fp+vyxHucc03Dfn1TU20M5SwM8Ekj9KO5fn7I=;
	b=Na3hKNy2STk+UHY8kttKxofy9ZSAFMxEVdhUrP1m1osOXXpPdZrXyHa2hivJPaxLA1KD
	 l6DCUj4pPzLvh0qhnX9QcTmszuExps/NqbeGQNYCAP1qmcWSUN66WMBnfQhtWW19H5WWq
	 JjucvpqC/qkoSRVuNUPSF8sL5+f/yE/+wLwahxvXs7YBWw9VaMt1KJw9XYPh8VsEXdLXr
	 3JLMYZbC2cxWrWjV8JDvFat0Zzm4feTQ5CoBh/gH3iUNJglToNS4HHgZSvrMmRMok5jil
	 YitnoG+KhzkrCwjnetvPlAk8AYlbf4wSvMqIuQ2G2gFIFamOb1UOAv/jqiDgZWuVV1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flsXT5+t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB1606A324;
	Thu, 12 Nov 2026 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flsXT5+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDEE1F00A05;
	Thu, 12 Nov 2026 00:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443797;
	bh=iV+es/fp+vyxHucc03Dfn1TU20M5SwM8Ekj9KO5fn7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=flsXT5+tcmj//681j+iBaPwWWx0hanIAZykaBz+rgOLLDtZ1xxZXmSt3dB5qM/SPs
	 wdpCgLiAom8akYYjG0liOHd7gU+7fRdZ+oihZdhx1pGYQcFoN3/bcFcRvYxsP/hpun
	 0iswwTIY1P9x5NS5ItKQ1ht9jC6WbAavlvJ1OKew5LxrAl9rlLLPfZ2HZ81qWj+o87
	 6+tm2ylVXkowdAOPZM0p+5gDOJyq1wKGUtlrh/J3YIKWZ7YKsqyQ/HDL/h3nYGJYqn
	 aEr3hCtDmMDNKsvq52WuSx+pJq7kOtOGRgyeDc/NdmwjHRT2uYNo/x06q7FKJrAdX9
	 ytbLjEzdrzP6Q==
Date: Wed, 11 Nov 2026 16:36:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ding Hui <dinghui1111@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org (open list:STMMAC
 ETHERNET DRIVER), linux-stm32@st-md-mailman.stormreply.com (moderated
 list:ARM/STM32 ARCHITECTURE), linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/STM32 ARCHITECTURE), linux-kernel@vger.kernel.org (open
 list), dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Subject: Re: [PATCH net-next v6 RESEND 3/4] net: stmmac: release descriptor
 resources through priv->dma_conf on open failure
Message-ID: <20261111163635.042fc7ec@kernel.org>
In-Reply-To: <20261106090507.1020751-4-dinghui1111@163.com>
References: <20261106090507.1020751-1-dinghui1111@163.com>
	<20261106090507.1020751-4-dinghui1111@163.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Nov 2026 17:05:05 +0800 Ding Hui wrote:
> __stmmac_open() copies the temporary dma_conf passed by its callers
> into the long-lived priv->dma_conf before setting up the hardware.
> When the open fails after this copy, the descriptor resources now
> belong to priv->dma_conf, but the error path returns without
> releasing them and leaves stale pointers behind. The callers then
> free the already-copied resources through the temporary dma_conf,
> which aliases priv->dma_conf after the memcpy.

This patch is not sufficient, as AI points out.
The duplicated error path on failure of __stmmac_open() indicates 
the state transitions need a lot of work.

We need someone who knows what they're doing to look at it.
You can't even read what the series info bot is asking you.
Please *DO NOT* send any more patches for stmmac.
