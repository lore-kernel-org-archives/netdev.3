Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F111E5018
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791025240; cv=pass; b=hgQ2QQKg028muooXrK4mOaezC/vsZcYB+cuhDLfn6Tve5jtu386JgvXnH1mRuWdilb/wQXsYMv0Z98wQ/tc+dKWvLv3+I6mC9Mm5JYulYmLWIZJGmxkQA9a9q01cWO1hqIawEcMsT198Wf8ReIptFktDb5cGjPcxGltiqf3c2Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791025240; c=relaxed/simple;
	bh=UijEtMi2hPDnoA+kzuOFJieUKruBYOBeozxfUxyRIWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRuvqFGZ++OrsLkEjmo6CBD2upNSwKpQQwbQ7MjnyXX+9VVZSSx3B3GfO7ObyL3sQ1p/yf3y0H276RXGKy53BHu0Myv5zAEpKdT80TWZ6zmQzIubWs01eI7yyHYbXQPgypprIt7eSHAm/xhdbzIb5yoWbaPIGTaxN9K6MQ/rfPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Hy6aN/5x; arc=pass smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Hy6aN/5x"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-886ce63c1c5so58796b3a.0
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 04:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791025237; cv=none;
        d=google.com; s=arc-20260327;
        b=GEE5XHZuLcrC8ZMn/fYnrbZ+3qzlpvGZntjp7fzakvla4qk5Pf4cO93JRuG1dO1D5T
         1jT24s680rZ5c+NO8dbW/O/YX7Z4fl/mK23Ra3mfOpslLOnUrngVs/f0obM+D6sFfOkb
         E/KW15zvLftnWJ2Z9U6sBH02xfeaC6/s+EKXi6r7EWETAi8ZvFiCZ6Xq7xZN1gaRCglj
         f3MAA8eOnj9CO7kHHWGnakMuD27Si+dRPJzL/pMD9PSnsgdXqWTdxfSMvyLIcAbZ1M64
         BSatGSdVRVSI0trF2yo54tnDhkjo8UsS4lIkQjj0vlQ0b5vF9ZwsJ9XxAbT+VhaAa5ah
         seXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1WN6UklSK5YnpCCTWETNdiiLh7JAqP1icKWs3q8Yju8=;
        fh=yYvUm8q20CaNND69y9DvocVj0rmBcLdhYOYGzCFdDcM=;
        b=SfgMnJ3H1eCrJM4yJiJ3uCr2siBMUzgdkBONEqaSFqNGfTlbwinpVhAM+bfemdwpmo
         OpQUawB+drugYBzSGj5Xha3FL/9wb6x6NdzR1Z8MPAynQI362pFH1f0ZJFp9/YfD1W7f
         Weii12s/AyvOpavotGGdAMz6m+i2w9hLM7ciouUhm7g+xyjdGsvkhVRKeRupiJjsPfkC
         QNzvNV+f1bvyt9ebAEmv9oCXc+0B2SS+N2S52C3uDUHtg0TfeOxB+nlCbcZifcstg1ht
         OSUxu3vzpdRLgjYibURXVgzrqznkdjneOxgrkFjj+sQTSqdoffm+kPLuw3TiFN1YSfW8
         g2tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791025237; x=1791630037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1WN6UklSK5YnpCCTWETNdiiLh7JAqP1icKWs3q8Yju8=;
        b=Hy6aN/5xF6zIBTlls55A4kZToUmtoVccfhawOzvuWP5LLxLrhH4buJQkO/emCfchv/
         9qG7p0mnkvuFJ0IslPIyRGas4Io8CHGcUhKAq4jn1cDTdm8btUHfG43VAifQX1jDN6fJ
         SDYKYRVmt36UeIOR/4ODo9fzFuYN0X6L9uNt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791025237; x=1791630037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WN6UklSK5YnpCCTWETNdiiLh7JAqP1icKWs3q8Yju8=;
        b=uHwdXx9EL5I+Y/HsAZ9X6VZrbU39BJI7HtLYfpFjpaaoSWqImeAtf+QrRad61HNLJU
         TrBJTLxXpCEW21KZ6m8w9ViL4kvrwYR1zYLDLkTP1PNMctCZncTlbO/AE6iv6JcICe5v
         jFlfpWwxjVc90dZtLz5hPqZ68MSfWbLc9cmDCiEmOQ2ClGPMDJTO675KTm3umGxz1nlu
         VZy9BLWOGGTHexesZAgvRisdLzOClZH+Jlblzic+Ee42vOrGGroFFWA2Gk4fR2Ng4Cpk
         SpS2M1skwjIs3KaooJYTWMKoYa9mScyy2U0OQae9mHokxGMospLZGr/C5A/sO6v64UVY
         7rlQ==
X-Gm-Message-State: AFuF++nK01dAPirLj5koyMx012EaKfBAKuOy7C2aos8gsxZjEI61DJkS
	iGCrUjGiRa2PhYHvQKEDCCv5Gmg02P+wfdAcRSckL2Wyv5LjACQFIrW3K26P98Nk/w8kTGos8xl
	RBbyWyYWweYeIu3FnEImsg9lXK/fLegCz4/tr8l3q
X-Gm-Gg: AYBFou3uITBlM27XxLRnDQqCgX5iglGsaSifk2F71yvR2YGljoL4nDvJmhR3X+cgnMn
	pEmt9Jp7Wpsy7Rv7N9L7cV2+lyZtLjo2fBtj11qXnDAKLANesOldFBn9mPJlLq9I4DnKUOejqZI
	TO8YOY94yA1lTyu741QB0pxj5Iu93QImgfz3TdselvOO3DynpyIvRP7b4lazU7PRzjxOiwl9DJ4
	DijqC3+ARDhmilEC0+PIPVX7jX6Ub/uY6iCWJZSr2I8lH0kSvse9pj6zAsHrqtdjZ80pxyyEj2/
	LlaIVcw0njYpkkgE+aaDXti4IDBTZE0mGCWHQfQo2qewLmDVb47vZnQaQYy/F65y1mENKSexYlJ
	O0NReWuWT1m3NzQBpPd0STiUFr3r92Yq6yA==
X-Received: by 2002:a05:6a00:391a:b0:883:371:88e5 with SMTP id
 d2e1a72fcca58-88af73eb135mr4898850b3a.38.1791025237571; Sat, 03 Oct 2026
 04:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-6HS9.v1.20260928064754@mojatatu.com.1> <179077366943.434549.8458923511073715827@kernel.org>
 <CAM0EoMnfws0ZpmCwbjgihfrLFMYe6Vyo6TK=OXhWwmv+m1qeug@mail.gmail.com>
In-Reply-To: <CAM0EoMnfws0ZpmCwbjgihfrLFMYe6Vyo6TK=OXhWwmv+m1qeug@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 3 Oct 2026 07:00:26 -0400
X-Gm-Features: AclHuK_j83dP7-dtV5lKa_hl3nv9KdF9KKq6PWdNoVMGqB50PbjF6e03p3zZz1s
Message-ID: <CAM0EoM=4CcBYcWh66um64Z+5xkCe0=L1Nbv=FjphO_0H11WC6Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: sch_teql: fix shared headroom and
 header strip on slave retry
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, hybris@mojatatu.ai, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:57=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Wed, Sep 30, 2026 at 9:07=E2=80=AFAM <netdev-bot+sashiko@kernel.org> w=
rote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 (1) =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] The commit message and the new code comment give the wrong
> >   reason for problem 1 and the wrong way to reproduce it.
> >
> > Pre-existing issues:
> > - [Critical] teql_master_xmit() in net/sched/sch_teql.c treats a slave
> >   transmit as successful only when `netdev_start_xmit(skb, slave,=E2=80=
=A6
> >
>
> Sorry, I missed responding to this:
> This is  a different root cause from this patch series - we are going
> to send a followup fix if no one beats us to it.
>

For completion:  nothing on patch 2. So i dont see any reason to
resend this series.

cheers,
jamal

> cheers,
> jamal
>
> > --
> >
> > net/sched: sch_teql: fix shared headroom and header strip on slave retr=
y
> >
> > The patch adds a skb_cow_head() call before dev_hard_header() in
> > __teql_resolve(). It also changes teql_master_xmit() so that, when a
> > slave attempt fails, it pulls back only the header length that
> > teql_resolve() pushed for that slave. It no longer pulls
> > skb_network_offset() bytes.
> >
> > Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mo=
jatatu.com/
> > Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@=
mojatatu.com
> >
> > > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > > index 409ce50cc0dbc..acd03f9afc6b8 100644
> > > --- a/net/sched/sch_teql.c
> > > +++ b/net/sched/sch_teql.c
> >
> > [ ... ]
> >
> > > @@ -265,15 +265,28 @@ __teql_resolve(struct sk_buff *skb, struct sk_b=
uff *skb_res,
> > >       }
> > >
> > >       if (neigh_event_send(n, skb_res) =3D=3D 0) {
> > > +             int off =3D skb_network_offset(skb);
> > >               char haddr[MAX_ADDR_LEN];
> > >
> > >               neigh_ha_snapshot(haddr, n, dev);
> > > +             /* The skb may be shared (e.g. a packet tap clone); mak=
e the
> > > +              * headroom private before dev_hard_header() writes int=
o it.
> > > +              */
> > > +             if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
> >
> > [Severity: Medium]
> >
> > The skb_cow_head() call looks right. Are this comment and the commit
> > message accurate about why it is needed?
> >
> > The commit message says:
> >
> >     1. When the skb is shared (for example a packet tap installed on th=
e
> >        master makes xmit_one() clone it before teql_master_xmit()),
> >
> > and later:
> >
> >     and a shared skb is unshared before it is modified.
> >
> > skb_cow_head() only handles skb_header_cloned(). It does nothing when
> > skb_shared() is true (users > 1). If it has to expand the head,
> > pskb_expand_head() has:
> >
> >     BUG_ON(skb_shared(skb));
> >
> > Would "header-cloned" be a more accurate term than "shared" in both
> > places?
> >
> > Can the packet tap reproducer actually show corruption?
> > teql_master_setup() never sets header_ops and uses ARPHRD_VOID, so
> > dev_has_header() is false for the master. packet_rcv() and tpacket_rcv(=
)
> > only push back to the mac header when it is true:
> >
> >     if (dev_has_header(dev)) {
> >         if (sk->sk_type !=3D SOCK_DGRAM)
> >             skb_push(skb, skb->data - skb_mac_header(skb));
> >
> > So the tap only sees bytes from skb->data onward. __teql_resolve()
> > writes the slave header into [data - hlen, data), which the tap never
> > reads.
> >
> > A trigger that does seem to cause visible corruption is a tc mirred
> > mirror on a physical device's clsact egress, with the teql master as
> > the target.
> >
> > sch_handle_egress() runs before skb_dst_drop(), so the clone keeps its
> > dst. ARPHRD_VOID is not a mac-header-xmit type, so tcf_mirred_to_dev()
> > pulls mac_len off the clone:
> >
> >     expects_nh =3D want_ingress || !m_mac_header_xmit;
> >     at_nh =3D skb->data =3D=3D skb_network_header(skb);
> >     if (at_nh !=3D expects_nh) {
> >         ...
> >             skb_pull_rcsum(skb_to_send, mac_len);
> >
> > The original skb's Ethernet header then sits in the clone's shared
> > headroom, and dev_hard_header() in teql overwrites it.
> >
> > Should the reproduction steps in the commit message describe this case
> > instead?
> >
> > The subject and body also say both problems happen "on slave retry".
> > The header write, and now the COW, happens on every slave attempt,
> > including a first attempt that succeeds. Could the wording reflect
> > that?
> >
> > [ ... ]
> >
> > > @@ -374,8 +390,14 @@ static netdev_tx_t teql_master_xmit(struct sk_bu=
ff *skb, struct net_device *dev)
> > >                       nores =3D 1;
> > >                       break;
> > >               }
> > > +             /* Undo only the header teql_resolve() pushed for this =
slave.
> > > +              * Pulling skb_network_offset() instead would strip a
> > > +              * userspace-supplied header when the slave added none,=
 e.g.
> > > +              * an AF_PACKET/SOCK_RAW frame with no dst entry.
> > > +              */
> > > +             if (hlen > 0)
> > > +                     __skb_pull(skb, hlen);
> > >               skb->dev =3D dev;
> >
> > [Severity: Critical]
> >
> > This isn't a bug introduced by this patch, but can this __skb_pull()
> > and the skb->dev write touch an skb that the slave has already
> > consumed?
> >
> > teql_master_xmit() counts a slave transmit as successful only when it
> > returns NETDEV_TX_OK:
> >
> >     if (!netif_xmit_frozen_or_stopped(slave_txq) &&
> >         netdev_start_xmit(skb, slave, slave_txq, false) =3D=3D
> >         NETDEV_TX_OK) {
> >
> > Stacked slaves such as 8021q, and macvlan through macvlan_start_xmit(),
> > return the lower device's dev_queue_xmit() result unchanged:
> >
> > net/8021q/vlan_dev.c:vlan_dev_hard_start_xmit() {
> >     ...
> >     ret =3D dev_queue_xmit(skb);
> >     ...
> >     return ret;
> > }
> >
> > That result can be NET_XMIT_DROP, NET_XMIT_CN or a negative errno.
> > dev_xmit_complete() treats all of these as consumed:
> >
> >     if (likely(rc < NET_XMIT_MASK))
> >         return true;
> >
> > For NET_XMIT_DROP the skb is already freed, for example in
> > __dev_xmit_skb():
> >
> >     kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_BURST_DROP);
> >     return NET_XMIT_DROP;
> >
> > For NET_XMIT_CN it may still be queued on the lower qdisc.
> >
> > In both cases teql falls through to this block. For a VLAN slave with a
> > resolved neighbour, hlen is ETH_HLEN + VLAN_HLEN, so __skb_pull() and
> > skb->dev =3D dev write to the consumed skb.
> >
> > The loop then calls teql_resolve(), skb_cow_head(), dev_hard_header()
> > and netdev_start_xmit() again on it, or it reaches the drop label:
> >
> >     master->tx_dropped++;
> >     rcu_read_unlock();
> >     dev_kfree_skb(skb);
> >
> > Would that be a double free? The function can also return
> > NETDEV_TX_BUSY, and the core would then requeue a freed skb.
> >
> > The setup needs CAP_NET_ADMIN to attach teql as root on a VLAN or
> > macvlan device. After that, ordinary congestion on the lower device is
> > enough to hit this path. The rest of the series does not seem to fix it
> > either; the final state still compares against NETDEV_TX_OK.
> >
> > Since this patch already reworks the post-failure skb handling on this
> > path, would it make sense to check dev_xmit_complete() on the return
> > value instead of comparing it with NETDEV_TX_OK?
> >
> > >       } while ((q =3D rcu_dereference(NEXT_SLAVE(q))) !=3D start);
> > >
> > >       if (nores && skb_res =3D=3D NULL) {
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/QDISC-6HS9.v1.20260928064754%40mojatatu.com
