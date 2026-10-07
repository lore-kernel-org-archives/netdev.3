Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC284B4058
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399591; cv=none; b=KiXzLDuzyw2C5WzD8a1Cx8cShZN9dk6G/OEmtjmOi9UukegCUV+u9t+POBG+UfTbEYdrvFT41C3LC+wv8GoyoFU+awtZ1z2l/MHCBSS22R3I0UlCOHeAze+/BBCKt17ciH1Yy52psxrZ6IaYmwbg11J4WChIX/6nwQkq/2CbC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399591; c=relaxed/simple;
	bh=tSe0HwHwGaHBzXco/aL/zhpyFQADcXLLOcWq3KMpRAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sk4b7gIBJbb3BaND0/2jL5+K6cJmJdVMVbDPOfwmcPvu5HSsIlYoM0L/vfnVMnpHvILw/xPZ4FkwS51bjgg7nwByez6cLKrpAmBb51Vr8RjzAv0K0UG8NEqLC2HYlE3aZ19/w2ZpTl4eVvBmQLbr1s++WBWMHD58WPMQyAltidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=gmtKHQ4I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TytvURHf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="gmtKHQ4I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TytvURHf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E4E28EC04E3
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:59:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 Oct 2026 14:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1791399588; x=1791485988; bh=eu
	67nKrl8thChRWWxwnPMWk5WRVt8b81znEUdh6QWzI=; b=gmtKHQ4Ite249oRZBS
	R/OzwNbgLhQwT1YNACvTb2P30P0IV+uxx0UfWwkksE+LsjiyY6ZitI1y1oozRovl
	VthxrmiB4QIyOj4kF7wbMVBPTELYVMoxxzycY/EALGKmViVzzn60B0e98RLxKOW8
	uoSHdSb9JDzGWX6oTfeQ3cQ6i4NFC3TYAZ5aB5BVF0RY2zEzI24c6Mao99rm5RCA
	0FyGzE1WT+zulcZC8IyZNQ3vd+QAKYnHmQTE8iKmp5jsE2h6wFCUC58f9KKTT6ht
	hYravdTqIYvy6/Ig+pNHbntHQioC7ESB61RBJqRASnXso07wxPZFdhvpi7gFpQB1
	iw4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1791399588; x=1791485988; bh=eu67nKrl8thChRWWxwnPMWk5WRVt
	8b81znEUdh6QWzI=; b=TytvURHfoL/csuhN7TAhmaWtNr9PJa+9GGJ5drh3Mv+2
	+Z7aed5SRbNXl0CKW2ot5syivNhejjfmG6OQF5/eOBQXp3F6jq8UzaTa1PpOfksx
	YQ1qrZUlIJPEixlrORdAgKk3YVODaVuGCdG8N6OtZ6yFIs4doN3Vf7G3arIWCkgg
	FpYNIPJiQZQsQsrPj+uJvd4XalXCrSvwDpBtgDXs925vTx3BdUfOHtc/N987ZGwd
	pNjBg7Lmj0HQMaCU3bnmcx1qhMWaro09EEG5xWTQOlQvidB047PoEGJVU5DA3gO7
	YS+BW//5XXwo2S0MRqeGM9DxO6tZn1hTE3hsz2bxVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791399588; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NNgjBF2Ym8ExxM+K0JgylOJmIdIswUKAybXYLfxI4F2ILD+
	VYGSVwAhZerMLb1oZfY20sELIcT0gH7OHllcVSE+l0mCKUpqNVsLRcG1weTq0Gsp
	pr9JzzJ8dfWKTynHUGoCoBCabxmoqrNatfebrXGeKIjvy1l2El5FeiWV4Fo6HgG3
	+CRNIDfF5a/OXybetRn9jGyagYOsd76pzarhdr6RhO//SUkluxzNH+SaUyUlILFd
	4GnWK6YsBcPkEAKrERCPJ4ntT0y51Bw1Ww0Dn8bB0oyDMxLju0piCCl2DXotLAeY
	4CJXr2G40Otck1HR/pVSZJToSA2F7RluRR3SeYQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:u6QYGmW7OZIKzHs2Ye6NNfdD1aBVuT/K7VQb3K4RP2c=:tSe0HwHwGaHBzXco/aL/zhpyFQADcXLLOcWq3KMpRAQ=;
X-ME-Sender: <xms:pJbGaorWb7L91Zv_EoWCU5B_AtbKGgJ72EUC6FGT_O34C-Nidn9fGQ>
    <xme:pJbGanbwvoT-VoiPirtbWzSvoGUW3YR5ZGe_t2FZYmUc9LK-e-z6L4kljSnFNIcvB
    625oerUEVmWbl207_ezX4nRQ7UsVMamOg_kXLG_VXjBneRbvI7wmb3C>
X-ME-Received: <xmr:pJbGar6FvVwymgYSAiIbNvbdsHDjsDKY-pV_oXLNzX5KAuH3Hf4jD24VwKJ9N4lRDsHZ-IY-xQZQa5WoNzas0FgJwy2iOCc>
X-ME-Proxy-Cause: dmFkZTFM9Id3SBMEkDBtkk2umITVNVd483RkCuPbIFuDihg99GVNhAQlcJJOFsMvT1ULUg
    jG+qrK4iMdLWSWYIlGPVv74TpPOoRqr+fRJ5Ty3o4U1eoLiBYgfS4AvzyacTOjnn9hyU9s
    dMvLd96DPfFxNn2/HuHkcyPjode7JtOstfbsJw528Va3NPnvgpaYxdVRyXvqoAfgquugFO
    wVBbcWizL/9BznUu4hcMsSn2PeJB6CJI/rTEwTZRagy2zLtYbVsjm9icPJgm/bXDdZoYgi
    TQalMvTOK5mlSVE/jigmazJi0yzqeWBaEr0RVIhTkk6npOE5RgFKAxAg9DKqdlfv6Z7JcH
    IoCEYt5GD8anjC44DJSAeXBpy1n0aSD7I+4PP5PQgahyRibQigB3z8VUF57AMIGQqvo3Dr
    fSaJFjF2kfEFcCbcdIlP0MDK0nwHc9lyaiMRIi4cpLCGkrakTULNfDkoPvxc98DIoxO+L7
    /ytj2bW5x+dMF1Ykz4s520UOTyi7R7Zh/ivVzr0gJ5JtNEtaxL+07i/ye5wuifVF1g0t0f
    JqOXbmH4Col7HicWh6lQVDjfrVzTjOW4WFPYZP3SNAeY5nHCCjUxN8cpZdYfg01+wl8hyl
    bfaji2iYvx/8WbHdelOFurwQYBQyruTbngKOoepB9pfH273y01Q1KHGBH9bw
X-ME-Proxy: <xmx:pJbGaiQ9HTTDhr3Y5kFiimqzzlHn9XAVgx9vhjtqjUQq4l_6YhUhVg>
    <xmx:pJbGarsfSKazGaVP8_YOoJy7kXUk0-4UmvjHVAEAcml1mMVxzeVSiQ>
    <xmx:pJbGakY7kgfn8TAEp8uHgE9EPH_ZpMUNpBZZ2ONEAJj4_oE2YJmx1A>
    <xmx:pJbGal8qsgibOniy7uMnT6x5a4GRxBGTUxvyOONQ0PkNFilrZy53Cg>
    <xmx:pJbGajD-_8grtwAy5fG9Yhgbh62wIwiUmt4DjbAmVtRDwrLk6bZ2dLz2>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 14:59:47 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v7 0/3] ptp: Add driver for R-Car Gen4
Date: Wed,  7 Oct 2026 20:59:17 +0200
Message-ID: <20261007185920.4042783-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series is the first part cleaning up how PTP timer support is
implemented on R-Car Gen4. Currently there is partial support for it in
some of the Ethernet devices that can use it, but not all.

The partial support have been implemented by hacking the gPTP module
directly into the first Ethernet device driver that used it, RTSN for
V4H and RSWITCH for S4. This is understandable as earlier R-Car
generations had a dedicated gPTP timer for each Ethernet device, but on
Gen4 there is a single system-wide PTP timer shared by all.

The current implementation makes it impossible for other Ethernet
devices on the platform to use the PTP timer without messing around with
other Ethernet device drivers.

The effort to clean this up starts with this series which adds the
system-wide gPTP timer as its own driver and device tree node.

This series will be followed by work to the RTSN and RSWITCH drivers
will be be switched from its current partial support by mapping the gPTP
address space directly to instead use this driver.

Having both this and RTSN/RSWITCH described and enabled (!) in device
tree will not work as they will try to use the same memory region. For
this reason this new solution will only be enabled on platforms
after all user's of the gPTP clock have moved to only use the new
centralized timer. But in the interim both devices will be described
(but not enabled) in the platforms base dtsi file.

For some platforms this is straight forward, such as V4H Sparrow Hawk,
which only have the RAVB Ethernet interface. This platform currently
have no users of the PTP timer, but still advertise it supports it. This
and the soon to be posted RAVB patches solves that.

The gPTP driver itself is heavily influence by the existing partial
support for gPTP in the RTSN and RSWITCH drivers and the Renesas BSP.

Niklas Söderlund (3):
  dt-bindings: ptp: renesas,rcar-gen4-gptp: Add R-Car Gen4
  ptp: Add driver for R-Car Gen4
  arm64: dts: renesas: r8a779g0: Add gPTP node

 .../bindings/ptp/renesas,rcar-gen4-gptp.yaml  |  64 +++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi     |   9 +
 drivers/ptp/Kconfig                           |  12 +
 drivers/ptp/Makefile                          |   1 +
 drivers/ptp/ptp_rcar_gen4.c                   | 225 ++++++++++++++++++
 6 files changed, 318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
 create mode 100644 drivers/ptp/ptp_rcar_gen4.c

-- 
2.55.0

