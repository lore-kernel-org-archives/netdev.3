Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E67148594C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399239; cv=none; b=Itq8v3/eLjDET+NiJNhG7X3vCatiY9AEE14zJKOKnPIyV5fJwQM21PCuZGZIB3FMnx3p542XuFIMyGiuX0NbXlXviRvg4EQnc5iwwD6/VofxQjCVwa3XG+Gl1PfGFPtYR4/bOHESsbCzPlfLLhRV7AvgWG+FRnuomeNC1+jZe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399239; c=relaxed/simple;
	bh=+RJy4/1CZWMGpIomq9rRX3FDlzjAyxgqndFyH/8QQ34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heXBXIDZkWRPO5Oawnk6DWg10mHV721370/a3WSv/HdwQIf3m+dxJ+at78mdHSuTkrydBohrbXT4plRR5HaVg2S25o2L9f/rehqLc3L0rTQe+qu1nfdJvoGigQ1gCLY29UVrIjkpq5/6BNAYFs9vssYp1+O+RP7us2Sxu485YS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z23BVL9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z23BVL9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97001F000C9
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399238;
	bh=kbbc18Cvxb0ZkFfeTiQznolGy8+ESv8PHDFn19DRekQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Z23BVL9+ELjt+cKdusMKRhHFw8UBL9KR8FYcUNDvyzrLivRHweMGuL5rmtKdbvPQu
	 f/yYYG5NhbzDDceo+y27yBntC4eYR8MUbHmiZUdur0to5Ej5AyIRltY7b0FYcA8NV0
	 u2b+Pz5peAan7aAptJNCUnsUQxNvhbxf5AT0aYYz71gWEn69viMfhyoaWKUIO5Ua7y
	 DsS8HzQJCVy4vkY/PDbHKrgZ/08QssIA+nv0XYOvUyD7ABwEXNchLdJ/KuySQ/1/aD
	 slRgE8WTCB3WiGY0pa0jUngeWCdtgsEzD+KQL+UALPt2Y0NeJQcy2GTxXqyAlKeE9/
	 bUDhfx5bi6UFA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3ab3b29a210so7028041fa.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 01:40:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz7JZwdzAsOMYNa+83dX7BucDRBkHd8YS4ggqfYbU4lZRRh6nfkU34+Oik03iAnnVkU1cTHAtA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWl+5JJxtXFxlmonG70jjb8SvQtIuig6Kf0q9DlhxIGAY6Ppo+
	JOm3ad+MfmGTm5QesLLvSZJiqu4uKgC4altDiSm2Qpourc68jukeFSgm5XVwFtWFRdG4pg44zqy
	3aJPAMJ9ir2bt4ApJcM6xyN9IXmoKKEI=
X-Received: by 2002:a05:651c:43c1:20b0:3a9:a07b:7448 with SMTP id
 38308e7fff4ca-3ab14800861mr14136711fa.19.1792399236671; Mon, 19 Oct 2026
 01:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
 <20261002115850.962676-7-o.rempel@pengutronix.de> <CAJq09z7rAtikR+AZ93zjruhrhTEC6GbFJEXbQsbN_OVDgk29pQ@mail.gmail.com>
In-Reply-To: <CAJq09z7rAtikR+AZ93zjruhrhTEC6GbFJEXbQsbN_OVDgk29pQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 19 Oct 2026 10:40:23 +0200
X-Gmail-Original-Message-ID: <CAD++jLknmkndMJQuDGMnXohvf=X7Lw-dmCjOKo4Adb6V4mXO6Q@mail.gmail.com>
X-Gm-Features: AclHuK8StAfiXPzzA-5_qpgPJKTDai8MFFCshc2OP8TDipUlYSr8l6jA-xmTMpo
Message-ID: <CAD++jLknmkndMJQuDGMnXohvf=X7Lw-dmCjOKo4Adb6V4mXO6Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1 6/8] net: dsa: realtek: rtl8365mb: add QoS
 baseline and DCB default priority
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	OpenWrt Development List <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[CC OpenWrt-devel to get some real-world usecase inputs]

On Mon, Oct 19, 2026 at 6:01=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> > +       select NET_IEEE8021Q_HELPERS
> > +       select DCB
>
> Is 'select DCB' really desired here? Drivers generally avoid
> unconditionally selecting DCB because it pulls in a non-negligible
> amount of netlink and QoS machinery into the kernel,

I'm not saying you're wrong, but the Microchip DSA switches
do select DCB for them all despite not all chips have this feature.

The argument to select it would be if the features are useful
for everyone.

I had an AI describe to me how the DCB features can be useful
for simple home routers running OpenWrt but I got a very
muddy answer :D I do not think a default OpenWrt
router userspace even uses the DCB features.

If this is just for datacenters and fancypants set-ups maybe
it would make sense to have it compile-out optional?

Arguably it is something OpenWrts default userspace
*should* be doing, even by default, since it's a well-known
and old feature present in many routers. I think they/we might
not have gotten there because we barely even embraced
DSA, such fancy stuff could be on the TODO list. In that
case, it may be helpful to have it default-enabled in the
DSA chips that support it so it can be rolled out.

Yours,
Linus Walleij
