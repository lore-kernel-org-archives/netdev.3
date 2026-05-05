Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8B03128D7
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984086; cv=none; b=iP4oTSxPYiPtDIGXt6+dumdY1cf4BLcVTUvKuFO0+MeXiIIswNoMCr/lIhzWPiZKlZwb0/FE4TF9e0ItyXn/8v2D+2LYsN63L1Bto+onGmjKZSvwIGpulfJH3RDNUzxZqHZ+/xXk3Y4s79AG097ZrSdP1kahye7uMZrOUVd6VA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984086; c=relaxed/simple;
	bh=vPo69eniW+CSnRiTOz7tgFD7qWwMopNJvTj89E6VCDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJa/XK2jvxKbq1L3JR1vNu0kvrcT9FKzF4p39vjY/pnp5s2ZVg9ynrzyfc0EefOmeTcZe6ZkCymxZpXw7qPf7T05R8Ou52bAjgBbd3YLA5lOvd+Ds/yDCWHEYU09x1H4TkH0r8dNaW91d5BJANBfvGw0C6+TrGR0NdXYfIhrAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pazx9KIL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pazx9KIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD2C4AF0B
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984086;
	bh=vPo69eniW+CSnRiTOz7tgFD7qWwMopNJvTj89E6VCDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pazx9KILB2MfZ6mJEEAFUWcyX+D0PG0fve7XbEzuKDxLfvLRCw3Rbm8VejNFIF3lm
	 HU5Urka63VMivhfrTP0I/1lv8oQWMxLThYY0iRXvUKJZR0oHTbSUYwbAv7LbwigShL
	 UehnWkJ4iM2wiBcIsES4GijPEXIEpS4VSycB57xBRrEwK+T8+ZYGGFg3dnBS+1ZOSr
	 hYelFm+xTmW6ZVd6HCeh6VgJDahlnTwANxvg8S4SOO6IsEA/qHK0s2Gqi+tuMNTc3F
	 VPBpL9crxBEhFUOHYbAQfR2PMzK36LTu+TosmiS6PLQWPfT7jyD59agDZQXDKoG9bp
	 pJkCRN8WGi3Hw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a748d5ece4so5720990e87.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:28:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9lQ4r05nfhHsCiGBlzKV2mGMQZlkFWs+LCbQD2HzwhWRHMI+aT1csce2tz1tp0msJRsq/gQ+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YygO0q6NKBnTdYwyVkhDx/fx4Vs5K7OuNzvQ4B0m2zI9mLvVAtr
	9zFr5kTDa9ccTXhp1SPqepB4YWXnfUTeaCv3P85dqtbjTpCRYBwGnwEhJL2OOZrtIG+NDD2Po5e
	cqFRrZ74CYTW4A3k61EWfcYiJgq6CR6Y=
X-Received: by 2002:a05:6512:400f:b0:5a3:f2ed:87cd with SMTP id
 2adb3069b0e04-5a862ec316bmr4618383e87.10.1777984084721; Tue, 05 May 2026
 05:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com> <20260503-realtek_forward-v2-8-d064e220b391@gmail.com>
In-Reply-To: <20260503-realtek_forward-v2-8-d064e220b391@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 14:27:52 +0200
X-Gmail-Original-Message-ID: <CAD++jLn3WSuQ0oGfPAX3P-P9qvKfDBO24McrLouhu9sKXM-62w@mail.gmail.com>
X-Gm-Features: AVHnY4Lj2yGywUvX4SfTk-FZbqPh0Iz7yYBEelMM3aj5Lq-dtuovmAX2p6yObKM
Message-ID: <CAD++jLn3WSuQ0oGfPAX3P-P9qvKfDBO24McrLouhu9sKXM-62w@mail.gmail.com>
Subject: Re: [net-next PATCH v2 8/8] net: dsa: realtek: rtl8365mb: add bridge
 port flags
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 8:19=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Implement support for bridge port flags to control learning and flooding
> behavior. This patch maps hardware functionalities to the following
> bridge flags:
>
> - BR_LEARNING
> - BR_FLOOD
> - BR_MCAST_FLOOD
> - BR_BCAST_FLOOD
>
> By default, all flooding types are enabled during port setup to ensure
> standard bridge behavior.
>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Excellent again, thanks.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
