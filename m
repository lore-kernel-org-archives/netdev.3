Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.184.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748592;
	b=SUdPzTYNw6aWWKK+WHbHnkAu6Pvi8GVKjBKrtDmpeTtb9eG/wW0tviTwypYTrTlKz45d
	 P5Pgt8LVaV49SZNEBiuA2fCT+Dndgy730pA9hMW8ByIrnJediNKTjwZAIxyvaGnh1rVo8
	 gZZ6HXg4qFfmcUyvm/w7SsahYAFcwxVsKBM4ZUevPKxqE6wBFYfQF7in2x5AvvCmUwAr5
	 dvo5bLVwz9XcqROgYMuLdEpur1nODhSJfTNLtbtzA2Z4pkimxtfy2VqmeyJrRlybRKx+7
	 Vz3DkowlQiaStvT314GTNUAxj/m3pkfidFwLKzpFE+RtHGrgDMX/+/PijmoPqW2GtTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748592;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=z/CwkSd6JQDmGsiwXLjC4cddNlMZgpDGbV72X4IXO0I=;
	b=LH0OVfgcEWgndKY/3/PHhO6l2gGrfkB1qzwz+kWg04VikQPlVd5u2PY0q0p8QVugFQYY
	 0jAoG+fLqQ+20YES4nIxMgR+ulc0FCXA55DkZmV0SwuLxJvCjwfbtUEd2GqFaH5eO+eOa
	 p4YlYiuP5BHe53r3Ty6Rj3kWUbrOQZkGbhLKG+4iOWLUfFdO5gPVE+vY8+FOcYpRKc4ni
	 PHYlVoH/e84dkgxmgCTD2CLh7aijOLb18zBt3FveIzhLWS3EzK4pQB/hO+yYqCIjtcGn5
	 hvrneRLAptSuArs1/b2uQOtGsgVQsg6TRfEQPJhf0//gMqU91QNZT/4HKffGd5gKoMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="oR9/9pTq";
	arc=none smtp.remote-ip=66.163.184.147
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26D606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F26D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=oR9/9pTq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748591; bh=z/CwkSd6JQDmGsiwXLjC4cddNlMZgpDGbV72X4IXO0I=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=oR9/9pTqORJLU9LheUUYdbwnOPpQnTDCb8Y6BVC9GcDJEmLg+HGD/dE5S921f0nn9jXOk5Xlmv0u9fHqDWNxpAd9723jfXhYd9rB+4hDpZFgyZfEhS2kQZsZENLT7JugnVKTbJpRmrP8JwROdDznhCFIj+kgMbYaILJ4NX2aNaBSYbjffgo1chDskPZbfhhq8GCc6FEOMOs/mYyOIyrzyrOKi2Zccf4eeCpN37oZFyCa0G/reQg0midPPCbDZXq396Z0rZZxSftmc8yCO/HFE6aTpbZV4UTONMCzv4I8UfvOLmQ0wpkuVuFCDWIeUgsE+/ZL9G40aB1ZvUzpMbdnzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748591; bh=jZG/W9u73OXUUmcgCvxSAlHPlySfL3BDIHuGMKgLIJW=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=rITh5hw69+zTYupvzhS6D8Biuo4rQSE0YWvSjU4MDGylgRXWWq3CerHNaS5HLEtbj6HbL7MJCPFAAGtbksP1OAGTVC2MEc9xDNNV1/Oaqypz6UflRF90in4XX+y/mnhuJM0MI7foGB/7fXLrKmV2WT/Mp7jabGrnfDk3mzclE4h5QLh83uwmqxgIP6ROEgFraJ0Fa6Gzmw/8OtX1H6JUffxoTASEr7VpogcdBk6N6St7gEytzWUfwJfRmSB081E/sPSv1FDr9nZ50eK9D3ZgoGHHcFhdOQ2NYeUtMWH/aRLhAWiItChobWD8f3cqI/sz4GOnU7mI60IDKQM5R9pLPA==
X-YMail-OSG: NPObdDcVM1nNHYA7sl9t.N126_BzUf0_8kmZuXY8oG7OFYj2PqONfgwLMhZ2.Ae
 DzLBEq7hmF3geCQ9zvnHb_COBcb8W9Gk8VYkKysifRvV0Iat7Zm7FtcG_3nQJzf5YJkAgy4fuIV4
 vuEfDbkmhcb7lBomO58kyS7P86zJyBJtfgNV0rXpq3Ke6tKbFc2D.1jhKlqOOoB2aXJ.8Fym8al2
 NthGrBUO82aI9w41xclAz.UDKEmw4zXdzkMANyT1pCZCB3_OmvyrAK8Zos7a8O40bK2JzDIwiTea
 iikSIxYXBgJeXAeaYDaahoCAp2_v8H9tNkQhL8qA9HMXFwPKkX8V4qTrt3yUHYydXW20z8aAYxwm
 SwmQTq7uhImol6mkw87U1r_pi2xiHE_raqmJlYA3yDDVOQETt.U7DE860kqe_KAoVfxrxhunAN5x
 0ObL3pQE3RGmPce_THttuoyI7ag3yP9ZyDhVGp530XYhgrJDuNB5ZNUXoytypAiCT7HwfT1Z08SH
 nVklZcEvrP66VQfj5uIvu98Kf3qOrIt9K8OmLyGdDOdsk_15CUKMkGEP4Wo.mwAlYFc5ff6Shp2Q
 e2cKkTus5XQ.1cHNh_9YmPmRVwhelqjMRvBPAddmM5hMTfWTSyEDPSrbFp.frJml5eLiadyyINj0
 c4sjkx1RNVWLT5ROpQTDpF5aMwIsZKYDNq0cw7IpLv3JsKv25DGvcgvwAIBVawwTVc_YRKyJBlIj
 b9RdjW0t0gpYLCUVUki0jP8xd75u72U7rkMR5MTegO99iwtoz5T79dFtxPRVbewX4rmslNGeUk7t
 uAtVUEPWrYnaJJK7pLsz08lnbHls.WfvEXTXRNn4GQxTVuI4626m_IYS2yl.zNXn7E3UqvbMZnUO
 eUefhcKHie6WuRH9EOGykBQZqQHhbFj9ko5jzpU6heuFPy1lElBshT_QC_saSqsDGYbQWAJ7SSU6
 mRi3rySvLC9Kd714zbBtrFEqLrwOj.Nl9y5PBHsNfRlnxSrhwpAIpPdyxRVPsC_h8mvLIPLu4jPT
 stU38qDAHxj5d.YLmYJM0JatQwEtDMzIeKZtbaLFjZuxPTfcKdKbH_rLzSu.qqtQ_uMa1zT3f3kq
 HTQm4dYKB4HUcCrWGFyysgWcOUP3XJKucowo5SoxNMV0pooM1mhEzWKpJYBs3hey.OPrZTWZ0wKd
 NZG4BG6ddkMyfdMY0oA3KvSw0976JneHK0Q_iAUDFui4ct_WbTyxIs6zSkAHNRikofXgNLjReWjt
 xhql_4tYEKoVRcGtH1gUKkoJkYkue7w4.Eyp.pOkKLY5hVxVFiwYvohgj7xZMp3FRLBvi8IE_3YT
 tjuXE7XIqOE3fVJF1r28QJAPT9ebqQWQ7bYt9RvWIaLekHEqCXXJOOyoaYPe0VMZE8amzc7vCeht
 SSPnbxsP_1UmlsAsiJOrxhzCdXqHKy3dKh0P8zCcSW1_2hlErUJCAjd0Av5z5PejsaIGoo_6.zHu
 TnLwFGrPWqByIPhO2cf_g8jTw2XWh8pD0Xc6iRvuHnsK3SHVd0kpBFJfOCenRS5CU9Pt_bwxagxj
 gCsv92MmB0qqnBVWKCN8llilQw3LNPP6qmGRLZNhjKmxfMvGU4hzi4Ch1G0MUimcu_FDKawHQBqL
 kPYHNkk1Kv9DAFSHp.BTBunrEBJcjHDpV6WqjdHNYyr46E5gwLK8yEJen89SuquhVKHccjycGQ.H
 VftWuSDicyt9loaDp9uFfzQzkhlx_3rQ33SGPXt0bLvT7SVyZYTRHzF7dBP.eafBgUuIfo_cMJ9n
 9Ivz4P.K__MHVAkDcWhFrcxLRoflt06v8uxBNrhlQ5vTmY__LMpXNu386SLPpsQ4ONJmUSALYpgd
 GiIBfccV357CY0UGBxevjUgIt81SHGk7_YdrDCm1SUB6O9SBMq3.MDQ8lOKI6cNODM_1maTDHB9W
 gx3u_RYZZvteyqNz01N91BFk4KpsovbnIphAOi6svbrenjwvShTOaZtbzqdO02xacbN8TfPNlBQK
 y3WZIX8ADQioXRB08V_nj8TskM4dQ0395wEOWcb02uUl4ig1R69hLMuXOvOkbew3QvBSNSfQjoU5
 rv6DCYi03rIm9CCvE_ncGKlAsqVDfpRv8M1_Pm_K0of.1GFSBkIV9TMV7sF1vb3bTlOsYzsX3ByJ
 Y8evPTwEpl2RCCdFiBcCir46qkJskUOPYFqgjtQXmmakaIqam78MXRRzaYfYDRB6LmC4fzFIm5QZ
 wY0vNPyB1Y.xlOMHRmZMLUJC7KHn2SSnXd6ICdlDZwYFFFTvZbtwbPCbELJ_YoFtmpxPntOuRks6
 T1E5FH57Gwc7EHchYzus4r_KNfzZDL_4kJ16Ze9xqUw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 820d400e-e660-4917-af78-bf08ac0a6c45
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:29:51 +0000
Received: by hermes--production-ir2-5dd9bf4598-jnk89 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8c98858cd6f04512254314a08e32c69f;
          Tue, 03 Nov 2026 23:29:48 +0000 (UTC)
Message-ID: <fd6716a5-a650-4f5e-8501-a6456125b8b7@yahoo.com>
Date: Wed, 4 Nov 2026 00:29:45 +0100
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
Subject: [PATCH net-next v8 03/11] net: dsa: realtek: rtl8365mb: set speed for
 family D
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
index 840db5a..bed29b4 100644
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

