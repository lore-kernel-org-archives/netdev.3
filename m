Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF84B95D1
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574488; cv=pass; b=lH7pX5yOP6RGCkZT6Sn1luETKRy8C7BlD/7nTJRF9HvWmydPhzyezntE1Et9b4Tr3m6O43Hl44BUDEvq1gC+ZZeCrCgND6KKgjHpgMPHZuCyJKgLx1o6I2bzsfUW+d53Dn+tz7A/GeN0a2HHftmOiSx0UxKPB6zv3rthE34ftGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574488; c=relaxed/simple;
	bh=KZzkhX7Yg9tq5VztU7UiOhKrR7TxsvCHoG9frYwd3EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxBZQZ8EXUra99uql7WTWmqrWtz0L3VMMemLZBxbWXSosIZhN6H3viZniogHIzwXUMQ/kVlII1I3CfknOGaPNE76YAsST3nKKmNG+GVKsVhAoC5rOpMCCVboMbOkhTfnQD69fGcJzGhN2fp2VUTpCOpiB+exUXSe0M7Oq/Hr4Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leSSh0IF; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leSSh0IF"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-86ec25cf7ecso2221189b3a.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789574484; cv=none;
        d=google.com; s=arc-20260327;
        b=dqJWocxfiaRm/iaZrfKWo/wRiNSWL9Kn8JasQNVTWomW/x9ASPBo/cKsskHxrfMTYn
         2oGl7fvwt88WGiKypVzgkadAyIKUK/Th71jPzIi3WsqTBxz3xEvLbXoNRhAQUDNOExNI
         mYd0OBtaIKDkY4bvAzenIPhS4F1BmxNCp4hYd2vId6bKai5KV4e3DcyA4DnU8PnGK6fo
         pG9N0cNSMsdQhaxSnfPJDSaJNhM3vXsWAHPGSIc7OPy3b1LiZ8Msfae1w+FIMY2xN8zL
         rk1PikVFJgLaKZ/0gYtzlGSeZ+FMX3lWs6cQUOBtpEWE+P7yFtXWATvD9StXl6gowYgK
         FvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dZUcimEc7wlnFEZ6ZQZ/uU5ugi4xLHu5NBwADbejVU=;
        fh=QFMgEb3XV5rS/ZRBmyHUP58oM4AaOHTWaWQeeAou20k=;
        b=MlGRQPlMpFBnT83/hJ0JVDtY+MxlQ5A5OKC16qjKOjcT4xhp2KN9EynkHzLxzutl+k
         fEwepR086UZY1V85aT5Fq3gzW9XdiTPSzON8+RRMlzn7Bx4wy7XSo8K3wPN+hJiWMFTs
         jWo+EevqiQK++3ix6gcnmw+Xuljs2fSfqRr1WMzrY9Ue1EqstN1q2ogO62YGiQwFlw76
         Fw3oFmbHywAJqk/tJ9GWhWSf/SYsSCR0QynS4pB/0sbK0WWMUehclzyl1Z/AMxiU60MM
         8TvU5YKQXFzV0F4sWnEB86WVGUy4/AIL6KWQ9/n4etA7tIRVn8fzeUn27YOk0FaHYHVx
         TyZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789574484; x=1790179284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6dZUcimEc7wlnFEZ6ZQZ/uU5ugi4xLHu5NBwADbejVU=;
        b=leSSh0IFFHEgnMFzqH6OfPaqDq3ldpBS4QBKF0J6kyr3ouVpnWi4iQduD0xD/F2YL6
         FnohLcWPf+TypudfbQauLUSAh/IolsndmzXO3075QY26JDx4W0SPp+m+i9qqHlDKslFR
         DA5B8jA3oMwZE/54UEEB7E+Tjte4OO+1W7dCeXi8sPR0m5CLHRW9L/ZF8aDPOITL/NvK
         YdfwwSyWx8WJk3JPTjw9hn64RP9OE+7FUWEmuvs8UQRpv8bpk6xq5l/d0G+pf3vGTX5n
         QRmnf79cWMHoEom80kclzvCtGeBmWFzS5WotiMxZNEUuRcrPFWmhmpVMFt8hjqVrPp9z
         ZruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789574484; x=1790179284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dZUcimEc7wlnFEZ6ZQZ/uU5ugi4xLHu5NBwADbejVU=;
        b=nmbUK+kAk5HquU3eoCYIKDFVJhD09jsHh+PItgpPonQdiKWgk5MN/fmS1tWVQM8dPP
         RlHDn1w5PCeBv5aRgsH+8Z0f2tcnVQXZ/aNUr/EOMFnTW446RKeoI5McbD1+W/cOdDQt
         5OKTcrDaxH/d6I+JdApdP/ivxBG8xdx6tAzrqoO4S6PSlm6uaNi8O2Z4lJULnBq1+FD7
         r+puI77T5KwVRhWchxYdqFoSE8OtsNgen0/61+WMPmwQvPfRwjpW97gkdysaIUFA20Dg
         r6Il1g+eUXp313ZnVEDpdSXkh3y+5/hOJMmg9fGKIIx0aWs1QKiGtx8malV3v+1guuyW
         3u1g==
X-Gm-Message-State: AFuF++mX/PM9DqUhH8rNPmz49uTIqFjS9314+71mH654hNiYtV/VlFLD
	nGeT+UmM6sTmpRcU7h1gl0UOD7+3b1THGakIry9zATEY7OtG5sfWy7lu2t1cX6r3Qq5Vk0HYrnG
	MdE97I9kfox1LcnjZTDlpM3rgg8mK32s=
X-Gm-Gg: AYBFou1h5yw9G1HPZ6lzPvUO7WGua22WagXcwnXEL/YkzICyuDEi5LRfOYKvn1AZ/3W
	Qptq7HtnUKybNqhdQ5y0MUPgTBsTz3HkJ6RJY6xBvSsKoXD+8IU+aFQQEXCVXkh6MfHXRZgqHTB
	5WaP56femX4aJ3AsHtqlOxvkI/iUwLMFqCclTHlJaL3GIGgftFiCnCgz/LXng3VrGgJfsrzFpMt
	/Qbxs3XBEqQ7yT37YxlcnWMEEau5CO8nufzULIFpGAyGn4YtD9SJrub/YH41E5iX7++tnVAbzgs
	HXE/qIRoJVsAdUfp4cn8lOPXltkxMpN1h/NWqAMRyomhkBf1/LRgfPZQ2qlIwy75IWItHTRx6oJ
	qVhul5uPPjVxaMKw2Go6CMCGpqrrYLj+MlnL5ZmS14LGmhHq3A/VVwZ9g
X-Received: by 2002:a05:6a00:194d:b0:858:ea6a:4415 with SMTP id
 d2e1a72fcca58-87341085f89mr164645b3a.2.1789574484253; Wed, 16 Sep 2026
 09:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06841ed60dda515dce3f3f16b4c3b31fdd7113fe.1789393775.git.lucien.xin@gmail.com>
 <178950185396.22033.4056258856263599395@kernel.org>
In-Reply-To: <178950185396.22033.4056258856263599395@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 16 Sep 2026 12:01:12 -0400
X-Gm-Features: AcwNN1Wlyl-Jb-pcM6ljfG1c-LlXoB2ud7xNxMc2wjUUg2Dsiy8bDgQmSGaxVHw
Message-ID: <CADvbK_d9-8y8uC09+Sqqxxs_7a_YaOZxhL6JXC-5PQZXGARN6w@mail.gmail.com>
Subject: Re: [PATCH net-next v15 12/15] quic: add crypto packet encryption and decryption
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	metze@samba.org, mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, pc@manguebit.org, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:50=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 2
>
> - [Medium] quic_crypto_encrypt() records crypto->key_update_send_time =3D
>   quic_ktime_get_us() *before* attempting to protect the packet=E2=80=A6
> - [Medium] The new packet protection paths
>   (quic_crypto_encrypt()/quic_crypto_decrypt() ->=E2=80=A6
> - [Low] The comments on the new token helpers describe an earlier
>   revision of the code and are now wrong in three ways.
> - [Low] Reported concern: quic_crypto_generate_token() computes len =3D
>   sizeof(flag) + addrlen + sizeof(u64) + conn_id->len + QUIC_TAG_LEN and=
=E2=80=A6
>
> --
>
> quic: add crypto packet encryption and decryption
>
> This patch adds packet-level AEAD encryption and decryption for QUIC,
> including header protection and its removal, plus helpers for the Retry
> integrity tag and for generating and verifying address validation tokens.
>
> A few questions on the new code below.
>
> > diff --git a/net/quic/crypto.c b/net/quic/crypto.c
> > index 910557b680524..d62c6c4bea7de 100644
> > --- a/net/quic/crypto.c
> > +++ b/net/quic/crypto.c
>
> [ ... ]
>
> > @@ -252,6 +253,457 @@ ciphers[QUIC_CIPHER_MAX + 1 - QUIC_CIPHER_MIN] =
=3D {
> >                   "rfc7539(chacha20,poly1305)", "chacha20", "hmac(sha25=
6)"),
> >  };
> >
>
> [ ... ]
>
> > +/* AEAD Usage. */
> > +static int quic_crypto_payload_protect(struct quic_crypto *crypto,
> > +                                    struct sk_buff *skb, bool enc, gfp=
_t gfp)
> > +{
>
> [ ... ]
>
> > +     aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> > +                               quic_crypto_done, skb);
> > +     *(struct quic_crypto **)ctx =3D crypto;
> > +     atomic_inc(&crypto->async_pending[phase]);
> > +     cb->crypto_ctx =3D ctx; /* Async free context for quic_crypto_don=
e() */
> > +     err =3D enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req)=
;
>
> [Severity: Medium]
> This is the single place where every QUIC packet is protected or
> unprotected, so it looks like the natural home for the AEAD usage limits
> of rfc9001#section-6.6.  Are those limits enforced anywhere?
>
> struct quic_crypto in net/quic/crypto.h keeps secrets, IVs,
> async_pending[], the key update timestamps and the bit flags, but has no
> field for the number of packets protected with a key, nor for the number
> of packets that failed authentication, and a grep over net/quic at the en=
d
> of the series finds no confidentiality or integrity limit check.
>
> On the RX side quic_crypto_decrypt() just returns the AEAD error, so a
> peer can keep submitting forgery attempts against the same key without th=
e
> connection ever being closed, which rfc9001#section-6.6 requires once the
> integrity limit is reached:
>
>         err =3D quic_crypto_payload_protect(crypto, skb, false, gfp);
>         if (err) {
>                 if (err =3D=3D -EINPROGRESS)
>                         return err;
>                 ...
>                 return err;
>         }
>
> TLS_CIPHER_AES_CCM_128 is supported here (quic_crypto_is_cipher_ccm() and
> the "ccm(aes)" ciphers[] entry) and has the lowest integrity limit of the
> QUIC AEADs.  Is the intent to add the per-key counters and the limit chec=
ks
> in a later patch?
>
True:

This is a missing feature. I'll add per-key counters and the corresponding
limit checks.

> > +     if (err =3D=3D -EINPROGRESS || err =3D=3D -EBUSY) {
> > +             memzero_explicit(nonce, sizeof(nonce));
> > +             return -EINPROGRESS;
> > +     }
> > +     atomic_dec(&crypto->async_pending[phase]);
> > +     cb->crypto_ctx =3D NULL;
> > +
> > +out:
> > +     kfree_sensitive(ctx);
> > +     memzero_explicit(nonce, sizeof(nonce));
> > +     return err;
> > +}
> > +
> > +/* Encrypts a QUIC packet before transmission.  This function performs=
 AEAD
> > + * encryption of the packet payload and applies header protection. It =
handles
> > + * key phase tracking and key update timing.
> > + *
> > + * Return: 0 on success, or a negative error code.
> > + */
> > +int quic_crypto_encrypt(struct quic_crypto *crypto, struct sk_buff *sk=
b,
> > +                     gfp_t gfp)
> > +{
> > +     struct quic_skb_cb *cb =3D QUIC_SKB_CB(skb);
> > +     int err;
> > +
> > +     /* Packet payload is already encrypted (e.g., resumed from async)=
,
> > +      * proceed to header protection only.
> > +      */
> > +     if (cb->resume)
> > +             goto out;
> > +
> > +     cb->key_phase =3D crypto->key_phase;
> > +     /* If a key update is pending and this is the first packet using =
the
> > +      * new key, save the current time. Later used to clear old keys a=
fter
> > +      * some time has passed (see quic_crypto_decrypt()).
> > +      */
> > +     if (crypto->key_pending && !crypto->key_update_send_time)
> > +             crypto->key_update_send_time =3D quic_ktime_get_us();
> > +
> > +     err =3D quic_crypto_payload_protect(crypto, skb, true, gfp);
> > +     if (err)
> > +             return err;
>
> [Severity: Medium]
> Should key_update_send_time be committed only after the packet has actual=
ly
> been protected?
>
> Here the timestamp is stored before quic_crypto_payload_protect() runs, a=
nd
> neither this error return nor the header protection failure below restore=
s
> it.  If payload protection fails (skb_cow_data() returning -ENOMEM,
> quic_crypto_aead_mem_alloc() returning -ENOMEM, an skb_to_sgvec() error, =
or
> an AEAD error) the skb is dropped by the caller, but
> crypto->key_update_send_time now records a time at which nothing was sent=
.
>
> quic_crypto_decrypt() then uses that value as the start of the old key
> retention window:
>
>         if (crypto->key_pending && cb->key_phase =3D=3D crypto->key_phase=
) {
>                 time =3D crypto->key_update_send_time;
>                 if (time &&
>                     quic_ktime_get_us() - time >=3D crypto->key_update_ti=
me) {
>                         crypto->key_pending =3D 0;
>
> Can the window therefore already be expired when the first packet in the
> new phase is really received, so that key_pending is cleared immediately =
and
> a later reordered old-phase packet is treated as a fresh key update
> (phase !=3D crypto->key_phase && !crypto->key_pending), overwriting the o=
ld
> key slot before those packets can be decrypted?
>
True:

This is not a major issue in practice. I'll move setting
key_update_send_time to after payload protection succeeds.

Thanks.
