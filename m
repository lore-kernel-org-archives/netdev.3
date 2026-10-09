Received: from send215.i.mail.ru (send215.i.mail.ru [95.163.59.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12738F932;
	Fri,  9 Oct 2026 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527034; cv=none; b=hK4o9b4jZNfkOR1wcIn2DtloEwbLsZ7RxAoDOnfsWpPWN/I7DM/pGSgbPa2+1Hiw6dCVx1H5ydUpAZMhh9qBCOITmcsVB0U4AvOyeHlVqN+NJ1DOS/HT4QByNI23s9Ml4OVxdJ1t3tWzdEaz5Cc3kYL0z6XKonMX242kbqVWics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527034; c=relaxed/simple;
	bh=4pJSEoZxqZuvVcMf3BR5c3SmCaLjz2Lgdt5RZ6Hqy5c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l5h6JvtI98WqjKemKT40R2RiHAs79i65qvd6FyNujCzzHZJU2vxDkhUqZQNbWT59Z8wmjrxMJT+xlCGfGTYD/000BGtN1bGu1vcMVjLNKudEqJXWGUBSyMLPTu6qhgZra9MuItCv3v46sOSFm2bXXaC2wBozvzbNKYTbf/JY+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=KimGy9+l; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=WaP/Uyw/; arc=none smtp.client-ip=95.163.59.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="KimGy9+l";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="WaP/Uyw/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=UzfottKkOUPRT5E1FlEirn2+vpqcjnZExJdQsGyWQqI=; t=1791527030; x=1791617030; 
	b=KimGy9+lopi/aup2ZimowIY/8TOjjxXtGcly3LQq5YUmc7GuheDaiob8/wrn7Aj1xP4GSVOUtiM
	TQlZ8jK8t+lpqGAcBKgdDmqVDCnukZFR2/Z/ihMIg3Af1GEecTtzqT3V0AWkethKyq+zVRi05EwXu
	ckp4zpcTghOO8A9tr4e0sk8XyGvBkaJS2st9XmqwAJrIGMXjlZrK4om4s9tKfkxZilzCld8sbAKvs
	KmAT8g6DI7e/StGRGfVWe+y+wmo1l/cSV8A43nSs1sGI/YM/V336LmNM5XUE6ZsRAV+F6Nt43aRWH
	CK5Fub3/mvzJioQmuy+E0wrhOPW2uBTLfHAw==;
Received: from [10.113.145.145] (port=44492 helo=send106.i.mail.ru)
	by exim-fallback-79c4746b9d-2gthz with esmtp (envelope-from <skyline@mail.ru>)
	id 1xF3mZ-00000000HRP-0nwL; Fri, 09 Oct 2026 09:08:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:
	Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=UzfottKkOUPRT5E1FlEirn2+vpqcjnZExJdQsGyWQqI=; t=1791526119; x=1791616119; 
	b=WaP/Uyw/wCXRqc0WXLEgRXRNW8LtXY0P+HMAaMJ+AylI0fvkL2xhiWvI2A7Bz0Wf8d9egwvxmDJ
	AF7a6fBie9WbEpJ9oCo6iEndlPVDXdO7rj3Sf9EYCNp/2HqyorTe/hZrCDIsBJBuq/YOqjtYXHwIT
	uGL+NL+9DEU9xqdVjOkoHIyldK+uak3RJdf9gg8kkF6TEkDclUHX/3+QYD+eX6exf5CAGDuguiGoF
	juOc3okezmjIEEDBshE0J8v29JH8K4W3b+qS/VrWSywe31Y/kwl34Kvgo4ZmX+cQizt3wUoO/yFCp
	1NeNiJp1iPAQFKsATLLwEZFbrLGqWVd8h89Q==;
Received: by exim-smtp-5cc9c86755-w5lss with esmtpa (envelope-from <skyline@mail.ru>)
	id 1xF3mQ-00000000EGF-1rKW; Fri, 09 Oct 2026 09:08:30 +0300
From: Konstantin Meshkov <skyline@mail.ru>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Aleksander Jan Bajkowski <olek2@wp.pl>,
 Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: marvell: add LED support for 88E1116R PHY
Date: Fri, 09 Oct 2026 09:08:29 +0300
Message-ID: <179152610952.2918676.6625057760354797023@mail.ru>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92A0ACD7B21DFA70054C3D9A44D65C0368317951D37201765CD62213F67905E7A3522691B043884DE41BDA8E036AE704FA275BDF396E81A689FD81C73E534A9E1DDDE7B70B5F5C79F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C6A43EB42C8B28B9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F88016AB904663428638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2D9AFF584AEBFAA432E070BE324C7D3C49080DE1A469488B3BB0A4F435E46E6718B35066C979671628AA50765F7900637D0FEED2715E18529389733CBF5DBD5E9D5E8D9A59859A8B6A0EE70D6C4970CA7A471835C12D1D977C4224003CC836476EB9C41850244470149FD398EE364050FCCD848CCB6FE560C1B0CC92B5A49C88EB3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B953A8A48A05D51F175ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5B08C017726E221A85002B1117B3ED6961E582E5DB8DC58B21A1B8FE1FED62FE8823CB91A9FED034534781492E4B8EEAD2739D626790C8313C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659BCC786D31A89D29F1AB50B94A5133E23036A06B9E81836998960A2D10DD8990E54A2D0D73C5E9990B8341EE9D5BE9A0A771F7E89F6C399FB602A9B25C9AD4F4C4113D4BD1738D2F7DABE3362BFED2FD64C41F94D744909CEF050418E73B5114343AC56E63459EDF0964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWPzsLCFLmFEpsl0Q2O/NArY=
X-Mailru-Sender: 7F28D27DF3217653F22F657F8252CA871D0C17298A6F51F4B951B70A5BD4BD8E91E9A2F01FF060F046A0A24852759D85E2E7FBE4C8C559FA08335C02508E532CFD0FAA000577B61F3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4D39661515D81C76EA60C793E4F4618BA837D51B21E6AE45168F3CF0E9FE49B69C5BE034648D0BABE3A3130B6281602E2D40D3F6CF2721CD3EB992154DD91F0E2BB92221D05867FEE
X-7FA49CB5: 0D63561A33F958A5405BCE1070374ED05002B1117B3ED6964A841D9E900141130F54D0ACED2DBEF802ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8azJwwEpi/pKF6Z5mwDkc4KQ=
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

The Marvell 88E1116R PHY (used on the D-Link DNS-325) exposes its LEDs
through the same page 3 register 0x10 LED control layout as the 88E1318S.
Wire up the existing 88E1318S LED handlers in the 88E1116R driver entry
so the PHY LEDs can be described in the device tree and driven through
the LED trigger API with hardware offload.

The LED polarity is configured through the led_polarity_set() callback
shared with the 88E1318S family.

Signed-off-by: Konstantin Meshkov <skyline@mail.ru>
---
This patch depends on:
[PATCH net-next v2] net: phy: marvell: add support for PHY LEDs polarity modes
https://patchwork.kernel.org/project/netdevbpf/patch/20260923204614.471409-1-=
olek2@wp.pl/

 drivers/net/phy/marvell.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index d57fcab..3b6c504 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3949,6 +3949,12 @@ static struct phy_driver marvell_drivers[] =3D {
 		.get_stats =3D marvell_get_stats,
 		.get_tunable =3D m88e1011_get_tunable,
 		.set_tunable =3D m88e1011_set_tunable,
+		.led_polarity_set =3D m88e1318_led_polarity_set,
+		.led_brightness_set =3D m88e1318_led_brightness_set,
+		.led_blink_set =3D m88e1318_led_blink_set,
+		.led_hw_is_supported =3D m88e1318_led_hw_is_supported,
+		.led_hw_control_set =3D m88e1318_led_hw_control_set,
+		.led_hw_control_get =3D m88e1318_led_hw_control_get,
 	},
 	{
 		.phy_id =3D MARVELL_PHY_ID_88E1510,
--=20
2.39.5

