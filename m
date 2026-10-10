Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54C36B929
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661401; cv=none; b=Z7fRGskUwCDVYVCPtYd3w4UE72cGDuAZ9eEO0wNyJRPMsQVLzyaWcyyPTU1PHix7aLnMizRmOJnvemrd28wcjlx6gidqpBA8Npt7lFfCNYBQNe1Kb0qG6/SWVTZGsMdgjA9ZDetDhDjWZNqWhV6OQLP/c12nPyabH4IdK0rPeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661401; c=relaxed/simple;
	bh=Ja26oaFUJUW7FK4i9oXHBsKHERz3O2JcEeNr4k0JXqQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=uAzdOa+I3+GKHJjIXeA3+RgB8kSfxrS70iYVr6D0bcrAhVV2tJ3Zi1n0LvQ/E+H6ReN5Odd7GLAMwgBAHIqV505FmOxq0bbjx2/kkVh7g2pFi8nM8rijdgowMl6nkdWZH70EIlTaxZKXn5ckXtjI2KzPZ7OaAU8NiIRr3P7EyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VRG+LZMC; arc=none smtp.client-ip=66.163.184.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VRG+LZMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661392; bh=mAc1d1g0Ab/QHEt22djO2Y2gDlDBDlno2aGaSHlDV30=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=VRG+LZMCyR8YUpee/+qxLhCBMgvUpvV9S1lU18TheiOpuchZ2HOK3XM2dQ2mX3lwg+Rjq768Np+FIygBXbmlNV+a7TMxunK3gfo/vwfjq1a9+l8IXS5GBK6mgwquYYSRPmz+LBmeZYhPT6qdek+Jz3v1qVEfBYuiPXyu2No5VfI+bsIYt7I9mMn0mj23Po8pyivC+tOtvPBzXQVYSM2WpP5QsQhT1FqIaxIwQzKxNHEVvt+GweBn7VO4bMN6+o1rhURHSPLN1KRO4dz1ZnuGn8L3Lm28TXFELjENdiJEL46fuhmTljHfNnCmSc8gpksLpHz0TWStXKRURLVEevXMkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661392; bh=GfRzuPxuPZtev0p4peF+ShRwhG0y4lRJ9jzqkvvCORh=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Bc0PX42gdml78G4KIHPjv6vF2sYEv1JircIO4lKR9bdF4MMBUrYiS+uA4eiM/XpcyQgoo1P2N/QR92eIxvLL0iAbsVtuMqzjRWgSpLOlSsnV5veETkD1LiLFcaDkW1SNhWw3xmA34M9Vi/7UPdJtQN122IGDn6B7m6Vkt2byzovb+994MB6LTuJayVHXZvIvTmYKZNL31jjX+dLAIxpv1u3Hj8+QefQVjiVOFz8SIZbe+UKoxhcMMWPpt/4qXXBkS+guKuMF4y/X+2sNPNvpQ0nATjbapnCiwZGqRFvS4R8CDiBGfMpGWTEpAkTFhdwS/gbwfJ9ArmH5ii9QklhYgA==
X-YMail-OSG: bAb5g3QVM1numgLiFghw8s8AA2oalhTz6I9QgXcHRt9PgbuYAU9Bx5.f5Vpyqx6
 8.sSOdl_iUdRv0HnVucvg2oiE.mW4eHBGUHyqUJt8w6p8dzWiJeQD.s00MuaVnGIYUGwcSk_nWP5
 o5o_pusi.9nWJUReMtrWp761MHmggoL6EEf7gvKAAdZ9cwFl821ptiy9z4BSb8bTSRAXJq_GY188
 z_gcrX18o7o_PLVJPFKa0hAOB0J0iPn2CsUzm9FS_gni6h6OqCFnnrpl.E0zQroqvJL2UlomB0t3
 Vq3nBwxwG8XuKIjGEaK8jRF0mre0m_LspG4mjJ523F2mpGk17rHvyVhLyUeQHRPAxpzmek5SGYLv
 ICf0UyZ3QTnWMoR.vYzNIuwxfhAZhJHu3DJ06aWRTjmzVPU8Awav2LLiVQwIC5ZnSpJI.ieLHEnh
 hHklvO6hoH_xCsPCB.T0fdnDxLvj0UI3K3C4K2VOuy6FfwWNdtT46EhelhvOhZhA.Xz6WHBwkvqK
 TWr_2wH6fvcTQRHXzRpjUtvLm57zbm5.nTcJKJrpPpScTKUJgmKnBFhye5JGGRO7Or1aSdS79IWm
 ktc7Dd6cLDky8xVauooQPz7rKD_j4ZQQvLuxALBiNEZBJhoSsemcxveh.4qWv_5j9cEEeIcVGt3J
 kEWWO7D7qQov.IT2MKXg39HW2stnOzQN86bHinLaM3RuqC4EEmEPeF1pQVRgjLYU4S_wwjXyAwwc
 rYsCL0siZsNsxnQo4rrP3lDI7Cy7STwUm11hj4.BVQWKXtVAc31nQSkwJ4GJWHcW_e1JR0i._.SN
 8zcnqDvS55Qr7TsspGBiUOdAzDNcAYTAWLen4pIV49SdRYTD8tqNNSzcbemwsTLEtYPTvCJiFcnM
 fv2_WbhNQ.ZhvjOiUD8Rn5fCVusZMiSjp11G8RfYiy6AyGhwnqh5AaRzn0nBq4.RjK2rroppulWh
 6XNteb1FFvoPbmKpbZP3Ht9.Nx89xQVGdwhq_JDV7hkxWSyvVZQR0g.E6uwHwGrN9a6xm3nL92n3
 amWsMcrL3Ayd8TkjbL07W.1o76H667vqD1ZF9k_qy7PE9U_PTHot9mZC9HZYEBS.m5qpeyVNbNW5
 wWJy2LMmOZXWC0cz7sB1fviT6_OaDRte9HY8LQg0_mLQ3rPGK7WWPTWUD4yErwlVmpmfzAl2F.PP
 vUYXbes2sUZhPdwWmRVctT3bnnu4WmDR2Jjw.955mmwTm5hgaiDFWDcJFQffWGxPxZgwSjamZfit
 DpMioSQv_PtS1jBDlbDuFaMawrbXVRsBVwhlo5B82pJpdK9rLB86yYXyzRj500Nd4vlavNIsSTL.
 i0ITw266kaI6ITT2oDeYZOru627mehkNWBoH.jYSYkHZrjsiKDDlz9SgLhWogSBRwHGp7ou02EJz
 pZUHxxDiiuE7tEAdSZefWucabQK2f0LJIn2fuxePsgoCRnHmuVY5_FrMiIawa8lze8JsWlM2xAVl
 k8v3N4c0BIo6RAfzF0FScC9ipqELlONXxA3m8vnJNxc1ZnIR_bVZmh_8vh0Is5UeVudRA7IEUGdf
 NBLmu8AxzJ_2fP3gY92j9nSbV7_6H8AVJeHubqdlOXu7k9BoaZuIteS9cbTpQt13IYYDcsmmHsc.
 UWoDw_iLXWn3ct9.fUhCVbC2drtMhPVuXWgMsKjZIZ.e6jQHtrS0Z6X7NkHGgSjaaJReQ0zl7a5u
 En3d6JTKbJVo17Uc9Ir3q.j6l75PAqIMsJ_tKSyRxgX8_7mEL6Lry5goOJifqv2Qn0ZeTsj8a1Ey
 6X8ixp5FgLlfifAnqX1piegxXR2Rt7RTIm5iHBSUYyeRBYM5cgr56bHQrc48Yo7V0fcxyNoKZ4tR
 8wGnjG8dzuLW.of1RJZRlvf0KVbOs8GNe2_8CwNa1WhZiTsM5pi9HK_LB_sroWfuewcTpBZxN4Fx
 pLZazGN7m60I14oxfkaj3mSwK3.BsROH.Co.bftg_71ATTQlPm9TmVlBM9nzOiYiKuLTWFrrQC7A
 6GxTiXXQwFIvFGxvBmyDptuipoSeWweNntJORSRkzyajOLDSXnzQEyoutoixq2hwSFtF7r1Nugs5
 EQskiQ8XCzbCkC_khEBlA3iOvwfrvcgPLSccLW3hGXSu25_i8q4lQElQPC1Fj7ChFSHJnuFK9V6W
 8OevvDuXJTcYvrjuc6MEi4fzlshWuERAaP30kPv8aNY7fdPxcE7qYBCOzzJva0tf._OYrRSa7ZCc
 E3zpviv2llFm7Ivafihg7OMs81YLM4mP9x5BivKbrGs8z9wk4ljnofDcqGnipFsTR4hiFdDVN8_q
 coaSH9sumRibmZdaN6JFWfKzZQDDqlxjYrg2pSvkumneWV84-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 689d0570-3ae0-4eb6-a549-c2de9d869194
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:43:12 +0000
Received: by hermes--production-ir2-5dd9bf4598-jgkl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ff505be9b6cb0e0906307ebcff7f5c62;
          Sat, 10 Oct 2026 19:43:10 +0000 (UTC)
Message-ID: <a982eb30-e977-4b8c-8526-16027c02a6c2@yahoo.com>
Date: Sat, 10 Oct 2026 21:43:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 7/9] net: dsa: realtek: rtl8365mb: add family D
 SDS13 PCS support
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
Content-Language: pl
In-Reply-To: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
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
index c15b88b..0d3a2a3 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -284,6 +284,7 @@
 #define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	BIT(8)
 #define   RTL8365MB_SDS_INDACS_CMD_RUN_MASK	BIT(7)
 #define   RTL8365MB_SDS_INDACS_CMD_WR_MASK	BIT(6)
+#define   RTL8365MB_SDS_INDACS_CMD_INDEX_MASK	GENMASK(5, 0)
 #define RTL8365MB_SDS_INDACS_ADR_REG		0x6601
 #define RTL8365MB_SDS_INDACS_DATA_REG		0x6602
 
@@ -332,7 +333,22 @@
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
@@ -713,6 +729,21 @@ static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_hsgmii[] = {
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
@@ -1316,7 +1347,8 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	return 0;
 }
 
-static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
+static int rtl8365mb_sds_write(struct realtek_priv *priv, u8 index,
+			       u16 addr, u16 data)
 {
 	int ret;
 
@@ -1334,10 +1366,13 @@ static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
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
@@ -1347,7 +1382,9 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u16 addr, u16 *data)
 		return ret;
 
 	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
-			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK);
+			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
+			   FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
+				      index));
 	if (ret)
 		return ret;
 
@@ -1387,6 +1424,14 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
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
@@ -1465,28 +1510,47 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1515,34 +1579,53 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
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
@@ -1552,12 +1635,14 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1565,14 +1650,16 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1597,10 +1684,14 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
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
@@ -1608,7 +1699,11 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
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
@@ -1619,6 +1714,13 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
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
@@ -1660,6 +1762,12 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
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
@@ -1989,7 +2097,8 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
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

