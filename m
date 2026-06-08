Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F21E2858;
	Mon,  8 Jun 2026 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900380; cv=none; b=sbsQ8Z9z7HZJjpB+RkrCaJAPVP6YFslgycfJcBBsOXbAbX9njnm+zZTqch/tdAH3iGRp8HtUuaXs86McUHmTNRhzDXH4PzX8p/S1bwDeNh3vx9K6Lz0ixU2knAZA6DQmOE9WhgTcu2Kw/lYnu2si/T11cdfKm3xf7u8X7nyQE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900380; c=relaxed/simple;
	bh=tUndfLol09EHbqRK3TD+Yfcea1+P2fSjph7ZPfudk/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rXHq2LtZKKq7nGfvYX9vkh41ecGfxzSkclTgRVKbYkbwc+wWlmij3If0nU4MR88bk27VeaWf8ol1yQ+Ci2Kxl1GyX8vva/pChvIQ0vlGvFJaaWC3pCW7CdHEzfMsllPOIlGycUajwxXz/JdVT4NI2Y0UyMOrtNuu7g6sQbohq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=rw3JJsAa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="rw3JJsAa"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6586WJME03402999, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780900339;
	bh=kzuIL5VnR4BuJuRmm32NHFPK9SCYgquyWS1h3/bGbMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rw3JJsAafBtU63fSLa+0wY2rrctAJrH1Mrk4WSs7hW4IgxpaLCEZyCSf9ums3AyAo
	 j5/PiWvMtU93RDlmUGoemse7rZG5i4+Cupx7xPXcJEyf5cpvxBitW8evFyFkdOs1e9
	 IsNvc0Jiga7A83+w3/stkJRabPOxzwgQ+YPMg/+4pTn+EEQu3esU+BzNQwkLrG+uTL
	 JUrAvfUFn+oF296xai5YPJNPuOmqN0NDNjxS9GSvKP1787RsvYplwK506BL0CRtobg
	 9Borwe3PoFZZsh7coCpP/a/jBj2tU4daao3mH48v6vc7G9WUM0OHMIYZtmUt/rxCZG
	 pbJlDv6itIvYw==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6586WJME03402999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jun 2026 14:32:19 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Jun 2026 14:32:19 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Mon,
 8 Jun 2026 14:32:19 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1 4/6] r8169: add support for RTL8116af
Thread-Topic: [PATCH net-next v1 4/6] r8169: add support for RTL8116af
Thread-Index: AQHc9NeKx3fmMihSw0SPIMX6a9yYtLYwzGSAgANkRqA=
Date: Mon, 8 Jun 2026 06:32:19 +0000
Message-ID: <b54b5f3a6703498fbc17e64548550ba0@realsil.com.cn>
References: <20260605103906.1445-1-javen_xu@realsil.com.cn>
 <20260605103906.1445-5-javen_xu@realsil.com.cn>
 <5005c1c3-d807-456d-a9a0-c77bde9f437e@lunn.ch>
In-Reply-To: <5005c1c3-d807-456d-a9a0-c77bde9f437e@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>> +static bool rtl_is_8116af(struct rtl8169_private *tp) {
>> +     return tp->mac_version =3D=3D RTL_GIGA_MAC_VER_52 &&
>> +             (r8168_mac_ocp_read(tp, 0xdc00) & 0x0078) =3D=3D 0x0030 &&
>> +             (r8168_mac_ocp_read(tp, 0xd006) & 0x00ff) =3D=3D 0x0000;
>
>Do we know what these magic numbers mean?

0xdc00 is a package-detect field. 0xd006 is internal HW id. RTL8116AF share=
s the same RTL_GIGA_MAC_VER_52 mac_version with other variants.=20

>
>>  static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private
>> *tp)  {
>>       switch (tp->mac_version) {
>> @@ -2397,7 +2431,7 @@ static int rtl8169_set_link_ksettings(struct
>net_device *ndev,
>>       int duplex =3D cmd->base.duplex;
>>       int speed =3D cmd->base.speed;
>>
>> -     if (!tp->sfp_mode)
>> +     if (tp->sfp_mode !=3D RTL_SFP_8127_ATF)
>>               return phylink_ethtool_ksettings_set(tp->phylink, cmd);
>
>Is this even needed? phylink should be able to handle sfp and copper in th=
e
>same way.

I will try to handle this.

>
>> @@ -2509,9 +2543,10 @@ void r8169_apply_firmware(struct
>rtl8169_private *tp)
>>               tp->ocp_base =3D OCP_STD_PHY_BASE;
>>
>>               /* PHY soft reset may still be in progress */
>> -             phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
>> -                                   !(val & BMCR_RESET),
>> -                                   50000, 600000, true);
>> +             if (tp->phydev)
>> +                     phy_read_poll_timeout(tp->phydev, MII_BMCR, val,
>> +                                           !(val & BMCR_RESET),
>> +                                           50000, 600000, true);
>
>Maybe this all needs to move into the PHY driver?

This is after firmware application. And PHY_MDIO_CHG opcode switches the ac=
cess callbacks between PHY and MAC accessors.
data =3D=3D 0: phy_read/phy_write
data !=3D 0: mac_mcu_read/mac_mcu_write
So the firmware may contain mixed PHY and MAC.

>
>> -     rg_saw_cnt =3D phy_read_paged(tp->phydev, 0x0c42, 0x13) & 0x3fff;
>> -     if (rg_saw_cnt > 0) {
>> -             u16 sw_cnt_1ms_ini;
>> +     if (tp->phydev) {
>> +             rg_saw_cnt =3D phy_read_paged(tp->phydev, 0x0c42, 0x13) & =
0x3fff;
>> +             if (rg_saw_cnt > 0) {
>> +                     u16 sw_cnt_1ms_ini;
>>
>> -             sw_cnt_1ms_ini =3D (16000000 / rg_saw_cnt) & 0x0fff;
>> -             r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
>> +                     sw_cnt_1ms_ini =3D (16000000 / rg_saw_cnt) & 0x0ff=
f;
>> +                     r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1m=
s_ini);
>> +             }
>
>Can this move into the PHY driver?

It reads a counter from PHY, but the calculated value is programmed into MA=
C OCP register via r8168_mac_ocp_modify, which accesses r8169 through tp->m=
mio_addr. So I think this can not be moved.

>
>> @@ -5017,9 +5054,11 @@ static void rtl8169_up(struct rtl8169_private *tp=
)
>>               rtl8168_driver_start(tp);
>>
>>       pci_set_master(tp->pci_dev);
>> -     phy_init_hw(tp->phydev);
>> -     phy_resume(tp->phydev);
>> -     rtl8169_init_phy(tp);
>> +     if (tp->phydev) {
>> +             phy_init_hw(tp->phydev);
>> +             phy_resume(tp->phydev);
>> +             rtl8169_init_phy(tp);
>> +     }
>
>Why is this needed?

I will try to remove this.

Thanks for your review.

BRs,
Javen
