Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450C2E03EA
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534885; cv=none; b=G85X/WY0fWiKUXolhlrgqrTi/x8uY/lN1R2lM+6uiD+6aPTqm3oganXcxX5mcN2lVLLdtE4DyFAD4CC4cV9miT3fuROrXlI9TF82GIL+yve8ke1THhNFXJK46+7y6oiml9BYbr2+yvHOXeOXpOnUHqH6LXFY6vZPdQluTApgJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534885; c=relaxed/simple;
	bh=kltJ9Qp9GBYlFGd/R581DdOCJEczuDIMPii8eXULGr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moN+eV2MUX7Hh7HjmRkWeXGiUZfuK1wKnO3awMI/WGcdWzdYTl3nqC51XvZfy4JhDo3FXwFTOmTISGpM6IuZmsIBdJw+BUlp9ytym1CG812EBDD5TcaUpWTzoCnqDGz2UqBsDtb7U1sN+4x/WhhunvcJB7V66nkMuPCMFEARSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jniIetz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jniIetz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790FE1F00ACA
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 21:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785534884;
	bh=r4VMEywjEJ56Lxg18ykvw6IH2jo9qwA3FksJFNXTd3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jniIetz8xIpeZvf+cKdk94AenGIjwsIcViJaaZODS7PAjRmchz5qN5G4vmak3MoH8
	 WDMybgBNcKySdSpJ5xbikzsu4o9AasB6TUNeO9jpa5C5Lhqiy+l1x6Gz4cMt9EjCvp
	 eP+pwFc5z2/gisOwXFeLETcMhVh1J/v7AAotoESlupxLjGa+h7zXqq320gnefaFQL+
	 jLi/JYF4uBbkDDMsshfkCJroyOF3gO5PbS983n/7WpkUAF2XXGW7sypjFOlEIjwSW2
	 c/Z9x1bR84F5m2y1UjKnb1IXalE2kOaXvGIeOPuEbZMhWtTSGiAz7xwEm+cBIMOtsx
	 /zhiHkfCKZFLQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so1439240e87.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:54:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrn3Qjr/H2WJSiCgeYvEWJ/2iwyhtM1hLaVFbQy4X7whjdsEGbyVu8NmHcCLlXDwywqMggWbO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy510A5zCSlnbtT0t6AtDAclxD0Pe0Tc5QiPsTsJ2QZQaZHhO0E
	HVPe6r8rQWPofdBtv5kG1rKo4MZ0TV6mBJpLsmBdfarWBmDWQBdsNtrBtm9iieaqVmXQ+Qtqlfd
	sFqsoTLwa3hrTJ+flPE4lkbQ6eYLio8g=
X-Received: by 2002:a05:6512:23a9:b0:5b2:dba5:806f with SMTP id
 2adb3069b0e04-5b2e4f76d66mr230287e87.31.1785534883280; Fri, 31 Jul 2026
 14:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-rtl8366rb-fixes-v3-1-57557b39aaa5@kernel.org> <20260730154834.07038c8d@kernel.org>
In-Reply-To: <20260730154834.07038c8d@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 31 Jul 2026 23:54:30 +0200
X-Gmail-Original-Message-ID: <CAD++jLmF8K-Ys8eeBmRZTn4pyxzJtAFF6dPRTxDE_E4697SOew@mail.gmail.com>
X-Gm-Features: AUfX_mxaCBWBPhJDe3afpwIDmIGs7l6aNB-fW-C76VFhjdSIVuNY-nkhGA84Cm4
Message-ID: <CAD++jLmF8K-Ys8eeBmRZTn4pyxzJtAFF6dPRTxDE_E4697SOew@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dsa: realtek: rtl8366rb: Fix up port isolation
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Fri, Jul 31, 2026 at 12:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:

> Sorry to report that both Sashikos remain skeptical.

No worries, I'm used to it :D

> https://sashiko.dev/#/patchset/20260725-rtl8366rb-fixes-v3-1-57557b39aaa5=
@kernel.org
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260725-rtl8366rb-fi=
xes-v3-1-57557b39aaa5@kernel.org
>
> The mask is the allowed mask so the write of 0 was correct,
> but we want EN + mask(0) ? The problem being that
> rtl8366rb_port_set_isolation() does:
>
>  if (mask)
>         reg |=3D EN
>
> so with mask of 0 we can't enable.
>
> Maybe pass
>
>         rtl8366rb_port_set_isolation(priv, dp->index, BIT(dp->index));
>
> ?
>
> Of course neither I nor the LLMs actually know this HW :S
> But comments on other calls to rtl8366rb_port_set_isolation()
> suggest that indeed the mask is for allowed ports.

I went back to the vendor code drop which all code is derived from (previou=
s
OpenWrt switchdev driver and the new DSA driver), and the code seems
to support this. I just drop the if (mask) clause so we enable complete
isolation as intended, I think this works. Sent a v4!

Yours,
Linus Walleij
