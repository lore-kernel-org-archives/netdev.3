Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696C4848BF
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792240389; cv=none; b=AHASO1OCH3G6F6NWdAvoJVBDJpY57A1YNPUTsReI49/thSmWfCQDis9SQW1GelGIlBsATOoBrZMQRoAaEqhzKfyKoSaRNx+9BibpZayW71WA1hcbclV14j1recJkHpkFcKyvL4hoRysJmtIzOcUa93fjBVQRHze08297VhMCf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792240389; c=relaxed/simple;
	bh=GEeHk6S7mQb/+I4+xIWGQDGmZPW7/nBIQMpjecIG1nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDJpvJVfsYjGn5OmuhRVpY0ZYqdRfnpYsV7H1oOZKmPc1jzX+shLQyiB8OTJ3nlL4yu8wdphe7EHauwxyZdcxkG4voEXXRXFrnXkKZD6Z9P0Xpk+1BBKIZlh/6vK+sObdZJ5SGogrYrcxioEFUCZpPer9zMqfVLRogcmPv8d56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtUwy/bJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtUwy/bJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4035D1F000C4
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 12:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792240388;
	bh=AD9Fx2GvsncC5aqA7hFno7iSTFG1b3DaScJqKcrt40o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CtUwy/bJ22zU73S38fnZ0qZ6FKqpY2u/WPDX0mrwuizmXdGL/BApJFqvJGSQrpKIF
	 3PjKIzwSt9L7jpfQnHv7CuzPCiooE5s99VYOBztqDeKsE/Az0Kq5OUpV6gEaUWQr4I
	 sM5HxmnWUhPisAa+6gfa5u5AepCpvXax9bPJh0ZXJZeKd0/VJn36qtkNMfg86J4v2l
	 qB2k0Md8IYVmybLR3bIfNMU0i+UxTcH2jRYtRYnefjLK4BWtsHzgiF1sTzsdhdTdOS
	 WmIvKpIRcK56T+LqabwdBrcExyHYBfJqwS501SISbGfrkLcb8Uuw4nIzEZqbea6ov+
	 UziW2b+adhftQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-486f013db83so240377fac.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:33:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwLk0nNpFt147wi0UJHe/85luqZns0cEoraZgk/26y1H84162AKTyI0qvgkE/bm/uH/tNKDpds=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSV4/13a1Yi1EQBrOMt60vZygHghwvxeHRVEoqY9k1nE1wWhje
	bFKO4+dxGgw46ThwnBOnb/ScKYzF5QmNDePH62xHlx84zwT1WdfA4up4b8nld/LhPxihsZyC8HD
	5+tjZCVALnr1NzcTfLmRcdsnwF5rmdHc=
X-Received: by 2002:a05:6871:3407:b0:494:7af4:954b with SMTP id
 586e51a60fabf-4a757974186mr2003567fac.19.1792240387553; Sat, 17 Oct 2026
 05:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
 <20261016-bug-net-netns-move-rcu-barrier-v1-2-4157d798658f@gmail.com>
In-Reply-To: <20261016-bug-net-netns-move-rcu-barrier-v1-2-4157d798658f@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 17 Oct 2026 14:32:56 +0200
X-Gmail-Original-Message-ID: <CAL4WiioL+wiv3jgqeT1qiZ2mGWQ+HV+mEQP2K0aFMCpjDvwYDg@mail.gmail.com>
X-Gm-Features: AclHuK_Do3zKvqxvHgFKWUwKg_2z7PqPbuLYUX8rdBoTNRq6JgnmoDu_jAQFd-Y
Message-ID: <CAL4WiioL+wiv3jgqeT1qiZ2mGWQ+HV+mEQP2K0aFMCpjDvwYDg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] ipv6: take fib6_sernum from a sequence
 shared by all netns
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2026 =C3=A0 08:10, Qiliang Yuan <odys.yuan@gmail.com> a =C3=
=A9crit :
>
> A per-cpu IPv6 route of a nexthop object records fib6_sernum of the
> netns it was created in, and rt6_is_valid() compares it with fib6_sernum
> of the netns its device belongs to when the route is checked. Every netns
> starts its fib6_sernum at 1 and increments it on each tree change, so
> different netns often hold the same value.
>
> When a device moves to another netns, such a route remains usable until
> nexthop_free_rcu() releases it, and fib6_info_destroy_rcu() queues that
> callback from inside an RCU callback, after the device has moved. If the
> fib6_sernum of the new netns matches the cached one in that window,
> ip6_dst_check() accepts the route and a socket in the old netns keeps
> sending through a device that now belongs to another netns.
>
> Take every fib6_sernum, including the initial one, from one global
> sequence, so that a cached route never matches the fib6_sernum of
> another netns.
>
> A connected UDP socket in netns A caches a route through an IPv6 nexthop
> object on a veth. The veth is moved to netns B and brought up with one
> RTM_NEWLINK, then the socket sends 200000 datagrams. A route is added
> to and removed from B 0 to 20 times before the move, 63 trials:
>
>                                 before     after
>   trials sending after move          3         0
>   datagrams sent after move       8187         0
>
> Fixes: 8f34e53b60b3 ("ipv6: Use global sernum for dst validation with nex=
thop objects")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  net/ipv6/af_inet6.c |  1 -
>  net/ipv6/ip6_fib.c  | 14 ++++++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index a9b8b4b42a1af..db4cccfdc565c 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -945,7 +945,6 @@ static int __net_init inet6_net_init(struct net *net)
>         net->ipv6.sysctl.max_dst_opts_len =3D IP6_DEFAULT_MAX_DST_OPTS_LE=
N;
>         net->ipv6.sysctl.max_hbh_opts_len =3D IP6_DEFAULT_MAX_HBH_OPTS_LE=
N;
>         net->ipv6.sysctl.fib_notify_on_flag_change =3D 0;
> -       atomic_set(&net->ipv6.fib6_sernum, 1);
>
>         net->ipv6.sysctl.ioam6_id =3D IOAM6_DEFAULT_ID;
>         net->ipv6.sysctl.ioam6_id_wide =3D IOAM6_DEFAULT_ID_WIDE;
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 0dc6ebee6e568..c66466be64451 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -89,13 +89,21 @@ static void fib6_walker_unlink(struct net *net, struc=
t fib6_walker *w)
>         write_unlock_bh(&net->ipv6.fib6_walker_lock);
>  }
>
> +/*
> + * Draw every fib6_sernum from one sequence shared by all netns, so that=
 a
> + * route cached against one netns never matches the sernum of another on=
e,
> + * e.g. after its device moved.
> + */
> +static atomic_t fib6_sernum_seq;
> +
>  static int fib6_new_sernum(struct net *net)
>  {
> -       int new, old =3D atomic_read(&net->ipv6.fib6_sernum);
> +       int new, old =3D atomic_read(&fib6_sernum_seq);
>
>         do {
>                 new =3D old < INT_MAX ? old + 1 : 1;
> -       } while (!atomic_try_cmpxchg(&net->ipv6.fib6_sernum, &old, new));
> +       } while (!atomic_try_cmpxchg(&fib6_sernum_seq, &old, new));
> +       atomic_set(&net->ipv6.fib6_sernum, new);
>

The atomic_set() of net->ipv6.fib6_sernum after the cmpxchg()
 is not ordered with other writers. fib6_new_sernum() callers only
 hold the per-table tb6_lock, so two tables of the same netns can
 race and leave the netns with the older of two values. Since values
 are never reused, I think this only causes extra invalidations, but
 the changelog should say so: fib6_sernum is no longer monotonic per
 netns.

>         return new;
>  }
> @@ -2466,6 +2474,8 @@ static int __net_init fib6_net_init(struct net *net=
)
>         size_t size =3D sizeof(struct hlist_head) * FIB6_TABLE_HASHSZ;
>         int err;
>
> +       fib6_new_sernum(net);

There is no need to draw a value from the shared sequence at netns
creation. Netns creation is exactly what you are trying to make
cheaper, and the shared cacheline does not need to be written there.

You can instead keep per-netns initial values that the shared
sequence never hands out:

keep atomic_set(&net->ipv6.fib6_sernum, 1) in
inet6_net_init() (0 is not usable, rt->sernum =3D=3D 0 and
FIB6_NO_SERNUM_CHANGE have their own meaning), and make the
sequence never return 1 (restart at 2)

A netns that never bumped can then not match a value from the
sequence. Also, the moved device is down after the move, and
NETDEV_UP in the new netns bumps it (rt_cache_flush() for IPv4,
the route inserted by addrconf_add_dev() for IPv6) before the
device can transmit.
