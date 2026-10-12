Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F432D7C7
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791784316; cv=pass; b=QVID6LffNEatJ5z/A2uP9jxuojvQGNlHCyaZ68M/qHqE9PmAtdmSzOBifVaIkfyKoT6RfhTcg5bxbACyVRmUTpOzRHVnRUbLo8fv0298xhZdEsZQ5KyQ2rnx9X9vZ3085Gtg3jcSBZO7i4F4LUzPTe8qSMN83feWFoUCK0UFcM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791784316; c=relaxed/simple;
	bh=RMrOyRWgelCdaTh04TeQVAi8/u5010xn5Q8zRGB/p/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az/U5bApbvqHDQXBID+afKtLxO56Tllqzv4hei8p3ZOh/9KD3qP2vpf2Dk4VuodeJ6N+fiSJ1BvaYWHtbeGWY+9K2SvkwLHutjViRbdx4XtLbn40/jTGEiXdlaCHaW15AHUqncTOY3f5EWKiUCiodbN1MoNARhjnbHHGj1kf1tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hysi+6KX; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hysi+6KX"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e706a6ba9so221548185a.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 22:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791784314; cv=none;
        d=google.com; s=arc-20260327;
        b=RXU4S2SXL/HqLj9fY+kBHAQBQucDUKz2Or7HA4YyhfKoWI/d6kCAcetQRri+Pqw6AU
         OH2NJF2wnJO5H2ugRtLVx+j1IhRoGpdvLesiZZYV9wjJoKWtawCmHZU/hgh/d7wVNQuy
         4Q8XVrgh/raa7W7eqffO+3hg3LV9POyWFB3qTutNromEY9X2xQnP6aI5/KP+X5EQxh0Y
         N3uAnEZH+l2Pz8gXCikCsx3xSvb3GlIYyaoXAyRw9da87bFM5M4a8LJv5V7h1OQXheGV
         stYSJgP6Diq0O6Qez9G9DRWDsjY7JKhtmF8sEdkGavw6ZXUCe4dktDMYS26Plx6PwAU+
         aHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CC8Mxf5P9+FMx1bJlSArM03EiTJXelj+K+rGTNeTbzQ=;
        fh=Cmz41Jdbde56sfxsezrU2f6TOrRN5TONTo8cmroU1Js=;
        b=IUH/Ad6giHGXYg9UQ0Zz7oG9jGmk9k74XAmiFDtryt6c9TxDhMx9QurYfX0C56kWoD
         d6u7obksbpS6w78yx89l4toqeZYQj5dEg42hsFJOiI+n1Vzepa9+JRkbi9MLhpLpgioJ
         LUj+LC1cWkR27y/UaxRy4hXQxV1NVydfWbetnGgOoqbCuN/IHhFcGhwo+13he+uS7qnK
         R+KPVZArMZ+o67MAUkoJCYk8GVDULAUWCbTapb1l+BQ6NhS16dFw9MvzZesHzkAPngbL
         RHW7N3oLxd8ZpFD7Q/rwyx3EopecLbYsUawRnD8qwh6u3u+kH0ZmLweh15CdQBx/Cscr
         5M/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791784314; x=1792389114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CC8Mxf5P9+FMx1bJlSArM03EiTJXelj+K+rGTNeTbzQ=;
        b=Hysi+6KXMOqysTn788ZnMyLmweGDZnTaT9zRuzey9k4ym3KW3mFSCcKcRRa41TEL46
         mDAcz1XlMQ1Hw+3XS6F3UIZiM5yLNyAHIf6KtRdhsnJT5PJ99GE1GsrM+pkxsfL+b2Xe
         V4tb6+6cyUbwwg3V6vXF0iwZJbVjY1PYBz3QEw8zB6d8nTlPaPG6i4nl1n6J9XWL0eUn
         qgF9CCVndDy2iXk8/8hlBlvjUERm7Y1l44VgysWf33mYCMani3+hgtohk9m+OpTbDPLK
         qDJLwFlO6A8qYEFvqj/CWBK0oyT7uGL6HrA8VMIBhthswYLOPHxllSGOzTo1YkyxMKgq
         HhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791784314; x=1792389114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CC8Mxf5P9+FMx1bJlSArM03EiTJXelj+K+rGTNeTbzQ=;
        b=tjQAvBfN0y8eeZOPyDXUYuTU3irlO9wCo4XzD07kjNn2RY75RAbVCxdCkpBAqMumjg
         Mfbnc9yPVYhRgVm4oCqHSfOnuru7/v+xEU8klvdl6DsN3WLg4yoxG1xDo8TgFSP2hIob
         Z4dKvLVFDN/LyAVQGpfTVBGaPS66s5Qyp+s2JX1wzj3/60DpTfmdemVMFQop0l8ed5wP
         bIjKXiPDCjrWXiaUi729E8zhZSBfr4ol5knOrHfoqQ5iI92T0+gGfpv6+XKwl2fCCdf8
         WpxocXHM8S70/xl9FYO7AL86t7kzTEpB/zdSPLpifUq3RbHmuyiyF1ph9zQiKGv4IaQd
         OETg==
X-Forwarded-Encrypted: i=1; AKwUvBwYSn2exclAigwqzWPaMurJ5q1g0hTe5t9xZHmi0rzAIVoswkin4sVAm1LuHpmcXQjrkbm6SLk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIREd0iceF8XG78XvuhPa8MPs554vKiYCMJSf6Rb6uRMNvYiPYl
	mSW2LUrp+zewEpVrkKRzJfNdRqb99DWgZpQBed7kK/1NWTSqo5/Y0JCP5Wgp71WumfZnMqZ2Oaw
	VuZE4wCxnmbPpcko/uYHIhX8ii6kaUio=
X-Gm-Gg: AYBFou2KaQ5BEeTaT5FixAHFRmKS7O768929LlJfw3EI9R6kJZlEyP5KM8kJjSOZJIK
	11Mq+3Nm47hk5lNuzuF2V3mo/k8GPEnxsnIVvro1gxJ0UYGumVHs+uMCk4BDm5U9/5v2y4S9K39
	vpKnQOisuiMFE1PmGWxXNAhPW9cZGyT795ZTA+LE/fRR3ZszDsP1H1TwdRCa/qGy9k8dfS8WMoJ
	pNEMSB95tzbpjCJQABT+0+Z2x4W9qvHZb9Kv5XsVhTspcXjaw+A4yjJXPFxv4mihahGe8VMFIs1
	OFCiJLKPxJEVsnxNTPJshTeLEw0vBZeYRjJdZd6ekzdga7sU8pBv6tU=
X-Received: by 2002:a05:620a:711a:b0:93e:7dfa:2f3f with SMTP id
 af79cd13be357-93ebd493d90mr1580936385a.62.1791784313402; Sun, 11 Oct 2026
 22:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-6-physicalmtea@gmail.com> <179172875205.434549.8636973340087490564@kernel.org>
In-Reply-To: <179172875205.434549.8636973340087490564@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Mon, 12 Oct 2026 13:51:17 +0800
X-Gm-Features: AclHuK8Ki9X54bInYhhv1pL0dcfB74cVT9pZCzrKL4qZHpNOUX6PRTgdoDnVTQ4
Message-ID: <CAJwVaMKUa-c2e_jgGfQ63rMPYyYi8-reZYNBBiKTKQdXe1xV-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/5] vsock/virtio: defer RX readable
 notifications until batch unlock
To: netdev-bot+sashiko@kernel.org
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 (1) =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The new attach-time handoff passes partially read skbs to
>   read_skb, which ignores the read offset.
> - [Medium] Sockmap attach/detach now drains queued data on every vsock
>   socket, and the commit message wrongly says non-batched sockets keep=E2=
=80=A6
> - [Low] The commit message says "Sampling at batch finish takes
>   sk_callback_lock once." That holds only on the native path.
> - [Low] vsock_rx_callback_handoff() calls sk_data_ready without the
>   sk_rcvlowat/SOCK_DONE check that vsock_data_ready() and the per-packet=
=E2=80=A6
>
> Pre-existing issues:
> - [Medium] vsock_rx_callback_handoff() reads sk_data_ready under
>   read_lock_bh(&sk->sk_callback_lock), releases the lock, and only then=
=E2=80=A6
>
> --
>
> vsock/virtio: defer RX readable notifications until batch unlock
>
> During virtio vsock RX batches, this commit holds back the native
> sock_def_readable() notification until the batch has dropped the socket
> lock. If sk_data_ready or sk_write_space has been replaced, for example
> by sockmap, a new vsock_rx_callback_handoff() passes queued skbs to the
> current callback one at a time. vsock_bpf_update_proto() now schedules
> that handoff on sockmap attach and detach.
>
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index fe7f49da6c4bc..df6faee0bd37a 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -931,6 +931,107 @@ static int __vsock_bind(struct sock *sk, struct s=
ockaddr_vm *addr)
>
> [ ... ]
>
> > +/* Caller holds lock_sock(). */
> > +void vsock_rx_callback_handoff(struct sock *sk)
> > +{
> > +     struct vsock_sock *vsk =3D vsock_sk(sk);
> > +     void (*write_space)(struct sock *sk);
> > +     void (*data_ready)(struct sock *sk);
> > +     bool wrote =3D false;
> > +     s64 before, after;
> > +     int i;
> > +
> > +     if (sock_flag(sk, SOCK_DEAD) || !vsk->transport)
> > +             return;
> > +
> > +     read_lock_bh(&sk->sk_callback_lock);
> > +     data_ready =3D READ_ONCE(sk->sk_data_ready);
> > +     if (READ_ONCE(sk->sk_prot) !=3D sk->sk_prot_creator &&
> > +         data_ready =3D=3D vsk->default_data_ready) {
> > +             read_unlock_bh(&sk->sk_callback_lock);
> > +             /*
> > +              * start_verdict publishes sk_data_ready after the proto =
swap.
> > +              * Retry once before treating this as a stable non-RX set=
up.
> > +              */
> > +             if (!vsk->rx_cb_retried) {
> > +                     vsk->rx_cb_retried =3D true;
> > +                     vsock_rx_callback_queue(sk, 1);
> > +                     return;
> > +             }
> > +             vsk->rx_cb_retried =3D false;
> > +             data_ready(sk);
> > +             return;
> > +     }
> > +     read_unlock_bh(&sk->sk_callback_lock);
> > +     vsk->rx_cb_retried =3D false;
> > +
> > +     for (i =3D 0; i < VSOCK_RX_CB_HANDOFF_MAX; i++) {
> > +             read_lock_bh(&sk->sk_callback_lock);
> > +             data_ready =3D READ_ONCE(sk->sk_data_ready);
> > +             write_space =3D READ_ONCE(sk->sk_write_space);
> > +             read_unlock_bh(&sk->sk_callback_lock);
>
> [Severity: Medium]
> This is a pre-existing issue, but sk_callback_lock here only covers
> reading the pointers, not calling them. Can a concurrent sockmap delete
> restore sk_data_ready and clear the psock between this read_unlock_bh()
> and the data_ready(sk) call below?
>
> The delete path takes only write_lock_bh(&sk->sk_callback_lock), not
> lock_sock():
>
> __sock_map_delete()
>   sock_map_unref()
>     sock_map_del_link() / sk_psock_drop()
>
> In that case the stale sk_psock_verdict_data_ready() still dequeues an
> skb through virtio_transport_read_skb(). That lowers rx_bytes and sends a
> credit update. sk_psock_verdict_recv() then finds no psock:
>
> net/core/skmsg.c:sk_psock_verdict_recv() {
>     ...
>         if (unlikely(!psock)) {
>                 len =3D 0;
>                 tcp_eat_skb(sk, skb);
>                 sock_drop(sk, skb);
>                 goto out;
>         }
>     ...
> }
>
> So the skb is dropped after it has already been credited to the peer.
>
> The baseline vsock_data_ready() has the same window. It calls
> sk->sk_data_ready(sk) under lock_sock() without sk_callback_lock, and
> tcp_data_ready() has the same issue. This patch adds more call sites
> with the same pattern: the attach-kicked work item and the batch-finish
> handoff. Taking the read lock here can also make it look as if the call
> is protected when it is not.
>
> > +
> > +             if (!wrote && write_space !=3D vsk->default_write_space) =
{
> > +                     write_space(sk);
> > +                     wrote =3D true;
> > +             }
> > +             if (data_ready =3D=3D vsk->default_data_ready) {
> > +                     data_ready(sk);
> > +                     break;
> > +             }
> > +             before =3D vsock_stream_has_data(vsk);
> > +             if (before <=3D 0)
> > +                     break;
> > +             data_ready(sk);
>
> [Severity: Low]
> Neither of these data_ready(sk) calls checks sk->sk_rcvlowat or
> SOCK_DONE, unlike vsock_data_ready() and the per-packet path in
> virtio_transport_recv_connected(). Is that intended?
>
> For a replaced callback such as the sockmap verdict, data_ready(sk) runs
> whenever vsock_stream_has_data() > 0. The verdict program can then see
> data below SO_RCVLOWAT that the per-packet path would hold back.
>
> For the default callback the call is unconditional, both here and in the
> retry branch above:
>
>                 vsk->rx_cb_retried =3D false;
>                 data_ready(sk);
>                 return;
>
> Doesn't this wake readers when no readable event was pending? That
> happens on every attach and restore kick from vsock_bpf_update_proto().
> It also happens when virtio_transport_rx_batch_finish() enters the
> handoff with only write_space_pending set.
>
> > +             after =3D vsock_stream_has_data(vsk);
> > +             if (after >=3D before)
> > +                     break;
>
> [Severity: High]
> Can this hand a partially read skb to read_skb?
>
> A native stream read can consume only part of the head skb. In that
> case virtio_transport_stream_do_dequeue() advances the private offset,
> leaves the skb queued, and lowers rx_bytes only by the bytes copied:
>
>                 VIRTIO_VSOCK_SKB_CB(skb)->offset +=3D bytes;
>                 ...
>                 virtio_transport_dec_rx_pkt(vvs, bytes, dequeued);
>
> If the socket is then added to a sockmap with a verdict program, the new
> kick in vsock_bpf_update_proto() runs this loop:
>
> vsock_rx_callback_work()
>   vsock_rx_callback_handoff()
>     sk_psock_verdict_data_ready()
>       vsock_read_skb()
>         virtio_transport_read_skb()
>
> virtio_transport_read_skb() does not look at the offset:
>
>         pkt_len =3D le32_to_cpu(hdr->len);
>         virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
>         ...
>         return recv_actor(sk, skb);
>
> Take a 1000 byte skb with 400 bytes already read, so rx_bytes is 600.
> The verdict program sees all 1000 bytes, 400 of them a second time. The
> u32 rx_bytes then wraps to 4294966896.
>
> The after >=3D before check above sees no progress and stops. But
> vsock_stream_has_data() now reports about 4GB, so poll stays readable.
> The next native read hits WARN_ONCE("rx_queue is empty, but rx_bytes is
> non-zero") and returns -EFAULT.
>
> The offset handling in virtio_transport_read_skb() predates this patch.
> In the baseline the same corruption needs a partial read, then an
> attach, then another packet from the peer. With this patch the extra
> packet is no longer needed, and the new attach-time drain depends on
> read_skb handling already-queued skbs correctly.
>
> > +             if (i =3D=3D VSOCK_RX_CB_HANDOFF_MAX - 1 && after > 0)
> > +                     vsock_rx_callback_queue(sk, 0);
> > +     }
> > +}
>
> [ ... ]
>
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vi=
rtio_transport_common.c
> > index e5637291f3185..6b96d8ac0d598 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
>
> [ ... ]
>
> > @@ -1986,33 +2007,45 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>
> [ ... ]
>
> > -     if (write_space_pending) {
> > -             vsk =3D vsock_sk(sk);
> > +     vsk =3D vsock_sk(sk);
> > +     if (write_space_pending)
> >               vsk->default_write_space(sk);
> > -             write_space =3D READ_ONCE(sk->sk_write_space);
> > -             if (write_space !=3D vsk->default_write_space)
> > -                     write_space(sk);
> > +
> > +     read_lock_bh(&sk->sk_callback_lock);
> > +     native =3D vsock_rx_cb_is_native(sk);
> > +     read_unlock_bh(&sk->sk_callback_lock);
> > +
> > +     if (native) {
> > +             release_sock(sk);
> > +             if (data_ready_pending)
> > +                     vsk->default_data_ready(sk);
> > +             sock_put(sk);
> > +             return;
> >       }
> >
> > +     if (write_space_pending || data_ready_pending)
> > +             vsock_rx_callback_handoff(sk);
>
> [Severity: Low]
> The commit message says:
>
>     Sampling at batch finish takes sk_callback_lock once.
>
> Does that hold on the non-native path? sk_callback_lock is taken once
> here for vsock_rx_cb_is_native(). vsock_rx_callback_handoff() then takes
> it again at the top. It takes it once more on each loop iteration, up
> to VSOCK_RX_CB_HANDOFF_MAX (64) times, and the requeued work can do all
> of this again.
>
> [ ... ]
>
> > diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> > index 9049d26486460..7770a6c51dbe5 100644
> > --- a/net/vmw_vsock/vsock_bpf.c
> > +++ b/net/vmw_vsock/vsock_bpf.c
> > @@ -154,6 +154,7 @@ int vsock_bpf_update_proto(struct sock *sk, struct =
sk_psock *psock, bool restore
> >       if (restore) {
> >               sk->sk_write_space =3D psock->saved_write_space;
> >               sock_replace_proto(sk, psock->sk_proto);
> > +             vsock_rx_callback_kick(sk);
> >               return 0;
> >       }
> >
> > @@ -166,6 +167,7 @@ int vsock_bpf_update_proto(struct sock *sk, struct =
sk_psock *psock, bool restore
> >
> >       vsock_bpf_check_needs_rebuild(psock->sk_proto);
> >       sock_replace_proto(sk, &vsock_bpf_prot);
> > +     vsock_rx_callback_kick(sk);
> >       return 0;
> >  }
>
> [Severity: Medium]
> These kicks run for every AF_VSOCK socket added to or removed from a
> sockmap or sockhash, not only for sockets in a virtio RX batch. Is this
> change in behaviour intended?
>
> RX batching exists only in the guest virtio transport
> (virtio_transport_rx_work() -> virtio_transport_recv_pkt_batch()).
> vhost_vsock and vsock_loopback always use virtio_transport_recv_pkt().
> Both still set .read_skb =3D virtio_transport_read_skb, so their sockets
> reach this code too. The same is true of SOCK_SEQPACKET sockets, which
> virtio_transport_recv_pkt_batchable() rejects.
>
> Before this patch, sk_data_ready was not called by either path:
>
> sock_map_link() -> sock_map_init_proto() -> vsock_bpf_update_proto()
> sk_psock_start_verdict()
>
> Data queued before attach only reached the verdict program when a later
> packet arrived.
>
> Now the kick pushes that data through sk_psock_verdict_data_ready(), up
> to 64 skbs per pass, and requeues itself if data remains. The verdict
> program can redirect or drop data that arrived before attach, where it
> used to stay for the native reader.
>
> If only the prot was swapped, for example with a msg_parser-only map,
> the handoff calls the default callback unconditionally after one retry.
> That adds an extra wakeup on every attach and detach.
>
> The commit message says "non-batched sockets keep their existing
> behavior". It also says the handoff is scheduled "so an attach or detach
> outside the worker still drains skbs already queued".
>
> Neither statement seems to fit what the code does: this is a new sockmap
> behaviour for every vsock transport that has read_skb, and the subject
> line does not mention it. Could this be split out, or at least
> described in the commit message?
>

I will drop the attempt to preserve RX batching across sockmap cb
replacements, at least for this optimization series.

> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261010142247.99223-1-physicalmtea%40gmail.com
