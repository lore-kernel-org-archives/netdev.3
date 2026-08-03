Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D736375F65;
	Mon,  3 Aug 2026 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728019; cv=none; b=QO8lzTvgz96a/pFbtKXclk3+3pliXoq6nZ19rH0hR1uQLfWOUrYayIpWvBAx/zTe3QjkQhDISYfWfOcfS1tLONyKHIWGK14wwNxNbS6yhvYZeEgGU3Uo2w0sB8YLLfeirnMezwViAoX8e6GHaFWTP54S5RoDb0//4ZCLCLXHEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728019; c=relaxed/simple;
	bh=3tr1cdtwUZcGsGnAkNE2W32XReu7tEZGQtl8jz/KkiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r3s6ZAM/uA/YiYOKb0yv7QY7R9u+NVSbMGHmM3RQIu5rnA2Wg79FWxOZ730ln9tuvLUWivSTobG64r713lF/AzssMoen5UPXo5gAw+gsI7ofVIiEY65Z3kZAw6aDkqRdx6w5Am151cCF2wnnJ0sgWvOg6+qUmxu9s6nWsEmyhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=P6ZyMYwL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="P6ZyMYwL"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6733WBplC3871711, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785727932;
	bh=rWszaDzIZOV88AL+zVRTO6AmHfilyQN6RMeq13BwIW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=P6ZyMYwLUFAU/NQalJYqF3YKQ10HrKubRWdvJIJF7hqKvfxCJghgt0O4W/40avZ7q
	 Hw1h3VUEovkXPiLxlWdDMAb8dPAFB4IF9hyZkauTAYmOfFRLfXEEBDdC6ExPB3iYJ3
	 IpANAGDm2FgV5m8wkPr7JphxM9eS+A1rchwZC9eFrfZ7qxqWaNxVDgxnCb4HTmfO/2
	 e3hOPEB+ZYW+mGrYnhIPfvNckitpnQDRxhwP/IluYJpHTs4j7HgBKrTVhhKE6rJROK
	 p7Eq7y/rt3/yUTdkq9CHeSviWnR41Ge1IZFByq/6tdLkOS+bSWc3/pKEqAr6uWt31j
	 97FavAAoEHuiA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6733WBplC3871711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Aug 2026 11:32:12 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 3 Aug 2026 11:32:12 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Mon,
 3 Aug 2026 11:32:12 +0800
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
Subject: RE: [PATCH net-next v8 3/7] r8169: add support for phylink
Thread-Topic: [PATCH net-next v8 3/7] r8169: add support for phylink
Thread-Index: AQHdH++uiKR31q7P6ECrRxr8Kj4WuraKV/oAgAFWRmA=
Date: Mon, 3 Aug 2026 03:32:12 +0000
Message-ID: <4338caa7b5d244e1b0d9a6713ed8fce3@realsil.com.cn>
References: <20260730065014.883-1-javen_xu@realsil.com.cn>
 <20260730065014.883-4-javen_xu@realsil.com.cn>
 <cfcf87aa-3d4d-411a-9af0-5a5b78c9ae89@lunn.ch>
In-Reply-To: <cfcf87aa-3d4d-411a-9af0-5a5b78c9ae89@lunn.ch>
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
>> +static void rtl_mac_link_up(struct phylink_config *config, struct phy_d=
evice
>*phydev,
>> +                         unsigned int mode, phy_interface_t interface,
>> +                         int speed, int duplex, bool tx_pause, bool
>> +rx_pause) {
>> +     struct rtl8169_private *tp =3D container_of(config, struct rtl8169=
_private,
>phylink_config);
>> +     struct device *d =3D tp_to_dev(tp);
>> +
>> +     tp->speed =3D speed;
>> +     rtl_link_chg_patch(tp, speed);
>> +
>> +     pm_request_resume(d);
>
>This does nothing with rx_pause and tx_pause. How is the MAC getting
>configured for flow control?

To actually generate pause frames, the MAC needs Rx FIFO "Near Full" and "N=
ear Empty" thresholds. The driver configures these statically during hardwa=
re initialization (rtl_hw_start_xxx) by writing to ERI registers 0xCC (RFIF=
ONFULL_TH) and 0xD0 (RFIFOEMPTY_TH) via rtl8168g_set_pause_thresholds().

Software enables/disables flow control by setting the Local PHY registers p=
hy_set_asym_pause(). After auto-negotiation with the Link Partner, the PHY =
resolves the flow control capabilities. Once the link is up and flow contro=
l is negotiated, the integrated Realtek MAC hardware automatically reads th=
e PHY result.

Therefore, we don't need to do anything with tx_pause and rx_pause in mac_l=
ink_up.

Thanks,
Javen
>
>    Andrew
>
>---
>pw-bot: cr
