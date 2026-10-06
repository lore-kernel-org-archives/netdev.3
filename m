Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF937F312
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328208; cv=none; b=XdHNwfz0hnfpka+yoDffZQEtmp0b82gwAiFJECDlPffU5XLfOqPuSpIQeiah62U6TE99ixJLJemYlRBXzFQHZb8ZN/3kmwXwgyOO6e+pwoB2k1IHGxFq+3YpqcyK4G+xAQSJLp5Nyo1oooFrGAqekJ8jwzKon+lHOE3lYbm+ZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328208; c=relaxed/simple;
	bh=AB06BL/vnPRFI0DlCOKn0i1dkiWvVoY1FCS41gMMRU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OJFeYx6mBO6jCI74fshZx001Agjq86iJIkcqczcX3cxSYylFj6YCJZlKNvH1YbbF39asDpaUe5s1DlOpnzN6O+nJZqI6uS9Ejh6ard4YmARn4/RiQJ1Bgg6tWfG/K8EzeFsr/MevB+15hsCc9LbyhrEsJuy4rUl+a6OHFjx/FSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjjZwSaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjjZwSaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8054C1F0089B;
	Tue,  6 Oct 2026 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791328208;
	bh=FDzKxv3k8R0QsvPwYT/dSzXTtdrN1rgBzpBNgPVE5kA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CjjZwSaUr2KsFUmt66O3nHRYsNTLxiPzwSJhGd+WwG1kaBcxdMW4hb7rTO/Y7JbS0
	 VS7Zm2kQ7hugXtG71qkvzS75jrIS6vxiupId5hzifykiqojBDdonGJmV9eAwCoysjH
	 rxjAq+Sal5IwsEP+qaHyktuvfUz4ryWJQgRQfGfXUN2PUhH2NgUkyeSsjmZiyvcy/6
	 MP0vlfTUjDWXTz9YSvdXeOJq09akpKRiRpC65NRcCFJCU/Bw6k6ZrZR5WsXuNn42aZ
	 nJ40nN4k2/FuvZDPK2kTrloSvLaVBG6GgbiL4sT6I6CzrySju/FnhUNaNGKRvvdlHR
	 Va/yvErbgClyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7751739E4DAC;
	Tue,  6 Oct 2026 23:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/6] ip: Batch flushing uncached routes per
 batched device unregistration.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179132820728.2820791.12400400664272313290.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 23:10:07 +0000
References: <20261001204752.2572265-1-kuniyu@google.com>
In-Reply-To: <20261001204752.2572265-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, carges@cloudflare.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 20:47:12 +0000 you wrote:
> Chris J Arges reported high RTNL contention during cleanup_net()
> caused by rt_flush_dev() and rt6_uncached_list_flush_dev() iterating
> over the global per-cpu uncached route lists for every netdev in
> dying netns [0].
> 
> This series resolves the issue by batching the uncached route
> cleanup after __rtnl_unlock() in netdev_run_todo()
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/6] net: Order blackhole_netdev_init(), inet_init(), and inet6_init().
    https://git.kernel.org/netdev/net-next/c/20dff14006b1
  - [v3,net-next,2/6] ipv4: Inline inet_blackhole_dev_init() to devinet_init().
    https://git.kernel.org/netdev/net-next/c/3d51928a882b
  - [v3,net-next,3/6] net: Rename dev_isalive() to netif_is_alive().
    https://git.kernel.org/netdev/net-next/c/2e65372a2b64
  - [v3,net-next,4/6] xfrm: Check netif_is_alive() in xfrm_bundle_create() and xfrm_create_dummy_bundle().
    https://git.kernel.org/netdev/net-next/c/4eb2e2f358fc
  - [v3,net-next,5/6] ipv4: Batch rt_flush_dev() in netdev_run_todo().
    https://git.kernel.org/netdev/net-next/c/ca6854799069
  - [v3,net-next,6/6] ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().
    https://git.kernel.org/netdev/net-next/c/f12d2907992d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


