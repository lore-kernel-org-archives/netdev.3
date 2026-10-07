Received: from sonic312-24.consmr.mail.ne1.yahoo.com (sonic312-24.consmr.mail.ne1.yahoo.com [66.163.191.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882B417D97
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406324; cv=none; b=OeljVBo5Y+YLPAvxd6krLv9wtrdCmq2GqiTmU/4shCvqH3FTMYjoNKpHlMMiIqkTarvIXQOJcr2a5Bg8EVw2sPLAl29K2zfq3qcM1EQm0/J68LdLNMPrqQYIpkzpF6hFLB1DqPprrB0ZN2/3k7EaOp6h3lu2K+Se4fQe/B2qSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406324; c=relaxed/simple;
	bh=/r9JMwER2+88dtbKPIx5dzfk8M4StB2XA7X/zFNQ91w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cIkg2wXk9OkpHF8ZmTAJOYix6poMHpxAGoKBUN6QGVEphB8Q3Q23WVXINSC2XHgvOwtRBcyeQwmks/SlrPKzZ18vNlT32zyKKaZ0N/n1OTM7cIV/rA7Mkr/RksAoY5VaeEO6Tj4015RMl66GdnbOxxyOFT+ebNRANiqiUklZyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DYO4jSTj; arc=none smtp.client-ip=66.163.191.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DYO4jSTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406322; bh=sb7e1c+YQ3u5BR4KMCvK0Cxl9zSsvcAymOX1b99ohs4=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=DYO4jSTjIAmDIsiA/8o0GegWMRFuknRqWBqQoYQv4HxQtE9pVVSHrC8PgPT1ccO2ZhVd/iNI7gBtjiFJ9q/Tm5FGwio/wpVcI6Qw3iikt3AMRu0NQ6LkYB5BytMqdGu5t6R+gTW9HI3rpmBTKPcUGjkHs+59nIz+do6LZolJnTshlNCALya/2POLMp4IhHFg5JXWlrUFKH+JzDvnyCC6DJV34C5kWERE0Qf9SOZfNVZV3GhEio+1wy0hIaCIYgb+bSciZBGYd/97/8BJCNAcEwMj72shbDI4+79ZbWWD03sd0i+t5zwc+7dQAHorGzLutFfdygnnOfgyDwd2RMlv8Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406322; bh=tfPtEq6ASs5VomqkRoif1g43CNutAIFaNJ+313uytBF=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=VrWYwFpE80jekYU5LNSugkLiraXDhRVQ/hCvtNYSrX+kmRUKQYKhdvmd4bHPBVvybacUJBbDJrY0upM85mTIcY8ohFzoyZ9JRmgjvP9p+jOtSTLUrxVttCXY+L1oA7JNaWbSJmNEXc9hEBQP/etLtUhHoVagVDMB65RqhFIM2+U743eQ+pagVFj8493N1ZUFYzKASXqBiw2rLxOpiv8EK9IZFhhQjseWrfexuE0yYjTgcMH+J2AnOBltCfawmZnmFWyhYpzpXqODIm7mROF72qJo40Ceu3IJa5QPqhObofbVzhDM/Oiw2HjemkGV2smfVd1IjmZlmdFwbY89mlBwWg==
X-YMail-OSG: XKSWw_kVM1l6NlSwZiBf7jsr63N3QnKRFswL.Y5zTD7j8l9kMLmQDWNbhUtn9z2
 YHgSuo8b26Hga0AQ6ShXg4dd2PlRobH4da2EwirWQNI7aqwz4MWNC2DoHcvsWs0TdLI3XLsMzFq7
 zn3SXysCQZWCSzGufIIqle45SSAvwVSlIQyip5oTeXdsLvX8h.4g5ewkPMw9tNniLjZWSZ7W5iZq
 DFWaMY_UNSs8mINL635PjqdyK2BluhpPM.C77rmEq6qBDZULAmRSWan85XjcdXJD97rXYmPfnfQV
 sZlxg9774tUIkA6_zbjwhhmZZdanHud2h2l3OD3GYm26XNKnH8U19qPC4cnMEOKrOdgW.NnK14sN
 dDtfKI5cPDE6nB6heXnX52.maHTP2.gYenw81y6ZYYrbUr6HlZ4q9umZcCMURWspWFlEYahgD8i6
 KgWHiZKtG6bENErYT9UWGKgknKXZTnNcCXSt52lsyo0ouuMgYxbzdfKXoMt1pj0MWpU6bJUrrl0O
 VzEJaC3SMWaBCPy_26wsb5etE6a4C.YXLF.YkT.gzk4WZNa_N9NEhCOKExtvExbM8MZKmQ_nBzBP
 wSmpIFzOtw0p2nWSMtNAqB3UCB4J5_WsZTn8q0vhTjXR5R6hoZa0TdxErTONifZK07neFGSc5INy
 BQNDOwo.C9VLIU21JLVlXVqV29iwiLa2a.FLEsEyoSQMSa5292mblb5EoMUn0X5WcQGJxUwrCc40
 ZOTLTo.BgXcogzYu9exqEUEipXTRVddF8hW6CMmwfxx3qh9tGMeKVkeHDIL1FJytRUbOYaBW7lXp
 oOZnpKH8fo_i5mqyxAP0t3cEu5uqI9T_Jfo84LGhRuWrWoLaToDV1XKgLcvrzEhIXurTEpTJVpE4
 eJ24Hime1RMhVZaEqk6AiSo9WdMOtc_0PZl7v.nAcMkbCZeMaX5F3dP6ZrFHhX5fA.7eFUSct_wy
 4GAFMnXuMkTP8mAEXSrCRDfJHLDWvgpU.W9S5ZnA7EHOoBxuiQws7rIIhI_MxQM1qU5l0mmucQNo
 LMoLlkICX_uVFTR4Rd2wnG3BHJWd875l1JpVD.Hgdu6o0mNu9ccHWJqy8.uByzZ1pjm3T5KqLauA
 ZRBQ7J4WUCbnGpCzjfHV5j4o8xLvaJ4Zc.3V0H1wmVEdjZwqL6J3L78baCocoHafxmpjnE0CHUyc
 vq9izyTdg2nhbnu0NTIzcWZYqhE48OdLWakPXYRWj9UCE7ElDaxKpjOgO5zO8OpdV3NymcwoQZpU
 0DIwmnPgStsTRnkubVjtOnNZXDvOjVUU9NoA2ruQverB5EjF3nzDahnhYUve397OI8.KpC.CKSqU
 ufpoQ8IZA7Z5uozQurTsAETSvrblt9zMnkOfdDeVKeKCpDW5sK41J8WWOshziwrLts5Rh2CR0gbN
 1ks1KQGhBHwkgAPqv8Iuv3TYppEgHbZkWpEx3qllYgs7CJrZceTQ2k2YxxsDbTRICxi1pBLr9ih7
 3bxML2q1rBFF8YSdDwIlKygSY0N8QYchSnfRhgigzc26T6xwTU6_HdLNwY9D.NQxVasmi1MhPoMg
 kkwc.FQhEsZpsOEYUK87c7XDplksFBN00ykOMdXi5jBeM9F0RA4vypVmoBpCXsNH0IaLrdj1fYB9
 GjnEq0MwOLTD0xbbwB8XgqMvSfwse_UtdlXlTTU1wvoFDGjROaPK.ejGq74pciAQiEbWzyEo.zQM
 zBTDRkC0721aY2AckwL11sB7aHWddRedR9hta909N9XP1NSPbcfbPVbAb_wZEajIsFk59y5uFB2k
 prZsaMuBchCFcf0eIJn8290Hb9TrpC3YZdJV9dn_82z0W0BvoilQDI1ZEK74Gq0WyNClwoObngXi
 vG0nIRPlAOD50L2c4jOmwo2TmLc4bHm098vrzgNdImEgKtqZ6WRjhuwu45RT4JL4kVRe_UEGZdgV
 dVj3f2jJs2BP2YNdK2icN6xJZuKNGfPBdCTRK_nrKJq2NndwOrxlbw0BU_3Uk.95X17kGN2Fg52o
 4bV8_Ywg061LSYg1tnPHCrjGObYKUrIWRhwEzTTj3LozdIB4BJwkrDfXuP28o1i3ar_E5L.PujNZ
 pbOOgW8UqnpqTq8d2ZU5KY26GL4TMTBpUoOpl3VTIl37Ggu8_aRie.0KH0dkGpXFFsrNF8BwzHaL
 n4iPC9hTo8JX3ogd6VyS0Zwdhw9hpmdGEoJ_uhh_Yvi9JlSyahHEUNkDp5HsrD7zCua.PjlNegms
 lMiZTft_JlUlQgaqwZJsVEbkJbfo8BirGk0yz24T3YfGzWyUv9GIxBkxHj7m8qjIbOqgJ.BZhJmp
 8Jows3njTwkAvsK2h4VCwsEBRYC2sJQvE1_2CjOWu
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9074e8b0-c823-4a9b-84fb-4898406b77b8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Oct 2026 20:52:02 +0000
Received: by hermes--production-ir2-5dd9bf4598-9c455 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ec6ba47e9d1184103448354478a63db5;
          Wed, 07 Oct 2026 20:41:40 +0000 (UTC)
Message-ID: <562b5fda-e1ec-40f0-834f-2bcebe2894b7@yahoo.com>
Date: Wed, 7 Oct 2026 22:41:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 7/8] net: dsa: realtek: rtl8365mb: add family D SDS13
 PCS support
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

Extend the existing RTL8367S SGMII/HSGMII PCS implementation in this
driver for family D switches, whose CPU SerDes is reached through the
indexed SDS13 window and whose SDS_MISC fields differ from family C.

The register sequence and tuning tables are derived from the GPL-licensed
Realtek RTL8367D port API distributed in the Mercusys MR80X GPL release.
Keep the existing family C path unchanged and select the new behavior from
the driver's chip-family metadata, making the implementation reusable by
other family D boards.

Co-developed-by: Fabiano Tassotti <fabianotassotti@gmail.com>
Signed-off-by: Fabiano Tassotti <fabianotassotti@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 181 ++++++++++++++++++-----
 1 file changed, 145 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index c638c20..aad26ba 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -286,6 +286,7 @@
 #define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	BIT(8)
 #define   RTL8365MB_SDS_INDACS_CMD_RUN_MASK	BIT(7)
 #define   RTL8365MB_SDS_INDACS_CMD_WR_MASK	BIT(6)
+#define   RTL8365MB_SDS_INDACS_CMD_INDEX_MASK	GENMASK(5, 0)
 #define RTL8365MB_SDS_INDACS_ADR_REG		0x6601
 #define RTL8365MB_SDS_INDACS_DATA_REG		0x6602
 
@@ -334,7 +335,22 @@
 #define   RTL8365MB_SDS_OPTION_ARM_KEY		0x0249
 #define RTL8365MB_SDS_OPTION_REG		0x13C1
 
+/* Family D uses the SDS13 indirect window for its MAC6 SerDes. */
+#define RTL8365MB_D_SDS_EXT0_INDEX			13
+#define RTL8365MB_D_FIBER_CFG2_REG			0x13E8
+#define   RTL8365MB_D_FIBER_CFG2_RX_DISABLE_MASK	GENMASK(7, 6)
+#define   RTL8365MB_D_FIBER_CFG2_RX_DISABLE_SDS0	BIT(6)
+#define RTL8365MB_D_SDS_MISC_PA33PC_EN			BIT(11)
+#define RTL8365MB_D_SDS_MISC_PA12PC_EN			BIT(10)
+#define RTL8365MB_D_SDS_MISC_MAC6_SEL_SDS0		BIT(9)
 #define RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK		GENMASK(4, 0)
+#define RTL8365MB_D_SDS_MISC_MODE_SGMII			0x02
+#define RTL8365MB_D_SDS_MISC_MODE_HSGMII		0x12
+#define RTL8365MB_D_SDS_MISC_CFG_MASK			\
+	(RTL8365MB_D_SDS_MISC_PA33PC_EN |		\
+	 RTL8365MB_D_SDS_MISC_PA12PC_EN |		\
+	 RTL8365MB_D_SDS_MISC_MAC6_SEL_SDS0 |		\
+	 RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK)
 /* Shared "disable" encoding for both SDS_MISC's and SDS1_MISC0's
  * 5-bit mode fields.
  */
@@ -709,6 +725,21 @@ static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_hsgmii[] = {
 	{ 0x0424, 0xD810 }, { 0x0001, 0x0F80 }, { 0x002E, 0x83F2 },
 };
 
+/* Family D tuning tables from the Realtek vendor port API. */
+static const struct rtl8365mb_jam_tbl_entry rtl8365mb_d_sds_jam_sgmii[] = {
+	{ 0x0427, 0x4E0C }, { 0x0428, 0xAA00 }, { 0x0425, 0x5189 },
+	{ 0x0424, 0x8414 }, { 0x0423, 0x1020 }, { 0x0410, 0x0002 },
+	{ 0x0484, 0x011B }, { 0x0421, 0x8E13 }, { 0x0422, 0x1140 },
+	{ 0x0004, 0x074F },
+};
+
+static const struct rtl8365mb_jam_tbl_entry rtl8365mb_d_sds_jam_hsgmii[] = {
+	{ 0x0427, 0x4E0C }, { 0x0428, 0xAA00 }, { 0x0425, 0x5189 },
+	{ 0x0424, 0x8414 }, { 0x0423, 0x1020 }, { 0x0410, 0x0002 },
+	{ 0x0504, 0x051B }, { 0x0421, 0x8E13 }, { 0x0422, 0x1140 },
+	{ 0x0004, 0x074F },
+};
+
 enum rtl8365mb_phy_interface_mode {
 	RTL8365MB_PHY_INTERFACE_MODE_INVAL = 0,
 	RTL8365MB_PHY_INTERFACE_MODE_INTERNAL = BIT(0),
@@ -1322,7 +1353,8 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	return 0;
 }
 
-static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
+static int rtl8365mb_sds_write(struct realtek_priv *priv, u8 index,
+			       u16 addr, u16 data)
 {
 	int ret;
 
@@ -1340,10 +1372,13 @@ static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
 	 */
 	return regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
 			    RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
-			    RTL8365MB_SDS_INDACS_CMD_WR_MASK);
+			    RTL8365MB_SDS_INDACS_CMD_WR_MASK |
+			    FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
+				       index));
 }
 
-static int rtl8365mb_sds_read(struct realtek_priv *priv, u16 addr, u16 *data)
+static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
+			      u16 addr, u16 *data)
 {
 	u32 val;
 	int ret;
@@ -1353,7 +1388,9 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u16 addr, u16 *data)
 		return ret;
 
 	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
-			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK);
+			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
+			   FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
+				      index));
 	if (ret)
 		return ret;
 
@@ -1393,6 +1430,14 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
 	int ret;
 	int i;
 
+	/* Family D has a fixed SDS13 programming model and does not use the
+	 * family C option register to select its tuning table.
+	 */
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D) {
+		mb->sds_supported = true;
+		return 0;
+	}
+
 	/* Nothing to probe if no external interface is wired to the SerDes */
 	for (i = 0; i < RTL8365MB_MAX_NUM_EXTINTS; i++) {
 		extint = &mb->chip_info->extints[i];
@@ -1471,28 +1516,47 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				const unsigned long *advertising,
 				bool permit_pause_to_mac)
 {
-	const struct rtl8365mb_jam_tbl_entry *sds_jam;
 	const int id = RTL8365MB_SDS_EXT_INTERFACE_ID;
+	const struct rtl8365mb_jam_tbl_entry *sds_jam;
 	struct rtl8365mb *mb = pcs_to_rtl8365mb(pcs);
-	struct realtek_priv *priv;
+	struct realtek_priv *priv = mb->priv;
 	size_t sds_jam_size;
-	u32 mode;
+	u32 misc_mask;
+	u32 misc_val;
+	u32 sds_mode;
+	u8 sds_index;
+	bool is_d;
 	u16 val;
 	int ret;
 	int i;
 
-	priv = mb->priv;
+	is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
 
+	/* Select the appropriate tuning table and SDS mode */
 	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
-		sds_jam = rtl8365mb_sds_jam_hsgmii;
-		sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_hsgmii);
-		mode = RTL8365MB_EXT_PORT_MODE_HSGMII;
+		if (is_d) {
+			sds_jam = rtl8365mb_d_sds_jam_hsgmii;
+			sds_jam_size = ARRAY_SIZE(rtl8365mb_d_sds_jam_hsgmii);
+			sds_mode = RTL8365MB_D_SDS_MISC_MODE_HSGMII;
+		} else {
+			sds_jam = rtl8365mb_sds_jam_hsgmii;
+			sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_hsgmii);
+			sds_mode = RTL8365MB_EXT_PORT_MODE_HSGMII;
+		}
 	} else {
-		sds_jam = rtl8365mb_sds_jam_sgmii;
-		sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_sgmii);
-		mode = RTL8365MB_EXT_PORT_MODE_SGMII;
+		if (is_d) {
+			sds_jam = rtl8365mb_d_sds_jam_sgmii;
+			sds_jam_size = ARRAY_SIZE(rtl8365mb_d_sds_jam_sgmii);
+			sds_mode = RTL8365MB_D_SDS_MISC_MODE_SGMII;
+		} else {
+			sds_jam = rtl8365mb_sds_jam_sgmii;
+			sds_jam_size = ARRAY_SIZE(rtl8365mb_sds_jam_sgmii);
+			sds_mode = RTL8365MB_EXT_PORT_MODE_SGMII;
+		}
 	}
 
+	sds_index = is_d ? RTL8365MB_D_SDS_EXT0_INDEX : 0;
+
 	/* Hold the embedded DW8051 microcontroller in reset and keep it
 	 * disabled. The vendor driver loads firmware into it to manage the
 	 * SerDes link, but the firmware only duplicates work that phylink
@@ -1521,34 +1585,53 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	/* Tune the SerDes with vendor-prescribed parameters */
 	for (i = 0; i < sds_jam_size; i++) {
-		ret = rtl8365mb_sds_write(priv, sds_jam[i].reg,
-					  sds_jam[i].val);
+		ret = rtl8365mb_sds_write(priv, sds_index,
+					  sds_jam[i].reg, sds_jam[i].val);
+		if (ret)
+			return ret;
+	}
+
+	/* Family-specific post-tuning configuration */
+	if (is_d) {
+		ret = regmap_update_bits(priv->map, RTL8365MB_D_FIBER_CFG2_REG,
+					 RTL8365MB_D_FIBER_CFG2_RX_DISABLE_MASK,
+					 RTL8365MB_D_FIBER_CFG2_RX_DISABLE_SDS0);
 		if (ret)
 			return ret;
+
+		misc_mask = RTL8365MB_D_SDS_MISC_CFG_MASK;
+		misc_val  = RTL8365MB_D_SDS_MISC_PA33PC_EN |
+			    RTL8365MB_D_SDS_MISC_PA12PC_EN |
+			    RTL8365MB_D_SDS_MISC_MAC6_SEL_SDS0 | sds_mode;
+	} else {
+		/* Mux the SerDes to MAC8 in the requested mode */
+		misc_mask = RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
+			    RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK;
+		misc_val  = (sds_mode == RTL8365MB_EXT_PORT_MODE_SGMII) ?
+			    RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK :
+			    RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK;
 	}
 
-	/* Mux the SerDes to MAC8 in the requested mode */
 	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
-				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
-					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
-				 mode == RTL8365MB_EXT_PORT_MODE_SGMII ?
-					 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK :
-					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK);
+				 misc_mask, misc_val);
 	if (ret)
 		return ret;
 
-	val = mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
-	ret = regmap_update_bits(priv->map,
-				 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
-				 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
-				 val);
-	if (ret)
-		return ret;
+	if (!is_d) {
+		val = sds_mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
+		ret = regmap_update_bits(priv->map,
+					 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
+					 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
+					 val);
+		if (ret)
+			return ret;
+	}
 
 	/* Take the SerDes out of reset. The vendor driver does this only
 	 * after the SerDes mux and the interface mode are configured.
 	 */
-	ret = rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_RESET,
+	ret = rtl8365mb_sds_write(priv, sds_index,
+				  RTL8365MB_SDS_REG_RESET,
 				  RTL8365MB_SDS_RESET_DEASSERT);
 	if (ret)
 		return ret;
@@ -1558,12 +1641,14 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	 * This flushes the FIFOs and ensures a clean state for the link,
 	 * preventing silent drops and CRC errors.
 	 */
-	ret = rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_BMCR,
+	ret = rtl8365mb_sds_write(priv, sds_index,
+				  RTL8365MB_SDS_REG_BMCR,
 				  RTL8365MB_SDS_BMCR_DPRST_PHASE1);
 	if (ret)
 		return ret;
 
-	ret = rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_BMCR,
+	ret = rtl8365mb_sds_write(priv, sds_index,
+				  RTL8365MB_SDS_REG_BMCR,
 				  RTL8365MB_SDS_BMCR_DPRST_PHASE2);
 	if (ret)
 		return ret;
@@ -1571,14 +1656,16 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	/* Keep SGMII in-band autonegotiation disabled: the link parameters are
 	 * forced from rtl8365mb_pcs_link_up() instead.
 	 */
-	ret = rtl8365mb_sds_read(priv, RTL8365MB_SDS_REG_NWAY, &val);
+	ret = rtl8365mb_sds_read(priv, sds_index,
+				 RTL8365MB_SDS_REG_NWAY, &val);
 	if (ret)
 		return ret;
 
 	val &= ~RTL8365MB_SDS_NWAY_EN_MASK;
 	val |= RTL8365MB_SDS_NWAY_RESTART_MASK;
 
-	return rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_NWAY, val);
+	return rtl8365mb_sds_write(priv, sds_index,
+				   RTL8365MB_SDS_REG_NWAY, val);
 }
 
 static bool rtl8365mb_interface_is_serdes(phy_interface_t interface)
@@ -1603,10 +1690,14 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
 {
 	struct rtl8365mb *mb = pcs_to_rtl8365mb(pcs);
 	struct realtek_priv *priv = mb->priv;
+	u8 sds_index = 0;
 	u16 status;
+	bool is_d;
 	u32 val;
 	int ret;
 
+	is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
+
 	/* In-band autonegotiation is not implemented, so the link parameters are
 	 * forced from rtl8365mb_pcs_link_up(). The real link state must still be
 	 * read from the SerDes itself: the embedded DW8051 microcontroller that
@@ -1614,7 +1705,11 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
 	 * rtl8365mb_pcs_config()), so the link status register can be read
 	 * directly through the SDS_INDACS window without racing the auto-poll.
 	 */
-	ret = rtl8365mb_sds_read(priv, RTL8365MB_SDS_REG_LINK_STATUS, &status);
+	if (is_d)
+		sds_index = RTL8365MB_D_SDS_EXT0_INDEX;
+
+	ret = rtl8365mb_sds_read(priv, sds_index,
+				 RTL8365MB_SDS_REG_LINK_STATUS, &status);
 	if (ret) {
 		state->link = false;
 		return;
@@ -1625,6 +1720,13 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
 	if (!state->link)
 		return;
 
+	if (is_d) {
+		state->duplex = DUPLEX_FULL;
+		state->speed = state->interface == PHY_INTERFACE_MODE_2500BASEX ?
+				SPEED_2500 : SPEED_1000;
+		return;
+	}
+
 	/* The speed and duplex are forced; read them back from the values
 	 * programmed into the SerDes MISC register.
 	 */
@@ -1666,6 +1768,12 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
 	u32 r_speed;
 	int ret;
 
+	/* Family D forces the external MAC ability from mac_link_up(); its
+	 * SDS_MISC fields do not share the family C link-force layout.
+	 */
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		return;
+
 	/* The speed field has no value for 2.5 Gbps: the rate is determined by
 	 * the HSGMII SerDes configuration, and the vendor driver programs the
 	 * 1 Gbps value here.
@@ -1991,7 +2099,8 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 		 * rtl8365mb_pcs_link_up() because pcs_link_up() carries no
 		 * pause information.
 		 */
-		if (rtl8365mb_interface_is_serdes(interface)) {
+		if (rtl8365mb_interface_is_serdes(interface) &&
+		    rtl8365mb_get_family(priv) != RTL8365MB_FAMILY_D) {
 			u32 val = 0;
 
 			if (tx_pause)
-- 
2.53.0

