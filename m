Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742606;
	b=eQz9A0XcUQD58Tc0SXd2P6hKZvHgAqwkp+wQlviRUGiQmY0V+cUZKGb+myfcQsSG/Fi9
	 I8j6S68c82mmqd7B4LHkVow4/N4CvFlg5l+m+5vf3fs5BovcrRpeGZpOROkg6fBJUjamR
	 oqLAveufsv1lsbZsx//UbJY17mAy2oxyL77gudDTjq1/bIdvjMJuVxvI5XghbcOGLtEvt
	 yLAu6+6lC2BcAZF4SIeVWvHbqTIHHJMkN95pZTX5rCXc4Xib+hEbkAUCARH1cwGIPCIAN
	 4PIfGKWsVqTbyiIHeQ/H9iNzKq8o6qTrziZ1aJ7CzNk0E6DITMffcWanHMEkPCSDabw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YLZ62UzP11m5JUQjSB50W1ABBc+HLXqltNhUJoJSJQU=;
	b=rxZXaTo758gM8x2Uuuf5RwmUZOEsoPBg1RlL/2530jltqsb87ume6CMLl7oKjcouOqR8
	 We4eNNJMctUuM87bFGg5WdLOqBE0hk9zDFjWQKy9buvM7r78fpbGGIuMQ52X3kUpchy+3
	 dfqzFkuWx1xyK7zOUbF07TZWWE0T2J5WTXACJyzwIBwMW91zvQ4MeTBKKfR42jAWaOt/n
	 vwa+/cTMsgN2oHicJo1QaYJGjvvZXVlYOSGIdcZ+JEugr+WA0SAJwphqHYyB2zBOqk2TB
	 xG0dxxkI0stAp10zQcw1OjtWjC4T7vDryE9RXnFzWF2HJ8GUB0NNOFKqwDgteNvSzTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBFbX4vs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB0606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBFbX4vs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DD11F000C1;
	Tue,  3 Nov 2026 21:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793742605;
	bh=YLZ62UzP11m5JUQjSB50W1ABBc+HLXqltNhUJoJSJQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HBFbX4vsIgH21ccGLYP+fi6Axgi3yj69spn/aRSAUBRrgQnK9N3AELnzbyV9DBbqH
	 aTYinuC3U+RHtjDcIMz9f9BA5E7dcFlC02fBU+TrTWBu7V81l6ZBsLGT9ifp0zZuqV
	 azKoVoHRPnbUV6g6t2Y7lpNneqylbDVl5eVYKTTpDNLW/9kjrBeXfgIMRfqmGad7Go
	 rOl/OYMgjmESp06xuBaR0921jqRvE+AOGgytBQBq+Uci6UIYPVZxY/xNJp3RiuB5hR
	 l7s/9gdVNyrmBxP0YoANfsw8FR25KuouKF1AIavihNXUSpzDOAvQqV/wmBtpBJmrf9
	 2eLkYsJfTYnNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D188391B0A6;
	Tue,  3 Nov 2026 21:50:05 +0000 (UTC)
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
Subject: Re: [PATCH net] ipmr, ip6mr: queue netlink route queries out of band
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179374260430.1900723.4562124216281892705.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 21:50:04 +0000
References: <20261030092303.2749386-1-edumazet@kernel.org>
In-Reply-To: <20261030092303.2749386-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 netdev@vger.kernel.org, kleaver@janestreet.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 10:23:03 +0100 you wrote:
> ipmr_get_route() and ip6mr_get_route() queue synthetic skbs on the
> unresolved MFC entry to answer RTM_GETROUTE requests once the route
> is resolved. These skbs carry a fake IP header with version 0, and
> ipmr_cache_resolve(), ipmr_destroy_unres(), ip6mr_cache_resolve()
> and ip6mr_destroy_unres() rely on this in-band tag to tell them
> apart from regular packets queued by the input and output paths.
> 
> [...]

Here is the summary with links:
  - [net] ipmr, ip6mr: queue netlink route queries out of band
    https://git.kernel.org/netdev/net/c/787268686c64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


