Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F03C76BD;
	Thu, 18 Jun 2026 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787094; cv=none; b=I6qHt32pTlfsb3cMrTQuh1fbf3K27kVcTcGBIxl9ThQeR/+ibTHn18hLnYaY2LVH9dx7obC3P8DSolQ0m9qkM2nMSS9ZJta5cccAKa8rRJBjmBdr0T7YAVSPN0fv1l2m1QJjxz9JwFPB3ExJzFdx+Jf4/73A0IxoS3ahoqbo5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787094; c=relaxed/simple;
	bh=ZwnXwxkWqhx679FI/5lvpRu5cz5vkS0VwKGWTySAldU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTlU0LuVTpoEey1RvNS1uNnu9OEtB0z+uds0aUmNVLCsNAVhwQ6ocg2v/WmxB6BmjrfKeLkMT6TPZXQql/cwfD4stB9ED9jKpXPn38BBfOR917w7RKpfMl5i1PrMDBP3RUWU7S2RkfQbGjyAa10+TV+8r7XZiyvBm0BIYyulr9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4JeH3Vla; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mJu4YcAF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4JeH3Vla";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJu4YcAF"
Date: Thu, 18 Jun 2026 14:51:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781787089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFaGeVb4KkPS81ugpUkFN0IK2OSklyWnevwBRk4zMtI=;
	b=4JeH3Vlars1ols3ZldP3gMVp4R0iXg4pimbasWXj66NHHNvMHhzqg1Dz0g68C04N6mo0kL
	Q/hBBOld2CEP3x3K6EzvsRF80GmK86sTdRPB0T7JV3RohGPi+qwRsuXIAmSrPBiZEzXJ62
	QUgAZg0GsXIj/uXHPhL+iRGuEBIOHpNral6fcL97B2FQut7+hwacLccwfTrDKLygLjRZES
	80sl3C7/41mAl7TdsXFwqR+5R8lAI6I64ew4rvrir01RWsP59xWL2v3WiRvcY0MruVmQQK
	A9qP40mDZsg6i4HpxAU5iyXuQxdFzlz3YhgMz7DpawuxkOZ0keiFlEBHAA5cGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781787089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFaGeVb4KkPS81ugpUkFN0IK2OSklyWnevwBRk4zMtI=;
	b=mJu4YcAFd5/MWvZSOSLOrRAgGys++uYiH5HsafKMVYi4Rs+7eDpM0LoGc4KQ/O710ydVCf
	DHwfueINBAbsxwCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: mvneta: re-enable percpu interrupt on resume
Message-ID: <20260618125128.h5g-StPH@linutronix.de>
References: <20260618104351.3456161-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618104351.3456161-1-yun.zhou@windriver.com>

On 2026-06-18 18:43:51 [+0800], Yun Zhou wrote:
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5907,6 +5907,9 @@ static int mvneta_resume(struct device *device)
>  	rtnl_unlock();
>  	mvneta_set_rx_mode(dev);
>  
> +	if (!pp->neta_armada3700)
> +		on_each_cpu(mvneta_percpu_enable, pp, true);
> +
>  	return 0;
>  }
>  #endif

This does not look symmetrical. I wouldn't mind if mvneta_suspend()
would have the matching disable but this isn't the case. 
But if the thread is idle then you have one enable too many, don't you?
Well you have the NAPI callback which does disable on the local CPU and
this resume which enables it on every CPU. So this does not look right.

The interesting question is what happens to the enable_percpu_irq() from
the mvneta_poll(). Is it lost? And if so, how/ why?

Sebastian
