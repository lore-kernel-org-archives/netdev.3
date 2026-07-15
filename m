Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31D3ADBA4
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132156; cv=pass; b=gA60Hf0fIEhaDmq6rXZGt3nCTWX3386cSAjZyzJa69jz/X4Rjnm38/kpLSg0L0Eonz39u0KD63Li3OmWTRfpQ8G6mkwN/BKPPV58qcllFFBPEMkMqE+dH9ILulmgog1bhJzjMzCPvcHKcBNBF3g2SdenXQAP01fCQoPX50pvmHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132156; c=relaxed/simple;
	bh=FWxiQlTdycZ3hlyFTtfVocuTp0ZAD9+zUnnyMVWM3YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SM2YM0w51SXk0aS5ZgB6kCDPyAPav/LojAtQFOS+VC+7oKWWwktwCEq62egVmezR5sZ2U8aLy0UK1fuB6JuyA3aS1a114w6s7LUVsQAfYCk6N7OK6PMTzCG3KlkgGzvzxCGsMzqE0sc23LN/Ugl8WNwQu4zPHpeNCqtLqgGigqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJkCsuZ5; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJkCsuZ5"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1939704b3a.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 09:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784132153; cv=none;
        d=google.com; s=arc-20260327;
        b=nEgmv0+7GmMS48yvSS0m21rmIN0o5Lk4tlPxrJvYVTaL3eL0FY1/zlHI8k1TJ0lnvx
         CwfF3t0bxRqJPozTKJVwwAyaxlGx4PxmlBv4cQa2Zb+KODd8vR6VBN65fgeleREATgBR
         RQrmsa+8byUrUif/mhj5MxMx8M60oZuuGQRI7+VGB+Pb5QZQIRhoik6JQ7ahN1Y6/ffy
         uPl3Dx+IG8kNmhgzHGhJ1nnslJnRumFw95Nmm9GcUWpnrtSsRNIzJGykfq8mbc5KYonz
         GLJpdhw51EOlmEipv3nzmi3gg1KSYFkk1+LdhOfCLtOdr28DTbWzGsvxzsxEJSuqnBPK
         0tnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=55U5jPSUwP069w7ruvqo1At+jwtU2ebGa6t3Zfz+ez0=;
        fh=mpgUmGA42Z8y+ZvRyLMEYwnktuwL1vPDEDcBcS26sJE=;
        b=rer7u16h+6KtZaxTaQsIacTDP85Mmh6AZ3Xe1lE5pbmBYEdnI8oXdTm8iR37cV2Vrm
         oA4SRGgQ69dTod/rp18LQc3pfq8VE4Z9YtYWw8i0G9ph18xp73cHmqqpbEsqD3FUEQ1a
         I0a9qni2J5Z2pRPNKa08sqB7eKTaoKQTQoJP3tgVQQVFJ0JcITv7ZuqmVRjAGRPPFB2z
         0LX0yJk7IyQfGUM/xxvmw34GAqM1pfZt80row+GeRuVKTGxvFux9GNgzaOUq8k0Lp5KY
         DH0w16PqJlTPckTd1C+yisyJ/Xk6NKsdLSE3wVNpLNOOpi8w67fOYTnSLO5ZMrrPY1La
         NkpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132153; x=1784736953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=55U5jPSUwP069w7ruvqo1At+jwtU2ebGa6t3Zfz+ez0=;
        b=gJkCsuZ5UQVwFiaMjQHDwxGR11gsOHa8WB+CZdbI5DxcyZUWGLC2oUllK/RAyajXQz
         7Rsn3mRu3MxwEXIzjklOlkPHEuxqYmfKzl7TCp+UHNHSr49OUXtE6UBN7GerfWa5PgCg
         E0PAPA6sqPxbo/lg8ygU6bXyG06906yuoORwfzTpY6bPUc+w59QPRefinlTPCuYc1d+p
         6/2HOwYc6gcixegPEaZLsVUqUyKz6BX+VqP3q4j9wxA+YRSjlQSlwmYXnUZ8VKkXNUq6
         4xAeS7znJdgwoJMr6AA3M+kBktQSktWidp5ohAvUnR131kHyv3vRizpZ8MFUP7Zbk3ac
         pI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132153; x=1784736953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=55U5jPSUwP069w7ruvqo1At+jwtU2ebGa6t3Zfz+ez0=;
        b=mjUlsjFTIbtnN+Nv0fz8xLyyPWsArbcdUm3hMCj578kLfHFEMYZ6OInuHVA6Z6uaIy
         oEMPQs8aW7sZm0bkcZE6ST+reQ7C1WIkz3i6O9WTxOCe9YLqVafTbsmZUV/Uk4adcRK+
         XkhbFEDkqg8sRBP995TUPsnFNOkyx1IvWEyM92dU7f0IERJpsckiMsP0YEC56guDKtB3
         KBhNsXhIk0lG5RhWIstIzCkVDs4JmW+IQQNSxdEVLcEPvm25Ql6tmbKeodzIym22RmlH
         g1qEkoiIR4lbofvPbDpZxr1DaKWnpLKX9ANRsyGHm0Y3MVjj3RIf0EXwYTPEGAaIm8ly
         jOSg==
X-Forwarded-Encrypted: i=1; AHgh+RorVEs2HSTRIDRAV7Yit+UEEGlgDoAsT8AU5yNJ6Bg95h0CQ42726c+Jyj/VU0oSXyEay4KQLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTamGpT4uSwU4l0ZOgOnI4gnEbUSiu6pOjKCkwoJ93KjCd0izN
	J+SkQ9Qt7lY2Er3XczqrSS33KjTYxXGU9VBkYWThzG76m2BtoVEGBKItsXoCmYWLPeIeppiiMap
	w9WgdNBR0p236K95Vi2ln0NEVDmb0cSY=
X-Gm-Gg: AfdE7cmx7gNyywGXGJuNgf3qdJIKq4hfOyYlid3LgVeyQybd3f4rB5JKt/ikvXembRk
	622VJzK9UttpqV24HSwC7amhiYAWn4oBYpPmpN5JLb9+C5GV8F89Q/GkGwbFaVIFSR+uq25ZEiD
	KkQADUgWzvPJ4JzLJG2Q1MWkRQu/yPx14o/o3lC4aCuSxkPylDX1fawQxDSAjcryfBajESEja01
	rCE3uVk1QvaoyvkGz82pZmAtvLtGWhv75eL3s0d0l+ISpNXJp9IjnhAcDW52cDRYXRK/SaaZmFz
	mE1511oa0A0Cp8QxTz2zavmrFylFgKUSvNJi1QFu06XtXBgajWWz4E5OA8YewxZdBEqxbIRF
X-Received: by 2002:a05:6a00:27a5:b0:847:99bb:b6d0 with SMTP id
 d2e1a72fcca58-848896bf0bbmr16582991b3a.15.1784132153108; Wed, 15 Jul 2026
 09:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715033536.64963-1-omeux327@gmail.com>
In-Reply-To: <20260715033536.64963-1-omeux327@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 15 Jul 2026 12:15:40 -0400
X-Gm-Features: AUfX_mxyqRaNfNT_XTqID_5ulkJvqsCBG2mC6ONt8peeaiBkWktmOsu9fvIkJOc
Message-ID: <CADvbK_ew0KJjY5Ya64LTFgWastL34A7LNOBFqFjJUceGS+qHCA@mail.gmail.com>
Subject: Re: [PATCH] sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
To: MingXuan <omeux327@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 11:35=E2=80=AFPM MingXuan <omeux327@gmail.com> wrot=
e:
>
> inet_diag_msg_sctpladdrs_fill() copies sizeof(union sctp_addr) (28 bytes,
> the size of sockaddr_in6) from each sctp_sockaddr_entry.a into the netlin=
k
> INET_DIAG_LOCALS attribute and then only zeroes the bytes from offset 28 =
to
> sizeof(sockaddr_storage).  The same pattern is used by
> inet_diag_msg_sctpaddrs_fill() for INET_DIAG_PEERS.
>
> The IPv4 address-filling helpers sctp_v4_from_addr_param() and
> sctp_v4_from_skb() only initialize the sockaddr_in portion (16 bytes) of =
the
> union sctp_addr; the trailing 12 bytes (offset 16..27, the sockaddr_in6-o=
nly
> region) are left uninitialized.  Those bytes are propagated verbatim thro=
ugh
> sctp_add_bind_addr() (which copies sizeof(union sctp_addr)=3D28 bytes) an=
d then
> copied straight to userspace by the diag fill functions, leaking 12 bytes=
 of
> kernel stack residue per local/peer address to any process that can issue=
 a
> SOCK_DIAG_BY_FAMILY dump for IPPROTO_SCTP.
>
> Fix it by computing the actually-initialized length of the address from i=
ts
> sa_family (struct sockaddr_in for AF_INET, the whole union otherwise) and
> copying only that many bytes into an already-zeroed sockaddr_storage slot=
, so
> the uninitialized tail is never read and never reaches userspace.
>
> Fixes: 8f840e47f190cbe61a96945c13e9551048d42cef ("sctp: add the sctp_diag=
.c file")
> Cc: stable@vger.kernel.org
> Signed-off-by: MingXuan <omeux327@gmail.com>
> ---
>  net/sctp/diag.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index d758f5c3e06e..12557e924cc2 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -85,8 +85,12 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buf=
f *skb,
>         info =3D nla_data(attr);
>         rcu_read_lock();
>         list_for_each_entry_rcu(laddr, address_list, list) {
> -               memcpy(info, &laddr->a, sizeof(laddr->a));
> -               memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr=
->a));
> +               size_t addr_len =3D laddr->a.sa.sa_family =3D=3D AF_INET =
?
> +                                 sizeof(struct sockaddr_in) :
> +                                 sizeof(struct sockaddr_in6);
> +
> +               memset(info, 0, addrlen);
> +               memcpy(info, &laddr->a, addr_len);
>                 info +=3D addrlen;
>
>                 if (!--addrcnt)
> @@ -113,9 +117,12 @@ static int inet_diag_msg_sctpaddrs_fill(struct sk_bu=
ff *skb,
>         info =3D nla_data(attr);
>         list_for_each_entry(from, &asoc->peer.transport_addr_list,
>                             transports) {
> -               memcpy(info, &from->ipaddr, sizeof(from->ipaddr));
> -               memset(info + sizeof(from->ipaddr), 0,
> -                      addrlen - sizeof(from->ipaddr));
> +               size_t addr_len =3D from->ipaddr.sa.sa_family =3D=3D AF_I=
NET ?
> +                                 sizeof(struct sockaddr_in) :
> +                                 sizeof(struct sockaddr_in6);
> +
> +               memset(info, 0, addrlen);
> +               memcpy(info, &from->ipaddr, addr_len);
>                 info +=3D addrlen;
>         }
>
> --
> 2.50.1 (Apple Git-155)
>
Acked-by: Xin Long <lucien.xin@gmail.com>
