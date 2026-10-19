Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792445745;
	b=K1wKF+2Otg/BE+hQ2k5C+lQYL3OkhLUtQAPoO3V4br1EGRSw+9at1QyGfxS8reXh99Il
	 xN5T0u1o+PPOmksT/G9N6IaQRZBrKTdGgJRIBh+1SFwQhb0AmY+yFEpfVeeKtIJetGqfA
	 SVZGEwMi+QJpaY9XSpEksLC2/r3urufbX1FUYGKP8ZNetQWA+gn3U8AmljeQV+EGhtGKR
	 EwnPVuLtS8gWV5G5HuavGFr6Mkh2fjMqFVSkAyqgzKoxUEmgwFuozEKojmEzk3pRyhKPW
	 ekmg8OGhJdUMQs5QkbFICN2eCqaVlP2CTPEONm+9x3i4OY8Fe9RRhtvbEOJwKyaQwCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=rTup29isLPRYZMrCHMspM4k8Os1ZwUgbxx5EShHoFyI=;
	b=rwWaDtqpsE+G6Eo2Jtbovmx8fmNcPuNpLYmjYUcjMuA0/biBnFZK0giFeTn0k4soQrez
	 60zPiKp1rKVPbWnSSjK6RFHZuidnr8M2Y7k39NWURDxyNY/7Ddx7SYGnMd2rwZtemHuhT
	 bIltsHzmUdD8omXkwOUg7hGZm5X9XYEI32SvAebxB7hXnQKJAUZiAwnLYs9/RfEM9msll
	 ijae8bawlcF+aSZ+PdpvRcr0/uxgYWXTBWoT6eLMQ7zVwHCx30RD3C+1wNj8byEz4dhuO
	 b2pfw6JAcvOwfpNbM9kvhL3/Zg+RN53879k589sBWqRK4GvZAc5WpfTO6wEo0FvMPdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dduLRk3X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFBD606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AFBD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=dduLRk3X
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so1641091b3a.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792445744; cv=none;
        d=google.com; s=arc-20260327;
        b=OJfEh6AaBgVILcnDIo1r5NwYXrAMHS8cSykFyirilIPbMfnuGcCbNCt67AIzTblCT7
         stUPs0kOWYshIuUHCCr1anAlsJnnFeTHOjgIVPawekLvmutBnBEUac41NlCL/q5XlgjQ
         +FSozHb59WfGrahTkvhIxOBVglW7tgcwUZoijDjpp/e6aZejjEXEVGvAv7P8DOthjJV6
         Jhcxx2QfxvFCQ8upMjjvN4uvIH5NmqYXV8Eb1X/7bu1m2nAl4CncZ419r3wQZRaI3Hm2
         4ANIkgpaQds5ua0ytWmtf1la43mrn1y9iy5a+UJD1FSKukpCls7rDkmaLZApzjrjRcRv
         81tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rTup29isLPRYZMrCHMspM4k8Os1ZwUgbxx5EShHoFyI=;
        fh=xmp1vX2ksVRtN/ju6J6bqhuSKfOgjk3q1XA6KuGu+8E=;
        b=T7JAlLmEJnmBf8ZsSZOo+yVv9ixQ6UrgRl5xRSYCruj/m8xNX/RbGBXVXrMByAcq4q
         9ORwIAXp55E/+RjoSN7NNp89XPqPHGdIq29tV9/wUllGiJl9JSL9Xp+ecVo/cxnNM4NW
         7EkopmYgXmXmwOItrcl50fVrjr872cR0uR2ipYVDG9IskuqH+Dc0yLhqlvZKgAvWUeVl
         WBDhDFwYD/B7ws3TEEmy5tv9Tqg4U4hO3zIPI81NXMw4TO9YtzEq/L6PtPbgqhyVEeuT
         zo9AQQvnZcZZpFbWfZw1MRPg5/zCMsWouVq8c8smGfzodNs5XHmvagXcvoS81+7Q1zAq
         TxrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792445744; x=1793050544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rTup29isLPRYZMrCHMspM4k8Os1ZwUgbxx5EShHoFyI=;
        b=dduLRk3Xnm/Ck0nm6hG40Vm8zk3tNvxPTZy00VJaVrnHm0cHVzWB5mJ4xZlfqA/5dc
         cAfer76ygiW2yfGvPMx0wTNsprgC2z+NNxrxTfRVgIGAjbrh1BBIn1sbCBZmbwXyEFzj
         n/LHr7go3BtkNIgBUBg1hOqSwcsH531L6dLXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445744; x=1793050544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTup29isLPRYZMrCHMspM4k8Os1ZwUgbxx5EShHoFyI=;
        b=B04zy6FTubSo5+ACMXeC6s3IS95VXFCJ6gW3Eho6PPZrzx2r9L2EdSw6IgSly8AaFk
         4j91SyJHaLmHwFBwA4f8Ko3K06lYwoFkBpFIQNrCULiwdVUmly9hXuzYX7amqK4hEbY1
         1H5KwL7aSfaAWAKxzycbqqd0TwcJl0Y0RPldK2RW4Tc9aMIECBWmqs+qpAKi5eVZl9gZ
         3HeS2uFS8jZhIRk7qHTeKdBYfTONt2IuBbKvhUgJbTVhN0rSz1DW9N4ccsvqJPsoXcSf
         ByyZ4SON+Q3aubcdT7H7Kk8Tcm9UFwL5ShQPrPawMmDPZPRw7KhlgYLig+xvd/xVNZs2
         /asg==
X-Gm-Message-State: AFq9FYLbSNur8JcnCqclQFYSY1tAxazuB4C/wCFwnFY+62xgSGNzNwqs
	L5vKnS55W320eV2ZKPV+0XDSFwAWSrrpy8puPszYKmD+P4Y6V0I+xx1+0EFHqx6p9JxKywOJrN9
	4K6ylOrBKxBCYVlK8TNMmrVlQi0N0+YZnJkGA+vBk
X-Gm-Gg: AYBFou1vbPsgy+d63svuBlZNkslK4QoPNc3Ewr+BZO7J3pH7CHwOIkeKC+dEXpdhWJ7
	SdBBajODUWBhSmGLzoz6lJp9HDjRm5wt3QfmTt90AZ7YyTOQ8DNSRD0M3oHp7z7iiGrDF5tc+LO
	NvsqW/6tVH5Kf9LTKD+uoRvyfsDGDvPcehNyATz13lBLPdMKTwVi/tRxZ5uUXKawq9DRGZ+/g2j
	VyBfkWtpVPOWaVL2ZhVJRXp1We+bqXL7LGJoV8wYSxNoDGcsPmQjR0ViNGvrPkOwSpcCgrHPhbV
	OlZRmmLS/ALDwanEx1+DFkJhwSh/tGOc6o2+3qGX3Bi8Qf5zTq8b92qL1NrGKi88GmuZrMmX/0N
	JVoFkfMmsXVU5DwimbdiIl3X+GWjm87Swiw==
X-Received: by 2002:a05:6a00:2d93:b0:891:3e34:e06f with SMTP id
 d2e1a72fcca58-8a04c248605mr6757189b3a.44.1792445744177; Mon, 19 Oct 2026
 14:35:44 -0700 (PDT)
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
 <87o6cpwnh5.fsf@toke.dk>
In-Reply-To: <87o6cpwnh5.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 19 Oct 2026 17:35:32 -0400
X-Gm-Features: AclHuK8BMeTl4BZ64Q5bXTV8MQ1sfhpPW3JZAVfYpgUa7kopAIfu68bKFzERd6Y
Message-ID: <CAM0EoMnNvr4Ep_0m78UidcEGbdE-5x8dfxbpgO1pbaVTHs4H3A@mail.gmail.com>
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

On Mon, Oct 19, 2026 at 2:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@toke.dk> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > The Fix:
> > with CAKE_FLAG_SPLIT_GSO, cake computes the flow/host hash keys, then
> > splits a GSO skb into segments it accounts individually. Key extraction
> > must run on the unsegmented skb -- skb_gso_segment() can rewrite an
> > encapsulated packet's headers to the inner ones -- and the resolution
> > must wait until the packet is admitted, since it commits the
> > set-associative tags, host indices and way counters that a later
> > rejection would leave mutated (a GSO skb whose segmentation fails was
> > dropped with that state already committed).
> >
> > Split cake_hash() into a side-effect-free cake_hash_keys(), run on the
> > unsegmented skb, and cake_hash_resolve(), run only once the packet is
> > admitted. Move the split-GSO path ahead of the resolution: sum the
> > segment list, test the total against the ceiling before linking any
> > segment, and drop the whole list on rejection so no persistent state is
> > committed. The list is deferred to to_free so the tail segment's
> > sock_wfree() never runs under the qdisc lock; a fraglist GSO, where
> > skb_segment_list() returns the original skb as the head, drops the
> > caller's reference and queues the list once instead of self-linking it.
> >
> > Tag every deferred segment with QDISC_DROP_OVERLIMIT: __skb_gso_segment=
()
> > keeps SKB_GSO_CB at cb offset 32, aliasing tc_skb_cb.drop_reason, and
> > __copy_skb_header() copies it into every segment, so tagging only the
> > head left the rest with GSO scratch (a headroom-sized value) as their
> > drop reason, which __tcf_kfree_skb_list() would report as an unrelated
> > core reason.
> >
> > Read q->config->flow_mode once with READ_ONCE() in cake_enqueue() and
> > pass that value to both cake_hash_keys() and cake_hash_resolve().
> > cake_config_change() writes the mode before cake_change() takes
> > sch_tree_lock(), and the split introduced two separate loads with the
> > segmentation work between them; a concurrent reconfiguration could
> > extract keys in one mode and resolve them in another.
> >
> > Link: https://lore.kernel.org/netdev/179231933068.3135.8034079263307798=
6@kernel.org/
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v6 -> v7: the split-GSO reject path now sets QDISC_DROP_OVERLIMIT on
> > every deferred segment, not only on the head/original skb; the GSO cb
> > aliases tc_skb_cb.drop_reason and is copied into every segment, so
> > untagged segments carried GSO scratch as their drop reason. The
> > flow_mode is likewise snapshotted once with READ_ONCE() and passed to
> > both cake_hash_keys() and cake_hash_resolve(). (Sashiko nipa v6
> > review, gpt-6-astra-2-5, gpt-6-astra-5-9)
> > ---
> >  net/sched/sch_cake.c | 130 ++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 99 insertions(+), 31 deletions(-)
> >
> > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> > index 91c33295b30b..730c90af14bd 100644
> > --- a/net/sched/sch_cake.c
> > +++ b/net/sched/sch_cake.c
> > @@ -706,19 +706,28 @@ static u16 cake_get_flow_quantum(struct cake_tin_=
data *q,
> >               get_random_u16()) >> 16;
> >  }
> >
> > -static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *sk=
b,
> > -                  int flow_mode, u16 flow_override, u16 host_override)
> > +struct cake_hash_keys {
> > +     u32 srchost_hash;
> > +     u32 dsthost_hash;
> > +     u32 flow_hash;
> > +};
> > +
> > +static void cake_hash_keys(const struct sk_buff *skb, int flow_mode,
> > +                        u16 flow_override, u16 host_override,
> > +                        struct cake_hash_keys *out)
> >  {
> >       bool hash_flows =3D (!flow_override && !!(flow_mode & CAKE_FLOW_F=
LOWS));
> >       bool hash_hosts =3D (!host_override && !!(flow_mode & CAKE_FLOW_H=
OSTS));
> >       bool nat_enabled =3D !!(flow_mode & CAKE_FLOW_NAT_FLAG);
> > -     u32 flow_hash =3D 0, srchost_hash =3D 0, dsthost_hash =3D 0;
> > -     u16 reduced_hash, srchost_idx, dsthost_idx;
> >       struct flow_keys keys, host_keys;
> >       bool use_skbhash =3D skb->l4_hash;
> >
> > +     out->flow_hash =3D 0;
> > +     out->srchost_hash =3D 0;
> > +     out->dsthost_hash =3D 0;
> > +
> >       if (unlikely(flow_mode =3D=3D CAKE_FLOW_NONE))
> > -             return 0;
> > +             return;
> >
> >       /* If both overrides are set, or we can use the SKB hash and nat =
mode is
> >        * disabled, we can skip packet dissection entirely. If nat mode =
is
> > @@ -753,50 +762,64 @@ static u32 cake_hash(struct cake_tin_data *q, con=
st struct sk_buff *skb,
> >       switch (host_keys.control.addr_type) {
> >       case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
> >               host_keys.addrs.v4addrs.src =3D 0;
> > -             dsthost_hash =3D flow_hash_from_keys(&host_keys);
> > +             out->dsthost_hash =3D flow_hash_from_keys(&host_keys);
> >               host_keys.addrs.v4addrs.src =3D keys.addrs.v4addrs.src;
> >               host_keys.addrs.v4addrs.dst =3D 0;
> > -             srchost_hash =3D flow_hash_from_keys(&host_keys);
> > +             out->srchost_hash =3D flow_hash_from_keys(&host_keys);
> >               break;
> >
> >       case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
> >               memset(&host_keys.addrs.v6addrs.src, 0,
> >                      sizeof(host_keys.addrs.v6addrs.src));
> > -             dsthost_hash =3D flow_hash_from_keys(&host_keys);
> > +             out->dsthost_hash =3D flow_hash_from_keys(&host_keys);
> >               host_keys.addrs.v6addrs.src =3D keys.addrs.v6addrs.src;
> >               memset(&host_keys.addrs.v6addrs.dst, 0,
> >                      sizeof(host_keys.addrs.v6addrs.dst));
> > -             srchost_hash =3D flow_hash_from_keys(&host_keys);
> > +             out->srchost_hash =3D flow_hash_from_keys(&host_keys);
> >               break;
> >
> >       default:
> > -             dsthost_hash =3D 0;
> > -             srchost_hash =3D 0;
> > +             out->dsthost_hash =3D 0;
> > +             out->srchost_hash =3D 0;
> >       }
> >
> >       /* This *must* be after the above switch, since as a
> >        * side-effect it sorts the src and dst addresses.
> >        */
> >       if (hash_flows && !use_skbhash)
> > -             flow_hash =3D flow_hash_from_keys(&keys);
> > +             out->flow_hash =3D flow_hash_from_keys(&keys);
> >
> >  skip_hash:
> >       if (flow_override)
> > -             flow_hash =3D flow_override - 1;
> > +             out->flow_hash =3D flow_override - 1;
> >       else if (use_skbhash && (flow_mode & CAKE_FLOW_FLOWS))
> > -             flow_hash =3D skb->hash;
> > +             out->flow_hash =3D skb->hash;
> >       if (host_override) {
> > -             dsthost_hash =3D host_override - 1;
> > -             srchost_hash =3D host_override - 1;
> > +             out->dsthost_hash =3D host_override - 1;
> > +             out->srchost_hash =3D host_override - 1;
> >       }
> >
> >       if (!(flow_mode & CAKE_FLOW_FLOWS)) {
> >               if (flow_mode & CAKE_FLOW_SRC_IP)
> > -                     flow_hash ^=3D srchost_hash;
> > +                     out->flow_hash ^=3D out->srchost_hash;
> >
> >               if (flow_mode & CAKE_FLOW_DST_IP)
> > -                     flow_hash ^=3D dsthost_hash;
> > +                     out->flow_hash ^=3D out->dsthost_hash;
> >       }
> > +}
> > +
> > +/* Commit the flow into the set-associative table (q->tags[], host
> > + * indices, bulk counters). Only after the packet is admitted.
> > + */
> > +static u32 cake_hash_resolve(struct cake_tin_data *q,
> > +                          const struct cake_hash_keys *keys, int flow_=
mode)
> > +{
> > +     u32 flow_hash =3D keys->flow_hash, srchost_hash =3D keys->srchost=
_hash,
> > +         dsthost_hash =3D keys->dsthost_hash;
> > +     u16 reduced_hash, srchost_idx, dsthost_idx;
> > +
> > +     if (unlikely(flow_mode =3D=3D CAKE_FLOW_NONE))
> > +             return 0;
> >
> >       reduced_hash =3D flow_hash % CAKE_QUEUES;
> >
> > @@ -1761,13 +1784,17 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >  {
> >       u32 idx, tin, prev_qlen, prev_backlog, drop_id;
> >       struct cake_sched_data *q =3D qdisc_priv(sch);
> > +     int flow_mode =3D READ_ONCE(q->config->flow_mode);
>
> This breaks the reverse x-mas tree ordering. Move the u32 defs below,
> and keep an empty line after the qdisc_priv() resolution?
>
> >       int len =3D qdisc_pkt_len(skb), ret;
> >       u16 flow_override, host_override;
> > +     struct sk_buff *segs =3D NULL;
> > +     struct cake_hash_keys keys;
> >       struct sk_buff *ack =3D NULL;
> >       ktime_t now =3D ktime_get();
> >       struct cake_tin_data *b;
> >       struct cake_flow *flow;
> >       bool same_flow =3D false;
> > +     u64 slen =3D 0;
> >
> >       /* Classify first: a terminal TC action consumes the packet. */
> >       if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &=
ret)) {
> > @@ -1784,12 +1811,59 @@ static s32 cake_enqueue(struct sk_buff *skb, st=
ruct Qdisc *sch,
> >                                        QDISC_DROP_OVERLIMIT);
> >       }
> >
> > -     /* choose flow to insert into */
> > +     /* Select the tin and extract the keys before segmenting:
> > +      * skb_gso_segment() rewrites encapsulated headers, which
> > +      * changes the keys.
> > +      */
> >       b =3D cake_select_tin(sch, skb);
> > -     idx =3D cake_hash(b, skb, q->config->flow_mode, flow_override,
> > -                     host_override) + 1;
> > +     cake_hash_keys(skb, flow_mode, flow_override, host_override, &key=
s);
> > +
> > +     if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_=
SPLIT_GSO) {
> > +             struct sk_buff *nskb, *seg;
> > +             netdev_features_t features =3D netif_skb_features(skb);
>
> Reverse x-mas tree, please.

Grrr...

> > +
> > +             segs =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_MAS=
K);
> > +             if (IS_ERR_OR_NULL(segs))
> > +                     return qdisc_drop(skb, sch, to_free);
> > +
> > +             /* The split path accounts the segment sum, not the
> > +              * stab-adjusted qdisc_pkt_len(), so check it here.
> > +              */
> > +             skb_list_walk_safe(segs, seg, nskb)
> > +                     slen +=3D seg->len;
> > +
> > +             if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_=
BACKLOG)) {
> > +                     qdisc_qstats_overlimit(sch);
> > +                     /* __skb_gso_segment() puts SKB_GSO_CB at cb
> > +                      * offset 32, over tc_skb_cb.drop_reason; every
> > +                      * segment inherits it. Tag each one with the
> > +                      * qdisc drop reason.
> > +                      */
> > +                     skb_list_walk_safe(segs, seg, nskb)
> > +                             tcf_set_qdisc_drop_reason(seg,
> > +                                                       QDISC_DROP_OVER=
LIMIT);
> > +                     /* skb_gso_segment() moved sock_wfree to the tail
> > +                      * segment, so defer the list to to_free rather
> > +                      * than free it under the qdisc lock.
>
> I don't think this part of the comment is needed - we do all the drops
> using to_free, so the sock_wfree thing is irrelevant.

I was trying to rationalize "the segs =3D=3D skb fraglist". How about:
/* Fraglist GSO returns the original skb as head  (segs =3D=3D skb), so
drop our ref first */
I can drop it if it seems obvious

> > +                      * Fraglist GSO returns the original skb as head
> > +                      * (segs =3D=3D skb), so drop our ref first.
> > +                      */
> > +                     if (unlikely(segs =3D=3D skb)) {
> > +                             consume_skb(skb);
> > +                             return qdisc_drop_all(segs, sch, to_free)=
;
> > +                     }
> > +                     __qdisc_drop_all(segs, to_free);
> > +                     return qdisc_drop_reason(skb, sch, to_free,
> > +                                              QDISC_DROP_OVERLIMIT);
>
> Since you already set the drop reason above, there's not really any
> reason to use qdisc_drop_reason() anymore; so this logic can be
> simplified to simply:
>
>                         if (unlikely(segs =3D=3D skb))
>                                 consume_skb(skb);
>                         return qdisc_drop_all(segs, sch, to_free);
>

How does this look ?
tcf_set_qdisc_drop_reason(skb, QDISC_DROP_OVERLIMIT);
skb_list_walk_safe(segs, seg, nskb)
     tcf_set_qdisc_drop_reason(seg, QDISC_DROP_OVERLIMIT);

if (unlikely(segs =3D=3D skb)) {
        consume_skb(skb);
        return qdisc_drop_all(segs, sch, to_free);
}
__qdisc_drop_all(segs, to_free);
return qdisc_drop(skb, sch, to_free);

> > +             }
> > +     }
> > +
> > +     /* Admitted: resolve the flow. The mode is read once above, so
> > +      * extraction and resolution agree if cake_change() intervenes.
> > +      */
>
> The last sentence here is just distracting. Please drop.
>

Ok.Will reword to: /* Admitted: resolve the flow. */

I wont wait for the 7 days for sashiko to respond if we can reach a
quick consensus.

cheers,
jamal

> > +     idx =3D cake_hash_resolve(b, &keys, flow_mode);
> >       tin =3D (u32)(b - q->tins);
> > -     idx--;
> >       flow =3D &b->flows[idx];
> >
> >       /* ensure shaper state isn't stale */
> > @@ -1816,14 +1890,9 @@ static s32 cake_enqueue(struct sk_buff *skb, str=
uct Qdisc *sch,
> >       if (unlikely(len > b->max_skblen))
> >               WRITE_ONCE(b->max_skblen, len);
> >
> > -     if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_=
SPLIT_GSO) {
> > -             struct sk_buff *segs, *nskb, *seg;
> > -             netdev_features_t features =3D netif_skb_features(skb);
> > -             unsigned int slen =3D 0, numsegs =3D 0;
> > -
> > -             segs =3D skb_gso_segment(skb, features & ~NETIF_F_GSO_MAS=
K);
> > -             if (IS_ERR_OR_NULL(segs))
> > -                     return qdisc_drop(skb, sch, to_free);
> > +     if (segs) {
> > +             struct sk_buff *nskb, *seg;
> > +             unsigned int numsegs =3D 0;
> >
> >               skb_list_walk_safe(segs, seg, nskb) {
> >                       skb_mark_not_on_list(seg);
> > @@ -1837,7 +1906,6 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
> >                       qdisc_qlen_inc(sch);
> >                       numsegs++;
> >                       q->buffer_used +=3D seg->truesize;
> > -                     slen +=3D seg->len;
> >                       WRITE_ONCE(b->packets, b->packets + 1);
> >               }
> >
> > --
> > 2.43.0
