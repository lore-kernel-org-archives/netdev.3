Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F933F5A9
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146797; cv=none; b=GrMfAP7Z5E7Cj0DfV5z3KJPXzK7AglHkoNlMrDNhMtoR4Q22y8n3ceLzCKZehugdMhImF+PGzyDERBey2RZt+8ayvcD94RbAUn+W6ves0iC4O2YQk/CaU8RlBOxYZb+PMemILWbtkRlFfQhmXQ/aWpnJLJaFmobpoEQKzPAvMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146797; c=relaxed/simple;
	bh=G6WMmvNBQJKLqE+l7pWsN0Q7fo+Sq2RvtlY2C9SANnQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCqBcdQruBV6XklhCzgNF4AJsDDKIRufEhVKdWyG/SVOnu7rBT/CQ3EMphlkyUJPsL/vDveu4HBtq7nzHWtN1JBYosxAHA1GP6MAPoWpIyYCJPR8/jZqSDNMoyPs8D5Qcns7VqIE2hP6vkKRQmG+7TbBYkk/XS86PSzjU84hzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh3aAe3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh3aAe3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB87E1F00893;
	Fri, 11 Sep 2026 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146796;
	bh=+/Y1vhtrRWmmzBNn9QMZFRJ/eb2RySk5VRrzrxK2isM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kh3aAe3wwYPnBLmnUhg5uhs5v/VmXU93FvesvsWSgHqm1PsMehXGXq5wJTYOMENew
	 gaecQvd9Wzh5msSInPJeZKm2b3hWWErTYfPShsrkM8QQRfCRRhGn8xHSUQ3rOl+m2L
	 zpbD6oRoPgln5uhF21cOTZwLvT80Dm2HjaFrfhzTpy3K1ZvsFCy+G3l5nhJpLjsfbZ
	 cm5fKtuJtirAjOsMoW0wONIw1r5I55dypVi5EDegq6YMp1ewjQ6h7Ub/gbgkC/OUOt
	 x6eKWj3A6L44fPlRtIJDyDl/Uws+CCCKs0GrRV7oDuso0Rp3VSQ/a3os6p5I0Dl9JY
	 OiO6duoyvJz9g==
Subject:
 Re: [PATCH net-next v9 2/7] net_sched: sch_fq: check device pacing offload
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 11 Sep 2026 17:13:15 +0000
Message-ID: <178914679525.219967.9347882764408033378@kernel.org>
In-Reply-To: <20260910171131.2532487-3-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-3-willemdebruijn.kernel@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 2

- [Medium] New, undocumented netlink rejection in fq_change(): `tc qdisc
  {add,replace,change} ... fq offload_horizon N` with N != 0 now returns…
- [Medium] Configured vs. effective offload horizon are now inconsistent
  across the three FQ interfaces.
- [Low] The patch introduces a per-packet TX fast-path read of
  `dev->max_pacing_offload_horizon` (fq_offload_horizon(),…
- [Low] fq_offload_horizon() reads `dev->pacing_offload` as a plain,
  unannotated load from the qdisc data path (net/sched/sch_fq.c:315,…

--

net_sched: sch_fq: check device pacing offload

FQ now consults the device's pacing offload state before applying the
configured offload horizon, via a new fq_offload_horizon() helper that is
evaluated once per packet in fq_classify() and fq_dequeue().  The helper
returns 0 when the device flag is clear or when the configured horizon
exceeds the device maximum, and fq_change() gains a new rejection when a
non-zero horizon is requested on a device with pacing offload disabled.

A few questions below.

> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 35f940b2205df..dfc7f98b600f8 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -301,6 +301,26 @@ static void fq_gc(struct fq_sched_data *q,
>  	q->stat_gc_flows += fcnt;
>  }
>  
> +static u64 fq_offload_horizon(const struct Qdisc *sch,
> +			      const struct fq_sched_data *q)
> +{
> +	const struct net_device *dev;
> +	u64 offload_horizon;
> +
> +	offload_horizon = READ_ONCE(q->offload_horizon);
> +	if (!offload_horizon)
> +		return 0;
> +
> +	dev = qdisc_dev(sch);
> +	if (!dev->pacing_offload)
> +		return 0;

[Severity: Low]
Is this read of dev->pacing_offload racy?

The two neighbouring loads in this same helper use READ_ONCE(), but
pacing_offload is read plainly here.  It is a 1-bit bitfield inside
struct_group(priv_flags_fast) in struct net_device, and the sibling
rtnetlink change makes it runtime-writable:

net/core/rtnetlink.c:do_setlink() {
	if (tb[IFLA_PACING_OFFLOAD]) {
		bool val = nla_get_u32(tb[IFLA_PACING_OFFLOAD]);

		if (dev->pacing_offload != val) {
			dev->pacing_offload = val;
	...
}

The writer holds only RTNL, while this reader runs from fq_classify() and
fq_dequeue() under the qdisc root lock, so the two sides share no lock and
both accesses are plain.  Would KCSAN flag this?

Because it is a bitfield, READ_ONCE()/WRITE_ONCE() cannot be applied to it.
Would a dedicated non-bitfield member (or bitops on a separate unsigned
long), or at minimum data_race() on this read, be preferable?

Separately, storing a single bit is a read-modify-write of the whole
declared unsigned long storage unit, which also holds priv_flags:32,
lltx:1 and netmem_tx:2 - fields read locklessly on the TX path.  Which
lock is intended to serialize RMWs of that word now that one of its bits
changes at runtime?  I did not find a non-RTNL writer of the neighbouring
bits, so this part is speculative.

> +
> +	if (offload_horizon > READ_ONCE(dev->max_pacing_offload_horizon))
> +		return 0;
> +
> +	return offload_horizon;
> +}
> +

[Severity: Low]
Should Documentation/networking/net_cachelines/net_device.rst be updated
here?

This adds a per-packet TX read of dev->max_pacing_offload_horizon, but the
row for that field in net_device.rst still has empty fastpath_tx_access and
Comments columns.  The companion bit added by the preceding patch in the
series was annotated:

  unsigned_long:1        pacing_offload    read_mostly    ...    sch_fq

struct net_device also carries a comment asking for the document to be kept
in sync ("Please update the document when adding new fields").

max_pacing_offload_horizon still lives in the cold region of struct
net_device next to irq_moder/napi_config, outside the net_device_read_tx
cacheline group, so for qdiscs that configured an offload horizon the TX
path now touches an extra otherwise-cold cache line per enqueue and per
dequeue.  Was that placement considered?

>  /* Fast path can be used if :
>   * 1) Packet tstamp is in the past, or within the pacing offload horizon.
>   * 2) FQ qlen == 0   OR

[ ... ]

> @@ -357,6 +377,7 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
>  				   u64 now)
>  {
>  	struct fq_sched_data *q = qdisc_priv(sch);
> +	u64 offload_horizon = fq_offload_horizon(sch, q);
>  	struct rb_node **p, *parent;
>  	struct sock *sk = skb->sk;
>  	struct rb_root *root;

[ ... ]

> @@ -705,6 +728,7 @@ static struct fq_flow_head *fq_pband_head_select(struct fq_perband_flows *pband)
>  static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>  {
>  	struct fq_sched_data *q = qdisc_priv(sch);
> +	u64 offload_horizon = fq_offload_horizon(sch, q);
>  	struct fq_perband_flows *pband;
>  	struct fq_flow_head *head;
>  	struct sk_buff *skb;

[ ... ]

> @@ -1179,11 +1204,15 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
>  		u64 offload_horizon = (u64)NSEC_PER_USEC *
>  				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
>  
> -		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
> -			WRITE_ONCE(q->offload_horizon, offload_horizon);
> -		} else {
> +		if (offload_horizon && !qdisc_dev(sch)->pacing_offload) {
> +			NL_SET_ERR_MSG_MOD(extack, "device pacing offload is disabled");
> +			err = -EINVAL;

[Severity: Medium]
Is this new configuration-time rejection intended, and should the commit
message mention it?

The changelog only describes runtime behaviour:

    In FQ, only offload if the feature is enabled and within the supported
    device horizon.

but this hunk also makes

  tc qdisc replace dev X root fq offload_horizon 500us

return -EINVAL whenever qdisc_dev(sch)->pacing_offload is 0.  Before the
patch the only gate was offload_horizon <= max_pacing_offload_horizon.
Since the only setter of that bit is do_setlink() via IFLA_PACING_OFFLOAD,
does this create an ordering dependency where the link attribute must be
enabled before the qdisc can be configured?

The new fq_offload_horizon() already degrades to 0 when the device flag is
clear, so the datapath is safe without the hard rejection:

	dev = qdisc_dev(sch);
	if (!dev->pacing_offload)
		return 0;

Would accepting the value (and letting it stay inert until the device flag
is enabled) be preferable to failing the command?

> +		} else if (offload_horizon >
> +			   qdisc_dev(sch)->max_pacing_offload_horizon) {
>  			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
>  			err = -EINVAL;
> +		} else {
> +			WRITE_ONCE(q->offload_horizon, offload_horizon);
>  		}
>  	}
>  	if (!err) {

[Severity: Medium]
Does this make the value reported by fq_dump() inaccurate and no longer
re-appliable?

fq_dump() is untouched and still reports the raw stored value:

	offload_horizon = READ_ONCE(q->offload_horizon);
	do_div(offload_horizon, NSEC_PER_USEC);
	...
	    nla_put_u32(skb, TCA_FQ_OFFLOAD_HORIZON, (u32)offload_horizon) ||

Consider:

  ip link set dev X pacing_offload on
  tc qdisc replace dev X root fq offload_horizon 500us   /* stored */
  ip link set dev X pacing_offload off                   /* do_setlink() */

Nothing clears q->offload_horizon, so fq_offload_horizon() returns 0 and
the datapath does pure software pacing while tc qdisc show still prints
offload_horizon 500us.  Replaying that same dump then hits the new -EINVAL
above, where it previously succeeded.

The same silent divergence appears when a device lowers
max_pacing_offload_horizon on re-init, for example
idpf_vport_set_pacing_offload() doing
WRITE_ONCE(netdev->max_pacing_offload_horizon, max_horizon) with
max_horizon possibly 0 - the "device renegotiation" case named in the
changelog.

The uAPI comment also still promises unconditional behaviour:

include/uapi/linux/pkt_sched.h:
	TCA_FQ_OFFLOAD_HORIZON,	/* dequeue packets in the past, if within horizon */

Should fq_dump() report the effective horizon, or should the comment note
the dependency on device administrative state?

One smaller inconsistency: fq_offload_horizon() uses READ_ONCE() for
dev->max_pacing_offload_horizon while fq_change() reads the same field, and
pacing_offload, plainly.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910171131.2532487-1-willemdebruijn.kernel%40gmail.com
