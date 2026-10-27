Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114809;
	b=23kbtM55h18FY2pO4C7smp7SOyVjq/zfqUh2O0tq+eU0y281q2AbZkoMs19mRRvyab59
	 D9kaIzw7PSFouiQDk8lLTZXBwBa3/q859PT5hq4oetjrp3GKT8QB2tBJqk+u8KmdOEhba
	 oEOPMCapKeunERMIjFtDeXRISgDoUS9RX8fTL3+zOp19TTECcTu/GnxSwoQV8X8SaKAxK
	 EsxGjwimYv1t3IHnwtDfKhZN593LLvxIoqYWL0wjywqjOMz3exsWsckEkFVChvvCyR94u
	 tLxK9YfR5m5UaD3+YcVdn2L6B4sKJVE+rX7m9mtciGavvYiTLoqx1/65KbK8895kkGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1tGy4+33uO/MaMkCs8SwEG7aM07D814jeQg5PdFcUYE=;
	b=ZGFr0CgJ4zFqs6OR4pJ2fqXfqOdkF5fZ1IMZ8nOdjK3S5ekhUIc3LG0tkILKlcFpb+e6
	 XCQiZo+cYUrolwJD8sWJczEVg8zoP2gGil6aSiPa1m5ChcatogRZFaPdDVk+GoVoHR0Yl
	 iiQnMJ7/7R71cLUd+pbDOC6YTTiaLyudbU1HPldACZgDou+Zmewrir0fEKB3FfNVnw9dL
	 5Olr1TTLX7knD8I9FIdDU2RUiRZEvaAjXWZqNsVI3bwonc1gs0BkE17Xmiswtjmjz3oT+
	 vtTm3N9hVVkXnG/i7wvNcb6XXP3AhbKhDBQ8sIDGoJBdYlcKM6VbWKoLIWZUKKiyNbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W+87aI1O;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629A606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B629A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W+87aI1O
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9906c85122cso24189241.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114807; x=1793719607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1tGy4+33uO/MaMkCs8SwEG7aM07D814jeQg5PdFcUYE=;
        b=W+87aI1OPlrMUG0L352mZwYpSj23/GcxekBOW6oN7CHP4kmO/9+wip96I/k6tM5PFF
         0j6yd2yYYOprqmYEgL7hWsuun3g+HftqA59gmEM1v37fqQAZb5VXPtmeASnF/XsxPivo
         UaJ6bODgG4InVOf9RsFMji/XWAojJnsliw2BEmh/cN8V6dqpfrnvv0m5pVK2VfukrXrZ
         9TjYhRxeyJ2fohYPyCY1PuZiQNbKxQu0UvwdbjW41/M6LrIirAVf46QpI7tosFSxrZrz
         KZIwIFkMDZxVpHeup9iLq5Kp5+MenR4UhdUbbvWIRR8dZgR23o3zwH1tgV6WrhqURG2O
         YCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114807; x=1793719607;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1tGy4+33uO/MaMkCs8SwEG7aM07D814jeQg5PdFcUYE=;
        b=j8TJQZOidYHUcRxIiZQpEkis6zQs5+C5P9nhbJpjaZaOTtwbvjrhQMRb4NoulPfVHW
         b/0oSkaExV6FP73ofuL0NzZTBrCRH3rq87zMJel6BjGcFVBtlam2zdcnHJleN08xTdjA
         3jFZcR8wL2agwzERztVbAzCJmup0JRBLH3ANQId6uBPMZqVtHCHv0JxSwbip3QVVt0IB
         XOLYHVRbzM7zhkDoCgQa78tn/q+67ufb+BiD4Reh92ONcxf0dpxRx/OkPvFMNDBEW9Kc
         1BYgan4EVTXjKy0i/Fg0N/NnkketGQooQERyjy47omAyXbBKrNTipx3FvGkn/LbPBvFq
         Snmw==
X-Forwarded-Encrypted: i=1; AKwUvBwNSpIAEayyVQ1numQAtMzLfNiAVxFVCo5kphYfwyuncEnzbi+1NWaBa6eFyegxr42JfV8M4hc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe1o5hbsoYY2rgHZRFwv9btigmiX3WrIX8I6LFwHhToHvj4A7T
	3g6c3RRh9RsEWNtp9d9CrXQ86HunznkuSvDnY++YLFXlhZgqG0v+9MY6
X-Gm-Gg: AYBFou2y0azAMj941+hIPWFM0exiGvnIqSxjkkAbt/ElliugQampZnGn3UXCTNIUVh4
	bMgO6RrfXUgYi8I0ZjsID3nkmMLbEobAOu6GXsJ/FIc/JuEwOJJYBLM5XB3NDtv95FBe16ZgjvP
	d5VNeQjp0UK81sX8MIU19qrifmY0yEgXcMa96mnhCR8RMu9GZyYwU6KQx9d51nlG23P9dAtPjFN
	F1ZcJbXyTtHAThH8S9YIZkyYA9+0PGw8yNOpx+DdMSwE+URg5OFO108i+JVY8FFdXCGmMUiSkem
	JidHvVpZemBcJq0tFnR+afWcIj70IxMu6ihYfs5e9LCKxPk/vwk15uiFQ4cfntHbWAhbmGujSO+
	OoJcOFtR1n09Q5B9mTRBGNC5/k4Mxj5qXMLQ1gtii8O1W4avUsycyg3ojLv1wjf5QpmX0i8XK0T
	xFXD786lhWUYbYcBStWAQ4dMaeTzRzWSxguD3NRMaJ7mafLe5u5Q0EMwDzh0ke7Lt+PypviNAj7
	OGUvWj+WnM8sbGu3nce9YFkyfqYjQ9zUed7LEPixcGFodcwwtXi1Lny6TOjAPn8thhHTzkKrvdh
	m1BlL05yzEUmbZdqNXp4Di5P9ylS/OQL67rEl3oUI99cwE74qzaJ3BiEj2xhvjixZwOges8n8Xb
	GfP+GtQj3zpVMklg+VD0=
X-Received: by 2002:a05:6102:5708:b0:7cc:26a8:e732 with SMTP id ada2fe7eead31-7ce5cd12376mr3424217137.20.1793114807291;
        Tue, 27 Oct 2026 08:26:47 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9912da2d9d1sm243498241.7.2026.10.27.08.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:26:46 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:26:46 -0400
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
 security@kernel.org, 
 steffen.klassert@secunet.com
Message-ID: <willemdebruijn.kernel.754d523a3a4@gmail.com>
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

LGTM on the general approach:

The XFRM inserted headers must only be inserted once on the first
fragment.

The same approach is already taken in IPv6. Though there the variable
is dst_exthdrlen, not to be confused with exthdrlen.

My main concern is that this code is notoriously fragile, with the
same variables used in different calculations / overlapping uses.

Writing past skb head is obviously bad. Ideally we could catch that
with a patch that is trivially reviewable for stable. Not sure that
exists. But I'm a little hesitant to send to stable something hard
to establish the correctness of.

I can definitely stare at it for longer to increase confidence.
Also Cc:ing the IPSec maintainer for an extra set of expert eyes.

> ---
>  net/ipv4/ip_output.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index eaa6fab..b84d56c 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1150,16 +1150,16 @@ alloc_new_skb:
>  			 */
>  			skb->ip_summed =3D csummode;
>  			skb->csum =3D 0;
> -			skb_reserve(skb, hh_len);
> +			skb_reserve(skb, hh_len + exthdrlen);
>  =

>  			/*
>  			 *	Find where to start putting bytes.
>  			 */
> -			data =3D skb_put(skb, fraglen + exthdrlen - pagedlen);
> -			skb_set_network_header(skb, exthdrlen);
> +			data =3D skb_put(skb, fraglen - pagedlen);
> +			skb_reset_network_header(skb);
>  			skb->transport_header =3D (skb->network_header +
>  						 fragheaderlen);
> -			data +=3D fragheaderlen + exthdrlen;
> +			data +=3D fragheaderlen;
>  =

>  			if (fraggap) {
>  				skb->csum =3D skb_copy_and_csum_bits(
> -- =

> 2.55.0
> =



