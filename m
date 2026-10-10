Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDC3D093A
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661211; cv=none; b=CZhRPI0AB2Dx1W5HMjeCTaDCnSbQbKIrgiUQ/Mc2+o7YEVW9ewBWHjFZBu/rqZ2SZtkqWmi4dGzY/ykue4RyrFHAQqzrCb50mJNfAx7fnW9XhUfoIpl0lz5modYVARj06KqcQcrQcqkeI7CKvMNwSOXgqTUq/cdLDcTYxfAWC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661211; c=relaxed/simple;
	bh=JoSAXVV7oUm1yecB46K+hgs8LDXZe1nY0EcgmE10ak4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Frc/AwvxaLvQ8a1qzObvdbOoQrlgX5SFybDhXJH1usLIDBQLx9eTDeqXOqTFukMNrJlqLjKTI4iO9GvKrxwwmEEPbAR3UDq5/b7CeOBvzuQThf7Tub+NPdlKREWwqUiW4OuSbYjtFSME7aCegtv3ZqVkMGBIKr5hccFdqdjHhPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FORr6dEO; arc=none smtp.client-ip=66.163.185.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FORr6dEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661195; bh=veuiUetz6HucRhYBzWQL1g7c0oLszHPzlq4NmMzuG8k=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=FORr6dEOleuO6Pi0r1tP9SyhmUdoQxcJaYDRgXC6NVd47hhCTbXCXijqdhIBB/fLvHTKVUueh0fLrmg5DPqxMbAzI56Ub5lLG5i0DyEioWG+6bVIduWj0zJSk+9GcGgZ2d9C63QPi8Tovj/1riz35ABQQF5l4AZqdqTuuVM0s7h/VzUh/77W4e/rqyGBFYB2fm31fu7MUbPt+RCg+p780aWw0FKsSidbVzjEPPayom73TZWmxPuVzw0F4CB4+HRc2HR1RmMDtvcw5WlqsTRzY4uUQd45+91yJlMC+e5qGYwUJYcw+DfjRjZ34QNZjqNzE2o0eDQ2i5UXa49GAXhQ7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661195; bh=F54NJhgXWVL1AcAn7kt2VPPs8VP2Iiw6oMVnyaW7oo8=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=GPQX8CpO+gpunKemi4oL0lGa7GEHumqNneaXz145WQmKGDuKxsOfczm6QbO6ICHjKb3zvMS56dIQ1sxWjk8SHcabRBa1jxIFa1hBwMHxjdtdcZqqPOxOGuu/hDjsC82xyIqXuZo8kuuQGBTD0z8jl01BzVQBNXH7tjxTMmyS6E0l6N3kIPv98rNXkF/K1XV1fUkM5DYzJafguDJ2N4oaqs/4+pSG2Zsy46TZuktcO1uUlujkoMxNr8JI6tlyXh/rEgUh7JI5zizUedcQFrJRL76cKWV8iKqLkEYM/GkP8oQ4higMMll3Y7NLxnGxVv8IuX3KjkgXO1+QPNC8swzNYA==
X-YMail-OSG: WzeL9_EVM1nJeyCNA2Y1oxQth8dsmL1YxjQzYSGy5bluznDDsLjaKzwmYUO43Ep
 Nm9JRUsQ52UbVSpht0x5Dtu.Qn4jffXOK_vi7ECo6hSAHHdbmtUwh.zfaJXS.uGEi10znKvUIlsz
 605MzGda.Qx3ktr7Fg_SU5y7strVfjpZv77HbUcCTeS_BhjJLae5l2NMEnBqJkXzgATiiV7ZqgVe
 cKqH.hUfAUGA6dFArHJDOr7wJjcx7fsde_7OkktcfoL3VaU7UQY416H5VdkD5.uxB8S3p0Bs2VOU
 Y1xr3jdQnmqVfMyMqX8w6_Gp7ddXMQo5mwJfEeiB9CLkWIOov2luF8AAcPrfNiOPLsqXvghqwnSE
 Zda0ubtMFJ6hz55SwVWKCEBPxg.PLfjljtXIT2uAbjgCOHGZU5iIAdqRjW2BUjdjo5HZtZ1w2eZY
 YGcfMhcmK7lh_kn5Dg5GzJ8w1yHKfONV8hDEFXNG.wZiAMeyX6QLi_3WhP3iT1gz3HESu7KgKskh
 n.6_yNZNTi64fzS30b3NAPR0x9xUo8qxAybhXcyOoDaij2i9InkWw7qUpSg6LFHMQa0JXNZIF6Jm
 4FvUQXzybJ8SVZVpTIpIsxbnUHjHsXHhwyAxfsA_ri466JQN8g6UQu725L1aNdFN.ckSPEU5R7ov
 Fp7d1.9FyXmxgVfayfB9w9yPBcnsP3nrw9NoRpRjcbXb4H5NL_1.Z07Rx8g_fXwwAv.7kFznIRLl
 c4CWA8i9mI9g3u6ybyJOYOUq9D_ETslmmYmcmb9bZ4ebn0hGFWxgKdJinhZ96zM92y53wiu4mHh0
 _zXyG8g6i40gHsYc2DLXQTIZviqVxWrxk74aUu70qkiQnwytleQ0vucXCFgxxEl3Oo_XwUEX3t0E
 oUYBzpZR1TLjRdk1xvQi_fmRTmaEmuxOSYhh_cW9i5Z_C0bulNIOT7SS86oKCpFal7oZScSsdN.3
 RSZTqVJ36pt8Xo_T0Ze5BAtECKm1Xj1bc9rWbSmfewBgMoSkGaeE0oxaCQnghjP2HofMuaJbkcVO
 UIeX5YvTsKM5s37rwuI66TzdlXeAxaftSXp5SJruEmOy7hyFUMwSYt4DA88hD6iOOPaFy8rnxIix
 nmKxVctCpRLDCqe3A2RWjF.0bXSYxLB02BWZd4Vkw4Mh1TjEVKSuD20dzBqpKquk2BKj3m81ISxw
 upIu4lrsswMS3w0BCp.PuwHuQ5cdlUYufydyUXd6T0IUe5NZQ13iloFnUwoAhcTN3XvprzLldG84
 3dBxmf_aa_5v3TurP7WU2LThHOJgFhLyYtYTgVnXALBdjmLPx2Z4BM9EFAATUPZsOwQL4V3vK_R4
 jKSALJfkruL1C9qU.5tqFTp0ZcOjfGs6XTChO26JnJyQI_0Wa0QDtBlPh9iRe3p4IyItOS6Oi2fj
 RPUUD3pBlTTP2qQl1MfmkpjmIH_nHVzEiyF0jFkRRhVnDJ3epwQIJVsRIHepCsOpP6SAn8aStj02
 RZ60rU3iVwWDjmm3lSJXlFrUQSjEBns_2OVLaK4ItJJYqoCHk0DjujaLGdsSHQoonOaLXNqk1Uwc
 uldGgBj8rEhtqngmaOtRcaC6Tdt.g4GzOAtbHE7DC9ecZvnStHDJ6EgDOkO3fQaF.3Bv_m4pMOk.
 YswFY5FgxoDam248wUxo9395t3S11lnfVnrzzW2YGJRWF0Q404FzrJiAvdOeLXsghiw1VSCgC5rB
 qAOT9LGmUT9F8F37aey6mtCeqlp6U7b7jNq_nstlZAql.hwnUgxpdLfx.h7buzZciZ2o2DBYLbZB
 Sbj5NE_DpqsiinOjTyBRYwugjiUM1FGW0eSAMS7_pSl6Lp4SPeGMvl627vzceoGBIium3kLWaWxU
 SA6M8hFeGQMklxKNb1mMqskfEAHzNqyB3qD192JBtBftYYKW8BFCcoJsoOnw.Miujg.jkKeHEHMy
 Esgfj3TVZ33oRp8R9BCS2gvkesrZiFZdW2WYMFPG5vUrFvzon9lbnhVlf6mdQfLi5ZLHMrpEBnIN
 McZl2TrrP0.2411pXFVSxvzFqDJv.hYvKongdKE_LZY960SOzj.lmgbZnkh1TVdLMV7RAosmEsEz
 WXXuQnXGADVbeyYKdwgdU8VPk1J1zLdBghTRL8y7XxeJhQTJbdJRtyJcv0FZzsmcxnG3PN58xqaL
 ASfoOfPpGSclmB4yE52WbTT6zS2czWGJyvfC2heozqfPvXc4DIlxx0ZoAag7mQUkF_9.CZrrM2.R
 nkoUrXs98hd7PlvhtUwYmViHTgS0nS1BTZsdfHn13x3ic8ejCQ39AzTzXhKNRb59u5SOhnFZ.3eF
 xzOjERgvpA_m_IXqX8YOcTBCGCBv52tyrACfMUbej
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 3168e88c-c6f2-4b40-9882-000756f87ee0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:39:55 +0000
Received: by hermes--production-ir2-5dd9bf4598-fvbwk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e34b5574416e385c7f8ad088ef1673d3;
          Sat, 10 Oct 2026 19:39:53 +0000 (UTC)
Message-ID: <d9773155-5e61-4b6e-b892-73668ca61fc8@yahoo.com>
Date: Sat, 10 Oct 2026 21:39:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 3/9] net: dsa: realtek: rtl8365mb: set speed for
 family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
Content-Language: pl
In-Reply-To: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
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
 drivers/net/dsa/realtek/rtl8365mb_main.c | 75 ++++++++++++++++++++----
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 840db5a..8f3295c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -344,6 +344,7 @@
 #define RTL8365MB_PORT_SPEED_10M	0
 #define RTL8365MB_PORT_SPEED_100M	1
 #define RTL8365MB_PORT_SPEED_1000M	2
+#define RTL8365MB_D_PORT_SPEED_2500M	5
 
 /* External interface force configuration registers 0~2 */
 #define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG0		0x1310 /* EXT0 */
@@ -361,6 +362,21 @@
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
+#define RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_ALL_MASK	GENMASK(15, 0)
 
 /* CPU port mask register - controls which ports are treated as CPU ports */
 #define RTL8365MB_CPU_PORT_MASK_REG	0x1219
@@ -1646,23 +1662,32 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
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
@@ -1692,20 +1717,44 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
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

