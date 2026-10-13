Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440134FF79
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862293; cv=pass; b=GGaLtFe4OrwlM20LkJgLKWo8jZN5LQqvqfRAm2zYpIIpWRvZixTlBtxgFPBQ2UzGCkYBk87otCJp9ASfCsz6WBThZ+5CZKDnFDw4034YCXv3oM1zdjTzjt44ISeit8LDdSfjt2g4S7nnRjB8pmOQQjfrYrAT4lkdxAS0WXi9mKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862293; c=relaxed/simple;
	bh=zCSEKIAPKVwVSGY4GyE3kxLa1knCjzTA3Y/jvMzWxiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opvbyFAj6V3sHNNrGbMXOi1wubfLnb3vssqg7gTSdObjiVd1lA4z2aGcdJ4YblD8Cf4BeEaw6JJS+yEttBlTWndAZV/sLGr5c8FMvos4po33cHReEgYTaWF5LmwCNTj6I7Luu0/K/pGDEk/g89XQaWQH8syjoDus1ZbjFJ6nzks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNRyFkqW; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNRyFkqW"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e55db58cfso256606285a.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862288; cv=none;
        d=google.com; s=arc-20260327;
        b=htDS4n755vvdnlDutqiCeVzVLtrlnA5Bf7xgKCy7Lhgetoz3XGM1FBHJCWJP4aQc20
         FVcj15k4wLqScF9MetBFNlDHrcjKAdFKZOLCVrdexukT4U/t08RrghWWGi7BY2o32buL
         XhR72r/L/PUpT+wJSF8d2Gxbk+B0XKc3WrMKHgJc7yKInKqOtSeO4JBRhkGJJaSSwjW4
         Jmye7L1nC6IUhi6R4jDbfwtXvvRpJKh3IGXz9szndN6HNqTavqzzc38wIK1W892tXZMP
         3xuZdxQR+QXAcAToDxLF9sMHLkq4go9mLvYgYQjz3xtFCMO4c2WVyp6Vzf857m2YHGFd
         1xLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        fh=48dJKwi8r7QN6ytTI0FLyyVv0qc57e0ILwh/8/td3aw=;
        b=NHkriqv1TrG5moS2SNu4A5NrNeeUZ5d4fm2A0Lmzahmm4fY6etC2g6eJruG25YOOp4
         6oVTG5eN7N7rdL17YG1peX8yu1q+li99UPryFW8mXx0VIFVQ8hdvCD6UooWC1cAsVeFI
         GkbOEuzxC9vGE7uFRTr1PxA87aBH9FQFQ2xSCgqAZBb7ROFp3lJczSyQf1te7s4yeSjb
         /i0vNsMPO7pBomWCmW3Dbdg+hS4hB50Z3XJBYf2w47SL4KXYWMs5kzAyuUAffrZwmqBz
         i9YTg/Neoijbl3Rk9guUa0EHXp7B9joDCnPMHXmEcSnvHjWG/XGxLYu+dUnpw7U7ryTC
         VkcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862288; x=1792467088; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        b=CNRyFkqWvkphXy4611cQxfWd3tluQ2Ap+aZpYQtlP56Wvf2uIOZtIBNT32f9l64lCL
         HdERnSWoEgkR/I2ykgmwW9MosDd36LVBYLu6FgpxJZ8CfziAMvs+159cn0FEnD3Wk8vs
         owf5QJpZW1rBUtUGwT8vcnB3pYZ53gcu4humkw3zPvllA3/lNcsYd9DuB+3stYgwMh0x
         WzsNiT7bE58HHyvxKNhB6gyxAw17LkLNfWXXnhSE0WUgxAQ5MbNsa9RRuytAk3T19QiY
         g6OGGZcFuYXaRsFoYjuxyt3UAtI2t/HA/7ciI0OrbqE1t8NO/gP65CGhRi7fSe90KWxZ
         f/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862288; x=1792467088;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        b=TMxnYPllRoTUFfkXIZbPFZA8lc6q97YlfRE7l6p8AdeWaXW7CS0/gsalSnnCjOJBc8
         Tb4hApAywcd86MPqudRN4l19V5EGSfRUnPfckG/PaGSLkt1JTOFlXWH8qKZfuFmXB3Xn
         xZ75Gv3waIyWdpvVJC2adFnRkiisCs+kf44WPBWUJvHB9YTSqpiX25IV1o67Jr3noVeN
         j4vhK94hlFV4E2a6AaP5GiPjfMZkegMvSPvUJmY+RXSUKl6mXuo4j2/U+40VFTLayTxD
         DcXr6kz6CDt0OT7isBox1WKqLmqa8RADwbToc6CVmuTgMotAwRZ1wono0g+g0HnE3jgT
         A2cw==
X-Forwarded-Encrypted: i=1; AKwUvBynGPereINSi+9SS1cJiLEKUos7D4eDAFujc94b0r7dtV87YwdHIOrKjOMgjmVkAT2Yib13p4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJY6SLRXhqiZdEJ2d9RtGfx5YBWHlhogk3YoOUu2u0r1LBoV+eM
	JfIXo/UFBmz5w4ZrdfBxWfrq64r+zMaZmVW2kTA+uzYxmJdcL8HvWK9nHdne7OIKU5t3ZqxYDWj
	tV9ZDAUp5Kol6aoDbVSjrfcKi3njdqus=
X-Gm-Gg: AYBFou3WiTfO8FbVrUyz00W8s7fe1WafdBJrzuKD/+GkMQrkUm9tOmPNQIpiTNdydBL
	3lt7Qgx6zqMx2L8yOEagY9CVeVl6nnX+MTmJBRwEtRLJy0ryqln2aq/RN82mSrLNDDsjts5RsVg
	ryov7eHYfNcZlbK8PiCjJvhz+NaPetswzhT4un2Y+Cj5ENyg6QmN4ukrx2FT48PfvX0dYlA0VFq
	sHEau689AyxVyTdZfoYxv5WnuV3NYYtB2YU//eMXS3kthsSRfSxxigs/+f0mSsuYl9yictNDp/9
	qRZdBA928PajSwtbWoK1Lmh16Q86Nd/Gp5KzgIzhtqg8hUhjp5wkMjw=
X-Received: by 2002:a05:620a:44c8:b0:939:1222:b9f1 with SMTP id
 af79cd13be357-93ebcd2b3d1mr1818738285a.0.1791862287366; Mon, 12 Oct 2026
 20:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-4-physicalmtea@gmail.com> <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
In-Reply-To: <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:30:51 +0800
X-Gm-Features: AclHuK82x5TMJTU3P4uV1cGGZ695rdTmYCG-meYcWlEm97kH4rrDUYXGHuCS2tM
Message-ID: <CAJwVaMJxgjbEXk8LW+wYbmfPYA2anNcRtitB=G1=kNv-WXm4TQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket
 lookup in RX batches
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:45PM +0800, Jia Jia wrote:
> > An RX lock batch still looks up the socket for every packet and takes a
> > temporary lookup reference, even though the batch already holds a reference
> > to the locked socket.
> >
> > Record the network namespace and packet address tuple when a batch starts.
> > Reuse the batch socket for later STREAM/RW packets with the same tuple, and
> > release the batch before looking up a different flow.
> >
> > The cached path still traces every packet, takes an skb owner reference,
> > validates socket state, source and transport, updates credit, and runs the
> > receive state machine. Only the socket table lookup and its temporary
> > reference are skipped.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  3 ++
> >  net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
> >  2 files changed, 38 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 26dde6909c4e..d6528681e052 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
> >       struct sock *sk;
> >       unsigned int pkts;
> >       size_t bytes;
> > +     struct net *net;
> > +     struct sockaddr_vm src;
> > +     struct sockaddr_vm dst;
> >  };
> >
> >  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index e67dfcaa279c..73e5c7dfe8b4 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> >       batch->sk = NULL;
> >       batch->pkts = 0;
> >       batch->bytes = 0;
> > +     batch->net = NULL;
> >
> >       if (!sk)
> >               return;
> > @@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >       virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> >       virtio_transport_trace_recv_pkt(skb, &src, &dst);
> >
> > +     if (batch->sk) {
> > +             if (batch->net == net &&
> > +                 vsock_addr_equals_addr(&batch->src, &src) &&
> > +                 vsock_addr_equals_addr(&batch->dst, &dst) &&
> > +                 virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> > +                     sk = batch->sk;
> > +                     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +                             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                             kfree_skb(skb);
> > +                             return;
> > +                     }
> > +
> > +                     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +                             .net = net,
> > +                             .src = &src,
> > +                             .dst = &dst,
> > +                             .batchable = &batchable,
> > +                     };
> > +                     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +
> > +                     if (!batchable)
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                     if (free_pkt)
> > +                             kfree_skb(skb);
> > +                     return;
> > +             }
> > +
> > +             virtio_transport_rx_batch_finish(batch);
> > +     }
> > +
> >       sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> >       if (!sk) {
> >               virtio_transport_rx_batch_finish(batch);
> > @@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >
> >       if (!skb_set_owner_sk_safe(skb, sk)) {
> >               WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > -             virtio_transport_rx_batch_finish(batch);
> >               kfree_skb(skb);
> >               return;
> >       }
> >
> > -     if (batch->sk && batch->sk != sk) {
> > -             /* Never acquire a second socket lock. */
> > -             virtio_transport_rx_batch_finish(batch);
> > -     }
> > -
> > -     if (batch->sk == sk) {
> > -             /* Keep the batch reference; drop this packet's lookup reference. */
> > -             sock_put(sk);
> > -             ctx = (struct virtio_transport_rx_pkt_ctx) {
> > -                     .net = net,
> > -                     .src = &src,
> > -                     .dst = &dst,
> > -                     .batchable = &batchable,
> > -             };
> > -             free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > -             if (!batchable)
> > -                     virtio_transport_rx_batch_finish(batch);
> > -             if (free_pkt)
> > -                     kfree_skb(skb);
> > -             return;
> > -     }
> > -
>
> Not sure I love adding code and then removing it in the same series.
> Seems like these are asking to be squashed?
>

I'll fold patch 3 into patch 2 so batching is introduced with
same-flow lookup reuse from the start.

> >       lock_sock(sk);
> >       /*
> >        * Sockmap removal restores the native protocol under sk_callback_lock.
> > @@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >       free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >       if (start_batch && batchable) {
> >               /* Keep the lookup reference until the batch is released. */
> > +             batch->net = net;
> > +             batch->src = src;
> > +             batch->dst = dst;
>
> Similar to my comment in the other patch, seems these are all in sk
> already?
>

For the batch cache, yes. I'll use the locked socket state for the
same-flow check. The packet values still need to be passed to the
locked receive path for source validation and reset handling.

> Best,
> Bobby
