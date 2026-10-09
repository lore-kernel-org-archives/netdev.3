Received: from sonic308-10.consmr.mail.ne1.yahoo.com (sonic308-10.consmr.mail.ne1.yahoo.com [66.163.187.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620893B52FF
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522659; cv=none; b=gbhGWI8GuZR8ZQrh3cDFmVCYkza3hLWf4//kE+2+JMeSKhF+mvhwdK5dW1k0eFxty7I7L3A9f20TnlZYBqIKKzhhoOtOnuRcpJQfOKcacALPyRTcvB6C+HT5PP2QngtAzK2JtedwepePGRB735f5VN7oxgy9oqZAKj3DBJkRfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522659; c=relaxed/simple;
	bh=liQ1yxbkNFQsNC1fJVWxY0YVKzkyEwh/kMzNMtOTfqE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=t1DN6vuiMjSmTHqfwYxaja2kDzcR59LDgqesE8wr5UHoguxSVe8ykcHXRJaDlv0geKV49xU/7YMl6AeEg1dSnDfL5dKxfclizx5nmlpql1omCIU0MFbHfFlj8vFDg1JfEV/el5BLvcWKssf4bl1bmJcJp4ZQq5CJXnUtUR4cwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mwXuleJj; arc=none smtp.client-ip=66.163.187.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mwXuleJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522657; bh=56Nx5p5RuPwWuVbJECBEiyNrkSuVNCSISaaE05CLNg4=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=mwXuleJjv3CSMFgiqXG96YsdD213X3/Gxr0pHs7vrIgYRAzCAnbjQWTPGn5dstyNM7tl8pjcd/UJJ7Fu+vrAamNp36vLr2p92MLPhjdoI4un1VIPRuAnZyipIvmoQgWrwLNwuItPIshQJ15lcTnfVz9csP90QSx+uqf5B0vWKktOOyLhrMByyEBUHGUyJdy59ooHaeMrRQyuGHs5oXBECtoMZ8bYh0aIO+voNEx8xSaR2YLBGk8+IXkULDrLOwI7RgkwY06bH9LcS8bHUDjJQb2nIImreZGTPhPDIGj+GBLzNPzJP4UexuJN9xzEckH1RpBVJuviTF/yEGZm2l8/gg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522657; bh=BlwiOLFhVFyNDUKvR8NDbKitjeMPtBgH+SbQdcCtNrd=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=PwhRcxAejx+AcnsT4s3hdWuNXSTtZrjmPF4zAha3nQkDClBRIK2Mhi32Jh5WuMW7NDgHFAw2aXZCqExvaHEbBchx0AyTqwQlg56gldy2/yGHt9rj6TODL99F9E4wBxCv78IxBXkPS78vW0Sz4zh2asXZNWIPJ8cF6i5/lBFUDXFrOJjs0Ns+V7InVyjtsz7KbwaijSvWAUYMrGB0HpGBWJFkPss+KRMrixhuc7Xx7ixmjKj5Mi7tH3BNqoy2YZrguy+alVjCFpTRrqakfaNQGyenSWUVIG0Jm47KRSsgYwiP5rSB6+MVM/YmXuQXlMuuVBJ2sfKFv2O5GFmcJLQNsg==
X-YMail-OSG: HDAH9HMVM1m7huEA4VOJvyflucKwuLkoTH2f55mEuQ0vHOfBmxStC3QiBt9foCv
 MptAK707wEwl2FWpyuxJqNQpvwe3qw1dMSmOKNL.WBuMxxpoyU01Wfz.3sjvH2bgYWb.Rd2vCBcP
 Z2Si.wxjrQV_nllSmJJQXJz3..eOakAXSfbXYWTuyuG1olPT795mRPhQjXQEI64gqV_iY.YwnJEA
 2GsyDXG8znR9fFuGLXk1is6J6hyFuQVZvJi2M9H6slJp1whK7feZtYSgMP8X6xXShDKjk._0qEXV
 y2oFvsKk8DPoX0hHsuzZwf_VVqhB._.rN5P70i.u6NYjwrNaNryZYlthg435AsaQtdkRSKBFP.XA
 K.E37z5dwo69lg7VkekS98cMVMqp4CyV4UhddbBk0erWdGLbiqS5MvTLrU78QDtT1U8fp3cJmzew
 lgzhlmdBaJ11nwN1mgm6_bEFxB_uVK63EkRXoSggyyVs2oB5ZVJfqxBb3s4ApaWB9JiJ.xynz38N
 P98LvxTTSDnm7jEBzEDUrFfSz4nSAZJ1GxUVot8U59yHQlVbW3zU3YeBopG43tjlaCoP8124o0zq
 75HDFc69PreF1ANUkbYHsYCUAQ44ADF7KPbcZZKpLlx7XZDgqcrn8wLMwb2rLJcBN2YOmyOmmVqb
 RYwlN8uSp1vKehTIN9Nb416WK.Dm96lEcK5HkCdyaLPNBwS9UQmezqCGE52CqY.tdAkKMe6EjezW
 7fekGb3p9bhOALnWqPqytJ62gsvG1Z60d0M2Aix9q8jUdX0vocasb9lEr7uwpBcrMWOINgMOpClE
 N2vWrwLofb.tRFcfiW_r6_NpBDv4M1bGhsJOHlszL3MAoMlG7Tn6WwOeTQzdOIEQJ9KwzOpE1Ouz
 RcO.DB6IYafRJVgwjlk5CwHnRJXEsDnmNIg3XbDP8wJbVOepxxIrS5BcE4iJtqbNMrU6t_jZPjUv
 AzzRlehR9Py.qAvi.oghbAvugkpoeGzACp8PYlYNmfrBFm9_LlezsyNhZ8yTIUFoOIQaXIX28hIs
 YrmkdgOh7OWI2QuIhIDu5Q5gtOYy49OiM4sm4G5QnuYIXvxMwGJ.mE46LF6dNuyJRQjJq.fOiv0z
 Eqw8UUS.Rd5bzBcLIrCKg6Mc0FMrklAMQYHrQ1KPY4TzTgUE7_M8ZW7s0x_IPHsuIcBPh62Tt55L
 bs6e8N5n_KBygY7Kwc75PQ19wHtHJ81Rw8p3x6YUgoItjPDFNDrvlH.D4QrkJ3JuvKjID_hE.n2a
 UCUk2YHZ2jDHsOd78u9uxEJOWCB5ODTeDDZ.wjpa1jRmJMdKpkNuXdFGX5OnQteRcspQ1Kz0ZtcJ
 6gC0me7tS1AZ9hE.PZ.LcBRwBjdQPM27FqYkZcKvrfyVOI.lVuP8uL.c3PXq5DfTY5rkuSTAJjks
 .W5ywcA9ytZOkxolGXBBNHkAxHAkUWzij5pQnldJrFjQAimSWnWZQIlKgKk.IXMV2Mg7PiT0_F74
 r9I30rc04su_djacLQ_JLxmkLQ6M3BFUENKl.ndQs0ponREucOj4K6D_cYVbHzvZUWLnYa_fqkSf
 GUHqiBuQXj6Nd5drMsmaZlssvS_WZtzZEvTAiGwmiZGPetufBYeizc80ok38FIl28hZoWbXA4hwg
 D7lcUJjUpmwpu.u5FM6Q9AYarAQtWATOlZOb0EJmfjQkmXnpWAwlnoXU6I2Nf6YPUYROpFADvy0j
 wEzkJlitW0LM.o9a7AWIoDV1oz4TzdhGf.YOEn_BhTs0HyY61hYEwursFRrVmgiE33YVfUeni.jB
 N7D4905MkBXTvJojtRsyNrkeWLlQwsqn40wzzGcnOkmcNIEcfkE89Dc8UxiatFevezSmXYNRmr_U
 7XKMomx55RWOnGawd9USHd0ccxaX5noJz0mFVTLziKcC2wwQMaIUA_uPXCAcxpvfAFsTiFWQ0Bdx
 _YjX2BSL7iyNhkJzXCBqcP0ckwbiA3aKwPFjHIeQhJ3w8s1txVW3hAORA1JTECH2D7GICPZCGBeB
 8vtHx2_ZgzdU0MbP3JZvEvCx_p2bpVC1DVTH1EdZ_pmr2pgNshM3OWnIE1vd1_cfJSWDdZtCWUil
 Oy_mXgwJ58akmcHrOrG94QygbZcT87ZsfXy6kaP3KSIw.sjTvyV89VfhcJk_ZIR6xTwlbJg5O6MK
 MuO5ARXG.YI6PAJWrQBthYl36iAy8di1BXuZo0a3J._8FnNYMNrlfo3zkLjoYiNxvfyslKftZLQF
 C.D4nsjyRjz1GhJmceukpjoyZKwkvm5uT_ThdM56t8bcWGqIGGm46V7KE08FEoyTRHuobuDudxpW
 ok6G7p8ynD_IonPzaHv6IXF1G0QzesDjf2dEovKo-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 3e4a362a-0e37-470c-ae8d-db1d32371c9a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Oct 2026 05:10:57 +0000
Received: by hermes--production-ir2-5dd9bf4598-ztwl7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bdf7bea4b2dfe1c386d043e78a785697;
          Fri, 09 Oct 2026 05:00:40 +0000 (UTC)
Message-ID: <a45bbcfe-9436-4800-bf23-553d1d566716@yahoo.com>
Date: Fri, 9 Oct 2026 07:00:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 7/8] net: dsa: realtek: rtl8365mb: add family D
 SDS13 PCS support
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
index 3819a48..4cad90f 100644
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
@@ -714,6 +730,21 @@ static const struct rtl8365mb_jam_tbl_entry rtl8365mb_sds_jam_hsgmii[] = {
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
@@ -1327,7 +1358,8 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	return 0;
 }
 
-static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
+static int rtl8365mb_sds_write(struct realtek_priv *priv, u8 index,
+			       u16 addr, u16 data)
 {
 	int ret;
 
@@ -1345,10 +1377,13 @@ static int rtl8365mb_sds_write(struct realtek_priv *priv, u16 addr, u16 data)
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
@@ -1358,7 +1393,9 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u16 addr, u16 *data)
 		return ret;
 
 	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
-			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK);
+			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
+			   FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
+				      index));
 	if (ret)
 		return ret;
 
@@ -1398,6 +1435,14 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
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
@@ -1476,28 +1521,47 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1526,34 +1590,53 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
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
@@ -1563,12 +1646,14 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1576,14 +1661,16 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1608,10 +1695,14 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
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
@@ -1619,7 +1710,11 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
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
@@ -1630,6 +1725,13 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
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
@@ -1671,6 +1773,12 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
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
@@ -1997,7 +2105,8 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
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

