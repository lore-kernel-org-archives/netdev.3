Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E62389458
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301713; cv=none; b=ClEuXFZdy8JCHus+qVBdkpqGaF6AglHoZu4P6U6C/PG4lMnis0Zd1E9e33MeZ0LTF9bHgthFN95Yy8tWUc68HUl2V3l9DU/psCFpybCkOCRs4j24LLWKb0mjTjgILTQBzqKgUSQXnQAurwVeV+MLFQsTwofnBuD8a4FtzkIK/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301713; c=relaxed/simple;
	bh=y6ZZGd5HZp+4cfuli6ST+EnFldsgQkO/jKSkyGstQ4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4sLhKNSWEngkKuNWxMAeaz+AVFtvg2FT1HZOFuSbHFeaa7Mh7MrWGAThKYxHR6H5RWhOdWT2mYDXRuFN93BS9Fy5v3xtL/E+UyDuWT9q2Z72tg/tchafjw350htimlcIeBuKNIwMDYSMuMSzxQzOxDdsf3ES3mHFwuRWYNOHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq5KUCVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq5KUCVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9651F1F00893
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780301712;
	bh=y6ZZGd5HZp+4cfuli6ST+EnFldsgQkO/jKSkyGstQ4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Aq5KUCVOBlghWDsbPG24Jax1mq5werm58ZV097OjC0eCa9LYgxRSF8P9PG+KyU37m
	 b7ZcqJ3q3v170if+MwV8veM8dtRWcV8uqy2WVLy1m3tUF27sQkm8ouGCDJjgOkgHOL
	 9HFkCN4as3GPaV+eauIm75nW1CAS4NtUedVf4N9AeyFlXVSQwy1CwbzVTrEgr3TUl4
	 06AbSDye3wimrPkv8nItUAiIIIWL3jre5TwGUkItVzPMb7zp/6d94Xm7IjD9X2KeN9
	 9LvfiJFDCjz+peeQNuDkbpJjj/4HCvdxdgFoe8BQYe78BU/m+vQoLXMLFKKBstO1kM
	 rzSQIknLY92iQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso1280890e87.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:15:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8tJWLc8RwAbnQlsDvXFic7Vv0qYRFWpR0MCUR10RPGODckwB3lBAs1yosrat3y8nFMxpibam8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUZ5uRe2QjHTtwsIUkIW1aXaYlc+e1i4odNzvINSDRQQ1lns9
	tCXo33D8nHId3oQ44LhJXH+pxmsEVEHeCCReopGgWaoFfBqIO7LtX9dSzkp0lIpg3WAXmC1dMEP
	x4eoRO5NVXaBZELrO+06y4Mg23gThXLo=
X-Received: by 2002:a05:6512:1096:b0:5aa:6155:d645 with SMTP id
 2adb3069b0e04-5aa6155d7b2mr3333446e87.44.1780301711363; Mon, 01 Jun 2026
 01:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com> <20260530-realtek_forward-v10-2-d14b51e6a69d@gmail.com>
In-Reply-To: <20260530-realtek_forward-v10-2-d14b51e6a69d@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 1 Jun 2026 10:14:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLkL_iYMcoz1APM9Kb6U0xJf1_D3PR-R94X1BQstdY-7mA@mail.gmail.com>
X-Gm-Features: AVHnY4JKlUQb-NZDzEpuQj9TvCsW3m-2dCsJdI6YAp6-KkVhLYf2Ec21PvkGoWA
Message-ID: <CAD++jLkL_iYMcoz1APM9Kb6U0xJf1_D3PR-R94X1BQstdY-7mA@mail.gmail.com>
Subject: Re: [net-next PATCH v10 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
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

On Sat, May 30, 2026 at 12:51=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
> cascade links (-EOPNOTSUPP) during setup to prevent silent failures.
>
> These topologies were already non-functional. Without a CPU port, the
> driver does not activate CPU tagging. Additionally, the switch hardware
> was not designed to be cascaded, and DSA links never worked because
> CPU tagging is not enabled for them.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
