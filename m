Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550646;
	b=bzi8XK5cuKIMtvr6kiSP17E1BTjI3qLN4xeocdJgq5YQkF9CGtkWTs+szCIVIVVsVBKO
	 bLdT3odHney5sQZXcn+wKIngNZNthGkShfiLrNiINnJwPJxp9I54/oIFGQ7iMQ1+GoVmW
	 59BLe6Ud+kMtUNF2D7dtf3ZTJGyv2eb4w4hpV0mbO56rP8f0YCxPY7LDCUWf4LcDU6suQ
	 bjqRhxGITUnjEx+rG7SexmFH4Ttf+xuSPZeV4sp+DIuxc4/O+NTK3ChAvZjwCMtIZXrjx
	 JSfdYOK+64SP+T0IMkiikEkzFG61pPnGdRgWvMCv7fbPJKZbdUrAImzCIidzGqJzSkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550646;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pym0WhT+qvTbeYJitXM6250lqg6RXxznxmPyuxJHkps=;
	b=XndW9nV6QAcK57zCwHKyRLT97P51pOvoIjs0AMNQa9d7DPBsqW24O7h4E6AJ2lsBTEOf
	 vSMPIO5jZBKv6YaA0ipQsUGhlTSCiMVYdJwmv7sNbe4NmmOrpOZksANhznO3miIvMeasu
	 2K9H5p9JAqeyRzciyOny8PEohTWxs4Z0sZ0Wv9BrBSgRzN+flxDRHRCEYIQ7SlVMfTS3N
	 rIBB2aKFJefFnisa4fC2lyVv3XIYnEkQrnrro38KvcYIX4dLCYYzqTU3MkeSVwFBZR7Qt
	 cXo5TxNvO+bk62r8hm+BxHbtltqZPHOEfsqVauYYLFjHPx/1E3BJZyYjgsEmemp1i3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZ2K7Cfd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD2606A331;
	Wed, 21 Oct 2026 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZ2K7Cfd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0A61F000CE;
	Wed, 21 Oct 2026 02:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550646;
	bh=pym0WhT+qvTbeYJitXM6250lqg6RXxznxmPyuxJHkps=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RZ2K7Cfd39sSBucECD68WaRzd02Wt1iZCE02GFAhNRdlvnP0XFQNEpF5XFNhxQ0gn
	 mAEfCpyzmmYHOBDE2WvAY/vySg6Xmtmq2PZfwoVNX7hOxRkfeTD0Z1ozjdyG7L5iGV
	 fQ1FxwNtR9/XyeerFMbV01HmH3WvxoVe3IkCPUTxN1OwbFXDgfV9WQ6ACkf71DeIEb
	 kkHNVqIvMFeO4zTuvfisx6wLJQxzwMny5pkg1iYBN82CJuJrERbLPR8mdnslWKRBaz
	 6xXBTsPdbXhGwbmBnIviWqd3LfC0J7eSqf5Vcmrc+h9aHyfm8WuoPdkxsyjZ6ynR6U
	 Vwe2jC8tnlikQ==
Subject: Re: [PATCH net-next v2 3/3] net: remove rcu_barrier() from
 __dev_change_net_namespace()
From: netdev-bot+sashiko@kernel.org
To: odys.yuan@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, kuniyu@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 21 Oct 2026 02:44:04 +0000
Message-ID: <179255064497.3135.10889465434398446823@kernel.org>
In-Reply-To:
 <20261019-bug-net-netns-move-rcu-barrier-v2-3-b6eb7780c492@gmail.com>
References:
 <20261019-bug-net-netns-move-rcu-barrier-v2-3-b6eb7780c492@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: stale IPv6 nexthop exception dst and wrong-netns stats
  after netns move

--

> diff --git a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12994,7 +12994,6 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
>  	 * the device is just moving and can keep their slaves up.
>  	 */
>  	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
> -	rcu_barrier();
>  
>  	new_nsid = peernet2id_alloc(dev_net(dev), net, GFP_KERNEL);
>  
>

[Severity: High]
Removing the rcu_barrier() here looks like it opens a window for IPv6
nexthop exception routes that the changelog does not cover.

Consider a route in net_old that uses a nexthop group with more than
one member, where one member, nh1, is bound to dev. When dev is moved,
nexthop_flush_dev() calls remove_nexthop() on nh1. Because the group
still has other members, remove_nh_grp_entry() only drops nh1 from the
group. The fib6_info stays, its fn_sernum is not bumped, and nh1's
exception bucket is not flushed synchronously.

That flush happens later, in this chain:

  nexthop_free_rcu()
    -> nexthop_free_single()
    -> fib6_nh_release()
    -> fib6_nh_flush_exceptions()

remove_nexthop() queues it through nexthop_put() and call_rcu_hurry().

Under RTNL, synchronize_net() is synchronize_rcu_expedited(), which
does not wait for that callback. Without the barrier,
dev_net_set(dev, net) can therefore run first. Two things then go
wrong:

- RTF_CACHE exceptions created by ip6_rt_cache_alloc() have
  rt->sernum == 0. ip6_dst_check() then skips rt6_is_valid() and goes
  through rt6_check(), which still passes because rt->from is alive in
  net_old with an unchanged cookie. A socket in net_old can keep
  transmitting through dev after it has moved to the new netns, until
  the callback finally calls dst_dev_put(). The fib6_sernum argument
  in the changelog does not seem to hold for these entries.

- rt6_remove_exception() uses dev_net(rt6_ex->rt6i->dst.dev) to pick
  which rt6_stats->fib_rt_cache to decrement. When it runs after the
  move, it decrements the new netns counter instead of net_old's,
  leaving both counters wrong.

Was this case considered? If the barrier goes, it seems the nexthop
code would need to flush nh1's exceptions synchronously when nh1 is
removed from a group because its device is going away, instead of
relying on the RCU callback. Alternatively, rt6_remove_exception()
could avoid deriving the netns from the dst device. Which direction
would you prefer?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492%40gmail.com
