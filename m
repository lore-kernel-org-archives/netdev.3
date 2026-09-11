Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732937A827
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146796; cv=none; b=hulLZlZO6R1q3izB6h5DtamgGiQ4fIaWbK+K1v2JZp58nvQCK2hPSYTUAiAqRemj8rv6XqsEmQvXhl7IV1uhEKmRWZgSSdkLoGjoK1BZLFcJeTGfLtqi9i2X2/t4vXWhVOvvQXKRdb6UvZnfJResNEURarov2KjrKLNKbadkfVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146796; c=relaxed/simple;
	bh=my0hsYE8//1YF39GTIu70NX8+hmZ+O4hxbCBCqpMuXk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5o4PXiJAdE0WTti9CWX3k4D4oqC2bZkLAUgg9Xs4OvSgFckWs+dXUlsEKRCiPQfDTHD1weORfuqaorsmIoCO4/QWXcRBJ10PYeHIHvBY85JIyElWWucuO7Pk0dOLi0e3pd1+CIxlvFtj9DdEaTvBOPiYsuHgVybAt6ZZZoIAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccvB0z1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccvB0z1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881C91F000FF;
	Fri, 11 Sep 2026 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146795;
	bh=hTLrAFl4VygQLbuB2SNPhNOGsqjGYBa8jLFGm8VfMEU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ccvB0z1dnfXbsCZghxwsugRZZfs1WrfOpNCu8Vfcs7R1FIwk0sTBzEf7bzM6jI8rc
	 D9Q+sWLqkkOhwBtKXmVkvXaLA1tgNYYmt5YNkUxA3PTDYo0MFHckm/VoCxzdno9qWv
	 oU+BIiCG65Q1/sE5IloD+3cZ2llOVVk02wGlPXjDAMEnrPKxYnuPoCjryJKgffFMqJ
	 H3AvPj4w50FXfoUui27lwK2jvwQCVdB8musdhOlzrSs7dpTDVD5nfZya3czMVpXw1M
	 N1RQVKJlwiqSNOICOnz7VT7tqcNMwavgDU8PW3uzLKNxE2CdOzfuCjMeXTW3vLo13k
	 F1T9ylat8+KPg==
Subject: Re: [PATCH net-next v9 1/7] net: rtnetlink: add pacing_offload
 attribute to net_device
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 11 Sep 2026 17:13:14 +0000
Message-ID: <178914679401.219967.11906428098360110344@kernel.org>
In-Reply-To: <20260910171131.2532487-2-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-2-willemdebruijn.kernel@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

- [Medium] `pacing_offload:1` is added as the first *runtime-mutable* bit
  of the `struct_group(priv_flags_fast, ...)` bitfield word in struct…
- [Low] Concern (verified as NOT a defect): dev->pacing_offload /
  IFLA_PACING_OFFLOAD is claimed to have no in-tree consumer at this…

Pre-existing issues:
- [Low] Pre-existing YAML spec gap adjacent to the change: the shared
  getlink do/dump reply list (`&link-all-attrs`,…

--

net: rtnetlink: add pacing_offload attribute to net_device

This adds a new IFLA_PACING_OFFLOAD link attribute plus a matching
pacing_offload:1 bitfield in struct net_device, so pacing offload can be
turned on and off administratively.  It also marks
IFLA_MAX_PACING_OFFLOAD_HORIZON as NLA_REJECT and documents the new
attribute in the rt-link YAML spec.

A few questions below.

> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index 5217d0bb4a3a5..7a72cd1b7e1ee 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml
> @@ -1091,6 +1091,10 @@ attribute-sets:
>        -
>          name: tailroom
>          type: u16
> +      -
> +        name: pacing-offload
> +        type: u32
> +        doc: Enable EDT pacing offload (0 - disabled, 1 - enabled).
>    -
>      name: prop-list-link-attrs
>      subset-of: link-attrs
> @@ -2559,6 +2563,7 @@ operations:
>              - devlink-port
>              - gso-ipv4-max-size
>              - gro-ipv4-max-size
> +            - pacing-offload

[Severity: Low]
This isn't something introduced by this patch, but while the shared
getlink reply list (&link-all-attrs) is being extended here, should
max-pacing-offload-horizon be added as well?

rtnl_fill_ifinfo() emits it unconditionally in the same nla_put chain as
the new attribute:

	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
			 READ_ONCE(dev->max_pacing_offload_horizon)) ||

The same holds for netns-immutable, headroom and tailroom, which are also
always emitted but not listed in the reply set.

The commit message advertises reading the horizon with

    ynl --family rt-link --do getlink ... | grep pacing

which works, because the Python decoder resolves reply members from
attribute-set: link-attrs, but consumers generated from the per-operation
reply list would not see these members.

> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 512f6d6fa3d8f..8eceaa80b6860 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -11,6 +11,7 @@ Type                                Name                        fastpath_tx_acce
>  unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
>  unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
>  unsigned_long:2                     netmem_tx:2;                read_mostly
> +unsigned_long:1                     pacing_offload              read_mostly                             sch_fq
>  char                                name[16]
>  struct netdev_name_node*            name_node
>  struct dev_ifalias*                 ifalias
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 707b2e51c2b97..1f0710eef185b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h

[ ... ]

> @@ -2170,6 +2171,7 @@ struct net_device {
>  		unsigned long		priv_flags:32;
>  		unsigned long		lltx:1;
>  		unsigned long		netmem_tx:2;
> +		unsigned long		pacing_offload:1;
>  	);

[Severity: Medium]
This puts the first runtime-mutable bit into the priv_flags_fast group.  On
64-bit, priv_flags, lltx, netmem_tx and pacing_offload all live in one
unsigned long, and adjacent bitfields are a single memory location, so a
store to one of them is a read-modify-write of the others.

do_setlink() writes the new bit under RTNL only:

		if (dev->pacing_offload != val) {
			dev->pacing_offload = val;

but priv_flags in the same word is modified from softirq context with no
RTNL held, in net/ncsi/ncsi-rsp.c:

	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;

That appears in ncsi_rsp_handler_oem_bcm() and ncsi_rsp_handler_gmcma(),
both reached from ncsi_rcv_rsp(), which is a packet_type receive handler.

Can these two read-modify-writes lose each other's update, so that either
IFF_LIVE_ADDR_CHANGE is silently dropped, or pacing_offload reads back 0
after do_setlink() already set DO_SETLINK_MODIFIED and sent a notification?

A second point on the same field: a 1-bit bitfield cannot be accessed with
READ_ONCE()/WRITE_ONCE(), yet the net_cachelines row added above documents
pacing_offload as a read_mostly field consumed lockless by sch_fq.  Every
neighbouring netdev field in these paths is accessed with
READ_ONCE()/WRITE_ONCE(), including max_pacing_offload_horizon right next
to it.

Would a plain bool/u8, or a dedicated unsigned long used with
set_bit()/test_bit(), work here instead?  That would make the update
independent of the neighbouring bits and allow marked lockless reads.

> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index be9d1625bac31..e3444fd240615 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c

[ ... ]

> @@ -2176,6 +2177,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  			READ_ONCE(dev->tso_max_segs)) ||
>  	    nla_put_uint(skb, IFLA_MAX_PACING_OFFLOAD_HORIZON,
>  			 READ_ONCE(dev->max_pacing_offload_horizon)) ||
> +	    nla_put_u32(skb, IFLA_PACING_OFFLOAD,
> +			dev->pacing_offload) ||
>  #ifdef CONFIG_RPS
>  	    nla_put_u32(skb, IFLA_NUM_RX_QUEUES,
>  			READ_ONCE(dev->num_rx_queues)) ||

[ ... ]

> @@ -3342,6 +3355,15 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>  		}
>  	}
>  
> +	if (tb[IFLA_PACING_OFFLOAD]) {
> +		bool val = nla_get_u32(tb[IFLA_PACING_OFFLOAD]);
> +
> +		if (dev->pacing_offload != val) {
> +			dev->pacing_offload = val;
> +			status |= DO_SETLINK_MODIFIED;
> +		}
> +	}
> +
>  	if (tb[IFLA_OPERSTATE])
>  		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));

[Severity: Low]
This isn't a bug, just a note on reading the patch in isolation: at this
commit do_setlink() is the only place that touches dev->pacing_offload, so
the new knob has no reader, and the net_cachelines row that names sch_fq as
the consumer has nothing to point at yet.

Checking the rest of the series shows the consumers arrive right after:
fq_offload_horizon() in net/sched/sch_fq.c returns 0 when
!dev->pacing_offload and is called from fq_classify() and fq_dequeue(),
fq_change() rejects TCA_FQ_OFFLOAD_HORIZON with "device pacing offload is
disabled", and idpf adds both the first advertiser of
max_pacing_offload_horizon and the

	if (!tx_q->netdev->pacing_offload)
		return;

check in its TX path.  So the annotation and the setlink example do become
accurate once the whole series is applied, and the commit message already
says no driver advertises max_pacing_offload_horizon yet.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910171131.2532487-1-willemdebruijn.kernel%40gmail.com
