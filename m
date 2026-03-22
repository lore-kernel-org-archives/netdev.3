Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EC3BB40
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774198880; cv=none; b=K1gvUJ3Q+SW/27BhK69EGM0BY3pflrxpR2hG/4nBdGs5eyCpiDLmOci62Cj8rv93kJEmEIIRsgOsTnkC8DS960E/IxE01k9EfhrS+kjn6yZE8bpCg5GzbQ4ZV1q0xHyNEJTjIif9SaPW6d2aycoZI+fxghiFyqNN7z6bxyhZJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774198880; c=relaxed/simple;
	bh=M5cAXrGe1hE9fdKfbItosApoVwJITeicSOyzCKrlHZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0FPHf/K6jvaqNQQuwxA9XysD6f4svhCRI5G1J2WSAxODbQDTUk9eUfNWkIdISqeoZOyvAR7f3Oysh7eco7Cip7nUfW/f1MNg/QltGPf6uZ4kPyQLhgTxVKwuWc0XD3HiZXO3hHwn4H+dhz51EUHOWDP0qLeMNN8+f4k27pfLJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTgV5Bo5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTgV5Bo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D671EC19424;
	Sun, 22 Mar 2026 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774198880;
	bh=M5cAXrGe1hE9fdKfbItosApoVwJITeicSOyzCKrlHZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bTgV5Bo5SJ/kr9GOtLke/e94XLdvdtZeuLCWLs0ZkDTgmhy25TNjR0Cf26NCJbLOu
	 B/io+Y1J5+v29g036DmdmH1fMvPIBV5DrabA3vf9AckGZkQG3qWWsWa+IxxlXRbQ3U
	 7WC7Dzos5EsLDVOSLO/JClaAE4vuf6tZRi7CBkulN0KnEByDgMUZebMA534V0uEEb6
	 L28/W/57+waaxPtBfgAk++FZwJBHvXG3uhT2iIpa5O61HMwcurtUoScSJ+X8S6hSZd
	 Afe44LFdOxPINvRZVO/SFy9WPK0ALffaB8JEbGeR3mLgtD9D99LvxtRPM7VuUnuEGv
	 Cfj21hi1YrafQ==
Message-ID: <cdd527be-2dac-4b36-96bf-26b8fd2f8f32@kernel.org>
Date: Sun, 22 Mar 2026 11:01:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net 2/3] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260320072317.2561779-1-kuniyu@google.com>
 <20260320072317.2561779-3-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260320072317.2561779-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 1:23 AM, Kuniyuki Iwashima wrote:
> The cited commit mechanically put fib6_remove_gc_list()
> just after every fib6_clean_expires() call.
> 
> When a temporary route is promoted to a permanent route,
> there may already be exception routes tied to it.
> 
> If fib6_remove_gc_list() removes the route from tb6_gc_hlist,
> such exception routes will no longer be aged.
> 
> Let's replace fib6_remove_gc_list() with a new helper
> fib6_may_remove_gc_list() and use fib6_age_exceptions() there.
> 
> Note that net->ipv6 is only compiled when CONFIG_IPV6 is
> enabled, so fib6_{add,remove,may_remove}_gc_list() are guarded.
> 
> Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v6: Call fib6_age_exceptions() under RCU
> v4: s/,/;/ for fib6_gc_args initialisation
> v3: Use IS_ENABLED()
> v2: Fix build failure when CONFIG_IPV6=n (no net->ipv6 definition)
> 
> squash
> ---
>  include/net/ip6_fib.h | 21 ++++++++++++++++++++-
>  net/ipv6/addrconf.c   |  4 ++--
>  net/ipv6/ip6_fib.c    |  6 +++---
>  net/ipv6/route.c      |  2 +-
>  4 files changed, 26 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


