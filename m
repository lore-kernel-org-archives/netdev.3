Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44831B2EF2;
	Thu,  1 Oct 2026 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790819368; cv=none; b=DlIas9+45N3wNjqb2ULdveqNue4rCKmwMMpjOs31fbirrqc1BhjfvQe8gDVDw7nTQa1L4WprSWZw9rG9e92RXAj7i+RPHol7MrfyLY9PK5Tn5AWxLr/q2ATX5QadmkzgWXSwjYRU3aPD2Rnny+b7tDJ3dl1qZv25eHQNKYcPgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790819368; c=relaxed/simple;
	bh=1eRIC6QwZ5Svor+izDXSwp/simfQVqoWmi6eKhLcJso=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WLUI/r/3Zcqw43yDgaWopiHYS7cmCkQZ5f0PWYTXAh7g/s2jNABg5iAYZEtQjGycr3924OkMZDxEBWrqJtXPc9pgXpn7rcN8fst9ToXuLXWEKGfKrygeAz59rpjCljHoDLJ2RtvFWRSqpZr3gFJYyNjC1lPGaxnINiJ1lD3YqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8EYo3Rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8EYo3Rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB611F000FF;
	Thu,  1 Oct 2026 01:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790819366;
	bh=OaTspnSppdug0kn60xdsGmQJhCWrIuSrl37TlvNdxhM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d8EYo3RkNhfMDM99BeqNGj/glrSTyxDxQrrUgX4qVqu5fMuSCAHxemSURXcyJr1MH
	 sN5YMm1hE6hyOVlaUdpTg4J4uI5j77FXr39RAXN+eMdNKVrGnGKCmZHpwjT0KJBcJh
	 8pnzaOLj9TIwk69xNdIcubvuh3IMYb6DopqWFWUKbqDUaj0aSJYDFtHr3OhvH9N9nr
	 lV1xrUMVcQYjxopOVZ0r7StihLBhk8Ymbnut2PQzNFEyRBuhQBuKlpkcm/NMQmgQVR
	 fBhBNMc7ykxzjso7lAWiq8Glt3jEwcQENoZ51iiSz4qgApTD5t9mDe7GVMvO+pXrfS
	 Q5SeeftOBgq4w==
Subject:
 Re: [PATCH net-next] net: iterate online nodes in skb_defer_free_flush()
From: netdev-bot+sashiko@kernel.org
To: kris.pan@intel.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, atomasov@redhat.com,
 oliver.sang@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 01:49:25 +0000
Message-ID: <179081936536.434549.10388925622845161029@kernel.org>
In-Reply-To: <20260928014708.3903028-1-kris.pan@intel.com>
References: <20260928014708.3903028-1-kris.pan@intel.com>
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

- [Medium] The patch changes skb_defer_free_flush() (net/core/dev.c) to
  use for_each_online_node().

--

net: iterate online nodes in skb_defer_free_flush()

This patch changes skb_defer_free_flush() to walk node_online_map instead
of node_possible_map. The aim is to skip per-node defer lists that are
always empty on systems with many possible nodes but few online ones,
such as POWER10 LPARs.

Closes: https://lore.kernel.org/oe-lkp/202512112119.5b9829a-lkp@intel.com

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0dbc..807640155e649 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6927,7 +6927,7 @@ static void skb_defer_free_flush(void)
>  	struct skb_defer_node *sdn;
>  	int node;
>  
> -	for_each_node(node) {
> +	for_each_online_node(node) {
>  		sdn = this_cpu_ptr(net_hotdata.skb_defer_nodes) + node;
>  		__skb_defer_free_flush(sdn, 1);
>  	}

[Severity: Medium]

Is cpu_to_node() of a running CPU always in node_online_map? The commit
message says:

  skb_attempt_defer_free() only queues skbs on the current CPU's node
  (numa_node_id() of a running CPU), which is always online, ...

skb_attempt_defer_free() chooses the list without checking whether the
node is online:

net/core/skbuff.c:skb_attempt_defer_free() {
    ...
	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + cpu_to_node(my_cpu);
    ...
}

The only place that brings a CPU's node online is cpu_up():

kernel/cpu.c:cpu_up() {
    ...
	err = try_online_node(cpu_to_node(cpu));
    ...
}

With CONFIG_MEMORY_HOTPLUG=n, try_online_node() is a stub that does
nothing:

include/linux/memory_hotplug.h:
static inline int try_online_node(int nid)
{
	return 0;
}

Consider a pseries LPAR with CONFIG_NUMA=y and CONFIG_MEMORY_HOTPLUG=n,
using the same 32 possible / 1 online layout this patch targets. A DLPAR
CPU add goes through dlpar_online_cpu()->find_and_update_cpu_nid(). That
function only checks node_possible() and relies on cpu_up() to bring the
node online:

arch/powerpc/mm/numa.c:find_and_update_cpu_nid() {
    ...
	if (new_nid < 0 || !node_possible(new_nid))
		new_nid = first_online_node;
	else
		// Associate node <-> cpu, so cpu_up() calls
		// try_online_node() on the right node.
		set_cpu_numa_node(cpu, new_nid);
    ...
}

The CPU can then come online with cpu_to_node() == N while N stays
offline. NODE_DATA and zonelists exist for every possible node, so that
CPU runs normally.

When that CPU defer-frees skbs for a remote alloc_cpu, they go into
per_cpu(skb_defer_nodes, alloc_cpu)[N]. With this change, will
skb_defer_free_flush() on alloc_cpu ever visit index N?

Only __skb_defer_free_flush() resets defer_count. So it looks like up to
sysctl_skb_defer_max - 1 skbs per alloc_cpu (128 is the default max) stay
stranded, along with their page frags and page_pool pages. The only
remaining drain is dev_cpu_dead():

net/core/dev.c:dev_cpu_dead() {
    ...
	for_each_node(node)
		skb_defer_node_flush(per_cpu_ptr(net_hotdata.skb_defer_nodes,
						 oldcpu) + node);
    ...
}

That only runs when a CPU goes offline. Could page_pool_destroy() then
stall at device teardown, the same failure described in commit
06e3f54e8b22 ("net: flush skb_defer_nodes in dev_cpu_dead()")?

Would it be safer to keep for_each_node() here? Another option would be
to track the nodes that have online CPUs instead of relying on
node_online_map.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928014708.3903028-1-kris.pan%40intel.com
