Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629053F5BE4
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405435; cv=none; b=OEsLBT9AoDA4Gvrl8YDl9jItDXFoMPu/jRWgPtqX1yR5GC9OIC3qAv0wH6SEWENLD0Ajwiig+Taw903JVg9mhjM+hpLFlOHbX/8sTMY7DJcSdNqXx8ZVEh4yqHLyO48q1ajzMlWA+cOExyJyVzDKPObeOcH34rmdomwVyxIH4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405435; c=relaxed/simple;
	bh=fzcr2kdPWbc7/aAJDXC1Eb77BBcSFaOGBV2Wh/Erol0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=EH9+mJHofglx0PbRzqoaOKxZexebgnQYAE4uJEigTvyPiOW0yVgAAB60a2o4vzsAUrfZW9/FXQh22fq//Yr+WcSyFsP6jVc5SaL3dQj+XGCwC3OFH3LnR3yyou5zrczwGq77YC7Rt+iCzvMvSooofyOJxX6k2vwOCHqSR2FI8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=txJP3bkQ; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="txJP3bkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791405432; bh=qq3SjnBxLagfxLZvwQoyknA3oiBzNTAgNf/7Tf7e9nQ=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=txJP3bkQ82kUv9vPPGdFXiYGHQbJc7yML9mQzBVEOo/HvtDPCxzAiRSghBqopGNryLs581YdLMXHEGQobRcGdWTz/zIbFJIricA3dQm8XopieAJ50D+Vdv5L1PQgL5BebBZ4UbyHMjSXSr29V5kIMOfnG+NwYNTZWiEnBLAif9k4jMT/G4nSe/uvV9ZLiv9bSE5R3OXs5bwFoocy8f9Vb5yyrjarvjoX+1y9ee8W0YvLd+jBu1Awx9hYeo8lBiF4UITd6YEFwqwaHl74z+Bs93FBZ9AAyBodkrBiX7g57JFcOi15WUZ6/lzgAGS5+rY/gn+ZK5WUJBDCbKkiXBKuJQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791405432; bh=qWfyNfG4+SAoLZX8JK4hWpRsgLfc2emWMovIr8xyr2/=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=pQn4VIuuAkXSnULHs7Gs7ylleTEBi/r+tvWR2I3F0X78piFMa3wYfkr/HHWiitvNbOD+elEzfydKJEIT+xlW8p2C9uB3+pRccZSW8A19y3GBpSUESZ3P3a2rBehK6YfGyH0O8YYJvzDN2I8L/5X1b/6rn2opwmSRQGfe4rID25eqy8aPAZYAN1DGXJt3RMtAZ+YZeJ+HCxch1covnD59f4ZyKS5z8Y0e2lztDMYzOIC13IFRvzBDhNtQMLdAvqtDEQyy8ALRdNZWzFiP/EKi3oBLCjoUlv+SvqTmXVvCnCZ02jfUmR1Xm6vIqivnloE1dqfNbZOpmjZzdHePGlkacA==
X-YMail-OSG: gpXrD0gVM1ngKFGap3v6U.MqvglSJ762SUslp_pF0XEo5Axt8wGykkCCVh.Enq7
 cziAbjrQlq.mLB6Sy8AoWz3Ax.JqmJQudtmugg3TuX4dPxqbvWuOYDSFb_KhvcjVg0EOEFjNcwH0
 gVpER57oeYXve7JwHmflIJDjOvSfVnBG6p7C0RQcTOXOnLa66Ut0FFFIN.REP8QvHqnOJ7vSqZzi
 dGJNML.w6fFTQUN9eXKrjGccWw7phgDvBs_3kASroC05nKotBhV9GG2N5vP5lMjU1Dx4vLtziIiO
 7pjS4n8SHG5JnOdXxqx849vtbmYfadnBH6TRFojV7glAxMz.T02kuV3lU7Cgg2v6yLHwRGt7IO.B
 OIqay3hQSYHn_ZlV.obvZbDHQL_Ufawb9OzwfaOcw1a242LEN_4VYxYVJdhAtsZFp82RESQwQ7JC
 jiTR5AwZEY7eoWyfZ3SfMYHhweP3OXjewjJo4Tesc0qLfGYXSznvr86v2Is_HQUWVNJQjuTXx.EO
 XINrZo3LTJBEkouKMlOB3Suavvhhb1ZCT5D94nxnjR4VZTZqcSySpQUmSL4fHjRcs0ltRFCcupjR
 BY7rLuvgoWkNivndLqFYCRTlB4UpOQk9wokV4Z_xbLERcXGQirkPJR3JRkCe1fn.qsGKAeLkpTg8
 AN0sACKUlggCgkF7OLo.k8ycYARxKMRLoFnvfuYM6R11TtcEP9mhfFa6rRUz4wdz5qtwjdSjohdC
 0UEacw3By17IMCxJitNTHE2bOnrGh2tSCcdUWe746ewKuGNCec9RkLjJB8YqDS.jKtIsNqBNus_b
 VK8Z9rMr5ejXZcbMgTWwx5xwwAtWGkJK6xGnKsuWf7lmTXL_7GWVF64OstYhFaYV3F.dRF.lbUqW
 onRb5tQMZTweixZ.3y49p1oLtGONktj977UZxCl5Foud1HUiBrHisR9xOBpuQHqIa6OvfODa49wq
 h2g1QqXbHW9CEynKc3hMC7zn3sE_9LBNrNaBaUrm0K0AwPGCfRzx.b_d6hk7feNKiGfycP9aldjz
 3u6Y5G2SWrUUeQKMdaOAMz6lB67JiJdOrpQ6A68MaG0eEjY6UuYFzmBWHzlh8HjZDB6PjIbnKH2D
 VIKXdXhyjOb_QkKrm99FzZq732hjXOzVlfUX59On2pgr2DFu3qIlakQPDURCfncjCgyf1x1eX.R9
 Mkm_xRA9u1RgjoEVCHgp3lh2OKvZ3PsYAPIY8UYq3GMztn2TUNHEDzmrkbdZRJrJODELUK88IKyX
 KuLUZALOCIu1QeX2cBV5maqaCooZVreF5RgYq1UIRsJTZWdtUaL6PzNHCgWdGQ8AB8X.AEpU4YL4
 pHDRvj5AgIIZJYGq.iSP8M_unJ5e3AQlXwuIJeSI5CzjhAivylN4JyCc4KWb8Ibef3xlwBETtwJr
 3WWndKEihLDz7HIspyDra0HwCE.FP8WrP77k0YZWZ7b9DTHo2gbwY8cdbQMhg6y7Jp4miSZaXJzI
 m0HedMMNwvihRurN7U1XprrGGwf5MQ8OlncVlbVd4Brjx7LsB18nmr3I7nELn1DPH5GkSDpmaaGd
 dy_FTLlf96DaTbVFRecDVRnea3yXBznWGla.DTvLLfnhGTy_QQEC6e4DHE2GLQRt6jQYOksdXhmD
 u_jIpAQEOcMcKc0j50QcKSsrBu19rgLt0.9FCpGYJDSWiu7JWaMhBKeW1gM7yxbVJlPdu4OkwtM5
 JbAE7DtFId6xg_wqiJ1BG0vuzUlcgQo0.V4duiE.JBtf7okFYvBAb1wzISMLm78O.bPyQXrtb6t.
 qDcwVx202f14Nw3K6Gu8vrXxe7N7G2HSmsPGYZvclHhDC3mVv0Xn2Cn7UATFlvtuj8HhmOZB9Vjr
 NOtGidooMr1ubeQP3q.FNyPz8vJQP33P1lZon99mlaYhpmZC4DGGSsmVUbr2FNecb3kF9IGaK7tQ
 CoocvF7dCiBrqAp9gopLHmJMzqUaUr0hTlRb.IfD7enKYiS.Kqj3mOioNXgL_dy7B7o2uA7jWzVN
 iyhJ5DcPDNvirpFRVAFG1k.Qwbiax0Mpkg5CvaAfvGH0ZMsCtDyKmrmD3dVlFFdzSlV9qEPR9rxm
 vtX0P1kfwecJ6m7PUW_kp0TDs01TTvwBdrUoR3YWoYt2KSfHTwJr3tSdAyHHsTJa3htwfnqN9HQb
 8WYx0Lwid4VWXBQXPSr1jnsuK69G25iTGl_LJVrb2nVLiam0.6FvgiCdTthxwYR2.0JDPZVImCLu
 6zexZGUreCnLkYknTKq741r8vbjiczjQwj5h6uZJ5.3Q6kdxd1HMIQvxu8Q7QFD1.CqbaX8Tknam
 xodTh8L4fMFR22tPgrHTVSv0PtrlLQ5yGrnNT4XwUhA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 0342c1c4-b88f-4540-b97d-128cfeffbbcf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Oct 2026 20:37:12 +0000
Received: by hermes--production-ir2-5dd9bf4598-fvbwk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6600d2612d3d00286863a6884ccebb87;
          Wed, 07 Oct 2026 20:37:09 +0000 (UTC)
Message-ID: <a5dc447b-ad21-4c40-b329-9e22141ff8d9@yahoo.com>
Date: Wed, 7 Oct 2026 22:37:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/8] net: dsa: realtek: rtl8365mb: set speed for
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

On family C hardware, forcing a 2.5 Gbps link speed requires relying
strictly on the HSGMII SerDes configuration block, while forcing a dummy
1 Gbps value inside the standard digital interface register. Family D
introduces a dedicated hardware link speed value (5) for 2500M. The speed
bitfield width has been expanded to 3 bits, splitting the most significant
bit into a new separate register field (FORCE_SPEED2), which maps directly
to a distinct per-port digital interface force layout.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 68 +++++++++++++++++++-----
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 80fc551..910e868 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -346,6 +346,7 @@
 #define RTL8365MB_PORT_SPEED_10M	0
 #define RTL8365MB_PORT_SPEED_100M	1
 #define RTL8365MB_PORT_SPEED_1000M	2
+#define RTL8365MB_D_PORT_SPEED_2500M	5
 
 /* External interface force configuration registers 0~2 */
 #define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG0		0x1310 /* EXT0 */
@@ -363,6 +364,20 @@
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK		BIT(4)
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK		BIT(2)
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK		GENMASK(1, 0)
+#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_WIDTH		2 /* bits[1:0] */
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
+#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_ALL_MASK	GENMASK(15, 0)
 
 /* CPU port mask register - controls which ports are treated as CPU ports */
 #define RTL8365MB_CPU_PORT_MASK_REG	0x1219
@@ -1661,23 +1676,31 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
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
+				/* The speed field has no value for 2.5 Gbps: the rate is
+				 * determined by the HSGMII SerDes configuration, and the
+				 * vendor driver programs the 1 Gbps value here.
+				 */
+				r_speed = RTL8365MB_PORT_SPEED_1000M;
+			}
+		} else if (speed == SPEED_1000) {
 			r_speed = RTL8365MB_PORT_SPEED_1000M;
 		} else if (speed == SPEED_100) {
 			r_speed = RTL8365MB_PORT_SPEED_100M;
@@ -1707,8 +1730,7 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
 		r_duplex = 0;
 	}
 
-	val = FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_EN_MASK, 1) |
-	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK,
+	val = FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK,
 			 r_tx_pause) |
 	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_RXPAUSE_MASK,
 			 r_rx_pause) |
@@ -1716,11 +1738,33 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
 	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK,
 			 r_duplex) |
 	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK, r_speed);
-	ret = regmap_write(priv->map,
-			   RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(extint->id),
-			   val);
-	if (ret)
-		return ret;
+
+	if (is_d) {
+		/* Speed is 3 bits on family D: bits[1:0] go into FORCE_SPEED,
+		 * bit[2] goes into FORCE_SPEED2 (bit 12); only 2500M sets it,
+		 * bit 13 of the field is unused.
+		 */
+		val |= FIELD_PREP(RTL8365MB_D_DIGITAL_INTERFACE_FORCE_SPEED2_MASK,
+				  r_speed >> RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_WIDTH);
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

