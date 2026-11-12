Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504898;
	b=k0Axsqh1kZgrHUf7yjk69ahlY3fQdXL/yWQF/wmHEPpHgsk/Coss3zHgFTaJDZL6qTLV
	 6VCHnFYgi6InmvpfqhouNEzRryyrWaD6udN+Ie+XUxCb9fB7Et8jMMej8rdsuxD/cj+oC
	 rDvBg6AlLupvHMOBl0n5/ecboyQdIHQ77p+vlFPA73sRHkz0gff36fE7hWoxNAuL8K62Y
	 DHA831wO/57jlYwy1BM2ryVpoYm29Q7SEDOWKYUEShrbPxGtpPFXNZX+WJhRw+26eaZJZ
	 TXnv3XzdEIItoEeIDjtAw6i3xSpx9V9AG+jMy2KLr5UGo1Y1hhXLemSlIhFTy9d3+qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504898;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=xZFGCbHHDA930kNhg5JksTPwdJCEfzaDUNyG5sEFjX0=;
	b=rXwGxriUx6WFdkMzOzbSdNFNEHeKu160xryfS00oTlJLBUS5R0uRSmCqRDwFi/HtXohM
	 8/2vTzBHvU/Zz0j+XHuw7qlNhhsh8R0ZqUqqCc72ok3TqHj1NbkUSDZRj7xhIILzY51oU
	 8yqH0PBqmSwD2OQ8mGRnMLrJhmLWNItPs9EIsQpGR92XuI77tvBkYyAq2GJhtpQy9UpKW
	 ic7wX4L620oPzODusKNYHYQP2BpOKkoUVxgIhrEpt3pOCsGnZcY8Y9Nu4kjivV0YBm2We
	 hHIvGdMB/sDdUlyCD9p7cG4K5+Ia8bIs5sKwWE/lzP8RjweSfnh/zOzwFVh4l0ojKRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="C//BfZMA";
	arc=none smtp.remote-ip=66.163.184.147
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D46070EF0
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 986D46070EF0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=C//BfZMA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504896; bh=xZFGCbHHDA930kNhg5JksTPwdJCEfzaDUNyG5sEFjX0=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=C//BfZMAboaS2T1Gwp0TfjzLTs/AdYqIYwQJru5h/lzVAP56/fxbm7jSffseD1NKLmBaUWpMYTIBXuWhM2baVQAy/3Q/GNAPJQuI9ida4zlSP3I3FwO+lO7Xuk1MwVbX8VrshRJswiib1UcS1FA7dGsAbc7+uax/Y7plxLJm2TySNCZL2bwdgBSpIx1pt72oL4grtqTa/vD9fhf4jr4aDxbPB5ROyK/DRp6oeM1t9waKcZ25Mtfxa8Cbj8takoTuo0rURrg90lu2tHH8jHdktnX5Q9m2Q3VCEOdV+FJsxZ+QeG2jMaLhD69aQVzvmPn4ljXf6xfp99Nm1UM/0aha5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504896; bh=FCeqzTR6wDlMbMDVcF+1OPArUTFrARxnMStXoOrbRre=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=rfxVl7sqB9tKnxhd3NNbApiGMQMwuzuCtsqpjtEf7S1xmETM8GNHwpIlOk26dbtmsIkkgCjEAmGb5K1qsbRBkoRkuIIWKhAlbi5qR/5HsldiifGoK/n//LBo98wDSkIwcgwuVjv0tyGtru76LFD1nKjyDJvXhoxAEXxwwGBebWN6qA8b3AUipktFSG5dz9M/O/zKiHrhynxlrMjIIScVsPAxIcdt1S0R4n7wxiLu3gPPPisobVbMlmApWBzkIeAqEKM582nx3proSxIXG6FePu3U7G3hocvCf19bguv+cj5dGi3mpagy9Q+GBo9jbyIPi6ZtBzTE9IXCdXr1h8DnoQ==
X-YMail-OSG: 2HMfmoQVM1msinEeqJHYy6xG_Xt0H3ydSuJF78EE9MzhShODwyFoamYQjlXoR_U
 OfV3V7JuHgWMXk9uQDhJr83e1lqYykWTMz4DfufXQqSLlGtnn0AaKlgO6qoz5ukffhO0sA9yYqHp
 n7lcyXDlZnTdalIcJ0ngdO5NIDGsd5IreBXCctBjSRZOOJ5m2OzAZk_Hoo1v7V88fvveCNDQUPNx
 QDiXqyvxRDiTYYIrQUSpP7kzEqzUDN1SI0ExcNAs2YPspA0O5oppu4o5xHVX4wm3mVTeMruthL9X
 NgbaoEcUqlJdzLW_DrVZpBpyrDDWP3asLbh0_oZCkSPtlw9IIL4DGSuyFedNVKDlPUpmvB.MLTwy
 Z0Dsa22GOk98sC0V.sfp_IzxBkaLrsy3LPnuwVqirIOS2MKEC90.0XgozjMUrm1AscWNfivhBWOK
 Xe5CyLIpfqEUnM1We1H3dAeoV28Lh_BP.fyfvceMneL4yO2Q4vE_9_3CcQGYTxruQvqu1Qb5iNOM
 .gNslezZLDZx.UGGNdxcu6HsNe2o_XLykP4Q.7pTbxWBMCxjxZJvphinZZS.jelgtlg_XkG.1xWK
 l9hIl_FEzuw97KEpCPJ8eS8S2VsCqJv23TyShVflsqxbVSQ5cDjVwTdmRZnptQlpYpXLbgyDMgrm
 kSVjE6iI0diAZIGRNw0gI8xJpiyI7pPSyLAZAlXoHm1HFdrqs.9eikRy5cbpNCRIhN6Bv8RVQrTo
 dOsy0uFHJqB3piFPQCCbHUbHzFz._1afBwJOEoHaQsFf.XH6Ddh4KfuY3SgdxlEcq.jcYgh9XZ3Y
 ZiMvRxK2cUCJ_rNED6ZF48CCLWSBLawyT_rbIp6yrHPcliKGaMnyZ_h6KIjWYOpZ79_Lhd6PcbYn
 n8rwqR4bLYbT54BrwhBMse7sqTcHMdGjaDadtjc107VYbusvzHhsnrDSg2EF5mLbZWQRXgP84pAe
 hAwHaz_ET6f1PZD7fGiGvxUew1T2_OOf4hf1lpEOYVOMG8syyPykunoU4it8h6Tin8p246lfd8qX
 5WAdX.d1WLBv4iiL5Cu4_A3S4YXt2eqG.vwmajPrwAxuQ0Rv1JjRpUP2RA16jmqzLlgTjfUekHd_
 m7V1wdrQyu0FaCXQTSDE2fWH68GDyGP5QhIqnhGzOTT7TilS.2tReuhoVDNmcUbEOikfyBJVukM5
 vVlxrzFEHeHTco4aAZ0A4_tHaUHDhR8z4c4_JElbB1m8N_L3kOVJ2d9Mpg8B7LqnQbNO34elJiv5
 CjkgYYHEEBL9wHNmjdOMxOSoaAdttSmpOYvrpZk6M2ZeYiB9S0kgUPSq90DgRjH1ufjPV7lnP4nF
 j2Fh78lP2TqRSyprzxQNy39PMUjTCttaeal1su0PuVLEwlo4IuGALqEY6.EFh3l2Ac05GcgItvQe
 sGTXGHYDV4dUSW0zsJwERN2HkmuC7fO9nFsmFz3ZoccgUMNQtmNKUA5Iv1J15a1ET62HwA1wtm9A
 aDEP0R4XNDHGWCj.xALF07dZsGgyi3smOKXHbvoLMzFFgrgm8wWXYLN_mNwD_D3s..HJsCmB3_qm
 oGl0_w6kYMFIfwSwdzmCPAd0oTo.JFa_ER.pZHDOEIv34.CLwLxW9BMQTrrhZzzIMd.sKfbVJsnA
 jU18dPYlIyZMaKHd.miucu3RiUjgTojjddu6.SeAGABN4XNM1oovbQtMDAhELnT0mAz25hVkN20w
 2g8GhqY8CDfQ1MRISABBNpUmYnvMHYO1DW4XrbJunfasQb0qOf5ZE76bz.8eQmUZUDmNia4PGRF7
 XGzZv7BAjcp.Uefb8tfwlFbh.9E9VBM8MaCKaWEreFrPO0j5PncTrfqSuAGjD9XFHZN_0jC..uPK
 0kxTSTeCfY6T0fSUbw7CFfB40.2bQpEJ42QIvbkCLtNLez54y0J19G0iaF4jLwKtrLlWXFjFAYAp
 aF9S4ysg0oJkE9NWXAN4fcItS4fL.B2DcJmHyHSzdcIlq9D0AEz1bltILAKjrcUfmazWCYHy1_St
 HTvkZNxPWdCgNZm_2_q00iNgnWOirUWhtMKrk0f53D.IwoV5YgG2y_mhVAqMYQrBdXmtj6Mr27kp
 HcsZyqXIMMR8glRZDkOUdFnEY4Iq6yqg5Yucp5u9Ooi2oy6KLO6vNZgRPISO.D.9kZB2U3ronulw
 DCTpEHLE6RxnkWAYWJsxdC5pTIVDepxuG89NWx_N6sBdgasRasD8r1QArfJnfHUytD_vtIWApyWP
 wq4D8.2yZW0vgGk3GThPRJnGJk0PqKrAq44W2p.k3ECQkx542LwHs9BawkkUmBZtJLUVidvmmryp
 s86c4bj1oeYsruzAr_JYvM51PjD91xWu5DEqCHy5a
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: fa8f8e52-4c3a-47c2-a319-b4d621ea2390
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:34:56 +0000
Received: by hermes--production-ir2-5dd9bf4598-9c455 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6beab65f14dff0f33ea26c2aa480fea4;
          Thu, 12 Nov 2026 17:34:51 +0000 (UTC)
Message-ID: <ccf26274-13cb-432b-b8ed-e016abd2020e@yahoo.com>
Date: Thu, 12 Nov 2026 18:34:49 +0100
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
Subject: [PATCH net-next v10 04/12] net: dsa: realtek: rtl8365mb: set speed
 for family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
References: <d9da17af-f49e-4878-a8dd-59a8919e6930@yahoo.com>
Content-Language: pl
In-Reply-To: <d9da17af-f49e-4878-a8dd-59a8919e6930@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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

Add the family D implementation as rtl8365mb_d_ext_config_forcemode().
The shared code reaches it through the ext_config_forcemode pointer in
struct rtl8365mb_family_info, so it needs no is_d() check.

Nothing points to it until the family D info is added together with the
chip table entry in the last patch. Until then it is not static and is
declared in rtl8365mb.h, so that the build does not warn about an unused
function.

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb.h      |   4 +
 drivers/net/dsa/realtek/rtl8365mb_main.c | 110 +++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.h b/drivers/net/dsa/realtek/rtl8365mb.h
index 664bddb..3d607bd 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.h
+++ b/drivers/net/dsa/realtek/rtl8365mb.h
@@ -24,6 +24,10 @@ struct rtl8365mb_family_info {
 const struct rtl8365mb_family_info *
 rtl8365mb_get_family_info(struct realtek_priv *priv);
 
+int rtl8365mb_d_ext_config_forcemode(struct realtek_priv *priv, int port,
+				     bool link, int speed, int duplex,
+				     bool tx_pause, bool rx_pause);
+
 static inline bool rtl8365mb_is_d(struct realtek_priv *priv)
 {
 	return rtl8365mb_get_family_info(priv)->family == RTL8365MB_FAMILY_D;
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index ef75dc2..27a6917 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -346,6 +346,8 @@
 #define RTL8365MB_PORT_SPEED_10M	0
 #define RTL8365MB_PORT_SPEED_100M	1
 #define RTL8365MB_PORT_SPEED_1000M	2
+#define RTL8365MB_D_PORT_SPEED_2500M	5
+#define RTL8365MB_D_PORT_SPEED_MSB_MASK	BIT(2)
 
 /* External interface force configuration registers 0~2 */
 #define RTL8365MB_C_DIGITAL_INTERFACE_FORCE_REG0		0x1310 /* EXT0 */
@@ -364,6 +366,26 @@
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK		BIT(2)
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK		GENMASK(1, 0)
 
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
+
 /* CPU port mask register - controls which ports are treated as CPU ports */
 #define RTL8365MB_CPU_PORT_MASK_REG	0x1219
 #define   RTL8365MB_CPU_PORT_MASK_MASK	RTL8365MB_PORT_MASK
@@ -1713,6 +1735,94 @@ static int rtl8365mb_c_ext_config_forcemode(struct realtek_priv *priv, int port,
 	return 0;
 }
 
+int rtl8365mb_d_ext_config_forcemode(struct realtek_priv *priv, int port,
+				     bool link, int speed, int duplex,
+				     bool tx_pause, bool rx_pause)
+{
+	const struct rtl8365mb_extint *extint =
+		rtl8365mb_get_port_extint(priv, port);
+	u32 r_tx_pause;
+	u32 r_rx_pause;
+	u32 r_duplex;
+	u32 r_speed;
+	u32 r_link;
+	int val;
+	int ret;
+
+	if (!extint)
+		return -ENODEV;
+
+	if (link) {
+		/* Force the link up with the desired configuration */
+		r_link = 1;
+		r_rx_pause = rx_pause ? 1 : 0;
+		r_tx_pause = tx_pause ? 1 : 0;
+
+		if (speed == SPEED_2500) {
+			r_speed = RTL8365MB_D_PORT_SPEED_2500M;
+		} else if (speed == SPEED_1000) {
+			r_speed = RTL8365MB_PORT_SPEED_1000M;
+		} else if (speed == SPEED_100) {
+			r_speed = RTL8365MB_PORT_SPEED_100M;
+		} else if (speed == SPEED_10) {
+			r_speed = RTL8365MB_PORT_SPEED_10M;
+		} else {
+			dev_err(priv->dev, "unsupported port speed %s\n",
+				phy_speed_to_str(speed));
+			return -EINVAL;
+		}
+
+		if (duplex == DUPLEX_FULL) {
+			r_duplex = 1;
+		} else if (duplex == DUPLEX_HALF) {
+			r_duplex = 0;
+		} else {
+			dev_err(priv->dev, "unsupported duplex %s\n",
+				phy_duplex_to_str(duplex));
+			return -EINVAL;
+		}
+	} else {
+		/* Force the link down and reset any programmed configuration */
+		r_link = 0;
+		r_tx_pause = 0;
+		r_rx_pause = 0;
+		r_speed = 0;
+		r_duplex = 0;
+	}
+
+	val = FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK,
+			 r_tx_pause) |
+	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_RXPAUSE_MASK,
+			 r_rx_pause) |
+	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK, r_link) |
+	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK,
+			 r_duplex) |
+	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK,
+			 r_speed &
+			 RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK);
+
+	/* Speed is 3 bits on family D: bits[1:0] go into FORCE_SPEED,
+	 * bit[2] goes into FORCE_SPEED2 (register bit 12); only 2500M
+	 * sets it. Register bit 13 is reserved.
+	 */
+	val |= FIELD_PREP(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_SPEED2_MASK,
+			  FIELD_GET(RTL8365MB_D_PORT_SPEED_MSB_MASK,
+				    r_speed));
+	ret = regmap_write(priv->map,
+			   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG(port),
+			   val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->map,
+			   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_EN(port),
+			   RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_ALL_MASK);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 				       struct phylink_config *config)
 {
-- 
2.53.0

