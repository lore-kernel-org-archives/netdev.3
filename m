Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234983;
	b=VeuJtecq1WsmmMRevOWfPBYi4/FzxPxipmfvajKczxjrABZuMzBjbs/r+7kyIoECK64L
	 reVmKCYd9BIq13q/glJrwEdHwkpZiv/WMSMpMMm8tdYxtZqWj/Uw9ZkV93OMNJcA0HlNs
	 7HDYWEln/q+/vIWGwMETiHZCuZqRzUteVY3w2o2WRj6/Y2VF7lQI9ImyE++dS6RnSPRHS
	 OOJ7EBhxaNv/zS21Fepm/6qK2R402/RVBlb5UepEOzWNjVihyCCmF9hILzNRdY50xoBYW
	 Xv/0mldvITJrdCLEcaj8tRtwpgBYxUucwPTeMVEEvcZE4TE2t4rzfB0E/C+bO+d80Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234983;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YEtAZJ0iJf6+9fOufFHDxKIrhDR38R/GasJrb8soNE4=;
	b=d+oSvE0XlMriNc9wzfoMLlJkKSlsbodVYct78UaMj0mU4MpuaypcsC2KPLrVAEhMLZeJ
	 W5m93KI7M83pLTEd21EbqtNhDNhGuqyZvhWA2XD1Zj7wvYNcRMzo/K808g0aK5BXs+gRP
	 ZK4u4STVqnAEz7PffdI/ppusy9VGArsA6H4b6RZvFyqsBIrQH+eoZoqxQpSrK/YqJDxau
	 wM8Hq9amRHDe0cbCEOlqtbmBBAbliNvYpaiTTeWHbocFGnpVsQYS44fGPsa6U2NASokZW
	 fyC1XCHyD18EtU91coMW+xm/Wjzp5KReocfnir3ESG5dQs3zuDEgzpGzAszJTlLXvOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxGhbNfn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9865606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxGhbNfn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB3D1F01825;
	Thu, 29 Oct 2026 00:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793234982;
	bh=YEtAZJ0iJf6+9fOufFHDxKIrhDR38R/GasJrb8soNE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mxGhbNfnRMgqRHjivGhHxhr3ueGq6dKjw3Fmb162knHq417rPJkMaQDS2fqs+GSO4
	 d8cmu5orHQOfKkQRA2TUjnaShohfJilBI2jMXzGQxwFTIwdCas6lnzv+KwnKuHbFHw
	 wlhZWpwZjsU9bPeT49LqIDY0PVGVIZ9MoLzwXazw4Wrp/pBB7VCyksEA736ryKXWRU
	 nOr/6uUHoQ0o5HZIi5z9O0W9Vz8hvlnyQaN4NO/Uvq5tWBpmNbOPNOyxuQjcXwGZWV
	 tnj20kzkN/8AsAM/d+Mumd2UYeJEgYTlgnvMY3s1Ng5XiYDqMDyoVk/stID2Y5RkdM
	 PLs3nwvKB3TwQ==
Date: Wed, 28 Oct 2026 17:49:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, eddie.wai@broadcom.com,
 prashant@broadcom.com, huangjw@broadcom.com, gospo@broadcom.com,
 brett.creeley@amd.com, ap420073@gmail.com, joe@dama.to
Subject: Re: [PATCH net 1/5] eth: bnxt: recycle agg buffers when Rx head
 buffer allocation fails
Message-ID: <20261028174941.7db170f1@kernel.org>
In-Reply-To: <179323156398.3134.2862221492750758183@kernel.org>
References: <20261027234940.1267225-2-kuba@kernel.org>
	<179323156398.3134.2862221492750758183@kernel.org>
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

On Wed, 28 Oct 2026 23:52:43 +0000 netdev-bot+sashiko@kernel.org wrote:
> Low priority / nit picks for your consideration:
> 
> - [Low] bnxt_rx_multi_page_skb() now re-posts the head page to the device
>   without dma_sync_single_for_device() when napi_build_skb() fails.

This is what I flagged in the cover letter as outstanding bugs in DMA
sync which I have separate series for.

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch adds
>   a new consumer of it.

Same.

> - [Medium] At this commit, the XDP multi-buffer path in bnxt_rx_pkt()
>   still leaks buffers when bnxt_rx_agg_netmems_xdp() fails partway.

As bot realizes this is fixed later in the series.
