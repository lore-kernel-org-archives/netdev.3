Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933500;
	b=lYl4El0MvQGN6/mYo7miMH6syyPiincMaFKdbKnY5Q2MR5UrMJl5LDK4gOXtXhvMiMAn
	 7oh42Yc5CpxftGyy6I5LEI3SZAqC6UnOTeMPPUGYS6EAJ/dY5f5s9ODpQ5vHDDCLfzYAC
	 J9iwJk88O7O1tO30elmY0v3vdICTYxqr7Pa77KaK1ebtGEpV7MICzyRji0ho5uqDLNKzO
	 wJ7Kai45PcsepUZjGooY+ECUbX7l2rls9Y9D70sGn5cHLNuvu8KBcnQLAyVrvdZLaJY57
	 i7BlVb1AkWO2fa8WFP9Ny74K10DQPnY4QQqCHhEJWS/djxAfEV1WkZBHxBn/lPvL12A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C4YKO6ifCvG670/AtfKy+sKSzMH1iQMMQOHq83vJaQY=;
	b=GG9vLvY3c8yZHM3y/s7smCTLzd2OtEJnSt5+r5SXK9M966hxwWVbTnT44MxkMXtsoRLa
	 vk/EVNMmV3gOGBjMxop33XTQsYCQikENyFqUH3UqftSTSJHSmYWDlHyui1F/d8Fnq70NX
	 sKo7NDezS22dlSPsVPYZL/gBTKpRCMfx22ji6qzHIQYiDHojhVbcxAC8WDRcXTVcbuFKP
	 oTfQa3WUElFr//sswM/h0anyRQefqoOfzVZjrTNfdHLWR8NnstLjUREOG297aQyKv0bxB
	 LKMZGjEWMigWyd+tKLBlasrmeh9fba4DPVsry2fuCNS4pdu4LtUsC8L/Xmr3qRzsJcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhFcBwWj;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF2606A31B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 02:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4BF2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhFcBwWj
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-77bf892b496so83098137.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 18:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793933499; x=1794538299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C4YKO6ifCvG670/AtfKy+sKSzMH1iQMMQOHq83vJaQY=;
        b=xhFcBwWjS4HqafxaONQ7+8hoecwIizKVadRymVGlIE2lGD1bXqih5Wexq0npneCZ/t
         E+yxAyS/ApEV1zvgakQ0d4r2cREz4SCssltufK98oeIheG91vDtvayGZfIYOqtviVEyW
         EjMWl+v0xLSMyi/XBftGgfCiWfKpPEunloijI2b1Fyraku4fJm2UjKDmfPT2InTImthv
         2hATAPOFyFtqYF+paljdZ1K4cZNvpXZZEm0JcM5aagBt+WUv2JBaIL+H3J8XKu2E1i6P
         IlScCKiZORvOQ7Wr+vdedsjvweHf5kJAiflrOWyiLzLVlyGrXfJknikZG37Z/8aEvp86
         8Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793933499; x=1794538299;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4YKO6ifCvG670/AtfKy+sKSzMH1iQMMQOHq83vJaQY=;
        b=AL+X2xjabsXKVWXGl0woSiyzZKjAGccVscK5HrVbCVFqsKPY/8fJ65ftdQ7IqviSy+
         o68c4Pm1WcHKCQK25PADi01IZJf0PJQy0TT9kbGsKVUcLJmYfkYT10KPjv92o2l7laFQ
         c+s3f7h3b+4Dc2w+R03T/QqpsMYQyxHp5IRDndN8Rys/X7Ekd+eLfJV9UOXfA9wG5M8A
         3TpH5pbGSPrZVsXd+etNIRwdehctMNBQdHro94KzTm/s3WzblhWCSi/2rWN4Y41f7mFD
         vUMYJwbb45FKs78XPtQfsgLky3j1eOUjo8Cp7GGt61eLq0WjivDONeMVvtiEV2lwyLbs
         1lmg==
X-Forwarded-Encrypted: i=1; AKwUvBzBDFjAiM4nzACjZi14VOZoAdIJEo+WQ/FrCvbAvg8yUnW4W9MaL3zOMRDeT2U38g+nqXkEcxc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/a0SkPNDqSYAxxcNRC4IcaLQCqJ8XgRfo1aaEY2LvHRXso0pQs
	nqtrHJo+rZrmYtSKrDCXBEcIzXqarxV2tsyN/Z2mTzIRCe+eNbMHe09Y
X-Gm-Gg: AYBFou1INZW7aqlXYYN9wL8i6songmtehODeyx1eCJ/0mMQ4Hckj1F7vWpnLUT0+t8e
	HqUYmXkfrkM/8kipCL9/P2ReEyZ7Jl58Mvj1YXJO0lJ4Uz09S5eKtVWRbqlhC62GY6tOMgzHUfl
	4g04XbBs3SQNrTfjc/h9ni6whLi+N28DLQYhcA5Xv2Ety+i5uhyGTZ+xcxz/HeuP8NETFXALnD6
	vqFZhj6V+RaoeUywHr+yf0r5Y0JbnP0cJ6tPC6uWVOnsFcZOzJ36Oy+gGrLFiZMgKxeJEgp8rho
	UTv7sfMjs7RkOsTkXeXI4BJle/eLHKhmDUr17GrwRsYGzfVkEKgElzh92ToLITlaMhVN1ZGae48
	OcowwhNvONkV0L0EBUsJTXjw77QP4MAfYcH/mlMv+f93gIusCyAhB4qj3T/MhiHK8XHKPvVrPfj
	wiN1X6qrtcKSk+4Blaz2Cl7lv2SZEf5Ng0Ic4ioE3rOPOz5nDvaGGLhZmYcbcmSkr2y0JN3Ldb3
	WqUDI2aMNYmInPWROGTTdjbVyDlWNIBWW8leThtEwBfV80XGkQXeNJhrQI1vDr56/k3ExyHWmkW
	u/dCHGqh2hI/Z5KsdBUoeunZPHhKzRAR21zyazk+6V96mU+c8xKMCHGkVqpwYw6qcNLpZOWxXtR
	M0Q6TpH/uTbvTHNKu5ZoPRMXwP+waejksugYzXSNJEBJVD4qPvRY5N2aYWfeDMzq1pAh0+dY=
X-Received: by 2002:a05:6102:dc9:b0:7cc:9d82:ae17 with SMTP id ada2fe7eead31-7d2a1521b83mr797725137.11.1793933498749;
        Thu, 05 Nov 2026 18:51:38 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99bab48abe0sm864033241.2.2026.11.05.18.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 18:51:37 -0800 (PST)
Date: Thu, 05 Nov 2026 21:51:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1PlronlhajlhazlhbHpgq7nrrEp?= <tencentos_secure@tencent.com>, 
 netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Steffen Klassert <klassert@kernel.org>, 
 steffen.klassert@secunet.com, 
 Eric Dumazet <edumazet@kernel.org>
Message-ID: <willemdebruijn.kernel.20f8423db92c4@gmail.com>
In-Reply-To: <306E09760B4212AC+ipv4.6d58afc075934322860394a26ceaa2e8.2@tencent.com>
References: <ipv4.6d58afc075934322860394a26ceaa2e8.0@tencent.com>
 <306E09760B4212AC+ipv4.6d58afc075934322860394a26ceaa2e8.2@tencent.com>
Subject: Re: [PATCH net v2 2/2] net/ipv4: reject appends with negative
 fragment copy
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
> __ip_append_data() caps datalen at maxfraglen - fragheaderlen when more=

> fragments are needed, and later computes
> =

> 	copy =3D datalen - transhdrlen - fraggap - pagedlen;
> =

> If transhdrlen + fraggap exceeds datalen, copy goes negative in the
> non-paged allocation branches, where pagedlen is zero, invalidating
> the offset/length accounting. In the paged allocation branch,
> pagedlen =3D datalen - transhdrlen - fraggap wraps unsigned instead.
> The subsequent copy calculation cancels to zero, so checking copy
> alone does not catch this invalid fragment geometry.
> =

> This is reachable independently of the xfrm fraggap bug fixed by the
> preceding patch. icmp_timestamp() passes a 20-byte transport header.
> With a small MTU and IPv4 options, the capped datalen can be smaller
> than that header even when fraggap is zero. The negative copy then
> propagates a negative offset into icmp_glue_bits(), and a timestamp
> reply with corrupted timestamp fields can be emitted.
> =

> For example, with MTU 68 and 40 bytes of IPv4 options, fragheaderlen
> is 60, maxfraglen is 68, datalen is capped at 8, and fraggap is zero,
> so the 20-byte transport header cannot fit.
> =

> Reject this geometry before allocation with -EINVAL, covering all three=

> alloclen branches and matching the existing __ip6_append_data() guard.
> A negative copy cannot produce a valid append, so this does not reject =
a
> send that could otherwise construct a correct packet. All callers flush=

> the cork on append error, and returning -EINVAL in mid-cork state alrea=
dy
> happens in this function (MSG_ZEROCOPY ubuf mismatch).
> =

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anakin Zhang <tencentos_secure@tencent.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> v2:
> - Document the independently reachable ICMP Timestamp corruption path.
> - Distinguish negative copy in non-paged allocation branches from
>   unsigned pagedlen wrap in the paged allocation branch.
> - Update the subject and Fixes tag accordingly.
> - Drop the unrelated xfrm Reported-by tag; no code changes.
> =

>  net/ipv4/ip_output.c | 5 +++++
>  1 file changed, 5 insertions(+)
> =

> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index b84d56c..5db8b06 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1105,6 +1105,11 @@ alloc_new_skb:
>  			fraglen =3D datalen + fragheaderlen;
>  			pagedlen =3D 0;
>  =

> +			if (unlikely(transhdrlen + fraggap > datalen)) {
> +				err =3D -EINVAL;

nit: EMSGSIZE might be better

> +				goto error;
> +			}
> +


