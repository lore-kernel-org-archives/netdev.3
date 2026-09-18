Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BB48551F
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712825; cv=none; b=EW4clQoZyMJM7TXKmWXC9IT/OdZXaWl3Wjzn6oq6+xLqHRP8GIzyijF4OHQ7Ahrm/aciEv5YZf0k3wVX9wTj12+pHbXjfPpIawpj1Vpi+DK/fRtach63/6KPV1m7Dk/PatG+6mtgyD9z3IlRGoOsHgIP8BknWqqFPNaCHYt0zXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712825; c=relaxed/simple;
	bh=UjUkNLRnEFK2RGFvvN2ggD43/ocS8CRfNNY0EZbwzHM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJjw3kHTm1sVK/JbvqUXsR48mJLkAo1nsNJu0exfJDH+F6vvi9mqW6E0Umt34uGmZBNmlDo24e/GFPD3jYZEhxadYPJfUJBOxUd9z3t4VnckVEQl9u9PEh+w3zRn0qy5TiVOFDhwkQxD+MKFxcBWqK1sTJO28ymTTl2zEFsIxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRFOh8LS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRFOh8LS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19071F000FF;
	Fri, 18 Sep 2026 06:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789712823;
	bh=evC5+3Q3BGyV/vSaXPR+Ie/iSqIk9aB7YTEVCIGmJhA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WRFOh8LSoiL1Vr5+28JGxGGPcQfhr6XkhNc0N0PE3OLieEKPU3VeNxcN6yNfCDuDx
	 LejdrSr8JQON9xPkRHmk7xSqIB3Ki9D1BRhegEEizJrlAZCduIlkIDHch0FcYtHYK2
	 Yqjo+9K6CVx3afqIEWtAGMvPNbDCL6vtuDtFlAzzAbioV+V9LYzddAF6LDl0N1Y0YT
	 C+qbRyJeqLqfCxxcJTUb3v7FKr4JMAFXyN3HzpsKg3QNp1QYWLiFiqboE43qcKdJKK
	 HuTp2ibQ6bFtQEBtYlOU04J7QbLR6Od/7643py2k+8OYZK2whRY5oypoLtN9vgWck2
	 5M8UAZg5yNn0Q==
Subject: Re: [PATCH v2] openvswitch: fix soft lockup in the netlink flow dump
From: netdev-bot+sashiko@kernel.org
To: den@openvz.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Fri, 18 Sep 2026 06:27:02 +0000
Message-ID: <178971282245.22033.17364092566029672665@kernel.org>
In-Reply-To: <20260915122401.3910188-1-den@openvz.org>
References: <20260915122401.3910188-1-den@openvz.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The patch converts the whole netlink flow-dump callback into a
  softirq-disabled - and on !PREEMPT_RT CONFIG_PREEMPT kernels fully…
- [Low] The submission fixes a user-visible production failure (soft
  lockup and panic inside a single OVS_FLOW_CMD_GET netlink dump) but…

--

openvswitch: fix soft lockup in the netlink flow dump

The patch wraps the whole ovs_flow_cmd_dump() callback in
local_bh_disable()/local_bh_enable() so that the nested spin_unlock_bh()
calls inside ovs_flow_stats_get() no longer drain the softirq backlog in
the dumping thread's context.  The dump loop already runs under
rcu_read_lock() and does not sleep.

A couple of questions below.

[Severity: Low]
The change repairs a user-visible failure (soft lockup and panic in a
single OVS_FLOW_CMD_GET dump), but the trailer block carries only a
Signed-off-by, with no Fixes: tag and no stable indication.

Documentation/process/maintainer-netdev.rst says:

 - for fixes the ``Fixes:`` tag is required, regardless of the tree

The offending construct, the per-CPU spin_lock_bh()/spin_unlock_bh() pair
in ovs_flow_stats_get() executed once per CPU in flow->cpu_used_mask for
every emitted flow, is long standing, so the affected stable range is
wide.  Could a Fixes: tag (and a note on whether this is stable material)
be added so backporters know which trees are in scope?

> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index 631a03136fa14..a80bac81c0430 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -1532,6 +1532,11 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * Not needed for safety. Stops every spin_unlock_bh() in
> +	 * ovs_flow_stats_get() from running the softirq backlog here.
> +	 */
> +	local_bh_disable();
>  	ti = rcu_dereference(dp->table.ti);
>  	for (;;) {
>  		struct sw_flow *flow;

[Severity: Medium]
Is the length of this new softirq-disabled region actually bounded by
anything small?

The commit message says:

    That region is bounded by the skb and the table size, where the
    softirq backlog it used to absorb is not.

The table size is the part that worries me.  ovs_flow_tbl_dump_next()
sweeps buckets with no per-callback budget:

net/openvswitch/flow_table.c:ovs_flow_tbl_dump_next() {
	while (*bucket < ti->n_buckets) {
		i = 0;
		head = &ti->buckets[*bucket];
		hlist_for_each_entry_rcu(flow, head, flow_table.node[ver]) {
		...
		(*bucket)++;
		*last = 0;
	}
}

and n_buckets only ever grows: table_instance_expand() doubles it when
table->count > ti->n_buckets, while ovs_flow_tbl_remove() and
table_instance_flow_free() only decrement table->count and never shrink
the bucket array.  So a datapath that once held a very large number of
flows keeps a large sparse table, and the last callback of a dump can
walk all remaining empty buckets in one BH-off region, with no
cond_resched() or other break point in the loop.

For every emitted flow the region also runs one lock/unlock pair per CPU:

net/openvswitch/flow.c:ovs_flow_stats_get() {
	for_each_cpu(cpu, flow->cpu_used_mask) {
		...
			spin_lock_bh(&stats->lock);
		...
			spin_unlock_bh(&stats->lock);
	}
}

While that region is held, NET_RX/NET_TX, timer and RCU softirqs are all
suppressed on the dumping CPU, so NAPI stalls and the rx backlog can
overflow.  The loop also loses the preemption it previously had inside the
preemptible rcu_read_lock() section on CONFIG_PREEMPT.

The dump is reachable without privileges:

	{ .cmd = OVS_FLOW_CMD_GET,
	  .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
	  .flags = 0,		    /* OK for unprivileged users. */
	  .doit = ovs_flow_cmd_get,
	  .dumpit = ovs_flow_cmd_dump
	},

so a process can repeatedly force these windows on a host with a large
datapath table.

Would a per-callback budget work here, emitting N flows or scanning M
buckets and then returning so netlink re-invokes the callback with BH
re-enabled?  Alternatively, could the BH-off region be scoped to the
for_each_cpu() loop inside ovs_flow_stats_get() rather than the whole
callback?

I note ctnetlink_dump_table() already has the same whole-callback shape
over nf_conntrack_htable_size buckets, so the approach itself is not
unprecedented in net/; the question is only about bounding the OVS sweep.

> @@ -1552,6 +1557,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
>  		cb->args[0] = bucket;
>  		cb->args[1] = obj;
>  	}
> +	local_bh_enable();
>  	rcu_read_unlock();
>  	return skb->len;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915122401.3910188-1-den%40openvz.org
