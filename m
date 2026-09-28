Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029D2D8DD0
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613198; cv=pass; b=eMuqzLiamoz6aeOI7HWaKsLGtnV9nMQmlsmyockracGKSl5gBR7uv2qtEKS4Zt6Zo5BVVxE7KkVbpraYQ28tUZeK1wj9s2nTG6XYrIimhfM4Um+/XKmafHxbE2hxqfUzgb2ZAoQ02/7NBOe7vdc+2ijiqtrWhwg4lV7odCfLTO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613198; c=relaxed/simple;
	bh=mppBaPEWEQOtchR8JI8cRRfZppxqgT0xBEY5JgRZ52E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFVWbTBk6Gk9s9fOXqBk6D+i9hf0zL9pjIPb2OmotjNrQ12zok1bNq16cPP+UHLQ7eecJ8FjNP2WgRIwcNFwivy+MD/iB0YYvvggE34jEJvaOfZxwmnaqgFtFoVjmVD/Vod5kvqn4hfnw2N55pw3Oc8lvJx+PX8zmaBNE+Kb/Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tw5qyDCw; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tw5qyDCw"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd046b87so2293365c88.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790613196; cv=none;
        d=google.com; s=arc-20260327;
        b=hROJClqR2M9Vwk1soUDxru7zXrNQTqc9EEP0Kwr+jR+hWC1tQhBxuxRNqnwx12+PvF
         AHu71cXMt8PwplxXRi5TnGPLfOInHoLoi5Cu9fiHlaQsju7hgHQRvaUYiemeuGbbyWFn
         quJ59tyGgpYnWHLy8OnFIfD0VmLxlKN2AJuTsb6j3sdMUxCcntbmFOYRRu7IJFdb2aq/
         3XQzXYHrGGpwMOWSljY7GCVTmSkWP4lTg6OF3TviQJpaQY02KMy1UxznlvVv7smP2Wrz
         9QRAjAdEAAfCymevDjVbgj+frwImi3Jgx/aOWKpLXnznb+54OQnbq7IPo1Dr1zpAMO1/
         /R5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=atmyq5wTdrutU4YVxAhrorXaFL/miDNHiGShRPm/blU=;
        fh=qewC8wGrpVUK7q2bYQ+6c+5JK7rA1VBA6KvKi3P4nts=;
        b=WX/FeXhniqLlqYUp8azmGOPgZ78yFGdw35w6p7uqNe17x6QuKoQVaSpR3ccbRvLzN0
         OaZCn/CU0lyuggEQoSl25xmyRfYyQtm6ZZ8NVP6d97DYaGfHMlw/5zdiprMj+T8USl6t
         bf+VlxunI3GzeIEC42g9a2qhGAPYQU6dVZRs7TjxaPy7Wn0e2rrd354z6l3E66ssZ9/u
         eOpJdWUGGAr+gH11yYDffozAY/254uJpgtAzrTvIfFJVuR3lA6kCT1zikwIq2HhcIAL0
         j7sxLFIEnapKiaZtOS4jX39gjRWJaPmRn/o/po9CYJv8rjsWaRmRBTuSdblUSFeA5b8n
         5j8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790613196; x=1791217996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=atmyq5wTdrutU4YVxAhrorXaFL/miDNHiGShRPm/blU=;
        b=Tw5qyDCwssaY/up4MIDfZjMvJsfmHGm4ZCSmhZPD+Ca1ri21+hofrCllg2e0GWYV90
         fNFAYkk9P2+i28F31AieDjdVzO+h0TyuVkobAwlFN/EKJSTdsOQ9Rfnl84au3HwUImEJ
         moqjCw4dqHWE/5diZW96sORVQYW4KMRXQS87lC+/CQeHmnsWfMogzmwvKa73EZAzGLlv
         fq7Kw70AB8qxaRqFDtKDuc/pj2Dn4OFbB8lLgKPBnsZ13uWnVKaTTN3ZEH5gzKmsOkDM
         hKdDuhmQzZgKKReuVAtFvNL/10rf1Qg4PwCkfoOvJEWK1YXs+jqeoKLFD/9jkxZfAXbX
         kMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613196; x=1791217996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atmyq5wTdrutU4YVxAhrorXaFL/miDNHiGShRPm/blU=;
        b=RsDccDp0DuH4dwBAOYTRACzKft1ySF+QkoeQSlKRlxbcpowSs1UN9xQ7cltvzuZzvj
         mfeKzqNg78cEzeQuaBeLMSPgGbnNs5PexFaG+zSlKkzGwwISu+Kcwk+VX/RoHkVbNJao
         YXDynbatW0iqtT02QjfHeXWsRP2zp13AgvIKQ07CZLOR+3wipq/DQhn8aeZS09y5a0fi
         maDoktSR55a6/nCLQUXjly3LCTj1zA2h03rhjbr/yHF1OwUnvvgTdgl2uyM7W7F8SS3R
         2YVpsoLgBtCHCG97CRoK/gjldCvWtW9K+voT+tUCTfI+hPoWJsOnwwZpSTR0yLRCVRue
         ohHA==
X-Forwarded-Encrypted: i=1; AKwUvBwhE1CG1QxqIUElvaOmyynWmUUyzHSXOAmg1fEiUdOS+E4V1D20u5o92mRBVMh00pQhraOJ6Tk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsZdtRHKEN4qHzCe2qyywrXKrkReZJHl4rxVsPx4wfNzfZ0bax
	qhAJpBqOoUI2nV7++tngWXSzKgR/80yMn+h4Jj/l7IkgXOwJu6OlgDo0TrJJU4X0Fm5ZSWfSiSM
	Uu9PZ4msOwd8WZh2lZ4WBrbenUZi1HjXLshTtHxDGlug5yDsqfRBso/C5L8wsqw==
X-Gm-Gg: AYBFou3xoLJuJW2HImE0dWyeRHJLcpLBLe1Ze2x7ad//f2az8HzgXleM+XCd0xVoqCi
	itsFkaV+eVrkFgzFHR0oh2/CxOxjznz2jFN/EDwlwfNuXiVTNJlQo7H2PGOqO+LVxzzF2ibeh7M
	s+D5tLsulzExv0OjwHqS6pDUGH8DTVnTJih7N8sQpJEIDy4c7Z2D7q4UqLOES6WsK0VFsyCxVXj
	+eBYwe/DM55cDORVFWb19e2K4cSlReBX3JkOoEanZCklelEEs5IayWjzFqA0lpg8lTuc5C9/r9A
	UQEiFJljFODMTu+VtNVIMSqZuePJ5T0nNlFxA+v9tOs6HIlyciF/7YEYF9ChpVJXYg/bARKbHyI
	JDpKaxVCUitlLGf+skSQFiAG5WpENBfak6uYDDgSKUu9OGuAJOmnxvbrfPvz889mjuSUH3xQxjA
	QeCZb76hOorjoKUqAr4b5KtQ==
X-Received: by 2002:a05:701b:2059:20b0:147:9ad0:cf76 with SMTP id
 a92af1059eb24-1479ad0d1b9mr9503277c88.34.1790613194704; Mon, 28 Sep 2026
 09:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927202429.2452589-1-kuniyu@google.com> <20260927202429.2452589-5-kuniyu@google.com>
 <CAL4WiipHSvpgRwzP3C-E2xWSv1dqzB5eCOVZGiTVyxy6JohhPQ@mail.gmail.com>
In-Reply-To: <CAL4WiipHSvpgRwzP3C-E2xWSv1dqzB5eCOVZGiTVyxy6JohhPQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 28 Sep 2026 09:33:01 -0700
X-Gm-Features: AclHuK8opYTLJ8J3V5U2sUuHmDcMaoZFCOPRC8YulZeSmUpZ4Yub-q651R8g_Ag
Message-ID: <CAAVpQUC-ZZ6am1ZCwCjm-_=s7K9nZQ8tDv3=k9L94D9H68ALBA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/5] ipv4: Batch rt_flush_dev() for dying netns.
To: Eric Dumazet <edumazet@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 3:52=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> On Sun, Sep 27, 2026 at 10:24=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > IPv4 uncached routes are linked to the global per-cpu lists,
> > rt_uncached_list.
> >
> > When unregistering a netdev, rt_flush_dev() iterates over the
> > potentially long lists to find uncached routes tied to the device
> > and swap it with blackhole_netdev.
> >
> > Since it is called for every device in dying netns under RTNL,
> > it adds O(N_dev x (N_cpu + N_route)) costs to netns dismantle.
> >
> > Let's call it (almost) once per cleanup_net().
> >
> > When rt_flush_dev() is called with NULL from ->pre_exit_batch(),
> > it purges every entry in dying netns, reducing the cost to
> > O(N_cpu + N_route).
> >
> > Since ->pre_exit_batch() is called before synchronize_rcu(),
> > we must prevent adding a new route for dying netns, so now
> > rt_add_uncached_list() checks !check_net() and swaps the device
> > with blackhole_netdev.
> >
> > When rt_flush_dev() is later called again from fib_netdev_event()
> > via NETDEV_UNREGISTER, it just returns.
> >
> > Note that net_pre_exit_done() cannot be replaced with !check_net()
> > because:
> >
> >   1. some ->pre_exit() call unregister_netdevice() before
> >      fib_net_ops (e.g. ovs_pre_exit_net(), l2tp_pre_exit_net()).
> >
> >   2. ->dellink() could call unregister_netdevice() for another
> >      netdev in a dying netns queued for the next cleanup_net()
> >      batch, for which ->pre_exit_batch() has not been called
> >      yet (e.g. veth).
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/fib_frontend.c |  6 ++++++
> >  net/ipv4/route.c        | 28 +++++++++++++++++++++++-----
> >  2 files changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
> > index 8a3dc04e8cac..b8d76b6279e1 100644
> > --- a/net/ipv4/fib_frontend.c
> > +++ b/net/ipv4/fib_frontend.c
> > @@ -1685,6 +1685,11 @@ static void __net_exit fib_net_pre_exit(struct n=
et *net)
> >         nl_fib_lookup_exit(net);
> >  }
> >
> > +static void __net_exit fib_net_pre_exit_batch(struct list_head *net_ex=
it_list)
> > +{
> > +       rt_flush_dev(NULL);
> > +}
> > +
> >  static void __net_exit fib_net_exit_rtnl(struct net *net,
> >                                          struct list_head *dev_kill_lis=
t)
> >  {
> > @@ -1704,6 +1709,7 @@ static void __net_exit fib_net_exit(struct net *n=
et)
> >  static struct pernet_operations fib_net_ops =3D {
> >         .init =3D fib_net_init,
> >         .pre_exit =3D fib_net_pre_exit,
> > +       .pre_exit_batch =3D fib_net_pre_exit_batch,
> >         .exit_rtnl =3D fib_net_exit_rtnl,
> >         .exit =3D fib_net_exit,
> >  };
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index d7da2f1acbb5..cbe328b3f254 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -1554,14 +1554,29 @@ struct uncached_list {
> >
> >  static DEFINE_PER_CPU_ALIGNED(struct uncached_list, rt_uncached_list);
> >
> > +static void rt_replace_uncached_list(struct rtable *rt)
> > +{
> > +       struct net_device *dev =3D dst_dev(&rt->dst);
> > +
> > +       rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
> > +       netdev_ref_replace(dev, blackhole_netdev,
> > +                          &rt->dst.dev_tracker, GFP_ATOMIC);
> > +}
> > +
> >  void rt_add_uncached_list(struct rtable *rt)
> >  {
> >         struct uncached_list *ul =3D raw_cpu_ptr(&rt_uncached_list);
> >
> > +       /* Set once and never cleared: non-NULL marks an uncached route=
. */
> >         rt->dst.rt_uncached_list =3D ul;
> >
> >         spin_lock_bh(&ul->lock);
> > -       list_add_tail(&rt->dst.rt_uncached, &ul->head);
> > +
> > +       if (check_net(dst_dev_net_rcu(&rt->dst)))
> > +               list_add_tail(&rt->dst.rt_uncached, &ul->head);
> > +       else
> > +               rt_replace_uncached_list(rt);
> > +
> >         spin_unlock_bh(&ul->lock);
> >  }
>
> Hi Kuniyuki,
>
> Doing this in ->pre_exit_batch() and rt_add_uncached_list() /
> rt6_uncached_list_add() is too early.
>
> 1) check_net(net) becomes false as soon as the last put_net() drops
>    __ns_ref to 0, while devices in the netns are still UP and sockets /
>    packets are still active (until default_device_exit_batch()).
>    Swapping rt->dst.dev_rcu to blackhole_netdev on live routes (while
>    rt->dst.input and rt->dst.output are not dst_discard) changes
>    skb_dst_dev_net_rcu(skb) / dst_dev_net_rcu(&rt->dst) to &init_net.
>    RX paths (__inet_lookup_skb, __inet6_lookup_skb, tcp_v4_rcv,
>    icmp_rcv, ip_error, ...) will then look up sockets in init_net or
>    send RST/ICMP from init_net, and TX paths (ip_route_output_flow,
>    icmp6_dst_alloc, ip6_output) will see blackhole_netdev / init_net.
>
> 2) In patch 3/5, ops_undo_list() is also called from setup_net()
>    (out_undo) when an ->init() callback fails. At that point
>    check_net(net) is still true (__ns_ref =3D=3D 1), so ->pre_exit_batch(=
)
>    will skip net (or not be called at all if setup_net() failed before
>    fib_net_ops), yet ops_undo_list() sets NET_PRE_EXIT_DONE because
>    ops_list =3D=3D &pernet_list, causing default_device_exit_batch() to
>    skip rt_flush_dev(dev).
>
> 3) In rt_flush_dev() / rt6_uncached_list_flush_dev(), the lockless
>    if (list_empty(&ul->head)) check can race with a concurrent
>    rt_add_uncached_list() that observed check_net(net) =3D=3D true just
>    before the last put_net() but has not yet executed list_add_tail().
>    Since NET_PRE_EXIT_DONE disables all subsequent rt_flush_dev(dev)
>    calls (including the retry in netdev_wait_allrefs_any()), that dev
>    reference would never be released.

Ah, 1) & 3) are problematic exactly.


>
> Instead of ->pre_exit_batch(), could we batch this at the
> unregister_netdevice_many_notify() stage (after the NETDEV_UNREGISTER
> loop, when all devices in the batch are already down, unlisted, and
> marked NETREG_UNREGISTERING)? That would avoid ->pre_exit_batch(),
> net->undo_state, and touching rt_add_uncached_list(), while also
> speeding up any batched device unregistration.

I think it's doable, we can skip each dev's call by

if (dev && dev->reg_state =3D=3D NETREG_UNREGISTERING)
  return;

and do batching later.  I think it can be done in netdev_run_todo()
after unlocking  __rtnl_lock() and if (!list_empty()), then we could
check like

if (!dev && list_empty(&rt->dst.dev.todo_list))
  /* purge */
