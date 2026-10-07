Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F33DB626
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405999; cv=none; b=uG3BVh+oA2+9tLR9uW4JpPtcvS880daH3pBs0WJEmxT4hPie0ziJDwRTzBp/7Vrpg2U/NZ5C0wvxlJKifOfOcgky4E9E1Ee9PFhafaVWovT7eSdn80nY4oN5Smit/VmFHnJSLjUXpQGtywe+CYZ/OEHWP0DmWLVgsMIz6w++Bwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405999; c=relaxed/simple;
	bh=eVk57hN9ktE/7tQ2bC2mTWoKmfG96R3Jw0Xn/GzyhLk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=irexhatZgB2IlREJgLmO/bD1O2A+Gi2inKEVkqvWnbi9bf/snAtgt+6zd0mTHT06FYBjAcALa16Scsw/o3VFtEksPjV14yRZFdmByth9PBk7paBzQzuluwIe4olcenP/8xQ6bUGDwgpIXRvMyYI6KxPtTcG4utqBQ/fM7c3QplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Dvki1Ggv; arc=none smtp.client-ip=66.163.184.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Dvki1Ggv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791405996; bh=6DxZx47zPi7OKeOxP8W5/e9CYPnMSVEaVB37zIkAvfA=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Dvki1GgvXqtAULt69CHXbZZ19JXhDF+Shedh2vQfQta421WT4izmvBcQwMRucGb8/Y5wmy9BCFM6daIW4Wv9fK9BOg4wU/x1gFZptDIcPOZIEy/OPs1GMXdNVlfW6eL/dDbrQL3PNIZwNRUPqoBt3CK8e+Iv5eA3dt4iQGzxnBQSzwDUVPqEEwCgiqd9Tx9y6xT1DZx/UDKdjRGAaD06G5a/Bc/J5Ox34QqLQPh9YNF6PXM7OxLdBqVj5BMagomwQCd8aMhp3te4dbMMfqONBvN6a9b1SvGtPy7TWAwZS2D+k/mDZu7qkn3eh2voWStTA6HljA7MVRv+oBif6lhZ0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791405996; bh=n/RvdlfkyyNxfJcQMV0zkj1Fim4twhZfhp9gA7Nzb64=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=maldVLezRkxax0jTIb/u+vh4eeSSKJF8RgorKDUF6vtwgwjWdL7+TfxQapX1S8qW3D+qSVJhQBnLx2i50xsqvzmMBfZRDg1Uqvkuvy9IK1T3jKR/CDxrJxTQwwd9tTGDYvQXsH0450oVfTKecfY9n0cOLpyfvUB9iRWjRYLJntwRnLMZldGg5OSZ5BAhhWMQWciJeVGCiujmoNq+nY1PXxYuTTURcwpTG939o9VZJJQDQGt0js9+Y92okBs1Ffhpx8TQR1Gj2MhdIaUJwmWKWawN9glLuT/gsfskJJ3lbf5SOWB1cg2jVBlPzUeAI9JtWN3q5iPYy/fsDG82UvmtVA==
X-YMail-OSG: Ry8DO6AVM1nAIOSq3B.npRdZUOqNSl3B7zuTzudwfd1WOQ2VAL69_Le0ti53Xzg
 QYu9cayRwn_zviwftaxaEGR4hxZz_1Eredb3_Trc20gJnnFc5PhT_KrflWj22jnzwxVII66c4RVN
 fBboP46AvIvfAdaeIWsfkZ6rxHgsAPY5EnGrTAKdyP9QUlp3Ggr1D6RYgNYB7XjAgXclJhFdU5.N
 5tdT5c3Ni3WF0WKKL31y6IfIxW3JrNcnpODHfn6GYNe5PGDpjCYigNfZjvaq29Df4URlnwaJBESr
 m7Zlk0iOMyjQk3mG98ulzQmUnsNeMfsVLhQ6IhAsduBDVVhlscogLW5mpRg2VBrQMRxklXTCes3N
 aYAhARHa7Bc6tYLjOCdPSSpxZGkbCbfo2h_eCV.BxOkn06rTQjQINlxdU6dvWkuiuUz5oVzaum4w
 58vTiKi7TosK1dXjexQRHlrY9rDnA_dXiPx5ROpsJd87.FPhlg7vipd3W0nP8P2Rqua7JjOMn0mV
 o5S4Xdd7zR7HvKir0X4e9mySxSJX9otS9JmqIvMWN9T7kYiiTRSEe65KR6SMHT7Rw8pTDXEC5hjq
 V_s5.31FXpvpMkdQ1IHhTwOT8wo7vsducbMfPjzm0u8VaFTvdp51DTOp18B8JMGGo8qB0.hq2BEz
 JSDQZhSo7MaGyS2MA8cKyrAFdKQVjluMo3CmvjJLC6niSsbLWZqgVgyXUVoaJ50SueRmCMfyqJvG
 u4CJocab6U_R6DDgyDDHNUiSxQ0tBisFjKa18bHwWacN2HIpM_RtId8hFI4DHuVmnNBxztj1tHfX
 DD0_HHIoz2TnEo7V5hAu.6jrDMmDbAzfzA1rnsF235l4HiPq8Y_zmP.vOa35JbDD5JaCjqQhoCPh
 B2O4IGPSkMVwMy5CEEUfKWYFTa0d5_5XR3FuoQxfM0aycWTKR.5OTw4XoDaBsrBnPCikDrrhsfos
 ul2RRYzZMWRYQksFbbUN3ggZzBMATCiqTFuLQZ5KqlDcw.3i_tREhK9hGzexLcMW_J5V219iDyPK
 FujrttTj4cBp9fEzXc7.u56slFQl4IpejFru1Uh81bRew6aU7Cc5wHAcqIUeQQGkw98ydYIuGZoA
 RztNPyNmT4_36Q48IoaVPH4Axt8aPAUIjlJ0TQG4KDQe9ozSUpeP.q7u8yZIYzYXhr2n.pCu7aMe
 ZGetYkJBed6YvmEZ5l3uTQ2DiBd0bHT3GUQwWG1vcoFiTk4kFftRqHHl7iFEPZZh4LOezAOAMO8N
 _UjzIv26ovg2wD1ybpq_lE6saaaw77Ko2u2gkpqp7zUKgwX9JfBsLWgIkd0C2oRHqp7mUPv8JYIM
 PT6UIcnUnqA5YLPvH.oN0Z2AFSvRnPQsfPRYEf8c2_yFvsJcQfOf8DzGY5QXerX3xmZgJV_xveBP
 krhiH.6lm1VQvu9rab7kotKGZr0pgv6hH61z8jJdjDUiB._Tqx65Yz0xrrvBOCBYiMX5NYx7Rch1
 142E_xwS1FlOwIiG807PMXq7TMWPnHgc3gqiM_LM3CK2FIiuxhyRiE0Rt_oqiuF2DJ8rjgEuCtxV
 GsOgRL4BJBNB_W.INHCmpDrte_QNBk5RReLXaH5TC1kx.ugy58jDYzvdiqi1M8i5Lp_hv1KUlAwn
 _uM01iUlQNZQjubRQaeZi5xxkGlKtqaSea.raZsJy4oMd8Pha.q2TPWhJN6q9ZMoHMZhIwSZZMyF
 nfpPvfhqc787NcUquMCWou7UKgvS.mrqO.IpdYusXgYs6It7NviHi6SOZPR.LXSpkps402XCronK
 nw5.HC87Assa5tqhiQ6g31OSz08aG2mp5hWJVAENvukEqFyU3_BdtV5qo6Jpji1R0ARCEanYBHS_
 9UWLuAFXL10L8KC8FiTsjuE4nd8rID53MOd634MoeLc6g.FEn231m2deXomqfVBVd3c3ZjUe6VfW
 LptXid_D3T1ncNgrgIeEuas70MgZ6DutBL3vfvxlLGa5oDFmPaSj4mKXTZDD6R8nplAEb292MpOs
 Hm_LN.ISiUq6D1nIi6haKs9QMh5_wsPJguuVXaqgLsdYv3jGZYFGTckN0OHOHSPte_vGPrrnfNOF
 ByElaoSSy9U_WaxFZxkyzkP8dfRItP9UVGl7Cs2bWXRLKK8M782UsgnGWmHnPFJIlpO2hBbvnB0G
 XTIgCtFjAtUegyWE6pZAnP0FPYyNL1QQD05nTD8UMkPe2XbUxw1aVtfdoO2vHA9IkQI6Lo4e91il
 ODuKL8imnjt3LzPKM9w4L2M5Ycc_QkymQXQJ4E0IyYF8D0rqZrojLrbriMad7BDl5YVE8xunr2m6
 rYVnlVSheKJcP0t1MGQyX0GqMIfQjOaLrTDR.Fy6BiA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 93e6c83f-1dea-4d85-b4d3-54700edea07c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Oct 2026 20:46:36 +0000
Received: by hermes--production-bf1-6d6877594b-54zwc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 63f276fde0a60670a4834230e0ec9d9a;
          Wed, 07 Oct 2026 20:36:18 +0000 (UTC)
Message-ID: <c973a8a3-6853-4214-a7df-20f99f47d327@yahoo.com>
Date: Wed, 7 Oct 2026 22:36:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/8] net: dsa: realtek: rtl8365mb: detect RTL8367S-VB
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <84fc7483-b22d-45ea-a3b8-3285dc357265@yahoo.com>
Content-Language: pl
In-Reply-To: <84fc7483-b22d-45ea-a3b8-3285dc357265@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The RTL8367S-VB belongs to a newer hardware generation (family D) which
features a modified register layout and independent logic blocks compared
to the older legacy chips (family C). This patch introduces the family
separation by defining RTL8365MB_FAMILY_D, hooks up the new hardware
ID (0x6642), revision, and maps its unique external interface capability
where SGMII/HSGMII sits on ext_int 0 instead of ext_int 1.

Also cap priv->num_ports at RTL8365MB_D_MAX_NUM_PORTS (8) for family D.
This is a functional change: it sets ds->num_ports, the IRQ domain size
and the bound of every loop over priv->num_ports.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb.h      | 14 ++++++++++
 drivers/net/dsa/realtek/rtl8365mb_main.c | 35 +++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

diff --git a/drivers/net/dsa/realtek/rtl8365mb.h b/drivers/net/dsa/realtek/rtl8365mb.h
new file mode 100644
index 0000000..315de4c
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb.h
@@ -0,0 +1,14 @@
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
+enum rtl8365mb_family rtl8365mb_get_family(struct realtek_priv *priv);
+
+#endif /* _RTL8365MB_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index da06f95..80fc551 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -81,6 +81,7 @@
  *  - RTL8367RB-VB
  *  - RTL8367SB
  *  - RTL8367S
+ *  - RTL8367S-VB
  *  - RTL8370MB
  *  - RTL8310SR
  *
@@ -110,12 +111,14 @@
 #include "rtl83xx.h"
 #include "rtl8365mb_l2.h"
 #include "rtl8365mb_vlan.h"
+#include "rtl8365mb.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
 #define RTL8365MB_NUM_PHYREGS		32
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
 #define RTL8365MB_MAX_NUM_PORTS		11
+#define RTL8365MB_D_MAX_NUM_PORTS	8
 /* Valid for the whole family except RTL8370B, which has 4160 entries.
  * RTL8370B is mentioned in vendor code but it might not even belong
  * to the same RTL8367C family.
@@ -707,6 +710,7 @@ struct rtl8365mb_extint {
  * @name: human-readable chip name
  * @chip_id: chip identifier
  * @chip_ver: chip silicon revision
+ * @family: chip family
  * @extints: available external interfaces
  * @jam_table: chip-specific initialization jam table
  * @jam_size: size of the chip's jam table
@@ -719,6 +723,7 @@ struct rtl8365mb_chip_info {
 	const char *name;
 	u32 chip_id;
 	u32 chip_ver;
+	enum rtl8365mb_family family;
 	const struct rtl8365mb_extint extints[RTL8365MB_MAX_NUM_EXTINTS];
 	const struct rtl8365mb_jam_tbl_entry *jam_table;
 	size_t jam_size;
@@ -731,6 +736,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8365MB-VC",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0040,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
@@ -742,6 +748,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367S",
 		.chip_id = 0x6367,
 		.chip_ver = 0x00A0,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
 			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
@@ -754,6 +761,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367SB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0010,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) |
@@ -768,6 +776,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367RB-VB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0020,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
@@ -777,6 +786,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
+	{
+		.name = "RTL8367S-VB",
+		.chip_id = 0x6642,
+		.chip_ver = 0x0010,
+		.family = RTL8365MB_FAMILY_D,
+		.extints = {
+			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
+			{ 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
+				PHY_INTF(RMII) | PHY_INTF(RGMII) },
+		},
+		.jam_table = rtl8365mb_init_jam_8365mb_vc,
+		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+	},
 };
 
 enum rtl8365mb_stp_state {
@@ -874,6 +896,13 @@ struct rtl8365mb {
 
 #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
 
+enum rtl8365mb_family rtl8365mb_get_family(struct realtek_priv *priv)
+{
+	struct rtl8365mb *mb = priv->chip_data;
+
+	return mb->chip_info->family;
+}
+
 static int rtl8365mb_phy_poll_busy(struct realtek_priv *priv)
 {
 	u32 val;
@@ -3349,7 +3378,11 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
 
-	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		priv->num_ports = RTL8365MB_D_MAX_NUM_PORTS;
+	else
+		priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+
 	mb->priv = priv;
 	mb->cpu.trap_port = RTL8365MB_MAX_NUM_PORTS;
 	mb->cpu.insert = RTL8365MB_CPU_INSERT_TO_ALL;
-- 
2.53.0

