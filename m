Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505345;
	b=axtDaauIFy3IkjvGDXMtTvdZgmlqnuLYFGMnMHZ+8tx/HpA76TtxDHAngqfjwmqpoJgt
	 oA/jLXmglw0IO0sAwaGfFcEEfMwyb9++JvTpl4FRzyJj2EQ3ec10iKgpNBtLpdF8peJPC
	 FPe+uV/rqc/Ry9NEfxsx50nz6tAqwJ/+F6IT/P80RGswHPevA+vidfl1+VdYTP3g3S4xT
	 0RRmpnj40nlyv23oG7je/Ic4wzQoOm2cchj0tsYPfboXfWCVqfu/UQVmkO7YAR1T7/wpb
	 HrBx08KJZzMhHuQVwIfEgbSef3oovtGfcvUDJH5XWy6n+PeygkLkyc3c+OJD68p4N1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505345;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=V65OP9gOQppPp73n+IXJnhmVVdrAaHK3diQGSPp0P+U=;
	b=JwHqRSSZwGlv0G5M9oHze6jmHryANmtGv06irGY8ws54crlQ0eUNJNnztCkKTtOtaR62
	 YbeLKlskwmN3EZ2TQmzuUJlmZ16XKjlxm6IMEbV0MA6060JLqC7mVOiMHCBjraXGGABZD
	 frvtTuOUoieanHFcbaKekGyYUYvbUKcswHTe5HjKsfgZdmBXi5NPNBdCKcQ+Ocy8YdUAh
	 33fi9p9M2VEg109E/I1AffTbbAa5TXIPNuxuZDgZ3Kh+GkNxL8i7abIl85Yun9dehKy7E
	 62EBZHK4Djbqp438bfnQrms9TK/RKy6bE4uise/ac8wi7/+avAhFF/HXCYoarE7OwcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=pYMEPU+o;
	arc=none smtp.remote-ip=66.163.188.147
Received: from sonic303-21.consmr.mail.ne1.yahoo.com (sonic303-21.consmr.mail.ne1.yahoo.com [66.163.188.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A9606A33B
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 182A9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=pYMEPU+o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505343; bh=V65OP9gOQppPp73n+IXJnhmVVdrAaHK3diQGSPp0P+U=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=pYMEPU+o1cifchIGpPq9zEuA/xRLq+7lietluxeOaErl6dUIBHQRyW5W4uuDZ5pl9HPvDVT3IvNTFn3wkbeovg2XQ8EQ0elNWutKlfQSSJPcljqsJEbJDSJ723l8/YawpE9H5C4lWo2dAzX7RJ3HZ3ZLl+ylRlV1p8NPSJM5D3WcIz3zV2rs7iE33Roa8TtzenjuGT23YrmkP8YcMJ9K295WKfg9tl1r0YIoCG41hfmFz646EWqA12PVpAfsWVQaYqX4P0bcjrVXX3it+t013dP5zDUMAv4e2ek+X/D2v/imnv7B+UzNyqc64TuprRhwp2kC3B8v1TlAexpIL6BvQg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505343; bh=8080z0SFyTX7ZnlX5vheJ/AKgHRGVCsy4om4EF4HhJw=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=OVpNuISUNBTw4KRSwB4NtV9IztMWX26sX58rBcQxKhAIxxrILznYoEHEiZA1V5HY9dUVB1+GmfBEsolSWS5fA1hFdtfZqZaxCQPg1GPfayM7D4CiSWecxlqmVhi7Rj2c2o3XdwuYMNoiGS4Wb9zMJE+AxrPvK/oEK1uw66KJSMxKKXgZsLYdkuZpZMD4len17bfyqHLDH0WL+VP1aayQIos/i9T3cUpbuhTvL1Lqh9N828OLBk4ZHl9uIyE78+0ekg4V4U+AK5WIS9hRYatz9i6qTHpbv+XeYYt1l0bB5r20z7WG9/8a5evJBsKinjHLWmOx0qakZQHGkwF+SZFcew==
X-YMail-OSG: _paZuEIVM1np1a.8N_N77EFqoBl5lNiQFLLRXZJH2IYgfrNFLzARHUgQAcwiywL
 QSugL4xefZFRAEpoNehcrTbAB7NUFnUjixfOrS2dfLNFjRQAiwM3rkr0g5aKabAAbd65VjE00q4D
 zipzqBd5MgFBVKKvUuqXW6qk_ihzRqEYqBzEaDhAE8NE3a97aB7Rj8ibhbAECEMerlpTZmzKHo.h
 NiFn23t5UZ8zB3LDWD8JCMwoDJUtc79Eny88hccBSzZxKXxBZEUNX9ZbAbRa_pnP3k_gW04W81ab
 fG.szxsTBXcGLhbCtg37n.D_4nyrHj2mflJD8.Yo_3TGEsTWIR37g0JLs9tyHyK81Vgi5sqE9Qfl
 28h_AvaHitoKpl2x1cNdzHS2c7cEvwkNXq4Y3YB2vKSFidaQlOuaA8fP9ouLyTk3aBmQGHEJYir6
 KnDSSGBKET3YD712wrT77u9LXO6NU6qUWYPOHbCjk8rBUPID0ri027e_K0uYjI68PwucXPUeCBpx
 CfVbm5b0KOc9KynGbtj9SV5DU.G_rTWOg3B5cacGsw7XaJ41B4GKhw4cO2r_KhvFZLch5BIvHpQJ
 _W3n2ZpFq3FkM.RtjRyMNNp.GEmCb5j14AOlExJ7apU9ANvmD5HZXphzrLjC.4o.scwG4JMVrD4C
 WXfuORP6FaAe.HnR22XISEAhlnEOZcz0MmoRYXqznV2aWrcrl.PI_Dw5UM8kPQ1PCMHdO1WgWWKO
 f.rHVkDg44PjtpbGj9axa.AFlQ0pAWJ.caWxI2ANPXq.DPSxVCnCBjununC5NaJzofL4nNiFwMjE
 bMgaW87hRiMpvoU8yuCjBXv_223e69ZobvQnU2IH8Tp3iJ9oon4zx7v3JXaAR64EefbyYpUYaH24
 i..j9YuBZT5CVpKImVGRci4n0IhbP14mPTRW3fwvYFCLRmOmK8O4MTxyT_b7fcJOvrzOupCgJDbp
 HD8ig3WoN9F0dvAq92F5gVzoLfW.P7Lwuy_V.3F_lhnT5g5h1bYO8lP_bPyALguGYf_mJjV3E36W
 Jzl0zza1A6.PmwAY4V0gkgqNIVTQkUGUly2I6j.X0no86cNNKbPiuWxxIEzrx9o9n0DiiY1xWfMU
 YDMKv5faoR.DImvW2Y9TE8s5.yyStrrRyR3N83E8v3TiA8rLJQkKglKo6ukCNnhts98QxvikYzne
 8U_0wVrXjNc_u48.GSYgiASoHkHrdq7O5Xcj1K0NRXMT3Swr75EyM39MCh4et4hHBKfpcR_EixIL
 HHa_PT_wYwn77aYMY0fWzzIgfdMvrWbTJqFJor8pAHI1Ip614Fqb_PzPZL8DSsfuC16vSyI_YJyP
 a0h_aPQVFDzi4YqRPNZEGpRevi1dMbrtBswbCClwDUHAn_00.9Q2zR9TuwiiUk5Dvd.qLhh62DMK
 PxlAFhs4GV_8jJ_71EELHLMQiIq5SG9xKUf6A2OO2qBHEOkFuojgRDA7mlKfFTaYmn5PaHnQMDpD
 fiTKKotIhj2RRdhpd1VQq2dkhfFqTfN3wzHG7Hx7kk_iMRxt67Z_1zhEmK0Uy.a0tK0HffGybhoo
 TJd3CUyj.U2GnVNi4mIr3B5xSQzsNh7IcNMTeg7ajY_asyGn1IylttmQBhFMWfeU_M9ybWQ_b59g
 bN_MiIRxup4C0kN2_mgm2fwkZBKASDhpJvGN8rKP3lI8yN_VGO3tYlgXuxuuChM1gKdB3eVXaOre
 3BE8ucePelozSZ6yFIfGQeYRl4aofdBWece.057w_sxblxbBSEK02SECGfmlXsy8aU8y2LObBVLI
 DZ2J4Rf4aisHXsAtISOe6JjhklCWDG15ZEX0VJZwmmNWQfO_TYinhMdEwrG2o89_4IZ10SYCmpa0
 fZwaaOpBkHyxTl4CGviJ_DqWtG.y6brIoUP0irvpjcvTeFXCV9ZLK1lvLqtSiOJgwR.C2lcA8DIy
 0PCHuM.EqUODgxNKxyHg9lMNwqhw2Yo93Dszg3bH13i4DHIpqSHbEL0XSg1hKJf7S.M6B415AbkE
 .hhmHapDQW3m0Iv4F8ZDrbkZyYIxD_9Yo_8fGYBMxGZ3h7pC4RgBQfi2WiwDUjqQW5okd6q7eoby
 gbGOCchsaat7TgukFjd14guIhnmzQD3qBNI6HmvNSLMaMAr67_3HvWPkzBxXpoh65kCq54RJsUok
 95vxaoO9PaT.zsfP32Mxta8FmZ5sjEMjFMoVj2.2lPpQDSTl0EOeU8nD3Hy6fNJNhupnHN4B4FnR
 CnYUhZm0OaTZwbif_5DC4upkUfcOlFoCBz6i.60XtpQDKQaiO.Fbr8_T1_Tj7WrFZYSBoQ.Gjj6M
 GouXKE9lDfE9PLC1YhCKwU188_BLsxjZgiwfGR86LY9iYpo6WUj4-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: f3ce00e8-da56-4bd2-ad65-37094990dd36
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:42:23 +0000
Received: by hermes--production-ir2-5dd9bf4598-9c455 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8c3f3d6185ee7574b5717ab9ed94caa0;
          Thu, 12 Nov 2026 17:42:17 +0000 (UTC)
Message-ID: <767d6461-abb8-4411-a8b6-a7bfaada6d10@yahoo.com>
Date: Thu, 12 Nov 2026 18:42:14 +0100
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
Subject: [PATCH net-next v10 12/12] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
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

Add the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the chip table.
It is the first chip of family D, whose handling was added in the
preceding patches, so this is the patch that makes it reachable.

The SGMII/HSGMII SerDes of this chip sits on port 6 and the
MII/TMII/RMII/RGMII interface on port 7, as on family C, but the external
interface indices are one lower (EXT0 and EXT1 instead of EXT1 and EXT2).
The chip reuses the existing initialization jam table.

The chip has 8 ports, not 11, which is described by rtl8365mb_family_d.
This sets ds->num_ports, the IRQ domain size and the bound of every loop
over priv->num_ports for this chip. rtl8365mb_family_d also selects the
family D implementations added in the preceding patches: the force-mode
configuration, the VLAN 4k accessors and the L2 entry (de)serializers.

The L2 learning limit is the same as on family C (2112 entries), as
given by the Realtek rtl8367 common API (rtl8367_common V1.4.2), so
RTL8365MB_LEARN_LIMIT_MAX needs no per-family handling; only its
comment is updated.

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs, and on a
TP-Link EX511 v2 (RTL8367S-VB, CPU port over 1G SGMII to an IPQ5018).
RGMII mode has not been tested. See the cover letter for details.

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/Kconfig          |  3 +-
 drivers/net/dsa/realtek/rtl8365mb_main.c | 41 ++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

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
index 5d822ad..27ec031 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -89,6 +89,14 @@
  * things will work out-of-the-box for other chips, and a careful review of the
  * vendor driver may be needed to expand support. The RTL8365MB-VC seems to be
  * one of the simpler chips.
+ *
+ * The RTL8367S-VB (chip ID 0x6642) is not part of the family listed above. It
+ * belongs to a newer generation, which this driver calls family D. Its
+ * registers differ in the VLAN table, the external interface speed and RGMII
+ * configuration, the SerDes, the L2 lookup table (FDB/MDB entry layout, no
+ * EFID, LUT configuration registers) and the table access control register,
+ * so the code paths specific to it are selected with rtl8365mb_is_d() or
+ * through struct rtl8365mb_family_info
  */
 
 #include <linux/bitfield.h>
@@ -117,11 +125,12 @@
 #define RTL8365MB_NUM_PHYREGS		32
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
 #define RTL8365MB_C_MAX_NUM_PORTS	11
+#define RTL8365MB_D_MAX_NUM_PORTS	8
 /* Highest port count of any supported chip, used for sizing */
 #define RTL8365MB_MAX_NUM_PORTS		RTL8365MB_C_MAX_NUM_PORTS
-/* Valid for the whole family except RTL8370B, which has 4160 entries.
- * RTL8370B is mentioned in vendor code but it might not even belong
- * to the same RTL8367C family.
+/* Valid for the whole RTL8367C family (and for family D, RTL8367S-VB)
+ * except RTL8370B, which has 4160 entries. RTL8370B is mentioned in
+ * vendor code but it might not even belong to the same RTL8367C family.
  */
 #define RTL8365MB_LEARN_LIMIT_MAX	2112
 #define RTL8365MB_MAX_NUM_EXTINTS	3
@@ -812,6 +821,21 @@ static const struct rtl8365mb_family_info rtl8365mb_family_c = {
 	.l2_mc_to_data = rtl8365mb_c_l2_mc_to_data,
 };
 
+static const struct rtl8365mb_family_info rtl8365mb_family_d = {
+	.family = RTL8365MB_FAMILY_D,
+	.num_ports = RTL8365MB_D_MAX_NUM_PORTS,
+	.jam_table = rtl8365mb_init_jam_8365mb_vc,
+	.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+	.ext_config_forcemode = rtl8365mb_d_ext_config_forcemode,
+	.vlan_4k_read = rtl8365mb_d_vlan_4k_read,
+	.vlan_4k_write = rtl8365mb_d_vlan_4k_write,
+	.l2_entry_size = RTL8365MB_D_L2_ENTRY_SIZE,
+	.l2_data_to_uc = rtl8365mb_d_l2_data_to_uc,
+	.l2_uc_to_data = rtl8365mb_d_l2_uc_to_data,
+	.l2_data_to_mc = rtl8365mb_d_l2_data_to_mc,
+	.l2_mc_to_data = rtl8365mb_d_l2_mc_to_data,
+};
+
 /**
  * struct rtl8365mb_chip_info - static chip-specific info
  * @name: human-readable chip name
@@ -881,6 +905,17 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
 		},
 	},
+	{
+		.name = "RTL8367S-VB",
+		.chip_id = 0x6642,
+		.chip_ver = 0x0010,
+		.family_info = &rtl8365mb_family_d,
+		.extints = {
+			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
+			{ 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
+				PHY_INTF(RMII) | PHY_INTF(RGMII) },
+		},
+	},
 };
 
 enum rtl8365mb_stp_state {
-- 
2.53.0

