Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490807;
	b=tZ/Wk8rxu5keVNr4ETHvl75nJ0cyNmmb10UJtkrmA65zaxlRYlBpvomSHOceP1E7Jtdn
	 CizjhSMk97dfnOw5+IINAd6Q+X4sr7P2N4tLDehx92D/8fUgkiXkqYUKihobdfgpAs489
	 NoDy4bLbhmIXs5G3+KVnw/taClHjxYGF3olSvnImiPyyULjJs/J2sQ3KZOxyPT5sB0THj
	 wHXptveCITJndK6ac/Wl6I8h31Vs1ev6JbB7xoV1T8wqvhzc26ym4gAP9vof1nvIPXXe2
	 Y2bcRjv+H7xlkaGJJphMs51JnBp9zXRZFzTkEOw2hclorJMirqqQoYwKOmgLt6GvMKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=RqxWc2yz/kh9/FruYMQBSAEbxmtTfit/aRHk0IId6Mo=;
	b=uEe5P0fqa9wu6RmC2DQNsZFIXrCzfmWvIoqn6oweRSEnEuooCqg0/mR4X2AU7Acot9wV
	 4ndj5OCo6d5TXIGuEOhENLQ7L3bVgN+j+Cci1Z29qQW53c1+0u7O1DfG4q/H7kxHEzGbH
	 AUttBaFrwEskRfNh2b94mOIa+ajLXpA8YXJ+9LrMmzuMBFUzfjqMIKhcEHSPn6vsTlpss
	 rRuXaCHJFBh1aDzCo/BnjX0sO25CsoWUWfo4HRnqN1lGkpCEHIlvL5rzafj/SbjubyK9e
	 wky5r1LaxzNkM4t3m+BRJ5B2ORmf9lz1Oe26LpHk3hmDaFsFpbEvjjcCKviHTqmOuxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vfjt7zQD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D8606A884;
	Thu, 12 Nov 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vfjt7zQD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E366D1F00A06;
	Thu, 12 Nov 2026 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490806;
	bh=RqxWc2yz/kh9/FruYMQBSAEbxmtTfit/aRHk0IId6Mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vfjt7zQDTnCsutP0i/Gnn5V17pC+UqppYJwQw6XKJz+fUAiqg/mrMgiWUGxwvaZQW
	 EOi5KzskdrLzFXecR19XbAnBNWxJdlW34kZ+7E+EfXbC2gUhE+V/N+W262aQSX2weK
	 h48ypblck6BaZJLaiQB21VioHj1RhJ/7pJqLLXc+16WGQ/6e6dYyJPXb4vsx5WPGpY
	 3dsMttHIueikS7nzDBuW2+ekcWvKzltmnE7AbWJ4Fz+JGxuzdrjyawDocmKveGsN83
	 2LfUK5MxQEjmSwILt2k/agOUxqDvtnOMYXHaf95daysJvt1/oDtLxEqXwtoGpqLDdN
	 2kj3eHAl6QrdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D82633AAA0ED;
	Thu, 12 Nov 2026 13:40:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next v5 0/2] seg6: skip route refcounts in seg6local
 lookups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179449080567.2107380.12389973165436502767.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 13:40:05 +0000
References: <20261109-seg6-lookup-noref-v5-0-96dc6a652c7e@gmail.com>
In-Reply-To: <20261109-seg6-lookup-noref-v5-0-96dc6a652c7e@gmail.com>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, g.goller@proxmox.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 09 Nov 2026 09:10:13 +0900 you wrote:
> seg6local looks up the nexthop of its IPv6 and IPv4 behaviors from the
> RCU read-side section of the receive path, yet takes and drops a route
> reference for every packet.  Skip the reference, as ip6_route_input()
> and ip_rcv_finish() do.
> 
> An LLM coding assistant helped write and test this series.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] seg6: skip the route refcount in seg6local IPv6 lookups
    https://git.kernel.org/netdev/net-next/c/dcbda564e19b
  - [net-next,v5,2/2] seg6: skip the route refcount in seg6local IPv4 lookups
    https://git.kernel.org/netdev/net-next/c/6b290fe547c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


