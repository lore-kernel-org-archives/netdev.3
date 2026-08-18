Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6D533D6
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078275; cv=pass; b=YkhrT7YbbeqcmFQ5Wm0LbNyvpdnDtM3JuCoGF9IlOq5/nKYpyE2vO6qHZr2nquxX6f04kY0x+E0VAKJVUhQEgYHJ4dgGITwwFqTMbyCKJwoIsRtSB3bjMw5A/v2Y8mNfVJ+LmiU1JhNbiWSyUgLomlOCIS8UK61EqetgcmHZhRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078275; c=relaxed/simple;
	bh=UCr/x2eax16jb2obVKwCMA0GIH6Lcp0ThryncgE29pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lk0bZD37FpEzUUdbtfpAB90fqTwEiOUxvZwsSrGbB1SfigV9qrzzXJH0cK1xRX6sz/3zbsg6UayWifejKThI2Wo2CAcWNAi7ROlGzPPz8MWJyicVpRag9UfDxHd/bPUwuFjcCvceD9nrxUvqBXX/zgFUU+gFIngWN1cXOiz6HGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WAtcVIPO; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAtcVIPO"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so15006a12.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787078272; cv=none;
        d=google.com; s=arc-20260327;
        b=M+sbluAehR97Por35iO/rF9ogD3xY+yfsaEPmtZua5ZGmziuGpdOoaZi51kTTzdAb0
         MqArcZ1KzP9rV8YY6dwMM1Z7U7XvItPyjMp942OPNojJ7+ZxIgdOgq8yjrJ025tJZJna
         ITp9v3TUYSO1CabM8mRIjTDrMslGTQGP3Ojz8IaGnqTfSp6FHBUJP3QYGd+bEUCC3rk/
         yXYV4lOA/CQddB72dEcMNKtCpqOOLbF8vJjTegcneTO992yEQIaAqYnC0w4ExRi/ps8s
         Zryw4A5+LVZ03p7Xv4UTd7tEpTY/EkmsBK/ejMlBIs1izIyLCZ5bhKv0t2TQMa9E5t5Z
         SxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UBMeBtiD0MFrKlnV2YS+XWx/H6ihn3/+SHtLBuLc4NM=;
        fh=P7L13DzG00hGsdNCkd+NeoH5Mi9+LngXPeceMQ9WofQ=;
        b=m94doRL/Kf4wX5LH4FZ58KeD73xHFW9BEHTcONMITO6osTZQFcdc8wwuFDDtuAR8Z1
         nz7zWMh1xQtJFDvDYIsdODFJLaW/tiepjB6K2N0kcS0eous0xjW/2qrshhMUjcDkp6y9
         3sawrFcOnWJthlMZK6XP3bKNrIltbOra2fFqxcQvSsAuEnulWjblFFxxhnIjSbLLBLx4
         1oqAIFH3/2wAgDL4pqWzXtHCZkxslNLjFKFQQ62f/QNMH3oSzo42mRt5nEiGmj/xLQH1
         /7c6gLqqFdZHr8tOuWR+r6a98DPMGdyh9vks0PX0UKidtbkWKssV/zUpjOdIYnzWrnaC
         qCnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787078272; x=1787683072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UBMeBtiD0MFrKlnV2YS+XWx/H6ihn3/+SHtLBuLc4NM=;
        b=WAtcVIPO/IGc/h2dOhFGwudaULWismeuC59Hvstp0QVUpOGw3dmSPsbf+JIhKD+Pl3
         5S3xYU0l5yU8N7QR6ZrITCOp6X8B8KSIl4Uvc3o0VMjY4BwuDiFILecR8SxOCOSmITy7
         xrIPSLV66c25B2v8rARAFK8GEnImy8oD5JXkWDYKm7V1lxrLKCfXyJtYF0i0rTEHgJb4
         CS7XLeq/gfO+vATKNEgpo3zEpzab9cuDUYp8T8rWQV5UPslkKMFULs8PyDuGwfw5vXk8
         FbFSD+7wxaIJRhWl8pfznfJKV5ZtGMTkGwuT+plfXrpcqn2XTF5PyBKLwNdjAvhMuZaf
         r0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787078272; x=1787683072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UBMeBtiD0MFrKlnV2YS+XWx/H6ihn3/+SHtLBuLc4NM=;
        b=X2pYYZaK85ZhsIxy5S+oABUS3ae/pquffLWUffGcb9f5QglrkKtBUF/mzWnjqOurt6
         b3pO/lT4GL5QWPUOoEaWXk7rdMyuHtC3uzN0q47YpEuvSiIL+cqTlegFxRRfRHN2oyu0
         DuNtNl5ftxvZnX+BNIWv4EoaVtTNI616xI9SWMlwTgd7i2N/UIH2j5uavnB26o/sRcMH
         g1Dim4BX4CA+vvwIqqPFekIb7KNa/9tLHKVNjMjwAdt1szu6En3sXAMAvtiXPYVSO1lA
         EXmW6COmoemep6EqJkL+U+rPiHHbLBiBf6YOTBi+91rIoY5237avFDjIjNuBMWKvv2UK
         +IFA==
X-Forwarded-Encrypted: i=1; AHgh+Rqs7eDi1eM48KtuxWKgMr/AX2GIr55JcW6fFcg4F1YJZ0fm0gmPqT1o0D4XI8/GpY6wVj7+VX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZb+GAjTvv1W3HSWGmey7l1VlrhZLllOrEDtwlZCr6pbU5Os2u
	qtrX40nZEaHFUgUZte+MfJ5FkiB1gd3Zk5CTdCq1qRaYIbT4jutyrcvzAdALM+JANBlpRPKpmvX
	lVeAbPJkbujSdAy6iIfwpCA+MP/Cpq8guZireISGO
X-Gm-Gg: AR+sD127fWztpGkeitL7+2hwkRw7l0M3cA0AEWuizGb3nVO9j748GAY95smRwhmejCk
	UQdlpeUjHeqCD2fzJjnvYhgCXEn4kKN/uRirGBGO21y8yRF93eeoLCOX2vXPxDsx0g67vUDu/jB
	Mii+OfFLnyJl0oPioKQiV039UCwEHa3wdcj1oDL/7p0iardc5emf7pVoa6Z6614DjyqUW4GOmqm
	gFAZhn4g9Q0KZZ0GMXrYCRHxyK4col3W8a0CQ8teUiUB774YTg63wjZ+ZdfKDzZ4hUS9rG30fwM
	XToB6wsimHGM4ElijsK0AsvZSh5OsPnXh+Nv3K8qfmz18ZG1XMzaD8wakYpZmG+UJQ41mVH4Nkg
	=
X-Received: by 2002:aa7:d3c1:0:b0:6a3:ec9b:9dfe with SMTP id
 4fb4d7f45d1cf-6a3ec9ba0femr58042a12.8.1787078271246; Tue, 18 Aug 2026
 11:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814191336.187243-2-almasrymina@google.com> <20260818102612.132228-1-pabeni@redhat.com>
In-Reply-To: <20260818102612.132228-1-pabeni@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 18 Aug 2026 11:37:39 -0700
X-Gm-Features: AcwNN1VQ1np3B6ExGliu6wwr8nyBbLSO4ixxxlJou3I2o32IB2RzBa2fp8b6eS8
Message-ID: <CAHS8izPid1ZBEE1PqdUZGi10KK0vPZjza-nSOP65h5Munr9bHQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] net: tcp: block mixing readable and unreadable frags
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, kaiyuanz@google.com, willemb@google.com, 
	edumazet@google.com, sdf@fomichev.me, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dev@openvswitch.org, davem@davemloft.net, 
	horms@kernel.org, ncardwell@google.com, kuniyu@google.com, aconole@redhat.com, 
	echaudro@redhat.com, i.maximets@ovn.org, kerneljasonxing@gmail.com, 
	asml.silence@gmail.com, bobbyeshleman@gmail.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:26=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: tcp: block mixing readable and unreadable frags
>
> This adds a check in tcp_sendmsg_locked() so an existing tail SKB is not
> collapsed into when its readability does not match the presence of a
> devmem binding, forcing a new segment instead.
>
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 455441f1b6949..b4237d0e994d6 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1240,7 +1240,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct ms=
ghdr *msg, size_t size)
> >
> >               trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
> >
> > -             if (copy <=3D 0 || !tcp_skb_can_collapse_to(skb)) {
> > +             if (copy <=3D 0 || !tcp_skb_can_collapse_to(skb) ||
> > +                 unlikely(skb_frags_readable(skb) !=3D !binding)) {
> >                       bool first_skb;
> >
> >  new_segment:
>
> [Severity: Medium]
> Is binding alone the right proxy here for "this send will append
> unreadable frags"?
>
> What actually selects the devmem filler is the zc dispatch in the loop
> plus __zerocopy_sg_from_iter():
>
> net/core/datagram.c:__zerocopy_sg_from_iter() {
>         ...
>         else if (binding)
>                 ret =3D zerocopy_fill_skb_from_devmem(skb, from, length, =
binding);
>         else
>                 ret =3D zerocopy_fill_skb_from_iter(skb, from, length);
> }
>
> and that is only reached from the zc =3D=3D MSG_ZEROCOPY arm of
> tcp_sendmsg_locked().
>
> Can binding !=3D NULL coexist with zc =3D=3D 0?  In tcp_sendmsg_locked() =
the
> binding is taken whenever the cmsg carries dmabuf_id:
>
>                 if (sk->sk_route_caps & NETIF_F_SG)
>                         zc =3D MSG_ZEROCOPY;
>                 else
>                         uarg_to_msgzc(uarg)->zerocopy =3D 0;
>
>                 if (!sockc_err && sockc.dmabuf_id) {
>                         binding =3D net_devmem_get_binding(sk, sockc.dmab=
uf_id);
>
> while zc is only set under NETIF_F_SG.  The one dmabuf_id validation
> does not look at SG at all:
>
>         if (!sockc_err && sockc.dmabuf_id &&
>             (!(flags & MSG_ZEROCOPY) || !sock_flag(sk, SOCK_ZEROCOPY))) {
>                 err =3D -EINVAL;
>
> And sk_setup_caps() in net/core/sock.c only force-adds NETIF_F_SG when
> sk_can_gso() holds:
>
>         if (unlikely(sk->sk_gso_disabled))
>                 sk->sk_route_caps &=3D ~NETIF_F_GSO_MASK;
>         if (sk_can_gso(sk)) {
>                 if (dst->header_len && !xfrm_dst_offload_ok(dst)) {
>                         sk->sk_route_caps &=3D ~NETIF_F_GSO_MASK;
>                 } else {
>                         sk->sk_route_caps |=3D NETIF_F_SG | NETIF_F_HW_CS=
UM;
>
> so a TCP-MD5/TCP-AO socket (sk_gso_disable()) or an IPsec dst on a device
> with sg turned off ends up with binding !=3D NULL and zc =3D=3D 0.
>
> In that state, does the new predicate go wrong in both directions?
>
> If the tail is readable or newly allocated, skb_frags_readable(skb) !=3D
> !binding evaluates to true !=3D false, so every iteration takes
> goto new_segment and the write is split into one skb per iteration, even
> though the zc =3D=3D 0 path only appends readable page frags via
> skb_fill_page_desc().
>
> If the tail is already unreadable from an earlier devmem send, the test
> is false !=3D false, collapsing is allowed, and skb_fill_page_desc() adds=
 a
> readable page frag to an skb that __skb_fill_netmem_desc() already marked
> unreadable =3D 1 =E2=80=94 the mixing this patch aims to prevent.  Would
> validate_xmit_unreadable_skb() catch that?  It only looks at the first
> frag:
>
> net/core/dev.c:validate_xmit_unreadable_skb() {
>         if (shinfo->nr_frags > 0) {
>                 niov =3D netmem_to_net_iov(skb_frag_netmem(&shinfo->frags=
[0]));
>
> Would keying the new clause on binding && zc =3D=3D MSG_ZEROCOPY, or
> rejecting dmabuf_id when the route cannot do SG, line the predicate up
> with the code that actually fills the frags?
>
> Note the mixing described in the second direction pre-dates this patch
> (there was no check at all before); the incorrect predicate and the
> forced re-segmentation are new.  Reaching this also needs a local
> privileged setup (dmabuf TX binding plus MD5/AO or IPsec plus an ethtool
> feature change), and in that configuration a devmem send through the copy
> path would likely already fail in skb_copy_to_page_nocache() since the
> iovec holds dmabuf offsets rather than user addresses, so this is stated
> as an observation rather than a demonstrated corruption path.

Pre-existing issue I think. We indeed assume binding !=3D NULL means the
send is devmem and zc is set. We missed that we may not set zc if
NETIF_F_SG is not enabled. Probably the code setting binding to
non-NULL should check if zc is set. I think this is best reserved for
its own follow up fix, but let me know if not Paolo.

--
Thanks,
Mina
