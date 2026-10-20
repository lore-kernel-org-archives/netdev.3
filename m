Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525220;
	b=MpXaYIPdXZKCFSXhHu6SFwfL7ngVdQSayRfxJNCpP+xq/+urYhvNeCAdcuSnrrkspYnF
	 eBfoeqkPAADwnrWz0jPcMJ0fH5C+EAgeCK7H/w2YUiNRsu/MUl0DwqYe9R9197NtDwnbQ
	 ZjJpVN8zmOZJwCeO9hwoLgzybEgs1tDhNSuuffVELxbO+yb8E8TnyoNVRlXHti3yQT+V2
	 DKMUcPY/t759dkvyqUhBt23wxVkR5gKraAbzYgfufyVaj246AaVrKg3GsKIcvNfgq3jXs
	 UTgoHfkaYgnFSJHa9QJYK9BpfIPF6QAY+V8Q+kPiASwfnc2dKEVWmbZKbSSDG34I50w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525220;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=d5kFB5UieyWzDHi1vxyzRWFWGnl9UcUS9COrlep8IGQ=;
	b=n0/ndARt/u6pIIafAvyr6TqRpaI0LtJnVzraxCofCq46MOeMSt2lEPkcj/nUxX6aHxUY
	 QJz28PgxN6XcfKTrWm1XxQt5Q6hlUd/sQDPm+kCEMgeR7kdRT1XMlOk9hY8my2JTgdNoV
	 vAl4dFsER56ZyNkd4JjiS8q+jHMKRlr+xEq7IzW4KzAOHOVWtMKqBrGjx6ROPm6o93ttF
	 s5txi95uRCqEv9fqU6pcgCVqSotwl6E2LeZ6rPlBV654oI73FHvowtHoRLRwnZG3oeDzF
	 ucD+X1A3AzZAbjG0JHdE5seW1M1Ws1NaUW48kNP4/uyYdsL4Ol4CLU9sHUlm7QaHT+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUAY1hlH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFEE606A326
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUAY1hlH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067D21F000CE;
	Tue, 20 Oct 2026 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792525220;
	bh=d5kFB5UieyWzDHi1vxyzRWFWGnl9UcUS9COrlep8IGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aUAY1hlHx6MMdY35FWRLAP8fDYFTd4jYpM2X1h6AlKiufyU2sW5c+yx0tCypMpF7q
	 ONoNaqtXafLRh9nzhDqNdyBOY+2OyZeNwL5UXrz6kDStEpXXxnNj88zxdCdsnOuSOt
	 DWH171HVWrncBG5sO20FL8A/jWe3VoyB/N4DPlFeLSuwm88PYuuhzbjojFxcjqpJzN
	 O1r5RYBarOJx+uZa1Gvz/v+6pwdPqatSSoKZ40nYsE+Zef+nHzW9FqZdqpgHixZlMY
	 e1fuaHDdvQ7xN7qR2oLZcjS6lIVqNsu/Jlgz1QZVgcDfpxOHU/ohoS3wfxtxdXyC7S
	 j9q2erf0ixl6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F179A3809A09;
	Tue, 20 Oct 2026 19:40:19 +0000 (UTC)
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
Subject: Re: [PATCH net] tcp: tcp_metrics: use the socket netns,
 not the dst device netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252521852.176933.17096404531205983034.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:40:18 +0000
References: <20261016084802.2725187-1-edumazet@kernel.org>
In-Reply-To: <20261016084802.2725187-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, odys.yuan@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 10:48:02 +0200 you wrote:
> tcp_get_metrics(), __tcp_get_metrics_req() and tcpm_new() look up and
> create metrics entries in the netns of the cached dst device rather than
> in the netns of the socket.
> 
> These usually match, but not after the device has been moved to another
> netns or unregistered: a socket can keep a stale dst in sk_dst_cache
> until it is checked again, and tcp_update_metrics() reads it with
> __sk_dst_get() without any dst_check(). Once dst_dev_put() has run, the
> dst device is blackhole_netdev and the entry is created in init_net.
> Before that, for instance for routes through nexthop objects whose
> cached dsts are released from a nested RCU callback, it is the netns the
> device has just been moved to.
> 
> [...]

Here is the summary with links:
  - [net] tcp: tcp_metrics: use the socket netns, not the dst device netns
    https://git.kernel.org/netdev/net/c/504bdcb8c156

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


