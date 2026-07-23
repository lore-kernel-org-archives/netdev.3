Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A611E5207;
	Thu, 23 Jul 2026 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784776937; cv=none; b=CW/LSSPwNCYHkiaFWRKBmRlb5KWND8tlJ4UTEVx55x68G8048LWYiAN0TF7dMVny9lWfk6eMlL/WvwZnsW5+Tf6PJkNOGLTn2uZU//gr5ALCsu9oeOoheGPRFJyulX3AA/zTUbwMUVHLg1cwqIyfTr/tVVyBQa0BXu3luaPI3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784776937; c=relaxed/simple;
	bh=AQzIh0BeMGOiGic2zaOCRN1Kg2vAqRJX9xy0q1ySwx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n5Syv59r0G/tNjMnYxFgGXcGtVxwT3yW90hpAFKUf0VVv0NhzM1G++qjsyzD5KT9IHAgCio6rZhO35Wk0mkNzLbY1+orcz4VcXjr4UIojzJsYbh7osw7b41WXtdPKc0Hebj76OJRF7hykDB+7Kx5eZPlSx0Jc6ank3EjCDe9Rg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=j96By/1Z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="j96By/1Z"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N3LQGf8172944, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784776886;
	bh=jnsHUxvfdk5kvQ0mx2OYZgAJ0HAoVi6Km6w45vkF0zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=j96By/1ZSdlcRCBPw5VIHAdUmXlhSd4vP4UKvNiyBflxradV+B59CiKkP32XJtxvo
	 RXjq4fYW7o9FiFtHgKWye4WNvtgizS+C5DSnFqFbjJO9B7+bsGF/JtUi5t6aPK/hVv
	 Nh5NdAWKiepOGfnrhzX7Fuik3pnPn+kCow2EPdJ2dsZ1BvU8WdJpIQCp/wdgj7BygS
	 H1CstLsYEk89VceJ2ELM5ctgQ/1dIp/NB5QQkOuwm8Y8yo9lfk2aoG8SK5EkWVlBk9
	 SIPPyDcpnQimJp8HTiqdZ/aKbMvvcvpZjfgMh3jKWp5KgIBfi4lXFtqwUpbbZJmeJb
	 bKZKle8IP3knQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N3LQGf8172944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 11:21:26 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 11:21:26 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Thu,
 23 Jul 2026 11:21:26 +0800
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
Thread-Index: AQHdGYHgECGgdwHRfk+In15lMVg2/7Z5x7IAgAClguA=
Date: Thu, 23 Jul 2026 03:21:26 +0000
Message-ID: <90aea677b62e44f3a705caa900b3af95@realsil.com.cn>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
 <20260722022906.271-5-javen_xu@realsil.com.cn>
 <ff90f295-31df-490b-aad3-1bba6ef0ab5d@lunn.ch>
In-Reply-To: <ff90f295-31df-490b-aad3-1bba6ef0ab5d@lunn.ch>
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
>>  static void rtl8169_init_phy(struct rtl8169_private *tp)  {
>> +     phy_init_hw(tp->phydev);
>> +     phy_resume(tp->phydev);
>>       r8169_hw_phy_config(tp, tp->phydev, tp->mac_version);
>>
>>       if (tp->mac_version <=3D RTL_GIGA_MAC_VER_06) { @@ -2562,7 +2607,7
>> @@ static void rtl8169_init_phy(struct rtl8169_private *tp)
>>           tp->pci_dev->subsystem_device =3D=3D 0xe000)
>>               phy_write_paged(tp->phydev, 0x0001, 0x10, 0xf01b);
>>
>> -     if (tp->sfp_mode)
>> +     if (tp->sfp_mode =3D=3D RTL_SFP_8127_ATF)
>>               rtl_sfp_init(tp);
>
>This could be diff getting me confused....
>
>You unconditionally call phy_init_hw() and phy_resume(). And then if this
>device should have an SFP you do something else. How can a device with an
>SFP also have a PHY?

I totally agree that the SFP initialization logic does not belong in a func=
tion meant for PHYs. But rtl_sfp_init() call was already located inside rtl=
8169_init_phy() before my series. And it works well. This mainly because th=
e patch which add support for RTL8127atf(commit id: fef0f545511f72223) assu=
me that RTL8127atf has a dummy phy. So tp->phydev will not be NULL.

And in patch 5/7 of this series which add phylink support for RTL8127atf, I=
 remove it.

BRs,
Javen

>
>        Andrew
