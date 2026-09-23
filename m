Received: from mail-ej2-f27.google.com (mail-ej2-f27.google.com [74.125.228.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14B5632B6
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183144; cv=pass; b=Losoyad6wxPdy/X5do6trQe9k64LL+Dnb5uslctzqG4tDX0JKvK9+OhteEfgKXHM/RREeugA7OdVPspCbd0dBUma9eHkaZwK/5FXT88lUVqZOIAxwO8KjUQ2laJ8VQ2d3ADY0CZRijbBa6CRQOiD1KWuZTteYzxyjkhWXmSRbtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183144; c=relaxed/simple;
	bh=tXcoFcLTFrl+n3mWO/nhG5PERRfGLycJwn2ML6UF/qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfREW/u71h1tLRh3zg9I0vqX5eL1TGW7W5ijTjr2kGnkmo3B9H3mibeDE5PuV8lKWkR46Fgkp70vRzDcXanayB2pjsPeCGfXnfYLx74wg7CGJ+adDWn5vU8XmAoOSV+YjywUC52FbiayI2OT82kYhsuBSXAl57WY9D3h7kia2Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dO5MGeEU; arc=pass smtp.client-ip=74.125.228.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dO5MGeEU"
Received: by mail-ej2-f27.google.com with SMTP id a640c23a62f3a-c254f6c7a58so192014866b.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790183135; cv=none;
        d=google.com; s=arc-20260327;
        b=FYX13DFpCWnDcuhNzw3NGpoUC+4V3CLjTiekcj+IJ3DKMblNiaDAuBh7VgytbA/nw5
         wDNrtMolKu5P+0AHgMAiRkAS6d8v6C0sfOZFb7Jrz6WsKxzXJaWDbvd4eSaH7+HrpXRU
         ur0MTF0SnCNHAqFK6Un0RWelLVuP/V12lPgGE7Mln+R7g9vzf8jhncz2ZywgZvcEv0NH
         2AGVyACKB125pmfEVLcgR1zwMiHpqxDvXWit+Vi4fhr9tUMIuHtb1oxwxfuv0nmxJ02y
         gAmy8mfKCAtbQDyEYgMdJRwcVpO2rWOAC3LgNFkLCDdYzo8j6ZGFsnl7NwmNhL3oozsb
         c/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pwdBCHa26KMlecbWf844DI+fhyw7MFEtFw7RqtnLG3Y=;
        fh=5/E7tJoP954SQl9L+0fdRCAALCJwNfwk/ttD/+2mqt0=;
        b=MKg93ySzm2nDGPfM/tJk37QsdkslKlg3eVLNjkH/FWdsP2QAgJ0UPy8xKDicTs7hj1
         rjgsPqzkupWQstGm5BM+KP5W9FxNzP7cKFkcNWqIQCJ3UHMovmrKoZQ9hCuRLFhAfTrN
         hagPLeXlcY8JjsYCQVYKw1mbOHiDqa75gDzWnJhiPRhTRnHx/IPWbvixpZ9BazZdDL2c
         OU5x8VFGoZ9QkHtfavau9YqQH37+zS91L+IOD7sXovGaof/CEI3+Wr96wue2Al4Ozm2w
         QQgXnEgMpSJ0mgfuK+VaDz7/v5qqjAC+VQtztwoWK954lrfJ7X/Qw2IlqcMNFojmHR7U
         ga2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790183135; x=1790787935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pwdBCHa26KMlecbWf844DI+fhyw7MFEtFw7RqtnLG3Y=;
        b=dO5MGeEUKUit9zgThkxEf2VTD4evtGpCm4LdVPKuCmMv6s8FFN1cMTiLW2PPGibEqc
         OrDH3lkmyqQ2ujhKJ3NCohtAhIX2lg4cVgaZTlD39oz7FHpyi1GmgQMcJSmZ0uVF9a4i
         XgYCr+cnVi8rD52WwmKe9AffPQZwu7h13hlCar/p//q+dG/C5nGDWJE+xWcdNQIUHhqd
         dSd93t5fuKUws2aA6fS5wbHtVdQJF4PToh9+E/MZ3TA8iZs3ASIB0ztqj5u+iUA9ROYt
         YZBDgtDY280EOA8sECvPVHVIv4pkQCxT0eZH4vVbe9vW5CkDLszEHwj5QMddd5FazP0y
         ERDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183135; x=1790787935;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwdBCHa26KMlecbWf844DI+fhyw7MFEtFw7RqtnLG3Y=;
        b=UpYP+i/R8hGLoeQVEsYce5uOHMR4KHRbFeA8saA/2he1pUozDpP5aIHp6vmWnDjMAU
         RXGu1piXloNua9bqj0kjqrykq1HGIKeODzPw2Q02nAYg3x4fdle91uEf/htGF9+FMyBy
         M+CGLli8nSPCvKaPBcWJ3m/3/Mia1Bcvyj+jIYHhn7DMavhu17WzWGaWkVF9zIxJAcLJ
         OA+ETxBBxphUUNiVZKf5X04UGcZyUUMctmZKFUJ99suHRPQP7ZpwWdB6FdnxE7YdGZLM
         3c8+7PYMfPzorTnEs5LjMkFNwday1O2djiqavZAGgx/efrCcnvY5LYHsl2FywUnzn1HJ
         83nA==
X-Forwarded-Encrypted: i=1; AKwUvBylhvZWio28e0FlamwiTT21PVm0JATRwB9Q6peXai3m7iKdUVO1P1wBrkacoi3e5T4ecFZ6jAg=@vger.kernel.org
X-Gm-Message-State: AFuF++m3Mk8MnT++19jEHMzUFeEqFTeSiTA7TMrF1wy4wW+kGYHSSBem
	TbEz9MGXenkp+OfxfgWWQowlg2XJ7KvdukkfNNxX1g+uYoDJzzf8sQ7ADb0MBtXhWxRSVzkEt1F
	1XmgJ0UXYuYrvMzt83qzVbHKIRC6zx1eB2WM5JDzd
X-Gm-Gg: AYBFou2yaD04uOJfX2MwvZLJIYt/gBTEfNb0315di2sY7Y3WSMOWcXiPq3nCLvicDi/
	l6gSlKY1P57BqQg5E2uXfeBAdgAF/ETCwjVc+IAAQSBMZPBaSGS4+wcgXAU1iGNBzgnyIQ22OPW
	AVGFC5lCDSZIBLFCHpt1DUARt+xclbRbs0rV6l2S42ZGs1KHpuBjNkLRCn8vOUuZhiPZxsWQesK
	xLZGI/eZ0wtTqPSvUg8Yws/ZS+g+DTcnUxn5XihT8eCg+WVr/LWS0PIVCH6r4HZ/YdxyTn1x9xB
	O7WYKBdq7ZJEfyHW0fcBE2jxt/ofMv36eCN3HYUim8lL9ZI3uIx7d9QaMTJxvCJCGjFxJ5bshvR
	HjEqwPmY4FnQ=
X-Received: by 2002:a17:906:ba87:b0:c26:1649:47b2 with SMTP id
 a640c23a62f3a-c2aae1f21f0mr277413366b.40.1790183133999; Wed, 23 Sep 2026
 10:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923141047.14047-1-hannu@varjosoft.com>
In-Reply-To: <20260923141047.14047-1-hannu@varjosoft.com>
From: Ankit Garg <nktgrg@google.com>
Date: Wed, 23 Sep 2026 10:05:21 -0700
X-Gm-Features: AclHuK9AIjEdfKNbdmltW9NWJL2YcFKTxr1aM9kODW6usKONgLqYTmcmrG62auk
Message-ID: <CAJcM6BFh7LxceUAGAWxLyjcyQs6NF_=N_sSSyKk9+JgBA3zjrQ@mail.gmail.com>
Subject: Re: [PATCH net] gve: DQO: accept TSO packets with non-protocol
 gso_type bits
To: Hannu Varjoranta <hannu@varjosoft.com>
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:11=E2=80=AFAM Hannu Varjoranta <hannu@varjosoft.c=
om> wrote:
>
> Since commit 014c607f86ab ("gve: add support for UDP GSO for DQO
> format"), gve_prep_tso() matches shinfo->gso_type exactly. gso_type is
> a bitmask, though: SKB_GSO_DODGY is set on every GSO packet that comes
> from tun/tap, packet sockets or other untrusted sources, and
> SKB_GSO_TCP_ECN and SKB_GSO_TCP_FIXEDID can be set as well. Such packets
> hit the default case, gve_tx_add_skb_dqo() fails and gve_try_tx_skb()
> drops them, counting them in tx_dropped.
>
> These packets do reach the driver: tcp_gso_segment() passes DODGY skbs
> through unsegmented to devices that support TSO, after recomputing
> gso_segs, so drivers must tolerate the bit.
>
> This breaks virtual machines behind a tap on GCE instances using the DQO
> queue formats. Every TSO packet forwarded from a guest (gso_type
> SKB_GSO_TCPV4 | SKB_GSO_DODGY) is dropped, and guest uploads slow to a
> crawl of retransmissions or stall entirely, while the host's own TSO
> traffic (gso_type SKB_GSO_TCPV4) is unaffected. On an n4 instance
> (DQO-QPL) with a Cloud Hypervisor guest, a 64 MB upload from the guest
> went from a 60 s timeout at ~0.9 MB/s to 0.19 s with this change, with
> tx_dropped no longer increasing.
>
> Restore the bitmask test that commit 1b9f75634441 ("gve: ignore
> nonrelevant GSO type bits when processing TSO headers") introduced for
> the same problem, keeping the UDP GSO support.
>
> Fixes: 014c607f86ab ("gve: add support for UDP GSO for DQO format")
> Signed-off-by: Hannu Varjoranta <hannu@varjosoft.com>

Reviewed-by: Ankit Garg <nktgrg@google.com>

> ---
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_tx_dqo.c
> index 80ab0a449ff5..675c7644817a 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -596,21 +596,20 @@ static int gve_prep_tso(struct sk_buff *skb)
>         l4_start =3D skb_transport_offset(skb);
>         paylen =3D skb->len - l4_start;
>
> -       switch (shinfo->gso_type) {
> -       case SKB_GSO_TCPV4:
> -       case SKB_GSO_TCPV6:
> +       /* gso_type is a bitmask: SKB_GSO_DODGY, SKB_GSO_TCP_ECN and
> +        * SKB_GSO_TCP_FIXEDID may be set alongside the protocol bit.
> +        */
> +       if (shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
>                 tcp =3D tcp_hdr(skb);
>                 csum_replace_by_diff(&tcp->check,
>                                      (__force __wsum)htonl(paylen));
>                 header_len =3D skb_tcp_all_headers(skb);
> -               break;
> -       case SKB_GSO_UDP_L4:
> +       } else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
>                 udp =3D udp_hdr(skb);
>                 csum_replace_by_diff(&udp->check,
>                                      (__force __wsum)htonl(paylen));
>                 header_len =3D sizeof(struct udphdr) + l4_start;
> -               break;
> -       default:
> +       } else {
>                 return -EINVAL;
>         }
>
> --
> 2.55.0
>
