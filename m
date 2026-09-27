Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC83D093E
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549522; cv=none; b=lTA5PYjPXXtrp0R2/X/gFmfK/eo7ZClqgjdwjN0OlXZM+7D02rzm21OOC81SYbfveB3V5mtR+YMPdimHKebFxO7ZIbLVpzHH4Ihnwf4MDJaExpfsK29rY+QKNL5rWMkhcxV7NEoYIFUZcb2ZHIfgkJx7c9ku/3JZt+7b5D3eTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549522; c=relaxed/simple;
	bh=XwjtKmgJOg/V3I5YeAvi8W9i4uXRgR8GAg5dPgQw12c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCyS8fJxdUI/bjWsTthGmqXmjkaYV0xpf/ISaoepONA2u7AtcvwCHb8IuRS2vQNflshIIDWcVVgj8rxp2H4nje9sF4CyjzLSYrrbqu60CIwIjFhtFbuooBpf3LLnEEjaQx0Nm+wn+mw0LzsQWsE1z0zyvJuUIL8LspEYFtS2bpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esCMkkU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esCMkkU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD421F00893
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790549519;
	bh=9/R/RO2dAEt41rtxNR8WksF0Z55xw5mINwgFB9hyFXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=esCMkkU8MDRCdyHFKgoAqFQJISPuXPSGjgpCDsrTe8uEc5g2J4feVPPr5txTeGu9d
	 +gIjpZ4TkR6e07Pb4lHq8TXGSFS/a4K7T2HdKGj/VK+fhAyCcXdlUU0QCQq6CS/dGQ
	 cb3hvXHCWwddzlDaUMNfv375y+Whrp9p3fuJqZ++s8VE6z2gD6MkrvxoomT73uQCm/
	 aKFu8J6nCb4mSx0y4tDEapNHoE2AMoZ/RuXjt5fCwRFMSOYdmnRWPTW84Njl1rYtKM
	 kqftqW33VQ7S2MqRZJ0GwhO60bSJ1O2F9rCz+Z1AKAOzlaKfi9CSCRJLbM2stJkN9o
	 bJ2YRGBT8kTxg==
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6d7530420abso736585eaf.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 15:51:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzxbfcK/RRiCpymK6j5cPTtIWCIsnMjE2UWuR/FejptCEuLDCsuPdCApIofgz3GjRKeJoVpm1I=@vger.kernel.org
X-Gm-Message-State: AFuF++lNyEtg5ewMa7a4c23DDmicXZl3KVIb0vHssGFI8HgyLiExzOdc
	aRIGhGyFMd37tJDFj0WOl/edWf1XZ5hN4+I9ozCdV5dC3KdRA1NxnpsHblARGMRbsgrdx6+ZftW
	QdT9qaWdGayqncQThCWrOVWiO4VHSMiw=
X-Received: by 2002:a05:6820:627:b0:6d8:edd2:2aef with SMTP id
 006d021491bc7-6d8edd22febmr1970319eaf.5.1790549518691; Sun, 27 Sep 2026
 15:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927202429.2452589-1-kuniyu@google.com> <20260927202429.2452589-5-kuniyu@google.com>
In-Reply-To: <20260927202429.2452589-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 28 Sep 2026 00:51:46 +0200
X-Gmail-Original-Message-ID: <CAL4WiipHSvpgRwzP3C-E2xWSv1dqzB5eCOVZGiTVyxy6JohhPQ@mail.gmail.com>
X-Gm-Features: AclHuK8O9LlVut0t5yPtTg0MtUnm0YdjlnJoLCL3DkFii_6Lza2CAdSGbYu2W3w
Message-ID: <CAL4WiipHSvpgRwzP3C-E2xWSv1dqzB5eCOVZGiTVyxy6JohhPQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/5] ipv4: Batch rt_flush_dev() for dying netns.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 10:24=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> IPv4 uncached routes are linked to the global per-cpu lists,
> rt_uncached_list.
>
> When unregistering a netdev, rt_flush_dev() iterates over the
> potentially long lists to find uncached routes tied to the device
> and swap it with blackhole_netdev.
>
> Since it is called for every device in dying netns under RTNL,
> it adds O(N_dev x (N_cpu + N_route)) costs to netns dismantle.
>
> Let's call it (almost) once per cleanup_net().
>
> When rt_flush_dev() is called with NULL from ->pre_exit_batch(),
> it purges every entry in dying netns, reducing the cost to
> O(N_cpu + N_route).
>
> Since ->pre_exit_batch() is called before synchronize_rcu(),
> we must prevent adding a new route for dying netns, so now
> rt_add_uncached_list() checks !check_net() and swaps the device
> with blackhole_netdev.
>
> When rt_flush_dev() is later called again from fib_netdev_event()
> via NETDEV_UNREGISTER, it just returns.
>
> Note that net_pre_exit_done() cannot be replaced with !check_net()
> because:
>
>   1. some ->pre_exit() call unregister_netdevice() before
>      fib_net_ops (e.g. ovs_pre_exit_net(), l2tp_pre_exit_net()).
>
>   2. ->dellink() could call unregister_netdevice() for another
>      netdev in a dying netns queued for the next cleanup_net()
>      batch, for which ->pre_exit_batch() has not been called
>      yet (e.g. veth).
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/fib_frontend.c |  6 ++++++
>  net/ipv4/route.c        | 28 +++++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> index 8a3dc04e8cac..b8d76b6279e1 100644
> --- a/net/ipv4/fib_frontend.c
> +++ b/net/ipv4/fib_frontend.c
> @@ -1685,6 +1685,11 @@ static void __net_exit fib_net_pre_exit(struct net=
 *net)
>         nl_fib_lookup_exit(net);
>  }
>
> +static void __net_exit fib_net_pre_exit_batch(struct list_head *net_exit=
_list)
> +{
> +       rt_flush_dev(NULL);
> +}
> +
>  static void __net_exit fib_net_exit_rtnl(struct net *net,
>                                          struct list_head *dev_kill_list)
>  {
> @@ -1704,6 +1709,7 @@ static void __net_exit fib_net_exit(struct net *net=
)
>  static struct pernet_operations fib_net_ops =3D {
>         .init =3D fib_net_init,
>         .pre_exit =3D fib_net_pre_exit,
> +       .pre_exit_batch =3D fib_net_pre_exit_batch,
>         .exit_rtnl =3D fib_net_exit_rtnl,
>         .exit =3D fib_net_exit,
>  };
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index d7da2f1acbb5..cbe328b3f254 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1554,14 +1554,29 @@ struct uncached_list {
>
>  static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt_uncached_list);
>
> +static void rt_replace_uncached_list(struct rtable *rt)
> +{
> +       struct net_device *dev =3D dst_dev(&rt->dst);
> +
> +       rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
> +       netdev_ref_replace(dev, blackhole_netdev,
> +                          &rt->dst.dev_tracker, GFP_ATOMIC);
> +}
> +
>  void rt_add_uncached_list(struct rtable *rt)
>  {
>         struct uncached_list *ul =3D raw_cpu_ptr(&rt_uncached_list);
>
> +       /* Set once and never cleared: non-NULL marks an uncached route. =
*/
>         rt->dst.rt_uncached_list =3D ul;
>
>         spin_lock_bh(&ul->lock);
> -       list_add_tail(&rt->dst.rt_uncached, &ul->head);
> +
> +       if (check_net(dst_dev_net_rcu(&rt->dst)))
> +               list_add_tail(&rt->dst.rt_uncached, &ul->head);
> +       else
> +               rt_replace_uncached_list(rt);
> +
>         spin_unlock_bh(&ul->lock);
>  }

Hi Kuniyuki,

Doing this in ->pre_exit_batch() and rt_add_uncached_list() /
rt6_uncached_list_add() is too early.

1) check_net(net) becomes false as soon as the last put_net() drops
   __ns_ref to 0, while devices in the netns are still UP and sockets /
   packets are still active (until default_device_exit_batch()).
   Swapping rt->dst.dev_rcu to blackhole_netdev on live routes (while
   rt->dst.input and rt->dst.output are not dst_discard) changes
   skb_dst_dev_net_rcu(skb) / dst_dev_net_rcu(&rt->dst) to &init_net.
   RX paths (__inet_lookup_skb, __inet6_lookup_skb, tcp_v4_rcv,
   icmp_rcv, ip_error, ...) will then look up sockets in init_net or
   send RST/ICMP from init_net, and TX paths (ip_route_output_flow,
   icmp6_dst_alloc, ip6_output) will see blackhole_netdev / init_net.

2) In patch 3/5, ops_undo_list() is also called from setup_net()
   (out_undo) when an ->init() callback fails. At that point
   check_net(net) is still true (__ns_ref =3D=3D 1), so ->pre_exit_batch()
   will skip net (or not be called at all if setup_net() failed before
   fib_net_ops), yet ops_undo_list() sets NET_PRE_EXIT_DONE because
   ops_list =3D=3D &pernet_list, causing default_device_exit_batch() to
   skip rt_flush_dev(dev).

3) In rt_flush_dev() / rt6_uncached_list_flush_dev(), the lockless
   if (list_empty(&ul->head)) check can race with a concurrent
   rt_add_uncached_list() that observed check_net(net) =3D=3D true just
   before the last put_net() but has not yet executed list_add_tail().
   Since NET_PRE_EXIT_DONE disables all subsequent rt_flush_dev(dev)
   calls (including the retry in netdev_wait_allrefs_any()), that dev
   reference would never be released.

Instead of ->pre_exit_batch(), could we batch this at the
unregister_netdevice_many_notify() stage (after the NETDEV_UNREGISTER
loop, when all devices in the batch are already down, unlisted, and
marked NETREG_UNREGISTERING)? That would avoid ->pre_exit_batch(),
net->undo_state, and touching rt_add_uncached_list(), while also
speeding up any batched device unregistration.
