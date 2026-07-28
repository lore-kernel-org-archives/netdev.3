Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E323244692;
	Tue, 28 Jul 2026 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219592; cv=none; b=NLcEJ7LQgeynnPXHG0ZnlRUuypP3kllo7kw1n4QVX8yGTCxtE4aVKuTuOXfiRW74C6w3/OVTvnuKIM5qsx94SCz1xlkmbQD6+yoYRcM2donfPBHW3b+YluYuMFuhGNz//NDoV71X28U2wGuxpfd06ajwtNhpCUD2p02yam4xubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219592; c=relaxed/simple;
	bh=rm0dntThz0DwmcNzLNO300rGwZiw4vacrmFC8RxjhT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fhnXdXMrMs6l7urKjw6u8qSN42wmgtcUgFpm0kkBMf83qOSU+RDMW8t+PXesx6BSzuS59YZkRD+glhUc9LfJws2BPX/PnG+pzZZH00+2oIDm8myBh0133Qq8uUZftGAoC/jyA8sXyA1TQm/46dKUTcl9P617IlS6pKfi3mLuAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=pAy9edPx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="pAy9edPx"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66S6IMMK03651401, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785219502;
	bh=zytL0UhueysO2+dNdXO7unTI6+xqk/WT8m3TOBPUIBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pAy9edPxAn0hpZfyxMoH3ZaPio9y/mpwfvOBBRIPTWq215xwo6mqWUMU0XxxQHNIH
	 xK3/UVE3k+qaqFBQm5wqYRHshfDFzUwDFRRDkiIJpW4nL5vZIdEDiCbYZlBeMd+30A
	 1DKKajeECOmx6qp+dr3glMAY+pIkc8IAf4ttAf2P+dnPVdXt6MX9jIoYufjXmsjXb2
	 2jKXAFAyAAevQ3rFi/CXnfaxJNGZFfsbXkx9UExdk2lZOgeb+dHfC6zBZHPrq0FAu+
	 tXYV/MkmBJqD3MsLYG5d7B3zSe9hpQgmyHsAXFlBZbKHAk5e3pEbiu7J6rrcj9HJk+
	 VqN2IrUTFm/iQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66S6IMMK03651401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jul 2026 14:18:22 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 14:18:22 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Tue,
 28 Jul 2026 14:18:22 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
	"daniel@thingy.jp" <daniel@thingy.jp>
Subject: RE: [PATCH net-next v7 4/7] r8169: add support for RTL8116af
Thread-Topic: [PATCH net-next v7 4/7] r8169: add support for RTL8116af
Thread-Index: AQHdGYHgECGgdwHRfk+In15lMVg2/7Z5x7IAgAClguCAAB6GgIAH8VTQ
Date: Tue, 28 Jul 2026 06:18:22 +0000
Message-ID: <d8fa2337e3894a178616a0b1f2786a1f@realsil.com.cn>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
 <20260722022906.271-5-javen_xu@realsil.com.cn>
 <ff90f295-31df-490b-aad3-1bba6ef0ab5d@lunn.ch>
 <90aea677b62e44f3a705caa900b3af95@realsil.com.cn>
 <b01e69e8-3c8a-4af5-9de2-19d73713cff3@lunn.ch>
In-Reply-To: <b01e69e8-3c8a-4af5-9de2-19d73713cff3@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andrew,
>
>On Thu, Jul 23, 2026 at 03:21:26AM +0000, Javen wrote:
>> >
>> >>  static void rtl8169_init_phy(struct rtl8169_private *tp)  {
>> >> +     phy_init_hw(tp->phydev);
>> >> +     phy_resume(tp->phydev);
>> >>       r8169_hw_phy_config(tp, tp->phydev, tp->mac_version);
>> >>
>> >>       if (tp->mac_version <=3D RTL_GIGA_MAC_VER_06) { @@ -2562,7
>> >> +2607,7 @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
>> >>           tp->pci_dev->subsystem_device =3D=3D 0xe000)
>> >>               phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
>> >>
>> >> -     if (tp->sfp_mode)
>> >> +     if (tp->sfp_mode =3D=3D RTL_SFP_8127_ATF)
>> >>               rtl_sfp_init(tp);
>> >
>> >This could be diff getting me confused....
>> >
>> >You unconditionally call phy_init_hw() and phy_resume(). And then if
>> >this device should have an SFP you do something else. How can a
>> >device with an SFP also have a PHY?
>>
>> I totally agree that the SFP initialization logic does not belong in a f=
unction
>meant for PHYs. But rtl_sfp_init() call was already located inside
>rtl8169_init_phy() before my series. And it works well. This mainly becaus=
e the
>patch which add support for RTL8127atf(commit id: fef0f545511f72223)
>assume that RTL8127atf has a dummy phy. So tp->phydev will not be NULL.
>
>[Goes and looks at what rtl_sfp_init() actually does]
>
>So it does not touch phydev making this function at least safe.
>
>> And in patch 5/7 of this series which add phylink support for RTL8127atf=
, I
>remove it.
>
>Yes, i did notice the dummy PHY getting deleted. I will look at that patch=
 in
>more detail.
>
>      Thanks
>        Andrew

Just a gentle ping on this thread.

I am currently preparing for the next version. However, since you mentioned=
 earlier that you were planning to look at patch 5/7 in more detail, I want=
 to ask if you prefer me to send the next version or should I hold off and =
wait for your feedback on patch 5/7 so I can address everything in next pat=
ch.

Thanks,
Javen


