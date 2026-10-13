Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47248C414
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912727; cv=pass; b=FMo+V7zkxRWSUrmrtRRlhV9LAjaud2RlxUZfODzImEFQF4h7obNGYYCgtIVtU/1lpofjoYueV0Jpqroxil4QULzlFR6GR6vraZH37L777WaX1ChfrrQAc80zCdP9GRJfZd66DPbmPxzq93anNZMO1oD3jaIlag4Zl5PFiPDNGFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912727; c=relaxed/simple;
	bh=3bJf7rB5mzrk5Vnkzr7cMS80P6CdxrJMNGaNVEb1BEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCeHl8ei9MSgnP5TVFc80K5doKpfHFJewq8pEyRehs+AsNj/jL8BSeODTEt4PuA3rMuKmQHQwQ/Kxdm7opHhceDTyO+psflC/MWhI4x45yRCz284xZHXuiz/5jp2BRjltzRrJ41YnRNJB+0qjfr3BeD5yc7WnrhalDaoxKBTUqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdHMFn6E; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdHMFn6E"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b190cdc9feso2003671b6e.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791912723; cv=none;
        d=google.com; s=arc-20260327;
        b=lywKaXeRayBluEb6mU+moKQ7HpUqqoIkMA0283H275PQfGXBjo1WHDM7YNB3BnECKF
         ZXEN15fkWLtpXHKUFFjXMOuaqtjQaWjnhD1CQVgjzDxrvVUIpUHvYt4VmRs6lk1mzOun
         tVeRMK9aArIX93P6aATFZ9Bq9dAynA1ODhJTa3TrDecMPbrwNQp+81z1IoevyEGI8wnN
         XJLmkBuwIVgP7ZrnLDBH8dts6ThKiw4kvyzNImesAVklUTnf1rzla92Ny5GF5F/SKFQo
         iBaVgU/2/XpX6y7zqYcyCtMzX0Kb2PJw2fvaEaTGbH4RxlQ9/+IpeRhJmAWA9yGx3JDT
         b9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+YqJp4O+59gQY9J3r/yMVPYfKYHH1g4JMnIPubeUpbg=;
        fh=Q3hopzfXSV3ON/sx6HnOiIs23SoDzed/qLXVnxtsSMo=;
        b=mICxwHYKMvM+6t19+e9tqPrVnMhodk7PAqgZvTB7aAvhIic0kR6a7V1ch7DzLMaV5v
         g6FOa7i26nVUMfgqNdlhJqeXJlxKau9WhajpVSygebFHBfNsLjAqCJxjaM54xNXXxM9n
         QGwIgX8QFgB6yZO5z/FdB8uagaFnKZEvE7j278o2SzBZyzRmlIyHmCZZSy/aEMkekNoY
         58Y9yyEHiig8UVv1nfv6dxHxSeDbkqZdSYibly1W2lmUin8hj+3M0DWGC3F8drChzMGa
         OMlzx9GRCDjJIvefQfb8HHb47VkI7ta6dPPAfJ8jtheSkZZZtlRHbqyUHlz9nJxZaQpN
         B1kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912723; x=1792517523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+YqJp4O+59gQY9J3r/yMVPYfKYHH1g4JMnIPubeUpbg=;
        b=EdHMFn6E0qm5D0y3oZMTyZddmr0jMrRhUuousUedTBlHxV8TqIDWJyCanzOUW46RLU
         uKYgR6nB1HsFvI7C8C9ibHv5RCCM4JOaU0hjzhB7mzsAbuw4CywYjI2oSg4yKawhDbxK
         cWlYdL1AE4OHL8V4waWgmIBfqS35FqrXNDgMOwfSOc7kkOhIXMbjZ2ZZa5fCAnjo8v/N
         q2kPstMMzPhNt0/OFm/KT9WRHcF/rlIJfbaEZrNlZln73igMKr65KDDyxxYN8KPKWFdw
         JvSXDF4/geWZM6xfybtDUAPvSpjWfQVZ84up5wDYamWyaiCyD78xBXP0C0nuqebTrV4A
         1L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912723; x=1792517523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+YqJp4O+59gQY9J3r/yMVPYfKYHH1g4JMnIPubeUpbg=;
        b=Z+y0MQUqm2qkyuE368JLiga8rgEQKzcLX0FkXHFozGfdrT+KrwTpNXu15Bog8+gHCI
         ZSnYq6P6u4n26ZqsRaBy/QBfai5tuGnfgRzG9dSKmLnL+cGSU6/VZNINQhfJi1eGKssz
         5l4zGHmongJVxXhgKc6rXazeLc7WP/KYh+pezjCwjWXQGldqKevxPs+hWXiioXnx18ZR
         ld/thSSjLetEiaWH+tVFIuj+mHgIwP2jn+lqvU2D6qbVEp3vcA9BuFsaD34KflKXR/VK
         gijKNVOZ7dRgvYrDxYS4JJ57TrAKA0v9H/SanO/WetXZXrTFsaIBlexRzfo4js3JGi49
         1TcA==
X-Forwarded-Encrypted: i=1; AKwUvBznTZcexrfLZ0IhhjFxmC6nvbt+2G828KoRHZquz+JY938U/j+IvLp6E0nf6seY9krOwIABHPE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5AvivJaBGx44+kghzFnJKnpeBY8STU1lDWJuc9K5B4dFx+zAw
	0nOLV3oldYySfwx2kGatYGmkwfNuenZzyoQ+cvq7B1Nkrc5SgwHn3biTfPrwRG5I6kdXH6I6+DK
	ZLZsxSf30IP422Bj0zDjtnQMJKhZtxiY=
X-Gm-Gg: AYBFou0Hy52E6/fqYsUcFUU9GYUS8ebGg2/fipHiukbD7Fn4u3vD7UL71u/2lrYZsL2
	SRRHsJlKuM9Fwm7S782pIJD1MsPaXBsYYROOVEEAO7LUjdFrEBzsUkGKXLbIMmLqCZ/pPKp5ipu
	rWndkVnPyILfz2HsjjJW1PcxvWa6DZzxQ+k3468BjHneP84IEPc4g2beslNYsl6okYjbkVIEh19
	oNqA2506jx7EbrUDIfhzMA68iQBZyZ5m7mkLqmoBRTlkvdOOAS3/lmIAlirWG3TaUdCxk8pJups
	At6v4st1peYSe6z1PyII7VH0tKwx17hDqTLAv64RjbVZQ6ZebCkPF7l0
X-Received: by 2002:a05:6808:c3ee:b0:4e8:92e5:db5b with SMTP id
 5614622812f47-50c5b4648camr15525292b6e.54.1791912723215; Tue, 13 Oct 2026
 10:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012125943.558629-2-omar@blockcast.net> <179190010922.434549.7719203541619227350@kernel.org>
In-Reply-To: <179190010922.434549.7719203541619227350@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 14 Oct 2026 02:31:51 +0900
X-Gm-Features: AclHuK8nmvo0sDZrNVF5UU3WsSdwlcxhN5MAdz88n-m1O0twpTrHbBedjUxJICc
Message-ID: <CAMArcTUgPVLO=A--VnMz77UAeTDhXmKVARrSD7ib0HG9WQ_zdQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/6] amt: fix use-after-free when a Membership
 Update re-arms a freed tunnel
To: netdev-bot+sashiko@kernel.org
Cc: omar@blockcast.net, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:01=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 (1) =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix stops a concurrent Membership Update from re-arming
>   gc_wq, but that Update can still arm other delayed work that points at=
=E2=80=A6
> - [High] amt_dev_stop() replaced the RCU-safe list_del_rcu() loop with
>   list_splice_init(&amt->tunnel_list, &doomed), which moves the RCU-=E2=
=80=A6
> - [Low] At this commit, a tunnel that only ever received a Request lives
>   three times as long (3*GMI instead of GMI), and the commit message=E2=
=80=A6
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but tunnel
>   teardown does not wait for a group_timer callback that is already=E2=80=
=A6
>
> --
>
> amt: fix use-after-free when a Membership Update re-arms a freed tunnel
>
> amt_update_handler() no longer re-arms tunnel->gc_wq. It now stamps a new
> tunnel->last_seen field, and amt_tunnel_expire() either re-arms itself or
> frees the tunnel under amt->lock. The patch also adds a tunnel->dead flag=
,
> and amt_dev_stop() now marks tunnels dead and splices the tunnel list out
> under amt->lock before freeing them.
>
> > diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> > index b53f8ec556615..b284fa7b7307e 100644
> > --- a/drivers/net/amt.c
> > +++ b/drivers/net/amt.c
>
> [ ... ]
>
> > @@ -2494,9 +2515,12 @@ static bool amt_update_handler(struct amt_dev *a=
mt, struct sk_buff *skb)
> >               if (tunnel->ip4 =3D=3D saddr) {
> >                       if ((nonce =3D=3D tunnel->nonce &&
> >                            response_mac =3D=3D tunnel->mac)) {
> > -                             mod_delayed_work(amt_wq, &tunnel->gc_wq,
> > -                                              msecs_to_jiffies(amt_gmi=
(amt))
> > -                                                               * 3);
> > +                             /* Refresh liveness only.  gc_wq is re-ar=
med by
> > +                              * amt_tunnel_expire() itself from last_s=
een, never
> > +                              * from here, so this cannot re-queue the=
 work of a
> > +                              * tunnel that is being freed.
> > +                              */
> > +                             WRITE_ONCE(tunnel->last_seen, jiffies);
> >                               goto report;
>
> [Severity: High]
> The Update path no longer re-arms gc_wq. Can it still arm other delayed
> work that points at a tunnel being freed?
>
> amt_update_handler() still holds only rcu_read_lock(), and it never check=
s
> the new tunnel->dead flag. After the goto report it does this:
>
> drivers/net/amt.c:amt_update_handler() {
>     ...
>                 spin_lock_bh(&tunnel->lock);
>                 amt_igmp_report_handler(amt, skb, tunnel);
>                 spin_unlock_bh(&tunnel->lock);
>     ...
> }
>
> The MLD branch does the same.
>
> Suppose amt_tunnel_expire() reads last_seen before this WRITE_ONCE() is
> visible. It then goes ahead with the teardown:
>
> CPU1 (amt_tunnel_expire)            CPU2 (amt_update_handler)
>                                     finds tunnel in RCU walk
> deadline =3D READ_ONCE(last_seen)...
> tunnel->dead =3D true;
> list_del_rcu(&tunnel->list);
> amt_clear_groups(tunnel);
> kfree_rcu(tunnel, rcu);
>                                     WRITE_ONCE(tunnel->last_seen, jiffies=
);
>                                     spin_lock_bh(&tunnel->lock);
>                                     amt_igmp_report_handler()
>                                       amt_igmpv2_report_handler()
>                                         amt_add_group()
>                                           gnode->tunnel_list =3D tunnel;
>                                           hlist_add_head_rcu(...)
>                                         mod_delayed_work(group_timer)
>                                         dev_hold(amt->dev)
>
> Nothing deletes that gnode afterwards. Would the gnode, its sources and
> the netdev reference all leak?
>
> The tunnel is freed once the grace period ends. When group_timer fires,
> amt_group_work() loads gnode->tunnel_list and calls
> spin_lock_bh(&tunnel->lock) on the freed tunnel. amt_del_group() also
> writes gnode->tunnel_list->nr_groups.
>
> The commit message describes this same class of bug: an Update holding a
> cached tunnel pointer arms delayed work that outlives the tunnel.
>
> amt_dev_stop() seems to have the same window. An Update that found the
> tunnel before the list_splice_init() can add groups after
> amt_clear_groups() has run. This path looks unchanged through the end of
> the series.
>
> Could amt_update_handler() check tunnel->dead under tunnel->lock and bail
> out before calling the report handlers? Both freers set dead before
> amt_clear_groups() takes tunnel->lock, so that check should close the
> window.
>

I agree with Sashiko's suggestion.

Please make tunnel->dead protected by tunnel->lock as well, and
have amt_update_handler() check it under tunnel->lock before calling
the report handlers.

> [ ... ]
>
> > @@ -2732,6 +2756,7 @@ static bool amt_request_handler(struct amt_dev *a=
mt, struct sk_buff *skb)
> >       for (i =3D 0; i < amt->hash_buckets; i++)
> >               INIT_HLIST_HEAD(&tunnel->groups[i]);
> >
> > +     tunnel->last_seen =3D jiffies;
> >       INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
> >
> >       list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
>
> [Severity: Low]
> Does this extend the lifetime of a Request-only tunnel from GMI to 3*GMI?
>
> amt_request_handler() still arms the first expiry at one GMI:
>
>         mod_delayed_work(amt_wq, &tunnel->gc_wq,
>                          msecs_to_jiffies(amt_gmi(amt)));
>
> When that work fires, amt_tunnel_expire() computes:
>
>         deadline =3D READ_ONCE(tunnel->last_seen) +
>                    msecs_to_jiffies(amt_gmi(amt)) * 3;
>
> The deadline has not passed yet, so it re-arms for roughly another 2*GMI.
> Before this patch, a tunnel that only received a Request was freed after
> GMI. Unauthenticated Requests can now hold max_tunnels slots three times
> longer, and the commit message does not mention the change.
>
> The new comment in struct amt_tunnel_list also describes last_seen as the
> "Last time a valid Membership Update refreshed this tunnel". At this
> commit the Request path writes it as well.
>
> A later commit in the series, "amt: do not create tunnel state for
> unauthenticated Requests", seems to fix this. That commit stops the
> Request path from allocating tunnels, which also makes the struct comment
> accurate.
>
> [ ... ]
>
> > @@ -3053,6 +3078,7 @@ static int amt_dev_stop(struct net_device *dev)
> >       struct amt_tunnel_list *tunnel, *tmp;
> >       struct sk_buff *skb;
> >       struct sock *sk;
> > +     LIST_HEAD(doomed);
> >       int i;
> >
> >       disable_delayed_work_sync(&amt->req_wq);
> > @@ -3079,9 +3105,19 @@ static int amt_dev_stop(struct net_device *dev)
> >       amt->req_cnt =3D 0;
> >       WRITE_ONCE(amt->remote_ip, 0);
> >
> > -     list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
> > -             list_del_rcu(&tunnel->list);
> > -             amt->nr_tunnels--;
>
> [ ... ]
>
> > +     spin_lock_bh(&amt->lock);
> > +     list_for_each_entry(tunnel, &amt->tunnel_list, list)
> > +             tunnel->dead =3D true;
> > +     list_splice_init(&amt->tunnel_list, &doomed);
> > +     amt->nr_tunnels =3D 0;
> > +     spin_unlock_bh(&amt->lock);
>
> [Severity: High]
> Is list_splice_init() safe here while RX readers may still be walking
> amt->tunnel_list with list_for_each_entry_rcu()?
>
> The old loop used list_del_rcu(). After this splice, the last tunnel's
> ->next points at the on-stack doomed head. amt->tunnel_list is
> reinitialised to empty, with no grace period in between.
>
> The only grace period in amt_dev_stop() is the synchronize_net() before
> udp_tunnel_sock_release(). udp_tunnel_sock_release() clears sk_user_data
> with rcu_assign_sk_user_data(sk, NULL), then shuts down and releases the
> socket without waiting for readers.
>
> So an amt_rcv() call that already loaded amt from sk_user_data could
> still be inside amt_request_handler() or amt_update_handler():

I think this is correct.
amt_dev_stop() needs to wait for in-flight amt_rcv() calls to finish
before tearing down the tunnel list.

>
>         list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
>                 if (tunnel->ip4 =3D=3D saddr) {
>
> A reader that has already passed the last tunnel would never reach the
> terminator, &amt->tunnel_list. Would it then treat &doomed as a struct
> amt_tunnel_list and read ip4 from stack memory past the list_head? It
> would then follow doomed.next back to the first tunnel and loop in softir=
q
> under rcu_read_lock().
>
> That would stall RCU, which also holds up the pending kfree_rcu() calls.
> Once amt_dev_stop() returns and its stack frame is reused, the reader
> follows garbage pointers. If the stack bytes happen to match saddr, the
> send: path in amt_request_handler() writes tunnel->nonce through the bogu=
s
> pointer.
>
> There is a second problem. A reader that reaches the allocation in
> amt_request_handler() after the splice (amt_tunnel_get_or_create() later
> in the series) can list_add_tail_rcu() a new tunnel onto the emptied
> amt->tunnel_list. Nothing in this stop path frees that tunnel.
>
> Would list_splice_init_rcu(), which waits for a grace period, or keeping
> list_del_rcu() work better here? This code also looks unchanged at the en=
d
> of the series.
>
> > +
> > +     list_for_each_entry_safe(tunnel, tmp, &doomed, list) {
> >               cancel_delayed_work_sync(&tunnel->gc_wq);
> >               amt_clear_groups(tunnel);
> >               kfree_rcu(tunnel, rcu);
>
> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch. Does this
> teardown wait for a gnode->group_timer callback that is already running?
>
> amt_clear_groups() calls amt_del_group() for each group under
> tunnel->lock. amt_del_group() only does a non-synchronous cancel:
>
> drivers/net/amt.c:amt_del_group() {
>         if (cancel_delayed_work(&gnode->group_timer))
>                 dev_put(amt->dev);
>         hlist_del_rcu(&gnode->node);
>         gnode->tunnel_list->nr_groups--;
>         ...
>         kfree_rcu(gnode, rcu);
> }
>
> If amt_group_work() is already running, cancel_delayed_work() returns
> false. amt_group_work() loads the tunnel pointer outside any RCU read
> section:
>
>         struct amt_tunnel_list *tunnel =3D gnode->tunnel_list;
>         ...
>         spin_lock_bh(&tunnel->lock);
>
> If the callback is preempted before spin_lock_bh(), could the grace perio=
d
> finish so that it takes tunnel->lock inside a freed tunnel?
>
> If the memory has not been freed yet, the callback takes tunnel->lock onc=
e
> amt_clear_groups() drops it. For an EXCLUDE mode group the source lists
> are empty by then, so delete_group stays true and amt_del_group() runs a
> second time.
>
> Would that call hlist_del_rcu() again on a node whose pprev is already
> LIST_POISON2? It would also decrement nr_groups twice and call
> kfree_rcu(gnode) twice.
>
> amt_tunnel_expire() has the same issue, since it also calls
> amt_clear_groups() before kfree_rcu(tunnel). Only gc_wq is cancelled
> synchronously here; the per-group work is never waited for.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261012125943.558629-1-omar%40blockcast.net
