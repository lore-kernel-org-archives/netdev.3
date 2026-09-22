Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CA3955D6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088756; cv=pass; b=a5Ii6Mhxwq5LYMpZdBKfKgYuweYKfQP+6GiR8cWRbeUq9FlZTPfx3Pp9816FJewuiLn8QwTThelVrban2laXOLt2r6UApycGQLrz4l9cUGzASSvY13uS7/Me8O4P28I/bJm2lExIAhOYW4znszv8o1RXS75EpkppvZ7JNMl4YQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088756; c=relaxed/simple;
	bh=7sVwErfco+8+EMVPhXwvTV1CuJJIBB3tXQZyI1MPDrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXdeVjGYyr3By/h98RNJMFUk9reN8yfDs61ZnmzH3QLkcIV3xot2oLWuwfe+VSGUqlH8OiFugMTq21BPF+1fslNQBcRjR2YOBXf1MqlEp61MOzCHBdQRqqou2vXovZmYHuBo9nHfv2NWRaoaydIm334IQEYvoAjjJX26h0BXEIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O4aIlhmd; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O4aIlhmd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d8facae850so110475ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790088754; cv=none;
        d=google.com; s=arc-20260327;
        b=Hq8mwLBqxfDICCWYL/pHG0QmAHwvNu3UyVFcNl7rKvLBiNATMoGV7lu0K8EfcGxod2
         OEs1uwVPvFPJAQJZLPDYJsApL+cWmTCfNd35xO5iUPYli0pg8hzcJqp7LI3Kdv/cWBXZ
         0MTL3geDE1YyUX/T1xmQn6bApv57dMsKH2aZiOJbWus5KX8K2CoakNteW/HWPLIYTbwQ
         EYGnDGa/A7EbULTxfgO2sHAIGz6SeaLwp7zQOtp1/VEJHwO90kIK80DAr0f4CsCH7qu0
         zi0eYle8RrPE2Mv/iVk7DRwCT/WUp4ucPgdpopHozb2m/6fLiQq4yI2fkCdsXfQCxsTN
         KmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTIoEW85SNN7D0Fwascax7ulU13Zqj41VZ1QFZ0r9YU=;
        fh=APbJliO46LkatvoEcnPoJWpXRq0vrXvKhEkedbXlMHs=;
        b=inxsnF58gsEVrnZ+c2nY5YIssJltcNNXsO7iK/nXuRANHi+omFPSbiEUSxobxTlTww
         Isc5ntcXPoAYZh88p8f8rSrNmM1SyDw0jT98eQ+1Q3JIE/qn8HN1ct5NxKGQ3xWsusAh
         1akT5mZpDxQSx04ELO6SP9OwvnjMy/jwdDRz6y2r9n/nWu3gRMIKh/HnChwDiHrYgazq
         gbIHr7rIsKPdUp7JmRzK51pMJ8KVk9C2rNMIGHHL8P2ktl/yXQ7DamcKKIIhapxXNSlm
         MHgIoYGj8Gph5ZvAgU3zwojV68bN5JhpsAn5zhD//eEAv+GEr2KN2w0dFhWQSiJc2odX
         gQVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790088754; x=1790693554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yTIoEW85SNN7D0Fwascax7ulU13Zqj41VZ1QFZ0r9YU=;
        b=O4aIlhmd/k7LGq5UZq7Evsa07K0uP5QvEUssypZ8LH7t0Ii/keSJXO04XqarW+Fsyi
         f53Twi5X2/iAGq2XWqifHm9hDBKzDN6FN84hd5EbADXRN1EFKpACy1IPx6x7N0uUsnOr
         D6C+IS6yHw32kmUYHs9nIxgEl0RGIZb3GUY8Wle0gEJvzDP0A2TIJ3zO2OtTuwP8f0dB
         pDMXBA1Ad7+ephCQr0f/YV6Y4ChdSsZiZJDG/JvWRklzjyzDZulCZ9xztf/Pp1qX+9AL
         bQ9ukpfgKb0F/2LujJ6kWaAd4ga4OmQ99RLrriX2xUwBpV6FK5XRWrxMZyJXJhlL9356
         LKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088754; x=1790693554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTIoEW85SNN7D0Fwascax7ulU13Zqj41VZ1QFZ0r9YU=;
        b=AYrnOyOz5G4a1Sy0jiry+5TU4X0edQ9caLfqzMZWUbSAGtdlG8hpY3gvGr6J5FuLkh
         bMiSmkVUz4cfglozXgAPK8RcOSFn6iuUsTgk/Qj43KfjQWpAvFP6VT6/SC0/JjEXO4HV
         CRGO8xrQ3N4SlGG6GAT2jzDNxl13bJIyZ6OEyNSIibzAm+wsQx4xZMW2X4pn4DIjtD4m
         iQccYqkQDjHm37Vz0dxvZTwT4K57E9NOQD5ViHNE4fEd4l7mBFcAM0v8dyGfhef4XBYV
         wI046ZgxqmEDPjv6RUnsd/9EwFG2MDTFZASgkM6cI9+kF+tA6L4CZSwc/ZWMRfDJofIl
         Fj3A==
X-Gm-Message-State: AFuF++nhbHp05TRvaVZN777IlzKNNxNXS+9WNdhHoK2J6NvhFy4EIjBM
	wi2c3Dc9ii9BJ+5ycuyLKXXBTSp5eXtpWaCkCgzb0kwhqzz3ZXpwerqcSQw0K/1F96ww4No59MW
	CLbfCBmFGbNFZ87Rf5BWvg7eCypkMYrgh9hQdKknX
X-Gm-Gg: AYBFou3YC0TiCH5EHQ0zR+6JMGe4F3krQQ/HWAe5RrZn+rd2BCZ3qL/pIfMifVpeVcs
	NZOWEz3qmCgQl4lh3p+G2+Wj8zJ9SuNRcUVOtTxTfzGpZUhtEBQWT49ptCWXHNnHUURZfI+ikC6
	Tz9TQhJaWV7a3aUkHRuNzXk5l2T/SOItxA02m9S9+l7pdOGJDQpKK8aSZ74/5IRh25Y8pmFmB3X
	UCJlr1jQ97rfJWUPvDoDfp1IwN8VKQcPz59b3KcEmvhr9mt9kNgufILp029oMzVJCJBWElPeyFC
	cmGkb8eupvkh3SyadKTi1ettKR1pHR4f3qJZ3YMxI6nOk5r7C9QsSYo8fypFqtABdnVfUS96HO6
	OQkR6aYLO
X-Received: by 2002:a17:902:fc8d:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2df662e3374mr1116865ad.1.1790088752668; Tue, 22 Sep 2026
 07:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921195545.493253-1-almasrymina@google.com> <179007458060.2160803.1077952399417880240@kernel.org>
In-Reply-To: <179007458060.2160803.1077952399417880240@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Sep 2026 07:52:16 -0700
X-Gm-Features: AcwNN1V4Ci3W10Pgy9sSkPzuwcP_7GXIolq8-v2uiIIScOXhlMj8k7qpggL2nHY
Message-ID: <CAHS8izP5KFE13qp0H6WY8iTYi22_YQyCYfhrG3KzOgwd-uybRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: devmem: document that bind-tx is
 unprivileged by design
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	donald.hunter@gmail.com, sdf@fomichev.me, razor@blackwall.org, 
	daniel@iogearbox.net, bobbyeshleman@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:56=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] NETDEV_CMD_BIND_TX is unprivileged (net/core/netdev-genl-
>   gen.c:240-245: .flags =3D GENL_CMD_CAP_DO), and this patch cements that=
=E2=80=A6
> - [Medium] The comment added above netdev_nl_bind_tx_doit()
>   (net/core/netdev-genl.c:1183-1188) and the mirrored note in=E2=80=A6
> - [Medium] bind-tx is reachable by any unprivileged user
>   (net/core/netdev-genl-gen.c:244: .flags =3D GENL_CMD_CAP_DO) with no=E2=
=80=A6
>
> --
>
> net: devmem: document that bind-tx is unprivileged by design
>
> This adds a comment above netdev_nl_bind_tx_doit() and a matching note in
> Documentation/netlink/specs/netdev.yaml stating that NETDEV_CMD_BIND_TX
> carries no GENL_ADMIN_PERM / GENL_UNS_ADMIN_PERM on purpose, on the groun=
ds
> that bind-tx only DMA-maps the caller's dmabuf.
>
> A few questions about the rationale being recorded here.
>
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index e13461cf3fc33..4303593e5003c 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -852,6 +852,8 @@ operations:
> >        name: bind-tx
> >        doc: Bind dmabuf to netdev for TX
> >        attribute-set: dmabuf
> > +      # Intentionally unprivileged (no admin-perm / uns-admin-perm); s=
ee
> > +      # comment above netdev_nl_bind_tx_doit().
> >        do:
> >          request:
> >            attributes:
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index fa9edfdb32c29..690c27f63d260 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -1180,6 +1180,12 @@ netdev_find_netmem_tx_dev(struct net_device *dev=
)
> >       return NULL;
> >  }
> >
> > +/* Note: NETDEV_CMD_BIND_TX is intentionally unprivileged (no
> > + * GENL_ADMIN_PERM / GENL_UNS_ADMIN_PERM). Unlike bind-rx, which confi=
gures
> > + * shared NIC RX queues, bind-tx only DMA-maps the caller's dmabuf so =
they can
> > + * transmit from it on their own sockets without affecting other traff=
ic or
> > + * device state.
> > + */
>
> [Severity: High]
> Is the "on their own sockets" part of this rationale actually enforced
> anywhere?
>
> net_devmem_bind_dmabuf() in net/core/devmem.c allocates the id out of a
> single global xarray and only records the owning netlink socket for clean=
up:
>
>         err =3D xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id=
,
>                               binding, xa_limit_32b, &id_alloc_next,
>                               GFP_KERNEL);
>         ...
>         list_add(&binding->list, &priv->bindings);
>
> priv->bindings is then only walked by netdev_nl_sock_priv_destroy().
>
> On the TX side, net_devmem_get_binding() resolves whatever u32 the sender
> passed and checks only that a tx_vec exists and that the route egresses t=
he
> bound device:
>
>         binding =3D net_devmem_lookup_dmabuf(dmabuf_id);
>         if (!binding || !binding->tx_vec) {
>                 err =3D -EINVAL;
>                 goto out_err;
>         }
>         ...
>         dst_dev =3D dst_dev_rcu(dst);
>         if (unlikely(!dst_dev) ||
>             unlikely(dst_dev !=3D READ_ONCE(binding->dev) &&
>                      dst_dev !=3D READ_ONCE(binding->vdev))) {
>                 err =3D -ENODEV;
>
> and net_devmem_lookup_dmabuf() is a plain xa_load() with no credential,
> netns or creator comparison.
>
> So can an unrelated unprivileged process reach another user's binding lik=
e
> this?
>
>   process A: NETDEV_CMD_BIND_TX -> gets id N, keeps the netlink socket op=
en
>   process B: sendmsg(MSG_ZEROCOPY) with SCM_DEVMEM_DMABUF carrying id N
>
> __sock_cmsg_send() in net/core/sock.c takes the bare id:
>
>         case SCM_DEVMEM_DMABUF:
>                 if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u32)))
>                         return -EINVAL;
>                 sockc->dmabuf_id =3D *(u32 *)CMSG_DATA(cmsg);
>
> tcp_sendmsg_locked() then calls net_devmem_get_binding(sk, sockc.dmabuf_i=
d)
> and zerocopy_fill_skb_from_devmem() builds frags from the resulting niovs=
 at
> attacker-chosen offsets. If B's route egresses the same netdev, does this
> let B transmit the contents of A's dmabuf to a peer of B's choosing?
>
> Ids are allocated cyclically starting low, and the return codes differ
> (-EINVAL for an unknown or non-TX id, -ENODEV for the wrong device), so i=
s
> guessing a live id cheap? Should the TX path check the binding against it=
s
> creating netdev_nl_sock before this is documented as safe, or should the
> command grow a permission flag instead?
>

This is a pre-existing issue that we can tighten up in the future. It
technically may be possible that 1 socket guesses the binding id of
another socket.

> [Severity: Medium]
> Separately from the enforcement question above, is the wording here wider
> than what the code does?
>
> Two parts look overstated:
>
> "so they can transmit from it on their own sockets" - nothing in
> net_devmem_get_binding() ties a binding to the socket, task, uid, netns o=
r
> cgroup that created it; the u32 id from the global xarray is the only
> credential.
>
> "without affecting other traffic or device state" -
> netdev_find_netmem_tx_dev() can resolve the bind target to a different,
> shared physical NIC via an rx queue lease:
>
>                 phys_dev =3D lease_rxq->dev;
>                 if (netif_device_present(phys_dev) &&
>                     phys_dev->netmem_tx =3D=3D NETMEM_TX_DMA)
>                         return phys_dev;
>
> and net_devmem_bind_dmabuf() then runs dma_buf_attach() and
> dma_buf_map_attachment_unlocked() against that physical device's dma_dev.
>
> Would it be more accurate to state the narrow property that bind-tx does
> not reconfigure RX queues or steering, rather than claiming no effect on
> other traffic or device state? The same wording is mirrored into the uAPI
> spec in Documentation/netlink/specs/netdev.yaml, so it becomes the answer
> future readers get when they ask why this command has no permission flag.
>

Ugh, commit message can be tighten up a bit but it doesn't matter. The
critical point is that bind-tx doesn't make the appliaction take
ownership of an rx queue, unlike bind-rx.

> [Severity: Medium]
> Does anything bound how many times an unprivileged caller can do this, or
> account the memory it consumes?
>
> net_devmem_bind_dmabuf() can be called repeatedly on the same dmabuf FD, =
and
> each call allocates with plain GFP_KERNEL / kvmalloc, so none of it is
> charged to the caller's memcg:
>
>                 binding->tx_vec =3D kvmalloc_objs(struct net_iov *,
>                                                 dmabuf->size / PAGE_SIZE)=
;
>         ...
>                 owner->area.niovs =3D kvmalloc_objs(*owner->area.niovs,
>                                                   owner->area.num_niovs);
>
> and each call installs another mapping on the shared device:
>
>         binding->attachment =3D dma_buf_attach(binding->dmabuf, dma_dev);
>         ...
>         binding->sgt =3D dma_buf_map_attachment_unlocked(binding->attachm=
ent,
>                                                        direction);
>
> There is no duplicate-binding check, no count limit on entries added to
> priv->bindings, no __GFP_ACCOUNT, and no RLIMIT_MEMLOCK accounting for th=
e
> long-lived mapping. With the rx-lease path in netdev_find_netmem_tx_dev()
> these mappings land on the physical NIC shared with other users.
>
> Given that, is "without affecting other traffic or device state" the righ=
t
> thing to document, or should a per-socket or per-user cap and memcg
> accounting come first?
>

I don't see an issue here. Binding one dmabuf to many netdevs should
be fine. Binding one dmabuf to the same netdev many times is possible
but pointless.


--=20
Thanks,
Mina
