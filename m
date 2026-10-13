Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327E5452B3
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921614; cv=none; b=JnfZnsOpAd5mJoRIE9UfUFEesdbsDx9bBDBfzXACd7KHhhvkO16MPwDeT4uNrWmpTmBQHVGNkwjuLXJPxfxN1/0pcOQqVVvURDuIzBju2bx/3y4eKlY7/u4bA9StncSpMXLwD3LnX7Hh8k9GMUonZczLgml64VMp443S48htosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921614; c=relaxed/simple;
	bh=vTXY0pcdwJg4eyn+oAbuTcP1m07idm9BgGFzHFT1QPg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oYyPZuqXZLzgD+SRAaFW6x4gSnNGi1HmjWSZl9vzS28U/CuCC88KtGj4x6nNGKd0mjy/sEQZx9uf2PcV4FY3nc0AL22BCi6PlLb+s7cZNWReydHpL4mcz1CaQqtHvub9CjFDD3R6f/M2Av23pZaWjOI9OtrimT0YB4uhWKBcdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STamcJ0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STamcJ0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E6C1F00893;
	Tue, 13 Oct 2026 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791921612;
	bh=Wtz2Fzy/qBVLqqCfPHzMCwUFxK9Upu6HGeCqZ6chISg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=STamcJ0V5xpY7vU6nW8tks4gZJ3RMiHWBeEWl/+4BMm7YQHeTrm/pzes3RK5ujvXQ
	 Kj4KqN5/oZzMC59hPABY+vetqoFOlANffaj6ZJsrTWL2f7UVMpaJQuGnMH03nESzFU
	 kNl4lP1JdIVWrKuEWqCl2zguhowzZEAf6Mn34RkNY1L/+m/lZnCGsp2vlhyBDKEETw
	 AisWjHCo0sIlH9No512fQA50p1hKCKuzdRPpADAur3UHP10oObBtJH/ehGUF8EIrV4
	 x4uEuVPatFCmTf9sqhEH0HTPiIp9U8yh4Eqn1A3qLzk2d0NfEWy6c+YezyERkxG3RO
	 LfGuN7jfycCTg==
Subject:
 Re: [PATCH v1 net-next 4/4] neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
Date: Tue, 13 Oct 2026 20:00:11 +0000
Message-ID: <179192161164.434549.2046952979938439215@kernel.org>
In-Reply-To: <20261012194530.3751034-5-kuniyu@google.com>
References: <20261012194530.3751034-5-kuniyu@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch narrows the accepted uAPI range for
  interval_probe_time_ms in every netns, including init_net.
- [Low] The commit message describes a bug fix: a namespaced user can hog
  CPU because neigh_table is now per-netns and the interval floor was 1…
- [Low] The sysctl and netlink paths now accept different minimums for
  the same parameter on kernels with HZ < 1000.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  makes it easier to hit.

--

neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.

This patch raises the minimum of NDTPA_INTERVAL_PROBE_TIME_MS from 1 ms to
1000 ms, both in the netlink range policy and in the sysctl handler. It
also updates the YAML spec and ip-sysctl.rst to match. The reason given is
that neigh_table is now per-netns, so a small interval could be used to
hog the CPU.

Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/

> neigh_table is now per-netns, and a user could hog CPU by setting
> INTERVAL_PROBE_TIME_MS to a small value.
>
> Let's floor the value at 1 second.
>
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

[Severity: Low]

Should this have a Fixes: tag? The message describes a CPU hogging problem
caused by the per-netns conversion, which looks like this commit:

cda2962b6e2b ("neighbour: Namespacify neigh_tables.")

That commit lets RTM_SETNEIGHTBL set the default table params
(ifindex == 0) per netns.

The message mentions 211da42eaa45 and 6d79b223ec44, but it never names
cda2962b6e2b, and there is no trailer for tooling to pick up.

cda2962b6e2b seems to be in net-next only, so stable is probably not
affected.

[ ... ]

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 6b0569aa5d643..92e3c83c0fe50 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2438,7 +2438,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
>  #define NTBL_PARM_MS_MAX	(24 * 60 * 60 * MSEC_PER_SEC)
>  
>  static const struct netlink_range_validation nl_ntbl_parm_ms_range = {
> -	.min = 1,
> +	.min = 1000,
>  	.max = NTBL_PARM_MS_MAX,
>  };

[Severity: Medium]

Is the intent to reject these values rather than clamp them?

With .min = 1000, the range policy now rejects NDTPA_INTERVAL_PROBE_TIME_MS
values of 1..999 with -ERANGE. This applies in every netns, including
init_net.

In the same way, min = HZ in neigh_proc_dointvec_ms_jiffies_positive()
makes proc_int_conv() return -EINVAL for sysctl writes below about one
second.

So commands like these used to work and now fail:

  ip ntable change ... interval_probe_time_ms 500
  sysctl -w net.ipv4.neigh.default.interval_probe_time_ms=500

This removes the sub-second managed probing that 211da42eaa45 added. It
does so even for CAP_NET_ADMIN in init_net.

The commit message says "Let's floor the value at 1 second.", which reads
like clamping. Could the message say that values which used to be accepted
are now rejected?

Another option would be to restore the rearm-time clamp from ed6cd6a17896.
neigh_managed_work() currently uses the configured value directly:

	if (!list_empty(&tbl->managed_list))
		queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
				   NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME_MS));

> @@ -3701,7 +3701,7 @@ static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl,
>  	struct ctl_table tmp = *ctl;
>  	int ret, min, max;
>  
> -	min = msecs_to_jiffies(1);
> +	min = HZ;
>  	max = msecs_to_jiffies(NTBL_PARM_MS_MAX);

[Severity: Low]

On kernels with HZ < 1000, does the sysctl path enforce the same minimum
as netlink?

The range check runs after msecs_to_jiffies() has already rounded the user
value up to jiffies:

proc_dointvec_ms_jiffies_minmax()
  -> do_proc_int_conv_ms_jiffies_minmax()
    -> proc_int_conv()

kernel/sysctl.c:proc_int_conv() {
    ...
		ret = user_to_kern(negp, u_ptr, &tmp_k);
		if (ret)
			return ret;
		if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
    ...
}

With HZ=100, a write of 991 becomes (991 + 9) / 10 = 100 jiffies. That
equals HZ, so it is accepted. With HZ=250, any value from 997 ms up is
accepted.

RTM_SETNEIGHTBL rejects those same values with -ERANGE. Both ip-sysctl.rst
and rt-neigh.yaml now give the minimum as 1000.

Before this patch the two paths agreed: 1 jiffy for sysctl, 1 ms for
netlink.

Would a shared constant, for example msecs_to_jiffies(NTBL_PARM_MS_MIN),
keep the two paths consistent?

[Severity: Medium]

This is a pre-existing issue and was not introduced by this patch, but the
new floor makes it easier to hit.

neigh_proc_dointvec_ms_jiffies_positive() calls neigh_proc_update() whether
or not the write was accepted:

	ret = proc_dointvec_ms_jiffies_minmax(&tmp, write, buffer, lenp, ppos);
	neigh_proc_update(ctl, write);
	return ret;

neigh_proc_update() then marks the parameter as explicitly set on any
write attempt:

	if (!write)
		return;

	set_bit(index, p->data_state);

For a per-device entry, neigh_copy_dflt_parms() then skips that device:

		if (dst_p && !test_bit(index, dst_p->data_state))
			dst_p->data[index] = p->data[index];

So consider a rejected write such as this one:

  echo 500 > /proc/sys/net/ipv4/neigh/eth0/interval_probe_time_ms

It returns -EINVAL, but eth0 also stops following later changes to the
default. Writes of 1 to 999 ms used to succeed, and now they end up on
this path.

Would it make sense to skip neigh_proc_update() when the handler returns
an error? The other neigh_proc_* handlers make the same unconditional
call.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012194530.3751034-1-kuniyu%40google.com
