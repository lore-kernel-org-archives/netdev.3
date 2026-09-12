Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A8155757
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173197; cv=none; b=dhQ8RhVpt1DA18ZWLYCQTfwHrKGOFu7n3Usta32ty7CMNsWbLadT85rJ3Aj77glOubFq9Aa28A0OR2H2NlAGwRN6EW559YzS7WfLChp9c/dWPT762vJQ0jXbUlaROZdQ6ntWF4AqSN3NN/SPlnY/3fVQyl7c3de8bpS1Rz3XkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173197; c=relaxed/simple;
	bh=DZa/b424onuQVIbrTsp1pjQMeSp2fRQZq54Omh8BsjM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NqSWspVF835jK8wpQOIOD5IRowgqHakwfq+Lb8oaDyfQixLAH7wLudgWAVtcWBhivhKv6PSlxtQSHVnW3QbXFFSqI2Oh2aFQU0dVgHDtrOjmZas5QeTvbETiihf41V2gP1oz7Jh5+EHw0+cOWNOK/2kGZzJI0TQs8r8peIdMrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL39VzqI; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL39VzqI"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-8659af7454eso1268647b3.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789173194; x=1789777994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=anowyQwhyqw67BPN3qj90ejI3+8sv+wxw9pYdpv+uj8=;
        b=IL39VzqIcMv5nv2plzFFzJZyXqHfSR6qoc7SyEyX9tQHgjsF5KQtVDsgDvTgWZO8H2
         bRDEQfoyj+P4WELsnUhnclE5l9faSYWy3NMoLQv7xq8hO76RZgLNyilWAfZ0JVP9BAqK
         T6dQ01IU4KafKfyhYkTYhz0zNyiHJeAjj0R5VZQ69Vm9+3qnw9OyVGE6rta9+C1rwX+k
         mSUWt5hAp7d01zXEJTTjx/uLDdCBwfxD7YeHFZBWU5rXdqzGDEL4g1J7hijcNAXlw4FO
         AwS3ytjH8Py4FbxzC8G43/uX+vYj/nQuEfdEIC9hJNmxU5gihGgGQftyNBjTRuBqb24g
         g6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789173194; x=1789777994;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anowyQwhyqw67BPN3qj90ejI3+8sv+wxw9pYdpv+uj8=;
        b=H1/2gVgGZC4vL0Yk7/5S2zA5emyM+7shZIOhU/yyugiPLu1znDjkboZWx0Kh6NBxeC
         iu5WU1RORKdDfCBH50/iyhSKQT/dWXLpk4r8VF4GtJ2WJWqWtTZpvlr5XV7gnm+7wank
         YNAzpfWGD7KhCLuwV4aiBsUUnYKJDV4X82b6l5kidB/2J4qtIe0IrELjD4kYIN75ULQ/
         PFIX1uuFQPv4wHq2SetC1abv2quXMJSHIvH+y7JEOLVhm2VOuiD5+/+9Re2xv82aOWyg
         7yLx3Skh7EJSA9RwBwLPbXI0t5o33DWcuqi0vu9hYHl+M32fvgJ4W2SBs80A2JpFGceD
         SlhA==
X-Gm-Message-State: AFuF++lSO0xGncxaQRDXkqwo/a0s35CXjDKxTw6L40OYRxtW5b4Sqy8q
	HukbcXCrcRyVa5XjI7ondTUaCRYa1IXH9de+yc6GNbeglXm/bhVVU2Xh
X-Gm-Gg: AYBFou06oJ8EuvACT7dRnlDY7ziKuT47xu+EIcnozqEE7Yhx0ot2P0LDG7WxQHhxOlG
	/TrUxofHwUQsKozUDfQWkROamaoP88R8g0QH7VuNBuxMsBGS6fM7vAhkXg/3wkfm6nUbq//RKtx
	sXrXvjenFAstKi3qV4D5w+WfiQs7GYmXMt40fLbWi3G3BqpN0osjgW0zeAR694XQjc1hzOmmWym
	JvPSCFCrmwkpU6cj270ZKhx/5JXWM1dftG26eIlnZWo4SnXY9rnYPs9d1joV0LrioNE4lK/414R
	2S0GYqVNKBHorxc2STXoWpRKdzd8s5bLr2bbYheBSknr9fPSlZvlWjnZq7WpPd/3cozwHoBMRko
	I/uTpolbIazw+vZyIlPCiem+FsxR4Bh+mA/KU99LPfG34a8UIEoS2KqNONQH15PPe3WI3Zuu/3D
	/mSfo2fcM0lBvg6fqlzq2sKmuvY/fcn56UyiwKtpt+rdGw84suhMpDk42Lp7bTuSeENBlVdrHzE
	G0NFhKFIBJ4uxbEmNsLcc3P7toLFr/VnRDwxdjswDe8CYHCUR5C
X-Received: by 2002:a05:690c:309:b0:80b:de9c:8a2c with SMTP id 00721157ae682-887a8d99ba6mr2835927b3.8.1789173194350;
        Fri, 11 Sep 2026 17:33:14 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88488c3ab26sm16995557b3.40.2026.09.11.17.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:33:13 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:33:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.1f5d02e9eaca2@gmail.com>
In-Reply-To: <178914679525.219967.9347882764408033378@kernel.org>
References: <20260910171131.2532487-3-willemdebruijn.kernel@gmail.com>
 <178914679525.219967.9347882764408033378@kernel.org>
Subject: Re: [PATCH net-next v9 2/7] net_sched: sch_fq: check device pacing
 offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 2
> =

> - [Medium] New, undocumented netlink rejection in fq_change(): `tc qdis=
c
>   {add,replace,change} ... fq offload_horizon N` with N !=3D 0 now retu=
rns=E2=80=A6
> - [Medium] Configured vs. effective offload horizon are now inconsisten=
t
>   across the three FQ interfaces.
> - [Low] The patch introduces a per-packet TX fast-path read of
>   `dev->max_pacing_offload_horizon` (fq_offload_horizon(),=E2=80=A6
> - [Low] fq_offload_horizon() reads `dev->pacing_offload` as a plain,
>   unannotated load from the qdisc data path (net/sched/sch_fq.c:315,=E2=
=80=A6
> =

> --
> =

> net_sched: sch_fq: check device pacing offload
> =

> FQ now consults the device's pacing offload state before applying the
> configured offload horizon, via a new fq_offload_horizon() helper that =
is
> evaluated once per packet in fq_classify() and fq_dequeue().  The helpe=
r
> returns 0 when the device flag is clear or when the configured horizon
> exceeds the device maximum, and fq_change() gains a new rejection when =
a
> non-zero horizon is requested on a device with pacing offload disabled.=

> =

> A few questions below.
> =

> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 35f940b2205df..dfc7f98b600f8 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -301,6 +301,26 @@ static void fq_gc(struct fq_sched_data *q,
> >  	q->stat_gc_flows +=3D fcnt;
> >  }
> >  =

> > +static u64 fq_offload_horizon(const struct Qdisc *sch,
> > +			      const struct fq_sched_data *q)
> > +{
> > +	const struct net_device *dev;
> > +	u64 offload_horizon;
> > +
> > +	offload_horizon =3D READ_ONCE(q->offload_horizon);
> > +	if (!offload_horizon)
> > +		return 0;
> > +
> > +	dev =3D qdisc_dev(sch);
> > +	if (!dev->pacing_offload)
> > +		return 0;
> =

> [Severity: Low]
> Is this read of dev->pacing_offload racy?
> =

> The two neighbouring loads in this same helper use READ_ONCE(), but
> pacing_offload is read plainly here.  It is a 1-bit bitfield inside
> struct_group(priv_flags_fast) in struct net_device, and the sibling
> rtnetlink change makes it runtime-writable:
> =

> net/core/rtnetlink.c:do_setlink() {
> 	if (tb[IFLA_PACING_OFFLOAD]) {
> 		bool val =3D nla_get_u32(tb[IFLA_PACING_OFFLOAD]);
> =

> 		if (dev->pacing_offload !=3D val) {
> 			dev->pacing_offload =3D val;
> 	...
> }
> =

> The writer holds only RTNL, while this reader runs from fq_classify() a=
nd
> fq_dequeue() under the qdisc root lock, so the two sides share no lock =
and
> both accesses are plain.  Would KCSAN flag this?
> =

> Because it is a bitfield, READ_ONCE()/WRITE_ONCE() cannot be applied to=
 it.

Since it is a bitfield, READ_ONCE/WRITE_ONCE cannot be applied, indeed.

> Would a dedicated non-bitfield member (or bitops on a separate unsigned=

> long), or at minimum data_race() on this read, be preferable?
> =

> Separately, storing a single bit is a read-modify-write of the whole
> declared unsigned long storage unit, which also holds priv_flags:32,
> lltx:1 and netmem_tx:2 - fields read locklessly on the TX path.  Which
> lock is intended to serialize RMWs of that word now that one of its bit=
s
> changes at runtime?  I did not find a non-RTNL writer of the neighbouri=
ng
> bits, so this part is speculative.
> =

> > +
> > +	if (offload_horizon > READ_ONCE(dev->max_pacing_offload_horizon))
> > +		return 0;
> > +
> > +	return offload_horizon;
> > +}
> > +
> =

> [Severity: Low]
> Should Documentation/networking/net_cachelines/net_device.rst be update=
d
> here?
> =

> This adds a per-packet TX read of dev->max_pacing_offload_horizon, but =
the
> row for that field in net_device.rst still has empty fastpath_tx_access=
 and
> Comments columns.  The companion bit added by the preceding patch in th=
e
> series was annotated:
> =

>   unsigned_long:1        pacing_offload    read_mostly    ...    sch_fq=


This is fair. Very minor, but will do if respinning.
 =

> struct net_device also carries a comment asking for the document to be =
kept
> in sync ("Please update the document when adding new fields").
> =

> max_pacing_offload_horizon still lives in the cold region of struct
> net_device next to irq_moder/napi_config, outside the net_device_read_t=
x
> cacheline group, so for qdiscs that configured an offload horizon the T=
X
> path now touches an extra otherwise-cold cache line per enqueue and per=

> dequeue.  Was that placement considered?
> =

> >  /* Fast path can be used if :
> >   * 1) Packet tstamp is in the past, or within the pacing offload hor=
izon.
> >   * 2) FQ qlen =3D=3D 0   OR
> =

> [ ... ]
> =

> > @@ -357,6 +377,7 @@ static struct fq_flow *fq_classify(struct Qdisc *=
sch, struct sk_buff *skb,
> >  				   u64 now)
> >  {
> >  	struct fq_sched_data *q =3D qdisc_priv(sch);
> > +	u64 offload_horizon =3D fq_offload_horizon(sch, q);
> >  	struct rb_node **p, *parent;
> >  	struct sock *sk =3D skb->sk;
> >  	struct rb_root *root;
> =

> [ ... ]
> =

> > @@ -705,6 +728,7 @@ static struct fq_flow_head *fq_pband_head_select(=
struct fq_perband_flows *pband)
> >  static struct sk_buff *fq_dequeue(struct Qdisc *sch)
> >  {
> >  	struct fq_sched_data *q =3D qdisc_priv(sch);
> > +	u64 offload_horizon =3D fq_offload_horizon(sch, q);
> >  	struct fq_perband_flows *pband;
> >  	struct fq_flow_head *head;
> >  	struct sk_buff *skb;
> =

> [ ... ]
> =

> > @@ -1179,11 +1204,15 @@ static int fq_change(struct Qdisc *sch, struc=
t nlattr *opt,
> >  		u64 offload_horizon =3D (u64)NSEC_PER_USEC *
> >  				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
> >  =

> > -		if (offload_horizon <=3D qdisc_dev(sch)->max_pacing_offload_horizo=
n) {
> > -			WRITE_ONCE(q->offload_horizon, offload_horizon);
> > -		} else {
> > +		if (offload_horizon && !qdisc_dev(sch)->pacing_offload) {
> > +			NL_SET_ERR_MSG_MOD(extack, "device pacing offload is disabled");
> > +			err =3D -EINVAL;
> =

> [Severity: Medium]
> Is this new configuration-time rejection intended, and should the commi=
t
> message mention it?

Yes, this block rejecting enabling of pacing offload in FQ if the
device does not support it is intentional.

If respinning I'll add the statement to the commit msg.

> The changelog only describes runtime behaviour:
> =

>     In FQ, only offload if the feature is enabled and within the suppor=
ted
>     device horizon.
> =

> but this hunk also makes
> =

>   tc qdisc replace dev X root fq offload_horizon 500us
> =

> return -EINVAL whenever qdisc_dev(sch)->pacing_offload is 0.  Before th=
e
> patch the only gate was offload_horizon <=3D max_pacing_offload_horizon=
.
> Since the only setter of that bit is do_setlink() via IFLA_PACING_OFFLO=
AD,
> does this create an ordering dependency where the link attribute must b=
e
> enabled before the qdisc can be configured?
> =

> The new fq_offload_horizon() already degrades to 0 when the device flag=
 is
> clear, so the datapath is safe without the hard rejection:
> =

> 	dev =3D qdisc_dev(sch);
> 	if (!dev->pacing_offload)
> 		return 0;
> =

> Would accepting the value (and letting it stay inert until the device f=
lag
> is enabled) be preferable to failing the command?
> =

> > +		} else if (offload_horizon >
> > +			   qdisc_dev(sch)->max_pacing_offload_horizon) {
> >  			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
> >  			err =3D -EINVAL;
> > +		} else {
> > +			WRITE_ONCE(q->offload_horizon, offload_horizon);
> >  		}
> >  	}
> >  	if (!err) {
> =

> [Severity: Medium]
> Does this make the value reported by fq_dump() inaccurate and no longer=

> re-appliable?
> =

> fq_dump() is untouched and still reports the raw stored value:
> =

> 	offload_horizon =3D READ_ONCE(q->offload_horizon);
> 	do_div(offload_horizon, NSEC_PER_USEC);
> 	...
> 	    nla_put_u32(skb, TCA_FQ_OFFLOAD_HORIZON, (u32)offload_horizon) ||
> =

> Consider:
> =

>   ip link set dev X pacing_offload on
>   tc qdisc replace dev X root fq offload_horizon 500us   /* stored */
>   ip link set dev X pacing_offload off                   /* do_setlink(=
) */

The choice is a conscious one to check all three conditions at runtime

1. q->offload_horizon is set
2. dev->pacing_offload is enabled
3. dev->max_pacing_offload >=3D q->pacing_offload

and keeping them independent variables that are not disabled
cascadingly at runtime.

As a result, fq_dump will indeed dump the state of the fq variable,
which !=3D whether offloading happens.

For that the user will also have to read the dev rt-link settings
and/or device counters.

I can make this explicit in the commit message.

> Nothing clears q->offload_horizon, so fq_offload_horizon() returns 0 an=
d
> the datapath does pure software pacing while tc qdisc show still prints=

> offload_horizon 500us.  Replaying that same dump then hits the new -EIN=
VAL
> above, where it previously succeeded.
> =

> The same silent divergence appears when a device lowers
> max_pacing_offload_horizon on re-init, for example
> idpf_vport_set_pacing_offload() doing
> WRITE_ONCE(netdev->max_pacing_offload_horizon, max_horizon) with
> max_horizon possibly 0 - the "device renegotiation" case named in the
> changelog.
> =

> The uAPI comment also still promises unconditional behaviour:
> =

> include/uapi/linux/pkt_sched.h:
> 	TCA_FQ_OFFLOAD_HORIZON,	/* dequeue packets in the past, if within hori=
zon */
> =

> Should fq_dump() report the effective horizon, or should the comment no=
te
> the dependency on device administrative state?
> =

> One smaller inconsistency: fq_offload_horizon() uses READ_ONCE() for
> dev->max_pacing_offload_horizon while fq_change() reads the same field,=
 and
> pacing_offload, plainly.

I will look at this
 =


