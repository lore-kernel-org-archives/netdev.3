Received: from mail-ej2-f6.google.com (mail-ej2-f6.google.com [74.125.228.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB83472F9B
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467795; cv=pass; b=sHsFqaCE4IpiAIRPpbxiNl+AzVGRKLxUTcNuZ4++dk9rbOUNad2+XobvDfkHXD9ILBWHHIcum4C7noIe2q01NRO/Q7GFK4VunGG9yXh8VAl1yK4n2bMpytHLC2cXxzd0+vtE/fwj6IGMv9NvXwi9OFGuNjSqoEpcjpa3JYU6Yw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467795; c=relaxed/simple;
	bh=c3RIJ2i8Y04OYsadwKNxN56yhveUJrAsHw56HkKOmYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otdsMlvuqTO//46AYdu6h0jJXRR/qyBxklQ+5MNpuSYvL0+oo8NlLLQ4IBeQTVXn3b0Mu6jJL+nTcYI/rVBDnkSyzD9utnIoT3xePUtr/mV7quOsF00xs1kqcuNgtCmCDPwe5h239jlTH/ArSnpC8orQI0Co4R21vxNd+glzQvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD8BCWYb; arc=pass smtp.client-ip=74.125.228.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD8BCWYb"
Received: by mail-ej2-f6.google.com with SMTP id a640c23a62f3a-c29440ee0e7so201358466b.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789467791; cv=none;
        d=google.com; s=arc-20260327;
        b=qJFaHdVBtM10j1hQc/QRVCD+bdh9Mhn2Uyh2uo3uSaXdJUBK8IHERoX0KCWPodfaNT
         Sn9bAIHCLUnHacZy0Knz+0+5Ans6bbKU97p1oyCdWTv7ZbwmbNPY6cHvtfH9QiefXczr
         9/AVH9J6W453DX67VZHEes34Ti+ZEvc1QU4F0uZd6b2KTSThu87OMS9RMngsRjLWwzb2
         pNiFiDUjPcE53AebP0SrORi+ik9rldjCxyI4sGPPHHUHQ55GnL2LAPS/tgTYnkLBpAc9
         U7EMv6R944Lv5Q+bgAhiF40KbGLdbS4Gm4jegprcoIQ9Izc+ToZj2wwGayBTzlGn4HdM
         lxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nYoTXRWm9dXxQab97Avfkm/YI6364EPnV/puvJGLZtc=;
        fh=GfVnWbg8oA14F9v8vZdTggBPl8Tk1GoGQKHqjY+cc2k=;
        b=AHOX+i2UBWzK9VgR8o3GMEdbPBlDE6+kLJKJd77KPLxBrxbeBL/zauXDisc3UBFknB
         sQyM/p7aYDFVA5yeB/fRggBBrCfWyGrZD/at/XGzSbvjvbHheHeZeULAw04nxQ3EMyDX
         meyifYKoFI1WORZ/bWeVroR9apc88wAp6We26MWNgE4TJljFRX2QTIarHBvsPnbdNL9+
         sBOdbjMkdR/hNgegAmD61flcKvCC/zzHOoMRewezVblLGZ/GZS9mZwIywAWfPJy4qcbN
         MCVWSph4A1M6IamMQF8PQrr7JrRCwfGzFkTrST1AgqA2XxQvVGJ9ptmqIbQEOkBVN+k1
         FfvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789467791; x=1790072591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nYoTXRWm9dXxQab97Avfkm/YI6364EPnV/puvJGLZtc=;
        b=BD8BCWYbg/2D6ELs1XNumO73g7sbmRiB4WAMxDPiToc1VZH2i+07pszYcoto91GCXY
         ArGwZHhNqEP5889Yg2n28jOKLcwthlZlYdybB6pm0/hhBTFG7QCpJrECo/Uj2O3MTCHk
         j83wwHysm6Ikl3f7jPb7EgHswjSGL0ngI9QpvCXYzrtEPq/BQsVoDyxXECmQqeKKJrMP
         B8MNqasHbfvHd5Myw2ix2+naDoTWxgYCH9xYVl6mDx/Igns3/sNkYT6vb8kH4RuyeUrA
         m9MapE6PU8l8j7LCF+FWO52q69vLRYIwv4jqcQbbanJbsGI1D/7j4HiVAmcR5S1ElAyl
         s0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467791; x=1790072591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYoTXRWm9dXxQab97Avfkm/YI6364EPnV/puvJGLZtc=;
        b=Mc6+zBSmhLij4+stI/oFhEV52XcRMDJ94yRyqB53HN9tD3mmLX6hcZGhWMjbnqNb34
         1ZSU+kjxuytP7az7xAXyvsiSIwWpRhuZXpS6oY9NUzT3zvWJgqXy79nW0t/fSc8bGwYn
         8lY0MuB3CY/756kN00IAoPjfYjuqmHe1Q+e6NcotAIkqIEyT/exLW3aSJaffPOeAQ1tf
         JpqLnTGlw/DuXDbwAu7m5BE7v7ngDiY4TWTp/IlwKWkGEjMxyVJuQlXu9QMKwk1UxS5v
         8wu2Jbe55AXkvsYTVKRXDABCZm1nnOp1XXKbdbI6wBBxSGw0kT0jfnq17ue/9LwHoXHY
         JDmw==
X-Forwarded-Encrypted: i=1; AKwUvBx5q/8fUn8p0fxnIIT54ZKK7xDUA2pPo2onFRxTDMRHL8/VIw58SPJuJTZuqRJ7TvZFEfGowWc=@vger.kernel.org
X-Gm-Message-State: AFuF++laolIWwHqQ1uTlM5f8XUMkA6luUeseCctqPsjqyswFHLxnLfoz
	4ajZFGTfSpb1GY6k6ABjykg5fb8Qzjxdytrd7mCrDFKFnbHVihK1wBrB46oxiHYY34Ey1tjSNNS
	7qHQmODMO05Pl/GphMMGMNLbqm1QFJPg=
X-Gm-Gg: AYBFou1YmX71kTAtRFkQgU/izvIRC4O2CvSsx9C2+j6M2I4EEuWbT8QtvvhoQOLWrh2
	1vEZMsALA1LyKSBJokzQMmBj9cdy97XTl+4AgNxEkOQT7KuHmuR9qyq5+WPVXKnmnQLN5oKxZet
	U/2gYV6SK1pBxDZRns9wWOxrAXgQCDakaePnGvP6vQz64jgUIODczUIFGuu/QXaF1KLa6bnpU7z
	Sd2Vobph5EEBdGXrtdoPUphT5qYBg01qT6A9rdQgByQA3ie9fYm6zv1oYlfmk7H6AXO/3l4Du2D
	3Mu7FIDL8Lr2j8/2tOw78p+2oo+B/nfJwX4oWApTSJCwPtDe4+6Jwb5fIA==
X-Received: by 2002:a17:907:3d56:b0:c25:6c9a:88bc with SMTP id
 a640c23a62f3a-c29b87339e8mr775899466b.19.1789467791028; Tue, 15 Sep 2026
 03:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913185849.907479-3-coiaprant@gmail.com> <178941747711.22033.8495700704733189874@kernel.org>
In-Reply-To: <178941747711.22033.8495700704733189874@kernel.org>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 15 Sep 2026 18:22:59 +0800
X-Gm-Features: AcwNN1XIwap_FwM1kV5GNhNfjY4yI0txPnJoW2RyomCTNzqIwhUfgmMQ2h9aiaE
Message-ID: <CALj3r0ge_AVi=jrUZh_T8cEt954S_Ah7Hi4QxkccjEm6zug_Ag@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/11] dt-bindings: phy: rockchip:
 naneng-combphy: add rockchip,sgmii-mac-sel property
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org, 
	maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org, 
	linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz, 
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<netdev-bot+sashiko@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=8C 04:24=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> - [Low] Concern (validated as NOT a defect in the series context): the
>   binding adds `rockchip,sgmii-mac-sel` while, at this commit alone, no=
=E2=80=A6
>
> --
>
> dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel pr=
operty
>
> This adds an optional rockchip,sgmii-mac-sel property to the naneng-combp=
hy
> binding so a board can select whether the RK3568 SGMII interface is route=
d
> to GMAC0 or GMAC1.  The property is restricted to the RK3568 compatible v=
ia
> the existing allOf conditional and defaults to 1 (GMAC1).
>
> [Severity: Low]
> At this commit alone, is rockchip,sgmii-mac-sel read by anything?
>
> rockchip_combphy_parse_dt() in
> drivers/phy/rockchip/phy-rockchip-naneng-combphy.c does not look it up,
> struct rockchip_combphy_grfcfg has no pipe_sgmii_mac_sel descriptor, and
> no in-tree DTS sets it, so a kernel built from exactly this commit would
> silently ignore the property.
>
> This resolves itself later in the same series: "phy: rockchip:
> naneng-combphy: add SGMII MAC selection for RK3568" adds the parsing
>
>         priv->sgmii_mac_sel =3D 1;
>         device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sg=
mii_mac_sel);
>
> along with the RK3568 pipe-GRF descriptor
>
>         .pipe_sgmii_mac_sel     =3D { 0x0040, 1, 1, 0x00, 0x01 },
>
> and the write in the PHY_TYPE_SGMII path of rk3568_combphy_cfg(), and
> "arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port" adds the
> first user:
>
>         &combphy2 {
>                 rockchip,sgmii-mac-sel =3D <0>;
>                 status =3D "okay";
>         };
>
> So this is noted only for the record, since the binding and its consumer
> being split across consecutive patches is the normal series layout.
>
> The remaining point is a design question rather than a bug: is a raw
> uint32 MAC index the interface preferred here, or would a phandle to the
> GMAC controller node be a better fit for describing the routing?

The property maps directly onto a single bit in the combo PHY's own
GRF register (PIPE_GRF_XPCS_CON0 bit 1), which selects whether the
SGMII lane is routed to GMAC0 or GMAC1. It describes a mux setting
inside the PHY, not a relationship to the GMAC node. A phandle would
introduce an extra dependency edge between the combo PHY node and the
GMAC node for no benefit, and the raw value matches how the BSP and
the surrounding GRF properties describe similar muxes.

So I'll keep the uint32 form.
