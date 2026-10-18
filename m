Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91935F19D
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299531; cv=pass; b=hd/K1UYX/jAjIoVjfl3fzChc3y7wdNwte32av/+N3rifSsrM+YBS2A/xaHAXwBlIhQO3aop9OpJ3iPfnvzuJw2eEQHZh+VYxl9w3nmhJu87yXx5/6IA5mhnYkoBsk8A4LI2MpPYaSLsOnAzeTV+w9jRAd+OwNv5c10p6/zt1wuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299531; c=relaxed/simple;
	bh=2jacn7S1Q9FlxeVvnvAIlfCi8jr+ktJM+dSbhY55nxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFqKqVY9hLgvZBDdhQzsauSL3W/5QkVDtGXz7kA5852XDllQVmtdcSQp4tX1wv3WzsPLW4c7PvB0DVcuwyhem/E/sEsqpsgKjF4AFo4A2CWI1Ri7iy7A5GEIPEtLCPhIWAG51RFTKDxr1iUeStMtBo1koliNnvdLG8o9Lk6A2vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzCgfCFm; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzCgfCFm"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91b834592afso13038426d6.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 21:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792299527; cv=none;
        d=google.com; s=arc-20260327;
        b=EflYRe9BJ0vNyGMmt9yG7y8KDxXGMoteo7BycBNDyIOljyWEzA0r8YhQ7UfetbtpAQ
         R5hElAvqn3bLIQTqU/r2qaZIwJvVarvvsdwGBrBwxzLntnLFmRxEqhtP57pnze0OZ5sk
         t5Hggruf5IxoIlidTg+RYSAGBUWgGcd5SVfyB++PCn/Vw7G79fTx31dT3FSl/X4hns0J
         1mPl1nKIo0CQK5D697YH23TP8kmq6LaDDis4PdNuXEx0+MybGe//xABbdQOwzUNNqKSX
         BatbQqvJydRXp94JsQkjz1FaZJO1RzIePiwcv786A4k1fdM96+kFCrqpAEvqqU07M5np
         rz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVpEQObwWOIqtaAcnO44zwnUu1XsD27+z0cFMp5vI8I=;
        fh=GDwYtpHjpNMDjiEdlnXYuW6YcPAoeKfwxvkDAkMy2N4=;
        b=FSRreoHhG4L9MWQECn/Nl/v1qxV3hUBdXqfbcWUYSdSuZI7EQYslqjrUSfo1+LaE1r
         sceSNVkc4wRXjnfI8ES7p+NppDVH/vDTM8kJT9v/ohzva9iQ2WKhKrE7MgeQJvc03dBy
         /oj52yuwn//65Umnt1GB+sa5RAQFEHY7KpyoH3ZI5XuOWLLnkCyz75pLy/2+IQ1LwVCO
         dAI3t2TDK7UNIESFNr6hbl7Assi7ff2aqAFrZVHE3tSZSiAtclC3k9LsUPVIbI17c0SJ
         N57CsTcVkBx5nj6Ehrjx0+3kgDnzoIAS40JmVIsjFieh3UigdKjm+ZO00yhDfUFjQ1yC
         clgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792299527; x=1792904327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SVpEQObwWOIqtaAcnO44zwnUu1XsD27+z0cFMp5vI8I=;
        b=AzCgfCFm9UJYnz3v7eaBujQsLz07MMN7oM0PDtsH02lGhb9MCpALQ9n/ZqNeLSyz73
         WhXPZkKBTuT/mxowQSlfMnXoZJOSlbvOJy8Yui89PYqILtdCxKOe9gGz5/ICGhuVhpGL
         +tc22ykRHPrM8E19o7GHz5p3X549sWfp5fLTI2FXeTi8f44/+aQNTiJCmUHG2FdVagpF
         OMq3LUAQs8XPcDOVkmN6kylIA0pvBsG/n5jgnn8YmxO7PFlzG5H++zq3Cb2jHzFhkguG
         x7u3DtgDrfzxbfZx1xua7iezWr/OtFyFIsst7upMmTimQEfzrKbueZa2NpWmhCcvPxV4
         iecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299527; x=1792904327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVpEQObwWOIqtaAcnO44zwnUu1XsD27+z0cFMp5vI8I=;
        b=yfTxv5hS97MGN3aST8W/XF0rN3lYA2/omTdSZDdJOh77Qtlx4nx4rVbNUATP6U701V
         klG1Rn09UI4wHke1A6wFb0T0HZKo4RkwfCKqQ2Kgx2YqzGYak7olJMOwv8eRqRyP5gLR
         qaIkGSonhYFGXnCJ7tRUuAWat76xHj8XaqvVt2Z0QuZ0VOlga2FE+1lEBr7rtgpez6yE
         Y1+d7yYUZ0fEPZSKMGe5rLg2QXy9SPB4lfSwjrRHYCiGD3nXym5LftD56HGN6ufOsm5M
         lWkHzRSfrzOPaGiCjTszZ23V6yd6F1wew1YEnKmqkeKYDMcwEmdeFi97xzGoKVhAHVEe
         /VLw==
X-Forwarded-Encrypted: i=1; AKwUvBwTBqOTd9pk5rpipoGix5egpCNFYGQK6WUhJnEYPZC7ynf+W+mRYqAIkQiCYITQ8sXv9ml5A2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYE1Z8dwXQ8MhKO4/PrNkCXs3ZcjjD7R4Mv9gJTSh5xvTba0bb
	3GBYhJmIFOmfO0YDPdrMZEPop2rYIcixCBMztyFUBy74//bRwLPhJ0QOhJasZ6Rq6HK83JMRVFg
	/gG1Qq9vhrKHIrWbapdbXI4C5M0kdk2c=
X-Gm-Gg: AYBFou32GVmOT+ut+u3DMwGJgsNxNeTLHmuA2zm4ZPDB1EAlBgR6t5bod46oi1poH56
	esoLxY1oTx0RnR6b1VmiBuzt1IXWYLJjrDxbrK6i+cpdpHZlKBfQKCZOB20RqTVqrxIugsD4UNn
	u5Nq6WIvmKeASbHy9JHnOEbjyRhCh6+VC35fBYKVtlmXN3P71DZfhS31hOnv7UiIBi517505fFh
	A+4eyfMZyVLE+kJKvvF249i2bngwDpxl51YtGtLuYYQDRerxrQ+nAI4n6C/P1H8zlX2ICY/Y4JI
	GZngyl1ip328XXYtSPX6TiT74XkX0i8S1o9xeUxUAfRGbqFNBJjMrus=
X-Received: by 2002:a05:620a:171e:b0:93f:5ac:14a0 with SMTP id
 af79cd13be357-93f29de3496mr751682285a.67.1792299526279; Sat, 17 Oct 2026
 21:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-4-physicalmtea@gmail.com> <atIvkN7GJTpsczu8@devvm29614.prn0.facebook.com>
In-Reply-To: <atIvkN7GJTpsczu8@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 18 Oct 2026 12:58:09 +0800
X-Gm-Features: AclHuK9AelIjvjLZl8EdKC4WfogWCvECErnvcMt1QyfPdt0mduLoNaQolEZS0YM
Message-ID: <CAJwVaMK-KYZyOkYyuH-CnPG=urE53hGXexVn_ezd6icdKFJ=-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] vsock/virtio: coalesce RX write-space
 notifications in lock batches
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Wed, Oct 14, 2026 at 07:56:39PM +0800, Jia Jia wrote:
> > Each received packet updates peer credit and may call sk_write_space().
> > A writer cannot use that credit until the batch releases the socket loc=
k,
> > so one notification at batch finish is sufficient.
> >
> > Save the initial sk_write_space callback when the AF_VSOCK socket is
> > created and require it to remain installed for batching. This lets the
> > transport module deliver the deferred notification without referring to
> > the unexported default callback. Sockets with replaced callbacks retain
> > their per-packet behavior.
> >
> > Record the batch socket before processing its first packet so a batch t=
hat
> > ends on that packet cannot lose the pending notification.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  1 +
> >  include/net/af_vsock.h                  |  5 +++
> >  net/vmw_vsock/af_vsock.c                |  1 +
> >  net/vmw_vsock/virtio_transport_common.c | 53 +++++++++++++++++--------
> >  4 files changed, 44 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.=
h
> > index 26dde6909c4ed..bf077ee0ded88 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -287,6 +287,7 @@ struct virtio_transport_rx_batch {
> >       struct sock *sk;
> >       unsigned int pkts;
> >       size_t bytes;
> > +     bool write_space_pending;
> >  };
> >
> >  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > index 5549298c1ec6b..9a40960d10cbe 100644
> > --- a/include/net/af_vsock.h
> > +++ b/include/net/af_vsock.h
> > @@ -63,6 +63,11 @@ struct vsock_sock {
> >       u32 peer_shutdown;
> >       bool sent_request;
> >       bool ignore_connecting_rst;
> > +     /*
> > +      * Initial callback, used to identify replacements and deliver de=
ferred
> > +      * write-space notifications.
> > +      */
> > +     void (*default_write_space)(struct sock *sk);
> >
> >       /* Protected by lock_sock(sk) */
> >       u64 buffer_size;
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 44cee74519555..fe7f49da6c4bc 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> >               sk->sk_type =3D type;
> >
> >       vsk =3D vsock_sk(sk);
> > +     vsk->default_write_space =3D sk->sk_write_space;
> >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY=
);
> >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_AN=
Y);
> >
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
> > index ff74e805527a5..f4b5f0230493e 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1820,6 +1820,7 @@ virtio_transport_recv_pkt_batchable(struct virtio=
_transport *t,
> >       return sk->sk_state =3D=3D TCP_ESTABLISHED &&
> >              sk->sk_type =3D=3D SOCK_STREAM &&
> >              READ_ONCE(sk->sk_prot) =3D=3D sk->sk_prot_creator &&
> > +            READ_ONCE(sk->sk_write_space) =3D=3D vsk->default_write_sp=
ace &&
> >              !sock_flag(sk, SOCK_DONE) &&
> >              vsk->transport =3D=3D &t->transport &&
> >              vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
> > @@ -1828,13 +1829,15 @@ virtio_transport_recv_pkt_batchable(struct virt=
io_transport *t,
> >
> >  /*
> >   * The caller holds sk's socket lock.  Set @batchable if the socket ca=
n remain
> > - * locked for another ordinary STREAM/RW packet.  Return true if the c=
aller
> > - * must free @skb.
> > + * locked for another ordinary STREAM/RW packet.  When @batch is non-N=
ULL,
> > + * record a default write-space notification for batch finish instead =
of
> > + * delivering it immediately.  Return true if the caller must free @sk=
b.
> >   */
> >  static bool
> >  virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> >                                struct sk_buff *skb, struct sock *sk,
> > -                              bool *batchable)
> > +                              bool *batchable,
> > +                              struct virtio_transport_rx_batch *batch)
> >  {
> >       struct virtio_vsock_hdr *hdr =3D virtio_vsock_hdr(skb);
> >       struct sockaddr_vm src;
> > @@ -1863,8 +1866,12 @@ virtio_transport_recv_pkt_locked(struct virtio_t=
ransport *t,
> >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> >               vsk->local_addr.svm_cid =3D le64_to_cpu(hdr->dst_cid);
> >
> > -     if (space_available)
> > -             sk->sk_write_space(sk);
> > +     if (space_available) {
> > +             if (batch)
> > +                     batch->write_space_pending =3D true;
> > +             else
> > +                     sk->sk_write_space(sk);
> > +     }
> >
> >       switch (sk->sk_state) {
> >       case TCP_LISTEN:
> > @@ -1931,7 +1938,7 @@ void virtio_transport_recv_pkt(struct virtio_tran=
sport *t,
> >       }
> >
> >       lock_sock(sk);
> > -     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
> > +     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, NULL, N=
ULL);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> > @@ -1949,22 +1956,27 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> >
> >  /*
> >   * Finish the RX batch.
> > - * For a non-empty batch, the caller must hold the socket lock acquire=
d with
> > - * lock_sock(). This function releases the lock and the batch's lookup
> > - * reference.
> > + * For a non-empty batch, the caller holds the socket lock acquired wi=
th
> > + * lock_sock(). Deliver any deferred write-space notification while th=
e lock
> > + * is held, then release the lock and the batch's lookup reference.
> >   * An empty batch is a no-op.
> >   */
> >  void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch=
 *batch)
> >  {
> > +     bool write_space_pending =3D batch->write_space_pending;
> >       struct sock *sk =3D batch->sk;
> >
> >       batch->sk =3D NULL;
> >       batch->pkts =3D 0;
> >       batch->bytes =3D 0;
> > +     batch->write_space_pending =3D false;
> >
> >       if (!sk)
> >               return;
> >
> > +     if (write_space_pending)
> > +             vsock_sk(sk)->default_write_space(sk);
>
> Any reason not to just do READ_ONCE(sk->sk_write_space)(sk) instead of
> storing this for later? If we setup the socket in a sockmap program
> mid-batch, doesn't this and sk_data_ready (from the next patch) go
> stale?
>

Thanks for the review, I tried loading the current callback in an
earlier version, but READ_ONCE() does not synchronize the load and
invocation with sockmap attach or teardown.
For example, it could load sk_psock_write_space, then invoke it after
the psock has been removed, in which case the wrapper would no longer
forward the
native wakeup. The sk_data_ready case is more serious: the stale
sockmap wrapper can dequeue a native skb and then drop it when its
actor finds no psock.

There is also an attach-side semantic issue: one deferred data-ready
notification may represent several native skbs, while one invocation
of the sockmap
callback consumes only one skb. The saved callbacks are therefore
intentional and represent the native path at packet admission, rather
than the callback
installed at batch finish. A packet boundary that observes a callback,
protocol, or psock change terminates the batch. I=E2=80=99ll document this
admission-time
rule more clearly and add sockmap attach/detach stress coverage.


> > +
> >       release_sock(sk);
> >       sock_put(sk);
> >  }
> > @@ -2019,7 +2031,8 @@ void virtio_transport_recv_pkt_batch(struct virti=
o_transport *t,
> >                       }
> >
> >                       free_pkt =3D virtio_transport_recv_pkt_locked(t, =
skb, sk,
> > -                                                                 &batc=
hable);
> > +                                                                 &batc=
hable,
> > +                                                                 batch=
);
> >                       if (!batchable)
> >                               virtio_transport_rx_batch_finish(batch);
> >                       if (free_pkt)
> > @@ -2059,23 +2072,31 @@ void virtio_transport_recv_pkt_batch(struct vir=
tio_transport *t,
> >
> >       lock_sock(sk);
> >       /*
> > -      * Sockmap removal restores the native protocol under sk_callback=
_lock.
> > -      * Serialize this initial eligibility check with that update.
> > +      * Sockmap teardown restores callbacks under sk_callback_lock. Ke=
ep the
> > +      * initial eligibility check consistent with that update.
>
> Why reword here?
>
> >        */
> >       read_lock_bh(&sk->sk_callback_lock);
> >       start_batch =3D virtio_transport_recv_pkt_batchable(t, sk);
> >       read_unlock_bh(&sk->sk_callback_lock);
> >
> > +     if (start_batch)
> > +             batch->sk =3D sk;
> > +
> >       free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk,
> > -                                                 start_batch ? &batcha=
ble : NULL);
> > +                                                 start_batch ? &batcha=
ble : NULL,
> > +                                                 start_batch ? batch :=
 NULL);
> >       if (start_batch && batchable) {
> >               /* Keep the lookup reference until the batch is released.=
 */
> > -             batch->sk =3D sk;
>
> Seems like `batch->sk =3D sk` is moving around between patches?
>
> I don't know, feels like if the batching patch introduces
> sk_write_space/sk_data_ready bugs, then that patch should probably
> contain these patches too. Should minimize churn too?
>
>

My intention was to structure the series in two stages. Patches 1 and
2 form a complete batching change while retaining the existing
per-packet
notification behavior. Patches 3 and 4 then add notification
coalescing and after-unlock delivery. Therefore, Patch 3 is not a
correctness fix for Patch
2; the series through Patch 2 remains functional on its own.

The batch->sk assignment moves because Patch 3 introduces pending
notification state. Once the first packet can record a deferred
notification, the batch
must record its socket before processing that packet, even if the
packet subsequently ends the batch.

I agree, however, that this split causes avoidable churn.


> >               return;
> >       }
> >
> > -     release_sock(sk);
> > -     sock_put(sk);
> > +     if (start_batch) {
> > +             virtio_transport_rx_batch_finish(batch);
> > +     } else {
> > +             release_sock(sk);
> > +             sock_put(sk);
> > +     }
> > +
> >       if (free_pkt)
> >               kfree_skb(skb);
> >  }
> > --
> > 2.53.0
> >
>
> Best,
> Bobby
