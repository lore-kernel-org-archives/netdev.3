Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862237F337
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775538; cv=pass; b=B3DyHbGSNUsRAYaWTF122ssRY7nyTGcof+Gx0dBxiuvU74y9BbsYdCA6nsadvYzZMGzOk9ZWpdUcuoxQg1igCWdVzcFhXiR2lFA9pI1Nn9Taznd8kLFzec4xdnJFvBk7VJ7kVVrqdcIHj73U6imlhY2I+2eSqNlMAPIJFVrUnmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775538; c=relaxed/simple;
	bh=pVJ/u9SrHtpIYcpsDllTKqpayBtCBNOqrDA3wdvqLR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZtsogAo2dTnpnTxvM5+LaJbSUjN3kC7RvmcksJdT3x+yscsNIJO0Q/4VlILIABlAsQM576xu2dbiri41HfJbvwLVqdvWnc4l8Z5t2bivMVxxV1HqYv6pupja8RYU3AKhH1p+d+VUuX587dxCZNc7dXbOmgVDeBKqmARqbb4rAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjb7+6s6; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjb7+6s6"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-963a722ed59so863619241.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785775535; cv=none;
        d=google.com; s=arc-20260327;
        b=QjyQjjm4m/EaGaTVzBBUO+u2uy3sVqzxLVQqBI+x9qlbXIi7/WRI20EAGO0QxY3a4A
         fYr6RoVb5Kp7YGwgYBDGev6AZscZbBRlEIKOaIhYIbuQsU7r3fCqRfuXuoZRN7ldBfGe
         e+KRugXdh0rx8l1pdxyP08EEW6ExQqk3a2IL/cGGwN85zoaYG1kTDcv4zN90MAoTkqI1
         rtDHp8d24cx8nZjmRms+KV27iRMFqhhRcSpaESGy4UH6mkgRgq4OYfZSD64JUuwe1IX2
         5LkqldYuLtsVh9kO31DB2jIMlXBReuYN7PTuLKIt7YPr/DjItRQC6AjBJKTJHQdD/t7k
         vy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niqvePJlDSQd28Qyc7y5gE/vwAYMmaOcsvRZCG9PwY8=;
        fh=smK2X5Pqiz6hzYtQ02nvoMO30gs1MaPwH4qoCPMYb9w=;
        b=JAB1HcFgAk46kynulu7Rj3jau+v4dyjA+aZzgKz+bO9yO5VEKeZX2GKEm+dZ5Hh2nq
         OiOsvV0oKrtgRFCI3vOtBGA4MTcoAQfa+KxgRtNnJVv2gWov9AueVgqbGPiHb4nOwOR2
         Lot/txNS2sbN4BUkCO1F/60FrMjZSwYkgCCKVLIMakc5elpp4UzMoTIJE+Jeq5o0pxpv
         JbSLwjEKKK0f/b1/PA/Bnysv0Px/pqVPlwSCKUV1d5Mxs+9XR50kBVJHRzcRDEvZT9sc
         D84a8+0PnBWOq4Qxpn9KZAicJy1w1OCbLMlWru+ZU5/8g5KCBa41QPbfDuh7uP5S3i5S
         BTwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785775535; x=1786380335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=niqvePJlDSQd28Qyc7y5gE/vwAYMmaOcsvRZCG9PwY8=;
        b=Jjb7+6s6TLFWkOKejxwVE79v/pHkKWcfRtDNHkt49mRhfkUcOV65hnXYgFCgxlRbYM
         OcgqZe3TxIn664s4+7YrY/E5n4QRGLLgYj6J9Vfz7SgRICyQZqIyTvWt8rW0MOLY0nlc
         LlKqLm8Vzu0ip+aSFCUq+gyJJvJPvhMpcZobSUDu4WQSjoAX15+QnRoARTaBVejBzaGO
         xbWR4SavD+rEoi/M/wf/SGEzW4HKYn4xaOZpprSjsUr5vua4l6B1VUsN1aI5tH5v3Rss
         AaH3sQXP1H7gxi4lCQwoZjXD+A1iWZedLFs+aghC0X2OgtjnjEqlsKI5czbza+5Noyfu
         q37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785775535; x=1786380335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niqvePJlDSQd28Qyc7y5gE/vwAYMmaOcsvRZCG9PwY8=;
        b=EBcejFZDa+AclgRKpsinPmjvt1ArGV6Zm/YHwZa7eb7D9e4BClfU92mxgp1paIRSxj
         /Aqk8HFsa36RTxudd8z+njEbZw4RFjD56h6qQSsB/n97KloIGX8XugBzX+2fjqRLSg2w
         NH+BMwPDrC69Z6/XkfK1Ikc9hfMFFHfp8XlEW7nV38rO5nwb8tWmkaF0nmiPX2dPaCKw
         Hcn3d8mTaMgOYfARmxea1au4m2Tuvxh/uB4D8ob6QoWgnRExZbCI5EXwHkChRbH5yOWC
         ASYD2EoI50RMh3e9CPBjwnGCiKzFuZL1TEUvYjE+99S/9h9ilCwtjUKeeZQ3AWYki2FG
         CmyA==
X-Forwarded-Encrypted: i=1; AHgh+Rph193Cq534Tjxc/9welnzpKXRyLsrCnfNVAFNp+X29CFewJhuEZMa8tC5lHvL6TrkOrPh8vR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ9zeAUZGMJa3/yq8BGUG0d3Ezfs3cNZ1ZpMLVDCLG51QnV46v
	y1LyV/sGeT+h7VgZp2SlMX/N2HDuSdBXz3ao72k6Ujj/qxNhXp3epVNGxpa/RBHE6cL5sEkp86d
	Bb9zsESWivXqULjJtipJutC8rKWVnzBA=
X-Gm-Gg: AR+sD11DdLNpfBW1MRyU9Hv3LPqaAbr7jPNmZF77vHqyZtPYFFkraQ66vdpaieqaDCD
	wgqDuoUNlZVx2pEoWzTU2dI56exZeVZAK/Yc5vcIXFGgvK8xlhkE3DH7iK1lkkb2KZD9DvbvYLj
	ZYXe15wm20NV54lR8sOVi5mUrmF5cpwfqUvvDYJGhbsJRwq+k5z72UZB5ZX3tXsZh2y5W9+D1Af
	JBC81mRU1I6jgfDwQ1Ew1y0EslFMnHy50qbktfyQiN/I11+A37irz7FxIa2dJPJQzhudDjnlDEZ
	b6DOUxXyCmv5mKwWDAYHM6Lli4x2LMpmGlukm3ExKq4dnqYvDb12OkSAoVKH9RA9OCHX6AHXyHi
	1A1YU2R3fE8/0bi+O2IaCmMOCy3I+Dn03iaX+N40HKZrlcwon4n9FZuifMfkI/JYCGqq4eR1GwZ
	WgNiNmphdwWQVTYlRWAhV8Yl99sKZ/R1hBzNX0
X-Received: by 2002:a05:6102:5e82:b0:73a:128c:4e3d with SMTP id
 ada2fe7eead31-75b22b6375cmr7983333137.8.1785775535469; Mon, 03 Aug 2026
 09:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-8-0a53cd9e21cc@gmail.com> <2c0210b3-2c68-41f1-aa33-3f1693454849@lunn.ch>
In-Reply-To: <2c0210b3-2c68-41f1-aa33-3f1693454849@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 3 Aug 2026 10:45:23 -0600
X-Gm-Features: AUfX_myHhqSCOlS18NU3-rnIJB_yJDCs5Z0LNUdIv6o7tNasY8YkhUjPJd2Ilvs
Message-ID: <CADvTj4pfNFVGrQV86T7X+nZQYUamxEYLLWuxVXk=av0da_XocQ@mail.gmail.com>
Subject: Re: [PATCH 08/21] dt-bindings: mfd: x-powers: add AC200
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>, 
	Richard Genoud <richard.genoud@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 7:18=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +            ethernet-phy-control {
> > +                compatible =3D "x-powers,ac200-ephy-ctl";
> > +                nvmem-cells =3D <&ephy_calibration>;
> > +                nvmem-cell-names =3D "calibration";
> > +                phy-mode =3D "rmii";
> > +            };
>
> What do you mean by an ethernet PHY control?
>
> I assume this is not an actual Ethernet PHY, but some control logic
> around it? Where is the ethernet PHY itself?

Correct, this is not the Ethernet PHY itself. It is the package-specific
sideband control block that must be configured before the normal Clause 22
PHY registers become usable. For AC200, this control block is accessed
through the parent AC200 I2C regmap. For AC300, the equivalent control bloc=
k
is accessed through a separate non-PHY Clause 22 address.

The actual Ethernet PHY is a separate device on the MAC's MDIO bus. The
shared PHY driver for that device is added in patch 16:

https://lore.kernel.org/linux-sunxi/20260802-submit-acx00-of-dynamic-v1-v1-=
16-0a53cd9e21cc@gmail.com/

The later board DTS patches instantiate it as an ethernet-phy node beneath
the MAC's MDIO bus and reference the appropriate sideband control provider.

>
>        Andrew
