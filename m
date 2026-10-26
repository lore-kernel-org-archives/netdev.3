Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793058707;
	b=CEvZHGRQ2OyGlzDmIKaFtBWtSdFv5PGbAbe//9aZxd4FyMP9hc775Ldn6Q2JIDbVwV+/
	 3isAbIq1Nr6485zJ2ZCQ/reHqFEPpY1vCLs01E4AfyEnxI7Ah3Zialf5YVlkyke1F00Gp
	 fij7eHbz/bQ1Ho24sznCSk53nNV2CuayT7uQA2DTEysH5DmZQVleZhfs1X1SvNoi1abCj
	 fciCsi5Ah94S6pCfmkR7X4smCVDGntai0uKZUQqoYBYlOuttT4Ir00NDe7YggIPK1yNJv
	 NOZpAbx56XmLoLaPv2dNuCJxFpTD7z0bJUtWO8dvKcqFvVhOl1GkiyR6PQJ4vvBk1ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UaoOtljsZiSqMBuHcOa8fGzQ5BRPIrVZWD/hL3QGdlI=;
	b=0hJFJz8ilE9d0Zdkgsopm+bwm9KcbhjRA6X92eenUl0GEwQcoNle/ZRcyKNA8HrUOfz4
	 Wazz5UKlG9998kFEwBxLDyTtW4vstSce76KxXo+s3kQRAs+rMcZNGVnVmQUh+0glS6OTu
	 KPF1MFHTXjfkeJ4p9X7M14ZfD7yDXtFWaV7rNN9tfJbDYAYTX0lEK78ZMKPX4NR8os4Ih
	 Dh0EebarCt2VZC+3BlygFVTCSEcadtm58MwAzHusEOGK7+NdRCqcTSp5DQlRtuHj9oIfl
	 KweiW/i0/GdbEb9bpdupmNAv0T9fc0AOuy/fCVPlNd2KHb8QSQHn8W/2nd/9Xt/zqEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="goXIMrx/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554D606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4554D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=goXIMrx/
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so1539631b3a.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793058705; cv=none;
        d=google.com; s=arc-20260327;
        b=bAWI8U5CIlVZxFlJ5TcnBkCcOGxcKdw5Nf1Eg6X94GwkcTgjudQfxO871iSDPQjqU1
         /xtsrIvw5l+qmmn+oVqkr1mA1fa10P3nReRlb5zOfS+4ttFvDGB3zvd8ki/3ZqD40P8y
         wXoqQIPwH+wIynf/wi1Zcg2bXazIpzkb3gBKN0nlhQq3q8Mg8Nv76r5EPCuWzMEas+cA
         nwEi0/Cov1xG4VucAs7i6eldDH9udBZYfGKEs2KCBH7fz1ICILZgFeMQ3aGtTHBTPvjz
         bvxMfES67+mZ8PXrrhnfuxH/IuUmd0w98dgB4HGzCjSm0z0w925/bMvzdYoI6/PDbGUt
         wPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UaoOtljsZiSqMBuHcOa8fGzQ5BRPIrVZWD/hL3QGdlI=;
        fh=xQcTKnSGwzhLr7lZiz8uL7QOkG/FimUkqhZX65QOsC8=;
        b=NG+IJNSkugLRD8MsrvCJD8XCGwrwtQ1WQo2DACpb4RfHJbFa1hHHE7jVG8FnWBp1VK
         Rg/mGziVGqE3Ajb5/Wfbbt0GEtbaITFTnLujFUWTr9DBJyoM5tWkB2U8JYx8nDF+mD6O
         9BCeUuhoTwQ8hffOODamswv5nM5Oc5aTDdI/AF+jAUOf//WPI7rqWaPgsXCSBzsF7QYp
         Ftjlos3Rb1Y92jsWcP1KvImSseCMT3ILE9AkfYfHvgpKCTZILf+QQKsc1ZJqle0n4mly
         PLFvLtKfdyi0loRyxT4EbZF6whVt2QluTjS71Dui+9noR/CCbOJXTSUDgRO7oXL9zRKl
         7oVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793058705; x=1793663505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UaoOtljsZiSqMBuHcOa8fGzQ5BRPIrVZWD/hL3QGdlI=;
        b=goXIMrx/3XjAcQ+cSW5YwfuTirY+Lh7JxbdW58R8kt1vFWyozoutudfzR2D6O9b81T
         aBKVERFm4MQfqvpA84tGp/IMkXsnqTLkcaP7XfmQ7JdID12qo1BiSQq24NBwNAHXNUaS
         7/cT3PhJvsUmJx1OzbX7vo0jQDiXumfPGHvf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058705; x=1793663505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UaoOtljsZiSqMBuHcOa8fGzQ5BRPIrVZWD/hL3QGdlI=;
        b=vT1+JejGOo/RcjP0uMFqh9d6XzFEXA9XnVCZj0ZhtMyXaLuCvJ5JyDQSS0g4uq0wFs
         /Id5vjUwd0UYGoI5k2nzOpCQthSsCgOCOPySz/mY9THkTEKTqkuzDJTWJ08pcctp+Aiw
         k/WVksNfdlnSxVCPxuej9rvZmB85Z7CE1+/YyZn9aHQABcd+2HcYjf+8swlt/IZB76p4
         UYoafGn3j4NN1MoEMTG+alKxK/2SC2Fm+JZPJdSHP0QD4o8s/Xh2ug5htcTy5YjMeuoW
         Oe4v2XIPcAx6Sc1wkYiw2Gu97MmV4xySJwWCQg/3FKHaFj9gGNoIeQKfHa9Tc3/FNWLj
         Vl5w==
X-Gm-Message-State: AFq9FYIn9G1hT2eOoqXdJ0Uw34moLHzPCLZX/MmZUhf+RxtIF7nyBI9D
	NkXOjS5OH50dZVodiChdmcLPUtV4+HLsbZY+3YieFyRlBjS/pN+jb38viCUJFwFrKWfRT2fxqie
	w/DaG5mc5UqYM3vwtOxQTqT6su/bOWqKplUDnCob6
X-Gm-Gg: AYBFou1r6znZVad+JAj0gLWTp8fSg9urWasZLMivR8qS9rUTqMViIx7fqmjzX/D1vuN
	VmyBm94ZoLLLi/3h/agcXsSdqh085UCA7N7fIUnaHUBW86SHOHYNMhq/gdQ9HC07yrmHw0l1JtN
	N3r1/9G6APNAzVORHVm1kuuFC1ObRoKLDHVC7m/eFwfxKRpaUha16cYLeS3K2l9w44UaQsM5TCP
	/RwVNOdbnPg4CCrJ38WREsBu2sC8s6MaDfSTpswPjf6xkrkZQQhG87uToBRGMR/JBnvzse2Uiag
	L/of0ceFgHJaGs0+A7V8VdD0Uxu6aO2f3kIf6Ds8kfeVwCt0Gaf6VnXybd6JGZJz1phqfnmEMOM
	o8fDOBa+FQnzM9rApSsJW6hngczxnIkwVkhwHuZFzveWQX1wac1UIm8Lq1w1/HdpCMcHq7RznOA
	5d6xAfYLCibOkaZ7LRPDrbFlBQc3WN0CDDGHz4
X-Received: by 2002:a05:6a20:549d:b0:3e2:2b76:bf23 with SMTP id
 adf61e73a8af0-3e7cd5034b0mr9457553637.68.1793058705580; Mon, 26 Oct 2026
 16:51:45 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com> <20261026160747.283702-1-horms@kernel.org>
In-Reply-To: <20261026160747.283702-1-horms@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 19:51:33 -0400
X-Gm-Features: AclHuK9KOrZqBCdN7DDV5_e9NiBiIHJYcLxYj0JIq2lJ37Nc28lxMC77niZb0Yg
Message-ID: <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 12:08=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email says "Hi Jamal, passing this on for your consideration as it
> seems to have got stuck somewhere."

There was nothing wrong with the headers this time - so not sure what
is going on. A bit frustrating.

In any case these are complaints about commit messages in both 1/2 and
this i.e there is nothing to change in the code.
If necessary, I can resend repost 3 with the fixed commit clarifying
the "identity for every other parker"

cheers,
jamal

> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC=
-6HS9.v1.r2.20261020051718-1@mojatatu.com?part=3D2
> ---
> net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
>
> The patch sets skb->dev =3D slave before teql_resolve(). An skb parked on
> the slave's neighbour arp_queue then names the slave, not the teql master=
.
> It also adds skb->dev =3D n1->dev at the reinjection point in
> neigh_update_process_arp_queue(), so parked teql skbs go back through
> teql_master_xmit() when the neighbour resolves.
>
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 7448320f7ad52..5823f5007812b 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1336,6 +1336,7 @@ static void neigh_update_process_arp_queue(struct=
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
> The commit message says this assignment "is the identity for every other
> parker (neigh_resolve_output() parks with skb->dev =3D=3D neigh->dev, ndi=
sc
> probes carry no skb)". Does that hold when the skb's dst points at a
> different device than the neighbour it was parked on?
>
> If the dst is not DST_OBSOLETE_DEAD, n1 is not the parking neighbour. It =
is
> replaced by n2 from dst_neigh_lookup_skb(), and ipv4_neigh_lookup() looks
> that neighbour up on the dst's device:
>
> net/ipv4/route.c:ipv4_neigh_lookup() {
>     ...
>         dev =3D dst_dev_rcu(dst);
>         if (likely(rt->rt_gw_family =3D=3D AF_INET)) {
>                 n =3D ip_neigh_gw4(dev, rt->rt_gw4);
>     ...
> }
>
> So the new line is only a no-op when dst->dev =3D=3D skb->dev.
> skb->dev =3D=3D neigh->dev is not enough.
>
> At least two parkers seem to break that. The first is bpf_redirect_neigh(=
)
> with explicit nexthop params. bpf_out_neigh_v4() moves skb->dev to the
> redirect target B and resolves the nexthop on B:
>
> net/core/filter.c:bpf_out_neigh_v4() {
>     ...
>         skb->dev =3D dev;
>     ...
>         } else if (nh->nh_family =3D=3D AF_INET) {
>                 neigh =3D ip_neigh_gw4(dev, nh->ipv4_nh);
>     ...
> }
>
> However, __bpf_redirect_neigh_v4() only replaces the dst in the !nh branc=
h,
> so the routed dst for the original device A stays attached:
>
> net/core/filter.c:__bpf_redirect_neigh_v4() {
>     ...
>                 skb_dst_drop(skb);
>                 skb_dst_set(skb, &rt->dst);
>         }
>     ...
> }
>
> bpf_out_neigh_v6() follows the same pattern with ip_neigh_gw6().
>
> The second is nft fwd ... neigh in a netdev egress chain.
> nft_fwd_neigh_eval() changes skb->dev and parks the skb without touching
> the dst:
>
> net/netfilter/nft_fwd_netdev.c:nft_fwd_neigh_eval() {
>     ...
>         skb->dev =3D dev;
>         skb_clear_tstamp(skb);
>
>         nf_dev_xmit_recursion_inc();
>         neigh_xmit(neigh_table, dev, addr, skb);
>     ...
> }
>
> In __dev_queue_xmit(), nf_hook_egress() and sch_handle_egress() run befor=
e
> the IFF_XMIT_DST_RELEASE skb_dst_drop(), so A's routed dst is still
> attached at these hooks. If B's neighbour is incomplete, the skb is parke=
d
> on B's arp_queue with skb->dev =3D=3D B and dst->dev =3D=3D A.
>
> When B's neighbour resolves, n2 is A's neighbour. With this patch skb->de=
v
> becomes A, and n1->output() builds A's link-layer header and calls
> dev_queue_xmit() on A.
>
> Before the patch, the frame still left on B, though with A's link-layer
> header, which was already a pre-existing problem. After the patch, would
> the packets queued during resolution go through A's egress qdisc, tc and
> nft hooks a second time?
>
> That could mean nft_fwd_neigh_eval() calls ip_decrease_ttl() or
> decrements hop_limit again. Non-idempotent BPF programs (encap,
> adjust_room) would run again, and counting or stateful rules would see
> the packet twice. If the redirect is not applied again on A's path, the
> packets would leave on A and bypass the configured BPF or nft steering.
>
> Since this is a change to core neighbour code tagged for stable, could th=
e
> reinjection fix be limited to the teql case? Alternatively, could the
> commit message describe the behaviour change for these other parkers?
