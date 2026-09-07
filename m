Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391F37BE72
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795793; cv=pass; b=Vlb3iuYC2VZggjRvSiiAtP9iYuxfyBwceJhPDP7pW+F07S8JDduIzadKiOAbVto0V38dA2z2bulVKLL0v1h5NfLyTuGB1T75KcYPQXB6DN0UahqUto+KTrDaigCRZDtOn5q+lIGXYs5EBXZrB7UVi/8/aO1V523UycWFgwr8UkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795793; c=relaxed/simple;
	bh=exBs6t9+toYmI6bzp6z3m93jnMFbojaZaysDeemdveY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEUuf4/KkGUDk6URfiGCZ/hp9z3fw50xfPpPUb85hL5ntOcyx+vlv15iR4mNS3iWipeybG6sTl1wHSs2hwOH5tKzYD1PgnPoXfhou6g6PagQVvO1JCh3aFcmscJiyC0A683NiEmLeKfB2lWPUQrdT9O8VpnfG29Snp4vaT7uJgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GwOuzuBc; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwOuzuBc"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52ff0eea420so38313371cf.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788795790; cv=none;
        d=google.com; s=arc-20260327;
        b=jaSAmxElG8wVMck10Oug/lluoQA/q4IkW7eb6ZVOzezAKXmo1xS/r5MYYUpzRcYy4U
         PSzv1BCoLWb2/hrcGPV4anOBrDTHhJGBLk3lj0o/QOZI2pgMNcGVfxOMcaPEp2AU9jOh
         toT7fLLglBI+q3JnmqNqNJidI9Ohf+M+y/CuqZpg6xOJk+m36ZHnlOHH3N+pSfhoGfYB
         Nateq3UyLff+8Oi3cPNkK4yBjI3SSMZDobwMsp1qNLJH/IvrmE5g/YxeIQLF93v7uEtm
         WEUds21k/vCrJE2gVn1V1JS8T1j3DAUbA1FvS2TiJAGh+6deMhQnQS5jivCAMQ976W55
         +fyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etDBJocPIU+yevjp2qTpGUfQi6He1jc942AOBp1rjsk=;
        fh=i9Aksfdr+haJPhn49TeZtPkNvikqd3uuhj0/lk9TUAk=;
        b=CTyUr0UBFU0xbIlZ9MgZIEhLEVFhrBIRhWh1/Yra4wg5faeiDIF2IUcDqvA617CMbB
         aVWVsd0ovF0SPTyeBfYz8m9T3k1GIvSmrwqm1FF8s5cX2h+JJ2ty0PTaklB2Bo51jbPZ
         MFK+eAH4Kk4fmx6of9zrrKyW+VL0kBm1pp2lHGguiFATCIDXGwK/Ga6vGP25JzSRzATT
         mB5HIZfejy/H846WnP7vkOV8mDdofjzDyZ1qzu+d4HWmqLFodLRRSoQ87if4BG8KCK1J
         NZzWXinLcyGZTbQ+8WFA366VMq3PMo41ZNnnhZLCMBPk96+wMAkxVfJYRQNoCevMTnq6
         PpnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788795790; x=1789400590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=etDBJocPIU+yevjp2qTpGUfQi6He1jc942AOBp1rjsk=;
        b=GwOuzuBcf2+RUX7WYCs9Fm+uVtkQFHXrVBV+AkYWMDQV49zMSyXQqM32zMOdEclG2i
         sP6PCCM/27LOAYx9FR4mN+yIXiJg1SH0m4aPGFMvO8tj4ub3uzJMCMY0CCIb8bF+wEb0
         HuqZ20wlNcrNoXaMDtUnc8NKTv8IhvdLN/FRSswPlIq8+g0e9OMx80a9tdKxTttIQrlp
         XxxTPbDEMMN0EpkFRp8gZPZavdr/vAQc2k8SnM1kABpcBMlovZlzFnbCzw9WCDFt1Hx+
         drU5i0kU4UvqDZ3ar1a1In70AP4qfkQuxRKrt2lsMB4YaFZCqfnk/MISiwoLBZT2c6w+
         o/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795790; x=1789400590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etDBJocPIU+yevjp2qTpGUfQi6He1jc942AOBp1rjsk=;
        b=p6UfQLspYq4JSWEV2rvDrWUgfoBN36YDKJ2eAMtJjhofhkSt4Xu4gCo142LXZEImE1
         sS9K3X1za9gfcTkIHDpWRisZ8xIuFdDz0V7PpN8PX3WnzD7f9gxg0boJzEsNaJHN0x5D
         SSH8ShoJaoCJlufmznIcRWFnoSeDUqsRtc9B/qwUHuT9Qnc9Ftr9XtXylmqccDCSWx2D
         m5sP7461om3iYSv8sKlz64PEvpb5fqqT2DiyB27HQltHkgKqmhGKIH7xKLiEGX5sUGd9
         2TaI03Al96JcJ4y2CDBSFBh8mxQFK+XDd8faO3jkUtQ0xEcPdinJx0rfoQ2ZX5N9jFy0
         anuw==
X-Forwarded-Encrypted: i=1; AKwUvBysxKFm20UXVO3u6aaO6hhHt65kAEJq8dmPSZw11swhw4BK244qmJ3P/SQKzndQTRXnzP5zBC0=@vger.kernel.org
X-Gm-Message-State: AFuF++ksPRZP3NtSEp6/HnSVeI9TbgzZz5Lq/T3VMwUe+AjSUIrgyT5u
	VcM2ML08+xtuWHTyHeo0Nz3QZL116CWt/5Id27x3kiAfC9UXPDxQ5gatR9mmS+cZAPynzF3CBrh
	ccTqh3d15Y3XNF0+nJyg4/6cNHgxHV6st0T62j6f8
X-Gm-Gg: AYBFou1lsI3OIJfEtIwMOgSPwy7u0Oem+5iqf9wwAEtnjaEMPgzlQsTDTs5TN1rbQ6W
	TtQ8+yzPknl00hVTPAe5X+r9+PtHjokoQVga+IGJnBJGRzUi9T5gYAbXYo7uQ1fj4eqEzMEmG8+
	+wqyyTyWr2rL/qG5z9kVCWf7CjczBYTT7EGtTJDfOzEWYIvLJMNUxzI+VAq99aWq+HnvvDNSJwZ
	pNuPm92bzrnhaZHqN2GKmXmGXxEkmNxqnDfL9k4HhwqQCKv65ymuOSNyuVodsTb9xQvWCDHIsLI
	2xuf1MRMOmBJHi5wNjTotrRYuDlmvmQQ0OFKsOTTdSHeS/g4fLBwwxNuJ0ZrrC18BYkfZGTiVng
	n0xxZtQUpDpG97raSMzaSf4xll5H5I5EhKahPDEJgrLehelBCWp4rsBfmOw==
X-Received: by 2002:a05:622a:507:b0:530:90c8:d04 with SMTP id
 d75a77b69052e-53090c81816mr19803091cf.45.1788795789440; Mon, 07 Sep 2026
 08:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904180645.706425-1-namangulati@google.com> <7612748f-3a0d-4930-9067-f5bc49e1b361@suse.de>
In-Reply-To: <7612748f-3a0d-4930-9067-f5bc49e1b361@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 17:42:57 +0200
X-Gm-Features: AcwNN1VRSt8ifcjlWeGVpIr4DxL2mQh-2PlcJA5T5BYkFSxCAbSu239DoQC3IKk
Message-ID: <CANn89iKB2Hcc+krqPOZ6ROF9VBXiqP-j2pnqv0uZ7suppU8RUQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: null-check fib6_node before accessing in __ip6_del_rt_siblings()
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Naman Gulati <namangulati@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 1:38=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> On 9/4/26 8:06 PM, Naman Gulati wrote:
> > syzbot reported a null-ptr-deref in __ip6_del_rt_siblings() [0].
> >
> > The stack trace hinted towards a null dereference of rt->fib6_node when
> > fn->leaf is accessed in __ip6_del_rt_siblings(). With
> > RTNL_FLAG_DOIT_UNLOCKED set, inet6_rtm_delroute() operations run
> > concurrently without acquiring the RTNL lock. In ip6_route_del(), the
> > route lookup happens under rcu_read_lock() without acquiring
> > table->tb6_lock.
> >
> > Between ip6_route_del() looking up the route and __ip6_del_rt_siblings(=
)
> > acquiring table->tb6_lock, another thread can modify the routing table.
> > For example, when an ECMP route is replaced via RTM_NEWROUTE with
> > NLM_F_REPLACE, fib6_add_rt2node() unlinks all old siblings and sets
> > iter->fib6_node =3D NULL. A reproducer was found that triggers this [1]=
.
> >
> > Add a check to ensure rt->fib6_node is non-null before accessing it.
> >
> > [0]
> > KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> > RIP: 0010:__ip6_del_rt_siblings+0x31e/0x7c0 net/ipv6/route.c:4056
> > Call Trace:
> >   <TASK>
> >   ip6_route_del+0x1054/0x1110 net/ipv6/route.c:4232
> >   inet6_rtm_delroute+0x5d7/0x6d0 net/ipv6/route.c:5669
> >   rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7132
> >   netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
> >   netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
> >   netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
> >   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
> >   sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
> >   __sock_sendmsg net/socket.c:815 [inline]
> >   ____sys_sendmsg+0x565/0x870 net/socket.c:2713
> >   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2767
> >   __sys_sendmsg net/socket.c:2799 [inline]
> >   __do_sys_sendmsg net/socket.c:2804 [inline]
> >   __se_sys_sendmsg net/socket.c:2802 [inline]
> >   __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2802
> >   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
> >   do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >   </TASK>
> >
> > [1] https://gist.github.com/NamanGulati/0766a1159b6ca61928faaf87425ff89=
9
> >
> > Fixes: bd11ff421d36 ("ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELRO=
UTE.")
> > Reported-by: syzbot+a73e5ee0fd534fed75bd@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6a9b03f9.04649fcc.10325f.0003.GA=
E@google.com
> > Signed-off-by: Naman Gulati <namangulati@google.com>
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Naman!
