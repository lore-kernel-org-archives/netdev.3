Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504793;
	b=mzHA6KgW+CaTOtqzUg3D1ZPjiw2cJBDptyoPWD7nz1GWiK+osId4RUjuYSzcMbwhHfDU
	 3YccKP+czA/HhaLlw5fvt+un+PTPiG+tiN2hMnbhs29WmviG6ssxmVtsDi3l11sgobsJ7
	 3PVY/W76a5cBmvHc/Z2LCEo+vw8sUIB41OlRXK0eCUtpeNLDuVG2sCFlttQmNMRpW6ljh
	 pZp+ofGnaH/g/L0WLOI4bQB10ZoGSFfXxwH+4IOatH+BnvsahvBuTbNSLL6x09Lt7KG0G
	 88+6WVHpSMTJIg1qrpGc3F+B+tQ4G3cy0DrN18Jtb/lEMGuf6CUAisKcnIV3yZq72Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504793;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=pg2FgbyIFl0pjZOmJzpheHvkYDwQlfZjkHc9zeduk7k=;
	b=UedB8B1HqCROh2IE7s0KGMG9oyzNu8CqANKWzVAKYJ1LvX29ue3+9TnSRGV4T9Dbm56j
	 msWQLRVmL9zoeed/Fa2hp92KDGjoXdlWZ7zuD3Rs5Nmde/LYjhjyy0xZ4+3ukFJInCL2H
	 oSZVeGgz8guxiaiGVjOdtNK3w3AADdMKittzKegzVEeHCj3T+TlIuwssMB7tVdo9k5YHP
	 OCAPsfnxia+HIJopcctjs/TN5VENY157nXCduI3SI1DF3hYtJYpJ4hOx/L2hCNR/unJki
	 B8nhm6vv4pUKILiJoNR8SrxJ1pSm33Al7YiWYPB54Xcd4bn8CW96uHntTPLZAOPKTyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ocSNBfbw;
	arc=none smtp.remote-ip=66.163.184.43
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB3606A893
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8DB3606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ocSNBfbw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504792; bh=pg2FgbyIFl0pjZOmJzpheHvkYDwQlfZjkHc9zeduk7k=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=ocSNBfbwcs7lV1KrHta7NrDeMOrBS6P6NstEyxWRs2YxFzBsM9gqgd6SgOnvqhnH76GxX3MDsUdkeixQaMJXG/p4hEduzkzOFodSIo+AYZtf79VrmPB+uyv/+lX48TgzJZe6z0Ci0pivPF9v8ZzX4hFMvMhtdIm84lXxs7gVs2yE50sPl13XzjEfoy3m38AjsZSmhlEFbsdBPEq1+Wn1xDxNsQeWMbZ+I6dEgQswFed9jxdL7Fl0S3/scEIw3JUROvivd5STMfSCBUjy33VJQq2BK/n1hHIokpQAj96oEAfs5kk/nk171HFSt6rYELoNu6HsMyTqVhI2LhycCr/kkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504792; bh=TK8XmyWMDEfGN9brr5wBwS50HHVfrOKjhyBSFtIWJ9G=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=VFfLBvoJzHH4YjMKiGZZTsCZH3A0Ai47enkWOqaloiZEAi/jfjk1i6yPYHkKiu3hE77zUSLYBRgBu1CTIMzjSQ5cajT9xifA8UeCOYgw+u5YQPcdXjYgPWwgH40ksi4mq4W7Wf1p9GMtwdJQt0sHpHxxvIpW0UiJlG7OU9uVBWfi7Ffx0l5s9yy8XAGyoNJ59g1C+awqv8B8qzZBGtK/7vltSs0p4sZNTQDdslRdZGEg7PNZEDUvIeYA+zXkFHJLplv9C8mJcO5/NALvdfk2Sfr5FjwEfznMPFLK1Z6M0AOHg5WFtH2LIuJswfEuOYLD5VrT9FXoKDTPt2iEDA+63g==
X-YMail-OSG: zBYAsu8VM1l2C_DaFwUsBB2p8yzG2Xs50KZCRD6QxfOn4g7d3QGGZfRsY1CAzUD
 nyGghg01ijM2MwUq9QPQDHurP1TdgYXcDmP61QN2ikrE3.sxdOmbdMWAi5TgTEaBE92L635qei._
 J4_b1CEnnwxQUnitWQkRvIyqhCn1rClelJhYPFpA7ToeZnMkSAM2P3Dz3FtbXKCHza3OngJhuwe3
 OobSU876QMYpzV4W39klOIEcIUnwaVnXWuhwpr2I_tAiZYyuwrHefcpFl4LC0z.J5A._PvkYvXZu
 .4gIykUMqUX5QxvxwdVaLqQJ5X_hvHMB5vAeba4P_1WDonPUKH2FmR3fuVwxeZ4acaTqTLbsZvuL
 IFPnUehatiQW6.ArMpFcw9K7KJS_ZfNwlO2wgnB4O4R9HTI.XU1vdB1MMYVujU_RZekgp4.fyqH3
 zLzh2vH4ksXVEh7ebpJvqXtLQCHDIxVUVjpTFkK_N39hEzxo3Mi88_2I9e4PJuwOYva9EeLG8cTJ
 zBKf7tCIcsR30v2EsN_QlPQQ5cvoWdYRsu90PBhqIw5GBllg.iXqNIsRieO48COVU5hBUsI1_lPs
 tF2L9SYQ7s4IT_eLltgyUi7yNtdQEokFo.9SGwnLXOfe0kPj9C.67PVwp_1SESLEdII7LPcEVHt2
 5N6ZFRBTRQhi_uiwh7a.gjjsuwSL_76X2AKBuDfletLUkNGT5iOJjkXFGYcOQgW2Dxhw13EhrcB4
 Y5RC7pbXBXsLv9A54p25lJtUDcaJ.9FdofUfQXXwVM9rOdBF_zGuXVbdZ_WpNRS.srHhqsEhBqnH
 Xz.TB4Q8hR5jdEkSAqoY6kaDIbnLlRMOVY0fiq7cs2mIEMt_0MbrA0gCw2QFY8TgYxluIMexXwMX
 ChRXNn1bGQC_372cRohXpkrohuE3UY2_qI.lFNQYqTUVGZ_wvZcGqXD5xtdRn0j8f7FdoHNpKBkz
 cMMGy14JxDcAEGdWBdjHqOBYtyntidfa3hI5DHp29UVG8QQBJ6pJgnl8lL8ihU7k2nn9XmBuccRP
 2RnL3CQs2VDg8mX6UCN7NEUwk5wEljnRrPDdvdG.F2IW8dn6o1Atr3QhNRzFwHg3DEBFusG9sit2
 c4CL.WJxHW5r3FSfq.bG4HlztEUQdUPtrhuj7YiTnH0UUYcNE_xS40P4hOevW8aYSIYxsuREdDdr
 O0I9.1dBtwO1ZcrQgWuINf0eN5lMTwrKvqDLIAm2bWZZGBHUMe9WCAEb3WwOj6RGDKnO0.3vuBJ_
 ukVMqcUmyCY_sexL_f9znrCMIpMY4ISp7kw12ryl.kUh0uHk1PKSFI_rPBVDiki0zYifEj26mBrZ
 ImEApI78YFbhZSFmhxiiH60OkYiePwPMg3YKgfoxEQpAyTUIQVC_02LsX82S8G4wKoLp1jmkuGmU
 Bjjhog_CtjLkKr_F5fdJYHsFs9l6M_uOMMMlTxNh9ytuGr0ELsqLa42_PnS.5.khTWiH5Dfo8dbg
 L_UCFJ93fab4nz.TCYfN_FkVbA4pi_7MOxDfs1gEqzOdvHsIrG4_1f9xN89eWyaQ4v_K7Dku.k41
 4Ci1nkCWCAn.yE44EcffntzQhQR12i8VH6UC79rpg2mbZejHVdh6eYBoMjk5h840rRC0v1Pu_e.a
 WZQD0omRfj1hJjoV4Wnz9xIgo9BvdC7zMaTBhDyTXhLCJzlLjcH_h955TYiRp05vAoxe8FUV5efv
 x5fl_hPyjYZ1i_uUDqSOfvGZJW6HOqZPDZfi9GWGolOidm.io93B5z4M5mnkonC20NK4YyXr1IEf
 lbnQijhBOiCiV9yPiO_uYAl4co0JWI6Ql5v3rRx0NOtTO1y3mnf5yAQATNHJqe0tKwcNrBKDsxAl
 x5upIku0QA4EIGydQ81_dHy.WfPWaowb2kIu0X7zk7WwPIOe1wBdtOJJhc35IZGCYfF_JvWzbifF
 fycUzzehHxUtTiNu4yvcNe9TvXwYUCCrDRnVm46zOHruUdRqDH3UMTYkCGxREOGg_EDTIEWJAkng
 lpa56oBZpLfhmy3auESZVvoIDFQ42UII20Psps4wCvxtEi4S7..xOqPBu2V35h2sj00vJRL225ZC
 .hN6ZBf3FBu4ZlVZ.8T7P2BVxtcdaV9.nVdh2r9qse8dmy5mxUHuAATdSmQ3yTnvcMVlbSlFGDAP
 yMBvHdd3O49kJzcK2XGfPq.oFk7yME0pB2YoFX0aWREO_Miu7s4iURB.3WYhHIQvciG72.p19JbH
 i7wwkP5vXFuqaCJTQhEh3XrJ3dpRZqYX0vOsAy59vHfRndIScdjxR.KwTpTHEbUU2ZwW95AfalqG
 5edHBwy0Cc2Ln8rIXU7BDOFXXnKm3wAf4CTCvyr0-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 44440209-5e6c-4872-a0e4-8dedb06f7f63
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:33:12 +0000
Received: by hermes--production-ir2-5dd9bf4598-hl6xw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6cfc8d0ea86592f985678e54fcd7913e;
          Thu, 12 Nov 2026 17:33:06 +0000 (UTC)
Message-ID: <decd2adc-b23e-48b2-9cef-5517be0e8c8e@yahoo.com>
Date: Thu, 12 Nov 2026 18:33:04 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v10 02/12] net: dsa: realtek: rtl8365mb: add chip
 family infrastructure
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
References: <d9da17af-f49e-4878-a8dd-59a8919e6930@yahoo.com>
Content-Language: pl
In-Reply-To: <d9da17af-f49e-4878-a8dd-59a8919e6930@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Add enum rtl8365mb_family and struct rtl8365mb_family_info, which holds
the data shared by all chips of one family: the family id, the port
count and the init jam table. struct rtl8365mb_chip_info now points to
it through a family_info member, and all existing chips use the
RTL8365MB_FAMILY_C instance. rtl8365mb_get_family_info() and
rtl8365mb_is_d() are declared in a new rtl8365mb.h so that the VLAN
code can use them too.

Use num_ports from the family info in rtl8365mb_detect() instead of a
fixed constant, so that a family with a different port count can be
described by its own entry.

RTL8365MB_FAMILY_D is defined here but no chip uses it yet; it is
needed by the following patches, which add family D handling for chips
whose register layout differs from the existing ones.

No functional change.

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Tested-by: Stanislaw Pal <kuncy7@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb.h      | 29 +++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_main.c | 54 +++++++++++++++---------
 2 files changed, 62 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

diff --git a/drivers/net/dsa/realtek/rtl8365mb.h b/drivers/net/dsa/realtek/rtl8365mb.h
new file mode 100644
index 0000000..daa8f0b
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RTL8365MB_H
+#define _RTL8365MB_H
+
+#include "realtek.h"
+
+enum rtl8365mb_family {
+	RTL8365MB_FAMILY_C,
+	RTL8365MB_FAMILY_D,
+};
+
+struct rtl8365mb_jam_tbl_entry;
+
+struct rtl8365mb_family_info {
+	enum rtl8365mb_family family;
+	unsigned int num_ports;
+	const struct rtl8365mb_jam_tbl_entry *jam_table;
+	size_t jam_size;
+};
+
+const struct rtl8365mb_family_info *
+rtl8365mb_get_family_info(struct realtek_priv *priv);
+
+static inline bool rtl8365mb_is_d(struct realtek_priv *priv)
+{
+	return rtl8365mb_get_family_info(priv)->family == RTL8365MB_FAMILY_D;
+}
+
+#endif /* _RTL8365MB_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index da06f95..e25eb7e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -110,12 +110,15 @@
 #include "rtl83xx.h"
 #include "rtl8365mb_l2.h"
 #include "rtl8365mb_vlan.h"
+#include "rtl8365mb.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
 #define RTL8365MB_NUM_PHYREGS		32
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
-#define RTL8365MB_MAX_NUM_PORTS		11
+#define RTL8365MB_C_MAX_NUM_PORTS	11
+/* Highest port count of any supported chip, used for sizing */
+#define RTL8365MB_MAX_NUM_PORTS		RTL8365MB_C_MAX_NUM_PORTS
 /* Valid for the whole family except RTL8370B, which has 4160 entries.
  * RTL8370B is mentioned in vendor code but it might not even belong
  * to the same RTL8367C family.
@@ -702,14 +705,20 @@ struct rtl8365mb_extint {
 	unsigned int supported_interfaces;
 };
 
+static const struct rtl8365mb_family_info rtl8365mb_family_c = {
+	.family = RTL8365MB_FAMILY_C,
+	.num_ports = RTL8365MB_C_MAX_NUM_PORTS,
+	.jam_table = rtl8365mb_init_jam_8365mb_vc,
+	.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+};
+
 /**
  * struct rtl8365mb_chip_info - static chip-specific info
  * @name: human-readable chip name
  * @chip_id: chip identifier
  * @chip_ver: chip silicon revision
+ * @family_info: data shared by all chips of the same family
  * @extints: available external interfaces
- * @jam_table: chip-specific initialization jam table
- * @jam_size: size of the chip's jam table
  *
  * These data are specific to a given chip in the family of switches supported
  * by this driver. When adding support for another chip in the family, a new
@@ -719,9 +728,8 @@ struct rtl8365mb_chip_info {
 	const char *name;
 	u32 chip_id;
 	u32 chip_ver;
+	const struct rtl8365mb_family_info *family_info;
 	const struct rtl8365mb_extint extints[RTL8365MB_MAX_NUM_EXTINTS];
-	const struct rtl8365mb_jam_tbl_entry *jam_table;
-	size_t jam_size;
 };
 
 /* Chip info for each supported switch in the family */
@@ -731,29 +739,28 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8365MB-VC",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0040,
+		.family_info = &rtl8365mb_family_c,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
 		},
-		.jam_table = rtl8365mb_init_jam_8365mb_vc,
-		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
 	{
 		.name = "RTL8367S",
 		.chip_id = 0x6367,
 		.chip_ver = 0x00A0,
+		.family_info = &rtl8365mb_family_c,
 		.extints = {
 			{ 6, 1, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
 			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
 		},
-		.jam_table = rtl8365mb_init_jam_8365mb_vc,
-		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
 	{
 		.name = "RTL8367SB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0010,
+		.family_info = &rtl8365mb_family_c,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) |
@@ -761,21 +768,18 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
 		},
-		.jam_table = rtl8365mb_init_jam_8365mb_vc,
-		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
 	{
 		.name = "RTL8367RB-VB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0020,
+		.family_info = &rtl8365mb_family_c,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
 			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
 		},
-		.jam_table = rtl8365mb_init_jam_8365mb_vc,
-		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
 };
 
@@ -874,6 +878,14 @@ struct rtl8365mb {
 
 #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
 
+const struct rtl8365mb_family_info *
+rtl8365mb_get_family_info(struct realtek_priv *priv)
+{
+	struct rtl8365mb *mb = priv->chip_data;
+
+	return mb->chip_info->family_info;
+}
+
 static int rtl8365mb_phy_poll_busy(struct realtek_priv *priv)
 {
 	u32 val;
@@ -3036,17 +3048,17 @@ static int rtl8365mb_change_tag_protocol(struct dsa_switch *ds,
 static int rtl8365mb_switch_init(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
-	const struct rtl8365mb_chip_info *ci;
+	const struct rtl8365mb_family_info *fi;
 	int ret;
 	int i;
 
-	ci = mb->chip_info;
+	fi = mb->chip_info->family_info;
 
-	/* Do any chip-specific init jam before getting to the common stuff */
-	if (ci->jam_table) {
-		for (i = 0; i < ci->jam_size; i++) {
-			ret = regmap_write(priv->map, ci->jam_table[i].reg,
-					   ci->jam_table[i].val);
+	/* Do any family-specific init jam before getting to the common stuff */
+	if (fi->jam_table) {
+		for (i = 0; i < fi->jam_size; i++) {
+			ret = regmap_write(priv->map, fi->jam_table[i].reg,
+					   fi->jam_table[i].val);
 			if (ret)
 				return ret;
 		}
@@ -3349,7 +3361,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
 
-	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+	priv->num_ports = mb->chip_info->family_info->num_ports;
 	mb->priv = priv;
 	mb->cpu.trap_port = RTL8365MB_MAX_NUM_PORTS;
 	mb->cpu.insert = RTL8365MB_CPU_INSERT_TO_ALL;
-- 
2.53.0

