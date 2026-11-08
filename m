Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125477;
	b=2ysyIKiz17pxZbdtvAZAEolWWiAhCoWnAIUgnHDCkyYprTVpVrOZN68V7gv0yCgVBhZI
	 YJXLYoyCIPdehu/VKPhywWHURq23HOYDGCg0gMCHmlr/EwPGK5epZJWZzjZdNylnboejJ
	 CL04vm1zwyPquew0VLaoqLD+vGqOGx2jIZESq8GaH5ikUomfupZv17B7IBKraOoO8aFms
	 oyhZc73yeGop8KZds4pZ33iSHvxtp4PHftCrT+cgoUdLeX5lugHhuwP1HWHWzCfGOGOxo
	 H7z/eXYT+HPzuC/ippQue0NdNbywWe6exjkU8OgolUXxTwDYhjmTGcQF6qeJu8Ne6PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125477;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=2SBbI7N0m1mEAVMCOcgw9cmNtdJLgRpd28VwmHlwmII=;
	b=fTkptqUbhkbPStGz2C9Op/UmCkhr5eROGeO6Ixsze8VEFwr/bSB6J63792At/1OK9vxn
	 p2mJv1M1X07QHrwgiojwB1bV1l+kem4PmTGts/6aMsbczFp4R9W1VKEGNiQWv0ZBVqcwe
	 +Pg69lGslcg34RDWummnyolLi7xzxbPk9M/YriOVzqp+hAO+MAb47KaBgpvP6wA27TRUP
	 ASuEIEiHB3rDpMUPnLprObvdarHldm1h/poA1V3kvGv4tYJWQJ8ZTAfBgQPiN7TOP8uTX
	 j/bwXNCCuv5N7gc4Jgil4dH+4p/+f/QqCua4NUGbnn3eSJjB1QPkNmYT3qkE6muFbUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Glc1+ueB;
	arc=none smtp.remote-ip=66.163.184.146
Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05084606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05084606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Glc1+ueB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125476; bh=2SBbI7N0m1mEAVMCOcgw9cmNtdJLgRpd28VwmHlwmII=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Glc1+ueBgJueMCluf6o5h32qtrMquSNjXAN6dr9vELvmHkh1wf8vvish+FYRjidcBTDr3SaqGJixpbS36bi8pzd1KKoffUfPh8lt4NNF+cel2ynMdZeid4192YHe4x4CUN+qmq9aKmRaColMs6U2RMqHg8zBFQtFcvt3oHxQIrJ5dS1HDQ1EQ1e/DaucJ2zK5FYWUdRWYG1FM3wise0H4W/IStNcAY+ztOTdnyKwC6zO4unDSxc8wm+oKXkLR8LBVI2RisRsF+Vgt9ep3ZNS9SBdrsUtxLQMEviz0C7WUdz21XGKiwxsBZbGRS269YMGkLtXA08QT0+QkYiCXZkGLw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125476; bh=E977Uw1v/XKn9H/l9aY59vtTDbVK3aO4BXsARNY8J+T=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=nYb3PLVYfsIk9MHzpxQ22DYL2+2gzRLIVvCn7mnAQB7cw4OF7NVeZnwQ4u2xqf1Xqa+mG7qbZlHpA+DkTsAHNiiDTdNxZUznrVVgJ/Zkf7xyi7s7PWg7o8Vi+Nx/QHARf1A0TU74sKkgBFat+56HT7NixjH3DnLj34bDaptQtDMSnsW3/ggG+ilfCIDZzUeUL4dfg/xCUkbViG4c42ogD65c+SvoK5lHYHbkVrE9R1rqL1XsX4GBwo1As9IEQbnc8GlAVpTCwbFzM+vDZcZRbGuEOYjcKcxogdRO/eb0Np75gR7Bzu9r4peKSP+sWfcAU+mFC2HR+7rgeBCyaLsmQw==
X-YMail-OSG: Cgs8agYVM1kvfLc4kwpiUgReak75boMV8uvbRNJaPaOu7VU0DnIZhAL9o1fyJln
 6.via6sJroJjd1e_Zyp5jrbtQD2aDJ__nEpBlcsDu3_xSZhgcU.mEFmpMQcytJDLfwIDd7A5BeFs
 7zAeffni_Hdx2WNiG.hh3kEvOcYnFludfkq5GnovjoGyV6GNqEMi7_0SHvcsAeeM.KEcsgRwX8aX
 Z1bNNGvapyrbs6g3mpK8jqfNTZhj34lSbAn_HaGNwcK4avRkFC.dXDj0x_1MHLXAeROMlDaitwRb
 rjpbtsTJwUNxLVL4Z06k_W0XrkuUl9TJqTdxJYUmFhLtQkOmIt8bdm.oPjqeZCXLnJksOLpIUH1i
 cBnZUO9WxuDob5gYNdxoOEvzJDGWeuvSw3PTWcl3vYJMBzT_0Cb8ytdVm_.4WakudasZDh9xlWOV
 cLSdU1kJKMV8nVUWD0g7P5wFsewvlHlcmay9LnqyUM.sufn7qrooNtUT14ZrXPm0Uy7CtUiubhYK
 1Ob.n22DXLCq2N2xyk.xr.GStagfMchuKMQiEnvfU4h4Yw__v2tRnUHTtSqjsr6nvSt14pRWONU9
 Hsga45bW3ovjERIs.po1NJxb3znfOclOZhOT0EIvRBWItdHm90D4XzAimnJIpMvBzT05JZqfxeFO
 VEo0V6RAoopICmaLQ.I2rzxlzn6y7LsC8FgkIqZ.__iXAMf9hdb7oY.4hiYERXhg2RXUvfRoZoUl
 E96WFHsTwnImAyN8OzebOeeHUmD1pbfzxyunHmc7JBD6AIJsIPHrQjeuONGprItvEts1YT3HPVrk
 .f6qoov65q5BY_9IPGetsM51lonyO4a908w_XWS5NWxO1BhyhpwPKcZ1T09_MX6qA_wqHdsS9Exe
 8d3_jJDLZ72oWn5l9eZC44F4C3SsgDRQii.EPy_YUdmkk60.IBUJfRLRA7NzB3Neao9D1G_pwYBp
 zO5zCd2nUYQkOdJ.J0x48eI8reSeIyMUr__phBtS6toV2aT_KcZyvtCn4JxBqz_L3vMevNjNVmAQ
 fR3khjwiw_VSWk3jHJWQRMjtYhjTBawmVO3wOf_ZGqVL1Ganoiqj7emw5XnPMW01D0F5Iaq1ucss
 H9jpLfaMhw.nheOC2ONBxCXEk83l7Ozl28wowhXizc4EfwMjjqCgnyOfDrj7yeyAE91IyomdMKER
 HIG_isJNsq3zh.0bP3IO1tt2lyT7Cly6X5sQdNd_ZLloUUhd0ddkit1Hfx_idJVkN97vhldXMsa4
 KRO7uwsAT77RyVJr571B3kEWvMzZtYOcJdo.eI0az_EcSgc.kFbFTQUiChjwNkbiHhKp4GbemYg_
 3Wbacu29uwNnpVgM5xBF2ub8BmE_Cl8Ji5KQa0n7z1NbKEjFSGvuFXyZauVKerPerFQTqesYFuK0
 eZqSbBsDR9RYYQhMEaQkyQPKnAFEjcDWPWGpR5zL6vZynPXWscVk11mhjgQ4sXSRUt2UmVMNBtrc
 2yAo_2DrBHzGTxpB6c9sXZqorxbdoeKxB8pux6wNGpTZr_xlIN_pQMyctgHXVGjhb4M3PVooJMbz
 a_rdrJjAuasurLaYgoh81o7pPW7QZ7URI5Xbf8N9rPYTTAAGCjBTt.a_pqOf3YmAyMeJWlGSjTaE
 d.46ZJMUxdyCTRh8bPey.9tikMMMlgRtRYA0QZn7.0ppasj1UTuhp8WBKyfBTXoNX1OR0RytLwKc
 XMk40YSoc6kUGoPkJ.wbGfI900lf4CxW4u5VdOPN6jpsUffvFijRtNd2vL.Y5KgvulQOkf7PqdE4
 .lJSSL1B24VJ9FxhInz477A30PcDRFK0j7b5ek86lXLqCdEccGEHvLUoanacw.iI62CSxnzDx5Ii
 DxyU1a5BjE.Tui9eGvHatEey0eXGVCReMNMLDLoLz6mj78nKZmdB5_IaVSAoETP9rPIIYrbeYWkU
 LMi1TazOfnAb3ykQT8FA_6IHJRJfi8E_enXegyuQk3chpNUqhZJ7eUbARD_IxMyaLzx_etqGdTZB
 WQvORYP4dGKnxN646rivxXa20wqcCHojzJ..n8KyzYmlyTu17BkHIHQLnVh2YNjnCnbrIiMg8YT1
 p7E.c162d.eOSt0F6gC8CcD4cuTj9Mzvt02s1p0zzAowN.urudSCe7zxH85Wbc0f.p2DrQRPw4a0
 Jo3wV5RBybJC4LhHQeAAxamjtR5fehXIvdnR2UJj65nQjEuuIxqQnShOxxo_yuzGrARS0.BsJldD
 I4I5j10ryATlp3Ka.b2cWJQFAYe9mf1B36eUgJUmtLxT.3G711oljLhzuNaBqpOaUpJob5QspiuZ
 3auZmznw7QhtH.8M85Z2U1qKo4YyTxJII.hTl9AeP
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 581ae285-612d-4eea-bc79-3ac59705056b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:11:16 +0000
Received: by hermes--production-ir2-5dd9bf4598-jnk89 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8991b588ae2bb59c15e8a7dce50d0752;
          Sun, 08 Nov 2026 08:11:10 +0000 (UTC)
Message-ID: <7845f6c0-4b8e-48e6-a5e6-b0b3dd8a182b@yahoo.com>
Date: Sun, 8 Nov 2026 09:11:06 +0100
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
Subject: [PATCH net-next v9 07/11] net: dsa: realtek: rtl8365mb: add family D
 SDS13 PCS support
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

On family D rtl8365mb_sds_probe_option() does not read the family C
option register and always sets sds_supported, so the port 6 rate limits
are raised for every family D chip. The only family D chip in this
series, the RTL8367S-VB, has a SerDes interface on port 6.

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Tested-by: Stanislaw Pal <kuncy7@gmail.com>
Co-developed-by: Fabiano Tassotti <fabianotassotti@gmail.com>
Signed-off-by: Fabiano Tassotti <fabianotassotti@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 248 +++++++++++++++++------
 1 file changed, 191 insertions(+), 57 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index a87253b..86194d5 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -264,7 +264,8 @@
  * interface, indexed by the external port number with port 5 (the first
  * external port) as the base. Other RTL8367 families index this register
  * differently (e.g. the RTL8367R uses (id + 1) % 2), so this mapping only
- * holds for the RTL8367C-style parts this driver supports.
+ * holds for the RTL8367C-style parts and for family D, where it is the same
+ * (one bit per external port, base port 5), as in the vendor RTL8367D API.
  */
 #define RTL8365MB_BYPASS_LINE_RATE_REG		0x03F7
 #define RTL8365MB_BYPASS_LINE_RATE_MASK(_port)	BIT((_port) - 5)
@@ -286,6 +287,7 @@
 #define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	BIT(8)
 #define   RTL8365MB_SDS_INDACS_CMD_RUN_MASK	BIT(7)
 #define   RTL8365MB_SDS_INDACS_CMD_WR_MASK	BIT(6)
+#define   RTL8365MB_SDS_INDACS_CMD_INDEX_MASK	GENMASK(5, 0)
 #define RTL8365MB_SDS_INDACS_ADR_REG		0x6601
 #define RTL8365MB_SDS_INDACS_DATA_REG		0x6602
 
@@ -315,8 +317,10 @@
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
@@ -334,7 +338,22 @@
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
@@ -721,6 +740,21 @@ static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_hsgmii[] = {
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
@@ -902,8 +936,9 @@ struct rtl8365mb_port {
  * @mib_lock: prevent concurrent reads of MIB counters
  * @ports: per-port data
  * @pcs: PCS for the SerDes external interface
- * @sds_supported: SerDes tuning parameters match the chip option, so the
- *                 SerDes interface modes can be advertised
+ * @sds_supported: SerDes interface modes can be advertised: the tuning
+ *                 parameters match the chip option (family C), or the chip
+ *                 is family D, which does not use the option
  *
  * Private data for this driver.
  */
@@ -1316,7 +1351,8 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	return 0;
 }
 
-static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
+static int rtl8365mb_sds_write(struct realtek_priv *priv, u8 index,
+			       u16 addr, u16 data)
 {
 	int ret;
 
@@ -1334,10 +1370,13 @@ static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
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
@@ -1347,7 +1386,9 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u16 addr, u16 *data)
 		return ret;
 
 	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
-			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK);
+			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
+			   FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
+				      index));
 	if (ret)
 		return ret;
 
@@ -1387,6 +1428,14 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
 	int ret;
 	int i;
 
+	/* Family D has a fixed SDS13 programming model and does not use the
+	 * family C option register to select its tuning table.
+	 */
+	if (rtl8365mb_is_d(priv)) {
+		mb->sds_supported = true;
+		return 0;
+	}
+
 	/* Nothing to probe if no external interface is wired to the SerDes */
 	for (i = 0; i < RTL8365MB_MAX_NUM_EXTINTS; i++) {
 		extint = &mb->chip_info->extints[i];
@@ -1468,25 +1517,44 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
+	is_d = rtl8365mb_is_d(priv);
 
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
@@ -1515,34 +1583,58 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
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
+		/* The register and field names follow the vendor RTL8367D API,
+		 * whose SDS numbering differs from the SDS13 window used
+		 * here. As in the vendor sequence the whole 2-bit field
+		 * (bits 7:6) is written, so bit 7 is cleared as well.
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
@@ -1552,27 +1644,32 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1597,18 +1694,27 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
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
+	is_d = rtl8365mb_is_d(priv);
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
@@ -1619,6 +1725,23 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
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
@@ -1660,6 +1783,12 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
 	u32 r_speed;
 	int ret;
 
+	/* Family D forces the external MAC ability from mac_link_up(); its
+	 * SDS_MISC fields do not share the family C link-force layout.
+	 */
+	if (rtl8365mb_is_d(priv))
+		return;
+
 	/* The speed field has no value for 2.5 Gbps: the rate is determined by
 	 * the HSGMII SerDes configuration, and the vendor driver programs the
 	 * 1 Gbps value here.
@@ -1949,7 +2078,7 @@ static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 	/* phylink has no pcs_link_down callback, so on the SerDes path only the
 	 * MAC external interface force is reset here. Clearing the MAC force is
 	 * enough to bring the link down; the SerDes keeps presenting its last
-	 * forced state until the next pcs_link_up() reprograms it.
+	 * forced state (family C) until the next pcs_link_up() reprograms it.
 	 */
 	if (phy_interface_mode_is_rgmii(interface) ||
 	    rtl8365mb_interface_is_serdes(interface)) {
@@ -1982,9 +2111,11 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
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
@@ -1998,18 +2129,21 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
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
+		    !rtl8365mb_is_d(priv)) {
 			u32 val = 0;
 
 			if (tx_pause)
-- 
2.53.0

