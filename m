Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14CF41E6D6
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791025089; cv=pass; b=IRtmF4Fa+4UixEaRiDlSY7Zo2QE+wvE8UNliL+oRNhIwkJYDndXTDIrpecGb+BE5PYFJ3F8VTFdOFybqbS5XV7Q+ZW3QlTeHKbvVfngV0Xmu4SosXHk9gHlw4WWqDq0x/XlR3SGHQxYadH7XlE1BcocXAxha0oL6dfuAkbtJ93g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791025089; c=relaxed/simple;
	bh=oMuYJ2CoPJe0JMOw41kNxAiWSaGBrOOEiYgU4UFP+AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrNXssu82M3HfNZTyBpHWSPZU3TuUgrrZniRKlczpyoorPaZhP71wcBkkWa4L1ywa9q8yixS8U7eHL3bhog+XWPl69OkM9Fdm8ASng2z9OqDB/y0WvWd/xl2KcWFQqkficJDDsQSKYg1OzwZMcq29I8OvJXfXznWRYo9c4wRBeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=BIzfaWl+; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="BIzfaWl+"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-881a3a28e72so64532b3a.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 03:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791025086; cv=none;
        d=google.com; s=arc-20260327;
        b=DgGpusAVFY6ODkmu/VBBFrFbkBC6V1DezQsuBtHbG221NBAJL8yMvA2IESQCXEFNdS
         pqSkA/5tQxsrjy5xjqhuZgne5dfjszywNJWLimshsJ2Oo+2B5W8IzXY2MwnNt0MnMROn
         uXexqfzr8yXpi6MunUOeY/6nX17Hrji2kQb94vPmTcWJYEQ8ngYBp9XdUovr0Von7qGs
         cnQVs7+2Ek0pLKUbAlA5/b5fm3KFkOv3pDQWCFfdUX2alBaoDOh+ZllbqsDGGi0ssm8C
         FiFxK0ZYtbG6fdm3GfSPcSQEOfbc2gt1MGPz+RcEheMQYuALxcm5THg3saJdLNgaC9i2
         v4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bzOza6j3ozLq7eHe+x3/NaGjUrKM6N/fr1sQCB9xww4=;
        fh=yYvUm8q20CaNND69y9DvocVj0rmBcLdhYOYGzCFdDcM=;
        b=OpLjYl2LOI2iT4y/GAA7OG3TPkvNIopR0o28j9q8MKS9pkuzA/0+D6T08bGeY4kH5W
         e/wXBfW8DCv44TAcG6Z8hWsOl7m9SxKqYIiYOyQ+2ligPRQYbXg0ibhtCtUbDxo1eTPU
         rHRp7jgbI8dr8hbVWAzLqqS6+RZqKRkpoBGv2zi+D8C8pAAyYPK23PVD08C+7GnmvB3V
         zzvcGmvOfzscgXIcOugeGA/oNS/yYgFTGPflaVpmLloeLAr4bTQdFTWppc9M6D39DZoI
         cPBGo0YydIBv331IIK/JczC4gjkTLrPPIT+IjPsaB+rYwinqTcegq4tq+eLAG+sIPVNA
         KzKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791025086; x=1791629886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bzOza6j3ozLq7eHe+x3/NaGjUrKM6N/fr1sQCB9xww4=;
        b=BIzfaWl+n8/j4GyufTCsZtETCuBlqyLnGsP1ADLwdktrznXW9Khq0w+EoPDUt7cdYn
         UYI8FwIczFnc4+tVQUa/vzsf5u9c1DbgBqRZxmuBbDOhNUaP+bdpVe1BWPXhWqc+ZqmW
         jQwhnxTrTdiwrmKjlKICiwQQ3hSHSc5gHGEyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791025086; x=1791629886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bzOza6j3ozLq7eHe+x3/NaGjUrKM6N/fr1sQCB9xww4=;
        b=Vu7lX0FgDEIdHWV/eijmBQMNs9NQaNRMYjReHKtqkm5Cvu7RQ/cfcG1sy40w421c2+
         GUEyBvWWB8gP+Tl545f8xKLMtDlvYqZqB+ibvYgUAKE2iHnRsdl0jLoy7+EyIdWylDia
         h7tSQaEqM54V60XlHQfA0ZApBBo1Pw91hxVxXpyo2D4uvfr+lN4SwzeqSy65zKYEa7qG
         2zD3oFQ9KEXqG0nGr+2kEuo67gpQregWn4x4ZL/ulD2XWnC+05j+QiXNlU0zVihu3NS2
         QTWZGCErlF9d2YuWgLTKjA2sQmsTURMMqWI8IVSxhE1T75ICRB7saopDrcYVg7YuKUkg
         3vHw==
X-Gm-Message-State: AFuF++mw9he5kOIUMx+4jmruUYD3aT9F0PxS4e7C8oneAdKplVKbNEvQ
	Ite3jkMPCQIAtN6MvzPtP5DP25aZJnWlzQoRYHphVwz9cF5cIw4Z5RkPFKUL+pz6QCEKNNV9bUO
	tUje/zYi7T9gKfr2ahhiNcyeGxZU56e5u8DV5imoP
X-Gm-Gg: AYBFou3Vl7vZsSq4Ww20Mm4V+7217a/FZimgbUKgi+KqF2UAOwYuPtbJAiIf+ZY/mmZ
	V488roOiopaFsl2mxwdf2/YOITeid9F13QgtJcijUYl6m74/XZ92sbzf751e4I46xPGq5nPNgEw
	odqQWUCF8PVtyhTwamLlvRGidKpd4Uh0xKxPhQV2qozEV25p1eK7w9g0RBGJW2d5U6axy7Xty5i
	u2RdzZAJDuLTWKcORJBs5/4Y7N46NdS+0V9vQo6dBCzwMr17IyxtCeRWjEdeHhcQTfdJP6RQbQh
	D6lks+T8ZXvLtVDpvBFgsrVcf/uwjZTxL8XIfXamJiap4mK0pnc4RzywGYnfrd+30wYx4Bat4hs
	lDie4zelerv2ZkN4flfBM9ThQyd6Fkn1BZQ==
X-Received: by 2002:a05:6a00:230c:b0:882:359f:ef42 with SMTP id
 d2e1a72fcca58-88af5ac16b7mr5994992b3a.49.1791025085796; Sat, 03 Oct 2026
 03:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-6HS9.v1.20260928064754@mojatatu.com.1> <179077366943.434549.8458923511073715827@kernel.org>
In-Reply-To: <179077366943.434549.8458923511073715827@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 3 Oct 2026 06:57:53 -0400
X-Gm-Features: AclHuK9FNtyte7fVi9zkCCmfzWfp9yj2bczjqbjEOgea2gNyqJnz8WC0l-EDq_w
Message-ID: <CAM0EoMnfws0ZpmCwbjgihfrLFMYe6Vyo6TK=OXhWwmv+m1qeug@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: sch_teql: fix shared headroom and
 header strip on slave retry
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, hybris@mojatatu.ai, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 9:07=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 (1) =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message and the new code comment give the wrong
>   reason for problem 1 and the wrong way to reproduce it.
>
> Pre-existing issues:
> - [Critical] teql_master_xmit() in net/sched/sch_teql.c treats a slave
>   transmit as successful only when `netdev_start_xmit(skb, slave,=E2=80=
=A6
>

Sorry, I missed responding to this:
This is  a different root cause from this patch series - we are going
to send a followup fix if no one beats us to it.

cheers,
jamal

> --
>
> net/sched: sch_teql: fix shared headroom and header strip on slave retry
>
> The patch adds a skb_cow_head() call before dev_hard_header() in
> __teql_resolve(). It also changes teql_master_xmit() so that, when a
> slave attempt fails, it pulls back only the header length that
> teql_resolve() pushed for that slave. It no longer pulls
> skb_network_offset() bytes.
>
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
> Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mo=
jatatu.com
>
> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index 409ce50cc0dbc..acd03f9afc6b8 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
>
> [ ... ]
>
> > @@ -265,15 +265,28 @@ __teql_resolve(struct sk_buff *skb, struct sk_buf=
f *skb_res,
> >       }
> >
> >       if (neigh_event_send(n, skb_res) =3D=3D 0) {
> > +             int off =3D skb_network_offset(skb);
> >               char haddr[MAX_ADDR_LEN];
> >
> >               neigh_ha_snapshot(haddr, n, dev);
> > +             /* The skb may be shared (e.g. a packet tap clone); make =
the
> > +              * headroom private before dev_hard_header() writes into =
it.
> > +              */
> > +             if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
>
> [Severity: Medium]
>
> The skb_cow_head() call looks right. Are this comment and the commit
> message accurate about why it is needed?
>
> The commit message says:
>
>     1. When the skb is shared (for example a packet tap installed on the
>        master makes xmit_one() clone it before teql_master_xmit()),
>
> and later:
>
>     and a shared skb is unshared before it is modified.
>
> skb_cow_head() only handles skb_header_cloned(). It does nothing when
> skb_shared() is true (users > 1). If it has to expand the head,
> pskb_expand_head() has:
>
>     BUG_ON(skb_shared(skb));
>
> Would "header-cloned" be a more accurate term than "shared" in both
> places?
>
> Can the packet tap reproducer actually show corruption?
> teql_master_setup() never sets header_ops and uses ARPHRD_VOID, so
> dev_has_header() is false for the master. packet_rcv() and tpacket_rcv()
> only push back to the mac header when it is true:
>
>     if (dev_has_header(dev)) {
>         if (sk->sk_type !=3D SOCK_DGRAM)
>             skb_push(skb, skb->data - skb_mac_header(skb));
>
> So the tap only sees bytes from skb->data onward. __teql_resolve()
> writes the slave header into [data - hlen, data), which the tap never
> reads.
>
> A trigger that does seem to cause visible corruption is a tc mirred
> mirror on a physical device's clsact egress, with the teql master as
> the target.
>
> sch_handle_egress() runs before skb_dst_drop(), so the clone keeps its
> dst. ARPHRD_VOID is not a mac-header-xmit type, so tcf_mirred_to_dev()
> pulls mac_len off the clone:
>
>     expects_nh =3D want_ingress || !m_mac_header_xmit;
>     at_nh =3D skb->data =3D=3D skb_network_header(skb);
>     if (at_nh !=3D expects_nh) {
>         ...
>             skb_pull_rcsum(skb_to_send, mac_len);
>
> The original skb's Ethernet header then sits in the clone's shared
> headroom, and dev_hard_header() in teql overwrites it.
>
> Should the reproduction steps in the commit message describe this case
> instead?
>
> The subject and body also say both problems happen "on slave retry".
> The header write, and now the COW, happens on every slave attempt,
> including a first attempt that succeeds. Could the wording reflect
> that?
>
> [ ... ]
>
> > @@ -374,8 +390,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff=
 *skb, struct net_device *dev)
> >                       nores =3D 1;
> >                       break;
> >               }
> > +             /* Undo only the header teql_resolve() pushed for this sl=
ave.
> > +              * Pulling skb_network_offset() instead would strip a
> > +              * userspace-supplied header when the slave added none, e=
.g.
> > +              * an AF_PACKET/SOCK_RAW frame with no dst entry.
> > +              */
> > +             if (hlen > 0)
> > +                     __skb_pull(skb, hlen);
> >               skb->dev =3D dev;
>
> [Severity: Critical]
>
> This isn't a bug introduced by this patch, but can this __skb_pull()
> and the skb->dev write touch an skb that the slave has already
> consumed?
>
> teql_master_xmit() counts a slave transmit as successful only when it
> returns NETDEV_TX_OK:
>
>     if (!netif_xmit_frozen_or_stopped(slave_txq) &&
>         netdev_start_xmit(skb, slave, slave_txq, false) =3D=3D
>         NETDEV_TX_OK) {
>
> Stacked slaves such as 8021q, and macvlan through macvlan_start_xmit(),
> return the lower device's dev_queue_xmit() result unchanged:
>
> net/8021q/vlan_dev.c:vlan_dev_hard_start_xmit() {
>     ...
>     ret =3D dev_queue_xmit(skb);
>     ...
>     return ret;
> }
>
> That result can be NET_XMIT_DROP, NET_XMIT_CN or a negative errno.
> dev_xmit_complete() treats all of these as consumed:
>
>     if (likely(rc < NET_XMIT_MASK))
>         return true;
>
> For NET_XMIT_DROP the skb is already freed, for example in
> __dev_xmit_skb():
>
>     kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_BURST_DROP);
>     return NET_XMIT_DROP;
>
> For NET_XMIT_CN it may still be queued on the lower qdisc.
>
> In both cases teql falls through to this block. For a VLAN slave with a
> resolved neighbour, hlen is ETH_HLEN + VLAN_HLEN, so __skb_pull() and
> skb->dev =3D dev write to the consumed skb.
>
> The loop then calls teql_resolve(), skb_cow_head(), dev_hard_header()
> and netdev_start_xmit() again on it, or it reaches the drop label:
>
>     master->tx_dropped++;
>     rcu_read_unlock();
>     dev_kfree_skb(skb);
>
> Would that be a double free? The function can also return
> NETDEV_TX_BUSY, and the core would then requeue a freed skb.
>
> The setup needs CAP_NET_ADMIN to attach teql as root on a VLAN or
> macvlan device. After that, ordinary congestion on the lower device is
> enough to hit this path. The rest of the series does not seem to fix it
> either; the final state still compares against NETDEV_TX_OK.
>
> Since this patch already reworks the post-failure skb handling on this
> path, would it make sense to check dev_xmit_complete() on the return
> value instead of comparing it with NETDEV_TX_OK?
>
> >       } while ((q =3D rcu_dereference(NEXT_SLAVE(q))) !=3D start);
> >
> >       if (nores && skb_res =3D=3D NULL) {
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-6HS9.v1.20260928064754%40mojatatu.com
