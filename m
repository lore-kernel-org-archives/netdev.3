Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66747CA65
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259302; cv=pass; b=txlTCnO1KyPYN5GKJnucZO74/L3kFXuoGoGh7pNjGNDEpUh22EEXEsluVco5UsEeaxHbVVL6/9j99F+U8Fqik0IxKL+4MH3bcWSAKZIv1xIW4bb0cn4k4P/igopobvfF8wNPLfSFrcjVeYwfgfNhUK5sRLu80KO49hRNjuV8sFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259302; c=relaxed/simple;
	bh=xxETTt94XbDI8sJ/dOOg02pLX7m5znmohkFPG0NeYPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shOt23nHV0efYVg4m+t7XFGdQhApr6cVmBgr9SNoZCB3t+r/68SpkZwLIutf6NpAEg3l4UywWCuvZRvBNdzXmcjC3GUd0uC15v2kwmaclpPv77GE6j9dOofZnzBaOdFZ8soRLnJx581A7AzjDEjawtypy3GH47FEQ8ydnAYNz5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=H+NJkNts; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="H+NJkNts"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-86162c086f8so14305847b3.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 03:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788259299; cv=none;
        d=google.com; s=arc-20260327;
        b=rZMT2hsvNCabWUF5nZJgmhJwiUp3QtGx5IX9QncuA5APiz9dpqHEt8gv6dJpyzX0g0
         3FYTaFN2ZjxLbyS44YvG9kcMCLzIVErryIi1vakWXPB7ywOIH7f94NRoGsESJ1pX3BCY
         dvHQ4QFd58nJoM3A6QB6HLc/3oV7+nnWdttYjvtN0DjzhSLDSdRFs1hD/CoAlmprQo5F
         dTfj/ITF1i0xHLyKzyxIrwPo7Y/CcxnBE9rLoSXoL2u7sc/bsXrsI1TXvAx7ulPkzPh7
         HQcnpyShky+tK1xWrtDU9zFb7m1AX62Fz3SX6+BcGgO/f2hUPzglJIs4CXQGe8GEsBZu
         gRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=r5xUrqa6zSY5RggXlOvnQn1pXM3VVHoRSVX9zGt7wDs=;
        fh=P36yrQHFERPJuHGHiWdu4fKds7JgHfa2RSfl7UVei7k=;
        b=BWjQwanajF9OVqUWh7Hm70aSJQTfHgWkiFpuvZT8x1xR556H6i/ZfjI3XXwhCmqjXJ
         +VOiMOuzbupT5AlntGF+bwMzZQ3tokH8yhHbQ8W/Nr36IBZevq6cphaK37j0Os6yfC8N
         FUdFsvhq+AB28uBpY2l2jubBquHSb2uaXpAIzs4Uf0pvmbr72cAP1VthpOBVEpCJTnqC
         LkZo0l78jBBPP2s0H+d5G4xHXKkHAWd05vDSKaiGdSLTJvtef6Rkid7MZKM0KXz0KTog
         0wgx37aPTNcB7nUT3gIbhlYAyevCYoxIeUSjXQjs13ahYsmu/D+QCvRprHVR5g4wZDuN
         bs4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788259299; x=1788864099; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5xUrqa6zSY5RggXlOvnQn1pXM3VVHoRSVX9zGt7wDs=;
        b=H+NJkNts64Q0Vhl6mJcXU9FJXP4h+k/yYChZoQdp2oQW6PLYr97XJqbyUXtiLUcBQr
         j0FsLpY98BFphbeTz24e4eS4V9DHRcYv9coKO+pNOgw4kdlmoMImAeJokrwOTKyxZQTu
         SrkrW1Fg1Rnlx3Y7a0vRfzqxca27fOInazJMVYHoqDWVRwAVIUSC6Lx7B+Gvhf8kSWx0
         YhQL/1rxJqxlqPT+yCYGit7UOeeu15epojQ6fwkSTT3upGoJdIBJuL4ewdZH8S4a0qlj
         My1oFQaorb5nJuyYUOYxa4lAxLgzrfpFsUJeFETligiZ1Cy6s8T4C/pTEQhaQapm6muD
         5zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788259299; x=1788864099;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r5xUrqa6zSY5RggXlOvnQn1pXM3VVHoRSVX9zGt7wDs=;
        b=opsFvdg2bQT+G8M3zp6uZ3IpfwJxXM1tER474Gme9bE/fYaSfMSmkrK5nbEWL5UFaz
         5mAcfSmeySnlkO3/AGJlWHDj2xaYJpT9BXdlSnQ5DCEkQZ/y4WzQVDZc9CSVQ1uMlVFr
         ETBlddvY3Boqo6GJmT0wYcX7/OewPcf9sAkCOCYjoCSio8d5jxYpQe+yzaNU+aiGPKTk
         TcYSY4rATpFszPYT4NrIXnFU7FBzuYjeH3lIo+/fZooteE0gAEq4Z4/kIPkUywwijjbq
         81VcpwtW/hjHsWKpMFxTjp5omwJcvSSLd8iIiJtCxaBMUBpQtV0fDWJcpPZSY5ZZ3UB8
         1HrA==
X-Forwarded-Encrypted: i=1; AKwUvBw/d3gFTvntDrYiXG7dOlCeu5nf+W+0BQactBiQIHBuCsGYzJalgl0Ejmyr9ldBUTGbGR9Uuac=@vger.kernel.org
X-Gm-Message-State: AFuF++nDeXnKoXF53PFsMigBIhZz2WFgmvlkf5oSK8NnQvoUut++7d4n
	53BlH3clJNRqI37eH2Rz/ljZexTnJom4LDnhReZH9BFBxsqdyVQuQjzraJwZsdj2av4ZUgO+3cP
	GhES3vekXvZKeTWCsj3XrglOzHTVhSuxx8D+U31pM
X-Gm-Gg: AYBFou2qlMOBGGwcMYFRQT281Y+Ax0FVU6aaZhikwokvtpc7t8WdYTn4XNdNL43OPr5
	rcbTYJSKmWX7Jr5I6Wd951Ptfgco7OK2O3sq9WScoix6dHADwlg/yT2lxYh3UTsWGYnZ2G3wUWw
	AcSHuM8UKB7/y4nZrFetP4DPlDHkTc2tHCUd+OfihVY0EbP8GzLlpHnI7ZYjXpBUYqxHF/ELXo5
	63iAJKy5tt2ORFJ0evY9QPDTlwtKc4BklSU4KpoE04o9N5kE9bI/2ptPkB1i6XYwr/8g88CTjHz
	CgbEB/O+hOT/gF+1SPvPMyTvqb8k5JTZhXEcH1DyF28gfg29gsUeglR8ON1Uu47ojUmn/Mjuo3f
	UeZvwC7tOJF/JW1FQZf/CaLnGjPetdp69tcghA7Djtvu8B+WHp9R4bIeOyA91xSMqpEnL0S9scP
	YJKo5SOMZiY/Mdi5sfD/dKB9ORhzxLZ3/HnlLdWfJXpyfls4Q3omlYejwnZcQO5mnqgWMuD/BjW
	2FLQo7LXu2cGNs+fzvsxvfb5uDBiFYx1tinUQYXXcT8cA7ko/xMjY7+hsWG4cbWN8z/wTEnoFgj
	R9kvobbmGCREHQ==
X-Received: by 2002:a05:690c:e187:b0:82e:2dda:fb0a with SMTP id
 00721157ae682-86949e580b0mr14937287b3.7.1788259299093; Tue, 01 Sep 2026
 03:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901092632.369248-1-julius@bairaktaris.de> <apaix8MjIkRPjHVq@lore-desk>
In-Reply-To: <apaix8MjIkRPjHVq@lore-desk>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Tue, 1 Sep 2026 10:41:01 +0000
X-Gm-Features: AcwNN1VC5hjHM3WR5pHxOoSAcDyx36Os8cGZ9xiJpcKS8kl0-4xHvvgS61p5JxY
Message-ID: <CAC1t37KSALgrxX_4ZkGqWFnUStfYmMz+sG773UPQQ3TbjHm5CQ@mail.gmail.com>
Subject: Re: [PATCH nf-next] netfilter: flowtable: carry a priority into the offload
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

Agreed. v2 applies the stored priority on the software fast path as
well, in the IPv4 and IPv6 hooks, so a flow forwarded in software and
one forwarded by hardware get the same treatment; both paths are
exercised on IPQ8074 hardware. It follows once the 24h window passes.

If the earlier discussion is the CT metadata action RFC from last
September, the software-plane point raised there is what v2 closes - a
pointer would be welcome if more was raised elsewhere.

Thanks,
Julius


Am Di., 1. Sept. 2026 um 10:02 Uhr schrieb Lorenzo Bianconi
<lorenzo@kernel.org>:
>
> > A flow rule handed to a driver describes NAT, encapsulation and the
> > output device, but not how the flow should be treated on the way out,
> > so hardware with priority queues can only fall back on the DSCP the
> > packet carries.
> >
> > Carry skb->priority of the packet that created the flow and emit it as
> > FLOW_ACTION_PRIORITY, the action act_skbedit already emits on the tc
> > path. "meta priority set" before "flow add" then reaches the hardware.
> > A flow without a priority emits no action; mtk and airoha, the two
> > in-tree consumers of these rules, ignore the new one as they do
> > FLOW_ACTION_CSUM.
> >
> > The flowtable holds one flow for both directions and the expression
> > runs once, so the priority applies to both; per-direction
> > classification is not carried.
> >
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
>
> Hi Julius,
>
> we have already discussed about this kind of approach to offload skb priority
> into drivers that support flowtable hw offload. The main blocking point is we
> need the same feature in the flowtable sw path in order to not introduce any
> missing capability in the kernel tx path.
>
> Regards,
> Lorenzo
>
> > ---
> > The consumer of the emitted action is a DSA driver for the IPQ8074 PPE,
> > maintained in OpenWrt; measured there, "meta priority set" ahead of
> > "flow add" places offloaded flows in the port's hardware priority
> > queues. The mtk and airoha hunks are compile-tested only. The new field
> > grows struct flow_offload by eight bytes on 64-bit; the entry allocates
> > from its own kmem_cache, so no allocation-class change.
> >
> >  drivers/net/ethernet/airoha/airoha_ppe.c        |  1 +
> >  drivers/net/ethernet/mediatek/mtk_ppe_offload.c |  1 +
> >  include/net/netfilter/nf_flow_table.h           |  1 +
> >  net/netfilter/nf_flow_table_offload.c           | 11 +++++++++++
> >  net/netfilter/nft_flow_offload.c                |  7 +++++++
> >  5 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
> > index 92611802801e..2afce76ad131 100644
> > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> > @@ -1161,6 +1161,7 @@ static int airoha_ppe_flow_offload_replace(struct airoha_eth *eth,
> >               case FLOW_ACTION_REDIRECT:
> >                       odev = act->dev;
> >                       break;
> > +             case FLOW_ACTION_PRIORITY:
> >               case FLOW_ACTION_CSUM:
> >                       break;
> >               case FLOW_ACTION_VLAN_PUSH:
> > diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> > index 99b28aaa7cc4..4ee99e8e4a34 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> > @@ -378,6 +378,7 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
> >               case FLOW_ACTION_REDIRECT:
> >                       odev = act->dev;
> >                       break;
> > +             case FLOW_ACTION_PRIORITY:
> >               case FLOW_ACTION_CSUM:
> >                       break;
> >               case FLOW_ACTION_VLAN_PUSH:
> > diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
> > index f2e2771f188f..23218c8cbc3d 100644
> > --- a/include/net/netfilter/nf_flow_table.h
> > +++ b/include/net/netfilter/nf_flow_table.h
> > @@ -202,6 +202,7 @@ struct flow_offload {
> >       unsigned long                           flags;
> >       u16                                     type;
> >       u32                                     timeout;
> > +     u32                                     priority;
> >       struct rcu_head                         rcu_head;
> >  };
> >
> > diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
> > index 801a3dd9ceea..caaadffc2563 100644
> > --- a/net/netfilter/nf_flow_table_offload.c
> > +++ b/net/netfilter/nf_flow_table_offload.c
> > @@ -696,6 +696,17 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
> >           flow_offload_eth_dst(net, flow, dir, flow_rule) < 0)
> >               return -1;
> >
> > +     if (flow->priority) {
> > +             struct flow_action_entry *entry;
> > +
> > +             entry = flow_action_entry_next(flow_rule);
> > +             if (!entry)
> > +                     return -1;
> > +
> > +             entry->id = FLOW_ACTION_PRIORITY;
> > +             entry->priority = flow->priority;
> > +     }
> > +
> >       tuple = &flow->tuplehash[dir].tuple;
> >
> >       for (i = 0; i < tuple->encap_num; i++) {
> > diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
> > index 32b4281038dd..dd3ac2b9c963 100644
> > --- a/net/netfilter/nft_flow_offload.c
> > +++ b/net/netfilter/nft_flow_offload.c
> > @@ -117,6 +117,13 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
> >       if (tcph)
> >               flow_offload_ct_tcp(ct);
> >
> > +     /* Whatever classified this packet before it reached the flowtable also
> > +      * describes every packet the hardware will forward in its place, so
> > +      * carry it into the offload rather than losing it with the software
> > +      * path.
> > +      */
> > +     flow->priority = pkt->skb->priority;
> > +
> >       __set_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags);
> >       ret = flow_offload_add(flowtable, flow);
> >       if (ret < 0)
> >
> > base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
> > --
> > 2.53.0
> >
