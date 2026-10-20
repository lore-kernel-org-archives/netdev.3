Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486079;
	b=UUP/uhToXzKhtaUqVVYClv8MdOxr2LDeyyb7SPN4uhZFS7W7B4tLiB5b5kJWFeF2X/2n
	 yb8616RiXbpE+U3RTthmk2VR9DCawJVRf72NdNvF85CdVpO6sh/lWKl+GN1BhMFvayg38
	 ftwk/8xOYFArU8pl6WcrfPLRDklMFes8aC6Zq+Xtov2ujDXfEYnn88LoR0p9KQLzjmhho
	 yShVpOvMvUDANiQZ3VjD1tDiM+i0XDpMx2zjAAljsPBYZHkgRjF0GuQitOT8odBpw0Ib/
	 nS0xfoYSaruDrge8BZr+4mQt6BCvPBij6VqEN7B62uEj3J5Z1PMGLUo0S6aeBRNtnQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486079;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type;
	bh=XkaU7AQU9KO+oLyNWBT/0Ji5JFYhBxgOpCvKk/9FgR0=;
	b=rUlscLsz1yMyZBivcu17RlmG/kudOgmkOD1VMTs7ERhf2Rvb9pjAMuUHFW17z6XL+5Ck
	 Fkd1JuPc90UJmvMhOlF0er5zjJUi4SrwtPGCnSWc2rRoU48ai6ypajrxG5v5smzqmPJ85
	 RcRGGSdOSZsbHftpNgh0aCPyoq+NEjXzKzUhhpAoghsSnDP4AD6MuuqXYa+iT31Q3OO8a
	 ql7kXCuIZ9fI76xHCtvPncdduf1cO2crYR9gvvxsvuS18YJKchZI/dZagHc4uwM47mZAu
	 wNWqnMbN1sugJc71HVdYYYfvt8pppTZ43gFWSskpU1Dz7PUh6UWn3UcXjnQ/vRJqzxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3A60A3802
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B3A60A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
 <bjorn@kernel.org>, cake@lists.bufferbloat.net, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v7 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
In-Reply-To: <CAM0EoMnNvr4Ep_0m78UidcEGbdE-5x8dfxbpgO1pbaVTHs4H3A@mail.gmail.com>
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
 <QDISC-BA27.v7.r0.20261019115505-4@mojatatu.com> <87o6cpwnh5.fsf@toke.dk>
 <CAM0EoMnNvr4Ep_0m78UidcEGbdE-5x8dfxbpgO1pbaVTHs4H3A@mail.gmail.com>
Date: Tue, 20 Oct 2026 10:47:54 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878q3svjut.fsf@toke.dk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

>> > +
>> > +             segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
>> > +             if (IS_ERR_OR_NULL(segs))
>> > +                     return qdisc_drop(skb, sch, to_free);
>> > +
>> > +             /* The split path accounts the segment sum, not the
>> > +              * stab-adjusted qdisc_pkt_len(), so check it here.
>> > +              */
>> > +             skb_list_walk_safe(segs, seg, nskb)
>> > +                     slen += seg->len;
>> > +
>> > +             if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {
>> > +                     qdisc_qstats_overlimit(sch);
>> > +                     /* __skb_gso_segment() puts SKB_GSO_CB at cb
>> > +                      * offset 32, over tc_skb_cb.drop_reason; every
>> > +                      * segment inherits it. Tag each one with the
>> > +                      * qdisc drop reason.
>> > +                      */
>> > +                     skb_list_walk_safe(segs, seg, nskb)
>> > +                             tcf_set_qdisc_drop_reason(seg,
>> > +                                                       QDISC_DROP_OVERLIMIT);
>> > +                     /* skb_gso_segment() moved sock_wfree to the tail
>> > +                      * segment, so defer the list to to_free rather
>> > +                      * than free it under the qdisc lock.
>>
>> I don't think this part of the comment is needed - we do all the drops
>> using to_free, so the sock_wfree thing is irrelevant.
>
> I was trying to rationalize "the segs == skb fraglist". How about:
> /* Fraglist GSO returns the original skb as head  (segs == skb), so
> drop our ref first */
> I can drop it if it seems obvious

Yeah, that bit is fine to keep :)

>> > +                      * Fraglist GSO returns the original skb as head
>> > +                      * (segs == skb), so drop our ref first.
>> > +                      */
>> > +                     if (unlikely(segs == skb)) {
>> > +                             consume_skb(skb);
>> > +                             return qdisc_drop_all(segs, sch, to_free);
>> > +                     }
>> > +                     __qdisc_drop_all(segs, to_free);
>> > +                     return qdisc_drop_reason(skb, sch, to_free,
>> > +                                              QDISC_DROP_OVERLIMIT);
>>
>> Since you already set the drop reason above, there's not really any
>> reason to use qdisc_drop_reason() anymore; so this logic can be
>> simplified to simply:
>>
>>                         if (unlikely(segs == skb))
>>                                 consume_skb(skb);
>>                         return qdisc_drop_all(segs, sch, to_free);
>>
>
> How does this look ?
> tcf_set_qdisc_drop_reason(skb, QDISC_DROP_OVERLIMIT);
> skb_list_walk_safe(segs, seg, nskb)
>      tcf_set_qdisc_drop_reason(seg, QDISC_DROP_OVERLIMIT);
>
> if (unlikely(segs == skb)) {
>         consume_skb(skb);
>         return qdisc_drop_all(segs, sch, to_free);
> }
> __qdisc_drop_all(segs, to_free);
> return qdisc_drop(skb, sch, to_free);

Ah, right, got the 'segs' and 'skb' variables a bit confused, sorry
about that.

But, thinking about it some more:

In both branches of your code above, we have a drop of the skb, and a
drop_all of the segs. And the existing code already has an unconditional
consume_skb() after segmentation, where none of the post-segmentation
uses the 'skb' pointer.

So wouldn't it be simpler to just add the consume_skb() unconditionally
immediately after the skb_gso_segment() call? Something like this, on
top of your patch:

diff --git i/net/sched/sch_cake.c w/net/sched/sch_cake.c
index 730c90af14bd..20173aaf973c 100644
--- i/net/sched/sch_cake.c
+++ w/net/sched/sch_cake.c
@@ -1819,13 +1819,17 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
        cake_hash_keys(skb, flow_mode, flow_override, host_override, &keys);
 
        if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
-               struct sk_buff *nskb, *seg;
                netdev_features_t features = netif_skb_features(skb);
+               struct sk_buff *nskb, *seg;
 
                segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
                if (IS_ERR_OR_NULL(segs))
                        return qdisc_drop(skb, sch, to_free);
 
+               /* we never use the original skb after splitting */
+               consume_skb(skb);
+               skb = NULL;
+
                /* The split path accounts the segment sum, not the
                 * stab-adjusted qdisc_pkt_len(), so check it here.
                 */
@@ -1842,20 +1846,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
                        skb_list_walk_safe(segs, seg, nskb)
                                tcf_set_qdisc_drop_reason(seg,
                                                          QDISC_DROP_OVERLIMIT);
-                       /* skb_gso_segment() moved sock_wfree to the tail
-                        * segment, so defer the list to to_free rather
-                        * than free it under the qdisc lock.
-                        *
-                        * Fraglist GSO returns the original skb as head
-                        * (segs == skb), so drop our ref first.
-                        */
-                       if (unlikely(segs == skb)) {
-                               consume_skb(skb);
-                               return qdisc_drop_all(segs, sch, to_free);
-                       }
-                       __qdisc_drop_all(segs, to_free);
-                       return qdisc_drop_reason(skb, sch, to_free,
-                                                QDISC_DROP_OVERLIMIT);
+
+                       return qdisc_drop_all(segs, sch, to_free);
                }
        }
 
@@ -1917,9 +1909,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
                WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
 
                qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);
-               consume_skb(skb);
        } else {
-               /* not splitting */
+               /* not splitting - skb pointer still valid */
                int ack_pkt_len = 0;
 
                cobalt_set_enqueue_time(skb, now);

>> > +             }
>> > +     }
>> > +
>> > +     /* Admitted: resolve the flow. The mode is read once above, so
>> > +      * extraction and resolution agree if cake_change() intervenes.
>> > +      */
>>
>> The last sentence here is just distracting. Please drop.
>>
>
> Ok.Will reword to: /* Admitted: resolve the flow. */
>
> I wont wait for the 7 days for sashiko to respond if we can reach a
> quick consensus.

Fine with me :)

-Toke
