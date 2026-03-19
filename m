Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341E3B0AEC
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913418; cv=none; b=A5FhIgTzcZdKeOPExsFWoFW7kxOnMFWkqUeJcidXfGewysyUV6qFpp61WC5V+sFO9q/XSeajz7rQu3vnTRmYmXbgGI5ynwzT/VXjPJZBy0bIMP7/7CPiJPTechSktsGzs6x16WEZEomQid6GX2PoT5llH9zfOzmpdq3GhI7qdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913418; c=relaxed/simple;
	bh=bMgGHUQEJT68rcKmPKkkz+YA7h0UjcbeuxER+65CECs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUxcHrrcrv50vYZkxlEo50gq62FsSwV9DREGb1ofzsZW5nYvbyYLs1JlUKTPDwjuXEwGJNtPT/G5cm9jItYbj9kQSHjgqlvwie2cvb6llBmsPLOJMAv4GF1qdLexWmucMKj+7huKt2W9/IXI2uR84nMYlBBT/xBM7MRRgQOomfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJpkT6AM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJpkT6AM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FA0C19424
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 09:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773913417;
	bh=bMgGHUQEJT68rcKmPKkkz+YA7h0UjcbeuxER+65CECs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CJpkT6AMgLyEDWog2VuhaeuWut4qbpNvN8wETDsXnnb1T8tX3tRRI5W0KMzj5+V+A
	 NfVS7DTuGsd1bEYQjb/u3/mUuMnGn+Xvf6xdH12GPejjt7ef1SS3IsTShlP3DhJzM3
	 L5Y8uzD98RWY7dMMKwqTKusE2HOKkzroYrjw2Ro5jyjbx14bOYBgE1vMFsXsDZ8WHS
	 dh8yG2jXnVlBWJhEzSkKw2rPB76FZQH4H6+olyhWF3lcbGLi0snE2YeKOyPM6uSUOo
	 kBOe/2LOS+MO6y4F0LokKadUMI1tYNh/Lq3y4CzDQu5EV/BmKxamj22l+U7/gjNwhc
	 xxESAUopnwpsw==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a5a37113aso8285497b3.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 02:43:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3Z9FyYq+bJmpE8S7VA/zBpfGP37Gils/+dvkLu+pJScRBn4vD82ys2PdcQJfHbKI2IFmLetc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHjFGWi+KdsT1B2CzeZ6EHxcTD1aTuNlpsNxhTE6FrLSmnGgU
	yPb3rQo9FZrEOOdoIoBWJpV3dkfgOh3EJ3ot+y7tq9CmyMvce0o3oQux6B+UfXgMcIR0Octpdso
	D8QRjIXjKXHndgd+2Nu+SVMXUDztQNPM=
X-Received: by 2002:a05:690c:5c0f:b0:799:266:83e0 with SMTP id
 00721157ae682-79a71ad3746mr55108737b3.34.1773913416961; Thu, 19 Mar 2026
 02:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313105718.359614-1-christophe.roullier@foss.st.com>
 <20260313105718.359614-2-christophe.roullier@foss.st.com> <abPwHh12MLwMwOIs@shell.armlinux.org.uk>
 <CAD++jLmBP5Puwf1ZuFOzF6U0XowoF1nfqEL3gwLy-svXsXrbJA@mail.gmail.com>
 <abStv0IPLfkKMD-W@shell.armlinux.org.uk> <CAD++jL=Av5K7Ag95LYou4TMKGR59TmtiQpxcnpcj+4tZFtzRug@mail.gmail.com>
 <ablS_C8oEQFeSU1Q@shell.armlinux.org.uk>
In-Reply-To: <ablS_C8oEQFeSU1Q@shell.armlinux.org.uk>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 10:43:25 +0100
X-Gmail-Original-Message-ID: <CAD++jLm5_mfx1572Cg+NPhuLoPu6DKDfOwK5XxRc4R_8M7kbYw@mail.gmail.com>
X-Gm-Features: AaiRm51a7-23Ps_LNUqYLhXePq1YU-pfVicusBYk32Lem3Dq79jrtE3Jr1i48f8
Message-ID: <CAD++jLm5_mfx1572Cg+NPhuLoPu6DKDfOwK5XxRc4R_8M7kbYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] net: stmmac: fix pinctrl management during suspend/resume
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Christophe Roullier <christophe.roullier@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	antonio.borneo@foss.st.com, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 2:11=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Tue, Mar 17, 2026 at 01:13:14AM +0100, Linus Walleij wrote:

> > Aha I understand.
>
> I'm not so sure.

OK let's hash it out.

> I'm trying to get an answer on this, because the original patch
> description here says:
>
> | In the deepest low-power modes, the pinctrl configuration is
> | lost and is never restored if the interface is down.
>
> stmmac uses the "default" pinctrl state at probe time. This commit
> says that is lost over suspend/resume - which to me sounds like
> a pinctrl driver bug, because on resume, the pinctrl driver is not
> ensuring that the pinctrl state is restored to whatever it was when
> the suspend happened (whether the driver explicitly changed it or
> not.)
>
> To put it another way...
>
> On entry to probe for a non-pinctrl driver, if DT describes a default
> pinctrl state, that state will be selected by core code.
>
> On suspend, the driver is free to select another state if it so wishes,
> or do nothing (e.g. it's unaware of pinctrl.)
>
> On resume, the pinctrl layer, what is expected to happen. Surely, it
> is reasonable for a pinctrl unaware driver, or at least a driver which
> has _not_ changed the pinctrl state to expect that the default pinctrl
> state is still in effect when its resume function is called - and if
> that is not the case, then there's a bug here.
>
> Another way to put it...
>
> We shouldn't be expecting device drivers to have to mess with pinctrl
> e.g. switching to a sleep state and then back to a default state just
> to have pinctrl settings restored to a functional state on resume.

OK I see your point, the pinctrl hardware state should not change
behind the back of the driver, and if it does, and that is worked
around by these calls to restore the state using the pinctrl PM
helpers become a messy quirk.

- Selecting those states to reconfigure pins into special modes
  during sleep is OK.

- Selecting those states to restore the hardware state inside the
  pin controller itself is NOT OK.

If this is done for the latter reason, you're right of course, there is
a bug in the pin controller. Certainly it is expected to maintain its
own state over a suspend/resume cycle.

Yours,
Linus Walleij
