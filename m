Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8D381B07;
	Wed, 19 Aug 2026 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125180; cv=none; b=l/lEPraIT6oa0Th5rdnQJv6gWbD6M2GYgdcOWJYQTg8bl5Tr8lneVxJPS+avJcPI59hD0fpEqir78mtoBFgTshA44/2odoDdO+EMPeWQtUz87fn2HbyTHKXnU8S1R1XzUQy/jVGyzKhYD2ReVsNJ2oVba1cirwIt1uYqrGxNsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125180; c=relaxed/simple;
	bh=vN6rCgHSlU5AL8ZqVwf3XVRyJ+O2xNT6Fxzu0onoFw0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=W5CJzKUeh+x7Rtq+JLrb6GtiM2Y6PQVRWbpJa6yVvBj5IGb+N4t+nb0q2WrZ+Cqpq9cuyJad5nFe1NFEtioC/PqqtfTtFQj7begL5R3pc7BKEwAmt2jMFIeVlR5vn5GIcrU3tD0++h3z2duSeAQCSdVkwKsf49b2gJWwXlrxiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=mZ3yuW35; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="mZ3yuW35"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1EA3A48B9;
	Wed, 19 Aug 2026 09:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787125175; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9FEvtrkgd8ShdYbshH607rkZpxigI416sHruBrX8Rjo=;
	b=mZ3yuW35d99JrfLt2tb64UnFZJjp9GEdfZdiZ3Y+oo7ntsO/eaM7wujCmxjq5OdpX6cTR4
	26Ca4k9BK16M3EoPt7i3ol4HH/POq7MR1m0IjPniw4wCLXFPbjzaDi1MvbRjGrQBOxoZ/X
	NPf+JxACZNqejEvFt2aHw/xMtL5/OaOYzwfRyVhh1wQ+TCtjL0qweKucstbm/QJ4xOMkkP
	E9eDZ5Th8R4JOUp+I5MhBvdVow2wZh4sy3MXnaDE6QcMKVFh6I0/bDR6AxlCDw6+S1cQc/
	yM9qYTUUz1S2ITf++nkhegcqKdXTOwQfPD5whuZ9onTNA70Vdj/DD1FiupPxeA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 09:39:33 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: macb: Move macb_{alloc,free}_tieoff() out of
 CONFIG_OF block
In-Reply-To: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
References: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
Message-ID: <3733966c87d048f4a6ec749865fe6e9c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Nathan

On 19.8.2026 03:14, Nathan Chancellor wrote:
> Commit 5262eab9462a ("net: macb: allocate tieoff descriptor once across
> device lifetime") moved macb_alloc_tieoff() and macb_free_tieoff() into
> a CONFIG_OF block, breaking the build when it is disabled:
> 
>   drivers/net/ethernet/cadence/macb_main.c: In function 'macb_probe':
>   drivers/net/ethernet/cadence/macb_main.c:5951:15: error: implicit 
> declaration of function 'macb_alloc_tieoff' 
> [-Wimplicit-function-declaration]
>    5951 |         err = macb_alloc_tieoff(bp);
>         |               ^~~~~~~~~~~~~~~~~
>   drivers/net/ethernet/cadence/macb_main.c:5973:9: error: implicit 
> declaration of function 'macb_free_tieoff' 
> [-Wimplicit-function-declaration]
>    5973 |         macb_free_tieoff(bp);
>         |         ^~~~~~~~~~~~~~~~
> 
> Moving macb_alloc_tieoff() from its original positive does not appear 
> to
> be necessary, so move it and macb_free_tieoff() back out of the
> CONFIG_OF block to clear up the error.

Sorry about that, I reviewed the original and missed it. Thanks for 
fixing it!

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
