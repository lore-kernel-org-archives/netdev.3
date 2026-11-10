Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794324709;
	b=T7SWUEPVxGYCZIubqbF9TlHPOTCjyxuQXT9xLV4XmRhQf1yGfFnb1u0/dnFBo+YMltFT
	 YctQLT6yjkP2J6RyxKHOX1DMKNbMUDOf5wQoiDtnPuayurt5fuaFq9LtcYhOqJy8hmieG
	 S09mFDDC/hrcESBFoekRyWxn1oQ0wOgIU36rcb5M0RaoCpZUQerv+FUStyszcFjTV9BRM
	 HpM3y68z+EKXpjX5gPjUNe13OqZYSHSES+he8HrVvymjrpDsEY/87ZShAJIzGfmg+6dJV
	 AYB1J2uzF5S2VkIOSSDvuy7EiDLdBvmUCgqz+R9bBpjzC4GoFGF9IJFrwlceDS6SQsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K1/d2NyIuCP6NUn/LZuS44tPxEN2bj+/f16ojUcHMk4=;
	b=hpUgVfxOKtoHIJV4T2qCfzKFKR8unqXpF8Vyh1bvECovUHNxXgSzI9UL4x6qQAbq8Uv2
	 Vb0fczFHTsr3Ue2IlwZxBzs2xWrETEDNk8Mi5Xb6gcQmdwkpEBtkkhQJAaz3jOzkUp8Yf
	 yh2wicclovWCVAEKpDh3a0nAkd6ZD/kUe0z1v9KtC0jJJhfDKWLgbWEUx5ogvpqutxQms
	 AMpNWfTF8aTDH+paqDiSKwvkYOkEJ5iCjeI9/sS9HU2yXaiRG4jHmjrbQSi4d8AN6C94V
	 sWnH2NFrAN66lXgXH4fNE57B3RxX0tZ4+gZBxVD5UHhxQVWKALWGOM+OOceXzNgkpuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sOnALV4R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2960A261D
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2E2960A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sOnALV4R
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2dc9a7b52so1173804137.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 07:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794324708; cv=none;
        d=google.com; s=arc-20260327;
        b=LJCS8KaN4nAttT2RMkTN1dMGNuQRamZoccz2Aq38/graCAfr0EifMJiJQeem56SVm0
         wtXvu2TiE7IWnJjOvHRxX0Ns2RJVaHpPl1xFGLt79wrabDe9Vjy49sVpkHiH42P9YUlv
         +u04ePc1YYAVXFwXtNCbKgoOmDbR8sBsrc70DRqJGpShd9ETdyUvAPIATY/Pzn4/rGD9
         UV5rE+AoP3ikNvri/0DxT+pdPWYx/djOUmPMjF8NsfLjkY95qdlbx9PU9+pRbtAf9EXV
         yCkTu4MaBGpNWBgJazv+9vhUO6upeoM8duSurCd7tK2B2307BROvrn810GJbDHKu4NV4
         wejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K1/d2NyIuCP6NUn/LZuS44tPxEN2bj+/f16ojUcHMk4=;
        fh=54G8zaY9GdOdccVNod0zIgsABYS0R2X/IHnWcRheuFQ=;
        b=Fw1jVA2peZuGx+pOUyKzW0esYie4zX3c4PJBOyZtvCasnYwhkcpE7vX3qZp7irgpBz
         XNTgySo1CtIU2IgZ3Zo1eA9VwlsIPiFeZy1LRbOVGPszi6jrNs71ZYXDRqgnzIPLP0br
         SGQG0ggFVTeG5KD37I9o7UkGCbWtU2nGVj3R6imzX9aJ5Gi013OeyLo/J1p8LzBYEl43
         /Mvr2N6XOCCB89lQqNv5GARXvOk2QsU7rWsFxcgn1TVBbNa44e8QAgdapL2/O+SyCaA3
         sPa1pQkfCGHvmU2qjmmhQ6ZRGG0uhLv5FkfBvr1tLcM8hYgF/hHkPG4I3/TC8qHAwZfH
         YVvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324708; x=1794929508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K1/d2NyIuCP6NUn/LZuS44tPxEN2bj+/f16ojUcHMk4=;
        b=sOnALV4RabTW7TXx7rjmDTNsf5tHHAYmUXJwgfUDq5UM5W3BHjN5iBQXvAvIlZdHDT
         RunsTaxFGOmPsBVI/UWUQRUU61lGTeSOTV7Ls4oDevMfljfbDaejNb2p5o/je/oUzQVN
         ODiTECjiawd9dA5ApJKl1GPG+snrlUdzTJMDx8+vzHyuEIH8h5PdZF+FRvrol+Yj/3gJ
         vRHo4q1oHwQ11AsQGydfRlFpUdIMf33G3Tui7lBp/+FbxkDoWkLiGS2AisC+jeSvVL+J
         uMeijdhrcOXb3WUOVkGaNpFRye90vYvFGNsOPsPzp+zSZMQDurT6HH2hkHYZo/OmfCgj
         omvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324708; x=1794929508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1/d2NyIuCP6NUn/LZuS44tPxEN2bj+/f16ojUcHMk4=;
        b=Tu5oc/JE3dEDlZ9yB8P7QKcZyScvXFMANpw7J56GwENFVXw4eoVfdZlayDzbKj2t/d
         jLwsPi2gWNQqEtMp28tU1WvoVQgh/a6kJTPR3q65uLl244QstkIyI98sDZD3991Ve441
         oySAm8BS+CACYcONKUxp+iR184W9hW55o6cPZcr+GsSPYt4GNetdK98YeXnrcR4s+YkX
         bxpBDC3Gilu4/TdKI8mr+UXHZZyof+CLbE98q1AoibMO17Cuu/hnDAhkKUQZl3D+ZdSl
         L2dboYOrq3brnoGT43KVifLQ0H8nL3GENlEM2rcywzgsa5rZLpDiDFmQcnncSXvh6l0B
         2sbA==
X-Forwarded-Encrypted: i=1; AL+hErG5y6VTVyI87xCvJ1pDPxG564aQfVcO2Jdsc4NM6MepGnJYu0ERpnXAfj6WsKCobB1ShIvD+00=@vger.kernel.org
X-Gm-Message-State: APuU4Z8S5w9xBK/u/isWfvxk9XEPe0HyXQV1/kQuyjckjRUQebQtErIs
	P2XI7vLqLbVUKv0I77tD+1VlETBuZhRY4BmEbrElqbmK2d0RHJhPemz+BWD3fB3bWP/w/vk1DWq
	GQ/1zW6HRjZJYhjpWnJylo8HVtf+gH6M=
X-Gm-Gg: AYBFou1dQPsZOuHB9vqbIo4wbp+FllhAvNGvxFH2eGjMWomdjMnXOgsyidHNp4pf4IT
	mu5llynlOgpRkdTYsLLffvnsriBgmcjfzouFjxaEKnLzWfVG7/lV1OtsAsHbMGs4EJRkH9FSZ1B
	zp7uQfA/aJQEsW3y5RLEFR3JiNl8/NAQd6JqBgpqdLk2aE8gcRQSZm4pz1V1hX9nOmWDPXy1yXj
	Y+h2vRfe6o4k51tYsicAzIvfMcc/f6qH0lFFJ3TA2WkS7mldCEeCw+vf6zbotIvAnztefcpDFcp
	wNDUuTKOJakas4VpN/cmZxrFKb/0bcfSphscdmymGEyEXsWdZuvFP9TbarbOw+InZeeOFXtqUxJ
	6I4ItusXvlhSex17IyewAJlW1SSX+VOyaT1ifWdBpaUrxGhZTY/8LuPedpJhuRSmLh186Xk7yB1
	CdlA5RFpuRVxNdVsU4sLKGmVBdOUwzyURotnZvzQ==
X-Received: by 2002:a05:6102:1629:b0:7a7:19aa:8a88 with SMTP id
 ada2fe7eead31-7d301c1ac50mr1147212137.35.1794324707817; Tue, 10 Nov 2026
 07:31:47 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108161149.2774119-1-bestswngs@gmail.com>
In-Reply-To: <20261108161149.2774119-1-bestswngs@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 10 Nov 2026 10:31:35 -0500
X-Gm-Features: AclHuK9iYVUMVhjgMP1YORbw_EmIVcS02-pRhlLXyvezE7vMUFhkCvMgT7r-RmU
Message-ID: <CADvbK_fGfv2k5rB1Q4Q-OwzJicXbKzs1ofW48F2prx6Z15CQZg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: reset stored flag for each association
To: Weiming Shi <bestswngs@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wei Yongjun <yjwei@cn.fujitsu.com>, 
	Michio Honda <micchie@sfc.wide.ad.jp>, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 11:12=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> sctp_send_asconf_del_ip() walks every association on an endpoint. The
> stored flag records that the current association took the single-homed
> deferral path and therefore did not allocate an ASCONF chunk. It is
> currently scoped to the whole function. Once one association sets it,
> later eligible multihomed associations allocate chunks but skip
> sctp_send_asconf(), leaking each chunk and its skb.
>
> Reset stored for every association so only an association taking the
> deferral path skips transmission. In an A/B kmemleak test, the
> vulnerable kernel reported 210 leaked objects from this call path and the
> fixed kernel reported none.
>
> Cc: stable@vger.kernel.org
> Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host=
")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index c7b9e325ec1c..ed91ceff45a9 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -771,7 +771,6 @@ static int sctp_send_asconf_del_ip(struct sock       =
       *sk,
>         struct sctp_sockaddr_entry *saddr;
>         int                     i;
>         int                     retval =3D 0;
> -       int                     stored =3D 0;
>
>         chunk =3D NULL;
>         sp =3D sctp_sk(sk);
> @@ -784,6 +783,7 @@ static int sctp_send_asconf_del_ip(struct sock       =
       *sk,
>                  __func__, sk, addrs, addrcnt);
>
>         list_for_each_entry(asoc, &ep->asocs, asocs) {
> +               int stored =3D 0;
>
>                 if (!asoc->peer.asconf_capable)
>                         continue;
> --
> 2.56.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>
