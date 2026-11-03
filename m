Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739607;
	b=HtNNEva91XnN1jNmKx3IptQPbhfI93A6e9Bw1J7vTRIhwKvEeqAeTOouft4lrPPspKMG
	 Nu2Way02hynWpID2gfNJ6aIkBCkDkror0HutbVrme4r2yo01bEAoZneRuNw1SjLBaSE4p
	 6D+cd9IKYZG9+9oqSoqNh3pqmZSEw34RYxSpehLLQBJfSDksoqHKSzcJSrzeH4wB4gbIJ
	 3RtWMVrvBu46nnXsrhwZv+Y83WS2wtR8py05xG7fIka/9fsZyk1TX6akCycni7a304ERj
	 0FTeH7dKokR9hR3Lm2Nk03I76CBgx26lsHlBWe7vsfm5cWsbm7nHMMZNB0F9BUiHOFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=31oOrvKDLGNYxKr21WlHoeu7jh6aJf58xMg5VOoTf8o=;
	b=n3B6uluL1HNFqdFK6+TUNsMXos4lG+lDX7hDjpqFkolFNogrlPRlY9t+GHnQAaEvXYKw
	 6CjK9bEcqS/T7GuPkQYgu82YsMUetO5l094hJMDDfvVpLsPA/7adsw2rVmh8XmB7FvU8N
	 WkWJ61dpW2S6vXPnbnyUNn+ofiDb7y21qyW2AbMTYET0xGDUCwoNRjwv/ATowQhKCwM6e
	 jgZHutEre788+5YrYy3bz/X0TdQ19uPxz2GZv5h0FsKRjGWwAhaxyCjFTV0ETmVFtj0Ih
	 /pGh/ipkgg6ER1gRXAOM+PMWfd4/D5Qd1D4BMhVnshVjGfqF1hIoZGTe+lLpmOUZGww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxzuLUY9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0644606A326;
	Tue,  3 Nov 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SxzuLUY9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9421F000C1;
	Tue,  3 Nov 2026 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739606;
	bh=31oOrvKDLGNYxKr21WlHoeu7jh6aJf58xMg5VOoTf8o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SxzuLUY9VnUQINbOww3cCQ496MCeSWk6DEf9KDy+/VRtIXWBY4R5DmLu6nHCrMEJw
	 AwQ6nXvaX4d22Cw+sE27N88FIuXi//sLOiGFen6D8pdYw85A7HMonhn3J8gkCxukex
	 5EROkjxdQFnKcBqxK+k+/iGDWRwpOcnPwYWLqeazUuLFIkBovvWyNECeBJe+teGNow
	 tmfPO26UqLpGlegf+qSS2IDV1duy6sem1VkdmIriRNkI2uXrqrZ4d8t+T6Si1oIyFL
	 Js/I9WOkrpNcUN19zniRG0uUA8tfIZQxYM20/n1n2FOtN84fuEhVXoAZiTy+aDhIex
	 f8zQue5uCBcMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4014C391B09F;
	Tue,  3 Nov 2026 21:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/2] net: dsa: b53: Fix IGMP/MLD snooping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179373960504.1876147.2459637376828973157.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 21:00:05 +0000
References: <20261028235100.3892374-1-florian.fainelli@broadcom.com>
In-Reply-To: <20261028235100.3892374-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Oct 2026 16:50:58 -0700 you wrote:
> This patch series fixes IGMP and MLD snooping for b53, these were found
> by running multicast membership/learning tests.
> 
> Changes in v3:
> 
> - move general IGMP/MLD snooping comment to be applicable to all
>   switches, move comments about zero controls where they belong
> - added IGMP snooping programming for older switches, too
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: dsa: b53: Enable IGMP and MLD control packet CPU copies
    https://git.kernel.org/netdev/net/c/3362cb822ea7
  - [net,v3,2/2] net: dsa: b53: Enable legacy IGMP snooping controls
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


