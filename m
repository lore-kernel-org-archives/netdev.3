Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C7412BF8
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406170; cv=none; b=Fh0rKN1lEXI0zLBBOCkfvCyKYGTMdpnKHFpvYUgP7Go1q9ZnrnYKKBP6LUXgLwbZpvM2jfUO7sEvqpWPRoe7+eEhwqt1PI3gY7AqVqq2xiNg0cw8lr/go+xkQZZGRZ8Q6NvpsVz6iLEGlsOVTrMkPTBs7C5+gjq5upgcvHB8LqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406170; c=relaxed/simple;
	bh=rxm4kNS/vSXQmw2rlLcYYDA/aMHsymbtXCorzD1cNSE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=moq4R/6C3wJ7OEfrnKwux5q6yrETRdhGI2v3TdKT0jiTAP/Pq+jm4hAcYMkIYcJ3dGBQwi927nvtKZ6fu411IH+QMm18gfXOdLKILyaGo2aguElGHqKo94ipCQNgmBaGfNJePQG0Lm7avXX9KTQikq53ZvfGohpPWWdiPZSljRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Y9bKUrPE; arc=none smtp.client-ip=66.163.190.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Y9bKUrPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406168; bh=RbAzeT1WsRn0PMFyu28kb5JmbFrF/tzavm1qIyi5cr4=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Y9bKUrPEeoO3x4Eolgw+XjiH+awFf67BK3MQEwO0vymzSF7b0p1SPISM6jX6TcrABjXgSQG5dIrXNHYActXn1il2BQTIo88UHidr+2sY/cebOYAHKTi4ZY90WHsBFR/QfiZR01CXkGRiSDPlcqJLAJ1T1gzMzg7l8bwtGOJTd0XNtiKHScjKX1zBjNoaKNdDJCMAlPU+jYQKdlgQVDidZQSbPOy5VzDk25KM8TKHheqoRDvvv+k2wOPjK1eZ0vITIlMKMdCKvWZYxZ/8hayrftw70XYefSInEKFEyJ2oHShxOW0zUTn+ILjD9uZhqSO/j8ct76l0ktIxI+2gjfHyFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406168; bh=CdRhk2mexztceQN8+EYmkOsUUNXtOwaibveHjsIjTn0=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Tk2lGQZd8oiemRDtdclMV9QDoyzIHeQfpJlVyVlqODxvLAbgigQJTMwvTP02gMrCw5/KlmSsC9QO8jMYb99Jwq5mCThbvEYFZiYxzM6Cji4Iwr23Hr9CIlP+7IkKjckWNLWI8+DeqGGtaUSvjOE3nBg//rRkWd1W4CHGZscrFe09wb9UMnRAyWmP/fA97jqOE4OsVijKpCzpknrwrROCYdlwiYUK1uKo6iTenResaGV0KocVop75w6bIfO4/sv7Aw8Y5rHXN6Xvh0BXxPBLRbL1d+1ywZUfqV59yRsis8PpTULbQaIkGVaCowz6bcxXyL0ap+ewsj8+BHBZ0Cm0p/Q==
X-YMail-OSG: VlgYR8kVM1nsaMDIz486865bRKEGJxC7GUYE8R5FElt2u9UCXonC3ZkfLML0ZBh
 c2EypCmNTkv20uSThtRXBtHeUc_USeANWOFGfGQkN6EB6bw8dSTJK4ylzkOQ_aW_i38tFGiPyn2s
 BlQXgWQKTdOEKZ4kW.Xgi6Nk2nLmrJZgfEtU_Wib3pdqZUQ.y.6OKktIw5.68HOtQYLVt2VrnCkN
 5hT9kFCmq_zfUBWK8v8yxfkjO9jEVHqMB76DbYb4mT2Yo.EQpesAYk1Fc7qo9eZT7ovo97MC9s_Y
 J8nkYaIuRbkZUGjAGZXg6dEgz.g9cHRnXZpHsO1Sj2D_GDYlVxlpIGeKLk8ox0gXAXHY8t9VWLzO
 B96oY0ffFTuWvFygioHeYsUItPLJDrn2O9sNXGwpKPjiXISZs.Ye2QyA9HlAbjZpYGYkyCse9Glx
 HjGzlzKpbVmPMmA.nxm45dgBm9VyHXpM8fTKQImHd4nM_zcSbyZ1w13q0pQYK2YJkNrNRxj2i0iS
 RtBDvODnaQmdl8AQ0lVkg5n48hT5do.QIFe16Z7IAbzC8wL_VtsbYlP0qh7f79PCE7IS.Rm5Hu.K
 kiK25QvVxfC7yw9D3WqVwsZwwCnpJ03TIr0Ek349Y9crP9jHY1SR.zDnj8gYsPteZIQbdheoOMgC
 jcOaaYJIchG97RwtdDJlXtsvFIFqdzWAbpJjC0VbBeSbD_Kt7DzzJoMxm3jwU6YgVxSGQWebQGgh
 BPZewzlyEaITXfVf0t_YPsrK6Lm44Fh.f2E80B72XO2hxRcUsK3fzCwHoQbSEKZs30nnlShlNIqy
 0qdpyn_.BqIxLZA9VNEbK5iN0tRzceQq.NKUCFL3qtW.i1OvEUVK7XFTROt479Ekk.tv0dBEA5bT
 SrQqUR2AGEz8Z9SjR_AIgl1nzWnwJwzFZ03ROPVR8KKj8uYkFr9Dhxwd2oHvR3MvIZo.0bM6lz.y
 fljh_NdoOuFH.LPK1.gyJa8XuqEbLkTxh79uf73Z6gVVTwnFfLH3yTscsgFBecxHdWFHE.dFn7Zj
 ARTrE2DejVm.cSF0D8xgxs7Ulx2G1II49Xx949TDh8tlfZgOeS2u_IGbNsY58pwQ_u1ksbL3Zrlv
 WrsLmID0fHBhFDWD_VE_yVB1aOiLAko0QodMVw_LTVCCmuszLnOFVgqZb7oQkXcISrPUl_x8YonG
 Wi0pxBTTDcoRwJ.RNUaWuVFtVflIjpyJ1KDVpYfCwh1AnzhvwyoVp8pXtcWFrgTyl_br_iOsZHky
 0YCIVrBjl_XD9vkpr2XPCOzy1mNk_ApgKRvG9U31pzczSWbimV6avyKWWj2Co46u8p5OiTzEMQfs
 TxlKZ8F81UHVttgVOLUsdGWxzq0G.g79hLx7KY9kj28HlaJxe4Z9AGmQ9k3oUzDlRvS6Pb5Ioi9Y
 8E2KxBcTpG0SKhet5RtYYWwQNlYhmezjl1DbRALZajN3vhaKaHW0zdf1cMWgVaj8_SSXolyboLJA
 znX2Q7Mrt9H5RDDBYcOgHsqbefpjibq91ou_gVu0He12FRTPJMo2hTh69HOkRFk17S0.pE4yOmIA
 mToJnRRVaKhe07er9W1tPOTh3t2vSgoO8ar_6HNCAmCDniQA.iiBYvqoQQ96ZeX2qMZnNG2oHICO
 VZqDMm6ZOErYmLOtaI_BEmwipyGb7Gqn6ETC9T2fUkPXBo64__9tl6ZQLkjmJkHpCY5pOUiB.dnm
 CnhscYNdPr4lcSnC4WeoTXfjDOAyVUD861UlwAaLPDjEY_xu679a4FkGDyH0tfNvtzo_jjRzNfyd
 C0oBOquA4HI0xsmQwBo6JD2.M5Xc50xL5TgG9H5xuHrMDc0caYfS2k5gAlo4D5lx5_vArwsB5pWq
 BbL1C_R9jKcYmLCfGlNhsGwTwEXT1FiZ24Jc9yRFGF7dyUgdchr8bzmU4q6S.2bd2mRTs7ceipjq
 iuLJHXNxoAw.KBLnutTPlaKqGUlX9FJrnevtmwmwqrbsfoVLGZD6vrzDlvSpJeij0sK9Ab5igez2
 NIdKwf3l8c1QvTt5ciM8sCYuj0xtT3kg5AeT9rClDZ2SEPd2OgDUYsW0sDguQNMS3tP9lElHCaDY
 sc0.89V2UR1T2e0VVp4gWg2kieyj.84DhksbVXIED5tPnxbyBDlFrkNsKO.j0QEl7_BveD6JU52s
 .aJZfNOpg0CG_v4NCC51DrbHPMofcyoF5ehB9jwZmt0KQKRlvPs_rurlbDlLOhEuhU5la.qbzh24
 ig6CVDDSfDMH.sh1GwHNsUfYDiDUC5VhedjXGUqfvWn95YDvpQLX7JqVgsZ8O9pTKYYfUHnhbMZU
 jc5.UMrSK.HoyzeeEaLloSFwlLsI2jz_zsqDksCY_
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9082bdfe-39c0-4c99-9f53-01ee97ff7357
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Oct 2026 20:49:28 +0000
Received: by hermes--production-ir2-5dd9bf4598-vvk7z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e8db9e01f4a3ba1dbe1cee89d9a5d5f1;
          Wed, 07 Oct 2026 20:39:06 +0000 (UTC)
Message-ID: <dd78e00b-c161-4915-a917-3b5694139621@yahoo.com>
Date: Wed, 7 Oct 2026 22:39:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/8] net: dsa: realtek: rtl8365mb: set RGMII mode for
 family D
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

Forcing RGMII mode on extension interface 1 within family D silicon
demands an alternative muxing and clock delay path. The driver needs
to explicitly reset the hardware TX clock delay line
(EXT1_RGMII_TX_DLY) and evaluate the top-level configuration register
mux. If the internal MAC4 block is not occupying extension 1, the
RGMII/MII pin mux matrix must be bound to MAC7, disabling the
conflicting SerDes 1 lane in the process.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 910e868..c638c20 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -334,6 +334,12 @@
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
@@ -459,6 +465,15 @@
 #define   RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK		GENMASK(5, 4)
 #define   RTL8365MB_PORT_MISC_CFG_CONGESTION_SUSTAIN_TIME_MASK	GENMASK(3, 0)
 
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
@@ -1208,6 +1223,7 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	struct dsa_port *dp;
 	int tx_delay = 0;
 	int rx_delay = 0;
+	u32 data;
 	u32 val;
 	int ret;
 
@@ -1277,6 +1293,32 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	if (ret)
 		return ret;
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D && extint->id == 1) {
+		ret = regmap_update_bits(priv->map,
+					 RTL8365MB_D_REG_EXT_TXC_DLY,
+					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
+		if (ret)
+			return ret;
+		/* Configure RGMII/MII mux to port 7 if UTP_PORT4 is not RGMII mode */
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

