Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BF3D34B9
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257876; cv=none; b=vC4yebd6jj1SGozjqMlKWabBelc+QEL9i3qx+A7eIggEKc2z67Qm8EdbTm3fbs4IJswATajMnZLk9cInRXJJR+FvrM4TcY76Z5+4WdF6oM1jwSNvCOhWzqypFYoV6crjiOlgm5VKUpItzo5SPQqRLE5aT8wlnHbGwE15rUqAYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257876; c=relaxed/simple;
	bh=KnEVvMtDOQjPyATDyflz5PhiSN5/P9xH8EhDsFPdjLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rrRHO/6b92rKb0Wg5mvqP7Ct/9+63MQFzoXWCS0GiqMZ1CIWSFQYWXyh8XahsegCsKYn00TDY7TM/E29Zhrx9Z4C5PT5RTdETd6UIu1j/wq8v+SG/q5Xgx+RyMFVSJ4687ywWUB6XleFkILVpVEODresu/pODyrZDIXz3gl7AsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVd/j9Yx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVd/j9Yx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9A61F00A3A;
	Thu, 20 Aug 2026 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257872;
	bh=C2F+2mGnYhm5mbxHGro10/lq7ZnoECcVakutRfhaiQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LVd/j9YxMD88acy0JSf4F+mFjkYnVOeRp+ti64UyhTu3jq3INvGCzwom77jDZP1V0
	 8SeEDf8g4eStA7fkQeddtgdX0an0hHYrfB9yIfX7y3oTiTIcBqQXDrA/AIw0HytsRv
	 UXCkkJ1d/49FSM50fVB9jTOLkmHqMvVMngKRwvxHVLNb9irCAQ6sGOqcybpxCEt0y1
	 4mPcM8uPKB+YW3eDCEDu94uM9QVg8i4FfWp9kWsP2HDZVbuejpcmSf8VPvBluTV9x/
	 lKX3GUF4E0ngOyJ4tAUQmg78Z7im4VlZSso/LEklgKStgdA0n0J3P5UL19uA3imsbJ
	 Tu7VO4QEPTV9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08CA392445B;
	Thu, 20 Aug 2026 20:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] inetpeer: randomize RB-tree node comparison using
 SipHash
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725782239.470503.8485996306546345281.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:30:22 +0000
References: <20260818151213.3953963-1-edumazet@google.com>
In-Reply-To: <20260818151213.3953963-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 michaelbblunt@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 15:12:13 +0000 you wrote:
> The inetpeer rate limiting system stores peer entries in a Red-Black tree
> keyed deterministically on the remote IP address. Because tree lookups walk
> the RB-tree using standard lexicographical comparisons (inetpeer_addr_cmp),
> an off-path adversary can predict the exact topology of the tree and the
> sequence of nodes traversed during lookups (the gc_stack candidate list).
> 
> By combining deterministic tree traversal with aggressive garbage collection
> (triggered when tree size exceeds inet_peer_threshold), an attacker can
> selectively force the eviction of targeted inet_peer nodes. When an evicted
> node is subsequently re-created upon receiving a new packet, its rate-limiting
> token bucket (rate_tokens, rate_last) is reset to full capacity. This creates
> a side-channel primitive allowing off-path attackers to bypass IP-keyed ICMP
> rate limits and infer open UDP ports (similar to SAD DNS style attacks).
> 
> [...]

Here is the summary with links:
  - [v3,net] inetpeer: randomize RB-tree node comparison using SipHash
    https://git.kernel.org/netdev/net/c/2ee66e948717

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


