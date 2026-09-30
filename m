Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559F4322EC
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802008; cv=none; b=NBlRu/EL95bnEvGDBMcmMfiz++e0jflvWD40a9jzevOudFg3MAiXKqAzpLp3m4AfsghPwldbQWoEfPSH6WqMmlprPpzpT9SGGiBnrY8cEHtgepeiHlCwCeIskgxAWHxyzlcfbvgpbNdyQPBmZ/myJ9KyHuZOpc/SywCuaSlMGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802008; c=relaxed/simple;
	bh=7wnXTL5oBnjKfeO41yiK0LC+yzruF9F3rjIgCpybGA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mO8lLp29z0aaGGwNvRftlbedtzRfA7W1MptqUoFgt+NsIX9HiUnLQ7cfFEK2lSqQlyLrTddAdpXbeg6r6YsuAEQPmn3J2vzJF50s4ettR2OJNcxynfyJgS3drqS9c942jVw4TXByKEcJqVMsw4oAdjpQFGLfmJxdTeElOEirVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRtAmS0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRtAmS0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38611F000FF;
	Wed, 30 Sep 2026 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790802006;
	bh=bbJOH5MGo9TZz+i2RaD+GfBXQ3FxVajZ/B4vgwTYEWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fRtAmS0g5YqNaxQnhC4bxjGw7zZaHW0a83t8kWDIJYWRUWHh/hogtSdenfMWD1VOq
	 +wk5KO0+aC50lnDboqFif5fbkWgfJU3wisOQ9/bj+c3ccbz/rPIw+B+9C26kdon+n8
	 IVRvgY8e+FVHBr5134MD9/lp9KRZ/quu5+I8kTA+OMUMUHFzxiOqPyRi/vzihNnGy9
	 b6A4/OIKs93LTkAX7LFlIvlAhAutgCkC9zV7ZekJRA4DhlDnPd5o+wKdL6yhLIyFEo
	 eSIKufIj2wzDjBDqNTIX0kEr2fSxSIdFwMbCQD2u90p1uK3NKfNfUQW28RFg+Sr4R6
	 qePHWl1Qnoj8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44263A56772;
	Wed, 30 Sep 2026 21:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] tcp: preserve timestamps across receive queue
 collapse
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179080200526.2127741.7368137316557148808.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 21:00:05 +0000
References: <20260924152529.5689-1-kerneljasonxing@gmail.com>
In-Reply-To: <20260924152529.5689-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 23:25:29 +0800 you wrote:
> When tcp_collapse() rebuilds skbs under memory pressure, the copy
> process doesn't include the right tstamp and hwtstamp from the
> old skb. And memcpy(nskb->cb, skb->cb, ...) copies has_rxtstamp,
> but nskb->tstamp and hwtstamps are left at zero, so
> tcp_recv_timestamp() ends up emitting no cmsg at all.
> 
> In net timestamping case, if such an skb happens to be the last
> one consumed in a recvmsg() call, the application receives no RX
> timestamp for that call.
> 
> [...]

Here is the summary with links:
  - [v3,net] tcp: preserve timestamps across receive queue collapse
    https://git.kernel.org/netdev/net-next/c/1a924ab28fb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


