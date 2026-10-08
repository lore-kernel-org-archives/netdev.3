Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670673D954D
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791495662; cv=pass; b=vBK+OibNKngt4dmHGzVp68FHAix8M77oT3E740BXibsI+RjhpUJw6rxLKJYh+rmPXomF2L119MWoCek4A7gvJCQozCutTB4fcSI7G7IllgTeTW8sMufLWQF6k/BPPwCvJ90ADthHllJTGva1sVELAPQyBNCo1A6+xtNVY9foVLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791495662; c=relaxed/simple;
	bh=X79HiiRrOSQEwG0wkO/yWS47cMb3pYSvxPyGF5qUYzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JncVZf49hDPhCCkZCUxxNex4UU90LsY3/RoNLTQL4T8nDBBvWU47ye/z2psuFAC44MDTHX94ogIYdpkMc76SbD+pUpvbQMWSVPvgR4QGVC8/bB6YvQ+06oSGA9+ysx46z0wII7n4CNFNQfdSq4k9wbWZJ6eFeQlM2inMADITBJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8/F/OdW; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8/F/OdW"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-5058b105df7so495688b6e.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791495660; cv=none;
        d=google.com; s=arc-20260327;
        b=D4VeKdcqB0Sl0dBpSJzya8QsquTUUxbDvwac/HXjEmSX5pEGBR8ls3Jxj3IKeLoWe+
         YT23N/af2CW7F+tPiEJQ9EqZcHVpy8A7omywgJ04ElzyhF5FkoYhUGb5/kIMF3AW256U
         fn5r2WlVz6DvbCv26/T+bfv/ggR/1RdFTb3OhAH0qxekxQU9PRbQum3b9TS5pfeyoBHq
         +0ZBOZYyf43+dJAyxAQy5aHRwcjYuR8h9YMMicWiJy6qJt2bLwQWzgZ8b7lsZo+ZFoLD
         lE91EwT5aRS/NwcTzggMLZo4M9nHkJb5f+wPc051kzuk8xwGgcqSDjf8Iq92xJ58+kHy
         be6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gyBM3co0jtFEmVtQRTuXUNMSlVWNRsqFWBZpqheFeJQ=;
        fh=3UPN0VHKhD83JKXMGEfbsmc8jFyp2ywmkZ8Ho2UWU5Y=;
        b=k+sKcdcbsdp0fRLlV6KOBmnQSnHC/XbAHiDr79TqsJQnrHBbcgVO4juFHxLzV+tOLD
         qye/jVIPJuDGEa2tMgDAedTugfQ5icgemIxSUheq9pc6z1tIALia8/2aysRAO5CikQQT
         KxC4Pafpfgj0yT6VIuzO40Ca2JawIIXChGWKEmtNFMMUF4BRFxaw2AMHn6gv3JptYbwV
         cSCRjkDoZqNjiHNX84Prdr4yzoJmQqJcgxepPEdcoluHYF5JxOaZdV8BS62tFb0wQV3A
         HNdeOkm7DT15B1HmU+FRaVLTF3RGeDKC4j0xXvALVZymFbIiG9H8lq9g8J/AlWD4c/Ux
         jx1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791495660; x=1792100460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gyBM3co0jtFEmVtQRTuXUNMSlVWNRsqFWBZpqheFeJQ=;
        b=n8/F/OdWO8oAvL71RNtl6lbYZdbxp9JJ3mCCKNu4X8FWOz55LGRUjvMf5Zhh9R9c2M
         VCmMbDMLRgyjDX2He9lDRRyvFzY92351yz21Ql9Cm7k4ATGW7U4xC5pejP6zWGek73nz
         vNYkHavnVdmWaWtupPhWl8YC/ZRFl5zo/B7CM7ou/ZNnG0JhjWgpMvUwplFAGZnH/y9h
         uSF+3Snq6RYGr99QMyjc/UBfSv6wdkkBqUd52BzVSCYjjJ0FcEmfQRRq4/uAQdS4mk41
         DHym/kFjxmRGlUD9KtpOiXsuT1LcObDov3FhHjv15GYN2kMYTRcKRQtxbnGQpNse194I
         g7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791495660; x=1792100460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gyBM3co0jtFEmVtQRTuXUNMSlVWNRsqFWBZpqheFeJQ=;
        b=eZGhzjm150nspKwVV/MRaz8tnQBtdxvVZ7cQTsTxxYkrNObeWYKF4vlnw5nF9uwR3i
         ywN3HgeAKmJ/a4I2Em2QN24zM6rUShwfgboZEpQ2HjQy2+NeeJVr6J3u9LBiZUgyf5/O
         sCXktexX2blqkeVaMxP+v9N8x//JVUSS4xTaqYauQHbKf+vJNVsPLtUIu2DOhJfa4MYg
         4azUi4UyXLnPxwOqqauzkYBHpo3TXOS3C8iG6bdIcjtEwOOyfzETHTv/8X7QPcRgUyYZ
         qMgEKt1+CywNPOjXnZ+d1VnjXyXF/qROHgeMXhaigvcBH7gSlMp2sH/sD0LKrrufxpep
         /27Q==
X-Gm-Message-State: AFuF++kHOntj7lMwBoUXqOzD9aEU3NacCYXTODSgAi8qps8kz+FZd4qa
	ruYl+LeZJdHORN28B4PTBuTXhg8HIu1HakczDg0XdQryeKZHcmhuOlPoxIRLmSTbvEOiEsoBmMt
	cO7Acp/mTRacs2+JnUc4IoUNcCumemx2Ai6U5HAO5
X-Gm-Gg: AYBFou2JA3DpRNWGXMgxepaMlY2dztyeMTWRqL4Og1HvHhJmp6ws14bfU3G392P8Y9Y
	s7oAxNhUvFuqIbptH4DAcXrh1vmqX/qknaTwU2JOD3N6gzcJplMvyCT+G5MTmQuT+qz0/625kOE
	sEu04PItgcCowk9SdkG/SttErPH/aNF2ul5+GMMfhkNSI4aaD6ZIDEklT1OHB35hoGerpu0APPb
	nPTsPpqS51mj8BWjpjNdCjzr2L03A+wXmXZi6iEZY3AGhvsH+5UcWynRYV6c2UcGFH9Psac+S0d
	/+qVsZDoj1Lu/i8bSZ9QdnQFmJjR4iz1DG0HXtD0hHlTZFOVbVBDxHqZ9rMQl7g2zPvp57OxGYW
	lgg84FGkyn/nZ3g==
X-Received: by 2002:a05:6808:199c:b0:4d6:9273:251d with SMTP id
 5614622812f47-4fc46c91169mr7379369b6e.57.1791495659715; Thu, 08 Oct 2026
 14:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005210403.3206872-1-kaifengw@google.com> <179141784973.434549.3492874220530662715@kernel.org>
In-Reply-To: <179141784973.434549.3492874220530662715@kernel.org>
From: Kaifeng Wang <kaifengw@google.com>
Date: Thu, 8 Oct 2026 14:40:47 -0700
X-Gm-Features: AclHuK8cv6b3xgUvgnZyHMF_wQUTwWKnGRkc9RdLBmCevhccE2Jkqa50GwksMzw
Message-ID: <CAKkY-qOKHkuPfMk+1vhQjRymPKcG5P69CWFLYv46Xp6BiTXO5g@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: check uid and netns in net_devmem_get_binding()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org, sdf@fomichev.me, bobbyeshleman@meta.com, 
	kaiyuanz@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Could this break existing devmem TX users whose TCP socket and netlink
> socket have different owners?

This restriction is intentional. NETDEV_CMD_BIND_TX was made
unprivileged specifically so that an application can bind its own
dmabuf directly and transmit on its own sockets without needing a
separate privileged helper process. As noted in the comment above
netdev_nl_bind_tx_doit(), bind-tx is meant for the caller to transmit
"on their own sockets". We are not aware of any userspace workloads
that split bind-tx and TCP socket creation across different UIDs or
network namespaces.

> The mismatch returns the same -EINVAL as a stale ID. How would userspace
> tell these cases apart?

Returning -EINVAL on mismatch is deliberate: since dmabuf_id values
are allocated sequentially from a global xarray, returning a distinct
error code (for example -EPERM) would allow unprivileged users
to probe and enumerate active binding IDs belonging to other users.

On Wed, Oct 7, 2026 at 5:04=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch narrows who may transmit from a TX dmabuf binding.
>
> --
>
> net: devmem: check uid and netns in net_devmem_get_binding()
>
> This commit stores the network namespace and sk_uid of the netlink socket
> that created a dmabuf binding. net_devmem_get_binding() now rejects TX
> sockets whose netns or sk_uid does not match. On a mismatch it returns
> -EINVAL, the same error as a non-existent binding ID.
>
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index f4d60654ce7fd..9a773b1ce92de 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
>
> [ ... ]
>
> > @@ -220,6 +221,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, void=
 *vdev,
> >
> >       binding->dev =3D dev;
> >       binding->vdev =3D vdev;
> > +     write_pnet(&binding->net, sock_net(nl_sk));
> > +     binding->uid =3D sk_uid(nl_sk);
> >       binding->niov_shift =3D niov_shift;
> >       xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
> >
> > @@ -390,7 +393,9 @@ struct net_devmem_dmabuf_binding *net_devmem_get_bi=
nding(struct sock *sk,
> >       int err =3D 0;
> >
> >       binding =3D net_devmem_lookup_dmabuf(dmabuf_id);
> > -     if (!binding || !binding->tx_vec) {
> > +     if (!binding || !binding->tx_vec ||
> > +         !net_eq(sock_net(sk), read_pnet(&binding->net)) ||
> > +         !uid_eq(sk_uid(sk), binding->uid)) {
> >               err =3D -EINVAL;
> >               goto out_err;
> >       }
>
> [Severity: Medium]
> Could this break existing devmem TX users whose TCP socket and netlink
> socket have different owners?
>
> binding->uid comes from sk_uid(nl_sk), and the new check compares it with
> sk_uid(sk) of the sending socket. sk_uid is the socket's owner. It is set
> when the socket is created, in sock_init_data_uid(), or changed later by
> sockfs_setattr(). It is not the caller's current credentials.
>
> sock_graft() does not update sk_uid. An accepted TCP socket therefore kee=
ps
> the listener's sk_uid through sk_clone.
>
> In these setups, every devmem sendmsg through
> tcp_sendmsg_locked()->net_devmem_get_binding() would now fail with -EINVA=
L:
>
>   - A listener created by root, or through systemd socket activation, whe=
re
>     the service opens the netdev netlink socket after dropping privileges=
.
>     binding->uid is then the service uid, while the accepted socket's
>     sk_uid is 0.
>   - A privileged helper that runs bind-tx and hands the binding IDs to
>     workers running as other uids.
>   - Sockets passed between uids with SCM_RIGHTS.
>
> The mismatch returns the same -EINVAL as a stale ID. How would userspace
> tell these cases apart?
>
> Should Documentation/networking/devmem.rst be updated for the new
> requirement? It still describes the ID as:
>
>     The netlink API returns a dmabuf_id: a unique ID that refers to this
>     dmabuf that has been bound.
>
> It also lists only SO_ZEROCOPY / MSG_ZEROCOPY, plus an optional
> SO_BINDTODEVICE, as TX socket requirements.
>
> The comment above netdev_nl_bind_tx_doit() says:
>
> net/core/netdev-genl.c:
>  * shared NIC RX queues, bind-tx only DMA-maps the caller's dmabuf so the=
y can
>  * transmit from it on their own sockets without affecting other traffic =
or
>
> That is not quite the same rule as "same sk_uid and same netns".
>
> Because of the Fixes: tag, this restriction would also be backported to
> stable. Should the commit message describe the compatibility impact?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261005210403.3206872-1-kaifengw%40google.com
