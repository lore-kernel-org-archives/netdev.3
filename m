Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630396;
	b=DmGPaAJ8owBAROrPsTOpv1rnIa4gPtd4ugZtWRjLggp2eNDa6NLIcaZwPdytrXErbwof
	 1nGfztYZV0+WJ/UJsuRtQDS6S2/eXqbAFXsd6Ge39OJPwPU58foICHNrQfNh/GZ17iMLe
	 Jzpo8WW3L0r1HStZuPgX+gBcWqA3T3N5VLy3bZS5KWfHTULFil2YBJGgCH9f1+MeJsDd3
	 IN/0P4TPIZXmjGSa4ZhX0sUt/vQ0BinlTIFB4MwlN8uJEi1LqRl99MHs2kYvMDS9AySSF
	 lasBTrhl/z1fzZB/vCvXqE091Qx3O5hYDtv0ewHXGYit7wlc5ORnYXCHKqsTiormiYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630396;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=WPFjKf1qKcgz11+Ce0ufLySLKjsTJL9cIztNPQQDp/Y=;
	b=Mfd/eOj+aUGre4GnJ07WPBTQAlVXHjpOi44lh6Erdu5jjtzBtfAM69hJCEmuzQsGx7eY
	 iEjW5GD3BnYeiPRts4P1fkos/wKOquakQ/1tb790T4Ke7A38dMJohFGU7sIj/7RrBtkq9
	 JRp6buvnAHONyC9oFnbr2KTpUejVvwPfIVY8nmz+XMc09hERa0fT1taUJaZy3CGC+OH2u
	 OiB+2SH9FoJRpF/x+/2WqPESs3AaRsFuZ1iBDWBSZojvbuA0Q6kiGCK29m2dDWVoZtzBo
	 FJTjYgEuGr5FRahYCNv4i/RFwnaPAp+jeTbDMAgZDUu/JOT8qnEf7GeLUyVC/QtrTVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=k43EHQKZ;
	arc=none smtp.remote-ip=66.163.188.147
Received: from sonic303-21.consmr.mail.ne1.yahoo.com (sonic303-21.consmr.mail.ne1.yahoo.com [66.163.188.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD20606E011
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD20606E011
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=k43EHQKZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630394; bh=WPFjKf1qKcgz11+Ce0ufLySLKjsTJL9cIztNPQQDp/Y=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=k43EHQKZgboFG0vRTsCZ+lsDxoL1zpLypcxDlxxgx2WzF9M1mG7RoMRpxjwvJ5dyUmS2zCIYmGpivmNuPUaYXiRHegmhKshbXMY7mY+APCbWCIU9IpHnHzo+C0md6Hr8AbWYdtTYfTCuDlpH46Zjn0F6Ba3DWL50MZt6iNRkhVCOlAj6h5PUUXDi1xxlzvwc6u+CTq+bm6fVhjr0SFKTsGIJstW9X8pXu7zeC8EHHbdoxsn6QjBQvuOmg6kZf6HG68wXAn4yWb2acQitKGHqtLD2s65/1oS6hMFTMiqQN3YK6skLVzGJ/abRhgPMy8TVc4iZ2skOdb1lzuIhs7V9Ag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630394; bh=h4C9vd8KXA7MyRUNplVVNfv28H+Y4bWwvfrLC0mYiwL=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=iX/2pZRFC0r/MiIfSzlw+2zkENJMb1HyD8cqf5+V/sXo2ASIGN5Kl9ULDV3PvVZC6egWLV7UN2wp0oiZm3j5dnS0zGzYZ1CL4nG6pU8umu+t+uepIgg4DycrOzecTi1qlCoSGM3YrQ2VHmdE/aU5KuTnKDKn+7EVSOKmyyeiQjPFW1WVLPaUQXVFZzYaytH4c5LodH+5Dq+DxPTjvTSYI7r7t0HrNhSrT+Hv6KfmAOVEmWPmv5osI13lKFn7ey3ckytr0RJYdBlvu5nYn2TZPx1+tcsybbkxvpe5H9JlBp/LX7n1vO1iSc7BsKxhF6t2BQoPgrvnCCscgu6lkYLOjQ==
X-YMail-OSG: RXKJGo0VM1meml59BRvko5piglPW0QW88KAz.O0lnlOT3wh6SzB3eivejYKGjXy
 YKjB68OE3U7DrAwP.HeuoouSMIZomrGHxv0Um5hDguTvmn3IFjIKOBkdW1vD3ETHFDr96qZANVlf
 7zPEJcKFABRKLnDdjHLpblDtpHd.WfEKPKYYtA9pxPh.xc20svnQtu8FX_FyFr75pu8gfK6irbdJ
 tx5qRCd_tqF1VsLJhbWEI4U0Hec.1kV68c8osKXFYY7lKcJ2uVKSgxBF6h.Fn4OQVM2BW2_3sgES
 nx_3kMOQ9p4SiC7lLK8XN8OgvibZhh3UJjvZf_KFAfJGICVx2Qaafraz3laG6NNfyZUIJP6vOh.0
 DywbQBNmsWqtszOebMTNMiWGR_I.K_W9ZlFGZnZYlkRMprRE4YUGE5.fcOLhZXsClyY2twdLdIKa
 2jhWMQzjWEKJJlhwa6_8Soz.EGQQBH9urml0WljrNuZdDVI.Hl5wXBkPEWWEtVrnhGCxMtTq_N_Z
 7S33fQlYZ9Xqr50bnUuvcuRgUOXleHG55ZQXvK0vC_vEO.25k7DQWpYsh053I2kF4JqHgDGl6e80
 JZkC85glvCaDDZrwWcJfmSvfNtaJyjPJH86eJraOvAN_bhm8lP62_JgiSI1MUXjrZeR4A41wf_Bc
 pE4j3m2fp5JZUXkSh.UhVz9RccLollNKSqsQAa.uFlOKxDe934bQXN6SdQcqrJ.OPa82zeVT_fjS
 L3XYau0zaHTUkEgzhqh3CfBM.n9XrE957V7pGwc8hlXjCG00j_ANYv0i.4Mq.Y65wLFVHlroQ2sJ
 9mR53ip7ZpIFYdcBlaCZGuOAxpRM3Vcukt.6xEjye3KAGgHDkyQEHTJszntp1eu2D2OfOClSjYEh
 BLJO7odpBFlb3XUAbrB166ceteqLfJ04yhBYwSyeI4zwkq7dqw2LXdubVR1BDqg0QcN5fDh0YV6I
 BCS8GCE_D7DsfW8b7iht3xRUv_qNoD7oepL6QnNe3KIZfXiis1Lhp515Mqo3mjxJSHOlNpt.yRSf
 lGA5K2M08T7Vmh0lxej9W_bb8NcY0zBFLi4lTnYjdCDPlrhqe7SZqdUe5MpXSWOssHA.qGmbSwsD
 1FBuOmTdtaaLUoY262nf4i7Uh.wgpxOmlEKt5qukwvv9132z5I1ppU6ExpfGuYUeikTsQ3nmlcUx
 ou.PqQpnet2W1Z8A0mUoFzz25t7jpcesv.LQ8u_H8PjK4jfqtVbdi2TEJ3QPzyFeJ15en5aPSYul
 7MCvW_k_3hqE_0GFkbM90SkOuZKnsGExeaLC13qdwMSAJ2ENqrw204LIkbJaXIEQ1yKcpoTRCk6M
 kDgwaraapq9bTiWv7xEDzqNOH.BcTpgZ5cgmhEO0tgwEpNfrgZeuXyDkcuGWE6Pzv57yumB_sTi8
 WnaYJJpd_NKfxoqcve.YsVyCgtq1jx7lnpUKtXJYIiFBAkpWKu1KZ1hzhqHGTeC3gQcjWfMPxMja
 OS2onFfiJT0JovoGLMw9fW.1VguZFfz9yMLnPGCKygkyQjdR7q_n3dl_6yyVraVlaM1mqASJgEMc
 Gtp3QfL9_fH1rce2QfoHEiHnT3MyafM1a.GbOAK5GxP0kjd1UDruRmJPEoAUGFirnbF5bqbpWjze
 tdrv68SAptUYvr._BRR3ZysCuNAsLfq0v5AyElGIBZxKGDzXTHMSuPSrWvLHy3.2HUYxMsRoDT2b
 6h67E2HIdJChPBehA2N7bjUnvlaaZ7aEI.k57JcBvHcGwnDcw.UXbLWH68UIW_u5n1ReaDztcUaO
 vPFBmyyLAVrkXJsr9d2Tcv4mKffJrlfAQftBgK3PvtG5NcpzVWgtsJ5LjOrCLNWNk_dvdNdq13ZB
 oFBlGopDVbdYdfVKnfoLsrAVnDrBqL1LOm_1zFy2pbi_4Mr33G.3I0P0xtAr1Hv5VcVwGNqfsil4
 7MUrQSMfHjZ3OS21pClgoJ725mZuu9GqHYHU4LqPt4ApTYeeVvaqAfYXftna9TV6NYDjIU1vedBj
 ZP26abN1zcT9ZMxujBQFpMgC1Uk9.JFg1aleQqVhFn3vi8nhmvkvt7OImbvKC9FHtkfBds9KawcK
 IAwkzK.7IBOtWJJHbAI5pqgOXyUjVCDpwXYQFHN_WEY2RlAug4n__pDIqQtaLNEzNVjt9BpxJJcD
 tycvrrRuGE2gfxbPUZL59WXZLTxk.reNuTTSDmA6M0KGvzSqSgA2dPNGwjOqzlJnc5LNW1jwzdg1
 lYjHK_hqax9PGUFuGprSG0filCvNvRwCJ1i1eeJrcWgFCJ.pZUzbUT7On.Se.Py2xmKnPTXsc42z
 J96W4kytILeRtyVYvPMoBXybTNeRfgJQ06Sil6JtU
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 8df70a24-d68a-4212-9b7b-96931cd1c285
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2026 14:39:54 +0000
Received: by hermes--production-ir2-5dd9bf4598-xpdvn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c4ceeb8d475d46d01ee97ac36755a922;
          Mon, 02 Nov 2026 14:39:49 +0000 (UTC)
Message-ID: <2befac48-25eb-4c1b-9632-2f3237d68a3d@yahoo.com>
Date: Mon, 2 Nov 2026 15:39:47 +0100
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
Subject: [PATCH net-next v7 04/10] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
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
 drivers/net/dsa/realtek/rtl8365mb_main.c | 72 +++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 2dabc4d..d69eed0 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -332,6 +332,12 @@
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
@@ -465,6 +471,20 @@
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
@@ -1261,6 +1281,33 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	if (ret)
 		return ret;
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
+	    extint->id == 1) {
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
@@ -1773,6 +1820,8 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 		rtl8365mb_get_port_extint(ds->priv, port);
 	struct realtek_priv *priv = ds->priv;
 	struct rtl8365mb *mb = priv->chip_data;
+	u32 data;
+	int ret;
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 				   MAC_10 | MAC_100 | MAC_1000FD;
@@ -1802,8 +1851,27 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 	 * which remain unimplemented.
 	 */
 
-	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII)
-		phy_interface_set_rgmii(config->supported_interfaces);
+	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII) {
+		/* On family D the EXT1 pins are shared with MAC4 (UTP port 4).
+		 * If MAC4 owns them, RGMII on this port cannot work.
+		 */
+		if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
+		    extint->id == 1) {
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

