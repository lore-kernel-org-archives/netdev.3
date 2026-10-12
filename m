Received: from sonic314-21.consmr.mail.ne1.yahoo.com (sonic314-21.consmr.mail.ne1.yahoo.com [66.163.189.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AA6FC5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791763879; cv=none; b=topF3FguPvfKVIpGO+EAtgwBUHiKaGwtn/wcty0T0zti48/z+NWye9qDq+hj0tLh+89MqqsUWaKbKvxemVJS/v4XNNImTk3e2lmbs88qhvybQJfKGijp0yBigzovkKxDereJTQc624BTdQ/67I8XeXcWtM5VDs6Ylebd82V5t7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791763879; c=relaxed/simple;
	bh=Pk7Fb1AZzeW7M7FKRbqjC0DzgTCdNOOOuZDBDnmkuPI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=pWLVUfdXR6vBHpfLgpPOvuNusL6zCAXrLUiNq5zzzh0FS6v04SP4VVzlkO5GVAVXnSsv+2JPzBks0BNEQeMPYd3rJLPfy80rUDpzedYpdNfrFWRvzDOrrz6bQpBY7gBbruBjtZzqZ0HhlKl0qRyEa9Yx4BJxUotBO4YHX097hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ajnTNM0s; arc=none smtp.client-ip=66.163.189.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ajnTNM0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791763877; bh=lMXy7NS+CViVo/GJ9mjOwveWeUgRdmhWsoy0QjbGr0M=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=ajnTNM0s76gtHs1874TGbz12uYalS7WDLn/lCNGCu/BJyMSGwnzDc5iaLmOSDVo4FkN9luxjYHiQqfgEyLCHSbfGIcUkmHvlQdYIZ3rECXQTlOdU+aU8dEKls3g8hZzynitPXJ2x8yb5jce/1hdQgQQW1m8e92UXLEcX26x+d+NdtLxgcq4OGa3SfNncf3ZUhupVUMrqpUfDiAus8xq1IlHP+GFgTG0SOGur6t2ytUMix6JUEZlMdMXq/d7txc4vpaXUzWpbXBshMZqODTEQaSMv44pzg6tnJuaGwAxpmjFlUyJBxAaz7bboXX6DayjTHh+k8A5qDf3bC+wyVjOHJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791763877; bh=VKp9fvcbK08TO/GD8UmAZSoG2zmnkvjsLhKGDzlkwKz=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=NJKNVnDmxXoEnHhHGi07/pftTabBAsz3nab0DeJxZmVxyzVGbROCx462fb7vnlpRNU3y4Cj+AwvIbgQ5qp4hhWvtznXfMjyhndaJronIsUDtiiPuX6y2Abo/c7BMiDMQeEHfRBsq01ajpvsNO3CFa+sXTkpzYKmdu0RU9g5dA/XP8UXCAbCEbha077V7fdtXm0VM7Zya6elekhqi2RXMwY1XtDlagAU4EbGFwWAqK2WIOv4KifOwOA4h7cW/xszQHDgnLJI2fP/AJsddxGPTborIHDVRQRudnuzPgxGdJ8fNnw2BbnqFyCEGDDtIJzcZhnJUYuv6mguaxXERplwgfA==
X-YMail-OSG: uMSjMj8VM1kLM_aluSA5lZJ_YbUSc1s1RNPjcusjcSEq1xROTgvIZ6D.9GsTGeg
 1XEmkj3lzg.hoT7XGbmlr_tK8OSwYCLUXHJN83rA5gwJMLGEA7S.1b3Du5Ln7hiwmY_dgJBgZtuY
 O9EJ8UZKhfuvSMmbG9YEz0UZjZBno6WWi4HWlCuSBjFD5uaDuqzuBA2u6eYxMMsi6gmAObwhXHVv
 6MpXG5tPIVHLnWuwtrlnii3T17ZUAK2gvC1DLME0maMolJRs5cDK9tKLRpY6JzbgFU_roPXqIhJY
 YxfjeGAivZCXingEYtZ2g6ho1zNJa4d4TAVtP1wOgeGGfac8h2joFrJBoI3OlFXMDbpBcD7VDe9F
 MSXErph0l8POp_IpBgtQYaEyOqwEftZUN__9GQkEqEzu1SCl.Djrs25V2cL85VwHVjGDlEmOPCgF
 Q.j.PRoBbLdkds3UscmfsOdChFvVBQd9_D7VRtaqLPusLBWSoHSp0fLbqsMuXIo6FKerJkatqgxc
 7rHz6suuZj41SpDpnbb_gUG5tQVZISGyN2McHdg2lwwqjut0dP_v2v9WT42_INQzBC9WkqEmhm.t
 Oy9aqeBHEeSxpk3IwIT93MWcgCtxe2CV4RDAoWzb_LVFg9oUpgRtes6g2.2n2Jw2.uKF9I1He0Wo
 0NAnmmT9tY_CwuDpP4Rp70Y38UCgRgeig5PaZZz_LZEbb0FW1aIJceFxm9WhWUsR5IrZc.zGFoo1
 JJY0.5lM_a5LSfaA1mrxMF1744K_Zuj8EJK3UeyJvOb6GmQFyt3AMYGH0s_ao96vFa8hz9dBlnoK
 edFZR7y53jcmCM0wn0IuF8KHfwUhVX7DPiUg0GsH73TVoz68tlITtPWRAVL64KvPTk0NGOm9CyWi
 Cs0IgF32vtPxGzVR6cK6ATVRy.NiLmvR8lQGAjuoAwGEcK1MF88orvhXwJznDhVWxHP5XZqPVylK
 DYESQ1VDzY8VF.QJZhjnh8R0H6U28kZnNP.K5LYsEOEzmikfW49BY7Gfk0HonVCXI3kpIweDJYSJ
 n5DSPI0q8YqpP4aGRpGiO9ij7zAfEAv4IZBWafGXqXAiORkXw8P_RuXxDDJWhH7962WSROPTLJZI
 u2yb7HQ8iRI35rFSaM0enwQJ835iUKr.DbkUNbVLa2ypNVrm_63Fjua88bDq35rEfgXbCVqjTbeq
 i2Sr0OcsbaTlNanODACdGs9ABW3OpIIOK8dh1dF8JsCFLf01P6T0m34nRTV1zHu88.4s_SqQFl_v
 e8aYjyw1yhatjYk.3aEgBeiscj_gAVgymcqw4en15NSrSBU0YqXYOeMW.D_v0RaR56VA8Y2_epwI
 41_.qlptLkfAztSSdQNtnIGU0rufBWnOlnfbTFOdvFeQzKPzWvdNCHspy1RaocqlyOGPbLuLDPcB
 v6XEC26lF5wfq8iTJF.CMcKgssmogVreQMMU9pRBCOunLIJxtGCkizpii0SWrs8sFMl._2YeSaKp
 ScGWB3DoeGXBq.h98Rfj02sX11H2SmwZT0LXMKXR_6T1X644Ee9vLShWIBe_DiaqALZRzM5uDZo4
 GmpqZB_5j725R3C7FjJA.XmzV1xw4Fp.vBp7W1XZoaKtbiJ8gwXlq2gNWcBWC5mEmWchm6sgVA7h
 S79TPLtJW81pX5jn91MZhA8HWgWZjDTbVAXzD3AfucAUJiandxmFo.HkgX5QCO_wYS2X_KfA7lLa
 xsY75FEGSn0GjLULVzu60asLG0_MqlDILIUd88wo0bFQ4dKkN.BNIm5cf29sdQus46TB6rJJ8pPh
 WPevJlgFFFxSLHX_rD51id5gVjOCNVh4F7uwL6sYxJtm0b_SwTY8Oqp3zux0Nc.AZ4GNQe.vn2e7
 ZWr3IjoK.1VzZU1yV5Sq4bYwCoAP_kHznQZI9tbGK52_I6e_8vP41wdE6iseOVAQO6bSBtyQjeaC
 0W_3r74UEeXCxl4dKkpYbCdpiN_r7s2n1UAUvf3SIaDHhWmCmYB.aCCx_TsLMglp.BTG7mH9lwqr
 7cA1JHMaqQWHVDHa1xn4C9Yv.1sXhsPuV2UkQduBPodYixImPKbdsT7bqVNcXgt7fpo3QWqllCta
 K8.RdwkEXtk07fMZ2QBZ_TLoFx9E8Uu61_jj.YGxZLWo_B8RC_Y4VCWv_U1aEsOuAlRq0bhcLSio
 76qad.UuGvNm3uoANWkhhQQlX5IZgp89nZIlDep0GSozoeFkZvFAsLJr26PnN6YsT6InKrL602yx
 VBWwdfKdDx1GjqMQ9xdRfC2PaL6PjeKHexuXMmY.jvcddv.YEEGLUOXDCIUbjK9s2IG5hP79vYb.
 Op7.ZXQ4qnvZiYzgxTLt7iB83Jzxsnevh7ege9E5M
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b4489a43-0396-4f34-a275-12c9c76b102f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 00:11:17 +0000
Received: by hermes--production-ir2-5dd9bf4598-c2rmk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6acb0dae8a9adafbd0f22a9eebe7ce71;
          Mon, 12 Oct 2026 00:11:14 +0000 (UTC)
Message-ID: <a430a30e-a32d-47a7-996c-2d63a1320fbe@yahoo.com>
Date: Mon, 12 Oct 2026 02:11:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 3/9] net: dsa: realtek: rtl8365mb: set speed for
 family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Language: pl
In-Reply-To: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
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

On family D the forced-mode configuration (link, duplex, pause, speed)
is written to a per-port register at 0x12c0 + port instead of the
per-extint register. The bit positions of TXPAUSE, RXPAUSE, LINK, DUPLEX
and the low two speed bits are the same as on family C; the upper speed
bits go to bits 13:12 (FORCE_SPEED2), so FORCE_EN (bit 12 on family C)
is not set. A second per-port register at 0x12c8 + port enables the
forced mode: the vendor RTL8367D API writes 0xFFFF there when the MAC
is forced and 0 otherwise. This driver always forces the MAC, as on
family C, so it writes 0xFFFF on every call, including link down.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
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

