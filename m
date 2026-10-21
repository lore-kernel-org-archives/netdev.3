Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551010;
	b=t9/nUU96smFG4+EJoSNt6dhqrj7iuk3jEIwbEd94vK6hXQ4HF7uauDx8tRXPjzhejEvE
	 GeVCoPwZgKkBoKm3xYD333gVS2BR2RYVDwVs98qPhZcz03NYUQPQHiw13w/J5CVSI3pcd
	 8XEOcgYd77p/hT6Ou9aL+zS04hCAIKEtnLM+BuVWMhQWrTDIlRD27DYaIlgJkki+8zf/d
	 5wQQg9cAZ3WeII6Zjk8+MN1DJ19AJOffCVb+OXW4+biwFNu3i/A6eAnqJF147P5ijl+BD
	 EyK3rGn1+oBIojNnJ+YEwQQv3MMqid7MYA/2L5muQY3pReuAxUnFoijbtBQt4V+MfNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=shUy2332KjdMn9QJ4gQEk2B49JkKaAbAZLmjwvvzn34=;
	b=Ii7Wu8PE1gCz5hH8qFpTo/ywW14cGqZhN94yicce9Jair8lc4z77lbPeBuZg69QbeCzK
	 J+sndelbNEHDh6uBh9jB2cx6F8rekXInXqZacHWc8Fufb3M/NRBTzahelW5w8IyoDPWNF
	 SmPgS7eUFMTunJdxeYk1g0YGi5p651I9kNJ2cCorLGTw9/bxBYVOlNf9/tKGrYvTcxOhM
	 pCWJy8oI6tIFS1HcnmAJgCXw7ep/TG3dMAXh7lcuzF61t68GUQmohgOdcuj1sPokI+u9d
	 1xzNgN63g8kHGdkbTjWyqJUJBdDcF37XRYU6NL4DtAzVfuda2osDKzks4Zv8ON5/qGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRX9aBqf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F6606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRX9aBqf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D721F000CA;
	Wed, 21 Oct 2026 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551010;
	bh=shUy2332KjdMn9QJ4gQEk2B49JkKaAbAZLmjwvvzn34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NRX9aBqfx5/TPircUfPPBxMh6xEf4TUSBMQauCWkg4N41UrAn50BlMQj1zpJElDVg
	 ptWDEt+Pjv8J70lmFDNACP6Jc7bHcinw3g194bJyUB5h2mWyfbkDgIW3z+83w1PY4I
	 OAS4s2DHRp8VTSYNZFyi/qN/uyLYTSzgGwitvJWyaZoc8HtWMhrMpx9zQvvq/4NCRs
	 77CKOGR2/wehvHikhf9rIBKUNDgZq3dvWpTuyX2ko1oXiti+wHaqT+ZrMlPMLH8dJL
	 L0yfxwXAPIszBf3hX0ItDPxCuYS4JfOsf/EfnJnuzkFK3ILepuph+D2c9guLdoYinv
	 PaqyY/3NKh8Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A37C3809A18;
	Wed, 21 Oct 2026 02:50:10 +0000 (UTC)
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
Subject: Re: [PATCH net-next] netlink: specs: Add a spec for nexthops in
 rtnetlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179255100877.346551.17981468103622036658.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 02:50:08 +0000
References: <20261019-rt-nexthop-spec-v1-1-9c586edf86ab@gmail.com>
In-Reply-To: <20261019-rt-nexthop-spec-v1-1-9c586edf86ab@gmail.com>
To: Demos Ra <demosthenes.ra@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, dsahern@kernel.org,
 idosch@nvidia.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 13:35:51 +0700 you wrote:
> From: Demos Ra <demosthenes.ra@gmail.com>
> 
> Add a YNL spec for nexthop objects and nexthop buckets in rtnetlink.
> 
> ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/rt-nexthop.yaml \
>     --dump getnexthop
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: specs: Add a spec for nexthops in rtnetlink
    https://git.kernel.org/netdev/net-next/c/457dc9fefe9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


