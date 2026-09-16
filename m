Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D704349CD2
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535552; cv=pass; b=loHYYcwle2wOjc8YB3DS8+oY/cQjAwolHOzUzni3m4mquY6BYfMCLfnCNOwoBs+nqaTncngochT8TvKGrg72XbxYCMQYRjABQ04lGez+sb6+KvmE1z75ukVnXygLIRqCIpE6SxlZalDil9ulbNSWQf7dMkU04o3wnDyRK7f60AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535552; c=relaxed/simple;
	bh=xfMfjILt2qYVQAqWVFpTkowhP2xgf3MvNiTst1AwzOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M27HUXR0+8zanpFzWpmDHFzRfagiNi08qDfNJ0Wqw6NqVX4Ln5xzIzBQ9FZrbeFIeSNDiljL7fNPBsLudWlQeb+ptqmbiB5YUJ7fCliF4XzU81S+/QMOkaK0QLY5tiuUsR/EI8caZLmy2JuuC7QvJYVIjMmM8Yww6z6Vdtkkjyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoYzsp2Y; arc=pass smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoYzsp2Y"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c979c5eca8so328217e0c.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789535548; cv=none;
        d=google.com; s=arc-20260327;
        b=g0v9T8M4syYaNBoM60+sMvWzsyHQF5OLbBvNwvedw82kAqvCexcEEHYwO5plrk3E/H
         C4odufkhghdkhNZEw8Jf2dufLZHOk+Wajg8qJV5R1bYQEwEE+49MsYvUJ4n5RFXALPqK
         AHeGaD8A/csPqw7SkYYEVnW7uWvG1It4xo0pniL23g1o9XOYxH7mQlfaQB+0sLzg1r06
         6fK2tGmX91WW4ki3BNp8Du8tFlTjrA9bidPU7r4vDPbTc5vWd51NGirBHBzl8Vq9DkdX
         +gdWBokCU+pIIoq4jEojKHQo5XJE5ihQN2blrtShHbTuWqj6B4XlzA/6qvJRunDxUqzp
         3xoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EVAkoIa4qb/USGuXY22Fjfb1KpGXE+Xb86EIM7n4PT8=;
        fh=CYXJ6xzKdswS80iwkP/GBjO8tyUq+slE0OxU3E6pjr0=;
        b=C8tARgGTPM6yj4mOmTaQU50bVxuw3hFl8gLtm0yKpjI85yN7b0k92RA5h70Kx2NwKL
         lBj4BQGZBMkEe8syKuaFyQ7+qsuGfHcMIXmgdcWmR/W5RG9Q3jFQmdoRZ1TesbRftmOV
         dZQ60N8hTAM0QdWfZgh5iievPEDftyE7wI0x/juDKh/drsCw9bu35s89gCfjQjGB/aZd
         ITxdPiHZFMJWkKjYeJH2HswF7FjIW+njnBxneY+hCrXbrh+Nq2qGzPPmDR6gEE9heBqt
         2uQyrsrLUzMQmeFCZ2nIQeTt07Zqz2PxSWBQQFFTyhbdecNTSqjgO+LJz7Et95H46FyE
         YpxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789535548; x=1790140348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EVAkoIa4qb/USGuXY22Fjfb1KpGXE+Xb86EIM7n4PT8=;
        b=XoYzsp2YhnEj9tlW4XHgn995P2na4t2gSWWxk2SiJP8ad7mKThT4Y2a8CWDzf8C1Yq
         SrK6GhePfogTZkYeMNs+qudtEZCaHxoyZzh2l4BjVYrdsUC+YNor94INAd7cFvbnqkC9
         Ap7ibXqKgl6H/dBqrZLfL6jCQ0/pms6nLa6G6W+XeO2wm/uOpUm1pcgsDAVCcmlsoZ98
         2qzETLTUpMqnw7ayJIpBMm2PTDedi64KyixAtjwqd511aLIfxZ4V7dxzixwwZLpbZ5yI
         vybsmFdHC903hzXM9NsdCqWc8FOusttxOFXnLnMFtSEoH5CHPGZu4Hux4VAtPHi5ZKoE
         A0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535548; x=1790140348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVAkoIa4qb/USGuXY22Fjfb1KpGXE+Xb86EIM7n4PT8=;
        b=SYl6ZM3lUDtMSryKUam6bTSp/RhJflxMQ6y4V/7Lirhfs4LmVHByRl7qTjnn8jE2XY
         euYcPanvkpC9L8I8IcFSPXuyXntflewWVyG7M3SeTP4Bf69xU+fffCe3nUEkmAnir4XP
         FSSK3q2VgaTgij1yTtylv+a5SkpOgQxtdn072mFWHpFWGsTm5mo9hoib1o4inbxG2cQh
         pJbRQyXwrh6DDkHfVIm9mQIyz0AROkGu1votUfGqh6+D6ieQyX2pBJS37Qs4AWwy6sQE
         hIAZS2QqGWzjNNep9WbJYUM2XLXnVUbHB5ZSffKDYi3eKsltemtdCBpnaca9hS9Njg6r
         jjkg==
X-Forwarded-Encrypted: i=1; AKwUvBwAiSXdIhKtsEP/CToYokyqjIO0o6dfV75HjGEYxHTbdyJFi49IuDVhy1B03zuWVXkxU6SwMlM=@vger.kernel.org
X-Gm-Message-State: AFuF++mmrzMbX0p3+x3zuX+mRgYxr8sqiazuirB9WfynXyLltXJyIs7g
	wtQpsgvZTxEh5wE7+f5XuoCbAVXoN8VJ+hqGdTFwNmMzvxTyF4GuQrFuNTzV9Tg8BlZMdRJ0V6c
	cchH0+XsqzrsekIyHex2kqn44H/112ZA=
X-Gm-Gg: AYBFou3Kamsl6mIUbqEADVqRIAGTfpXNUGJaCvcqmMSxF7NS5YclVuuNcHWdWYZscGu
	ZNeHjoXwt9U37S4nC2i8M6v1Bp5l0yZTXuMK9ntwcXkwGxQWwnd+Ls88ejSOtBMPSyd3dYKX6jo
	XVik9P/c+c4oTiV0hDvpSAqHIRxgdttOiEio4XH8mtgn0xKPZbRNcBXMUh/lY5WuwHGYb9NUNSk
	epp001W//O18dvz1gAk1zhlOjDLxC6AnyNmsk6rnk+K1ZnJiXKq0G+cNQ+YEl4U8FjQRlYcqxKX
	Tkzv1pv8pzs52jZ2xfT4PRlvKJLenf2fWaKjqHT0zmvvT822uFJ9Cdqpt24CZjIRHnmg5ko/ey6
	yqyEELjDwfoUl9x68QhZJAWGmxfAU6X7GevUqwwQ3Zjo3pO2jIsp1rdU7T9IEF2XzI8NftDz6HO
	uHFgf9vpB4NUFPKKUeJ9Np47hfmfARpLG5wRSEUzlJdY2w
X-Received: by 2002:a05:6102:38ca:b0:79e:caaf:de9 with SMTP id
 ada2fe7eead31-7a02acc855amr1205112137.6.1789535548385; Tue, 15 Sep 2026
 22:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916044119.475666-1-alastair@d-silva.org> <CAGb2v64HZoqBscyKTkTin6DnMv5_kZpBxoS+cm7aYy09pRc7hA@mail.gmail.com>
In-Reply-To: <CAGb2v64HZoqBscyKTkTin6DnMv5_kZpBxoS+cm7aYy09pRc7hA@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 15 Sep 2026 23:12:17 -0600
X-Gm-Features: AcwNN1UNecxTndtUibx9ggVDgut-WAi8ElAvEyyyzRhfanBmsu20NosAEZK33OI
Message-ID: <CADvTj4qRMviM=KXinCKi657pVC_kj7Kt1yizW_EGDu4m7VKQFg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: Add Allwinner H616/H618 EMAC1 and AC300
 EPHY support
To: wens@kernel.org
Cc: "Alastair D'Silva" <alastair@d-silva.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 10:56=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wro=
te:
>
> On Wed, Sep 16, 2026 at 12:41=E2=80=AFPM Alastair D'Silva <alastair@d-sil=
va.org> wrote:
> >
> > This series adds support for the secondary Ethernet MAC controller (EMA=
C1)
> > and the co-packaged AC300 Fast Ethernet Physical Layer (EPHY) found on
> > Allwinner H616 and H618 SoCs.
> >
> > The Allwinner H616/H618 SoCs feature two EMAC instances: EMAC0 (typical=
ly
> > used with an external RGMII Gigabit PHY) and EMAC1 (Fast Ethernet,
> > connected internally to the co-packaged AC300 EPHY). EMAC1 uses a
> > dedicated clock control register in the syscon register space, which is
> > accessed via an offset index in the DT syscon property.
> >
> > The AC300 is an integrated 10/100M (100BASE-TX / 10BASE-T) Fast Etherne=
t
> > PHY communicating over MDIO at address 16 + phy_addr. It requires
> > retrieving factory bandgap calibration data from the SID nvmem controll=
er,
> > managing internal power rails and clocks, and optimizing transceiver si=
gnal
> > parameters.
>
> There is already a series from James covering the same thing. Please chec=
k
> the mailing list and possibly our wiki (linux-sunxi.org) to avoid duplica=
te
> work and subjecting the maintainers to the same discussions again.

See:
https://git.kernel.org/netdev/net-next/c/783f6f1fdcd5
https://git.kernel.org/netdev/net-next/c/6cc2fbceb49b
https://lore.kernel.org/all/20260915-submit-h616-emac1-v1-v2-2-322b32e40eb9=
@gmail.com/

>
>
> ChenYu
>
> > To ensure reliable link establishment and MAC software reset with the
> > internal PHY, dwmac-sun8i is updated to defer MAC software reset until
> > sun8i_dwmac_init() after the internal PHY has powered on and begun
> > clock generation.
> >
> > The series is structured as follows:
> > - Patch 1: DT binding for Allwinner AC300 EPHY.
> > - Patch 2: PHY driver for Allwinner AC300 EPHY.
> > - Patch 3: DT binding update for Allwinner H616 EMAC1 and syscon index.
> > - Patch 4: dwmac-sun8i driver support for H616 EMAC1 clock index and
> >            internal PHY deferred reset.
> >
> > Testing:
> > - Tested on physical Mellow Fly-C5 hardware (Allwinner H618) running
> >   Armbian with sustained 100Mbps full-duplex network traffic (DHCP,
> >   iperf3, NFS rootfs).
> > - Device tree bindings validated with dt_binding_check.
> > - Separate SoC and board DTS additions will be submitted via the
> >   linux-sunxi tree.
> >
> > Alastair D'Silva (4):
> >   dt-bindings: net: phy: Add Allwinner AC300 EPHY binding
> >   net: phy: Add Allwinner AC300 EPHY driver
> >   dt-bindings: net: allwinner,sun8i-a83t-emac: Add Allwinner H616 EMAC1
> >     and syscon index
> >   net: stmmac: dwmac-sun8i: Add Allwinner H616 EMAC clock index and
> >     internal PHY support
> >
> >  .../net/allwinner,sun50i-h618-ac300-ephy.yaml |  79 +++++
> >  .../net/allwinner,sun8i-a83t-emac.yaml        |  14 +-
> >  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  65 +++-
> >  drivers/net/phy/Kconfig                       |   9 +
> >  drivers/net/phy/Makefile                      |   1 +
> >  drivers/net/phy/ac300-phy.c                   | 331 ++++++++++++++++++
> >  6 files changed, 486 insertions(+), 13 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun=
50i-h618-ac300-ephy.yaml
> >  create mode 100644 drivers/net/phy/ac300-phy.c
> >
> > --
> > 2.53.0
> >
