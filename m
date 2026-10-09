Received: from sonic309-22.consmr.mail.ne1.yahoo.com (sonic309-22.consmr.mail.ne1.yahoo.com [66.163.184.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916727B35F
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522223; cv=none; b=jz15AGskobu/vJ12YIAo6voJAyW81VihdMgVFAzbGHvJi+5RarcM9FD2U7UPG9GnQXkDm+fuRW5uQl7C4GHP4GmIUNTHSquaQRsYl3xHNjCFk52EuIxUUw2lExghPQLQ8B/Db+/pUbG52S0bDUdoAQuEVP38B5Zj9P8S02zzWYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522223; c=relaxed/simple;
	bh=eVk57hN9ktE/7tQ2bC2mTWoKmfG96R3Jw0Xn/GzyhLk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Adej95ZIQatRtnX+G3dUCHshoYcDQq6rPc8OpaS00q+KXa6vzcUiCwtItMwoZ1L2Hg6hV+jzZrjoMOe6v800cTdM5JWyOFdEvy1zwv4+P1DA5HYJh44OrwApJMHb+E1/qKIGtR/HzL4Dr3tsPgoA2mBmbtSn8JjPZ/KTO1sZVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Fe63EESc; arc=none smtp.client-ip=66.163.184.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Fe63EESc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522221; bh=6DxZx47zPi7OKeOxP8W5/e9CYPnMSVEaVB37zIkAvfA=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Fe63EEScNOK9OKN/DHQKc0i08lHKlE2z3tO5Vo+AZJ4iCjQwpRu4d/Se7sYzNDdD7aEpbgM8FuofKYYmhTRahEnUsXkfSkR3WpLSZNRKU8jLrrs0UN+A2ZsDSzyyehfvXx4V24wUC2emzOtzaLnns5wYg00pPI2YfEFMSab36hfQrbRec/WMkJ65qbcOyqZ3IYdnEClRp0NkUKBUJt6caOKgIFwTSitRquqXfUJkHR82Xr14aT/ToL5mLqLpAC7KfmhoVV4zF/KDQcDvvuHusc+dQFTgjdw7/c7vVDmjlE9Tm0jIDJ9Qz5LtF/802ymBBK5KMiJqfpoT9dPCFaCiKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522221; bh=jklumYHGRwvF7rQ6y0zICvixEgJaxuws60FmleBIS2a=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=p+rCwsO9MEuqRylGC9ZNpy/KkaLGBUxcwa0/+KzbMP7iamClV+vwi8PQKrakP4VCFlhGShB+Oyc/G+1IVznhWFS52AYGjSetfI+MJgw2EWb2lKSbBXm+HC2GtTQXQZmwE4x9C2oDP8kDT3n6EIry9EWzcqQG7SYatCCImTOxxpFVNuwG44AtXfrNNFzbr+Cu20BjDKwHcID3HuyIFoUygy0yzKeB/mU26fWXJaPUgZq4r2IOYrSzIhAnSQGjqrWmnrxdRsrfG5QAmW5rs/6KKg9oGMWfYQM8AOGbVNmg6QLeQPrLde88m1l83m4WMVzUVQkzYLj65bp/OpPAmiuA4w==
X-YMail-OSG: OYXCXsAVM1k7vv4kOiyUFaay1sXnFmuy_mGo8jHFIJnFf2vTmgyPg2558YCWRFV
 D1ElaRkvDJtr4UZs_YF2i8nFdyleOck6LTqJPXKKfnkTWd0owyOMkVFJ0OjQ88RMeDuZAREtWMlU
 cXoF8WvOL9Bv6NvKcyUrnSdP6H0jjTo2mkDLjZhmlOWZuVSeKQ6ErWfGSf4zzYA3busy9deHlBzL
 _aGIuV_XaTxCulCD9ATAdcdqNUaCKc5PJfjzKE17DW_9GQ_HWv6KawybwdKUnGNJ50dS3oVBEiCc
 VH4HLZELkgee5s7_ywVbLjoKkm.g6YScOyKKvmMee9Ec8r.NScXdeGF8K3sArvLccU1Kv6Y8a7VM
 98Dg_JPFzvr68ZRgprFYUNhFOv3Ptc4alDwrW8UFeJVQmkw__BTnybLzvD9wtACq91MAy6nuFEuR
 1Q.2Uum.pnL2P42A6SiDYSSplnz4oqC5lqgydG5jNts7AIoVhoTiu8igerUTXgq4XjRs9m41ax30
 Bc3zCCCjOwz6j01CNYRd8Xq8oHi75zDoUh9ZUnoPYGggmUTPRIgGIeW8Qor_U7RaG3vj9_ggq0wH
 C7xOPmsjn79I_.Mlx_r7PxCsh895Do3QHmH78t.shIiTvXTgyzlGSjGEsAcDA5nJombRLI5rWW6O
 kpDHVlDtmZ9OdOTut7G6PioT22cro2.j.8l9fA0hxbaoOydFX2icCLwLUdA48e38OfDnkRk96xdf
 Nkok9htNxvn.VKy7ta9bPx06kLQA1P8lv0TRKBqRhQwW0a_QSx5MEU9qJ1.fUIL11t59gS4bthwa
 L80s1gY5ZJFSn7731RqOBQkO3MQbTi.fRgQy3yKO8QxDBLvq9dOi.NTVI.ARd6_9pDr0RDEadaQw
 WGakymenrpaTuXCAyrBlbHHgBaFA1epbkaczrg_JhSawgq2qkxNqFfHoo1EMqMiLcbsszXjZvWl4
 I8mhztgfwr5Ug66I3tGdcm5SnRfLpsxxM1GvfLiU9Cc9203XQFTJvonNasNkslfzfHiRzAF6kYWv
 STrRuI0h34fOObPNBUp6J9MnjMZqUzumsZoFaz.qeDWvU47z.LMuWIe7eshri5LTnvha9V4S1njK
 CeHFnMazwNeYj3B3Tn1VtWBETTRGnIztQAUOYZQThFHmPVyLt1eytvg1CsnPM8rdZu3gyitLTeBb
 uxLPqZ8otM5oUYBh7C8gX2cKCmg9TyGd0vvpXxqKUjO4y2eSsvh_FF.Q3qCf9cPp5kqpKL54J4kd
 i.shTqu8uIOPkz8GWiBdGfJGNp1OosgjueppsLAFM8im3z_Hz0mLrsLOsoPn.9QeT6MrXqrxldJn
 g7bjuCE2PpWllqROtEyap8UHmSOy5WtNkzFFNEXpB_Pz7bak09qU3pMmRMynmYFKdKceh9Rnq6je
 kmJodmhxDUulh7kouQSZ3JvnfBHx1rnUxR2_m1aLABb2OwFPFMcLE9u52ZDHeOV7XQ52VqGJHPVg
 joc20abkkWryo.irxIA1Rohr75v3sq9CneJLsP1QdA75NZmjfsPiaKJr7FFXcP4cJ68Ktci1m8Z4
 2QBDD3jOuhUGHilKzzcgEB20KRqrgVqAqwL_IYijSQjOzRJt8QY4.Eit4apDZHWXPpOkstk1Qfpr
 guwcJwEjq9WOLd0yYPZZfQsRCR__EkE3UHdjIOjsS0OcRcALZlA69mdoa3Ni_hnLzT3gT6KSF.NP
 PEsVVrJyDDuJaAEm2CgWeg3bjgJsXZ52sy0HRJR67heQMg6kaqxUoR6BHo2Jr5h9LHngMOI_K4QI
 p5JN0vSH0kBcdmBIf.jNUkHDYAx0kjw_uU_GaULKtRXhylUwavr_NfNwQ3RuK4Wlm_aeQ8a7fWKs
 khMAQYICT1HXfd6lImk39hbAn9Arc56gHyyoYyi_MPiBYgXLnRskSP9Ne3fRYQKdGa8dsJddBDAC
 BRKyJc.qm9TsdUlMq7OJ_Wv6465dpGUHYtYSfeiH6YTy0s3DuTWBYgzvzym9Jy8HA_TOWsReK9Wf
 UCGo7Y1NATCp2CliFTTnjLNDocxNgwT3lpWo1zSejNQP_NzNoxZ2279cslAw4yWHghE0N8VlCHJI
 Ae8gtNqBGFwp2wFwjOZSFkJN5pSUsHj31KG2JmK2oy6aQk_85LWpipZusmxogdq_TUkyy6ztNGDT
 eqg72VIDFZyShFr5ixKSyrPeLTyGt0mbBBccSMIQBOufmcMHMgSGBwgR8MIb_hfWkdAGusuVY0ZV
 YCjl5VKBPrjRzfHq1Vhs27EnVY3151BiGDsJ3SJZ8zsQ37MQZKQhjhq_S8gU_6.YRfvrfs2644eu
 kMPuNiiF0aRt5qOczKs8v9wtEBRTs0u3svNCVAA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 5fc57092-811c-4825-ba62-6c13fbcbdadc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Oct 2026 05:03:41 +0000
Received: by hermes--production-ir2-5dd9bf4598-nbdmm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c67758ed35d833f9cd319f6edfc1a55c;
          Fri, 09 Oct 2026 04:53:25 +0000 (UTC)
Message-ID: <29f75a64-fed4-449c-92c5-c0b67f270504@yahoo.com>
Date: Fri, 9 Oct 2026 06:53:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 1/8] net: dsa: realtek: rtl8365mb: detect
 RTL8367S-VB
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <28382f3f-03c1-4606-9b11-86f118abeafe@yahoo.com>
Content-Language: pl
In-Reply-To: <28382f3f-03c1-4606-9b11-86f118abeafe@yahoo.com>
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

