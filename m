Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A539D6DB
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803691; cv=none; b=Rs0pxd3cs+zl/neQmLrqG6oYkeeyFalu6tPsXYBo58AAHz2w6BExLRsIbFUSGqhvWfznUlHvUpB2WWXVaQBYdd82icOBCiZ66rCaEKZ1ZyKLoe2vhHxGY+TYb/j1G1ckT19YILm82z3HWgT8jJ/GVimZG6ZJgS3xqIg7Y75NTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803691; c=relaxed/simple;
	bh=KBNzeZfusnJvFiG05Py2FuUHBBu7b/h0Na5PQzEHzX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj+e1/yIzoFIEA7LnC62XzvG5I1vhzMGY5kCN4JYQOMKn3dC5oAdbwqxi4mNKxwhJRLkpronDS4W7Eo4/oGP4MewLCxFEPwouKodZwmTzOpU+QvCLW0sXR61e0ugoCA1SnvXBlQoynf+rqCKENHBBX6XMESqxd330obMdIYB3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsmtXEsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsmtXEsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9227CC4AF09
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772803691;
	bh=KBNzeZfusnJvFiG05Py2FuUHBBu7b/h0Na5PQzEHzX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DsmtXEsVje0CzFfsRxDddY6AuAudTGxg9uZf5VOgd0X6hqdU1z3OQ9eae2uajdBi+
	 tV7V0lmzOkJb98wA784Q66NYgF5ZsOP7YvBChqwPIn3TWbglUj+4p2t+wCfBSkK2Jp
	 WqWWUSY1Dunwu2w3qkxz7O7sQWEuu0TnADG+mVPmfYqFvknm88pa24rS18uOZ6toi5
	 /4YeBpeC6egzgFv2UXPLKlMvCJ8G3srlp1ny3CPq6TPaUDVZ+GoQnoGc4XKe+mPR8j
	 GxHmdJy7T3Y8oNGoPHBI7rEvzJYGAxy7zSGd434RdLqP/E29dfrNh9kkv9//VVxyNY
	 J7qFWrMiNMShw==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ad46a44easo8164153d50.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 05:28:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8EEB8pI3RHZtXLpkbEtZ7ri7JTR0piqT89FmPV+ocP+GOVseAh8NzCMuf3/kUygkqEv6l/x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkdWntSa3caX/FtaSAKXKWJHuKDXw4AYlOdCbyPP547AK3zuW
	MJanOHga8JVGokWRBmdvg8LVtPkbnEyF6JF4DI/+Ibb8TjNwDjfzx4La8LU7NwylLTu60XRj0Qe
	sOZXT/VtYJ4faY44SPp0dzK9WHNIglYc=
X-Received: by 2002:a05:690e:1381:b0:64a:d67a:11d2 with SMTP id
 956f58d0204a3-64d14127df9mr2032369d50.29.1772803690827; Fri, 06 Mar 2026
 05:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7187C401290C256B+20260304084808.440955-1-xujialu@vimux.org>
 <D5F95320CE72E20A+20260306035539.2443355-2-xujialu@vimux.org>
 <CAD++jL=sj=DCuRvOveVeUo1RWmS9ZvA6YqXNjOQf3qhvyRzL+A@mail.gmail.com> <3f88caa5-cf81-4734-84c1-ae3db15c557a@kernel.org>
In-Reply-To: <3f88caa5-cf81-4734-84c1-ae3db15c557a@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Mar 2026 14:27:59 +0100
X-Gmail-Original-Message-ID: <CAD++jLmaUn=usx-N4pMSK_X6GobSXP00T34rhpT7U9LPOzhKFw@mail.gmail.com>
X-Gm-Features: AaiRm52ut2KSSRPEtSZe6vL8Ur6qd6orbPyeRCwor1TOW_T_v80FecuHtoeViEM
Message-ID: <CAD++jLmaUn=usx-N4pMSK_X6GobSXP00T34rhpT7U9LPOzhKFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove <linux/of_gpio.h>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Jialu Xu <xujialu@vimux.org>, brgl@kernel.org, kees@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:25=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On 06/03/2026 10:38, Linus Walleij wrote:
> > n Fri, Mar 6, 2026 at 4:56=E2=80=AFAM Jialu Xu <xujialu@vimux.org> wrot=
e:
> >
> >> Convert the last three NFC consumers of <linux/of_gpio.h> to the
> >> GPIO descriptor API, then remove the deprecated header entirely.
> >>
> >> Changes in v3:
> >
> > v3 looks great to me.
> >
> > The NFC subsystem is orphaned, so I suggest Bartosz simply
> > merge this to the GPIO tree at his earliest convenicence.
>
> This should be sent same way it was before it got orphaned - nothing
> changed in this regard, I just don't do reviews - via net-next.

Fair enough, either this or the network maintainer can give an
ACK to take it into the GPIO tree.

Jakub, what do you prefer?

Yours,
Linus Walleij
