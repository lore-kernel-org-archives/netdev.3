Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793305393;
	b=WCn+TL3WyxZrANnLMaSSb2PJglLzkB/j5lpZJLOsO4dJf+mDwBHQD1FDuQbzejBqEgAz
	 fGO+EfQ8EsgSxwYxrSH1xxtMz5rEIdnPBoS0IPd401yBbhBH0wq0CC0hLqhd9cDvSj0SQ
	 2L4rYKZop6E7XIQ0ahojwOudd4MRTE6p85Iw0B3CJ1R16kziuqRP/1GXJdqYYPsADJKLA
	 y9HQ/YQ+7LSnHusF1xGF1W0Peo0s9v+jAJB3Qh9ePNrM1Vy9aWKWFhUEfZZTZ0RwzPv57
	 1Z79UlYTN1eFr926kXsAC+WyKkiV44/U6GMdLkN0x88bMzkZKSBZg8pTUVJJwIy1TIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
	b=qvcpUcsehk7i5LGeC+pB7S2xfd0o2N2urvlEExw6DbW8/Y5qpvAL6+G3EwbFHWrc9K4Q
	 KUlFpfYog21rxe03zUG7a1b4SzCrISArBxyLaXapQNRf5tXJcavmxQ/CJYkMEQLK+OdmT
	 NDiBA8NXLLZsNiizZM0WbrSa6YyMMptdRc5spD8cam8Cq0QRc5CTo2uXuF/TENkQAIh0Z
	 /+7XMaZdYHM8XAkBF49H+QoJA+sYHP63LA2OcGf90fAhr4lg7m5udryoTIsc1OdjBDCV+
	 tp47NU4V5PkEkPzX3WeIa54Xe64P52wXGncP+we1t9C8EYwrxuMTC5kHgzpd6qpsr1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DCFa4tpF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E5606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 20:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 396E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=DCFa4tpF
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06b436dffso1233604b3a.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793305393; cv=none;
        d=google.com; s=arc-20260327;
        b=amQWor1k/aGFU3baLmjMZ0fnuqEjTwEyBvHrIqlfj/zRFTFPwWIBVC+knLKMe6TUuR
         +CsUVVXw9KirCOO9xstj4wUz/su7BckjbjE/uabVGdonbb6TkosroZuRK6sYMXNbzsky
         rGkROsTrelv9EtZflqcUKEOcfESYkBes1SUatwAfm9o+CiTXyLekHwMZfVjz4zpet1nt
         cMGvCEBKcgrlaeq3Ja4zXzgRabvrJqpS6N8Pep15x4531zJ0rqU7YzzoycDP6brkZ+VK
         W0r8DaaNErB9kRl8JZRrbWeHbIhUMm45llIWRo3tc4zZHFDfrmDKlNuQnT4SYzx7vNtU
         pYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
        fh=T/3HATjMC9Bm0BKxFWeAh0aHMwVZYv/i9Crbl5nNz/0=;
        b=iMSZqIjE+oMtxHICXXBVDyU1wql8iQ+S59be1saXsPv5WRkMwror1AoCfK0tbTo+pF
         T7ENr0uzdGf20DAm1dSnEjTU+NP/1EiWXHp+kSRfcm3cvQNgjVTSJJi/QRC15JqvsDiZ
         01KIfGIs76s0Cnru3C0pz2KwJqIIBv0UtkR7R53qts/KZxNTN7AN5xbETGnId9GUrnfa
         yLbVvWFF3+xF4TNcdSzdV0IVZebH+S/fIno1PhEpSoCbzRcdCxmdFuwkFChExxpRtsZK
         NVeQin48g4oOegtXXboWR7kNW0TO72VJ6+YcclITkg7QFEo156ZSaZJw9HeeTVaO4F2y
         QWUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793305393; x=1793910193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
        b=DCFa4tpFU0JSr9iQ7diE++luzxQ5lxOD6TczsNDy2QqLo92I2egzlVw1qcysnCz93N
         s6ql5/7+oQezo8DBowqeXXa9c8WfQ3zMl4w+7O92iRH6oMZrR8WF5EBV646rDEuotP72
         KvFs+MPPUZgQ+HQWUEFvRuggKXx97dMdbZcfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305393; x=1793910193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KiIhvG8lOlwQG0lb7m/oiOyUeW6Fz+zTOcXywbar0lE=;
        b=ZOVmBzZZHHp2lY8pO3n3mzjX/tpsZdOm0dW0tFenGqT+TjZLEO3BwBkJIIEGsqdRP/
         I7TYmDo5pFDgds3/XGi7WXZTueJr0RV3o1QnPC/iaG19yDMUoRCqrEXiFwfJWVHTq5OI
         tnKHfEfLDYxmNsSN5C4sNddnGOnz4t0shwqHBS3oERphqaHJ22CjUDbwnHCV+Lk2UPjD
         OB+izUss/1Lmcezh+P6vu51B5SGmi1rZzvORNK9XsJOhsYBIJpTZ7dtOgDZsdV33KTNL
         Fw+smmzJttEdASZhhmuEyVdaEq+Jg8iDkUCy332/twPCHG02vqLXmOwaNqjFBvMks3cL
         OMbw==
X-Gm-Message-State: AFq9FYLjwNaH0erA6yxHKAxGACtW+iYvyMZ0MgWqLOC//OI4xR5zBcUJ
	A0QKaDIdMVGoKejuIA0V4t4kVi4Z1DxOheZ7O9O+2bjfFkd+0HSOIadInCe+dAFkH7e2hbHjhZ9
	jFsXNqbehoZwdkNGaMPqHqJkCYbzsJkE881MK9Cdk
X-Gm-Gg: AYBFou3zeo6MWe+jLxnywSkRDWHKoWqoigdiqvsMzUriliGBCqc8O93SIqHpyxu9eHO
	7gLKy1OzGYW0vh6FuBEdNXwFoOuFPOqXDbV8BM0WC0rK+2wlkPhtokeIKQh1dvY54ezsO5MyZFh
	gOQAWs7vGhmo3dk9Fnv6NbZnISHctXsMjDxsyH4XC3PyTJWVBOEU2UK37YL+9Zt5Jhh3Z1cK3RR
	aF72fzZ0ZGsp+DzDzQgr6CKCRdWGtmxO6xQx3+xQ0cq6FYsz1NvXTOAX7lN2+UUDrV55SeLEdJo
	tWpwDZJqjjY4ar/cak9G0aAu9moIXYw49YbBSbJWTi3CwKsidUTBUIahJ1YlPF+OZmhbSZZGvPI
	UMGwVb7ODVMjTHhIG/SN8IHBwOJt1M169EsBIwr05Lgf+PRBsqLDkn/PB6WYQKxrXdwKcTudbjo
	JACOvD2kH2dDhW/7w=
X-Received: by 2002:a05:6a00:1814:b0:898:3898:3826 with SMTP id
 d2e1a72fcca58-8a9be58914bmr217096b3a.14.1793305392573; Thu, 29 Oct 2026
 13:23:12 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-MD1X.v5.r0.20261026053226-1@mojatatu.com> <179329777513.3134.12135506558709584471@kernel.org>
In-Reply-To: <179329777513.3134.12135506558709584471@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Oct 2026 16:23:01 -0400
X-Gm-Features: AclHuK81fdOF3hQJNx2mlfsMkazycSpdb9h0JGAAUY4VUhgLcYcrWN6YKU1fFJc
Message-ID: <CAM0EoMm_3=sHFEcoynZpNMb_Y2sT=a8WZeKz_2Ewn4eo9rfJ_g@mail.gmail.com>
Subject: Re: [PATCH net v5] net/sched: clamp skb->queue_mapping before
 indexing the tx queue
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	vinicius.gomes@intel.com, horms@kernel.org, hawk@kernel.org, 
	daniel@iogearbox.net, sashiko-bot@kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 2:16=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch silently changes behaviour on stable kernels, and
>   its commit message and docs do not describe the change accurately.
>

sigh. Exhausting. I will send v6 with the commit message fixed.

cheers,
jamal

> --
>
> net/sched: clamp skb->queue_mapping before indexing the tx queue
>
> A tc BPF store can leave skb->queue_mapping out of range. This patch caps
> it in the qdisc dequeue paths in sch_generic.c and in taprio_enqueue(), s=
o
> it can no longer index dev->_tx[] or q->qdiscs[] out of bounds. On a
> TCQ_F_ONETXQUEUE qdisc the mapping is pinned to the qdisc's own
> q->dev_queue instead of being capped to queue 0.
>
> Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994=
398206@kernel.org/
> Link: https://lore.kernel.org/netdev/179293123940.3134.114912867992323467=
7@kernel.org/
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v4.r=
0.20261021042722-1%40mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r=
0.20261015165943-1%40mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.2=
0261005193231%40mojatatu.com
> Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.=
org/
>
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 6f6a6f0d5eb0..5dc1d47f811a 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -96,9 +96,34 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q=
,
> >
> >  #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
> >
> > +/* Re-cap a stale queue_mapping; an ONETXQUEUE qdisc pins q->dev_queue=
. */
> > +static u16 qdisc_cap_skb_tx_queue(struct Qdisc *q, struct sk_buff *skb=
)
> > +{
> > +     u16 queue =3D skb_get_queue_mapping(skb);
> > +     struct net_device *dev =3D qdisc_dev(q);
> > +     u16 capped;
> > +
> > +     if (q->flags & TCQ_F_ONETXQUEUE)
> > +             capped =3D q->dev_queue - netdev_get_tx_queue(dev, 0);
> > +     else
> > +             capped =3D netdev_cap_txqueue(dev, queue);
>
> [Severity: Medium]
>
> On a TCQ_F_ONETXQUEUE qdisc, this branch rewrites the mapping of every sk=
b,
> not just the out-of-range ones. Is that intended for in-range mappings th=
at
> a classifier sets on purpose?
>
> The rewrite happens in several places. dequeue_skb() applies it to the he=
ad
> skb and to gso_skb. try_bulk_dequeue_skb() applies it to each follower.
> __skb_dequeue_bad_txq() applies it to skbs taken from skb_bad_txq.
>
> Here is one way to hit it. Take a per-queue child of mq, mqprio, taprio o=
r
> htb offload whose q->dev_queue is txq i. A filter on that child can run
> "action skbedit queue_mapping j" with j !=3D i and j < real_num_tx_queues=
.
> tcf_skbedit_act() accepts that value:
>
> net/sched/act_skbedit.c:tcf_skbedit_act() {
>     ...
>         if (params->flags & SKBEDIT_F_QUEUE_MAPPING &&
>             skb->dev->real_num_tx_queues > params->queue_mapping) {
>                 if (skb_at_tc_egress(skb))
>                         netdev_xmit_skip_txqueue(true);
>                 skb_set_queue_mapping(skb, tcf_skbedit_hash(params, skb))=
;
>         }
>     ...
> }
>
> A tc BPF store of an in-range value behaves the same way.
>
> Before this patch, qdisc_restart() sent the packet on
> skb_get_tx_queue(dev, skb), which is queue j. With this patch,
> dequeue_skb()->qdisc_cap_skb_tx_queue() first rewrites j back to i. The
> packet then goes out on queue i, and nothing is logged.
>
> The commit message says:
>
>     netdev_cap_txqueue() already logs a ratelimited notice and selects
>     queue 0.
>
> The TCQ_F_ONETXQUEUE branch never calls netdev_cap_txqueue(), though. Tha=
t
> also covers the 1-queue reproducer in the commit message, because
> qdisc_create() sets the flag on every non-multiqueue device:
>
> net/sched/sch_api.c:qdisc_create() {
>     ...
>                 if (!netif_is_multiqueue(dev))
>                         sch->flags |=3D TCQ_F_ONETXQUEUE;
>     ...
> }
>
> So in that reproducer, a store of 1 from the filter on the prio root is
> quietly pinned to 0, with no notice.
>
> The only place that says in-range mappings from a filter on a per-queue
> child are now overridden is the v4 -> v5 note below the "---". git am dro=
ps
> that part, and the patch is tagged for stable.
>
> Documentation/networking/tc-queue-filters.rst also still says:
>
>     2) TC filter directs traffic to a transmit queue with the action
>        skbedit queue_mapping $tx_qid.
>
> It does not limit where the filter can be attached.
>
> Could the commit message describe the pinning of in-range mappings, and t=
he
> missing log message on the TCQ_F_ONETXQUEUE path? Should the documentatio=
n
> be updated to match?
>
> > +
> > +     if (unlikely(capped !=3D queue))
> > +             skb_set_queue_mapping(skb, capped);
> > +
> > +     return capped;
> > +}
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-MD1X.v5.r0.20261026053226-1%40mojatatu.com
