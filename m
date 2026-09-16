Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483313ACA46
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789534606; cv=none; b=Zko5HRw3eBY0ejtOtOHVR+hobqJgxHhTxA6p6e+MP+J3qPYX9BX5fyutKXGvxk63aXZH+2SJX4NY/ilpFxFUsXpJnJymQFS3T8WioccUjg/xWM2yz7LNZW63xxhRmpGKYCjykheFNFCn11Pd0rTKarHPxDTseGbhGPyJIf7rpVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789534606; c=relaxed/simple;
	bh=4K3h3Rw54RjSRFKh9ol4ea6kBKJbtFDgm5hxnraDt+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KubBlAOvHMecDdwgXc16KuWno84HK12aYbA8pWbKVmZe/BIfnLVUYRzzov9WpLaARErjhekNQQKaLz/qFAMoT0n1AhhPbCGc/9kkdL3GBEwvjI5MNFLPmA8xrWG7pQlQ2g+6Qfs5UMeaP44x6SD0YaSQnv7h2mWhSXSFHE1TJpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKBiGKYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKBiGKYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CF01F00898
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 04:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789534603;
	bh=C3tZpMYh27w/dm8oruC2ikSebTIKfee6UIDxXeFEmbY=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=IKBiGKYLLMUMavvEOwhr1hUltwScpJ6Nn0CirRQciev/9NbCf8wATGwFr0bjP8FAb
	 X9saMjFq7ZgPSBnHvwFrOsmZWaa/uGHZM9fpvJSGZhJ5NnUxt23w+DBBO6vzYHZENW
	 evNBjpGoYpZJAZ9vA5nYXvPPFUHFvdl7FjBm/0Rf2xonpuWRoVKRc/+2Tperd3G4VO
	 6P7MWC1GVbhK3PMPOtcmZSyJ2Nqq08w7pQSl4XqEY4HIctrWiklKQyGaRgNMLbrfne
	 B26cCYCOU5OOgRtaW6MdecgGVZBbwNGFr1TwbYLnk7hkaCmDaA7Ppr8OvGVIWbRhRH
	 2ki4pk73sJWwQ==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16c72so492417e87.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:56:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwfiHNGHNFmns/SvUG25KremhBstiQXYGZAiNml6sxMv39WOKCmiVv8xQmXqnKdxu59j+j/jXs=@vger.kernel.org
X-Gm-Message-State: AFuF++klcMvmr6MIPdf0cdHFrbJS1Hbkivp1X+aX4Ws9mTPdzkwQNQNw
	71aql9OoGvVP0nhyVr1HdpvhWYOxC3XF4ESBE2UFGyQnodplhw0HDuu14gY+8JrzZDde6/EB1FT
	z6eW0kPEQnfwVuKMoDsvIonUcj0dVqug=
X-Received: by 2002:a05:6512:b87:b0:5b6:1a7c:fd86 with SMTP id
 2adb3069b0e04-5b8b6652ac6mr244953e87.44.1789534601132; Tue, 15 Sep 2026
 21:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916044119.475666-1-alastair@d-silva.org>
In-Reply-To: <20260916044119.475666-1-alastair@d-silva.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 16 Sep 2026 12:56:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v64HZoqBscyKTkTin6DnMv5_kZpBxoS+cm7aYy09pRc7hA@mail.gmail.com>
X-Gm-Features: AcwNN1UfVwvH_TTNjxWxYFWqmDiwY6R0M22kYyQVnOwJYHGWocQFI_cDBu05Ups
Message-ID: <CAGb2v64HZoqBscyKTkTin6DnMv5_kZpBxoS+cm7aYy09pRc7hA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: Add Allwinner H616/H618 EMAC1 and AC300
 EPHY support
To: "Alastair D'Silva" <alastair@d-silva.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	James Hilliard <james.hilliard1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:41=E2=80=AFPM Alastair D'Silva <alastair@d-silva=
.org> wrote:
>
> This series adds support for the secondary Ethernet MAC controller (EMAC1=
)
> and the co-packaged AC300 Fast Ethernet Physical Layer (EPHY) found on
> Allwinner H616 and H618 SoCs.
>
> The Allwinner H616/H618 SoCs feature two EMAC instances: EMAC0 (typically
> used with an external RGMII Gigabit PHY) and EMAC1 (Fast Ethernet,
> connected internally to the co-packaged AC300 EPHY). EMAC1 uses a
> dedicated clock control register in the syscon register space, which is
> accessed via an offset index in the DT syscon property.
>
> The AC300 is an integrated 10/100M (100BASE-TX / 10BASE-T) Fast Ethernet
> PHY communicating over MDIO at address 16 + phy_addr. It requires
> retrieving factory bandgap calibration data from the SID nvmem controller=
,
> managing internal power rails and clocks, and optimizing transceiver sign=
al
> parameters.

There is already a series from James covering the same thing. Please check
the mailing list and possibly our wiki (linux-sunxi.org) to avoid duplicate
work and subjecting the maintainers to the same discussions again.


ChenYu

> To ensure reliable link establishment and MAC software reset with the
> internal PHY, dwmac-sun8i is updated to defer MAC software reset until
> sun8i_dwmac_init() after the internal PHY has powered on and begun
> clock generation.
>
> The series is structured as follows:
> - Patch 1: DT binding for Allwinner AC300 EPHY.
> - Patch 2: PHY driver for Allwinner AC300 EPHY.
> - Patch 3: DT binding update for Allwinner H616 EMAC1 and syscon index.
> - Patch 4: dwmac-sun8i driver support for H616 EMAC1 clock index and
>            internal PHY deferred reset.
>
> Testing:
> - Tested on physical Mellow Fly-C5 hardware (Allwinner H618) running
>   Armbian with sustained 100Mbps full-duplex network traffic (DHCP,
>   iperf3, NFS rootfs).
> - Device tree bindings validated with dt_binding_check.
> - Separate SoC and board DTS additions will be submitted via the
>   linux-sunxi tree.
>
> Alastair D'Silva (4):
>   dt-bindings: net: phy: Add Allwinner AC300 EPHY binding
>   net: phy: Add Allwinner AC300 EPHY driver
>   dt-bindings: net: allwinner,sun8i-a83t-emac: Add Allwinner H616 EMAC1
>     and syscon index
>   net: stmmac: dwmac-sun8i: Add Allwinner H616 EMAC clock index and
>     internal PHY support
>
>  .../net/allwinner,sun50i-h618-ac300-ephy.yaml |  79 +++++
>  .../net/allwinner,sun8i-a83t-emac.yaml        |  14 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  65 +++-
>  drivers/net/phy/Kconfig                       |   9 +
>  drivers/net/phy/Makefile                      |   1 +
>  drivers/net/phy/ac300-phy.c                   | 331 ++++++++++++++++++
>  6 files changed, 486 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun50=
i-h618-ac300-ephy.yaml
>  create mode 100644 drivers/net/phy/ac300-phy.c
>
> --
> 2.53.0
>
