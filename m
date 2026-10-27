Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793143388;
	b=yGDIFZK6ynq/OpaoZ4rOovyERsjvA6SDXIq30qirR7TvbNnhil7rjP/RFECzutH4UnbP
	 D/98JdU0SFTf7UEFCe/4Uk+G6zvTkE/PnLXc0uKjYgI0qr8lcx18BRuGnmeBgt1GJZ0IF
	 f6OXL3SOzE7D0XsZCQO7n4rFQ+GfMZlPx75DlUtj3t8m/Q/VIoWANPAN85uC/hqgn5yXj
	 D78D5Fj/kb5XvZokV7MgtSMcYARpwGoso164xhOSLZeq0aVDlKLzd3ceVEA31mNc1bed7
	 S0PMXBcwVgDBxCwaAVBK9DhzYT7ryKAfKj7VriWZSsRvo3GQozpXb49cX4FIYNMPJhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143388;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=afws3t8gUsUgdQ8PYku6SmpBffHNAMIiHuve0kA7xT0=;
	b=4zZ0H8yd+Y4YWTdjT5sNF/sbPxkgatdYK3RQwSlCu8OWgudhWCkRhCLcrMRrFMuslvV7
	 N/AkfoVcGINcRgXJghD64cK9B0CX217ZTMNW+wu6JyaFVI7rs6ckkMROpWxwi9pECZ73O
	 SPUeBKI5f0O83xQDRuueaiabh/OaIulqfFYZX0n5AloD6qZrV+QutrZP/mRuycmLwadSX
	 Ki+w7qjG/7wHnmTyUzEK89lX/I6mKZHMr3kFdl2HtIhuhq+ohrihaGuBCBKf+enRnAe2j
	 ptQaFD9R8AWUHj89r3H1zFMoQDv8GCIFAZdd66VKAmsRg0JL6bC7IlaKFp64O1LwYTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvL1kI8d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA5606A31A;
	Tue, 27 Oct 2026 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvL1kI8d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9B61F01825;
	Tue, 27 Oct 2026 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793143387;
	bh=afws3t8gUsUgdQ8PYku6SmpBffHNAMIiHuve0kA7xT0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FvL1kI8d9Va0rpyhFdoDX3ZHvw4FQgrgGuqARNouPlMP1sVgLW0Pdv1IQZ91ok4Yq
	 CNvAZcnW5zqjkQOmZGEGhxJBzgb0Qti5CY2iCE0bYa7tfcgWtvgkvlD+eHbLjDAPOq
	 PKdwhqRKjHQjEdL5aO8Wguo7cM0abRiBoone+g2SLtL1uDhi9D6QQ59y8mTFdXGzn/
	 gGpbrgpY+wL5sUIVvi5/JeHQythrDS1/l/ToaCCm4XqzWdPVtQLlfGJF5sjedHJNA8
	 lXjlwUKat6O8kyQGIotk7syTlnZwH7PaRe1qZzB01g65SBtOVQCYQ620bFQf3F4oA4
	 bxZfuOtzLj84g==
Subject: Re: [PATCH net] ipv6: bound temporary address regeneration advance
From: netdev-bot+sashiko@kernel.org
To: 1075151112@qq.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org, alexhenrie24@gmail.com
Date: Tue, 27 Oct 2026 23:23:06 +0000
Message-ID: <179314338680.3134.12884407597513324652@kernel.org>
In-Reply-To: <tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com>
References: <tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message names only regen_min_advance,
  regen_max_retry and dad_transmits as inputs to the overflowing int…

Pre-existing issues:
- [Low] In addrconf_verify_rtnl(), the deadline expressions `ifp->tstamp
  + ifp->prefered_lft * HZ` (lines 4727, 4744, 4783) multiply a __u32 by…

--

ipv6: bound temporary address regeneration advance

The commit makes the regen_min_advance, regen_max_retry and dad_transmits
sysctls reject negative values. It also reworks ipv6_get_regen_advance()
to use checked u64 arithmetic capped at U32_MAX. In ipv6_create_tempaddr()
the minimum preferred lifetime is now computed in u64 before narrowing,
and max_desync_factor is computed without an unsigned wrap.

> ipv6_get_regen_advance() combines regen_min_advance, regen_max_retry
> and dad_transmits. All three are signed sysctls, and the latter two
> are multiplied as int. Negative values or overflow of large positive
> inputs can make the unsigned long result much larger than intended.

[Severity: Medium]
Is this description complete? The old expression also multiplied by
NEIGH_VAR(idev->nd_parms, RETRANS_TIME). That value can come from an
on-link Router Advertisement, not only from a sysctl.

ndisc_router_discovery() in net/ipv6/ndisc.c stores the RA Retrans Timer
in the int RETRANS_TIME slot:

	if (in6_dev->nd_parms) {
		unsigned long rtime = ntohl(ra_msg->retrans_timer);

		if (rtime && rtime/1000 < MAX_SCHEDULE_TIMEOUT/HZ) {
			rtime = (rtime*HZ)/1000;
			if (rtime < HZ/100)
				rtime = HZ/100;
			NEIGH_VAR_SET(in6_dev->nd_parms, RETRANS_TIME, rtime);

On 64-bit, the rtime/1000 < MAX_SCHEDULE_TIMEOUT/HZ check always passes
for a u32. The only gate is ipv6_accept_ra(), which is on by default for
hosts.

Take the default sysctls (2/5/1), HZ=1000 and an RA Retrans Timer of
858992859 ms. The old int expression becomes:

    2 + (5 * 1 * 858992859) / 1000
  = 2 + (-3001) / 1000
  = 2 + (-3)
  = -1

So the old ipv6_get_regen_advance() returned ULONG_MAX. That is the same
state as the dad_transmits=-1 reproducer.

With age 0, the old ipv6_create_tempaddr() then set cfg.preferred_lft to
(u32)(ULONG_MAX + 1) = 0. Temporary addresses were therefore created
already deprecated.

Sometimes the new address does not stay tentative (accept_dad=0, or
IFF_NOARP devices). Then addrconf_verify_rtnl() sees
age + ULONG_MAX >= 0 and restarts its scan. This gives the same
address-creation loop under RTNL, and any RA that refreshes the public
address tstamp can start it again.

The new check_mul_overflow() in ipv6_get_regen_advance() does close this
path, because retrans_time now goes through the checked u64 multiply.

Could the commit message mention the RA-supplied Retrans Timer as an
unprivileged on-link trigger, next to the privileged sysctl reproducers?
That would matter for stable and security triage.

> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index c8c0dd04982d9..39ecb2c25055b 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c

[ ... ]

> @@ -4705,7 +4722,7 @@ static void addrconf_verify_rtnl(struct net *net)
>  
>  				unsigned long regen_advance = ipv6_get_regen_advance(ifp->idev);
>  
> -				if (age + regen_advance >= ifp->prefered_lft) {
> +				if ((u64)age + regen_advance >= ifp->prefered_lft) {
>  					struct inet6_ifaddr *ifpub = ifp->ifpub;
>  					if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
>  						next = ifp->tstamp + ifp->prefered_lft * HZ;

[Severity: Low]
This isn't a bug introduced by this patch, but can these deadline
calculations in addrconf_verify_rtnl() wrap by themselves?

ifp->prefered_lft is __u32 and HZ is an int constant, so
ifp->prefered_lft * HZ is computed in 32-bit unsigned arithmetic. At
HZ=1000 it wraps for preferred lifetimes above about 4294967 seconds.

The same pattern shows up further down in this function:

				} else if (time_before(ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ, next))
					next = ifp->tstamp + ifp->prefered_lft * HZ - regen_advance * HZ;
    ...
				/* ifp->prefered_lft <= ifp->valid_lft */
				if (time_before(ifp->tstamp + ifp->prefered_lft * HZ, next))
					next = ifp->tstamp + ifp->prefered_lft * HZ;

If next ends up in the past, the clamp at the end of the function
applies:

	if (time_before(next_sched, jiffies + ADDRCONF_TIMER_FUZZ_MAX))
		next_sched = jiffies + ADDRCONF_TIMER_FUZZ_MAX;

Would addr_chk_work then be rescheduled every ADDRCONF_TIMER_FUZZ_MAX
until the real deadline? Each run would do a needless full scan of the
address table under RTNL.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505%40qq.com
