Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4541D10D
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243544; cv=none; b=PHTtykodtjAxO/uhpXfL3p+O9BhKXCf7gnOVbciuy0+oqKtO+Ct4vkWyztb7glVlukfDPY+J6dCTYEzvh2vK8Ti1xVCk58gq/vZup3v2Pf2W1cddZ3vhs8dR4rjuyaf9qTzU0ab9KuN1dmibNGa/B24pp431EWCFk2iaQcHHpOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243544; c=relaxed/simple;
	bh=7Z4YQNQjAkp7fBRBfGTICKlRVpTs3liJVTbe9LCjByU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=so1XoCMAh/WXb/MqYvoiV+lhes3xjIbkzNjhHMW5jpvv0SCz69BRZZZJj1+1YfOTHEpP5UHnxNlQPANvsBAHwEMe726Iol3UF26E5zWgUMNjpkyfb7wcVn0ETQ90bHldbp4GZ33dFTs8CL0AvXLrOzVo/9p0EUVH3aCa0+pxdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vj0z80kQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj0z80kQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEED1F000FF
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243543;
	bh=JBW2ODmtigkrsix+0HH/8z6xbG9n5M8X7qtAqWl/PSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vj0z80kQRnNbFBcWuyEU53Oq1Yd7O08hmIxSonFhF3dA8UjvJ6dY9n/6jTKCHWDIm
	 OFCVAwcjAbS5YxRCcJ2RXN9U0iYNeWt2okSZqrypusfCnp/pvOf2i651GWYObKIKWk
	 9BtZdV5zFWkVpO2JjGA/EuJOh4Bme9CffeBElqLVfeWnG9eMElKWwDSqe5FuoPqUxN
	 IgBXtqrF0RNGmipku38DvufyhAkLvTv0xb/n2rYr8ZMeQqQVMROXj9ewoLqDjIcDgE
	 xKQ6YEp2e6Qg7d9SNjPfpes8RlxTVJe9auu8foC4xojbqODD5VVVT3MzqMNeoxSWm6
	 hse/ng3NhulNw==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a77da28307so20914281fa.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:39:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxxmYa9EsvZ25V60vH4BQPCT3g6XQywWc2hxny4ktMYE4TnYkGwXpKKL2JjXIvcQf9mBaUBcTU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcroFTWZWHFpMhSfP/x8JoLmYafovsuoIl3RLohKD6qgO1AwYL
	EkC5AAAxjx7uPKeaKy+DdlvC1lN4OYHOM3jT0y7UGmWBoBNHoqDmeVTFZsYIKE4R4ApgvqoNJms
	fplAu01bWlL2pvdHrQaSaxQLVvYYZ2rw=
X-Received: by 2002:a05:651c:b27:b0:3a7:812b:d0b with SMTP id
 38308e7fff4ca-3a8877e2986mr33078091fa.11.1791243542023; Mon, 05 Oct 2026
 16:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de> <20261002115850.962676-8-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-8-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 6 Oct 2026 01:38:49 +0200
X-Gmail-Original-Message-ID: <CAD++jLmckJt44y4HNTs4yb2oMm3nJTTBKDVh8dohAeBrDX4a_Q@mail.gmail.com>
X-Gm-Features: AclHuK8XA3y4aGMxpVyTYMYhnPBZuxOn10ShDpEb47GBNRqHJNMwmPMgq3wAZ4k
Message-ID: <CAD++jLmckJt44y4HNTs4yb2oMm3nJTTBKDVh8dohAeBrDX4a_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1 7/8] net: dsa: realtek: rtl8365mb: offload DCB apptrust
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

thanks for your patch!

Again some potential to share code here, not going to
repeat myself from patch 0.

On Fri, Oct 2, 2026 at 1:59=E2=80=AFPM Oleksij Rempel <o.rempel@pengutronix=
.de> wrote:

> +/* rtl8365mb_apptrust_weight() gives the first entry the top weight,
> + * RTL8365MB_QOS_WEIGHT_PORT + ARRAY_SIZE(rtl8365mb_apptrust_map); fail =
the
> + * build if adding a selector would raise it past the decision weight ra=
nge.
(...)
> +/* Trusted sources outrank the port default, and earlier entries in
> + * rtl8365mb_apptrust_map[] outrank later ones. Deriving the weight from=
 the
> + * entry's position makes the table order the sole expression of precede=
nce,
> + * so the order and the hardware weights cannot drift apart.
> + */
> +static u8 rtl8365mb_apptrust_weight(unsigned int entry)
> +{
> +       return RTL8365MB_QOS_WEIGHT_PORT +
> +              ARRAY_SIZE(rtl8365mb_apptrust_map) - entry;
> +}

RTL8365MB_QOS_WEIGHT_PORT is 1.
The returned weights
will be 1 (default), 2 (DSCP), 3 (PCP)
if I understand correctly.

The RTL8370 source has some other opionions about this,
it writes a power-of-two value here, would be something like:

return BIT(ARRAY_SIZE(rtl8365mb_apptrust_map) - entry);

returning the weigths 1 (default), 2 (DSCP), 4 (PCP).

So for RTL8365MB this value lands in register 0x0886
for example if both sources are trusted as the value
0x0302. But for the RTL8370 (which uses another register)
the value is instead 0x0402 for both sources trusted.

Can you check this in the RTL8365MB manual because
the register usage overall seem very similar to
RTL8370.

Yours,
Linus Walleij
