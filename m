Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485007;
	b=tA71KEumKVAh3ubzcj/PIga0HdHaj51GggXRg1FUyEH6eaz17uUpiOk267/3/vBALkXY
	 RXNAsMaWN7agwsfxfe2P2HLXA+MBsh1a9P4JQm8vgLYZJBTk8YUVnHffNwqOdI17a9rTV
	 C9e1iQwZK6CQbKrg0jdRjypTCPP2ZjO+IjybdN7talh5osPwWPaaMDDRlZUzX31KWUvjY
	 HB1D0PvodpakMA+2Ohs2tajWCihMKXpx6IP0h0J+AKlnkEMJh6V9hNVc5MZqAo6HVq6Ew
	 D157ZU2Ne6WoStJpLKJ6/uW9iK8DTMRgV1bPYnL4x2x8VdCdBxR/DRZBvTg9nHgwmtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Rtzthx3ba8HYK/lc4AJv6lc9xFK8BTkYMFeeTL3XLl4=;
	b=1RY/JG54Mmq6+EzwPfBCHKsQFacULMlQZtEcSsMVF4RHxA0nqMdnmt97irGntXZKMByp
	 Yp53+W5W8LmC1qx8win51IHZDzb76l/8WGKdLEQhM7Xj+hMfppoLgFRVG19FEtFHCJVEa
	 KcbpVkrDp3pUqHRhWP4M1uHfvAosBjYWuicEaTwy1wiSRDDgpFpwbzWH0W6/340UpBALH
	 aaLzcaXoG9R0+QCEPZQZYxX77OrmE/KD7rOnvV682ovW+aIUvZtGkM5qT5HxPG6On1mTU
	 3Zzfgik44IPpZODojkeDO6zuFlZ60sl775A9L3015zq4W0F0rjESwu/KPzdXfUOihbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZGt2aDR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366DA606A328;
	Tue, 20 Oct 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZGt2aDR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB1C1F000C4;
	Tue, 20 Oct 2026 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485006;
	bh=Rtzthx3ba8HYK/lc4AJv6lc9xFK8BTkYMFeeTL3XLl4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nZGt2aDRKt9woM/MBYw/bBKmosh2c7HnhtSioqcaeEkibSQ7+f5C1w58tJXUI4G7q
	 Kef/KmTg+ZyfDS/v4b4CsTBaIIM1PzRdx59FDiV44TrLgv+DxdqsZFwWPS2oBLzjoe
	 kgk+vKNeTGZQXoXv5BL/wvnoVZRHg3erAsNL5G+G3S29muaZl5x3/XwwMmbwbTVaQB
	 yHOg0F+w109KhE6SGYiOK4fm5aSwHcNP6p7S7A80HFk5rJi1gq2dfJ68uouZytbhsC
	 yvl3ATcIQt44QHnymYHrP45VSLym7VbfbraqZEd0bLvdx7274sE/pDJ7kwVQSBKtal
	 YndnDkKQFBUaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44093924FEF;
	Tue, 20 Oct 2026 08:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: xgmac: do not treat TBU as a TX event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179248500525.3578847.17015469413547290153.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 08:30:05 +0000
References: <20261013024747.2688984-1-zhangfeionline@gmail.com>
In-Reply-To: <20261013024747.2688984-1-zhangfeionline@gmail.com>
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, chenchuangyu@xiaomi.com, horms@kernel.org,
 zhangpengfei16@xiaomi.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 10:47:47 +0800 you wrote:
> Commit 8d07a7930434 ("net: stmmac: xgmac: Do not enable TBU interrupt")
> removed TBUE from the default DMA interrupt mask, but did not remove the
> TBU check from dwxgmac2_dma_interrupt().
> 
> TBU is set whenever a TX channel runs out of descriptors. Since TBUE is
> not enabled and only enabled bits are cleared, the TBU status bit is
> never cleared. As a result, TBU stays set on every idle TX channel,
> regardless of whether there is any TX traffic.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: xgmac: do not treat TBU as a TX event
    https://git.kernel.org/netdev/net/c/305deb54c6c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


