Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9974BE435
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212794; cv=none; b=YEFgvJPDz/8Q6Pr01aoSL3AUrnbP9PSAFEAcZZgD/XwqBOIG4oVqq8QKxVVBEkT7JbkTq5SjFQ9V5aN5c0KHPQigz2qIliF3nql2Jvl1RRxGloNoBOQMZLrYE02YsO43X6AFz4gtcNTNVK0MgJeLlbSo1ZhXFyfDDzPZYmSuCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212794; c=relaxed/simple;
	bh=Dl7Z7JEOlj3es01WQyVYYiJeIduy37m+RAyJv8IUM20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lX/Ifc1xiBNWlP195wkN0yMaFjO5oVX6uFGqddAztVhtOIT2FcxlXKSs5eGRDDOHdL4ioICuV72TYTtNJnYzXdLsMiIulBb7oX5pW35/+lDTWz+856yyiVAbTb2VcAM9vIpow8qEmYhx4bNCF7yRzk5Zt2hNDkS0YnDAuRL58Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMex5FbK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMex5FbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16581F008A1
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212791;
	bh=Dl7Z7JEOlj3es01WQyVYYiJeIduy37m+RAyJv8IUM20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gMex5FbKY7YIUS7I9Lt0y8dhFYqTN7I0XyFByRqzbxqX1uS/S9tFw878H4gP+64Oc
	 5nII8ZElWpZRi7ezO4ob8E+7Kuo3pDwB5NvktuWhqImbj/yf3OxW0TzihzQyW2Dyfa
	 JN8dFrb/cJEOUsZdrZS/5KeV2PCRwd3VaVgOFhbDpQqc9/z79ThQycFvZ5yQzWt7lL
	 VtRJArfIwca67tohScMfXW92u9630DbgGwggRrHpuFMGmLRhFOvjbRWKlRkU58B3dP
	 4kMeqysMJk57rrKdb8nreB+qRzbmamml05+/+X0ylqpbboCoRQDumrfago4CW53wlI
	 yDUzLMuxu/wUg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5bb79ea1170so1471681e87.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:06:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxYnj0VAplnd94ALlBr5hBNSpLCTqSMj2aJR5DsnTY8C2a0uH43elHDU4uhCszYCm8Vjt2p7Zg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkfFoBlDzg8W4qaWy6cj3m4FUsLJmN5Vp7CYrXnjybEaNuK0DL
	yQ7XfYvwBddtsjnfSmJb8ylBZ8aXIyAYny/6NYBq3bFAEWdIH2bo+2XPeLsfvEil6oz+SuW38a6
	2jJlNUNjzLnXaVsLidLuT5LgO7Lme3aA=
X-Received: by 2002:a2e:be25:0:b0:3a7:812b:d1c with SMTP id
 38308e7fff4ca-3a87ec38b9emr29475221fa.0.1791212790667; Mon, 05 Oct 2026
 08:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-3-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-3-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 5 Oct 2026 17:06:16 +0200
X-Gmail-Original-Message-ID: <CAD++jL=5joKEbMxq0Rrt2HR_nvsEVfPpgHhFerUS3ZKfV8rhBw@mail.gmail.com>
X-Gm-Features: AclHuK_3_WgrDVeWuZ4Ba3l7G2hz1h1MnZ5Np2yr1x4uOHNIoSbiU2G1qMrb4WI
Message-ID: <CAD++jL=5joKEbMxq0Rrt2HR_nvsEVfPpgHhFerUS3ZKfV8rhBw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/8] net: ieee8021q: add pcp_to_tt()
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 1:58=E2=80=AFPM Oleksij Rempel <o.rempel@pengutronix=
.de> wrote:

> Add a helper that maps an IEEE 802.1Q Priority Code Point (PCP) to the
> corresponding 802.1Q traffic type, complementing the existing
> ietf_dscp_to_ieee8021q_tt().
>
> It is very nearly an identity map, except that PCP 0 (Best Effort) and
> PCP 1 (Background) are swapped: per 802.1Q-2022 (Annex I, Table I-2)
> Background is a lower priority than Best Effort even though it carries
> the higher PCP value. PCP 2..7 map straight through to the matching
> traffic type, and values above 7 are rejected with -EINVAL. This decodes
> the 8P0D encoding (Table I-7), where every PCP value is a priority and
> none carries drop eligibility.
>
> Drivers that classify ingress traffic by PCP need this to map into a
> priority-ordered internal space without misordering Best Effort and
> Background. The first consumer, the realtek rtl8365mb DSA driver, lands
> later in this series.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

This looks very generally helpful.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
