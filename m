Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783808;
	b=TWLtJaGeZXW3xvy0JqB9HDxeTptFcRiIJUdwgRhDztzjdWL8/LEDVtnkW+LTMO0D4pQ+
	 37bGNknSMKNhcfSKqYupiqZmNtFw5KqCZir4v5kcm+By7psdu4y0qax+L1ip3SGaTh3sP
	 IHsC/8E0VWWZkLtDlt+KezhdVJ89NVlCWRSLEe7XBzBgbm6pX+B+fiQ2GZUIbF5+cq6+l
	 ZM06bMNx00uRWcrhZaT33+gGA0SBFMqGQkrAOIXUTBVtWaaXVUFnRSLcOPB+nZOcNZXkR
	 biYam/5L6rMmcyuIYFHclQw9KbqvKt6U1DYzXs6kRWpZB4kaIM/VJGVRqQP4+PAVefQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PHESqNef51e+n6qW0vybigLbU4I/rVOfjCWH+7+jY9A=;
	b=BzTTpQiptAK7C7oWbpLXObejMFAzhPjRlWti1dPpCJ1ivto00/q6Eiqm/Elr2T/mdE1F
	 vp8csTe4HG1be89Oi53iR3+Jt61zy5I139ZprhJjnQez8A2GBaI4SKgvW09/uBBmmaM36
	 ZHYAJRxmC21+6Rwi6EA45K+KrEAnzHoQVK9adywB7BrP+fysP8i3FEd0v3MgoTLmEDJVC
	 YAx7/OvKsUgQ44girRQFBKePJ8aGNH56Ibtz8KcTVZS0Er3DIoLqfKwHZBNIpaDXdZrXt
	 U9Xmdj4VygYpbPflHrqV0pu3rd3LYIICsQxg1AmmhVLkuyW2XTzsD6p8B3kQNiYkO+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mW4BIy8t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A1606A323
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mW4BIy8t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFDD1F01825;
	Fri, 23 Oct 2026 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783808;
	bh=PHESqNef51e+n6qW0vybigLbU4I/rVOfjCWH+7+jY9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mW4BIy8tZykK1u5prKaxHXPfOc4OmEKi5D6ZqIlB65j4KybeYBu9YiHLbeE3iQWaB
	 +zhW1i+O7ucjUVBCxxhxaTNctomyiLKCoBms4j6SJoQxTDvVIdoqhCLT4Vmz3eUMkj
	 bL0y3zcazEFqitZQHZjiNEoo8ddk+/2YWcN94Vas1P7+/HCYxgu/9ObqAXy7kG16UE
	 VVFf3/wE5aypYGmfvoD112AWylyXgmTOit7M2OmwuB2miF1NNMiV51AEgAQapLhRR1
	 W6zUpPzbj6+xTEqpDFxGhWZIuJV7ftuxck3wfJRRAZGMJ5Jf9I6aCDZ7azrUW0EbzT
	 U/W3cW9ALl7Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 07419391B14F;
	Fri, 23 Oct 2026 19:30:08 +0000 (UTC)
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
Subject: Re: [PATCH net v6 0/1] ipmr: only copy pktinfo to cache reports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179278380656.1224496.7623195527446661817.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 19:30:06 +0000
References: <cover.1792476357.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1792476357.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, edumazet@google.com, netdev@vger.kernel.org,
 dsahern@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 leone4fernando@gmail.com, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 14:39:35 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv4/ipmr.c. The bug is reachable
> by a non-root user via user and net namespaces with namespace-local
> CAP_NET_ADMIN and CAP_NET_RAW.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/1] ipmr: only copy pktinfo to cache reports
    https://git.kernel.org/netdev/net/c/94a6736bb5ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


