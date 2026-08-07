Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41D3911B2
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128452; cv=pass; b=Q1HBtssEdrGsEt8O1bmlmPEbEDLwW6aYRr7QSW9o6G96OiRHcoag6hMWQ3rDEoWeVr9DgSKHpWkAieyuijTcf2ze9aYvG34vEhLmaYkGt8VuRRkEJdXbCUofua4gKNIxiEki7aXBOLQeb3LEnEtcv8UwA1zJUHlyE/usYxiDHHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128452; c=relaxed/simple;
	bh=O+yzlvrwmZ54QPpAlV9V5Cikx9/6kgLtsJ+MIIDb1R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVYxOTGhx8SC4BtEXu81EQNwDGbEYtEt5O0VUIq8EJfqFOtvh7Ltd0QdyKkx+joLLtVB5pp4tQHvu2Bvo9PYhfsIbRM/nfClu3B2H2F3114T5sv3oo9SNWFYUC8TGyD6se8CbYvgF82T923Zm/k9kuIMO3AytRfLb5SRsis0fbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfvRkhar; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfvRkhar"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so4127951b3a.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786128448; cv=none;
        d=google.com; s=arc-20260327;
        b=LfIK+7XiNW9YkwFEp4DHgU/CDAIVS73mWcYPaXgErQbevBjr2wraTkFe1m7aooymEk
         wlljGafO0BtWkSMg82H+ifqx8m+l8+mqigKUPH84hv0xskZjNfUOIHUBp1aS/HA/rUj3
         Nm/KgQGJXZsll+Szy3gZOfEXgEpM4gRXH5wgkpKHvBrdc1J/L1TD2OX9yj932sDT7uhS
         9nxDiXiXMWuvUPFURNQ5WfcTnVC9T8T9qA+bu0gJKBvtQr+dwv+dZibHobJiPR9vcqWr
         fe9SzOzQ6pef8tprX7JSKteBVkDmHl9gLh32cEtzjn3nKPdwg+sQvgkh7ZkGLtYNR/ku
         U1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4rdUpvnkrA0Ybs1prrzqLbHK4h7QUdBBwsxBOff0r8=;
        fh=iZBERwvocVxN4O2in8H0wE2IOtkWGc942XqC0h2Q+uw=;
        b=roobnU+2wJW696ocZQAomIue2T9YkfcluMA5yxZbJ9SDaLoKoIVzat78yirdtQ4i2F
         ZuwEl0F2rTOpuFbhnsKZUgACqhwzoOiVCyuth0yxZx+OS8HajdwKzfCLh5cQRh0wp/YS
         PKuft+bbTplZpNWk8A5nQHXtEE5gW3QIA7d6H+guuBpuYyRKO8KqbwKYeSGx+3OC0T10
         3AlGg6TzSY7sGK74pt/W4BuIPyEVtxSOX871NBP6R+HUSgDE0afxcZw/pkkzoCke86gR
         EoEEUbGYRF0Dic/sbK8llRctR2gNp6kTB9KRtay0/Z0JI925eKrrdMNwyb/jPN4OTIAb
         LSFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786128448; x=1786733248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w4rdUpvnkrA0Ybs1prrzqLbHK4h7QUdBBwsxBOff0r8=;
        b=qfvRkharbaoomMTHKfF3tVOmi0gzhsCEFyyNfFftFJ/B6PZh7z54eAmOQZUgb2Xdy0
         bFkxNPOSw2De3A2Q8PiU5J0h+zuRq4EhFki+bxlHM/rDVfhzdcuREmKyZtUdEglrWN1l
         IIHL9B2bsIe3EfZkfhjl2PvXZ3nvj/7EjaT+LD4frjXxlY8fIVcoDLqyuz5byYI9G3zX
         8CPrA2apIpMlVcpr5nE11sBicbXS+hxIFaVw7uDqB/3bkSMSF1lAqvV6duCaZeRpEFDN
         /4s/0fPNYYQYAeXBIBAfn0oRP03qgiTuhqzv88R7SwvE8kmYkqc5oS2CnJW77tXidk3j
         RFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128448; x=1786733248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4rdUpvnkrA0Ybs1prrzqLbHK4h7QUdBBwsxBOff0r8=;
        b=tHtvX0xih4mn+87Ub7bJB4b8z27LIr0Y0w1yflYuwUipm8EGsfHSZoELhKD/9UA/uC
         Q3f4F2wXeY5YCCKzjwaiAyh0yRStTAd4AT5xCKQwP1fh/8uj+szNkjNFAQ8rEucR1r7v
         6m5fvJEviQ4JpgzKaMt457d1MPHt/qN9zZK4CpauVHEFTqVAP4MI2om11mKxd+7xQPaa
         +HpnUOXasUK8yaa4iFgTLhaXcIhqwAypiZG16FVgwrE8ZvFjjbxU1lu0wpOk2VXBX0Hd
         3BT7k5lVkv9BMpZ1e32poNWlNr7Jgu8OTfJtLQuyhxUN+A4GhFF6MWIVadpt6/g2eQpM
         Ccow==
X-Forwarded-Encrypted: i=1; AHgh+RoCC3mif2SJy8sb6yPTQ/M4cxTHI3xqZxT3P9/xe3G+eVHORMTMkNS8ZJp5YX6NXmf08ZFHq60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKI9xYzlqwX8POZc9OZaLJd0pF/SRA0Fa//N6T5CqsFOmVB9k
	Riowwu1UmDmqGXd9tvz8UImHEsXouzs4sX1VSLO4QhWsRi5HV5wvgV5UxziQEiDsW+kKduXn5zW
	9eM79rn4EVWdJUDvn3WfFyZ6FWKqqc88=
X-Gm-Gg: AR+sD13/t6S2hqbS9kXYmJs5aeisdDJPI7E9kgJuK0+Ew9pje/L93G7dt9sSMX6pGt7
	Zt7nUDtmDv7AYm0lUfiVJK88Up/AnGWwY5yN0vfoQ5afQNhPZrLhW8p6bloEssrtiFiw1rFszSH
	i8bm1f2umCaGXSWaaWAthjnE+Ac3j32OCaUvNiknqcbH88D/8DGKeMVO3WDkmOD38Pyr7eFMAa2
	tMXN6iHGmGhg6unxoe/bXrIh34pNs/Pe0Aa2eKTKy37bHWS0vq0mgN56nbnBi/I9ItS3Y6lMoUy
	7aAxZ3/HxdF0OlaJzKkk2+YhOF4bZgF8ONszcWCw8HM53B/+Wcc4cIG3pkRzaecP30wahJzSHAM
	fG0YMeZSoIYd9njKamZdX+h4+WX8PSLou6jRuEDIbe4f4zxcOI/GteOY=
X-Received: by 2002:a05:6a00:6313:b0:848:8619:c149 with SMTP id
 d2e1a72fcca58-84f5af70253mr6305584b3a.2.1786128447959; Fri, 07 Aug 2026
 11:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804200042.2412009-1-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260804200042.2412009-1-Jeremy.Jean@oss.cyber.gouv.fr>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 7 Aug 2026 14:47:15 -0400
X-Gm-Features: AUfX_mw41gJYCiTV6mbQ4ccji5iS3BLua2t0NwKnoy6Nsq7wvi3OcJKpIKDFyAw
Message-ID: <CADvbK_fs8FObEc25MGhiMiYZMR7YzdanTRJtMTvsbFQZJg_fqQ@mail.gmail.com>
Subject: Re: [PATCH] sctp: validate cookie AUTH state before use
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[sashiko-gemini]:
> > +bool sctp_auth_verify_cookie_params(const struct sctp_endpoint *ep,
> > +                                    const struct sctp_cookie *cookie)
> > +{
> > +        const struct sctp_paramhdr *random;
> > +        const struct sctp_hmac_algo_param *hmacs;
> > +        const struct sctp_chunks_param *chunks;
> > +        u16 hmacs_len, chunks_len;
> > +        u16 n_hmacs, n_chunks, i;
> > +        bool has_sha1 =3D false;
> > +
> > +        if (sctp_sk(ep->base.sk)->cookie_auth_enable || !ep->auth_enab=
le)
> > +                return true;
> This is a pre-existing issue, but does skipping validation when
> cookie_auth_enable is true leave the system vulnerable if auth_enable is
> dynamically toggled?
> When an endpoint has auth_enable =3D 0, it generates state cookies with a
> zero-initialized auth_hmacs array. If the administrator then dynamically
> enables auth_enable =3D 1, an attacker could send a COOKIE_ECHO with the
> previously generated cookie (which has a valid MAC) bundled with an AUTH
> chunk.
> Because cookie_auth_enable is true, this check skips validation and the
> zeroed auth_hmacs is restored. When the AUTH chunk is processed,
> sctp_auth_asoc_verify_hmac_id() calculates the element count with a zeroe=
d
> length:
> sctp_auth_asoc_verify_hmac_id() {
>         hmacs =3D (struct sctp_hmac_algo_param *)asoc->c.auth_hmacs;
>         n_elt =3D (ntohs(hmacs->param_hdr.length) -
>                  sizeof(struct sctp_paramhdr)) >> 1;
>
>         return __sctp_auth_find_hmacid(hmacs->hmac_ids, n_elt, hmac_id);
> }
> Since length is 0, this underflows to 65534, causing an out-of-bounds rea=
d
> of 131,068 bytes past the association allocation in
> __sctp_auth_find_hmacid().

False positive: when cookie_auth_enable is true, the cookie is already
authenticated. The cookie content is generated locally, so validation is
unnecessary.


[sashiko-claude]:
> > +bool sctp_auth_verify_cookie_params(const struct sctp_endpoint *ep,
> > +                                    const struct sctp_cookie *cookie)
> > +{
> > +        const struct sctp_paramhdr *random;
> > +        const struct sctp_hmac_algo_param *hmacs;
> > +        const struct sctp_chunks_param *chunks;
> > +        u16 hmacs_len, chunks_len;
> > +        u16 n_hmacs, n_chunks, i;
> > +        bool has_sha1 =3D false;
> > +
> > +        if (sctp_sk(ep->base.sk)->cookie_auth_enable || !ep->auth_enab=
le)
> > +                return true;
> Discovered by: opus-5, old-prompts =C2=B7 Missed by: sashiko-gemini
> This isn't a bug introduced by this patch, but does the new invariant lea=
ve
> the underflowing consumer reachable in the default configuration?  With
> cookie_auth_enable set (the default from protocol.c), this early return
> skips all validation, and sctp_auth_asoc_verify_hmac_id() still has no
> lower bound on the parameter length:
> net/sctp/auth.c:sctp_auth_asoc_verify_hmac_id() {
>         hmacs =3D (struct sctp_hmac_algo_param *)asoc->c.auth_hmacs;
>         n_elt =3D (ntohs(hmacs->param_hdr.length) -
>                  sizeof(struct sctp_paramhdr)) >> 1;
>         return __sctp_auth_find_hmacid(hmacs->hmac_ids, n_elt, hmac_id);
> }
> For a zero-length parameter the unsigned subtraction wraps and the
> truncation into __u16 n_elt yields 65534, so __sctp_auth_find_hmacid()
> scans about 128 KB past the 12-byte asoc->c.auth_hmacs array in softirq
> context.  Note the sibling consumer __sctp_auth_cid() does guard this
> case:
>         if (!param || param->param_hdr.length =3D=3D 0)
>                 return 0;
> Is a zero-length asoc->c.auth_hmacs together with peer.auth_capable =3D=
=3D 1
> reachable without any forged cookie?  It looks like it is:
> sctp_association_init()
>         if (ep->auth_hmacs_list)
>                 memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list,
>                         ntohs(ep->auth_hmacs_list->param_hdr.length));
> with ep->auth_hmacs_list NULL while ep->auth_enable =3D=3D 0 (the default=
 in
> sctp_endpoint_init()), so c.auth_hmacs stays all zero.  Afterwards
> sctp_setsockopt_auth_supported() does:
>         ep->auth_enable =3D !!params->assoc_value;
> and sctp_process_ext_param() then sets, for that same already-created
> association:
>                         if (asoc->ep->auth_enable)
>                                 asoc->peer.auth_capable =3D 1;
> A remote AUTH chunk then reaches sctp_sf_authenticate() ->
> sctp_auth_asoc_verify_hmac_id() with the underflow.  If the scan happens
> to match the attacker's 16-bit hmac_id, sctp_auth_get_hmac() indexes the
> four-entry sctp_hmac_list[] with that id and the resulting hmac_len gates
> the 20/32-byte digest write in sctp_auth_calculate_hmac().
> Would it be worth adding the same length =3D=3D 0 guard to
> sctp_auth_asoc_verify_hmac_id(), and bounding the index in
> sctp_auth_get_hmac(), rather than relying only on the conditionally
> executed cookie check?  The same applies to
> sctp_auth_make_key_vector(), which still does:
>         random_len =3D ntohs(random->param_hdr.length);
>         ...
>         memcpy(new->data, random, random_len);
> out of the fixed 36-byte asoc->c.auth_random.

False positive: same reason as above.

> > +
> > +        random =3D (const struct sctp_paramhdr *)cookie->auth_random;
> > +        if (random->type !=3D SCTP_PARAM_RANDOM ||
> > +            ntohs(random->length) !=3D sizeof(*random) + SCTP_AUTH_RAN=
DOM_LENGTH)
> > +                return false;
> > +
> > +        hmacs =3D (const struct sctp_hmac_algo_param *)cookie->auth_hm=
acs;
> > +        hmacs_len =3D ntohs(hmacs->param_hdr.length);
> > +        if (hmacs->param_hdr.type !=3D SCTP_PARAM_HMAC_ALGO ||
> > +            hmacs_len < sizeof(struct sctp_paramhdr) +
> > +                        sizeof(hmacs->hmac_ids[0]) ||
> > +            hmacs_len > sizeof(cookie->auth_hmacs) ||
> > +            (hmacs_len - sizeof(struct sctp_paramhdr)) %
> > +                        sizeof(hmacs->hmac_ids[0]))
> > +                return false;
> Discovered by: opus-5, old-prompts =C2=B7 Missed by: sashiko-gemini
> Can these checks reject a cookie this endpoint minted itself?
> The decision to validate is taken from ep->auth_enable sampled at
> COOKIE-ECHO time, not from the state that produced the INIT-ACK, while th=
e
> HMACS and CHUNKS tests unconditionally require a well-formed parameter.  =
An
> all-zero (absent) auth_hmacs/auth_chunks looks like a state the producer
> legitimately creates:
> net/sctp/associola.c:sctp_association_init() {
>         if (ep->auth_hmacs_list)
>                 memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list, ...);
>         if (ep->auth_chunk_list)
>                 memcpy(asoc->c.auth_chunks, ep->auth_chunk_list, ...);
> }
> auth_random is the only one of the three always written, and the endpoint
> lists are NULL while ep->auth_enable =3D=3D 0, which is the default in
> sctp_endpoint_init().  sctp_make_init() treats the zero-length case as
> "parameter omitted" rather than malformed:
>                 auth_hmacs =3D (struct sctp_paramhdr *)asoc->c.auth_hmacs=
;
>                 if (auth_hmacs->length)
>                         chunksize +=3D SCTP_PAD4(ntohs(auth_hmacs->length=
));
>                 else
>                         auth_hmacs =3D NULL;
> sctp_pack_cookie() copies asoc->c verbatim, so the outstanding cookie
> carries those zeros.  If the application then calls
> setsockopt(SCTP_AUTH_SUPPORTED) while the cookie is still within
> Valid.Cookie.Life, and cookie_hmac_alg is none, the early return above is
> skipped and "hmacs->param_hdr.type !=3D SCTP_PARAM_HMAC_ALGO" fails with
> type 0.
> Given that, does the comment "they must satisfy the same constraints as
> locally generated AUTH parameters" hold?  Locally generated parameters ma=
y
> legitimately be absent.

ep->auth_enable can be changed at any time during the handshake, especially
on a listening socket, and we should not change this behavior for backward
compatibility at this time.

If it changes from 0 to 1 while processing a COOKIE-ECHO, the packet will
be rejected and the connection will eventually fail, but it will not lead
to a crash. Changing ep->auth_enable during an active handshake should be
considered invalid SCTP usage.
