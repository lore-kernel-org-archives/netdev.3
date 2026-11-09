Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183837;
	b=fv+J4KWSbSfAqiPE1epRbFa+5uQxdTMGd8wAtk8Iaz88RaFMML9ewv3t5rjEtXfzGKdV
	 EJdlNRS3tm0cwmpvyhnOjpUbXF7dzG5Z2s4T0lJIY4dld29uyYOiZT6nBvvfV0KONahQG
	 aYIHCAfwqvZPntM/o2PQBLRfSZ8qxubFIYwshTmkItJRr4X9wyn2r+Y+PUz+PDIirZhwA
	 IHFCZGkSdYepO9qNPThKaG4hw1pntjS+xc/iox9B6wE4oRYaF6SWfBDPk51sRsUoVG1O1
	 EGh92t4Tm2eOZFfhARtwpqooK9IExC3AtliRrvWbB9Hsw838YKVfZslxtmLdse4lYjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183837;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DkX6KBsgv2qzyLNxo91uw6wgKh4tAOWSDrtHuM+maXg=;
	b=D2fxmgqYqS3sLqFVK7QnHBYs6QRRcY9Q4He9Rq1eihbktCX9EitDRsiPoPeBl5+4u4g1
	 2iyFnru3s7n8Arhuw+KY67OCuu/8zN6wu74tTdijfr+ly8Z6DECR556+PWwn9U23soZle
	 v68E2WuKUEaoFB2qKmDFHbpVc+9Zfup+Evz6ZGxK7wEsKHyi9vJTxwI1M8plZ+EV/PFWx
	 u0Xg5e/ZkPuBBSE6yi9P79AiMiAtSBeu3WEpchbNvo9T628wOTTgGxw4PWFO/cHVrzkwu
	 xHPPFEJhUxStk5TDLZlxYAd6R0Vai/InnDRqRAZiUVM2tDJvhiZINEwtQmOtTj4v4gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEjYddBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14527606A321;
	Mon,  9 Nov 2026 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEjYddBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EF21F008A5;
	Mon,  9 Nov 2026 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794183825;
	bh=DkX6KBsgv2qzyLNxo91uw6wgKh4tAOWSDrtHuM+maXg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oEjYddBBFnh05leLCuQZkU0mhaH+0F85M+NnBWM8bRdt40/GQaboncWWgM2fryd8/
	 KU3C30xLJGGMzxJdZpBXgsdIweVL2HarzzAkc59PkovhHHVSxBSNu0UX7v0Kgn3nUj
	 TtvOIJJw6aDxDeD2uSmzKVa2xN/WYp5E7Z1p6O3Cglxju6AjubpHDNjJv/G6tD03sJ
	 I92IcwqhWSZybXgS9Z9Bsz3ZAKEOgp9h9UdnUYs7FOEMqSnbiLDjR9NC4dGPpJLjIP
	 IaSXQXH0u7OR60iLU/tY0esbM/AHUwDLKXoFucff5K3GSW4gidjXjXfhMXR528LHx1
	 icPgoZoNnfxLA==
Subject: Re: [PATCH net v3 4/5] net: mvneta: keep the TX rate limits across
 open and MTU change
From: netdev-bot+sashiko@kernel.org
To: pepe.schlehofer@gmail.com
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, w@1wt.eu, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 00:23:44 +0000
Message-ID: <179418382458.994134.13358702184048740523@kernel.org>
In-Reply-To: <20261104224518.66487-5-pepe.schlehofer@gmail.com>
References: <20261104224518.66487-5-pepe.schlehofer@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "net: mvneta: keep the TX rate limits
  across open and MTU change" is a bug fix (it has a Fixes: 2551dc9e398c…

--

net: mvneta: keep the TX rate limits across open and MTU change

This patch saves the bucket refill value of each mqprio rate limited TX
queue in struct mvneta_tx_queue. When mvneta_start_dev() runs, it calls
the new mvneta_restore_per_queue_rate_limit() to program those values
again. The reason is that mvneta_txq_hw_init() resets the refill to
10.23 Mbit/s on open, on MTU change and on resume.

> Tested on a Turris Omnia (Armada 385) with 1 Mbit/s limits on a
> 100 Mbit/s link. After the link was set down and up, or the MTU was
> changed, each busy TX queue carried about 10 Mbit/s. With this patch it
> stays at about 1 Mbit/s.
>
> Fixes: 2551dc9e398c ("net: mvneta: Add TC traffic shaping offload")

[Severity: Low]
This isn't a bug, but could the commit message say how the issue was
found? The patch carries a Fixes: tag, and the "Bug fixes" section of
Documentation/process/maintainer-netdev.rst says:

    All bug fixes must state how the issue was discovered and validated,
    and how the fix was tested.

The message explains the validation and names the hardware used for
testing. It doesn't say how the bug was discovered, for example seen in
real use, found by reading the code, or found by a tool. There is also no
Reported-by or similar trailer that would imply it.

The same section also asks for a statement about selftests:

    The testing statement should explain whether the fix was tested against the
    reproducer and against kernel selftests.

Could a line be added saying whether the kernel selftests were run with
this fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104224518.66487-1-pepe.schlehofer%40gmail.com
