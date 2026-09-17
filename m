Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B846A604
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685414; cv=pass; b=OX+3bjm2tM/NUrM4i3hna3R9zE7FMzKCGsPiy7PdLNRPOd2XbY0cmcZanvwbf3f6sjcc332vFx9XdnZj2en2mQ549kW4baaxnDreRn2tNi6ZIEXBXD6kS+pcIXK60JfK/SpMJ9n3cAHIQlse5xECe4lNB0GsQp3Q1UxOi993niw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685414; c=relaxed/simple;
	bh=12lfKPHLAxW3uCyPQXDQdHAdDjXHeujlF9MBEb+IKCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrAO6fn0X0z8rhgocD3Ueof6JV/Mh5AQx8twpC1FbpNs2au/ugjqn98VMfK8mYqc2UeacLs3urpjN7Wv6S0zZ9N9j4JrYFadaRVxCgTGp+z3CQBqlo0gl8FCy8zACeRamoHvUvwHC8TodChxfPzCPkWEMl10/RHNVr9X/e1B0Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=MPavCeFQ; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="MPavCeFQ"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5059faso33135e0c.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789685412; cv=none;
        d=google.com; s=arc-20260327;
        b=a6X/xaDFD2Nift0LBd7K8ShjyTSFJTGpjTGRoVinHyaarAZdQZJSGhviciEJxlGmok
         s6NBcYVhVX88FxYI2Rb0B6oH4rShmphIiG/adK0+vDq9uPqLMfknmEjk9/RQ6AYBqi9K
         ivuUMw/U7XB6NKGsBY+2e8H1/isc2ZENdl3ZSg1JaCB9yX3LsZK4A83txU6dG5zlP/kJ
         DPyJHeYqV4sLtiztlT4Rum3JYt3LrGrSM5VI6B8naKBYhlLTbIgn1xl7D8IIZNGFDuMI
         OwVr8B3PoAuCw+jEpbFi2OQ10lw3IMuoomeZabstHASfeMS21NJX08v3i0DXbnMTuiXh
         IVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSa4NqJ6axEWMZ1NzQsiUSKmmrF06OVnALAb0fFoCc8=;
        fh=KDPEyLFrx0IaPdgkSonKsexwzLCh01ZOslfJI1v3q8w=;
        b=HlonVm9r4IIAI+K7PxNwizi0xaS+gnai/xlsr9Ckkx/8wKzfN8NW4fCtmhbK3mM8V+
         7g/pQAt6PxbIR0N5UUeZUWJa2gABvZ1ig+sjoLQQMId0BJN4SFkNVmgw61dAD7h8eSB9
         7j+Xx4aZJWUNxDcQdgMlmtNl7JGxv2jiBg+/WQINEZBB2VfUDZiARsembRiS/aLUCvHv
         0SBAHzr+6vGIOGAZXxqZOTAIKH9Kt1np6PS1qjmZ5hwamWzPx/PKhXhvyOIyB6wbAwTh
         1ZIvh2e2ShtjcBFkoW0qMCsUo0ffo4JVCOeWL2wdk/WsfboVwSQ6ZVapZU0N0Kg1Yydq
         ufoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789685412; x=1790290212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSa4NqJ6axEWMZ1NzQsiUSKmmrF06OVnALAb0fFoCc8=;
        b=MPavCeFQHztKA8Z9IuPtJNReq32efUnUEHpoXjvhXYvHHtObzo5eTCuyIlwCmdqVKe
         sxJO3QxQ52pYBNH+w45R8U0TbL5Mg8u+L3/zHhgY2PMpJsmi/ynxwjnPwVSnCxv8jB73
         9Mrr+PqS40IDPp3JfaKLcZKZJ+RStM/c2q7gnsV6wBcjMCr7QQUDmAznRxftQXSG3MSP
         ToGq8nBZRDu805DyUd9GATGyR5RxC/M7TvJY0uuRe/m7akUMNoyMtV1mp8U5NWmhcapH
         M+UY9yKtpXkbCut2n6uKFb4tFx0ZNKExbLb1+1cP2Td283n3nMeMOPiOkQwHjkwzVLMa
         kuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685412; x=1790290212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSa4NqJ6axEWMZ1NzQsiUSKmmrF06OVnALAb0fFoCc8=;
        b=e6icER6/KZCk1lLmJFSN7o2UDhSXAg8swmx+3PwyIdvHuNUJJpQfoiDMpNCaGhl9bv
         CjuP4hDP5me/Ec3QsU7StFy8DP3fSNSZdQsHyabNH5csJ+gA4lZQ5MPk1tL8v+iQuFli
         qIZXvbygnMbI5CE2Y99edQQCC4OpS8v2NHaoHgcp1qhdsdpZxE1pPe6UFBRS/qWWdl8D
         3DJnKF3+G0yha8w1yKdX0kwLTJvG1A/iwsvryXF4aMxt0p1+cezMphnfOYjZApNl4NHK
         J31VQWl+7HxgGzu8wWQzdRFBmzJWfLsg3szHIKHAxCy70e7AT+6vZChPmX4fUN2i6xhb
         ygXw==
X-Gm-Message-State: AFuF++npnuyNViQ+6DK5+L6OngTBkLxam4ivNwJ/txMGHmGv2MDCka+1
	tyE+7dCl9ZOqQLWN1Tf7C9ahqMlGNkAL7hHiP+61on+lXITkBiw4EGVpdaKKoSCe8hYTTU5XSuO
	fvBS/0Bp6P4r3ZU1Hp3fSpp1s5bi9TED48905gEMxFw==
X-Gm-Gg: AYBFou0RBM35DYOOgFSYhUiScfi+cLnqrFIU0yjwMc1VFugpROZDzY+mTARcNy3nN9H
	O/ncRIuZ45T5b81JQQdn1F8aHlfzYEGB5zPK1Njj93AtnUU1qC+oHcA55bi4qCyin29fw1hwl3l
	WTOqqlccgJF3pnzZ65WQz2o466yO/VXBQfgOQwbnUIw2ORxX2bgqHESwJUi9BqKcnJFy56MJjOm
	OheG+op0xJWobm8E5Mhpgq+4ACHlYGu9gsEbzsGQZNotB+BEVQnnMkJFtcaE5G9d8AlZRSmtvHE
	z328Rhc/VDAWfUJ4d6QYU4KTyZg2QY3ToEtG7u7qnfoj4Eu/sXwnhj9yWUCSl251GBIXLK7Oyqi
	UfrcXzJTVf8v9DT4sxB96Nj88Ppixvk0M9q6B9x2FgsfHv6OkuEBCLPCgRML2R8+S8nmK7wF61Q
	iIPC8rb2960RzNb9SlUhhNoOoddtH5cEBAe9Zpj48x
X-Received: by 2002:a05:6102:1090:b0:7a5:71a3:5556 with SMTP id
 ada2fe7eead31-7a571a36387mr107394137.24.1789685411694; Thu, 17 Sep 2026
 15:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807183853.2288959-7-rjethwani@purestorage.com> <20260817221142.3666425-1-kuba@kernel.org>
In-Reply-To: <20260817221142.3666425-1-kuba@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 17 Sep 2026 15:50:00 -0700
X-Gm-Features: AcwNN1UE_0AQBNS6s7cGsN7tb4uW1ZRk0xQ4mpMMRaT-Na2T-m11eicf5FShjck
Message-ID: <CAKaoeS26+P1e6CKo=vwq70dd4fUXbdoZs3BV41eUFrV+p2cbAw@mail.gmail.com>
Subject: Re: [PATCH v16 06/10] tls: prep helpers and refactors for HW offload KeyUpdate
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> tls: prep helpers and refactors for HW offload KeyUpdate
>
> This patch hoists cipher_context / tls_crypto_context above
> tls_offload_context_tx, adds a tls_tx_cipher_ctx() accessor plus a
> tls_sw_ctx_tx_init() helper, splits tls_set_device_offload() and factors =
out
> tls_device_dev_add_tx() / tls_device_commit_start_marker(), and moves
> crypto_aead_setauthsize() into the !*aead block.  It is described as no
> functional change.
>
> No Link: tags present in the commit header.
>
> > diff --git a/include/net/tls.h b/include/net/tls.h
> > index e57bef58851e..eb258bcd62bc 100644
> > --- a/include/net/tls.h
> > +++ b/include/net/tls.h
>
> [ ... ]
>
> > @@ -392,6 +392,12 @@ static inline struct tls_sw_context_tx *tls_sw_ctx=
_tx(
> >       return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
> >  }
> >
> > +static inline struct cipher_context *tls_tx_cipher_ctx(
> > +             const struct tls_context *tls_ctx)
> > +{
> > +     return (struct cipher_context *)&tls_ctx->tx;
> > +}
> > +
>
> [Severity: Low]
>
> The commit message says this accessor exists "so the TX path can redirect=
 to
> a temporary SW context during rekey", but only some TX-side users are
> converted here.  Is the remaining set intentional?
>
> tls_fill_prepend() in net/tls/tls.h still reads the explicit nonce straig=
ht
> from ctx->tx:
>
>         if (prot->version !=3D TLS_1_3_VERSION &&
>             prot->cipher_type !=3D TLS_CIPHER_CHACHA20_POLY1305) {
>                 pkt_len +=3D iv_size;
>
>                 memcpy(buf + TLS_NONCE_OFFSET,
>                        ctx->tx.iv + prot->salt_size, iv_size);
>         }
>
> and on the HW TX side tls_device.c's tls_push_record() advances
> &ctx->tx while tls_device_resync_tx() reads tls_ctx->tx.rec_seq directly.
> tls_sw_ctx_finalize() and do_tls_getsockopt_conf() also still use &ctx->t=
x.
>
> Walking the paths, none of these look reachable while the accessor points
> somewhere else: do_tls_setsockopt_conf() rejects a second crypto info for
> anything but TLS 1.3 with -EBUSY, so the TLS 1.2 nonce branch above canno=
t
> run during a rekey, and the device record/resync paths are entered from
> tls_push_data(), which the later series patch diverts to the SW helpers w=
hile
> the rekey-pending flag is set.  So there does not appear to be a live
> mismatch today.
>
> Would it be worth a short comment on tls_fill_prepend()'s ctx->tx.iv use
> noting that it is safe because rekey is TLS 1.3 only, so a future reader
> does not have to redo this reasoning?

Your analysis is correct; there's no live mismatch.

I'd rather not add the comment on tls_fill_prepend() though: it's a
generic helper shared by 1.2/1.3 and SW/HW that predates rekey, and
the guard is one line above the read. A rekey-specific note there
would imply the accessor was meant to be threaded through, when the
branch is structurally 1.2-only. The invariant that matters, rekey =E2=87=
=92
TLS 1.3, is enforced and documented at the setsockopt gate.

> > diff --git a/net/tls/tls.h b/net/tls/tls.h
> > index 5a6ee1ea00f8..e8b552c2f4fb 100644
> > --- a/net/tls/tls.h
> > +++ b/net/tls/tls.h
> > @@ -157,7 +157,10 @@ void tls_update_rx_zc_capable(struct tls_context *=
tls_ctx);
> >  void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
> >  void tls_sw_strparser_done(struct tls_context *tls_ctx);
> >  int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
> > +void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_=
ctx);
> > +int tls_sw_push_pending_record(struct sock *sk, int flags);
> >  void tls_sw_splice_eof(struct socket *sock);
> > +void tls_sw_splice_eof_locked(struct socket *sock);
>
> [Severity: Low]
>
> The changelog lists five refactors, but two of the changes here are not a=
mong
> them.  Could the commit message be extended to cover them?
>
> tls_sw_push_pending_record() loses static and becomes a global symbol, an=
d
> tls_sw_splice_eof() is split into a new externally visible
> tls_sw_splice_eof_locked() plus a locking wrapper.  Neither appears in th=
e
> bullet list.
>
> tls_sw_splice_eof_locked() also gains an entry contract that is not writt=
en
> down anywhere: the caller must already hold tls_ctx->tx_lock and the sock=
et
> lock, and is expected to have checked ctx->open_rec.  Would a comment abo=
ve
> it, or a lockdep assertion, be worth adding?

I'll modify the commit message to include the two missing changes.
For the entry contract, I'll add a comment above the retry loop in
tls_sw_splice_eof_locked().
One small correction: the caller isn't actually expected to have
checked ctx->open_rec, the function handles the no-record case itself.

> >  void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
> >  void tls_sw_release_resources_tx(struct sock *sk);
> >  void tls_sw_free_ctx_tx(struct tls_context *tls_ctx);
>
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 63c83247f9a3..7b6ab992c86e 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -555,11 +555,11 @@ static int tls_do_encryption(struct sock *sk,
> >               break;
> >       }
> >
> > -     memcpy(&rec->iv_data[iv_offset], tls_ctx->tx.iv,
> > +     memcpy(&rec->iv_data[iv_offset], tls_tx_cipher_ctx(tls_ctx)->iv,
> >              prot->iv_size + prot->salt_size);
> >
> >       tls_xor_iv_with_seq(prot, rec->iv_data + iv_offset,
> > -                         tls_ctx->tx.rec_seq);
> > +                         tls_tx_cipher_ctx(tls_ctx)->rec_seq);
> >
> >       sge->offset +=3D prot->prepend_size;
> >       sge->length -=3D prot->prepend_size;
>
> [ ... ]
>
> > @@ -676,7 +676,7 @@ static int tls_push_record(struct sock *sk, int fla=
gs,
> >       sg_chain(rec->sg_aead_out, 2, &msg_en->sg.data[i]);
> >
> >       tls_make_aad(rec->aad_space, msg_pl->sg.size + prot->tail_size,
> > -                  tls_ctx->tx.rec_seq, record_type, prot);
> > +                  tls_tx_cipher_ctx(tls_ctx)->rec_seq, record_type, pr=
ot);
> >
> >       tls_fill_prepend(tls_ctx,
> >                        page_address(sg_page(&msg_en->sg.data[i])) +
>
> [ ... ]
>
> > @@ -712,7 +712,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, =
struct sock *sk,
> >       return err;
> >  }
> >
> > -static int tls_sw_push_pending_record(struct sock *sk, int flags)
> > +int tls_sw_push_pending_record(struct sock *sk, int flags)
> >  {
> >       struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> >       struct tls_sw_context_tx *ctx =3D tls_sw_ctx_tx(tls_ctx);
>
> [ ... ]
>
> > @@ -1028,7 +1028,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t size)
> >  /*
> >   * Handle unexpected EOF during splice without SPLICE_F_MORE set.
> >   */
> > -void tls_sw_splice_eof(struct socket *sock)
> > +void tls_sw_splice_eof_locked(struct socket *sock)
> >  {
> >       struct sock *sk =3D sock->sk;
> >       struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> > @@ -1039,21 +1039,15 @@ void tls_sw_splice_eof(struct socket *sock)
> >       bool retrying =3D false;
> >       int ret =3D 0;
> >
> > -     if (!ctx->open_rec)
> > -             return;
> > -
> > -     mutex_lock(&tls_ctx->tx_lock);
> > -     lock_sock(sk);
> > -
> >  retry:
> >       /* same checks as in tls_sw_push_pending_record() */
> >       rec =3D ctx->open_rec;
>
> [ ... ]
>
> >       /* Transmit if any encryptions have completed */
> >       if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
> >               cancel_delayed_work(&ctx->tx_work.work);
> >               tls_tx_records(sk, 0);
> >       }
> > +}
> > +
> > +void tls_sw_splice_eof(struct socket *sock)
> > +{
> > +     struct sock *sk =3D sock->sk;
> > +     struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> > +     struct tls_sw_context_tx *ctx =3D tls_sw_ctx_tx(tls_ctx);
> >
> > -unlock:
> > +     if (!ctx->open_rec)
> > +             return;
> > +
> > +     mutex_lock(&tls_ctx->tx_lock);
> > +     lock_sock(sk);
> > +     tls_sw_splice_eof_locked(sock);
> >       release_sock(sk);
> >       mutex_unlock(&tls_ctx->tx_lock);
> >  }
>
> Both observations are documentation level; the code changes themselves lo=
ok
> equivalent to the previous behaviour.

Agreed, both are pure refactors:

- tls_ctx->tx -> tls_tx_cipher_ctx(): rekey.cipher_ctx is never armed in
  this patch (only later, on the HW path), so it always resolves to
  &tls_ctx->tx.
- splice_eof split: pre-check preserved, every "goto unlock" -> "return"
in the helper; the wrapper drops both locks on exit. Locking is unchanged.

I'll tighten the tls_sw_splice_eof_locked() comments
