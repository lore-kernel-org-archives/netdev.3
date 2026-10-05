Received: from mail-ej2-f7.google.com (mail-ej2-f7.google.com [74.125.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70B3E2AB6
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234925; cv=pass; b=W1MLwCpiu0bDyyS1Dj3SD2Xfga60RspiffYPvBPiF7QAhvpUIqRhdfZ7o+eFU+KtvapDP6shws/9QdYAuu/nAwi1Ub8UCuRv05rKkxockTWI6ZNpKqo5F/u5Lhf4Ks/0cTKnOVSYyaGorT/fs12jDD8tXUUczfpEfpvjz+8zJzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234925; c=relaxed/simple;
	bh=hqIWRi6Tpux/2qAc3lWZzGdHe7GnVUNYF9Jq8zwuyMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+kfpsHiSt/KGE1lq766jmFNfB4TdGu2ptJyqbURl5euBARilTgL6ons16ZqIPMAJkuj8ANrxzuQ4J+7KQ0UVvvO8he4UtR9v1UrhVqSfV+JgWyOtjFyXjIKiSR6++KxJbP2yn1UUtqbftfKi4+3lidEu464pZ2rpAV+Ra70Kq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAFIFXK6; arc=pass smtp.client-ip=74.125.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAFIFXK6"
Received: by mail-ej2-f7.google.com with SMTP id a640c23a62f3a-c2e15e7ab2bso135501366b.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 14:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791234918; cv=none;
        d=google.com; s=arc-20260327;
        b=YCfWRDLCf7y6CqYfoV8ZIkrqN7Bp2QoxVZgqkxzRLtIApIVz4dYEhHurHSkdAQSI4R
         xQmKqpYLkv6V8tC0ym3CadiTF4tt+cUtR2UV1xwCz0D+jl7xlcLcMZVNOaMwiqMoeI71
         h61YcDj5MPy5YyCDyBiwk0WpBmQVBU7Et0e+9dItSqXHez3bt7QS0UVcUmlXTEqoxqmk
         7pW+4qWAMBlg5cs5ncpJNgHhEjC81CAekb5d8KjF4NTtQeGL9quBKnnNYQoftlFEw95G
         uymJvt0viScAozTnH9gwIjuzjymZlhJrzIXnw336tsBpADWOXbknUovlnQYZRM71rQm8
         4YIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v463Ztb7l8HkbYlND0+jy6OLKJauaplyxKRrplRmY1k=;
        fh=w6fBRQVDnKY+Pgxo+/Q+IQDw/S9XwOrL4CdnOj1rT5E=;
        b=aV+/iFpKHxGGA4w2rslO0ZmaRtJ1NpzIqF4Kwr8dFQyFjZSzBo8HSWKWzUN7YnxZky
         WAxLqlammrZTRyulq8i/6mi72cqJHtSkXkXKDJSS0ukuSSAVEflk1naDyHdUnIrbOqBK
         fQIcZpl3hl3hh8d1+LySXexGxeJBdiARSIf2Hya2dIq5xakS2yjANh+XVhj2kx8YgNsA
         DcNY4TfNJ9j8nPDIYuYuEXvkZwzWO6Uts20Yf0E35hMgpZTYTR675Jzt1iv2JneTL1el
         hVWu/k2PnKPiPf/CfygqlS0Mj+hOuczKCoq/4rQX/X9x/CqhmS+4baCuyIpMaoUXATyg
         969g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791234918; x=1791839718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v463Ztb7l8HkbYlND0+jy6OLKJauaplyxKRrplRmY1k=;
        b=SAFIFXK6PwsIHAJFlSgsJvpLZAAAaxXXJKBVyGiqvqZBQ1qV/qA02uCQqWCcTBeSEX
         t+DfKN2/e9Ktb60blPSTUhRP3DMqSr26MBhAffDKXCO1cBKLE9KqjtP3KsFv0pTyIHxA
         flHZpo7j+AX4rpp765KRTePnoaK0oWKQq+4Z+/4tcvXmUoFWPHOVeyIeOgpmiD4KnKaT
         BDj+376D567sTBCKAKvaeBqRwnuJFfD4M+QUH+ehf/lLQ6N6RbiWhGuZWAh0IPXjUlw3
         pTnp4lofAIsfNCiGgwHnH65kdXQbWx+FYypBg2Nl4EWOhIl9WB5K4to+AWXCWn/RXY+X
         Ac/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791234918; x=1791839718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v463Ztb7l8HkbYlND0+jy6OLKJauaplyxKRrplRmY1k=;
        b=ESbAEZAotuhDIOddwBKnxBsCAX3iouFOe6yi+LYN78RT2LyeKJ/5Qs7iVSwsG8kZ1o
         PhiLcr356JX6Zjoquv3/YfZ/JqrUsK6dd+M+zgSBr5IISZ4vG3sL+FFAlb9/9//wyAQ/
         MrRKDmr8IBK7ppTsHzIS2RoQzZBgQiw/z2S6TsZzOlPXVC2qRjuRuGXEpptygb0OENwy
         vI10pz5JxeA14siMN2iSkYZ/kMNjipY9VxE89IaY3OI13xf7WOOELxzxszJdNPbwlgn4
         WaAqDO47oQbijjhfpAvGtzWjn5GjO27DKkN5V3KTLx5kphJTcbVC5P/WJU4gqtZyMc0F
         Rvlg==
X-Forwarded-Encrypted: i=1; AKwUvBzz4hfJ/xPY7inpvT9TK0C5aUl6uMoPYfCAnKtzNTSfgcg0wIxghITguMaos3qmvCuyJoHccsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIU0sKENCQXbVP6A/bx34LELht0x3kxCWOZZqwXFQonYbmzYIqr
	OpzTSJa5squQfqTA0YX+afsbqQUxPyeO3FdwleMkn4u4z1t9ocgLHCEve5X1Zp1/70tz0PUr+FR
	ZIYoJQ3oD8RtmjBDWIKF4FZ9xNagnY6c=
X-Gm-Gg: AYBFou0nQsyJVUMM2JSSl64scyZFkJK1cyeLAGw+wckdQ7NCHYfgncZYK9gpa5AFPE1
	pj7iqAyFtNVkUJtg8AEi/UXtOnGZSbpk0XZf2Kcuo6GngIoCy2OZBzbWi07Ds1hZnekzm3vF8K5
	1LtfuZcGVwSVkShZmCpOLEiJzTGfw+/Bk9PV6xwIh5r1UhhblNeT4wUQS9rkp+yQTtSaStcAIXh
	E/g+CSOOh+zJj5P0EXrAOeThX5GRsQ55AHgffJGL8d7YXGfQk84CKqTQvnVXCYS80HyTeVmrP6I
	JQzjoOzJNi4U8kV73eKB4DUh0waiJDF70eOx58RPPkBRt3qgMlQUCTxnBw==
X-Received: by 2002:a17:907:7215:b0:c2d:bd95:874a with SMTP id
 a640c23a62f3a-c2e4ad79199mr1112515766b.17.1791234918176; Mon, 05 Oct 2026
 14:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922200336.2201212-1-coiaprant@gmail.com> <20260922200336.2201212-4-coiaprant@gmail.com>
 <20261005135939.01ccde50@kernel.org>
In-Reply-To: <20261005135939.01ccde50@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 6 Oct 2026 05:15:07 +0800
X-Gm-Features: AclHuK-hmC2IHermBe0I62cu-4Uo5MfOk7srVIbtbJ9DQ0aB5gykKJWKnA3WMzU
Message-ID: <CALj3r0h7j-4ZAiX67LmbgpmYCvK-Xmzd_qnYYgoBmniAW+eiWw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 03/11] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
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
=A5=E5=91=A8=E4=BA=8C 04:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 23 Sep 2026 04:03:27 +0800 Coia Prant wrote:
> > On RK3568, the SGMII interface can be routed to either GMAC0 or
> > GMAC1 via the GRF register pipe_sgmii_mac_sel.
> >
> > Add support for this selection by introducing
> > the "rockchip,sgmii-mac-sel" DT property.
> >
> > From the RK3568 TRM (Part1, Page 229), the PIPE_GRF_XPCS_CON0
> > bit 1 (pipe_sgmii_mac_sel) is defined as:
> >
> >     0: SGMII routed to GMAC0
> >     1: SGMII routed to GMAC1
> >
> > The hardware reset value is 1 (GMAC1). If the property is set to 0,
> > the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
> > remains at GMAC1.
> >
> > This is necessary for boards such as the Ariaboard Photonicat, which
> > uses the SGMII interface connected to GMAC0.
> >
> > Out-of-range values are rejected by dtschema, so the driver does not
> > duplicate the range check.
>
> While looking thru the patches again I noticed this is changing generic
> PHY. Maybe you can send it separately to Vinod? I don't see a hard
> dependency? The code can "converge" during the merge window for the
> whole thing to work.

Hi Jakub,

Thanks for the suggestion. I looked at this again, and I think the
dependency is a bit more involved than it might seem.

The PHY patch (03/11) adds the driver support for
"rockchip,sgmii-mac-sel", which is documented by the PHY binding (02/11).
The DTS patch (10/11) then uses this property. If I send 03/11 separately
to Vinod and keep 10/11 in net-next, dtbs_check will flag the DTS property
as undocumented until the PHY binding lands in mainline. That would break
DTS validation for the net-next series.

Also, splitting into separate series means each has to queue and get
reviewed independently, which I'm worried might not all make the merge
window in time.

So unless you strongly prefer splitting, I'd rather keep the whole series
together in net-next. If that works, would it be possible to coordinate an
Ack from Vinod for the PHY part? Or if you still think it should go
separately, I can do that too, but I wanted to flag the dependency and
timing first.

Thanks,
Coia
