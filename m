Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792490950;
	b=rUA6kIn+s9uD9RIWVrKoq5PoPGYcvLrdiUhFWKIK92n7G/c31DrAKoNTLBCqKI1BB38d
	 Iu/E5GEGvXwVIdl1f9Bzk8wJZkv1rI7q7X5/OEtnkMHOOSwac75elBE9uMOfdWg8HB+pp
	 0E+8BF6AuBNfMKL6yC4VWQxLnQX1pBaKPywmlOvUP20ZNycSLzrkk2Ikj5PFLv6QrHbn0
	 uHssLSMPp5EJSODp2hp624r9GIxbMmCb1Uc4rrxIzkUAnrZVhKVjI0tdkXZcjFsvfLhGa
	 ISKJH2bIyjU57War2Gw6vxMsHgciCyxb9bLXNxiqXWrYvLlOtp8KHi2XjAkJqlFVSvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=qhnr10hYwvo+mGlvIXUR1+7EJxKovnVM/xD0YZCy14c=;
	b=WrTTSt7y2RKAiX59yFzE1JJo0cFrQ61PIc434O7Lrv58u8egWe6C6g/Vek+KptHP1H5G
	 6DBRKfqHSj05pcFvP0YPD8Bn+jw8YZNt98xrtAKGRAzpVWTHfkWnG7yPxMZmLAU+CNzsY
	 urlNUM6DzkjXNgLse69/S3binSDnJL2Maur4JZntInzCKekxv/3qHgryTKudiMJmhXmC8
	 6Csdmt11lds4Ly2pW2f+Ia9H1ZiDhvN/2Jw8BBfWgTjz8Wrh2s1OD0QKZ0VStHb75Nzin
	 gB6w9kdwWqGEaBgJrrIh+ovSW7KKeXB56/gdGgJfmFgdA+cBGTUaurfyZrnCLLABBAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QWWOim7X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EA606A337
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 286EA606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QWWOim7X
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06210b29fso792348b3a.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792490949; cv=none;
        d=google.com; s=arc-20260327;
        b=m/UBwq9PsrKeswuurlpmg9+PLYDZL0jmJWvNjxCK/VbDtHpBGtj5IH2QLovatbO9g1
         lTvVL7qWr10axBWyT43AlXeteIiZQyqvMId+H4GVYfPeSFlJQ22HPwBdcM+qsypAibXw
         u68lucgkHTU4fpGR1tc4BUFlNigdYktroBn4+ofGmyZIyIS7xSIoreevlRhUka3ClhAU
         HtYemk6VmSkX5O4tVykH3W9vS9eIeiF6F8uIhBg+rUWHFvrObBuw+CTizftuO6zFPfPy
         BccOC3/8wXLyB/vLxZ3y0JKoSHmEcI++hcEJOMOfbOLm4PGj0+/Y+Kbxk/wYabx0DBNw
         DXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qhnr10hYwvo+mGlvIXUR1+7EJxKovnVM/xD0YZCy14c=;
        fh=xmp1vX2ksVRtN/ju6J6bqhuSKfOgjk3q1XA6KuGu+8E=;
        b=iQh+DE6rOT3B8syTw21ZsiSGImpg8nUMaF8CzQ8ErzL1vMIAZByf1SxSBwx5jycNQC
         4dGBN6+pNJkiTXB9x5o0GDQHnjn06pd97fD2RGQrMuwthYMKiCKscko9VV7UtHcS2j2y
         ur5YaQHaQYNj4gaiOIxAlAOJpRRekUZW+9B3pKxYtow/hCTvtbP6cLtX7SwwH8MS8bHR
         0I1sVx8dsanA6kXLWX8/0kQAfEePjCii60S5kHWJBpWMbpYitG/X3Ao8BYq9XUEfgsjw
         fyVQI/bx7AYQxcCTl0pkVZt+8LSN6kWTupZQeZ5wFhhYy+P2oZTpzoZerdd88EZ/jJac
         LB3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792490949; x=1793095749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qhnr10hYwvo+mGlvIXUR1+7EJxKovnVM/xD0YZCy14c=;
        b=QWWOim7X8Q5bV+JSU8Tw1JQpoLE4izuCBMMfBUHzFOypohffitiVaeX8TRKeFhVltm
         F4/EQLfOsUW+yKAjxTrD83WsfAwi8w6txQqPMQgtGN1aFer69/4nMwBwaJwNFuTc53X/
         bBavFya+dyYnj3KtgdFRr3SG0zi9DNG7rwX3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792490949; x=1793095749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qhnr10hYwvo+mGlvIXUR1+7EJxKovnVM/xD0YZCy14c=;
        b=dTEwpylLqC7rLnVjpJkl0g2jrwUHeF2II2XIqMLod+Us8Lz1sbOJdBAK4i/ty59ezn
         4b0F35UrU7gpqWNo8o/snYLFZ4jUHvXZMCO1r3N+EBwvGsyhouZpyY6FF/x6v/8qek2i
         o4s2ek3IYdBtqHwJp6jlldpaA5omsPtz9czndIYhideJASZ2BUq8Sc4PiNd1BuHXuJvB
         xqx3YzIlKcv3Sd0jll+j1p6ePjA/Gx/yMsbksjC9uJZuEwgJf/Ej+eFUq3plj9sB9GgS
         cTVQ9l5V4bq+8CRRusjy4fJMQoU/gblhIC/7/MEaFv1rA9XSJ8kPfNTmkA+NVPAjTaJn
         19kg==
X-Gm-Message-State: AFq9FYLhG56xfw0JRlOpavNyY3NmjposF5EG7iupQ0aJfenz0FjIM/Bo
	3dtmLPa3VEYSir76Bj3Op2l0p/qQ9Me6UH6vSD38oWlMJiCOPc7VlUUJo36BEzQTp/0oGtOKCwT
	NrajWUv8fTqo92jBZNYdsLD8bpHVvCR+h5h4CXuEh
X-Gm-Gg: AYBFou13bjSei9FVeXJ5UJQr6xZ7eIbXHjprslcxlqjA6qXJdxCxnon9boTnni/7u1o
	Og4/UGIhLdMnWJmR5UsX5KXTdTN5MxGkzyq8en1jy50s9UmUls0gKoMqSuRL5f3g5dfUkuF3ROK
	vWbybYby8iAHyr0/4vwc92ExXKFy5/gy+euqZ1LSFWGejbCkIPCaJL0x81RBpi4aI2JVaBk0x7l
	2jJdogXjUE59vrh3+/XNYNnflJnGJEHtGjzhHoJrqV7K8t0WuN922+Z9hgs882j5beG9c4UsvS4
	Dir4bgbJC1L4lEUouYo6tquNM254Q2Zfn7VPoIc+3IarHzEhrD7zR1sKzTFl2eIUtmta29EBV6A
	39OLvBQspbDi8ezaOnbkpmBR3vCs4r+3AhdHk9wZ3zal56JdhPUnoLa4QHGchfwkX8VQwgtL3V0
	B6ATiWidJWS5vANrI=
X-Received: by 2002:a05:6a00:1822:b0:89e:37b1:b80d with SMTP id
 d2e1a72fcca58-8a04d04decamr7640049b3a.45.1792490948959; Tue, 20 Oct 2026
 03:09:08 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com> <QDISC-BA27.v7.r0.20261019115505-4@mojatatu.com>
 <87o6cpwnh5.fsf@toke.dk> <CAM0EoMnNvr4Ep_0m78UidcEGbdE-5x8dfxbpgO1pbaVTHs4H3A@mail.gmail.com>
 <878q3svjut.fsf@toke.dk>
In-Reply-To: <878q3svjut.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 20 Oct 2026 06:08:57 -0400
X-Gm-Features: AclHuK-Ykhr61fZX0TVqaXoTjZWGfzDVqiYE77ECXlrlYf5XxolAxmj-GohDtVI
Message-ID: <CAM0EoM=rSqLatP2D72iKaeXSt95fTZvyP6wbPnvf_Ai53wq=ew@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 4:47=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> >> > +
> >> > +             segs =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_=
MASK);
> >> > +             if (IS_ERR_OR_NULL(segs))
> >> > +                     return qdisc_drop(skb, sch, to_free);
> >> > +
> >> > +             /* The split path accounts the segment sum, not the
> >> > +              * stab-adjusted qdisc_pkt_len(), so check it here.
> >> > +              */
> >> > +             skb_list_walk_safe(segs, seg, nskb)
> >> > +                     slen +=3D seg->len;
> >> > +
> >> > +             if (unlikely((u64)sch->qstats.backlog + slen > QDISC_M=
AX_BACKLOG)) {
> >> > +                     qdisc_qstats_overlimit(sch);
> >> > +                     /* __skb_gso_segment() puts SKB_GSO_CB at cb
> >> > +                      * offset 32, over tc_skb_cb.drop_reason; ever=
y
> >> > +                      * segment inherits it. Tag each one with the
> >> > +                      * qdisc drop reason.
> >> > +                      */
> >> > +                     skb_list_walk_safe(segs, seg, nskb)
> >> > +                             tcf_set_qdisc_drop_reason(seg,
> >> > +                                                       QDISC_DROP_O=
VERLIMIT);
> >> > +                     /* skb_gso_segment() moved sock_wfree to the t=
ail
> >> > +                      * segment, so defer the list to to_free rathe=
r
> >> > +                      * than free it under the qdisc lock.
> >>
> >> I don't think this part of the comment is needed - we do all the drops
> >> using to_free, so the sock_wfree thing is irrelevant.
> >
> > I was trying to rationalize "the segs =3D=3D skb fraglist". How about:
> > /* Fraglist GSO returns the original skb as head  (segs =3D=3D skb), so
> > drop our ref first */
> > I can drop it if it seems obvious
>
> Yeah, that bit is fine to keep :)
>
> >> > +                      * Fraglist GSO returns the original skb as he=
ad
> >> > +                      * (segs =3D=3D skb), so drop our ref first.
> >> > +                      */
> >> > +                     if (unlikely(segs =3D=3D skb)) {
> >> > +                             consume_skb(skb);
> >> > +                             return qdisc_drop_all(segs, sch, to_fr=
ee);
> >> > +                     }
> >> > +                     __qdisc_drop_all(segs, to_free);
> >> > +                     return qdisc_drop_reason(skb, sch, to_free,
> >> > +                                              QDISC_DROP_OVERLIMIT)=
;
> >>
> >> Since you already set the drop reason above, there's not really any
> >> reason to use qdisc_drop_reason() anymore; so this logic can be
> >> simplified to simply:
> >>
> >>                         if (unlikely(segs =3D=3D skb))
> >>                                 consume_skb(skb);
> >>                         return qdisc_drop_all(segs, sch, to_free);
> >>
> >
> > How does this look ?
> > tcf_set_qdisc_drop_reason(skb, QDISC_DROP_OVERLIMIT);
> > skb_list_walk_safe(segs, seg, nskb)
> >      tcf_set_qdisc_drop_reason(seg, QDISC_DROP_OVERLIMIT);
> >
> > if (unlikely(segs =3D=3D skb)) {
> >         consume_skb(skb);
> >         return qdisc_drop_all(segs, sch, to_free);
> > }
> > __qdisc_drop_all(segs, to_free);
> > return qdisc_drop(skb, sch, to_free);
>
> Ah, right, got the 'segs' and 'skb' variables a bit confused, sorry
> about that.
>
> But, thinking about it some more:
>
> In both branches of your code above, we have a drop of the skb, and a
> drop_all of the segs. And the existing code already has an unconditional
> consume_skb() after segmentation, where none of the post-segmentation
> uses the 'skb' pointer.
>
> So wouldn't it be simpler to just add the consume_skb() unconditionally
> immediately after the skb_gso_segment() call? Something like this, on
> top of your patch:
>
> diff --git i/net/sched/sch_cake.c w/net/sched/sch_cake.c
> index 730c90af14bd..20173aaf973c 100644
> --- i/net/sched/sch_cake.c
> +++ w/net/sched/sch_cake.c
> @@ -1819,13 +1819,17 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>         cake_hash_keys(skb, flow_mode, flow_override, host_override, &key=
s);
>
>         if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_=
SPLIT_GSO) {
> -               struct sk_buff *nskb, *seg;
>                 netdev_features_t features =3D netif_skb_features(skb);
> +               struct sk_buff *nskb, *seg;
>
>                 segs =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_MAS=
K);
>                 if (IS_ERR_OR_NULL(segs))
>                         return qdisc_drop(skb, sch, to_free);
>
> +               /* we never use the original skb after splitting */
> +               consume_skb(skb);
> +               skb =3D NULL;
> +
>                 /* The split path accounts the segment sum, not the
>                  * stab-adjusted qdisc_pkt_len(), so check it here.
>                  */
> @@ -1842,20 +1846,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struc=
t Qdisc *sch,
>                         skb_list_walk_safe(segs, seg, nskb)
>                                 tcf_set_qdisc_drop_reason(seg,
>                                                           QDISC_DROP_OVER=
LIMIT);
> -                       /* skb_gso_segment() moved sock_wfree to the tail
> -                        * segment, so defer the list to to_free rather
> -                        * than free it under the qdisc lock.
> -                        *
> -                        * Fraglist GSO returns the original skb as head
> -                        * (segs =3D=3D skb), so drop our ref first.
> -                        */
> -                       if (unlikely(segs =3D=3D skb)) {
> -                               consume_skb(skb);
> -                               return qdisc_drop_all(segs, sch, to_free)=
;
> -                       }
> -                       __qdisc_drop_all(segs, to_free);
> -                       return qdisc_drop_reason(skb, sch, to_free,
> -                                                QDISC_DROP_OVERLIMIT);
> +
> +                       return qdisc_drop_all(segs, sch, to_free);
>                 }
>         }
>
> @@ -1917,9 +1909,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>                 WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
>
>                 qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);
> -               consume_skb(skb);
>         } else {
> -               /* not splitting */
> +               /* not splitting - skb pointer still valid */
>                 int ack_pkt_len =3D 0;
>
>                 cobalt_set_enqueue_time(skb, now);
>
> >> > +             }
> >> > +     }
> >> > +
> >> > +     /* Admitted: resolve the flow. The mode is read once above, so
> >> > +      * extraction and resolution agree if cake_change() intervenes=
.
> >> > +      */
> >>
> >> The last sentence here is just distracting. Please drop.
> >>
> >
> > Ok.Will reword to: /* Admitted: resolve the flow. */
> >
> > I wont wait for the 7 days for sashiko to respond if we can reach a
> > quick consensus.
>
> Fine with me :)

I will resend with your suggestions.

pw-bot: cr

cheers,
jamal
> -Toke
