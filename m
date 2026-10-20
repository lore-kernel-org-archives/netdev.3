Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525225;
	b=tLUzmIsCaftFC39YWjqlzGdGTMg4FJmVTG/PMhgXs6EnrG2xCkGp3Sh7t/2n0m5geuuw
	 a7+gmRLv2HSUoEEXEo/H8kyyESRTg42lWGlfZ1HbDUER49V4dytDn3A/mtTlfPVKgB1OA
	 M48UL0aNf1gipiaE56B4UvrX+8x9VRfEHwa0vH7pEC7ZQ5pVTLXXi+DQnZZB64CSvhYsB
	 4QLxMyaR1uvNVLVvM8OIiv87uS9unNYZctluAWT8ivBl6zkbNOXQbdS4gxObDApvsI2oe
	 ZvxZ9o4Bjq8mO/Skivvzy+Ei6vkG0oS83fo58FuL0KAzV3Kq7NTq64Eq74clkcxG9iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525225;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=VjkIoPeWPAXMhlvnnZV1gfCgw2epxC03CL7v+ulw3n0=;
	b=l879ypP5alkq0+DIJ7nX+VvfIzbQk31S7U0xpxLOYbHymx9FhyIlUhVlFfexJTWKiC2c
	 +a34mnxLlQ5g65YK7GovjBVbIpRsocoFPYzz8RTQoECAGh6dKh4mtXQC7G43RY950CFoB
	 SYh6gpGHN5Yg1ODaWLNr9h6DyD+GM1d+NBauj4KBwrCEe9t7DWMepY/f6MZxLqgiU1JvS
	 nux9MSyMyKN4geUSWrhM567yCKqntby1E0O/IdkXC4EL8vXbSFD0FLRnlGkzZxorf/l5h
	 mc3+1qyciXDAg0DoL3nhmHFtdsfKAl/unBJGPl6HGdiYTrqUg4O1ZGMXuR0XI4uVcww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5TejP4a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713FA606A31A;
	Tue, 20 Oct 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5TejP4a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ABB1F000CA;
	Tue, 20 Oct 2026 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792525225;
	bh=VjkIoPeWPAXMhlvnnZV1gfCgw2epxC03CL7v+ulw3n0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y5TejP4arY9F7E60DNfOwhIbrAemzQ4MbTxmQ1nctzA5IFTpbwHlfmGbdN5z9Jk60
	 uW/HyexkrBc0Tfd8Vn1EW8Zdx/3iOuVVr5c3jJvTTSCHa8mCbLsemS9CSt99l2BWRr
	 CVIVM0wiGOLxMjaEEqrX5zkz3UDsdP3JgHhVbND6xB6pJB/HcfFsSJa6jzFqlzBqsC
	 XjMzCLsZSBIMet32auHucRn187rGFjE91NOr73Qt4KirkFqSg48UGk9Bf2nkMiWbHI
	 1SgC3NwMOy8mNOEscu24ZOBK/O/3gpjo8WhIb4QUdIV1oFquvtvTb9iv+jiHb13pqW
	 /lMHXnvtFNeGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14B43809A09;
	Tue, 20 Oct 2026 19:40:24 +0000 (UTC)
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
Subject: Re: [PATCH v1] octeontx2: Fix use-after-free of qos node in delete
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252522352.176933.11656341625613809683.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:40:23 +0000
References: <20261014064204.291688-1-18983559317@163.com>
In-Reply-To: <20261014064204.291688-1-18983559317@163.com>
To: Binbin Deng <18983559317@163.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 14:42:04 +0800 you wrote:
> hash_del_rcu() only unlinks the node; a reader that already holds the
> bucket iterator still uses the node.  The immediate kfree() has no
> grace period, so a concurrent transmit on a socket whose skb priority
> carries the deleted classid reads node->classid / node->qid from freed
> memory (use-after-free in the softirq transmit path).
> 
> Fix this by calling synchronize_net() before the node is freed, as
> mlx5e does.
> 
> [...]

Here is the summary with links:
  - [v1] octeontx2: Fix use-after-free of qos node in delete path
    https://git.kernel.org/netdev/net-next/c/dcaa62196489

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


