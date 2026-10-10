Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1441404882
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 05:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610614; cv=none; b=rcQVBkso5/ocW1prQy10T2f7rcFaLpkNc3tkkkwFynLqU3Fsp3VRPD2mutljbTa1izU65JuxUi35ZkHYx+f4nDS+XI/xgg2m7Q4qxigjJ1inHAmmw2IP/VOm1OenWgax8K6EThkwcb4U9EOSPKFWDrxN7flHDPA+fBpEd/dYrHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610614; c=relaxed/simple;
	bh=7k2N2JHJiOxBGm22VpvI1GM+I6o/xXv0xV9g6vl9MiM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hPo3DZUqD0HoJH0nE1cl9rhAG7oDst8kmzuLCttRRoi5nyafzq/xYQOk5ypPS4gJVcpWiUmoLHZOzPVU62ljKt9o+zhm8FeKbTA5ZEqbfOzzCxa69gIW12kQ+CZHQpni2so9ZRiaXxTEFSVddG1If1UnpW/B/vo0f7ejc26i6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn4XCHi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn4XCHi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E0C1F000FF;
	Sat, 10 Oct 2026 05:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791610612;
	bh=q2ROiaqG4AzsdL5tmgKoza8XfM0ca+uOmhwRCY3KdLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pn4XCHi33DxOIq7MLX+ocQOXwFDKmgxB5oPlwuBNT96HPOn9hkCWnk8wo2w8DV2oF
	 qCKNVgqc4ya8VW2AlJuUASQ7cip5yhePRjiJ/5TMBi4fFBw3Nl64rjZ/j1bjv+XCG3
	 3ftTbzbHEOrhXkknW4JlFSyEAP6O9pXYkee2kEF1cGEGm6xtzWEZVsPSbj6UbkPIKR
	 Wf8qhdfZ2bpQwKDkvhvt/1XEzfWVmhT7w7PCRsc9FYOWvjVtppeR6ZFQZKaQH5IaA5
	 dDbBkA60V1q8sEdkb7pccqKM2TMNzWXfUgZdwUscBR569xzujFJf1rSknXz+OBvDXK
	 ZokkozkWOIt0g==
Subject: Re: [PATCH net-next 2/2] net/sched: act_tunnel_key: skip dst cache
 for skip_sw actions
From: netdev-bot+sashiko@kernel.org
To: acassen@corp.free.fr
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Date: Sat, 10 Oct 2026 05:36:51 +0000
Message-ID: <179161061150.434549.17402573349623469379@kernel.org>
In-Reply-To: <20261009051930.3619697-3-acassen@corp.free.fr>
References: <20261009051930.3619697-3-acassen@corp.free.fr>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch only saves the dst_cache when TCA_ACT_FLAGS_SKIP_SW
  is already in act_flags while tunnel_key_init() runs.

--

net/sched: act_tunnel_key: skip dst cache for skip_sw actions

This commit makes tunnel_key_init() skip dst_cache_init() when the
tunnel_key action is flagged skip_sw, because such an action never routes
packets. On replace it checks the flags of the existing action rather
than the flags in the request.

> diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
> index 5038348533060..28d9cc080101a 100644
> --- a/net/sched/act_tunnel_key.c
> +++ b/net/sched/act_tunnel_key.c
> @@ -481,9 +481,13 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
>  		}
>  
>  #ifdef CONFIG_DST_CACHE
> -		ret = dst_cache_init(&metadata->u.tun_info.dst_cache, GFP_KERNEL);
> -		if (ret)
> -			goto release_tun_meta;
> +		if (!((exists ? (*a)->tcfa_flags : act_flags) &
> +		      TCA_ACT_FLAGS_SKIP_SW)) {
> +			ret = dst_cache_init(&metadata->u.tun_info.dst_cache,
> +					     GFP_KERNEL);
> +			if (ret)
> +				goto release_tun_meta;
> +		}
>  #endif

[Severity: Medium]
Does this cover the usual hardware offload setup? In that setup skip_sw
is set on the filter, not on the action:

  tc filter add ... flower skip_sw ... action tunnel_key set ...

For a new action, exists is false, so act_flags is checked. act_flags
comes from tcf_action_init_1() and holds only the per-action user flags
plus the BIND/REPLACE flags:

net/sched/act_api.c:tcf_action_init_1() {
    ...
	err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
			userflags.value | flags, extack);
    ...
}

fl_change() passes the filter flags (fl_flags) through
tcf_exts_validate_ex(). tcf_action_init() copies them onto the action
only after ->init() has returned:

net/sched/act_api.c:tcf_action_init() {
    ...
		act = tcf_action_init_1(net, tp, tb[i], est, ops[i - 1],
					&init_res[i - 1], flags, extack);
    ...
				if (skip_sw)
					act->tcfa_flags |= TCA_ACT_FLAGS_SKIP_SW;
    ...
}

By that point tunnel_key_init() has already called dst_cache_init().
tcf_action_exec() always skips the resulting action, but the action
still holds a per-CPU dst_cache.

This matches the baseline behaviour, so nothing breaks. Still, the
subject says "skip dst cache for skip_sw actions". Only actions with an
explicit skip_sw in TCA_ACT_FLAGS get the saving: standalone actions, or
in-filter actions that set their own flags.

Could the filter's skip_sw reach ->init()? One way would be to OR
TCA_ACT_FLAGS_SKIP_SW into the flags given to tcf_action_init_1() when
tc_skip_sw(fl_flags) is set. Otherwise, could the commit message mention
this limit?

The commit message also doesn't say why the change is wanted (presumably
to save per-CPU memory). Could that be added?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009051930.3619697-1-acassen%40corp.free.fr
