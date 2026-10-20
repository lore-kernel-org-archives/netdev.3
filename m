Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502659;
	b=LTBUknMX8UGOwPdwZHc2DcoFYAhpkhu/cKWQJ5yRhifp2PBlWvXmsCpIkLHn3HZxrDIE
	 XuJzpYaRWf/d+rquCNuqoyzGQ6NsxMdxOpYgxOQ6vzQMCfKS1G43yHmVdouoM2JvQbsgZ
	 kr2G6dVJrz0evibi7+gXChPHpvMPb6dIZgLfqM7RA2w1sKWJ+H8jl/fDJ9w5I7kWwlH3K
	 s61gRqZDpHXjZREEMg6B3BnzUC1XyQn6OEbdoRHfQA9gbR0QN04a2kPrG5EmiqXGkWKHy
	 JKlB6/Fr6Xg6luIm8z80qpiT3aTREB4KJIWof5iODMU4IxQYk2bxdx59Uze7bBLiD6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502659;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=CgWynObHiTL6sbKZ8e5s3zD0AjZAi5FCYl16mnru5sw=;
	b=f5JS/LXuTITz1sJp57YLwHUottP6bV6IEKMXXPy/psthhtJ7V364SzruRM6IiFAOwG0g
	 3i5EVVyRYowIhHooDb0w1NcNo/35YracS9RZanmlwfs3hP8hmyth9fk/b9TWRmOYKKCAW
	 6Ps/xD9yWmjkuZ1cektldIauDCnKkOZPgkEtpgkz/81NH2iELsWOGyD+6is5TeDkK2MDO
	 gXgtxrQZr0yKItTVxV4MFEaNn8iAve8CC9kYcxdPJ0YWnQOr2KPwioLhFz2DWgP9Uf7K4
	 tZ2fY5PeEjFyeVOWmZnB61P5Cuw4pS+t/VCKNu9tScizWsGGJzU4U4XY/Mzz+3avGbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=auOiHwec;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEDC606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAEDC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=auOiHwec
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3a706146559so2409760a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502658; x=1793107458;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CgWynObHiTL6sbKZ8e5s3zD0AjZAi5FCYl16mnru5sw=;
        b=JeKf+dTloeDetlZCFMrEog7hSIXFf4+mIaW0A8/H8LRf6S+KvKhbXAmCRmixLChR09
         Xb+p5KV3XPH1B+w+0Dol+Tn4SayDVhn7piet0OL8nzsZpDkmFRAMjs/n6U1lKWTATdZs
         LisIlRR+U/PdoflTGWZMgf2+L9sVEPoP5SyIBb/EyYqT0btyLMB+u9UNxeAwRrvE9PjH
         34kqxCW4E4AV6W5EYIDvhv/qUA9him8LD4dTcdE1UfIXbwBA4PrgpPf6VcbPZ15wGWYT
         3ri8RFpGsAh3PXZ9Fbqjp2cXoMUTw7rynfDkQq3rhrLEeN03nZuddFy30ptqmzp7VYvX
         rXLA==
X-Forwarded-Encrypted: i=1; AKwUvBxC6vQBGNzgL6ud/07eO64pjdE0z5ek0J8uxSLRGhFrzrdMhJSlWcLA79sXKbxa3+/HS9t7drU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJxkvLuPfEYRB9LZOdiyrA0i8KLdfZtR1KkPE9ERzsLj9X+gnf
	9QH2Vt702hrV87n4v1JLEncnFAwgtpKMEK2JfZI3zwNSoHyjkNB93o86Gp64YUP9A4LUVAZlwI0
	fFYCKEwcSs9WohGlA9b2XnsEa3JQBHXCDLDEbf4bEdgMFRzh9QpZDdeFbOi0hzSkw2QPVVziISy
	PhmBUMa1W9mTGZbTMrbfMaIMO+IRE4+844SovnpPfdTtuBWTYxbX7q3pV+JKX5hgtzfRYdy8xuU
	1mR6slbfw==
X-Gm-Gg: AYBFou20GmPSd+vjvj6gBdAjDGePNetkJ7A6PkzISxBNmOh4lvcokR9Vc/+iwFTerMC
	BeRB9X789jU9BOt8EbHDL/UltLsb4eGGr4q6yi7OZetgKMDDiWBDUmEhikB70s9fsYDQCsNJhUC
	mrJ3bIoXLsiHfiydK9HcY5onN9UkRwAIEOMqzbZp9aqmK9ntA86rGTHgN9t/sKq9GxyAIjv31e+
	1xuuyW0pLVLJ1/7+CtslUn1VjpNDKhLtAHjM9996X4S34p2LJWAjgNIwgn/F2RxTIxt/peSVdHE
	e2+mBAeXz5MSVn3KMdheNbhi+irXDLPn6jF9pjxRWuTtgbGaKdfgeL0AbFQdLhXw5SB8yglUAaX
	2/OUjRJDRTpWit86YkWoyPjgvtENb4TYPBxI+MLibDGAVLAoH293jzoHPL6zFejgoskxy0Q37nH
	0c2NBwQ3M0QMqghpYsZAxcmK1VjSOQUWPHJvUf
X-Received: by 2002:a17:90b:55cd:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-3acef101a73mr9628075a91.12.1792502657757;
        Tue, 20 Oct 2026 06:24:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad271d6454sm2257479a91.1.2026.10.20.06.24.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 06:24:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7bf5c02f7a3so312468137.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792502656; x=1793107456; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgWynObHiTL6sbKZ8e5s3zD0AjZAi5FCYl16mnru5sw=;
        b=auOiHwecnXWhemAsR88rsNMSA8OzEmNM2hFUAEfN1u0NqkZ0MhnPwHCCI4QUhmwj3L
         opohj1AwP0YD/1ECDHhAhSUrJ41NT4/ap6bdzq87uQfM/weEfEeesWobLZLkYoemoLBe
         q7/9lZng76Go8/n+9xLBeeWR/i7Og4GaIkVZ8=
X-Forwarded-Encrypted: i=1; AKwUvBzNbrfWvafOs1smfDJm4cAqV9AS/nmtXtvq8T4u6FxMtUhGiQCqTdSv+NufGvYBbM6vWQo8nOo=@vger.kernel.org
X-Received: by 2002:a05:6102:5494:b0:7cc:2daa:90ee with SMTP id ada2fe7eead31-7cc3695dde9mr2880996137.15.1792502656392;
        Tue, 20 Oct 2026 06:24:16 -0700 (PDT)
X-Received: by 2002:a05:6102:5494:b0:7cc:2daa:90ee with SMTP id
 ada2fe7eead31-7cc3695dde9mr2880979137.15.1792502655818; Tue, 20 Oct 2026
 06:24:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015121847.1933308-3-vikas.gupta@broadcom.com> <179241358967.3135.12651975554831459971@kernel.org>
In-Reply-To: <179241358967.3135.12651975554831459971@kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Tue, 20 Oct 2026 18:53:49 +0530
X-Gm-Features: AclHuK-CzjfIaeX71EVRuOgy6tX3RphTm8XgnlrtGMt6lEbt4B-eQ7fKPnlBEBc
Message-ID: <CAHLZf_teroSkRNQq1Q6DrBKqqj0Kd5cnX4rjwjhTa+gTF4DWEg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] bnge: fix RSS table sizing for large RX ring counts
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com, 
	dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001f31cf065e458c56"

--0000000000001f31cf065e458c56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AI review looks valid. I will send new revision.

Thanks,
Vikas

On Mon, Oct 19, 2026 at 6:09=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] This patch adds a new helper, bnge_calc_nr_ring_pages()
>   (drivers/net/ethernet/broadcom/bnge/bnge_resc.h:90-102), that keeps=E2=
=80=A6
>
> --
>
> bnge: fix RSS table sizing for large RX ring counts
>
> This commit changes bnge_adjust_pow_two() so it always adds one block
> before rounding up to a power of two. With that change the RSS indirectio=
n
> table covers every RX ring. Ring page sizing moves to a new
> bnge_calc_nr_ring_pages() helper, which keeps the original rounding.
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/n=
et/ethernet/broadcom/bnge/bnge_resc.h
> > index b62a634669f62..58462524939fe 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
> > @@ -81,6 +81,17 @@ bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
> >  {
> >       u32 blks =3D total_ent / ent_per_blk;
> >
> > +     if (!blks)
> > +             return 1;
> > +
> > +     return roundup_pow_of_two(blks + 1);
> > +}
> > +
> > +static inline u32
> > +bnge_calc_nr_ring_pages(u32 total_ent, u16 ent_per_blk)
> > +{
> > +     u32 blks =3D total_ent / ent_per_blk;
> > +
> >       if (blks =3D=3D 0 || blks =3D=3D 1)
> >               return ++blks;
> >
>
> [Severity: Medium]
> Can this new helper size a ring smaller than total_ent?
>
> The rest of bnge_calc_nr_ring_pages() is:
>
>         if (!is_power_of_2(blks))
>                 blks =3D roundup_pow_of_two(blks);
>
>         return blks;
>
> If the floored quotient is already a power of two of 2 or more, blks is
> returned unchanged and the partial last page is lost. The ring then has
> blks * ent_per_blk slots, which is never more than total_ent.
>
> The commit message says "bnxt_calc_nr_ring_pages() always adds one, which
> is correct". This helper has the same name but keeps the rounding that th=
e
> message calls wrong.
>
> In bnge_set_ring_params(), the completion ring budget includes
> max_tpa_v2. bnge_hwrm_vnic_qcaps() takes that value from the firmware's
> max_aggs_supported without any cap:
>
>         max_rx_cmpl =3D bn->rx_ring_size;
>
>         if (bn->priv_flags & BNGE_NET_EN_TPA)
>                 max_rx_cmpl +=3D bd->max_tpa_v2;
>         ring_size =3D max_rx_cmpl * 2 + agg_ring_size + bn->tx_ring_size;
>         bn->cp_ring_size =3D ring_size;
>
>         bn->cp_nr_pages =3D bnge_calc_nr_ring_pages(ring_size, CP_DESC_CN=
T);
>         ...
>         bn->cp_bit =3D bn->cp_nr_pages * CP_DESC_CNT;
>         bn->cp_ring_mask =3D bn->cp_bit - 1;
>
> hwrm_ring_alloc_send_msg() then sets the CMPL and NQ ring lengths from
> that mask:
>
>         req->length =3D cpu_to_le32(bn->cp_ring_mask + 1);
>
> Take 4K pages, rx/tx ring size 511, agg_factor 4 (TPA is on by default)
> and CP_DESC_CNT 256. Then ring_size is 3577 + 2 * max_tpa_v2.
>
> Any max_tpa_v2 from 260 to 387 gives a ring_size of 4097 to 4351. That
> means blks =3D 16 and a 4096-entry completion ring, while bn->cp_ring_siz=
e
> keeps the larger budget. The MAX_CP_PAGES clamp cannot catch this,
> because the page count has already been rounded down.
>
> With 64K pages (agg_factor 2, CP_DESC_CNT 4096), any max_tpa_v2 from 2819
> to 4866 gives blks =3D 2. That is 8192 slots for up to 12287 budgeted
> completions.
>
> Could the completion ring overflow if the driver reaches that worst case?
> I could not confirm whether shipping firmware reports max_aggs_supported
> in those ranges.
>
> The RX, RX agg and TX ring sizing use the same helper. They are only safe
> today because the ring sizes are fixed at 511 and bnge has no
> set_ringparam. A tx_ring_size between 512 and 767 would give
> tx_ring_mask =3D 511, and bnge_tx_avail() would then report more free spa=
ce
> than the ring has.
>
> The helper also breaks the rule encoded in BNGE_MAX_RX_DESC_CNT and
> BNGE_MAX_TX_DESC_CNT, which keep the ring size below pages * DESC_CNT.
>
> Should ring pages use the always-add-one rounding as well, the way
> bnxt_calc_nr_ring_pages() does? If dropping the remainder is safe, could =
a
> comment or the commit message explain why?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261015121847.1933308-1-vikas.gupta%40broadcom.com

pw-bot: cr

--0000000000001f31cf065e458c56
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZKzsTDzWEhPsCM5DcbMg/B7eD9n+rBWHxsk+yKJKdkLpkpTKdxxTd1Y5Ln+k5KCTjxlCUQQ7Q2Zz
qYU8bfRq5ZMwUVJD3NZCqEKbEIgSX2vXFS61zdPwnLyHyaC/erAWmgHLu4kzpk/V10NcnUjX9FYK
f/Ggi9MeMNG20gEIUbCg3RgYf89YLXUJDOuoz/Yajw/VuiVlwS81wF44DmJhAVcGzrI00uydpksG
oQY2qVlhYsvNTqU2V/uaBrKQnyM0PkU140cCAwEAAaOCAdwwggHYMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcw
AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIARe
MFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBo
dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIwYDVR0RBBww
GoEYdmlrYXMuZ3VwdGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQY
MBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQI6pBWVwIN47wGrC1m7lYfqN94QjAN
BgkqhkiG9w0BAQsFAAOCAgEAOdSnSEyuTvTtsnmEilB0JfgRKx1MM7kNdv0pfWcINJhssfHD8Fc5
wm+JzenYR9yJAkntX0Lr9yv+OG0Jqhvy7u9gKljfI4jXO4qxZ2jf1YvI+fDK29/NV3JAQuipT3Vs
IxBI73CQO11VwMePOTsUNM1s+9cWT5zLuqOEEu+95jRo5KEtH1/4nahrToLU1Y+flylsBaAUhB72
KoBBzdewa+psa32lY8X23AWDoczIlUBmPt0hmApBvHOUCYszSiBu4/VhVDuq2iMBtnYAj2j9Q7Ct
pZHPj6fQv247S9dTDDym05r8arHAsUw7B29KvPfxeaqexL4gwQQjIsfdZeh88XYLXA+mvEej6OlO
YO3546G7bczFxIjO6V9RrvYEeAb+n7udXYymuIm02XtxIkr/Uk0gRuFoOpG2Dw1OH8xsOUER1+16
qGb2QKMgaKL/IIM3gXAuCxNVBOT+Fj/wh5hw7MFvTTXPFA8IKusoHZYpxdrr9xjoJ/wt6j4/E6K4
IO/WuSc4nM6kshiwIu5c6r97213ZtJFOrjoITiBIYFP0WQsTsEbWvaBX/7daT5IVr9rvCOCk2JA8
bOWwP4OYXCKJY5nZOntb0ECSI7RM0kGelGY4MAD42+OBWHxKU1Qvt5WK4kIXdKpdFp9Drv17PyCU
dR4AvAJyWnkqZyi5QuRg/hMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIz
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIP1yefM9ycFP
+mQMBIMgMwwhkilv/VSW5VYoS/IUP02aMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MTAyMDEzMjQxNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBABgZ1T4dRxn8EjG1ms1YNkmopVy/W6cJ0qOh4AYn/KTZFj6/
pZFyowdEs3U/LAGDwNFxJQOu1IG9m3N+RjjQmVd696CnpgRwPDKO56rJ9qMcKqTIxQ8Wf3WNY1y7
pUehdPVzwAyQ9lb0IBp2/I8LNCYMBicbjR1dHFd5WcciwZy6IdKuU9ljHoGt3cKt0T01exrrmEvO
L2GksE6Bzo47ZnKao779qSenhm5GlFX57iN4E8mtcWut2nK8ZoL3rJPsi+DMbM7QwzlI8HqUW1ck
4lijQc5JaTA9KIEPiTSYVqVQWqC5wQEFcaN4zAHPsz3wZV4KzFMhABTmOvVOmydBe1Y=
--0000000000001f31cf065e458c56--
