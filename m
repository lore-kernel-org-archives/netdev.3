Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9633BD643
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538585; cv=pass; b=VJD8WA2iGf7/+Q320DTTBLcte0F3nAGWlmknRnsazPD2uSnbfg1G5rJsC74Y6uJrh7L32qsCZS39chm7xKvnLkBD/gxOS8v1hB3wmWtvJLfafiXmB1qgjsoaslystT1Oxs5c1j2fVY5fcj+s7q4R07KnsbKpxczhGQ6sMLx+IGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538585; c=relaxed/simple;
	bh=tTIYMXBBKuNeukVMDbEhGNQ/MJhu970OibGNjiZv/8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8iiAOSDsR1Yoch2TyBtLRBl7/Ink1Ig3le5JC9CgYMggmAXnHNbpsj5MLe/yNmiucwj2QbM0MEkS3QZJVPwx814l3jbk28ZzMv0LtYY4AXY+5cDULp2GbSo/1AGzctwPeZukRQGm92sRAr2MAgy2buvtnJMWKxF4GRXBpyOCeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQ5PYkuJ; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQ5PYkuJ"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b1b881a8e9so559940eaf.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788538582; cv=none;
        d=google.com; s=arc-20260327;
        b=KsW+plRkFv7p6ZgXJkAt49LpNvzw65R0r7/1vIjnbWspi8lPJrEkDyaoC7jeLzwRFq
         NjUmnNibu4KvdXqENxLVVAlpCO4cUiP8grmzGOO3Nzf9dPrLC1ESQ1iExTYXr5TrEGMy
         WZi70juSkjEPfFNaPoaP78pDPVUSA1H5O+6pCpzIRrUeSIMgl3K4uybPF44NYvf5hqqM
         kv7z95CCWUdQfJLZPYHaFReZ4fmJXsdMJa+EbMN5d7i3dvs7qwzIvY88L1lIRLGadtE9
         6Vh9CqSFId7qINP03nsiTnJ9zyNPHqfENgz5riX2zYBSiD0dywYgxiYq/fZXlyjNr0iF
         g0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EmauK4x4jaQgrvkkRYmcwqIUZGhjm/Uo11oLMGjcBkc=;
        fh=P8x20FwT6GHu0zKKYfFUYA2F4rX37Ef497hdD6WDHkk=;
        b=TcRn59fBTTd927zuIViaob1TyIMK+Cm5ckxUjYXozchzkI/MtKVNAfHWJRvUPMvb4u
         tA8IL70Yiv+rfvvPqly9YEZE9QnmdqTEFfqvZPvZScwJud1Evfe9IMcuH4InnvYBi864
         IVTmA8jYu/CLY2SwRt2uMdABW4tRDRy4H0OIFO5S4qmLDLtdo8kuUCgLBhUa/cHodu/b
         fZCfnlxXfjpgHenz8QBrl2UEIFxfQnLktK/EsQNPbEUlLcR0FbnDwQJ+GwYxM4g9RlHV
         EjjBI5xUXQpEPrce8uNoJsQLXOo9RR522n6XidbLMWIVzPbDkj3c0tAZqhOXVrV7MjPJ
         IryQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788538582; x=1789143382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EmauK4x4jaQgrvkkRYmcwqIUZGhjm/Uo11oLMGjcBkc=;
        b=HQ5PYkuJidfdZ3Mfyn7YS2NtUoJVc8DiXB1BiyyA1jY2Gk3WbUlsOgRmCM2fChPl6b
         C57w4r4/I/oSOY98vohnl84YcjtVlgP3kPCSatYKvxqZDI/ulEQGu9K/Rmb/GhjDsmpA
         dYndrXURCN8JMCfguERN15xgO4Dnr7EJ6uDs8dAGLagzkPhmKpWeX2ano1W/Q0JB/VgG
         E4XXnQ8Cc5Z8kX7O8RqCBjzdsVib0mrks7U5TI6t+XSdCPYWHuVYyNGck4UkM6WHH7Qk
         IWkK1ftH81YzP9eKrf5bF8vL2m9gRNGXPEEJ5A0nUJnlSgWzJaSXXHe+bpU5gm9eY8Uu
         s+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538582; x=1789143382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EmauK4x4jaQgrvkkRYmcwqIUZGhjm/Uo11oLMGjcBkc=;
        b=tVBry50uI6FV/TT7iP75KDqHJ6V5kfrD9EhltBfbGJFB6CNwpxJnjc09PXfiM2FB5r
         IcXTG9v9QXhME2ZmQsQmaWYiP+a6uMI1ay7HqWXIdfi499HdoHyOl7S6RqC5ou2NTEHF
         72non4vDP7alHYHPfMzUQf/nRdDHoaJ2EGT1iRectHro/PX0YXTrW9LTvZGkffNKhOM5
         77H5mNMYzaICwlKEcpUE7K/Lo3FdDHsc7v2DPpJiRDRgbBtrn7xGg3vJrZoCBLtL1tko
         Lqw4aqz+3TbyVjwDV9eFFdro51a/4q5fbtT2otADuxZv2RKwkkk6MDHFL7mteRdLCILR
         1Q2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzdhwhK9ZSVue81prMqXbL/ogDf6vz71wQQXMzWGdefW9G72dDomLcZsa0IoDplmiYQfEP2KDY=@vger.kernel.org
X-Gm-Message-State: AFuF++ktrGc0wSGlQZP+3/HbXnfFOqubuc92mITYmmpqf/k2qQ/lWFqp
	SAtWpTX5pDp7gD4r9OADlnzit61+U7Ac8TaCmJNeG2T0BcjtirTqw2fJFxq7NUDDRRoGlg8PeCE
	5Vrmm8Z97r6i3VtyPR9wNOiA8NjFVN24kjxxVspDZ
X-Gm-Gg: AYBFou3iP7NY79RMrzQ3mYE4msAQxHbCLdmQZtoHfhvFAj7MN6qzFtBlC84x8uJFoqZ
	KIqKW5MDj9TYJnmXDyLWqPKtAdRzjwNGs+aB8pRsjElmuvQDo5Y2LEv+LNrmTvUpORJud2P5h5D
	esZTP5A3Ir55h/k0yuXIbemlek303bTDf4EHQzogtvEMVgb8AEVZdWgWRNFJCoMPTzphIgmMh5x
	f6fDMawb3A8ixLIsaouiUGYZcgzTePtFxzbyTn7MJS/Y6LOu1SVTacPJYM49cYipZzh3ZBkdNTs
	fEdH+MqyXZ0p+0Z5tKD1y7o1ypXOS00YWVFTj+G+muzMB2RpZUtaenzro7Vr9CNPJEmDDR/4wWP
	ZmArwOLRFfaC94eC/HEXOjfUbkBKns+7oebGdAzmixm4hkkqXDGVTV3BIQybDmXRTnTxHyyoN9Z
	EVSI8nmkJKVCYv
X-Received: by 2002:a05:6820:60b:b0:6b7:8396:f3c2 with SMTP id
 006d021491bc7-6b78396f7ecmr2667337eaf.36.1788538581195; Fri, 04 Sep 2026
 09:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902203722.926528-9-kuniyu@google.com> <178849139822.4131868.12725598676678725342@kernel.org>
In-Reply-To: <178849139822.4131868.12725598676678725342@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 09:16:08 -0700
X-Gm-Features: AcwNN1XG3i_F_c8PLSW8defdLmXHx53zLKXz2yh-Mvwr9kvwlFQPvcyNtwga-74
Message-ID: <CAAVpQUB-ZPABt7hrpM3pcE6LMPoD-tv9P2VrYGDQE58VqmPRNw@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 08/15] ipv4: Replace &arp_tbl with arp_table(net).
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, 
	horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:10=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 2
>
> - [High] mlx5e_tc_update_neigh_used_value()
>   (drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c) now=E2=80=
=A6

This is a pre-existing issue as mentioned in the commit message.

  3. mlx5e_tc_update_neigh_used_value() dereferences nhe->neigh_dev
     in trace_mlx5e_tc_update_neigh_used_value().


> - [Low] estill instructs switchdev
>   driver authors to resolve nexthops against, and monitor updates to,=E2=
=80=A6
> - [Low] The patch introduces new reads of the RCU-protected netns pointer
>   dev->nd_net via the non-RCU accessor dev_net() in paths that run only=
=E2=80=A6

I'll follow up on these if there are no other critical issues.



>
> Pre-existing issues:
> - [Medium] The neighbour fallback path in mlx5e_ipsec_init_macs()
>   (drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c, label=E2=80=
=A6
>
> --
>
> ipv4: Replace &arp_tbl with arp_table(net).
>
> In preparation for per-netns neighbour tables, this converts all users of
> the global arp_tbl to the arp_table(net) accessor, makes arp_tbl static i=
n
> net/ipv4/arp.c and drops its EXPORT_SYMBOL. It also removes some driver
> checks that compared n->tbl against &arp_tbl and &nd_tbl.
>
> A few questions below.
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c =
b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> > index 8b827201935e..33737a29ab97 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> > @@ -393,20 +393,10 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5=
e_neigh_hash_entry *nhe)
> >       struct mlx5e_encap_entry *e =3D NULL;
> >       struct mlx5e_tc_flow *flow;
> >       struct mlx5_fc *counter;
> > -     struct neigh_table *tbl;
> >       bool neigh_used =3D false;
> >       struct neighbour *n;
> >       u64 lastuse;
> >
> > -     if (m_neigh->family =3D=3D AF_INET)
> > -             tbl =3D &arp_tbl;
> > -#if IS_ENABLED(CONFIG_IPV6)
> > -     else if (m_neigh->family =3D=3D AF_INET6)
> > -             tbl =3D &nd_tbl;
> > -#endif
> > -     else
> > -             return;
> > -
> >       /* mlx5e_get_next_valid_encap() releases previous encap before re=
turning
> >        * next one.
> >        */
> > @@ -447,12 +437,23 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5=
e_neigh_hash_entry *nhe)
> >       trace_mlx5e_tc_update_neigh_used_value(nhe, neigh_used);
> >
> >       if (neigh_used) {
> > +             struct net_device *dev =3D READ_ONCE(nhe->neigh_dev);
> > +             struct net *net =3D dev_net(dev);
> > +             struct neigh_table *tbl;
>
> [Severity: High]
> Is nhe->neigh_dev safe to dereference here?  As far as I can tell no
> reference is taken on it.  It is only stored:
>
> drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c:mlx5e_rep_neigh_en=
try_create() {
>         ...
>         WRITE_ONCE((*nhe)->neigh_dev, neigh_dev);
>         ...
> }
>
> and there is no netdev_hold()/dev_hold() for it anywhere, and no
> NETDEV_UNREGISTER handling in the mlx5 rep neigh code that would clear it=
.
>
> The rest of the driver only ever compares the field, never dereferences i=
t:
>
> drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c:mlx5e_rep_neigh_up=
date() {
>         ...
>         same_dev =3D READ_ONCE(nhe->neigh_dev) =3D=3D n->dev;
>         ...
> }
>
> Before this patch the pointer was only handed to neigh_lookup(), which
> never loads from the netdev (arp_hashfn() uses hash32_ptr(dev) and the
> lookup only compares n->dev =3D=3D dev), so a stale pointer was harmless.
> Now dev_net(dev) reads dev->nd_net and the result is dereferenced again b=
y
> arp_table(net) as net->neigh_tables[NEIGH_ARP_TABLE].
>
> If the cached route egress device (for example a vlan or bond on top of t=
he
> uplink) was unregistered and freed while the nhe is still alive, does thi=
s
> read freed memory and then index a garbage struct net?  The reachable pat=
h
> is the periodic work:
>
> drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c:mlx5e_rep_neigh_st=
ats_work() {
>         ...
>         while ((nhe =3D mlx5e_get_next_nhe(rpriv, nhe)) !=3D NULL)
>                 mlx5e_tc_update_neigh_used_value(nhe);
>         ...
> }
>
> and rtnl_lock() held there does not keep an already-unregistered netdev
> alive, since free_netdev() runs from netdev_run_todo() after rtnl_unlock(=
).
>
> Also, note 3 in the changelog says:
>
>   "3. mlx5e_tc_update_neigh_used_value() dereferences nhe->neigh_dev
>       in trace_mlx5e_tc_update_neigh_used_value()."
>
> Does that justification hold?  The tracepoint dereference lives in
> TP_fast_assign():
>
> drivers/net/ethernet/mellanox/mlx5/core/diag/en_tc_tracepoint.h:
>         TP_STRUCT__entry(__string(devname, nhe->neigh_dev->name)
>
> which only runs when the tracepoint is enabled, so it does not show the
> pointer is safe to dereference unconditionally.
>
> Would deriving the netns from a refcounted device such as e->out_dev or
> priv->netdev work instead?
>
> >               nhe->reported_lastuse =3D jiffies;
> >
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +             if (m_neigh->family !=3D AF_INET)
> > +                     tbl =3D &nd_tbl;
> > +             else
> > +#endif
> > +                     tbl =3D arp_table(net);
> > +
> >               /* find the relevant neigh according to the cached device=
 and
> >                * dst ip pair
> >                */
> > -             n =3D neigh_lookup(tbl, &m_neigh->dst_ip, READ_ONCE(nhe->=
neigh_dev));
> > +             n =3D neigh_lookup(tbl, &m_neigh->dst_ip, dev);
> >               if (!n)
> >                       return;
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b=
/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > index db260e3d1412..37a8ddee3ea1 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> > @@ -364,9 +365,10 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ips=
ec_sa_entry *sa_entry,
> >       return;
> >
> >  neigh:
> > -     n =3D neigh_lookup(&arp_tbl, pkey, netdev);
> > +     tbl =3D arp_table(dev_net(netdev));
> > +     n =3D neigh_lookup(tbl, pkey, netdev);
> >       if (!n) {
> > -             n =3D neigh_create(&arp_tbl, pkey, netdev);
> > +             n =3D neigh_create(tbl, pkey, netdev);
> >               if (IS_ERR(n))
> >                       return;
> >               neigh_event_send(n, NULL);
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, since the pre-patch code alrea=
dy
> used &arp_tbl unconditionally here, but should this fallback pick the tab=
le
> based on addrs->family?
>
> The AF_INET6 branch above can reach this label with a 16-byte key:
>
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:mlx5e_ipsec_init=
_macs() {
>         ...
>                         pkey =3D &addrs->saddr.a6;
>         ...
>         case AF_INET6:
>                 if (!IS_ENABLED(CONFIG_IPV6) ||
>                     ip6_dst_lookup(dev_net(netdev), NULL, &rt_dst_entry, =
&fl6))
>                         goto neigh;
>         ...
> }
>
> and the ARP table has .family =3D AF_INET and .key_len =3D 4, so the look=
up
> hashes and compares only the first 4 bytes of the IPv6 address.  Can
> neigh_create() then install a bogus ARP entry and send an ARP request for
> an address made from those 4 bytes, leaving the IPv6 packet-offload SA wi=
th
> attrs->drop set or an unrelated MAC?  A separate fix using the netns ND
> table for AF_INET6 seems needed.
>
> > diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/=
drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> > index ca30702f8878..551db6417405 100644
> > --- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> > +++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> > @@ -235,7 +236,8 @@ void nfp_tunnel_keep_alive(struct nfp_app *app, str=
uct sk_buff *skb)
> >               if (!netdev)
> >                       continue;
> >
> > -             n =3D neigh_lookup(&arp_tbl, &ipv4_addr, netdev);
> > +             tbl =3D arp_table(dev_net(netdev));
> > +             n =3D neigh_lookup(tbl, &ipv4_addr, netdev);
> >               if (!n)
> >                       continue;
> >
>
> [ ... ]
>
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index 459f19f7071e..03e932744e3e 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -1841,11 +1841,12 @@ static int vxlan_err_lookup(struct sock *sk, st=
ruct sk_buff *skb)
> >
> >  static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __b=
e32 vni)
> >  {
> > +     struct neigh_table *tbl =3D arp_table(dev_net(dev));
> >       struct vxlan_dev *vxlan =3D netdev_priv(dev);
> > +     struct neighbour *n;
> >       struct arphdr *parp;
> >       u8 *arpptr, *sha;
> >       __be32 sip, tip;
> > -     struct neighbour *n;
>
> [ ... ]
>
> > diff --git a/include/net/arp.h b/include/net/arp.h
> > index f8d18b1f8b28..e932def63d62 100644
> > --- a/include/net/arp.h
> > +++ b/include/net/arp.h
> > @@ -7,8 +7,6 @@
> >  #include <linux/hash.h>
> >  #include <net/neighbour.h>
> >
> > -extern struct neigh_table arp_tbl;
> > -
> >  static inline struct neigh_table *arp_table(struct net *net)
> >  {
> >       return net->neigh_tables[NEIGH_ARP_TABLE];
> > @@ -25,10 +23,12 @@ static inline u32 arp_hashfn(const void *pkey, cons=
t struct net_device *dev, u32
> >  #ifdef CONFIG_INET
> >  static inline struct neighbour *__ipv4_neigh_lookup_noref(struct net_d=
evice *dev, u32 key)
> >  {
> > +     struct neigh_table *tbl =3D arp_table(dev_net(dev));
> > +
> >       if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
> >               key =3D INADDR_ANY;
> >
> > -     return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, arp_hashfn=
, &key, dev);
> > +     return ___neigh_lookup_noref(tbl, neigh_key_eq32, arp_hashfn, &ke=
y, dev);
> >  }
>
> [Severity: Low]
> Should these new netns reads use dev_net_rcu() instead of dev_net()?
>
> possible_net_t holds a struct net __rcu *net published with
> rcu_assign_pointer() via write_pnet(), and the two accessors differ:
>
> include/net/net_namespace.h:
>         static inline struct net *read_pnet(const possible_net_t *pnet)
>         {
>                 return rcu_dereference_protected(pnet->net, true);
>         }
>         ...
>         static inline struct net *read_pnet_rcu(const possible_net_t *pne=
t)
>         {
>                 return rcu_dereference(pnet->net);
>         }
>
> dev_net() goes through read_pnet(), which asserts unconditionally that th=
e
> caller holds RTNL or a device reference, so it silently turns off
> lockdep/sparse RCU checking on these new dereferences.
>
> The sites added by this patch that run under rcu_read_lock() only are
> __ipv4_neigh_lookup_noref() and ip_neigh_gw4() (reached from
> ip_finish_output2()), br_do_proxy_suppress_arp(), the vxlan
> arp_reduce()/route_shortcircuit() xmit paths, and nfp_tunnel_keep_alive()=
,
> which is called inside its own rcu_read_lock().  None of them held RTNL o=
r
> a netns reference before, and none of them read dev->nd_net at all before
> this patch.
>
> The dev_net() uses in inetdev_init(), inetdev_destroy() and arp_ifdown()
> look fine since RTNL is held there.
>
> > diff --git a/include/net/route.h b/include/net/route.h
> > index 45290177a33c..6b55de2e4df8 100644
> > --- a/include/net/route.h
> > +++ b/include/net/route.h
> > @@ -405,8 +405,11 @@ static inline struct neighbour *ip_neigh_gw4(struc=
t net_device *dev,
> >       struct neighbour *neigh;
> >
> >       neigh =3D __ipv4_neigh_lookup_noref(dev, (__force u32)daddr);
> > -     if (unlikely(!neigh))
> > -             neigh =3D __neigh_create(&arp_tbl, &daddr, dev, false);
> > +     if (unlikely(!neigh)) {
> > +             struct neigh_table *tbl =3D arp_table(dev_net(dev));
> > +
> > +             neigh =3D __neigh_create(tbl, &daddr, dev, false);
> > +     }
> >
> >       return neigh;
> >  }
> > diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.=
c
> > index 87a40e2f1c50..92a3abb1e357 100644
> > --- a/net/bridge/br_arp_nd_proxy.c
> > +++ b/net/bridge/br_arp_nd_proxy.c
> > @@ -193,7 +193,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, =
struct net_bridge *br,
> >               return;
> >       }
> >
> > -     n =3D neigh_lookup(&arp_tbl, &tip, vlandev);
> > +     n =3D neigh_lookup(arp_table(dev_net(vlandev)), &tip, vlandev);
> >       if (n) {
> >               struct net_bridge_fdb_entry *f;
> >               u8 ha[ETH_ALEN] __aligned(2);
> > diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> > index 824c65c70408..a44fa68fdd07 100644
> > --- a/net/ipv4/arp.c
> > +++ b/net/ipv4/arp.c
> > @@ -149,7 +149,7 @@ static const struct neigh_ops arp_direct_ops =3D {
> >       .connected_output =3D     neigh_direct_output,
> >  };
> >
> > -struct neigh_table arp_tbl =3D {
> > +static struct neigh_table arp_tbl =3D {
> >       .family         =3D AF_INET,
> >       .key_len        =3D 4,
> >       .protocol       =3D cpu_to_be16(ETH_P_IP),
> > @@ -182,7 +182,6 @@ struct neigh_table arp_tbl =3D {
> >       .gc_thresh2     =3D 512,
> >       .gc_thresh3     =3D 1024,
> >  };
> > -EXPORT_SYMBOL(arp_tbl);
>
> [Severity: Low]
> Should Documentation/networking/switchdev.rst be updated in this patch to=
o?
>
> Its Nexthop Resolution section still tells switchdev driver authors to us=
e
> the symbol that becomes file-local here, in four places:
>
>   "address discovery comes via the ARP (or ND) process and is available v=
ia
>    the arp_tbl neighbor table."
>
>   "The driver can monitor for updates to arp_tbl using the netevent notif=
ier
>    NETEVENT_NEIGH_UPDATE. ... The driver implements ndo_neigh_destroy to =
know
>    when arp_tbl neighbor entries are purged from the port."
>
> At this commit, git grep arp_tbl matches only net/ipv4/arp.c and
> Documentation/networking/switchdev.rst, and the doc points at rocker as t=
he
> reference implementation while rocker itself is converted to
> arp_table(&init_net) here.  The doc also never mentions arp_table(net) or
> the new requirement to pick the table belonging to the device's netns (or
> init_net for netns-immutable devices).  The text is still unchanged at th=
e
> end of the series (d4be111038a59be6217f9b018ec033041ab7bf2a).
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902203722.926528-1-kuniyu%40google.com
