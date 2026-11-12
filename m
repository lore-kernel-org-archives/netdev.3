Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.190.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504837;
	b=woaUSqAK94pbdHG+xSpd08RuHYPY3ywGMKBf21iEd9FEu7QoyEF9ZcjzGXlIpSubpOyg
	 NswdX3nx4R7YgSsuiCrSsrJU3xD1Hf+41Bj2JpJBKz5pY0ZmB4CqXaRqfsWIV3S40LRPz
	 UAtIQVTiajirPPp1mxbRUeKASNDT5lsDTPOvNWHjbGvt+DPKizGxYBgXP0/2zDrpysSlM
	 KBQLbXqo+Sn7qWCHXtZGa7HNado6xGXRzdp1Ql/bykO46sogTYzFsAbMd49w/s/YbLgA0
	 5QYlHQuq/nVgx7k7HcbuOD+jHFViXlWkjzHZ7MhkNJuJgB0U2y54O7E1Hhdr5i/c4CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504837;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=L7pc3TBvkib4rS4/t6Hn1Sg9oIIleIUohMlV43+AHj8=;
	b=HeBuQrbeUhfWc/U3lOrh/+eVaHBmdHbUHg+gCXoviVXTAFzd5mCkF5YPoP42+G7qDsRv
	 gyD00oAPsTfFNvg3iTinhUSXBPa4XMtlb63ZN1YCdDmvRJQu97norwkpCo8RQDSTmdimq
	 fr4p/REbVEBsa7Uup95y59BdrOCYBfGMccf+5niut8D7ULEoyy5h0Mtnd42GBGdUJC41a
	 /kQpR1lv7ZwdWdjiYbZ5SNxmHMq7wlh9S2qwjC969/dNz2SNkhlaRLJ85P5C4q7pTDncj
	 V3b6WIykPDLwXQg2hbBnpG1uLYStYDBwJTz4EpAq/D+xrWao2XxWyDGl43JVYvpz/6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Y+aWS0H+;
	arc=none smtp.remote-ip=66.163.190.146
Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D6606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0D6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Y+aWS0H+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504836; bh=L7pc3TBvkib4rS4/t6Hn1Sg9oIIleIUohMlV43+AHj8=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=Y+aWS0H+sZmRsigql1y6UI0oC4ffifRRGglqE2bWr+TmdEGC5DgN5EEyRcjn61ENtwN8z98YP+mfNM8cHY4tHtl/o2Og8/wYBAOcjf+aBuTNMYOr3i7WFf+MfxjxgqKDAd7Z58/obC2wQO59mmkj/pq/V9rsiQjfR6ewaoqD4+SVYojr2IrDAYmDHV7CLz013A5/l/WTDG++q/i+8usvo3JaEROnxffQxVbYgNelNNnWUCKbWUoGdCl9da/XciwsTv9B7GGRSfXDCulBLr3MWBj67t/yXfzNLB3ixZonYIG5CLUo5isaOQT/EJYyKKRggIBthS82bMNs/ln5eD8xBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504836; bh=eASkNb/vvBEHDbw6IxGKV3yYr3F1zEwzZ/NL/sv8ehW=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Ir+TrXL7ePkRBXmpzRCcKLSMFQDJpWlhq+Ubf/cg079IwvssuEBKbX+YAH698YXoB4X6KIOtfsawXqgMiBYJrzxvNQLWx3sw2WeBTfEAP2xcGJEKWQKh2PRWfJABGrZBrawQnrlOgu3TJzIXs9PkzhGmXQVFOWpygakNGvrQO6SShYCGIDQfd0/AFhE+12ALoEWODwUSeKx4i83SG46K17LBoQAtnZ4db92/RrTj22QLDRHEepKxKZKTATaMruvjdoOorZ6KgUn53Fb7bu421HyEr83Odg6X/FsW+BjBvsnW4d22RBJWhDRCSrN1/fr5rNmev15J0dzU56EF2/hJyw==
X-YMail-OSG: 9WgyXIMVM1nhP8cHfoYeSsaCexi1vW5MiALTaSA3JfyRSfcwcyHbUh5JYOObYvS
 D0SUe5BaDRi42OVrFLQ0RqsXhm9zxa_JaIV2jqQ.MiLp8XcUs7QsG63zr8PEJ_JCM4kzfJqDgaml
 1VPjLrKA8VxMxX183f28S1KfnlPAuxZOdIgD2b_fl6opSNamUlaaLjZm9WAJnQlix6Vw3_e2U_OM
 bgCxoYhmCrzKaOd5fe59PoiISKv2xfNHrpWdFihh3rs8wJZu4zBGFG6vdqFzYshu4Syqu0hiN5tc
 7NOblup1XXzAfySjF8k8y3T3LpWJqOsQgHGYRPXf.ngoEoq499Se8peuOcPspD5JcuRUmcCriy76
 9vY6BNLrzUo8nv6v2z7LH0agwEWvzh6JCT93jaUsisNElLXccm9SQUHelbSedwmJD.5eKV._ZqS7
 n2VFHVbvf5Nwr4IBgj.dms4NxkekKQysGlGp9L470h.lM_sV63rwpQcZ8vOTOJqlWDS7DgpRkt08
 A76CI3Vt3FSNdr3Z7iVkKmz8AQ9FJAexqQhR_RFGigLlLryHIgh3W9MSh4KOwASBBvA4OcVrYYYs
 umUW9cGuJKhwH21VZgZYLFJnh1UhAWgxS4i3U5b7aRba8PHNmsCh1LLYE7aD1vlJIhS2DgcN7IWX
 aTxR3hIpPUQQTzZW9ut2gKfKN1reBZbDThFc9UAFl_RUpWhQ9LwAn_2OTcRBifAR6AjYzXEeTHQe
 72wg4nwCu417rbac9ew.O3w3jwANwwVkbAAnlzVzAGc5KL2WWE.Em0U_yzHuJWDW4koZbg_DiCF.
 GjPx81WB7IORvKCjMyz5oNLHY58xqHux7YFx119FC7XHSk11IKIVW5ihhgfHz0Dt.Afl3rAVKf9G
 bEDdKOx12yqZ2H64lSKfsVfuOgBV50FFaux2cVYTjf8200QPor5sMeMrU8QQ0_1aKO3zZbeEr0Gb
 WFKkJk151kSOxVpTdWxBqAOl9D1b5a6_iE3KwJuz3XIKBinDRW.V7VcVUk4wKKmbV_RnOsHVwWxg
 GSzPcjRyDf1R8.MLtWEwn6Iz1u55XajICi76tjxpgDQhzhm324VVGi7FbGcb2o.W0q5d.GC.7kGd
 GU9zYBsAECaQhsDQTwWwi.MLmHfegVsN9xG81NSYnTcvss7HL2NpqVDqdQGyBbdd9tlyBCYK0L.E
 BYzMof9fXtK.XV5yhoaS42VY2WYT.hnRZ9TkW_aYGDLW7pg.9XI600niA4APkCxn76sDFGGMGBEx
 LQB4axbbITda3ZImEiYyYzMQFAUq6qICj1xPC2wES9LxlPRcmfxUfVM9pWLv8vuNcHLCelDItyz1
 9q_sS22kqmxG34zJhMPTjBZqiHUr4PgyEbYd_Ofb_v.DFzAhNujdSYLfwQwWWDymqMGCT51uCiHs
 Lu4MiH3GZn3Bin6rXzM4.ICc5tA1Y3LzfKOt8sRuyU9yFyNPoOqQAqAjVlnP94vJfou0j5SFZiQq
 wDaC2lheXEOy5jLuHMeN990JQGQswKACIVvwpQgyeGLJvfkkbxT4FCWEZKI_XNTutTLcheLk2z0G
 hWSk8CVIAwxv.gXHVrvvZQZtn4bXJdFNTZu9tdsGBQZttd0avedod8v.CmRtjyVE9zI1NEPXrSvm
 ae9BlO_m0Hfhs9Y.hMjMkvvV2hS0j8v0pizgvsOF09RDBf2wLuCBdKMgNYUKQG2PujGWvHGcj9dE
 y2unI13_Omu6RAFuFhWaIspP87U4ry7MwBy24n.NLshorgFTpZRydHSIria93nYYzglPnbhxorsN
 I4mtbBHZ9LqsOxe_YHlksAhVdExDbV5_ifVgO1NrgbMLOd1h1GhuSIYFw8qbqbHs.P_o74zK.AFM
 AoslzqZwEl3j4z.mWp93Dr59FchjeenWroUmC6iwDxzkzlvcpjCDx5De4m9TLvN6fcCKTBeUZYmE
 wXK26Trj8tjbwe_s5fjQmzGL0GFLm7eHhMPo_UrwdCDc5tIwNDKHTm692hE7wHXfdIRSOHjEtERM
 iOsOEYCGJ2IfvyObJodRoiis2avWHc258antmcekwmyRWhlT3EHzNsaWsdtKbUHIfSvhAQ2R2q7e
 UhtXSwY3E2OcTE.VXQDp7NqZXotb1wOW5h1gKZ8c159SKbvI.qjJt6k0zamBTmOtBDq2pGTjeG_H
 bAbEuDYzEJshMAG.g595OybgrEczjW_I9li7VjWrxKF7Z6DkGUzY3fSxB7UwfTVCheg1KeFuvmoF
 .rocaF0Qt6MenK1InJu0Uw69zjv.aBo90pFwglHSgxEqqhTTogIqc0J6enQqFETAGmngxA1pRc8Q
 MbSeKfzJ1ydvZB5evy4KHa36jbyOjfI1QfRNhPXSw
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 0070acba-99f6-42ab-8121-98f4cd20e082
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:33:56 +0000
Received: by hermes--production-ir2-5dd9bf4598-98szj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ace25387be1892f12b7bf2366151fcb4;
          Thu, 12 Nov 2026 17:33:51 +0000 (UTC)
Message-ID: <b86b9176-3ece-40ac-8fc2-75a3d079829f@yahoo.com>
Date: Thu, 12 Nov 2026 18:33:48 +0100
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
Subject: [PATCH net-next v10 03/12] net: dsa: realtek: rtl8365mb: refactor
 forcemode handling
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

Move the external interface force-mode configuration behind struct
rtl8365mb_family_info, so that family D can provide its own versions
without is_d() checks in the shared code. The existing code becomes
the family C implementation and is otherwise unchanged. The
mac_link_up() and mac_link_down() callbacks call it through the family
info.

No functional change.

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Tested-by: Stanislaw Pal <kuncy7@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb.h      |  3 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c | 44 ++++++++++++++----------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.h b/drivers/net/dsa/realtek/rtl8365mb.h
index daa8f0b..664bddb 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.h
+++ b/drivers/net/dsa/realtek/rtl8365mb.h
@@ -16,6 +16,9 @@ struct rtl8365mb_family_info {
 	unsigned int num_ports;
 	const struct rtl8365mb_jam_tbl_entry *jam_table;
 	size_t jam_size;
+	int (*ext_config_forcemode)(struct realtek_priv *priv, int port,
+				    bool link, int speed, int duplex,
+				    bool tx_pause, bool rx_pause);
 };
 
 const struct rtl8365mb_family_info *
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index e25eb7e..ef75dc2 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -348,15 +348,15 @@
 #define RTL8365MB_PORT_SPEED_1000M	2
 
 /* External interface force configuration registers 0~2 */
-#define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG0		0x1310 /* EXT0 */
-#define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG1		0x1311 /* EXT1 */
-#define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG2		0x13C4 /* EXT2 */
-#define RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(_extint) \
-		((_extint) == 0 ? RTL8365MB_DIGITAL_INTERFACE_FORCE_REG0 : \
-		 (_extint) == 1 ? RTL8365MB_DIGITAL_INTERFACE_FORCE_REG1 : \
-		 (_extint) == 2 ? RTL8365MB_DIGITAL_INTERFACE_FORCE_REG2 : \
+#define RTL8365MB_C_DIGITAL_INTERFACE_FORCE_REG0		0x1310 /* EXT0 */
+#define RTL8365MB_C_DIGITAL_INTERFACE_FORCE_REG1		0x1311 /* EXT1 */
+#define RTL8365MB_C_DIGITAL_INTERFACE_FORCE_REG2		0x13C4 /* EXT2 */
+#define RTL8365MB_C_DIGITAL_INTERFACE_FORCE_REG(_extint) \
+		((_extint) == 0 ? RTL8365MB_C_DIGITAL_INTERFACE_FORCE_REG0 : \
+		 (_extint) == 1 ? RTL8365MB_C_DIGITAL_INTERFACE_FORCE_REG1 : \
+		 (_extint) == 2 ? RTL8365MB_C_DIGITAL_INTERFACE_FORCE_REG2 : \
 		 0x0)
-#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_EN_MASK		BIT(12)
+#define   RTL8365MB_C_DIGITAL_INTERFACE_FORCE_EN_MASK		BIT(12)
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_NWAY_MASK		BIT(7)
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK	BIT(6)
 #define   RTL8365MB_DIGITAL_INTERFACE_FORCE_RXPAUSE_MASK	BIT(5)
@@ -705,11 +705,16 @@ struct rtl8365mb_extint {
 	unsigned int supported_interfaces;
 };
 
+static int rtl8365mb_c_ext_config_forcemode(struct realtek_priv *priv, int port,
+					    bool link, int speed, int duplex,
+					    bool tx_pause, bool rx_pause);
+
 static const struct rtl8365mb_family_info rtl8365mb_family_c = {
 	.family = RTL8365MB_FAMILY_C,
 	.num_ports = RTL8365MB_C_MAX_NUM_PORTS,
 	.jam_table = rtl8365mb_init_jam_8365mb_vc,
 	.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+	.ext_config_forcemode = rtl8365mb_c_ext_config_forcemode,
 };
 
 /**
@@ -1633,9 +1638,9 @@ static const struct phylink_pcs_ops rtl8365mb_pcs_ops = {
 	.pcs_link_up = rtl8365mb_pcs_link_up,
 };
 
-static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
-					  bool link, int speed, int duplex,
-					  bool tx_pause, bool rx_pause)
+static int rtl8365mb_c_ext_config_forcemode(struct realtek_priv *priv, int port,
+					    bool link, int speed, int duplex,
+					    bool tx_pause, bool rx_pause)
 {
 	const struct rtl8365mb_extint *extint =
 		rtl8365mb_get_port_extint(priv, port);
@@ -1690,7 +1695,7 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
 		r_duplex = 0;
 	}
 
-	val = FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_EN_MASK, 1) |
+	val = FIELD_PREP(RTL8365MB_C_DIGITAL_INTERFACE_FORCE_EN_MASK, 1) |
 	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK,
 			 r_tx_pause) |
 	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_RXPAUSE_MASK,
@@ -1700,7 +1705,7 @@ static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
 			 r_duplex) |
 	      FIELD_PREP(RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK, r_speed);
 	ret = regmap_write(priv->map,
-			   RTL8365MB_DIGITAL_INTERFACE_FORCE_REG(extint->id),
+			   RTL8365MB_C_DIGITAL_INTERFACE_FORCE_REG(extint->id),
 			   val);
 	if (ret)
 		return ret;
@@ -1816,12 +1821,14 @@ static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct realtek_priv *priv = dp->ds->priv;
+	const struct rtl8365mb_family_info *fi;
 	struct rtl8365mb_port *p;
 	struct rtl8365mb *mb;
 	u8 port = dp->index;
 	int ret;
 
 	mb = priv->chip_data;
+	fi = rtl8365mb_get_family_info(priv);
 	p = &mb->ports[port];
 	cancel_delayed_work_sync(&p->mib_work);
 
@@ -1832,8 +1839,8 @@ static void rtl8365mb_phylink_mac_link_down(struct phylink_config *config,
 	 */
 	if (phy_interface_mode_is_rgmii(interface) ||
 	    rtl8365mb_interface_is_serdes(interface)) {
-		ret = rtl8365mb_ext_config_forcemode(priv, port, false, 0, 0,
-						     false, false);
+		ret = fi->ext_config_forcemode(priv, port, false, 0, 0,
+					       false, false);
 		if (ret)
 			dev_err(priv->dev,
 				"failed to reset forced mode on port %d: %pe\n",
@@ -1852,12 +1859,14 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct realtek_priv *priv = dp->ds->priv;
+	const struct rtl8365mb_family_info *fi;
 	struct rtl8365mb_port *p;
 	struct rtl8365mb *mb;
 	u8 port = dp->index;
 	int ret;
 
 	mb = priv->chip_data;
+	fi = rtl8365mb_get_family_info(priv);
 	p = &mb->ports[port];
 	schedule_delayed_work(&p->mib_work, 0);
 
@@ -1867,9 +1876,8 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 	 */
 	if (phy_interface_mode_is_rgmii(interface) ||
 	    rtl8365mb_interface_is_serdes(interface)) {
-		ret = rtl8365mb_ext_config_forcemode(priv, port, true, speed,
-						     duplex, tx_pause,
-						     rx_pause);
+		ret = fi->ext_config_forcemode(priv, port, true, speed,
+					       duplex, tx_pause, rx_pause);
 		if (ret) {
 			dev_err(priv->dev,
 				"failed to force mode on port %d: %pe\n", port,
-- 
2.53.0

