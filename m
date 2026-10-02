Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA13A6EEC;
	Fri,  2 Oct 2026 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937608; cv=none; b=L3L0BMD8Ybnlx8z8Xn/ZiJQuVhRtjoxJyPwSmCNladnM7T2f8ip6Co/RzSjndChZ/l9Jn35LVx5vSKead2XSPFp0PHvSAPKO8Tq3bKAxkup5HJu8+hUp/X01NfsXsSenVBBDHaFjY4pQq8kENHBwqeJBM6e7JlR2w4gjpO/RXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937608; c=relaxed/simple;
	bh=KQ1HOpFFK/1H/Cdbs2aDLG+TrVClcAEG+HQZxLwdj6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F7oX4NnDRxUEpTYhl4xiGJ+PrZnKjWSXo4ckeLvxq9seBk/0Qd8DVvj/MhdvEft0S2schvB2nZa3OkdUH2rGRsRbz+fo+vD+TorekrG2YiieNODUyRJzyNnXAX8meA4joaKRwdkoWhtAziNtFrCI0YW72HYbmOy8SscKCR3cm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyCuXvLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyCuXvLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C041A1F000FF;
	Fri,  2 Oct 2026 10:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937606;
	bh=r4INfRqpxT7YhPd+W06NysuXddY9wGvptiUPCAUf84Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lyCuXvLvrukBpLA5Oi0fuVfgDeW7EReHHvoKZu6zcpIWq/1NDdNVlVB11rBiizCn7
	 ULtta7vJTQso8vCLmTCzRS+obSLOuhGqjYEI2V+SXCV7vkIWWN7Rq3YtdzhcUYSPJh
	 8d2mJlulPkrCQCG1TaesS9XxTloiQ9iL4b3PWTTgZzMn7JAj3Zcs3FvzxycawVB1lj
	 brOGbKH8dvgzsZGDa2SemNmROVp+X1U8YPbzRDc0n3fj1DrHYhpKuF+flS9nXmzFCS
	 A0TpJHnOHU6a6+oE1c2RhRnnJWnQNh8Oj+Sve7hRxLGqT7CS8Q6O2UbmFtFksdRlrP
	 yW8ECfZto62Wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B448C38119E9;
	Fri,  2 Oct 2026 10:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: allwinner: remove dmaengine_desc_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179093760553.3349832.499337152312400934.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 10:40:05 +0000
References: <20260929190640.3516766-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20260929190640.3516766-1-Frank.Li@oss.nxp.com>
To: Frank Li <Frank.Li@oss.nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 bartosz.golaszewski@oss.qualcomm.com, andre.przywara@arm.com,
 phucduc.bui@gmail.com, arnd@arndb.de, kees@kernel.org, liyouhong@kylinos.cn,
 Frank.Li@nxp.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 29 Sep 2026 15:06:36 -0400 you wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> dmaengine_desc_free() is designed for DMA_CTRL_REUSE. If DMA_CTRL_REUSE
> is not set, dmaengine_desc_free() will return -EPERM.
> 
> 	if (!dmaengine_desc_test_reuse(desc))
> 		return -EPERM;
> 
> [...]

Here is the summary with links:
  - [1/1] net: allwinner: remove dmaengine_desc_free()
    https://git.kernel.org/netdev/net/c/71a77ab76e74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


