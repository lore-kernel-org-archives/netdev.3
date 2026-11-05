Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870312;
	b=vkcdA5jCBQOLZuw5cM89FecCW4YJk7ebQ2cBEzdp9aoGcbpFrxtdV/HjQpQGX/jbhfny
	 jcyW4jx/yJTF0RLIl3WrEr9hQiTW5OeYVyFg5eu+Lz7bkt6a2UisahVVrdF1FFJ8IcvoF
	 78WwUj/a+UNum9c1EhwKGrUiGcXdNuJMZi4VEtBuga9JXXrUdFjtSXa2iBzt0e2wQ2H6G
	 FfNTb7KWaVqseosHLEuZ17+O35pIb9B4NAlNHoZ+2jLHuw/TGiyPk9m++9L06HHHTygB/
	 cGuw+9vmrG+xN10Wxy0ga5RovhDTy6//uafcu/DjDf4V68Mh/iJplAeYIGO3smypFeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870312;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B7DWIWEHYIXw7nlh8lbOCJtbur1khzB/9N+8sudt72g=;
	b=iUZ+mC8uOTND7pBIXKRjvFvbpFlYQUZ+T6GbVowMMjMh8FfcTs7oQ5HDleCzk3qRbHTR
	 4TGeLhlhR7JiBhg6bK4OA8meDTAE1ehvcXvez8ApHojp8aFKOveOhJwSWBASI3TjSdaN7
	 FGwzNSyZuFpsKgVfHfReS3mYNx3FNZE6M3PFdiqrWUHx0MlUa+mQOVKMpFn56vjt9TJo0
	 efDzFEm4x0crKRvqOZ0Dh6qHPoAfdBU5HTdSnMXiPymb548y1i5XcmLeJQut5C7msswmf
	 1p0KoOIt8RpRbcGc3zPyXQ9mCRjWtxXS1YR6pTpKjHwTl8DdsSL2xh1s3hFFUqq9hdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJM+BnRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2C606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJM+BnRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5111F00919
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793870311;
	bh=B7DWIWEHYIXw7nlh8lbOCJtbur1khzB/9N+8sudt72g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DJM+BnRY/GLQ9wK/9H14FEMG6nUzugP/2jXedCn1Ffy1htfKtcnP5W3Xc4Kjhg8SL
	 +WrSWpHtE24X/qOp0BIom2Zy42HkrxXfXcIFD1HwsoJy/ws4XlCuVXeLkBAIGCOktk
	 ARcFANo8MBcasZpRH4gfMjDLL3q3ug1V0QLozRj9PLA1719giK5JZdUxDcijtV/Kxz
	 jwDOHgwh1a8BgmGgYGN0BMMpacIov+yEavqmYUUhuCfgA7MvWBL6keXzXj1OcLtFDb
	 kELGivdCYplEjGXuBAD0bz2S01T3g680pMAB5mgOE8Y4X2NS+Sj+/6nwPqNNgvz2P7
	 mXD/VNiFHD/WA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso1389580e87.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:18:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxcvhCQ/MJr1QdWWYTMvHWG7h8xF7e8GvJivWv4HNVgNNQt2qFz0owls8JoWzI/DLP08BwE2gY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9J9DfQm6kECrRybPNNdZUNWGFlBcyk2QHfGJ7qoRzneIOWAWK4
	hd2B+0e4Fp1xMsDz5yhOWsQ/DnpKgccL0d+Ru9cHPbCIx43Crmf3Ipzl2MQiyhtgUHKPlxlu2Fz
	DXtOedFwOO2QthhSMMuLk/IrltG72lR4=
X-Received: by 2002:a05:6512:2316:b0:5bf:e643:cb75 with SMTP id
 2adb3069b0e04-5bfe643ccdemr4944705e87.48.1793870310730; Thu, 05 Nov 2026
 01:18:30 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <08611959-c555-46d9-8e7e-20b85d0c4056@yahoo.com> <3685f73e-0c28-4ff1-8c8e-3c39643a6649@yahoo.com>
In-Reply-To: <3685f73e-0c28-4ff1-8c8e-3c39643a6649@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 10:18:18 +0100
X-Gmail-Original-Message-ID: <CAD++jLn4EnfaU+jVOxx526pfEFcUT44V1voFnw6JwSkr1WAkxQ@mail.gmail.com>
X-Gm-Features: AclHuK88ewFmh9vAPMZtxXN7cAVEYnMa8u2jUSdr40HMf_OO8Bh3rYGKrGBiPR0
Message-ID: <CAD++jLn4EnfaU+jVOxx526pfEFcUT44V1voFnw6JwSkr1WAkxQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 09/11] net: dsa: realtek: rtl8365mb: refactor
 L2 MAC handling
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 12:35=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> Move the L2 MAC pack/unpack helpers above the family C serializers
> and use them there instead of open-coding the byte packing, since the
> layout of the MAC address words is the same for both families. The
> now unused per-field MAC masks are dropped.
>
> Rename the family C serializers to rtl8365mb_c_l2_*() and keep
> rtl8365mb_l2_{data_to_uc,uc_to_data,data_to_mc,mc_to_data}() as thin
> dispatchers taking priv, so that a following patch can add the family
> D layout without touching the family C code again.
>
> No functional change.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Looks reasonable:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
