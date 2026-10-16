Received: from sonic310-25.consmr.mail.ne1.yahoo.com (sonic310-25.consmr.mail.ne1.yahoo.com [66.163.186.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76742820AC
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112637; cv=none; b=Anix/26JAOKZz4oex1meC+8YnAHt6q9y6mJSZMMfvd3MSw0KXDtnxAlGv2egjj0pS5sT+f+2dov3F8g3xbK99CuWGtVZloMvdo3fKbmqWuk5OgoHWcc0qo1POm/zMTg3610c8ZO6C9zBJPHXWN0cDRNz9EOxAD0QbGL/v1F44yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112637; c=relaxed/simple;
	bh=Pk7Fb1AZzeW7M7FKRbqjC0DzgTCdNOOOuZDBDnmkuPI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=oRfOKCPujgZ0o0VTXlHvpWxex0ng2IVdfH8DU765saqeaDo1xof3+/3txgJFCtvjJbhzmI4UgSZUzO5e53itb0lZqXcO4DOyN9ZPfmjQh7EF9Jo3YsUcPR0pbZHgvrd+Dr4Ahw02hdGNSOCGIq4LkRqKl7MoBDjhyGUVYx8ovp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=eo9wLN/P; arc=none smtp.client-ip=66.163.186.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eo9wLN/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112628; bh=lMXy7NS+CViVo/GJ9mjOwveWeUgRdmhWsoy0QjbGr0M=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=eo9wLN/P5ZideK5ErJTjjA0e5CqjwpMvz0BKDEgSSdV9U5icndLDNJInGajucWFLdlNDTVcUO7D1Nh3E1fa3Oik1hJz7Gr63QDF4Xa/7NtllZqWKeWbFzen4ff1OkhjIxNOm5ft1o6igkbGwohM99lwim6P3TYhBD03fD0Ps20ciunoytNe+LfGMyqGhEL0zAneol5F6TLhnu0rgQ+541AsiJmcfqlfICpUtMu2nkb5YcOU4lbaFq05HS658eOMjfjoJ+ebuNY68zYj6HnzmfZpWq6SU2U5+9gb1vTGFSi1saaqexxe2qzKfoNKDj/uws4m/wRYLu2eoemfESB9vWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112628; bh=ny7nGMiC/vd2BeQe0r1/rVQz37M/j8RW7cZmm1zI94p=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=bK5lJY8WgDMARGJ7Wgn/OL9K67KuW01GMoItC4+X0LcuaWlL9/qjucFZDKuY7I4ulbo0GfdWMF4+M54oKFHjCj3dfhwSZncxoGuom3Y2K9IfIV8rXSBiTNLdIQT8JKNnHWOX1RWsgZhUlv9wRaqO42v1Fr8YsiKdfkhK3NOiK6MaOkWcK5IsKfDpBl5bLZyCaiganDtjxszBLhOV7FTptz6e7qzb7BYwZp6uwfqCF7Ya1inRquHOvip+Z0+t0eivJQ/lIBDK1iGH3CD/legwWuUC1bOLoBe+nhoZJUIHo9FV49W7ERt7LSQmqRD7RqgRxIpJP0keXQ3s9qAVjDq8iw==
X-YMail-OSG: gHd6ZXIVM1m719x_fS_Ka2keIVDqonz9uLxOLGd2pJHFEtgWmrDKVhymgx.AzzT
 inutMyWBgBd4MubF.ct4Ue_U8xURIXWT5GpgUKL2azIYNiVqMT9uMKoL8TAOHyYrvSTlQF7tt88e
 0ISOPMCB97m1C3Kj1NxEcji3IKMyQLDI6z8svWgATL27YLs_IWEyg0rCmCBi2nWYu5E_Uqsv0tta
 XZy_N0mcPFFS8WPPEIjxqL17TJjEISGzy33YaSxslXaTP8Lb7JmTL1VLBHI14vFaxONAso4gu1TR
 FPcIaskQGB8sUFRqhzwMiJRnNjFrsUFwRj.RVgCiaG3zr6PkUYsQ9ZYjMJmH5bNzfrBmIP5PCbkl
 Ztn6Ln7xXwgFQ.HRs06qON5ZDFz.aLQFEQWp9QCcXBz8d5hclarAp4loEQBgXPBiIx3M7mwHTH42
 T.e.y89cWQVogDa.m1fB4j9Xac9BZXncM3k.IGZEjxenE3p_xYfpu6wolnmJ5Cos4jUGPSAm4p5o
 vtAZVqPjs8U4MNFKcuFt8ULsxa5Zq.gWw8s_SDmicxl1mNHj72k7vqi95oSeD0e0K9N7oDn0zFxk
 If1s48GX2bW7K49M5pezHMpYKpWdv_dXGsTNZc_H7IgJ4_Q3dEwADY7kdz.tBkbXsB7qq5ugQ_k8
 3mR2eIw.ihC6GFuXp8syKGEn1SWQSlMYWmUkL3rRzv4QweS0O7ojRuKkOzXvifADbKXfD06Qfxoq
 C4t63cGJJGSLDihHfOqH8NszztY_EEjtbQR21ynoP0.jKhOl3F8NoIy8x6DKOWr2oCRBtQVEnjzr
 obdRc1.tNxTcC37M8YOG2E_JmzEOsnZJImE8dSC07dNXdhYatgz7Fqhw0e5RhJMiz732eU8jL1gv
 5hCwk87Sd8IqrKa8mCXm2jJa884a3roYTMMjLixHQxI.GE8hOu9qTvW4Cyf.KOXes2yyg_dX7eCY
 HebCJX.TP9ZlCOLaE8Ke2yMQxdkjni.nEPx2XaVXCnP1nW0Q5he0FOi3tw.LyxTjnGURPcs89Ztl
 rzEdAFiVgHBgQ0EYY5_8NRFgsGvrFnayrhFnzPNk29xB.2UN0JS.rRh8LKpI9sRPEZOh8QYXCpCn
 FxYjiHRI_LsSmEdAE0F1ImKCRWSquRb_GAam4jGGz2jK79RHyYCCoDgbNaSRDkVauVnri4or8OZH
 ArxANquSCzJC6Pt3m.IXvDO2IOj81tdWU1OY6unH2ZR94AXcm.EeRs4IPmEgKyFEXBDyHZ1t7Xit
 dAcspfXiaiGYOSY3cDU_MzbUy1RhlYe42f3F7pd_Oz_96X644HpI5AdOv9VrOZulM32uM1IMeUrz
 JlW8574r_xP8XWC44Wgl2NrjsrUdYNAya7L7VA2rpMqEkLexM4aXI02_TfMX28X1Lsg0NTxxZJKE
 4aLpDTsbQTQ.6pCUoKhduXYFSN1tDg3FIK.wGxe.zc_4e0aIe0quaitV7ZprqKpxiCzH5qp9R80.
 69GOGFTz_KPdOMDh_Qr_LIQo9uUGVldvjj2L0yJi1V9P6nDIVJVZP3X2UmYVKgUWaeTwfOfghpzf
 d2j8DnuMskVYHXFrIC9uIL24gWHWJdy2JX35LKKnrbuun_7_oKhovb6S.ZLcb6kTykxpQI0AXHSS
 Cd2e45gm_CT7QNccQ2l6kzQ0zr0rCTvrj7rjwzsCaX98XjVzRMnUsT52I3tXhHyNitTLb3FRj5YP
 ISo5_zV8hXDD8vDnFTIdEaf0i.LDf0LBIw3IX44v6e3WNbctG0Vc_p_u9TT44e9WYSVm3NclyS6D
 BxOm0_xWF2Lu0c7brXyI9m7Z.m5XDLcgE14_qtqu3ArWPOFcA2icY6yR4WqayY3Pljb7f_YfCFcK
 apjUlP.l3LIQEmUUPWghilNRty2DnaeQNFG.1Hui.aHLpBjlOoQVxyNlGkxful7jbtqkRnmvbgGt
 4fxS.x7lif7P0JHdRr1JqIZ0cpMQSzLrErayPRnLJO.M9TpT0BIW7.dK6fz42eKHNQ3bYJdFLowG
 CaxQCIF5VbT14A.jeFEMHFFomUwLVl4dgnB3_PtFt5Z2tDwJaRvGmtlrPI.aSbXXV8wekkTf.LLT
 6qIbD7RTggmqlp2sOEiUu0jbvrwQEgAX3GXt2eyR2jdfj__w6uB1PTQsqmzJSDbP7370Ey6wi_4T
 Hd27tLCyCcvfzRVhHWHiRm6HTECv7IHolH7nkHDbV9ocUOWaB6aaBST9AEzqFILgRnDu.zeJihyQ
 BuPNIUzm9xEi3xpO0kpiroN6BQb9kGb_vK3.ffnfZdys3Vn.hLirIf5aVdwnjXGNvXYnhxUxUoXJ
 yWWcGuzhlr633NDH8bwzHNom0OVCMiOnWiA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9f451eab-13a9-4717-a3e5-b56c054b9512
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2026 01:03:48 +0000
Received: by hermes--production-ir2-5dd9bf4598-bgsl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0c66292a91fe4d79b04ecec5a6cfaf87;
          Fri, 16 Oct 2026 01:03:46 +0000 (UTC)
Message-ID: <75829f0c-69d4-4c16-8300-142023f840d7@yahoo.com>
Date: Fri, 16 Oct 2026 03:03:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v6 3/9] net: dsa: realtek: rtl8365mb: set speed for
 family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
Content-Language: pl
In-Reply-To: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26740 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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

