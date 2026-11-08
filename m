Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125220;
	b=MIgPdULSlDTIoBuXVS4nnE4zO9oOnwflYoMXjeew5KC+o+yhYnDIuZBrUKzTCqwnxgHM
	 mjhnkP42XpltX4zTDWaim2iZUNodPGc777W3T6eM7yrICDzuUAHuvcEWYYj8VjQJoZhKF
	 R2eWTWD2KLTQuL0n2qq/ty41+IcV9mP3BF+G4RkJigkChgP6dtwNgAO8rWAygoVb6zKOw
	 1PPPOTEM8cnsqPjuh13ubvsFxln7QqjlKzm1ckrTRbQ6zJPhrpE3J5V2D66g9NXFuvaRO
	 Wu3e0v6aOONDmCcVtwuBJZqTwuT5dAnT4uu904O0wdOGhXobIpFfA70dyIq8/exL5Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125220;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=cCUDO6hpmWPlWvGiiXpkfQ2w4rus1uQTPSE74K03cdc=;
	b=fC0YdbxpD1dUEJAFy39aUM5ZIcidqXM/XrTCUDHqSkVkiDGF5Qn41GPXbL2lL2oCxS9U
	 yNsKWY3X5XfmlJWnq7LQVWqjFTmh+2rT5wPWNvlJUEz9lRdhFfBahgu5ToyE8JeUttrnZ
	 oGt4W5+aCUYEoxXvoQj1o8vFWu9l2gdWe+8W7F/4V4Yo6ztptzM0UWuDaa54WKAjaXI3f
	 +B67l1G/TjnIIAhgKPLR3YHAPSY39XNKbTDwDm5d3ZqXob2cFCdfkehKfbPMxn3NkIjTE
	 6z9muK0JbqDpn1n8AwspPS59+tjm34ZudSI7yMDM2e72Q9rovJK6Lf0ogsrf+2ZB3GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Ul570lH3;
	arc=none smtp.remote-ip=66.163.188.146
Received: from sonic303-20.consmr.mail.ne1.yahoo.com (sonic303-20.consmr.mail.ne1.yahoo.com [66.163.188.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66A606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E66A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Ul570lH3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125218; bh=cCUDO6hpmWPlWvGiiXpkfQ2w4rus1uQTPSE74K03cdc=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Ul570lH3ooQ+TyYTmKbK8hJorTxEyNsrOQlroq0ddCQAMjJVhdbQDxIR44jHiZAs5S7pfh9AGT7j2F3CX2xM85Q1z3oHpYfWe4JWS2yoeusaJ2MFlRH6WlU2qECUQHGa6yLyDDprKgq+YKWgo0+dH175uBKRREirinBzFA8yIceatdGYsftG89eQKHd+dsyb6XvHL1AstvYH+7eKEeykVMkHBE37e+cHdTElVKo0cwkLhbu0fG5EIn+ijVWdqguvL+VH59oudd/kdarNqsrSPfvhaUtBtWqNZD5IezZCnZgNsbSdXnSqjDo9gqqFTVC+NvJPolL3hyz2if84w1488g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125218; bh=BLmi+WmJ/v3Gq6vUHeDPzWUoZnfCcLgZ0vmPDEkiwZJ=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=V51MShxhy8Kc/GpjEeEm5H4e261NARILNe8qpxzQMMTq445j9ItTqOz7c+BzJwrljKcxzUEryZwVmOswvLFlwSHqnqn72UL/FpdlqjB5rj07Kat8sUwLXDBI03+bggv6Dt+54YMyJiUf3ZZrCcWfbUJ9xfUn4+WtNFM7vlzbW/ghCRCYYik8hbpmATBQg27JOFIXFOjj8xFI049+O5wsXDBzmpottNELugriomPll6Ig2Ue1hNR+4l2MdXI7Ye6+D7DPVhod4esNjYb/BSUYlcoYLCmBqVzAGndopGqWn+kO9ETpOOCtKN/g1z9GLhLBXCVevL/NtyqVwCZGrjTU8A==
X-YMail-OSG: aQR85gUVM1noA.FGZVp7rbn_Gc7T.lxaz3Tab5OaiI2UTt2W9tzg.1OvORhwaK7
 NGqldxiFOFudl4jIgLzLE1nYMB94_TsDbiOSxIugcotk0Dcle8aHfOdaOjEmY84ggCVQdprtUmwO
 JksVz9f4Bt5L3gdGo6Xo8Y3_rkT_.D4pjBWU1ApkJmAAQcW5dh5tHnqC12KhbkDvMGyTPwXw4hmJ
 3Zl2duJalGaPBCbBoG4vrZgZw178ulfJ8jQcxK5gq7otABFOr8MyRdiSdAeUrTMusItpkbGV5Fmc
 gXlpEZ9.gEgKNiqOlpUns.qmrzhRBxzYWy8l8lqWoMN9_Me8m43UQpFZIo.jUyTMDwluXpIjeJWB
 8IcYCB6XGnDLGIe2mCcNpiz4bn0Mdjvuq00Wg.hGtfDsUNE9WiS52iOy9ZZ.hjU5uKyLicj1GlO5
 Z8acQOB3gwmojCFWiJxhIQLhNrLBvxW598fEdoH9uJ.5TCkhBvhVw_PYi7TtwhtapUPsCNwxTckL
 0z2UoNikwl3kxflfkceL4UdbwDyMEK7HnuqgOf3j_qzaY1dXKCRNPTvg8cbE8tQR65CXjaA6N50l
 EPUWtRH6KZmCPdUrRX7HXEvaygrSpj03uzCpm03ZfDcXhZi8_ETRDoEkfEXpFAxEkc1sCVJdqvMZ
 CnpSAL2__xHHQLKpdGxHkeUPEgfVgU7XqbzyxhZk7o0bct.ZhalzlG7jFJcHN4CG29hsKmA42yQO
 ScOSBOSCrvZdvcwAlSuOLzDdsFaRJJ4y2Qbzqa0pfAPk89SAyQDb1WE44tmhOTOAwfmg4EXp5m8B
 0dzC.H08o.GiMMiNY6wKFf_xGtUb80HfEwWqcLE8hHem8TaAld3reafKxmQ24DuYbR63jgcqr7At
 YdtFR6dJCV0E18WfO9QO4t8UJF_U.GLV0GF2RUbbD3FbBUP3_8IXecTYrPtnLRVDZMCzTBtuDB_V
 ckwBE11OPz8WieArGxAVg7Sx12ljUf7YuZuIgg6FWjI7V469f1rzo49hAejrGy9eQmZh4WcCR7nw
 k0RF9hPGv4ewK4VhXnLFXgHErsNs16LIarDthLePABIFy.vHQkkHS.cQVVTZhtOVsjAdt7Yz79mq
 9vLxlqwPuZEQclRigK2ZVVBLhtNun.fid4rcDFkrpMmE6w0iDAqnuORPwrOVNXclVgsgM4.MfzGh
 5PY8uzUxqWOYl2N7lQnQfPkw0aqdiqlX24JelpyI3WKWN9Ep.e2rGoD3oYavmFjY3cqSiOYlvl3X
 As82FgWR0Tdw1uhbRAjV7rZCE8u7ynnsu5BXUUuBbsztn3ZzK9Z_raqr0PHEHB4RMJ0JGyObPx_F
 XEVZbT9UPda7ELx9Uv4nNR4URsz2IZ3dCt9KmsDsbjdz8IpGRJJRGkUbdcmMFBf4HZGZh1LkPaHl
 BZym1KDiFcepSytB2wSqtBIFPQv7Dozbhl9p4N5dM2kPL1siI0cILA37w3WTlQ05krFULBqhazNK
 o6IfCpsk7dAJAB2Hhy6fh51bOxwG1sOjvQ.ruZzXR.Ff8klJCGK_iioJAMXCbhBRL9l55pixfwcX
 beSi8ZX7DNAFACKWoCIWWYIGyATKJ370MEC6pbzP2FAxPGkMqGJnSEbVKe62B6mAodCWfxP1qgRm
 IHUBman2SaWYROWUI61495Zf2YLlZMsLo.mk0IoLnXmmgBo7rjpCJPKFw.c3mvZ94IOGlTGSN46u
 YOooOxxqPaisrUI0HKF._GLWwOI2ZsMzHNbSiqnfO2WCspeUfiJsvMO6Q2W4h694erlrASJsBJoP
 HYKRIXPtWCrff2ALWA5LuZDSng3IzOtPFdvr06loQQ9ZNYR2Jf74etRmwljkhEu6SZtSHUksH5YS
 gSDBUvkrLArmNxbu88rt6j09t_0jIn_aSKqolx68TvV1hDmMTFsqjN8hbLrZM_KAYIPBYX9Scusf
 NuoRDp9ruhMugNE1ZfC2gxNt0glR1ROcsLG1Jg_3bnq3hZrgCk04uy4adWCxv6kyA.yx7M44gb1z
 tNQC3h9XhslIXsDAj0ScSuAdHW1.rIHRXifrAEvkYRRdXtQLGP28CBRLQDmDStw3j.e7EP8ojJDZ
 El4l_uGNfly5gtCERTVJ2.HyeZ2T.uf0oV9ntsy_BDxuqwtgMTAY17gFuwaoVe64B4gD92HFzQLw
 hDprVTp4DMu7IWE0paRbbx9YFpoExw3X8ndUfS27IeLVebg63TFKsVlhtzZ3tRsY.Q5RDxKUsthn
 ZmVxV0oh1Hvdudoo6p49XX7OKDYztcWXWuApoT9c467gbjJq.vs7iEYeSWKPX06OwpzpNB3FYWV7
 NZCAAoWU0k6qd7YYQZu6Wk2kKGeDD7e195jAD
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: c610995b-83c4-483b-9fb3-cb7e38ee670d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:06:58 +0000
Received: by hermes--production-bf1-6d6877594b-txh44 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 29fc1b2c3ae916a3487954e516a1409a;
          Sun, 08 Nov 2026 08:06:53 +0000 (UTC)
Message-ID: <310bca10-e082-4d0a-a645-42fd4e58d2a6@yahoo.com>
Date: Sun, 8 Nov 2026 09:06:48 +0100
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
Subject: [PATCH net-next v9 02/11] net: dsa: realtek: rtl8365mb: add chip
 family infrastructure
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
Content-Language: pl
In-Reply-To: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
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
---
 drivers/net/dsa/realtek/rtl8365mb.h      | 29 +++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_main.c | 52 +++++++++++++++---------
 2 files changed, 61 insertions(+), 20 deletions(-)
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
index da06f95..b500c84 100644
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
 
 	/* Do any chip-specific init jam before getting to the common stuff */
-	if (ci->jam_table) {
-		for (i = 0; i < ci->jam_size; i++) {
-			ret = regmap_write(priv->map, ci->jam_table[i].reg,
-					   ci->jam_table[i].val);
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

