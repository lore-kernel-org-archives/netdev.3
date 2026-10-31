Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793470684;
	b=cqtwO7ziapjOH6JdDny/pujLslqj3CH5ZVTUTyvPNRLTZs/QRW1xpwrjsa+kX2a/aF0L
	 JUC2C4qWQt5xZg/CPwgSzTMCh9Zr0hDIGbprbxLrzbbs/+mPasQza4FlgfFBta64GTUXq
	 xhjDtgmkGZfayDroE372o8PSQOz+KfAcZ9OnUADyq2aQrLZpeAXPDaZw5EVccxMOW2n/9
	 6Uhz6654XxzdQ58a178mS91RWwNdRU63gb6XNBzXHa+9HdIIbufjfl0f3Ddwod2kuQKPK
	 2OujDXamZYxWboJv5Z9NISvBSkbTls9eYoKcHJodK3hITJAGAszpEJkogFPgHYW7IyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Xf+2jr2yCEKrSYu/5k7hH7BT6BJHrV0c3wg3u2rwgjQ=;
	b=PvLHOx+zntr4P/zccNu3ticoxb7tBMF0S2spSs+ojrU/re5kDKhaV6eX5x6E2zUJRhhP
	 u5RQcEWkPV7LvIAnCqVz3eQxqUKVq95bLSuQutbdkd9ugX7REYPWodlNYYpIyDTq6NDko
	 syaU+KVzkRDqd7TJNcvKgCCgdckT6lHfHi+XcpGKax/1sIz0IlvPCVnjtJVz65z1UOo86
	 LM7+3JPor0ORAiz8vVNWAHXawl/+XPc7+V+Hfl96vJnC+OXoRe9bcPr5IrBvdjPXb7Esq
	 MS5GIZKWubQQMHZvK1jUeUXn6Yc/+gn0cboFrLX9LqlMG9GUTlw8GgsECRLc8ATyJ6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rZBvgQKd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8991606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 18:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8991606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rZBvgQKd
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so805808b3a.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 11:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793470683; cv=none;
        d=google.com; s=arc-20260327;
        b=bmFvgFxX7wP0UDvE7blMhXs6NQ6UcgKkATbZ0mYiiuOyDwGNTM3I/l2aczi5f9efiu
         nRGTuSbXa9sul7ppYZSsgZ5FUjvz7iao0AY6kA3Y+9dCZ3IweHn69wQA4u0Wp5Ix3hJs
         W2xfn3kRQmgRGFk9MFitMnEV6lj/0cb4EDotOROHatCfasOjeQPRzaql2MMEQcqlT1F9
         lcxS7n9pIqmtReT/HBOPwM+FEI/ulBMk7q8IW0nLwoBBx9gJCGldaVCpVEq9Gxmja4jm
         wC9adQblcN16jKVy2MKn79ELRHe+inRS0HT+hyX8KFpfkchaWSufLo7m4lBfP6B/ENcI
         Yovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xf+2jr2yCEKrSYu/5k7hH7BT6BJHrV0c3wg3u2rwgjQ=;
        fh=xQcTKnSGwzhLr7lZiz8uL7QOkG/FimUkqhZX65QOsC8=;
        b=ROKmzPoHlJQIADLL5ZowNWan3Jjcn1lxkdMCgx/l0ODMwjY3E+7sGWXmh5sJIO7Eka
         rUjvbJswzP9KX2X7PLukGnCMhikmVQ/af71IJ0IJevPy1uhYagImdIyQcK9gbIRh/ML6
         wdHp5jjqhP+4yrvFBvmWzH2iTEuUC/mti0wIlFXHu2y69rf8kZBOuMzVtYvm0bALzgtm
         f7honGk1Ktw3XAWZG/lXsK8wMhUQ/R9vSodaISEUOPeloHbzZzxQdu2FXaWBxnyqlg6B
         NpO2KRejV+GLO9EOEZrE4x9Ae+EYamEDEtqD3STHdDGzqKpHD++AK+kQ0Gg+vqduTrbX
         +cIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793470683; x=1794075483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xf+2jr2yCEKrSYu/5k7hH7BT6BJHrV0c3wg3u2rwgjQ=;
        b=rZBvgQKd87Txw/Gs3OoRgvbztT8csNg6OK5eT2Ppu9DAGr2tA1RhVR5uYTjP8OhkK8
         JjVCXXcFz7XhJjFI4/WcHzKPKnrbTejPRe+FKpSVDx2e6jaNxktbzQybNqC3FlJffqEM
         EhdW7Ht+n6Ev3PNFP3x33p4MeNhG4noxkCggQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793470683; x=1794075483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xf+2jr2yCEKrSYu/5k7hH7BT6BJHrV0c3wg3u2rwgjQ=;
        b=HJy68LBNs+Yhkrf5urT3LXwnuXDl5XQEZ/ls1WYcTJGM+xsI10CcSO6LcosNRiWHHZ
         YIbD8R9O0oXE79xD+J/R7CldCb0UT1RuR6H9OXoIOvM0DoG/C77sWhL8yIfbpgOYzw2z
         DgXR7PzThHlrjlboluLyqNGW5aHX7Kf2d4m8eVfmvCFj9aOgoUM1Uxj2XfTCgKCd+93z
         XiXJy7epblemOrkbPOCA41AvVvyNbRPcOToEW+XNJPYuCBzn1Mv2srFqDxeLPUmI2NzE
         RRmXl1SU/a57AV7WFWYwlln0B8yCYhxwTxpDf9k+ndcJ27rZKWE7wmp4O2nzIQFfKxqR
         FdKQ==
X-Gm-Message-State: AFq9FYJYDy9rDfAxHhTkK9TIu48FJfEH7zLHhqq3jAeCUV38EbIIbXHb
	c1zSuzoU9esCYZM/dfhUKxJbwlcJYuNgc1M8HDM/yW8Xa/bNUjrng9NeAnz7AQvKiXjHic5cyIx
	5nReKcTBWK3MPu6wOgr/vCPL7lNQfQZDFVtqo9vbV
X-Gm-Gg: AYBFou2M5dtURfJSqRdSQznivsE9Ko8omHkDlkhAgomPwGLwAgJo5iFU3O+omPAAmyM
	3ainmkraBSj8r29YHKrVD9GX+bD6ldtuGSXo8STg5FM6V7FShGltiXyRMLshGEygPk0EN+NyZ5C
	ukSVpIkVpsREzruHzhtI1DxypyfNVSa2klK64p8ojDv7CjDHnv/OqJ2xWLeBm21xENJCdDwKV/1
	DLLZLcrqmB6dcdht0iiQuNSCPddNLZDDm2OmJOuQZ3kprzcBZMJjZdVFqKt/5Bf6K3SxmxdU76I
	LdiqjPdG+qrn+p1aM6vg68lPtwXRxBnTryDeEA2UtSxr1DKM/BVMtvheEqUZpYvO023mKgEh/md
	N2gdjyIXQRiJEJjGfM9A6B4ILHMQe47zmHlRlZ9kjyGfwtu50ChZg7t2yI53xxZrrj/jNoMzG4k
	lCWss45TQr9VvtXH7F
X-Received: by 2002:a05:6a00:12c2:b0:8a9:95d6:31f4 with SMTP id
 d2e1a72fcca58-8a9beb69affmr4990553b3a.32.1793470682913; Sat, 31 Oct 2026
 11:18:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r3.20261027034729-2@mojatatu.com> <20261031165925.780930-1-horms@kernel.org>
In-Reply-To: <20261031165925.780930-1-horms@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Oct 2026 14:17:49 -0400
X-Gm-Features: AclHuK-iYfsqzRZDDx_HCRa4NQIrG7hm6ImBp8-ZBw71JJWJs4Y8qK7bbqFbMzQ
Message-ID: <CAM0EoMkDCpxtN6EqUMjQ_s7+F--JJQWXviE+wBQjc3vx-+HUjg@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost3] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 1:00=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email says "Sorry Jamal, another round of AI-feedback for this one.
> It is superficually simliar to the \AI-generated feedback for
> repost2, but does raise some specific points that I think warrant
> you expressing an opinion on. Thanks!"
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC=
-6HS9.v1.r3.20261027034729-1@mojatatu.com?part=3D2
> ---
> net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
>
> This patch makes teql_master_xmit() set skb->dev to the slave before
> calling teql_resolve(). An skb parked on the slave's arp_queue then no
> longer points at the teql master. It also makes
> neigh_update_process_arp_queue() set skb->dev =3D n1->dev before it
> reinjects queued skbs.
>

Man, this thing is relentless (double edged sword, i like it's
improving the code but on the other side it's sucking my time with
more pedantry than I have ever been subjected to by any human, and i
have met human pedantry).
Like ive said in other emails: No good deed goes unpunished by this thing.

To be fair: nipa's repost2 review was on the mark already - i should
have invested more time analyzing.

cheers,
jamal

(I am finding myself using that word now and other annoying words like
"shape", etc)
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
>
> > The master can be freed while the slave lives, so the
> > queued skb can dereference freed memory.
>
> [Severity: Low]
> Could the commit message say how the master gets freed? As far as I can
> tell, teql_exit() is the only place that frees the master net_device, and
> it only runs on module unload:
>
> net/sched/sch_teql.c:teql_exit() {
>     ...
>         unregister_qdisc(&master->qops);
>         unregister_netdev(master->dev);
>         free_netdev(master->dev);
>     ...
> }
>
> teql_master_setup() never sets rtnl_link_ops, so rtnl_delete_link()
> refuses to delete the master:
>
>         ops =3D dev->rtnl_link_ops;
>         if (!ops || !ops->dellink)
>                 return -EOPNOTSUPP;
>
> default_device_exit_net() moves devices like this back to init_net
> instead of freeing them, so destroying a netns doesn't free it either.
>
> That leaves one window. Every teql qdisc has been removed from the
> slaves, an skb is still sitting on a slave neighbour's arp_queue with
> skb->dev pointing at the master, and then sch_teql is unloaded. The
> unload needs CAP_SYS_MODULE.
>
> This is the justification for a stable-bound change to shared neighbour
> reinjection. Would it help to describe this rmmod-only trigger in the
> message?
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index d6e9c7c59a892..120c3369406fb 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1339,6 +1339,7 @@ static void neigh_update_process_arp_queue(struct=
 neighbour *neigh)
> >                       if (n2)
> >                               n1 =3D n2;
> >               }
> > +             skb->dev =3D n1->dev;
> >               READ_ONCE(n1->output)(n1, skb);
> >               if (n2)
> >                       neigh_release(n2);
>
> [Severity: Medium]
> This runs for every neighbour user, not only sch_teql. Here n1 isn't
> always the neighbour the skb was queued on. It comes from
> dst_neigh_lookup_skb() on the skb's retained dst, and
> ipv4_dst_neigh_lookup() looks it up on dst_dev_rcu(dst).
>
> Two existing parkers set skb->dev to a target device B but leave an
> original route dst whose device is A.
>
> The first is bpf_redirect_neigh() with explicit nexthop params.
> __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() replace the dst
> only when nh is NULL. bpf_out_neigh_v4() and bpf_out_neigh_v6() then set
> skb->dev =3D B and call neigh_output() on B's nexthop neighbour.
>
> The second is nft fwd ... neigh. nft_fwd_neigh_eval() decrements
> TTL/hop_limit, sets skb->dev =3D B and calls neigh_xmit(), and it never
> touches the dst. nft_fwd_validate() allows NF_NETDEV_EGRESS.
>
> In __dev_queue_xmit(), nf_hook_egress() and sch_handle_egress() run
> before the IFF_XMIT_DST_RELEASE skb_dst_drop(). __neigh_event_send()
> also calls skb_dst_force() before queueing. So the dst is still attached
> when the skb is parked on B's arp_queue.
>
> The resulting sequence looks like this:
>
> egress on A
>   bpf_redirect_neigh(B, params) or nft fwd ... neigh
>     skb->dev =3D B, skb_dst(skb)->dev =3D=3D A
>     __neigh_event_send() on B's NUD_INCOMPLETE neighbour, skb queued
>
> B's neighbour resolves
>   neigh_update_process_arp_queue()
>     dst_neigh_lookup_skb() -> n1 is A's gateway neighbour
>     skb->dev =3D n1->dev;    /* now A */
>     n1->output() -> dev_queue_xmit(A)
>       nf_hook_egress() / sch_handle_egress() on A again
>
> Doesn't this run A's egress hooks a second time on packets they already
> handled? With nft fwd neigh the TTL is decremented twice, and a packet
> that arrived with TTL 2 would hit this in nft_fwd_neigh_eval():
>
>         if (iph->ttl <=3D 1) {
>                 verdict =3D NF_DROP;
>                 goto out;
>         }
>
> Counters and quotas would also count the packet twice. Tc egress BPF
> programs would run twice and could apply encap or NAT twice.
>
> The second pass might not redirect again, for example if the first pass
> changed a mark the rule depends on. In that case, would the packet leave
> on A toward the original gateway instead of the nexthop the policy chose?
>
> Before this patch skb->dev stayed B. These packets went out on B with A's
> L2 header. That was already wrong, but they did not go back through A's
> egress path.
>
> The bpf_redirect_neigh uAPI docs still say the packet is redirected to
> ifindex, and NFTA_FWD_SREG_DEV is still documented as the output
> interface. The commit message says only "This is a behaviour change for
> those paths", and the patch is Cc: stable.
>
> Could the skb->dev restore be limited to the teql case, or handled in
> sch_teql itself, rather than applied to every neighbour user here?
