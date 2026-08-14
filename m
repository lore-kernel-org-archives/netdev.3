Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032A35C687;
	Fri, 14 Aug 2026 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694207; cv=none; b=FHEmJQaDx6dJKDMjb/MyzF+cW2NxeIOgBDxkJt/sBjNshxd68KHWMkJUyVEH4Q30aUNhzE9qXpU15UXHLxNdT5imZGCjiy4s6MoGLfMZsOK8rokJYVY2XYcvE309rU+lcZBvpOj0xX4UJw/tY2uuzAdMplKrX09gCxLPw9PM6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694207; c=relaxed/simple;
	bh=eTiQlI25pBUjs/a9n63tNedaT8j+Ade7BZd8Ai/s8mk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=La9Xn0i1dicgpympjDBcax1JllO6UTTDdHnUS8Uty/CM8ix3ZjNSfUkj5UshHLhuoqGp1LcQ5Q6fgEuDdlf6kmJ5UZdk/wH8h0vm6sApIjnsp+5IZ6+YTMFiqutC+yQ+uPVokavPDrh2TwKYlrZtK71qtdsuKtyAOBwEVUztNtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=tVnoJQpO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="tVnoJQpO"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67E7tImyD1074346, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1786694119;
	bh=XjwKhCLzTFGd9ljvZBxi4xT+iS+CaIyZ+A2Fo8m4oCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tVnoJQpOP8gJTM9qQdWY57EWS6HfepMONkiO4W0k+C3BWE2E+TFiMEWgFxa90R8k8
	 72TvCkkWaUbecyWbJxekkeoeHq+3Jz6SNc76HzPBR6HE9MsaLBC2CgHzmJO+8bwghi
	 weQkqGAC4jDi/IE5tlBFZSN3BPwo0jSzakg2T7RC/X4dCyfZj3xF1qfwllX+XK0DQ1
	 cazvW3NgzfXeav85IoT11LZDPVkU4jHkST8b+g92sh2azLXLjmZUtSUrUYB1e+VsHs
	 X7Fy1QvSlK3fS4LxGZLflfIuAMXwvepf3baB6LpXLymNEk44/3dxWiL7pOiZpbkvb1
	 Zn08VsGeYMn4Q==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67E7tImyD1074346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Aug 2026 15:55:19 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 14 Aug 2026 15:55:17 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.043; Fri,
 14 Aug 2026 15:55:17 +0800
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
Thread-Index: AQHdH++uiKR31q7P6ECrRxr8Kj4WuraKV/oAgAFWRmD//4C4AIASEvEw
Date: Fri, 14 Aug 2026 07:55:17 +0000
Message-ID: <13ac909ae522426f9352fe8770ba2a5c@realsil.com.cn>
References: <20260730065014.883-1-javen_xu@realsil.com.cn>
 <20260730065014.883-4-javen_xu@realsil.com.cn>
 <cfcf87aa-3d4d-411a-9af0-5a5b78c9ae89@lunn.ch>
 <4338caa7b5d244e1b0d9a6713ed8fce3@realsil.com.cn>
 <0ddca9cd-4834-4d00-adc5-520e74a803eb@lunn.ch>
In-Reply-To: <0ddca9cd-4834-4d00-adc5-520e74a803eb@lunn.ch>
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
>On Mon, Aug 03, 2026 at 03:32:12AM +0000, Javen wrote:
>> >
>> >> +static void rtl_mac_link_up(struct phylink_config *config, struct
>> >> +phy_device
>> >*phydev,
>> >> +                         unsigned int mode, phy_interface_t interfac=
e,
>> >> +                         int speed, int duplex, bool tx_pause,
>> >> +bool
>> >> +rx_pause) {
>> >> +     struct rtl8169_private *tp =3D container_of(config, struct
>> >> +rtl8169_private,
>> >phylink_config);
>> >> +     struct device *d =3D tp_to_dev(tp);
>> >> +
>> >> +     tp->speed =3D speed;
>> >> +     rtl_link_chg_patch(tp, speed);
>> >> +
>> >> +     pm_request_resume(d);
>> >
>> >This does nothing with rx_pause and tx_pause. How is the MAC getting
>> >configured for flow control?
>>
>> To actually generate pause frames, the MAC needs Rx FIFO "Near Full" and
>"Near Empty" thresholds. The driver configures these statically during
>hardware initialization (rtl_hw_start_xxx) by writing to ERI registers 0xC=
C
>(RFIFONFULL_TH) and 0xD0 (RFIFOEMPTY_TH) via
>rtl8168g_set_pause_thresholds().
>>
>> Software enables/disables flow control by setting the Local PHY register=
s
>phy_set_asym_pause(). After auto-negotiation with the Link Partner, the PH=
Y
>resolves the flow control capabilities. Once the link is up and flow contr=
ol is
>negotiated, the integrated Realtek MAC hardware automatically reads the PH=
Y
>result.
>>
>> Therefore, we don't need to do anything with tx_pause and rx_pause in
>mac_link_up.
>
>Yes you do.
>
>ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]
>
>Pause configuration falls into three major categories:
>
>1: The link is negotiated, and pause is negotiated
>2: The link is negotiated, but pause is forced. ethtool -A autoneg off ...
>3: The link is forced, ethtool -s autoneg off, and pause is forced, ethtoo=
l -A
>netneg off ...
>
>The PHY registers only tell you about 1:. phylink mac_link_up tells you th=
e right
>thing to do for all three.

Hi Andrew,

Thanks for pointing this out. I have double-checked with our team, and the =
driver currently cannot handle Cases 2 & 3.

Here is the exact hardware limitation regarding flow control on our chip:
There are no independent software registers to configure Tx/Rx pause. The M=
AC hardware is completely hardwired:

When Autoneg is OFF (Forced mode): The hardware automatically locks Tx and =
Rx pause to DISABLED.
When Autoneg is ON: The MAC automatically polls the PHY and enables/disable=
s flow control based purely on the negotiation result.
Because software cannot override this hardware behavior, we cannot explicit=
ly force tx_pause or rx_pause via mac_link_up when autoneg is disabled.

How would you prefer I handle this limitation?
Should I just add a clear comment in mac_link_up explaining this, or is the=
re a specific way in phylink to report that forced pause is unsupported so =
ethtool rejects Cases 2 & 3?

Best regards,
Javen

>
>    Andrew
