Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B343806AB
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128560; cv=pass; b=niZ0trrZKyu31YeDvyAiPPCwIOe7DZcIbmFmfpgcsRefAVOh6s0qTy4ZKDxGJ+YowhDi6oqYCCuPtpNW1+XCTVUcN2iENkiuEkZTABzDm6Fq9COCFhxVWSCC/5C8OO+sI/l7PwWtvpElT1TrFnBEfzN1xPUJzPgQFFulxHR3Czg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128560; c=relaxed/simple;
	bh=cMLhlgk0orhgodPiLnxT6aS7BKgXgh0IFtpLbjrYAPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK6Iq9m3r/5RCq0rHevL4BS6WJpjzTnrzjb/ndTs3v0EW5FRCK46gCDiRKSN8eqDJBMSMxooP3cRVOCEg10BW7i+fIsU1keMMqNjyOmf6J3sE0EVBBGVJoznIYpeszdEbIMkJ1DR2PTwPFN7M3iiPxhC8d/TFOt43/AgV1NinLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOgKZejx; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOgKZejx"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8453427d3f4so4327484b3a.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786128558; cv=none;
        d=google.com; s=arc-20260327;
        b=EvQ3dSEH0kJaEJqhie/+f8anc5Y7eQJ/IHxwdvIrX0dGVbfqlxuzc1GXJG1/e5TwJB
         Rh4kChu+Vr4ddfaxFi/j5MgLtZpyaFNiGTLsUO8jqyvQlRE9QqmEqI4QvBYhnqLhhCKf
         Z7deVWFv8AxS9LmbEvyD3TVYsVJ2w7+wSz1b6e35ZkCuqsjKOUmj24KnnXmsWZoRPITo
         5bH1Dsgf2icpe6b6SggdSmP2OvHhW02QgiphTVElqijFk6ABEPSUL+JPfdwGpgesjUpv
         Ql1jC1M+i4J09j/y9KRFBvX2LuNh0s51+jdYNwEp2TUUIsKtVspnVGe4CRYDyCNGVaBv
         dOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sIsYnSDGuGotLIFBuLysAd3V3WVCpo1jYD2HT13QtQU=;
        fh=GA/uJSnVPuPKJcfcylBI3XbfiOAARkAJ7cT/cqnYMf8=;
        b=LTV84wbNh2Fpf0jdjxoADFJcJ1f5ScoV2S+opYmpmcufdCRGgjyAoRs4Gxd8PjHsAy
         NtE8B7XQnjjZrJLQlX7PlP2TOpLnrunid7uWiiVukMhJWX92RGUYM5w5oQGsApbijTO6
         gjoT++gTzDeFukXdkFlcfwqCqeUazrWa/0s0W/g0/zvMBfhf3/TIVuMluPl7MX+hsdBa
         MHmbXcmrUCNZvixCKgQ6Awy4eI3OVYVS1uSv69yVORlW1uR9NuTY5Hh7eaPhlVMc8WfV
         J5AYFqREBCwA3RspGOdxHon09P6td9xkjxKy8h0808Dk4Hz70jiwRjCeIiMSh1SdHI57
         J7bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786128558; x=1786733358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sIsYnSDGuGotLIFBuLysAd3V3WVCpo1jYD2HT13QtQU=;
        b=WOgKZejxT2/QDVtj6+wuS4QuYryNWc2dH7fhSIwzesV74hoxC5xFusiuUH3iQENrq5
         i/ZCqoG/2tjGTY9boZqwvyM+YqrBJuY1HEuGpeePiLKeA5BwAiNX1LEYMS1mIwcl/hca
         nWcUKhh47JjkbvY6avPFZM8ZQSmkGYqXk0zowICMHWCmlgogBagk7TCLvRYjjcGXWgWP
         q+TA77Zkr994DgCKPSwOmh5gORu+KuUDIWmKGW7j7ZEK01NeFz8GRnGKVLFzFuGoZz8y
         +IOWEVbcE1FDr0cgxmoT2e6SciGvCojbsKSc1O1wphwrN9ktDY7Qd4weLF755+GZ42XL
         OcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128558; x=1786733358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sIsYnSDGuGotLIFBuLysAd3V3WVCpo1jYD2HT13QtQU=;
        b=pTnSkxOzPotLzTqsctDUanrbTu8Q/WewPhMSKjJh39DoyTtgfFm6R+CgkeiCIoBtzG
         DOFTXcKos09Bb4gIEnaksiZqlmYNY8Xs9yTlN7yicqxOOi93tXkT7HZo/bV27amMxam2
         Zf9CvV3U8Mm/HY6/bITDg1JnWPgTJGtEZ0FdVTc46iuQk5Rz2E1YZ91wxFxrDX8YsAay
         FlPvTxDvltAv9luQ5g+ovImWnEv2pcIz26KuRqtRP4J6e5GywsCyGtgZ5nGRojzJ5bg4
         BT21BhMd80gHTCMgJphzTM/GoErSmkmHtPSTewrsMVMU04G8+iJ1/WjKyMM0jZXkGVUO
         4gOA==
X-Forwarded-Encrypted: i=1; AHgh+Rrp+6tIsr9y0NIiEYOkOgGxUJBdj/tvr6JCgR9OLhbVcZdmNKxhMwm5lAotF8m9U3dKHxo4Coc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRcLI/asEYbPtoWVDfuXE3kaR6BAdXA4Ot93dDHCjX+ZTiTip
	VEniK4mJElKOo6oIugJmBR2htELLEDlvw/Of9bZkTszzsMQAhbKWwX2/u6sG1rlH9askrVBlK32
	AWJluhynLL8+XTJALDzqr1vXcp9RW1aw=
X-Gm-Gg: AR+sD13L3u5A5j7EEoQxZWqdgsVZdZCmyD8mnuCWESLPge/IDP4xgWXq9zG/Dbm9hsu
	vQtcm+NQUozJczlAAkYQ4TZZe2AcPAyDHmvqoa3kmUl435k2ewvb51iV+AL85U2xO8rT1yfimwX
	XnQfnpR90BC3jTR+nMetr4YQxzXQa57q2lFUzRnafd1op6sObqdvQAtB0rKDZFP07ZpCRU/YsUY
	uvCmWfHdLoleWA8Ndesm7ks0voZ6zi4QzoSl8oP64iZ5mx3FwJc04fuZAU/MgNCNKHzpJnXMlHq
	lMm/8SxJoW5layV4JhyENDk5nkMfsm6ZZLDlYVbfjRIxjww7mqycL9+sXTfysJnDOeirGiA1KBG
	PMNNeyPuR8CuAmB++W1SVDEZaJXQXRS/U53d91jOM8gE=
X-Received: by 2002:a05:6a00:348d:b0:842:706e:ad43 with SMTP id
 d2e1a72fcca58-84f2e0ccba3mr28384946b3a.33.1786128557901; Fri, 07 Aug 2026
 11:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804200042.2412009-1-Jeremy.Jean@oss.cyber.gouv.fr> <CADvbK_fs8FObEc25MGhiMiYZMR7YzdanTRJtMTvsbFQZJg_fqQ@mail.gmail.com>
In-Reply-To: <CADvbK_fs8FObEc25MGhiMiYZMR7YzdanTRJtMTvsbFQZJg_fqQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 7 Aug 2026 14:49:05 -0400
X-Gm-Features: AUfX_mwiDpL7-UK9yPj6T3mzC4-sccKB4KQOmcs6OiOJXkIdsl04HlxdHkC8j0M
Message-ID: <CADvbK_eDZRfopfzha_TXEzfsZL5GEnJnE5WwouN2OmwOLO18TQ@mail.gmail.com>
Subject: Re: [PATCH] sctp: validate cookie AUTH state before use
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 2:47=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wrot=
e:
>
> [sashiko-gemini]:
> > > +bool sctp_auth_verify_cookie_params(const struct sctp_endpoint *ep,
> > > +                                    const struct sctp_cookie *cookie=
)
> > > +{
> > > +        const struct sctp_paramhdr *random;
> > > +        const struct sctp_hmac_algo_param *hmacs;
> > > +        const struct sctp_chunks_param *chunks;
> > > +        u16 hmacs_len, chunks_len;
> > > +        u16 n_hmacs, n_chunks, i;
> > > +        bool has_sha1 =3D false;
> > > +
> > > +        if (sctp_sk(ep->base.sk)->cookie_auth_enable || !ep->auth_en=
able)
> > > +                return true;
> > This is a pre-existing issue, but does skipping validation when
> > cookie_auth_enable is true leave the system vulnerable if auth_enable i=
s
> > dynamically toggled?
> > When an endpoint has auth_enable =3D 0, it generates state cookies with=
 a
> > zero-initialized auth_hmacs array. If the administrator then dynamicall=
y
> > enables auth_enable =3D 1, an attacker could send a COOKIE_ECHO with th=
e
> > previously generated cookie (which has a valid MAC) bundled with an AUT=
H
> > chunk.
> > Because cookie_auth_enable is true, this check skips validation and the
> > zeroed auth_hmacs is restored. When the AUTH chunk is processed,
> > sctp_auth_asoc_verify_hmac_id() calculates the element count with a zer=
oed
> > length:
> > sctp_auth_asoc_verify_hmac_id() {
> >         hmacs =3D (struct sctp_hmac_algo_param *)asoc->c.auth_hmacs;
> >         n_elt =3D (ntohs(hmacs->param_hdr.length) -
> >                  sizeof(struct sctp_paramhdr)) >> 1;
> >
> >         return __sctp_auth_find_hmacid(hmacs->hmac_ids, n_elt, hmac_id)=
;
> > }
> > Since length is 0, this underflows to 65534, causing an out-of-bounds r=
ead
> > of 131,068 bytes past the association allocation in
> > __sctp_auth_find_hmacid().
>
> False positive: when cookie_auth_enable is true, the cookie is already
> authenticated. The cookie content is generated locally, so validation is
> unnecessary.
>
>
> [sashiko-claude]:
> > > +bool sctp_auth_verify_cookie_params(const struct sctp_endpoint *ep,
> > > +                                    const struct sctp_cookie *cookie=
)
> > > +{
> > > +        const struct sctp_paramhdr *random;
> > > +        const struct sctp_hmac_algo_param *hmacs;
> > > +        const struct sctp_chunks_param *chunks;
> > > +        u16 hmacs_len, chunks_len;
> > > +        u16 n_hmacs, n_chunks, i;
> > > +        bool has_sha1 =3D false;
> > > +
> > > +        if (sctp_sk(ep->base.sk)->cookie_auth_enable || !ep->auth_en=
able)
> > > +                return true;
> > Discovered by: opus-5, old-prompts =C2=B7 Missed by: sashiko-gemini
> > This isn't a bug introduced by this patch, but does the new invariant l=
eave
> > the underflowing consumer reachable in the default configuration?  With
> > cookie_auth_enable set (the default from protocol.c), this early return
> > skips all validation, and sctp_auth_asoc_verify_hmac_id() still has no
> > lower bound on the parameter length:
> > net/sctp/auth.c:sctp_auth_asoc_verify_hmac_id() {
> >         hmacs =3D (struct sctp_hmac_algo_param *)asoc->c.auth_hmacs;
> >         n_elt =3D (ntohs(hmacs->param_hdr.length) -
> >                  sizeof(struct sctp_paramhdr)) >> 1;
> >         return __sctp_auth_find_hmacid(hmacs->hmac_ids, n_elt, hmac_id)=
;
> > }
> > For a zero-length parameter the unsigned subtraction wraps and the
> > truncation into __u16 n_elt yields 65534, so __sctp_auth_find_hmacid()
> > scans about 128 KB past the 12-byte asoc->c.auth_hmacs array in softirq
> > context.  Note the sibling consumer __sctp_auth_cid() does guard this
> > case:
> >         if (!param || param->param_hdr.length =3D=3D 0)
> >                 return 0;
> > Is a zero-length asoc->c.auth_hmacs together with peer.auth_capable =3D=
=3D 1
> > reachable without any forged cookie?  It looks like it is:
> > sctp_association_init()
> >         if (ep->auth_hmacs_list)
> >                 memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list,
> >                         ntohs(ep->auth_hmacs_list->param_hdr.length));
> > with ep->auth_hmacs_list NULL while ep->auth_enable =3D=3D 0 (the defau=
lt in
> > sctp_endpoint_init()), so c.auth_hmacs stays all zero.  Afterwards
> > sctp_setsockopt_auth_supported() does:
> >         ep->auth_enable =3D !!params->assoc_value;
> > and sctp_process_ext_param() then sets, for that same already-created
> > association:
> >                         if (asoc->ep->auth_enable)
> >                                 asoc->peer.auth_capable =3D 1;
> > A remote AUTH chunk then reaches sctp_sf_authenticate() ->
> > sctp_auth_asoc_verify_hmac_id() with the underflow.  If the scan happen=
s
> > to match the attacker's 16-bit hmac_id, sctp_auth_get_hmac() indexes th=
e
> > four-entry sctp_hmac_list[] with that id and the resulting hmac_len gat=
es
> > the 20/32-byte digest write in sctp_auth_calculate_hmac().
> > Would it be worth adding the same length =3D=3D 0 guard to
> > sctp_auth_asoc_verify_hmac_id(), and bounding the index in
> > sctp_auth_get_hmac(), rather than relying only on the conditionally
> > executed cookie check?  The same applies to
> > sctp_auth_make_key_vector(), which still does:
> >         random_len =3D ntohs(random->param_hdr.length);
> >         ...
> >         memcpy(new->data, random, random_len);
> > out of the fixed 36-byte asoc->c.auth_random.
>
> False positive: same reason as above.
>
> > > +
> > > +        random =3D (const struct sctp_paramhdr *)cookie->auth_random=
;
> > > +        if (random->type !=3D SCTP_PARAM_RANDOM ||
> > > +            ntohs(random->length) !=3D sizeof(*random) + SCTP_AUTH_R=
ANDOM_LENGTH)
> > > +                return false;
> > > +
> > > +        hmacs =3D (const struct sctp_hmac_algo_param *)cookie->auth_=
hmacs;
> > > +        hmacs_len =3D ntohs(hmacs->param_hdr.length);
> > > +        if (hmacs->param_hdr.type !=3D SCTP_PARAM_HMAC_ALGO ||
> > > +            hmacs_len < sizeof(struct sctp_paramhdr) +
> > > +                        sizeof(hmacs->hmac_ids[0]) ||
> > > +            hmacs_len > sizeof(cookie->auth_hmacs) ||
> > > +            (hmacs_len - sizeof(struct sctp_paramhdr)) %
> > > +                        sizeof(hmacs->hmac_ids[0]))
> > > +                return false;
> > Discovered by: opus-5, old-prompts =C2=B7 Missed by: sashiko-gemini
> > Can these checks reject a cookie this endpoint minted itself?
> > The decision to validate is taken from ep->auth_enable sampled at
> > COOKIE-ECHO time, not from the state that produced the INIT-ACK, while =
the
> > HMACS and CHUNKS tests unconditionally require a well-formed parameter.=
  An
> > all-zero (absent) auth_hmacs/auth_chunks looks like a state the produce=
r
> > legitimately creates:
> > net/sctp/associola.c:sctp_association_init() {
> >         if (ep->auth_hmacs_list)
> >                 memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list, ...);
> >         if (ep->auth_chunk_list)
> >                 memcpy(asoc->c.auth_chunks, ep->auth_chunk_list, ...);
> > }
> > auth_random is the only one of the three always written, and the endpoi=
nt
> > lists are NULL while ep->auth_enable =3D=3D 0, which is the default in
> > sctp_endpoint_init().  sctp_make_init() treats the zero-length case as
> > "parameter omitted" rather than malformed:
> >                 auth_hmacs =3D (struct sctp_paramhdr *)asoc->c.auth_hma=
cs;
> >                 if (auth_hmacs->length)
> >                         chunksize +=3D SCTP_PAD4(ntohs(auth_hmacs->leng=
th));
> >                 else
> >                         auth_hmacs =3D NULL;
> > sctp_pack_cookie() copies asoc->c verbatim, so the outstanding cookie
> > carries those zeros.  If the application then calls
> > setsockopt(SCTP_AUTH_SUPPORTED) while the cookie is still within
> > Valid.Cookie.Life, and cookie_hmac_alg is none, the early return above =
is
> > skipped and "hmacs->param_hdr.type !=3D SCTP_PARAM_HMAC_ALGO" fails wit=
h
> > type 0.
> > Given that, does the comment "they must satisfy the same constraints as
> > locally generated AUTH parameters" hold?  Locally generated parameters =
may
> > legitimately be absent.
>
> ep->auth_enable can be changed at any time during the handshake, especial=
ly
> on a listening socket, and we should not change this behavior for backwar=
d
> compatibility at this time.
>
> If it changes from 0 to 1 while processing a COOKIE-ECHO, the packet will
> be rejected and the connection will eventually fail, but it will not lead
> to a crash. Changing ep->auth_enable during an active handshake should be
> considered invalid SCTP usage.

Acked-by: Xin Long <lucien.xin@gmail.com>
