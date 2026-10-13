Received: from sonic317-34.consmr.mail.ne1.yahoo.com (sonic317-34.consmr.mail.ne1.yahoo.com [66.163.184.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2439A806
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881520; cv=none; b=SAglamrfMplDIuT4sFtgIAiiKBcJTNw25TMuUQNQdW05XNvktKEHWnlFA9jfeoVZtdlumGju5fONJ/7wA8lJ72ZdOSPCdbwQ6rdWrAsGjB6bWw0UC1Xr5fRbOdUw/2wL+3g9d3YSqHLNIvS+kBsPvIdEeqFCEsd9t9XmF97f1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881520; c=relaxed/simple;
	bh=1bYHZyiJ0zELT2Nki87vopPgbeVoi4dW4pdUVP4vBxs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=kZ3uMyMOTCFIDKmpYtwareWm2VFYz/643jKgIJ3JXjN45CAyXorUQiNRMZMVUfTTdN6ZiNy0cyvd/7vIsJFQEEyxNhEWT0DxFbG+FDv3CoLMVIOg86W43HCaH4Cr8dtbF8+aRHjoh+/wbIOvp/53gb2EcyvEPWnyvkrXJKbyxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WXN4XIPI; arc=none smtp.client-ip=66.163.184.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WXN4XIPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881518; bh=Vll+PLf6ziZvGx4vAGbRFHwoM3h8NgDUU80oS4JWkWE=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=WXN4XIPI5ahPIs5ih5VvHtCzFNXxAIGzlt4xAO/4i8vJafEE0d99mKNhe5iTYISM0Jf4X9gz3o/UYzzUaCEpv2xlu4JQpczoJn0yu1viKQ0ggxGYAf1V2ef1umC7PZrKfym6lW+wLb8SlGb4P0QjsSV8s+iumQ+9618q+vLfz3EqLZKc3HWhKT+81Kf/gjveYHalLs+9rzbzKtHUzmIGZtdBua4l5GoCIXHpQSmRKt14MBxz1d3znKY/sSFD9uYk0k6yJls3uqgLPReOsS0UW0gM1PSTzSe1OSV42Dm1K4rTuVq8qQfU+4CcNH4JX/dGJbY+9EJhPL6o7cQHdj8M4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881518; bh=spRmjAXYMUFoTETziD8el1oP/dpuWW3G/EbddFw1mh1=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=O6X6PLWDFxVDqyz94HbsdjQpVZ6xSCdKqBwHjJXvzB2Q8Z4JTxTwOX3OVcaOOK0Mk9BA36VRtpp6QNbxVJhQXqwAGLJyBev90wIeRypEkjGoX2H1EirjbRPrAvq3E/AImPUMxMKDvgDpuNuJFBZo2KvmB8POhHMy9Mdg2IxeqGkFK6krE18+zq96sq3p6J0JtZVGsyT+VWRxtFP6frndTj8EjlJglAF7cGHtU0aQH7nPAUWEkQ43YzousZzGUlTLvt3FMiVjl8H2J6G56btpwyd3bAuDPDJ7q+h9rjHRrxT70qa0+AKuMv1IiQJWLXDZUd8fV8ak45OO0ShoSyj6eA==
X-YMail-OSG: L6EYm58VM1lLuLZqFVBnk8SMCcBDemz20zFTMLKORPmxSor.c9r654DgfxEMjiQ
 w5o9u3lubyIDnAubMmO5iNb39SV.vTQnLiMhHvL7jiZIogKt77ivLQ8uKSCoB8wlqLgLDmSSbHjV
 _IfCQTzEz0qqJMTjXqLt6dtAskj7SX1AyqL4MXzJ0EfkfahDjbduAYWt0I5MzQrA9.oKVpsRMkUQ
 81wSyFnVwHuBBfG_PwpPW_YgkLeXfSLuABaMhC9g8EwlKKKP5dC9_53nH.xWBXrVbr8ecVDiy6mj
 .gtPAjz20BMc6Pgksmkr9CxcLYOBNEDhj4iJwkr63IpZJIYoaJYGTjE5wWGIRHrzftvBamdb9SAF
 5IxsMizt4OX8hMAWs22o9o6xjwg5Slm3ma2QMEx99r292Eiqq9w6ZwmLZadMDsC9hMXV9.w6sv2f
 XGvbu2JNNcqSz8DOwCuTM4agAzXArYSY13kPmoRPzS36sBF5wVOlJekpbmrpWPmI0qzYZB2BP3ky
 HVOFNbwWodDDTPCs5Q26Xpgk42P9EX9KV_K2MU._k7cJwPnxR5iEzACM3llOnyuPM_Qbl4CrXEJ.
 o64qejp2PaknJmNFsify3OP6SVa7mipyPD.blFD8TcYGJRs6OuV_ZHFJBbXP_iIS4a8cGu0ymdac
 ljs5PCZjf3PT3EjosRAaUVXlBBFiwzdnnsQGqnQ7adrD9PVXqq4aOosq6tixl07aiAlW_wTD5Cot
 r2qqJQBFelmtTb.Cd9r1de_8PTyBq7xZil5hCatxmvKmD4mOkFFB3Iu.BCHD1nlP_8mz2GWb6_yq
 0lgEtia9q2NfuZAhT7onlTEhL6RzqwX.2A5fmfgcMI20.0xMxfRzQWh.Qu8j_A4vR49G6Z7mEwV_
 mPYXd8FYynMmIS1Kv89XY_HLIccGQTWC53pAGO6KIcZJZ4bZniHZDpbS83I6suwWi9Z.tAKpQRlK
 oDzL_X7f_iu2_ewytBG7DNIvOfLbGmH8J0blDNn5ZRSYOzOH0Z48fX_i0u7_QIwwaVWzwBapdVxP
 ff4kKs2y.jweVE5voGd6snsAXAABF1p7PYzO8pnADZkXDYju1wRDA7ZayffTqOHxtXsGnrf1VODq
 1D.bSrAbx0afd8L6XjnOXsFSbxFuAskDBfgmlZBZQC7hYF2rhighEEn_VftTKfLvWxf_6p3HOjVs
 VAI_UkqYEAGNoiyk92.zwiokoepQpoNa.DCNLgM5VnDBnewHJsuviBcL4Gk_8PwqwlXGjqMEUh5y
 GvogLX3KJ2nQ4B.tbtJmtJM2_kMbRKhnsJXtd7aHGQwzkIA7DUbpJfXT7YfqzNvbp4qFXgiVRjsK
 cFP8JPPDMRzJ4DRZNmayqHjaWFYt3DHft26UXD0OIA0UbGy.RpZ71DG1uJAXVnuv74zipp02fqqf
 5uDwy6nlcavKzPXOdnecXs6dzSgGPxPHX_f2qAca3L.6BlZqt7H8nedHCfLKYjqM.Z_9Ba8HsexN
 Cnl_gsgY.OJqh4eYODUa2DMe84bSpGiKinGSiWdMLDOPeKaIycgSadQIFF1n3zIAyMdHDMn59MEY
 L8exjbW5OTb0inhJ2lID9ywQEPphP3b3q2YflFZ1FrrMg4S8BvSFAQkDWovT244buE8QYEzM2NAr
 bM6jBOQ1LFCgOwlCKAcd2.mSFMcbDZZAU_67NqJ48PoqZQdk77g07Oa8U4pL06ZAokc7CwXb3zBw
 9NKFwiUTUpn9bTZc3trNUTGmFhTbnTXKOixJg.CT9GJgJjtpKfUmudm3MgV61aDwbpZv4958NT0D
 5t6TMIQ5O8OHEQ7CTldtX_NTISN7ERjQ2KWfTufzphrNcBNcgYFtZ8pLQmF5HNB7XsbhwYhqyrse
 YCp8UdLWqSE3jkag9WAn4IrYrHiKYci0M2D51XLRjkHMR0orddE_vLzeXtGjkiGmoYh5sFceMHqS
 f.ePi0dVntm30PiS7zGRpBZV1NrhcuN7ebk9q74DJh.vTR2fyLYvV0XzWvvJlNFYa6FvuYMmeKYF
 SKYp.6ygpJwMMlZln_3G2wl.NrHf6NPvKundJEpnpYNfFrkZgPeuWpr.KpLt9fFtxjPHCLW9iFDW
 TOETYNVMZ7_JqRiaoltuxIE3N7r6qDzuIy6NiEDFZ0q8uWOA3h5.Da1JwAWcv1ZrpDAovpEVmCUV
 fc6zHHpxIjRlFQOoWUPrc2ptJWQ6MvGa7hi.h_4dsD14999zjRcSxIbEpNGX5woKDDMbpNJlnql_
 mF4h.CmK0aBABMr78AbfCubP8uWGhW7ExlBB8yT8U3j9qeQWnX312NDFNNHeYuZzz3__dZkYUuzp
 HkoVLK2RA9Kk-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: cab9ce54-e9bd-40d0-bd3b-07ab04d29e6a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:51:58 +0000
Received: by hermes--production-ir2-5dd9bf4598-rr7cw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7f1979d776997360b77045a1fff39e5e;
          Tue, 13 Oct 2026 08:41:38 +0000 (UTC)
Message-ID: <3e67227c-9427-4c0c-964e-b6e72d906f13@yahoo.com>
Date: Tue, 13 Oct 2026 10:41:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v5 4/9] net: dsa: realtek: rtl8365mb: set RGMII mode
 for family D
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

If the internal MAC4 block occupies extension 1, refuse the RGMII
configuration with -EBUSY before any EXT1 register is touched.
Otherwise bind the RGMII/MII pins to MAC7. SerDes 1, which shares the
pins, is always disabled.

The family D branch is not reachable until the chip table entry is
added in the last patch.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 2dabc4d..ff9d9d1 100644
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
@@ -1201,12 +1221,26 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	struct dsa_port *dp;
 	int tx_delay = 0;
 	int rx_delay = 0;
+	u32 data;
 	u32 val;
 	int ret;
 
 	if (!extint)
 		return -ENODEV;
 
+	/* On family D the EXT1 pins are shared with MAC4 (UTP port 4). If
+	 * MAC4 owns them, RGMII on this port cannot work, so do not touch
+	 * any EXT1 register.
+	 */
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
+	    extint->id == 1) {
+		ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, &data);
+		if (ret)
+			return ret;
+		if (data & RTL8365MB_D_MAC4_SEL_EXT1_MASK)
+			return -EBUSY;
+	}
+
 	dp = dsa_to_port(ds, port);
 	dn = dp->dn;
 
@@ -1270,6 +1304,32 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	if (ret)
 		return ret;
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
+	    extint->id == 1) {
+		ret = regmap_update_bits(priv->map,
+					 RTL8365MB_D_REG_EXT_TXC_DLY,
+					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
+		if (ret)
+			return ret;
+
+		/* Bind the RGMII/MII pins to MAC7; MAC4 does not own them,
+		 * see the check at the top of the function.
+		 */
+		ret = regmap_update_bits(priv->map,
+					 RTL8365MB_D_REG_TOP_CON0,
+					 RTL8365MB_D_MAC7_SEL_EXT1_MASK,
+					 RTL8365MB_D_MAC7_SEL_EXT1_MASK);
+		if (ret)
+			return ret;
+
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

