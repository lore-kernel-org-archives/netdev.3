Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.191.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125318;
	b=pNy9r+MAXyE89d4sfRDLWmW5RTEBVbkXICXayDLXIF68BCQq5gL6K8cYkem/a877hHQR
	 cjo1SmOq+gZ+0V+A3irk6dZ00FIKnvYHyuzG5T30NdzSdDb+uKv0OuuqlX0AeWHsqvfEg
	 dnrTvw481v+qib+VbkOJx+2UG2VogVAQ6m8cZLjErQn62JKmJze/VK/PW5PzxVBXD1zpi
	 kkOO9WMMOxs9QlB7d1V7FN+mXwkqvPlaHzeWkJj+3t+4crj+JNpnaUEhOaTt5e9oEKo5P
	 Bjp5mx/A+R5gnHMxh2o9OKFVdKlZXGb8H0K0nGx+gI+HbcnDyjF16dL1GPO6oNDcnyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125318;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=Dbogl0LaH+J1t3ivrJNvjvl2qFkQi7zEdSVjxYvpF2E=;
	b=g3dfFl4sGhdG9+JB5s7lCwH+8BJ92Ta0ccWjvm5hCBybhbxjX3WfESuR7sthjEMnPqCy
	 MAhOndIdwWiegL/PD62eRV6x9ZKnUqGLkL+umqxtW8MgiEUtP+TvS0Fd8rMgXYpNSTZdf
	 ckwGh1UOjFaNtmg+Oj3jY86q+TwwpMpn48WIVb/DLJ2yJIGF1Z6OmWuVRGzDaGR1Si7/g
	 r9jn0vy0+rWXHx43BkdQDMrT1Meh6JVattP0YHFQBp8LAcNa4+5Ra63pPsXXACSY9YrjE
	 7cDb6xeELfsDXBT/D6YCxhNZEeNxTdPBO0bwgfxx57wOmguDMAuU4OEEyKhadrZzvLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=kjWor1Uo;
	arc=none smtp.remote-ip=66.163.191.146
Received: from sonic304-20.consmr.mail.ne1.yahoo.com (sonic304-20.consmr.mail.ne1.yahoo.com [66.163.191.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816A606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4816A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=kjWor1Uo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125317; bh=Dbogl0LaH+J1t3ivrJNvjvl2qFkQi7zEdSVjxYvpF2E=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=kjWor1Uo6i+29HhwVNCElBqtwvyz0jk3EC98ab3TqdcWMS31r8sfajoPcugFjgC4bOAnfk2Gwz8/Rlmkzd2Zl9kAl1SdWOCmQcGxLUNOjHdsTx5xJTL9KRXglBmAkBYiGQHRRC8bLB8f+LS6tsAbDBzXQhaRp+DwxqdlqqFp0h28c9H8EJ8YsoP67kDqx3T0jEhBKIjgBZOWy0jg18Q7prG8J8jxvEfhxezRkp8y+TZHGmUJba6ASZPKuC8GYPMFOk+0LanhOFoat7VFydBP8kwBzxkehZCeptQeY7YUDnGYp0TxOIEI1V1tdztU0rfH9o9BLyMEKl3lgq08OhlnYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125317; bh=ovAqdvffuYI2hQtLJBlUAFoP9AiPmjozOlS4ByNU4o3=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=QigTLM5RhdbYkrwAHrYvthxUaGrAamG6h4t/LBqWFTeyU24ZTMH6kftNpToNSVra6m1QyKe4DSNWPZVkUfHOVJ6b0p23tgikrljYvt52E88kXj8T9iPZFHGS/Um68XRohCJQON9Dd1Fs0MqClLCjiCSFQRv0yibKdTc9CeYPrm7+Iza/iBqoCGusv5oaa8AAOwOSIJZtOu2cYQXoJVv6+1Di/QyzS9gi+rcLVoYc5PrNWvSQO1Tc/9d765P6rrUieX7Y6192mPzeB10z6zWmNXPGHZeCmGIu1QpD4/LSlttkzkYg8bx3fGUq0/544cCaTcZ2AuSvCkmAFyvEUUFTGw==
X-YMail-OSG: gUyJ4DoVM1m1BGcyRk0JJH8w9h.xJX2m85Kjy7VJ_8bXc9j_iNPRUKzgg0Tpjfj
 jvkz8srxxZkAHER1VSrNal8T6l4rqIR8aiWJJ.QHrsIUSJuCslMQCwXob_0S5UWK8sZSj3R5wMjU
 RAeYEURiqQV8LCCDEUTxCmJOKUzbdsoidUn4PDD5E959xPPdc.dbWDU5SwNun2T0S9bZg2osgmQI
 xDDZmkuWHk5v.eWOd7C9.jgNn5d49AOMmqxUeKjyRT_5PpNEepgzg54VmX2myFVcRAr76MeNdlox
 XSIOlHDmwF3zWZpNbw3kRXHxazeLc0RpBqgltDTCoKz_TIyASWzEKMYbJCV1baewg0z5YeTWZj6E
 NW.xtrEuOKWC0QRXrF_0Xa2JrKWNO7AV4ynt_qeoHe_Wy2yWJWInLDZn8rHlmruNUQrwBm3uKAvf
 v2tnj65xdsvCylirsdWMrazA6CZDKsDOQvUO4A3GJlEhtrUlUFulr8sudH5_JXIZIIYZn97FPd1I
 clP_8FAlG0DkxlAt566x_wnexC.07pM6FW0nhML6LvUYar8sBobhGXwnJaRKD.00EBM8bjxmJz2L
 kE8jZRd3XTfr2kPUX3KatVrt0G7etYnKhoLgRx.7g4IyebMnIjXTMwMUYh4TlQGtuSUp4Xhr2e6R
 dc1BHt.EGWZufdGE5lbG7Z0Zgh86alINng_Ydhu2Zxk_qN5w5F31HIDC1kKNcEB653o8TiNEgU.T
 1KcAYnlBbX4VvFSJeBh2ZXPjp4wdOws2a_Vx7HDuLqzkBN7Vu_6fRHV5x8WpMALmyhN63J4AZxBL
 zIjJbIACK34n5qtl88cxkOR5iXqi_ZHUCcL9SNWLakEJTUsFtBqP7CvEBsyMTvWpFLAPIeqXhkrK
 TcCB_btF3EuNJ3zdO22ppXRxRt1_OpIYiOtwkiNxlfDNbv5MTR3XB8nTx.S1s3w8zeqIRmkXm6lt
 DvYfYPBPCFXSgoRijNexfA.P4Ji1wC6pN1e5dV5bhmrV57C36hmeWbW3VdEYCGUqxeO3XuHfCeFL
 HwuZ4q_r8QUa9xfVfh9OtVzTQ5O3xs9EqWpdMw.KY_jba4tWQ_TEUG0WcTmz0YGk6IW0.cd7fwMD
 xi_9txSxlSIR9Yx0.TZr_H_v0bUM6ch2X2yA0e_1L8RJjRXCM_W77ja2sf7jPTUoXQALXfpq6.9F
 wCBP2nBPnSQk737zxRtZGw9TQejVFqYgmN5GrZBrFBKWopigy6P0hxMtD5I24k.7aC9a9tgcaLoe
 mkBEsDJrpwnIUFQnYuR5A3YWwWgR7hUwY4QSV.NL6qvm7VXCBYrNZRbCoMZo96nMy0fuW8BtmpV4
 qpO1VMFtuu7BBphw0Cyu8oEP1eajYyKGTRIZR5S3o.kZZa2daZeFhz0o_Af.ks1l_rCv_ffhgJwD
 4IW81kIVzqIOKDoO.06RX2NB3Yjpl7EljAzu4.75q4YGwEzSSYUTzTkzVLobZwGTuIEwht5Eu22T
 vykO__b.LeDq.XXawkQMR_togUyIJ9wNzW5O87xbwSur3mVBCKdQqWVO8QS.D5Y0.ygLbFPD9iUG
 glxYb8U7eMbP5AxZSji0cm6yBrnhawLTnB4W7jKR9AdszpOtNOfdFQPiqYys0V96IpLkg6_VQu0K
 sXKXmCLWOU9GLsbSSlpiUCdptQFuGdnuqDuXV4.R9RihISujkUpFcZX12Yv44lFf3Kj30FJQNpZj
 _rw2HikjEdTd6n6hp91PQefHaYdznHQogo7Eucv9kCFWH3IAQB9xyvX.csuj7AW2eD3fZTKfwFdh
 q3xjjzasHIZYyFs.TFQghY7FKM7mndrGmI1LiOvwq0HAWTE2Jwpgh4lYWVB0wmcHo.uJJMtq13hz
 oO.8xVHaQ3p_0gBNht6pooeDm4Nz1T1a07a11NvXNMuviflyqUJ.JzGQdIifO8sUIvfd0CWK9z85
 htviTxVQqdjIRsRfdP9sEbaLvei7f8FYsSqA5HNFTog6YGb1m5IUpGSaGGJy2Ve3cigVnUJAhq3g
 4mBjgJN0w1TctMXLV51VCSLUYlZbrjjy5ey3WC8Fu6Dmn4xvHO6pUzP8M1eQeWlBWw_t2XV45f.T
 neDxbRcmRlOB5KMGGjtJ4qVitkVRdyAZg6.WMIOJb.4kQrrr3u81TFH3spJiV0IEkdZ3XNBuWuqW
 c_GnAC9U70WdHPa9gWL3CcWxEpsmHu2vwT5hhwRcZlBv0oyAI.fY3tXlrQgVjnIUX01VCZX14MkV
 dGJIQnBp_.EEUk1UgRjk68Ris7EJQGaglkVkeWolMI7sMERYHqe0YFwYxBa573HWx_K7HS5pCLZ5
 q5YfJm50Twg0X0JCm9mN40UI3tviuPGeXGL4-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: f8a5b4a8-0d61-43c4-ac20-6e7ba94c25f7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:08:37 +0000
Received: by hermes--production-bf1-6d6877594b-68jnb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5091c17d5684c30a21d2d3e39d4117ae;
          Sun, 08 Nov 2026 08:08:32 +0000 (UTC)
Message-ID: <9a9da3fd-2c1c-4911-aa6e-8a2100843bb8@yahoo.com>
Date: Sun, 8 Nov 2026 09:08:26 +0100
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
Subject: [PATCH net-next v9 04/11] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
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
index 0d87d6b..0b7c124 100644
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
@@ -466,6 +472,20 @@
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
@@ -1258,6 +1278,32 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
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
@@ -1770,6 +1816,8 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 		rtl8365mb_get_port_extint(ds->priv, port);
 	struct realtek_priv *priv = ds->priv;
 	struct rtl8365mb *mb = priv->chip_data;
+	u32 data;
+	int ret;
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 				   MAC_10 | MAC_100 | MAC_1000FD;
@@ -1799,8 +1847,26 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
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

