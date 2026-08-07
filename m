Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72942941A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126999; cv=pass; b=i+znX4LH1pENyoDGxWw4nIsXH87hnBy6G6gX4H7ASfe6YeXlEoksj0ici7suqxk1J4O4RB5UVDUuvp8azywxJVjxWxJOX9MUS4Kz4ELI6cvEyIvvxf1kGQ247yohiZHMx/inFy9t7LTwSqVSv99LJ+FelC+ZMCSoYeKXjeyRG6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126999; c=relaxed/simple;
	bh=32zBXvUWF6Xby5oxD8amRb7/3tUOkMTSfjQN/x2XNbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg0ErdydrAxjXD3BtuLb//PesfCacwphh64ZD7rS8KazaMbFauhh7WVzBovemm6LJv6yEzjivzZCKLMtEGxnGQk5JIqpA6hnNqSFJ8y7GfsC7X952E7HeaofZzUsPRFO332R2aZtRRs/qGMl4So8MiB7d11MgsgeUvFW2VLaZik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=EL79/qSE; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="EL79/qSE"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-754acc61e10so1488270137.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786126996; cv=none;
        d=google.com; s=arc-20260327;
        b=Y10evl+wB9G8K0qUQtTIc5WbKAW9UPZFwrS16fMQSdATNDXDJxAQA6ttd7vvDhbn7O
         EmmpYkmjSv1Dpoadl/GIMAj1/xaJ2G3r+jXa0FgQNEptmdAeuBE+LHxCRUfQvzKwFSvb
         EY+vHm79y04rGHL9gXGG/iue4b5OMj1RVnjY7yJj1l6fOed+5f6fwxvjFkRyZgbfEDSA
         x7bjOX86Fk2UHzrCRJq0XhFEUlsxZ9jjkG3mf+kYrfg7Gs462uaUu+/qNJeFERRKh5kv
         3meosgqj1P36DJ8DUI7rUmptbD+DiqydxGYOEzZ+V5Bfedw5hS7fIJePsSGHj0LE5R9V
         e4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vL74o9hL7azdfSExD/suMvpd2yIO53BJuJUlfuAhmPg=;
        fh=RNRDstDh6/mVTGDTxNOJzVFGFMLrZRCriDHrlRp+koM=;
        b=r7l6svgV8AlIqAOh1QUQko0s7sMi57M+v2WbM+yFXqIm+F8EYwiy4aINjjpcrNpjuF
         o6Yc5CR1lqRQucOL2/Pgaf4pcxW4kPQohXS0HCc9oV/3RBOUIhujGHsL8TBQyCuDRQVv
         HbafEvPTGf7xZtlDe/fcpw7h1+GKC3P1hmu7BbFElYph8a8ff10tDxEoC0jHJlz/LjoU
         RsUYfSu12gvOFJbpIKWxv44iKrnHbWP1Z5jTY7/p8uyuZDNXQiQwLNCEqszR5Vtll1Y4
         CeFgpcM9NhaSEgmpABwLDjAJiMt0zQA4l/piC8SqN2Hjs4HHYZzJDTYhlERtzw4J0N7p
         /61g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1786126996; x=1786731796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vL74o9hL7azdfSExD/suMvpd2yIO53BJuJUlfuAhmPg=;
        b=EL79/qSEgd0lVt9WtZqRv8QkKQm6LkuVSenCMeYKlGOkjRvWGG/lW86S4BmzNu7wa8
         2h35kn821czJhEDUaLzVzU/o891Fh22tqPf5IZV84tns/KEYS8OtSDgFzyZWrMV+VkDX
         YNo+g7TwxOVn+0fKZimKpr1HVIMDJXlQQu1e+wavqlrniqfZOZt4UJrMldBk1f0yVcJ7
         fkS1NKfNLh9mIPI0L3TPyg3nSFOQQyHhSAA5mLOzSFdCtUw0hnZ+NqBRL5sBiqA2zPSp
         qLmXlOZOi8Oc9nwgoPp4oXZ+Ep3iRsq74pzaVWOHeZl1qOQvUo67BMoNS/BNDHJUoV6O
         nUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126996; x=1786731796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vL74o9hL7azdfSExD/suMvpd2yIO53BJuJUlfuAhmPg=;
        b=VSg5Ct6DlnP8CDaC28BadnoaH4EYxUtInJvXlUSY0CwZ9JIgiyy6544P2qJLXVKZGn
         FiRisVpNw7S/ZUhkt0TtjsvkhkGAvTKfdCt4uxH1tJRW4fgJa/x1JvoI05kJIHh4AjKf
         OpBRV9j/OqkQxJB0WUwKVMVbM6/DJAmHAdWijpxaTlWRtVj+hdL6Gj3lbbF4NwYxbJUw
         3P0e/HCxi2L1wIOxsNEZNfeBeysaNPYaZ1EZ3NAkq1dzMtoDu6KsGFplNWILUgkaBdqS
         i9N7k6v/bIW+c1xtS07nW6UxqQ3tmJ2meB8hUPw45R/BPR/1pTVO1m0PQ8BV86+KbzDs
         TsTA==
X-Gm-Message-State: AOJu0Yz2z6ZVqX9jvoYZvUJNQBChQu12Z+3lrOyfHvhk8+UBh9iDvINP
	Zs12pjvqtXB+9olgyR0BWuyFMybQdEJJTndw5rmYUg0Xequ+1S26PdYRAzq6X2kd7jAdvboO2Nu
	qMSLoO9Y6rqyOY3uZnSV46H7EWnuUTIb6tGD8+hYApQ==
X-Gm-Gg: AR+sD130+8alLx+SepUYK7dc4r6Q7pfoOP/rqlLWKVTSvUEb1Bar4R6S7jKBm2zdrQX
	6tz8LZikyzBn+3+dgcHVRl6qSisaWSS5EMl54uCE9JZ/55l/hdfuLalIGi24tgrx2rYMtJa8Evk
	+UaKPtUpbl71w2auj6lV1zssnznI01twadOBlT5yYQB8Vb3ZYZGapnphsQtNiAuH/CB6eSCaHWf
	4vy96VXP9FnQ+ag07CYpl1fIXGhi8tL+iHSttu5zXL6SPYzi3GP3Slm3px2nIViDrNOxa3gq8OK
	ENKykU02uy4L8U6RWtXmNILWlxl8GxbHGFVh4katreGnLHnWFh0wvp9/H8oJPnDr5i9jHeb/zPq
	+O2ExXnCxL1LIVl58jXuHG+XTqhLXN3WcpuUudnS6yvfYsHvW8n/NlZR1FXfMnV/twrJTWCLmC3
	qZLlLoNv8PaFCwAU8/u2h62eCQeutR
X-Received: by 2002:a05:6102:3e1d:b0:739:15ef:cdfb with SMTP id
 ada2fe7eead31-764e5a4fc95mr946450137.5.1786126995140; Fri, 07 Aug 2026
 11:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709205325.1591196-8-rjethwani@purestorage.com> <20260723091548.68912-1-pabeni@redhat.com>
In-Reply-To: <20260723091548.68912-1-pabeni@redhat.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Fri, 7 Aug 2026 11:23:04 -0700
X-Gm-Features: AUfX_mxJ-u2C8h_P8ShxDVXHpoDBURmk5aHzB9vtRB8SCSfKqTO9eU9ErB2a2vo
Message-ID: <CAKaoeS0czD+ksg=R=Vu+HH0nJfa0+q1i03u9cw0stiAiUjOVsg@mail.gmail.com>
Subject: Re: [PATCH v15 7/9] tls: device: add RX KeyUpdate support
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@google.com, 
	leon@kernel.org, andrew.gospodarek@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:16=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> tls: device: add RX KeyUpdate support
>
> Adds RX KeyUpdate support for TLS device offload, retaining the old
> AEAD/IV/rec_seq on tls_offload_context_rx so in-flight records that the
> NIC already decrypted with the old key can still be processed, and
> deferring installation of the new key until copied_seq crosses
> old_nic_boundary.
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/=
drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> > index 337201f12895..71c9d3ca947d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
> > @@ -86,10 +86,20 @@ static int mlx5e_ktls_resync(struct net_device *net=
dev,
> >       return 0;
> >  }
> >
> > +static void mlx5e_ktls_rx_rekey_fixup(struct sk_buff *skb)
> > +{
> > +     struct sk_buff *frag_iter;
> > +
> > +     skb->decrypted =3D 1;
> > +     skb_walk_frags(skb, frag_iter)
> > +             frag_iter->decrypted =3D 1;
> > +}
> > +
> >  static const struct tlsdev_ops mlx5e_ktls_ops =3D {
> >       .tls_dev_add =3D mlx5e_ktls_add,
> >       .tls_dev_del =3D mlx5e_ktls_del,
> >       .tls_dev_resync =3D mlx5e_ktls_resync,
> > +     .tls_dev_rx_rekey_fixup =3D mlx5e_ktls_rx_rekey_fixup,
> >  };
>
> [Medium]
> Is this RX rekey infrastructure safe to enable unconditionally for every
> HW-offloaded TLS RX socket?  Only mlx5 implements tls_dev_rx_rekey_fixup
> here.  Other in-tree drivers that advertise NETIF_F_HW_TLS_RX (for
> example nfp) will still enter the rekey state machine with a NULL
> fixup pointer, so the whole-record-mangled-by-NIC scenario the fixup
> was introduced to handle would be uncovered on those NICs.
>
> Would gating RX rekey on explicit driver opt-in (a capability flag or
> the presence of tls_dev_rx_rekey_fixup) be more appropriate than
> assuming all NICs behave like ConnectX-6 Dx?

RX KeyUpdate is TLS 1.3-only, the state machine is armed exclusively
by a TLS 1.3 post-handshake KeyUpdate; in TLS 1.2 old_aead_recv
is never set and the fixup site is never reached. Among in-tree
drivers advertising NETIF_F_HW_TLS_RX, only mlx5 supports TLS 1.3
offload, nfp rejects anything but TLS 1.2,
so it cannot enter this path. The fixup is genuinely optional: it
re-asserts skb->decrypted for an mlx5 mixed-record auth-failure quirk.
I've
separately verified on Broadcom Thor2 (TLS 1.3 RX) that no fixup is
needed there, confirming it's device-specific rather than a generic
capability gap.

> [ ... ]
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index ef837bbd9560..74583433b593 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -66,8 +66,14 @@ static void tls_device_free_ctx(struct tls_context *=
ctx)
> >               kfree(offload_ctx);
> >       }
> >
> > -     if (ctx->rx_conf =3D=3D TLS_HW)
> > -             kfree(tls_offload_ctx_rx(ctx));
> > +     if (ctx->rx_conf =3D=3D TLS_HW) {
> > +             struct tls_offload_context_rx *offload_ctx =3D
> > +                     tls_offload_ctx_rx(ctx);
> > +
> > +             memzero_explicit(&offload_ctx->rekey,
> > +                              sizeof(offload_ctx->rekey));
> > +             kfree(offload_ctx);
> > +     }
>
> [Medium]
> Can this silently overwrite offload_ctx->rekey.old_aead_recv without
> first freeing it?
>
> memzero_explicit() clears the field but does not call crypto_free_aead(),
> so if any path reaches tls_device_free_ctx() with old_aead_recv still
> non-NULL, the crypto_aead transform and the AEAD key material it holds
> are leaked, and the explicit-zero intent is defeated for that material.
>
> Current callers appear to free old_aead_recv earlier in
> tls_device_offload_cleanup_rx(), so no leak fires today.  Would it be
> safer to call crypto_free_aead(offload_ctx->rekey.old_aead_recv)
> before the memzero_explicit(), to make this robust against future
> paths (for example races between tls_device_down and sk_destruct)?

No leak today but I'll add a defensive crypto_free_aead() before the memzer=
o.

> [ ... ]
>
> > +static int tls_device_dev_add_rx(struct sock *sk, struct tls_context *=
tls_ctx,
> > +                              struct net_device *netdev,
> > +                              struct tls_crypto_info *crypto_info,
> > +                              u32 cur_seq, bool is_rekey)
> > +{
> [ ... ]
> > +     if (!rc) {
> > +             clear_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
> > +             clear_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
> > +             if (is_rekey)
> > +                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYO=
K);
> > +     } else if (is_rekey) {
> > +             set_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
> > +             set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK)=
;
> > +     }
> > +     return rc;
> > +}
>
> [Medium]
> Is TLS_RX_DEV_CLOSED being repurposed in a way that could confuse
> existing consumers?
>
> Previously the bit denoted permanent teardown, used by tls_device_down()
> and tls_device_offload_cleanup_rx() to avoid a double tls_dev_del.  This
> patch also sets/clears it as a transient state during rekey (set before
> tls_dev_del in the rekey path, cleared inside tls_device_dev_add_rx() on
> success, and toggled by tls_device_rx_del_key() when a KeyUpdate record
> is parsed), while other checks (tls_device_rx_resync_new_rec early
> return, tls_device_offload_cleanup_rx skip-dev_del logic) still treat it
> as terminal.
>
> Would splitting the transient rekey state into a separate bit make the
> semantics less error-prone for future changes?

I don't think a separate bit is needed, the premise that
TLS_RX_DEV_CLOSED meant "permanent teardown" isn't quite right. It has
always meant the
narrower, non-terminal invariant:

  tls_dev_del was called for RX =E2=86=92 the NIC currently holds no RX off=
load context.

"Permanent" was just emergent, since teardown used to be the only
caller of tls_dev_del. The rekey path uses the bit with that same
meaning: it sets the
bit because it actually calls tls_dev_del, and clears it because
tls_dev_add actually re-establishes the NIC context.

The readers you flagged stay correct under this, because they key off
"NIC context absent," not "socket dead":
  - resync early return: you must not resync a NIC with no context, so
suppressing it during the rekey window is exactly right.
  - cleanup_rx skip-dev_del: correct double-del guard if the socket
closes mid-rekey.

A separate transient bit would have identical set/clear points and add
a new "keep the two in sync" hazard.

Your point about the name/comment reading as terminal is fair, so I'll
tighten the comment to state the invariant explicitly.

> [ ... ]
>
> > +void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx)
> > +{
> [ ... ]
> > +     set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
> > +     synchronize_net();
> > +     netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> > +                                     TLS_OFFLOAD_CTX_DIR_RX);
> > +     up_read(&device_offload_lock);
> > +}
>
> [ ... ]
>
> > +static int tls_device_reencrypt_old_key(struct sock *sk,
> > +                                     struct tls_offload_context_rx *ct=
x,
> > +                                     struct tls_sw_context_rx *sw_ctx,
> > +                                     struct tls_context *tls_ctx)
> > +{
> > +     struct crypto_aead *saved_aead =3D sw_ctx->aead_recv;
> > +     char saved_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
> > +     char saved_rec_seq[TLS_MAX_REC_SEQ_SIZE];
> > +     int ret;
> [ ... ]
> > +     sw_ctx->aead_recv =3D saved_aead;
> > +     memcpy(tls_ctx->rx.iv, saved_iv, sizeof(saved_iv));
> > +     memcpy(tls_ctx->rx.rec_seq, saved_rec_seq, sizeof(saved_rec_seq))=
;
> > +
> > +     if (ret)
> > +             return ret;
> [ ... ]
> > +     return 0;
> > +}
>
> [Low]
> Should saved_iv[] and saved_rec_seq[] be scrubbed with
> memzero_explicit() before this function returns?
>
> They hold TLS 1.3 traffic-secret-derived IV material copied from
> tls_ctx->rx.iv and rx.rec_seq.  Elsewhere in this subsystem
> memzero_explicit() is used consistently to scrub such material
> (tls_ctx_free, tls_sw_ctx_finalize, and the new memzero on
> offload_ctx->rekey in tls_device_free_ctx).  Leaving the buffers
> un-scrubbed on the stack seems inconsistent with the surrounding
> hygiene.

  I'd rather leave this as-is. Neither buffer holds sensitive material:
  saved_rec_seq is the record sequence counter, and saved_iv is the
  static IV/salt, whose secrecy AEAD security doesn't depend on (the
  nonce is effectively public), the actual secret is the key, which
  never touches these buffers.

  The identical bytes also live in tls_ctx->rx.iv / rx.rec_seq for the
  whole connection and aren't scrubbed there either; tls_ctx_free() only
  zeroes crypto_send/crypto_recv, not the tx/rx working copies. So
  scrubbing the transient stack copy wouldn't close a real gap, just add
  inconsistency with how the live copies are handled.

> > +
> >  int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
> >  {
> >       struct tls_offload_context_rx *ctx =3D tls_offload_ctx_rx(tls_ctx=
);
> >       struct tls_sw_context_rx *sw_ctx =3D tls_sw_ctx_rx(tls_ctx);
> >       struct sk_buff *skb =3D tls_strp_msg(sw_ctx);
> > +     u32 copied_seq =3D tcp_sk(sk)->copied_seq;
> >       struct strp_msg *rxm =3D strp_msg(skb);
> >       int is_decrypted, is_encrypted;
> > +     u32 rec_start_seq;
> >
> >       if (!tls_strp_msg_mixed_decrypted(sw_ctx)) {
> >               is_decrypted =3D skb->decrypted;
> > @@ -1098,10 +1225,42 @@ int tls_device_decrypted(struct sock *sk, struc=
t tls_context *tls_ctx)
> >               is_encrypted =3D 0;
> >       }
> >
> > -     trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full=
_len,
> > +     rec_start_seq =3D sw_ctx->strp.copy_mode
> > +             ? copied_seq - rxm->full_len
> > +             : copied_seq;
> > +
> > +     trace_tls_device_decrypted(sk, rec_start_seq,
> >                                  tls_ctx->rx.rec_seq, rxm->full_len,
> >                                  is_encrypted, is_decrypted);
>
> [Medium]
> Is this an intentional silent change to the first argument of the
> trace_tls_device_decrypted() tracepoint?
>
> The previous expression was unconditionally copied_seq - rxm->full_len;
> the new form is copied_seq for the non-copy_mode case.  Observability
> tools consuming this tracepoint may see a different value for the same
> record boundary.
>
> The same rec_start_seq is also fed into the classification below via
> before(rec_start_seq, ctx->rekey.old_nic_boundary).  If either branch of
> the ternary is off by one full record, the record would be routed to
> the wrong rekey path (drop-and-increment-old-seq vs reencrypt-with-old
> -key).  Could the commit message describe why the two modes use
> different formulas, and how the choice was validated?

The key fact is that tcp_sk(sk)->copied_seq is advanced at different times =
in
the two strparser modes, so the same subtraction cannot describe the record
start in both:

  - copy_mode: the record's bytes are pulled out of the TCP receive queue u=
p
  front, before tls_device_decrypted() runs. tls_strp_msg_cow() calls
  tcp_read_done(sk, stm.full_len) (tls_strp.c:135), which bumps copied_seq =
by
  full_len. So at decrypt time copied_seq already sits at the end of the
  current record, and copied_seq - full_len is the record start.
  - non-copy mode: tcp_read_done() is deferred to tls_strp_msg_consume()
  (tls_strp.c:599-600), which runs after the record is processed. The ancho=
r is
  loaded starting at copied_seq (tls_strp_load_anchor_with_queue(),
  tls_strp.c:466 =E2=80=94 the offset there is the byte position of copied_=
seq within
  its skb, not a seq delta to the record). So at decrypt time copied_seq st=
ill
  points at the start of the record, and no subtraction is wanted.

  So the ternary is not off by a record, both branches compute the same
  logical quantity (the sequence number of the first byte of the record),
  compensating for copied_seq's differing meaning. The before(rec_start_seq=
,
  old_nic_boundary) classification is therefore fed a consistent value in b=
oth
  modes.

  On the observability concern: the value did change for the non-copy path,=
 and
  that's actually a fix. The old unconditional copied_seq - full_len was
  correct only in copy_mode; on the non-copy fast path (the common case) it
  pointed one full record too early. This series makes that argument
  load-bearing for rekey routing, so it had to be corrected.

  I'll add a note to the commit message spelling this out.

> >
> > +     if (unlikely(ctx->rekey.old_aead_recv)) {
> > +             bool before_nic_boundary =3D
> > +                     before(rec_start_seq, ctx->rekey.old_nic_boundary=
);
> > +
> > +             if (before_nic_boundary) {
> > +                     if (is_encrypted) {
> > +                             tls_bigint_increment(ctx->rekey.old_rec_s=
eq,
> > +                                                  tls_ctx->prot_info.r=
ec_seq_size);
> > +                             return 0;
> > +                     }
> > +
> > +                     /* rekey_fixup sets decrypted flags in case if NI=
C clears
> > +                      * decrypted flags on auth failure
> > +                      */
> > +                     if (!is_decrypted && ctx->rekey.rekey_fixup)
> > +                             ctx->rekey.rekey_fixup(skb);
> > +
> > +                     return tls_device_reencrypt_old_key(sk, ctx,
> > +                                                         sw_ctx, tls_c=
tx);
> > +             }
>
> [High]
> Does the classification here miss the whole-record NIC-auth-failure
> case?
>
> The comment and the mlx5e_ktls_rx_rekey_fixup callback state that the
> NIC may clear skb->decrypted on auth failure.  If the NIC has already
> XORed the payload with the old key's keystream and then cleared
> skb->decrypted on every fragment (not mixed), is_encrypted computes as
> 1 in the !tls_strp_msg_mixed_decrypted branch:
>
>     if (!tls_strp_msg_mixed_decrypted(sw_ctx)) {
>         is_decrypted =3D skb->decrypted;   /* 0 */
>         is_encrypted =3D !is_decrypted;    /* 1 */
>     }
>
> The code then advances old_rec_seq and returns 0, feeding the record to
> SW which will attempt decryption with the new key and fail AEAD
> verification.  Only the mixed sub-case reaches ctx->rekey.rekey_fixup.
> Should the whole-record path also invoke rekey_fixup and
> reencrypt-with-old-key?

You're right that a non-mixed record with skb->decrypted clear lands
in the is_encrypted branch and gets handed straight to
SW. The reason that's safe comes down to what the NIC actually does on
auth-failure clearing.

The premise in the fixup comment ("NIC clears decrypted flags on auth
failure") only ever manifests as a mixed record on this hardware, the
NIC never
clears decrypted uniformly across all fragments of a record after
having XORed the payload with the old key. I confirmed this on
ConnectX-6 Dx across
repeated KeyUpdate cycles: auth-failure clearing always produces a
mixed record, which is classified as neither is_encrypted nor
is_decrypted and
therefore falls through to the rekey_fixup + reencrypt_old_key path,
exactly the path you're pointing at.

So a non-mixed decrypted=3D=3D0 record is genuinely untouched wire
ciphertext: the NIC never touched the payload, and SW can decrypt it
directly after
advancing old_rec_seq. The whole-record XOR-then-clear case you
describe doesn't occur, so it would never reach the is_encrypted
fast-path.

That said, the invariant was implicit and load-bearing, which is what
made your question necessary in the first place. I'll add a comment at
the branch
spelling it out.

> [Medium]
> Can old_rec_seq drift after tls_device_rx_del_key() has already torn
> down the NIC key?
>
> Sequence:
>
>   1. KeyUpdate is parsed by SW; tls_check_pending_rekey() ->
>      tls_device_rx_del_key() calls tls_dev_del, so the NIC no longer
>      holds any key.
>
>   2. Records that arrive next are wire-encrypted with the peer's new
>      key and reach tls_device_decrypted() with is_encrypted =3D=3D 1 whil=
e
>      rec_start_seq is still before old_nic_boundary.
>
>   3. This code increments ctx->rekey.old_rec_seq for each such record.
>
> If any later record in the same window turns out to be mixed
> (!is_encrypted && !is_decrypted), tls_device_reencrypt_old_key() will
> use the inflated old_rec_seq as the AES-GCM nonce input.  Would that
> produce ciphertext that does not match what the NIC actually XORed with
> the old key?

No, old_rec_seq isn't inflated, and the mixed record can't appear
after the encrypted ones in that window.

old_rec_seq tracks the TLS record sequence number, which advances by
one for every record regardless of key. Both before-boundary paths
step it by exactly
one per record: the is_encrypted branch increments and returns 0, and
tls_device_reencrypt_old_key() increments after re-running the AEAD.
So the
increment on encrypted records is required to keep old_rec_seq aligned
with the record a later reencrypt would touch, omitting it is what
would desync
the nonce.

The ordering in the scenario also can't happen.
tls_device_rx_del_key() removes the NIC key at KeyUpdate, and it's
only re-added by the deferred
tls_device_deferred_dev_add_rx() once rec_start_seq crosses
old_nic_boundary. For the whole before-boundary window the NIC holds
no key, so records there
are untouched wire ciphertext (is_encrypted =3D=3D 1). A record can only
be mixed (!is_encrypted && !is_decrypted) if the NIC XORed part of it
with the old
key, which requires the old key to still be installed. So in sequence
order you get old-key (decrypted/mixed) records, then the KeyUpdate,
then new-key
encrypted records; you can't get a new-key encrypted record followed
by an old-key mixed record before the boundary.

The genuinely mixed case, a record straddling old_nic_boundary, feeds
the reencrypt path with the correct old_rec_seq, since every prior
before-boundary
record stepped it by one.

> > +
> > +             crypto_free_aead(ctx->rekey.old_aead_recv);
> > +             ctx->rekey.old_aead_recv =3D NULL;
> > +
> > +             if (ctx->dev_add_pending)
> > +                     tls_device_deferred_dev_add_rx(sk, tls_ctx, ctx);
> > +     }
> > +
>
> [ ... ]
>
> > @@ -1612,29 +1789,88 @@ int tls_set_device_offload_rx(struct sock *sk, =
struct tls_context *ctx)
> [ ... ]
> > +     rc =3D tls_sw_ctx_init(sk, 0, new_crypto_info);
> >       if (rc)
> >               goto release_ctx;
> >
> > -     rc =3D netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CT=
X_DIR_RX,
> > -                                          &ctx->crypto_recv.info,
> > -                                          tcp_sk(sk)->copied_seq);
> > -     info =3D (void *)&ctx->crypto_recv.info;
> > -     trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
> > -                                  tcp_sk(sk)->copied_seq, info->rec_se=
q, rc);
> > -     if (rc)
> > -             goto free_sw_resources;
> > +     if (!context->dev_add_pending) {
> > +             rc =3D tls_device_dev_add_rx(sk, ctx, netdev, src_crypto_=
info,
> > +                                        copied_seq, !!new_crypto_info)=
;
> > +             if (!new_crypto_info) {
> > +                     if (rc)
> > +                             goto free_sw_resources;
> > +                     tls_device_attach(ctx, sk, netdev);
> > +             }
> > +     } else if (!was_dev_add_pending) {
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRES=
S);
> > +     } else {
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
> > +     }
> > +
> > +     tls_sw_ctx_finalize(sk, 0, new_crypto_info);
>
> [High]
> Does this path silently swallow a real HW rekey failure?
>
> When new_crypto_info !=3D NULL and dev_add_pending is 0,
> tls_device_dev_add_rx() is called and rc is stored, but the immediate
> error handling is guarded by if (!new_crypto_info).  On the rekey path
> control falls through to tls_sw_ctx_finalize() and eventually the
> return 0 at the end of the success block.
>
> Meanwhile tls_device_dev_add_rx() has already bumped
> LINUX_MIB_TLSRXREKEYFALLBACK and set TLS_RX_DEV_DEGRADED /
> TLS_RX_DEV_CLOSED, and the NIC-side context has been torn down.
>
> In do_tls_setsockopt_conf() the intended contract is:
>
>     } else if (update && ctx->rx_conf =3D=3D TLS_HW) {
>         /* HW rekey failed - return the actual error.
>          * Cannot fall back to SW for an existing HW connection.
>          */
>         goto err_crypto_info;
>     }
>
> But because rc is effectively discarded, that branch is never taken =E2=
=80=94
> setsockopt() returns 0, rx_conf stays TLS_HW, and telemetry, return
> code and state are all inconsistent.  Should the rekey branch also
> propagate rc (for example goto release_ctx / err_crypto_info) when
> tls_device_dev_add_rx() fails?

The mechanical observation is correct, on the rekey path rc from
tls_device_dev_add_rx() is intentionally not propagated,
but this is by design, not a swallowed failure.

The TLS_RX_DEV_DEGRADED | TLS_RX_DEV_CLOSED bits that tls_device_dev_add_rx=
()
sets on failure are the existing degraded-mode mechanism. Once set, HW
resync is skipped and records are decrypted in software via
sw_ctx->aead_recv,
which on this path was just installed with the new key by
tls_sw_ctx_init()/tls_sw_ctx_finalize(). So the connection keeps
working under the new key, just
in SW. That is exactly what LINUX_MIB_TLSRXREKEYFALLBACK counts.

So {REKEYFALLBACK++, return 0, rx_conf =3D=3D TLS_HW} isn't inconsistent,
it's the definition of a degraded HW-offload connection (same as
non-rekey degraded
mode): still an offload context, decrypting in SW. Returning 0 is
correct because the rekey succeeded from the socket's point of view.

The rekey path does return an error, via goto release_ctx, when
tls_sw_ctx_init() itself fails (e.g. ENOMEM). That's the only case
where the else if
(update && ctx->rx_conf =3D=3D TLS_HW) branch in do_tls_setsockopt_conf()
fires for RX, and there returning the error is correct because the SW
fallback
couldn't be built.

> [Medium]
> Can TLSRXREKEYOK be double-counted, and TLSRXREKEYINPROGRESS leak?
>
> When was_dev_add_pending is true and dev_add_pending remains 1
> (a second rekey arrives while the first is still deferred), this
> branch runs:
>
>     } else {
>         TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
>     }
>
> No NIC add has occurred yet.  Later, when copied_seq crosses
> old_nic_boundary, tls_device_deferred_dev_add_rx() calls
> tls_device_dev_add_rx(..., is_rekey=3Dtrue), which on success increments
> TLSRXREKEYOK again.
>
> The superseded first rekey's TLSRXREKEYINPROGRESS also does not appear
> to be decremented in this chained-rekey path.  Is the accounting
> intended to work that way?

Neither the double-count nor the leak happens, the accounting balances
across a chained rekey.

> [ ... ]
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> [ ... ]
> > @@ -1098,10 +1225,42 @@ int tls_device_decrypted(struct sock *sk, struc=
t tls_context *tls_ctx)
> [ ... ]
> > +                     /* rekey_fixup sets decrypted flags in case if NI=
C clears
> > +                      * decrypted flags on auth failure
> > +                      */
>
> [Low]
> The phrase "in case if" reads as either "in case" or "if" but not both.

Right, that's redundant wording. I'll fix it.
