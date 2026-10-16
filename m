Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1443EC6AA
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181701; cv=none; b=QM9seJTNGrsy3yS/NvqDkObmypM6QuV7zVNvX8Rgabb6rfLY2zOjKfQfNvNVi1ZLAEXTYxwtcVtJjYUnEzZqCEIqoPN5FWyKMlBGO/36BogRDmFpDas0UFeNtCyHLJ96IC1TdnyzDF/lIBLpyNSUDkXqgko0gkBKYzNau8/aFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181701; c=relaxed/simple;
	bh=jO9KygYAAiYjF2lkdbuUdM2Kh9v14N8d99UwSADyEjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwbg4xshQXB1B7viU/Mc0ylzLECLU0lJlQheEvfgcF3Vhb5NP/C6G8OvbVorKkvmbGeGq2QezPCUYCoE6TMRXm6N1Sc/cgQPkI92YFIdItwHMAXBcXqoSiazFkZQ6o0zVgNcMvjRXiF2BDeRp+s1V4A7xccgkcYnskhACe7YE8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGhRj+CS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGhRj+CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BCA1F000CB
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181700;
	bh=jO9KygYAAiYjF2lkdbuUdM2Kh9v14N8d99UwSADyEjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OGhRj+CS7Egknsq6GBhWnNYZIF5Gupxskl36fOwntO+YkX7qioLfTEUoZHFefvcwp
	 z31itWi77KB/oTXh/nYXRbaLli6SvdMT7iyosSMQPTHmccd3v2QRolj1yK+SSiNO0s
	 bsq+T7tq6PMebcRXw91OGtbbFnDfyc4cl6IL4Uv+jBfHpQ69iyiwOpSWmsnhnY85Ml
	 HkTzQFIdSq3Fm2DNOw9axtj0mpCDHc9GjMoYoEglMfgPR2Br0FMC+Up97WG5KxusqJ
	 NOuUP0+pA24rZ+9NxvIKN8ZH+ihN/xPtz/JwPhjbdgeAAz2oDzskOgsmTYwkFXBmqj
	 beP24PrLrZh6A==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3aae7df0971so1761501fa.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:14:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzo109bP/QUep6z97CFulXkv1gAU6Ed17/mcQ+Ax8Xb2XCBnj3O6Aa5uRsbaRmtf3o9sFhsjmM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIinFrNPlnNJlT0DT5AZbO6e+DmSGrKhLxuKZ6L4FmK2DkEvw2j
	/xacwYjBIvi6xFpzEPKHkwSixc+lPgPm0Af1hfAkSsa9wBvsr+wrYSiqdxlCqQrGH1agSB8VpNw
	5lSZV5hNY/g+QP4+CIXGdM4Qmh68YHKA=
X-Received: by 2002:a05:651c:41d7:b0:3a9:9b74:1ba1 with SMTP id
 38308e7fff4ca-3ab29111680mr1864781fa.8.1792181698714; Fri, 16 Oct 2026
 13:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <32ba8939-213e-404a-a247-1f24603ca6c4@yahoo.com>
In-Reply-To: <32ba8939-213e-404a-a247-1f24603ca6c4@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 22:14:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLmmxk0hy4-MzVU-gwoSyLRjkYH=0EmxTqt1OEOrer1mcA@mail.gmail.com>
X-Gm-Features: AclHuK82bVty_12nbRudu5-YWV07s2cV4wim26Gz4MzpAumk_bXdyaizRhRjGAQ
Message-ID: <CAD++jLmmxk0hy4-MzVU-gwoSyLRjkYH=0EmxTqt1OEOrer1mcA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 7/9] net: dsa: realtek: rtl8365mb: add family
 D SDS13 PCS support
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:07=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> Extend the existing RTL8367S SGMII/HSGMII PCS implementation in this
> driver for family D switches, whose CPU SerDes is reached through the
> indexed SDS13 window and whose SDS_MISC fields differ from family C.

We can't assume everyone knows acronyms like this.

PCS =3D Physical Coding Sublayer, something needed for SerDes.

I don't know much about SerDes and I know even less about
gritty details like that so we need to spell it out for fools like me.

> The register sequence and tuning tables are derived from the GPL-licensed
> Realtek RTL8367D port API distributed in the Mercusys MR80X GPL release.
> Keep the existing family C path unchanged and select the new behavior fro=
m
> the driver's chip-family metadata, making the implementation reusable by
> other family D boards.
>
> This patch only prepares the family D paths; they become reachable
> when the RTL8367S-VB chip entry is added in the last patch.
>
> Co-developed-by: Fabiano Tassotti <fabianotassotti@gmail.com>
> Signed-off-by: Fabiano Tassotti <fabianotassotti@gmail.com>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

WIth the requested clarifications:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
