Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEC1DE8BF
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481185; cv=none; b=t/1ZhdY9KtWHTkdX8XEQBEn0vCt0w1avcTob89Myrm6b/QBan/XzVvgt4rEAXVY5YYQtBb6+T5Xc5YwLCnvya6YzdwiqFvYqn954JAQ59AeGFnQqekUc7SgEkWHhK4uGZBdLUQsxvmqdNpQVefFpLf9oahNHtXtIpCH4k6WWWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481185; c=relaxed/simple;
	bh=FTt0lZcPKwqk3Cllosljk/aypfqQR5H/SeoRjYVKg3Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dUBj5IUXG4/JCvMMM18Wi450qCn2Q/2f8Q3qwO78e6p9sDRhhlDrtye+fZ3In6nCB3n1EamPekaMtk9QUezUfl7Mbl3/8ipviS5ElesSNYSaBsMiS1RKAPRIetggOYR2YJZkmHPZRfpZy7Yb5JEhfVH8xE4u+Oojo6oiOdqe0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvwlTDyj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvwlTDyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D751F000E9;
	Fri,  4 Sep 2026 00:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788481183;
	bh=Bh+1NPoLu0pnqMdZgGwsosjC2UXe57eZHjXYRQPBDhw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fvwlTDyjk0aCfv0MSGZXRcjtsmOHsHdebeZJ9Ieb3rR6oGeJZ8iozemDwtFTQZ0F7
	 DmZ8brHU7EHIqQffk8pB3LZIAIBXLcsJxQri7pugeX8s+BRQHT6Z+UMgBeKXKAzjXa
	 v6U2hZI9BdpBxh9KWBVMkvQEfFw/+a/gO5X+AbaeW9Mbv4EUMlKMTWJCYn5/2atKno
	 Zc/w7G12pLEcDdIqo2rw/am8QlUt4T8/mmX5L85RAgMU7tlTJqnoGZkY3eN1/UgCrd
	 vNBwq98Rijec0zFxm0Duf3tK8fOMEp5joig4bC2tNrRMJka9GJeQ3Nz5KNpZEiLDr9
	 6lu/raTPAK58Q==
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 04 Sep 2026 00:19:42 +0000
Message-ID: <178848118269.4131868.5248717808244298920@kernel.org>
In-Reply-To: <20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
References: <20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
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

- [Medium] Stale cached bound: sch_fq latches its offload horizon in
  q->offload_horizon at configuration time, validated once against the…
- [Low] uAPI spec vs kernel policy mismatch: rt-link.yaml adds 'max-
  pacing-offload-horizon' to the '&link-all-attrs' anchor, and that same…

--

net: rtnetlink: add pacing_offload_horizon attribute to net_device

Adds a new writable net_device field pacing_offload_horizon, exposed as
IFLA_PACING_OFFLOAD_HORIZON and settable via RTM_SETLINK up to
dev->max_pacing_offload_horizon.  Both fields become u32, and sch_fq now
validates TCA_FQ_OFFLOAD_HORIZON against the new active horizon instead of
the device maximum.

> diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
> index 61ebb9a2bad5..2a2aad9a29c4 100644
> --- a/Documentation/netlink/specs/rt-link.yaml
> +++ b/Documentation/netlink/specs/rt-link.yaml

[ ... ]

> @@ -2557,6 +2561,8 @@ operations:
>              - devlink-port
>              - gso-ipv4-max-size
>              - gro-ipv4-max-size
> +            - max-pacing-offload-horizon
> +            - pacing-offload-horizon
>        dump:
>          request:
>            value: 18

[Severity: Low]
Should max-pacing-offload-horizon be added to this list?  The list this hunk
extends is the anchor definition in the getlink do-reply:

  Documentation/netlink/specs/rt-link.yaml
        reply:
          value: 16
          attributes: &link-all-attrs

and the same anchor is dereferenced as the setlink request list:

    -
      name: setlink
      doc: Set information about a link.
      attribute-set: link-attrs
      fixed-header: ifinfomsg
      do:
        request:
          value: 19
          attributes: *link-all-attrs

So the spec now declares the read-only maximum as settable, while the same
patch adds [IFLA_MAX_PACING_OFFLOAD_HORIZON] = { .type = NLA_REJECT } to
ifla_policy, which makes a ynl-generated setlink carrying that attribute fail
the whole message with -EINVAL.

The same mismatch already exists in this shared list for perm-address,
tso-max-size, tso-max-segs and allmulti, but the more recent read-only
additions (netns-immutable, headroom, tailroom) were deliberately left out of
it.  Would listing max-pacing-offload-horizon only in the read-only/reply set
be closer to the intent here?  pacing-offload-horizon itself is genuinely
settable, so only the max- attribute is affected.

> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 81c5a6104dea..eeaf953b397f 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c

[ ... ]

> @@ -2344,9 +2347,11 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
>  	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
>  	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
>  	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
> +	[IFLA_MAX_PACING_OFFLOAD_HORIZON] = { .type = NLA_REJECT },
>  	[IFLA_NETNS_IMMUTABLE]	= { .type = NLA_REJECT },
>  	[IFLA_HEADROOM]		= { .type = NLA_REJECT },
>  	[IFLA_TAILROOM]		= { .type = NLA_REJECT },
> +	[IFLA_PACING_OFFLOAD_HORIZON] = { .type = NLA_UINT },
>  };

[ ... ]

> @@ -3337,6 +3349,15 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
>  		}
>  	}
>  
> +	if (tb[IFLA_PACING_OFFLOAD_HORIZON]) {
> +		u64 horizon = nla_get_uint(tb[IFLA_PACING_OFFLOAD_HORIZON]);
> +
> +		if (dev->pacing_offload_horizon ^ horizon) {
> +			WRITE_ONCE(dev->pacing_offload_horizon, horizon);
> +			status |= DO_SETLINK_MODIFIED;
> +		}
> +	}
> +
>  	if (tb[IFLA_OPERSTATE])
>  		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));

[Severity: Medium]
What happens to an already configured fq qdisc when this write lowers the
device horizon, including back to 0?

sch_fq latches its horizon once in fq_change() (see the sch_fq.c hunk quoted
below) and then uses the cached copy in the datapath:

net/sched/sch_fq.c:fq_fastpath_check() {
	if (fq_skb_cb(skb)->time_to_send > now + q->offload_horizon)
		return false;
	...
}

net/sched/sch_fq.c:fq_dequeue() {
	...
	if (now + q->offload_horizon < time_next_packet) {
	...
}

do_setlink() does not walk the device's qdiscs and does not clamp
q->offload_horizon, and sch_fq registers no netdevice notifier (only
act_mirred, sch_cbs and sch_taprio do), so nothing re-validates the cached
value.

Does fq then keep releasing packets up to the old horizon ahead of their EDT
while the device no longer paces them?  With the idpf patch from this series
applied:

drivers/net/ethernet/intel/idpf/idpf_txrx.c:idpf_tx_splitq_set_txtime() {
	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
	if (!horizon)
		return;
	...
}

no EDT is programmed once the horizon is 0, so packets handed over early
appear to be sent immediately until userspace also reconfigures the qdisc.

For comparison, netif_set_tso_max_size() clamps dev->gso_max_size when the
device maximum shrinks.  Would something similar, or a notifier, be
appropriate here?

Both knobs require CAP_NET_ADMIN, so this is a configuration-ordering issue
rather than something an unprivileged user can trigger.

> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 6144b5686f13..7cf7afda699f 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -1183,7 +1183,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
>  		u64 offload_horizon = (u64)NSEC_PER_USEC *
>  				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
>  
> -		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
> +		if (offload_horizon <=
> +		    READ_ONCE(qdisc_dev(sch)->pacing_offload_horizon)) {
>  			WRITE_ONCE(q->offload_horizon, offload_horizon);
>  		} else {
>  			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");

Before this patch the bound compared here had no in-tree writer, so an
accepted value could never become invalid afterwards.  Is the "invalid
offload_horizon" invariant still enforced once the bound is user-mutable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902181747.2483351-1-willemdebruijn.kernel%40gmail.com
