Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954467;
	b=d0qMSrdfDIQnkUGhayOmruSDXRakaQ5o+k/h2uxsPc1DdRa0qg+wlMA30wVoYzQsOcPE
	 7nLWMEUIlqd/fsZmDzQ3F02Uy8oOmn2krtd03EASfiTjKcgPTkZn2VUVB9DBDJ5+9EPeQ
	 aMhKjp5Rp3H2ftA/+ol5A7e//grvaOEqN9VGCcAEFM88m+Eu+IZp1qlUh1yBtAb55cB8B
	 rOEm7/f/5yV4ASy/YxHwXsXU/E0x6H1OIte0bBFB8OYcNhUKVZYSKnH/8uRa6QUmWMQ2Y
	 KeuzJJBGuJNIAHkR126Rkau8p28600Mmcqwzf+k/Acsw7tqC489Dn2Y/rv6uZif7+lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954467;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V/NE8i04XGGDBZHwLHKxl5naETcb1vdCKlMJnr5aX0A=;
	b=gb4sRM7RIDbu2dljT9KtPlsLJDHyQdzOApuBCr2ZqYgdv5Fm6VA459bci8R+U1d5HiMq
	 HJ3PyPQNAGAUTNqBMW/gbxMHkNJE6NCQrIzFM/a/edP0BrI912Y8Krjn2rwgHQBroTgaM
	 aaAwLcJDAmcKtSjV7KgJXl63HOXaOhklmBQsIupnSjCITE3RhN0M99C51eJqnvN1QypY6
	 uslWc8ow+Sl5mj92yjbHxjURZIYoqpebTwo2yIRMeyaekI4KgyABCBmXYB2ygm9QVYrVO
	 iz8FtU1/oB4a2UB0rpGyfcs8O0hl4UTlBVKgBDrD+Eq/IqfCmfvjnshj4ZOKt6NrM0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDiCSnYr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4C606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDiCSnYr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F91F008A4
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954467;
	bh=V/NE8i04XGGDBZHwLHKxl5naETcb1vdCKlMJnr5aX0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bDiCSnYr63y02vQdmq06M/fpcXlYIOMzEKXawyY07jU3a64GhkHpyrN25DT4Va7Bw
	 bRQ7rYUIPevXM/xXMRPKrmzLo7eYbDW15N6PGsqmhZnM+0KrQExSnJEUeTaQKtdAGv
	 Hb5ffZdXymurXDJTaRQMdYSk21LXw4pXR1p3DtiTh3L5CefC5nnKqFAY40OR4OPfXB
	 cTreiFgwMDUPdXjyS16KOuLUNhARLNlLc46F/dQwVGAjDHPchub2HyjpUN1MpxPjD6
	 tXdyF2AL24YA9KjOn9xC3n7uvQv9wYPkKTEeaGvYOfofn+pzw3uMkv3iK2JU1OpE9M
	 n/Ox1/UnFSkfw==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4f55a53898cso182178b6e.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 00:41:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzB1hUEH6T5cqiaeoh5tZk/t+bygXxoSEAGROfrkrQW6FoUrqBmsJ1gntkRk40PnSUQOAoyveA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0ffdoTLe7n+4R6uh3Y7mAv8b0ff+RaZgjzuIt/OnoAuAEbl1E
	4NwodaXu2By+QiVaI1Qv73Htw4b3nrGvLm4g9Q++QTNZl0QzSATKPtyJ4Y8fO7ix8zxYU3SJml7
	okTeHO0E2OzhScva2Y93AI8Y9uiSPFPQ=
X-Received: by 2002:a05:6808:15a5:b0:55c:928:69d1 with SMTP id
 5614622812f47-567e16594e8mr1161490b6e.56.1793954466385; Fri, 06 Nov 2026
 00:41:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105164830.1682714-1-edumazet@kernel.org> <af79b34f-a941-4d0d-adbf-fe30a09c20d7@linux.dev>
 <CAL4WiiqxeZSZWSKkK6qcA=U1haTCoCakEKYatYf0i7mB-CdXTA@mail.gmail.com>
In-Reply-To: <CAL4WiiqxeZSZWSKkK6qcA=U1haTCoCakEKYatYf0i7mB-CdXTA@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 09:40:55 +0100
X-Gmail-Original-Message-ID: <CAL4WiipSczMAqpkxm0GQ2QLqi1kgkoheLM0+5QhAuBOOd=krWg@mail.gmail.com>
X-Gm-Features: AclHuK-XaBSRE1j5mz-WAmw9EKZn4lB1ENNX2ol9LDRp71Y0xPgdHMJVIHLcm7o
Message-ID: <CAL4WiipSczMAqpkxm0GQ2QLqi1kgkoheLM0+5QhAuBOOd=krWg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not resurrect a former listener with SO_ATTACH_REUSEPORT_[CE]BPF
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 09:10, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :
>
> Le ven. 6 nov. 2026 =C3=A0 07:44, Jiayuan Chen <jiayuan.chen@linux.dev> a=
 =C3=A9crit :

> > I think sk_is_tcp() is better. raw socket still can reach here and inet=
_csk(sk) is invalid.
>
> Yes sashiko reported that. And had the same 'suggestion'.
>
> https://sashiko.dev/#/patchset/20261105164830.1682714-1-edumazet%40kernel=
.org
>
> SO_ATTACH_REUSEPORT_[CE]BPF does not make any sense for anything other
> than TCP or UDP.
>
> I can switch to sk_is_tcp() for net tree, and perform the real fix in net=
-next.

I forgot:

pw-bot: cr
