Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.186.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749066;
	b=HUcSfO3qclgsvG24SOGMyZnlTJbFmVd2leYj8bdkG0j0WhQYrKFW4/hKcOjAKabkASeW
	 WuGzVmU9YpC6NQ2Syc7p7P0zjOW7u1WB/5qmtefgkdGGz9yHSmtoxzwz1f6iGUkh0jE2h
	 PtbEC9TE7b/r3/IEMu3OD1dmqWrnhNuwWVNoXPL81e1JWgTYMQKtutsm91JbppdQyXQW4
	 8Vg1J26Y/FN+B0/uOCl07/fWKUOY+UU4Xz5+4VM1OhwPUq2OTQChgLj/SAqK4vtSkK4xM
	 yfnhKfVRc2UUmqTp7TwB4MHi+cJhQihviXBa/58dkmoxU4YNUsMdX2W2QUcjWjkDenw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749066;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=7bb/iNaYr7YMZ/NIJBb6MuHNrWUyPIHQofrFrJhOIx8=;
	b=PZ9jELIj/K14Td7o8+TjdmfJV2ghhCOZobf4mnVQrpTghUsBnWTTwOjetfLxk2cLcCmw
	 uYFAgN6wOSXw2D6PnuzsHzhGiRM5vGOQZTKsvnXs/y+KoWhv2rXW2j2PooZajt/ES3stL
	 BHWEeCsBF/scsoc3IgeZdqLWQxdy01vCt6kFwFW1zhAQpo4sKvh0j4C7fPWrFi/jB8o+l
	 wF7+ZLty5bUW8yzzvW4yrzlYDisueLGQOrS7489oCDZWaRmys4Fnsl/NF6AE57vKU6xxK
	 FDBf3qESFYVDk4927RUlVZy+nrzz+RgY4K4Fx2cgLiU0/7CLWS/SnA3hNBRuo7ZAmFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=k2nJ5G1U;
	arc=none smtp.remote-ip=66.163.186.148
Received: from sonic302-22.consmr.mail.ne1.yahoo.com (sonic302-22.consmr.mail.ne1.yahoo.com [66.163.186.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46C606A33C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B46C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=k2nJ5G1U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793749065; bh=7bb/iNaYr7YMZ/NIJBb6MuHNrWUyPIHQofrFrJhOIx8=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=k2nJ5G1U09/HvpNuizhCcFGb/O9kZL8R9qy5ocXLerwErJA/TDlQ8TvK9cEDafGSORq5LfFq8rUOFBW6aDkvfPMUqv9DoZ6NRAPWwk98UBAwART+684lizVwLkp8s1CKf1SzaJZSeSGqrY+KuxsQblZLvLMgE8w8vm+SsiAe0YAkFNjNTrsH9qeCKCqPpNUncusRKP9NicprdX1bQtW6ZkiIosWZJ/VJffUe0zbP3QcVdNHATFdtvq/Fgfujws4crzFKpDx4K/icggJrBhL3y9R/E1w/BvIcxmvrtjiyws1kROA8nFuu24Imj266BI78xM4Rn9uckztmP0Tu4swL1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793749065; bh=jg/Ly2s/M7rvQy3oOd0HsYGx6tvlun8yRon+b+D5vxI=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=W7IIPP4gxeBpGcShpxtBZImeefDCENW+gSpTZEVAxCV2owDfZ4TC+o7WABzV0ScUAmON7972RWqLoBJs+PVZiX9Zgbs/uE67jAnPrse6jKNEFrsXkC9BJNE6NhntDf4isKOjxmNy/k6x4jNXzQrsOWoJt3vvdHZ8ZkFtyLDIZO1HZicWB43VM+pib5XrWAGQFD53srmNNAKglxeYjwEcLst2PhU1D/8UONMf8GhbJ/imdgKpojEHHY1xFhzSri7nnJ9ieMPpw9qeO2bW5I5MY4F2mXuGXnkbDbWX45ZNhYb0PvUycJXerh4JPsa+IjdmbGDZ3U71BS3BocyaerOdJg==
X-YMail-OSG: u70G4qkVM1nqT_tco6IkCdQ6kZNHZQQwU01jj_YdXiUuI3GVFN9dhfYiLmUvMDW
 TbCXJVZq7VtUfTpcKtmGbclIEv_lWVY0FL0cTtEe6Dzvf4yLElFswVb_lSDaEzt94c4_knVxUh8k
 0ycZCNX50mEs17NKscAw3cakGQGK0hOZrveesa6QQ_mngF3m9v9Jm0y7KJUN9ovDPkqm_K0lZmOi
 la2yO9t6t2HAHcIXy0hJ_tQC.kzAqxaP_LhaWQ1rUbVFIKiNL9LLz1W2I8lwJ1CUyZJ4z.j88Dkz
 vcjeDyhzPi_8E2t1sJHtAccY1KJtqHspcxjFsmOZVdDNshxJ7c99QY61fA4Z7uU8tmE4_YW17Sss
 susf03T98DNAD.M.zA.J7zBTDTWypYhe5GFms1dFyAStA3GFQgY9eoCEGK2LKBzGeYFkZMCSEnt_
 u8GSz8NfEA7riFopG1uz7O7Wq87m0h6kNkphzix4hBUvBUID4OyQIGjWrf1ncUwGtfJgzOYQ72m0
 iupSSikbGCIHt05Mwx6atXDINgVP4A_ZSaIYQunZBqWkDLNKqhk9itcveBJwskeWuYbUl.iS62Se
 br9ObZlNYVrc.YJBxdVZzb0KI_GejQfJPVkH.9rwDlXm3Gvk09xzp_OIGBCIvWpopKjjYZYfI0tw
 NguyB0Df8gwn9m_eQcjjCHTMfPl9kgjmAabw1O3dbzAn.ieHIJsfahg3d9S0Jo2xfZ.WXUNz4yCW
 k6psaF2iWLdg2aaKT.2HW.FFJW8tc6DSPnXMP5.mx_6wN7Kg_4jLBE8swxE4tcBlzzXdH4oF0BAo
 ou4dCU6NVk2bat58nRp1AbMAtLmB90HLOZVsZaSdxV1JlNUbCcC3t_oqu6lHPgHc2209y.WAYGcF
 _DodcK9jzZfTP1Lu13RqBCZw_Am7uCST5HbVIqFNbh1YwVzjxI2Ylcc7daMaXhuhZdnF6bBjrGdT
 HBaZMHRPcg0diSzzIQL5zbNhBIk.RtH6ZMy5EW5S5JHN5QHxGlOvqjOCdXQ3c7IyxY6PPV8tnQdX
 mXmOVo48zj.az6AsZob4ACB20q7BZ7C_ZWO.DvPehMl2oVCXVwMiduiXFq6ETa4IzvHYawfNd91M
 X84cTk3nYkO5HC5qPP9i0jKkf3mNbEVubNIzZ6OUm4yqFTqj4UCOcGWqkkfM21sMqscGR.3sflSS
 D5hS3.ZuYiiJaKEohkkaMp1cir_O7waAUJkEE_j7h0AZm.TQZF14yqXMVyZkfiEI4V2.nl13d9S5
 N1tTSMPT8pClPN_TP3IlQamv1DoIGFy1OVANFreicQOxDqoY8CyPAdnA4DktuehJ9.U.saqLI4ec
 0Ftb.SYmHYLysxAzuChnaMIlXpVP9c6WTpdJZ.O5cpMTnUT3457v9VKAzFVyDEz4ijLCSQzE_3JC
 qrIdc6n7qJCouVUuFZ24SZITbsyJ2X1GmTtb4fTgaprALlmrwjQrwW.2QcGxJIX32t9J97QxBw2J
 st3atA_flNYkkJHcNWmGZfdaQaoK1S7SatN.0s52HwDGMFjTmHvV4Lh6YP99wkxGPf_5EXuEXYeL
 SAUmgwkNL1Ut9DbF4ToJeeZDOS_wMkm106JSRz1wjMDOvqPDuXbH5_dXWc1kJyW6.3Q6Qy75lcSe
 xFbFB_fClx3Co.wXHzuLuPIfSLpyFIQ_dnH9UcRMuHHxKP6vDJEA3gEfTV6lBcFA1Mrg3nOrrOrw
 Vie_BwguZReBCvg1b4SUlImKiTnO438jmJcsuYmTO5XqDvnj1FfbL9LOzncNnz9QpqitXIEsN0Yf
 5zAMV5vCzlGS34F6DJ8cpfndgIeD9sHAbmjwsQH6oEuaQfLdu1mRwg7oPW8aPaVvwboiKEsMM3Ax
 nOKSalytN3I14LPdBMyJSv952jKeVI0I72q559bvCuAGAaQQBXMgU1PgqO1jJ0KTR9rgLbYfg1k5
 nc1FmodaL2u8Bn2RQ.to09NASOR1.pZWRgkJ7KjZRqbxyiVEcceqLCkK6IDP_wd3bJbYHKRd0SkV
 J5Z_VtZyuSWsgZRv2rjgHlf7MPD7YnpU7JWU2DJiv9DWO67cavxHkoIen36rDExCz_Gkxf7yeahy
 u4vvDLi1G8sQHhez2Og6ZJJJkr9qHv6XThgC285LJr4lb8YU06z_a90YgIoXHMY3oGOLNJ6eccwU
 fEySBknPo_dzufi7KZQdLkJgDy.b7dxAJ5BqBi97Ct4HUDWVHUrRfMBtscKWv5.ZCQ78zQCpxqKj
 TfgjuxSuZ2cNpD_ziRRytxfX2R8RX49gO8pD7qKrHsGLGRETPM6H8W1zUODl9DMPcQ9W2rYfCA47
 jV_4PGqAEvW.xY70q0gcciKATH2VeFsEo9m0YJ3z0Pg0_WFdZ.vQ-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 35c52983-ec4c-4de6-8e39-874c9072d13e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:37:45 +0000
Received: by hermes--production-ir2-5dd9bf4598-hrqwh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6b8ddbd127f372bc1489dc345a876769;
          Tue, 03 Nov 2026 23:37:41 +0000 (UTC)
Message-ID: <e28146b6-3f0e-4553-a0a7-72ddd96a4444@yahoo.com>
Date: Wed, 4 Nov 2026 00:37:38 +0100
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
Subject: [PATCH net-next v8 11/11] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
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

Add the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the chip table.
It is the first chip of family D, whose handling was added in the
preceding patches, so this is the patch that makes it reachable.

The SGMII/HSGMII SerDes of this chip sits on port 6 and the
MII/TMII/RMII/RGMII interface on port 7, as on family C, but the external
interface indices are one lower (EXT0 and EXT1 instead of EXT1 and EXT2).
The chip reuses the existing initialization jam table.

The chip has 8 ports, not 11. Limit priv->num_ports to
RTL8365MB_D_MAX_NUM_PORTS for family D. This is a functional change: it
sets ds->num_ports, the IRQ domain size and the bound of every loop over
priv->num_ports.

The L2 learning limit is the same as on family C (2112 entries), as
given by the Realtek rtl8367 common API (rtl8367_common V1.4.2), so
RTL8365MB_LEARN_LIMIT_MAX needs no per-family handling; only its
comment is updated.

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs. SGMII has
also been seen working, but I no longer have the exact link partner and
speed it was tested with, so treat it as lightly tested. RGMII mode has
not yet been tested.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/Kconfig          |  3 ++-
 drivers/net/dsa/realtek/rtl8365mb_main.c | 32 +++++++++++++++++++++---
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index d6eb671..98b1727 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -34,7 +34,8 @@ config NET_DSA_REALTEK_RTL8365MB
 	depends on NET_DSA_REALTEK_SMI || NET_DSA_REALTEK_MDIO
 	select NET_DSA_TAG_RTL8_4
 	help
-	  Select to enable support for Realtek RTL8365MB-VC and RTL8367S.
+	  Select to enable support for Realtek RTL8365MB-VC, RTL8367S and
+	  RTL8367S-VB.
 
 config NET_DSA_REALTEK_RTL8366RB
 	tristate "Realtek RTL8366RB switch driver"
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 6e52344..46c62a8 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -89,6 +89,12 @@
  * things will work out-of-the-box for other chips, and a careful review of the
  * vendor driver may be needed to expand support. The RTL8365MB-VC seems to be
  * one of the simpler chips.
+ *
+ * The RTL8367S-VB (chip ID 0x6642) is not part of the family listed above. It
+ * belongs to a newer generation, which this driver calls family D. Its
+ * registers differ in the VLAN table, the external interface speed and RGMII
+ * configuration and the SerDes, so the code paths specific to it are selected
+ * with rtl8365mb_is_d().
  */
 
 #include <linux/bitfield.h>
@@ -120,9 +126,10 @@
 #define RTL8365MB_NUM_PHYREGS		32
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
 #define RTL8365MB_MAX_NUM_PORTS		11
-/* Valid for the whole family except RTL8370B, which has 4160 entries.
- * RTL8370B is mentioned in vendor code but it might not even belong
- * to the same RTL8367C family.
+#define RTL8365MB_D_MAX_NUM_PORTS	8
+/* Valid for the whole RTL8367C family (and for family D, RTL8367S-VB)
+ * except RTL8370B, which has 4160 entries. RTL8370B is mentioned in
+ * vendor code but it might not even belong to the same RTL8367C family.
  */
 #define RTL8365MB_LEARN_LIMIT_MAX	2112
 #define RTL8365MB_MAX_NUM_EXTINTS	3
@@ -895,6 +902,19 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.jam_table = rtl8365mb_init_jam_8365mb_vc,
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
+	{
+		.name = "RTL8367S-VB",
+		.chip_id = 0x6642,
+		.chip_ver = 0x0010,
+		.family = RTL8365MB_FAMILY_D,
+		.extints = {
+			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
+			{ 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
+				PHY_INTF(RMII) | PHY_INTF(RGMII) },
+		},
+		.jam_table = rtl8365mb_init_jam_8365mb_vc,
+		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+	},
 };
 
 enum rtl8365mb_stp_state {
@@ -3994,7 +4014,11 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
 
-	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+	if (rtl8365mb_is_d(priv))
+		priv->num_ports = RTL8365MB_D_MAX_NUM_PORTS;
+	else
+		priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+
 	mb->priv = priv;
 
 	ret = devm_mutex_init(priv->dev, &mb->sds_lock);
-- 
2.53.0

