Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E16248881
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685456; cv=pass; b=jkOE1k/uu5OzZl16+GvldcVSMAmkFaMlaGDYLLe9id4ebBZU0OMR8xDK1LKKXAu21ABwkkD0bGVk++lfFl2+kBZ0DA7aIjT5KcRqwihrfh/zLZtRwavFDx2hYjeLKaMn8p6yzZF0M+qKKMiaHM83OGd+0HNMNUeKMuAU5EtSy+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685456; c=relaxed/simple;
	bh=9zeiOctv/oDwLgnhTEh7NGGPyDhzrBKnGLL9H/D8ra0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPem9wfTa9zP06s5D2VJ+L4QcsrGJlaRkdPNCPoQsk3x9ErxR7T1/1o5mYiDi4WZSLcxX+VPXloZ0yhZdu+kvecmo/O+64BVZ8Me80KWxADVUddAob6hv9WMy5OB4jOKDLM8DsZWL+u/rbNygGKW3oWFKMpmHsk7pHpCMtZEQXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=b7lEqdcW; arc=pass smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="b7lEqdcW"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c67e2ff27bso55081e0c.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789685454; cv=none;
        d=google.com; s=arc-20260327;
        b=J/7XeeoK+nn1pIuGWPldKmKd5nlM8BvhDiVlRbIxg1NUfJjocpV9KbfWeBwTbEQWJN
         gUMVcasu27G8UtRpyj4EEoMOR/VSIWL7c+QN6ezshCWvknyQsu5XIJmnlVEpUxBaSqUU
         n7cDwmYiQrZzSdXXzHrWnh7tMU6R1LWP4ULN+FmOoqZUHgGwo7bg5m6d3b9d0XXghT5m
         yHu+IG2i1vUpxI9jxtedtotDzqKWX+YDNwcCWw9hUzn7DDFoPPm7M1TKNH7kYC9YKSzu
         rFQ0TtIAXHOpI4/psJXPwmta06XP6h9f9UiwYsgkwNCSbJSFg3JctWYdGa+z5PCHewsH
         mUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HELBCvyToCkWOYDLD1irlMxcH1TgKtopLF4Pt3KBQrU=;
        fh=KDPEyLFrx0IaPdgkSonKsexwzLCh01ZOslfJI1v3q8w=;
        b=cvvtsGc+Qpzsyv7kgd8pumBnVfKZ2iVSTz1+buvYsCI9QUEpZ1jvdqy1QYLGNq7dgc
         6dUP83plj6jOMDiJe+QLpPfCIlUlkW/dUUqDm20soGc6DvSpoV6z6ME9EJwfKv6I2p93
         44NranFwg+KwA6HGBlZqhixgVOJMMv3/V0rJrpxI6FgkzzjjZv5C/atakf9ZaDeApPgR
         OygXnqYUOjz1XbHuvU28tmeYUJDGHTOsxg/8kHC1uhu+lgra4nzNzpOAOBmiVxT4a64g
         0i/qPiH4IbqEwbakry4JiN79JEuB5mijPAXmKgbSpGkkluFb+OK2L0Y7HYaC5FNPwStZ
         mHzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789685453; x=1790290253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HELBCvyToCkWOYDLD1irlMxcH1TgKtopLF4Pt3KBQrU=;
        b=b7lEqdcWi4WPMBOKv75pFj9zPSMGDaSeHSbx2aAJ9QFwDD5MRmjgjbdQXwo8PR+/ak
         hDE8O/JIvuEpdzjN7iEi3WpL1T8XkUZW065qAHoxTVEeQM++L69likHUbkl10hHwfddA
         ANNqPg62Su+utG0fzgDgmLPu3MDAzPYSp9rfVinwqHXywfxlN0NQ2nDPIFlPo6Tiva51
         5h32v1IYuHPeSW6mWlcGbhMbDOBK4k1BYQYjrZ6anUFfgeqNMU0mMwZ1fjn66I1TNJqn
         rQvW2RDF9YqaP5ipmeakNXTlcgWScRGgH3XOZIN0xV7XK8s1TZS1oI/zpVMiOwWfRr8i
         TuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685453; x=1790290253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HELBCvyToCkWOYDLD1irlMxcH1TgKtopLF4Pt3KBQrU=;
        b=Yw5KuVm8B0efzynjbN43WlojEMpuf2UHtepHQdcPZBegOeqb4ECGCcOc9AaWqjnv6Q
         r0ogyQdKZ7pqOW6e/WlCD6g7Bg9IyCnG6hUKnwsV8wSOVNo5FmqrusAwGdapn3c/lNuo
         JN6SG0Z1iYSYI1UaFoNN4Sl6Viz7pJcKqJYOwIUVeg4IMIc0L2NjkKcheBLm0IHHNQCv
         3uoDCRmI5o+e1dzWPrW8RrpQecpyeWLSWH19FK4H3gVBAc1KZOUAYvv/ZFlgIl/PLWEC
         h0tjOcrMPjS2w3yT20WHxqO/WQ/0CmCXaJQDBzIihYq5liJ4uLT7yi8V6lv3gLBP7Juj
         KjlQ==
X-Gm-Message-State: AFuF++mb9R7/eY6FX311Uff1+HpeAIVr90xkesozIQl15OHIP4DTQI5h
	zBth2ETU5pUaBj75t/QqIlXxds3saBwPVs2vfdR2agzXa+9TXZ3Uwa6hzLydBuRgRjG6wS0V+Oi
	LyGu5zycCw4whghjjNgabQPIfQxJ5vbhckZV9m7/YpA==
X-Gm-Gg: AYBFou03QxIXibWcVJNF5ErthmqZ6iytlnnak31md4Zzyl8mh7Swi0rh4E0qqCrEfwc
	sC8uPXbvKykttvf42ftFbwktz+3ZU5vLlzXwI/ArdRIJM1pQPWVc5xcViWqS+vffnr8ocbk6yx+
	i7yceESIkuIzysSPCQaDI5Pw3dhB+UgTrvK0xW9tcsKmd7cGGykC/If62aBJEPG0whcrKEnkSvS
	oiAh3R6wUucO/Wb8Zytt5J0t3hWfF133768vqFe20DnbS+Z/3/bNf1A407nKfHnbKhKAhxhhPJa
	B7+QR/RT2eIvi0fjAsAIKf6W+Mo3ybrMcahdGv1rti9gk+JL6m2j0rN9K8hNLN92OGnJzTFRwgF
	qsDYhDByJ4tjA3rM+YUp/vbV3sxFG0OLdYL7UKyw1MEwG6A57QV2p2ji/kq2/qKOQGbDZDVC78a
	XUQ3Eav/MBdpS99gDFWAFn3/Ka4Ev66mCeY7cFsJv/nwX/hxNTtf8=
X-Received: by 2002:a05:6102:5e8e:b0:7a5:1d40:8d1c with SMTP id
 ada2fe7eead31-7a55781ca8dmr350401137.0.1789685453258; Thu, 17 Sep 2026
 15:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807183853.2288959-10-rjethwani@purestorage.com> <20260817221146.3666526-1-kuba@kernel.org>
In-Reply-To: <20260817221146.3666526-1-kuba@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 17 Sep 2026 15:50:42 -0700
X-Gm-Features: AcwNN1UZR8jWdMYQHhPVEhCjpz7Aa8fps7WmJrJpQp4TvqMpBDa1BcCSuwsYXp0
Message-ID: <CAKaoeS2n-5vnn4KH6yGkr1C5WX3cjWZTtxXoMoHTxRjTtmhO8A@mail.gmail.com>
Subject: Re: [PATCH v16 09/10] tls: device: add tracepoints for the KeyUpdate path
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
> tls: device: add tracepoints for the KeyUpdate path
>
> This adds four trace events to net/tls/trace.h and wires them into the
> RX and TX rekey paths in net/tls/tls_device.c. The events are intended to
> let an operator follow the KeyUpdate state machine: rekey start, the
> old-key reencrypt pass, boundary crossing, and TX rekey completion
> failure in sendmsg.
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index c34268cd9531..9a4c121dbebb 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -760,8 +760,14 @@ int tls_device_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t size)
> >       lock_sock(sk);
> >
> >       /* Old-key records all ACKed; switch back to HW. */
> > -     if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
> > -             tls_device_complete_rekey(sk, tls_ctx, true);
> > +     if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags)) {
> > +             rc =3D tls_device_complete_rekey(sk, tls_ctx, true);
> > +             /* On failure the READY bit is left set; the next sendmsg
> > +              * retries.
> > +              */
> > +             if (rc)
> > +                     trace_tls_device_complete_rekey_fail(sk, rc);
> > +     }
>
> [Severity: Low]
> Can this event ever fire for an actual HW rekey failure?
>
> tls_device_complete_rekey() has only one non-zero return, the drain at
> the top:
>
> net/tls/tls_device.c:tls_device_complete_rekey() {
>         ...
>         rc =3D tls_sw_drain_tx(sk, ctx);
>         if (rc)
>                 return rc;
>         ...
> }
>
> Every other failure (netdev gone, crypto_alloc_aead(),
> crypto_aead_setkey(), crypto_aead_setauthsize(), tls_device_dev_add_tx())
> goes to release_lock and then rekey_fail, which returns success:
>
> net/tls/tls_device.c:tls_device_complete_rekey() {
> rekey_fail:
>         ...
>         set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
>         ...
>         return 0;
> }
>
> So the case that permanently drops the connection to SW encryption emits
> nothing, while the case that does emit the event named _fail is
> tls_sw_drain_tx() returning -EAGAIN:
>
> net/tls/tls_sw.c:tls_sw_drain_tx() {
>         if (rc < 0 || tls_is_partially_sent_record(ctx) ||
>             tls_is_pending_open_record(ctx))
>                 return rc < 0 ? rc : -EAGAIN;
> }
>
> which is a transient retry rather than a failure. Should the tracepoint
> be emitted from the rekey_fail path instead, or in addition?

I'll split the two conditions into distinct tracepoints so both are
observable and neither is misnamed:

- tls_device_complete_rekey_retry(sk): new event at the call site, for
the transient -EAGAIN (old-key records not yet fully ACKed; READY bit
left set, next sendmsg retries). No rc field since it's always
-EAGAIN.
- tls_device_complete_rekey_fail(sk, rc): now emitted from the
rekey_fallback path, where rc still holds the originating error, i.e.
the actual hard failure that pins the connection to SW.

>
> > @@ -1267,6 +1273,9 @@ int tls_device_decrypted(struct sock *sk, struct =
tls_context *tls_ctx)
> >                               return 0;
> >                       }
> >
> > +                     trace_tls_device_rekey_reencrypt(sk, rec_start_se=
q,
> > +                                                      ctx->rekey.old_n=
ic_boundary);
> > +
> >                       /* rekey_fixup sets decrypted flags in case the N=
IC clears
> >                        * decrypted flags on auth failure
> >                        */
> > @@ -1277,6 +1286,8 @@ int tls_device_decrypted(struct sock *sk, struct =
tls_context *tls_ctx)
> >                                                           sw_ctx, tls_c=
tx);
> >               }
> >
> > +             trace_tls_device_rekey_done(sk, rec_start_seq,
> > +                                         ctx->rekey.old_nic_boundary);
> >               crypto_free_aead(ctx->rekey.old_aead_recv);
> >               ctx->rekey.old_aead_recv =3D NULL;
> >
> > @@ -1923,6 +1934,8 @@ int tls_set_device_offload_rx(struct sock *sk, st=
ruct tls_context *ctx,
> >                                       netdev->tlsdev_ops->tls_dev_rx_re=
key_fixup;
> >                               context->dev_add_pending =3D 1;
> >                       }
> > +                     trace_tls_device_rekey_start(sk, copied_seq, rcv_=
nxt,
> > +                                                  before(copied_seq, r=
cv_nxt));
> >               }
> >       }
>
> [Severity: Low]
> Is this the only arm that should be traced?
>
> The call sits inside the else arm of the RX rekey branch. The other arm
> in tls_set_device_offload_rx() also accepts a rekey and defers dev_add,
> and emits nothing:
>
> net/tls/tls_device.c:tls_set_device_offload_rx() {
>                 if (context->rekey.old_aead_recv &&
>                     before(copied_seq, context->rekey.old_nic_boundary)) =
{
>                         /* Previous rekey still draining. ... */
>                         context->dev_add_pending =3D 1;
>                 } else {
>                         ...
>                         trace_tls_device_rekey_start(...);
>                 }
> }
>
> That first arm is the "old-key data is still queued, dev_add deferred"
> state the commit message attributes to inflight=3D1. Since
> tls_device_decrypted() emits trace_tls_device_rekey_done() for any
> non-NULL ctx->rekey.old_aead_recv, wouldn't a second KeyUpdate arriving
> while the previous one is still draining produce a rekey_done with no
> preceding rekey_start?
>
> Also, inside the traced arm the event fires even when
> before(copied_seq, rcv_nxt) is false, in which case no old-key state is
> created and rcv_nxt is never stored into ctx->rekey.old_nic_boundary.
> Does the reported nic_boundary describe anything in that case?

On balance: start/done bracket the drain window, not each KeyUpdate. A wind=
ow
is opened in one place (old_aead_recv set) and torn down in one place
(old_aead_recv freed in tls_device_decrypted()), so every rekey_done still =
pairs
1:1 with an inflight=3D1 rekey_start. The "still draining" arm keeps the pr=
ior
window untouched, so it can't orphan a done, but you're right it emitted
nothing, hiding a KeyUpdate deferred behind a drain. Added a rekey_start th=
ere
with the existing old_nic_boundary, inflight=3D1.

On inflight=3D0: intentional and flagged by the inflight field. nic_boundar=
y is
rcv_nxt, the flushed receive frontier that would have become the boundary h=
ad a
drain been needed, not a read-back of old_nic_boundary. Clarified that in t=
he
commit message.

> [Severity: Low]
> Are the start and done events meant to pair up?
>
> trace_tls_device_rekey_start() is emitted here, before the rekey can
> still be aborted. If the following tls_sw_ctx_init() fails, the
> release_ctx path undoes the state that was just traced:
>
> net/tls/tls_device.c:tls_set_device_offload_rx() {
> release_ctx:
>         ...
>                 context->dev_add_pending =3D was_dev_add_pending;
>                 if (moved_aead_recv) {
>                         ...
>                         sw_ctx->aead_recv =3D context->rekey.old_aead_rec=
v;
>                         context->rekey.old_aead_recv =3D NULL;
>                 }
> }
>
> so a rekey_start is recorded for a rekey that did not take effect, with
> no cancelling event.
>
> In the other direction, rekey_done is emitted only at the free site in
> tls_device_decrypted(). old_aead_recv is also freed because the boundary
> was already crossed here:
>
> net/tls/tls_set_device_offload_rx() {
>                         if (context->rekey.old_aead_recv) {
>                                 crypto_free_aead(context->rekey.old_aead_=
recv);
>                                 context->rekey.old_aead_recv =3D NULL;
>                         }
> }
>
> and on the RX teardown and context-free paths, none of which emit
> rekey_done. Should those sites emit the event too, or should the commit
> message avoid describing the events as a start/done pair?

I'll add rekey_done at the supersede free in
tls_set_device_offload_rx() and modify the commit message.


> > diff --git a/net/tls/trace.h b/net/tls/trace.h
> > index 2d8ce4ff3265..2a90b77d75e8 100644
> > --- a/net/tls/trace.h
> > +++ b/net/tls/trace.h
> > @@ -192,6 +192,104 @@ TRACE_EVENT(tls_device_tx_resync_send,
> >       )
> >  );
> >
> > +TRACE_EVENT(tls_device_rekey_start,
> > +
> > +     TP_PROTO(struct sock *sk, u32 copied_seq, u32 nic_boundary,
> > +              bool inflight),
> > +
> > +     TP_ARGS(sk, copied_seq, nic_boundary, inflight),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(        struct sock *,  sk              )
> > +             __field(        u32,            copied_seq      )
> > +             __field(        u32,            nic_boundary    )
> > +             __field(        bool,           inflight        )
> > +     ),
>
> [ ... ]
