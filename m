Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA153D955C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837812; cv=pass; b=U5rNi///wj48sNl7DeeEP/Lxkq6eG/XYiYnVfOhURPfMHcZbFr3+kAAzTudETO2Ypuh6/WqV9Hls3OwvLUcmKEn4eEqfKpBZXM6IWbEnTHPFzH9KaCvgi+rCBMjWI/2gM3wizCJ9cq7ehrxV56KPme1dqqkgFJ3jYmjuUpt4oiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837812; c=relaxed/simple;
	bh=V9thtctaEPB6lL/KXtYDegVWUvfdX7j2N6TX62uRfpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUlWCAKXgvtlfwiAJ3FVBtthsWySqf2irs0c+eOFrzcxaPDbNCHneO/4U2cA8/xgCgTKUjLPXkgiPxKZwXgF581YWYCzYAzkaS1jCGfBvHttMSYBxA7a8Njc1ouWoP5OD1KqonYuF5PC2TQUdd7/azWfMi1QTr6kDX2QbefC1CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLtp9PA2; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLtp9PA2"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so982041a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791837811; cv=none;
        d=google.com; s=arc-20260327;
        b=L+SLKlOFQKTkZLETwmKYCvnEABVBLspxdLvOpPK5JUj08KIyyVwh4mE1nI8MSnaW6n
         2bKtEIx9fwVfWDA4w+kSS59QeRT3k3PCpG7+L1s+9yB6XwbXQuTihlQXziz93N3dA2hN
         ssoUpqoibkx2Iourk4xYVzcFcYW5u+RGZDrp0aQWNyn8eFaSRpw4kQWUrcLC8PDrO9cZ
         j41+uGTTDah7rYtqunGGMQmRLbf+c0fFfmxXVRpNh7NATD762V6u8jv5D80RcMZRoRbd
         Q6s7+gusDubgh5emYB/wHtws1fm9HRqoTsKVKIQciP/khjbs7ofdKrVLgevu17Lct+Rv
         EiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gBTKp/yDTh6RzoG3bbVkNoxEHUElC4XTCqvtS+EhVmE=;
        fh=44VQk+4rrRTro7CPT0fvzo80Qs0Um3vP4Y09dSn4TbA=;
        b=pNk06QT6Unc1jis7VMOyqcG4I8XHh9wY5zqYyTKjydfInHMUiIBsUNVUD5LpDgeKJ4
         tnJGDnHBZGkpkxgQfy6+rHohhxn57gROQtibs/hDS/nv7E7TtiN4T4cXvCmTo9WwJZVe
         JybG2xBz2nzamooZo+Tlw7mu4+taziJeeUJm68NKIdgHMAgVD267QERr5YUC0/AUhUAJ
         HAr+IyiS4jnTcI0Sz9DzTjG62PsLu2hq/cLQ122m/BHOSOONI8E1+0mgapfI8r97AF9/
         EFXBaGevZFcSExBTad1UQYpMvhF6gWn05Em36FavjNyutxkqEQ3YivwkrOfWkZq8GmZ9
         JokA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791837811; x=1792442611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gBTKp/yDTh6RzoG3bbVkNoxEHUElC4XTCqvtS+EhVmE=;
        b=pLtp9PA2RAqjY7DSMRJvq4Zsh9sbldCLLKKPH35EPwjd4Jjj7CHmM38YJ0shnL+dlw
         l93RHLRt/m5FVQbXV88j/4HcoLKELGT4xfyxX/6wkU9Z6WU5TzYMWYDy2LuEZF263X7X
         bxIvNIQ5K1a/A8aFpaVGbf0szBHVhMuugH8gFO+DuPPvOnWgGKkuK6V6SlZs+CWxrUPn
         gQ7uJzb45Yhau7AQ/W/NmdPgwW0pfz4JDGV9z+vGJYhIPZL0Qcj31HfHX9VmkrPX0QET
         GQcKecrrTjCV2bmb5jG2ZEgFh2OPhCRYgcG5QHK7eSf/OmHgazdvSjD7hhmcHPi1hiza
         37Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791837811; x=1792442611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBTKp/yDTh6RzoG3bbVkNoxEHUElC4XTCqvtS+EhVmE=;
        b=puhjRBRjTsDlx6Ie/QTuJeSHtXW8h6dQN/bPtz82rOnkamJ4NEMwzA+X8QQDFCc58s
         l2rxrkk6xx00odj1JnI8c+HWhAfBIEtYa0jPJGUoRxCwKlNNLfgwhfizVlcnYn2pSY3t
         fk5Z/BCmQz7R0eTxjHDV3qYkhqRTidDJsUG379zZKZTAazEF6va70jN29kUjMBrP1OM5
         4oT0eOtndvGl7ETB5lTecYt24vGENpiVZBBV+jLz5QPryTdH5CHaMXvsV3P7JaKgcA5l
         uTRaj76RS+4xhrXX9f1yBSGcgr+rPDUpWipaAAdy+z4fX1eOMBtSGho+DAkjcXnPJOYc
         DwNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZpTR4gmnB/R+CschEQSspRECWcN2Rrxm1f6d8nF3tZdGmNsOHhAqFcwX+SKRUHKENUuOrmBk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGi2yPg7YJFrEllwQcW+Fn3cRWa9NX37oqUCQHY8mHAXem85eu
	+SAN0IpKR5KrUjw3qXujiombpziJQFMKErhARjF3iE5XBMbXLzRRce71Ypi1hwtOw9knOjwrb8H
	Zni/RR0UBgvU5Nn23gNZZBBBve5kETTA=
X-Gm-Gg: AYBFou2fvZ+Wv1ZXAl6QNR2uKPC4cmyqvPFXuRz1bCDl7UiVLtQa6M0aa2DB1cIenA3
	QXhvwsL8nXReOPB8wpWgkKLIMJdRU/N+8FcrE88J1uMO0LSGJZGRFjxZxSxlK37ECAZ1igwO+ur
	UjzRwES6D8mVlwSi02pL0tEemKE+H+X+QLfHiVXSosrDJEwil+FTeYNW0xwUR/hguwtQ5/krT5C
	U3y0KulERHjSkZ7kYlHtewNwNamUHYFOGuog40ecZYraDqvxaMEzdsgcp2ST/AFwJAx4XcZhhAS
	wYtoSm9hFg+6onqH3l8H2gW0MyuFgV6CLCrtRACEHvwdxaeHddj6yFtjNjbCe1d1CK6MgYz4S5a
	9p18XSS1qrNxSC3wdmk33BLamba8rn7qpKruE3NqQ6hDj+ZdzpN46QB1c2g==
X-Received: by 2002:a05:6a21:4ea8:b0:3cc:92d9:80cb with SMTP id
 adf61e73a8af0-3e16bf7b29amr8270211637.12.1791837810715; Mon, 12 Oct 2026
 13:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009074601.3954275-1-hdthky0@gmail.com> <179162162010.434549.13276446555925201942@kernel.org>
In-Reply-To: <179162162010.434549.13276446555925201942@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 12 Oct 2026 16:43:16 -0400
X-Gm-Features: AclHuK__f9Fmh30gHFKiGhSOt6lO_--K35IuH8GJSBpMK6CIFrgoJ7zRY7PfsL8
Message-ID: <CADvbK_c49wgA41_NwOig7TosQKAnNdkUa3HwgPCSukTpJ9DAtg@mail.gmail.com>
Subject: Re: [PATCH v4] sctp: reject forged cookie peer_addr with unknown
 address family
To: netdev-bot+sashiko@kernel.org
Cc: hdthky0@gmail.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 4:40=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch now validates peer_addr in place.
>
> Pre-existing issues:
> - [Low] Two comments next to the code this patch changes contradict the
>   implementation.
>
> --
>
> sctp: reject forged cookie peer_addr with unknown address family
>
> This patch validates the COOKIE-ECHO peer_addr with af->addr_valid() in
> sctp_unpack_cookie(). Bad families are rejected, and v4-mapped addresses
> are normalised in place. It also makes sctp_v6_addr_valid() reject
> non-v4-mapped addresses on non-PF_INET6 sockets, uses addr_valid() to
> simplify sctp_process_param(), and adds a missing !af check in
> sctp_process_init().
>
> > diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> > index ef26878f1282a..97390569c4bdc 100644
> > --- a/net/sctp/ipv6.c
> > +++ b/net/sctp/ipv6.c
> > @@ -725,7 +725,8 @@ static int sctp_v6_available(union sctp_addr *addr,=
 struct sctp_sock *sp)
> >   * SCTP.
> >   *
> >   * Output:
> > - * Return 0 - If the address is a non-unicast or an illegal address.
> > + * Return 0 - If the address is a non-unicast or an illegal address,
> > + *            or a non-v4-mapped address on a non-PF_INET6 socket.
> >   * Return 1 - If the address is a unicast.
> >   */
> >  static int sctp_v6_addr_valid(union sctp_addr *addr,
>
> [Severity: Low]
>
> This isn't a bug introduced by this patch, but two nearby comments
> don't match the code that this patch now relies on.
>
> The v4-mapped branch of sctp_v6_addr_valid() says:
>
>         /* Note: This routine is used in input, so v4-mapped-v6
>          * are disallowed here when there is no sctp_sock.
>          */
>         if (sp && ipv6_only_sock(sctp_opt2sk(sp)))
>                 return 0;
>         sctp_v6_map_v4(addr);
>
> When sp is NULL, as in the sctp_rcv() input path, the code maps and
> accepts the address instead of rejecting it.
>
> The header comment of sctp_v4_addr_valid() in net/sctp/protocol.c only
> lists non-unicast or illegal addresses as reasons to return 0. The
> function also returns 0 for any IPv4 address on an IPV6_V6ONLY socket:
>
>         /* IPv4 addresses not allowed */
>         if (sp && ipv6_only_sock(sctp_opt2sk(sp)))
>                 return 0;
>
> This patch removes the explicit ipv6_only_sock() test from
> sctp_process_param(), so that function now depends on this check.
>
> The sctp_v6_addr_valid() header comment is already being updated here.
> Could these two comments be updated as well?
>
> [ ... ]
>
> > diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> > index 84a4c97d0f755..175dbb242e1cb 100644
> > --- a/net/sctp/sm_make_chunk.c
> > +++ b/net/sctp/sm_make_chunk.c
>
> [ ... ]
>
> > @@ -1841,6 +1843,11 @@ struct sctp_association *sctp_unpack_cookie(
> >               goto fail;
> >       }
> >
> > +     paddr =3D &bear_cookie->peer_addr;
> > +     af =3D sctp_get_af_specific(paddr->sa.sa_family);
> > +     if (!af || !af->addr_valid(paddr, sctp_sk(ep->base.sk), NULL))
> > +             goto malformed;
> > +
>
> [Severity: Medium]
>
> Can this modify packet data that is shared with a clone? bear_cookie
> points into the received skb. sctp_sf_do_5_1D_ce() and
> sctp_sf_do_5_2_4_dupcook() both set:
>
>         chunk->subh.cookie_hdr =3D
>                 (struct sctp_signed_cookie *)chunk->skb->data;
>
> For an AF_INET6 v4-mapped peer_addr, sctp_v6_addr_valid() calls
> sctp_v6_map_v4(), which writes directly into that buffer:
>
>         addr->v4.sin_family =3D AF_INET;
>         addr->v4.sin_port =3D addr->v6.sin6_port;
>         addr->v4.sin_addr.s_addr =3D addr->v6.sin6_addr.s6_addr32[3];
>
> No skb_cloned() or skb_unshare() check happens before this write.
>
> If an AUTH chunk is bundled before the COOKIE-ECHO,
> sctp_endpoint_bh_rcv() and sctp_assoc_bh_rcv() do:
>
>         chunk->auth_chunk =3D skb_clone(chunk->skb,
>                                 GFP_ATOMIC);
>
> The clone shares the same data.
>
> sctp_sf_do_5_1D_ce() calls sctp_unpack_cookie() first. AUTH is verified
> only afterwards:
>
> sctp_auth_chunk_verify()
>   sctp_sf_authenticate()
>     sctp_auth_calculate_hmac()
>       data_len =3D skb_tail_pointer(skb) - (unsigned char *)auth;
>
> That HMAC covers the COOKIE-ECHO body, including the rewritten
> peer_addr. The peer computed its HMAC over the original bytes. Would
> verification then fail and the COOKIE-ECHO be dropped through
> sctp_sf_pdiscard()? The duplicate-cookie handlers use the same order:
> unpack first, then verify AUTH.
>
> Other holders of a clone, such as raw IPPROTO_SCTP sockets and non-mmap
> AF_PACKET readers, would also see the changed bytes. sctp_rcv() doesn't
> prevent this, because skb_linearize() does nothing to an skb that is
> already linear but cloned.
>
> A v4-mapped peer_addr doesn't have to be forged. For an INIT that
> arrives over IPv6 from a ::ffff:a.b.c.d source, sctp_make_temp_asoc()
> stores the raw source in the signed cookie:
>
>         SCTP_INPUT_CB(skb)->af->from_skb(&asoc->c.peer_addr, skb, 1);
>
> It can also be forged directly when cookie authentication is disabled.
>
> In that case, the commit message statement "peer_addr is validated in
> place, so a v4-mapped v6 address is normalised to AF_INET before the
> association and its primary transport are built from it" would not hold
> when AUTH is bundled.
>
> Would it work to validate and normalise a stack copy of peer_addr, and
> pass that copy to the association and transport setup, instead of
> writing into the packet buffer?

This looks like a valid issue. We can't modify bear_cookie->peer_addr
through skb->data, so please restore your previous copy method. To address
the report from v3, you can then restore retval->c.peer_addr after copying
the cookie into the new association in sctp_unpack_cookie():

        /* Populate the association from the cookie.  */
        memcpy(&retval->c, bear_cookie, sizeof(*bear_cookie));
+       retval->c.peer_addr =3D paddr;

Also, change to use &new_asoc->c.peer_addr instead of
&chunk->subh.cookie_hdr->c.peer_addr in sctp_sf_do_5_1D_ce():

        if (!sctp_process_init(new_asoc, chunk,
-                              &chunk->subh.cookie_hdr->c.peer_addr,
+                              &new_asoc->c.peer_addr,
                               peer_init, GFP_ATOMIC))

Please give it a try.

Thanks.

pw-bot: cr
