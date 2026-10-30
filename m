Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398983;
	b=Nq7FpFOTgmvUvho530sOYCqPt1mrq1GgWch6IOandsDXpQKiToepT9uvhLPJGr4PTPzz
	 Xaj7ZfvlxH82pY1Ph3HRgZPf6KYNQH05HG16QG7ys6977temKRBekuCdUq9PKHgvbEhhz
	 dVqTlLnqSRonw7Zt2HKpMT+XMCXO0SK3gQh1NHsvni89629Fx22Ni0nVVroxzrPKznyAu
	 pwXUvLj+sGhuzQbzcPtj6EMLm+TWPi+faCSUFj/UApDm8SfLnSPmBRodtfuinB0IpBMK1
	 3BHVcR+t2zRrptYc7hKZzkcz5yUC6ahflhMDhHpbQqKmWGMQZsh6VUPLfhWG5tyWSpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z8xLH8tphg/sJCScdh+9RwuO0WOmq7EM7GVsYTwxod0=;
	b=0FcHmmneMqr3RuPLyY1yXvio6zUXyANv2S4cEkkEsgxCXsyRFSM9YFlzap9ewMfqZal2
	 jnMOT2D3VdCJqFkbZnMPSXTRuOnrBsiPinlYDXIpzndv87s9soM9GgzfLp+izcF6TyNC3
	 4C4hiaxdM8c8F7vjn8S6LIl/PSajNa5XSZM49CyjrrHtY8v3hAizyEBWhZluGCsHL8c3q
	 y83v5CqQJ7R0JEqt1kcNZO95C30hkI3LzAKOeqElLcKLi9oanwporHaJFTKmTm7xWyA9G
	 Zj6Rm0NwMiE794Cju/s9AkP6jLq3dqnYb1fKFz4iTWaZ0haqC8Sj6JYI3mqmXbwi49g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyOhzez6;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144A606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7144A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NyOhzez6
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7c03744ef27so399719137.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793398982; x=1794003782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z8xLH8tphg/sJCScdh+9RwuO0WOmq7EM7GVsYTwxod0=;
        b=NyOhzez60cdEJZkj3a1Ki0i9NX0+5oiPG8c0KX992RZv9xmU4iezyGrAoxDPDa50Pr
         5N42/UdFZtTzgL7gNmxMaTfbC1DOw5ijS+q+Jy+uhFA1baTHESJSaFe2LcTrcWfWZcHr
         APlC0pKZN5vcfRv9y2tpHgUsdqz8QRDra9UccLaUHiYe6cpolBjgamTZIcBQCsnL6QqS
         tJxaVU3GCDxNXBgXufmria6jQCHo58cccEDBNZwGExLutHNvHXhkuzioHKEGlP46rqoh
         FGAD4Ud2RxPInl4w7sBsnFNAVk3Td7Cu/wC9TNAQcI8HkLVhYaRhuLoLim92Oo58wjc0
         U/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793398982; x=1794003782;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8xLH8tphg/sJCScdh+9RwuO0WOmq7EM7GVsYTwxod0=;
        b=OrJf62nOeIbLIu4kAh2Oc70jKMXbaO6ocG2QjxgLbuWolQ50ZKpcjVfasSPRpfCo1Z
         mb9yVAeRdUex50QWp70ncUJMGUPsbzSX5WroA0jHlyQRNA8YfQ4HsU2u38fsQhoUXbVM
         YvvKlq/DCx7w9bVU0rE80dtHV0DHXPR7DGck5qD0EOikcN+5eqfhbf/46Jl7oLnTD/MZ
         jYG4P2VzPXj1fREwMURGvNZs4Kog4ZLzArLXNrvs40Qhk1GeKDtmigY7WUh8Oon8uek5
         I23tgJ3iB3BSYhJoKrQrB4NHkurmfuHdq0QuZINIjmAdftjS0MVpsBRJFPNuj+z/qMEZ
         HU7g==
X-Forwarded-Encrypted: i=1; AKwUvBxajvqJj1W1aJ+SqLDriqNVXSvklIy9nrXMEuRFxh1ljl2sYBkeLGpe8ee46GCOP3SM0mSmfEY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfccDd9eWveP4g5xmVpviUEH8iObpfo01ngCUPUWTr4bWVubHj
	3juLg0HmhKeUKB9yKr4VHBQWgPyslkzfhnE0RCj/8NUuRaWNXSX7WjBWeieavA==
X-Gm-Gg: AYBFou3XynULLcWxd4rCL2DkI8Y4bzGo2awIfYJGRpwkGMGZSVWx5/qCGnpdb+VHNqZ
	dS+WpDvaHpedPZzSZ0uI1BsyAfZ+JuKXEVzdGnDsBpSLblR48qKXx6DKKauP3HbvoKFJcSmoDe1
	VqcFsjVIXOwGEMfIkzIfe6QP7Eg/k1GsBM97ps5TXtT/6vZMSV7Eyl/EO6uxbv5LI4iehFTGwFU
	zewoQnDICy+FSBjX6zTsXO5aECXct4jlTmcSQorZktZMvHIQppwvrZN3FmM/FuieJEqZ28VU7bO
	wYuzkw05uQgoCEIgY1BW+jGBHhxM5DLYdpKEZt48yXQyGmrnQOLBWPgAECRXZS/lSyA236ARytQ
	Mn8SoqQfJVcCCQCwHUhPjoqPRgXqZwBfkMiNOratvY/dY33hRITvsKhab4n7Aa1+jk619OOvt6x
	K8VdGGitQGte1uPwJLGf/I+bROMb6B/pPGUg566O93en0sRuOvTfUUvtU+NbSqvNDLdnoevAZrC
	6Cqmm+14mAcTzPiLEzCzUjgpPlsBY/WeWbeLFZA491IOcPpZw1pp3ZeeO2GDjkWeDwS4uB2W6Qo
	8IshaJJy9m2y2XGP9r9Fv5R7rcZeOm7r6Esh3AHeK1qcWnhcZ3ZBT1ikXDhb3R5/XbfWySwNFk7
	/AqXJ1EMPLScJ23UxQPb21Fq8ll8hlSioQNRN/47ptumSKcCjRh+vgYOK8wB8QRkZjqe+
X-Received: by 2002:a05:6102:9d4:b0:7ce:5952:125d with SMTP id ada2fe7eead31-7d0728d38cemr1656784137.36.1793398982417;
        Fri, 30 Oct 2026 15:23:02 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee4c1603sm4219115241.10.2026.10.30.15.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 15:23:01 -0700 (PDT)
Date: Fri, 30 Oct 2026 18:23:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1PlronlhajlhazlhbHpgq7nrrEp?= <tencentos_secure@tencent.com>, 
 netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Steffen Klassert <klassert@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, 
 security@kernel.org
Message-ID: <willemdebruijn.kernel.18765b89651aa@gmail.com>
In-Reply-To: <589B4474E0A78486+v2-20261026-p1@tencent.com>
References: <v2-20261026-cover@tencent.com>
 <589B4474E0A78486+v2-20261026-p1@tencent.com>
Subject: Re: [PATCH net 1/2] net/ipv4: reserve exthdrlen as headroom instead
 of counting it in skb->len
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

tencentos_secure(TencentOS=E5=AE=89=E5=85=A8=E5=85=AC=E5=85=B1=E9=82=AE=E7=
=AE=B1) wrote:
> When sending through an xfrm route (rt->dst.header_len > 0),
> __ip_append_data() counts the bundle header space ("exthdrlen")
> into skb->len of the first fragment skb: the skb setup does
> =

> 	skb_reserve(skb, hh_len);
> 	data =3D skb_put(skb, fraglen + exthdrlen - pagedlen);
> 	skb_set_network_header(skb, exthdrlen);
> =

> so a fully filled first skb has skb->len =3D=3D maxfraglen + exthdrlen.=

> Since commit 353e5c9abd90 ("ipv4: Fix IPsec slowpath fragmentation
> problem"), the next iteration's fraggap =3D skb_prev->len - maxfraglen
> therefore inherits the whole bundle header length instead of the
> intended alignment slop.
> =

> fraggap is relayed into the next skb by skb_copy_and_csum_bits(), but
> the MSG_MORE (alloclen =3D mtu) and linear (alloclen =3D fraglen) branc=
hes
> account for fraggap in the allocation only for as long as datalen stays=

> uncapped.  Once datalen is capped at maxfraglen - fragheaderlen, the
> bytes copied into the fresh skb exceed the skb head allocation and run
> past the end of the buffer, corrupting skb_shared_info.  The
> paged-branch accounting of
> commit eca856950f7c ("ipv4: account for fraggap on the paged
> allocation path") relies on datalen accounting for fraggap, which
> stops being true exactly when datalen is capped.
> =

> Fix the root cause by reserving exthdrlen as headroom, like IPv6 has
> done since commit 1f85851e17b6 ("ipv6: fix incorrent ipv6 ipsec
> packet fragment") in 2012:
> =

> 	skb_reserve(skb, hh_len + exthdrlen);
> 	data =3D skb_put(skb, fraglen - pagedlen);
> 	skb_reset_network_header(skb);
> =

> With this, every fragment skb satisfies skb->len <=3D maxfraglen, so
> fraggap <=3D mtu - maxfraglen <=3D 7 (the alignment slop the relay was
> designed for) and the copy destination is provably in bounds.
> =

> Allocation sizes, tail positions, tailroom and truesize are unchanged
> (alloc_extra already carries exthdrlen), and when dst.header_len =3D=3D=
 0
> this is a literal no-op.
> =

> Fixes: 353e5c9abd90 ("ipv4: Fix IPsec slowpath fragmentation problem")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Anakin Zhang <tencentos_secure@tencent.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

On taking another look, it is easy to see that

- this only affects XFRM paths, and then only the first skb
- only data and len fields are affected
- data is still at the same location
