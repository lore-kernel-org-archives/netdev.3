Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B257C73B
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969534; cv=none; b=ltPcaRPhQyr1sBs7zPanyK2+Y6L3kCJXMZxDWhBFth8lk/1a3jV1PCBQgr9o0zSzeLGiTEvqqixKRnrtV2t8bhHYU5EugcyLc8y7IpH4C2USaelZD58oSuki8Vtf4eiA7ByhmY6Zfvh8JrZ2y2Yk2Uae03PqQsDyWB2x6HqquQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969534; c=relaxed/simple;
	bh=Oy7SJBtKWd+SlrXak34KXueF8Bb/SocmUYIFvQHHLjc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzBzvAUOW4PFCbh9NTQHcLG8yOzch0WuhzRv9oaF87UN5RM7KwouiufjJBU3d/zcaVvCl9pGjUJgEKVU7M71Zyhxk5Otk424f4GV3xOuAiswEZvLsPo92UWzjJjA4TbWIkJ5BjU4toOjFBPYc+9hk0i9Y7chW09omtZh+TwutjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU0sN10W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU0sN10W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513931F00A3A;
	Wed,  9 Sep 2026 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969532;
	bh=4DBBDISOoclv7HXd7ie8zufN+aRnJcxE0PebBg1jd/A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eU0sN10WpY4PkwqxRXPGcQoJVumBMiEA9Zpsi9GPFqf+R3RG0VKg8rTA7QY58t7+5
	 DeE9eGeDGej45x4sMWhFumWqRrJgsTdUvjP3uCucrRSdzr4c4GnuqOnyMWgYm0E+2w
	 +BLcDl5LxFC/V1hzMYNfg1MU1Ib0etpHLdsmR3FebuB+/N2NSTDU7AH5t+SYJZPMH4
	 mlui5GYHf61sTdHyTswwcMhv795Hb9W9qAJZShupLc9TCJ/eMM/DCq4L8MoaU8pQrC
	 4wxZot4GOu3+iPfVoulXthr7LDNxMIn119EI3jWWGcOhkGOrf7wjTj+39RhLm9wPoE
	 fro716qyuMtXQ==
Subject: Re: [PATCH v1 net 2/4] neighbour: Enforce min/max to
 NDTPA_INTERVAL_PROBE_TIME_MS.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, tgraf@suug.ch
Date: Wed, 09 Sep 2026 15:58:51 +0000
Message-ID: <178896953184.219967.1480289107581469046@kernel.org>
In-Reply-To: <20260907215853.3709987-3-kuniyu@google.com>
References: <20260907215853.3709987-3-kuniyu@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 2

- [High] The sysctl half of this fix is dead code: in
  neigh_proc_dointvec_ms_jiffies_positive()…
- [Low] Documentation/netlink/specs/rt-neigh.yaml declares interval-
  probe-time-ms as a bare `type: u64` with no `checks:` block (lines…
- [Low] Documentation/networking/ip-sysctl.rst:249-253 documents
  neigh/default/interval_probe_time_ms as having only a lower bound…

Pre-existing issues:
- [Medium] Only NDTPA_INTERVAL_PROBE_TIME_MS gains range validation.

--

neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.

This adds NLA_POLICY_FULL_RANGE() validation to
NDTPA_INTERVAL_PROBE_TIME_MS so values outside [1, one day in ms] are
rejected on the RTM_SETNEIGHTBL path, and installs the same maximum on the
interval_probe_time_ms sysctl handler.  A few questions below.

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 4b17c2a155947..454a8b8f3aa01 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2359,6 +2359,13 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
>  	[NDTA_PARMS]		= { .type = NLA_NESTED },
>  };
>  
> +#define NTBL_PARM_MS_MAX	(24 * 60 * 60 * MSEC_PER_SEC)
> +
> +static const struct netlink_range_validation nl_ntbl_parm_ms_range = {
> +	.min = 1,
> +	.max = NTBL_PARM_MS_MAX,
> +};
> +

[Severity: Low]
Should Documentation/netlink/specs/rt-neigh.yaml be updated in the same
patch?  In the neighbour-table-parms attribute set the attribute is still
declared with no checks block:

      -
        name: interval-probe-time-ms
        type: u64

With nl_ntbl_parm_ms_range now enforcing [1, 86400000], ynl-generated
bindings and the generated documentation describe an unconstrained u64 for
an attribute the kernel rejects with -EINVAL outside a one-day window.
Would adding "checks: min: 1 / max: 86400000" here keep the spec and the
policy in agreement?

>  static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
>  	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
>  	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
> @@ -2375,7 +2382,8 @@ static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
>  	[NDTPA_ANYCAST_DELAY]		= { .type = NLA_U64 },
>  	[NDTPA_PROXY_DELAY]		= { .type = NLA_U64 },
>  	[NDTPA_LOCKTIME]		= { .type = NLA_U64 },

[Severity: Medium]
This isn't a bug introduced by this patch, but the sibling millisecond
attributes above have the same shape of problem and keep plain
{ .type = NLA_U64 }: NDTPA_BASE_REACHABLE_TIME, NDTPA_GC_STALETIME,
NDTPA_DELAY_PROBE_TIME, NDTPA_RETRANS_TIME, NDTPA_ANYCAST_DELAY,
NDTPA_PROXY_DELAY and NDTPA_LOCKTIME.

neightbl_set() feeds each of them through nla_get_msecs() into the int
NEIGH_VAR array:

			case NDTPA_BASE_REACHABLE_TIME:
				NEIGH_VAR_SET(p, BASE_REACHABLE_TIME,
					      nla_get_msecs(tbp[i]));

For a u64 above jiffies_to_msecs(MAX_JIFFY_OFFSET), msecs_to_jiffies()
clamps to MAX_JIFFY_OFFSET (0x3FFFFFFFFFFFFFFE on 64-bit), which narrows to
-2 in the int p->data[] slot.

That negative value then reaches the same sinks the commit message
describes, in neigh_periodic_work():

	queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
			      NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME) >> 1);

and for the proxy delay:

	unsigned long proxy_delay = NEIGH_VAR(p, PROXY_DELAY);

	return proxy_delay ?
	       jiffies + get_random_u32_below(proxy_delay) : jiffies;

Since NTBL_PARM_MS_MAX and nl_ntbl_parm_ms_range are named generically
already, could they be reused for these attributes too, or is that
intentionally left for a follow-up?

> -	[NDTPA_INTERVAL_PROBE_TIME_MS]	= { .type = NLA_U64, .min = 1 },
> +	[NDTPA_INTERVAL_PROBE_TIME_MS]	= NLA_POLICY_FULL_RANGE(NLA_U64,
> +								&nl_ntbl_parm_ms_range),
>  };
>  
>  static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,

[ ... ]

> @@ -3670,12 +3678,13 @@ static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl,
>  						   void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct ctl_table tmp = *ctl;
> -	int ret;
> +	int ret, min, max;
>  
> -	int min = msecs_to_jiffies(1);
> +	min = msecs_to_jiffies(1);
> +	max = msecs_to_jiffies(NTBL_PARM_MS_MAX);
>  
>  	tmp.extra1 = &min;
> -	tmp.extra2 = NULL;
> +	tmp.extra2 = &max;
>  
>  	ret = proc_dointvec_ms_jiffies_minmax(&tmp, write, buffer, lenp, ppos);

[Severity: High]
Does this half of the fix actually take effect at this commit?  As far as I
can tell proc_dointvec_ms_jiffies_minmax() never looks at extra1/extra2, so
both the new max and the pre-existing min are inert here.

kernel/time/jiffies.c:do_proc_int_conv_ms_jiffies_minmax() passes
k_ptr_range_check = false:

	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
			     sysctl_u2k_int_conv_ms, sysctl_k2u_int_conv_ms);

and kernel/sysctl.c:proc_int_conv() only performs the comparison when that
flag is set:

	if (k_ptr_range_check) {
		...
		if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
		    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
			return -EINVAL;
		WRITE_ONCE(*k_ptr, tmp_k);
	} else
		return user_to_kern(negp, u_ptr, k_ptr);

The only remaining filter is proc_int_u2k_conv_uop(), which rejects
magnitudes above INT_MAX but lets 0 and negative values through:

	if (*negp) {
		if (u > (ulong) INT_MAX + 1)
			return -EINVAL;
		WRITE_ONCE(*k_ptr, -u);

So does

  echo 0 > /proc/sys/net/ipv4/neigh/default/interval_probe_time_ms

still store 0 jiffies, leaving the failure mode described in the commit
message reachable through sysctl in neigh_managed_work()?

	queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
			   NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME_MS));

If that is right, the commit message statement

    The same max check is applied to sysctl as well.

does not hold at this SHA, nor at the end of the series.  The prerequisite
sysctl range-check change is mentioned only below the scissors line:

    Currently, the sysctl range check is not applied to
    interval_probe_time_ms, which needs this fix:
    https://lore.kernel.org/linux-fsdevel/20260905233819.1064529-2-kuniyu@google.com/

That text is stripped when the patch is applied, so the permanent git log
keeps the unqualified claim.  Could the dependency be spelled out above the
scissors line, or the two patches ordered so this one lands after the
sysctl fix?

[Severity: Low]
Also, Documentation/networking/ip-sysctl.rst still documents only a lower
bound for this knob:

  neigh/default/interval_probe_time_ms - INTEGER
	The probe interval for neighbor entries with NTF_MANAGED flag,
	the min value is 1.

	Default: 5000

Should that be updated to mention the new 24 hour maximum?  The bound is
already observable on the RTM_SETNEIGHTBL path, and would become observable
on the sysctl file once the prerequisite range-check fix lands.

>  	neigh_proc_update(ctl, write);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907215853.3709987-1-kuniyu%40google.com
