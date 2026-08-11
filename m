Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2646825B087
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430271; cv=none; b=YvWQHYBaDNcM3pH6UQgS+JlCZX06G7HvX/3+ceRqcHFYYtV6s4XRxYjXGD2GutKJZBCs7JDQhJ7o+mtl6v9WXkuEBfyGbcNSMC5Fkq+oTavk9pY0OnfFeJb6rJybFJPHMguqyEyZ2wk0NNt6LL6bNVpMX3Q/MHyvmn3U222Jlv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430271; c=relaxed/simple;
	bh=tBLr/zr3YozGXbYbeO35tZJWvBmZWp1KaYLtzkvre+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVyCW/H9m8/xG+s2IJwoC3skmNen0uZCRnL5taghsHJpxMB0MKXzasbhvi0VxWV3AaAHMzYo0s4WeMI6j7rc/Q6SJgZF/yjzUPB1VQMN5WdCWkhqctNCeoxOjcGSiRS/NQFXzkfJ67d7S908DwjboSP0EOFIHu4bFSX1q7tRcqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL+O7hJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL+O7hJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20A61F00ACF
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786430257;
	bh=tBLr/zr3YozGXbYbeO35tZJWvBmZWp1KaYLtzkvre+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NL+O7hJO9q1BQS+zRadlFZYTgD+/P5LwFY7olRcT46/Q+sTlX67mt/71xscXAmoaV
	 /cBkAi+l/obapKC+C2W4uSb0XBlaDEiF5g099OQ+mFmLp61Aklr34v5sW0LFCJ859M
	 /ahRNt1cUgborCSwT9rGFZBGjZXLB2czg1Y8jooeckj29UnK5qFFS3lo2Ly30SJhx4
	 0nZoaz89PX2YgXmba7xfSVhahSMKoCCWGGLexA9qCfSSjV5MkrOaefJ47JS6FVHwNH
	 vZ9lJ7Nd2t44QVv0DW5xNX89QNmp6RN63M2A89f8GjhbCdJYQMsgzsqjFWGqS20/MP
	 w8d1veoUR2Qpg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b15c6fb864so1947922e87.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 23:37:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpZXvIiBY5+SO6rCdBeY9nt94i7pWrSmjEAIhoRpoWmuqNFd9H/5Xdm+SfrEkiXPlH6tOX3pQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjACIpDKZFPSFaQPpYCYX6q+Tu1GWcP4HZF1iZ5ank9NZ66C6P
	gK2EKZLDBIp5wa2BPFe4F+k5uRbbDxMTo9hXkywN2UwQBq61WdAH5PADBcCwqO6QaOWuRCgkQr/
	phL+Q5Z2faawUGZ7KYTgsPic/z8ntFYg=
X-Received: by 2002:a05:6512:2208:b0:5b3:e52:9ff7 with SMTP id
 2adb3069b0e04-5b44866558emr181770e87.51.1786430256514; Mon, 10 Aug 2026
 23:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810131032.455435-1-christophe.roullier@foss.st.com>
In-Reply-To: <20260810131032.455435-1-christophe.roullier@foss.st.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 11 Aug 2026 08:37:24 +0200
X-Gmail-Original-Message-ID: <CAD++jLn9z8oLGZ9UX=KhS3-OWou2pq0+dLVytWNf3AogDPgH=A@mail.gmail.com>
X-Gm-Features: AUfX_mxIsECvNT5meQ9IAG2w79JxujnWbutJsYXdfanjQzB3zUMk7zQ6F8rMX8A
Message-ID: <CAD++jLn9z8oLGZ9UX=KhS3-OWou2pq0+dLVytWNf3AogDPgH=A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Some improve for STM32MP2X
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, antonio.borneo@foss.st.com, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:10=E2=80=AFPM Christophe Roullier
<christophe.roullier@foss.st.com> wrote:

> Add PHY Regu for MP23/MP25-DK
> Increase deassert value for PHY Reset for MP25-EV1
> Remove commit "net: stmmac: manage error case during stmmac_dvr_probe"
> from my series to push in net-next networking tree

These look good to me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
