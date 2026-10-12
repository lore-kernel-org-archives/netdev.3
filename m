Received: from sonic312-25.consmr.mail.ne1.yahoo.com (sonic312-25.consmr.mail.ne1.yahoo.com [66.163.191.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B701E7C02
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791764550; cv=none; b=tXzT8A504FRDIioG0XMlKNXcfSTb8PAT8ETUMaG0M7rYJdctxLiUrbMQAqxi9bFPr+eEii88Oy/nmgaf7tbwSXwI3Kaqqo8ywy8DGBKnnt8KP+0Z14/yM7JILSPnaJFvh43RRGbAGRiDiUU/58mvl/+foEa6aZ7Kc+cG9zleRNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791764550; c=relaxed/simple;
	bh=oWIsY+dSSmkVn0AbjKeeG0oGJwIsxZBcRWXhj3QEtLs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VROqgHBZiKlRVx15GMu39YRIcLZW0QI+/iVAVmrjF4rlc6Q02nE307+b9np+UPj7RPpCnHTzsSHJZakgClL0dziLOE7azq42LcFYJWdRdq80S/BxxTuweAKMjO1ZZF2RxbMftRNMn7bXybQDDyIUIZxsShMb+PNo7ou0AY/uzyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KBUbsG3n; arc=none smtp.client-ip=66.163.191.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KBUbsG3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764548; bh=BLXG5VC07+xNWChTp4E1hZrZYbIHEPofmDmmIjHRsbk=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=KBUbsG3nHfUCr/xDEqMG9CPVferhrs/Kes+1rdbGwBZM+r9Mi8DN7zFYldIeyxqqnYL7UmjaICWrXUUm1awODq4pNwIB5kc+iF+Hj6iY175YGZf3XvTJrl6VXv5YQ9kU9qna2f2CSvzEoSzANHqCDC/95Ox1nb8yUli34X3TwPt7fMcEF90qKRRzk2J61xBVBbVrT/pZUmBtVd3YlPEHbGz6UIYpYhsCZFAmjt5kM1nlfL6woizBs+osA4/1KKwAq5HfTSe5e0F1cvp3fgNDrM6Sx30RLxg6EsQm5K44exFkYwZ8zdu/HlM+D/Z3635yyy/DgZ1ygzysDOEugFsq7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764548; bh=7JM5+R957xsFDvwBD7gAjOyMNX2EVlbmzxVTwUtShhO=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=OnDR+7CTudZqdyn8ubjQL0Gxy2i996rEatMjmGWc51Z8N1Imvxf48yIGrotXXdq0q1g00yEu36+7C1QUxveSXdg54zzQz8zJrafg6ohoj7NelbboOKjLLg6lbuNr+8ciVegBDfnkgYxazcGSCumTtQK+2bNtx5Z70i04G9rIv2z8UBrOp2b0732iILTR0ItpJVcsBOfs3+4k6ZBPPCptakhtNwvDx3Uf76PmqYG67c0xF7L7j7UDBh+jQMIGY+4UE11Dyg76eklz6qNlAggh1UaK8dJbZKovPwPZF+GulxDstinMUu9Q5XSNhBR7fIUkWZScIqJoA22t584bo0itcA==
X-YMail-OSG: bfR2URgVM1lYUmY8D5P3HfHj_wBHa7y54Q0UD7zSbFo2HfiXXaOBOcJpbTqc0qZ
 QQ3TGstNT6pebFfw0AVUExNIyjIwwXfKEHFz59kNdwNlOwWHSaArUtqz6i4nXDf9n_Vjz4AepNcB
 X0_BQXdg27myLeiNUYHGgrmBgwY2pII7Aogj3SpbDyUMGS5YcPuAetABOtOZlVU8s8lM0dNiEodP
 F1oVEuiV9tysdyJtOnRrckw_xoSq7jarE6wyyTAYUJJe3iIkf5KhliD99oa4P.IsvgOAnBnKnJxM
 Vh6ya4qIdJwdrwgI3v1u2OCRSMJ8T5g7CsxFSyKTe1.aBjsuqVRsqc3OZXSN3rqM7HrwQqFHDSyl
 mF7aJF3oeCFQTT.5C4J66slnTq3Dns8JSxW2rHaQ1lECeKrcHrD9qzv6iUCxxsj5QAuabsYKMfSz
 0DYtuM7zfrZKq41MX2HYmhUtDZU8DjWhjLz5x14cTu7xAPiwRvc76k9UY67s1_3WsEt3Mo3Y1rQ.
 ShSV0E3nm7wRtHK1X4O2j6zrumgdFG3W6kicjBhI_2VL7_e4cr5YccfjiYqjrlvUmGe2hCExFlwI
 ty3Pnr8gM_Dp1X2eHKvuMBrNFHEUmfmikACLBohKWxhA1O4JXtv9hYyXvnayjX_FSFPRfsH4N6Di
 I.2LVWiwe0hZRLLwPUeER9HkfHdoWStJBUWedw633DDvI.YpuQErx_gK0GeFmJ5EJoQi89p2NlqH
 5IgdXvgbar6_zuLXJFpFh9xT.d_DCXxElCKTCe5.3cP1PooOQ7XVfJG_g2o_TGzS2ZTYL28GV5rV
 JppbDs7nqdJO2MmgwEHzuTACf.XOr2C.pCU_Isdaffm02LQ_mbz3ceUEnKjs_J5c.ul_PH.d016.
 5_OL4y8TzaCgmVEtAbjBIdmlRQXHQ0Z1d1P9wtkYIcFXhYKzkMPmfHHruqxZsJzVGIC94dG6V4LI
 luU58BW9XhT8dAcT6wJyWqZz.FJDMjVBInQoCgvQG2vSmY8e1Koa3x3.FNv48jLBFr_COL4GSEmL
 J_niPX5ssdT1rDndCFaEupP8sICQAj7cZvL6k4qRFPwup7OPIthFPGdw7voRE55UTfQ70MU9ndfC
 Gzg9eJKg_BuQsxscdpnsxXIdLx5.KvxEdFO5PIS.mLT1hftKh9Eai1Tj3cE82xjaTR90XmGYkLnv
 MXoJzsMEx_mn7YiDXomR8UOA1AiWI8Xg6r3LsqRIIJHrL8IdwqUL1S4tvCDAuqwFiXNUiY9th7eF
 jrzVH_5gpyDFqcvN0YOwLJ04G9oGOSL6rUZKpl.A5DY5XLXkhogY_1NwrWowhhFmHzLHsU6kWmCP
 bcuOh.ta4GfOonMWKlxWkNcLHTpM3Go5GH6NElAlzwXbosB10XKHpNc08CfSvIFMhXbrF2i_CzDh
 CydZxSGvU74pAx7c4wcMZqOqOeZbCsYnqlmLAVXSVqwr7SrZBc_g9yoPas.hl517mEHDePHlUYP.
 0FeYYUUGfWs2VomNSzsOT52.Ev.eq9G3ZCQe0uX_aieQUNPBqTh1oDKkJaAaGkEXDNH7qxi2llO4
 ot8c2.oM.xpT.eqoSioQOhrK9f9h2lyFusJwsAf8eT.d32SILUSbxnNP7PFEAO4DYXvJ6s2CZnlI
 MSym.MoHlsFW_H_BDAbJsepwhPffehA6isPqZg_b_zV8dcmxSfvt.0Odo2nn86xXZ4VgmXgfVWta
 SmAlVpMRDaS_ILyRgy2NwoNMG7e5ZuNhImHTv.9AJojbmmuX8QjYIptUzVkCb3HPZidTXVx38tEf
 EmXXFVcQHz3JL0Z7O_019oUk32wfY3S4Ky_sXyQFmcEld20g.w2bSMBKpU7WOY8x6Tp1uZQ3shEN
 .z5wjqqRRGNbMAT3Luamb4kSw6Jw5frgmFGsSlvxiQIyrOELtBziVy30Gwcl_mrCdhtzG5r1vWlM
 kXZ4CPrRV3Rtja_Va7WALkoalYmK0pCtIHClI0SVwSmVJnQyiCwfR1nmuE7BM6pe5qBFhqItqu9y
 WhJoAxKgFSXq1dUQiZryxJAw5btAZTuB8vriAvWuZkwVGWxznZK25wVFoe_SE2ykYsdFerCILNw1
 Xr8tNt3r5GGnQ1qaID4xOyRLKjBrzF0sWSPM9hiEgU96oI3OUUyy3xcIZUYWUo6OrLXrnStPjiSO
 L9QJ3NPRDsZBukAiPpzLsUOdfVIq8H8BIwZ0I5PmPcYuuuqIhltfqe4gfXwTVv.BFZKhc9mfDYH5
 5NcPy91pto_RFMXlihUziW997H_7PLr9kXUfrwbDzoCGI7FIfuBWmAdK_ENnBLpL0GAxTos7v6b_
 o8U322iqV4_mmGl1WFptJP3_kuLkcDn0pnOvRiyA-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 0683c00b-d40f-448c-acec-6483eb7e0221
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 00:22:28 +0000
Received: by hermes--production-ir2-5dd9bf4598-9c455 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 080b6858a8240686bcd0a6be64780e9f;
          Mon, 12 Oct 2026 00:12:07 +0000 (UTC)
Message-ID: <a79f1f46-625a-4aaf-931c-65737f8552fa@yahoo.com>
Date: Mon, 12 Oct 2026 02:12:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 4/9] net: dsa: realtek: rtl8365mb: set RGMII mode
 for family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Language: pl
In-Reply-To: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On family D, RGMII on extension interface 1 needs two things that the
other families do not: the EXT1 RGMII TX clock delay field in
EXT_TXC_DLY (0x13f9, bits [5:3]) must be cleared, and the pin mux in
the top-level configuration register must be set up.

The vendor RGMII setup for EXT1 clears the RGMII field of EXT_TXC_DLY
(0x13f9, bits [5:3]) in addition to programming TXDELAY in RGMXF.
Do the same. The init jam table writes 0x0090 to this register, which
leaves the field at 2, so without the clear an extra TX delay would be
applied on top of tx-internal-delay-ps. Clearing it makes
tx-internal-delay-ps the only source of TX delay.

If the internal MAC4 block is not occupying extension 1, bind the
RGMII/MII pins to MAC7. SerDes 1, which shares the pins, is always
disabled.

The family D branch is not reachable until the chip table entry is
added in the last patch.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 2dabc4d..996ba2e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -332,6 +332,12 @@
 #define   RTL8365MB_SDS_OPTION_ARM_KEY		0x0249
 #define RTL8365MB_SDS_OPTION_REG		0x13C1
 
+#define RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK		GENMASK(4, 0)
+/* Shared "disable" encoding for both SDS_MISC's and SDS1_MISC0's
+ * 5-bit mode fields.
+ */
+#define RTL8365MB_D_PORT_SDS_MODE_DISABLE		0x1f
+
 /* Embedded DW8051 microcontroller control registers. The microcontroller
  * can run firmware to manage the SerDes link, but this driver keeps it in
  * reset and disabled: phylink already performs the link management that
@@ -465,6 +471,20 @@
 #define   RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK		GENMASK(5, 4)
 #define   RTL8365MB_PORT_MISC_CFG_CONGESTION_SUSTAIN_TIME_MASK	GENMASK(3, 0)
 
+/* EXT_TXC_DLY holds a 3-bit TX clock delay per external interface, for
+ * RGMII ([2:0] EXT0, [5:3] EXT1, [8:6] EXT2) and separately for GMII.
+ * Only the EXT1 RGMII field is used here, and it is cleared in RGMII
+ * mode so that tx-internal-delay-ps is the only TX delay applied.
+ */
+#define RTL8365MB_D_REG_EXT_TXC_DLY				0x13f9
+#define   RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK			GENMASK(5, 3)
+
+#define RTL8365MB_D_REG_TOP_CON0				0x1d70
+#define   RTL8365MB_D_MAC7_SEL_EXT1_MASK			BIT(13)
+#define   RTL8365MB_D_MAC4_SEL_EXT1_MASK			BIT(12)
+
+#define RTL8365MB_D_REG_SDS1_MISC0				0x1d78
+
 /**
  * enum rtl8365mb_vlan_egress_mode - port VLAN egress mode
  * @RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL: follow untag mask in VLAN4k table entry
@@ -1201,6 +1221,7 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	struct dsa_port *dp;
 	int tx_delay = 0;
 	int rx_delay = 0;
+	u32 data;
 	u32 val;
 	int ret;
 
@@ -1270,6 +1291,35 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	if (ret)
 		return ret;
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
+	    extint->id == 1) {
+		ret = regmap_update_bits(priv->map,
+					 RTL8365MB_D_REG_EXT_TXC_DLY,
+					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
+		if (ret)
+			return ret;
+		/* Configure RGMII/MII mux to port 7 if UTP_PORT4 is not in
+		 * RGMII mode
+		 */
+		ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, &data);
+		if (ret)
+			return ret;
+		if ((data & RTL8365MB_D_MAC4_SEL_EXT1_MASK) == 0) {
+			ret = regmap_update_bits(priv->map,
+						 RTL8365MB_D_REG_TOP_CON0,
+						 RTL8365MB_D_MAC7_SEL_EXT1_MASK,
+						 RTL8365MB_D_MAC7_SEL_EXT1_MASK);
+			if (ret)
+				return ret;
+		}
+		ret = regmap_update_bits(priv->map,
+					 RTL8365MB_D_REG_SDS1_MISC0,
+					 RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK,
+					 RTL8365MB_D_PORT_SDS_MODE_DISABLE);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

