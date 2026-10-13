Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45238E135
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861922; cv=pass; b=SNzH4NhwLYkITxvKeV0lt/NwZDdcIEvulyn3DrsS+b16NtFehoWSSiyg/ktxckGm6SQqOQSwGBoYDM+C75SSf+JHbq532rrQ817PJrD7l1fcrhrxQxcN0NxVWOj1bncTh9ZgAUlQSKMfDUXezcx1GMeIKwRMyXCJj5Xa0Bairdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861922; c=relaxed/simple;
	bh=0b7OaC4HUufUZhIweIEW73CTwJE8jbl1XyGAQdeamgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoNQaAduRKuLL83Vfx6RtmVY2POLDFsmOu5jJ0i0dwBXdwOo4K0Gt0Y3gDDczGi2X2Njr+IhLIYJJ1O+z7XYkoTzQX0IZaqL6+pb9IYsMeZSp6wMEwysKx7VFHHxVHuhzS7OsjLlMJmsntQjQz/InVYKBzOjuix523HV5+keJnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM/MMwV+; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM/MMwV+"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e5c8f53a9so209709685a.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791861920; cv=none;
        d=google.com; s=arc-20260327;
        b=RZuWN4NIzDWj/nVpwG1EWk4PXCKbWi9gMLe/r+zg5vPkuxG8bgWfRfg+BfPq1iY7mH
         TdFsxF6nr/cJk8mi5QadJmU8/65gHOuLzcnaLPgtCEFT+EnIeT+GXbgIDQACqzLyXw6I
         w90Hdj4iiKhgve/x9WspvNOxoWTH657IhJo6p1oVwkXZm2hc5m3iSG1j0C7TEZMz/Lv1
         jrJQDom1xzLUIKM7Jb9ZFlql4o9dhWOWO/qdvJvdUim/lGh5TVGxLZVTs0vPiYFbMxm1
         vUtMccFdnAfyeMYd1x/NyBxOod5k6y4URKHFA8dbdHIdNWdnFblkkTYlPyDphMvXnCW8
         96+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8btU5rJ+Pel0WPP/jtsdEEDxh2u3x4YA62OOuosbpv4=;
        fh=V3ckCPKIyjzgSEDPgckiGo9z82oLJJcqKnyi2ktdV9M=;
        b=slUC6bh+vziv6NyoxATx+FWqD6ONifDzv32QftnKDmTL35BvCZyYXw9Oniw1sYxRgh
         PlIdKHtT40QbA6MPDRP2APnx7c6qAuhKuRbn7Xm0P7BZDSXrXMtyRuWrNXSv+8mnRNvC
         nkB8ywag6umkruaSv/ycWwLM0UEM1z6dRV/h7bICmlJTe/VB/q+D5hgb8JFwEsgzu8h3
         L7zNaZ6r4en1i7Nb7OtyhqB9Rs3TnfOoeQ1gTsDA3K56GEt3SdtCLixP9sqMVTcIxfWx
         iftAoP50kopCoTZkUCFHOGfk3lCtU52DX3HAHXmZLN3voYlEdawze9Z17t1MaqrzDGL9
         cVxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791861920; x=1792466720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8btU5rJ+Pel0WPP/jtsdEEDxh2u3x4YA62OOuosbpv4=;
        b=jM/MMwV+spQdqLF4vVT1GKlzN7FtZ//7yship3FuXnn54P8A/8P7vr9MIsUglGAD2y
         pYTS2NZhZJsEQ2AnkMGK7gz5jtsYT7iy4cCtuc8yvjovpeCu+ftRYMgPpybgipk+G7eq
         ucZ5xgLF6wtocjvfwyHPjOcor9k9y5gKb4CkXkN4zlsf1mPSmEZNeqCLktGNaDUTmuff
         fy479+R8dLkcNw5QmA3t7eiWPugrSi2uneh1RDXeoBwji1OzO26AyK8mA8oUckiRnr8B
         Raw8qZqxyup1mJiYOzzwHvtYkXjOT74KtTkHNlRm9G86jpc6D+B0D59u201SmzW9kGfF
         S9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791861920; x=1792466720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8btU5rJ+Pel0WPP/jtsdEEDxh2u3x4YA62OOuosbpv4=;
        b=VH1qZaLTzxY49kBEb7XFhmuNTCrPDV0WmHCcabf65Gait+LU9dSy6jv+Z+MkIgezPa
         bvvwbNG7TZYy9qg3rPQbR6zx4o6iq5YTAACbADx1p504rKgydEsAPPU9YhhJus8cIDVp
         H0AjJ+Zks3WV7aCuT7naVePGCixcZpFKgYeTbc1S/W49t+71yE/TrxkyJlPF8gAT4s18
         7CZc6n5zOG16PAm+VqFNVoIomFS8ERubNES3qK3uZMkcfn2QHHXMCFM1QKdMUWKOzQAf
         FJMbU9DUMRw9Fk5KRRplUFKSB/ogFeZDa/V4XvN8xEp75SQ7hQQSVCce1H6FpwD+8Z0z
         KmkQ==
X-Forwarded-Encrypted: i=1; AKwUvByR+nvutr5CL1cZV8PG7Z+P04O7BpcVhSqHvzHg4yJoCLfyEvQy8Dyt5TYwaAaL4EOz4ozfOZc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtyyGNT8G7giNpI9C7PMya4F9mnz6bA13CuBpYWK5SbnnCf4lZ
	AH77muVhWAQmUgSNMHrehwUZWsdV7JihmcjYTnSu/ztDED9wFGYY3s0q1GeY0OtoILkPh2M0vXG
	O04JmMxh2p4eKqPSo+C2SsAQIZ3F73Ec=
X-Gm-Gg: AYBFou2Kc0OpcTo+QWZTE/Qp+U8JAQV8eeXP+sHc2Q1993ZM52HaJGkzzYu1sZvRJdz
	TXVrpN2zX+47bL90M5NmbWEmthTheM7/xFZELDirh99wqqRZ86qoqmluCiGrIa6sKFcX1JJR1Jd
	+XVD38ysQZE57Wtuzr9YtcOvcUfm7serGtUYvGuPhqL9/SdMX/EOETKbsaEsmOwRxptuwvp6YSb
	4AJZwfgBxqu6YazlEZSvpaN707uKZUaSz74GcEkguuuMFIatd2lt+K4dTMXSok9TR42fj6wf4p+
	YJLiynzBUFIkn44m2nsUhOZyHs2THJwtoh1gXSprp4TcjOIzZdrEGJjYzrjxjRVMWA==
X-Received: by 2002:a05:620a:1981:b0:93c:c7ee:8087 with SMTP id
 af79cd13be357-93ebd262586mr2063648385a.41.1791861918719; Mon, 12 Oct 2026
 20:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1SWsJw2dSrPYcL@devvm29614.prn0.facebook.com>
In-Reply-To: <as1SWsJw2dSrPYcL@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:24:42 +0800
X-Gm-Features: AclHuK8ArxSs8AN-w9MzUrVu9R026x9r6uOWM8JmPA66VFn2x0Xfdd31Fer7qUg
Message-ID: <CAJwVaMJsQs61+sCun6oJ7bW-Ob76AjdHVxLd+T1EVHvOR5e7Xw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > receive state machine that runs under the socket lock.
> >
> > Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> > Pass the source and destination addresses used for lookup to the locked
> > receive path so they are decoded only once.
> >
> > Pass the network namespace and decoded address tuple through a packet
> > context to the locked receive path.
> >
> > Preserve source validation and failure handling. Keep the lookup reference
> > separate from the skb owner reference so the locked receive path can manage
> > the two lifetimes independently.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
> >  1 file changed, 96 insertions(+), 43 deletions(-)
> >
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index f225f53..e3e75e5 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1774,81 +1774,97 @@ static bool virtio_transport_valid_type(u16 type)
> >              (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> >  }
> >
> > -/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > - * lock.
> > - */
> > -void virtio_transport_recv_pkt(struct virtio_transport *t,
> > -                            struct sk_buff *skb, struct net *net)
> > +static void
> > +virtio_transport_recv_pkt_init_addrs(struct sk_buff *skb,
> > +                                  struct sockaddr_vm *src,
> > +                                  struct sockaddr_vm *dst)
>
> I'd prefer these calls stay inline, there is nothing complex enough here
> to justify abstracting IMHO.
>
> Could we move things around so that we don't have the arbitrary move of
> virtio_transport_recv_pkt()? It tends to create noise and makes it
> harder to focus on the more important parts of the patch.
>

Sure, I'll update this in the next version.

> >  {
> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > -     struct sockaddr_vm src, dst;
> > -     struct vsock_sock *vsk;
> > -     struct sock *sk;
> > -     bool space_available;
> >
> > -     vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> > +     vsock_addr_init(src, le64_to_cpu(hdr->src_cid),
> >                       le32_to_cpu(hdr->src_port));
> > -     vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> > +     vsock_addr_init(dst, le64_to_cpu(hdr->dst_cid),
> >                       le32_to_cpu(hdr->dst_port));
> > +}
> > +
> > +static void
> > +virtio_transport_trace_recv_pkt(struct sk_buff *skb,
> > +                             const struct sockaddr_vm *src,
> > +                             const struct sockaddr_vm *dst)
> > +{
> > +     struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> >
> > -     trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> > -                                     dst.svm_cid, dst.svm_port,
> > +     trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
> > +                                     dst->svm_cid, dst->svm_port,
> >                                       le32_to_cpu(hdr->len),
> >                                       le16_to_cpu(hdr->type),
> >                                       le16_to_cpu(hdr->op),
> >                                       le32_to_cpu(hdr->flags),
> >                                       le32_to_cpu(hdr->buf_alloc),
> >                                       le32_to_cpu(hdr->fwd_cnt));
> > +}
>
> Any chance we can get rid of this wrapper and just call
> trace_virtio_transport_recv_pkt() directly? Even from multiple call
> sites I don't think this is a big simplification win.
>

Sure, I'll update this in the next version.

> >
> > -     if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> > -             (void)virtio_transport_reset_no_sock(t, skb, net);
> > -             goto free_pkt;
> > -     }
> > +static struct sock *
> > +virtio_transport_recv_pkt_find_socket(struct sk_buff *skb,
> > +                                   struct sockaddr_vm *src,
> > +                                   struct sockaddr_vm *dst,
> > +                                   struct net *net)
> > +{
> > +     struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +     struct sock *sk;
> >
> > -     /* The socket must be in connected or bound table
> > -      * otherwise send reset back
> > -      */
> > -     sk = vsock_find_connected_socket_net(&src, &dst, net);
> > -     if (!sk) {
> > -             sk = vsock_find_bound_socket_net(&dst, net);
> > -             if (!sk) {
> > -                     (void)virtio_transport_reset_no_sock(t, skb, net);
> > -                     goto free_pkt;
> > -             }
> > -     }
> > +     if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
> > +             return NULL;
> > +
> > +     sk = vsock_find_connected_socket_net(src, dst, net);
> > +     if (!sk)
> > +             sk = vsock_find_bound_socket_net(dst, net);
> > +     if (!sk)
> > +             return NULL;
> >
> >       if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> > -             (void)virtio_transport_reset_no_sock(t, skb, net);
> >               sock_put(sk);
> > -             goto free_pkt;
> > +             return NULL;
> >       }
> >
> > -     if (!skb_set_owner_sk_safe(skb, sk)) {
> > -             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > -             goto free_pkt;
> > -     }
> > +     return sk;
> > +}
>
> Similarly here, the unrelated functions blending makes for a harder
> read. Maybe worth moving things around or trying a different diff
> algorithm?
>

Sure, I'll update this in the next version

> nit: maybe we could just call this virtio_transport_find_socket()? AFAIK
> the tx side doesn't need a socket lookup since we already have the
> socket there, so we can omit the disambiguation if it lends a nicer
> name.
>

Sure, I'll update this in the next version

> >
> > -     vsk = vsock_sk(sk);
> > +struct virtio_transport_rx_pkt_ctx {
> > +     struct net *net;
> > +     const struct sockaddr_vm *src;
> > +     const struct sockaddr_vm *dst;
> > +};
>
> Let's just pass these directly too...
>

Sure, I'll update this in the next version.

> >
> > -     lock_sock(sk);
> > +/*
> > + * The caller holds sk's socket lock and must free skb if this returns true.
> > + */
> > +static bool
> > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > +                              struct sk_buff *skb, struct sock *sk,
> > +                              const struct virtio_transport_rx_pkt_ctx *ctx)
> > +{
> > +     const struct sockaddr_vm *src = ctx->src;
> > +     const struct sockaddr_vm *dst = ctx->dst;
> > +     struct vsock_sock *vsk = vsock_sk(sk);
> > +     struct net *net = ctx->net;
> > +     bool space_available;
> >
> > -     /* Check if sk has been closed or assigned to another transport before
> > -      * lock_sock (note: listener sockets are not assigned to any transport)
> > +     /* Check after acquiring the socket lock. Listener sockets accept packets
> > +      * from any source and are not assigned to a transport.
>
> We can probably remove the first sentence since the function-level
> comment already declares we are holding the socket lock.
>

Sure, I'll update this in the next version.

> Best,
> Bobby
>
> >        */
> >       if (sock_flag(sk, SOCK_DONE) ||
> >           (sk->sk_state != TCP_LISTEN &&
> > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > +          !vsock_check_source(vsk, &t->transport, src))) {
> >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > -             release_sock(sk);
> > -             sock_put(sk);
> > -             goto free_pkt;
> > +             return true;
> >       }
> >
> >       space_available = virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset event */
> >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > -             vsk->local_addr.svm_cid = dst.svm_cid;
> > +             vsk->local_addr.svm_cid = dst->svm_cid;
> >
> >       if (space_available)
> >               sk->sk_write_space(sk);
> > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >               break;
> >       }
> >
> > +     return false;
> > +}
> > +
> > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > + * lock.
> > + */
> > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > +                            struct sk_buff *skb, struct net *net)
> > +{
> > +     struct virtio_transport_rx_pkt_ctx ctx;
> > +     struct sockaddr_vm src, dst;
> > +     struct sock *sk;
> > +     bool free_pkt;
> > +
> > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > +
> > +     sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> > +     if (!sk) {
> > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > +             goto free_pkt;
> > +     }
> > +
> > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +             goto free_pkt;
> > +     }
> > +
> > +     lock_sock(sk);
> > +     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +             .net = net,
> > +             .src = &src,
> > +             .dst = &dst,
> > +     }
> > +     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> >        * bound or connected list.
> >        */
> >       sock_put(sk);
> > +     if (free_pkt)
> > +             kfree_skb(skb);
> >       return;
> >
> >  free_pkt:
> > --
> > 2.34.1
> >
