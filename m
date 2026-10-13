Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150363B14B7
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880855; cv=none; b=GdPCVsnHfM/ujxZXfGNJ7R+l4ta8mc1WC7Aiabm6ur8vTZa+tGBiHDnLOj7fRvCzefuqU7bWyec2VS3szeMk7PvTBmYczAdbzLWknASFmPMzRLrckjs4yTs9Q6hyBmpstryKZcmNFZJGfBNx+DCKHShGE4/xF4oiH4OkpuBEzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880855; c=relaxed/simple;
	bh=Pk7Fb1AZzeW7M7FKRbqjC0DzgTCdNOOOuZDBDnmkuPI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Zxh+WFGZS07a4T1dtBnWwolJunkkaGxKJwPRTcnChban9b6g0IdCF7CPOdK4r6hXv8+0e12pWa2n7ChteV6I3KiMOkPUcwfmcfsVK24OJShlmH+E+Z84MuZGTpafrPCBg0iILfy8B20MCDpsFk+GlgkIriZRotjQEWIM00iWmaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ipq20z3C; arc=none smtp.client-ip=66.163.191.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ipq20z3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791880853; bh=lMXy7NS+CViVo/GJ9mjOwveWeUgRdmhWsoy0QjbGr0M=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=ipq20z3CT+P9rYvBx7L+rvIdXnydEphemDtTO5jsqCGWGZSIxceFwe8m+vR3LBclmOqydsnlpfeo3pWFxFPOPsVoZxz7AtHUC+22O7bJIAblZYuMuC27YhygSucRbBok73aZhXs4lswQu917yA3Ahzl7l5lYz4JiBNckpyaFDGJqKeBjXFG3NoE6jrxyHuD4mwe5mdIOTbCR06OKKbX8i8INmLL76f284V6te+Av4fWITaxZ33shssQm+LSdlYJ1zL6c0WbkWvxFVeaWsSm3wdHzJzagf7xnLFER7Y6aCWKIj7jIuM68vphOSj0SjGOKt3oaEIBsDbV/6aKpaG23Eg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791880853; bh=ZFlKTLJf6a9rBF2jk+cocjDrbsfRVE6XyyhAsZ2Bf4C=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=WxqQFDWBt8tJ7YZvapa2WYQ5n8Z0bS3P2X7dAVfE/AnCSE67f0Czxv5dk4o8099oHGRqnSD7IOXd683AE/MGrXyUv177Lw0DBuCh7czb8QY6maJPBaphYRgNHT9cHXJItRpU2AyLVXBy6yArv7BaF3ctZQqvtMRTZeudApbMxcPIv/2PB7LN4gO81DlsFdxJEoCcDwAba+UGu2ozO3spu3DivG7+xwbA6VRzG3XG5cPNsum9pLqNfu4YuaZho7nqaL/P2CasFS7mGFjZvaUz7USbNQ5OHgOPwBZ+tBB698Ecv4ppHqqPh/y7O/xkz/QUlReS4ro/ToPPnmZc4/1i8w==
X-YMail-OSG: sui409wVM1lf5tX9rkrSnfmhfRmhv6W4yDjScYz0TKdf96dSqo81IHWw..bZPrr
 Y6UP5bLSvFh.A7aSCWjjAUGdShxhi1GtutGHpdg2bMy5abJkFxgg_zpoJ7Dt0wVrevurjIOYoBfD
 tmw1maWuHyb5kO9QFIKOTMfO4ALho8W2GMrI5U_MVeL3TwmXzsWRPSeO_YuGkHxzCy2byf3H4Aso
 _V5Y89fRNQ1vZEUZ0oEw1AnPtmEdNovVscScOW9Nm1eKrMEN_RLCpw_C6nn29BqWELNXW78C28xX
 wBq_CJ7pm8kDsogz5EgHHCUO4OYSVdXKWcSNmt6Q2vok4SBK00b04Zfazq5G1IrwKkBscIVW64.H
 fJC4x8PsvWdZKq3wtsAu_Q9YmlVq3h4uWyA1JivFUeU3ZaN6UyNEehPG9cPVSlarc_AT6QNASCh8
 DaEIo0cabSfFNv5rN5_WVJyRNrXAmZuN1lCANg_FRs4OufrgYeEyR.XeeckTVyy.uBkGY2s.6.CJ
 aXcozkINM62gni6xfBsrsBpHWELzH7qgkMOcOdh8FJ.7RRIic1p5EEOuDgJ_PyrdfvMHgvWyUtsq
 NWo1cNHyMNwu6v6pNIymDBcsnf3YgiudsasmVKn3rgTcckKR_G3fYBpkytI7bqU3hR40G1IfUyVQ
 k5PwpteM9FygAMOLUfBsQxb0_DoE8aepfhqPNAnhDcLXYRA1Snl0sHTbh21ZNAEQh2Y1a0CYst5D
 C3ywmtAZ8U67IucFNVwoJiULhSdcmzfwemrowGlULRl4nPG8hJDx3lT.FvahTBKvwoHjhvjWbbYw
 ilGCcGaZ7.a1udox3TMbh38tAMbosAhk.dlHKnXoE7Z4v6ogjUyuMPfIRGrKczZCqv181zeJhj0J
 oQnmzz_pADmpHT8pphPktMAdFR_pQ5FrZfMf9bpWFXH7zm3DTrOOVTHCjcojkjaON2Fqx7U8APTo
 OySXAYi0nkhlkybWtu60je.bteHA.CNJexSKIjqQHjtW6ncfNiYQUMfuEaA9oD7hf3AskQ.jrLCB
 B7xJCoG2H19T3aNMbnaKBO.rXA.G9zt4SmkAaXWJliqLK_x0rP2mLeeLbbq0aqS_4YT_0nB_3RWY
 J3y5gwhq5on1tc3J5ENp9AHVk82gRhcPYrDeWBEfco_Xnic7YMKsIszNw8KAR64ZcmySa2QLA_3f
 l_9TQZxfeUN4YXwfxzEd0G6xb4d3HJMUJT1B8qol7bsPYGuKNOMbSgWWokn3.L.U5uMhOx8_1.rj
 g1MaYSK6rulZYNqon06xiGjCNLv_DeT3xMgygS.itrvKS0KZTZxlG8SuLpadKToTuCLlzx7.wBIn
 fSxKKw6hlyQTAV.U9Jt6FVD4GYKdXJG_PsD2fxDzMZ3ZUGaZM3LLlkrhds_ToalvlxBYr3hVhDDK
 ylB0ZWlWj5yqpVrYm0d_UQkikKIWX2DjpJleDQUqiFxLiFMATnAR3Fj92pQ70pEgyLSlZJcEh0rz
 atgE4GnISbUTBTM8e0qvxiTl.SAxyfp9uWJMMy2tjjqDYHil4GNna32eBceuhmTI7s4YyjvV39dd
 LLjUCHIJ_cjMCrWxs.QwCI8sFvUR4e71UYKjL4S1nSKGpMHKT_9j_vISwLSgB.hiDFG53DnP2kxv
 ZSbLzriScWMyuDH8MG9QDiPec73AsXizFQ5bWcjhtwCB2KVIDh6_KYaZwV0v5Yadj7xDcD0pXBhq
 TFknHIJ9wMo_frKflZPL_sKoU_sMxpyxaVlRWV08Bd66qQ4S5NAEU94kQOAdGIg1V3M5w0amkkpK
 NjIS_Uo116_lxs7dOTJILAIdi9cTdMgXKlhrYVix4w6nHwqdco5Vh0pCwYAMX9SL3HbZAv40N4_h
 oI_ndoVmOfABND4gEX_w9PMsyD.egpeZRah6b_YEoOdqtDmpt3ioXiQ2kGpXaMXKNzBMje8r7MvB
 WB5ns3kBsYdU5a8R2yYH0egGUUCXgoPa384w0u3aRFwJAeWRaq8BHTWQCYyE9lu1fjFZUsQRy6ZI
 jBd6d59WNz9PYO.I3EYYTrPWAJzYXmh6C_cM6dFC6U5EIc_t4V0iCbeizppKPFLSpYg9FJiqypPN
 ZjhxfpFjtrXyGHP8YzdYYQ2U8P2O4kWT48mscS9JABlnnPruAJnTk7pqExrIdwjDph6d4UtKL9v3
 njcSgntIz02uYoULkBfBitP9cZo7C2nX1Ye106W8m_vIeiaFOSWsqpgBetMZkBpE6WQGjylKIa0M
 iPwgBWLYmxp.j48RL.pN6QhG.q8jAGW2_G0jmXBcFplj660lEknSPWL7BS5vmWovWnrVYXFGK_UQ
 6G04ucEHKm7I-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 288e6b31-b922-41f3-a021-14476f49e28d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:40:53 +0000
Received: by hermes--production-ir2-5dd9bf4598-nf4w7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 60f1b53c1a260cedfb94369f9aad8b88;
          Tue, 13 Oct 2026 08:40:50 +0000 (UTC)
Message-ID: <b5d4eddd-d455-4f2e-887f-bbbed4a24ca4@yahoo.com>
Date: Tue, 13 Oct 2026 10:40:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v5 3/9] net: dsa: realtek: rtl8365mb: set speed for
 family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b45a3350-44a3-45ad-89cc-452c25edbd7d.ref@yahoo.com>
 <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com>
Content-Language: pl
In-Reply-To: <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On family C hardware, forcing a 2.5 Gbps link speed requires relying
strictly on the HSGMII SerDes configuration block, while forcing a dummy
1 Gbps value inside the standard digital interface register. Family D
introduces a dedicated hardware link speed value (5) for 2500M. The speed
bitfield width has been expanded to 3 bits, splitting the most significant
bit into a new separate register field (FORCE_SPEED2), which maps directly
to a distinct per-port digital interface force layout.

On family D the forced-mode configuration (link, duplex, pause, speed)
is written to a per-port register at 0x12c0 + port instead of the
per-extint register. The bit positions of TXPAUSE, RXPAUSE, LINK, DUPLEX
and the low two speed bits are the same as on family C; the upper speed
bits go to bits 13:12 (FORCE_SPEED2), so FORCE_EN (bit 12 on family C)
is not set. A second per-port register at 0x12c8 + port enables the
forced mode: the vendor RTL8367D API writes 0xFFFF there when the MAC
is forced and 0 otherwise. This driver always forces the MAC, as on
family C, so it writes 0xFFFF on every call, including link down.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 82 ++++++++++++++++++++----
 1 file changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 840db5a..2dabc4d 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -344,6 +344,7 @@
 #define RTL8365MB_PORT_SPEED_10M	0
 #define RTL8365MB_PORT_SPEED_100M	1
 #define RTL8365MB_PORT_SPEED_1000M	2
+#define RTL8365MB_D_PORT_SPEED_2500M	5
 
 /* External interface force configuration registers 0~2 */
 #define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG0		0x1310 /* EXT0 */
@@ -361,6 +362,28 @@
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK		BIT(4)
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK		BIT(2)
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK		GENMASK(1, 0)
+/* Width of the FORCE_SPEED field, bits[1:0] */
+#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_WIDTH		2
+
+/* bits[13:12]; bit 13 reserved, no defined speed value uses it yet */
+#define   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_SPEED2_MASK	GENMASK(13, 12)
+
+#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_BASE		0x12c0
+#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG(_port) \
+		(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_BASE + (_port))
+
+#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_BASE		0x12c8
+#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_EN(_port) \
+		(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_BASE + (_port))
+
+/* Per-port force-mode enable. The vendor RTL8367D API
+ * (dal_rtl8367d_port_macForceLink_set()) treats it as an on/off switch for
+ * the whole forced configuration: all bits set when the MAC is forced, zero
+ * when it is not. The meaning of the individual bits is not documented.
+ * This driver always forces the MAC, as on family C, so all bits are set
+ * on every call, including link down.
+ */
+#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_ALL_MASK	GENMASK(15, 0)
 
 /* CPU port mask register - controls which ports are treated as CPU ports */
 #define RTL8365MB_CPU_PORT_MASK_REG	0x1219
@@ -1646,23 +1669,32 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
 	u32 r_duplex;
 	u32 r_speed;
 	u32 r_link;
+	bool is_d;
 	int val;
 	int ret;
 
 	if (!extint)
 		return -ENODEV;
 
+	is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
 	if (link) {
 		/* Force the link up with the desired configuration */
 		r_link = 1;
 		r_rx_pause = rx_pause ? 1 : 0;
 		r_tx_pause = tx_pause ? 1 : 0;
 
-		/* The speed field has no value for 2.5 Gbps: the rate is
-		 * determined by the HSGMII SerDes configuration, and the
-		 * vendor driver programs the 1 Gbps value here.
-		 */
-		if (speed == SPEED_2500 || speed == SPEED_1000) {
+		if (speed == SPEED_2500) {
+			if (is_d) {
+				r_speed = RTL8365MB_D_PORT_SPEED_2500M;
+			} else {
+				/* The speed field has no value for 2.5 Gbps:
+				 * the rate is determined by the HSGMII SerDes
+				 * configuration, and the vendor driver programs
+				 * the 1 Gbps value here.
+				 */
+				r_speed = RTL8365MB_PORT_SPEED_1000M;
+			}
+		} else if (speed == SPEED_1000) {
 			r_speed = RTL8365MB_PORT_SPEED_1000M;
 		} else if (speed == SPEED_100) {
 			r_speed = RTL8365MB_PORT_SPEED_100M;
@@ -1692,20 +1724,44 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
 		r_duplex = 0;
 	}
 
-	val = FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_EN_MASK, 1) |
-	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK,
+	val = FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK,
 			 r_tx_pause) |
 	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_RXPAUSE_MASK,
 			 r_rx_pause) |
 	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK, r_link) |
 	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK,
 			 r_duplex) |
-	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK, r_speed);
-	ret = regmap_write(priv->map,
-			   RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(extint->id),
-			   val);
-	if (ret)
-		return ret;
+	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK,
+			 r_speed &
+			 RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK);
+
+	if (is_d) {
+		/* Speed is 3 bits on family D: bits[1:0] go into FORCE_SPEED,
+		 * bit[2] goes into FORCE_SPEED2 (bit 12); only 2500M sets it,
+		 * bit 13 of the field is unused.
+		 */
+		val |= FIELD_PREP(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_SPEED2_MASK,
+				  r_speed >>
+				  RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_WIDTH);
+		ret = regmap_write(priv->map,
+				   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG(port),
+				   val);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(priv->map,
+				   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_EN(port),
+				   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_ALL_MASK);
+		if (ret)
+			return ret;
+	} else {
+		val |= FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_EN_MASK, 1);
+		ret = regmap_write(priv->map,
+				   RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(extint->id),
+				   val);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.53.0

