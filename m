Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445209;
	b=3RMQMzoBjyoJVXq0pq9pLQD14JBUMN/LtkHBTsOYjyS1Nz4vnYGJtN4HW6aSS0QYuXV3
	 awqCGM749WPWCkx3O6fK85JJAaRxJps1uNqdCNdqmTf7bXlbMu/P+sH1x6wA0kbIuYxW9
	 j85u08vOhv+jCaB50Ixw19aWqth7pkEJyroucauXkkVYcz61bbKVyO/NhhuQh458XutBk
	 6LRTReNzLWGIcGzdmxWILla8+v3cZ79Wtj2jPnZkssaCmfn9Gn6h/08HGwsu3pwJAv/Ce
	 Qp+VU1E30n5Gdr1cy6E8VXrxDazpAj09GCfjJWxOjL8Rpes9IWw9fLpZ9y4/DxhtaEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=uIotu3yVNVExwyG4fblu84Hlm4rATA4G44A+C8v55ZQ=;
	b=hrbarRDhEaN3q1P62p1IBKrZL6iA4pp81W1ogBvMQ98hMfozT4adJPsIdWW3TofyX9pU
	 I4GsWXFtSMjaGxQNBiXALoBTv7IX2mkF6eZG91trP/dW0/Y0iEpWRQA9/vpYe0Sn7uRZN
	 Eur0RIsctzuPf0/Mwvgb7bQnfV87xvphCCaXKEHtlnMZWD/AiJt+7g9JheSeYVjL6BEB9
	 qoSVdjhUSHxvSjxP1kiGXXin9Xkx2jURbkGm6iA+k0IIJUw1zJFJ2mSJHVTQbiBPLGvlJ
	 5A2o+sfKZM6EBYQB5Dr31J0cBwCHhVbTN2woJLZ7occHICTDHidEEsWyTSz9hLUSjrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mge8OiW5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B4606A882;
	Thu, 12 Nov 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mge8OiW5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8F91F00A06;
	Thu, 12 Nov 2026 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445209;
	bh=uIotu3yVNVExwyG4fblu84Hlm4rATA4G44A+C8v55ZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mge8OiW5/gSGUtK+5hhlqcGvfFVNkfHFQ6o3i3Qb0WLWLVfyZs7btPZa+rOhdLX1B
	 kxFwOznZtUxiCeQQt/j05IHb9/lT7LdipeT+fe/gOh6NUgIvgpph5ip++OINIMIKPN
	 fcVx2ExzonGeu3R47QuQUT10i04yGt1cKR9/mNbN4gFQvBrdolBpxknu4f2NfvO6jC
	 bSf1Bg5dUrc4n3F1y2e7+H36bc7lMZ3ZFlkbHq2R8EHlsF4HsRXnyXvVU7hOaB0Zcn
	 wpcdQXMpYMbjK9LVJJYKHVnTsrvx9PLeVWm9CuXRITGQNRSl9CS3pBefRxDX3LWh0L
	 J/W9l3FphWKkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20F83391AFCE;
	Thu, 12 Nov 2026 01:00:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next] pppoe: use sk_node for session hash chains
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444520767.1739789.10681932147394019452.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:00:07 +0000
References: <20261110091255.24158-1-qingfang.deng@linux.dev>
In-Reply-To: <20261110091255.24158-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ericwouds@gmail.com,
 manizada@pm.me, nbd@nbd.name, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 17:12:52 +0800 you wrote:
> PPPoE uses a private next pointer to chain sockets in each hash bucket.
> Removing a socket requires walking the chain to find its predecessor.
> 
> Use sock.sk_node and the standard hlist helpers to allow constant-time
> removal and eliminate pppox_sock.next. Cache the bucket index in sk_hash
> before publishing the socket and use it to advance /proc/net/pppoe
> iteration between buckets.
> 
> [...]

Here is the summary with links:
  - [net-next] pppoe: use sk_node for session hash chains
    https://git.kernel.org/netdev/net-next/c/7845123d30f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


