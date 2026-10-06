Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6747049E129
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309733; cv=pass; b=QfrccK6Uk3WMXq/SqaDEPj8l89dUZ+rLgWayBTN2XSuaX4cJD4P72BP7qARrPd+FJDKhkrzZ/pUB/cCFnuVcpdYVARP80rp36GQ6vG6ySElz4dKa06Kqk5vE7i5yehlT1IoSNfVr4UJb4KePBCv6psTJ5/f6dKiUcSjH2YoP+uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309733; c=relaxed/simple;
	bh=RzsjoAB/X15kGlZvwYpEQcCKjwrake2puTg/raMgnBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP+8yjV+5xYA5zKpKngvdcJawItwv/MuUSdswkrxWMN+WNpj59WEj8FWlNvDxhZkZdI3XVqhJeoIObeU55cUhuhVvHLoUVaASO3Jpfa7rfH6woyf6HhLYHsQuXhBedR1HuU7Uc7M6YlKU2CXu9YLZr/XDiCAbie5+h8WMqdtwKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHB73YTv; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHB73YTv"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-34c89609923so2686683eec.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 11:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791309726; cv=none;
        d=google.com; s=arc-20260327;
        b=rJ3fy5qUeDgwLEqOsKkM/vFl6IpFlmkwpcwzNTw2E8THIuCo+bwgbF3DE464GGbMZF
         xV4673wCwT4Tu+HtiqsL4VdgQmzIAZLjRMku66eVh387UDMm/X+ScmG0GxGJRlBR7mJI
         LGbNJrKeaoHQ10QjjQA0do02T2Y4BKvvjx2dH8ltuJGHLKyC8XlxGv6wTBzQdwT1yNWn
         zRNj+8rMe8i0eToAfO1MnFdPrD1VM/60p0ZRbIQCgdxSLYv2lCCbPXTPZHkpSm5zGbdr
         GFUbFYznmS2OyLQy6K3ZtEGY4PaIW58JW+sGAWWZIdJioRpUo33nkv+FQePqxVgk9HuO
         CqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVqubsa76Ow3kCZCxdJEYFBRFDMm/IeqP6PyI46HfII=;
        fh=ym+M57A6MlzvQMvTP5idBaM2oHzhNSSrl6q7PQc8dxI=;
        b=OPDmeCAs0fnuFe6ddNRfGAqSWuTlVLk4OwT3WDzCmPgdaw3QsUJeO3Vj++bmPet+Lz
         usuW8i3z5VYUEXcqYidpae/u5FqVkIK++dhw0oXOeLKV/MHVXwOJ75FL+DsspAlsuRIv
         6C6JcAdrOavW3gQvsu/3KPvfMs4C5ZrNOQU4/C6KlfJZg4HAQJyaA2xS3ei0MnDtibON
         jDQuGxv5/f/OhlZvNkkS7LAqoe3VrARFJxBb0IfQLvg0uoljFZ6ck4CRdQl0b8afKo71
         2p26ptV6MBtg1pGFSHeE/hPHlm10h0Bj0hQFBjVxGV7n2XskC2VMcItTgU7Pt8vRl4jf
         TIjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791309726; x=1791914526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aVqubsa76Ow3kCZCxdJEYFBRFDMm/IeqP6PyI46HfII=;
        b=aHB73YTv/Xr8QqNkR1CbwKzyQjt0UXvGxIutJUR4S2YKupsKROwPsR6CyLLzsXa0qD
         fb6OJMgSjsf5gu9xNvqvpY8pHKXnw4DKefuL3RSYaz/DpShj1AQM9UpcwIrGZJ9MSRpo
         pUg/dt+KI0+u/HQGn3roY8lP2qm6VDU+7Ali/xX3XmwnZMZ9QJZSe1/88rhwi69pdKvE
         J4Jm2zclXenw0V0Xl5APEKPFxialcl0601z5tIEZ66ZZVyQvRqM57g8+zdTIWd9DTsnT
         KkQpgmGcDi2pMQTvTuRFM7+tye11SFLldbX1HUa4TyYkq3hLhPXZgwF2NZKDS1VhSUSG
         rSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309726; x=1791914526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aVqubsa76Ow3kCZCxdJEYFBRFDMm/IeqP6PyI46HfII=;
        b=BVYuvojZWVzhsNFlA7kbyO1SD+TkCq7E/4qE863fLkXv2JFxREwBnXOQqZh2LFAf99
         9vW3m968tx9842WydPu0ZL8KLDFQBMbP5LDlzD8o/D2NfwncjPYT81adaDyjrF+b4MPX
         wPY0fn/aDvOc6zVCz+rzIKiVVxnUz7/VBrf+KNHLX081OpJkcN6BP65cytxuQP/Nztow
         1JaLqXVo4yD21xQTtLlsqrBfSPIfx3xPT/1e8kHWmo4AnstJEoLVYvtbe9rzG1hZDSeb
         aIXfk6G14XZf7Jxeu4fcxyzp40WLg3/XFlV01NOf33/s/4NQu9e9h1EoSFSGLqWlVPet
         J5Xg==
X-Forwarded-Encrypted: i=1; AKwUvBxlAxVZ5Ds7ctcXvXcQdmFh5aYqTuZL5Z3cDh/7lskpw8Mwd0MYkKuHBDTK2GJADLK7aU6oDFM=@vger.kernel.org
X-Gm-Message-State: AFuF++n6saaZ8W/S71Lk6ohDb3Cg8VVETdO8X9s3VyfewkZOdtrB43Ha
	6H2OF3zZhaem0YnVKO4qmWo7WI5/tuWqqs9BnPnlm2EU5qB4Q0jqwk7P0woaWK3UzSsHX+WG0sN
	s4T94kbNJA/TulySIYfBgYNX1rSvAoo8f5IataFTR
X-Gm-Gg: AYBFou3F6MK+X/ZSJ3nTnT2gk4GR2GZYoO3FIKTIIiCk9UsCaxSLEl+aZv1FQd6CSyw
	ku/whINyQyBsiopErzBg0y5H20sKd8sOfKeSpelCcPRpEgYCD6M1/8pjiXNZn8kQoCsL2V8495x
	SiFvJbq6FOfPsDbTo0YJKMpQSW8ym4596XomouWwpHJd/8ZeODPaW9tzIP+LoePgVESFforIaX3
	csvFELyfOGOzwkqGhDXwbg+FSwvGkJFaT9aYMI3p8Vcrv0o+i4jDbghpS8d3rx7vJw5GCpuws0m
	x1xhSY/RSuzqIgrBFxVUcU+vRGF+ZpC6OOcK4U/VpRfYpDe1YSP3Q4ds3Ddv+TNvYOS3jHTYPoa
	9MHlOKdfyTm684J/sVxcXbdnp12F+e2fcnYs7bpbYtBujQwMd/P8S0DQWUAFAmtlqE2jY771yHN
	alk01aURn1ehgeul7CoKKGjjE=
X-Received: by 2002:a05:7022:b056:20b0:144:c124:279 with SMTP id
 a92af1059eb24-15ecc8ea1e9mr2753830c88.35.1791309703614; Tue, 06 Oct 2026
 11:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com> <20261003212336.1304988-7-kuniyu@google.com>
 <da88c1e3-5445-4c0f-bdab-c7b451d74dd1@suse.de>
In-Reply-To: <da88c1e3-5445-4c0f-bdab-c7b451d74dd1@suse.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 6 Oct 2026 11:01:31 -0700
X-Gm-Features: AclHuK-LnbsGJNoLnvTpHEbr1JNzCGjKNKgCcDL7E-12-8yyQT2952DM0kNyK1M
Message-ID: <CAAVpQUA1NLzKjzRbKvRJOV6+fqcBqMNuZYF_4uxa0qDxokMyKA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/9] ipv6: Use ipv6_neigh_lookup() and friends.
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+5a8857f0b4a0a7b12c62@syzkaller.appspotmail.com, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 10:53=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 10/3/26 11:23 PM, Kuniyuki Iwashima wrote:
> > syzbot reported the splat below in neigh_mark_dead() [0]
> > where tbl->lock was not held while neigh_ifdown() should
> > have acquired one.
> >
> > This only happens when a neigh_table accidentally has a
> > neighbour from a different netns.
> >
> > In ip6_finish_output2(), the net argument is the caller's and
> > does not always match dev_net(dev) fetched from dst. (e.g. xfrm)
> >
> > It is error-prone to require callers to fetch netns and
> > neigh_table and pass it with dev to neigh_lookup(), etc.
> >
> > Let's replace neigh_lookup() and friends with IPv6 helpers.
> >
> > Note that __neigh_lookup() is split into ipv6_neigh_lookup()
> > and ipv6_neigh_create().
> >
> > [0]:
> > debug_locks && !(lock_is_held(&(&n->tbl->lock)->dep_map) !=3D 0)
> > WARNING: net/core/neighbour.c:154 at neigh_mark_dead+0x2fb/0x340 net/co=
re/neighbour.c:154, CPU#0: syz.0.857/9765
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 9765 Comm: syz.0.857 Not tainted syzkaller #0 PREEMP=
T(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/24/2026
> > RIP: 0010:neigh_mark_dead+0x2fb/0x340 net/core/neighbour.c:154
> > Code: e8 03 42 80 3c 28 00 74 08 48 89 df e8 ee 9a 80 f8 4c 89 33 5b 41=
 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 86 95 10 f8 90 <0f> 0b 90 e9 =
8f fd ff ff 48 c7 c1 80 9a 7a 90 80 e1 07 80 c1 03 38
> > RSP: 0018:ffffc90003726600 EFLAGS: 00010287
> > RAX: ffffffff89b7467a RBX: ffff888022e86000 RCX: 0000000000080000
> > RDX: ffffc900047fa000 RSI: 0000000000003e08 RDI: 0000000000003e09
> > RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> > R10: dffffc0000000000 R11: fffff520006e4cb8 R12: ffff888022e8613c
> > R13: dffffc0000000000 R14: ffff888022e86020 R15: ffff888022e86000
> > FS:  00007f9c30f046c0(0000) GS:ffff888124cc6000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 0000000076c56000 CR4: 00000000003526f0
> > Call Trace:
> >   <TASK>
> >   neigh_flush_one+0x27c/0x5a0 net/core/neighbour.c:388
> >   neigh_flush_dev net/core/neighbour.c:432 [inline]
> >   __neigh_ifdown+0x1fb/0xc70 net/core/neighbour.c:465
> >   neigh_ifdown+0x1f/0x30 net/core/neighbour.c:487
> >   rt6_disable_ip+0x751/0x7e0 net/ipv6/route.c:5058
> >   addrconf_ifdown+0x155/0x1ad0 net/ipv6/addrconf.c:3892
> >   addrconf_notify+0x1bc/0x1050 net/ipv6/addrconf.c:-1
> >   notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
> >   call_netdevice_notifiers_mtu net/core/dev.c:2350 [inline]
> >   netif_set_mtu_ext+0x5ac/0x830 net/core/dev.c:9963
> >   do_setlink+0xa81/0x47a0 net/core/rtnetlink.c:3247
> >   rtnl_setlink+0x578/0x820 net/core/rtnetlink.c:3623
> >   rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7159
> >   netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
> >   netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
> >   netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
> >   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
> >   sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
> >   __sock_sendmsg net/socket.c:815 [inline]
> >   sock_write_iter+0x2de/0x3e0 net/socket.c:1266
> >   do_iter_readv_writev+0x612/0x8c0 fs/read_write.c:-1
> >   vfs_writev+0x343/0x990 fs/read_write.c:1058
> >   do_writev+0x154/0x2e0 fs/read_write.c:1104
> >   do_syscall_x64 arch/x86/emlxsw_sp_ul_rif_getntry/syscall_64.c:61 [inl=
ine]
> >   do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f9c2ff9e159
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f9c30f04028 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> > RAX: ffffffffffffffda RBX: 00007f9c30225fa0 RCX: 00007f9c2ff9e159
> > RDX: 0000000000000001 RSI: 00002000000003c0 RDI: 0000000000000004
> > RBP: 00007f9c3003506b R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f9c30226038 R14: 00007f9c30225fa0 R15: 00007ffed3c74808
> >   </TASK>
> >
> > Fixes: df5f4f372de5 ("ipv6: Replace &nd_tbl with nd_table(net).")
> > Reported-by: syzbot+5a8857f0b4a0a7b12c62@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6abd69a9.80e1c6cc.22483f.0005.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v2: Convert __teql_resolve()
> >
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Tariq Toukan <tariqt@nvidia.com>
> > Cc: Mark Bloch <mbloch@nvidia.com>
> > Cc: Petr Machata <petrm@nvidia.com>
> > Cc: Edward Cree <ecree.xilinx@gmail.com>
> > Cc: Nikolay Aleksandrov <razor@blackwall.org>
> > Cc: Alexander Aring <alex.aring@gmail.com>
> > Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >   .../mellanox/mlx5/core/en/tc_tun_encap.c      | 13 +++----
> >   .../ethernet/mellanox/mlxsw/spectrum_router.c | 29 ++++++++-------
> >   .../ethernet/mellanox/mlxsw/spectrum_span.c   | 24 ++++++++-----
> >   .../netronome/nfp/flower/tunnel_conf.c        |  4 +--
> >   drivers/net/ethernet/sfc/tc_counters.c        |  5 ++-
> >   drivers/net/vrf.c                             |  4 +--
> >   drivers/net/vxlan/vxlan_core.c                |  6 ++--
> >   include/net/ndisc.h                           |  7 ++--
> >   net/bridge/br_arp_nd_proxy.c                  |  2 +-
> >   net/ieee802154/6lowpan/tx.c                   |  3 +-
> >   net/ipv4/fib_semantics.c                      |  2 +-
> >   net/ipv6/ip6_output.c                         |  2 +-
> >   net/ipv6/ndisc.c                              | 36 ++++++++++++------=
-
> >   net/ipv6/route.c                              | 11 +++---
> >   net/sched/sch_teql.c                          | 12 ++++++-
> >   15 files changed, 90 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c =
b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> > index 67c12ca19d59..fe0258375ef6 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
> > @@ -439,21 +439,18 @@ void mlx5e_tc_update_neigh_used_value(struct mlx5=
e_neigh_hash_entry *nhe)
> >       if (neigh_used) {
> >               struct net_device *dev =3D READ_ONCE(nhe->neigh_dev);
> >               struct net *net =3D dev_net(dev);
> > -             struct neigh_table *tbl;
> >
> >               nhe->reported_lastuse =3D jiffies;
> >
> > +             /* find the relevant neigh according to the cached device=
 and
> > +              * dst ip pair
> > +              */
> >   #if IS_ENABLED(CONFIG_IPV6)
> >               if (m_neigh->family !=3D AF_INET)
> > -                     tbl =3D nd_table(net);
> > +                     n =3D ipv6_neigh_lookup(dev, &m_neigh->dst_ip);
> >               else
> >   #endif
> > -                     tbl =3D arp_table(net);
> > -
> > -             /* find the relevant neigh according to the cached device=
 and
> > -              * dst ip pair
> > -              */
> > -             n =3D neigh_lookup(tbl, &m_neigh->dst_ip, dev);
> > +                     n =3D neigh_lookup(arp_table(net), &m_neigh->dst_=
ip, dev);
> >               if (!n)
> >                       return;
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/dr=
ivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> > index ba8a7a44ce9e..1f4753213b9c 100644
> > --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> > +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> > @@ -2449,8 +2449,6 @@ static void mlxsw_sp_router_neigh_ent_ipv6_proces=
s(struct mlxsw_sp *mlxsw_sp,
> >                                                  char *rauhtd_pl,
> >                                                  int rec_index)
> >   {
> > -     struct net *net =3D mlxsw_sp_net(mlxsw_sp);
> > -     struct neigh_table *tbl;
> >       struct net_device *dev;
> >       struct neighbour *n;
> >       struct in6_addr dip;
> > @@ -2464,9 +2462,8 @@ static void mlxsw_sp_router_neigh_ent_ipv6_proces=
s(struct mlxsw_sp *mlxsw_sp,
> >               return;
> >       }
> >
> > -     tbl =3D nd_table(net);
> >       dev =3D mlxsw_sp_rif_dev(mlxsw_sp->router->rifs[rif]);
> > -     n =3D neigh_lookup(tbl, &dip, dev);
> > +     n =3D ipv6_neigh_lookup(dev, &dip);
>
>
> Hi Kuniyuki,
>
> I have checked Sashiko's feedback [0] and I think it is right.

I think this is false-positive.

This was pointed out in v1 too, but I did not add NULL check to avoid
defensive programming.

Hardware only reports neighbour activity via RAUHTD for entries programmed
into RAUHT by mlxsw_sp_neigh_entry_update().  Those entries are created onl=
y
in mlxsw_sp_neigh_entry_create(), which resolves the RIF via
mlxsw_sp_rif_find_by_dev(mlxsw_sp, n->dev) where n->dev is always non-NULL.
Thus, underlay and loopback RIFs (where mlxsw_sp_rif_dev() is NULL) never
have neighbour entries programmed in hardware.

Also, when a RIF is destroyed in mlxsw_sp_rif_destroy(), all of its
RAUHT entries are synchronously removed from hardware in
mlxsw_sp_neigh_rif_gone_sync() and router->rifs[rif] is cleared under
router->lock (the same lock held during the RAUHTD dump) before the RIF
index can be reused.


>
> mlxsw_sp_router_ul_rif_get() can be called with a NULL mlxsw_sp_crif
> pointer which then would call mlxsw_sp_ul_rif_create() and there during
> the alloc a rif with a NULL crif is created making this feedback being
> correct.
>
> I think a simple NULL check here for dev should be enough.
>
> [0]
> https://sashiko.dev/#/message/20261003212336.1304988-7-kuniyu%40google.co=
m

NIPA's Sashiko is pretty better than Gemini 3.1 these days.
I hope our instance support Gemini 4 soon :)
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003212336.1304988-=
1-kuniyu%40google.com


>
> Thanks!
>
> >       if (!n)
> >               return;
> >
> > @@ -4312,17 +4309,23 @@ mlxsw_sp_nexthop_neigh_lookup(struct mlxsw_sp_n=
exthop *nh)
> >       net =3D dev_net(dev);
> >
> >   #if IS_ENABLED(CONFIG_IPV6)
> > -     if (nh->family =3D=3D AF_INET6)
> > -             tbl =3D nd_table(net);
> > -     else
> > +     if (nh->family =3D=3D AF_INET6) {
> > +             n =3D ipv6_neigh_lookup(dev, &nh->gw_addr);
> > +             if (!n) {
> > +                     n =3D ipv6_neigh_create(dev, &nh->gw_addr);
> > +                     if (!IS_ERR(n))
> > +                             neigh_event_send(n, NULL);
> > +             }
> > +     } else
> >   #endif
> > +     {
> >               tbl =3D arp_table(net);
> > -
> > -     n =3D neigh_lookup(tbl, &nh->gw_addr, dev);
> > -     if (!n) {
> > -             n =3D neigh_create(tbl, &nh->gw_addr, dev);
> > -             if (!IS_ERR(n))
> > -                     neigh_event_send(n, NULL);
> > +             n =3D neigh_lookup(tbl, &nh->gw_addr, dev);
> > +             if (!n) {
> > +                     n =3D neigh_create(tbl, &nh->gw_addr, dev);
> > +                     if (!IS_ERR(n))
> > +                             neigh_event_send(n, NULL);
> > +             }
> >       }
> >
> >       return n;
> > diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/driv=
ers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> > index d34d2040177b..79947f68b10d 100644
> > --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> > +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
> > @@ -235,17 +235,23 @@ static int mlxsw_sp_span_dmac(int family,
> >       int err =3D 0;
> >
> >   #if IS_ENABLED(CONFIG_IPV6_GRE)
> > -     if (family =3D=3D AF_INET6)
> > -             tbl =3D nd_table(net);
> > -     else
> > +     if (family =3D=3D AF_INET6) {
> > +             neigh =3D ipv6_neigh_lookup(dev, pkey);
> > +             if (!neigh) {
> > +                     neigh =3D ipv6_neigh_create(dev, pkey);
> > +                     if (IS_ERR(neigh))
> > +                             return PTR_ERR(neigh);
> > +             }
> > +     } else
> >   #endif
> > +     {
> >               tbl =3D arp_table(net);
> > -
> > -     neigh =3D neigh_lookup(tbl, pkey, dev);
> > -     if (!neigh) {
> > -             neigh =3D neigh_create(tbl, pkey, dev);
> > -             if (IS_ERR(neigh))
> > -                     return PTR_ERR(neigh);
> > +             neigh =3D neigh_lookup(tbl, pkey, dev);
> > +             if (!neigh) {
> > +                     neigh =3D neigh_create(tbl, pkey, dev);
> > +                     if (IS_ERR(neigh))
> > +                             return PTR_ERR(neigh);
> > +             }
> >       }
> >
> >       neigh_event_send(neigh, NULL);
> > diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/=
drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> > index d650d33e3709..27d80ec8e895 100644
> > --- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> > +++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
> > @@ -253,7 +253,6 @@ void nfp_tunnel_keep_alive_v6(struct nfp_app *app, =
struct sk_buff *skb)
> >   #if IS_ENABLED(CONFIG_IPV6)
> >       struct nfp_tun_active_tuns_v6 *payload;
> >       struct net_device *netdev;
> > -     struct neigh_table *tbl;
> >       int count, i, pay_len;
> >       struct neighbour *n;
> >       void *ipv6_add;
> > @@ -280,8 +279,7 @@ void nfp_tunnel_keep_alive_v6(struct nfp_app *app, =
struct sk_buff *skb)
> >               if (!netdev)
> >                       continue;
> >
> > -             tbl =3D nd_table(dev_net(netdev));
> > -             n =3D neigh_lookup(tbl, ipv6_add, netdev);
> > +             n =3D ipv6_neigh_lookup(netdev, ipv6_add);
> >               if (!n)
> >                       continue;
> >
> > diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ether=
net/sfc/tc_counters.c
> > index 793a562fc1f7..ae6cc6b93864 100644
> > --- a/drivers/net/ethernet/sfc/tc_counters.c
> > +++ b/drivers/net/ethernet/sfc/tc_counters.c
> > @@ -116,9 +116,8 @@ static void efx_tc_counter_work(struct work_struct =
*work)
> >                                        encap->neigh->egdev);
> >               else
> >   #if IS_ENABLED(CONFIG_IPV6)
> > -                     n =3D neigh_lookup(nd_table(net),
> > -                                      &encap->neigh->dst_ip6,
> > -                                      encap->neigh->egdev);
> > +                     n =3D ipv6_neigh_lookup(encap->neigh->egdev,
> > +                                           &encap->neigh->dst_ip6);
> >   #else
> >                       n =3D NULL;
> >   #endif
> > diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> > index 320f3584a43b..79d433f49f80 100644
> > --- a/drivers/net/vrf.c
> > +++ b/drivers/net/vrf.c
> > @@ -614,9 +614,9 @@ static int vrf_finish_output6(struct net *net, stru=
ct sock *sk,
> >
> >       rcu_read_lock();
> >       nexthop =3D rt6_nexthop(dst_rt6_info(dst), &ipv6_hdr(skb)->daddr)=
;
> > -     neigh =3D __ipv6_neigh_lookup_noref(dst->dev, nexthop);
> > +     neigh =3D __ipv6_neigh_lookup_noref(dev, nexthop);
> >       if (unlikely(!neigh))
> > -             neigh =3D __neigh_create(nd_table(net), nexthop, dst->dev=
, false);
> > +             neigh =3D ipv6_neigh_create_noref(dev, nexthop);
> >       if (!IS_ERR(neigh)) {
> >               sock_confirm_neigh(skb, neigh);
> >               ret =3D neigh_output(neigh, skb, false);
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index 27b0b6567d52..513779c07621 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -2091,8 +2091,7 @@ static int neigh_reduce(struct net_device *dev, s=
truct sk_buff *skb,
> >           ipv6_addr_is_multicast(&msg->target))
> >               goto out;
> >
> > -     n =3D neigh_lookup(nd_table(dev_net(dev)), &msg->target, dev);
> > -
> > +     n =3D ipv6_neigh_lookup(dev, &msg->target);
> >       if (n) {
> >               struct vxlan_rdst *rdst =3D NULL;
> >               u8 ha[ETH_ALEN] __aligned(2);
> > @@ -2189,9 +2188,8 @@ static bool route_shortcircuit(struct net_device =
*dev, struct sk_buff *skb,
> >               if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
> >                       return false;
> >
> > -             tbl =3D nd_table(dev_net(dev));
> >               pip6 =3D ipv6_hdr(skb);
> > -             n =3D neigh_lookup(tbl, &pip6->daddr, dev);
> > +             n =3D ipv6_neigh_lookup(dev, &pip6->daddr);
> >               if (!n && (cfg->flags & VXLAN_F_L3MISS)) {
> >                       union vxlan_addr ipa =3D {
> >                               .sin6.sin6_addr =3D pip6->daddr,
> > diff --git a/include/net/ndisc.h b/include/net/ndisc.h
> > index 2fce6fccf55a..91898a2475e7 100644
> > --- a/include/net/ndisc.h
> > +++ b/include/net/ndisc.h
> > @@ -423,11 +423,8 @@ static inline struct neighbour *ip_neigh_gw6(struc=
t net_device *dev,
> >       struct neighbour *neigh;
> >
> >       neigh =3D __ipv6_neigh_lookup_noref(dev, addr);
> > -     if (unlikely(!neigh)) {
> > -             struct neigh_table *tbl =3D nd_table(dev_net(dev));
> > -
> > -             neigh =3D __neigh_create(tbl, addr, dev, false);
> > -     }
> > +     if (unlikely(!neigh))
> > +             neigh =3D ipv6_neigh_create_noref(dev, addr);
> >
> >       return neigh;
> >   #else
> > diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.=
c
> > index ba4a63840b21..c23b99517cd5 100644
> > --- a/net/bridge/br_arp_nd_proxy.c
> > +++ b/net/bridge/br_arp_nd_proxy.c
> > @@ -487,7 +487,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct =
net_bridge *br,
> >               return;
> >       }
> >
> > -     n =3D neigh_lookup(nd_table(dev_net(vlandev)), &msg->target, vlan=
dev);
> > +     n =3D ipv6_neigh_lookup(vlandev, &msg->target);
> >       if (n) {
> >               struct net_bridge_fdb_entry *f;
> >               u8 ha[ETH_ALEN] __aligned(2);
> > diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
> > index 4f511476b992..b261daedc290 100644
> > --- a/net/ieee802154/6lowpan/tx.c
> > +++ b/net/ieee802154/6lowpan/tx.c
> > @@ -58,9 +58,8 @@ int lowpan_header_create(struct sk_buff *skb, struct =
net_device *ldev,
> >               info->daddr.mode =3D IEEE802154_ADDR_SHORT;
> >       } else {
> >               __le16 short_addr =3D cpu_to_le16(IEEE802154_ADDR_SHORT_U=
NSPEC);
> > -             struct neigh_table *tbl =3D nd_table(dev_net(ldev));
> >
> > -             n =3D neigh_lookup(tbl, &hdr->daddr, ldev);
> > +             n =3D ipv6_neigh_lookup(ldev, &hdr->daddr);
> >               if (n) {
> >                       llneigh =3D lowpan_802154_neigh(neighbour_priv(n)=
);
> >                       read_lock_bh(&n->lock);
> > diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> > index e3bcc25229b0..a98c7670d2ce 100644
> > --- a/net/ipv4/fib_semantics.c
> > +++ b/net/ipv4/fib_semantics.c
> > @@ -617,7 +617,7 @@ static int fib_detect_death(struct fib_info *fi, in=
t order,
> >       if (likely(nhc->nhc_gw_family =3D=3D AF_INET))
> >               n =3D neigh_lookup(arp_table(net), &nhc->nhc_gw.ipv4, nhc=
->nhc_dev);
> >       else if (IS_ENABLED(CONFIG_IPV6) && nhc->nhc_gw_family =3D=3D AF_=
INET6)
> > -             n =3D neigh_lookup(nd_table(net), &nhc->nhc_gw.ipv6, nhc-=
>nhc_dev);
> > +             n =3D ipv6_neigh_lookup(nhc->nhc_dev, &nhc->nhc_gw.ipv6);
> >       else
> >               n =3D NULL;
> >
> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index 10146a57b69e..25fe0ba98b1a 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -127,7 +127,7 @@ static int ip6_finish_output2(struct net *net, stru=
ct sock *sk, struct sk_buff *
> >
> >       if (IS_ERR_OR_NULL(neigh)) {
> >               if (unlikely(!neigh))
> > -                     neigh =3D __neigh_create(nd_table(net), nexthop, =
dev, false);
> > +                     neigh =3D ipv6_neigh_create_noref(dev, nexthop);
> >               if (IS_ERR(neigh)) {
> >                       IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES)=
;
> >                       kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREAT=
EFAIL);
> > diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> > index e1cbffaa0ad0..0ed1a619372b 100644
> > --- a/net/ipv6/ndisc.c
> > +++ b/net/ipv6/ndisc.c
> > @@ -947,8 +947,12 @@ static enum skb_drop_reason ndisc_recv_ns(struct s=
k_buff *skb)
> >        *      update / create cache entry
> >        *      for the source address
> >        */
> > -     neigh =3D __neigh_lookup(tbl, saddr, dev,
> > -                            !inc || lladdr || !dev->addr_len);
> > +     neigh =3D ipv6_neigh_lookup(dev, saddr);
> > +     if (!neigh && (!inc || lladdr || !dev->addr_len)) {
> > +             neigh =3D ipv6_neigh_create(dev, saddr);
> > +             if (IS_ERR(neigh))
> > +                     neigh =3D NULL;
> > +     }
> >       if (neigh)
> >               ndisc_update(dev, neigh, lladdr, NUD_STALE,
> >                            NEIGH_UPDATE_F_WEAK_OVERRIDE|
> > @@ -998,7 +1002,6 @@ static enum skb_drop_reason ndisc_recv_na(struct s=
k_buff *skb)
> >       struct net *net =3D dev_net(dev);
> >       struct ndisc_options ndopts;
> >       struct inet6_ifaddr *ifp;
> > -     struct neigh_table *tbl;
> >       struct neighbour *neigh;
> >       struct inet6_dev *idev;
> >       u8 *lladdr =3D NULL;
> > @@ -1063,8 +1066,7 @@ static enum skb_drop_reason ndisc_recv_na(struct =
sk_buff *skb)
> >               return reason;
> >       }
> >
> > -     tbl =3D nd_table(net);
> > -     neigh =3D neigh_lookup(tbl, &msg->target, dev);
> > +     neigh =3D ipv6_neigh_lookup(dev, &msg->target);
> >
> >       /* RFC 9131 updates original Neighbour Discovery RFC 4861.
> >        * NAs with Target LL Address option can now create a STALE neigh=
bor
> > @@ -1093,7 +1095,7 @@ static enum skb_drop_reason ndisc_recv_na(struct =
sk_buff *skb)
> >                       return reason;
> >               }
> >               if (!neigh)
> > -                     neigh =3D neigh_create(tbl, &msg->target, dev);
> > +                     neigh =3D ipv6_neigh_create(dev, &msg->target);
> >               new_state =3D NUD_STALE;
> >       }
> >
> > @@ -1108,7 +1110,7 @@ static enum skb_drop_reason ndisc_recv_na(struct =
sk_buff *skb)
> >               if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_le=
n) &&
> >                   READ_ONCE(net->ipv6.devconf_all->forwarding) &&
> >                   READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> > -                 pneigh_lookup(tbl, &msg->target, dev)) {
> > +                 pneigh_lookup(nd_table(dev_net(dev)), &msg->target, d=
ev)) {
> >                       /* XXX: idev->cnf.proxy_ndp */
> >                       goto out;
> >               }
> > @@ -1141,7 +1143,6 @@ static enum skb_drop_reason ndisc_recv_rs(struct =
sk_buff *skb)
> >       unsigned long ndoptlen =3D skb->len - sizeof(*rs_msg);
> >       struct net_device *dev =3D skb->dev;
> >       struct ndisc_options ndopts;
> > -     struct neigh_table *tbl;
> >       struct neighbour *neigh;
> >       struct inet6_dev *idev;
> >       u8 *lladdr =3D NULL;
> > @@ -1177,8 +1178,12 @@ static enum skb_drop_reason ndisc_recv_rs(struct=
 sk_buff *skb)
> >                       goto out;
> >       }
> >
> > -     tbl =3D nd_table(dev_net(dev));
> > -     neigh =3D __neigh_lookup(tbl, saddr, dev, 1);
> > +     neigh =3D ipv6_neigh_lookup(dev, saddr);
> > +     if (!neigh) {
> > +             neigh =3D ipv6_neigh_create(dev, saddr);
> > +             if (IS_ERR(neigh))
> > +                     goto out;
> > +     }
> >       if (neigh) {
> >               ndisc_update(dev, neigh, lladdr, NUD_STALE,
> >                            NEIGH_UPDATE_F_WEAK_OVERRIDE|
> > @@ -1478,9 +1483,14 @@ static enum skb_drop_reason ndisc_router_discove=
ry(struct sk_buff *skb)
> >        *      Process options.
> >        */
> >
> > -     if (!neigh)
> > -             neigh =3D __neigh_lookup(nd_table(net), &ipv6_hdr(skb)->s=
addr,
> > -                                    skb->dev, 1);
> > +     if (!neigh) {
> > +             neigh =3D ipv6_neigh_lookup(skb->dev, &ipv6_hdr(skb)->sad=
dr);
> > +             if (!neigh) {
> > +                     neigh =3D ipv6_neigh_create(skb->dev, &ipv6_hdr(s=
kb)->saddr);
> > +                     if (IS_ERR(neigh))
> > +                             neigh =3D NULL;
> > +             }
> > +     }
> >       if (neigh) {
> >               u8 *lladdr =3D NULL;
> >               if (ndopts.nd_opts_src_lladdr) {
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 8baac4d85251..ea9f0a4c34f9 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -218,7 +218,7 @@ struct neighbour *__ip6_dst_neigh_lookup(const stru=
ct in6_addr *gw,
> >       if (n)
> >               return n;
> >
> > -     n =3D neigh_create(nd_table(dev_net(dev)), daddr, dev);
> > +     n =3D ipv6_neigh_create(dev, daddr);
> >       return IS_ERR(n) ? NULL : n;
> >   }
> >
> > @@ -4277,9 +4277,12 @@ static void rt6_do_redirect(struct dst_entry *ds=
t, struct sock *sk, struct sk_bu
> >        */
> >       dst_confirm_neigh(&rt->dst, &ipv6_hdr(skb)->saddr);
> >
> > -     neigh =3D __neigh_lookup(nd_table(dev_net(dev)), &msg->target, de=
v, 1);
> > -     if (!neigh)
> > -             return;
> > +     neigh =3D ipv6_neigh_lookup(dev, &msg->target);
> > +     if (!neigh) {
> > +             neigh =3D ipv6_neigh_create(dev, &msg->target);
> > +             if (IS_ERR(neigh))
> > +                     return;
> > +     }
> >
> >       /*
> >        *      We have finally decided to accept it.
> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index 409ce50cc0db..19ccf1a55988 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/skbuff.h>
> >   #include <linux/moduleparam.h>
> >   #include <net/dst.h>
> > +#include <net/ndisc.h>
> >   #include <net/neighbour.h>
> >   #include <net/pkt_sched.h>
> >
> > @@ -257,7 +258,16 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff=
 *skb_res,
> >       if (dst->dev !=3D dev) {
> >               struct neighbour *mn;
> >
> > -             mn =3D __neigh_lookup_errno(n->tbl, n->primary_key, dev);
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +             if (n->tbl->family =3D=3D AF_INET6) {
> > +                     mn =3D ipv6_neigh_lookup(dev, n->primary_key);
> > +                     if (!mn)
> > +                             mn =3D ipv6_neigh_create(dev, n->primary_=
key);
> > +             } else
> > +#endif
> > +             {
> > +                     mn =3D __neigh_lookup_errno(n->tbl, n->primary_ke=
y, dev);
> > +             }
> >               neigh_release(n);
> >               if (IS_ERR(mn))
> >                       return PTR_ERR(mn);
>
