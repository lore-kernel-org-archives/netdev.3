Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC436E46C
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127178; cv=pass; b=oNhahIsaSutjiD5v7+A4UWkh9d82Oev3hvP0cmzp106m4g2ZlXcMDOs6fqgXJRRUu1pTcXMzf1iFEgD39eGHBMr9wFkASG/bV1Kv12sr1z4ULjFAg0TbqD5bJAFRS2d1LpHgFY89MVdzogRNTz9vtFx8HNJ74Om167M6J0bcHMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127178; c=relaxed/simple;
	bh=/BKsUPCcf0V0l49A8ZHjhT3VnK5g504fvcbru8QUEe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPn4gz3IagcEtfxtze0BVC/TWhnut7sM6QdM729FasK7s/TP9EXUhrSopckp0kat+flBsCLg7X/nCkkSz0FZMZPixt67rRw/NgDbTKF42rHnToTqdaz6Tiys3oHl/AtSy5T2ROKjkIYWX5rljNCYg9xnqgucOzktANds5cJdbDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=WW9Qj/kQ; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="WW9Qj/kQ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5bfb3347ce0so1080545e0c.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786127174; cv=none;
        d=google.com; s=arc-20260327;
        b=VSQN/Hr+0ogRUV4CnCohc0avj1g1QN+gin+qxS/YDkUZcIS0yuozfQiAEgYM+xncZf
         kkpHMzCdQPoqgXLtPPLszM8jQg7RvahhVGKL4/Hp/EekSlXxbSMY3OWLP2I2E8umJXYM
         Hx7dbPPIkvz1XCK8EVlZsGIcU0H3ry47sHHwni/574/jgZc6b0Cut4qPoG7wTy3XlmiA
         +ekw/cFNRLxO3imNcWVJKqJcUGDyudIv9QQT6dcYPDK8hKLwt/+wm54saSqdP4QOfRul
         slJl3PIwVEcsoulSoh5ox584SnGSGaHT3RTzmWlbJWzyk9V8teY61k1V1WvNnlD+Avmu
         9xJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YWMfmNX3boXl2wVViSwMjuKYPc/NdEJ/uPwXndzkM5U=;
        fh=RNRDstDh6/mVTGDTxNOJzVFGFMLrZRCriDHrlRp+koM=;
        b=H+LMXmSr6M0mQ2jbZMoaOOglKvjYjgB6YsFK5cndjDRAd3OnpHXwBT1uVxl1TcgACp
         l6nzaGIUVPyHQtJMeNglV5tnVigkueUXISY0m/QlrvGRi71fQPMu4pL4IQPKc4MtLkkc
         BT9e0YCqsmTC8EI0sVRUbV2/7A6d9bfMnPQmucz43GD9onzs+Z1dWL7BzVg3UvaQt9wT
         E7mmJHRivXH3EtpQHLYJgmSSndtz6MnNBWMYAH3bi4QMbkNBeDTHkUrKdAM3M3BbXING
         IDsKHw0L+AkFev5yb8mlWt+WrIYNVQqG8OgGUR+x7dMO+nv7i6VfPys47HwWlSRTzUL+
         jFEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1786127174; x=1786731974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YWMfmNX3boXl2wVViSwMjuKYPc/NdEJ/uPwXndzkM5U=;
        b=WW9Qj/kQanQflPLwvf8rqf3I6EN8pe7U5mLbzAsD4bTYcrgumOi1ozRyo2ebMfiNoT
         HAfT9ZzvrklywIYRZoW0ncRhk0sz7SjXLQtlZ5OS2eNI3c2R44Tr73yv8+R9UvXC5Zeb
         mM+qMTjSy+bdZKuf6lt/SuU4JNfWUtgve8uhzJxmMAhhg6MHUk98uztpNzR5vTEZ2zEd
         0GR0z9Q7oJoOzFMuOB5rR5DjCHxcevVQ6RCp8iYymiG0BN5TfdgaJ/6t0E3Z8pLgfHq6
         XiLA9wWYsv+E/mugczB55MZf36tUSCsJutku0NGuPdRGQJAxgoXjQslKeO90RnlYJja/
         7s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786127174; x=1786731974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWMfmNX3boXl2wVViSwMjuKYPc/NdEJ/uPwXndzkM5U=;
        b=CrUH5k9nFoOuZ5s7llKaz31mMKO77/9OL+LfiAqaRD9A1jX3vi+oUJWmwuXaR1hwa0
         PAyN6fpW5EjLkO58HBIfjZT7ws1gBHVsD5E+/YVD/6TeHdgNs5qODVacyKpkkNkmz913
         h1Pa5oLaQhC9gtndmnEvg4/ZXxeIJ/0PeLo6Dm0TRGvhCJAyCLiQMXWjeCW5+vYe/Io9
         dZYCYpEABcw87cksFMtNi5eZinJzXN1RCjQAGQdRKav5y/POE/rzLzq9lOCQ/Vyb1phR
         C45Ft8EqCNIIdvFRoZoGOxeZeNQTctv5w1vl2KH9pN9PWdUHCQh2SzvxqJwGeKBn47tr
         u6Kg==
X-Gm-Message-State: AOJu0YxHQvGDaVY68YR5rO2+7Lr/DVl/82BSUK8wUa9ZKT0npvzvQy1v
	YN4mzYjJt2A+L18rTLZ8w5j622SdyeRCiA9/BwnKkW7ldm4TjaP0QO6/xyrfec+mUdugs1O3AYZ
	6Tv5Yv9sWtbR6BuYYFNySsTlNO4lsZhyz/gYFX/7vwA==
X-Gm-Gg: AR+sD11lqUAmeFxiHGX3WCwB2okgSeTO1holXMQ6mr7wTAfFowcm/TC6Y0CMaXFCWBW
	fVUvJBjpcjOrFSY2wAEW7Mz68FD0onCq4kOo+LO5pIRg9/LI4XJNXGBY/aDkylhQpflNCTF7lE/
	VMl/xyXusT2QweggOTNrKkLZ/Ers4dRrEke7hq+lhBufK9uP2Z79rJda/rTUfJmbU6R8HA5q9nk
	Xb95RLA0SFkInJw6PkegRdmPACaAT98NffkhI1meJqmd12jWxUeN8ikE5eLyNJ0GWehO0MfoVWf
	LLVdoZ4AUO4zadpCUJuciyFKAKIoRbDafz0ylJVJkwdUZ/mrR5gGVZEnu4hLLKSWmS0JIB0dKV8
	Is5ZoD+gLPuWtcQjYZhEmHsOXLRbfCPri670czekP8IoDS+mTEy+ylCakOEhziDvV0lKRNV6yM6
	cTxeBv32HRx5YK1dB0ha4K9fIVIRmE6gtl9yGSzF4=
X-Received: by 2002:a05:6102:f06:b0:738:9bf0:f80c with SMTP id
 ada2fe7eead31-760e851c91emr6558306137.9.1786127171902; Fri, 07 Aug 2026
 11:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709205325.1591196-7-rjethwani@purestorage.com> <20260723091538.68897-1-pabeni@redhat.com>
In-Reply-To: <20260723091538.68897-1-pabeni@redhat.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Fri, 7 Aug 2026 11:26:00 -0700
X-Gm-Features: AUfX_mwSM0tqRP-7HlhaZjuHN7rPPxYm-1kFsnM-lKXdplBotqkoSww1NX6dLkQ
Message-ID: <CAKaoeS2Qs4zPVC-qs+Aw2BqS=d9Aa_S98k6j2RWga_V3iak4VQ@mail.gmail.com>
Subject: Re: [PATCH v15 6/9] tls: device: add TX KeyUpdate support
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@google.com, 
	leon@kernel.org, andrew.gospodarek@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> tls: device: add TX KeyUpdate support
>
> This patch adds TX KeyUpdate support for TLS device offload by installing
> a temporary SW context with the new key while HW keeps encrypting old-key
> retransmits, then swapping HW back in once all old records are ACKed.
>
> > diff --git a/include/net/tls.h b/include/net/tls.h
> > index eb258bcd62bc..2c6e314355fd 100644
> > --- a/include/net/tls.h
> > +++ b/include/net/tls.h
> > @@ -389,12 +422,18 @@ static inline struct tls_sw_context_rx *tls_sw_ct=
x_rx(
> >  static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
> >               const struct tls_context *tls_ctx)
> >  {
> > +     if (unlikely(tls_ctx->rekey.sw_ctx))
> > +             return tls_ctx->rekey.sw_ctx;
> > +
> >       return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
> >  }
> >
> >  static inline struct cipher_context *tls_tx_cipher_ctx(
> >               const struct tls_context *tls_ctx)
> >  {
> > +     if (unlikely(tls_ctx->rekey.cipher_ctx))
> > +             return tls_ctx->rekey.cipher_ctx;
> > +
> >       return (struct cipher_context *)&tls_ctx->tx;
> >  }
>
> [High]
> These helpers are inline hot-path accessors that dereference
> tls_ctx->rekey.sw_ctx / tls_ctx->rekey.cipher_ctx using plain loads.
>
> Writers in tls_device_start_rekey() and tls_device_complete_rekey() set
> and clear those pointers with plain stores outside offload_ctx->lock,
> and readers include tls_encrypt_done() (async crypto completion, may
> run in softirq) and tx_work_handler() (workqueue), neither of which
> hold lock_sock.
>
> Should these use READ_ONCE / WRITE_ONCE (and a smp_store_release on
> publish paired with a smp_load_acquire on consume) so a reader on a
> weakly-ordered architecture cannot observe rekey.sw_ctx transitioning
> inconsistently with the TLS_TX_REKEY_PENDING flag, and so the compiler
> cannot fold or reorder these loads against the flag manipulations?

I don't think there's an actual race in the normal TX/rekey paths, but
I'll add the READ_ONCE()/WRITE_ONCE() annotations.

Both writers run under lock_sock(), start_rekey via setsockopt() and
complete_rekey via sendmsg(). The initial publication cannot race
normal SW TX: on a HW-offloaded socket, no SW TX work exists for the
rekey context before its state is initialized, the pointers are
published, PENDING is set, and the validator is swapped, in that
order.

Before clearing the pointers, complete_rekey quiesces SW TX with
tls_sw_drain_tx(). tls_encrypt_async_wait() waits for all asynchronous
completions; tls_encrypt_done() finishes using its callback context
before decrementing the pending count and completing the wait.
cancel_delayed_work_sync() cancels pending work and waits for any
running tx_work_handler(). The sequence runs while lock_sock() is
held.

Release/acquire keyed to TLS_TX_REKEY_PENDING isn't needed: no reader
uses sw_ctx gated on PENDING outside lock_sock(). The only site
reading both is tls_device_sendmsg(), under the socket lock. The
lock-free PENDING reader (tls_device_reset()) never touches sw_ctx,
and the lock-free sw_ctx readers (tls_encrypt_done(),
tx_work_handler()) never read PENDING. The lock-free datapath redirect
is the sk_validate_xmit_skb swap, which already pairs release/acquire

> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index 7a98d2f6cbd3..ef837bbd9560 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -222,6 +252,19 @@ static void tls_tcp_clean_acked(struct sock *sk, u=
32 acked_seq)
> >       }
> >
> >       ctx->unacked_record_sn +=3D deleted_records;
> > +
> > +     /* Once all old-key HW records are ACKed, set REKEY_READY to
> > +      * let sendmsg know it can finish the rekey and switch back
> > +      * to HW offload.
> > +      */
> > +     if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
> > +         !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> > +             u32 boundary_seq =3D READ_ONCE(tls_ctx->rekey.boundary_se=
q);
> > +
> > +             if (!before(acked_seq, boundary_seq))
> > +                     set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
> > +     }
>
> > @@ -253,6 +296,14 @@ void tls_device_free_resources_tx(struct sock *sk)
> >       struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> >
> >       tls_free_partial_record(sk, tls_ctx);
> > +
> > +     if (unlikely(tls_ctx->rekey.sw_ctx))
> > +             tls_sw_release_resources_tx(sk);
>
> [High]
> tls_free_partial_record() is called before tls_sw_release_resources_tx().
>
> tls_sw_release_resources_tx() has a special block gated on
> if (tls_ctx->partially_sent_record) that avoids re-freeing the
> msg_encrypted pages of a partially sent record =E2=80=94 pages that were
> already put_page'd by tls_free_partial_record().
>
> Since tls_free_partial_record() first clears tls_ctx->partially_sent_reco=
rd,
> that special block is skipped and the generic list_for_each_entry_safe
> path calls sk_msg_free(&rec->msg_encrypted), producing a double put_page
> on pages already released.
>
> Can this be triggered when rekey.sw_ctx !=3D NULL, the SW send path hit
> EAGAIN mid-send leaving a partially-sent record, and the socket is then
> closed? Would swapping the order (release sw resources first, free the
> partial record last, following the SW close path in tls_sk_proto_cleanup(=
))
> avoid the double free?

I'll fix this double free issue by running the SW release first and
only freeing the
partial record directly in the non-rekey case

> > +
> > +     if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags)) {
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYABORTED);
> > +             TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRES=
S);
> > +     }
> >  }
>
> > @@ -624,6 +678,19 @@ int tls_device_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t size)
> >                       goto out;
> >       }
> >
> > +     /* Old-key records all ACKed; switch back to HW. */
> > +     if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
> > +             tls_device_complete_rekey(sk, tls_ctx, true);
>
> [High]
> The return value from tls_device_complete_rekey() is discarded here.
>
> tls_device_complete_rekey() has early returns before rekey_fail:
>
>     rc =3D tls_sw_drain_tx(sk, ctx);
>     if (rc)
>             return rc;
>
>     start_marker_record =3D kmalloc_obj(*start_marker_record);
>     if (!start_marker_record)
>             return -ENOMEM;
>
> Neither of those paths clears TLS_TX_REKEY_READY / TLS_TX_REKEY_PENDING
> and neither sets TLS_TX_REKEY_FAILED.
>
> Does this mean that under sustained memory pressure (-ENOMEM) or
> repeated -EAGAIN from tls_sw_drain_tx(), every subsequent sendmsg pays
> a full drain + kmalloc + drain retry cost forever, since REKEY_READY
> stays set and this branch fires on every entry?
>
I'll preallocate start_marker_record at rekey setup and stash it on offload=
_ctx,
so complete_rekey never fails on allocation while retrying.
That leaves only the -EAGAIN drain path, which is inherent,
we genuinely must flush old-key SW data before swapping the
NIC key, and it self-clears as the pipe drains.

> > +
> > +     /* Use SW path if rekey is in progress (PENDING) or if HW rekey
> > +      * failed (FAILED).
> > +      */
> > +     if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) ||
> > +         test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> > +             rc =3D tls_sw_sendmsg_locked(sk, msg, size);
> > +             goto out;
> > +     }
>
> [High]
> tls_process_cmsg() runs above this block, before the rekey-state check.
>
> tls_process_cmsg() -> tls_handle_open_record() dispatches through
> ctx->push_pending_record, which is still tls_device_push_pending_record
> (never rewired for rekey) and pushes via tls_push_data() on the HW
> offload_ctx.
>
> If a previous tls_sw_sendmsg_locked() left a SW open_rec with
> pending_open_record_frags=3Dtrue and the next sendmsg carries a cmsg
> TLS_SET_RECORD_TYPE, does the HW push path run on a HW context whose
> open_record is NULL while the SW open_rec is what actually needed
> flushing?
>
> Similarly, tls_device_splice_eof is installed as the splice_eof op for
> TLS_HW protos and calls tls_push_data() unconditionally with no
> rekey-state check. Should that entry point also route to the SW path
> while REKEY_PENDING or REKEY_FAILED is set?

I'll fix this issue by routing both entry points to the SW path while
rekey is active

> > @@ -1103,6 +1170,282 @@ static struct tls_offload_context_tx *alloc_off=
load_ctx_tx(struct tls_context *c
>
> > +static int tls_device_start_rekey(struct sock *sk,
> > +                               struct tls_context *ctx,
> > +                               struct tls_offload_context_tx *offload_=
ctx,
> > +                               struct tls_crypto_info *new_crypto_info=
)
> > +{
> > +     bool rekey_pending =3D test_bit(TLS_TX_REKEY_PENDING, &ctx->flags=
);
> > +     bool rekey_failed =3D test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> > +     const struct tls_cipher_desc *cipher_desc;
> > +     char *key, *iv, *rec_seq, *salt;
> > +     unsigned long flags;
> > +     int rc;
> > +
> > +     cipher_desc =3D get_cipher_desc(new_crypto_info->cipher_type);
> > +     DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable)=
;
> > +
> > +     key =3D crypto_info_key(new_crypto_info, cipher_desc);
> > +     iv =3D crypto_info_iv(new_crypto_info, cipher_desc);
> > +     rec_seq =3D crypto_info_rec_seq(new_crypto_info, cipher_desc);
> > +     salt =3D crypto_info_salt(new_crypto_info, cipher_desc);
> > +
> > +     if (rekey_pending || rekey_failed) {
> > +             /* Wait for in-flight async encryptions submitted to this=
 tfm
> > +              * with the previous key before changing it.
> > +              */
> > +             rc =3D tls_encrypt_async_wait(&offload_ctx->rekey.sw);
> > +             if (rc)
> > +                     return rc;
> > +
> > +             rc =3D crypto_aead_setkey(offload_ctx->rekey.sw.aead_send=
,
> > +                                     key, cipher_desc->key);
> > +             if (rc)
> > +                     return rc;
>
> [High]
> On an error return from tls_encrypt_async_wait() or crypto_aead_setkey()
> here, TLS_TX_REKEY_PENDING remains set, ctx->rekey.sw_ctx still points
> at the SW context, and offload_ctx->rekey.sw.aead_send may have
> CRYPTO_TFM_NEED_KEY set (a failed setkey sets that flag).
>
> Subsequent tls_device_sendmsg() calls then route to
> tls_sw_sendmsg_locked() using a sw_ctx that cannot encrypt.
>
> The socket never transitions to REKEY_FAILED, so tls_tcp_clean_acked()
> will eventually still set REKEY_READY, and tls_device_complete_rekey()
> will attempt to install HW using offload_ctx->rekey.tx =E2=80=94 but the
> memcpy of new IV/rec_seq below has not run on this failure path, so
> HW is programmed from whatever offload_ctx->rekey.tx held from a
> previous rekey attempt.
>
> Should this partial-failure path either set REKEY_FAILED or roll back
> sw_ctx / PENDING?

tls_encrypt_async_wait() failure is benign: nothing has been
mutated at that point, so rekey.sw.aead_send still holds the previous
key, rekey.tx / rekey.crypto_send.info and the PENDING/FAILED bits
are untouched, and the in-progress rekey stays consistent. We just
return the error to setsockopt.

crypto_aead_setkey() failure is the real issue. On failure it sets
CRYPTO_TFM_NEED_KEY, which not only fails to install the new key but
destroys the previous one, leaving the SW fallback path (used for both
PENDING and FAILED) routing sends through a tfm that can no longer
encrypt.

On the HW-programming concern specifically: complete_rekey() doesn't
end up installing garbage. In the PENDING case rekey.tx still holds
the previous rekey's valid IV/rec_seq, which is exactly what should be
committed; in the FAILED case tls_tcp_clean_acked() gates REKEY_READY
on !FAILED, so complete_rekey() never runs. The only real casualty
is the keyless SW tfm.

I'll fix it by making the rekey atomic: build the new key into a
fresh tfm and swap it in only on success, so a setkey failure leaves
the live tfm (and thus the SW fallback) untouched

> > +
> > +             memcpy(offload_ctx->rekey.tx.iv, salt, cipher_desc->salt)=
;
> > +             memcpy(offload_ctx->rekey.tx.iv + cipher_desc->salt, iv,
> > +                    cipher_desc->iv);
> > +             memcpy(offload_ctx->rekey.tx.rec_seq, rec_seq,
> > +                    cipher_desc->rec_seq);
> > +
> > +             if (rekey_failed) {
> > +                     set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> > +                     clear_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> > +                     TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW=
);
> > +                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDE=
VICE);
> > +             }
>
> [High]
> When transitioning from FAILED back to PENDING here, boundary_seq is
> not refreshed. The stale boundary_seq from the earlier failed rekey
> attempt is preserved.
>
> tls_tcp_clean_acked() uses boundary_seq to decide when to set
> REKEY_READY, and tls_validate_xmit_skb_rekey() uses it to split HW
> pass-through vs SW fallback for retransmits.
>
> With a stale (much earlier) boundary_seq:
>
>     if (!before(acked_seq, boundary_seq))
>             set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
>
> REKEY_READY likely fires immediately on the very next ACK, and
> complete_rekey installs HW at the current write_seq. Bytes in
> [old_boundary_seq, current_write_seq) that were SW-encrypted with the
> intermediate key would then, on retransmit, take the tls_validate_xmit_sk=
b_rekey
> 'above boundary, pass through HW' branch, where HW now holds the newest
> key.
>
> Should the failed=E2=86=92pending path also WRITE_ONCE a new
> tls_ctx->rekey.boundary_seq =3D tcp_sk(sk)->write_seq under
> offload_ctx->lock like the initial branch does?

This scenario can't actually occur. boundary_seq guards one specific
invariant: all records carrying plaintext that rely on the old HW
context must be
ACKed before complete_rekey tears it down and installs the new key at
the current write_seq. Those records all live below the original B0,
everything
sent from the initial rekey onward (PENDING and FAILED) is
SW-encrypted, and validate_xmit_skb_rekey passes FAILED skbs through
verbatim. So there is no
HW-plaintext data above B0.
That's why the stale B0 is still the correct gate: acked_seq >=3D B0
still means exactly "all HW-plaintext records ACKed", which is all
that's needed to
safely reinstall HW.

> > +     } else {
>
> > +             spin_lock_irqsave(&offload_ctx->lock, flags);
> > +             WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq=
);
> > +             set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> > +             spin_unlock_irqrestore(&offload_ctx->lock, flags);
> > +
> > +             /* Switch to rekey validator; new sends won't use HW offl=
oad */
> > +             smp_store_release(&sk->sk_validate_xmit_skb,
> > +                               tls_validate_xmit_skb_rekey);
> > +     }
>
> > +static int tls_device_complete_rekey(struct sock *sk, struct tls_conte=
xt *ctx,
> > +                                  bool deferred)
> > +{
> > +     struct tls_offload_context_tx *offload_ctx =3D tls_offload_ctx_tx=
(ctx);
> > +     struct tls_record_info *start_marker_record;
> > +     const struct tls_cipher_desc *cipher_desc;
> > +     struct net_device *netdev;
> > +     unsigned long flags;
> > +     __be64 rcd_sn;
> > +     char *key;
> > +     int rc;
>
> > +     if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
> > +             netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> > +                                             TLS_OFFLOAD_CTX_DIR_TX);
> > +             set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
> > +     }
> > +
> > +     memcpy(crypto_info_rec_seq(&offload_ctx->rekey.crypto_send.info, =
cipher_desc),
> > +            offload_ctx->rekey.tx.rec_seq, cipher_desc->rec_seq);
> > +
> > +     rc =3D tls_device_dev_add_tx(sk, netdev, &offload_ctx->rekey.cryp=
to_send.info,
> > +                                tcp_sk(sk)->write_seq);
> > +     if (!rc)
> > +             clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
>
> [High, High]
> Two concerns here about the tls_dev_del + tls_dev_add sequence:
>
> Unlike tls_device_down(), which uses synchronize_net() before
> tls_dev_del() to fence in-flight packets, this path replaces the NIC
> context with no such fence. Packets already handed to the driver TX
> queue may still be traversing the NIC's TLS engine when tls_dev_del
> removes the old context and tls_dev_add installs the new one at the
> current write_seq. Can that lead to in-flight SW-encrypted segments
> being double-encrypted, or to old-context in-flight packets being
> corrupted, depending on driver semantics?
>
> Second, this changes the tlsdev_ops contract by calling tls_dev_add on
> a tls_context that already had tls_dev_add + tls_dev_del called on it
> (mid-lifetime replace). The in-tree offload drivers (mlx5, chcr, cxgb4,
> nfp, funeth) were written under the single-add/single-del assumption
> and may allocate per-socket state keyed on sk/ctx assuming no prior
> state exists on entry. The commit notes it was tested only on
> ConnectX-6 Dx. Should this be gated on a new driver capability, or the
> other drivers audited and updated in the same series?

On the missing synchronize_net() fence:
 The parallel to tls_device_down() is visual rather than semantic.
tls_device_down() needs synchronize_net() because it fires
asynchronously on NIC
 unregister while sockets may be mid-transmit with live HW-offloaded
records; the RCU fence lets in-flight validate_xmit/skbs drain before
tls_dev_del.

 The rekey completion path never runs in that state.
tls_device_complete_rekey() reaches tls_dev_del/tls_dev_add only once
there are provably no
 in-flight old-key HW records:

 - Deferred path (common case): invoked from sendmsg only after
TLS_TX_REKEY_READY, which tls_tcp_clean_acked() sets only when
acked_seq >=3D boundary_seq
 i.e. the peer has TCP-ACKed every byte of old-key HW data. A TCP ACK
means those segments already left the NIC TLS engine.
 - Immediate path: runs inline only when !tls_has_unacked_records() &&
!tls_is_pending_open_record().

 From start_rekey onward the validator is swapped to
tls_validate_xmit_skb_rekey, so all data >=3D boundary_seq is
SW-encrypted and passed through;
 complete_rekey also runs tls_sw_drain_tx() first, then commits a new
start marker at the current write_seq so the freshly-added context
passes through
 everything before it (covering the SW passthrough region and its
retransmits). So there's no window where an in-flight segment meets a
context that
 would double-encrypt or corrupt it. The ACK-based boundary is the
fence here, so synchronize_net() isn't needed.

On the mid-lifetime tls_dev_add-after-tls_dev_del contract:
it's been exercised on both mlx5 (in-tree) and an out-of-tree Broadcom
Thor2 driver, so the del=E2=86=92re-add-on-the-same-ctx sequence is validat=
ed
across two independent HW implementations rather than a single NIC.
Rekey is also TLS-1.3-only and rejected at do_tls_setsockopt_conf()
for any other version.

> > +
> > +release_lock:
> > +     up_read(&device_offload_lock);
> > +
> > +     if (rc)
> > +             goto rekey_fail;
> > +
> > +     spin_lock_irqsave(&offload_ctx->lock, flags);
> > +     memcpy(&rcd_sn, offload_ctx->rekey.tx.rec_seq, sizeof(rcd_sn));
> > +     offload_ctx->unacked_record_sn =3D be64_to_cpu(rcd_sn) - 1;
> > +     spin_unlock_irqrestore(&offload_ctx->lock, flags);
> > +
> > +     memcpy(ctx->tx.iv, offload_ctx->rekey.tx.iv,
> > +            cipher_desc->salt + cipher_desc->iv);
> > +     memcpy(ctx->tx.rec_seq, offload_ctx->rekey.tx.rec_seq,
> > +            cipher_desc->rec_seq);
> > +     unsafe_memcpy(&ctx->crypto_send.info,
> > +                   &offload_ctx->rekey.crypto_send.info,
> > +                   cipher_desc->crypto_info,
> > +                   /* checked during rekey setup */);
> > +
> > +     key =3D crypto_info_key(&offload_ctx->rekey.crypto_send.info, cip=
her_desc);
> > +     rc =3D crypto_aead_setkey(offload_ctx->aead_send, key, cipher_des=
c->key);
> > +     if (rc)
> > +             goto rekey_fail;
>
> [Critical]
> By this point, tls_device_dev_add_tx() has already succeeded (HW is
> programmed with the new key, TLS_TX_DEV_CLOSED cleared), and
> ctx->tx.iv, ctx->tx.rec_seq, ctx->crypto_send.info, and
> unacked_record_sn have all been overwritten with new-key material.
>
> A subsequent failure of crypto_aead_setkey(offload_ctx->aead_send, ...)
> jumps to rekey_fail. rekey_fail only sets TLS_TX_REKEY_FAILED and
> returns 0.
>
> It does not tear down the just-installed HW context, does not restore
> ctx->tx / ctx->crypto_send, does not restore unacked_record_sn, does
> not re-set TLS_TX_DEV_CLOSED, and does not switch sk_validate_xmit_skb
> back to tls_validate_xmit_skb_sw.
>
> offload_ctx->aead_send is left in CRYPTO_TFM_NEED_KEY state, so
> tls_sw_fallback() will fail encryption on any retransmit =E2=80=94 and si=
nce
> the validator is still tls_validate_xmit_skb_rekey with the FAILED bit
> set, the very first check in that validator passes such retransmits
> through unchanged. Can this send plaintext TLS records on the wire?
>
> Should this failure path roll back the HW install (and the ctx->tx /
> crypto_send / unacked_record_sn state), and should rekey_fail return
> the actual error to the caller rather than 0?

I don't think crypto_aead_setkey failure would cause the data-plane
problems described.
In FAILED mode the socket runs pure SW: sendmsg goes through
tls_sw_sendmsg_locked(),
and the NIC won't touch those skbs because
tls_is_skb_tx_device_offloaded() only returns
true for the plain tls_validate_xmit_skb validator, not the
 _rekey one installed here, so no double-encryption despite HW being left l=
ive.
The stale offload_ctx->aead_send (NEED_KEY) is never used either, since
the rekey validator early-returns on FAILED before any tls_sw_fallback().
And the pre-boundary-retransmit =E2=86=92 plaintext path isn't reachable be=
cause
complete_rekey() only runs after REKEY_READY, i.e. all old-key records alre=
ady
ACKed and off the queue.

I'll still harden the crypto_aead_setkey() failure path to keep it in
consistent state.
Rather than roll back a successful HW install, I'll fix it by construction,
reordering so both fallible steps run while the HW context is torn down
(TLS_TX_DEV_CLOSED set)

> > +
> > +     /* Start marker: the NIC passes through everything before
> > +      * write_seq unencrypted (already SW-encrypted during rekey),
> > +      * same as during initial offload setup.
> > +      */
> > +     tls_device_commit_start_marker(sk, offload_ctx, start_marker_reco=
rd);
>
> > +     crypto_free_aead(tls_sw_ctx_tx(ctx)->aead_send);
> > +     ctx->rekey.sw_ctx =3D NULL;
> > +     ctx->rekey.cipher_ctx =3D NULL;
> > +     memzero_explicit(&offload_ctx->rekey, sizeof(offload_ctx->rekey))=
;
>
> [Critical]
> tls_sw_drain_tx() further down does cancel_delayed_work_sync() but does
> not set BIT_TX_CLOSING first.
>
> tx_work_handler is designed to reschedule itself via
> schedule_delayed_work when its mutex_trylock(&tls_ctx->tx_lock) fails.
> tls_device_complete_rekey() is invoked while tx_lock is held (its
> caller tls_device_sendmsg holds tx_lock across the whole path), so any
> concurrently running tx_work_handler is guaranteed to trylock-fail and
> reschedule itself.
>
> After cancel_delayed_work_sync() returns, this code path clears
> ctx->rekey.sw_ctx =3D NULL and then memzero_explicit's
> offload_ctx->rekey =E2=80=94 which contains the delayed_work embedded in
> offload_ctx->rekey.sw.tx_work.work (including work.func).
>
> When the workqueue timer fires later, is the work item that gets run
> one whose containing memory has been zeroed?
>
> Compare with tls_sw_cancel_work_tx() which sets BIT_TX_CLOSING and uses
> disable_delayed_work_sync() precisely to prevent this re-queue.

The handler will indeed trylock-fail and hit the
schedule_delayed_work() re-queue branch but cancel_delayed_work_sync() is
self-requeue-safe by construction, so no timer survives it in this case.
    cancel_delayed_work_sync()
      -> __cancel_work_sync(work, WORK_CANCEL_DELAYED)
         -> __cancel_work(work, cflags | WORK_CANCEL_DISABLE)  /* disable /
         -> __flush_work(work, true)                           / wait handl=
er /
         -> enable_work(work)          / caller had no DISABLE flag */

  For the duration of the cancel the work is in the DISABLED state, so the
  handler's own schedule_delayed_work() lands in clear_pending_if_disabled(=
)
  and becomes a no-op, the timer is never armed. __flush_work() then waits
  for the running handler, and enable_work() restores it on the way out.
  This is what the API contract promises (kernel/workqueue.c):

    "This function can be used even if the work re-queues itself. On return
     [...] @work is guaranteed to be not pending or executing on any CPU as
     long as there aren't racing enqueues."

  So the self-requeue you describe is precisely the case cancel handles. Th=
e
  memzero_explicit() therefore runs against a delayed_work that is guarante=
ed
  quiescent and un-armed; there is no later timer to fire against the zeroe=
d
  work.func.

cancel_work_tx() needs disable (permanent, no re-enable)
because tls_sw_write_space() fires from
softirq (delayed-ACK / ksoftirqd), not under tx_lock, and can re-arm the
work after the sync call returns, a genuine racing enqueue, which is the
one case the contract above excludes. That's commit 7bb09315 ("tls: Fix
race condition in tls_sw_cancel_work_tx()").

  That racing enqueuer doesn't exist on the rekey/drain path:

  - complete_rekey() runs on a tx_conf =3D=3D TLS_HW socket, so tls_write_s=
pace()
  dispatches to tls_device_write_space() and never arms the SW tx_work.
  - tls_encrypt_done() is drained by tls_encrypt_async_wait() before the
  cancel, and no new sends can start (lock_sock held across the whole of
  complete_rekey()), so it can't re-arm afterwards.

  So the only enqueuer left in the window is the handler's self-requeue, wh=
ich
  cancel already covers.

> > +
> > +     if (deferred)
> > +             TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRES=
S);
> > +     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
> > +     return 0;
> > +
> > +rekey_fail:
> > +     kfree(start_marker_record);
> > +     spin_lock_irqsave(&offload_ctx->lock, flags);
> > +     set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> > +     clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
> > +     clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> > +     spin_unlock_irqrestore(&offload_ctx->lock, flags);
>
> [High]
> On any tls_dev_add failure inside this function, TLS_TX_DEV_CLOSED
> stays set for the lifetime of the socket, because the clear_bit only
> runs on success. Both tls_device_tx_del_task() and tls_device_down()
> skip tls_dev_del when TLS_TX_DEV_CLOSED is set.
>
> If the driver's tls_dev_add failure path leaves partial per-connection
> HW state (partially programmed TCB, allocated key buffers, or in-flight
> PSV), does the driver ever get a chance to reclaim those resources?
> Is this relying on every driver's tls_dev_add error path fully cleaning
> up on internal failure?

 The clear_bit only running on success is intentional, and it does not leak=
.

 TLS_TX_DEV_CLOSED means "no live TX HW context needs tls_dev_del." In
the rekey path we tls_dev_del the old context at the top (fully
reclaiming it) and
 set the flag before attempting tls_dev_add for the new key. If that
add fails, there is no live driver context, so having
tls_device_tx_del_task() and
 tls_device_down() skip tls_dev_del is correct; calling it would be a
spurious del against a context that was never added.
 Reclaiming partial state on an internal tls_dev_add failure is the
driver's responsibility, not the core's, this is the existing
tlsdev_ops contract.
 Documentation/networking/tls-offload.rst: a failed offload request
means the connection "is handled entirely in software =E2=80=A6 as if the
offload was never
 tried," and tls_dev_del is only called "when the offloaded connection
is destroyed" (i.e. paired with a successful add). The initial-offload
path
 depends on this today: tls_set_device_offload_initial() jumps to
release_lock on tls_dev_add failure and never calls tls_dev_del. The
rekey path makes
 no new assumption, the same contract that has always covered the
setup path covers it here.

> > diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallbac=
k.c
> > index 1110f7ac6bcb..64ac4ef4012b 100644
> > --- a/net/tls/tls_device_fallback.c
> > +++ b/net/tls/tls_device_fallback.c
> > @@ -435,6 +435,30 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct so=
ck *sk,
> > +struct sk_buff *tls_validate_xmit_skb_rekey(struct sock *sk,
> > +                                         struct net_device *dev,
> > +                                         struct sk_buff *skb)
> > +{
> > +     struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> > +     u32 tcp_seq =3D ntohl(tcp_hdr(skb)->seq);
> > +     u32 boundary_seq;
> > +
> > +     if (test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags))
> > +             return skb;
>
> [Critical]
> When TLS_TX_REKEY_FAILED is set, this returns the skb unmodified for
> every packet, including TCP retransmits of records below boundary_seq
> that were SW-encrypted with the old key.
>
> Consider the failure path in tls_device_complete_rekey() where
> tls_dev_del() has succeeded (TLS_TX_DEV_CLOSED set) and then
> tls_device_dev_add_tx() fails: HW offload is entirely gone, yet this
> validator bypasses tls_sw_fallback() and lets the record go out on the
> wire unencrypted.
>
> Consider the second failure path where tls_device_dev_add_tx() succeeds
> but the later crypto_aead_setkey(offload_ctx->aead_send) fails: HW is
> now programmed with the new key, but retransmits of TCP segments below
> boundary_seq skip SW fallback here and are handed to HW, which will
> encrypt them with the wrong key.
>
> Either way, does the commit-message assertion "if the HW reinstall
> fails the socket stays in SW mode (REKEY_FAILED)" actually hold, or
> are old-data retransmits corrupted or transmitted in plaintext when
> REKEY_FAILED is set?

I don't think either mode occurs, the concern assumes a REKEY_FAILED
state that doesn't match the code.

Once rekey is PENDING/FAILED, tls_device_sendmsg() (and
splice_eof/push_pending_record) routes all sends through
tls_sw_sendmsg_locked(), so the skb
already holds ciphertext, not plaintext awaiting the NIC. The
validator returning skb unmodified is correct precisely because HW is
gone.

dev_add failure: REKEY_FAILED is set only in complete_rekey(), which
is reachable only after all below-boundary data is ACKed, the deferred
path is gated
on REKEY_READY (set when !before(acked_seq, boundary_seq)), the
immediate path on !tls_has_unacked_records(). So TCP won't retransmit
anything below
boundary_seq in the failed state; the before(tcp_seq, boundary_seq)
branch is effectively dead. No plaintext egress.

setkey-after-dev_add: that ordering was removed. complete_rekey() now
does setkey on a fresh tfm before tls_dev_add_tx(), and swaps it into
aead_send only
at the point-of-no-return after add succeeds. A setkey failure leaves
HW torn down and aead_send on the old key, coherent SW mode, no window
where HW
holds the new key while aead_send holds the old.

So the claim holds.

> > +
> > +     /* If this packet is at or after the rekey boundary, it's already
> > +      * SW-encrypted with the new key, pass through unchanged
> > +      */
> > +     boundary_seq =3D READ_ONCE(tls_ctx->rekey.boundary_seq);
> > +     if (!before(tcp_seq, boundary_seq))
> > +             return skb;
> > +
> > +     /* Packet before boundary means retransmit of old data,
> > +      * use SW fallback with the old key
> > +      */
> > +     return tls_sw_fallback(sk, skb);
> > +}
>
> > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > index c4c15c0e731a..b51f9ea1ed6c 100644
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> > @@ -449,8 +457,16 @@ static int do_tls_getsockopt_conf(struct sock *sk,=
 char __user *optval,
> >       /* get user crypto info */
> >       if (tx) {
> > -             crypto_info =3D &ctx->crypto_send.info;
> > -             cctx =3D &ctx->tx;
> > +             if (ctx->rekey.cipher_ctx) {
> > +                     struct tls_offload_context_tx *offload_ctx =3D
> > +                             tls_offload_ctx_tx(ctx);
> > +
> > +                     crypto_info =3D &offload_ctx->rekey.crypto_send.i=
nfo;
> > +                     cctx =3D &offload_ctx->rekey.tx;
> > +             } else {
> > +                     crypto_info =3D &ctx->crypto_send.info;
> > +                     cctx =3D &ctx->tx;
> > +             }
>
> [Medium]
> Before this change, TLS_TX getsockopt could only expose the current
> in-use key. This branch now returns offload_ctx->rekey.crypto_send.info
> during the rekey window =E2=80=94 a key that has not yet taken effect on =
the
> wire.
>
> On the rekey_fail path, offload_ctx->rekey is not zeroed (only the
> final success path memzero_explicit's it), so this raw new-key material
> remains observable via getsockopt until tls_device_free_ctx()
> eventually clears it at socket destruction.
>
> Is exposing the not-yet-active key (and leaving the material
> observable across REKEY_FAILED) intentional, and should rekey_fail also
> memzero_explicit offload_ctx->rekey?

Both are intentional. Once start_rekey() runs, the SW fallback
encrypts all new records (write_seq >=3D boundary_seq) with the new key
=E2=80=94 tls_sw_ctx_tx()
returns rekey.sw_ctx as soon as it's set =E2=80=94 so the "new" key is alre=
ady
the key on the wire for new data. getsockopt gating on
rekey.cipher_ctx returns
the live TX state; returning ctx->tx would report stale rec_seq/IV.
And getsockopt(TLS_TX) has always echoed the key back to the socket
owner, who
supplied it in the first place, so there's no disclosure beyond what
the caller set.

rekey_fail deliberately doesn't zero offload_ctx->rekey: after
REKEY_FAILED the connection stays permanently on SW fallback using
that key, so rekey.sw
is the live AEAD and rekey.crypto_send/rekey.tx are the in-use
key/seq. Zeroing them would wipe the active key and break TX. The
success path can
memzero only because it first copies the new key into
ctx->tx/ctx->crypto_send and re-enables HW; the fail path keeps
rekey.* as the authoritative state
until teardown, where tls_device_free_ctx() does the memzero_explicit.

> > @@ -714,32 +730,32 @@ static int do_tls_setsockopt_conf(struct sock *sk=
, sockptr_t optval,
> >       if (tx) {
> > -             if (update && ctx->tx_conf =3D=3D TLS_HW) {
> > -                     rc =3D -EOPNOTSUPP;
> > -                     goto err_crypto_info;
> > -             }
> > -
> > -             if (!update) {
> > -                     rc =3D tls_set_device_offload(sk);
> > -                     conf =3D TLS_HW;
> > -                     if (!rc) {
> > +             rc =3D tls_set_device_offload(sk, update ? crypto_info : =
NULL);
> > +             conf =3D TLS_HW;
> > +             if (!rc) {
> > +                     if (!update) {
> >                               TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLS=
TXDEVICE);
> >                               TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLS=
CURRTXDEVICE);
> > -                             goto out;
> >                       }
> > -             }
> > -
> > -             rc =3D tls_set_sw_offload(sk, 1, update ? crypto_info : N=
ULL);
> > -             if (rc)
> > +             } else if (update && ctx->tx_conf =3D=3D TLS_HW) {
> > +                     /* HW rekey failed - return the actual error.
> > +                      * Cannot fall back to SW for an existing HW conn=
ection.
> > +                      */
> >                       goto err_crypto_info;
> > -
> > -             if (update) {
> > -                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYO=
K);
> >               } else {
> > -                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
> > -                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW=
);
> > +                     rc =3D tls_set_sw_offload(sk, 1,
> > +                                             update ? crypto_info : NU=
LL);
>
> > @@ -885,12 +901,29 @@ static int do_tls_setsockopt(struct sock *sk, int=
 optname, sockptr_t optval,
> >       switch (optname) {
> >       case TLS_TX:
> > -     case TLS_RX:
> > +     case TLS_RX: {
> > +             struct tls_context *ctx =3D tls_get_ctx(sk);
> > +             /* A HW-offload TX rekey arrives mid-stream and races wit=
h an
> > +              * in-flight tls_device_sendmsg(), which holds tx_lock ac=
ross
> > +              * the lock_sock drop in sk_stream_wait_memory() while an
> > +              * open_record is half built. start_rekey() would flush t=
hat
> > +              * record and flip the SW/HW boundary under the sender,
> > +              * corrupting record framing. Serialize against the data =
path
> > +              * with tx_lock. Only the HW TX path reaches start_rekey,=
 and
> > +              * initial setup (tx_conf =3D=3D BASE) has no concurrent =
sender.
> > +              */
> > +             bool tx_rekey =3D optname =3D=3D TLS_TX && ctx->tx_conf =
=3D=3D TLS_HW;
> > +
> > +             if (tx_rekey)
> > +                     mutex_lock(&ctx->tx_lock);
> >               lock_sock(sk);
>
> [Medium]
> The comment above explicitly cites the race between rekey and in-flight
> tls_device_sendmsg() as the motivation for tx_lock, but the decision to
> acquire tx_lock is based on an unlocked read of ctx->tx_conf =E2=80=94 th=
e very
> field that transitions concurrently:
>
>     bool tx_rekey =3D optname =3D=3D TLS_TX && ctx->tx_conf =3D=3D TLS_HW=
;
>     if (tx_rekey)
>             mutex_lock(&ctx->tx_lock);
>     lock_sock(sk);
>
> If a concurrent initial-setup path is completing on the same socket and
> flipping tx_conf to TLS_HW between this read and lock_sock(), this
> thread skips tx_lock while a subsequent tls_device_sendmsg() starts
> running. Does this reintroduce the TOCTOU the tx_lock is meant to
> close? Would always taking tx_lock for TLS_TX (or deciding under
> lock_sock and then acquiring tx_lock with the correct ordering) be
> safer?

  I'll fix by always taking tx_lock for the TLS_TX case. tx_lock isn't take=
n
  anywhere in the offload-setup helpers, so there's no recursion, and it
  preserves the tx_lock -> lock_sock order used by the data path. During
  initial setup there's no concurrent sender, so the extra lock is
  uncontended.

  I went with unconditional tx_lock rather than "decide under lock_sock,
  then take tx_lock", the latter would acquire lock_sock before tx_lock,
  inverting the ordering in tls_device_sendmsg() and risking a deadlock.

> >               rc =3D do_tls_setsockopt_conf(sk, optval, optlen,
> >                                           optname =3D=3D TLS_TX);
> >               release_sock(sk);
> > +             if (tx_rekey)
> > +                     mutex_unlock(&ctx->tx_lock);
> >               break;
> > +     }
>
> [Medium]
> Separately, LINUX_MIB_TLSTXREKEYOK looks like it can be incremented
> twice for a single user-visible KeyUpdate. When a second KeyUpdate
> arrives while the first is still pending, tls_set_device_offload_rekey()'=
s
> defer path bumps TLSTXREKEYOK immediately:
>
>     if (defer) {
>             if (!rekey_pending)
>                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPRO=
GRESS);
>             else
>                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
>             return 0;
>     }
>
> and later tls_device_complete_rekey()'s success path bumps
> TLSTXREKEYOK again for the same rekey.

It's incremented once per KeyUpdate, not twice for one. The else
branch in the defer path only runs when rekey_pending was already set
on entry, i.e. a
previous KeyUpdate is still pending. So the two increments belong to
two different KeyUpdates:

  - 1st KeyUpdate: deferred, !rekey_pending =E2=86=92 INC INPROGRESS
  - 2nd KeyUpdate arrives while 1st still pending: rekey_pending =E2=86=92 =
INC
OK (accounts for the 1st, now-superseded, key)
  - completion: INC OK (accounts for the 2nd/last key), DEC INPROGRESS

  So N KeyUpdates collapsed into a single HW transition still yield
OK=3DN. For a lone KeyUpdate rekey_pending is false at entry, so only
the completion path
  bumps OK, no double count.

> Additionally, tls_device_free_resources_tx() unconditionally decrements
> TLSTXREKEYINPROGRESS when REKEY_PENDING is set, while
> tls_device_complete_rekey() also decrements it on the deferred path.
> Can these counters go negative or over-count depending on the
> FAILED/PENDING/READY transition sequence?
> --

They stay balanced. INPROGRESS is only ever incremented on the
deferred start (!rekey_pending branch). On the deferred path, the
eventual completion
(deferred=3Dtrue, DEC on success/fail) or a mid-flight teardown
(free_resources_tx, DEC + ABORTED) provides exactly one matching DEC,
and they're mutually
exclusive in time, once completion clears PENDING, free_resources_tx
won't decrement.

The non-deferred path never increments INPROGRESS, and it also never
leaves PENDING dangling: complete_rekey(deferred=3Dfalse) is only
reached for a fresh
rekey, whose SW context was just initialized with an empty tx_list
(all under lock_sock/tx_lock), so tls_sw_drain_tx() can't bail early,
it always
reaches either the success clear or the rekey_fail cleanup, both of
which clear PENDING. So there's no state where PENDING is set without
a matching
INPROGRESS increment, and the counter can't go negative.
