Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125266;
	b=d79KDl8FIdajGJDgjRF8nR1jWdB+PQWR3AaMAuHjPTH7+PZ9apNtR3gCSQ16o/UthgF0
	 uQpKRQeYcY05y/dTwFd3ekxzHEBFHB5EuVTy1qhmpKwewO5a3y1twho0JPy54DaFfXe9S
	 nxgCjDMgn2UlMROWfEnapFZnDfxFTlS5DkSlbItVB3KnKOGTt74AKvnE1LHomnHb/z+v/
	 SCjEzo6M+qj2gwuMfwGkZJVv6eKPn4BB8jE1PC0Bc3VX9DmSd+lmeIWrYpmQcpp9wAMXT
	 AWR2MpGRSxpetnKHEOcV/2NXVDLF1LV2ArVhlCvHqfZPWTmqAzmTCiD/HccwWDcePdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125266;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=6KfUEzdcsEDabwHcd4Zxkr4dgdZ+h3gk2mA5fGSh99A=;
	b=pB9YNqCsNz8wUgB33XT560GpcNfdKM3PQotkK0mp6p1hDJlMLPV689Aa5giWb0ES2Hsi
	 zA0O7jYuBQTW0jRl99NwjiQuy+RZVjMEQOTPDHF+nnaXNWVSRfmTxcR9jrsRDm2ExXHPW
	 3jrsMv0h5LG72u9J+XmKOkMgSlC7vIgjUnCV/0Zhlyf17/epqsyX1bYPKCBu6/8tmq7Dk
	 h0WrLn6pzaLAfnRqhbOS6HjlR51i8PYjLl/1dpq3wXegIGWJdU7y+VauwISH/ZHpCUk8g
	 2NknHYHoo+/nZkJEYsLTpwdmre47Ja6Kqs/ZIQQV1N06rUL4ZiaVYDwo4Qi8Hp26rIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=cBdYn5oq;
	arc=none smtp.remote-ip=66.163.184.200
Received: from sonic301-31.consmr.mail.ne1.yahoo.com (sonic301-31.consmr.mail.ne1.yahoo.com [66.163.184.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA36606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA36606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=cBdYn5oq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125265; bh=6KfUEzdcsEDabwHcd4Zxkr4dgdZ+h3gk2mA5fGSh99A=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=cBdYn5oqdM8VRQoekU5IiUFRKRa90FiGPLLAUv7J2L1GHibmOa2T5ghNh6LsOpf+fjefr5Locs1a/yUp/L5i+UeDchx6YVSum7YNd6GFO9WMM0nMA0Ek+ow3OB89LMWcUz5NUQb4Fi0XeDPJwrtDNOpTIV9ti4btd0s+3IH30dkhsDb2AT4MGbrL/toLwtI2hbp05owxVgmZluy36JNGoW0x9RFwGiF+ZR/yVt4NadXMqWJTrlKH1H0L4eNS5uWCoEgbFH4+L2w6+dMRjC50CVz3J41rClvmuEAuIb/sAl9UhzDO/C6lM/ugXfTW42Tde2XJYCTgkzh5KCltNwaPFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125265; bh=5nJKPXYN+f4yrriWRXfVaVPGoUoWGyu3PCzbPP5F3yX=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=EaJ+gAimxUnoSC9DlzF9D/GmVOrKOVD123OhxboiOJldi5CywwL6CweXLDGGixE3HVqq8yo0aj0NU3FWL+7GwicvhT4jhl2NMlKt6TYdDxcj41JBYL5LfDFKhRu3U27GVFkR977TIzjHByvKNkIw/c3Dg6clI81/9Ao+FeqJa/oBmmL2EvbqMF/Ib42FRPMyMvtvk6aHbEHUopuaH5mGUB3yUB+fcm38w1AGUpIzwP46VZPXQuAZ0doon6/BiKmH6GdQHpfyHYQ4BI6oGcV5LW+0p2dXtP9k9YH2yrlJlyNfD4cVmCOmeX1AsU53lG4L9djbv/3DMKTIiktwGn6/Dw==
X-YMail-OSG: dYzwfaEVM1myLJ0KxIxrDL41gTSk_TYqyHQ3HQoyKm015VPLNi3_wPYpiNt.ASB
 IeP3Y9dVcWwIsNYOmbTtMDMOk.K8qoZ5YN.ul_fKjoEX69o55vKnlxK.8ZomE1.mJhI8EmJckoQG
 5KqzY4LCIqPqi4xoJ1Viuq92hiyhIpRqRQ43rpjIUH8zS.67gQ1GXmYVVdf__4ccPpFY36qGcnEK
 KcKBKmhKzQB.l1dwjkyiGpL6c65t0ZrfO1TnW_8HMwjfOqGTLh564rJObMuxvrxLBqZFVa_ow0wM
 hLbgoKJjHPCxYXdbzusf1LQrxT1VAucvXrs_vHaFLlqtJaEG9QvKRl64YcPLSDb2veYQcwLc6Fnc
 BjerKNuiCEhd2Q3CAgsRdkm0DaO8j8_XK04Dx5tJZ1.15z70QyPAYf3Nlwn0GjX5raOGmNrB1pjp
 Nk6dB7.woXaz9xGaSjaRCuydpHHZf2ZxhljXlSdzVUjdCKgpw0uw_dBx8OLISJs5hqBhW8lHxcyp
 D1FY.3fycyvBABEaqcR6lSMIN8p0u7ifjaMtu9IGYmKt6WTOk1Frwsj2EB8OCsKkb3tQ4hBOeRHm
 LAk40v7NuSO_fHihOxK_IeZZd0DVj675ScWktyrEcaWABcIzzOmxESiPSyjZPm3Eekmf6Xi8pu6C
 JTi55mrwdjlFSvuk1gTKqvJD99gSrVaU.SbNQer8wAaOxYgazJCDTWszsGqGx3NGZMF8A808nhvT
 WeTdPRq49G0ucusPuKpdjLnfvFhY8j01SAiCOz6aYGgEK3diSuyHb4hmZue43Aonw4QRq6D7vQ4n
 RJbB2F0I.sj6NJrYJ2R62Hi47qcRceXDDSOxlNwHyIHb.A7zAzXXJn.9WVD37aWazFVJwDT4E7AB
 5OlHVi7D_ptCQMoA3E.riBEsCZ7sGx.eYqDR8YTFi7bUCoDngfWJQM9giLcngeNE2mQeS3g56ZEC
 oe_p1RJ0NG6I3fukbyCnpyDmsatQp9PGlgsCMvLjOQY3EYFJ8aL1hPEWUQqvK2PSY9o8q6BejyjE
 R_6PplXHDtL7lN4JIdKp.wzullJcLaciGV4T5_tYHqe95UqvMqHutQGsT.j8eRSSU2QZ95V_YZ1Y
 6HyBJHRt2Hx9ifvf40_d0HZcHj.99UT8c.i6Xcu5DWnOfTUyqpT9VS667hqldR67xB4C5dL_ayM7
 zZqAhNloOcU26A.itvUtckGegCNgxy_Rt.YmZIiITDvbrurAACFvrKlrZhHA4yDqlLY1KKRas6Dk
 EAIYj2lM8RP97CxV6IrxRyE6vvamu2w0uyKGrvPnCFt3SGk9louRtWW5WU8pdzB5D1rqk_LnN8x6
 5_WaAnfghsu2DGZ.03WxEgzQp_mOrTC_6oy.gXmOMVQ_Z2gQOWP2VHFAkZTf2.FIa_Fw_FBCEszl
 MP5V9yVgxc.b2CfV0b9f11DWqTR5UDpif2BjNBU94z40GOtWtRH_0npKEYVPw700eVDARKTLdk70
 qzfGI27sxLfHiyUawKEXT_IZjSHZVGetp4iNrPeT6J1iXOweHB3C1mB8yzvYwPWrRg0zHdOJpLqJ
 .58I4aBSrn.iJSi4Mn2poYXxCCizGozZG2GzFY672lEvaYvO5rBxdgbA7mFI35t.PG_2gDUnfaBH
 T7gn__F78w2Hcy0W4jGoi7k.O3y9NKy0ccDBFhqf1xlXG7K6nRS56yUtAWfjCyvn24fMNlTFciuZ
 pw._egCHqdVDrAJjIHHQxTlInwOVsvl.F1WfueWU6Jz80t.tASSvLrOv8ifgBvaQkYzcnRY_1e0o
 bcgvdxXoZ4p8ghSvaAP.wSc3eE3YpB_UJOQ5nl7Bju7qOWDUkRt85hD2QSfU6mxQf.iwfCqgRK.V
 WTTB5_RVCMmyoyqurx3zlevBG.MupOC.MpD_V4tRodaZWBpVMKlBb2qVdS6Xiup8scVqiAqEDBlv
 4gDPl5frlDfAwx_4lJ9vKly_s61KuQ4sXPz8lONQ.ojVyoMXNQVGk8eLCylIYfvfF7CKphlxgVxL
 w1eE4YQwjosyNs.u7F9Ir3ZMDKjRkJCzqK.u3hHHXba1cgJbyn.Y_3UoUjAXPstHC809wbnxH_VC
 Atm7PcORnLcX1cPjfuxaAjebZhRCa_1HfXSV8Qg6z_f4jwkGunh_sQkG2rbgfF6d8jyltMlnvj1f
 PnzsYiFhuKJGHP_KeLlAggJM84lbiXnil61kgFXvW7obzgxlbyqy4GzyQBfakGTER1xS6ij_h8No
 z.n7k6.9pYOswUvH0awJKejmx4ogVY8JEswuMLe83.49sZ11wLMo6dDyUGMWmBbBGwqU4dI0lhdu
 Rb.q4GP9Y5uvLgTtB5Z.wmhG98b9kZ2J2HFH.
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e6e16e82-a044-4c02-91c3-9de629474b65
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:07:45 +0000
Received: by hermes--production-bf1-6d6877594b-txhz8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e54a4390e0e3eda1a5bf77a8b1251c97;
          Sun, 08 Nov 2026 08:07:43 +0000 (UTC)
Message-ID: <c9cd2537-262a-428e-8f33-6ae039711b1f@yahoo.com>
Date: Sun, 8 Nov 2026 09:07:37 +0100
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
Subject: [PATCH net-next v9 03/11] net: dsa: realtek: rtl8365mb: set speed for
 family D
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

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Tested-by: Stanislaw Pal <kuncy7@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 81 ++++++++++++++++++++----
 1 file changed, 68 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index b500c84..0d87d6b 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -346,6 +346,8 @@
 #define RTL8365MB_PORT_SPEED_10M	0
 #define RTL8365MB_PORT_SPEED_100M	1
 #define RTL8365MB_PORT_SPEED_1000M	2
+#define RTL8365MB_D_PORT_SPEED_2500M	5
+#define RTL8365MB_D_PORT_SPEED_MSB_MASK	BIT(2)
 
 /* External interface force configuration registers 0~2 */
 #define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG0		0x1310 /* EXT0 */
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
@@ -1644,23 +1666,32 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
 	u32 r_duplex;
 	u32 r_speed;
 	u32 r_link;
+	bool is_d;
 	int val;
 	int ret;
 
 	if (!extint)
 		return -ENODEV;
 
+	is_d = rtl8365mb_is_d(priv);
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
@@ -1690,20 +1721,44 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
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
+		 * bit[2] goes into FORCE_SPEED2 (register bit 12); only 2500M
+		 * sets it. Register bit 13 is reserved.
+		 */
+		val |= FIELD_PREP(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_SPEED2_MASK,
+				  FIELD_GET(RTL8365MB_D_PORT_SPEED_MSB_MASK,
+					    r_speed));
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

