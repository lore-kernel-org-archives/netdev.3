Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD722D5925
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951482; cv=pass; b=G+8UUYq8DXSUA+8cfGKmG8YLiaaufqg+l4FJX+2mJbXiodbcdYInLxsV+CBLbMZxMs5zWE4qgcWqb6Y5LpOv4jWpGH9qJq2jkW3T5RkxLG8XMnN5LqhCA+byVdeuxlf+pvGT/YLydeH3bnJCYqgBseESMqthkIswK68xe7VcPO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951482; c=relaxed/simple;
	bh=FCFoyOy4qvXMnUzHelNH4AHBinUUgJXQyV47QXx+bBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sS2D3ai0YLiG4goMMHBqY0HKR7ehGNkqJACMmuWGkSo+g2B8ZTuodmpijj3jsdHbxNBUL642GJ3KJhZBfP1AmcQheBEDfDGFg8XfJ5n4olofO4OMQhSjOM4k1h9djkhp/OeBL7k6NdOeOzb8Q05fvuD/r9ysCRTKnOoZRlaromU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdI2p6LC; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdI2p6LC"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91791ec1b83so30908416d6.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791951479; cv=none;
        d=google.com; s=arc-20260327;
        b=CNnIDxO5Mqv2Fvg1cadULwAxiJQug42eNMbzTZ7dxfk+N45mzJD2pmu0zOGWMH7c7b
         f+rFd8RoOWeifcDoQbAtCmoaePz3AIl8c4zumTDEkRt6H2II8F3aYtgQy8po/B5K4Gh9
         ut53bWDzvnLBYyX2dOjWkliVaimSulkc80V5c3Skn+yrWDVDIZhRyxmbcVirrmKiQk8E
         oEC8gvQ2mjZNSt8QFgrsvE9v4/qY6yy4AmWAAbAFGueDLWE075CLKNOUWRMIxVk0OHWc
         yRY7PcZyIdD3vI6AdXoeY9ZOlDkohNT+tfkbksItQvvGKlncVHHJeQdSFVlICiKFI09m
         viKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        fh=Ncdyp8DGZS9wiG1kCGFS58zREB092pJxJr0fwzuQApA=;
        b=JqKiRbmhMGAOCAeU+2BxovRTsmUaD6S+ZJTRLtTobSNpH4KSE59vePxPCZb9ZChSL4
         W1QKB0gQJMUSFRKkGkzbtYfo2H764duB94KF/FSCD274hu/pNDIpWVWUa7/qV9duuVcJ
         1TZlHplCQn13rg6kAOTEnrber0lnckDMDmppGB5madJsTqPOUwhUzqyHZcVw27eYy/rl
         /KMDouOa61ZKY6zYRU/ay9jBmd9quJKz/WPx7i6ErMRED8QAjvjO5Ev2ocWuneOSB+mb
         vspaqiM5d3gi/6exXv57sEfzh96MLx1EKVisM08GVR0Sp/V5M7sfRwoAy0H6lukEO6u7
         Lh7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791951479; x=1792556279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        b=SdI2p6LCQ4aWaQPT6dillp92RI21bwsURrLkqh9CawHgTGt5ayFDz9YWLEYw+caXN6
         bTiaZhpDOG9II7LcivZaGyhxCF/Thd/6I9z7+R5vOPKcGAcXtZ0fPJLAslYG+p1tZXR7
         +NGiiP+A0bMWJtThoWCsVUpB5vveeEB9YM1RTB0tFMq8FNHvDwuZRywH8etLN1VzuD6a
         +AAaaORC27I23AXDgY9K+YNqlS4hRoUX7d90LU1GugjnmvZgbpjQzo0dCTDnxgPSQ9m9
         w9S3M9EAYyAkRCchj1URaqUEbYehTc7s/YnKtgT/DNv3RMfBcFcRTlu+9OQeV5DEAOnt
         UaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951479; x=1792556279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        b=umIspUYv2ybZ+tWPxeA4seNBqV6H4o1ph+NEc2ZRDSLEzkGGOvPav94TTGyUIVLZZQ
         EQNc1Z+m7dLGk4JPpdBd9c/bAcf+yxLr9ji5QN2ch8MLkU7tGnKTjVh11zGGzJ/mMa1R
         8S3GsBiGIb84ib+sfhhM9rFLzt0dSzWz7mlMawJp/QQmRRqc61e8GpL293ILVtPKuQyL
         NJg+3hQvDuXowzdRouGWCuWOPEaKjoBABAd6xIGX0NEx01apzc7niBiv++P5fUeMh0DV
         nfqf5LE8fzCwAbGkbpsa+hh9U5gMY2ox2caYr1TGhfwVrxYhFOtt9bIDbWuDvKJxEfaN
         DhwA==
X-Forwarded-Encrypted: i=1; AKwUvBy5N1aNn+SLxWQPothm1g/YhD1giXkXJW7BNXFoe66k8EMpCu6hF2l5EAzRvuYQeVr0yKNhdEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyP5MFRDn9KTbdYMy3QDhqvQNgNyZMXvX1lktEsC7gQTxRNVaM
	k8vR4ZAUXJurHjKgyUDvb9Le90CiJFGwzh/tem4JOuwouuYvrV82VSjP3KJi6/sKOIv9FZNLetE
	bJAs31gUr5L+bTInaWLEudosxBGu1Dns=
X-Gm-Gg: AYBFou1s5zoZ4M8Qfh6BZXO9k7YCY2GDkfkD0vfYIXVuRg8cqusnJ6PoyeRqDNjAdxD
	UXbEf8Qf0tMwl3dSmw32BAHB/wdwVXdrE/2puGCPAxi2lYOsGWXS6PujL0yX6391gK8guzY3qbL
	kTqKTzA7HNhlKWAJtbJ5X7DumW58w5PQMwgHWR0w627IjhoyRobdCKbJgUTUoX9+wJmhZrlAZ+T
	J5tKKnTgiAaWNX+IyvqPQXApFm0iPKdaj2Ye1xutNhGZcPOMUE5NGk1jzWOkxOA21thXAFesPYu
	GT9yLLk5R0ZprWld4lapZK5pZyYjG22XDrzOyrpvQHrjd7kmfTsyO3Y=
X-Received: by 2002:a05:620a:4449:b0:93b:e9db:1bab with SMTP id
 af79cd13be357-93ebd27cc75mr2258515585a.56.1791951478672; Tue, 13 Oct 2026
 21:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
 <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com> <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
In-Reply-To: <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Wed, 14 Oct 2026 12:17:22 +0800
X-Gm-Features: AclHuK-Tjj0vL8jiV-17JnHCHultMYwdnuqEsTpaVilZ25EnMCMFZNG1gR08W4M
Message-ID: <CAJwVaM+SHuidjUeKD8-MX2ErbkaBUKE8cPYH2fzNJR+jH-oWZw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Tue, Oct 13, 2026 at 11:26:38AM +0800, Jia Jia wrote:
> > >
> > > On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > > > Split virtio_transport_recv_pkt() so socket lookup is separate from=
 the
> > > > receive state machine that runs under the socket lock.
> > > >
> > > > Keep virtio_transport_recv_pkt() on its existing per-packet locking=
 path.
> > > > Pass the source and destination addresses used for lookup to the lo=
cked
> > > > receive path so they are decoded only once.
> > > >
> > > > Pass the network namespace and decoded address tuple through a pack=
et
> > > > context to the locked receive path.
> > > >
> > > > Preserve source validation and failure handling. Keep the lookup re=
ference
> > > > separate from the skb owner reference so the locked receive path ca=
n manage
> > > > the two lifetimes independently.
> > > >
> > > > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > > > ---
> > > >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++----=
----
> > > >  1 file changed, 96 insertions(+), 43 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > +/*
> > > > + * The caller holds sk's socket lock and must free skb if this ret=
urns true.
> > > > + */
> > > > +static bool
> > > > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > > +                              struct sk_buff *skb, struct sock *sk=
,
> > > > +                              const struct virtio_transport_rx_pkt=
_ctx *ctx)
> > > > +{
> > > > +     const struct sockaddr_vm *src =3D ctx->src;
> > > > +     const struct sockaddr_vm *dst =3D ctx->dst;
> > > > +     struct vsock_sock *vsk =3D vsock_sk(sk);
> > > > +     struct net *net =3D ctx->net;
> > > > +     bool space_available;
> > > >
> > > > -     /* Check if sk has been closed or assigned to another transpo=
rt before
> > > > -      * lock_sock (note: listener sockets are not assigned to any =
transport)
> > > > +     /* Check after acquiring the socket lock. Listener sockets ac=
cept packets
> > > > +      * from any source and are not assigned to a transport.
> > > >        */
> > > >       if (sock_flag(sk, SOCK_DONE) ||
> > > >           (sk->sk_state !=3D TCP_LISTEN &&
> > > > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > > > +          !vsock_check_source(vsk, &t->transport, src))) {
> > > >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > > > -             release_sock(sk);
> > > > -             sock_put(sk);
> > > > -             goto free_pkt;
> > > > +             return true;
> > > >       }
> > > >
> > > >       space_available =3D virtio_transport_space_update(sk, skb);
> > > >
> > > >       /* Update CID in case it has changed after a transport reset =
event */
> > > >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> > > > -             vsk->local_addr.svm_cid =3D dst.svm_cid;
> > > > +             vsk->local_addr.svm_cid =3D dst->svm_cid;
> > > >
> > > >       if (space_available)
> > > >               sk->sk_write_space(sk);
> > > > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virti=
o_transport *t,
> > > >               break;
> > > >       }
> > > >
> > > > +     return false;
> > > > +}
> > > > +
> > > > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's=
 vq->mutex
> > > > + * lock.
> > > > + */
> > > > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > > +                            struct sk_buff *skb, struct net *net)
> > > > +{
> > > > +     struct virtio_transport_rx_pkt_ctx ctx;
> > > > +     struct sockaddr_vm src, dst;
> > > > +     struct sock *sk;
> > > > +     bool free_pkt;
> > > > +
> > > > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > > > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > > > +
> > > > +     sk =3D virtio_transport_recv_pkt_find_socket(skb, &src, &dst,=
 net);
> > > > +     if (!sk) {
> > > > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > > > +             goto free_pkt;
> > > > +     }
> > > > +
> > > > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > > > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt =
=3D=3D 0\n");
> > > > +             goto free_pkt;
> > > > +     }
> > > > +
> > > > +     lock_sock(sk);
> > > > +     ctx =3D (struct virtio_transport_rx_pkt_ctx) {
> > > > +             .net =3D net,
> > > > +             .src =3D &src,
> > > > +             .dst =3D &dst,
> > > > +     };
> > > > +     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, &ct=
x);
> > >
> > > At this point the socket lookup succeeded with src/dst/net, why not j=
ust
> > > pass sk which already has all of them?
> > >
> >
> > If I understand this correctly, a successful lookup is not enough to
> > recover all of this from sk. The lookup may fall back from the
> > connected table to the bound
> > table, so the packet source must still be validated under the socket
> > lock; otherwise that check would become ineffective. The packet
> > destination is also needed after
> > a transport reset, and the RX namespace used for a reset reply is not
> > necessarily sock_net(sk) in global mode. I=E2=80=99ll remove the contex=
t
> > struct and pass src, dst, and
> > net directly.
>
> True that the lookup may fallback to the bound table, but this begs the
> question, why bother with the bound table here? If a socket hasn't
> landed in the connected table yet, then OP_RW is -EINVAL and we respond
> with RST anyway... so I'd guess we shouldn't even be trying to batch for
> those sockets.
>
> For connected sockets, the sk has the destination (vsk->remote_addr)
> needed by the reset. And yes, sock_net(sk) does not necessarily equal
> the net ptr used for a reset reply in global mode, but we don't really
> expect that for global mode in vsock, we only expect that
> vsock_net_check_mode() rules are followed. In this case where
> !net_eq(n0, n1), the RST reply will be routed correctly across
> namespaces following global mode rules.
>
> I could certainly be missing something and happy to be pointed to an
> instance of sk being insufficient here. In general, I think its nice to
> avoid new data structures if possible.
>

You're right. Although virtio_transport_recv_pkt_batchable() requires
TCP_ESTABLISHED and excludes other states from batching, the
bound-table fallback is
unnecessary there; batch admission can use only the connected lookup
and leave a miss to the normal path.

I also overlooked what the existing vsock_net_check_mode(sock_net(sk),
net) check guarantees. If the namespaces differ and the lookup
succeeds, both are
in global mode, so sock_net(sk) is sufficient for routing the RST. The
extra context is therefore unnecessary. Thanks for pointing this out.

I'll update this in the next version.

> Best,
> Bobby
