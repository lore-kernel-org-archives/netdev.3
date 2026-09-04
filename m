Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF333ADBA7
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491406; cv=none; b=uqkw18UM1/2uYuItC+EqKS7hopas5NLysTbgL67Mr5q9EjDBcUISbw0hsbuZykW8yuUhbmyD0nIQ+3Y6vXBDGphb6gptjMuzlx3KBX1UmGl26WyU1PPg87FnGC+GRaIxDUY4RCe4iNZkC4yx6f0u7Q1U+SMTdZ1SfHd4bzBx2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491406; c=relaxed/simple;
	bh=TA3v1WNOZV112v4GCTTPeugJFoAn11b2LQJQeoQY+Xw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FxAcLBre2Z6cYC59LLTjqARntgogPohP7A2aZY8z/zlNMrkxzm0SqDDQoHIC1ZgsE7mCSv4eBO1reecjXqAVrRo1yscfqma0aLUYRwKXrrUr6yC9ugrP76Z+UUB3+lBzKalz6a5m3HeY2ISf06Z8dWuWniOtLIO/gByn0aj1u0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZBU8QkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZBU8QkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DBF1F00A3E;
	Fri,  4 Sep 2026 03:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491404;
	bh=3oGfadTzvmucEy8oyfyKI0yy7l37S6Hx0vOF5MjQYIM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FZBU8QkYXDhckclg5V+w5ie/vUzVgGXdguS+KQ2Hy9OcCqPNlZ2yC+mymBCHDmHYh
	 vEU8sf6+U1closzxvi7vqkVr66dB8u2j5POJfBlWya1RbfoZr6AjNnAFMxJgSPd/ph
	 kJh5FFDpdB5ZT1F32+h1tAvCUrbTcXex+Z25mhkk1eAsyuTslP2b12KtV5sN3vKNPp
	 hteELRIO6iIDAFJ+gkBW4smfonzpdx/ZhIY0Sy3b4w+1SM+W4lCeeNihFsQaMRWbpL
	 qtpxhmQGH1WbY18f5vcw3044LbBx5FW3KA3AszY6fqlHG1xVMd5c8V1uD8z9Be0viZ
	 AZfju2ruIpbnw==
Subject: Re: [PATCH v6 net-next 12/15] neighbour: Namespacify neigh_tables.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 razor@blackwall.org
Date: Fri, 04 Sep 2026 03:10:03 +0000
Message-ID: <178849140347.4131868.7289933510858041654@kernel.org>
In-Reply-To: <20260902203722.926528-13-kuniyu@google.com>
References: <20260902203722.926528-13-kuniyu@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] neigh_table_unregister() (net/core/neighbour.c:1963-1969)
  retracts the table with a plain store `net->neigh_tables[index] =…
- [Low] tools/testing/selftests/net/test_neigh.sh (extern_valid_common)
  still drives "ip ntable change ... thresh1/2/3, base_reachable" in the…
- [Low] The new per-netns neigh_table allocations are not memcg-
  accounted: neigh_table_register() uses kmemdup(tbl, sizeof(*tbl),…
- [Low] neigh_table_inherit() copies init_net's gc_interval,
  gc_thresh1/2/3 and the whole parms.data[] array with bare READ_ONCE()…

--

neighbour: Namespacify neigh_tables.

This makes struct neigh_table a per-netns object: neigh_table_register()
now kmemdup()s the template table, optionally inherits init_net's GC and
default parms values, and calls neigh_table_init() plus
neigh_sysctl_register() for each namespace. A new knob,
net.core.neigh_inherit_init_net, controls the inheritance.

A few questions on the new allocation and teardown paths below.

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 7dc8f0cdbb45..414422bcc0ec 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c

[ ... ]

> @@ -1905,16 +1905,12 @@ static void neigh_table_free(struct neigh_table *tbl)
>  	nht = rcu_dereference_protected(tbl->nht, 1);
>  	tbl->nht = NULL;
>  	neigh_hash_free_rcu(&nht->rcu);
> +
> +	kfree(tbl);
>  }
>
> -/*
> - * Only called from ndisc_cleanup(), which means this is dead code
> - * because we no longer can unload IPv6 module.
> - */
> -int neigh_table_clear(struct neigh_table *tbl)
> +static void neigh_table_clear(struct net *net, struct neigh_table *tbl)
>  {
> -	struct net *net __maybe_unused = &init_net;
> -
>  	cancel_delayed_work_sync(&tbl->managed_work);
>  	cancel_delayed_work_sync(&tbl->gc_work);
>  	timer_shutdown_sync(&tbl->proxy_timer);
> @@ -1923,20 +1919,61 @@ int neigh_table_clear(struct neigh_table *tbl)
>  	remove_proc_entry(tbl->id, net->proc_net_stat);
>
>  	neigh_table_put(tbl);
> +}
>
> -	return 0;
> +int sysctl_neigh_inherit_init_net __read_mostly = 1;
> +
> +static void neigh_table_inherit(struct net *net, struct neigh_table *tbl,
> +				int index)
> +{
> +	const struct neigh_table *init_tbl = init_net.neigh_tables[index];
> +	bool inherit = READ_ONCE(sysctl_neigh_inherit_init_net);
> +	int i;
> +
> +	if (net_eq(net, &init_net) || !inherit)
> +		return;
> +
> +	tbl->gc_interval = READ_ONCE(init_tbl->gc_interval);
> +	tbl->gc_thresh1 = READ_ONCE(init_tbl->gc_thresh1);
> +	tbl->gc_thresh2 = READ_ONCE(init_tbl->gc_thresh2);
> +	tbl->gc_thresh3 = READ_ONCE(init_tbl->gc_thresh3);
> +
> +	for (i = 0; i < NEIGH_VAR_DATA_MAX; i++)
> +		tbl->parms.data[i] = READ_ONCE(init_tbl->parms.data[i]);

[Severity: Low]
Should this snapshot of init_net's table be taken under init_tbl->lock?

neightbl_set() updates exactly these fields under spin_lock_bh(&tbl->lock),
with the comment:

	/*
	 * We acquire tbl->lock to be nice to the periodic timers and
	 * make sure they always see a consistent set of values.
	 */
	spin_lock_bh(&tbl->lock);
	...
	WRITE_ONCE(tbl->gc_thresh1, nla_get_u32(tb[NDTA_THRESH1]));

An "unshare -n" concurrent with RTM_SETNEIGHTBL on init_net can therefore
copy a mix of old and new threshold values into the new namespace.

For what it's worth, the same fields are already written without tbl->lock
via the sysctl path that this patch registers per netns (neigh_sysctl_register()
points NEIGH_VAR_GC_THRESH1..3 and NEIGH_VAR_GC_INTERVAL .data at
&tbl->gc_thresh1..3 and &tbl->gc_interval with plain proc_dointvec* handlers),
and nothing enforces an ordering relation among the thresholds, so the
resulting combination is one an administrator could configure directly.

> }
>
>  int neigh_table_register(struct net *net, struct neigh_table *tbl, int index)
>  {
> +	int err;
> +
> +	tbl = kmemdup(tbl, sizeof(*tbl), GFP_KERNEL);
> +	if (!tbl) {
> +		err = -ENOMEM;
> +		goto err;
> +	}

[Severity: Low]
Should these per-netns allocations be memcg accounted?

Two tables (ARP and ND) are now created for every network namespace, and
namespace creation is reachable by unprivileged users through user
namespaces. Besides this kmemdup(), neigh_table_init() allocates
neigh_hash_alloc(3), kzalloc(phsize, GFP_KERNEL) for phash_buckets and
alloc_percpu(struct neigh_statistics), the last of which scales with
nr_cpu_ids for each of the two tables per namespace.

neigh_sysctl_register() in the same file already uses the accounted flag
for its per-netns allocation:

	t = kmemdup(&neigh_sysctl_template, sizeof(*t), GFP_KERNEL_ACCOUNT);

Would GFP_KERNEL_ACCOUNT here and alloc_percpu_gfp(..., GFP_KERNEL_ACCOUNT)
in neigh_table_init() be more consistent with that?

[Severity: Low]
Does this break the forced-GC and periodic-GC subtests in
tools/testing/selftests/net/test_neigh.sh?

extern_valid_common() still runs the thresholds and counter readback in the
initial netns while the entries are created inside $ns1:

	run_cmd "ip ntable change name $tbl_name thresh3 10 thresh2 9 thresh1 8"

With per-netns tables, neigh_table_inherit() only snapshots values at
registration time, and setup() creates ns1/ns2 before this command runs, so
$ns1's thresholds are unaffected. The same applies to the
"ip -j -s ntable show" readback of forced_gc_runs/periodic_gc_runs, which now
reports init_net's per-netns tbl->stats rather than $ns1's.

The last patch of this series, "selftest: net: Specify netns for ip ntable in
test_neigh.sh.", converts these commands to "ip -n $ns1 ntable ...", so the
only residual effect is a two-commit window where the selftest can fail.

> +
> +	neigh_table_inherit(net, tbl, index);
> +
> +	err = neigh_table_init(net, tbl);
> +	if (err)
> +		goto free_table;
> +
>  	net->neigh_tables[index] = tbl;
>
>  	return 0;
> +
> +free_table:
> +	kfree(tbl);
> +err:
> +	return err;
>  }
>
>  void neigh_table_unregister(struct net *net, int index)
>  {
> +	struct neigh_table *tbl = net->neigh_tables[index];
> +
>  	net->neigh_tables[index] = NULL;
> +	neigh_table_clear(net, tbl);
>  }

[Severity: Medium]
Is a grace period needed between retracting the slot and freeing the table?

The store is a plain one, and neigh_table_clear() -> neigh_table_put() ->
neigh_table_free() now ends in kfree(tbl), so the table can be freed
immediately after the slot is cleared.

Readers load the same slot with a plain load under rcu_read_lock() and then
dereference it, for example neigh_xmit():

	rcu_read_lock();
	net = dev_net_rcu(dev);
	tbl = net->neigh_tables[index];
	if (!tbl) { ... }
	...
	neigh = __neigh_create(tbl, addr, dev, false);

which goes on to take spin_lock_bh(&tbl->lock), rcu_dereference(tbl->nht) and
touch the per-cpu tbl->stats. Before this patch the pointer referred to the
static arp_tbl/nd_tbl, so a stale read was harmless; now it is freed memory.

Some drivers also cache the pointer in their own state across work items, for
instance mlxsw_sp_nexthop4_init() in
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:

	nh->neigh_tbl = arp_table(net);

I was not able to construct a concrete racing reader: cleanup_net() runs
synchronize_rcu_expedited() and unregisters all netdevs before the subsys
exit ops, and the netlink and /proc readers hold a netns reference. But the
preceding patch, "neighbour: Remove __rcu from neigh_tables[]", justified
dropping the RCU annotation with "neigh_table cannot be registered
dynamically", which no longer holds once the slots are published and freed at
runtime.

Would an RCU-annotated store plus kfree_rcu() of the table remove the
dependence on that ordering?

>
>  static struct neigh_table *neigh_find_table(struct net *net, int family)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902203722.926528-1-kuniyu%40google.com
