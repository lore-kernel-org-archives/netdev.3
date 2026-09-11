Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A52C3266
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089326; cv=none; b=YUYGbvV7OoKaPrHhqsCOfd6J0TsWSv60EAN1cUD98bdU8OjuTy2uB8pxrM+qBGsbqdJ78LNowCnVJJGESMXmt7zvIkdkKVAPTzMIl0GHamsyip+Z0mK1LHw2NIcLkz199IR8pVRmlzS8AaSd5mKRZ6JxvvINitLPhXG11g+w19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089326; c=relaxed/simple;
	bh=uQY6NSecif1/4TYb6TUe8zlUacuBgMVxYlG9QCWKHiU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WseYVC/eYPs84y0Sav3sxPislzb9QXpP79XQryjb8sgRK4jGsA00wnjHSTOBcayKeUymsMy+LNmlzizUL75FDgqnP2tGX0BVKIb1g6J9aBm8BLx4ywZmTqU97lUdnLUFweMd6yElWs/vCxdoAZe4E54mW/rH6VaYdm2lj5AbDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J273P6av; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J273P6av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346D31F000FF;
	Fri, 11 Sep 2026 01:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089324;
	bh=Ru/yNa4yP3eD7egGhdHcXlKTj4NjU+vOTeE3Sbq8yzA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J273P6avY4TIOuFrLymTHxehSmXQgGvwLbj3E7lQEMJ3u9bQIUcoyWD596NZro32U
	 APt+1sNlW17ERw373n/xxpMS5zutHRTQGaDm7izaMQIB2vb9rlThp+dMwz1GrfxpI/
	 HF09mBxQ1JSLkJGDhbIMmGUM6DKHPjtERZGQzx5wes49KvXS4aSshffuvuaiCwXDp3
	 U0kvt/qYE9k+DkZbx0EMP+q57axBvBS8iKk3NXfoZcyuIE+8gLLsrYlw02mqBy8QPb
	 hBzsydvvQILDl4UV8C0G+SWcyWv7f+GGhwDDcOGy3b4lcZsk6uoCLOqBlO/g2u1pTA
	 BAbhXNIgWZ1jw==
Subject: Re: [PATCH v3 net 2/4] neighbour: Enforce min/max to
 NDTPA_INTERVAL_PROBE_TIME_MS.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, tgraf@suug.ch
Date: Fri, 11 Sep 2026 01:15:23 +0000
Message-ID: <178908932373.219967.4672575432952615722@kernel.org>
In-Reply-To: <20260909233143.2401847-3-kuniyu@google.com>
References: <20260909233143.2401847-3-kuniyu@google.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] The sysctl half of this patch is inert in this tree:
  `neigh_proc_dointvec_ms_jiffies_positive()`…

--

neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.

The patch replaces the ineffective .min-only policy entry for
NDTPA_INTERVAL_PROBE_TIME_MS with NLA_POLICY_FULL_RANGE(), bounding it to
1..86400000 ms, and adds the same max to the sysctl handler plus the
netlink spec and ip-sysctl documentation.

One question about the sysctl half of the change below.

> diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
> index 0f46ef3135905..c8e55c98d5649 100644
> --- a/Documentation/netlink/specs/rt-neigh.yaml
> +++ b/Documentation/netlink/specs/rt-neigh.yaml
> @@ -341,6 +341,9 @@ attribute-sets:
>        -
>          name: interval-probe-time-ms
>          type: u64
> +        checks:
> +          min: 1
> +          max: 86400000
>  
>  operations:
>    enum-model: directional
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 208f46967ee59..b05829e44d8fc 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -248,7 +248,7 @@ neigh/default/unres_qlen - INTEGER
>  
>  neigh/default/interval_probe_time_ms - INTEGER
>  	The probe interval for neighbor entries with NTF_MANAGED flag,
> -	the min value is 1.
> +	the min value is 1, and the max value is 86400000 (1 day).
>  
>  	Default: 5000
>  
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 49dd7df149ef3..0db78a0dfb516 100644
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

[ ... ]

> @@ -3672,12 +3680,13 @@ static int neigh_proc_dointvec_ms_jiffies_positive(const struct ctl_table *ctl,
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
Does proc_dointvec_ms_jiffies_minmax() actually look at extra1/extra2 in
this tree?  The call chain from neigh_proc_dointvec_ms_jiffies_positive()
seems to drop the range check:

kernel/time/jiffies.c:

  static int do_proc_int_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr,
                                                int *k_ptr, int dir,
                                                const struct ctl_table *tbl)
  {
        return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
                             sysctl_u2k_int_conv_ms, sysctl_k2u_int_conv_ms);
  }

kernel/sysctl.c:proc_int_conv() only consults the bounds when
k_ptr_range_check is true:

        if (k_ptr_range_check) {
                ...
                if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
                    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
                        return -EINVAL;
                WRITE_ONCE(*k_ptr, tmp_k);
        } else
                return user_to_kern(negp, u_ptr, k_ptr);

Since the converter passes false, aren't both tmp.extra1 = &min and the new
tmp.extra2 = &max dead stores, so a write of 0, of a value well above
86400000, or of a negative value to
/proc/sys/net/ipv{4,6}/neigh/*/interval_probe_time_ms still succeeds?

If so, the failure mode described in the commit message stays reachable via
the sysctl entry point, where neigh_managed_work() requeues itself with the
unvalidated value:

  queue_delayed_work(system_power_efficient_wq, &tbl->managed_work,
                     NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_TIME_MS));

with 0 meaning no delay and a negative int sign-extending into the unsigned
long delay argument.

That would also make this sentence in the commit message inaccurate:

    The same max check is applied to sysctl as well.

and likewise the new documentation text:

	the min value is 1, and the max value is 86400000 (1 day).

The netlink half looks fine, so the sysctl path and the range now declared
in Documentation/netlink/specs/rt-neigh.yaml would disagree: an out-of-range
sysctl write can still be reported back by RTM_GETNEIGHTBL as a value
outside the declared 1..86400000 range.

The cover note below the --- line points at a separate, not-yet-merged
sysctl-core fix
(https://lore.kernel.org/linux-fsdevel/20260905233819.1064529-2-kuniyu@google.com/)
as a prerequisite.  Since that note does not end up in git history, would it
make sense to order this patch behind that fix, or to mention the dependency
in the commit message itself?  Note this commit carries a Fixes: tag, so a
stable backport would carry the documented bound without the enforcement.

I checked the end of this series and do_proc_int_conv_ms_jiffies_minmax()
still passes false, so nothing later in the series appears to restore the
check.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909233143.2401847-1-kuniyu%40google.com
