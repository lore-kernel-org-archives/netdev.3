Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3A7470126;
	Wed,  9 Sep 2026 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957557; cv=none; b=cQrMcCd97S0+5SfGsFwqQa2+Omjn3R1C191pwc9aZe7AaaCyNxzcXGUH5w4FyVLGjfEumnxzXU4WcNJ6VRzl5/D3zS7DxtsEpoIV3zvZwVfb3gw6AZjgqA7VqwpoU26XH6S0l/3+wjf1UVM5fOJRT/AiMoZ05KSUMi/gaaHD2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957557; c=relaxed/simple;
	bh=uYj6ej5PCBSHg2bRY7ej7atI8oNG+QWbxxknZ5hwxag=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sPggJJq40IGyuiE8tEvyadD7BLm4d0cMtIUNNml9L+sIripFpfJrRi+yIW2DN3xCngbLqxGGhxsSyJVDgxAXeCmU2Qg8XsjWWA+OxahoK3/WMkGTSEEim0q2RVIV/7ZTwfa4kfkyfwF6aHfXA6DfcK5APkRVOGY51KfJTTLhGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC9eqfsZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC9eqfsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2CE1F00A3A;
	Wed,  9 Sep 2026 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957555;
	bh=Em3hrMz7az8HDcufhQiRa3PV0ozCCHRcFtxVaNVposQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eC9eqfsZLUnN0anxs4swUIhdgUgveRQ7xcAhMJHLGC/PkwSeAJzSL0MGjLwubgUvW
	 Sw6tJ7SKCkEGVkGpVVOnrhkfAhoPX+nib+aOfU2joDs9q749NZc5JASOEBhy5iDRpQ
	 3mgzSRatFk7ieqhISzrQwsk+eXxL/W22tAYKicyN3IfIo9i0+0zhASSs2TMgcCvQsX
	 MA0TTikOx/kkQ1ne1cXVHVCSyTaCpwB8itjR2pDpLLUMXUKtqBCPVTCCPsLuNgSZPs
	 9lDT8pjhQbHvSIC5EzPoilUoo0zT2FLVW2hlHuJMkRqovwTJu7ocUOTaAQx5HgRLex
	 ks10bcbwB186w==
Subject: Re: [PATCH net] net/sched: cls_u32: take a reference on the hash
 table in u32_change()
From: netdev-bot+sashiko@kernel.org
To: norbert@doyensec.com
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 12:39:14 +0000
Message-ID: <178895755454.219967.8093907569129807456@kernel.org>
In-Reply-To: <79DB27AC-0FC0-42B2-A795-A8B585B73CFB@doyensec.com>
References: <79DB27AC-0FC0-42B2-A795-A8B585B73CFB@doyensec.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] The new pin in u32_change() (refcount_inc(&ht->refcnt) /
  refcount_dec(&ht->refcnt) around u32_set_parms()) assumes every drop…
- [Medium] Commit message understates the reachability of the bug being
  fixed.

--

net/sched: cls_u32: take a reference on the hash table in u32_change()

u32_change() holds the target tc_u_hnode in a local variable while
u32_set_parms() may drop rtnl to load an action module, so a concurrent
RTM_DELTFILTER can free it.  The patch pins the hnode with
refcount_inc()/refcount_dec() around the u32_set_parms() call.

Two questions below, one on the changelog and one on the new pin itself.

>     u32_change() keeps the target hash table in a local variable without
>     taking a reference. u32_set_parms() may then drop rtnl to load an action
>     module, and on a failed load returns without asking the caller to
>     replay (-ENOENT). A concurrent RTM_DELTFILTER can free the table in
>     that window, and u32_change() then removes the node id it reserved from
>     the freed table.

[Severity: Medium]
Is the race really limited to the "failed load" case?  tc_action_load_ops()
in net/sched/act_api.c drops rtnl in both outcomes:

net/sched/act_api.c:tc_action_load_ops() {
	...
		rtnl_unlock();
		request_module("act_%s", act_name);
		rtnl_lock();
	...
		if (a_o != NULL) {
			module_put(a_o->owner);
			return ERR_PTR(-EAGAIN);
		}
	#endif
		NL_SET_ERR_MSG(extack, "Failed to load TC action module");
		return ERR_PTR(-ENOENT);
}

In u32_change() any non-zero err from u32_set_parms() skips the
if (err == 0) block and falls through errunbind -> errout -> erridr, where
idr_remove(&ht->handle_idr, handle) dereferences ht.  So the -EAGAIN path
(module present and loaded successfully, request replayed afterwards) also
touches ht after rtnl was dropped, and that is the common case on a normal
system.

Would it be worth describing the window as "u32_set_parms() may drop rtnl"
without tying it to -ENOENT, so backport triage sees the wider trigger?

> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index a3e65c8cf29ef..0e9128f2f33e8 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -1180,8 +1180,11 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
>  	}
>  #endif
>  
> +	/* u32_set_parms() may drop rtnl; keep ht alive across it */
> +	refcount_inc(&ht->refcnt);
>  	err = u32_set_parms(net, tp, n, tb, tca[TCA_RATE],
>  			    flags, n->flags, extack);
> +	refcount_dec(&ht->refcnt);

[Severity: High]
Does this pin hold when the hnode being pinned belongs to a different
tcf_proto?

The changelog states that a racing deletion "fails its
refcount_dec_if_one() and returns -EBUSY", which is true for u32_delete()
of a non-root hnode.  But u32_destroy() drops the root hnode reference
unconditionally:

net/sched/cls_u32.c:u32_destroy() {
	if (root_ht && refcount_dec_and_test(&root_ht->refcnt))
		u32_destroy_hnode(tp, root_ht, extack);
	...
}

tc_u_common is shared by all cls_u32 tcf_protos on the same qdisc/block,
and u32_change() resolves TCA_U32_HASH through the shared list without any
is_root or owner check:

net/sched/cls_u32.c:u32_change() {
	...
		ht = u32_lookup_ht(tp->data, TC_U32_HTID(htid));
		if (!ht) {
			NL_SET_ERR_MSG_MOD(extack, "Specified hash table not found");
			return -EINVAL;
		}
	...
}

net/sched/cls_u32.c:u32_lookup_ht() {
	for (ht = rtnl_dereference(tp_c->hlist);
	     ht;
	     ht = rtnl_dereference(ht->next))
		if (ht->handle == handle)
			break;
	...
}

So a filter added at prio 2 with "ht 800:" can pin prio 1's root hnode.
If prio 1 is deleted in the rtnl-dropped window (RTM_DELTFILTER with
tcm_handle == 0 -> tcf_chain_tp_remove() + tcf_proto_put() ->
tcf_proto_destroy() -> u32_destroy()), the sequence looks like:

	u32_change()	refcount_inc()			refcnt 1 -> 2
	u32_destroy()	refcount_dec_and_test() false	refcnt 2 -> 1
	u32_change()	refcount_dec()			refcnt 1 -> 0

Two things follow.  First, u32_destroy_hnode() is skipped, so the hnode
stays linked in tp_c->hlist with no owner and u32_clear_hnode(),
u32_clear_hw_hnode(), idr_remove(&tp_c->handle_idr, ...), idr_destroy()
and kfree_rcu() never run.

Second, the trailing refcount_dec() takes the count 1 -> 0:

include/linux/refcount.h:__refcount_dec() {
	int old = atomic_fetch_sub_release(1, &r->refs);
	...
	if (unlikely(old <= 1))
		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
}

That warns and sets REFCOUNT_SATURATED without freeing anything, and once
saturated no later refcount_dec_and_test() in u32_destroy() can reach zero:

net/sched/cls_u32.c:u32_destroy() {
	...
			if (refcount_dec_and_test(&ht->refcnt))
				kfree_rcu(ht, rcu);
	...
}

Can this leak the hnode (plus its idr and any knodes later inserted into
it) for the lifetime of the block, and splat under panic_on_warn?  Would
handling the "we dropped the last reference" case, or re-looking up ht
after u32_set_parms() instead of carrying a borrowed pointer, avoid this?

As a smaller note on the same two lines: the reference is released before
the remaining ht dereferences it is meant to cover, namely
idr_remove(&ht->handle_idr, handle) at erridr and the
&ht->ht[TC_U32_HASH(handle)] insertion, so it relies on u32_set_parms()
always having re-acquired rtnl by the time it returns.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/79DB27AC-0FC0-42B2-A795-A8B585B73CFB%40doyensec.com
