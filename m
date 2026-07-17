Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFA3AD50F;
	Fri, 17 Jul 2026 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283652; cv=none; b=SOF5nqor1XFQIXqsO47QUeT9zckixggqclhJHnhM2eoR1NYpNr7kXODvBbX60SZDqG/BjIkJvKaiFm2zCdgNO6shmI6koDAa7r0w2DtGX/zRX9Euz8hqeA0X5wVZnzH5ZtMvGAYOVFJSEq7nIbW7FTi9fWpzP6OrmaMt3LVfE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283652; c=relaxed/simple;
	bh=4HVpyxNfDlKr/xzbh2FmHt8lzFrXcZ3q8jRxvMIOKjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=usuDnWYBJTol6M0yCYBUYVC1FuWVEtxFARJdZeYl33wRuLeCCxrvrzTUbrJWTK+7GnER0UNJUTWTAz4EccJiLv+xJ1Xp7SGrjNLkh1NayfsNG2+2c0iQ7Rf1uQ7XToLmTWmbYBzS0264N8Q5/eyc6z8Ivrfls4jxLDViIf2seBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfud2kzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfud2kzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7621F000E9;
	Fri, 17 Jul 2026 10:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784283650;
	bh=Zc3C0gZ2PspDZZ8HMlsVqsyMB7yDfShl9fFptB6xcKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rfud2kzQawR5oL3ggkdq6lzNmMX0Zl8tDn+3U6b6v7knSllJBX30LErFscq5RCq0F
	 QBePftCY1yaIgouCZ6EAKnWLGXHnGp77sYrumW42B6n4PXGqvPmwXAeWpcNij2+B95
	 VCA2hlxPxc6lx4N/OnRR+1WyHFbZjbMOaC4szkHDiHidNntrAcktBUaN4djmKtAOdM
	 J0yS/YQ4ilDxmKRcBh/OQFHvYiXmKvfuyCQDNqHKtJ5d2cpWMja4zj3y26qFg4+rYF
	 NVBABurMK66lrok6n019EpvqUvuVK7oh0TNtih7cj6QBAqO4CE23Rzc4KIlTO1a9a5
	 tvQlLkA6fOT0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569B6380CED2;
	Fri, 17 Jul 2026 10:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/9] netconsole: stop charging netpoll users
 for netconsole-only data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428362288.1651046.1516613633145991930.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 10:20:22 +0000
References: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
In-Reply-To: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jul 2026 04:38:52 -0700 you wrote:
> This work continue to untangle netconsole and netpoll, improving
> memory usage for netpoll users that are not netconsole.
> 
> struct netpoll is shared by every netpoll consumer in the tree:
> bonding, bridge, team, vlan, macvlan, dsa and netconsole. The non-
> netconsole users only need a per-port handle that lets them transmit
> SKBs.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/9] netconsole: clean up released targets dropped before the cleanup worker
    https://git.kernel.org/netdev/net-next/c/a620ff84d42c
  - [net-next,v3,2/9] netpoll: export refill_skbs(), refill_skbs_work_handler(), skb_pool_flush()
    https://git.kernel.org/netdev/net-next/c/ede59d06c28f
  - [net-next,v3,3/9] netconsole: take over skb pool lifecycle from netpoll
    https://git.kernel.org/netdev/net-next/c/1fee9a9c5904
  - [net-next,v3,4/9] netconsole: move refill_skbs_work_handler() from netpoll
    https://git.kernel.org/netdev/net-next/c/28511289088c
  - [net-next,v3,5/9] netconsole: move refill_skbs() and skb-pool sizing macros from netpoll
    https://git.kernel.org/netdev/net-next/c/2fbebfbe2953
  - [net-next,v3,6/9] netconsole: move skb_pool_flush() from netpoll
    https://git.kernel.org/netdev/net-next/c/67fb2038e1f6
  - [net-next,v3,7/9] netconsole: move skb_pool / refill_wq from struct netpoll to netconsole_target
    https://git.kernel.org/netdev/net-next/c/ba520084dc3b
  - [net-next,v3,8/9] netconsole: move local_port / remote_port from struct netpoll to netconsole_target
    https://git.kernel.org/netdev/net-next/c/3b247a595663
  - [net-next,v3,9/9] netconsole: move remote_mac from struct netpoll to netconsole_target
    https://git.kernel.org/netdev/net-next/c/49e03ca58334

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


