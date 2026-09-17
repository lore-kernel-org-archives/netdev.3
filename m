Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DB37204C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685548; cv=pass; b=G1HdOWDHwwLBOuFUswqzXlhT1hTz/VZxZ+o5NWqMKPv6HBRy/SfKGsioOywehgfDnQu3N+JtjoIJ7kRz7GeiN4UHUBXVExx50bWNOsjEnK0KNCok8Mn4FI3I/4cMl1w69RaR3R5o6DY0lJ/+XpZEP3jRy/OzboUH/Sr7bW/oxYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685548; c=relaxed/simple;
	bh=ssxn/a6vqocUQ7W1gi2VyZGbVMBKJGT9elbmMElKgDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2cOwdemiM6rZerQMsjEUKgtBlcFyZHAbknpol2jgT4IQMz/1dqT09FOgIcAWy/4LQoGWf+Yw1B2iJffSf5Qqo0mZpWyK6UH+4zO53l8AlLQsAF/K1InQwgyJWqC50ResTvnJGKEuQBixg1/LoHLifzFFpviVxybMrHB4vPbDMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=Rjvb+gBG; arc=pass smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="Rjvb+gBG"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c7bd056863so43567e0c.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789685545; cv=none;
        d=google.com; s=arc-20260327;
        b=kGh/aNzl1y6omqs8paxpFSvwwLZFYYATatgdNf1IvG18eO7gLwNHYzm5VSug7vIm4E
         LKoyBY8pEbvLhg7PKvnlvR/zctIRNMbklp9u5XuhhZ8ptQAY7HOOJvAixeM0G4DyOBnT
         occvl7Q+PHISbOi6l/WTnCRDerid9R6Bd/0d6wHlmGamNzFH+PRY4NAnf95dsOOfew8Q
         Dqerxq7u7NnQLucyrBi+v/iYQkrg71sB7vzrghFFtTYsnTeg4A66wVa8RDCXaLrhEZp3
         yyeLXyK++G+smq8cCphxD4wEFVRdPHQ+btylEEDUB5V87PaOr04wTkDJxM+wp8+Kr0xY
         mRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gm9GASDZb7ihHsZYkMclB1RzYhVfh/LKqoaEpDRdnEc=;
        fh=KDPEyLFrx0IaPdgkSonKsexwzLCh01ZOslfJI1v3q8w=;
        b=isqMlouyH1BHYJR/6/FSvg4DYeLJKABGibaV4oCbJrPS8+D4NdLPfvSH3qWtLHs4th
         AOnl+GYBYq+A9gBVvfFKjML70pNM4KFMUxxwh6//9IubpvzGxwUpHMAXB5YK+9UDt2wY
         fKmLBd3ETfDUSSLKVMAxDNViJx9B9Gsai1z5svi5QHf+x1VP8wts0l8TVfVKW8Pkglqz
         gEwEggswJ5EYV9nNVJ/3FogXvj8UzUMsFPjxLNyw71EOXfpY9QCxCmRpf+EFQWls7KwT
         LCmiG4IyZbMrV1Eq9v7Fhvq5/P9mWZbQwT09TNnPSu1Eujsxyoz7aNm6DChAHGDMBLF+
         +lzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789685545; x=1790290345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gm9GASDZb7ihHsZYkMclB1RzYhVfh/LKqoaEpDRdnEc=;
        b=Rjvb+gBGLgGD8mhnOmNKRBATo4vQe1ys+QnkqmHqYhJ+WLWAptzNnAhJcb83QKFmia
         hHYmTVwhnzWDG1/YlJ/WGYMHGESwMKLemkngffl1XySpvwQZH2J1RW5g6p+WRhIqZwdw
         HzGuiG3UPnxP56TlcchMfEvUbnzD8BStlEnpPguaW8a5azfFfhnfWVesMYU6zZhppYsd
         e9/p9tYr/KV2ObNNzDTqT+5Sjtkbv72bcytTQSGC6i12hYCF7SM8BK6yjOrwh4M+O3c2
         aySMG6XkKM3pnjRIvpm+c7+EmZoQjVaFSGAGgbFEWUVGjzFuUlWGaBeGbtL7JGumWrUa
         LAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685545; x=1790290345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gm9GASDZb7ihHsZYkMclB1RzYhVfh/LKqoaEpDRdnEc=;
        b=IS/mdTjtvIFW82eN/Uu/5IfKe7FwPmtYeCCX044Eei6qgb01YoKkTEjSirmvaG3LX3
         xYRMUB3brQqG4VqQFubmnubTCBQvoBrnudQKklkCDbo5WjYiNjQ4UhuHd/t/jhTI56qa
         e+uks3kJvBUthY/94+2zEoNST+3qEVJ2g2PvBnT67MFAM/0ZyP4XkVoqkg0pwr2aYEKF
         Rbqe8h0HYMlUkLFGVvcMCmmxl3OtAJ6Q58kCFqXIIEnw/rSDQFKbuzlXw6/Iv1/G8E4+
         q0uE3HlWnZ+TBWbRKgnoKhj4T/xyuLbxlIdkHXflXSSX1NYXPa6jMZbumGxK0lbKAetu
         O8DA==
X-Gm-Message-State: AFuF++mrkq/7aFQ2+b589ILaHrHBtEzS9Yv0CT3kUveOECzUmgIheBIo
	YbO48Qql/yJrXbErh3mZZ+4tSty0oRtwmMVbbBjb7/XUs84GQXGXM/3kvEFYL+RIAl+YRIX37t1
	VBHL7oEtLPz9pQxSr4DOQL/4xWzw7OWaBt8D1v0Dz3g==
X-Gm-Gg: AYBFou1DK6d3C5J0ZCTbXbOFJQSwcDIYbSiA3Sr3Q71kPHs/xFAe1CTEE+eAs7IndGS
	JU8vMeHd82DYM3LqFvU3EuCBY7Of0unjawD7M56cSQINwlnPw6yLIldw45nkcFinzqn7kXawhy7
	iUs7Iv7BhJAzgDev4Zxq5wk09McgTY6oajkeVoEJtcvqOBQmaLbdP3IepDjo9Zx8ZPLcijJWIwx
	VFLCwN6yBsnBimdNMlmWhGa6Loo7fTMw5PO15H6S7TX/npS7hf1W5l/I1x3judSviNmjJcPEjEf
	swld1kgzrNBYPRLw5Xsx2GGJRjbAkqrgQaMBDkwu6O8cVhoMxbuhnrcDAD4XEep+efAfcZP60pz
	DTFHz6ut4T1gXrPiPK77wMH4vg56Csgp31VHM3MCjvxWmAAWP4FEyhH3DNChLElf4BD89LMlYMK
	ro2YWb9/4gfokI8yOFnt0YQBjjFHZxXipjxevPuyLR
X-Received: by 2002:a05:6122:d0d:b0:5c9:a5be:7b4f with SMTP id
 71dfb90a1353d-5c9b58fb99cmr210977e0c.6.1789685545036; Thu, 17 Sep 2026
 15:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807183853.2288959-8-rjethwani@purestorage.com> <20260817221144.3666456-1-kuba@kernel.org>
In-Reply-To: <20260817221144.3666456-1-kuba@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 17 Sep 2026 15:52:13 -0700
X-Gm-Features: AcwNN1X6_EJQQ30zSpar96ZUpfI7tuhMVQqBHC6PS5t7VWxTGhnqeDV-bs4XUhQ
Message-ID: <CAKaoeS3=iEK0TyCPT0fbcVqPaCwUWjAxQv8cyC1p1XXBbOC2HQ@mail.gmail.com>
Subject: Re: [PATCH v16 07/10] tls: device: add TX KeyUpdate support
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
> tls: device: add TX KeyUpdate support
>
> This adds TX KeyUpdate for device-offloaded kTLS by installing a temporar=
y
> SW context with the new key, routing sendmsg through
> tls_sw_sendmsg_locked() until all old-key HW records are ACKed, and then
> reinstalling HW offload at the current write_seq. A few questions below
> about the SW/HW transition, the record bookkeeping and the new counters.
>
> > diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> > index 49f5640092a0..119fbd49179c 100644
> > --- a/include/uapi/linux/snmp.h
> > +++ b/include/uapi/linux/snmp.h
> > @@ -369,6 +369,9 @@ enum
> >       LINUX_MIB_TLSTXREKEYOK,                 /* TlsTxRekeyOk */
> >       LINUX_MIB_TLSTXREKEYERROR,              /* TlsTxRekeyError */
> >       LINUX_MIB_TLSRXREKEYRECEIVED,           /* TlsRxRekeyReceived */
> > +     LINUX_MIB_TLSTXREKEYFALLBACK,           /* TlsTxRekeyFallback */
> > +     LINUX_MIB_TLSTXREKEYINPROGRESS,         /* TlsTxRekeyInProgress *=
/
> > +     LINUX_MIB_TLSTXREKEYABORTED,            /* TlsTxRekeyAborted */
> >       __LINUX_MIB_TLSMAX
> >  };
>
> [Severity: Low]
> These three names become visible in /proc/net/tls_stat through the new
> SNMP_MIB_ITEM() entries in tls_mib_list[], but
> Documentation/networking/tls.rst is not updated anywhere in this series,
> even though it documents every other TLS counter including TlsTxRekeyOk,
> TlsTxRekeyError, TlsRxRekeyReceived and the TlsCurrTx* gauges.
>
> Should the statistics section of tls.rst gain these three?
>
> Also, TlsTxRekeyInProgress is used as a gauge (incremented in
> tls_set_device_offload_rekey() when the rekey is deferred, decremented in
> tls_device_complete_rekey() and tls_device_free_resources_tx()), while
> every other Tls*Rekey* counter is monotonic and the existing gauges use
> the TlsCurr* prefix.
>
> Would TlsCurrTxRekey (or similar) match the existing naming better?

I'll rename TlsTxRekeyInProgress/TlsRxRekeyInProgress to
TlsCurrTxRekey/TlsCurrRxRekey.
I'll document all six new counters in tls.rst alongside the existing ones.

> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index 4f6b3ea1bde4..85c74d0816b7 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
>
> [ ... ]
>
> > @@ -252,7 +296,15 @@ void tls_device_free_resources_tx(struct sock *sk)
> >  {
> >       struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> >
> > -     tls_free_partial_record(sk, tls_ctx);
> > +     if (unlikely(tls_ctx->rekey.sw_ctx))
> > +             tls_sw_release_resources_tx(sk);
> > +     else
> > +             tls_free_partial_record(sk, tls_ctx);
>
> [Severity: Critical]
> Can tls_ctx->partially_sent_record still belong to the device path here,
> while rekey.sw_ctx points at a brand new SW context whose tx_list is
> empty?
>
> The device push path leaves it set when the record does not fit in the
> send queue:
>
> net/tls/tls_device.c:tls_push_record() {
>         ...
>         return tls_push_sg(sk, tls_ctx, offload_ctx->sg_tx_data, 0, flags=
);
> }
>
> net/tls/tls_main.c:tls_push_sg() {
>         ...
>                 ctx->partially_sent_offset =3D offset;
>                 ctx->partially_sent_record =3D (void *)sg;
> }
>
> tls_device_start_rekey() only flushes a pending *open* record
> (tls_is_pending_open_record()), which is false for an already closed but
> partially sent record, and the defer decision in
> tls_set_device_offload_rekey() also does not look at it:
>
>         if (!rekey_pending && !rekey_failed)
>                 defer =3D tls_has_unacked_records(offload_ctx) ||
>                         tls_is_pending_open_record(ctx);
>
> The SW paths assume partially_sent_record implies the head of tx_list is
> the owning tls_rec:
>
> net/tls/tls_sw.c:tls_sw_release_resources_tx() {
>         if (tls_ctx->partially_sent_record) {
>                 tls_free_partial_record(sk, tls_ctx);
>                 rec =3D list_first_entry(&ctx->tx_list,
>                                        struct tls_rec, list);
>                 list_del(&rec->list);
>                 sk_msg_free(sk, &rec->msg_plaintext);
>                 kfree(rec);
>         }
>
> With the freshly initialized offload_ctx->rekey.sw, tx_list is empty, so
> rec becomes container_of(&offload_ctx->rekey.sw.tx_list, struct tls_rec,
> list). struct tls_rec starts with its list_head, so rec points into the
> middle of the kmalloc'ed offload context; sk_msg_free() then walks an
> sk_msg built out of the neighbouring rekey key/IV/rec_seq bytes and
> kfree(rec) frees an interior pointer.
>
> tls_sw_drain_tx() -> tls_tx_records() has the same list_first_entry()
> assumption on the completion path.
>
> Should tls_set_device_offload_rekey() also defer on
> tls_is_partially_sent_record(), and should start_rekey() drain the device
> partial record before publishing rekey.sw_ctx?

- Drain before publishing: yes, I'll fix this by draining the partial
record before publishing rekey.sw_ctx
- Also defer on tls_is_partially_sent_record(): not needed; it's
redundant. The record is linked into records_list before it's sent and
can't be removed until ACKed, so tls_has_unacked_records() already
reports it =E2=86=92 defer is already true. I've added a comment on the def=
er
condition noting this so the invariant isn't lost.

> [ ... ]
>
> > @@ -718,8 +789,13 @@ EXPORT_SYMBOL(tls_get_record);
> >
> >  static int tls_device_push_pending_record(struct sock *sk, int flags)
> >  {
> > +     struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> >       struct iov_iter iter;
> >
> > +     if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) ||
> > +         test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags))
> > +             return tls_sw_push_pending_record(sk, flags);
> > +
> >       iov_iter_kvec(&iter, ITER_SOURCE, NULL, 0, 0);
> >       return tls_push_data(sk, &iter, 0, flags, TLS_RECORD_TYPE_DATA);
> >  }
>
> [Severity: High]
> sendmsg, splice_eof and push_pending_record are all made rekey aware, but
> tls_write_space() is not, and tx_conf stays TLS_HW for the whole rekey:
>
> net/tls/tls_main.c:tls_write_space() {
> #ifdef CONFIG_TLS_DEVICE
>         if (ctx->tx_conf =3D=3D TLS_HW)
>                 tls_device_write_space(sk, ctx);
>         else
> #endif
>                 tls_sw_write_space(sk, ctx);
> }
>
> So while TLS_TX_REKEY_PENDING is set and all data is produced by
> tls_sw_sendmsg_locked(), the device handler runs instead of the SW one.
>
> Does that mean the SW tx_work is never rescheduled when send buffer space
> frees up?  tls_sw_write_space() is the only place doing:
>
>         if (tls_is_tx_ready(tx_ctx) &&
>             !test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
>                 schedule_delayed_work(&tx_ctx->tx_work.work, 0);
>
> which would leave encrypted records sitting in
> offload_ctx->rekey.sw.tx_list after an -EAGAIN from tls_push_sg(), and
> tls_sw_drain_tx() returning -EAGAIN so the rekey never completes.
>
> Can the WARN in tls_device_write_space() also fire now?  It has
> WARN_ON_ONCE(sk->sk_write_pending), and tls_sw_sendmsg_locked() raises
> sk_write_pending in sk_stream_wait_memory() with a SW partial record
> outstanding.
>
> Finally, tls_device_write_space() calls tls_push_partial_record() directl=
y
> on tls_ctx->partially_sent_record, which during the rekey belongs to the
> SW tx_list.  Completing the push there clears partially_sent_record
> without removing the owning head tls_rec, so the next tls_tx_records()
> re-pushes the same record from msg_en->sg.data[msg_en->sg.curr].  Would
> that duplicate ciphertext in the stream and put_page() the record pages a
> second time?

I'll fix this by making tls_device_write_space() rekey-aware.

> > @@ -1105,6 +1181,334 @@ static struct tls_offload_context_tx *alloc_off=
load_ctx_tx(struct tls_context *c
> >       return offload_ctx;
> >  }
> >
>
> [ ... ]
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
>
> [ ... ]
>
> > +     if (rekey_pending || rekey_failed) {
> > +             /* Wait for in-flight async encryptions submitted to this=
 tfm
> > +              * with the previous key before changing it.
> > +              */
> > +             rc =3D tls_encrypt_async_wait(&offload_ctx->rekey.sw);
> > +             if (rc)
> > +                     return rc;
>
> [ ... ]
>
> > +             old_aead =3D offload_ctx->rekey.sw.aead_send;
> > +             offload_ctx->rekey.sw.aead_send =3D new_aead;
> > +             crypto_free_aead(old_aead);
> > +
> > +             memcpy(offload_ctx->rekey.tx.iv, salt, cipher_desc->salt)=
;
> > +             memcpy(offload_ctx->rekey.tx.iv + cipher_desc->salt, iv,
> > +                    cipher_desc->iv);
> > +             memcpy(offload_ctx->rekey.tx.rec_seq, rec_seq,
> > +                    cipher_desc->rec_seq);
>
> [Severity: Medium]
> The other branch below flushes a pending open record before switching
> keys:
>
>                 /* Flush any HW open_record before switching to SW */
>                 if (tls_is_pending_open_record(ctx)) {
>                         rc =3D ctx->push_pending_record(sk, 0);
>
> This branch swaps aead_send and rewrites rekey.tx.iv / rekey.tx.rec_seq
> with no equivalent flush of offload_ctx->rekey.sw.open_rec.
> tls_encrypt_async_wait() only waits for requests already submitted to the
> tfm; compare the new tls_sw_drain_tx(), which pushes the pending open
> record first:
>
>         if (tls_is_pending_open_record(ctx))
>                 tls_sw_push_pending_record(sk, 0);
>         tls_encrypt_async_wait(sw_ctx);
>
> If a preceding sendmsg with MSG_MORE left plaintext in
> offload_ctx->rekey.sw.open_rec, is that record then encrypted under the
> newest key and newest rec_seq, instead of the key that was current when
> the bytes were accepted?

I'll fix this by pushing the open record before the wait and swap.

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
> [Severity: High]
> This re-arms the boundary based validator and the READY logic without
> refreshing ctx->rekey.boundary_seq; only the else branch below writes it:
>
>                 WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq=
);
>
> While TLS_TX_REKEY_FAILED is set the socket stays in SW mode and can send
> an unbounded amount of data, so by the time a second KeyUpdate arrives
> boundary_seq can be arbitrarily far behind write_seq.  Since before() is =
a
> signed 32-bit comparison, once more than 2 GiB has been written past the
> stale boundary:
>
> net/tls/tls_device_fallback.c:tls_validate_xmit_skb_rekey() {
>         boundary_seq =3D READ_ONCE(tls_ctx->rekey.boundary_seq);
>         if (!before(tcp_seq, boundary_seq))
>                 return skb;
>
>         return tls_sw_fallback(sk, skb);
> }
>
> would brand new, already SW-encrypted packets be handed to
> tls_sw_fallback() and encrypted a second time?
>
> And symmetrically in tls_tcp_clean_acked():
>
>                 if (!before(acked_seq, boundary_seq))
>                         set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
>
> with acked_seq more than 2 GiB past the stale boundary the READY bit stop=
s
> being set, so the second rekey can never complete.  Should the
> rekey_failed path also update boundary_seq to the current write_seq?

Right, I'll fix this.

> > +     } else {
> > +             /* Flush any HW open_record before switching to SW */
> > +             if (tls_is_pending_open_record(ctx)) {
> > +                     rc =3D ctx->push_pending_record(sk, 0);
> > +                     if (rc < 0)
> > +                             return rc;
> > +             }
>
> [ ... ]
>
> > +static int tls_device_complete_rekey(struct sock *sk, struct tls_conte=
xt *ctx,
> > +                                  bool deferred)
> > +{
>
> [ ... ]
>
> > +     rc =3D tls_device_dev_add_tx(sk, netdev, &offload_ctx->rekey.cryp=
to_send.info,
> > +                                tcp_sk(sk)->write_seq);
> > +     if (rc) {
> > +             crypto_free_aead(new_aead);
> > +             goto release_lock;
> > +     }
> > +
> > +     /* Point of no return: HW is live with the new key. Swap in the n=
ew
> > +      * fallback tfm and drop the old one; the remaining steps cannot =
fail.
> > +      */
> > +     old_aead =3D offload_ctx->aead_send;
> > +     offload_ctx->aead_send =3D new_aead;
> > +     crypto_free_aead(old_aead);
> > +     clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
>
> [Severity: High]
> Is old_aead guaranteed to be unused at this point?  During the whole
> PENDING window the installed validator routes every pre-boundary segment
> into tls_sw_fallback(), which reads offload_ctx->aead_send locklessly fro=
m
> qdisc dequeue on any CPU:
>
> net/tls/tls_device_fallback.c:tls_enc_skb() {
>         aead_req =3D tls_alloc_aead_request(ctx->aead_send, GFP_ATOMIC);
>         ...
>         salt =3D crypto_info_salt(&tls_ctx->crypto_send.info, cipher_desc=
);
>         ...
>         if (tls_enc_records(tls_ctx, aead_req, ctx->aead_send, sg_in, sg_=
out,
>
> The memcpys just below overwrite ctx->tx.iv, ctx->tx.rec_seq and
> ctx->crypto_send.info, which the same function reads.  There is no
> synchronize_net(), RCU section or refcount between the free and those
> readers, whereas tls_device_down() does exactly that before tearing TX
> state down:
>
>                 rcu_assign_pointer(ctx->netdev, NULL);
>                 ...
>                 /* Sync with inflight packets. ... */
>                 synchronize_net();
>
> Can a fallback that already loaded old_aead (a queued pre-boundary
> retransmission dequeued on another CPU) end up using a freed
> crypto_aead, or re-encrypt an old record with the new key and salt?

Right, I'll fix this.

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
>
> [Severity: High]
> The "- 1" here encodes the invariant documented in alloc_offload_ctx_tx()=
:
>
>         /* start at rec_seq - 1 to account for the start marker record */
>         memcpy(&rcd_sn, ctx->tx.rec_seq, sizeof(rcd_sn));
>         offload_ctx->unacked_record_sn =3D be64_to_cpu(rcd_sn) - 1;
>
> that is, exactly one start marker sits at the head of records_list.  On
> the inline (non-deferred) path, can the previous start marker still be
> linked?  tls_has_unacked_records() deliberately skips markers:
>
>         list_for_each_entry(info, &offload_ctx->records_list, list) {
>                 if (!tls_record_is_start_marker(info)) {
>                         has_unacked =3D true;
>                         break;
>                 }
>         }
>
> so with records_list =3D=3D [old_marker] the rekey is not deferred, and
> tls_device_commit_start_marker() then does list_add_tail_rcu(), giving
> [old_marker, new_marker, R1, ...] while the counter was rebased as if one
> marker existed.  tls_get_record() increments record_sn per list entry, so
> would every subsequent record report SN + 1, and would the skew become
> permanent once tls_tcp_clean_acked() deletes both markers and adds
> deleted_records on top of the rebased value?
>
> The rebase and the records_list update are also in two separate critical
> sections, so tls_tcp_clean_acked() can run in between and apply
> ctx->unacked_record_sn +=3D deleted_records to the freshly rebased value.
>
> That SN is what drivers program into the NIC on TX resync and what
> tls_enc_skb() uses to build the record nonce, so a mismatch means
> retransmissions authenticated under the wrong sequence number.

I'll fold the marker cleanup, rebase, and list_add_tail_rcu() into a
single offload_ctx->lock section (new tls_device_commit_rekey_marker()
helper) that drops any residual start marker first, so the list ends
up exactly [new_marker] with unacked =3D=3D new_rec_seq - 1

> > +
> > +     memcpy(ctx->tx.iv, offload_ctx->rekey.tx.iv,
> > +            cipher_desc->salt + cipher_desc->iv);
>
> [ ... ]
>
> > +static int tls_set_device_offload_rekey(struct sock *sk,
> > +                                     struct tls_context *ctx,
> > +                                     struct net_device *netdev,
> > +                                     struct tls_crypto_info *new_crypt=
o_info)
> > +{
> > +     struct tls_offload_context_tx *offload_ctx =3D tls_offload_ctx_tx=
(ctx);
> > +     bool rekey_pending =3D test_bit(TLS_TX_REKEY_PENDING, &ctx->flags=
);
> > +     bool rekey_failed =3D test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> > +     bool defer =3D true;
> > +     int rc;
> > +
> > +     if (!rekey_pending && !rekey_failed)
> > +             defer =3D tls_has_unacked_records(offload_ctx) ||
> > +                     tls_is_pending_open_record(ctx);
>
> [ ... ]
>
> > @@ -1354,7 +1769,10 @@ static int tls_device_down(struct net_device *ne=
tdev)
> >               /* Stop offloaded TX and switch to the fallback.
> >                * tls_is_skb_tx_device_offloaded will return false.
> >                */
> > -             WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xm=
it_skb_sw);
> > +             if (!test_bit(TLS_TX_REKEY_PENDING, &ctx->flags) &&
> > +                 !test_bit(TLS_TX_REKEY_FAILED, &ctx->flags))
> > +                     WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
> > +                                tls_validate_xmit_skb_sw);
>
> [Severity: Medium]
> This reads the rekey flags and writes sk_validate_xmit_skb under
> down_write(&device_offload_lock), but tls_device_complete_rekey() clears
> those flags and publishes the validator *after* up_read():
>
> release_lock:
>         up_read(&device_offload_lock);
>         ...
>         clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
>         ...
>         smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_sk=
b);
>
> Can this decision be undone right after it is made?  CPU0 finishes
> tls_device_dev_add_tx() and calls up_read(); CPU1 (NETDEV_DOWN) takes
> down_write(), decides here, sets ctx->netdev =3D NULL, synchronize_net() =
and
> tls_dev_del(); CPU0 then stores tls_validate_xmit_skb, overwriting CPU1's
> choice.
>
> The socket then reports HW TX offload again after the device context was
> deleted, since tls_is_skb_tx_device_offloaded() is defined as
> smp_load_acquire(&sk->sk_validate_xmit_skb) =3D=3D &tls_validate_xmit_skb=
,
> which is what the comment above is trying to avoid.
>
> Should the flag clear and the validator store happen while
> device_offload_lock is still held?

I'll fix this issue.

> > diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallbac=
k.c
> > index 1110f7ac6bcb..64ac4ef4012b 100644
> > --- a/net/tls/tls_device_fallback.c
> > +++ b/net/tls/tls_device_fallback.c
> > @@ -435,6 +435,30 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct so=
ck *sk,
> >       return tls_sw_fallback(sk, skb);
> >  }
> >
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
> [Severity: High]
> This returns every packet unmodified, including pre-boundary ones, which
> seems to contradict both the comment three lines below ("Packet before
> boundary means retransmit of old data, use SW fallback with the old key")
> and the flag's own documentation in include/net/tls.h ("HW rekey failed,
> permanently stay in SW encrypt mode").
>
> Pre-boundary packets are HW-era records carrying plaintext plus a
> placeholder tag, and the NIC can no longer encrypt them because
> tls_device_complete_rekey() already ran tls_dev_del() and set
> TLS_TX_DEV_CLOSED before falling into rekey_fail.  On that path the newly
> allocated tfm is freed and offload_ctx->aead_send still holds the usable
> old key, so tls_sw_fallback() would work.
>
> If an skb below boundary_seq is validated at qdisc dequeue just after
> TLS_TX_REKEY_FAILED becomes visible, is it emitted in cleartext?  Should
> the FAILED check come after the boundary comparison?

I'll fix this.

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
> > +
> > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > index a62e94508c8b..536f26d68d9d 100644
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> > @@ -445,8 +453,16 @@ static int do_tls_getsockopt_conf(struct sock *sk,=
 sockopt_t *opt, int tx)
> >
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
> >       } else {
> >               crypto_info =3D &ctx->crypto_recv.info;
> >               cctx =3D &ctx->rx;
>
> [ ... ]
>
> > @@ -881,12 +897,34 @@ static int do_tls_setsockopt(struct sock *sk, int=
 optname, sockptr_t optval,
> >
> >       switch (optname) {
> >       case TLS_TX:
> > -     case TLS_RX:
> > +     case TLS_RX: {
>
> [ ... ]
>
> > +             bool tx =3D optname =3D=3D TLS_TX;
> > +
> > +             if (tx)
> > +                     mutex_lock(&tls_get_ctx(sk)->tx_lock);
> >               lock_sock(sk);
> > -             rc =3D do_tls_setsockopt_conf(sk, optval, optlen,
> > -                                         optname =3D=3D TLS_TX);
> > +             rc =3D do_tls_setsockopt_conf(sk, optval, optlen, tx);
> >               release_sock(sk);
> > +             if (tx)
> > +                     mutex_unlock(&tls_get_ctx(sk)->tx_lock);
> >               break;
> > +     }
>
> [Severity: Medium]
> The changelog describes only the TX rekey state machine, but two changes
> here affect sockets that never do a KeyUpdate.
>
> tx_lock is now taken for every TLS_TX setsockopt, including the initial
> key installation and SW-only sockets, adding a tx_lock -> lock_sock
> ordering on a path that previously took only lock_sock.  The reasoning
> exists only as the comment in this hunk.
>
> do_tls_getsockopt_conf() above now reports the *pending* key's
> crypto_info, IV and rec_seq from tls_offload_ctx_tx(ctx)->rekey whenever
> ctx->rekey.cipher_ctx is set, so getsockopt(SOL_TLS, TLS_TX) returns
> different data than before while a rekey is pending.
>
> Could the commit message mention both of these behaviour changes?

I'll mention both of these behaviour changes in the commit message

> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 7b6ab992c86e..89f60cedb142 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -2411,6 +2410,23 @@ void tls_sw_ctx_tx_init(struct sock *sk, struct =
tls_sw_context_tx *sw_ctx)
> >       sw_ctx->tx_work.sk =3D sk;
> >  }
> >
> > +int tls_sw_drain_tx(struct sock *sk, struct tls_context *ctx)
> > +{
> > +     struct tls_sw_context_tx *sw_ctx =3D tls_sw_ctx_tx(ctx);
> > +     int rc;
> > +
> > +     if (tls_is_pending_open_record(ctx))
> > +             tls_sw_push_pending_record(sk, 0);
> > +     tls_encrypt_async_wait(sw_ctx);
> > +     rc =3D tls_tx_records(sk, -1);
> > +     if (rc < 0 || tls_is_partially_sent_record(ctx) ||
> > +         tls_is_pending_open_record(ctx))
> > +             return rc < 0 ? rc : -EAGAIN;
> > +
> > +     cancel_delayed_work_sync(&sw_ctx->tx_work.work);
> > +     return 0;
> > +}
>
> [Severity: Medium]
> Can this return 0 with records still linked on sw_ctx->tx_list?  The
> return values of tls_sw_push_pending_record() and
> tls_encrypt_async_wait() are discarded and list_empty(&sw_ctx->tx_list) i=
s
> never checked.
>
> On an async encryption error (or sk->sk_err already set),
> tls_encrypt_done() takes the error branch, sets rec =3D NULL and therefor=
e
> never marks the record tx_ready nor unlinks it:
>
>         if (err || sk->sk_err) {
>                 rec =3D NULL;
>                 ...
>         }
>
>         if (rec) {
>                 smp_store_mb(rec->tx_ready, true);
>
> tls_tx_records() then hits the non-ready head, breaks and returns 0, so
> tls_device_complete_rekey() proceeds and ends with:
>
>         memzero_explicit(&offload_ctx->rekey, sizeof(offload_ctx->rekey))=
;
>
> wiping the tx_list head while the tls_rec is still linked to it.  Does
> that leak the rec together with its msg_plaintext / msg_encrypted pages
> and their sk_mem charges, and silently drop a record that sendmsg already
> accepted?
>
> The same applies to an orphaned open_rec: tls_push_record() clears
> pending_open_record_frags before encryption, so tls_is_pending_open_recor=
d()
> reads false while open_rec is still set.

I'll fix this issue
