Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535363;
	b=FsnX4wwFv1D/OsnLeUU6e2KqckLh+jxZGGxlpnVuNHtKN/spyoy/dw59YQPxWesTyQGc
	 NGuGBF/0FHbXVA/y5xeLoQfdO/PywUc4W23WAmbdsOBw/hEniHMvZ2vlaum692qe/wcZr
	 HQ8gdV7RjYJDOmo/yuxpvOSJo2WaHqpTamF+opjsw95ryZHxc7OBs0mkY4hzjAdAr5VUm
	 ZL25e1DEiEslZzVaN1uGcHbGTpwTDTW2ESVEXyIDFmCe8oBmx8RZptZnau/TgcNPPrq5W
	 IQZoZD6YB3t4pDgrGbvu9lOlA+mDP1u1HFw4Q4gjHl274qA1MhD1XNiruneuoE0m9AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535363;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nKzBstValFuOg3CDf7s3NznDHsW1rCQroiqS+pQQYj0=;
	b=heOtIqbCjMc/HDNxikW+Q9YcgrUAxbON6QVy3LAsgYDcFga3nvTEU5Ni5O3/JCk2wSc8
	 OU8mPYO4k+3WztpfoOqitSlu+Inryr/YmnN2Y+Zq5TeryNZedRGTeblVcRv3XSwJ0/LA2
	 ySMgo0BqDzHol29bueMVbzwf7zsuXyi5cgZoMMQ/iEJEruxcrpgeW1Mw+gSdtNdUcqo/i
	 Z2+Zajqjh1gqj3LX9V5fNdhRNaTm9QSAZExAdMdwJkVoBejW2/P9VBtNK3OJydXQL3seE
	 b9SPSQLAXDpAsE0Gqqq0XyWmqK4TZlyp3rQbSqXbiBAvwzWgkbDPiTxyx23EfwcjZxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8OsJUtF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2A606A319;
	Tue, 20 Oct 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8OsJUtF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D7F1F000CC;
	Tue, 20 Oct 2026 22:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792535363;
	bh=nKzBstValFuOg3CDf7s3NznDHsW1rCQroiqS+pQQYj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P8OsJUtFTzDA/MAstoE8U8cQfWdftq9h9+JO0l3kV7l5tR3Gt0fhKkmubMnHK10pE
	 dFufRGyjjgg1eCrYQqJi6Cid0RufaPDR7OKEWvm+9dG+ZX04Xiu40eK2Bj46KdysV2
	 jSn3fNsx2UMgSmGlug7pvYI9Sg13UwRDCOAil7qctKSrmQ2EXUsyGtNOzIvdN1fG0H
	 nWHcKsu0De4v+ds8GZo0IIEbRmfKOOINzce6mbfNWoIED9d2H81UALCSdRV1L5fEAk
	 n5pPKJvztna5o4CnjFkS4pw+qvwnAn/YGNMynXToFYC7/6z94Amf+J8gzLUam0qjBo
	 V2Twce7yv55rA==
Date: Tue, 20 Oct 2026 15:29:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 xiaoliang.yang_1@nxp.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: stmmac: Track and report the TX DMA
 threshold per queue
Message-ID: <20261020152922.4d06ad30@kernel.org>
In-Reply-To: <466cff3f-e3bb-4581-9e79-f4a980570244@bootlin.com>
References: <20261013114503.57487-1-ovidiu.panait.rb@renesas.com>
	<466cff3f-e3bb-4581-9e79-f4a980570244@bootlin.com>
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

On Tue, 13 Oct 2026 14:44:43 +0200 Maxime Chevallier wrote:
> That's a nice cleanup, thanks for addressing it :)
> 
> Patch 2 belongs to net-next though, it's not a fix and it brings some user-visible
> changes in the stats.

True. Given the merge window started, tho, I'm just going to apply this
series to net-next in one go.
