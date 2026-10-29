Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793283718;
	b=GRU/6IH3DhN6dfEbZQ78m5biSz0Hy0bVn+QpnvgwfyLa3MHy+OzYksRmQvpAv9Gx5ImY
	 8EVnEBtVttsswV4s122CtvcVmZltUJJ286E2+BGnupH3o1rcDL3dLsYQzVq7qB1EparRo
	 fr4cozK5EpHpQrAKoZ/spe5Y/nbKPScvrRddLCKYaCWMLJQYoqLy/f7omolxj8uXzHmD5
	 KlQs8k+5fegBZoVHbR3+7otsuvQyDE3R08t8hv0kR6uE9Il4ycpe6NOn2HmOzYNQsxeR9
	 hFqV0I33IWrALNXko7HV+BlML9gjKNRqnXaymm2fjxp0TDhLxWIjaUJekgPZzoWMzEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z6YKwRi3x4Q8Z+CbubbbAyVrPI0QntEbeiOQrTl5ii0=;
	b=fu+r9h/WxDmnkOPMXLjBwdQ/XdU/lzvnD494I630ha36818XMqFVMOS7NbAKGh9tX+wu
	 eYAD1yKpZhc0nRPudPKOtEcuvcgonMoStZ0VlqTv9u/WUrnbzNALWxCr41/m/P/9pgr4S
	 90Bj04p/yyDDxRJzcTRogleFGHDud7n4PHLzJtGlbXgkn4iNm7zu2f+XqYb1UlqafPNBv
	 Icwvna2+3QfVlXcv6CucXXI44m6b71kGSXP9hHCfPN5Rx5NGU0tYreJfjYmptye5krgic
	 F0elEAEIcxMQxRxW4slBr/4MKBXPMSVxoTGZrb8peEeekdKnt+5vaTosdv9vHfCBlJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OLPDLgrG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478F606A321
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D478F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OLPDLgrG
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ba328513b9so2362192e87.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793283716; cv=none;
        d=google.com; s=arc-20260327;
        b=Rr+GwBgUKwhpo6/GrloUazmHCwaMmCXsoNjd84eYl2vHRaNl7nT0PxFNxFyIgKYXRg
         NUweYX8BtjHkl8oB5C7bB0HNTJ6nHZgu/pgKgsUIz6wAV6yEwuCC9UqzJgYv1Yi+AHPQ
         akTWhc//2JGZytPAF7KzC4L68PW/mLWlnQ/LVpkpaOY68IgCRjAJ30sM94JqxzVrmhz0
         ZIY4YwUJ6SlE0xDK3Qt6ANgtMUJOMXjsgEgO0jh4G5hmNP9+a2BYt+ZThzyfMLQZEzj5
         FVMGWZ50hewh3hIyap/MQr1iXrlSuBZjaJBxlCLx7AwOtjupAoSQfoSZxxZsEceqMSY1
         ghDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z6YKwRi3x4Q8Z+CbubbbAyVrPI0QntEbeiOQrTl5ii0=;
        fh=LAY2xIjCEA9sL0VFy6WzZNg9hAv8+f7+w+CgsDxLaoQ=;
        b=SQGiSaPIZMyZkdGlUrJ08JfRFHuat2KKNAbooskGbr83PB+xOJ6nr9jVP1dgMd1fdE
         jl5kTsePY8bM1opPEjkMsChWxoewqWo1tA8E4JZ0CI4Z1g38qol1Bzq5XBPXYJZWh0ya
         LLAAdk5lefkM4c87jX9jXeb7Gc/vBmy8NsNfbOmfmRs0yTY7NQyFpKsSLsNxvYlYY4tC
         bRMeyE9YlqZ5YuWyK2vP9TN9+ahmicqu0fL/nNQXZXvf7Jb8HjjU2ecnY1Q+EKzIwM4x
         cw3CzGgfXvnufcLfMiig5hv3J8Op1saRuASJ5K7XrbTNgnzi0vnOUBEMrHP6jPLccyd/
         UKhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793283716; x=1793888516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z6YKwRi3x4Q8Z+CbubbbAyVrPI0QntEbeiOQrTl5ii0=;
        b=OLPDLgrGYc1U16av2X0ZoRPMooUDBR6f/OSLKvuzzwHCpHwxXc/K95dtI3pT/Cq2Wn
         r3ngFUyHmp3pKeK2aQStGesucYK+b8QRyTcBVi9toAOaX/CsYS1d4UHoE8P+HwtjLDd+
         Q4Gpt0xDvAQRaEWkRzl+weIESQPpmHe0hIQ/8eC8nAjMq8LWpTUi2hBZA9n/cA5VdMW/
         gDKTrsjRcJRkQhGJwYGw+rpfhqIOuCNXZ0qVgZuSU7q2eXnWUnuQnw+2spkLm/dGfCOr
         URwszREI1BcMSaSMPAyXYgio0a94EQAyyfPxFIotkcyAEEdvvZxdTw8yEXpvu5AmiCcm
         mD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283716; x=1793888516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6YKwRi3x4Q8Z+CbubbbAyVrPI0QntEbeiOQrTl5ii0=;
        b=t4wv4Y2QKmL+4WZsyr3Idj677ZQ+fgPi3JYoeH2ciNV0GGLFExEN9UkAFVlSPay59N
         iuH2UZRzdsZXj9yrCwkOWMI8buBZMzcAzHx1xiyyODySwQmJMZlV1IPt9pR9qRxgflv1
         bWUD4CyKqkPJMB0FrwwJGOuBc9KE4iALKimRVp7ZJnTO93+5sLL/aS26HyIUhB552/VI
         8I9soltvV2Nwm/FM+fCtp3T597lQ5qTbaByLpkcUyucPtpjxHhxv7QOL8Lh+PmtS9AHS
         SiKr96lyy/uTY/HgiT1FXWDfHYcG3UjOdpJ1PvTJKA6Gz+v26dzP/8tqbkv1+t6gxM1f
         5hTQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1pj/ILg4Abo1i/c+EUnNK6DXRmA64Mep0gaXDdStu55dRFOrPOIeJZyHtlD2AtNPp+NZXCmk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ40PPB1a+Zi1Qz3YPiqWWVi7UMNy31aloAlxAGjuvWGMKlOoDo
	IJHmyIJnWShXHUkEt0+UYwzKnKmyymVguzk7OePGuyohDYxaRrFuiY/A5WnuaZfpsOcKFNqfx30
	VB+Fyt5tptsEBRup9GR9iy5oWGRxw02p0BjwH3Qxo
X-Gm-Gg: AYBFou2lOhK6dn5n3wVABymVtvkUhDgPZ9fDXj+oFFnXrdN/qapbcXLztV3IZGX/FQX
	Hu+PXY68pYvD+eJs8UL9bXuHs3uc+Kw1lcBxRArLocKq3j8vlVkLJS/hrD4xRCa4+d2x0w6tovJ
	jl1ZO8onFsW8mRltZfwRSHIzzhW52uhbEB1egAaP/964YwhImNubgNJl3yeFaRo0l9Lh0FmLb51
	Nl9bjMzPXW02EzilkR1ev4ckZLUx7E8VxjflckQVDOdrQPY8+e1BM5gvoSL6tWvY8rKub8q+z98
	nPWMgNVEcBhe8LNbobyW9fqoA3+2CD6mUx25kEM15becFJxy32/xvsKsXdUolUa0M4CBt2YoUjO
	/ICOC/upctTYtHqf50DidHcigbi9forcBX9u8lr9gtANXUBjEogiyDx8fsgz8TQgZ41hKvKFzYb
	CDFU2Texu/JKwz1Y9ryQpdIGMGoA/CmlVZUoUMLdCxplhn9ID9QVnE/hhd37WOh8PNmIUTPxYYK
	wxbYQCQJvpx5SND
X-Received: by 2002:a05:6512:3da6:b0:5b8:f4d4:7ff4 with SMTP id
 2adb3069b0e04-5bfcad66d6bmr1953612e87.53.1793283715257; Thu, 29 Oct 2026
 07:21:55 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <v2-20261026-cover@tencent.com> <589B4474E0A78486+v2-20261026-p1@tencent.com>
 <willemdebruijn.kernel.754d523a3a4@gmail.com> <ipv4-fraggap-review-p1.5c53816d985b45c391671df3826be282@tencent.com>
In-Reply-To: <ipv4-fraggap-review-p1.5c53816d985b45c391671df3826be282@tencent.com>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 29 Oct 2026 10:21:15 -0400
X-Gm-Features: AclHuK-hf48fNUv52ynN4bn-fezuuHNYVFQbivwsVDAh9GcqQOViTR2leNin5Ps
Message-ID: <CA+FuTSd+ZQB==2kCqvdhQmwPy4QQGwYx36o7zECNxQtkQn6oUQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/ipv4: reserve exthdrlen as headroom instead
 of counting it in skb->len
To: =?UTF-8?B?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1PlronlhajlhazlhbHpgq7nrrEp?= <tencentos_secure@tencent.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Steffen Klassert <klassert@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, security@kernel.org, steffen.klassert@secunet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 4:33=E2=80=AFAM tencentos_secure(TencentOS=E5=AE=89=
=E5=85=A8=E5=85=AC=E5=85=B1=E9=82=AE=E7=AE=B1)
<tencentos_secure@tencent.com> wrote:
>
> Thanks for reviewing this and involving the IPsec maintainer.
> I understand the concern about stable backports.
>
> For the same inputs to the skb setup block, the allocation request
> is unchanged, and the tail offset is equal before and after:
>
>   hh_len + (fraglen + exthdrlen - pagedlen)
>   =3D=3D (hh_len + exthdrlen) + (fraglen - pagedlen)
>
> The network and transport header offsets from skb->head are also
> unchanged. The initial pull in __ip_make_skb() becomes unnecessary
> because skb->data already points to the network header.
>
> These are local layout checks, not a proof that the change is
> semantically neutral:

But very helpul in reasoning about the risk of side-effects, thanks.

> skb->len intentionally excludes the reserved
> space, which changes the subsequent fragmentation calculations.
>
> Also, my claim that every skb has len <=3D maxfraglen was too strong:
> an skb can reach mtu, which may exceed maxfraglen. I will correct
> that wording in the next revision.
>
> Understood on IPv6: the corresponding variable is dst_exthdrlen.
> I'll wait for the additional review before respinning.

I'd love to see my eyes on this. But unless anyone responds, let's
move forward.

The series has been listed as changes requested in patchwork now,
so a new revision will indeed be needed.
