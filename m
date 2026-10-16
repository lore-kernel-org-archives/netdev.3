Received: from sonic303-22.consmr.mail.ne1.yahoo.com (sonic303-22.consmr.mail.ne1.yahoo.com [66.163.188.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988D1A680C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112873; cv=none; b=PrDs6IfDQKahAWZ7XtCKN+Q3l6fnmRnQi3jezMRfKsh/sG523/EKhlXPXL7HLLgd2EOM5nrDYwhHPO/ZwfzpjHwBJuD49QFaEE9U1gBUypxBSdM4cnZzgQRKzUpiz7Zn7QPvrPMAitmxxsUE69+k+k/C16EfvENw6++Ppv5vl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112873; c=relaxed/simple;
	bh=fEdo/xSemLqgaomiN1rVJKO8L1R045LmHqNF67X6dFw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CMnFJcnGh7eggC+M1kdHLZ0PVDSlsLTU89FkWMCEN3odHTR2OLWS0JT6SnvOEGJXjowGM8mKLDBJQ3bC8S6iA/i980buMgMLqJVMvyw89swhA9y4vuBN1c4mrMuu2QqHejePUIR/0zRXonxnxnkQ0ZNW7o5gLpjYvqLRER1l5Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=a3o/gIQm; arc=none smtp.client-ip=66.163.188.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a3o/gIQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112865; bh=b89XBrxVqut3O17eBX4iNDxLpjsUuaLV55EuLb52NAc=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=a3o/gIQmql8COH+acQu4NhoXSLEL4TI7Dd8Y4FHcc9Pm7I866QaMvuxGhz6R/Kkfl84tE0d/RLtSoq5MA4jYkKbn4usBnKW6Mf64LpldKsui/t/5UN94I1s+a+MlAHOCPBcS1p6hGbwoA4gLekbufxgd8E+GC6Mv2o+Xe2xitkOazOBfwdnzmnGYiyAoOyPZ1/C14ERQEShyKlGMY67YcPW2jmu6arHFhqy6iaDZETq9VHz0TBONwH0PJxak/14xk44vBmhqDWx5Qtbc+6ZmF8kIwi91/V03Voe5FJoNiZyE0kp+8UMQ7TZLFGKuyEbetX3l2GvVL1LFDHqjwS+Sng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112865; bh=CqY+eywg+2JfedODMv+XZ2o/M1siGSTJXwvJnZ7gL+y=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=HcgvOjDJMcW80IUQBiHKN/GO6rBch2t5WykuUDt8lFpCunUrdscb7gMNehzdedKTBo+Fd8DJQb0+cOzglVVIoDot+OqYNqzZUGhgsJFre+szqZsWrx82fFIk68qf4d4qWGNmKkgvQdbUvE82zp3BVQmQQuiRuhz19ZD/EQIzMfb8SWPBLzIVI9da0L3+cBWiPl87A3OflbWYxrxNgYl8pcKodwW+FwyhVTemIDDvSINNiSxEAbXYcSRzgiFTEhzr1tEPC69dT9n0p0ge2VseEzRSgpDkalX3Ue/zFlkpMkT32Rvj4fGtZMdst+ffqWj156l6tDvRnVbTUSvRPROyHQ==
X-YMail-OSG: HMOrDrIVM1mfzpg6SAkhmZEq5JA2HsO1v4NIQyPXtDwlkJ7AOR5VriiuwWrlh7q
 rt7Kk0hkaYjdFZDs0LC7Roe0BPyA.XlX8aiU2nrD720LkPgwk1q3gG4FgXmy7AcPS5gFF5.Do3B6
 0YPCtX894E3f7zqs._nOwQdGXvoMScwfuPHJLMF_lXLSTBCMzlrf1KLpFXAyzrPRVW6RPldCSEzQ
 u7P7iQ.evZ7e4_aOb4UT8D8rfphp3b4VUEIj.47WI19OSL1oGKVnCBUD1MQJU964rVe8..lyd0hr
 xpK_PHf7aUlU3SqwQw_hVdDlOCQ9zJOqn8eNa5byv9LcFSQJDLXFKGJuIISxDfojcXhEAs7bpP.Z
 nxjiTJGxndaiyNP4R0aQ7z9qK7k2GNanPjT.1ZOKGaExkaDoqWdayWZHRneo.boKyMhBU1fpexnE
 mwvErZyB.oRf1NSI8uqNVXlvw7ByI4sluKnwatl2VfkvmQGPS93YBrOlmStV4hApUQbTQ7oAPy9d
 km2VUlHfUUZqyPXtklScU4cphE_OXVjmi4M.iLMK5xF6L0BPIax67veOx62OYQIi1kcmIWZoT3Qm
 z.cawYns4MGOrhsmmUiDOGnepU6s8R4RKZEthaqAjWYcJ3Xn9stfGwEYmXft72NSYzpr_GNMDIHz
 phVBJ.YKGCirObJ9fPKSx6a0OLTUj6xx2iXPEIfhOEnRLOZK64vBF7ZP78lIQdJY59W5AWFE7UMl
 iCg1CCJEhBT7m9R5SoqLAYZBZoMFij53ss4cgZa9xhK7YqREI.ido4v5T7tkPq24BxwewIg0aYPY
 TXEMqbybhgkeQ6w060HLuCAVpy_UHEKBeQECx_wqhxmtSaoJ3ZSH6HpFNm.1tG31.B.5sbOpovzE
 M3x2GdvfSTAK.b1dBCK3G1.KS6e9zoO7dULJmAgNyR_5U31aCW2dfU6du4cysnOaOke1XhcWV.ju
 aTmExKuAAh4W7bKQnBBSJbwe6.ObskDiOiNWANPXIdFyPbFGKaFvjEDGoTb2gNfZXPLpEPVbygCJ
 ABo6MHRxQKf2RhVUg6iBVau_mQxDYUzqrH3GboqVInT39SV8Oz_AhgKzzIO8eSSbmerL5l6TnU.v
 5InjerbVK2CMwpOQe9dF1xuKfLMnd3V43FjdSN9lCnyUpwCcW3xgO3Wc0_nxn6_ibknfBl3PcUyh
 L3tuwbI2EYiUnJEfAcYYzP0wPvlB6sbi222Y8EmCcGyQkvToW6Kvlu4vZkEcZsAm5kTjUn0Rnz_n
 TgL1TDta1Q2XSFlvTzBpRj2BEicIfXgCdNMM.Mk5omLul0jLARDaKUCyaqg40SDR0BKI7FW2F9CO
 .3AghiV7c2YJ3Q71vlePp3n6MDUOBfKXiBCht61EzggMSOwwNBmO6glff8ovvbCESRrXag0JZ_at
 .w_MQiWkcV.4nSibwfexjj4Ads2jbO0ZoARJHOYC9B4Uk98k8a32nxxQmO7hFX2QwV8sVFn02n5q
 ZA20ycvUgt8v5HJZRXekQyvL5BRKbWjzxijvpBlyjKvuWtq.X.fvetQ6xxHevnaC1vDORYapOlJ5
 XLB6N_xNHh5q.xv50cZ9Ri.qBdbR0MNaJyUizZ2Se7BjdJKN2TB8RTGgPZtSL1gBQcxgnr0pPkdT
 5lw08hepnrljOflqSv62xRREslLUkYaY1LX6wyPxJyu97jigrKwHCio8ZnZjvlgEa9tkfhxHYrcp
 uwYK2QtnmNDd6lSu2qGLnXUEUHAFBY5BHyvsrkwVgR7_15YVvMplKyKv3WqXL2JbKkNnanw5tRtJ
 b48tMuQKQIXUeNnO3aDWGzd6hv57PGv_gBYxixAh1DrY6.nXWQxymjU3i6Qh4XQGjTgRRPguiFEl
 jaU4O.jPtW90S3JLSpZP2LxNJEuyDOkqb1X8Alg_T8xDa08pom2mtgK7.H4fuhHJACgpjj9Q4dSG
 AqxHky5K.kfr3_myFUdPbfcd1c9pRVrWdnGWFBRjnYQl3oXsYBIcW1XxGOsxi6kZ9jLMfnOc1WcI
 EuQ.llo9ZB45SQFcw_YmRdXBvDob97tHTvIgqkxQdDy3seymlHlA5QOdwZwMBAqubsgvmEO.k5x4
 n8VMXiBwWCnrSc_KTSM8yiD_XZ415Twqsf75LLYN.1LP0YUA8vKTcD1u45HQL09B2rPwaHQTw6ml
 mz42smuv17exn3hrgUU8po05PlOrJsOotNYGC2HDiDUG7Vx0ZJj6cdCkth0ZNexpdpiTgX9vPQEY
 MngMaaLABpwPAXfuXidFi7pJqLjd4Cr5U_hXE7iXGl37THkHJcD9JSDDfdpXtja2GDKy1xRU6oyI
 ZLPOiUj7QamHWB04i_PL.edcTvsHzngRkEIr_
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 6ccfe8b9-f0d6-4b3a-bbd5-6c07204fe953
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2026 01:07:45 +0000
Received: by hermes--production-ir2-5dd9bf4598-9c455 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID be5a98f1f65cb3fc72022a06c43a6744;
          Fri, 16 Oct 2026 01:07:40 +0000 (UTC)
Message-ID: <32ba8939-213e-404a-a247-1f24603ca6c4@yahoo.com>
Date: Fri, 16 Oct 2026 03:07:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v6 7/9] net: dsa: realtek: rtl8365mb: add family D
 SDS13 PCS support
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
Content-Language: pl
In-Reply-To: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26740 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Extend the existing RTL8367S SGMII/HSGMII PCS implementation in this
driver for family D switches, whose CPU SerDes is reached through the
indexed SDS13 window and whose SDS_MISC fields differ from family C.

The register sequence and tuning tables are derived from the GPL-licensed
Realtek RTL8367D port API distributed in the Mercusys MR80X GPL release.
Keep the existing family C path unchanged and select the new behavior from
the driver's chip-family metadata, making the implementation reusable by
other family D boards.

This patch only prepares the family D paths; they become reachable
when the RTL8367S-VB chip entry is added in the last patch.

Co-developed-by: Fabiano Tassotti <fabianotassotti@gmail.com>
Signed-off-by: Fabiano Tassotti <fabianotassotti@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 242 +++++++++++++++++------
 1 file changed, 187 insertions(+), 55 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index f8063d2..a8e9220 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -262,7 +262,8 @@
  * interface, indexed by the external port number with port 5 (the first
  * external port) as the base. Other RTL8367 families index this register
  * differently (e.g. the RTL8367R uses (id + 1) % 2), so this mapping only
- * holds for the RTL8367C-style parts this driver supports.
+ * holds for the RTL8367C-style parts and for family D, where it is the same
+ * (one bit per external port, base port 5), as in the vendor RTL8367D API.
  */
 #define RTL8365MB_BYPASS_LINE_RATE_REG		0x03F7
 #define RTL8365MB_BYPASS_LINE_RATE_MASK(_port)	BIT((_port) - 5)
@@ -284,6 +285,7 @@
 #define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	BIT(8)
 #define   RTL8365MB_SDS_INDACS_CMD_RUN_MASK	BIT(7)
 #define   RTL8365MB_SDS_INDACS_CMD_WR_MASK	BIT(6)
+#define   RTL8365MB_SDS_INDACS_CMD_INDEX_MASK	GENMASK(5, 0)
 #define RTL8365MB_SDS_INDACS_ADR_REG		0x6601
 #define RTL8365MB_SDS_INDACS_DATA_REG		0x6602
 
@@ -313,8 +315,10 @@
 #define RTL8365MB_SDS_REG_LINK_STATUS		0x003d
 #define   RTL8365MB_SDS_LINK_STATUS_LINK_MASK	BIT(4)
 
-/* The embedded SerDes can only be muxed to external interface 1 (MAC8),
- * which is port 6.
+/* On family C the embedded SerDes can only be muxed to external interface
+ * 1 (MAC8), which is port 6. Family D has it on external interface 0
+ * (MAC6), see RTL8365MB_D_SDS_EXT0_INDEX. RTL8365MB_SDS_EXT_INTERFACE_ID
+ * below is the family C id; the SerDes port is 6 on both families.
  */
 #define RTL8365MB_SDS_EXT_INTERFACE_ID		1
 #define RTL8365MB_SDS_EXT_INTERFACE_PORT	6
@@ -332,7 +336,22 @@
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
@@ -720,6 +739,21 @@ static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_hsgmii[] = {
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
@@ -1320,7 +1354,8 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	return 0;
 }
 
-static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
+static int rtl8365mb_sds_write(struct realtek_priv *priv, u8 index,
+			       u16 addr, u16 data)
 {
 	int ret;
 
@@ -1338,10 +1373,13 @@ static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
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
@@ -1351,7 +1389,9 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u16 addr, u16 *data)
 		return ret;
 
 	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
-			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK);
+			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
+			   FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
+				      index));
 	if (ret)
 		return ret;
 
@@ -1391,6 +1431,14 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
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
@@ -1472,25 +1520,44 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	const struct rtl8365mb_jam_tbl_entry *sds_jam;
 	const int id = RTL8365MB_SDS_EXT_INTERFACE_ID;
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
@@ -1519,34 +1586,57 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	/* Tune the SerDes with vendor-prescribed parameters */
 	for (i = 0; i < sds_jam_size; i++) {
-		ret = rtl8365mb_sds_write(priv, sds_jam[i].reg,
-					  sds_jam[i].val);
+		ret = rtl8365mb_sds_write(priv, sds_index,
+					  sds_jam[i].reg, sds_jam[i].val);
 		if (ret)
 			return ret;
 	}
 
-	/* Mux the SerDes to MAC8 in the requested mode */
+	/* Family-specific post-tuning configuration */
+	if (is_d) {
+		/* Bit 6 disables the RX of SDS0. As in the vendor RTL8367D
+		 * sequence the whole 2-bit field (bits 7:6) is written, so
+		 * bit 7 is cleared as well.
+		 */
+		ret = regmap_update_bits(priv->map, RTL8365MB_D_FIBER_CFG2_REG,
+					 RTL8365MB_D_FIBER_CFG2_RX_DISABLE_MASK,
+					 RTL8365MB_D_FIBER_CFG2_RX_DISABLE_SDS0);
+		if (ret)
+			return ret;
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
+	}
+
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
@@ -1556,27 +1646,32 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
 
 	/* Keep SGMII in-band autonegotiation disabled: the link parameters are
-	 * forced from rtl8365mb_pcs_link_up() instead.
+	 * forced from rtl8365mb_pcs_link_up() instead (family C), or from
+	 * mac_link_up() (family D).
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
@@ -1601,18 +1696,27 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
 {
 	struct rtl8365mb *mb = pcs_to_rtl8365mb(pcs);
 	struct realtek_priv *priv = mb->priv;
+	u8 sds_index = 0;
 	u16 status;
+	bool is_d;
 	u32 val;
 	int ret;
 
-	/* In-band autonegotiation is not implemented, so the link parameters are
-	 * forced from rtl8365mb_pcs_link_up(). The real link state must still be
-	 * read from the SerDes itself: the embedded DW8051 microcontroller that
+	is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
+
+	/* In-band autonegotiation is not implemented, so the link parameters
+	 * are forced from rtl8365mb_pcs_link_up() on family C, and from
+	 * mac_link_up() on family D. The real link state must still be read
+	 * from the SerDes itself: the embedded DW8051 microcontroller that
 	 * the vendor firmware uses to poll the SerDes is kept disabled (see
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
@@ -1623,6 +1727,23 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
 	if (!state->link)
 		return;
 
+	if (is_d) {
+		if (state->interface == PHY_INTERFACE_MODE_2500BASEX) {
+			state->duplex = DUPLEX_FULL;
+			state->speed = SPEED_2500;
+		} else {
+			/* Keep what phylink passed in, but never report the
+			 * link up with an unknown speed: mac_link_up() cannot
+			 * force the port with it.
+			 */
+			if (state->speed == SPEED_UNKNOWN)
+				state->speed = SPEED_1000;
+			if (state->duplex == DUPLEX_UNKNOWN)
+				state->duplex = DUPLEX_FULL;
+		}
+		return;
+	}
+
 	/* The speed and duplex are forced; read them back from the values
 	 * programmed into the SerDes MISC register.
 	 */
@@ -1664,6 +1785,12 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
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
@@ -1950,7 +2077,7 @@ static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 	/* phylink has no pcs_link_down callback, so on the SerDes path only the
 	 * MAC external interface force is reset here. Clearing the MAC force is
 	 * enough to bring the link down; the SerDes keeps presenting its last
-	 * forced state until the next pcs_link_up() reprograms it.
+	 * forced state (family C) until the next pcs_link_up() reprograms it.
 	 */
 	if (phy_interface_mode_is_rgmii(interface) ||
 	    rtl8365mb_interface_is_serdes(interface)) {
@@ -1983,9 +2110,11 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 	p = &mb->ports[port];
 	schedule_delayed_work(&p->mib_work, 0);
 
-	/* The SerDes forced link state is programmed by the PCS in
+	/* On family C the SerDes forced link state is programmed by the PCS in
 	 * rtl8365mb_pcs_link_up(); here only the MAC external interface force
-	 * is configured, for both RGMII and SerDes.
+	 * is configured. On family D pcs_link_up() does nothing, and the MAC
+	 * external interface force is the only forced link state, for both
+	 * RGMII and SerDes.
 	 */
 	if (phy_interface_mode_is_rgmii(interface) ||
 	    rtl8365mb_interface_is_serdes(interface)) {
@@ -1999,18 +2128,21 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 			return;
 		}
 
-		/* The SerDes has its own pause enables; program them from
-		 * the resolved pause modes, as the vendor driver does when
-		 * forcing the link on a SerDes external interface. These
-		 * bits, not the MAC force pause bits, gate pause on the
-		 * SerDes external interface: flow control testing shows
-		 * that pause frames are only emitted with the SerDes TXFC
-		 * bit set, while the MAC force pause bits alone have no
-		 * effect on this port. This is done here rather than in
-		 * rtl8365mb_pcs_link_up() because pcs_link_up() carries no
-		 * pause information.
+		/* Family C: the SerDes has its own pause enables; program
+		 * them from the resolved pause modes, as the vendor driver
+		 * does when forcing the link on a SerDes external
+		 * interface. These bits, not the MAC force pause bits, gate
+		 * pause on the SerDes external interface: flow control
+		 * testing shows that pause frames are only emitted with the
+		 * SerDes TXFC bit set, while the MAC force pause bits alone
+		 * have no effect on this port. This is done here rather
+		 * than in rtl8365mb_pcs_link_up() because pcs_link_up()
+		 * carries no pause information. Family D does not use this
+		 * path: its pause bits are set in the forced-mode register
+		 * by rtl8365mb_ext_config_forcemode().
 		 */
-		if (rtl8365mb_interface_is_serdes(interface)) {
+		if (rtl8365mb_interface_is_serdes(interface) &&
+		    rtl8365mb_get_family(priv) != RTL8365MB_FAMILY_D) {
 			u32 val = 0;
 
 			if (tx_pause)
-- 
2.53.0

