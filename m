Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515223;
	b=ECD+tnyrrt7PhElpoMbZ9myfcLL3S1l3HZiLH/M7Lmsig2lcq96byy5BLW1Au9bBkHZS
	 dGdWHv3EQkVucg7sB+VdYv9yaM5tPFXphe/GKzJVN6Io/2dLTR/k+/ek73f4fQwaexy0L
	 b15YVSsR3e4hLVVa09rx2fL+Srj/UhOKXuYCmhbPKxu/rY9qfnwhLrUNzWFDjhNECyLAp
	 ZVUEZjFLpkv6kw5i9A5eZp8xefrrI2rmytHU6Vt7QgRcutxCpDf13s/050sI6b+iJc3cO
	 rmX2K4cXURZb5m0m/lvDlczxSXHrrC3wISksQkHvGNkzyXYabTQbtbIOXR8cnPmAeCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515223;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Chb+aEEpnG9wBgADB7Efz085hxxOusSroeCKPcg1AC8=;
	b=ftAKxghe07zjrBSd6sbd88V/mvUwAaX7BJ+sbz/gaxhZs2zv7uihC5tmWyRtB3ELsLRy
	 c7KAlKRi8TjCt2PDULkOfqrWRC0Nt68UPbOzma2txM+dGbgIuish6yPO69EpZqPfqgUY8
	 v4Q1w5CIEEdOa1hIf1VZLvmKZjg1ECMDKSRtCJ6v2jfX5unppvzI0IL9h/jKdpxXBQNGl
	 /GPCNRNdLgnmYvq5Yi85agjOObqD1mbJ4eE8wXsfE4ja64PS6oNSVX2fITVHFJz+fri4e
	 luYlRO57DiE3AZ/ZskJRrWBAP/C1MdlxF6Tcv9mAdBnoy0BcztqqqGMjKs2t4feD4bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATS7JxV+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10249606A332
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATS7JxV+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86F51F000CC
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515222;
	bh=Chb+aEEpnG9wBgADB7Efz085hxxOusSroeCKPcg1AC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ATS7JxV+6MOYwgHE/fLNQPwuG223tWr1KOngzRgaekXHsU4DJdzHclPmAbxImTcPm
	 0snevFacJ3pbQQmQRHAOlwm68Qcp2ol6/HtHkGUkiNQYM4vKHH2FAuhohEyhPQIctu
	 z1afVrI2bUrrq0yohQo+t0T+1o13gdkF8GyxO/Z15AEu4EVUb4j+JEWzHZdNRaGWPX
	 eET30KhaCHdvY88RiUcaKJbFk5XUcnotxW99pOfWQUUXPYUExxefQ5FSb+yPoE+asm
	 MYCF4D8+WJH5cwo9khl5KY496S/qJAj5McGOJFIzKaVLkIH7Ub2kBdOjOFRp0gUl89
	 1kniHJQKMBh8g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ace304021eso1621861fa.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:27:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGRNG23QkHkr+myYEUVpaIGDKDGhRelh1lTARFVxfeBpqZUsSqTBl8QdTgLMMuDiosTbPi7ZBc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8FvrO6msqg07D5Yl0XyzRleYFBTsweiX9JK/JwtF2cXX4O80D
	GmAeTMExSWxi3pcfPo+6qN09UcPlVnyfy9UYZAobf4K5DBNwi6znyD3l24JtC5SD/lT/a/ek6x4
	GjcpKNTkWZEhHT4+w4vGX40BLq/cM/bE=
X-Received: by 2002:a05:651c:a1b1:b0:3a9:a2fd:5931 with SMTP id
 38308e7fff4ca-3ae2b4a1ea8mr2084711fa.6.1794515221502; Thu, 12 Nov 2026
 12:27:01 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d9da17af-f49e-4878-a8dd-59a8919e6930@yahoo.com> <9b7b42be-6cc5-467f-bd01-62ab74de3523@yahoo.com>
In-Reply-To: <9b7b42be-6cc5-467f-bd01-62ab74de3523@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 21:26:49 +0100
X-Gmail-Original-Message-ID: <CAD++jL=6rq=+NOD9U1FZ+wnmzUQDzF7sbebp1qvrRTMYnET1CQ@mail.gmail.com>
X-Gm-Features: AclHuK_hp8KGOjg2fIYGYRM-U9txeKytgoHXjAulH_X4Z4aeAayp8jUpHXZ6IgI
Message-ID: <CAD++jL=6rq=+NOD9U1FZ+wnmzUQDzF7sbebp1qvrRTMYnET1CQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 10/12] net: dsa: realtek: rtl8365mb: refactor
 L2 MAC handling
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvin.sipraga@analog.com, gusfmora@gmail.com, 
	kuncy7@gmail.com, fabianotassotti@gmail.com, gabonpivovich@gmail.com, 
	contact@c127.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:40=E2=80=AFPM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> Add L2 MAC pack/unpack helpers and use them in the family C
> serializers instead of open-coding the byte packing, since the layout
> of the MAC address words is the same for both families. The now unused
> per-field MAC masks are dropped.
>
> Rename the family C serializers to rtl8365mb_c_l2_*(), export them and
> reach them through function pointers in struct rtl8365mb_family_info,
> so that a following patch can add the family D layout without touching
> the family C code again.
>
> No functional change.
>
> Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
> Tested-by: Stanislaw Pal <kuncy7@gmail.com>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
