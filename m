Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.189.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630340;
	b=CToxEVuRq9Ml1pDEHJAj6r9+UPf7g/GXOwjRnAaaC6ya0sgaCizn2rwEDO7x//5f9n2A
	 BzxLUgAnfnGTesOWl6YTGQQ1xvySfIA1MwJNwhP/CzCc6sitcdLX8v1GoCUjsFuDIyShz
	 +ffNS2QyQiQSBFyjkR+Tdju8tcExP5DQd1iqn8DQyLekUALOJjfmZ9lyNNuaC0Y2fsyr9
	 k/gFpqp0qnoIhpR1fWELFmpeoyUnnFILrQOBZC3c7OMNIaZlNIDqGzcPiirvpi3PrOqmg
	 /B/egvDyUXN6+/48v7nnNavC8SWTnlG0SYwoeHK0kP8lbd6NwcC2opD21GopiwHGyNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630340;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=avVz+7g88klb4HjdD4G58Z9rchyB7vSgeDbHsp8k0Ys=;
	b=Mvs88CWsRDGOF7Hie04abQX28kSBxyz5YbEmSZ/qYc+pgK07IJTvfTCdySnQVxZaTJ/6
	 mIie9HXAujFFc23ZaX1BNpMuPsk1Oo76cfq5s0S0KRBeRw1HDSj8PviFhspXQ4S8H6Dnk
	 6dhAAHOQSQzKPHloD0rQ2lg1hFwM5jC3ZDtNvrCMOr7osTO67q/jMk0hRRUeSbx8rxURk
	 E7+2FgtrbtXiX88pH3pxmN3GPqki1tXW15pawQ/cDU8KYGATE4s2t65kSfrsuD510LaR+
	 sBGyMnHKgE7dCLMD7wc9ARs44Q6gx7p6nw16JuvaRPjZU3HmSotnTQcQb6FmTpocNrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Rv8n0JxV;
	arc=none smtp.remote-ip=66.163.189.83
Received: from sonic306-21.consmr.mail.ne1.yahoo.com (sonic306-21.consmr.mail.ne1.yahoo.com [66.163.189.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7759606A32D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7759606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Rv8n0JxV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630338; bh=avVz+7g88klb4HjdD4G58Z9rchyB7vSgeDbHsp8k0Ys=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Rv8n0JxV0M+IByHMhAcUjgrR+4kmWo6S+yPF21tOf7KeuWOgCO4lNchKlyVmxYsZhlZBG2uOwpbTLyDm0I6DGpeZBG8OZ+Rb/98KvgaTYNXu3oJMgGGEwPb++fgffk/E9hllIIZKtyA9k5/IICnrIH+IaC1VxQPrwWUxdV3OjP988YnOUJM2mSPmE8g8dYTy6SAj8r2tz0bvGHn4PMu7UIeDG7kPAMqbIfQWJT2D9yfTyLGFYGT0xhJEoLEBLmrF+jRphd3Uo2QxuJGDO8Iio+Pjyuddfs0HrEuh9US5RbvyrX1BMlkxHLm7Uxm2l8VwsYE7yWRUuQv5Cnhrx0LxnQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630338; bh=FMqgTZ4ppemRAH8sY6EwbQ8jg8o/xFP20XC6aQRBxjd=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=g6v9D45MPAu2OtKtt5k8QvMYPWvw7s/cJLUmIhMXGcHxPgDtainnSOs+P5s7zHhK/NNK/GGIEZpv8Qz399ddSD+uWIZ1wV1YNs1ropGJMYyFIWISzL4Afxz1IV9Y89OLy0kEHwZECYPt4DsYHKb30NlAW2Te1W+O11FLrvFQ2yHbeOvGCQCuN98Qk3dhv4TlcF/9X+H62oWmYWFFPWzoT1Gw7IWY/C24L422Q0/7QaIqxbiDLMzMGbiS7Cv7rnXRxxDGdfFHT3j+0T3mOqQcvzCvTPG5KykJJX2Iml/njhMcHiLnL3TZNAxoEBkVNfLSGrUsFRq8RIpo1pxO6XRtPg==
X-YMail-OSG: lb0kUucVM1kLCWekMMduGVPyh0XPBW6q865e6w4OR9ZykqUq16jiVJsk5Z5kyoC
 SH7hdCMscwJXlQIWuMG7i2w2hLqR834iZoCDBbk4A4VkmnF8oO30RPMmUhG9xh7n_oYiVNR1oq9a
 _WtFhm8v_8vaUblldZXvc2ofKAgrFGkuI8TW7hHdI9a5J7xTrBuUY0yQ_QRHwXBAqkuZRiDe0Ipg
 ElLhlPWbkTvAxb_pGvggiGrm44ftIXpfCujAxlBbRFWXb1EbyehbYdUbFy.HIAI8ZQXOx_JBNBFG
 aEfO6exgdh_m9YkQS8ueVb4B01v1VskBPplKhgcS8e7s9kXNJfAUUxp.2Ppd8Wsw1thX.S3_Jn3n
 U6sK8CTvQXBBW3XP6keLuzXf4JAJCZhCaIEkx02.TatL.MZnEDZz9QcI611KJa6801lShbofwG2U
 Du0.i0jTm5embTSx7wdz4l0N_m4SldKW8rypQXntuQYPlUu_vaZqfRqMGivXwPY1BGjWd0j4t.uG
 yLVmNdbGnzAVE5izDA5ALbOkPb_BDmYCbdorYJem37bGn.CfYGvCobAhRvEh15U4NPR9eR.LSf4x
 v2OCYKELSvt.aEwe.b8aaRntQz5MeiWtiNeCULGofsqsD20DHoIW3XbGaJdr0L2B9OKnCcc8cugP
 h787fimyR.LIdE3MLbtJD358Aop1OCXIt.wSAmJbXG.CVM49jdPFOlOr5BSgj_QQBjZ2YLLPik61
 8YThIKAtNGsm_l.FZFyPDjFPLk7CrqSSY2EKBOerso_Oc8K4oy48iY0mOKRq3Ei9VEMgWnFP6N73
 y4zKrHcRGwEckPWp1EwEQ4em5gZiNAG25vl01VbWfSznR.sDuhP8SvNx_O9arUi9aZfIhTureeI8
 924X2zKArtDfjGP3ljVwtahSkZGm2hme2kIhQZzSdkHecZ9j8srrOmUblUpZqGvRRewzvZRJ2THh
 SywM7Ic7je.78bPcdcpc27OdbHEjjh2ZiDKHoHFmyczvQVYlbjXyPAxpDVC3l.A5Ezw028aCGPNp
 y8mUeayFA8AZiH6_eaLSHtesbigwtMFfuXAe4tpknWAWESuTQaOWuaWDcVXg9u8s8PMoS9O12ebW
 rW977nGL0pCg04uV7PNJ0QuqKHHbbwQ.6OJZCBoxdxDVIBaqmR.x2QWDHvooAZx54C4yNp38xAFy
 d06yswiBrfTrSdMFI8gSrXBLY2EaW_CD4Ln4rdRPsB38ZJ43Nw6dLS_3zxuyr9pXTLJw0oaSGeMn
 6A.2pv9Kx0GRppamsJ9VqGnYt7O0DacWCuhwsPV2ZkxVzw3D_YKd4NjEg_VIW95ZFlwbwLGhGIHj
 O4Hml4TxjFXz3.5uuoTN7u0mAe.XRAhxkOjhJLgT54ay.6s6RwwQ5P31AMy_ElyAlBbguM25xSZc
 1cH5CtDBX2ElPjob1CXEaEB12cpIa1EpTyog0BYFrlRkUe683ioFEK2UHPLXsA5OW7RJIbPbvs9h
 lwkek4aqehPjknfDbdZMH_Q2JeKP3Pjj3U85gfopGVv3QIZJ3esaQTYWaUNITHXoENfhVdJRyP5.
 aY1RV7iH4HceI_zmSca_Li6I7PxuZWFiHHY105p1pHxPOnDo8PQh2hMDgAHRFK_oInMIZl2uBnDy
 wmKjiq6U0L1YKc9jDEC1oy9qboMu5mXFdmRtY_x51UyAQK.NivrRt.dSOUVdZDtL0TA9CJwAs1Kf
 W2ByIlhcpNUS2ocRYVPoSnVA_cW50MT_gZs.0.1pInykRwStbLniIJXoAsXphFzwd6fUpYdr0gxN
 EYOi02f3wd4Ot8_9eO3XqNXggz91InHzHlIxMSyxzNNDxVJdNbpX6pHREF2Dj_nhp14lq12kiGpQ
 cFghWpodgWKnc3ngIPaAX6FG7JrRCEuXZujBgtOYbo8X5aJmYX113WlVWAtSjnRSb_5FeEp6KGVk
 hHhnF7ljs_rIb1CNq.pok4zyAu_iSjWfLjWQJfbH5v0P9ljrx_XqEFLj..Ry4NVywFwVofQ9CPh1
 aFwPjRao2XTFiflsbMuxKabSsZt0fyVm2Ibth7zZ1BRriKsyxRiBEuVSaOiTd6e4NyEA9vuOz4Ah
 zyjO76MbyvPGFPR4RrqRTkCbm1zlAJhwKWca_dKapGZ1de6irWlMR3n8uylA60.sbtFXKBhmfjL7
 KDj.YZLMikFCrA0CUHEiEANfy0e3DRgn3ko6t6QXSIYqkd6leyK1RoqNDw4aDeHRq9xBbvVnWVNB
 nbcuQiOZ4u5WknbxzmKsL59SU0Gcqu0OS1VGCi7ilX1rD56hT6s.S1f70Y1LF_bpsHkDejDw1f4b
 7lyHpb9g5QEuMR_kWXttJ541oXFRvhC4.jZWf3oFe
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 6f3851a8-82e1-45cb-9f54-f929327fb39a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2026 14:38:58 +0000
Received: by hermes--production-ir2-5dd9bf4598-hl2mf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 14f607e426603152465a6b495217399c;
          Mon, 02 Nov 2026 14:38:55 +0000 (UTC)
Message-ID: <d7f64039-b629-48eb-a985-dbcb2cc53774@yahoo.com>
Date: Mon, 2 Nov 2026 15:38:53 +0100
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
Subject: [PATCH net-next v7 03/10] net: dsa: realtek: rtl8365mb: set speed for
 family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
Content-Language: pl
In-Reply-To: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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

The family D branch is not reachable until the chip table entry is
added in the last patch.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
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

