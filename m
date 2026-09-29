Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BF41D133
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663214; cv=none; b=kls0PLiylrGO4HvQ3ADembgeK3jCEBJhIvOaXB93jRg8MkEiFUQw5Xt+lqQnWFLkzfNbE49X/Yfou8KYPXt+/+tnxkWFrOdDfV8IkD1LOUY8NgKohlaHfBKYwcYr+8MCgSYwnopzZxVS32lvQ877Q7ikTaE8PM07I4Ffu6TrZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663214; c=relaxed/simple;
	bh=qMOvlFzn2vADHctv/0mGCCmyr13DY/QQ4g7rG6mLLJA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hekD4ugaYWDUt2ZLRcQG12rZJzC7AdETyg8sjGxu+EQ0+2rppkAupHKYg4t3DH++zc0G8pGUON2UBe0qZBFUETbwBGxLcM+bgpXvvzlQSkXS8ITcOTFbSKmWYktkimlOfkgK5O941fOKO+ywtXtySKuknFgMrzGF4rRDDMueyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brRXPfhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brRXPfhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAC21F00893;
	Tue, 29 Sep 2026 06:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663213;
	bh=yuAE3FNlRZ8WBe6lofgamRVfmpNsTRBW6UouxfPPKTU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=brRXPfhyo4q9ljWw/ulVBP2h4GYEtz/0y2bTrtnTc18AYQANlFTK3TB6qidysa1qS
	 c0NJBkqbyCbDh+RsDFAmAEyZMxx5c+UkuGzrmYYgjYS7TrcqraaOBaUrfHNr4bcyNp
	 Yn0rX+7Y6bxPkIwK3V0g0+VguQNSWeWwcPrjffNasuwdh4/GXlhiv/nsGXNE5SnJSC
	 JGz063HaIppmhbrt7uhH6HCuXGAAOQurHaA3PY2+scbFISOZfQJANbK3RZ8w9aFJ8+
	 UF1/P+0KM/RGT5dgjMxUe2RyZK6bE27MOGSQrJHuY9VGtbHkOP5ViRuHa2H+mnXDGc
	 /wIBqtsQ1RftA==
Subject: Re: [PATCH v1 net-next 2/5] net: Add ->pre_exit_batch() to struct
 pernet_operations.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 carges@cloudflare.com, kuni1840@gmail.com, netdev@vger.kernel.org
Date: Tue, 29 Sep 2026 06:26:52 +0000
Message-ID: <179066321227.434549.13771615629655873291@kernel.org>
In-Reply-To: <20260927202429.2452589-3-kuniyu@google.com>
References: <20260927202429.2452589-3-kuniyu@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new ->pre_exit_batch() hook is undocumented, and the commit
  message describes its scope inaccurately.

--

net: Add ->pre_exit_batch() to struct pernet_operations.

This commit adds a pre_exit_batch() callback to struct pernet_operations.
ops_pre_exit_list() calls it after the per-net pre_exit() calls. The goal
is to let subsystems batch device-related cleanup, such as flushing
uncached routes, across dying namespaces without holding RTNL and before
ops_exit_rtnl_list().

> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index b4247e767d135..58b2601bb8691 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -488,6 +488,7 @@ struct pernet_operations {
>  	 */
>  	int (*init)(struct net *net);
>  	void (*pre_exit)(struct net *net);
> +	void (*pre_exit_batch)(struct list_head *net_exit_list);
>  	void (*exit)(struct net *net);
>  	void (*exit_batch)(struct list_head *net_exit_list);
>  	/* Following method is called with RTNL held. */
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 0e13de0cd36b6..476fbf913bad8 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -160,6 +160,9 @@ static void ops_pre_exit_list(const struct pernet_operations *ops,
>  		list_for_each_entry(net, net_exit_list, exit_list)
>  			ops->pre_exit(net);
>  	}
> +
> +	if (ops->pre_exit_batch)
> +		ops->pre_exit_batch(net_exit_list);

[Severity: Low]
The commit message says the hook is there "To batch such cleanup across
dying netns". Is net_exit_list here always a list of dying namespaces?

ops_pre_exit_list() is also reached through ops_undo_single() from
__unregister_pernet_operations(). That function builds the list from every
live netns, including init_net:

net/core/net_namespace.c:__unregister_pernet_operations() {
    ...
	for_each_net(net)
		list_add_tail(&net->exit_list, &net_exit_list);

	list_del(&ops->list);
	ops_undo_single(ops, &net_exit_list);
}

It is also reached from the error path of __register_pernet_operations().
It is reached from the setup_net() failure path through ops_undo_list() as
well, and there check_net() is still true for the net being torn down.

The two users later in this series seem to cope with this by ignoring the
list and filtering on !check_net(). Could the commit message be updated to
describe the scope the hook actually has?

Separately, the comment block above struct pernet_operations describes
how pre_exit(), exit() and exit_batch() are ordered and where
synchronize_rcu() falls between them. It is not updated for the new
member.

Would it make sense to document the following there?

  - pre_exit_batch() runs after all pre_exit() calls for the same ops.
  - It runs before the synchronize_rcu() that comes ahead of exit_rtnl(),
    exit() and exit_batch().
  - It runs while the netns devices may still be registered and up.
  - net_exit_list may contain live namespaces.

There is a related and more speculative case later in the series. The
change "net: Track state in ops_undo_list()" marks nets as
NET_PRE_EXIT_DONE whenever ops_list == &pernet_list. That includes the
setup_net() out_undo path, where check_net(net) is true.

In that case, rt_flush_dev(NULL) and rt6_uncached_list_flush_dev(NULL)
would skip that net's routes because check_net() is true. The per-device
flush on NETDEV_UNREGISTER would then return early because
net_pre_exit_done() is true.

If an uncached route pointing at a device of the failing netns existed at
that point, would its device reference ever be released? It is not clear
that such a route can exist in a netns that is not yet visible, so this
may not be reachable.

>  }
>  
>  static void ops_exit_rtnl_list(const struct list_head *ops_list,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927202429.2452589-1-kuniyu%40google.com
