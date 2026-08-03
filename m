Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607E345EB4
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775934; cv=none; b=G+3QNUD2zKCj2JDOqE0G9TWrwpcWmsqDQ8j0he3kbA1hgaFLzipv+X43DVwcn+ntlsSsvKSCJL+aj0gXOLPQfkOfBiZJudSVczFXujbICPOMnbOQ4q8aeMfuqsNgIL9KkL232rH14hnwpRIfW9qQHvT1rGK0EhgC2matPka72x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775934; c=relaxed/simple;
	bh=9hFWHpMr6667KTRSWMmWOov01VOWplUFcHlU43Po8Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/pFDKteN9oVsuV9zf4pltrJMFIEdmR5qmz5PRdX8S+BqNrMY8poecWGGUL7as6caf/Y/Gt/O0Q7g22FC5CiTOOhdD3RnrgLlztvSqOx2Q3mpRGnuyXgRMW4+wmhSBa5SoLdPb5CypM6PVzyFHmZijfCO+8LlZMu7up+1+aDmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4ObqZm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4ObqZm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAA31F00A3A
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785775932;
	bh=ktJ1TUfqLx16vP/MAvZ075WUJwVncZtbcK2MP7W0fJA=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=W4ObqZm1721yih5Cc72KTg1SNORcLauLEAeTR/pQvfulljFV1MY786WAqOG+xn40r
	 Nm6krj9Zt3xk+1UjcfnwqMXNgD5eKdkTOopLe6stmk4hDhhDo+pnbC9woAg+LNhCEU
	 rfOXG8bFLRNqvzlg52wWAsCZKeZXzzsFdGKuftIB4RdoErFBA6IpAs8GvfEfVtD0yT
	 DhNz6Rmwo19vJ3v461khXi2B3D+UUxZ8Sr0FXMUTiYY9fXY8So5/RbjYmIoC3rlDmt
	 zeYYhcpO9uCkfPhrdg0r6h8cpqA0QbjEIp0DoSaTgZbDBaLOxjRM7OGX/eWpQiklrP
	 fO7+/JOLtU5hA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so3416771e87.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 09:52:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoRbc/aiVGf34pp4vwuuquUqt6sPrLnnrfH7lGB52Wlb7iQZXa/SFqTtY/X/ZiJGNJiq2WJqN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiPtDA6OU8oA4eCHZd1Cdqme07XibCESM07i/OjKUHtOdMxvn
	yJggkAUXK2w7K0NMjmnbU4eyNHKp9p3gw3EM/C2X7tQ86IuJxZ6WRvkLKLpw8yZRjAidIy6TfwE
	SxuCLny6zWRdAnWu0TWcbAzItuOQkjiI=
X-Received: by 2002:ac2:5218:0:b0:5b2:9c0e:a2d9 with SMTP id
 2adb3069b0e04-5b2e4f9dd16mr1400790e87.65.1785775931139; Mon, 03 Aug 2026
 09:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
 <20260802-submit-acx00-of-dynamic-v1-v1-8-0a53cd9e21cc@gmail.com>
 <2c0210b3-2c68-41f1-aa33-3f1693454849@lunn.ch> <CADvTj4pfNFVGrQV86T7X+nZQYUamxEYLLWuxVXk=av0da_XocQ@mail.gmail.com>
In-Reply-To: <CADvTj4pfNFVGrQV86T7X+nZQYUamxEYLLWuxVXk=av0da_XocQ@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 00:51:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Wo+WG47jF_vBUOwv0Vw1SDygXMdBgpsy3R1AQ_LLfHw@mail.gmail.com>
X-Gm-Features: AUfX_my4aoD19Jk3-8CcfeDfaoI0T_9zWEBW-1SE8UXOLwMz9Yfo_iLW9hIPcwI
Message-ID: <CAGb2v67Wo+WG47jF_vBUOwv0Vw1SDygXMdBgpsy3R1AQ_LLfHw@mail.gmail.com>
Subject: Re: [PATCH 08/21] dt-bindings: mfd: x-powers: add AC200
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Andre Przywara <andre.przywara@arm.com>, Richard Genoud <richard.genoud@bootlin.com>, 
	Maxime Ripard <mripard@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	mfd@lists.linux.dev, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:45=E2=80=AFAM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> On Mon, Aug 3, 2026 at 7:18=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
> >
> > > +            ethernet-phy-control {
> > > +                compatible =3D "x-powers,ac200-ephy-ctl";
> > > +                nvmem-cells =3D <&ephy_calibration>;
> > > +                nvmem-cell-names =3D "calibration";
> > > +                phy-mode =3D "rmii";
> > > +            };
> >
> > What do you mean by an ethernet PHY control?
> >
> > I assume this is not an actual Ethernet PHY, but some control logic
> > around it? Where is the ethernet PHY itself?
>
> Correct, this is not the Ethernet PHY itself. It is the package-specific
> sideband control block that must be configured before the normal Clause 2=
2
> PHY registers become usable. For AC200, this control block is accessed
> through the parent AC200 I2C regmap. For AC300, the equivalent control bl=
ock
> is accessed through a separate non-PHY Clause 22 address.

Basically, all the PHY behavior that is normally configured using strapping
pins on a discrete PHY is done over this I2C channel.

> The actual Ethernet PHY is a separate device on the MAC's MDIO bus. The
> shared PHY driver for that device is added in patch 16:
>
> https://lore.kernel.org/linux-sunxi/20260802-submit-acx00-of-dynamic-v1-v=
1-16-0a53cd9e21cc@gmail.com/
>
> The later board DTS patches instantiate it as an ethernet-phy node beneat=
h
> the MAC's MDIO bus and reference the appropriate sideband control provide=
r.
>
> >
> >        Andrew
