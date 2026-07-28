Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA943F4AC
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245514; cv=none; b=t+s9D+sqp5lR/BW9YTjtpe1N+F5HvLXfDgz72bdvTQcyKni0mLW7mBqYkT4KRMfEjuJhPP9fv0IF4K2ERsijicb/VLGonb7CZFIbu55bCAxrE9bw4U1wmFRQBxnCtjPUwZYW3AGJLqj7Tdc673f63JwkryfPS1YcxX0geUXifOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245514; c=relaxed/simple;
	bh=cjRBEYK0BHlkm5SM06tjEjn1zXseAD0gpuxZHmQ5//4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MkK1/nYC9lsAlJCZFOZWX/8CmXU4T94ShK38LD4Ao1Q6tU5qD5skFoKJtDJnRq8le6EM6TSSER2BWzoCZT8pekM5yLss7eCY+2C3bMMZm1qYWUMc+ShNLy29W35acaqNgo9KyPohqDYL0XkdAPSHvvN2nSH7UKeit9c75/3eeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSrZxp1a; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSrZxp1a"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80814edb536so50078817b3.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785245504; x=1785850304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+mWZyh0TSq1ET7+dcnWeB2pQu2sGsI0TV8FkbfiaGds=;
        b=nSrZxp1aUDqMTwliN+WK5aV/kXt5f70fIeKLrKWsh/GMUQu3qyDZpejFC/QoiQQAa7
         8M8J8qL1MfzmlOVYr2afID4Z37703Ji9b73wqLcqbDJMRlPTFLY4TVHuP9m3Eve/cQ7Q
         EFHNCWOPBpOt1Rj0fAFia383CWREbU0UVtC08Gge4ENaM4iVFIqCwzokDkQVbOrhqNI8
         sZ6ByXN3u7UCV28FOJbMO5FQrgG9YlvC13kql8UgSf+XBxJRj8+h6+byh5RwpgswNZ7u
         HNzzaTyrAmTMkjZW4vDraegcKVusqUQFHBioVfw9wSO7BGwZATRqKUxgGEE3DiDVO0/b
         OMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785245504; x=1785850304;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mWZyh0TSq1ET7+dcnWeB2pQu2sGsI0TV8FkbfiaGds=;
        b=ZAd5tfOO+htDvI5yXUEx4wlKyCGTQJhYJnnPrYZPkMWnNx7bDDT8NGyiuNx+4wVVyW
         hhKaEzSL2pJ8JD5g7H/n/GK79JWb8EA3XYcnS5NErWkz1ii6ADYJaE6FUzpu6AhT8DWt
         FTVBXxYsUxZ8dtGdjqM4hMnKcYz21aUGUCdW9GTC2lhuq4v8QibJyL3ZEUT+dEw39PA4
         howc457LDlT3zNqQtwHlOfPKRnCnwUgwAA44bheASpsX6x01bZ3r0gKq9FC5FHVudL76
         TDkPje+xiME+RBpISyjRY1mg0TtBrO47AL9uhyQBTK/rmu5Lw30O3IGat1gZQI1FXq0X
         JwfA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8RvdjsuV+ZPezd+OtAb+7LFbdRzsCYF0ktsz+oRQVOjNqPgCsKaWlaanmkwhTw2jT7OakBGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyffmeBE6241Gh1Z2dxXrBdPTSDVUcV0N22UMVk64WsjJrt0brK
	i3xTTEgRBYC68Yz8uhbwhqGPtsmsI9own22UBxgehLB4WMnxv9xAF5y8
X-Gm-Gg: AR+sD13gh22ex9rQFRDlbHHpuJ7TzqN6zTyeY5Buru393iGfwuo6IvH3ge7KVkI6J7N
	VaWQa1bNGf04fXVVRnA1QN9JD107lhkYwd7s8RpT1f5m5vjiTYiiYG++3UucA6lyOp6thmdmliX
	BJg7vXADhWpa0pu3xFRaz2u8JOyakj88OZ+jarw9D/qG5oRPnSl903ejrgI5nfE4X4dSad9Z/jl
	TYy/vDhyPAOLvIdVOkVdd/ymOybnUPQAtCEBsjekv7ymF5z//peQhdSbTpwdkLSMM4rHOD7JQAl
	7a0Wa2aHe9QYTNv4jZexwvok6KGzcep9S4cl7wQXQUgM/DflJ75Eomu1KVhust7yn44aQUkiPyW
	eD/9eQh7LwnHDdZiPei+22Lu8+Si4tB7ycW8kwZ5dQ7DnCCOxBUrHI6xtOpf4gKbD/zFM/f4Iky
	FqVrUQnFoOONftPywNZ+UBzRbK1TL/m5pr843rXV15oW4f86yhPg==
X-Received: by 2002:a05:690c:d06:b0:81f:6503:701a with SMTP id 00721157ae682-81f991e8564mr9231707b3.9.1785245504065;
        Tue, 28 Jul 2026 06:31:44 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6577004esm46896417b3.8.2026.07.28.06.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:31:42 -0700 (PDT)
Date: Tue, 28 Jul 2026 09:31:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zihan xi <zihanx@nebusec.ai>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Ren Wei <enjou1224z@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 vega@nebusec.ai
Message-ID: <willemdebruijn.kernel.37fb8a457aee2@gmail.com>
In-Reply-To: <CAANe3eSvdBrwNo7xzH677yPOr8Zm6dvdTF7nNAe_NrWxomy0GQ@mail.gmail.com>
References: <f1cd534481c2397a36850ad039dcbfd38c3233ce.1784551898.git.zihanx@nebusec.ai>
 <willemdebruijn.kernel.e559328910e@gmail.com>
 <CAANe3eSvdBrwNo7xzH677yPOr8Zm6dvdTF7nNAe_NrWxomy0GQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] packet: synchronize pressure clearing with
 ring reconfiguration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

zihan xi wrote:
> On Tue, Jul 28, 2026 at 7:44=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Ren Wei wrote:
> > > From: Zihan Xi <zihanx@nebusec.ai>
> > >
> > > packet_set_ring() updates the RX ring state under sk_receive_queue.=
lock,
> > > but publishes the tpacket receive mode through po->prot_hook.func a=
fter
> > > releasing that lock. packet_poll() and packet_recvmsg() can therefo=
re run
> > > the pressure clearing path after the ring has been cleared while st=
ill
> > > seeing tpacket_rcv, causing __packet_rcv_has_room() to dereference =
stale
> > > or NULL ring storage.
> > >
> > > Serialize pressure clearing with RX ring reconfiguration and update=
 the
> > > receive hook while holding the same queue lock when changing the RX=
 ring.
> > > Keep packet_poll() on the unlocked helper,
> >
> > Because it already holds the lock.
> >
> > > and let packet_recvmsg()
> > > take the queue lock only when PACKET_SOCK_PRESSURE is already set
> >
> > which is sufficient, because if the socket moves from tpacket_rcv to
> > packet_rcv, the socket is detached and a synchronize_net has passed,
> > so no new packets could arrive to set PACKET_SOCK_PRESSURE if it was
> > unset.
> >
> > > so the
> > > fix avoids an unconditional extra lock acquisition on the normal re=
cv
> > > path.
> > >
> > > Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Assisted-by: Codex:gpt-5.4
> > > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> > > ---
> > > changes in v2:
> > >   - only take sk_receive_queue.lock in packet_recvmsg() when
> > >     PACKET_SOCK_PRESSURE is already set
> > >   - keep packet_poll() on the unlocked helper under its existing qu=
eue lock
> > >   - v1 Link: https://lore.kernel.org/all/24f7311aed0c9ff06b8ea98264=
7b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn/
> > >
> > >  net/packet/af_packet.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > index 8e6f3a734ba0..0107e55de6ff 100644
> > > --- a/net/packet/af_packet.c
> > > +++ b/net/packet/af_packet.c
> > > @@ -1315,13 +1315,25 @@ static int packet_rcv_has_room(struct packe=
t_sock *po, struct sk_buff *skb)
> > >       return ret;
> > >  }
> > >
> > > -static void packet_rcv_try_clear_pressure(struct packet_sock *po)
> > > +static void __packet_rcv_try_clear_pressure(struct packet_sock *po=
)
> > >  {
> > >       if (packet_sock_flag(po, PACKET_SOCK_PRESSURE) &&
> > >           __packet_rcv_has_room(po, NULL) =3D=3D ROOM_NORMAL)
> > >               packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, false)=
;
> > >  }
> > >
> > > +static void packet_rcv_try_clear_pressure(struct packet_sock *po)
> > > +{
> > > +     struct sock *sk =3D &po->sk;
> > > +
> > > +     if (!packet_sock_flag(po, PACKET_SOCK_PRESSURE))
> > > +             return;
> > > +
> > > +     spin_lock_bh(&sk->sk_receive_queue.lock);
> > > +     __packet_rcv_try_clear_pressure(po);
> > > +     spin_unlock_bh(&sk->sk_receive_queue.lock);
> > > +}
> > > +
> > >  static void packet_sock_destruct(struct sock *sk)
> > >  {
> > >       skb_queue_purge(&sk->sk_error_queue);
> > > @@ -4304,7 +4316,7 @@ static __poll_t packet_poll(struct file *file=
, struct socket *sock,
> > >                       TP_STATUS_KERNEL))
> > >                       mask |=3D EPOLLIN | EPOLLRDNORM;
> > >       }
> > > -     packet_rcv_try_clear_pressure(po);
> > > +     __packet_rcv_try_clear_pressure(po);
> > >       spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >       spin_lock_bh(&sk->sk_write_queue.lock);
> > >       if (po->tx_ring.pg_vec) {
> > > @@ -4544,14 +4556,15 @@ static int packet_set_ring(struct sock *sk,=
 union tpacket_req_u *req_u,
> > >               rb->frame_max =3D (req->tp_frame_nr - 1);
> > >               rb->head =3D 0;
> > >               rb->frame_size =3D req->tp_frame_size;
> > > +             if (!tx_ring)
> > > +                     po->prot_hook.func =3D po->rx_ring.pg_vec ?
> > > +                                             tpacket_rcv : packet_=
rcv;
> >
> > Same question: why this new condition on !tx_ring here, that is
> > missing below. It looks benign to me, but especially for fixes only
> > make necessary changes.
> >
> > >               spin_unlock_bh(&rb_queue->lock);
> > >
> > >               swap(rb->pg_vec_order, order);
> > >               swap(rb->pg_vec_len, req->tp_block_nr);
> > >
> > >               rb->pg_vec_pages =3D req->tp_block_size/PAGE_SIZE;
> > > -             po->prot_hook.func =3D (po->rx_ring.pg_vec) ?
> > > -                                             tpacket_rcv : packet_=
rcv;
> > >               skb_queue_purge(rb_queue);
> > >               if (atomic_long_read(&po->mapped))
> > >                       pr_err("packet_mmap: vma is busy: %ld\n",
> > > --
> > > 2.43.0
> >
> >
> Hi Willem,
> =

> Thanks. Yes, that is the intended reasoning for the packet_recvmsg()
> fast path.
> =

> If PACKET_SOCK_PRESSURE is already clear when packet_recvmsg() reaches
> the pressure-clearing path, then after the RX hook switches away from
> tpacket_rcv the socket has already been detached and synchronize_net()
> has completed, so no new packet input can arrive and set the flag
> again. In that case skipping the extra lock acquisition is sufficient.

Thanks. Please add this context to the commit message. It's not
entirely obvious. Will be helpful next time someone does a git blame.

> For the !tx_ring condition: po->prot_hook.func is RX-side state, and
> this fix is meant to publish it under the same sk_receive_queue.lock
> domain that protects RX ring reconfiguration.
> =

> A TX ring reconfiguration does not change po->rx_ring.pg_vec, so it
> does not need to rewrite po->prot_hook.func. Keeping the assignment
> under !tx_ring avoids an unnecessary write on a TX-only path and keeps
> the moved publication strictly tied to the RX ring transition that
> actually needs serialization.

Still, this is a change that is not strictly required for the fix. It
may be relatively easy to reason that it has no unintentional side
effects. But it is even easier to do so by avoiding such unnecessary
changes altogether. It would not be the first NOOP that proves to not
be entirely NOOP. I suggest moving the original code as is, instead.
