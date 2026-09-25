Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0293309EE9
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335690; cv=pass; b=ckN1wYObdFqqAKKRfr8CRDpBCJ0zYOD1i+nv8WimOOgoT1D9sF/QrrpIGIffhpkfGg1mdJI3pHwMdtfSKn2ssGv12BJkl8i1LoKiK1SG9+obYUxTXUIHEiwsHiRuZPl3o5MWAQNSVY1gkbbFOe39NxLrPJ9slorVxdCAA4iBOMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335690; c=relaxed/simple;
	bh=pPXzEm3jG8F+9Y4I4ZbiCZzF18Cic91IzKEy1oKcXHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbLm5QLq88gTf+1En3opRGRzIdkoVMS3RskiLeuJUCdZzMiJzFWHeyo36ri7a3PR+uGvrMRxTQvmU22uM/nYdl6XDvpEeryZIkLiPsJFyfW1/NEAZxRIAHcaHItaVnA9/gUIXmdv1uuKD8yHNpdFs+cWqb3sh+KA3y1Mo+KG1DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=M/n8vzj/; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="M/n8vzj/"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a3490bso614234b3a.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 04:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790335688; cv=none;
        d=google.com; s=arc-20260327;
        b=GH68i6zEVf3lGGxAACwuMnERGCAbdGIlsgiz6nzKt0HNoFWDpGV3vrf1EaNEfYxAZf
         PfRzzZYkhrw7iyL2w6n46Y6+mtHdO+DzO7EuPpYpFepFY+CwQ/TqYKjxM0Xqr5JM3pnR
         0nc5BrwlxJ0l1gyF6nkY0ws8Mpx22b8VlP67IqGuTjEw0anB5BsIB6cXybJukzCjcPuZ
         8IefCftszFhJZ9tUyfegCNA7OCSLEBM0g6zgSMQKUqvccEgvx3OwVXmrrYLuHNbSphFh
         QDPE5mTsI2etqurYrov4KotOl1NPY3Uwz8xdGH2SmS2u9qUlJdqRJAdQiPJRoC85jdHF
         xjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vT5/bjyJslLlUAwC6M+UJEZRf5B1FXMtJ5ZL61PS+Vk=;
        fh=N8FEvgZUXrM4i6N9UahrhVhhFuscG60fHp5lmZoFZRI=;
        b=PEu0/j9mCn6Xf0E80SeYxzA/629PPbgGquwE1MJ6YqsFj6kKbRo5sYjN3QKkrxEEDD
         0dj9z1ZA+gqDZvhrK4ws1/+H3OLQEev0I3xvqGoMVkGvKtEmwBIGShxYs3cFpxPrxx7f
         oLxBB7ZNPR+4aP5Qjt0Nn0JmqN//VIlnU0jtCgmoliXUoQmGGLB7kM/Akz0Nhk2v2PXt
         rN6lMqeVMc70xqIFpa/SAlp5Lyx5bCiZ33O9Qbo8KHEhYluYAcfrs/SFcylKLbHL8Rbv
         Jaow1P4EN5zZNvHzMYk3CrtaJGJVt8lomUDbt/rILDXeGWH2qYbiUC4OmlQ4LgJvQU9S
         6oBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790335688; x=1790940488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vT5/bjyJslLlUAwC6M+UJEZRf5B1FXMtJ5ZL61PS+Vk=;
        b=M/n8vzj/gXjPgo1F1nkgfsq0GSRqXmiZ0497CVe2j9Oj14wpG8lBmh/Lg5DqmGJ0/L
         uy+cRbyoczexlGwmVVdcLCDzQFUzeDRI9JnhqTDZ/dLtr/0aEZGlJInEe8LYOE9hvi6D
         3XmoyNVhIVmG94VQhRLN3rzG6RIO518WKb66I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790335688; x=1790940488;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vT5/bjyJslLlUAwC6M+UJEZRf5B1FXMtJ5ZL61PS+Vk=;
        b=LoNEKieAE4pLn0DYIlmh21lmoIOCNnJd4ko9pIguDJLqeofuTnfvHPDekMvuvhIQ/Z
         5e6rOVEy0fH2uFUdqSsDMPLy1JVR1WMVsVGMd7M58KRl2fIiScQO4cw4wIo8zwjiaxQT
         79JBbRmqo78IVqaRRt2eBmg5ENrHNLHEtUWpeJrfJUrYl91NdfO6adnCHY0+lDSVveG5
         zr5j/1vhlKv0qIJ5/ArnCXc1nIh6AO0rGEfZ3HY/ZC25Qkz1SOue0daceUced8Ns27/8
         oWc3GxlAP1adVVWlpAB/DDhT95kB9lYX0M/ifAuElrXC2Q70Sl4SHr5emtNvhvj6j3Ta
         qaeg==
X-Gm-Message-State: AFuF++lwzqo8XtkoJEUHFqkEgEkN84F7D2kH9ibk7ri1lhigD6ZaHmNI
	6CXn6qDE9H2RDNOo8xnzaQ8uEQzXguBQImcQTyUwnV81U8LFxL0dnGK1f+esCa73j/2rm4uzxx8
	hXWLwkxdND3zM/pAFswMbk95yzJhSxCdZBxHIT66Z
X-Gm-Gg: AYBFou0gHbRCaHUryxiluqE87/rLraqQbWhJqrH4fUA1XKRRAFS7QKZM5xQ0tbuNs4/
	5MjHvA8L96++Y7kx9OCjhbAs4JANi6WEohjmqFvZijIV1Nt/b0HEB+eZ9InMVCq7tTBv6loW6KP
	/qJf2MdF1s+IAsJGWLwiFIMy34oV6MWfjXXMGoi0epFbMynJh1SsZ7NCfRcEAK/ngbrXEYChUEt
	6EWHyvqwKLdk3OG8Zg14AtKvEJ4Hw2RDWnrtJXJdFEP7myeOZEb1o7cf/68AqeAwpuQEV1CRjvf
	KLdr78pNB1u24nyA2K2/WFwbKq6ZFZ8zj7xx2QKVnsZAfMWafkWj8QkX/b+XEP2JLHtfQqYk9d2
	bcdqTdzCx1LpHdE83AjCah/963NVzd9t4oA==
X-Received: by 2002:a05:6a00:301e:b0:87d:3894:197b with SMTP id
 d2e1a72fcca58-8802dd03c64mr1243578b3a.59.1790335683264; Fri, 25 Sep 2026
 04:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v1.20260922092618@mojatatu.com> <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
In-Reply-To: <CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 25 Sep 2026 07:27:51 -0400
X-Gm-Features: AclHuK84b0y7F0HEqpezhYZXsPyeRFSkZ1qh_36ghb7v2lh-eAqUCd7laRHoWFo
Message-ID: <CAM0EoMn8_MVUHa2Jym7wKvd6Oo-JvNJ7GPvRJi2DsJCnQFmW+w@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: fq_codel, cake: widen backlogs to u64
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	cake@lists.bufferbloat.net, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 5:13=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Sep 25, 2026 at 10:54=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > This is a follow-up to commit 8f735d64382d ("net/sched: bound
> > qdisc_pkt_len to prevent qdisc soft lockup"), which capped
> > qdisc_pkt_len() at QDISC_PKT_LEN_MAX (1 MiB). That cap bounds the stab
> > amplifier but leaves the per-flow backlog counter u32:
> > fq_codel_enqueue() accumulates qdisc_pkt_len(skb) into q->backlogs[idx]=
,
> > so a flow can still accumulate 4096 packets of 1 MiB each and wrap the
> > counter mod 2^32. After a wrap, fq_codel_drop() sees a tiny maxbacklog
> > and drops from an almost-empty flow, and the dequeue-side subtractions
> > corrupt the counter further.
> >
> > Widen the fq_codel backlogs table, the fat-flow scan (maxbacklog/len) a=
nd
> > the drop threshold to u64. fq_codel is not lockless: every writer runs
> > under the root qdisc lock, so plain u64 arithmetic keeps the WRITE_ONCE
> > publish / READ_ONCE-consume pattern. The dump path
> > (fq_codel_dump_class_stats) stays a lockless stat-only read.
> >
> > CAKE accumulates the same generic qdisc_pkt_len(skb) into its per-flow
> > b->backlogs[] and per-tin b->tin_backlog and consumes the values for
> > longest-flow pruning (cake_heapify/cake_heapify_up) and for the shaper
> > staleness check, so it shares the bug. Widen those counters and the hea=
p
> > comparison locals to u64; the class/tin stats keep exporting the low 32
> > bits through the unchanged uAPI fields.
> >
> > Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
> > CONFIG_NET_SCH_FQ_CODEL=3Dy.
> >
> >   ip tuntap add tun0 mode tun
> >   ip link set tun0 txqueuelen 32 up
> >   ip addr add 10.99.0.1/24 dev tun0
> >   tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
> >       fq_codel flows 1 limit 4200 ecn drop_batch 4096
> >   # hold the tun fd open without reading (IFF_BACKPRESSURE) so the qdis=
c
> >   # backlog persists, then send at least 4300 packets (the wrap starts
> >   # at 4096 resident; the over-limit drop that reads the wrapped
> >   # threshold fires past the 4200 limit): backlogs[0] wraps at 4096 x
> >   # 1 MiB and the fat-flow threshold reads the wrapped value.
> >
> > With a 1 MiB qdisc_pkt_len cap the counter wraps at 4096 resident
> > packets. At limit 4200 the first over-limit enqueue (the 4201st) sees a
> > wrapped 105 MiB (half-backlog threshold 52 MiB, a ~52 packet drop burst=
),
> > where the u64 counter sees 4201 MiB (threshold 2100 MiB, a ~2100 packet
> > drop burst).
> >
> > Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101=
130.16203-1-jhs@mojatatu.com
> > Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatat=
u.com/
> > Tested-by: hybris <hybris@mojatatu.ai>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
>
> This makes no sense.
>

As absurd as it looks that code is reachable ;->

> These qdisc have been developped to address bufferbloat issues.
>
> Storing 4GB in a qdisc is absolutely insane.
>

The counter wrap is not because we stored 4GB, rather it is because
"tc .. stab overhead ..." inflates qdisc_pkt_len() for a 64B pkt to
1MB. So ~4K packets (put in other words a few "real" KB) makes that
backlog[0] cross 2^32.
Result is pruning the wrong flow..

> Let's drop at enqueue if the current backlog is approaching 4GB (this
> can later be a new config/attribute in net-next)

Note, this is net-next already. Enqueue is fast path - are you ok with that=
?

cheers,
jamal
