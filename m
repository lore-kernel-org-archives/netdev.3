Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053927FD4F
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293441; cv=pass; b=otarDbMwBDbJuNKEAFDivFfPJszxvZVyaSh4cy94iVIhjz9k8ENL9LXuadgj2B6Aa7XT16n0HV3dczgWP4Xx0M2EB8PbRv+OCLJeTrGjuUh+5RHihnIZ2/ge+0dmvP4F5LzsBqsMdTulDKns0UAxydn+wiIyk7vkDb7YK9xa17M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293441; c=relaxed/simple;
	bh=Q8ePWhI37kRRt9O18hCNptmsbz5tx2Miut6OaoJ7HCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXQRGXdhaJ2TzVbhlBaqsgwd4ZMf2lnC7pJ2HfM8/+w/5+zfi/uXptN7DKIjSF6Ya7EWuKZ8LhrGBlbg4OR852uCUMDu/7v2/j613PzFiZTR/y4pFOELKhYcH7XHfwexshNe4qK659uqHimwGCG4GppQJrH9x+z+KaDMddYNgn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WY5i3Ci7; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WY5i3Ci7"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80c5cb9a888so7286437b3.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 23:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787293438; cv=none;
        d=google.com; s=arc-20260327;
        b=rAWspxvrBV9sToskOfHly12mpXSO3h/GK0Mt6swJbr6cb1vsyDFYCMpapDhmSM2O5M
         L6DUyAaydstkF3z3+73P5T6NUMNUkdbnBiKaCEQuGWnOEhrYZH9yhq5Pnqk6QBNu34XE
         uLU0rLfp1+Nq/VhH2jjhbgJngnAQBnkxw6RHw2S3eK1WTQNny39NxjTJcFFjVwKmrAHb
         aw3wQG+z+RDAOuZ0amQZFOKrI0y4j4jNH5MPTY/IWfUvbcii5DcYhphJXgus6KH8R7W4
         rqlQBNUcH8fjqv+b+D/kxJUvT1kAUG5cvekW5kk7Uix0jGv8Dr4ilyJy1IZAdtMMWSks
         AB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jgejhtiig9D98ohnrNeyKPzk+xvQUFR979hDehapAH8=;
        fh=yXa1eIg25g9014uYpri7RwLOHLPMYoO5JJyC4mjZ5es=;
        b=GxH6XUyWcrj+AlJgarNL/uDVwSTP3qGveiWkFo1AaDyWnk87v65nM3zf8gq7K4NpYc
         K+rYLYoBuG3N2RoxjfMNB3gRqfayf1lSmuDm75wo3919kNnd/RHWbvcFaRTa2nrKB+xw
         AerU4YwtC7wT2qAgX+5Q6dMlRNjJP1Ix8A0XgM7qcLEokmwiW2/7OpOFZIhmMmg/ydvh
         zWqJhTeVfBBNhwhAQ/OdwjoYqAPWPaSY9KvLMLgx/Dc4IE/HnJD4AOufpWnvWx69WXVB
         7b8Col4viJ8ldOyqUR87bg9dR0PO5GVtoFLT4vLR2wI2K4wDr4o9VFrpDEcUvIrRySmq
         aDYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787293438; x=1787898238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jgejhtiig9D98ohnrNeyKPzk+xvQUFR979hDehapAH8=;
        b=WY5i3Ci7ATISmPBzjffDyiei4xQ6s+6LcX/LqD+zaXgbvc0JfE7Psv6G9Ny6nLPhEP
         Sc62BBwljRqRGnW3A/HD2kFsNXNTW6NFNbjbNs8xOLFimMhSgwEN+dFIOYJKXtHIdv5w
         8bT+hTdhjVOq6C+iLSunQhrCBYX74INjhWm9eM0CEPapmmhEugscsQNkjze8oj/uCeK4
         K5cZUZNmIuFyYlrEkBV4N9brxQ1+rj4qEWKH3uUiUHsuG6lPzj1RHQZ7brgXkczD39Rt
         uSzhwn47RWbx47BeY45XAP0R9OqLj7hoeyIPoHzWioBgpuzMTdGagVYwQxRqP3k3Kp+r
         0XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787293438; x=1787898238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgejhtiig9D98ohnrNeyKPzk+xvQUFR979hDehapAH8=;
        b=kbTKDz1MaA6VQohuRfS9a5VA+M4uCu4EBp6b7Mx2bxZjWDwFx3ha6cy18O5ejz3Rze
         bLrDERPLU5tawZeFHhMNTJEGfu9MKghB8dGf6n0ohKtfcFJxPnDGB5POiqyVsMQCYfUv
         D4Mq1X53P7IRWc2RRea0akQ45bzSYhbz6zJlVRhH9d7KuX2/aiQDekVg+h6WOFVnsupI
         sRlDZZobwr9SIxqNitqi3nET+O8fVd/ooTsrUwoOWwwuO3u9VgNkOsxjgbchxQmfHyhm
         jMZdAcfqtunljlsjMx0LQSWtpAea82CtE840vqOZ3QAXrCPGFslUBmjquSSGhTXs8a8r
         9jNA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0R5FXc3//iZvv4PsAPnMofJLxZ5H1//Ijp1Vmzj9rT0bck0NExh2hej17+LUpW9tuxNvoNEo=@vger.kernel.org
X-Gm-Message-State: AFuF++nA2BN8LNmDvGIm85ctetOHSqXJ1fHhVU+/hoaqVTR87LwJI8Xk
	1E12WgU0EHogWqU+eZtXahj3GosGxHZtWCJH5ZkH5xeuud3u04KJHXtB44kHE1Wm8HYJEsN/F1a
	sgGP5IGgpOuTG63dhHBw/eYTc/ktqPrN8Qnjn8S8j
X-Gm-Gg: AR+sD13TBFnTb/aB0ItSF3sE+kRExez2TCF8AlDCp6YlWE0iWrB1hZ6qbmwDr4O+qPv
	sh4p/N02cjGvLSoe1RtzgUOBw3G36qnaAk4VDErvCyj61EFfSc9dOSRiUsFGjEuDUYvbi26BEXe
	uCvwsNnEnypv/Ee6blzrEfb1UiyWRcbvj2nUX61+QfF8Z5kCwYjFaY4Mie5o5N+BWCVstXEcLFu
	GJKso/K7onV7hIXF5QvzVnZk0zci3Jf/QslLxxwOH//Ns3+rTsHvkTGSx7sKxpZ/y/J6yr/LqJr
	BAKo8efe6XS36oMBFrsQnrV9ZMLo4vSdr0ydJGV5rmxv3s/LOd0zl6Isxg8Onwom755dSMEoEyE
	llX889jymG+mT8RnRsw6xFA60bhYUVBBvPvAleazmyBVZM6qPHsaFxd53lg==
X-Received: by 2002:a05:690c:a183:b0:81e:79f0:48b8 with SMTP id
 00721157ae682-849ef58f83cmr13325887b3.7.1787293437227; Thu, 20 Aug 2026
 23:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813033855.3372172-1-dongchenchen2@huawei.com>
 <CANn89iLCrzmOfUVwa0yeROpkZxWmVsAkbH7=SBA3XuVxkmTfKA@mail.gmail.com>
 <53e86f6f-43b9-4e06-b185-1344f69cd650@huawei.com> <CANn89iJWTwiQJbjWz5jY6DE_TSA0EEMyJtQFbDSzMJfjV=MHQQ@mail.gmail.com>
 <9a80f88e-c8a6-44fb-a7b2-7cdbaa3bba24@huawei.com> <CANn89iKg5XhJQQQWaF0UMxs+Bwjthk=StBKVnKfh+VKBAywkpA@mail.gmail.com>
 <f8549a27-8052-4d74-a505-9c0b42c73687@huawei.com>
In-Reply-To: <f8549a27-8052-4d74-a505-9c0b42c73687@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Aug 2026 08:23:45 +0200
X-Gm-Features: AcwNN1Ux5S-Uhi_T3S1uMbw4lRHvK0otXuRgf7tnUwaLN0-6wnIVANLc2oCPOLQ
Message-ID: <CANn89iKxgad2uPQqNCuf1iA7ntUM-twA_deZY=JB+uqABBqwVw@mail.gmail.com>
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

On Fri, Aug 21, 2026 at 4:21=E2=80=AFAM dongchenchen (A)
<dongchenchen2@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2026/8/21 0:32, Eric Dumazet =E5=86=99=E9=81=93:
> > On Thu, Aug 20, 2026 at 12:04=E2=80=AFPM dongchenchen (A)
> > <dongchenchen2@huawei.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2026/8/20 17:16, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Thu, Aug 20, 2026 at 10:58=E2=80=AFAM dongchenchen (A)
> >>> <dongchenchen2@huawei.com> wrote:
> >>>>
> >>>>
> >>>>> On Thu, Aug 13, 2026 at 5:30=E2=80=AFAM Dong Chenchen <dongchenchen=
2@huawei.com> wrote:
> >>>>>>
> >>>>>> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a s=
tale
> >>>>>> transport_header offset after tunnel decapsulation.
> >>>>>>
> >>>>>> BUG: unable to handle page fault for address: ffffed102091a42e
> >>>>>> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> >>>>>> CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4=
-00061-g248951ddc14d #256 PREEMPT(full)
> >>>>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-de=
bian-1.16.3-2 04/01/2014
> >>>>>> RIP: 0010:__asan_load2
> >>>>>> <IRQ>
> >>>>>> qdisc_pkt_len_segs_init (net/core/dev.c:4145)
> >>>>>> __dev_queue_xmit (net/core/dev.c:4787)
> >>>>>> br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
> >>>>>> br_handle_frame_finish (net/bridge/br_input.c:229)
> >>>>>> br_handle_frame (net/bridge/br_input.c:315)
> >>>>>> __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
> >>>>>> __netif_receive_skb_list_core (net/core/dev.c:6287)
> >>>>>> netif_receive_skb_list_internal (net/core/dev.c:6445)
> >>>>>> napi_complete_done (net/core/dev.c:6813)
> >>>>>> gro_cell_poll (net/core/gro_cells.c:74)
> >>>>>> __napi_poll (net/core/dev.c:7735)
> >>>>>> net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
> >>>>>> handle_softirqs (kernel/softirq.c:622)
> >>>>>> do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
> >>>>>> __local_bh_enable_ip (kernel/softirq.c:450)
> >>>>>> tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
> >>>>>> tun_chr_write_iter (drivers/net/tun.c:2032)
> >>>>>>
> >>>>>> The crash requires four conditions to line up:
> >>>>>>
> >>>>>> 1. The incoming packet is encapsulated and carries GSO metadata.  =
The outer
> >>>>>>       transport header offset is stored in skb->transport_header w=
hile the
> >>>>>>       packet is still in the outer tunnel context.
> >>>>>> 2. The tunnel receiver strips the outer headers.  skb->data is adv=
anced to
> >>>>>>       the inner frame, but skb->transport_header is left pointing =
to the
> >>>>>>       now-removed outer L4 header, so it becomes a negative offset=
 relative to
> >>>>>>       the new data.
> >>>>>> 3. The inner frame is not delivered to the local IP stack.  Instea=
d, it
> >>>>>>       is forwarded at L2 by a bridge or HSR, so ip_rcv_core() neve=
r runs and
> >>>>>>       the transport header is not reset to the inner L4 offset.
> >>>>>> 4. The forwarding path calls __dev_queue_xmit(), which enters
> >>>>>>       qdisc_pkt_len_segs_init().  That function computes the GSO h=
eader length
> >>>>>>       from skb_transport_offset(skb).  Because the offset is negat=
ive, the
> >>>>>>       unsigned cast overflows and pskb_may_pull(skb, hdr_len +
> >>>>>>       sizeof(struct tcphdr)) reads past the end of the skb, trigge=
ring a
> >>>>>>       KASAN fault or page fault.
> >>>>>>
> >>>>>> Fix this by clearing skb->transport_header to the ~0U sentinel at =
the
> >>>>>> tunnel decapsulation boundary, after each tunnel receive function =
has
> >>>>>> finished all processing that needs the outer L4 header and before =
the skb
> >>>>>> is handed to GRO or the stack. The IP/GRO receive paths then set t=
he
> >>>>>> transport header correctly when they parse the inner packet.
> >>>>>>
> >>>>>> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init=
()")
> >>>>>
> >>>>> This Fixes: tag seems pretty random to me. Issue was present long
> >>>>> before that commit.
> >>>>> Next time, please be precise with the `Fixes:` tag; it's not decora=
tion.
> >>>>>
> >>>> Thanks for your review. Sorry for the late reply.
> >>>> The stale transport header has been present since 1da177e4c3f4
> >>>> ("Linux-2.6.12-rc2"), which is completely latent until
> >>>> 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()"
> >>>> was merged.
> >>>>
> >>>>    From the perspective of the root cause introduced by the issue,
> >>>> we can use 1da177e4c3f4 ("Linux-2.6.12-rc2") as fixtag.
> >>>>
> >>>>> Also, calling skb_unset_transport_header(skb) directly from
> >>>>> gro_cells_receive() would make more sense and
> >>>>> your patch would be less intrusive.
> >>>>>
> >>>>
> >>>> gtp=EF=BC=8Csit use netif_rx to receive pkt. so modifying only gro_c=
ells_receive
> >>>> cannot solve all the problems. netif_rx is widely
> >>>> used and is not only invoked by the tunnel driver, and serval path
> >>>> (such as genve encap) will reset transport header before netif_rx.
> >>>> Therefore, should we retain unset in the GTP/SIT tunnel?
> >>>
> >>> Hi Dong,
> >>>
> >>> 1) Regarding SIT:
> >>>
> >>> SIT decapsulates IPv6 over IPv4 (IPPROTO_IPV6). There is no outer L4 =
transport
> >>> header (no UDP/TCP), so skb->transport_header is not pointing to an
> >>> outer L4 header.
> >>>
> >>> 2) Regarding GTP:
> >>>
> >>> GTP is an L3-only point-to-point device (ARPHRD_NONE). It cannot be
> >>> enslaved by a bridge
> >>> or forwarded at L2; its packets always go through ip_rcv()/ip6_rcv()
> >>> where the headers
> >>> are properly parsed/reset,
> >>>
> >> Hi, Eric. Thanks for the review!
> >>
> >> I missed the rcv path in the commit message.
> >> With an ingress qdisc attached to gtp, the stale transport header
> >> will been consumed in sch_handle_ingress() and its not covered by
> >> gro_cells_receive() either. So maybe gtp is not safe by
> >> construction.
> >>
> >> gtp_encap_rcv
> >>     gtp_rx //stale transport header
> >>       __netif_rx
> >>         __netif_receive_skb_core
> >>           sch_handle_ingress
> >>             qdisc_pkt_len_segs_init
> >>
> >
> > Let's step back a bit :)
> >
> > For non-GSO packets, qdisc_pkt_len_segs_init() returns immediately:
> >
> > qdisc_skb_cb(skb)->pkt_len =3D skb->len;
> > if (!shinfo->gso_size) {
> >      qdisc_skb_cb(skb)->pkt_segs =3D 1;
> >      return SKB_NOT_DROPPED_YET;
> > }
> >
> > It does not inspect skb->transport_header at all. It will be set
> > eventually later if needed,
> >
> > GTP does not implement GRO on RX and does not use gro_cells, so incomin=
g
> > packets in gtp_rx() have gso_size =3D=3D 0.
> >
>
> Hi, Eric. Thanks for your patient explanation.
>
> Normal GTP traffic indeed cannot trigger this issue and pkt without
> SKB_GSO_UDP_TUNNEL will be caught by udp_unexpected_gso.
> The only way to reproduce this for gtp is by constructing and injecting
> packets, such as TAP device injects a GSO UDP-tunnel packet (with
> GSO_TCPV4 and GSO_UDP_TUNNEL flag, Ethernet/IPv4/UDP/GTP-U/IPV4/TCP).
> Should we add interception for such illegal pkts?
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index af260ff5462a..8620428b950f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4138,6 +4138,10 @@ static enum skb_drop_reason
> qdisc_pkt_len_segs_init(struct sk_buff *skb)
>          if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) =
{
>                  const struct tcphdr *th;
>
> +               /* Defensive: stale offsets from buggy tunnel decap can
> underflow. */
> +               if (unlikely(hdr_len > INT_MAX))
> +                       return 0;
> +
>                  if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr))=
)
>                          return SKB_DROP_REASON_SKB_BAD_GSO;

Certainly not. Do not add defensive code in the fast path for GTP that
nobody uses.

Add everything you think of in GTP itself, I do not care.

 I suggest you look at skb_gso_reset(), this might be missing in GTP.

commit e3c674db356c4303804b2415e7c2b11776cdd8c3
Author: Antoine Tenart <atenart@kernel.org>
Date:   Thu Sep 4 14:53:50 2025 +0200

    tunnels: reset the GSO metadata before reusing the skb
