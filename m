Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219718DB2A;
	Fri, 24 Jul 2026 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857572; cv=none; b=l+LSB/KEmjgJo1sfsS72tiK7PS+hkjGQOL3KmxGQsWhEyJzP5xCpReZ/ncc5dLwTF71Dl0QB/aA2kcg8zS++7Lt3VMwScOsTFRIU+6hJ5yaErxFUgTyPi9LTyHHnkh7GPu49S+2BC8qIegEQ46eVs8dgYeYDlues2VVTLSgXBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857572; c=relaxed/simple;
	bh=K3R9dXT1oqN7EZDFgiVlSqQzPhDVmSwIdKLD2Cba840=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P68sVowon9JbHj/Gb/B/vD/nRAgcUmEWUml4tEZs0CiBKTCw/Reo6v7++0ZEsUadiqt/wYfh0JXFC9aQSagrVZKzN58rCAdjDjJBCy2F1N4jiyKEsq9HkB/4qW+kYOOIoG8fW4OauVStQski+BOmFAGQfh2wK2wMMDGaCEKlU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=NG1acsBG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="NG1acsBG"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66O1iiAP3900934, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784857485;
	bh=Junt9qVEf0yP8lCaArQWTGl6/obCrfXpWF8vs+jDRmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NG1acsBGCW44GK4mT21Q22Gmy2nRvYc1hNRMYiDC71Xzex5tGwDvRKMT4CCCdcqU+
	 o9XDpkkX7pjwwp/kJ9ldyYByo5qW9r7p9uh5vNP4I4VbkxtW4oR3mc+sDb4ij5Pydh
	 r3LUX4o2D3Tqe9H7NLWKLps4NDz1CEqlw3re7WvWoNs7E/HM2h0WQoVjrh2TpN4uMG
	 Z32xL1YqAxBTQgUTcvkh7RQKnsm9gEOIBn8EoyinjGCefIHPjBt0fLfaQuPR2Fy/g5
	 Tpien4UmcBnJpD5gVjl+rdPhRSJKJc2xCbEQreo/MeqGE+MgawDmjbaUijBgzbyIg5
	 izxTg1Dp2YMwA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66O1iiAP3900934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2026 09:44:45 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 09:44:44 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Fri,
 24 Jul 2026 09:44:44 +0800
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
Thread-Index: AQHdGYHgECGgdwHRfk+In15lMVg2/7Z5x7IAgAClguCAAB6GgIABXLaQ
Date: Fri, 24 Jul 2026 01:44:44 +0000
Message-ID: <75521d902ba24ed0b97d14b8002ace85@realsil.com.cn>
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

Thanks for checking that. Looking forward to your feedback on patch 5/7.

BRs,
Javen

>      Thanks
>        Andrew
