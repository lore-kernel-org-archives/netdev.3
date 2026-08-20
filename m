Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A32E7396
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217745; cv=pass; b=AK4iVJu3xNMPD8krjCKPauwhenltElE5Bn5szRwXD3EWW+NeTH/+6o7JiDXWihlIuvDm8Deapb3j+wIVFIsoQ8w8gLuFy6KGTnPfM6hq2DDJXfxxxxf/OwARX6ZBzdwGwxzBu0Josm00n8Lyt8j8DWhXqFOOlUdO43azblXkNpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217745; c=relaxed/simple;
	bh=zd1CPNa20q5ZT/zoruVglHsY8U1WmLuqZltIktQXVmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPDKnbij6wsrw7F1cjDvKruddjbd0S+QZ2OdGJyC9Y6fzWCGZz8sttMsMt8h/U9/6ohdx9tRsGqjPpVmYQbmW/rYH/QBK/UnUYF2YRRFXWOFP+jfxpuM4LpoQq2DXfoYel/w1En5IAo/3qfZbLkjtsmwJmiLPni3x4rLgbhbeV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8/ZzYYg; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8/ZzYYg"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9693bbb962eso1410506241.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787217743; cv=none;
        d=google.com; s=arc-20260327;
        b=p9Q8pBoi8pHv4zNbmHD8iP+NC2pHkwrkuEFGGdrNLd/9YSrzvZ0FIaDgoja4ENOBRn
         N+kIdLjl6D488AkKFejrk90kqWbOhaCdlZpb7vwcYHLUHiYCJsTTcK8fmrnZO6xabcD0
         5ShByJBm648cRkNplzEOWft8g5YTpZlEMcUTd2H996D5SPg/9QbGp80hSsGss59r1vkr
         Lz0rAdHwS1WScaBm65iW/ui4gWAPTSkasyPKkczlahTX31Nrorrd/TEEtI/E9hZbYI8p
         GZvTjEunPM6LKha5k/tqfSKCjxHN2iOoOD+l0SQGJN49A911G+OIpjlBhf0Sbung8n2/
         sd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6gs09E8BDxZ12toJrW0v2u8295gX4jG7nAazwHWKHQ=;
        fh=BVHj0BNNw9HQCQaufWi/t6gHIaNr3yKPM7cmxJcilaI=;
        b=WF3Wk9VPCviQxOuLAiv+xfQ0aAvVRL5RaUARojvKU0NQfdqWQfGH1f6nnc2NX2ja1H
         8zI2uzDTzFQzepR1qTiFy4XX/BH5M3OSOyHhSU+LiKyWKZhxZbw9Ygq4VlFwrVxZV3zt
         oOO4qI7ODt+RP7mIdyKAqXSRfMYOy8KvfUmlINQXL5wzXXu1YKnTpqisVEXzxwCFzfDm
         nnVkuDLDUKiInOIMJ9MnFlBr2eIdu7KEH9ziBvEm+hsgAGoGv/hK7y8prA4MQJcmMZhz
         ue2xM7ZCn8NCbQkiUNrZADmdVJno9BlHy+GhQPoCIK9F0vniJXYGKUj8qBIG+9qDD0xb
         +Glg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787217743; x=1787822543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6gs09E8BDxZ12toJrW0v2u8295gX4jG7nAazwHWKHQ=;
        b=d8/ZzYYgq33tH2bekP8ZYFknEXJ8VOZF2pWHEGl0U8aIZHPCaMeYDb2MBxsEKF796E
         B2VTwxa20FwgzteL7BBh7luJZbTHG9/gb2ln51utRbdL8mDSg6CS32we65vP1MXvU5e7
         jEuz8Fr7zegLDaPD/dLZVMsm3MeL5kg6DW1g9WuiiAKro/w3g6LQNrcmdobHjb5aqbAZ
         0pAw8MOMiOpCFUIWxXClaPa24Yw5B/gYX07Eaq2sNg5eI1z3pYrVypvmdMMSBQFvm0XI
         +KiH3nboiNoqAyLd6D2zWwTij3bFJ1NLn47rxLH5Ab5Tg9n8WGEjfOUxgETn7QbELHkS
         /0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217743; x=1787822543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6gs09E8BDxZ12toJrW0v2u8295gX4jG7nAazwHWKHQ=;
        b=osKYuOM294fuJMtpFj8fTIPW72aOF3pSH7v8wrRO6wp4vef6/KBRBfsZsXTlWRN8R/
         YORog9rRKN+gcKs9ZlLndqwzYmbymlRZab5bIhjDdXl1bihh/ln+rRaguaSjiZgEik+t
         42tSXXXfOurmvX84Sdf6aLrgcYk7jah7cymwPlnWYvkiyVTfJ56u+EVC4HjAwbgq+V7Y
         uIx5jn6BgBIlSm8a7cKwL9BD9ec8guZCsRuwZw2pCsgxEPfChZ853iXdmUZHiZAl26T4
         j6sxrEef90JBA1ijbO1M9YkXROYscw4kKO+80oILYgjOueXVyDHN7JPAEnk0V4GUDmO6
         loMw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9dnu189qYDuPCBog294bomo7veepqsrnEnMPwEBi89eX4Bx88yChsfjwlGJ56AVnQQc4lUE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIFSOcSpAiC6fiqiKrPL4/SP/5teCS18G1MeLB5ExOcQ3yBYnP
	2TnMqORhB7Q8bwUQqg0IsniVWGtP5yeO3VtlLukDPjK8EJNWq5p9rVZKSmiD4MDyftnspGNbLU4
	Whe4cduKfWMVP7jQNBrQjAV5ezegMTEBNRMsCJ+3az+agENw1YRej0ICEPok=
X-Gm-Gg: AR+sD11qWsHNEQkHEMxC6+gshlRyKkFh3mc+tOzkLR6qgass1pqa36Uv6WXKcJKrYbh
	zbbm1TdEbrcBQuVbSV8nKaFFa1rFIG3ftO+RsGrfVD97uKbstYvo4qXcDaSoAG4y5kgGT7x6lLQ
	yvT8oIuR4JpL6FzMvkWmyzhWHgvk1v4HrmuI2+fanz2CpoUExuVqWWNve3y14ctFHrjj9T1iyVR
	ESuwhlAOmqiD6N62l65SkiZO/U4GSxjgmCkuufJEGm7ilCQbkn0iLh72oNJ1weHhJNLNrgtPlCL
	mp9r+ojPnYfqmS9Bo1aC7TWjH0YdFBLBUlSlL/svsfe1hmvCpB7MYcGvGhPVCyDohCgn1n1l2Oi
	wjsWdkhbzk7hd8KMlgT9dAap1woDa22fl8xp9OuBLlEWKCb93jQKwL0HWCWNxd3mtXrc2Mw==
X-Received: by 2002:a05:620a:1710:b0:932:ddff:123d with SMTP id
 af79cd13be357-9371e6f64b6mr1074349285a.29.1787217376801; Thu, 20 Aug 2026
 02:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813033855.3372172-1-dongchenchen2@huawei.com>
 <CANn89iLCrzmOfUVwa0yeROpkZxWmVsAkbH7=SBA3XuVxkmTfKA@mail.gmail.com> <53e86f6f-43b9-4e06-b185-1344f69cd650@huawei.com>
In-Reply-To: <53e86f6f-43b9-4e06-b185-1344f69cd650@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Aug 2026 11:16:05 +0200
X-Gm-Features: AcwNN1XdM1TXl_YrOtJOvomoDTTocz6-cpAOIjlmXdaACM9JgtIH-Q3log10Abo
Message-ID: <CANn89iJWTwiQJbjWz5jY6DE_TSA0EEMyJtQFbDSzMJfjV=MHQQ@mail.gmail.com>
Subject: Re: [PATCH net] net: iptunnel: fix stale transport header during
 tunnel decapsulation
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, 
	herbert@gondor.apana.org.au, kuniyu@google.com, idosch@nvidia.com, 
	andrew+netdev@lunn.ch, ap420073@gmail.com, steffen.klassert@secunet.com, 
	laforge@gnumonks.org, jiayuan.chen@linux.dev, jhs@mojatatu.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 10:58=E2=80=AFAM dongchenchen (A)
<dongchenchen2@huawei.com> wrote:
>
>
> > On Thu, Aug 13, 2026 at 5:30=E2=80=AFAM Dong Chenchen <dongchenchen2@hu=
awei.com> wrote:
> >>
> >> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
> >> transport_header offset after tunnel decapsulation.
> >>
> >> BUG: unable to handle page fault for address: ffffed102091a42e
> >> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> >> CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-000=
61-g248951ddc14d #256 PREEMPT(full)
> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian=
-1.16.3-2 04/01/2014
> >> RIP: 0010:__asan_load2
> >> <IRQ>
> >> qdisc_pkt_len_segs_init (net/core/dev.c:4145)
> >> __dev_queue_xmit (net/core/dev.c:4787)
> >> br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
> >> br_handle_frame_finish (net/bridge/br_input.c:229)
> >> br_handle_frame (net/bridge/br_input.c:315)
> >> __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
> >> __netif_receive_skb_list_core (net/core/dev.c:6287)
> >> netif_receive_skb_list_internal (net/core/dev.c:6445)
> >> napi_complete_done (net/core/dev.c:6813)
> >> gro_cell_poll (net/core/gro_cells.c:74)
> >> __napi_poll (net/core/dev.c:7735)
> >> net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
> >> handle_softirqs (kernel/softirq.c:622)
> >> do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
> >> __local_bh_enable_ip (kernel/softirq.c:450)
> >> tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
> >> tun_chr_write_iter (drivers/net/tun.c:2032)
> >>
> >> The crash requires four conditions to line up:
> >>
> >> 1. The incoming packet is encapsulated and carries GSO metadata.  The =
outer
> >>     transport header offset is stored in skb->transport_header while t=
he
> >>     packet is still in the outer tunnel context.
> >> 2. The tunnel receiver strips the outer headers.  skb->data is advance=
d to
> >>     the inner frame, but skb->transport_header is left pointing to the
> >>     now-removed outer L4 header, so it becomes a negative offset relat=
ive to
> >>     the new data.
> >> 3. The inner frame is not delivered to the local IP stack.  Instead, i=
t
> >>     is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs=
 and
> >>     the transport header is not reset to the inner L4 offset.
> >> 4. The forwarding path calls __dev_queue_xmit(), which enters
> >>     qdisc_pkt_len_segs_init().  That function computes the GSO header =
length
> >>     from skb_transport_offset(skb).  Because the offset is negative, t=
he
> >>     unsigned cast overflows and pskb_may_pull(skb, hdr_len +
> >>     sizeof(struct tcphdr)) reads past the end of the skb, triggering a
> >>     KASAN fault or page fault.
> >>
> >> Fix this by clearing skb->transport_header to the ~0U sentinel at the
> >> tunnel decapsulation boundary, after each tunnel receive function has
> >> finished all processing that needs the outer L4 header and before the =
skb
> >> is handed to GRO or the stack. The IP/GRO receive paths then set the
> >> transport header correctly when they parse the inner packet.
> >>
> >> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> >
> > This Fixes: tag seems pretty random to me. Issue was present long
> > before that commit.
> > Next time, please be precise with the `Fixes:` tag; it's not decoration=
.
> >
> Thanks for your review. Sorry for the late reply.
> The stale transport header has been present since 1da177e4c3f4
> ("Linux-2.6.12-rc2"), which is completely latent until
> 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()"
> was merged.
>
>  From the perspective of the root cause introduced by the issue,
> we can use 1da177e4c3f4 ("Linux-2.6.12-rc2") as fixtag.
>
> > Also, calling skb_unset_transport_header(skb) directly from
> > gro_cells_receive() would make more sense and
> > your patch would be less intrusive.
> >
>
> gtp=EF=BC=8Csit use netif_rx to receive pkt. so modifying only gro_cells_=
receive
> cannot solve all the problems. netif_rx is widely
> used and is not only invoked by the tunnel driver, and serval path
> (such as genve encap) will reset transport header before netif_rx.
> Therefore, should we retain unset in the GTP/SIT tunnel?

Hi Dong,

1) Regarding SIT:

SIT decapsulates IPv6 over IPv4 (IPPROTO_IPV6). There is no outer L4 transp=
ort
header (no UDP/TCP), so skb->transport_header is not pointing to an
outer L4 header.

2) Regarding GTP:

GTP is an L3-only point-to-point device (ARPHRD_NONE). It cannot be
enslaved by a bridge
or forwarded at L2; its packets always go through ip_rcv()/ip6_rcv()
where the headers
are properly parsed/reset,

3) Regarding Geneve:

When skb->encapsulation is set, inner headers are already parsed and
qdisc_pkt_len_segs_init()
uses skb_inner_transport_offset(skb), not skb_transport_offset(skb).

When skb->encapsulation is 0, it calls gro_cells_receive().

All L2 tunnel drivers that can be bridged/forwarded at L2 (vxlan,
geneve, bareudp, amt, etc.)
use gro_cells_receive().

IMO calling skb_unset_transport_header() directly in gro_cells_receive()
is clean and fixes all of them in one place.

Thanks.
