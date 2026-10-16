Received: from sonic317-33.consmr.mail.ne1.yahoo.com (sonic317-33.consmr.mail.ne1.yahoo.com [66.163.184.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB31FE47B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113305; cv=none; b=msG/BUw9rsMQnNsjWMO/gBdV7r3NCY6a94EZcm71EsJ2E86qkT0vS8yTLUMlwMR3g49yXN5XujpBL18UvNaXxwmIV4nYf4rTcO+GKVJExr2YUBWdsGIi6zJe7kE8ap/dJvZp3IDl6eSWCvTSzOR/mKbLvhEb19SqVGUfo+M/w+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113305; c=relaxed/simple;
	bh=vc4cv9TfXy6V0eLdTZ8XChpWs9cMoE+yk9vORjbehJg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ie7kcEEzf1xogpf73VH/GALOLWPT7VLH86bKztjHF4STbo3Q7EW3Ti4OweenHfaxGkyX0C+PKiC1YMt403AtT1YSl0vyjMt4F6QpiGW+t/6ky1piG3/bgyE94Hdj3hdVWjIfs7jvrHNb4AF6GHBLfmxSv6K83esRtxWV0Y/WBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tNsjv7CF; arc=none smtp.client-ip=66.163.184.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tNsjv7CF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792113303; bh=2r/v4f4+CTOzNYNcrtTt3nliQmx97miAvQ2bp6jBsgk=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=tNsjv7CFfUl/ScLOYCNPehF1DaDxO0vn7a9gJrmQQE3DDNy5Wb1nsDRNPyV2lUSE5h1vjWMeZSNbQbNnbfvwlyz1x/QHhaMYTW76ivZ4N2OYsk5JLrctnKc1K7cc03thuTgsZAbQP7eEvfBrom4FYH4JIOXQg5XxZ84kWE+HFwC+PWBJRrIvfFHantrQAaXpAzaKaziGkkA9nvPq5KIlq1+ikT1WJCrgtKedkbwlpxkpHfBkP6c8JYzRBirWWuidNvMt0f8+nh1nkoOkaE+EOOofnRLhGfBFt62A0QbAkCgs5EalnaljiCISW6XWV6ln28/epZJ6jX/Pl+Qz/jf8Eg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792113303; bh=qqjmpPHim1CmyZRUhm7mO83M5asNnG2148Zlgar350w=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=S6HuC+rHuhE7fUi8t7b/f9Dz5wGl8p3mKRki70CrmJjaLvjx0v2UZNsiB9vscq4DUiwvNVUJ0EFUvfomf9cONr2aKBbMRabTWo7Le5qNMgzZ2YUT/4saiCzzRlYRUR5moe58jSZIV9z9Q/fLnRzcVer89uJwBV2O5++QieDn0Mri+bDc4/V9Rjq+fewtwjbcBHfsi0FarB42xJxhqfbUR/Z++e9Dc7A2cYEPixHnGL9Rvp8y3aXVqa8PLAzYNSrH2D1efBO8tAzSCR134IyiJ6tp7SYU4xTnZwBakMuy0ruc2T7L21q68my87cYSiWW2D4U1L+nQnV+9HIgb7daRGQ==
X-YMail-OSG: .WYQ_kQVM1niajJ1KaOQqCVlAFecPF9lr4OHpbZoP7Te5Tx_YM7bC0dT9QRcBjX
 UxbE.qKlrKgKLlydSklEP2HDzxwQmSsyL.0xIi2qBIcyt_JwmtewUV3b6AtycBrEfz_rz8Rn7_yd
 cQAw0gvVMPN7B6.UD76XWaVOsifVHf84m0xm2dD2a0kynG3RwZpjLFtrGx0mBTpVxCybh03T7ApS
 sxiXyihVP3ndZk5LeXSqas9_twdSb5IUPa5zRneGWmi0k_PZMgzRDWKjix5W6vDEBzw0cbQk2oly
 Ayk_dntEDJG9l3YCZwamIBmt7yfSKN5KXHzvzMmKb_Xm7jumz6T6CKR6Vu4CzFdB9a_EG31GxqL_
 J.MuQftWmsGWMcaYAAbFIrU679nMwREnDfHyQvq4kIOkGZ8FhH3Z8iRpoh273Z35wW4_8DghEZlm
 flwR3kl5y5igHAOvlpBiQxzSxhoP9a7k0uoCwEx_WurhpgUP.eBtlSds0vnpXINlkU8a2LGmRdWf
 fbHsSlnq5gfwb8XZM3oX8VvpHxhvmKnmwlzEA2ofemYlEuVjoDzqAcfEFysu8eaNhKMC1n2nRIw.
 MIDkks5aiK.1xoeJzGNQTZsjZudWefz0e.rm_k9f6M8vwJJca7FLNxu1Jp14IAofdiVeQvFrkD8K
 OssLhgycQtjArs5_kVnPpQcjTJQs8FB4otje0PWxbOKE_jW7o1d4Kg6G_i961go9j5B1x5YNPByk
 tRXS4yCHxVQ.AvgdAFpceCGVIp7rrQyr.lWVMOrD.Q0KOTwMxa6IFBKDwh2ClgCRQrnFW.2q9zo5
 m0NZvbdabUlth7X1BbQCe3ZqGKv7weTar5LAruDM.0oRU6YNVMRNsZmcuynZc7Dg9JfTKGG3r.yp
 AH4SJv3U5c0ddreUJl82VshwWTaxS22ZJWphowmuP8WY.1nZ4iq9jDep3eUaR7MLVF4d8RoEJW_k
 SaUzOa12mHyYGjfYy2f_aNn3WQlnUYIRPA5z_G__1KjWyuidtbR8jYDpynBaKszfN27M.DQRMPFI
 6bRSrI30ZFCobTK1mpkOIuzjoXA34gXOx8P3L0JErgfYNwEc2JusddxGm_ynGcb5VXEn8NHGkMoP
 i.wstUhNwt0zM7aC9Nt1h22fsVB9n_3MJwU.Ya8J_5ZEGv06OcQvj_.bfIfiIRGZIXxbWPqfa_NG
 Vf.OIK_xoAQWSy2J9MNqzF.fUHKYcnCuO2OrFdf3Uaox2mcbWYvzlv3WVBwL7fdFDi2s7BiFPHYE
 Fi12tXBccIF9m63_6xGi_LMn_yhZew087PJ2MG2KJXyL5sKpoIej3lzcOXUndNEvaV6w6l0YilFP
 JNjLDd0q.R1jABhed8On_YoQJK7AZmcHj6cWkxGpCvoLEk5mAHhP6hYSUGS4Qqg5XIPna2dDXnlR
 WpjRMmLKVPgz3W66SfBs5z97HVrh6V3Y2I5sTJ50i1G2NUVZCp5W5G8laNEIw4DdR3B6Wix0oupY
 XlujvTzEHrjYgAvEclDBniv1LQj3kdJQBnqXymDZYnehNk2CWEafmtdKNCECG3JAv5C6osjfhIcA
 699nbCSfQ7vcFeVKFc1N2Y61EcLfdMcl5HG3Nkp4Xri31QkDY0zNLlGxf8MIlqJUMCh8fXLKnJK0
 F4qqA9dni_Qq5Zuv9jxQtlkZUzhH6YGp6LLHNYI0nPVnr5LoCAQDs54LY.ukMPYAqzagFzTrQ4.L
 9SFWh7JaoA55fZ045YtXrfkxLwYQ15JspAkPjAAqoJ44MTcuQZ5tEXCc6eIyF7FcxjtMDR81g1P.
 4Glw17wBtw7aL4bdUb_BWw1nIZ17Ia4jEZ_wpN9JrAw33amQ5Db_OnZYrlfo4iWhuJfmZLhq9v4d
 zvGyihmkF2UdGuY3Ms6jgFdSH7BeG0XoSD84.6NLJGiSJ3Wlx38vKEBqxVmroTVF6rvZPMwx2bAh
 pCYdNOlfst3V4.jcId4uPligNA4AIbUNAxKWuKfUo8PIMxVcNaVCWHfQXROVXoj1J4r4_izPlrIr
 k5xFD684wq.IfohLOmQmmw3TYyl439JrAyG.xP60ivhHlEllfJzm0fvPe5by95F3U5uubiVTDaq.
 ayk2ES_3kwltPsRrIfvfvfkVYoo0bNOdPl9BcgbOfICtjQ.1rhVVpi4J8z3.jqa_6A5VdHtEix98
 62Cfcq74ipQiqlkaR52JpyV_rFj.9lDbNktg5XK2a9NIJTfEGHQ1Dwx5BYDNSjVW0bl5W8szdIgk
 GZZAKe_A7bxTIr_t1aLYLcMeD_1ijslumA.7jnJXGsSbk3wVJkOa7a5Wq7lcsmPiMWDZyv6a7D4L
 KxrtOsN0cL1q_DiIdBxGd7wuF.bLovPdFQes-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: aec25bf8-369e-4eb8-927d-ccf1a4a23a18
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2026 01:15:03 +0000
Received: by hermes--production-ir2-5dd9bf4598-xpdvn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1104f8dfdca916fd523cdad120337e09;
          Fri, 16 Oct 2026 01:04:46 +0000 (UTC)
Message-ID: <aca905a9-9cc2-456d-ba5f-2d9425f1b5c1@yahoo.com>
Date: Fri, 16 Oct 2026 03:04:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v6 4/9] net: dsa: realtek: rtl8365mb: set RGMII mode
 for family D
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
interface. Otherwise bind the RGMII/MII pins to MAC7. SerDes 1, which
shares the pins, is always disabled.

The family D branch is not reachable until the chip table entry is
added in the last patch.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 68 +++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 2dabc4d..f00c1c2 100644
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
@@ -1270,6 +1290,33 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
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
 	return 0;
 }
 
@@ -1773,6 +1820,8 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 		rtl8365mb_get_port_extint(ds->priv, port);
 	struct realtek_priv *priv = ds->priv;
 	struct rtl8365mb *mb = priv->chip_data;
+	u32 data;
+	int ret;
 
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 				   MAC_10 | MAC_100 | MAC_1000FD;
@@ -1802,8 +1851,23 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
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
+			else if (!(data & RTL8365MB_D_MAC4_SEL_EXT1_MASK))
+				phy_interface_set_rgmii(config->supported_interfaces);
+		} else {
+			phy_interface_set_rgmii(config->supported_interfaces);
+		}
+	}
 
 	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_SGMII &&
 	    mb->sds_supported)
-- 
2.53.0

