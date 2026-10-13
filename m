Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB75226A0
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911811; cv=none; b=fn2Mtf7ig9ShZTCSj6qMFR9tLrd+7QEb0FtpG3o1FqoaoDz4AybkGMCJTA4gopjulbQl2IVcSwCqpBo6DgQIeLS53V6/3NeN5U/egxlnW3KGxU02hs5awCgh5qz7dY3D5T2v2PI1aTYi6dU/A/rfrjfNxLqYB5j+CzEtL6YHNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911811; c=relaxed/simple;
	bh=E0y7u+KR3xF/a4fcPKHidebxgCLhqgP2K/Rv6TPbOiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/bES9zquS0MugC+ApnYIXl1FLxvnCNDcpOBRRbupx/A2eY1+5KumjukV8L6MP6xqBTDNKiWaS3IK/eWVifUamg9/B0ZKVcUEpZphgGAoHXLohpXfJ797vqrXhdEzbGklO3/TCM83nCYA4r/+RsNtB1G3gz0eiBNC4Mc17kVzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OngxHnvA; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OngxHnvA"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4f59ea27bd0so1014360b6e.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791911808; x=1792516608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rh8zSXbKHc5uCKze2IT1wznFx+pVYTz0bfvRk4C07S4=;
        b=OngxHnvAA6saR3OBCtEOXWu6BOGRi+0KC/UsGTlv/UJBcnpyFztf00L4tqRe19juF4
         0NP69aClxJpJWCL6ILli8w+pOqUiUsmk6Q1tSLrbqqHwoxzxu+W9WLegjMmVhm08gXSp
         7L2iGOIG5qv7GQKjisQZ6xKVY5roN47WTEPrxIXGOf2uelKvAk6dTwEjYgU/prxMy5QQ
         mDLMTDyB8d1b5a/rDhd3zoWH73f5jtTvQq10X9TXE5zdy8ayYQMDxEB41YgyZlQkDzDu
         IhI2wBzMYATeYlmeviHi/U5CFKW85GFyhZp5HuLynuitHhWxhOogmdr2izp2Aae8SPT1
         VrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791911808; x=1792516608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rh8zSXbKHc5uCKze2IT1wznFx+pVYTz0bfvRk4C07S4=;
        b=kR/TSJqL1vT+prmd350aN/POjLDbR6Cwb9o/p0j0+swO8VgHJceS3JWWbvWd5wVJPN
         +WLfwN1ZYvk74Pr160XnOsyvVFBAOmsdD2s2iApbEOLrkIz6qeP29TD5R42mNeuppqyW
         nlzipbGOKx16cam9X6x4yJBUYmufm6em6ZDgIxILo7QXnDbvK++DkN3L2kB8HNhsgFgX
         y0ShrAaL+LUXw9z5Tu9vya4OBzI5Ag/FH7TBQAkRqF6PF8TTdR7yKzBxSGhQbdf2ZaJ6
         9Q+u8ardJp8Z6bY3I3MC+J6sJ8OfDRDpN6WZXHrc8h9nhI+MHMVDj0Ve9anjOJOZEHiu
         tu9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwSbrMbgUpa4yshPAqlFqJTcovkaimyNRUBtWkFezHKMKHRMGN6Bejqro9hTm+yUxhMEK1IzMA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV7n19vbuxHPs62LYjXc+y78PCXaPDvAv2RAZDz+c5bc6jBvFH
	uiEj8a8vvLHjNC+8jnOdcC8R62oxeryikZwYnYt+QeGA5I0fAnCQcUiL
X-Gm-Gg: AYBFou1MmMl8uqCjNSQaWqILMR4nlKwp64w9oDn4490R5X//UUnGH4DmrdQGTQRHPxd
	KOb7Me05PV+i4pbEAcsaLXo2E5fbSA+mtzRcIqHccxy8W7R7aalz8eCD1oAtCA6fmh0o86y5sWX
	WbCNgWuDVK/WW7vyPlZF0JfMv26KVV/SQCm7h0Yc1t6halmf8AYc4z+osHMuuVZJ97Wl+LCi+pC
	hVhByi19oG5katWa47edV+NTui02RLWD3hoWtEPwIMiyz49WJdwK6bMGoLjWNMUGX+lqknFuI3E
	uS7NVLDN36NezN+eq00w1F7+L2T0nQnsHLX8EIuFjPicP8eYcXmCrd3wdDwixaEciBnmlwH/O/N
	Vucg8zGo1QS5qf6FDWVU9uvh5Dcud2NUx45vA1oeD7u8iOQALphxJejmarqclf1N9jV3quzlqsK
	nvpP5//E4msZJ7VqNZoo67N7+ZwgZO6gSmUIRwRV55EnwT/4EOeOlLHX6rPD2DYTrKPBU=
X-Received: by 2002:a05:6808:13c3:b0:4d6:93e2:5bc4 with SMTP id 5614622812f47-50c59f38b43mr14625456b6e.64.1791911808288;
        Tue, 13 Oct 2026 10:16:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c0248fbsm15142233b6e.15.2026.10.13.10.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:16:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:16:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com>
 <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
 <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com>

On Tue, Oct 13, 2026 at 11:26:38AM +0800, Jia Jia wrote:
> >
> > On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > > receive state machine that runs under the socket lock.
> > >
> > > Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> > > Pass the source and destination addresses used for lookup to the locked
> > > receive path so they are decoded only once.
> > >
> > > Pass the network namespace and decoded address tuple through a packet
> > > context to the locked receive path.
> > >
> > > Preserve source validation and failure handling. Keep the lookup reference
> > > separate from the skb owner reference so the locked receive path can manage
> > > the two lifetimes independently.
> > >
> > > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
> > >  1 file changed, 96 insertions(+), 43 deletions(-)
> > >
> >
> > [...]
> >
> > > +/*
> > > + * The caller holds sk's socket lock and must free skb if this returns true.
> > > + */
> > > +static bool
> > > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > +                              struct sk_buff *skb, struct sock *sk,
> > > +                              const struct virtio_transport_rx_pkt_ctx *ctx)
> > > +{
> > > +     const struct sockaddr_vm *src = ctx->src;
> > > +     const struct sockaddr_vm *dst = ctx->dst;
> > > +     struct vsock_sock *vsk = vsock_sk(sk);
> > > +     struct net *net = ctx->net;
> > > +     bool space_available;
> > >
> > > -     /* Check if sk has been closed or assigned to another transport before
> > > -      * lock_sock (note: listener sockets are not assigned to any transport)
> > > +     /* Check after acquiring the socket lock. Listener sockets accept packets
> > > +      * from any source and are not assigned to a transport.
> > >        */
> > >       if (sock_flag(sk, SOCK_DONE) ||
> > >           (sk->sk_state != TCP_LISTEN &&
> > > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > > +          !vsock_check_source(vsk, &t->transport, src))) {
> > >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > > -             release_sock(sk);
> > > -             sock_put(sk);
> > > -             goto free_pkt;
> > > +             return true;
> > >       }
> > >
> > >       space_available = virtio_transport_space_update(sk, skb);
> > >
> > >       /* Update CID in case it has changed after a transport reset event */
> > >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > > -             vsk->local_addr.svm_cid = dst.svm_cid;
> > > +             vsk->local_addr.svm_cid = dst->svm_cid;
> > >
> > >       if (space_available)
> > >               sk->sk_write_space(sk);
> > > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > >               break;
> > >       }
> > >
> > > +     return false;
> > > +}
> > > +
> > > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > > + * lock.
> > > + */
> > > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > +                            struct sk_buff *skb, struct net *net)
> > > +{
> > > +     struct virtio_transport_rx_pkt_ctx ctx;
> > > +     struct sockaddr_vm src, dst;
> > > +     struct sock *sk;
> > > +     bool free_pkt;
> > > +
> > > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > > +
> > > +     sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> > > +     if (!sk) {
> > > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > > +             goto free_pkt;
> > > +     }
> > > +
> > > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > > +             goto free_pkt;
> > > +     }
> > > +
> > > +     lock_sock(sk);
> > > +     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > > +             .net = net,
> > > +             .src = &src,
> > > +             .dst = &dst,
> > > +     };
> > > +     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >
> > At this point the socket lookup succeeded with src/dst/net, why not just
> > pass sk which already has all of them?
> >
> 
> If I understand this correctly, a successful lookup is not enough to
> recover all of this from sk. The lookup may fall back from the
> connected table to the bound
> table, so the packet source must still be validated under the socket
> lock; otherwise that check would become ineffective. The packet
> destination is also needed after
> a transport reset, and the RX namespace used for a reset reply is not
> necessarily sock_net(sk) in global mode. I’ll remove the context
> struct and pass src, dst, and
> net directly.

True that the lookup may fallback to the bound table, but this begs the
question, why bother with the bound table here? If a socket hasn't
landed in the connected table yet, then OP_RW is -EINVAL and we respond
with RST anyway... so I'd guess we shouldn't even be trying to batch for
those sockets.

For connected sockets, the sk has the destination (vsk->remote_addr)
needed by the reset. And yes, sock_net(sk) does not necessarily equal
the net ptr used for a reset reply in global mode, but we don't really
expect that for global mode in vsock, we only expect that
vsock_net_check_mode() rules are followed. In this case where
!net_eq(n0, n1), the RST reply will be routed correctly across
namespaces following global mode rules.

I could certainly be missing something and happy to be pointed to an
instance of sk being insufficient here. In general, I think its nice to
avoid new data structures if possible.

Best,
Bobby
