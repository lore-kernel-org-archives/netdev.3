Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402832FA14
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337819; cv=none; b=nDLYJ1iOCpAYG/uYTCFeYi2WReAqRREdzwxLf1pLQy9jm8H0LK+bOP9rzlDOLKphG/lc1LR8j+xBuSNxg7PLrjMLvMUTxC6tDd+ZwJKmGhX3wGBMubNB866cCQLLjCHKRhkW+vSa7qyDiM0+jwU90fez6Nd1QiVOtnTAFl/gZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337819; c=relaxed/simple;
	bh=3JhVysWpaIUfrwa4s5zECBFVb7JNdYq7vbBgyKZKPQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JgD/rn9tvGF7iNXxhI63KMZ6NBv/BFtfJB3ulfibUpZsTEOM99zM9/p1jcNkvq2wBcuoO8PFcjYs/zhHGl2SpA69t/Dq/38lMkYgsrXPd9EN59OhCNYmWYf30Lm6d9jHAlFed/pNkd4gOe1g5Ba7GAFpnYsznKScPHMGAK+ldFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdU9GQqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdU9GQqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438261F0089B;
	Wed,  7 Oct 2026 01:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791337818;
	bh=BrkZOTL74TlyGeWV9aNrfQVEDcZHOkWS7l8q6TdbQvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QdU9GQqTHr6qjW8axYZr9kBN3XrDcZzB5NydL6qvl2Em4BX1JZ0rAL0NdIJ+bPTWc
	 pIL1FFqdQX3xtucfZpV8HSQVjklLKYlI6xNZTub5Rmww6r6ztFn+MmeEw0Q0ttFuqk
	 8GeQW061ZmcOjFZ80yvFDKAyYCS5nmHDpo+ewgPF6HwUnuVgF6djau7OZ+KOglArGk
	 cDjj41oMZ0zI+lMi/NIUy89xi/r9vFOOyU0K1wooHXKR0lYyprKe/yarf5n90Rr5C1
	 LcTvs8mMVjsUt27cPvBGwQ2I+VYT21fctEwxi0i9oFetengYoQP/+Dkhkdoi8OO36x
	 xCi469ePG+KIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A13C3806541;
	Wed,  7 Oct 2026 01:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bcmasp: fix lost TX wakeup race with lockless
 queue API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133781679.2868218.8600482716741136005.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:50:16 +0000
References: <20260929203400.1588868-1-justin.chen@broadcom.com>
In-Reply-To: <20260929203400.1588868-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com,
 nb@tipi-net.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Sep 2026 13:34:00 -0700 you wrote:
> netif_stop_queue() in bcmasp_xmit() raced with netif_wake_queue() in
> bcmasp_tx_poll(): a reclaim landing between the ring-full check and
> the stop call left the queue stopped despite free descriptors,
> hanging TX until timeout.
> 
> Switch to netif_txq_maybe_stop()/netif_txq_completed_wake() (the
> lockless TX queue API, which also brings in BQL), replace
> tx_spb_ring_full() with a live bcmasp_tx_avail() count.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bcmasp: fix lost TX wakeup race with lockless queue API
    https://git.kernel.org/netdev/net-next/c/ea311fea3236

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


