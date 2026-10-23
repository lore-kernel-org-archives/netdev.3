Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792777830;
	b=MhJ9q8QRU0uiukBuTzk9RijwbbWhlhD/6QrVIPavcqm4Otl+UYcZx4pAsUOBar0+rvGE
	 ydGDF2HrhVLSwXJg9WufBjO+NbwwxvjQta55VLDgHfYgqzz9GJWA8o1m12pweytur7/Mp
	 vxFms9TGK4zsmywXFysG/ejQZuSjy110iBdZ4BL4qNlw7jjKvcS41tfVrm5z79iAuFsfG
	 lzIzOV9gFTBY+41c159p6yWuQAYc90jYVfwntNc/OqohA4Ibx+dyKt7E/8Mq9AXqhMKYm
	 lfApLVdjqBMUXnkLcombWN+FG87HA3o/V+Ubt4s8c0Goe+H2XlRsbAeZ00hUXph4EDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NfTMKpM4Fi2gQW/7ivR+dxPSeSUZuVAfUibL9pBsSQg=;
	b=0gEDNZ1cLedN5lSWB4RhTfPnePXMHhrV+zQwTeJulwE9pOtepJ9Agt5qS2mY8B/4cNSt
	 3Hj1YMWBSWhKtRKSyZ1wAscWsXqmOvUVOmPVTzRtyOD4twEi7dGfxqGWAHYSocHmgLpFD
	 YSbEhSUGRnEdnp8hqtiiw3CsEzjE977sMPReezdlh7gdxOOoNO0nJw6A4xyBK2ijjIWdx
	 i+zla+9m86JOGvADst8BUmsel5QuQUhB8S1soyhrdSiyHeKd14bNod+wywAqaAdZoZ04R
	 NI7NRohmdaF3xuO0WnzZM8FEX8moYwL5Y8TiLWV7+B9AWAhx3CFS5Zk/AXpAaPvjOVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=kIidCFxN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701B606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 17:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0701B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=kIidCFxN
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a06210b29fso468787b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792777829; cv=none;
        d=google.com; s=arc-20260327;
        b=QKMhBuTIMRMp5mXqe/QqpVAm5xv9RAUfsS3WAXTLgAWwbQUTi2FFezQp0/jahX/bf2
         S0+tiz9oHu1efM/WywBtT1ROavA7qDZoiF5kRagELI7cuozb+bVtWjNtreOcUQUd7u0M
         fvO+1tR1pyye9lPxkl+ZG1mkfkTRHxyCzmLbVzSLe/87cah3mN4M5oLB/6X0u3B4KSUD
         jrMaJmD14il2GI30Yh7QlLoaN5MB2r9dSWDLqYtf9V6m6mUXzse5c25tWp/oWpPSRTGI
         6iORg5leDVnjQUWCwuiFWZeSIJg0X3tBDWWb8bEOUiYSqN5spXscgTvN9jE20mr+XHSR
         TZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NfTMKpM4Fi2gQW/7ivR+dxPSeSUZuVAfUibL9pBsSQg=;
        fh=UiU0WHibrZJNYyG27DSTT1+0IBHBnq9Xw9IbiT8HW4o=;
        b=mWdqdoNb0JvsMTuxYLF4D90oXgSnwfpwyugA8GwNtobx+LgFJM850GXF1lr+BrZGRe
         Z4rQs3o5PBX6359zBNFRaE2hsZhrwPBuNB8Tw4cRvcXijWG219O1pSXjfhCuM4QqY2C7
         D9rHMixSDAoPiXtaSyvRr+6c2lcO1fPKS6QV50QNFL7f+l6k4ug3VGpjw/VLzWalP7/w
         O2v1NVkAfktriPkQ4bFUSgziHvPwkUGEkB+18nR9gRrzqDAeBBR7GLtRRMfGOxY72+Z8
         t1eFOHcedWB4tPD2KbgnePV7rQN3AfDkSkmO3ULY2p9nzS2LK8lnfjAM3tozrbVpSXUz
         NGpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792777829; x=1793382629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NfTMKpM4Fi2gQW/7ivR+dxPSeSUZuVAfUibL9pBsSQg=;
        b=kIidCFxNjG5wNwDTUl7Dlz3h4oDosCg38JfDfuFTtQAm/Na7/ADzXuYWGVnm5ek2TE
         VfPIf3pfTzjtorBrRVd+JhrDvdver9mnGOpvvrdG39arX7SCdY6FHwP5RBcR3yOYn+dh
         mYzqW/5S4ErTX4U3efu0Yp8W0cfauCHrP9dHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777829; x=1793382629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfTMKpM4Fi2gQW/7ivR+dxPSeSUZuVAfUibL9pBsSQg=;
        b=MqW4CeYcYzfUNM0IagsdmccL1LCj0KbB50w404WKGAzLX7uV9DFjza2ZW3jz44Pi07
         ++qdDLIqXCaKkvmhXrfr3/NZIfI5T8d5MXsiIY+SMG4Mmoui523qag6BD0LKA3RWfcIR
         knzOFUfA2zlVcSL48CDPvPAUO0EJiOWNBbHoaaFSjRsAr+gXqQQ5zM7H0tpGe7YS7y92
         Ukx2Eh1NkEi9YqVs7QYCORJg29CsD2zTEMKj6X3vVWPaZsO8+R3kKx5O8eXf5XwqKHre
         j5feOCXxYOd51BGIy8YZrs4ZzPQu9czq/2KyS1id+VXk7I3PPsjNMK40KE2A7v9iykt/
         1jiQ==
X-Forwarded-Encrypted: i=1; AKwUvByphtrWgUTwUc6j0sAWVUkmMasoOcYVEBE0yU28AU982g8Vu0sO+URTRlnUIq8NOAXUGE8eoqw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPUM9i2AXsYM8KA64qnxoP5qaxMnqNAAmbQtmseZk0LLpF1uPQ
	a1NChLD9+Ct0rY+Lf1OLZySSUTqQMfZC4q86ozC0ZutDkSQp7XkIX6a/fsrDwYXl4XtXdvtRcTH
	SbM+w8BlrIXCvWJa+Y3E5CDd6nkdvRDJEXmdDVr0N
X-Gm-Gg: AYBFou2L6moPaJ0BBsM8zK4B9x/J7Gj6+o2hemP22ENPHd+a/+WD4JUI44k8kWmcJ0c
	KTYXgENzMmodygBzssslk/QP/CFNZaRgg3s6ipPrJOz28NhURDIp6SFEN/kBiI0UOSKTzczN6r1
	0mFsMhFfaZIgv244QcV1txQ4O0LXwel/r3kuWSINgThRnqnm6gQd59zoRVkapQtvaLhCNrTTDSl
	vEqAq9TKRjnSlXEiEPN9fcAYoPwBSQ+8asf115AY6EKVBl5dRUUOAFlKot0IzCRUCwwY3FLCOJa
	a0QCu2u9fLfmxmLiMMdMyTK+MoXbqQvFG6GnXTpSgH0Q66quFEPIhgGGJ/3GAS1QD9wD4b7FWyI
	2sqKIXmRzlXnaWYZN7Pv8CINR+5bXnEEkm4h8vC48UI6fFa2yxLs5QxgONxhqaE7iF6aMehNgoz
	5BuFY6BFDiAzo4C+8=
X-Received: by 2002:a05:6a20:cc8e:b0:3e2:490d:5127 with SMTP id
 adf61e73a8af0-3e359a408e7mr2657796637.2.1792777829063; Fri, 23 Oct 2026
 10:50:29 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-Y0BY.v1.r0.20261015184107-2@mojatatu.com>
 <179248763469.3135.1739559328868319628@kernel.org> <20261023162821.GN708417@horms.kernel.org>
In-Reply-To: <20261023162821.GN708417@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 13:50:17 -0400
X-Gm-Features: AclHuK-lPnqSWlBjm9YE8wHoMCILoIyS3_3o2j-_BfCIQutA2hTRfAEI60jMb08
Message-ID: <CAM0EoM=TTf=ugCtHv_Sv3Uj0trcUgNYcoSGn+kg_pHymLU-oLg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net/sched: sch_teql: fix use-after-free on lower
 qdisc drop
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, owen@verialabs.com, 
	jiri@resnulli.us, victor@mojatatu.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, kaber@trash.net, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 12:28=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Tue, Oct 20, 2026 at 09:13:54AM +0000, netdev-bot+sashiko@kernel.org w=
rote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] In teql_master_xmit() (net/sched/sch_teql.c), the patch
> >   replaces `=3D=3D NETDEV_TX_OK` with `dev_xmit_complete(rc)`.
>
> Hi Jamal,
>
> Maybe things have moved on for some reason.
> But this concern does seem to warrant a response.
>

Yikes, My new perfect "dont miss anything" script failed and didnt
alert me ;-> Thanks for catching this. I will resend, one of those
comments is legit - so i will send a v2.

I do find sashiko-nipa sometimes misses showing up on the list, so i
have a script that politely polls the site. Polling the site is more
reliable.
It is still strange - sometimes the embargo is lifted in 7 days but i
just saw something with the embargo lifted after 2 days. Is there a
human who decides this and intervenes?

The script has a bug which i just fixed: it took reviews[0] which for
nipa was for patch-1 which was empty review (meaning "No issue found")
and decide that patch-2  was also "No issues found."
At one point i think that approach worked. Note: The site didn't hide
it; the script just selected the wrong array element. Fixed by
matching patch_id/message_id.

cheers,
jamal

> >
> > --
> >
> > net/sched: sch_teql: fix use-after-free on lower qdisc drop
> >
> > This patch changes the check on the slave's netdev_start_xmit() return
> > value in teql_master_xmit(). It now uses dev_xmit_complete() instead of
> > comparing against NETDEV_TX_OK, so a slave that consumes the skb and
> > returns NET_XMIT_DROP is no longer treated as still owning it. This fix=
es
> > a use-after-free when a VLAN slave's lower qdisc drops the packet.
> >
> > > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > > index c7dcec25ef420..b3efd5c281988 100644
> > > --- a/net/sched/sch_teql.c
> > > +++ b/net/sched/sch_teql.c
> > > @@ -350,8 +350,8 @@ static netdev_tx_t teql_master_xmit(struct sk_buf=
f *skb, struct net_device *dev)
> > >
> > >                             skb->dev =3D slave;
> > >                             if (!netif_xmit_frozen_or_stopped(slave_t=
xq) &&
> > > -                               netdev_start_xmit(skb, slave, slave_t=
xq, false) =3D=3D
> > > -                               NETDEV_TX_OK) {
> > > +                               dev_xmit_complete(netdev_start_xmit(s=
kb, slave,
> > > +                                                                   s=
lave_txq, false))) {
> >
> > [Severity: Medium]
> > This closes the use-after-free. Does the same condition now also count
> > dropped packets as successful transmits on teql0?
> >
> > dev_xmit_complete() returns true for any rc < NET_XMIT_MASK. That cover=
s
> > NET_XMIT_DROP and negative errno values as well as NETDEV_TX_OK. All of
> > these now take the success block in teql_master_xmit():
> >
> >     netif_wake_queue(dev);
> >     master->tx_packets++;
> >     master->tx_bytes +=3D length;
> >     rcu_read_unlock();
> >     return NETDEV_TX_OK;
> >
> > They also advance master->slaves to the next slave.
> >
> > teql_master_stats64() copies these counters directly into struct
> > rtnl_link_stats64. There, tx_packets is defined as "Number of packets
> > successfully transmitted".
> >
> > With the reproducer from the commit message (a VLAN slave on a dummy
> > device with a pfifo limit 0 root), every packet the lower qdisc drops
> > would appear as a good transmit in ip -s link show teql0. tx_dropped an=
d
> > tx_errors would stay at zero.
> >
> > The VLAN slave counts the same rc as a drop in vlan_dev_hard_start_xmit=
():
> >
> >     if (likely(ret =3D=3D NET_XMIT_SUCCESS || ret =3D=3D NET_XMIT_CN)) =
{
> >         ...
> >         u64_stats_inc(&stats->tx_packets);
> >         ...
> >     } else {
> >         this_cpu_inc(vlan->vlan_pcpu_stats->tx_dropped);
> >     }
> >
> > Could the rc be saved once? dev_xmit_complete(rc) would then decide onl=
y
> > whether the skb is still owned, which keeps the use-after-free fix. In
> > that case, tx_packets and tx_bytes would only grow for NETDEV_TX_OK and
> > NET_XMIT_CN. The other consumed codes would go to tx_dropped (or
> > tx_errors), without touching the skb.
> >
> > The commit message describes this only as a use-after-free fix. Could i=
t
> > also mention that teql0's counters behave differently now?
> >
> > >                                     __netif_tx_unlock(slave_txq);
> > >                                     raw_spin_lock_irqsave(&master->sl=
aves_lock, flags);
> > >                                     if (rcu_dereference_protected(mas=
ter->slaves,
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/QDISC-Y0BY.v1.r0.20261015184107%40mojatatu.com
