Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E4438024
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242830; cv=pass; b=YnwHq4Bu2BYt19xgj8Ib2mV6w/sUqWEaYhSB9ovDr7KYpfEwmuE2oz8G2QqufYMjxJAP34pK+ccI/c2hCroyF7h3txNdJie6NiaVTqW+QHuCScDmWqTf/QhIWal/ZmrCuYRLsfkwctZHc6S/mNlioCAxrhItGOmO7NSyWoxnwbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242830; c=relaxed/simple;
	bh=revAp/zaUKA0lfczjrpNCU4hZxAtuQMZlrUT+8Yfz+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeHotBvCk0FeyRLCADyQafweKhJO50SguWKVa3FQ9AFwvck1uk6flFHyRkuRmlUHpO/ZCw+ANICddSBMEVqFL7Nf3FMF+Q6NraL3ThYYmVVPG2y1l4ems/HxGJU5Rdb3JB0ZXhTXfzVKclWCkFBX2Q45E01pPfNBog1X60AwCr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=BHEL7ncP; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="BHEL7ncP"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so32550551fa.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785242827; cv=none;
        d=google.com; s=arc-20260327;
        b=G/FxFun5kFZ5OjaeyUhFexHSxtdhGsWQB9Hwbb5da/4zWRFJIZBk1BVWRthJmRkPqQ
         DtfTlVyLeSMHTGHOuYgOr57skGJXFB1Wyk+R2+aSOzXEGhyzoPL+CcRx4bW4iXZGT5go
         9iuLX7kA12lCQEQ8tU90b8qvZha47wykT0I/t6xDgUCzgvPCy5XmRjbzLeGkt5L7A21+
         X0Mo16i2WyCNI5L6k66covKQNBeED3DZ6ZXU1g/5LSt+skLCoDuuMB1D0nKbCug8C7B3
         xHpJM9LTE+kfWi4Uthkfg/DjiqS27cvePjEorTKj4MrQ3UtlXz3eE5VAIe76ZQtAeexz
         VMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hErmckKIR7WMONl+croSGExVx1CEOObyalnXGnC8qTI=;
        fh=JZ8UwWfzUMudJKV6qgRR/LOjKvJztVGhE/5ll9BBRPM=;
        b=Z0Ow02DWMfqOZzbxiDzovizxRR8X/tO5XA3QAjWFvbM3rCX43QU+I2yg/U7Xv56xZX
         RBUscEXWb7ivyHfXSqdGwTAq7SNRIR+ntqj8EyGAfRzSeYfGW4mSwDDWlEzUXvCHdCgv
         Xoqh3UMeUHUj6GGxpJMfHN0GsOAoXVPM+cJlCM6KOMG+VTWSFM5mXoR9dbtdf+1PYLKw
         6sWm0czlVVQ77ZHefdwo57/fU0Rb49b906eTrCHoAzJF399LHBQ6ogDq0S7xY8XYgm22
         oj2RO0hjXYU+gim99FAznLkoW6zwx/6b8pV3LVRjQZDmrc6h32xBAWfY3MG1CsVO116B
         mGxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785242827; x=1785847627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hErmckKIR7WMONl+croSGExVx1CEOObyalnXGnC8qTI=;
        b=BHEL7ncPYEjWENQwpM69NH3wctWTYhhI0tlbRFY8qjDIy8Vcwh9qJG8wl+bjbXt308
         jtAe/O19KX4J5oVD6RqUxDfbJgRxxYMHA96wJuMkkJ3omJB1ol9E+Xwi+nqWbhfh7ti/
         WwEkTVnQiVtutKKOQiWAOi1Hp3CXu6xqXvGwzLTAApjUcFHigSdVBv0/0vmwAwmwjCHr
         hGbcbbXOZAYeOQeUYQxq+AM6l6b4526wqMMMfJA1csWe5rtUxpLQXoToxU8KAx46gdVa
         IYr9ppuDkrFfkJsYAQWshnyMbZJMwZI5D8Pxkqf3Olk/wzu9HnaVTneZ065/0dvcj91V
         FUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785242827; x=1785847627;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hErmckKIR7WMONl+croSGExVx1CEOObyalnXGnC8qTI=;
        b=c6NBabc0Axy4uSmBqGMPXbyPXBwKQJ2KEkOry5RCX4l49l15WPLYPz5ldBFnaEuHKG
         ArbPpDbzdgQqj67Co1M6q+WcZ8EU/dHfkv+VhryvZ/VSW6M5EHBuyOdI/AEUPjwaFixB
         8v3rDucIa6zxwtSEHzOglnklYs7iLC3jocO7q3w9SzzNCXThvA/+XlXmbAO/7YrBfpu5
         uby2rsWPBP/oh4fzTO8rrciIzVEApCWW571qqmPbxZ9T+TnrEFpW+bd0J2B+6Y+YFNiG
         avp8xFK8R2OcrqTWMGONhK3GhIItZa7wytwhKsqmaTxk1R138usFA1lw7rUzGzD24uW5
         rtjw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7Zf90jv0eQiZPkP4SAeFeAFoEYmlo4337blE0/ov/15TGk4dhfUdBXe56MH8Z2lIdmBeN3RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysqgXG78pQjlq14N49+SKISBbBDELFLa7evxv3sTCws34Va7l9
	la/FetCQ889zkS6qSJp2d4PP5PPdYzK7HGQtWVo/hZ0z21aJ7a+wkIZwqpkbvwAx/ognCsgXYac
	nS31lSpDU5vFGgBd3l5Swhsr2YumduvwHYW+m96R1G3k=
X-Gm-Gg: AR+sD11DpZ017jU1u1Y07acoV4tIuTJThtHhYrfTYN359QZvfg6DVZQ4sHTdt5c3Ib0
	bUGYYpjTW/aqQKQi95vXt1DhkayrJ6SZ1vdyzHAOSA21EIO8iS1YhZPSVvQcMGb65eqWeWHumtR
	q/sjF+DRVDxafmGFO/HTvsO7iAVsyoWlfBN1OycUUSEJcUrNRrsjFY2sAxkO6tcZNQOEgvKaUEb
	cO/kQnYGOarPcrVBJ+Nxwu8c57MhSkLwSOBDJY7fFBeOxUhf3tBbnou21oZ
X-Received: by 2002:a2e:bcc7:0:b0:39c:7ef1:a640 with SMTP id
 38308e7fff4ca-39f51d07f8emr4351191fa.12.1785242826866; Tue, 28 Jul 2026
 05:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f1cd534481c2397a36850ad039dcbfd38c3233ce.1784551898.git.zihanx@nebusec.ai>
 <willemdebruijn.kernel.e559328910e@gmail.com>
In-Reply-To: <willemdebruijn.kernel.e559328910e@gmail.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 28 Jul 2026 20:46:52 +0800
X-Gm-Features: AUfX_mxwZCN6U5B4LHSpwidCaAQQ83R48uknrwyAafTYSa90Cx3oMGN4La0o3Kk
Message-ID: <CAANe3eSvdBrwNo7xzH677yPOr8Zm6dvdTF7nNAe_NrWxomy0GQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] packet: synchronize pressure clearing with
 ring reconfiguration
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 7:44=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Ren Wei wrote:
> > From: Zihan Xi <zihanx@nebusec.ai>
> >
> > packet_set_ring() updates the RX ring state under sk_receive_queue.lock=
,
> > but publishes the tpacket receive mode through po->prot_hook.func after
> > releasing that lock. packet_poll() and packet_recvmsg() can therefore r=
un
> > the pressure clearing path after the ring has been cleared while still
> > seeing tpacket_rcv, causing __packet_rcv_has_room() to dereference stal=
e
> > or NULL ring storage.
> >
> > Serialize pressure clearing with RX ring reconfiguration and update the
> > receive hook while holding the same queue lock when changing the RX rin=
g.
> > Keep packet_poll() on the unlocked helper,
>
> Because it already holds the lock.
>
> > and let packet_recvmsg()
> > take the queue lock only when PACKET_SOCK_PRESSURE is already set
>
> which is sufficient, because if the socket moves from tpacket_rcv to
> packet_rcv, the socket is detached and a synchronize_net has passed,
> so no new packets could arrive to set PACKET_SOCK_PRESSURE if it was
> unset.
>
> > so the
> > fix avoids an unconditional extra lock acquisition on the normal recv
> > path.
> >
> > Fixes: 2ccdbaa6d55b ("packet: rollover lock contention avoidance")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> > ---
> > changes in v2:
> >   - only take sk_receive_queue.lock in packet_recvmsg() when
> >     PACKET_SOCK_PRESSURE is already set
> >   - keep packet_poll() on the unlocked helper under its existing queue =
lock
> >   - v1 Link: https://lore.kernel.org/all/24f7311aed0c9ff06b8ea982647b82=
bf543ec369.1784454542.git.xizh2024@lzu.edu.cn/
> >
> >  net/packet/af_packet.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 8e6f3a734ba0..0107e55de6ff 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -1315,13 +1315,25 @@ static int packet_rcv_has_room(struct packet_so=
ck *po, struct sk_buff *skb)
> >       return ret;
> >  }
> >
> > -static void packet_rcv_try_clear_pressure(struct packet_sock *po)
> > +static void __packet_rcv_try_clear_pressure(struct packet_sock *po)
> >  {
> >       if (packet_sock_flag(po, PACKET_SOCK_PRESSURE) &&
> >           __packet_rcv_has_room(po, NULL) =3D=3D ROOM_NORMAL)
> >               packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, false);
> >  }
> >
> > +static void packet_rcv_try_clear_pressure(struct packet_sock *po)
> > +{
> > +     struct sock *sk =3D &po->sk;
> > +
> > +     if (!packet_sock_flag(po, PACKET_SOCK_PRESSURE))
> > +             return;
> > +
> > +     spin_lock_bh(&sk->sk_receive_queue.lock);
> > +     __packet_rcv_try_clear_pressure(po);
> > +     spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +}
> > +
> >  static void packet_sock_destruct(struct sock *sk)
> >  {
> >       skb_queue_purge(&sk->sk_error_queue);
> > @@ -4304,7 +4316,7 @@ static __poll_t packet_poll(struct file *file, st=
ruct socket *sock,
> >                       TP_STATUS_KERNEL))
> >                       mask |=3D EPOLLIN | EPOLLRDNORM;
> >       }
> > -     packet_rcv_try_clear_pressure(po);
> > +     __packet_rcv_try_clear_pressure(po);
> >       spin_unlock_bh(&sk->sk_receive_queue.lock);
> >       spin_lock_bh(&sk->sk_write_queue.lock);
> >       if (po->tx_ring.pg_vec) {
> > @@ -4544,14 +4556,15 @@ static int packet_set_ring(struct sock *sk, uni=
on tpacket_req_u *req_u,
> >               rb->frame_max =3D (req->tp_frame_nr - 1);
> >               rb->head =3D 0;
> >               rb->frame_size =3D req->tp_frame_size;
> > +             if (!tx_ring)
> > +                     po->prot_hook.func =3D po->rx_ring.pg_vec ?
> > +                                             tpacket_rcv : packet_rcv;
>
> Same question: why this new condition on !tx_ring here, that is
> missing below. It looks benign to me, but especially for fixes only
> make necessary changes.
>
> >               spin_unlock_bh(&rb_queue->lock);
> >
> >               swap(rb->pg_vec_order, order);
> >               swap(rb->pg_vec_len, req->tp_block_nr);
> >
> >               rb->pg_vec_pages =3D req->tp_block_size/PAGE_SIZE;
> > -             po->prot_hook.func =3D (po->rx_ring.pg_vec) ?
> > -                                             tpacket_rcv : packet_rcv;
> >               skb_queue_purge(rb_queue);
> >               if (atomic_long_read(&po->mapped))
> >                       pr_err("packet_mmap: vma is busy: %ld\n",
> > --
> > 2.43.0
>
>
Hi Willem,

Thanks. Yes, that is the intended reasoning for the packet_recvmsg()
fast path.

If PACKET_SOCK_PRESSURE is already clear when packet_recvmsg() reaches
the pressure-clearing path, then after the RX hook switches away from
tpacket_rcv the socket has already been detached and synchronize_net()
has completed, so no new packet input can arrive and set the flag
again. In that case skipping the extra lock acquisition is sufficient.

For the !tx_ring condition: po->prot_hook.func is RX-side state, and
this fix is meant to publish it under the same sk_receive_queue.lock
domain that protects RX ring reconfiguration.

A TX ring reconfiguration does not change po->rx_ring.pg_vec, so it
does not need to rewrite po->prot_hook.func. Keeping the assignment
under !tx_ring avoids an unnecessary write on a TX-only path and keeps
the moved publication strictly tied to the RX ring transition that
actually needs serialization.
