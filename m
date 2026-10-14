Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47BA4DF4C1
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969346; cv=none; b=jDXPnXj7PY2jsty+4f4sjEkbMRePwVmCpbedT2EAXJTu3T9uf325NVODmXmjJo9tVjqrdTyE0QJcu5pLtqciT653ESUar+eYWkp+MW7C03ON1/lf4o4KC+ftXhMgxHnEJZttBvdndKsMXASQ5/3+uS1CrRpKNNSpBIslCGnQvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969346; c=relaxed/simple;
	bh=FFHDdI2TVymXsP0HN4HvtEdZ+TGvg/OehzIRJM3x3e4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bn257mYd6Xa6t9FE+sdhmnACysuDPQtYz4bErjTvqkZiHs2u+a+bDI7Gi/R92kozJX1plwI7ih5wLkP1Ch3ieKCcfOq4aBREjkXn3g5lZdyTCzsg1QSuhp67ofDriL374++sL6yzImtJx84Vv95E7BkmNVtryVhiP1kuQ1qb52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEKe2gBQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEKe2gBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145F91F00893;
	Wed, 14 Oct 2026 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791969344;
	bh=FDh4CZnga0ULzglpXJs+Mj7J1dilZw4XJUn0WMXmTS4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dEKe2gBQCW+8fTIX4lP4yfFUO9g+pxzhM9jGgWd15RoH92mbFDkdVQUK9wd6ZvnP9
	 BKO06Mfi9xB70jH+s9op7rlnQZeagNDgsWJuYyENBjEqnZIrIqfYHRP7DinZMlXozF
	 FnJ3sCA3WMvf42ffyyyU7b213ybSZFW7lMfnZRKmHdix5YYwX5Dq06nOQfQpYB4pfJ
	 cDLGqNgQpRNpf1kVd2oeCip3cKWkbAxdqVAeYzvlNsIIoz9WBUIrOiidkN3bwCpFXC
	 HhLxKZvWq0GsbLpBdCyNe3zA5XB8D3n7fx2AUyN2ndDeE1NTCu0EtV9KSszH3N5ldZ
	 PJUNuYFC/e5Zw==
Subject: Re: [PATCH net-next v3 5/5] net/sched: act_api: report an oversized
 action dump instead of silently truncating it
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, p@1g4.org
Date: Wed, 14 Oct 2026 09:15:43 +0000
Message-ID: <179196934366.434549.16677487229407143890@kernel.org>
In-Reply-To: <QDISC-H19Z.v3.r0.20261012193813-5@mojatatu.com>
References: <QDISC-H19Z.v3.r0.20261012193813-5@mojatatu.com>
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

- [Low] The patch has no Fixes: tag for the old silent-truncation path in
  tcf_dump_walker() (`index--; nlmsg_trim; goto done; return n_i`).
- [Low] The new comment above `return n_i ?: err;` in tcf_dump_walker()
  (net/sched/act_api.c:625-630) does not match the code or af_netlink's…

--

net/sched: act_api: report an oversized action dump instead of silently truncating it

When an action does not fit even into an empty dump skb, tcf_dump_walker()
now returns -EMSGSIZE with an extack instead of 0. tc_dump_action() now
passes the walker's error up instead of returning skb->len. Before this
change, "tc actions ls" silently left out that action and every action
after it.

Closes: https://lore.kernel.org/netdev/vPFrhbkwAui8zFPcGQTUDazQfsFDlr5GYuaYQ5BxJcrDiT6x1EljEze4cYadHqbeUW2ivLdpa8eC_cXC6ceACswgb-lW47aSVkHvHjhn_X8=@1g4.org/

> That case is reachable inside the gate entry cap this series adds: a gate
> entry serializes to 36 bytes (40 with the gate-open flag) while a dump skb
> is clamped to SKB_WITH_OVERHEAD(32768) by netlink_recvmsg()/netlink_dump(),
> so the top of the range the cap admits installs but cannot be dumped -
> and, before this change, fails silently.

[ ... ]

> This is a long-standing silent failure, not a regression, so it
> is net-next hardening.

[Severity: Low]
Would a Fixes: tag for the old silent truncation path in tcf_dump_walker()
be useful here, even though this goes to net-next?

The commit message ties the trigger to the gate entry cap in this series.
The same truncation can also be hit without the series. act_bpf_policy in
net/sched/act_bpf.c allows:

	[TCA_ACT_BPF_OPS]	= { .type = NLA_BINARY,
				    .len = sizeof(struct sock_filter) * BPF_MAXINSNS },

That is 32768 bytes of ops, which is more than SKB_WITH_OVERHEAD(32768).
So a single classic bpf action can already be too large for the dump skb.

Leaving out Fixes: may be on purpose, because the patch turns a silent
success into an error and is kept out of stable. If so, could the commit
message say that the problem is not limited to the gate series?

> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index fd7f60e0f62ba..33dba34364541 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c

[ ... ]

> @@ -626,10 +621,21 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
>  		if (act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON)
>  			cb->args[1] = n_i;
>  	}
> -	return n_i;
> +
> +	/* A positive count means the skb filled up before this action was
> +	 * complete, so netlink retries it in a fresh skb. An action that
> +	 * does not fit even in an empty dump skb (nothing dumped) must be
> +	 * reported as -EMSGSIZE by netlink instead of ending the dump.
> +	 */
> +	return n_i ?: err;

[Severity: Low]
Is this comment right for every path that reaches this return in
tcf_dump_walker()?

A positive n_i also comes back when the idr walk finishes after dumping
every action. It also comes back when the loop stops here:

		if (!(act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON) &&
		    n_i >= TCA_ACT_MAX_PRIO)
			goto done;

The skb did not fill up in either case. After a normal finish there is
also nothing left to retry.

The second sentence says -EMSGSIZE is reported "instead of ending the
dump". In netlink_dump() in net/netlink/af_netlink.c, a negative return
with an empty skb fails this check:

	if (nlk->dump_done_errno > 0 ||
	    skb_tailroom(skb) < nlmsg_total_size(sizeof(nlk->dump_done_errno))) {

It then goes on to netlink_dump_done(), which sends NLMSG_DONE with the
error and extack, and the dump ends. So the dump still ends, but now with
an error instead of silently.

Could the comment be reworded to match the return contract that
tc_dump_action() now relies on?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v3.r0.20261012193813%40mojatatu.com
