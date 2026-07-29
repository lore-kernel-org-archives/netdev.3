Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EC3B813C
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352840; cv=pass; b=EuHZIncDhQBgpEoBAb0LOEAi6/km96SkC/3VNparYtOeXBRefKLBHcfyGek/iT6MLV0Y3GvtGqaYDDJnmk2hmrKK6KjteQ28vesGDWzz/JKlGuIPdx/ig+owqOeBio+ggVwPCh1N0/vcAxMauErC68lHKoijR3tKm04QNvUlC0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352840; c=relaxed/simple;
	bh=v39J0NNGbheOQbg9MTs7WdorPz5bwtfU4Pews8O/IIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mg33E6DjSPgZ8uRFpCj/hXanGGIPbOQQc/QMEH/8++Gp07WDTIOa1T4h8cUMxKAGsTi08i8aWaeDl+tDaU30NTKui2EA7QEQwWLsoylPFxR72ZbdrDZf5ORBlGLyKLlUH6DidBqGONi55rk9Cfx7hYeXOI+rTeTbe0SazSej8Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFOc/fUy; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFOc/fUy"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso2059711a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 12:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785352830; cv=none;
        d=google.com; s=arc-20260327;
        b=JavSlLc+ulTDiaOuKFF0QFkkbJ7SiaNeKDbEj0/DZUj6VDzjGWIH41ESYzrIOza45b
         Ej5MfC14KQ4O0RztZSHJi5m8WrNAAbAqIhMvs3g+de23ZbIQkMAKka84wRQe4bLYR1IA
         CxyJC+Idpg9v07Y4a0UFBaoPU/6xbwQE+ZQpHiJOEWc69QSi2SDBWtmsY+/QA9QR4tlq
         Z3dx/P4ARYyaU1BDiHiV+vEOe9dXR1tSiJ7ESgkLUEdpW6ftxOeFgsOjWW0+gBQ9cZAp
         0sS9f9IADABw8L8ocd6rJV7I6RhFH2bb0QFqeggknG979aPAAL20KHI9sEAylnZsMnoQ
         gLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDSAww7eofhNwmhBo8NXZ9YQ6g85WKpVrD6PKX308GA=;
        fh=etWineGGfmVDm6Z7IoRpDGXIhMis/K8gMVx5Zs5yTko=;
        b=ETJpQlqrGkrFZC7Fh+LPxNdJzmXAl/RbkRPb3PIRNRHUFXSUhUH2dJaR67r4ocvakB
         5EXvFszPvQvBo8UwJGk/GYevJGpUA+DBCEfbUzCbwiZQQMQ+5BKTbC7MvkAOUkG2REJr
         dhL7gfFynZz3cSQwDD5OpDmu1/uesNAljEuwy0X58hzye8J0PAj2mT7ay5vY9rLggVyZ
         fX4YpbN9uF5ssH9gbTFLyEsX4EKJCo7SosGvjO7Wx4VCddjgOKxWNWII4FIpcmsUnBDI
         uuXSnJYncXPeMpb4gwyjspVbHTQvcflid+lEKWSl8lqRVrG2mcpFOD+uVjCyoe3ZAy1g
         KhFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352830; x=1785957630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NDSAww7eofhNwmhBo8NXZ9YQ6g85WKpVrD6PKX308GA=;
        b=OFOc/fUy8+Ygx08tslxV2T+DSfpMEEd+KgiXe6qCXef4DQwG6ajsHxqMHT1ToZlsq8
         +UyiIUD1mE03fFJlnkmKkL4ykWo/mPJHO/3SAzKKlWY6xx8C2j8pggj1Yw+PEHbwQso5
         Hyad8T3vIe0RE1EU4ss/40Gi+iaVnsGsGUM2mJqLDBPaO1y2rcRaVcmPCOaS3IBv6eLb
         moK30cLkriGGkPT7TeKfhevPQ8oEXLbk4RWGJlts3+W1L9Nq1lgm/UwdmxyWN5tyXfJS
         6vIRhjZ9qr8lM5EM4E4awjQRgmaFOFFQY0VpDcPJd7/rkMhQken5Z1H5IzXvyuyUvbQ2
         4NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352830; x=1785957630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDSAww7eofhNwmhBo8NXZ9YQ6g85WKpVrD6PKX308GA=;
        b=IJUU/bU8csfCBWtpbFgS9mQvz8WeIaLF9xQZFPIvJ47R7rIsF3B2+zs7X+FXaxL3rO
         O1gWhyhdQPSnOu8fC5GZKfmJa3ycR9qdZ11PB02gbuQ5as5JN0Hd7A/pmGDXT/PYAjkC
         dSRBJZvJ0o1Nugbon9mOSQTKY7ZYDHalxwOEKK/BZRFXRVvppali1iU0zafzu5g7phW6
         ifGNSO+toaBOtYIO8vqMsB6SvMi1SHi1UxlXSOGS9b4/UWpMnFGp4svV5wNMALcqnEav
         wB0FvK7u137lF7ZO9brfQWWlhHKD/TSebm3hGKNIe3EscS+Cm25jX3R2W25lP6uwEewj
         wy2w==
X-Forwarded-Encrypted: i=1; AHgh+Rq+p4kalnaYXqmCeG3X9M9U5UKzvXbIdhBXNlS4twBXrTc2D0hh+vt6F7O85zuJlA9odOwxPiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ37BrOtp1VeVPM7N9pR456GlG6nMJvtg+IOOqevPxjvpi49F1
	J4JeVOFXZQD6Vcta/KhZ0VyQ3Tv6jUZnCqRTq7TRECTXNaH78aQomYwFbssO9LDjpJqg0swyt1T
	94X5gkmuaCXhKQWHle2iZv0hVBb5NkrQ=
X-Gm-Gg: AR+sD10E6GbHcNg4zsJkcJx9nS0V/JjHSpURwPcNWVMUkfdoSa84ReB2UPk0hMtFE+o
	V0KKCpa9bHt0wnX+ZiT6JKKK5Apg6BW5+xGxpp+y0MhHJ/8/Zm+KOvPBgHA3MDEI9dyMzBPN6mZ
	SbMhMjrd0XiI1hiRfg2obAAdWB2G+jY1c3WuLjRJ9aARUiRQEeczIHcTAQUUA+VQXsiLgYN6lBT
	juPJ9zwM2MBOn5CNvM8TXgTBi+iPvX4guZubJexfO+bT3LizjXyrHkJmO8vThpHilglOFL3T1Wg
	4qV+E26pGZXdi6lC7SIHmBloPqXvWBkPnNW1VILUjq4Sy7mrp6/2LCynAikLKOY3nWkmkDfYaHU
	=
X-Received: by 2002:a17:906:6a0c:b0:c1f:922d:34c3 with SMTP id
 a640c23a62f3a-c1f922d3b72mr205963066b.14.1785352829519; Wed, 29 Jul 2026
 12:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727035804.1860862-1-bestswngs@gmail.com> <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
 <amoR0pnMO2OQ2E6z@sgarzare-redhat> <CANgPUi2LFBiBG1c7+s_AyzrtDdncXDXQQuphNqmC0uktvBY1dg@mail.gmail.com>
In-Reply-To: <CANgPUi2LFBiBG1c7+s_AyzrtDdncXDXQQuphNqmC0uktvBY1dg@mail.gmail.com>
From: Weiming Shi <thebestswings@gmail.com>
Date: Thu, 30 Jul 2026 03:19:52 +0800
X-Gm-Features: AUfX_myMxXtcqQ9SsdbccjfyUGE7H8t5bNEP8VjBISktONh9Fw_cte5ZVhUeiaQ
Message-ID: <CANgPUi3oUVf12GzPAWTX_3G6rEAssf6UwZi6dm7wW_YPjaMzmg@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted virtqueues
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Weiming Shi <thebestswings@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8830=E6=
=97=A5=E5=91=A8=E5=9B=9B 03:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=88=
29=E6=97=A5=E5=91=A8=E4=B8=89 22:47=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Jul 28, 2026 at 10:17:55AM -0700, Bobby Eshleman wrote:
> > >On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
> > >> The RX, TX and event workers read their virtqueue pointers before ta=
king
> > >> the mutex that protects the queue and its run flag. A work item dela=
yed
> > >> across freeze and restore can therefore retain a pointer deleted by
> > >> virtio_vsock_vqs_del(), observe the run flag for the replacement que=
ues,
> > >> and use the freed pointer.
> > >>
> > >> RX has an additional path: when rx_run is clear, the common exit sti=
ll
> > >> refills the RX queue. A queued worker can consequently call
> > >> virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
> > >>
> > >> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
> > >> Read of size 4 by task kworker/2:1
> > >> Workqueue: virtio_vsock virtio_transport_rx_work
> > >> Call Trace:
> > >>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
> > >>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
> > >>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
> > >>  process_one_work (kernel/workqueue.c:3314)
> > >>  worker_thread (kernel/workqueue.c:3478)
> > >>  kthread (kernel/kthread.c:436)
> > >>  ret_from_fork (arch/x86/kernel/process.c:158)
> > >>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> > >> ...
> > >> Freed by task 141:
> > >>  kfree (mm/slub.c:6566)
> > >>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
> > >>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
> > >>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
> > >>  virtio_device_freeze (drivers/virtio/virtio.c:658)
> > >>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
> > >>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
> > >>  device_suspend (drivers/base/power/main.c:1968)
> > >> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> > >>
> > >> Read each worker's virtqueue under its mutex after confirming that t=
he
> > >> queue is running, and only refill RX while RX is running.
> > >>
> > >> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove(=
)")
> > >> Cc: stable@vger.kernel.org
> > >> Reported-by: Xiang Mei <xmei5@asu.edu>
> > >> Assisted-by: OpenAI-Codex:gpt-5
> > >> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > >> ---
> > >>  net/vmw_vsock/virtio_transport.c | 14 ++++++++------
> > >>  1 file changed, 8 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio=
_transport.c
> > >> index 57f2d6ec3ffc..79cf19f58943 100644
> > >> --- a/net/vmw_vsock/virtio_transport.c
> > >> +++ b/net/vmw_vsock/virtio_transport.c
> > >> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct wo=
rk_struct *work)
> > >>      struct virtqueue *vq;
> > >>      bool added =3D false;
> > >>
> > >> -    vq =3D vsock->vqs[VSOCK_VQ_TX];
> > >>      mutex_lock(&vsock->tx_lock);
> > >>
> > >>      if (!vsock->tx_run)
> > >>              goto out;
> > >>
> > >> +    vq =3D vsock->vqs[VSOCK_VQ_TX];
> > >> +
> > >>      do {
> > >>              struct sk_buff *skb;
> > >>              unsigned int len;
> > >> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct=
 work_struct *work)
> > >>              container_of(work, struct virtio_vsock, event_work);
> > >>      struct virtqueue *vq;
> > >>
> > >> -    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> > >> -
> > >>      mutex_lock(&vsock->event_lock);
> > >>
> > >>      if (!vsock->event_run)
> > >>              goto out;
> > >>
> > >> +    vq =3D vsock->vqs[VSOCK_VQ_EVENT];
> > >> +
> > >>      do {
> > >>              struct virtio_vsock_event *event;
> > >>              unsigned int len;
> > >> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct wo=
rk_struct *work)
> > >>              container_of(work, struct virtio_vsock, rx_work);
> > >>      struct virtqueue *vq;
> > >>
> > >> -    vq =3D vsock->vqs[VSOCK_VQ_RX];
> > >> -
> > >>      mutex_lock(&vsock->rx_lock);
> > >>
> > >>      if (!vsock->rx_run)
> > >>              goto out;
> > >>
> > >> +    vq =3D vsock->vqs[VSOCK_VQ_RX];
> > >> +
> > >>      do {
> > >>              virtqueue_disable_cb(vq);
> > >>              for (;;) {
> > >> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work=
_struct *work)
> > >>      } while (!virtqueue_enable_cb(vq));
> > >>
> > >>  out:
> > >> -    if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> > >> +    if (vsock->rx_run &&
> > >> +        vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> > >>              virtio_vsock_rx_fill(vsock);
> > >>      mutex_unlock(&vsock->rx_lock);
> > >>  }
> > >> --
> > >> 2.55.0
> > >
> > >Not a strong opinion from me, but since this last hunk is the one that
> > >fixes the bug and the other hunks are moreso hardening, maybe break
> > >these out into two patches?
> >
> > I think also the other hunks fix an issue, but I agree on the split
> > since IMO we are fixing 2 different commits. Commit b917507e5ad9
> > ("vsock/virtio: stop workers during the .remove()") was before
> > freeze/resume added by commit bd50c5dc182b ("vsock/virtio: add support
> > for device suspend/resume"). Only after that one we can have the false
> > -> true transition of *_run variables.
> >
> > So IMO hunks 1-3 should have Fixes: bd50c5dc182b ... and hunk 4 should
> > have Fixes: b917507e5ad9 ...
> >
> > That said, it's not a strong opinion here too, but if you prefer a
> > single patch, please add both Fixes.
> >
> > Thanks,
> > Stefano
> >
> > >
> > >Besides, that all looks good to me.
> > >
> > >Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> >
>
> Thanks for your review. v2 sent.
>
> Best,
> Weiming Shi

Sorry for the noise; I resent the series as v3 with proper threading
and no code changes.

https://lore.kernel.org/all/cover.1785352330.git.bestswngs@gmail.com/
