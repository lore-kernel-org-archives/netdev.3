Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F51A6822
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251906; cv=none; b=gCs8lY1gxsuUOLIp2G86cy+AQO1c6Gp6vZmi/cSkddoqMvqf8mp/jhRHjnFGMDTlMnJHAAjW5S1r55Lmb0ZdrtlymythhX7eirsxldU3cyxT1F5TheOtGxYVi6wb29wJcHiXqg1k0MCUux4PczfgDDx6wjA4O+QTEfQTvQyKN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251906; c=relaxed/simple;
	bh=yKCqKsiSuSFj1x70RgwoIK4Wiot4BSjCJPoY+pqsf2M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QVKVdSRahE4L/994dPcHtmt+1vb55JlqBGkYZVJTKp5aOVRnAq7vQ1tHnElMU5wr/h8BWM0+YRiFI7m96MPqKLx63jMxORHOv10T9fCfCeI3wwcoJy1/hhbT0KDxvTufpfFFBMXAfoigbaQ/k2BiSZt10e7TX9uNyuXMchQiRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrZVQiC1; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrZVQiC1"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81e86df8987so49599697b3.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785251903; x=1785856703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CLpOWH7GTS7NCFz/hO8LkdLrPSWhyKCNToq1mREBO9E=;
        b=DrZVQiC14sLXYNRG0bwICAIRrWfhxCCmVt59uDrYq5uySYx84S0+Rqa54lkO6LJ50j
         6DjByS9b25QrsLRMikWg8BrNJdSNq+c7OBbSFuljlbe/SUqt+YO1Sj46AewKhZcgk132
         pwJoJ32SPMEKPk3IV/ZssaNJsZW0ReAuUaIgwWJeUz+glPLjoQHD/vHtuwx5Vxe1rDNC
         LixAruATMDRVgRbP9St5Tm4SSstCctflslZux1HfWzdKumPnA5CRlit8qaEMVneigGgh
         TF8j70w3R0X+49i0wiD35o9n9/XLQpFfRolGQ4L9GvS6Y2ZrkjOc4ofnqYvL9LETTu0R
         gcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785251903; x=1785856703;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLpOWH7GTS7NCFz/hO8LkdLrPSWhyKCNToq1mREBO9E=;
        b=mKvcfcjGLI1oiEuJ+nylcV6tmwU4js5cD7zwyvxWiX8pLl4x3HKe0bIlM3i+j53miD
         pJxCPR9rXFZU0VkwhLrDvKg2ymSHgRaogPG4t8Rx2wowccULsyqAEX9BD8vwohxBsYiB
         +2xuNQ4h0ZB0IEe3bXPaSSrYHyty0qmXW0ukZmvzJwlNzMagJ+yGGhQ8yub5j/JTG0su
         DCiFgw2+WVvVGCxuejtWsElROcKMJjIG3E19MH+/R2O/YYXvwUZfpcAYBy0W8mxMb3d9
         DfUfAZUY/INNxrcEijmJqjIiS0Lub8PP5aIXX7oSrpSsvUGIgQEzgHZpiArZslFT7EC8
         pxFA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1QXXmYVMe3yHPYvGrJUeVlJVjU6dtj+meqhn8+QrkJMwBqj8BpCPQT5I7idDfctdjsufVFPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2arUBCVL1VdCLALSmCpeGH03CAratQGnFfXugA1e05sqMjRM
	X0JBr0tCMVQGmdJhLaNzvstXtGeAQgXXJLz9DxofoyLeRjo3s1Iikgpu
X-Gm-Gg: AR+sD13J69t5o+xzS2userPaJZw/iUEyjFgyzN/oYfL8enQYj/yq0LaZMqL8e7hTrRk
	DlJy9GyCWPdKvRmaCOW5vu4Ej2vim5pYuA7JRN/yqyEFSeqEdkrtzAGd2hWfNuIB+rxVBozVyG3
	DINewTo9luXouKeF5k4Eh/lfW1uMVvPF2rQhgCWbeTyHAFQY4UBl//d0c+MWO/pF/UvIFvt3X1X
	n99ZdPOYBkRn19wQMnBBKNh1y2EGQ7kn2MtayiQTUqox2DC7pZaymfj/yX0njlyt9yrlH5olw6f
	b0Vteg7yuO3zkvqYyet/p30WqN7uFx7qeee7zo/xhypnEPbFLqM4degX/EkiXadQjlxrbgL9B5Z
	ZeEr2TcTOTVpU9bL9bmFyROHuAu8sRtkG8No5cR31TMUDfM9W1W2lwlbB7rwoGiPVfgbb9WNxcv
	/VHUh7yDlfRUTVE7Zqq9cEC/Ep5T9gkWNRK5LMw4ZTKSRQ/qq8Yg==
X-Received: by 2002:a05:690c:6f10:b0:81d:6af3:b9cd with SMTP id 00721157ae682-81f99364371mr11834227b3.40.1785251903357;
        Tue, 28 Jul 2026 08:18:23 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa27568a5sm1260737b3.7.2026.07.28.08.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:18:22 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:18:21 -0400
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
Message-ID: <willemdebruijn.kernel.37df21eabf6b8@gmail.com>
In-Reply-To: <CAANe3eRGYdDWvYK42WHdDzt80Z3G7gt-21C7dep+LNGKJR3Auw@mail.gmail.com>
References: <f1cd534481c2397a36850ad039dcbfd38c3233ce.1784551898.git.zihanx@nebusec.ai>
 <willemdebruijn.kernel.e559328910e@gmail.com>
 <CAANe3eSvdBrwNo7xzH677yPOr8Zm6dvdTF7nNAe_NrWxomy0GQ@mail.gmail.com>
 <willemdebruijn.kernel.37fb8a457aee2@gmail.com>
 <CAANe3eRGYdDWvYK42WHdDzt80Z3G7gt-21C7dep+LNGKJR3Auw@mail.gmail.com>
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
> On Tue, Jul 28, 2026 at 9:31=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > zihan xi wrote:
> > > On Tue, Jul 28, 2026 at 7:44=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Ren Wei wrote:
> > > > > From: Zihan Xi <zihanx@nebusec.ai>
> > > > >
> > > > > packet_set_ring() updates the RX ring state under sk_receive_qu=
eue.lock,
> > > > > but publishes the tpacket receive mode through po->prot_hook.fu=
nc after
> > > > > releasing that lock. packet_poll() and packet_recvmsg() can the=
refore run
> > > > > the pressure clearing path after the ring has been cleared whil=
e still
> > > > > seeing tpacket_rcv, causing __packet_rcv_has_room() to derefere=
nce stale
> > > > > or NULL ring storage.
> > > > >
> > > > > Serialize pressure clearing with RX ring reconfiguration and up=
date the
> > > > > receive hook while holding the same queue lock when changing th=
e RX ring.
> > > > > Keep packet_poll() on the unlocked helper,
> > > >
> > > > Because it already holds the lock.
> > > >
> > > > > and let packet_recvmsg()
> > > > > take the queue lock only when PACKET_SOCK_PRESSURE is already s=
et
> > > >
> > > > which is sufficient, because if the socket moves from tpacket_rcv=
 to
> > > > packet_rcv, the socket is detached and a synchronize_net has pass=
ed,
> > > > so no new packets could arrive to set PACKET_SOCK_PRESSURE if it =
was
> > > > unset.
> > > >
> > > > > so the
> > > > > fix avoids an unconditional extra lock acquisition on the norma=
l recv
> > > > > path.
> > > > >
> > > > > Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidanc=
e")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > Assisted-by: Codex:gpt-5.4
> > > > > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > > > > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> > > > > ---
> > > > > changes in v2:
> > > > >   - only take sk_receive_queue.lock in packet_recvmsg() when
> > > > >     PACKET_SOCK_PRESSURE is already set
> > > > >   - keep packet_poll() on the unlocked helper under its existin=
g queue lock
> > > > >   - v1 Link: https://lore.kernel.org/all/24f7311aed0c9ff06b8ea9=
82647b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn/
> > > > >
> > > > >  net/packet/af_packet.c | 21 +++++++++++++++++----
> > > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > > > index 8e6f3a734ba0..0107e55de6ff 100644
> > > > > --- a/net/packet/af_packet.c
> > > > > +++ b/net/packet/af_packet.c
> > > > > @@ -1315,13 +1315,25 @@ static int packet_rcv_has_room(struct p=
acket_sock *po, struct sk_buff *skb)
> > > > >       return ret;
> > > > >  }
> > > > >
> > > > > -static void packet_rcv_try_clear_pressure(struct packet_sock *=
po)
> > > > > +static void __packet_rcv_try_clear_pressure(struct packet_sock=
 *po)
> > > > >  {
> > > > >       if (packet_sock_flag(po, PACKET_SOCK_PRESSURE) &&
> > > > >           __packet_rcv_has_room(po, NULL) =3D=3D ROOM_NORMAL)
> > > > >               packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, fa=
lse);
> > > > >  }
> > > > >
> > > > > +static void packet_rcv_try_clear_pressure(struct packet_sock *=
po)
> > > > > +{
> > > > > +     struct sock *sk =3D &po->sk;
> > > > > +
> > > > > +     if (!packet_sock_flag(po, PACKET_SOCK_PRESSURE))
> > > > > +             return;
> > > > > +
> > > > > +     spin_lock_bh(&sk->sk_receive_queue.lock);
> > > > > +     __packet_rcv_try_clear_pressure(po);
> > > > > +     spin_unlock_bh(&sk->sk_receive_queue.lock);
> > > > > +}
> > > > > +
> > > > >  static void packet_sock_destruct(struct sock *sk)
> > > > >  {
> > > > >       skb_queue_purge(&sk->sk_error_queue);
> > > > > @@ -4304,7 +4316,7 @@ static __poll_t packet_poll(struct file *=
file, struct socket *sock,
> > > > >                       TP_STATUS_KERNEL))
> > > > >                       mask |=3D EPOLLIN | EPOLLRDNORM;
> > > > >       }
> > > > > -     packet_rcv_try_clear_pressure(po);
> > > > > +     __packet_rcv_try_clear_pressure(po);
> > > > >       spin_unlock_bh(&sk->sk_receive_queue.lock);
> > > > >       spin_lock_bh(&sk->sk_write_queue.lock);
> > > > >       if (po->tx_ring.pg_vec) {
> > > > > @@ -4544,14 +4556,15 @@ static int packet_set_ring(struct sock =
*sk, union tpacket_req_u *req_u,
> > > > >               rb->frame_max =3D (req->tp_frame_nr - 1);
> > > > >               rb->head =3D 0;
> > > > >               rb->frame_size =3D req->tp_frame_size;
> > > > > +             if (!tx_ring)
> > > > > +                     po->prot_hook.func =3D po->rx_ring.pg_vec=
 ?
> > > > > +                                             tpacket_rcv : pac=
ket_rcv;
> > > >
> > > > Same question: why this new condition on !tx_ring here, that is
> > > > missing below. It looks benign to me, but especially for fixes on=
ly
> > > > make necessary changes.
> > > >
> > > > >               spin_unlock_bh(&rb_queue->lock);
> > > > >
> > > > >               swap(rb->pg_vec_order, order);
> > > > >               swap(rb->pg_vec_len, req->tp_block_nr);
> > > > >
> > > > >               rb->pg_vec_pages =3D req->tp_block_size/PAGE_SIZE=
;
> > > > > -             po->prot_hook.func =3D (po->rx_ring.pg_vec) ?
> > > > > -                                             tpacket_rcv : pac=
ket_rcv;
> > > > >               skb_queue_purge(rb_queue);
> > > > >               if (atomic_long_read(&po->mapped))
> > > > >                       pr_err("packet_mmap: vma is busy: %ld\n",=

> > > > > --
> > > > > 2.43.0
> > > >
> > > >
> > > Hi Willem,
> > >
> > > Thanks. Yes, that is the intended reasoning for the packet_recvmsg(=
)
> > > fast path.
> > >
> > > If PACKET_SOCK_PRESSURE is already clear when packet_recvmsg() reac=
hes
> > > the pressure-clearing path, then after the RX hook switches away fr=
om
> > > tpacket_rcv the socket has already been detached and synchronize_ne=
t()
> > > has completed, so no new packet input can arrive and set the flag
> > > again. In that case skipping the extra lock acquisition is sufficie=
nt.
> >
> > Thanks. Please add this context to the commit message. It's not
> > entirely obvious. Will be helpful next time someone does a git blame.=

> >
> > > For the !tx_ring condition: po->prot_hook.func is RX-side state, an=
d
> > > this fix is meant to publish it under the same sk_receive_queue.loc=
k
> > > domain that protects RX ring reconfiguration.
> > >
> > > A TX ring reconfiguration does not change po->rx_ring.pg_vec, so it=

> > > does not need to rewrite po->prot_hook.func. Keeping the assignment=

> > > under !tx_ring avoids an unnecessary write on a TX-only path and ke=
eps
> > > the moved publication strictly tied to the RX ring transition that
> > > actually needs serialization.
> >
> > Still, this is a change that is not strictly required for the fix. It=

> > may be relatively easy to reason that it has no unintentional side
> > effects. But it is even easier to do so by avoiding such unnecessary
> > changes altogether. It would not be the first NOOP that proves to not=

> > be entirely NOOP. I suggest moving the original code as is, instead.
> =

> Thanks, agreed.
> =

> I'll make this change in v3: keep the receive hook assignment otherwise=

> unchanged and only move the existing assignment into the
> sk_receive_queue.lock section. That avoids the extra !tx_ring behavior
> change while still keeping the hook publication serialized with the rin=
g
> state update.
> =

> I'll also add the packet_recvmsg() fast-path reasoning to the v3 commit=

> message.

Great, thanks.

