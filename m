Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A60381E8B;
	Sun,  4 Oct 2026 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118932; cv=none; b=sXhQFXtvK/gFWGo0yQXVXnmYn9JKwQ2ZCWMe+0/T1mE8ahrv60s1mwOAEXzjlZzHfRb8mqBEXD9pdqs+LAmtydW0A85aNJ/pyu/AiG8Oaa8Zx7GTN0vjPPlGHJH8QOSIGSkzOS7a07xhBYM+b9wkDjTARjdBKbDN4DHj7hL8EEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118932; c=relaxed/simple;
	bh=ewsHhT0Y693+ulyI/5/45VClFz7ryAT4kYPzRhI78ig=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlGfsU6hV33zyeGe41F5O44kpDNMsuJ9LzV4S8WZwLrbU3WtA62Pd/4u7elFIOyS0snrUP3ZpleF6RohNnWZz01MKdMV7K8rMSfKsigJyMYe3tTbrY6O1B7xSptfBtTcNePsrFDhl3t1YtkX5VgEKKfSLzYS1/N9UtdLPBEVcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mdz8QOcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdz8QOcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1321F00893;
	Sun,  4 Oct 2026 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791118931;
	bh=dlcd0zuZhmEVNGntmaV+rmnnPoHJNhMxp5duOKoPYHY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Mdz8QOcIiXPyTmKf5TFt6Ut5dxRpnxvithsCuJsjsYh5SCTojSH12SyH/Z7prEdc6
	 MmTWyVBdZRmEqAgrpcBWs5Ko0uyl98rpyKbjRz79lzLWiPC1FLevam60/6ZNS6C+FT
	 rS8uKpLulVMM5aAkYwH0i6D6qyIFbJlVyL+iDMA5VrkjmZgfyFjrsmBlqeeervESYE
	 SqMS8FaGNi3DHZh2qF8+glDP7qlH9SWvoAiQFidFXHiJ2vvLx09N1iu9TATNGZMqyx
	 SN3R4Hdd2yikrpbzBkEyg++dPoZXlxSfkbwhb72pi9NH3zOXMBlnNjmvmh+13eCUGD
	 OQxB7q8vwa/Ug==
Subject: Re: [PATCH net] ipv4: stop PMTU walk when nexthop group shrinks
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 deliran@verdict.gg, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 13:02:10 +0000
Message-ID: <179111893007.434549.14219431686863441999@kernel.org>
In-Reply-To: <20261001010550.2742297-1-4ncienth@gmail.com>
References: <20261001010550.2742297-1-4ncienth@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

--

ipv4: stop PMTU walk when nexthop group shrinks

The PMTU walk in __ip_rt_update_pmtu() reads the path count with
fib_info_num_path() and then each path with fib_info_nhc(). For nexthop
objects, these two calls load nh->nh_grp separately, so a group
replacement in between can make fib_info_nhc() return NULL. This patch
adds a NULL check and stops the walk at that point.

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 37674d76f90f0..5f2197874bebc 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1082,6 +1082,8 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
>  
>  			for (nhsel = 0; nhsel < fib_info_num_path(res.fi); nhsel++) {
>  				nhc = fib_info_nhc(res.fi, nhsel);
> +				if (!nhc)
> +					break;

[Severity: High]
Is this fix complete? fib_dump_info_fnhe(), in the same file, has the
same fib_info_num_path()/fib_info_nhc() loop and does not check nhc for
NULL:

net/ipv4/route.c:fib_dump_info_fnhe() {
    ...
	for (nhsel = 0; nhsel < fib_info_num_path(fi); nhsel++) {
		struct fib_nh_common *nhc = fib_info_nhc(fi, nhsel);
		struct fnhe_hash_bucket *bucket;
		int err;

		if (nhc->nhc_flags & RTNH_F_DEAD)
			continue;
    ...
}

For a route that uses a nexthop object, nexthop_num_path() can see a
two-member group and accept nhsel = 1. A writer can then publish a
smaller group on the same struct nexthop, in either of two ways:

replace_nexthop_grp()
    rcu_assign_pointer(old->nh_grp, newg);

remove_nh_grp_entry()
    rcu_assign_pointer(nhp->nh_grp, newg);

After that, nexthop_fib_nhc() loads the new group, and
nexthop_mpath_select() returns NULL because nhsel >= num_nh. That makes
the nhc->nhc_flags read a NULL pointer dereference.

The reader path holds only RCU:

inet_dump_fib()
  fib_table_dump()
    fn_trie_dump_leaf()
      fib_dump_info_fnhe()

inet_dump_fib() is registered with RTNL_FLAG_DUMP_UNLOCKED and takes only
rcu_read_lock(), so nothing stops the RTNL-held nexthop writers from
running at the same time.

The dump_exceptions filter is set by default for non-strict dumps. For
strict dumps it stays set when RTM_F_CLONED is requested, for example by
ip route show cache. The dump itself needs no privilege. The writer
needs CAP_NET_ADMIN in the netns, which the commit message notes is
reachable through an unprivileged user namespace.

If only this patch goes to stable, the same NULL dereference is still
reachable through the route dump with the same writer. Should the same
guard also go into fib_dump_info_fnhe()? Alternatively, could each walk
take a single snapshot of nh_grp, so the count and the per-index lookup
always use the same group?

>  				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
>  						      jiffies + net->ipv4.ip_rt_mtu_expires);
>  			}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001010550.2742297-1-4ncienth%40gmail.com
