Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748647;
	b=5iAp+Mj6a/Qlk4PYfrkq84fL76zXFPHbcaJOd0hyxYaPdh+uC7zvLrCXuUVZw9iIbNVa
	 hf71zLS1DNvkCmQogSpKncmNE7IB1So5wSbrKJRlLUL9dtq+qvwscjgJND1DKAARiAbBW
	 oG3axqwEqdVZlJ5gpeYNrHunLnEEh3fkfNU9LohX298GHCBAQmVoZxpWewkQJeQnYMJ0F
	 ds3to2kUn4j26CdzRdgLgw8w4seSDhZ+jKhzhIbpvhYDQDUDBZ+jBgZwWNUgKH8UV38Uy
	 YKcEQy/j4avBz/+EJe8r5dzr62vF9WUXQJ+hHCgroVIll2U+3j1G391Gf3GNdjlkrnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748647;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=XulaMqhaIJQj8f0Zp29lsV3BUZPbsqDC2lICaWW4GW4=;
	b=TYEU1k1K28Vm5i2hyfFeoYnw+jiPCjC7k2b6FpJxgmTu3/idFivwhSZ5EuqRriCeHmRW
	 mnod9bSZ7Tqnng1dX9/K1FAfXuhlW9oZuD7IJmNMvLbZV9+VMZbB4EbTdnBhMsiSI2qSY
	 Dea+vKpzwEs+tdfTMBG0TPQ0cxUT9kSnoe2jcL4Vl8/dh1lowoyACC7SUwJho03cW4Rti
	 zg/8EhRs4w0RbEQEQF2c1DzdEB6P8DqqYT3o4dOVxeEkixdVxKfqZfhdG0Y4K5xlkZHVI
	 pEngS5ooKvgusjMGovkwujDbM2YvnX65/3JLm75ki3R1y4kNYecyQJ8Engs6m320pyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=arW3gj7q;
	arc=none smtp.remote-ip=66.163.184.147
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA631606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA631606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=arW3gj7q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748646; bh=XulaMqhaIJQj8f0Zp29lsV3BUZPbsqDC2lICaWW4GW4=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=arW3gj7qLrzS50/yboOWLYYk+U/K2l+xdC9IgstEtEfrjEQal4emfA1EVeZFHTyIcGYKXeyUTOMnSww7CziV1KQjRzv6RLrkwK/HObwNmFHYi8+7CtVQllkDcBGp4QaPUkYgUFvchgytVX6MlzMFZA5K3Un8PQfhBL8fRzTZ0frWQBypTKzWQoMrqDqmfV2uqwt5l8BBU7dNO/8II6vMhatRvrzo2g55YxdTmwhYrbT3jxUfqjPzJrWO6Tm662PooB7iQXH4+pWpMCHW9WjQ3/h4iFYK7KWoyBSNnwh2YpQkoC6gdxvohpL77YeGLeSAUSV7Z7Kzfqmw2wKDP2+05w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748646; bh=YCTvHRf+5vIOZErehm/RKYZsVSeq9tJfleU/cXe1dze=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=qyR31RHNCsTvswMvZWQr/lTHQ286COCsS+QXd83ynD5mRXuiW39f+UHNf7IyVd4dPCXqjr6OLl6NL2rGOh0t+ZStt727k8G2PNESt2N9z4ABNBdJfOjjMw/UO96VUE3ZG0NGrhYveusvHnjU1lucX3r6ZO2HY+Bytptx2PB8ooO9zsrQdKn9zfh4peziE5w/B3Rp0ajRehQaIHsO3OLsZBgyL9IhynWWkXAww5DcY0ZgSG2BwpGNX2dKNe7FAadM/QcGPCJG2bWbZhchsYcIyIH/ld5Pb4z/QF2mX075EETrOVhI2/tv/hj6PMtQLH9ToykxQOrUN0yAIxun6LGBGw==
X-YMail-OSG: e8AlyQMVM1lAdu.bZY8NdCM4oAQ1W3MdVSBOBJYNywryU_gnHIClDTi9qnFFdxb
 D5ciVZ0h5QQ26QZ8J85Hdo4v7lp.AH6vjcRHsNa9._PwZ4f7xUsk4sWv6_dvl.eiFexQc4nm5gHM
 ES5lGeffqlkQ6yLd4o2a3tTNAuo2ADBIjrqGQnym.D_WrYM8iadt0WJlKLjB9HrjlwYKAQvKiObR
 dwsWhatC3pZNW9ex..K6WgSn49bSiRT1lfmvIWeXLE7y7x_7ZuLH4yW5S4XTWgOgikpFCtxIWo_9
 cpyGrsaazQRp2RRLnUSZ31oU8IkmSgLIH9YbaQXX6l5nmq69IrBWrWghYnGTT3qDaJA.A0hsiGET
 IofXJmVG6eYo5ClK_GnNhXrWiuEvs8HvSUmgMI8pnO5bCGUOWtoY3NoEHMwC6tg8NJHuun8zkSgJ
 iQ4QzLO0O_qVxb4vg9UwYDa1v3KkYtmot_8JAWtlQrK3atJeGlSeyM9cZCXjbOBMpc1F0yZploo0
 UmV.6_T2nwO1ARfm18fVWSCBkOdwWOiS5jUdqw41VD3NrKwPGIXDCZyHF3kw.re48t.yF35FtFbk
 o2hPohNfet0dGSg6UPjbugfTk5WUCCeEFXdYBzqWm80uo8nSrPa5d_ThcD_Fe3sekGPV_SypyQjj
 OvUxWeBeEID1YXc8Yp4QVdeFmTpDRxUhwrVtIdHElWwikh03o04JmXrPguQZuArBe6XVT00ZzVGY
 gikZHlTP9jl2A2wX6uXgqOH0P40LwarxDlQBFEHXTG7eZ_zH5LptCYppuF57wsrx4Ab14x2SJhsU
 QWgbfXfNaIbAjTlLVOX4.A_bHOACCMUXZz2FXXTA7scEIC0TceuccTX4EzHyFChycLfypNVlUc9E
 kSLApebH1xV7Y7qdBlS5lkaxS6gmH9A_K1kVaueDLu6lsSqrR2IjgTX3X8s2FlIMPI5EuHjJSHdy
 vwNEFaPLj5h1RKh2a7vf5mw.X2bUsHyF_qTLlsB1z4P.uM03cEsvM1WaXnT0YVrDqVgY1gaNvq.j
 K8xBzexxZGeDoaXsptlK1BTa3sUyI87e0yQ_FgMbp0qDNIH5Q7myxyLHMgLfrLyUg196l5bpaZnm
 IAM1h_QPqd0h1Lyh6TDXPxQR3fABhRTTD67iVDqkiz_941myK04qPkuXbFNNmD.Kqy.6HtA6jwFP
 7wAFxRwNoD4IG7xv6zcZlfGHo7Xyi5ssKM5xrMkJvCq1ctnCqKfk5oiMlKyz5Nwz1zJNUOOewYi0
 a4Tm14PZOue2rIKSnOv7NKs3x2S7kZALS1w3MQMav.U.i.opGpsCi8Nty.YdbRdV4XHsCDfPGsIT
 4Ap01qMvM.32idDXvpfZOTJxlrxmjGQCY_.to3tBm3.aIYx.jN5tTEtadXhNGtBidT8nwyq_BneY
 C_ZGXX9CX3QAJHsabnlhoyz7fv15LALcQ90CCg2GO5VrkCI4S726txnKCPgbGw_WxrL5Ngsa.AdD
 Lh7JAGVqxz.jrEDYF6_fDRYQnUsENuGFm.4yOQfNn2sKS38umJPgXwZqPPW6.Q0asQIa3xjRJ4Pw
 JzCEIVgNaRN2S49MwrmftnGULq3GvU6IaFKcrb6yj7ZVNjUZKWYbbdJFB3.1LiX5QPYvWs.ikuf2
 fumS.avw7LN0l0h9QFgksjZBPhUid4ZMvNHRbIlEm16rTjwHNvwgEGHzZoyC4FYJmTMB.Z.7ewjt
 aPFX5.84om3qvEBHFCfuZDc9Dq6qdYJS8mfmKCdTR64Jjwp8ScqpUfzqR5wXkVqNXkWpY54Bxm.v
 W_y5kXWbLYjQCq9fFVVIaxIlUossaSnZjVLu83bzAhy.Kr.XNZF8Nwwl3HY7289fd3GVdb27GYV2
 DcvKlvsLFIQKTJ7Pb6IpLUG.XkoMfIfM3Vj1eTIbT4yE_boo.YenvrgtX78kqUPboq2aMilf55W9
 i8dVJm9mk9WX.CF1C50e1blSgyCKmVkXfKtcGMNGMOjd8NKTDmM6tp44ogAMSIPeWnrqsEIUicKo
 _1a9aolJggWHCP9ORtlVJdojlSAYsk2y2N6RzY1SOR.uSgQPUdiq.G759Jyl9x9T7B02CeqO75yD
 C2Qypm75MVt4wPb5mdweWkU.bCeC4z9kDtPGihaoLtQkO2XuxbDGhx4ReIftrqa7HhvwxOxgHBvj
 FG3.OtCX3gI_QjE65NQ3iWv3jHxOqSX3DChvadNLGjMIsWelasNQTtBj2Jd7cGBNJxQvVWtbzv9A
 .7egkya4cv9s7L8neDkVU1AGiUbbM136pjQgcg.p7wY8K9WMu64XIpFjsOA.ckAAG2hnlwm0Rflm
 BizctBhDbv7oW_d3WsGcxl071hzBz5kc9.Xcd2tm7OQ--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e338d4d3-9105-46f7-812e-f8d4e5447cdd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:30:46 +0000
Received: by hermes--production-ir2-5dd9bf4598-nf4w7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a458d3b81521437e90e34e44d6b70ede;
          Tue, 03 Nov 2026 23:30:40 +0000 (UTC)
Message-ID: <1ca057be-3757-43c5-a9b2-25828e996055@yahoo.com>
Date: Wed, 4 Nov 2026 00:30:37 +0100
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
Subject: [PATCH net-next v8 04/11] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <08611959-c555-46d9-8e7e-20b85d0c4056@yahoo.com>
Content-Language: pl
In-Reply-To: <08611959-c555-46d9-8e7e-20b85d0c4056@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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

If the internal MAC4 block occupies extension 1, do not advertise RGMII
for port 7 in phylink_get_caps(), so the configuration is refused before
any EXT1 register is touched. This mirrors the vendor RTL8367D API, which
returns an error for RGMII on port 7 when UTP port 4 uses the RGMII
interface. The driver logs a warning naming the conflict. When MAC4 does
not own the pins, bind the RGMII/MII pins to MAC7. SerDes 1, which shares
the pins, is always disabled. The TX delay field, the pin mux and the
SerDes 1 disable are all programmed before RGMII is selected, so the
shared pins are never driven by RGMII and SerDes 1 at the same time.

The family D branch is not reachable until the chip table entry is
added in the last patch.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 70 +++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index bed29b4..d8f406c 100644
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
@@ -1261,6 +1281,32 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	if (ret)
 		return ret;
 
+	if (rtl8365mb_is_d(priv) && extint->id == 1) {
+		ret = regmap_update_bits(priv->map,
+					 RTL8365MB_D_REG_EXT_TXC_DLY,
+					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
+		if (ret)
+			return ret;
+
+		/* Bind the RGMII/MII pins to MAC7. MAC4 does not own them:
+		 * RGMII is not advertised otherwise, see
+		 * rtl8365mb_phylink_get_caps().
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
 	ret = regmap_update_bits(
 		priv->map, RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id),
 		RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(extint->id),
@@ -1773,6 +1819,8 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 		rtl8365mb_get_port_extint(ds->priv, port);
 	struct realtek_priv *priv = ds->priv;
 	struct rtl8365mb *mb = priv->chip_data;
+	u32 data;
+	int ret;
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 				   MAC_10 | MAC_100 | MAC_1000FD;
@@ -1802,8 +1850,26 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 	 * which remain unimplemented.
 	 */
 
-	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII)
-		phy_interface_set_rgmii(config->supported_interfaces);
+	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII) {
+		/* On family D the EXT1 pins are shared with MAC4 (UTP port 4).
+		 * If MAC4 owns them, RGMII on this port cannot work.
+		 */
+		if (rtl8365mb_is_d(priv) && extint->id == 1) {
+			ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, &data);
+			if (ret)
+				dev_warn(priv->dev,
+					 "failed to read TOP_CON0, RGMII on port %d disabled: %pe\n",
+					 port, ERR_PTR(ret));
+			else if (data & RTL8365MB_D_MAC4_SEL_EXT1_MASK)
+				dev_warn(priv->dev,
+					 "port %d: EXT1 is owned by MAC4, RGMII disabled\n",
+					 port);
+			else
+				phy_interface_set_rgmii(config->supported_interfaces);
+		} else {
+			phy_interface_set_rgmii(config->supported_interfaces);
+		}
+	}
 
 	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_SGMII &&
 	    mb->sds_supported)
-- 
2.53.0

