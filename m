Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC83DE44E
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234845; cv=pass; b=bmPM02+o8QzaQV7Wuq1tz+M2sJqZK7TmELWjtu8r5yn0EMhsXh0G1NvhRIb+HwnAreeMv2u/jJslRU7CP1X98a/QNsSnaFQ8vvgXoUjMM8iufOjXBu8UKzIMY9OX4EKeBM4oZ5IcPtXOGtLEq+xDZg1H0RROUsimrrQS86stG2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234845; c=relaxed/simple;
	bh=Jg+48cepgWrDgUNaKNya1rXBAe0v3PkEajJvFhN8l1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mpx8TDzQNXHki36w5zIjN7HDlU07GGxhxRo1biE574ktoeUBZ5P/O8+yqdcgZvsYJoImVj/NCgfIl+j/gvxWXSomEQHvhcmgQkU6kHbtFcdYz4Rk1v6OvP8TDUc47f/iW1wUWlbuGPOjbzqySfB6rF+lGA1eWHTc3SDEsUWBA64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLu7YO1s; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLu7YO1s"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c1971f5efc3so132993766b.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 14:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791234840; cv=none;
        d=google.com; s=arc-20260327;
        b=dwJqo58UbnMno2jU2WJgu27fa6ZaTe151pPtT/BDURC6syUzS5mR4jMOdWCHVqwyCW
         1BL/SOt1z6EYguqfDTPy4bMqx0bYqr01Nm3rG5do34Pz2adVBBT49kdjr3DvZfmMLUVT
         zAagL6iFBOTm1ApfirHRqBLbiOtKZeVp+KPjRZBhysbe6TNZZNnvZLC6a6Z3vdqUL4IL
         BrMQDZX560548yONjtENjs8fWOoY5jmOy9Gmv89URQ2xrWh+1iBkzqdmKM41g48wH3s2
         zu5/sDgc/s75Csm8Ql6Ts7FKioMkVQ+Q4v2ZLDU38qIpEtEzLO8vfOKvucsjwSKJSK4F
         /1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jg+48cepgWrDgUNaKNya1rXBAe0v3PkEajJvFhN8l1Q=;
        fh=SoDmxOzNXK3oPtg/mFvNR9TkWILB+332K4dj27ujwEk=;
        b=aPLPmGs8aw7J29RxItqcLNNJ8ycMf0vfyWciAehdihgWJdxekfd20oiv1OmOmGcvdu
         2Mn+wq0J5geyn6w+bGhNamAvLq/rS9sZ5bYl/IOKkYQAsHHuP+CNTDM3/7MA1ImXLIg/
         mVS9wR6Gt1m1me3kXc/13q4GARPkS15HzzpS0+/u4RTKpCbhUJa3UPW7iEtiseGdrT+h
         ocuewGpMih+B4R6yBpHpvcqseBJZdvcA5U09iAIYjB31jgvA9IHhyQYt9OVah5RAo5oz
         WsXrTN5110raFt6Ps8he0MCOyEcjbVhx84fCDu46NULfD/Gbd5cynmvFABeVURrd19bB
         P+nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791234840; x=1791839640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jg+48cepgWrDgUNaKNya1rXBAe0v3PkEajJvFhN8l1Q=;
        b=lLu7YO1slAZEk+Wl6hSffZxM6Snh1lZSsi+WQAaXaQP1v5bvYdKtKSYhsF25BnML4U
         HcAmNaR1PG9wcCytglUyreRWS7KO/AQPpJ7F9m9KzqPlnUqdYVvy2gRRLgQ2BIZl03K8
         xb9tmKEGvtt8s3ek77sLxtrQ7aINnKfHP0ZyIfCvUU8nQZHqAMo6SVbKZMkI7qKXCZik
         27/FLQ6WRy15QyDVTGHvsnjOdlYnpjD5DIJb3MjNJAUU5+imo662ezsCPYAzL2qWrAtY
         i8pw5jFnjpiDUwQDMWI+OXVq/Ui0SOLBkBll3qYBsMJJ61hCONI1cQM8TJCPUXJcJl2N
         rpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791234840; x=1791839640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jg+48cepgWrDgUNaKNya1rXBAe0v3PkEajJvFhN8l1Q=;
        b=vXBpsA/bkiUyawv773jW4h2CV7uEC9U3fVNopzyYpaYN+7w3y44fHSaFs5qawVWXIS
         ClAE2vhD+pJLW7fkpFWU6ABZct1X0AWzbSmGuIYiLINXCHF1cPk4JsdsCAnUHyniltO2
         Cq8E80rJSKyvd7WDsezEJgel3KGo/Hxr4PehSkDUhDUU+DE7O2AXk+Z24yPWdMQv5UMT
         aIo1nwxgtA4fV4gMqNhk2VR/J4V4LVFdvSc/bWiW8uRhQDJqoIQwaxCgv5uCf3pl3PBh
         hdSSk/WlQF11/EZC2/f2TBG6s7xuR1tGQqbA9jZ/UGg7C2D1AOF3JplAB419PCxas9Pw
         kUgw==
X-Forwarded-Encrypted: i=1; AKwUvBxL8umgLZ4XFQ/u8J8cXpqUeUTEVLJB8pKGJ7pmGjFU6mAppeNhZr1YkT1FcsJjnmi8nMcM99g=@vger.kernel.org
X-Gm-Message-State: AFuF++l/2s0yU07/t9BMr6Tp+iNvFewFsTSfQ9bnNy9GX0lVHPEziyOf
	oCU/mUUD73OmvLtaWFC+vUhwsd47EXiw+F/8fgpKtXcLeN6sxtutvWWkYf79Ymcys6CbYgOJcAn
	rlzsOakNLdk6dZJHPj6umF8/G3W4g0VA=
X-Gm-Gg: AYBFou2Jd3oJ6/3+Is2CerboCww7/2tbwOSKbyWu3x62XcR8zFgAvjI5PefQoU+Iw17
	Kgle0kIDkXbX/+IQ3601oX2v5sPIerg9MbMKzD4XF1afXdL41iDDL6BifAs6E9zIz6UuANm+2KH
	POGePPg5Io865TJUtvHnYtXs3NLYuGFM056Xj9S2GuboI5FJ7S4xFtwR/WATzdfh6RQjFi553h5
	N4dWGTdIB3870QMDzUqjzbnvhxi/x5OLtCsv4ZLH2cjb/NQ4OlZ8jdLZjE32tv+xUEgvoselhgy
	ktHC1HMS/qoKcMdwg446jAqfuKUSRlwTN+ckrqdA0B2O2BK+HDCHuRmG+w==
X-Received: by 2002:a17:907:940e:b0:c29:62d8:68af with SMTP id
 a640c23a62f3a-c2e4b2bc542mr1047723566b.47.1791234840255; Mon, 05 Oct 2026
 14:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200336.2201212-1-coiaprant@gmail.com> <20261005135833.37376f20@kernel.org>
In-Reply-To: <20261005135833.37376f20@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 6 Oct 2026 05:13:49 +0800
X-Gm-Features: AclHuK96Q0r6tDkOyMFxRRlJTRgYT5CZFZq3doTRuVETMpVpnBIKbah20Qfa8QQ
Message-ID: <CALj3r0jgyhtmwSR03nZm4UJZ7dw6Y16X9N6-ASq9puY40zeBfA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 00/11] net: pcs: add basic support for RK3568 XPCS
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C 04:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 23 Sep 2026 04:03:24 +0800 Coia Prant wrote:
> > This series adds proper SGMII support for the Rockchip RK3568 SoC
> > using the integrated Synopsys DesignWare XPCS, along with necessary
> > fixes and refactoring in the stmmac core and XPCS driver.
>
> Someone marked this as changes requested. Not sure who and why.
> I was waiting for an ack from DT maintainers.
> If it wasn't you, either, maybe repost to re-queue this for review?

Hi Jakub,

Thanks for the review.

Regarding the "changes requested" state: I'm not sure who set it, and I
couldn't find any specific review comment explaining it. If it was
accidental, I'm happy to repost the series to re-queue it for review.
Please let me know if a repost is what you'd prefer.

- Coia
