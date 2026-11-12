Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.185.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504950;
	b=HtDEhQHuC6BgvThSV042xSpoBxdGd0wsUw68aZyv8bjZv/ZCtAO3JXqw6Tw7E08x1VnX
	 XFC3M4nOZ3v0rFf8c+cI8nV47zy4IiAGDAihMHWJHo0HxraYtQYoHcIH9LsH5CNVdW9mi
	 FcDZIcziMAHRAoVyJUyMzNzg+h32eZZSAjS/SRTUXyhNVr6oX0EPq/sc4qVU96uQRNAfR
	 ZV07OZeoJHPpsLPmPBS4mYM9BlWwebznZtJP9gUpoYUhd1zUA4rrPpgCBiVl5sruvnHb0
	 1ezk6ea7dR+Y3vPlkiQxPGJQYAEB9B0NYenBaoMLA7V+wzb7kw+vAMbidBmy7whLclQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504950;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=lIElPgc3zQAUQPuvQ54S5XZb2V9/VuZ+xDRzMf9i5eQ=;
	b=Rg1ukixYVsJ+u1ivD9SXxoga/z3s6+vRKLyfTbb4c08LPLN6u7T/h+4UlciI8vhL3lzh
	 m+EIGscppXdZ3F7ANylTwhDEWv5ADzzqW0i70VySXiJjdo4G/TCpveGSmjezr/sfwUBvz
	 fNoVqC02keESzDX5U/muoZDZ2xlxdwMP0ilON0VeUQvJDFRqVol+0Tn1f9Iv1Dliyqk8r
	 94gYll4Ky6igTWNRCSmEa60uc+IEPqCywqlx6B4+3y93EscIP1C+2Xgs4v9i7Vyy2Jiq7
	 /x2K11c7FyYJt9rwOv47gurv65Q+9/djuELLu4PBNX1akDaPPLs+kZ/boRS+BST7ILA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Xm6wupfJ;
	arc=none smtp.remote-ip=66.163.185.32
Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD95606A8AF
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CD95606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Xm6wupfJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504948; bh=lIElPgc3zQAUQPuvQ54S5XZb2V9/VuZ+xDRzMf9i5eQ=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=Xm6wupfJJNfpS9YssZPwMl1awk844B8TijM3BdeK3uFjR4NJW6YlUW6CdMriq7Ri1H1BAmU5Mr8wt9gMTdjmuB9z9XU0JNoOu7KtIbGGQLjcqMDbaWmtCGNTpqCQyv8GfXSAZPaBxuHSn1rEk7xQmm5/pf6k5LWOfp+Yl/FFTrXnTuuiDP8xZQn4YoMr00PqVlXPIGDu1OPSkGWumUvAXtTunIApbpLuPgRn4+5zqyuM+aJBOZNEqAJQTsQ8qbXemxGSJmnzpTfgVG5WXolPcKmRH2Ffh0143Kz3ROzjxcoYrXWkVTGulOzAYqv+pA7y8cxQ/CMmjn2rjCnKOBssbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504948; bh=JzjFn4juoCV2RXHzY5eDLyNUgHgjSjFHzl0vrS86+l2=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=f4m/ndQGBQHS4aiw6X0xBKhuEeF9stfJ8btUK+uoEwoXWc0+6FvW+5OShUFr8OdBL/tOhfavKfILl8QkJ9ukiwQGSkzm9zixMNvJIM4lHrcPMSBRk4wZOnV1b2PmNbJsBmOjEsz2G2j0kQ52H1VxHBleXrFX1Ve+6UWOaphEEEOQuIRlYD7QW8s+PYGBYTEfqc0m97us1rFljYStpZpnd57XFZr5S2mgfwfZDtPqa2fkofR+bE35knHqOEhQGcy+eaOHswUGnWqutnQ5LtKuUA6EEc9WXaHXtHspji+1/TBi3DV1Tk7yIpcdbTYRUt7n9iqQqZOKdK0mRpluNir1lQ==
X-YMail-OSG: Ong5Kd0VM1k314xWfOH19msxYd7lqLCMn_oCZrxvOrS4VdO7INhvq9YARvRee3e
 yOAtIp_Nt8hyQTwvLyODM7NxwvKC0dd9ZWZwJ8hyk2Sg6O6FHTMdUgkt.3YGeJWJcoDxybGaLbwo
 xSEPBdq6B.XZ._vjzK1ucxQHO0Wc.7Rs39Nk7xi2AHPjYdNys2DXxvMAKifYFmSqq_ep.u1lZn9G
 wQKYcly1_31D5YikNPOj47oPquFtHivBK4I42CnLAheQpn.dOjc6HndkCqdWRe.7gbLb.ZsnMK2u
 lr4eIg0g50DmbhdNoupIyVCcYiKekHoDBOyDzlQWldwcceFJSmU9y7wHfK9Fd5ml5aHvzoojZ7VM
 CW0XMxlQTg2.o082Uut3UzLO8bxPLdJ7kP8WTGgSk_dxTBZXoJ7hfA2TW_Br9b33aApr.TVAFgl6
 6CoSen88llrPIlN04Wr.0f5srnDtVmplkYN.OSVN0_smapzO1WnEDsfv6huh1ID4pSWWRlXCCq_D
 saRQ5MomFnaWTFEFlmbnKeEOFznKvrh5_SWV5r85KUAlFUS6GGvFA01fuAdyFa.Urdlb3gNxQRDv
 jP6eoKjYvZnllcPbvTUP1ttVeOdlOBfh.o5CkRrOi3fEd30fO0YG9be1MYB.1I7cCTOJFG0Cr6yj
 SgKkbIC_UJ3GNWjcq0g.NCdbQs.eRtSQi6DS7yI0UBN1b1bVUPZ1v2577mugPhRIKLfsG62MzxBN
 gil3JhtI_hjcFi_72XtNQD5597VCfvojmsUKZgocmqlnV0GoEFym.NWojp56efrkYxWwf6gmxr3A
 ZWaXEViKiYE2nN4F4KsLO_RQSOcifQ.x4USBmAx0roteYGaCzC7AeLl1X1N6DBILemfYSiinbuWw
 4bpa.iQn_uc.DEGsyRpgLwph1iJtEoga.ye5A5v1E6QRUw7809n4o6SlLvQLDv8xrs_ezvysBs8g
 Zczx.f8sbgSrmbanLXbqKRONeial1o88B9L_wasOJhr9H2iT6dWZUkpBrQn2LKToqee_LUoggnV0
 _sDJjuMNMR7lHYZjh72BkIvk.KWRgy4gum8uk8XMBicErcUhBBK6JgPbmi7UTm41.e3xcZwUlaqC
 IXp_eMFVQ3zH9Bi1nsNsjjHgFNOGs.3op9CQIDIFIsTqKgRvYpLusZOd.0piCVU96fssGHksX9sO
 GE01T5aW3GAWn4zHGg2H8.hyTm0SGTKTAmUo4Iwq0GwHVpRjXRQ5sZxfsHo3Z2NrPL7G.7H5m9rE
 Tcm5HrhnYnjk.Mw1MzgO8Eq9b6wBrkKIM_lMeJEYlE2LlkJlKcow8TPNaJIxReYwi2PS_oXWwKZq
 a61sv8IrxwlpexxTBii32yDM2orcepHpHmPkH88Yusl1gDnFYu.JSg21a1bDgS5ui2yb1G.wpl8D
 0p0KdRTFEDtMl2mkhxKQE8mKxH3WKcF4wJxp_LhrMaFxU3wcbYoGG3wcQCw5.WgOfHbVBg3AO5d.
 kctpisRN01mY94veZkAEi17VwT1WBsjrTce0unkHjYmgaft6jwN_ePe1CLiR3pW1JGg39CV_2IPV
 gyrIotYRDgfXZwfoPDvihRET7HdEPxmh.MALmcOwXI6GGuftBptK505BPzIZnW1horYFpBvreDDJ
 KD49dycNhhbOrFf_K6ZxkVHeeBjeKhggZFKdQBrgy6RDi0U61hQTmbWCK8wPQgGc.4jRuUsB_7Wi
 TRkN7IBpP74NTszI9S330DB_Shp3vl9RcE18zxqZZJfaM3QZ8HuRCTYw8UBg1RLP9TpUPdxpfQ35
 ff0WTD5QvJxTvplnykuhy38PFxcd0goXXPLRJyL.KUJNlTj5FtInbQ72uQBe0grJy.ExFbAthAVD
 .XI4Oirop0mq5flwtEdW.gBk7G0T628S7wl5KTWyWIJ4fd5GXVgGqOUh.0lm01YBLJCOPqMOf7vX
 P0Ozux_i2vwfSz9icXvG8SNFdOX0Uc3nnqFhPnvEKVGqNKn_A3bQusfwf4r.UxeG5fjc0ukd_.BV
 EhSysjV0rd9jXRT4oimmcLwiPe9ZgnovWx9LVuVz.wD6EQN_8Ty8..DxAl3A_SGKyG4fcZ6dpnuB
 HhVVNA037RnAmhPh2JWzPZSkA8daXuzImcDifZkk7BdZuFCgfFIBxdXDIXHlvsjbN9Wlo6fFIq1I
 5uUW6k5c371Yh3zcMqzqdOO_P0AzgBFGU4wsYiuhcIuf7zbkQA3xgQC3V0BtbMxCGfcireVViYwu
 CXK0b8ps2ilhdusZ1MvxQWSp3vtJhGD.zGQVIu1x6nVZRHYhlZ82O2Ccu.mzSZyUUEIQNNqLfHfe
 a5NYvXKOb6rnahf5PD4vikcQzeSEIJasyUKJkgvLN
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b02481b8-19dd-429d-96e9-06b6e379fcfd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:35:48 +0000
Received: by hermes--production-ir2-5dd9bf4598-b6ftf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3042556b733bdb82afada3b444a10d44;
          Thu, 12 Nov 2026 17:35:42 +0000 (UTC)
Message-ID: <226b2171-8cfb-4176-af14-d252bcc6240d@yahoo.com>
Date: Thu, 12 Nov 2026 18:35:40 +0100
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
Subject: [PATCH net-next v10 05/12] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
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

On family D, RGMII on extension interface 1 needs three things that
the other families do not: the EXT1 RGMII TX clock delay field in
EXT_TXC_DLY (0x13f9, bits [5:3]) must be cleared, the pin mux in the
top-level configuration register must be set up, and SerDes 1, which
shares the pins, must be disabled.

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
interface. The driver logs an error naming the conflict. RGMII is the
only interface of port 7 this driver implements, so port 7 then has no
supported interface: phylink_create() fails for it, and if it is a CPU
port the switch does not probe.

When MAC4 does not own the pins, bind the RGMII/MII pins to MAC7 and
disable SerDes 1, which shares them. The TX delay field, the pin mux and
the SerDes 1 disable are all programmed before RGMII is selected, so the
shared pins are never driven by RGMII and SerDes 1 at the same time.

The family D branch is not reachable until the chip table entry is
added in the last patch.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 70 +++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 27a6917..bdc29d0 100644
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
@@ -1263,6 +1283,32 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
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
@@ -1830,6 +1876,8 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 		rtl8365mb_get_port_extint(ds->priv, port);
 	struct realtek_priv *priv = ds->priv;
 	struct rtl8365mb *mb = priv->chip_data;
+	u32 data;
+	int ret;
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 				   MAC_10 | MAC_100 | MAC_1000FD;
@@ -1859,8 +1907,26 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
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
+				dev_err(priv->dev,
+					"failed to read TOP_CON0, RGMII on port %d disabled: %pe\n",
+					port, ERR_PTR(ret));
+			else if (data & RTL8365MB_D_MAC4_SEL_EXT1_MASK)
+				dev_err(priv->dev,
+					"port %d: EXT1 is owned by MAC4, RGMII cannot be used\n",
+					port);
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

