Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EDB394EBA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362638; cv=none; b=nJ9ihNvzm1NFowI5FLDXg8jEvkzmQafCqFjTqF1925ejNuiU/8tqjRsu0V0MajyMlclQeUqHwU+fvTgk8Onoi0BL73Vojz9d0se/nIVGFCLgue4Xhma8nFwUzKohlG/z9QkrwXLwP/g8+8Zhwy0Yukd4Ug2s8qHXcGRFLXOmNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362638; c=relaxed/simple;
	bh=id2rCQm5o5yjUVELOE8ufZ1hYF35onzhNYaDuFrQ4EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtwoLpC4oQIXe2/uBeHrozoPR6pYkosQqVgREVnygIckngopTkCeP5CzwRhpHVdxtrHnDQUzstZKBCdErU/bVYep7T0P4I9h6WNbJG7rlKZbTXEjLC1clUVjPMygto8jYVasF2ALt+EyXiOjXEucI34/QND1WK5PMXIVo5Id38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ctaPf2V7; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ctaPf2V7"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-917a04338c1so19563636d6.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791362636; x=1791967436;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtzNcccgMJEHHDfSSN90cxINQfafAaP3WAjpS4d4T0I=;
        b=FcegKO+T/XitmpYguhl13g5WNeqyT2XfHs3QTt9odsqlxPTpRcWaoaY+wqla7raYs+
         b9EwGGg3ToVg8wTax/vptzELUy220vhh4dnlebrwas+/qKYYS6uXgaSMor5Ieqf5VF5Y
         /p0foIAGGfQIKgkI66CAJ4123HTcj1Ct8QabPC8PINTQyxclnucumFGPYE8N+wwfyQAY
         aej0Dd0kL9G/cFZ/8GWCsVg2A95n+C31XOxY6LzenKH2SJxKCEeopcV/WwPMkSrMV3JF
         QhuYUBIA6C9BUY2VL9aJoF4gZ5e7B8wojVNjrjuWIEk7QvL92PcfL9f0xBIj0HensT+g
         BhKQ==
X-Forwarded-Encrypted: i=1; AKwUvBw28GDla3VazuA6MpdpFUwquh9QnTMfsHxo1lBKPSUF1rXc0sFpsW7AD6ThZoVkC5ThxCk8KV0=@vger.kernel.org
X-Gm-Message-State: AFuF++kC6D9vPiIHgpHiQUWlHMtf5Y5BqTdDZ81/M03XjyO/xXz4EwPe
	sNRO1LAv67ua5biEaiywbdgPTP+jTBMQ/RyUpTMnOXHItQMySaOQswPpXjOXD1DbufzZG1zsoeR
	raLyw0sn4KvXEvLhnW5TmcDg03Q8H/8cL6tcMmZk6M1UC+2qbOrU7325Z4IIjEYoVWbKV9i1KEt
	UZEoaQ6W5nI4478JrXvM2ugt89ElX8N1q+syGLmn1D9u9QBX41XNClz8TGSlrdRyQbfuxVvHmdI
	bDUmK8QoQ==
X-Gm-Gg: AYBFou3iCxMnFnpJ0tB+dRBMyykF5dCZLlIL2YhixwTmYWHFui7uUV9J6mDSuOiVypg
	wEkxyzHSqt+JGbZpMWjHnS9Ea5M+GUTmoIoEFKGhKReXL4aXzhnRVsoF+SS4KpRC/WgN+sbzMmf
	kNZc1gUkY5z0XCsc/GTEDH0CHd0l9BkOJmry4jx/q1Insn6X8vJjvA/5vDSvmNozA6tIHLdaxmZ
	luayKIpG1L9ds/iWVKLUqJxFrsp6OW6ZAVCUt/wtem8jlTY28O26nJTvINJQM2eR/pyBcTPk6r1
	jC0Dpy4qlyOlwEP8fj3W4/u/X252hsNUPGJYgnvSnUIPRJYOeRVZI8VU0ppA6fdHizQJF3zcKOQ
	0HixRN1jX/Vc4EdlQ1m022aTNkhBZsf5uKwOpoL1PbyzGfUSc/nlHenjMoM9T8JXqkKG1YGpBw6
	FbQf8mhU1e4k+isHeifUur8H3qAXl+fwo6Yl/H
X-Received: by 2002:a05:620a:4613:b0:934:ab73:ac53 with SMTP id af79cd13be357-93e9af42cd2mr323897485a.0.1791362635651;
        Wed, 07 Oct 2026 01:43:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93e990d8cbbsm58385985a.8.2026.10.07.01.43.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 01:43:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf67e46ae0so736332137.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791362635; x=1791967435; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtzNcccgMJEHHDfSSN90cxINQfafAaP3WAjpS4d4T0I=;
        b=ctaPf2V7PFvypG3p0z9OhKj0Q83Eq+5jkTlJuak/I3+1CbY9P3SyLJH+C4bDL/pQHu
         T7VIOnBwXfiiWLGwZiOeszOCHxIB3hAPKIb6h4PgBphflwKyXoK9+wDIcfjxra5jBa0I
         4CAhcwEA7AIgJNpjlujDo3102tE1744sgfKV4=
X-Forwarded-Encrypted: i=1; AKwUvBxhoPmGHkLAOlvJ0l7D3JLdJttMtmH1v16BO03F85Mu3TPDnYtYox+g3tH5gqK9A4udBnAD2VI=@vger.kernel.org
X-Received: by 2002:a05:6102:2914:b0:7a1:f980:e939 with SMTP id ada2fe7eead31-7ca38b3d4d2mr326027137.21.1791362634946;
        Wed, 07 Oct 2026 01:43:54 -0700 (PDT)
X-Received: by 2002:a05:6102:2914:b0:7a1:f980:e939 with SMTP id
 ada2fe7eead31-7ca38b3d4d2mr326012137.21.1791362634264; Wed, 07 Oct 2026
 01:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007075649.468033-1-edumazet@kernel.org>
In-Reply-To: <20261007075649.468033-1-edumazet@kernel.org>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Wed, 7 Oct 2026 14:13:42 +0530
X-Gm-Features: AclHuK_wIctc_bfvibTZaWk0Pm7leKl6WsVwA_DB7BCxQ9t55U0I5YdpIqU2SYQ
Message-ID: <CAHLZf_vq1buMvBFmC4t926xEgs9SCPCR8ucqYY=hETKygSkD7A@mail.gmail.com>
Subject: Re: [PATCH net] bng_en: pad short frames before sampling nr_frags
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008a7e8d065d3c1d74"

--0000000000008a7e8d065d3c1d74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 1:26=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
>
> bnge_start_xmit() samples skb_shinfo(skb)->nr_frags into last_frag,
> and stores it in tx_buf->nr_frags, before calling eth_skb_pad().
>
> If a nonlinear skb is shorter than ETH_ZLEN, __skb_pad() calls
> skb_linearize(), which pulls the frags into the linear part,
> releases the frag pages and sets nr_frags to zero.
>
> bnge_start_xmit() then uses the stale last_frag to fill TX_BD_CNT()
> and to walk skb_shinfo(skb)->frags[], DMA-mapping pages the skb
> no longer holds a reference on, and sending their content twice.
>
> Fix this by calling eth_skb_pad() before nr_frags is sampled.
>
> Found by Sashiko while reviewing the similar bnxt_en fix.
>
> Fixes: bd5ad9c052c8 ("bng_en: Add TX support")
> Link: https://lore.kernel.org/netdev/179134695789.434549.5352691633427688=
4@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>

> ---
> Cc: Vikas Gupta <vikas.gupta@broadcom.com>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_txrx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net=
/ethernet/broadcom/bnge/bnge_txrx.c
> index 7d45e057f2e82069b3b54936a02e4c955b2787c8..472b02cc43b3c1174e061906b=
730c0edf9478846 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
> @@ -1490,6 +1490,9 @@ netdev_tx_t bnge_start_xmit(struct sk_buff *skb, st=
ruct net_device *dev)
>                         return NETDEV_TX_BUSY;
>         }
>
> +       if (eth_skb_pad(skb))
> +               goto tx_kick_pending;
> +
>         last_frag =3D skb_shinfo(skb)->nr_frags;
>
>         txbd =3D &txr->tx_desc_ring[TX_RING(bn, prod)][TX_IDX(prod)];
> @@ -1513,9 +1516,6 @@ netdev_tx_t bnge_start_xmit(struct sk_buff *skb, st=
ruct net_device *dev)
>         if (unlikely(skb->no_fcs))
>                 lflags |=3D cpu_to_le32(TX_BD_FLAGS_NO_CRC);
>
> -       if (eth_skb_pad(skb))
> -               goto tx_kick_pending;
> -
>         len =3D skb_headlen(skb);
>
>         mapping =3D dma_map_single(bd->dev, skb->data, len, DMA_TO_DEVICE=
);
> --
> 2.53.0
>

--0000000000008a7e8d065d3c1d74
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
Agxt8eaxmNwH4eu5pUowDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIOSaYzYzfmfi
o5MLMyOWctzPt57mSv28rUZWukUafWP2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MTAwNzA4NDM1NVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAMAOBh9sxu0rmyTl+hRKo/wtjEaukuvsQnUEwgXRsrjT2S8d
KRf3m1sXUjy0UiUpSjORVmZYd34S2J7teaQigg9Y6y5dbhjZ5Typ931Fh4Kz6jCargykADWDA2q1
UPdJOeQl+0Wh2i6Lz4NbT0/BAdVr9eeBZv5EG4ReLE/c77GzJtL3JhcY1PrQhVtc548ISSC9fCyv
t7jxAwLb6bl/yCr503HFwmiWsr9y8sO7HZVaGS9yt3ZnZh9NhhKQQT/5x9kZCT+iI6SRMcJLqc8m
X2q4lxkcvQGXyOfFDrf/brqSIc2qQ+i6K7ZUIM+vljqAVM6pwPlMGl97MXmaT1jqlnQ=
--0000000000008a7e8d065d3c1d74--
