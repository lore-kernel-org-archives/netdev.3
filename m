Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529D4137B0;
	Thu, 23 Jul 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823656; cv=none; b=A6GnySgY+d8jZjmfOj6DdGoRhJQTYjEBjrzU6Ntjg2XmEt+41UGRS56CfTStXVWO3gjsUbwf+Xs435DmRgSeaVW1M/RNQPnl/NzXUbbw85X0rmZXWpU31Dz2HqZixu9+OgfdBqVAuOuhR0t425itQyNvKU2TIH6jlcyd24QBpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823656; c=relaxed/simple;
	bh=cniK5NRkdc7a0QBTpGtoAYJ+vTQpnUtNVRuMOCixs94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jGgQ2JG28AL8cQ/j3cx4sAgvdj9ld/M1Ob6csFqVfX/T83ZV61HumbO2pi4uj4boF4nXq1h0yRjQZejzqrbVGRQGJrvv/IP3RI4MwL7Y2Kz/GH3K+nzQyl2BeXLCmCijnUNmYimNLeVy31XIOaP0DJYQxEhRG77iBzjIGCkBv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaDNHQQl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaDNHQQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F501F00A3F;
	Thu, 23 Jul 2026 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784823650;
	bh=1RoIGTJWKk2f1IvHtFLKIE6kq9BN8jOhLN51qK1mgZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JaDNHQQl9gXe9yNHUmIVyJ+ZZ7dWRoa37YiVuFPupOn6WqJcrSWo7w8rT5qGLbmLL
	 ztkZoMCRPVgmhLpFJapW0gdx6UYzqcCWdmQj+lLGwPb76dmZOQyUMx8XKJ51t7cPqS
	 8zk0o94Ic67BSMN9dJGdzeSMYrbtnHTXqiywPHmBVr8v3ZSN56Cjtm8ALoKU1RkM/k
	 5upYSDOyM+exggY1WYysTrUbmAvof9bgvYYEdUgMrJEHOOQnBDOpiG7DcACJQHoqPR
	 GbUZBc25rQfL0nizYBAF9rtnbW7L//fh7TiacUEWWVypnS4Q1jBCBov2LCxW2dvdUt
	 FWMXSqAMdCDaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C0D3924478;
	Thu, 23 Jul 2026 16:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Change allocation flags to match rcu_read_lock
 section requirements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482361439.2769750.329022673168190868.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 16:20:14 +0000
References: <20260719105759.558050-1-zlatistiv@gmail.com>
In-Reply-To: <20260719105759.558050-1-zlatistiv@gmail.com>
To: Nikola Z. Ivanov <zlatistiv@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+84d4a405ed798b40c96d@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 19 Jul 2026 13:57:59 +0300 you wrote:
> Since the call to __ip6_del_rt_siblings has been converted under
> rcu read lock and it only has one call point
> we should no longer block or yield.
> 
> Our stack trace from the syzbot reproducer looks as follows:
> 
> __ip6_del_rt_siblings
>   rtnl_notify (Here we pass gfp_any() -> GFP_KERNEL)
>     nlmsg_notify
>       nlmsg_multicast
>         nlmsg_multicast_filtered
>           netlink_broadcast_filtered (GFP_KERNEL passed from earlier)
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Change allocation flags to match rcu_read_lock section requirements
    https://git.kernel.org/netdev/net/c/313a123e1fca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


