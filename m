Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF943793A9
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415210; cv=none; b=r9RnsCsk+vUAOxQN4jjKNqI38UZsQgKJQhpY9wryEKa8LVDPGRIsay5m4HRtMNNKOsjmWCCupwcFU4n1OGGP0+jy5T8CVfc5QZ7yFmw2xOz0z9pMBO/MX03CM55+ogaefiCf2L3YHGe7BMPlBwE+PxQnsea4IKD7BFhvBea5Tsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415210; c=relaxed/simple;
	bh=2nzEQ/qPnaxf696OHNHW7k8oCmrSCoZmZG2kIRE9r4g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TpgxkzNqus9KvHE/CNUdN59rtmfHMvV9Z9c1o/a4nNXn/YOF0m6IgldTxCr4p6U2IEJnSEAdeCYTnct7fBBVRKOI3zlPyn9PoQBJl1iWUjkAitb2xcfXlMbW0/qA9kYblCvSVM48rI9m+AdP95fARwwIV75daeIEUL3wh7MWY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekz3976T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekz3976T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451F01F000FF;
	Wed,  7 Oct 2026 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791415209;
	bh=5QbNXBI+pXmh3/sqA+xyeSzy0dk0D6uj6mnnfL7Nb0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ekz3976TttDpgHgaAOQdFjc70DMukjMxnPW4GB3OgMbZEWmt8VFzABq99xwrQssSX
	 u6YI6WseIXyqLBjeuGWRkwc1fve8QSWJTL12kPlNeLr/QXsfW4YY4XIc9Bkau/rMtJ
	 1TsOcdVbAGCwYHdoYip5E7g0xrEOglwlUs6G/v6y/Z3z3pZyBULXXza5fRPxN2ewrT
	 oKHXDMoyzFvg0WS3gKxMUkxWrjbVpx9IXndINJ7LOpwOxl588pxTnYPu9r01To5E0z
	 OVO3k6EjLLEpNgBweK9SyReDOVw5j6ofn88Mou1FSLZ9TGmWSrMzGCUeZk1vEsr169
	 ULtGHtap+ZmTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2873809A08;
	Wed,  7 Oct 2026 23:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/9] neighbour: Add IPv4/IPv6-specific
 wrappers
 for neigh_lookup() and friends.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179141520806.3731241.1254224400062933385.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 23:20:08 +0000
References: <20261003212336.1304988-1-kuniyu@google.com>
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  3 Oct 2026 21:23:13 +0000 you wrote:
> syzbot reported that ip6_finish_output2() could pass tbl and dev
> from different netns to neigh_create().
> 
> When namespacifying neigh_table, I chose to resolve neigh_table
> in callers to minimise changes, but it turned out to be error-prone.
> 
> This series adds IPv4/IPv6-specific helpers for neigh_lookup()
> and neigh_create() that always fetch the netns from dev to fix
> the problem.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/9] ipv4: Rename ipv4_neigh_lookup() to ipv4_dst_neigh_lookup().
    https://git.kernel.org/netdev/net-next/c/07cc2b151a26
  - [v2,net-next,2/9] ipv6: Rename ip6_neigh_lookup() to __ip6_dst_neigh_lookup().
    https://git.kernel.org/netdev/net-next/c/3e33cdcf54ee
  - [v2,net-next,3/9] ipv4: Add wrappers for neigh_lookup() and neigh_create().
    https://git.kernel.org/netdev/net-next/c/33ea2463c432
  - [v2,net-next,4/9] ipv6: Add wrappers for neigh_lookup() and (__)?neigh_create().
    https://git.kernel.org/netdev/net-next/c/616b2143f901
  - [v2,net-next,5/9] mlxsw: spectrum: Resolve neigh_table right before neigh_lookup().
    https://git.kernel.org/netdev/net-next/c/98071355ffc9
  - [v2,net-next,6/9] ipv6: Use ipv6_neigh_lookup() and friends.
    https://git.kernel.org/netdev/net-next/c/0e59523b440c
  - [v2,net-next,7/9] ipv4: Use ipv4_neigh_lookup() and friends.
    https://git.kernel.org/netdev/net-next/c/f2f25d59f56a
  - [v2,net-next,8/9] neighbour: Remove __neigh_lookup() and __neigh_lookup_errno().
    https://git.kernel.org/netdev/net-next/c/29ff0101dc00
  - [v2,net-next,9/9] neighbour: Check n->parms->tbl under tbl->lock in ___neigh_create().
    https://git.kernel.org/netdev/net-next/c/023753192e3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


