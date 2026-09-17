Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA144A4F17
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685386; cv=pass; b=s97RUCQrStOx5iF37Vq5+4+zXm/FfOxpZjzqLUqSMtRTfMjyJprxwM8E+8xqKvKrmtHYMyJVt3+kczPucqiKUieHx8ZA4O9g/py3LBdqsuerxuN1FjTaPjV6QloObo4Ly5RA2CiEV6HYFFvG5h8IaH58YoVY4YZf9cCYrY/fno8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685386; c=relaxed/simple;
	bh=g1y2S3ScLNqMokaua6sHRpGqfvZQebFLnNN6s3pO3co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQUUOvNl+3oXSalhYlWkWrC68LI2r5ZoSPVkA8mGBxSHn+kUzjA8+PVku6pKxFJFBtTGZufNdv2v+vbF9D1/ceHeCb3lH422HLazEsS4NTKN9LmYqCJc1LXuAAg2YP3vXeZscpUZrT/0ht5W3jOYkEV2K9HhrDstho6SfEi90po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=zlV+Y/K0; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="zlV+Y/K0"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7b3so56306241.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789685383; cv=none;
        d=google.com; s=arc-20260327;
        b=amkO929RnWy601FEQ1k5irzebEJrGky1gu0QxQg7zvxB168fPImtv4T7rxfw6cZ4q1
         iEp6RuI7BQpMoI8CLlmXhBPQgb+/k91MQ+/c0zUXXy1osdxdIZxRFkkhmItmFdnVUrl5
         LKMIgy9AJ4Te6RdnH939ecKwwSocZ8E1Wlu7DJ58HaUVUsheNW/ljdYGfS/OFnFbEPED
         AoAqvInMAa/SlZ6aOKRN/1IZHJefaYquVsyys44JJMawPBhH8Y+J9ykpW/QIR0NkJc6u
         NICUEqamCSNtF4KaG7GE8Rq62l42wT5iLm/3EolpXYMPFT9DrY7aUWAUaylbGtGSKyux
         Fyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gMnz9tKs4f0Xfd9UUmRoba4haQbv4Z/vBZCuMSGDjfo=;
        fh=KDPEyLFrx0IaPdgkSonKsexwzLCh01ZOslfJI1v3q8w=;
        b=kP1wrHFhsTmVCbYKVqN50FcsbxFhVOqXAgDfct+aQ7BQQ8e7ab1iCRvShhZViwG3F7
         XePKaTsH59+MUbm6vB7vMA8IB9d4+ULPSmpIp4MeKt4FDGf35JWhCz9HC5MR88XVWfSz
         pZZ+QotHJIo0RgM9FiySJn1Qd1+URI3OJK59/Y99IiY+XC1HVrXChH17gvYAmaDVqo3r
         NXm8eRsPhHGMf1RxUaL/+EtBgTLqqMzZI57t+i1O6msJGiA0WtbqIQWbB+nKuFjNeKYM
         imhgL/+tHSfi1i5wWJPpLEhy1jq9l+10xB9xqUSM5+H9VuhyYExSxI3T63ZuefoRjFc0
         Gd4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1789685383; x=1790290183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gMnz9tKs4f0Xfd9UUmRoba4haQbv4Z/vBZCuMSGDjfo=;
        b=zlV+Y/K0HOwmRNmD+pQL5F8C312OqQBXz/48ekPNarEjPNT3Ey1WgB6dU0ZR0wpcsB
         8+LN/xuyYKLu2mciktYBLsc2aURwXg6Dmra7LvUVmEx1ikk99hPs9pCTikQxF203iXKE
         lDmz7iqO76O+gamGzGWapJ5NZPsftn/rNIIh60IbK6/gZdPUbkHynTSLkivXDrQEiuir
         CThs+xe7/eam/Waax8FXm+zrFggT7V9f/+angIZhrjVnalgne44b0tb9Ka94lzy6QieP
         dhwUlKvNHru+dtFRytUb2D9YT9j+G3eyCT7XXYmpG02z/s0WQ5ObWfqs94KwIJr597+V
         gLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685383; x=1790290183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMnz9tKs4f0Xfd9UUmRoba4haQbv4Z/vBZCuMSGDjfo=;
        b=VUYAAsRFEB6wHJZ62cEu9732aYxUp4cjzWrntCpEXhJlR0YAErmQBVEIAYwX0GYgSS
         PmAOzqj6QKj5+ZbnV+GxmK7CiZwwmA5QOOkFRZYDKZ74QBUvFp9qHxOhq8vE3cJ0mMGi
         u936VatuBGQ7tHFfs33LxgRkg9j9HjOHseGcD870nGQzyLcmfUsY0flRa7IMe5+4ONUt
         7MPxdFawNv0XDvOiMoZx7swT5P/FdKPZRkowy0CXu3vCFYgY6jWC4Q41hPCTb84gqs0r
         2qaG3zLtsU5B7Ww3IQadg32QQKyn7kUXQnXk4Mj6vkNSbn6kAZS7iJzSIcCq5atQ9EKv
         +wqg==
X-Gm-Message-State: AFuF++mk5b/thu1ocRX2bfsow7npN0hGD1W/msCjOC4os8HiKb8vCq49
	KxV9PWPSWm0vHsmcBJn6WCwNwuld6zyf0iCvvhPV8eIxMrVfnkR5GcX56EKp1PUzpcWrv66WoDh
	jpQ81g6AP3UZBdkcKfXoDvRTJqlOI6UbrQU67YGRbLI2E4q/F5nW7MTQ=
X-Gm-Gg: AYBFou1YzMCpAzKuEBrmZVE/HY5HDwQHy3JOLkMsLVLBDDiy8C6Niidr6bQAX76syta
	GjdLrQzGhfa+eDI4mQcRotx0/OqGUM9p/BC9jYzVmF0OvtpcM/8RuoqXQF5INGXTXzsLrYUkbkd
	+sF6XTzAK2FasZh1JunAEnHTPnNRbGZrsk2X+KeDmuwM1KHX6dFn9htHSvL1FLJoKDd+iWT6idy
	kAePyuJ9px4VyM1OADaYNKgc5z84Q30DOfmsCgaoZLjmPahAb145jQq2YWXV+dffEMCmsVEFlRO
	hunvRQzP6KZUxFkuxsDvxm4ARwci7quoBK8TXEbQjZ90LASiiMGHYKbL+GPEzikyoj3zVPJ6Jp9
	/9NkkwDKMZLgaW+msPi/SrkY4QBYe+wrCoHe7bi2uVAKFiIXji6gv5CkPBjQaL+u7LblKUUBWx0
	g0BbEj0s+rYs906cFpWDPUKm5zE0b1K1ak0WtqUCTq
X-Received: by 2002:a05:6102:e12:b0:7a4:ebdb:cc0c with SMTP id
 ada2fe7eead31-7a55a72b4d1mr307255137.6.1789685382649; Thu, 17 Sep 2026
 15:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807183853.2288959-6-rjethwani@purestorage.com> <20260817221141.3666393-1-kuba@kernel.org>
In-Reply-To: <20260817221141.3666393-1-kuba@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 17 Sep 2026 15:49:30 -0700
X-Gm-Features: AcwNN1VdPLRzjL3LMeMbWl1DlTVo4J639WuRy6NrMJDEJ6TRFiz5Bn6zB5dPz0w
Message-ID: <CAKaoeS1f3O=0+yM7KTbfjot+V4kzX3OcurKAEMfak9c8KEBa9w@mail.gmail.com>
Subject: Re: [PATCH v16 05/10] tls: split tls_set_sw_offload into init and
 finalize stages
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
> tls: split tls_set_sw_offload into init and finalize stages
>
> This splits tls_set_sw_offload() into tls_sw_ctx_init(), which allocates
> the SW contexts and sets up the AEAD transform, and tls_sw_ctx_finalize()=
,
> which copies the salt/IV/record sequence into the live cipher context.
> tls_set_device_offload_rx() is converted to call the two halves separatel=
y.
>
> A couple of questions below.
>
> > diff --git a/net/tls/tls.h b/net/tls/tls.h
> > index 60a37bdaaa25..5a6ee1ea00f8 100644
> > --- a/net/tls/tls.h
> > +++ b/net/tls/tls.h
> > @@ -147,6 +147,10 @@ void tls_strp_abort_strp(struct tls_strparser *str=
p, int err);
> >  int init_prot_info(struct tls_prot_info *prot,
> >                  const struct tls_crypto_info *crypto_info,
> >                  const struct tls_cipher_desc *cipher_desc);
> > +int tls_sw_ctx_init(struct sock *sk, int tx,
> > +                 struct tls_crypto_info *new_crypto_info);
> > +void tls_sw_ctx_finalize(struct sock *sk, int tx,
> > +                      struct tls_crypto_info *new_crypto_info);
>
> [Severity: Low]
> Would it be worth documenting the pairing contract of these two helpers
> here?  As written, tls_sw_ctx_finalize() may only be called after a
> tls_sw_ctx_init() that returned 0, with the same tx value, the same
> new_crypto_info pointer, and an unchanged crypto_info->cipher_type.  Sinc=
e
> finalize() returns void it cannot report a violation, and the tx /
> new_crypto_info selection logic is now duplicated in both halves.
>
I'll document the pairing contract above the declarations in net/tls/tls.h

> >  int tls_set_sw_offload(struct sock *sk, int tx,
> >                      struct tls_crypto_info *new_crypto_info);
> >  void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index bbb1aa733500..cf67e1f6c5f4 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -1235,7 +1235,7 @@ int tls_set_device_offload_rx(struct sock *sk, st=
ruct tls_context *ctx)
> >       context->resync_nh_reset =3D 1;
> >
> >       ctx->priv_ctx_rx =3D context;
> > -     rc =3D tls_set_sw_offload(sk, 0, NULL);
> > +     rc =3D tls_sw_ctx_init(sk, 0, NULL);
> >       if (rc)
> >               goto release_ctx;
> >
> > @@ -1249,6 +1249,7 @@ int tls_set_device_offload_rx(struct sock *sk, st=
ruct tls_context *ctx)
> >               goto free_sw_resources;
> >
> >       tls_device_attach(ctx, sk, netdev);
> > +     tls_sw_ctx_finalize(sk, 0, NULL);
>
> [Severity: Low]
> The commit message describes this as separating "cipher context
> initialization from key material finalization", but this hunk also change=
s
> the order of operations in tls_set_device_offload_rx().
>
> Before the patch, tls_set_sw_offload(sk, 0, NULL) filled in ctx->rx.iv an=
d
> ctx->rx.rec_seq before netdev->tlsdev_ops->tls_dev_add() programmed the N=
IC
> and before tls_device_attach() published the context on tls_device_list a=
nd
> swapped sk->sk_destruct.  Now ctx->rx stays zeroed across both of those
> calls and is only committed afterwards.
>
> The split by itself could have been done with tls_sw_ctx_finalize() invok=
ed
> at exactly the point where the old copy happened, so the new ordering loo=
ks
> like a deliberate choice.  Could the commit message say why finalize() ha=
s
> to run after tls_dev_add() and tls_device_attach()?
>
> For what it is worth, the window looks harmless at this commit: the whole
> function runs under lock_sock() and down_read(&device_offload_lock), the =
RX
> data path is only armed later by tls_sw_strparser_arm(), the RX tls_dev_a=
dd()
> call is passed &ctx->crypto_recv.info rather than ctx->rx, and no in-tree
> tls_dev_add() implementation reads the SW cipher_context.  A note in the
> changelog would still help reviewers and anyone backporting this.

I'll modify the commit message

> >       up_read(&device_offload_lock);
> >
> >       dev_put(netdev);
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 62d46736e24b..63c83247f9a3 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
>
> [ ... ]
>
> > @@ -2650,3 +2631,55 @@ int tls_set_sw_offload(struct sock *sk, int tx,
> >  out:
> >       return rc;
> >  }
> > +
> > +void tls_sw_ctx_finalize(struct sock *sk, int tx,
> > +                      struct tls_crypto_info *new_crypto_info)
> > +{
> > +     struct tls_crypto_info *crypto_info, *src_crypto_info;
> > +     const struct tls_cipher_desc *cipher_desc;
> > +     struct tls_context *ctx =3D tls_get_ctx(sk);
> > +     struct cipher_context *cctx;
> > +     char *iv, *salt, *rec_seq;
> > +
> > +     if (tx) {
> > +             crypto_info =3D &ctx->crypto_send.info;
> > +             cctx =3D &ctx->tx;
> > +     } else {
> > +             crypto_info =3D &ctx->crypto_recv.info;
> > +             cctx =3D &ctx->rx;
> > +     }
> > +
> > +     src_crypto_info =3D new_crypto_info ?: crypto_info;
> > +     cipher_desc =3D get_cipher_desc(src_crypto_info->cipher_type);
> > +
> > +     iv =3D crypto_info_iv(src_crypto_info, cipher_desc);
> > +     salt =3D crypto_info_salt(src_crypto_info, cipher_desc);
> > +     rec_seq =3D crypto_info_rec_seq(src_crypto_info, cipher_desc);
> > +
> > +     memcpy(cctx->iv, salt, cipher_desc->salt);
> > +     memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
> > +     memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);
>
> [Severity: Low]
> Should this repeated get_cipher_desc() lookup be NULL checked?
>
> get_cipher_desc() returns NULL for a cipher_type outside
> [TLS_CIPHER_MIN, TLS_CIPHER_MAX], and here the result is dereferenced
> straight away by crypto_info_iv() / crypto_info_salt() /
> crypto_info_rec_seq() (which read cipher_desc->*_offset) and by
> cipher_desc->salt / ->iv / ->rec_seq in the memcpy() calls.
>
> The sibling stage still guards the identical lookup:
>
> net/tls/tls_sw.c:tls_sw_ctx_init() {
>         ...
>         cipher_desc =3D get_cipher_desc(src_crypto_info->cipher_type);
>         if (!cipher_desc) {
>                 rc =3D -EINVAL;
>                 goto free_priv;
>         }
>         ...
> }
>
> Today both callers reach finalize() only after an init() that validated t=
he
> same cipher_type (tls_set_sw_offload() returns early on error, and
> tls_set_device_offload_rx() checks rc from tls_sw_ctx_init()), and
> do_tls_setsockopt_conf() rejects unknown cipher_type before that, so this
> does not look reachable.  Since the helper is now exported module-wide as
> void, though, would re-checking cipher_desc (or at least a comment statin=
g
> the assumption) be preferable?

I'll add the comment stating the assumption.

> > +
> > +     if (new_crypto_info) {
> > +             unsafe_memcpy(crypto_info, new_crypto_info,
> > +                           cipher_desc->crypto_info,
> > +                           /* size was checked in do_tls_setsockopt_co=
nf */);
>
> [Severity: Low]
> The retained justification comment names only do_tls_setsockopt_conf(), b=
ut
> tls_set_device_offload_rx() is now also a caller of this code.  Should th=
e
> comment be extended to cover the device path as well?

The comment names where the length was validated, not the immediate caller,
so it stays correct for the device path too. Both offload paths receive
new_crypto_info from do_tls_setsockopt_conf(), which checks
if (optlen !=3D cipher_desc->crypto_info)
before filling the buffer, and then hands that same validated crypto_info t=
o
either tls_set_device_offload_rx() or tls_set_sw_offload(). So the
unsafe_memcpy() length is guaranteed regardless of which offload path we ca=
me
through. I'd rather leave the comment as-is than risk implying there's a
second, separate check on the device path.

> Separately, finalize() commits crypto_info, the IV and the record sequenc=
e
> into the live socket context, and calls tls_finish_key_update() for RX,
> without any indication that the crypto_aead_setkey() in the init stage
> succeeded.  Is the caller expected to guarantee that ordering?
>
> > +             memzero_explicit(new_crypto_info, cipher_desc->crypto_inf=
o);
> > +
> > +             if (!tx)
> > +                     tls_finish_key_update(sk, ctx);
> > +     }
> > +}

Yes, that's the contract of the init/finalize split: tls_sw_ctx_init() is t=
he
fallible stage (setkey is deliberately its last failable operation), and
tls_sw_ctx_finalize() is the infallible commit. Every caller runs init, che=
cks
its return, and only calls finalize on success
