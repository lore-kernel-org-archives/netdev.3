Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22147C0FE;
	Wed,  7 Oct 2026 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363746; cv=none; b=BC4Wm5RG53PReSvzzncIQzJECX6L52s0lvhsc0aUarOdTgIf+CDfBj3Ybsh5m21psAB/6ETkiGqrLJ5LzEYx4pyjKmkMSC8LL8mx5q8jvy+SLxL64pCCFRZ/Ruj6CsMCyWs1K7gc0vrB1mnVHeK001Sgy5+i8nk3dmcDr4PQsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363746; c=relaxed/simple;
	bh=AR2xGLZKIferTHOTi087PxlTZF+2KDb/LdX9Yw9EXqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPsvbn36ys/PrfzO7RfUj2DNJUG+JrSzlj/r7v86SsKoOtpCZTkVTxF915WiLMWveTxbhr9WLCEMtiYTNaSidhg1g2NRRmV57kouJrlZCcOgeoWkIkw/n+01FfKJ9vZOJKSSVQGdCGoJuSwsgejtnSpZISMOupgXEIkKcXRKGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=TG+G3m7W; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="TG+G3m7W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ymnwsRZDmp7x5OjeUD7x2IVlrPaB2H4EiiL0/5QC8as=; b=TG+G3m7WrdlyZZOh1EA3pX+6kl
	/hhKs3ZnOWjK0sk3YBAOcLmKvon6yIzzJEa68uGcy9m0NCFGLjcM6cXeeoekgj+qjOiBe0GJ3r6vX
	y/Iavs2sBSlRUsj0I/idLLltQJkmcW9CD4W3t7cy9XcMtXZl3usJWh1RIlZaT4l8aK2w200uj1RaV
	C2xSvJj2l1w5SploRHOMJujYodETPYiD76hFb+V8p60hslvSZWASLjREAmFYvfWpluuQ6o2KKYZRa
	fq9hPuo8lS7ju7xWtBwIGTwsGjKg2uW1ScthCi2Az4vCnCXcUXVl3Pj8BZ/0xWDumHrW1IDH6PDKQ
	qp4TFPRA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xENX9-004dOK-2S;
	Wed, 07 Oct 2026 09:01:55 +0000
Date: Wed, 7 Oct 2026 02:01:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Guillaume Nault <gnault@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: fix NULL dereference in skb realloc fault
 injection devname filter
Message-ID: <asYKFJZY45h52BhY@gmail.com>
References: <20261007004158.1266795-1-yanhaishuang@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007004158.1266795-1-yanhaishuang@cmss.chinamobile.com>
X-Debian-User: leitao

On Wed, Oct 07, 2026 at 08:41:58AM +0800, Haishuang Yan wrote:
> When a device name filter is set in
> /sys/kernel/debug/fail_skb_realloc/devname, should_fail_net_realloc_skb()
> compares it with skb->dev->name without checking skb->dev first.
> 
> skb_might_realloc() is called from pskb_may_pull(), pskb_trim() and
> pskb_trim_rcsum(), which also run on skbs that are not associated with
> a device. One example is a netlink broadcast to a listener with a socket
> filter attached, which goes through sk_filter_trim_cap(). With the
> filter set, such an skb makes the kernel oops:
> 
>   KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>   pc : strncmp+0x50/0xf0
>   lr : skb_might_realloc+0x58/0xa0
>   Call trace:
>    strncmp+0x50/0xf0 (P)
>    skb_might_realloc+0x58/0xa0
>    sk_filter_trim_cap+0x6a0/0x928
>    do_one_broadcast+0x35c/0xb20
>    netlink_broadcast_filtered+0x1a4/0x328
>    netlink_sendmsg+0x724/0xa58
> 
> The fault is meant to be injected on network interfaces, so skip skbs
> that are not associated with a device. Without a device name filter,
> such skbs are no longer reallocated either.
> 
> Fixes: 12079a59ce52 ("net: Implement fault injection forcing skb reallocation")
> Suggested-by: Breno Leitao <leitao@debian.org>
> Assisted-by: LLM
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
