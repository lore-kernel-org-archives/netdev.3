Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19B311958
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247242; cv=pass; b=WTkJaZ8l2XV/6vB7YmKFRUqhIoWljcFc8kdw/jUkSSoaVuilkPm6ySW6f3TtpJIQNanmupi2bS//v8XdFY+MeWkCgdvMAR7QfuOqBOFqMW7X2cFObs+xEZbhTFaMisekHjTnovi+9YprK7FyuYYVja2WPHHyYkMN7ovzTYYQzRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247242; c=relaxed/simple;
	bh=ChgiT1k7vXUsuBZ5A9piSRbX883DVr/Q3llS7dDHJu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7Uhqs2O6y4meRqu1djkQcFHYWvm9gYE/vkBFI4kd/rN+J1XkinGeLEPtGWBKJvTRSxWAVg5ha6kSjZoYKayZgUxc728H+cAaATuaqXqBBDj9+On1o4LXVRC+4gcyixDwQ2GHskod413E07xPgG3MIbZmxRR1bEEUGDKEaHSwdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=VCovFbX9; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="VCovFbX9"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so34310651fa.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 07:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785247239; cv=none;
        d=google.com; s=arc-20260327;
        b=JaP7viC0nEZy/7JOnkEslVpyM0KWBeBjijL8Gsqx2Jtx2r8xkIjcq34b4v9050G8P9
         N4jcfkAnZUkyC522hgVEtCnF7bfpxeo5EaIb4S21er52aDkVHFz+jvCzAAnG6ZxIdkqd
         HM5SDPIzLnYhKVUhQqjUpcPtMqdT1CNyzO0jASxchroQtp18CLliwiD2mkV285oWcYUo
         ydnWpuekwoTZwdQc2oXJ4U12LFPO8rBDsuwVS2dY+yR/Gtkip6SrAOCwJS44OtxLOjXR
         pj9mz0awQUWZkQ47RdgOs1aIARV40ocU22xRxaVLPDcjCisaeeSSBsGVOxmCCZanEYtq
         sCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nVIYE7CDf14YAilU7jBizGE3skXjniBjjgkhFkMhUJ4=;
        fh=0M3BKncbNA0B+eaohWWR/FYYe9KkjpanbwcPj43Rb/A=;
        b=OrW4/i7hhW0VK0gC2sF4THHtVP3VWBD6/s3gV+vDW4o65F0wzV51o2ku2QwPWdBTyy
         mAd/SD3a02X14vXXlja2bdsQ2OOsxJcsvKc4n+5ZlezlpCXpFdqWEc+qSNhz3GcTM1m7
         Y5inSSd3RMQMegzGeOoSjjJPwrkVscHPRDF0Lojz7arBcBkiOEjnAqAc1bGBbjJlXIgG
         8Ur4mtM/BZOVPivFuZVcT5Rs/q3Q59PxvzszTdKRTY9M6tABiv/tyvm5lIzKWg4dbHT1
         mAnDscu7pw2FUNv2HHAVn7lsqiFN9pDY7pthGoWdNowMcsxCa9xT69E8d7M/yAMy7U11
         4jXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785247239; x=1785852039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nVIYE7CDf14YAilU7jBizGE3skXjniBjjgkhFkMhUJ4=;
        b=VCovFbX9imxbu+2aL0jP93FVVpsWW4z4ePfPb+Wqfd5MgKjVtt7sCW9D1k8kbo3vSB
         e/zk64MN9CBN6t32q10KlUfMvISr/MT+p6xqF29G4gnw6UfdIjTuHgRkqxCmwv35adRR
         HI2R0FBExzBuubg+xRT2bBb6hFpI7bHRMMI++Sv2cm4NomCV/DubnyGyzu/NU7AJ0ERm
         M46iyRb/MX3uYWb+nSRJ3uzP8QItzjs995BISWb9d+Dn3MY5osRpmPd/vTI+G4g2IePn
         51zz3Oo0P2Jzw0qEwooA/FuNtD128zVcxQICUiAJHxKyQghzoDmBd6oN+xzXqdfYL3k0
         PNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247239; x=1785852039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVIYE7CDf14YAilU7jBizGE3skXjniBjjgkhFkMhUJ4=;
        b=ET5SKyKkvpxpB6oVpk5rafVeecezsizhtR6UtItK/ZGEiJ3lFc7g0N/DI/9HGKOQVZ
         yLUXn2KmheGURHvTVBNxHR2IQL7xVGsjLew1ow/QLKdxQV/8JXfCcQENmQEFhEwiXc+J
         9k/7Fz/svzTmGyGcj8tpd94VfyHDcjwYeJzyE1Sdj7tBN0ndIkbR9BcXkjHRKmH4+Rnc
         8P7UdOWkI2XDURFEQEjxO3aXosc0aocqT+hbfsdHwOEzOFEeenRvViXqLDcVZMsOAwxj
         BNHg740n0UinU5R7LIO+tz7gpGFMwyVSco/rfuqLdkPhfM7UQdutulyB/CECBvTLDVMc
         apJg==
X-Forwarded-Encrypted: i=1; AHgh+RqYavp9bs1MfbgmgC0E+XbGh5vOab1uZi8rcKw4vKJ+XDuu313dvsQWbZmEv04l64I0qRvska8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MYmjFqf9Yw+9HZAb9aE6DoSxtMywIjkjMD7KWTNJNLfOJ1RI
	/8uRBy37i6J9CZuz5HZlsobyM+KSJdP1QjX0iBJarFeOKWolhsDILK8wBWzvAkS3exAZHtKjDTu
	n43E2/fMcmnIs3KZntXuKSKRVnrDFjWd8W8FpCASewVHSJE3lz7qXXWFzljPPsdmB/kA=
X-Gm-Gg: AR+sD1370Uhc/tagrEnB6JrXD63IqpQ2U9t+W3zJcAxTMArFYIqQOE8vimFK24sTJ8K
	fCDowAZ+pr98MOjdRXE2djxsGcmIy72C2DOxNu+9pQIChKh8ADFXhoG8foC8z+LSpyuSGOqQ9ia
	D5iSm4AhmbI6PInhiWfNvFeir8lHZaVAJNSq9ZcdmDJlKSjcihyGkRg09G5rSKMxsSDsqjuWoR+
	FNNo3ABaqKA7LmHqnZMdVqxIsZECxnae9SOPfl5P3cmwAVS5COsn2X99j0N
X-Received: by 2002:a05:651c:3135:b0:39c:a06f:12ba with SMTP id
 38308e7fff4ca-39f51f36a06mr4623121fa.40.1785247238615; Tue, 28 Jul 2026
 07:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f1cd534481c2397a36850ad039dcbfd38c3233ce.1784551898.git.zihanx@nebusec.ai>
 <willemdebruijn.kernel.e559328910e@gmail.com> <CAANe3eSvdBrwNo7xzH677yPOr8Zm6dvdTF7nNAe_NrWxomy0GQ@mail.gmail.com>
 <willemdebruijn.kernel.37fb8a457aee2@gmail.com>
In-Reply-To: <willemdebruijn.kernel.37fb8a457aee2@gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 28 Jul 2026 22:00:24 +0800
X-Gm-Features: AUfX_mzm5Q5GLbkV_SSB07uUkjFw8_EytOmnR6xtcdg7HLz81aZZ-VFI0bNNvac
Message-ID: <CAANe3eRGYdDWvYK42WHdDzt80Z3G7gt-21C7dep+LNGKJR3Auw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] packet: synchronize pressure clearing with
 ring reconfiguration
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:31=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> zihan xi wrote:
> > On Tue, Jul 28, 2026 at 7:44=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Ren Wei wrote:
> > > > From: Zihan Xi <zihanx@nebusec.ai>
> > > >
> > > > packet_set_ring() updates the RX ring state under sk_receive_queue.=
lock,
> > > > but publishes the tpacket receive mode through po->prot_hook.func a=
fter
> > > > releasing that lock. packet_poll() and packet_recvmsg() can therefo=
re run
> > > > the pressure clearing path after the ring has been cleared while st=
ill
> > > > seeing tpacket_rcv, causing __packet_rcv_has_room() to dereference =
stale
> > > > or NULL ring storage.
> > > >
> > > > Serialize pressure clearing with RX ring reconfiguration and update=
 the
> > > > receive hook while holding the same queue lock when changing the RX=
 ring.
> > > > Keep packet_poll() on the unlocked helper,
> > >
> > > Because it already holds the lock.
> > >
> > > > and let packet_recvmsg()
> > > > take the queue lock only when PACKET_SOCK_PRESSURE is already set
> > >
> > > which is sufficient, because if the socket moves from tpacket_rcv to
> > > packet_rcv, the socket is detached and a synchronize_net has passed,
> > > so no new packets could arrive to set PACKET_SOCK_PRESSURE if it was
> > > unset.
> > >
> > > > so the
> > > > fix avoids an unconditional extra lock acquisition on the normal re=
cv
> > > > path.
> > > >
> > > > Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: Vega <vega@nebusec.ai>
> > > > Assisted-by: Codex:gpt-5.4
> > > > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > > > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> > > > ---
> > > > changes in v2:
> > > >   - only take sk_receive_queue.lock in packet_recvmsg() when
> > > >     PACKET_SOCK_PRESSURE is already set
> > > >   - keep packet_poll() on the unlocked helper under its existing qu=
eue lock
> > > >   - v1 Link: https://lore.kernel.org/all/24f7311aed0c9ff06b8ea98264=
7b82bf543ec369.1784454542.git.xizh2024@lzu.edu.cn/
> > > >
> > > >  net/packet/af_packet.c | 21 +++++++++++++++++----
> > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > > index 8e6f3a734ba0..0107e55de6ff 100644
> > > > --- a/net/packet/af_packet.c
> > > > +++ b/net/packet/af_packet.c
> > > > @@ -1315,13 +1315,25 @@ static int packet_rcv_has_room(struct packe=
t_sock *po, struct sk_buff *skb)
> > > >       return ret;
> > > >  }
> > > >
> > > > -static void packet_rcv_try_clear_pressure(struct packet_sock *po)
> > > > +static void __packet_rcv_try_clear_pressure(struct packet_sock *po=
)
> > > >  {
> > > >       if (packet_sock_flag(po, PACKET_SOCK_PRESSURE) &&
> > > >           __packet_rcv_has_room(po, NULL) =3D=3D ROOM_NORMAL)
> > > >               packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, false)=
;
> > > >  }
> > > >
> > > > +static void packet_rcv_try_clear_pressure(struct packet_sock *po)
> > > > +{
> > > > +     struct sock *sk =3D &po->sk;
> > > > +
> > > > +     if (!packet_sock_flag(po, PACKET_SOCK_PRESSURE))
> > > > +             return;
> > > > +
> > > > +     spin_lock_bh(&sk->sk_receive_queue.lock);
> > > > +     __packet_rcv_try_clear_pressure(po);
> > > > +     spin_unlock_bh(&sk->sk_receive_queue.lock);
> > > > +}
> > > > +
> > > >  static void packet_sock_destruct(struct sock *sk)
> > > >  {
> > > >       skb_queue_purge(&sk->sk_error_queue);
> > > > @@ -4304,7 +4316,7 @@ static __poll_t packet_poll(struct file *file=
, struct socket *sock,
> > > >                       TP_STATUS_KERNEL))
> > > >                       mask |=3D EPOLLIN | EPOLLRDNORM;
> > > >       }
> > > > -     packet_rcv_try_clear_pressure(po);
> > > > +     __packet_rcv_try_clear_pressure(po);
> > > >       spin_unlock_bh(&sk->sk_receive_queue.lock);
> > > >       spin_lock_bh(&sk->sk_write_queue.lock);
> > > >       if (po->tx_ring.pg_vec) {
> > > > @@ -4544,14 +4556,15 @@ static int packet_set_ring(struct sock *sk,=
 union tpacket_req_u *req_u,
> > > >               rb->frame_max =3D (req->tp_frame_nr - 1);
> > > >               rb->head =3D 0;
> > > >               rb->frame_size =3D req->tp_frame_size;
> > > > +             if (!tx_ring)
> > > > +                     po->prot_hook.func =3D po->rx_ring.pg_vec ?
> > > > +                                             tpacket_rcv : packet_=
rcv;
> > >
> > > Same question: why this new condition on !tx_ring here, that is
> > > missing below. It looks benign to me, but especially for fixes only
> > > make necessary changes.
> > >
> > > >               spin_unlock_bh(&rb_queue->lock);
> > > >
> > > >               swap(rb->pg_vec_order, order);
> > > >               swap(rb->pg_vec_len, req->tp_block_nr);
> > > >
> > > >               rb->pg_vec_pages =3D req->tp_block_size/PAGE_SIZE;
> > > > -             po->prot_hook.func =3D (po->rx_ring.pg_vec) ?
> > > > -                                             tpacket_rcv : packet_=
rcv;
> > > >               skb_queue_purge(rb_queue);
> > > >               if (atomic_long_read(&po->mapped))
> > > >                       pr_err("packet_mmap: vma is busy: %ld\n",
> > > > --
> > > > 2.43.0
> > >
> > >
> > Hi Willem,
> >
> > Thanks. Yes, that is the intended reasoning for the packet_recvmsg()
> > fast path.
> >
> > If PACKET_SOCK_PRESSURE is already clear when packet_recvmsg() reaches
> > the pressure-clearing path, then after the RX hook switches away from
> > tpacket_rcv the socket has already been detached and synchronize_net()
> > has completed, so no new packet input can arrive and set the flag
> > again. In that case skipping the extra lock acquisition is sufficient.
>
> Thanks. Please add this context to the commit message. It's not
> entirely obvious. Will be helpful next time someone does a git blame.
>
> > For the !tx_ring condition: po->prot_hook.func is RX-side state, and
> > this fix is meant to publish it under the same sk_receive_queue.lock
> > domain that protects RX ring reconfiguration.
> >
> > A TX ring reconfiguration does not change po->rx_ring.pg_vec, so it
> > does not need to rewrite po->prot_hook.func. Keeping the assignment
> > under !tx_ring avoids an unnecessary write on a TX-only path and keeps
> > the moved publication strictly tied to the RX ring transition that
> > actually needs serialization.
>
> Still, this is a change that is not strictly required for the fix. It
> may be relatively easy to reason that it has no unintentional side
> effects. But it is even easier to do so by avoiding such unnecessary
> changes altogether. It would not be the first NOOP that proves to not
> be entirely NOOP. I suggest moving the original code as is, instead.

Thanks, agreed.

I'll make this change in v3: keep the receive hook assignment otherwise
unchanged and only move the existing assignment into the
sk_receive_queue.lock section. That avoids the extra !tx_ring behavior
change while still keeping the hook publication serialized with the ring
state update.

I'll also add the packet_recvmsg() fast-path reasoning to the v3 commit
message.
