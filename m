Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792624435;
	b=RURD1x/Z+OI77TpCf3XH28FiJYpXBdABP0bgyZUOMvzHubzCw2UcLMSVo3nhkhX2HUF6
	 ulqsuv4S+GqJqO2r6gxW865A2GAiPfSCT0sYkP3YiHS3ILeNP+dQxMgyt6tE8D8B7m1gf
	 1K+mihB/A0XXx4wO8LdmlzbJO1e43SSQvivjrEYHyFXfZzSlEm9zR3jaioG7hKFzzBBPf
	 ybI6ah2PEgFgPFCAqQHw5XCr3gG8penViTlWVXGZ4mrGDvyV8SIdVJhIC+MnTxwCbgdrN
	 GBROyhDzlzl6DkUJzIfPdA/43b33Y73QZZ5doAEap8aMzqgT4/mXx0BL8VCyqka9hJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0bF8UDz4MemY9TmYMQbPDvcYna7bJ06acIjQGEONwiU=;
	b=Yuo2lrE11TXctBjF2PQpmtArbDAma9qI8wi4zCjGfV6yb3fQVMdsy/tbdMn+1V/dqIBL
	 F6TZyyk9VrC4yiFVTCZaPsJOM4dssHRO1VgywRgM7U7JGIEuXa2xJ5kQio3CQGBUiqFdd
	 //sSQYKs5QxKLKWrcVKIqcEFu9gJ/wFK577WOP4Evp/T5ZJwJq3toByHcYjkfuIn7TBeV
	 3H9sj3tmyrFA4q11lpoFuh67R4IqI9liJRXf5IlHzl7JV+GrWdZDBdSfNMukGYeSAj4Zw
	 pO9WlaIuHgW2FsmQXiuyVdeB8odpLxIt2RWwmp29bryIksL++APbeO/9clmM13SLA5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=QzwKB9Sq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08653606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 23:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08653606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=QzwKB9Sq
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9909e82513fso245155241.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792624433; cv=none;
        d=google.com; s=arc-20260327;
        b=m9vYyGmIJOrqSYcz2lamDfu0n9SPdidFrbdFlomJpDe2NJNNh8OEv9jNIqnA65Kl62
         AdGXfKsWXiCaBoYka/ldHJJ6mPY73c/8BORlmF1Um+E6a9IriO37cKI9LuRqQZ21dB/F
         wQOOHrDc7Irp9gMiqeWanCCO+cNHUNvR3DpcrEh8KvT6Qpw2LOkpZiA6mlgg0f90NK0R
         JJEXN0mH6mVDzz3z6bq8jIjanmVDrcTIXHLEH/nBOxbhAgh3Fmnm8DdG8HKjyfY1Zq2V
         6jM4V0YUYCqMIAFTwX/Lb+Id5AWfGHzfE47Ci898AZYc3y2/JAn602GREIZghjKT7Qzc
         8ZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0bF8UDz4MemY9TmYMQbPDvcYna7bJ06acIjQGEONwiU=;
        fh=AZxPVmi79m0sUWMfIEeT9kkHDCLYYkdCHXU6/ksMyE8=;
        b=HDEhN68OqH3zRd3qXonQsoklFEKXjjjTtfYlgpXmOFbf2d7V1znIq9WI0zCp6qCyf+
         h2KIENv7fTwWBZSykjaVm/jGbIihufH55DZX3V7xqdZLCLPbhqPFPBu7leonjqf39mzT
         yUeBxULAIcw2Qg8jhJ6cmwCbVdhZR9RprVkOphtAR6MO+dIH3101WK4ASdM0pGDxyMUO
         UVTEkq3dcFASRV5K1bsDZe9uGstKqwAfd0Z1XggsWCci31rfqqfcHyr9q+DIIJaD6lVv
         e3fqVs1OxnrlbP64rJGSCFWPQ7s2KefZ5nSa2hbTaeUUZWkZiE/RgyzH1LbITcFAwD59
         T3+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792624433; x=1793229233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0bF8UDz4MemY9TmYMQbPDvcYna7bJ06acIjQGEONwiU=;
        b=QzwKB9SqCsdQOurfoRv9ko7cP688myfFiEKxH5ukDnHAPW2EXrFrb57QtkDsCNdfjA
         RJ6T9wSpL+2BzmjDFqyp5keULnjRTh8+yaYDk2N+8xuWrA+DOgMSl5la8RzV2HO5ir2o
         3cX5BSdM76+S8gZiZ5ssC2rk6HaTDOJCdVkMJ9vGdadaFM2sYTdXjdXQDYN5VOBcV/Ue
         hR2SCxk8zYeOHl/iyLGfr++VpK5CXM+mxGtLZk+g4ePRwSYQmMm0RPTEGWHa5l8u7jeB
         QBpoZHaQOPmY7KalSP96Nhm4ujw0+ICnFrnJ9ojCSrk1qXcweM77tjIz19UbzlRsBM7a
         YAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792624433; x=1793229233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bF8UDz4MemY9TmYMQbPDvcYna7bJ06acIjQGEONwiU=;
        b=a65MP9JCZZejX2gs3+Dl7v0Z4wSlz0il1EBWvjS+K0/iuD+gHPT3RP0pM6KQiG/AVe
         Z0c52VAIjcpZEJCtwe2+thr1toSYfFjpjXki1M/j0P8mJpWBcMB5JyLsNF47pDo/deiv
         zUiV3AkfQVNhSTnMs0ILEbHFwvqJDRdNTXbPYc8AQGLMP29VM4m1CKIK0Lc4etCxoygl
         j9Q06Y7cb++pb3WX+aec5PfdbM6g+ExfJSXNLEBBsWbJSFvnIuEXZleL5SD3ghzoiPwn
         EQWKWODuyZ+APCCXSMsjdf7OaHT6/FMLsSG0kYcs6xwfKM+GUGDd0/FZyGeJsaVHVtNt
         Qd4w==
X-Gm-Message-State: AFq9FYK7ZzXetx+N+9sQEx09ZzgI8BtUKO71DfpkAKm3jHPhiyAd/4HQ
	+b1cz3U+5STmTx1k98bJxnhaNVOmzj21iYEtYPNxZBFKftb205EYU0KFmchKkxMctMOwhfL5gYP
	7/Ug1nbsyWIN8cfVuDbZ19HVPmdBfAMChTUKOuFzmPA==
X-Gm-Gg: AYBFou1497fJJAIRAQmbEhHHpZYyzOwCULz1ln48pz+XDA/XZueVy92X0Xet24EeJTp
	Lls+5khfC+Rt84aJBEf4XTkT/ejFdXx8/fYtaPTc+w1X3UYHg/LyxICFUqnxAqgx3zZppmrlPGl
	N6Gu9XQ3SI5LiAeDe5BbLhFr0jcRkeDKdkWWTmwoxZ1zKfShvqL2STkZWmY+Ped+dG99O6xjqcp
	CIO6fuLZ9pxGjGEyjYMyWKnLoh+EAWyMZT7htTWMbyX8a7kYGHVlL2YGVN8UJQsG+RZUjFiHoji
	aQhccvTPgRfrE4/jGj26bgG+hdeQhQqy4X0mL1zFet0erPWYMOzys0vVY7OQJBqnfyLYrm+WrAf
	W5E12baH+d1BcYlcDrJKJU0XwIVFVrxD2bveHCxpiPWJdzsrPNQgA7LQnmNKy+4+zNnCtY1rV9U
	2DxRH+D5oazsiy9c2tnzH++7kZkgdZm4nGgtIyjenorCOVCXGvo9TgFlGIMQKfrzss2/5DFuEFL
	A+u2Ng73VUlXOUipgbS65iN
X-Received: by 2002:a05:6102:6898:b0:7b4:db17:bca4 with SMTP id
 ada2fe7eead31-7cca976709fmr211015137.9.1792624432873; Wed, 21 Oct 2026
 16:13:52 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015201135.2744031-1-rjethwani@purestorage.com>
 <20261015201135.2744031-2-rjethwani@purestorage.com> <atc7FCQv84jn2CrZ@krikkit>
In-Reply-To: <atc7FCQv84jn2CrZ@krikkit>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Wed, 21 Oct 2026 16:13:39 -0700
X-Gm-Features: AclHuK-bL72iNSIPIkBcgorotxxU52K_whBw0PcWF-473H2-syNd7CbTsZCx3Vo
Message-ID: <CAKaoeS31sODP9nGvTo4KwHGNF54fWLpJAETYdusqEiUJzibi4Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tls: device: fix record start in the
 tls_device_decrypted tracepoint
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

.

On Tue, Oct 20, 2026 at 2:57=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-10-15, 14:11:34 -0600, Rishikesh Jethwani wrote:
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index f11d0528fc43..33e6dc3d4164 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -835,6 +835,21 @@ void tls_device_rx_resync_new_rec(struct sock *sk,=
 u32 rcd_len, u32 seq)
> >       tls_device_resync_rx(tls_ctx, sk, seq, rcd_sn);
> >  }
> >
> > +/* TCP sequence of the first byte of the record the strparser holds. I=
n
> > + * normal mode the record stays in the TCP receive queue until
> > + * tls_strp_msg_consume(), so copied_seq still points at its start. Co=
py
> > + * mode saves the start before TCP reads advance copied_seq, possibly
> > + * over a FIN that is not part of the record.
> > + */
> > +static u32 tls_device_rx_rec_start(struct sock *sk,
> > +                                struct tls_sw_context_rx *sw_ctx)
> > +{
> > +     if (sw_ctx->strp.copy_mode)
> > +             return sw_ctx->strp.copy_seq;
> > +
> > +     return tcp_sk(sk)->copied_seq;
> > +}
>
> nit: tls_strp implementation details should stay in tls_strp.c.
>
> >  static void tls_device_core_ctrl_rx_resync(struct tls_context *tls_ctx=
,
> >                                          struct tls_offload_context_rx =
*ctx,
> >                                          struct sock *sk, struct sk_buf=
f *skb)
> > @@ -990,7 +1005,7 @@ int tls_device_decrypted(struct sock *sk, struct t=
ls_context *tls_ctx)
> >               is_encrypted =3D 0;
> >       }
> >
> > -     trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full=
_len,
> > +     trace_tls_device_decrypted(sk, tls_device_rx_rec_start(sk, sw_ctx=
),
> >                                  tls_ctx->rx.rec_seq, rxm->full_len,
> >                                  is_encrypted, is_decrypted);
> >
> > diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
> > index 6cc222008d95..ad8b5150ac97 100644
> > --- a/net/tls/tls_strp.c
> > +++ b/net/tls/tls_strp.c
> > @@ -132,6 +132,7 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
> >       tls_strp_anchor_free(strp);
> >       strp->anchor =3D skb;
> >
> > +     strp->copy_seq =3D tcp_sk(strp->sk)->copied_seq;
> >       tcp_read_done(strp->sk, strp->stm.full_len);
> >       strp->copy_mode =3D 1;
> >
> > @@ -418,6 +419,7 @@ static int tls_strp_read_copy(struct tls_strparser =
*strp, bool qshort)
> >
> >       shinfo->frag_list =3D NULL;
> >
> > +     strp->copy_seq =3D tcp_sk(strp->sk)->copied_seq;
>
> Why not set strp->copy_seq every time we start processing a new
> record? Then we don't have to worry about whether it's set, handle it
> in multiple places, and we don't have different cases in _rec_start().

Agreed. I=E2=80=99ll move sequence tracking to the start of each record in
tls_strp_read_sock()
and rename copy_seq to seq. The device code will uses
tls_strp_msg_seq(), a simple
accessor alongside the other parser helpers in tls.h. This will remove
the copy-mode-specific
assignments and checks.

> >       strp->copy_mode =3D 1;
> >       strp->stm.offset =3D 0;
> >
> > --
> > 2.50.1
> >
>
> --
> Sabrina
