Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434407;
	b=DtJH6umQ4i+J55CttDpo9FOhNSM5jznBykdd8H3vrTiIZFrF7DzqoPl352KLvdKquF+L
	 klYie1ibCqiLvWU0JE1VpBcWZ8ZHyHwHoZcSW4AjRhdS2LfsByCeXxF887DRe43dqBFMg
	 ILD3pOUdi7fSOhXw6vBUAvNh1jegliaRJ6/h9Lh1sazwIFMM5vr46l+y1kMAQKWJ5zrnK
	 V1Aqgd9mWJnKu8CUjocvlyd8hLahFBge7IBYim1Rsn4m2Zz+U3qX2RLhi/Y9hfe5SeU2M
	 egb4ajThssdWmD4ot+cIae+6168SvB/8pnbHONl/KVAmJ5YN1MWx1iarDU1gdoJOAXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QPlbAjgLicca9iUK/LTU+4HhXH7DfDFsly5gN5ecr1Q=;
	b=EHdNPHQxnNBm4bwG+TKogicB4JOgZ63dJQnIWKuR4hwAMPHPzUf52UAu40Lhg5SgH2aW
	 7cmoOvlEdiQqlAEAFGetiCOpav5XxBnSo2gtopMcgJsHCCAD4m9sMVSUoj3WtHp7ZRCpm
	 coH09sXjhTa9TmBLcXneb8anC8O91Vxqd6Zf58H/my9OhTQmm24T370Y4wus9LeuDgTDY
	 3FFg1G5N82aO23xT/6LnhQw1roD3ZD5yrT9hHVBBDoPKd6jby2iJZrdyLf9UsV8GyjReH
	 nlqUfchRtmrCigUkdtFMT6m+DcZWIblknfqA9OplUD8+UMGwSWkTcULuUesatZNXtzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hu8bhn01;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3360A2612;
	Wed, 11 Nov 2026 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hu8bhn01
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E031F00A06;
	Wed, 11 Nov 2026 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434407;
	bh=QPlbAjgLicca9iUK/LTU+4HhXH7DfDFsly5gN5ecr1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hu8bhn01VnJLyF7O5DPtLJu7cCqzN3d+r5S/LtoY1L59o9i39jVDodWcTL5o84FtO
	 cefXcpHc9paHVp4aF5mpLjrg3H3ouMf5bikAzcSxPb4PB2vMb3ZmOgVwyroXkYKpOJ
	 yztLItBEz1mdKpCMT5SR51xfXdbAkxtI0q0I+IuBm7AyD88rgnLoEnnlDcu/exC17x
	 vf+9D2UhU7YUwQ56IO654gGmPPKZ4fwkqV3Vs4fUF1GqVsbirNZi/Lxl8ErhREfR78
	 8rHKRVBbGWqGJko1W+TkL7r6FS0OH6e5TOO4COmWWd+l2MCPjfLW/120SzfBlvCYga
	 thgXqAaD8lwpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8254391AFAA;
	Wed, 11 Nov 2026 22:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3] ipv6: reject routes without an inet6_dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443440545.1663612.15743969370880416230.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 22:00:05 +0000
References: <tencent_91DA7FD8277B509C55906702D1E425FBC906@qq.com>
In-Reply-To: <tencent_91DA7FD8277B509C55906702D1E425FBC906@qq.com>
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
 liuhangbin@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 16:29:40 +0800 you wrote:
> ip6_route_output() and ip6_route_lookup() can return an error-free route
> whose rt6i_idev is NULL.  Lowering an external nexthop device's MTU below
> IPV6_MIN_MTU tears down its inet6_dev, while fib6_ifdown() leaves routes
> using nexthop objects in the FIB.
> 
> An unprivileged user with CAP_NET_ADMIN in a private user and network
> namespace can construct this state.  Consumers which treat a route without
> an error as usable can then dereference the NULL rt6i_idev.  This was
> reproduced as a KASAN NULL pointer dereference in ip6_tnl_xmit().
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv6: reject routes without an inet6_dev
    https://git.kernel.org/netdev/net/c/08a1eb7a634f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


