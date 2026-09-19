Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141D1C860C;
	Sat, 19 Sep 2026 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777293; cv=none; b=PLjbBB+98dyqlBDSOWDEU1fd3NfeZZS+usOCz00LZSTDb/SmQkoUax3owOu7mqgq/aAHPOhekQR9jY1VQ2y1BO3Xn5hfrXnpWKI7Mxi0+N49oC3r8/VggGcGkrDY1yJS121h8Zkn50VsIQg0PTGoKUDVrTMGMab6WYFlc0tsK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777293; c=relaxed/simple;
	bh=MQEfs04hRaK1NzMz3CCI4DatpZPUwFDU/m8wxabrcdo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YDoXd/YJ45znpffX5GZkmYf1GNgPfrUvqaXDl7LUUpTrGg1rOkF/+TTziYTkAxPsB2wvHkK/WjyH8YcgbyvBV0u4DSRSSDZkB2ZpMhOumes5Kib1Sk+2bQbkdGQNfuxTXoWBtN0Pwo8Zy+2MvUYPMg8LA2wA3bceDUpvS7VZZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krY7Ouea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krY7Ouea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810591F000FF;
	Sat, 19 Sep 2026 00:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777291;
	bh=bQJaERFgjFbRajdnj2cLfLCkl2HkW+wlL1jXnhtCrFM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=krY7Ouea0OQ7yWcW/33gbC0LT3s1yiT13jkdOQ+3CZx3VRIYJgCKkC1WcO5gdH9r5
	 x73+B5tBtAJstsGWOjT0n661DZ0L1IlwRSVNE7DG6bACtXentLoeze9v+Vj/udKlEJ
	 3hHld66183GRWzYUQh+v7MTFZXwT7WP8/X/UQuRzp+3+vtmhSl2P0fs48H64XlMX51
	 EYbjGnOpQl6j4cp1cFWE07dRP5OcZTNJIFVjfHOSmPlGIy6qt3vOFc1nRa5t8RX/rT
	 wGTag9/DqOD1uYPcc7w8AeMMDk0/20xGvNuU5qfQz7fJqzlTccbnfhyZQ1n1p2SYSb
	 5fGMQ9W+w+YpA==
Subject: Re: [PATCH net-next v2 1/5] vxlan: vnifilter: reject VNIs outside the
 24-bit space
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, razor@blackwall.org,
 roopa@nvidia.com, linux-kernel@vger.kernel.org
Date: Sat, 19 Sep 2026 00:21:30 +0000
Message-ID: <178977729000.22033.11804607706102932436@kernel.org>
In-Reply-To: <20260916193449.2552039-2-alishmery18@gmail.com>
References: <20260916193449.2552039-2-alishmery18@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

- [Medium] Missing `Fixes:` tag.
- [Medium] Commit message inaccuracy: the message claims the offending
  request "is then rejected during netlink policy validation, before…

Pre-existing issues:
- [Medium] Residual per-request allocation storm under rtnl_lock after
  this patch alone: the new policy caps START/END at VXLAN_N_VID-1,…

--

vxlan: vnifilter: reject VNIs outside the 24-bit space

The patch adds a netlink_range_validation bound of VXLAN_N_VID - 1 to the
VXLAN_VNIFILTER_ENTRY_START and VXLAN_VNIFILTER_ENTRY_END attributes in
vni_filter_entry_policy, and changes the vxlan_vni_add_del() loop counter
from int to u32.

v1: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/

A few questions on the commit message and on the remaining behaviour of
the loop.

> Assisted-by: LLM
> Signed-off-by: Ali Firas <alishmery18@gmail.com>

[Severity: Medium]
Should this carry a Fixes: tag?  The bug being closed is reachable from a
plain RTM_NEWTUNNEL/RTM_DELTUNNEL message and makes vxlan_vni_add_del()
walk most of the 32-bit space allocating a struct vxlan_vni_node plus a
per-CPU stats block per iteration under rtnl_lock, so stable trees would
want it.

Both the "int v" loop and the unbounded NLA_U32 START/END policy arrived
with the file itself:

  Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")

Without that tag, backport tooling has nothing to key off.

> Range-validate both attributes against the 24-bit VNI space, which is
> what vxlan_mdb.c already does for its own VNI attributes. The request is
> then rejected during netlink policy validation, before
> vxlan_process_vni_filter() is reached, and nothing is allocated.

[Severity: Medium]
Is "before vxlan_process_vni_filter() is reached, and nothing is
allocated" accurate for a multi-entry message?

The new range bound is only enforced by the nla_parse_nested() call
inside vxlan_process_vni_filter():

drivers/net/vxlan/vxlan_vnifilter.c:vxlan_process_vni_filter() {
	err = nla_parse_nested(vattrs,
			       VXLAN_VNIFILTER_ENTRY_MAX,
			       nlvnifilter, vni_filter_entry_policy,
			       extack);
	...
}

The top-level nlmsg_parse() in vxlan_vnifilter_process() uses
vni_filter_policy, where the nest has no nested_policy pointer, and
lib/nlattr.c only recurses when pt->nested_policy is set:

static const struct nla_policy vni_filter_policy[VXLAN_VNIFILTER_MAX + 1] = {
	[VXLAN_VNIFILTER_ENTRY] = { .type = NLA_NESTED },
};

So for a message like [ENTRY: START=1 END=100][ENTRY: START=0xffffffff],
does the first entry get fully applied (100 vxlan_vni_node plus per-CPU
stats allocations, rhashtable inserts and RTM_NEWTUNNEL notifications)
before the second one returns -ERANGE, with vxlan_vnifilter_process()
merely breaking out of nlmsg_for_each_attr_type() and leaving that state
installed?

"Nothing is allocated" appears to hold only for a single-entry request.

Noting for the series: the later patch "vxlan: vnifilter: bound the number
of VNIs one request may touch" adds vxlan_vnifilter_check_msg(), which
parses every entry against vni_filter_entry_policy before the dispatch
loop, so the partial-application behaviour is gone by the end of the
series.  The wording in this patch's own message, and therefore in a
standalone stable backport of just this patch, still describes something
else.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index dd94085e08865..5aaaaeee81107 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -459,9 +459,15 @@ static int vxlan_vnifilter_dump(struct sk_buff *skb, struct netlink_callback *cb
>  	return err;
>  }
>  
> +static const struct netlink_range_validation vni_filter_vni_range = {
> +	.max = VXLAN_N_VID - 1,
> +};
> +
>  static const struct nla_policy vni_filter_entry_policy[VXLAN_VNIFILTER_ENTRY_MAX + 1] = {
> -	[VXLAN_VNIFILTER_ENTRY_START] = { .type = NLA_U32 },
> -	[VXLAN_VNIFILTER_ENTRY_END] = { .type = NLA_U32 },
> +	[VXLAN_VNIFILTER_ENTRY_START] = NLA_POLICY_FULL_RANGE(NLA_U32,
> +							      &vni_filter_vni_range),
> +	[VXLAN_VNIFILTER_ENTRY_END] = NLA_POLICY_FULL_RANGE(NLA_U32,
> +							    &vni_filter_vni_range),

[Severity: Medium]
This isn't a bug introduced by this patch, but the per-request allocation
behaviour described in the commit message survives it in a narrower form,
since the policy bounds each endpoint and not the distance between them.

vxlan_process_vni_filter() leaves vni_start at 0 when only END is
present:

	if (vattrs[VXLAN_VNIFILTER_ENTRY_START]) {
		vni_start = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_START]);
		vni_end = vni_start;
	}

	if (vattrs[VXLAN_VNIFILTER_ENTRY_END])
		vni_end = nla_get_u32(vattrs[VXLAN_VNIFILTER_ENTRY_END]);

So a single entry carrying only END=0xffffff passes the new policy and
still drives roughly 2^24 iterations of vxlan_vni_add_del() ->
vxlan_vni_add() -> vxlan_vni_alloc(), each doing a GFP_KERNEL
kzalloc_obj() of struct vxlan_vni_node plus netdev_alloc_pcpu_stats() over
nr_cpu_ids, an rhashtable insert and an RTM_NEWTUNNEL notification skb.

There is no cond_resched() and no fatal-signal check in that loop, and the
handlers are registered without RTNL_FLAG_DOIT_UNLOCKED, so rtnl_lock is
held throughout.  Is that span still intended to be unbounded here?

Also, when an allocation fails part way through the range the loop takes
the goto out path and the nodes already inserted into vg->vni_hash and
vg->vni_list stay behind.  That predates this patch as well.

The follow-on patch "vxlan: vnifilter: bound the number of VNIs one
request may touch" caps the summed span at VXLAN_VNI_FILTER_MSG_MAX before
the dispatch loop, and the memcg accounting patches later in the series
change both allocations to GFP_KERNEL_ACCOUNT, so this is addressed within
the series.

>  	[VXLAN_VNIFILTER_ENTRY_GROUP]	= NLA_POLICY_EXACT_LEN(sizeof_field(struct iphdr, daddr)),
>  	[VXLAN_VNIFILTER_ENTRY_GROUP6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>  };
> @@ -814,7 +820,8 @@ static int vxlan_vni_add_del(struct vxlan_dev *vxlan, __u32 start_vni,
>  			     int cmd, struct netlink_ext_ack *extack)
>  {
>  	struct vxlan_vni_group *vg;
> -	int v, err = 0;
> +	int err = 0;
> +	u32 v;
>  
>  	vg = rtnl_dereference(vxlan->vnigrp);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916193449.2552039-1-alishmery18%40gmail.com
