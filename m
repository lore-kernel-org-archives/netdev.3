Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279C4BB81D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791934094; cv=none; b=tjGAh6H2WV9ysOBPp2ZICM6W+R5Kv/+A6DrPouz0wTE3Tq1pXvv9IcmGoI5cDYW2gSpAhCFrm1gAa13uWNMvPmMXnHmQ5hq9VaIFdmi1Cgh3BK9Beeag8ducRFmqi+vjvh6RSI8zkelQMLPkNasmJj3KcOUNCE593u6Zs/fqQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791934094; c=relaxed/simple;
	bh=jfICjUN4uGEgxT4SIC11mAwKtjbwwaD5aD305KLzTmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWvI0qGH60mVEoudHcK3Pcx3pEg5vqujVKka2xXAa1b232pAfukMIiY4oGJRY+eiVdnf3RnU7SrQen2Fm/9MxeMUt6ft9EL0aTgldJs5A+jKKSs2sUGOsRXBsAn29lNTcE6+PoWP+Gy0BFG98aDzP0eC9nxuOBlPOpTQLs3LK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfdIPTVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfdIPTVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E7B1F0089B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791934093;
	bh=jfICjUN4uGEgxT4SIC11mAwKtjbwwaD5aD305KLzTmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BfdIPTViqrUvoKgyDOjZ4GSRMmT0vP/qzCOD3dk44TENBobYWugmO75x8KpvaKXFR
	 uZHwiOmTwA6oHXtcIDpOglH1XPRDx7i6vLwcwKZQdAlbgFynqbh7kkhJCQDW0S2yj7
	 Gn36ASQ1MT1Jxx/UjSao9nGiRGJK+HJlqSwZ9bLTq/s+1Rm0/Msw+vUU1xsK488r1b
	 WSyO97dsQQB7phOHs0cbWkhL0OXtospujIT+lQ1uvPaLoWhRhmauU7Xq1dJdAu8IPt
	 tr+Mwgqq2BQ+wqCsFRbmimP6tdAAUwP2+Jk3vEQj583C/lv9dnmQbiqE43rRQDqYos
	 /6orbnrnOBs8A==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so48566471fa.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:28:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw23EZ/KfjBASkOpyuHoG9TvPvuNESBt2uz2Jmn6xvvgz9rED00O9zPh/AClUWHlPZxFGKzphc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMSyGU887btbnsi5vsS7ljwTrk6MrcmV04/ETSWFi4RaBlS/uy
	ykXBIT92LJ7ZE6u07J2e+BTeHoO0qBhK+RUWqj30lMSwgSbI5TvzQ9fdrH0Sr5ctvavj/j8X8gG
	tikPLSAaozU9ZgQpZE1ET2bm6PodE6iI=
X-Received: by 2002:a2e:be88:0:b0:3a6:62bb:906e with SMTP id
 38308e7fff4ca-3a9c2b34d90mr33801471fa.20.1791934092040; Tue, 13 Oct 2026
 16:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b45a3350-44a3-45ad-89cc-452c25edbd7d.ref@yahoo.com>
 <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com> <56fb70c5-9e8c-4d7f-af47-46ed3c860694@yahoo.com>
In-Reply-To: <56fb70c5-9e8c-4d7f-af47-46ed3c860694@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 14 Oct 2026 01:27:59 +0200
X-Gmail-Original-Message-ID: <CAD++jLkwAr7QuJnrvZHao3Y=f4QDtxQQ1e1FMtbRicyhqyNwdg@mail.gmail.com>
X-Gm-Features: AclHuK8YuIE-kWbk3_VVqYiyOABl7Epu0vDyuoAROAUzyJrvRto2P0FIbcDiEDk
Message-ID: <CAD++jLkwAr7QuJnrvZHao3Y=f4QDtxQQ1e1FMtbRicyhqyNwdg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/9] net: dsa: realtek: rtl8365mb: add chip
 family infrastructure
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 10:39=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.=
com> wrote:

> Add enum rtl8365mb_family and a family member to struct
> rtl8365mb_chip_info, together with rtl8365mb_get_family() declared in a
> new rtl8365mb.h so that the VLAN code can use it too. Tag all existing
> chips as RTL8365MB_FAMILY_C.
>
> RTL8365MB_FAMILY_D is defined here but no chip uses it yet; it is needed
> by the following patches, which add family D handling for chips whose
> register layout differs from the existing ones.
>
> No functional change.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Makes sense.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
