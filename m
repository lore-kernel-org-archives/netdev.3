Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.190.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630743;
	b=UlpHSNj6RxkfSrh4XL0IfX0kQt9+Hjraa4tJi9istMvnuuT+4+nTCz1IcA6XtWN6U+2Z
	 skKoTLnACny2xm6ZeDnIU8/9+qZiBXc2UgjrmOlLhz9KfWdOmWlYWDvoB0QSlxTjOeWIY
	 9H1VNHGlvrkgtOe6G2SpHwMvYLygxj0N4ZBv/sPGjTvM0I17+OxWEUESjnj1BQOXjK+hJ
	 z22WOm8rcWlu3/c1QwuuQtvuapqrIFoMDq2YFtz5jUMH9lNwfz3+bSFHUUMY59DcvRgQd
	 To8fHXSRrrOfzJdEKmfgh2di2ssIwclqDRHQDONckr4zFzWVPsni9GQjbhWnHXU1ong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630743;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=aDcflfF5U1GI1EQJi2dQ1P+PUHdKUPlkPd8jh/noKEE=;
	b=mmGazPosjNWx0s81i82jtm6KZh0yQIGmty3jilw0mAABFI08FsmwGPdXvgIzPdv9pucL
	 cGjbOU3KmlXCXS/QYGgKGaJ4tRoC9wj3sPnsd3K6Yw8Q6bsVdJfnTct0gIOo/46PpcfcY
	 UyHWeESoLnS0+K+EPmIO8jPxzsGjS1bczY+FYTQCkcoMN1MrBgwjYDJ5V9ajPtwpMF3wl
	 zUszn+iIu9mquUK7HrM09vQzy/67BzkQ7jEJUqBpq1/QUwJS1xorU+9Gm9mNSzhaPG/et
	 +YFEJKDCyTX7sP1CNwPSIpbp/HXNNDh6O4thXCYVFQdseKp8jyeZXhEPFQ1nuo/RBPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=nndqSIir;
	arc=none smtp.remote-ip=66.163.190.32
Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB37607026A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FB37607026A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=nndqSIir
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630741; bh=aDcflfF5U1GI1EQJi2dQ1P+PUHdKUPlkPd8jh/noKEE=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=nndqSIirCM/yGYFZ37rGgj8JfzdVTShs0NZYQl6UVKNvOImqS4Zqb6of0VJ8bu5wLIo7gwxvwOnk3fSKeziO/Bpp6/OWuk6S2jiUMYLHM1I59KZfXRwGO3ze8Y6kpdxEsvIdzBVLYzwLauIHE1Jz9gMVc4S039FV9D5fxrowkggrdY7KTuSQBp34ZJptRKrC7q3FJfYA9IZLeO7BNhy1bd15iI79mNS9X9gF3CFGmC8ZN0dqPZuSCl139VfLUN3IefUyKvOAR/3nL3N9lLW9tLzx9p8lyFF2dunFW/9r5EoXSifdHk+Wn15ZYyyGqPTCfrcAMdO354T6NOhDjbrTbg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630741; bh=2BnRR6jnSwJ0Y3KtjCJjscbLZvzA2TpkbIgzdiAzZiG=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=o3CRASz0YWIaLuuWDN1NyQrNe54IAW0G8YpDVRIvNrFYqR9DTaSrFQs27QGZ3GsApHJWCSVRCrLZB6mEwyVLKLcsToUTY7xjokVpyGwLzGLlOqMHWhdb6NbmUT5ig/LBP0uyTY9vq9W6tUZJIEl3NsnO0MYRbV6d1D9DkyhqwoAC7fg5M6kK3/Q5ND99M74jhJac/XlkzEw5u0YVMtIAmWfZ+9iyREq4M0LYQ2O7SuetybHgdibxNYZJfJ2kfJDMXITqeL60RTg84P/f9OYyyJGp5ge5HEHbQCChVsr/7/fQYDT+IH4nOoN2AAuzSNMQy9e2dFtbmqnqTJg/CDP3Ww==
X-YMail-OSG: 8V7Yb8YVM1lZCeMfQSXkOg9MW6as2wdChQ5rEdF2sYA9Kt7hg8lGalqIsjgU71k
 g0hxlPsBKMqNg7zLixrUACBp6qRnj4upNqWT8bRVDHp8wNIPqPLnqSMHkJDbxUWU56MwQeg31x1N
 .qxnVjnCLZ3_HweoNXXjL2JMcqMOBZ1PAt_tl3RWs6JPJOV6S7ox5Pw2.fGixXff3LVQDSfzYbot
 nxFmYbf46.YwfTuaSeux4xyM6ffovVR9Fg_eWDRb5_PueOe8MfLYTC.dbHsWIC6jatFIto0vueAF
 w6n7kzjX_rGNWWnZybafKL_oCvwv2EkCylvc0iv7MMp_Xztq7TXpJBoPbeQ1Av.Rs0_sX8mmSGRg
 5gn6xeCN8gd3ERz.zr2_rkraQ_YxRF8VQbf7I0CTTjbM7Cy.7wzESiB1fiUGQQZ5DjFpIQ5LCrdZ
 NYmB3LELGSjWxrG0x6avFQXlzfvTBVLB1mGR7gHgDkrI8gVQtg3N_a0v6s5Q1HPhA_lPWQ116KqP
 8XKHxSRuVPb0FnVJ7dyrLB.aBOR1vBkYhimkDaKf5WNiwmQt.hWCaen0jNCogR5ZYWsfvFe7QEr7
 bbBhUcelPqSWBwlDenLvq5EvE2WOcOPoBPviv9KtkNqZUXOcK9W7a7jr1txvp.yLeMJ61Ima5Vdo
 Aj1dSGw.3FhDP4S67bk7BntchQC9GvovDpcTcNb.Eez1wY8r.tWrzXvQB_2WuKoKAEfXnQkICC7K
 y5IwAMydE8RZUa84jI1Rt2JHIjjJJ_pwBFW7.V3SiSIYUv4W6OnrrNrPiOCYG_0BdrnLjH_5h8eD
 t_8FP8bEmHiVmSzFRz2rDu9qVXICJE8SA09tCcSUewiJDzKOisCq0npuCv.aUiPlE2Uurbbu4zyd
 pEMi.K1rd6HPi_.pCeHZIRjbDs9Mmu8ddfZKGqs.qMBtdG0XASHnqILar9X.kKKh4uS8hUnziS2f
 sDF3Dpls.eZxQCStNIc6VBxHroNJV96zbPGO7Pb_6SnM6iHykbgWHWJjRb68fl1vAPATejsS17kY
 dewP.u8VYIYoLwIT695sWBhGHOEX6PB4Y9RQZCttN292tU3dUyLbwQEMG5k5Qz5Sq65fw_cVg9xz
 koudJK5FfYhbrGiftu6l5Ie0ir5TDC7BcjXHViu.kWz9AAis9JIl7KYMPHnEBFAE8hbgcadqOt5Y
 AXoYpObrAUoGjs5eo33DtBdFh9g5QiMqFyviLTyhvni5uoVPJOcV5Q5ZyJDp91j1bWXaZNq_p2ua
 nMLrr8Lzg.3fJRqExM2G4cJifYz5ng1o7aGebvYJwiks5Fop5g8E.Eq3CNLukTBmlmjSF0eMo7Ax
 5wcLlGinb1oT9CRGRT77ZyCduX9ZqWL_KTyFQnpanxsCEwy.4apkMx0k1NaB4A0dF3jB_mwOL8ni
 jsou3HYm2CGpX.cJVXnWUXw__9eHobXeZZu0MotDSnQlrO3rCm2pCjpY45nzmDbu1.ZZSOgIypTY
 doDrsfYZ9qVtMOUoEpJiqq9wj8ndwZdvOMIdzBONNN85dwPoqg3Hrd0MUIJojkeb17eSQL3whHPf
 MVkgmSed3aCTb8nzsoCiMIZo7dMqfiWW3bzHlyIqTFf8zP8VRx60qY.jGVRxSKAawQXTCB0iU6hO
 6A35LPY8lx5rR6HevXbNhPYgJ67flglbsuDUJ4odUTEItZKL_dvCORpOnUz5DE..V.rylD1zrs3C
 nui0UZbCFv9ZXoP567LiII8pgFwoKSsR.F74nvrk3ZYYLLo4gQpBs5auIh2739pPcQfcc9mqOVOt
 pyD7slrMU2tPyKWqSXt5azDLTdoM56iSnc_53c3keI1EsYWsZcw9dU5Lic2ZN0ScjHWjkWp_KB6.
 EJWz02oyq.sB7OrHsnBFJfu.p2aM4uau0SSaimPV_BGbllV74AVuytC37h.jw71JyscmqWQozzmQ
 VAwyant88VSorqVZwJ6sROOBJqsH3ttDlyPhyQxg1FLZ_lYqvtt9i3tjE3zqXf5GwY5v8yqVNpqh
 P1jMA3gcHImFYYMK.ZQ8VFZEFFuTXd_20Th0iBEYmnsLHZupGo802PK4kzoj1vrBHfv4EBPFn9gQ
 nuRcNz5kh_gZKyzrBR.K4o7lwQYDlBVTeFBS68fwfHenV5LPGO6ZyPvJ2oI7fY_W9MQxph2hY3xh
 KP5E8TSA_xd2s03NRrRKEtz3.wjdkQebHHe95bw0sYcqz04_ep1ltvnUFQDNE9AfPJihEWWDy.J5
 ki4QTS0nlmk2uyjSn03aohvJ2la0RHk0xljvKO6BhjrIBHR6cWd7ecvoNZQ4WnHkoIM.dUhKaXrS
 pqvj6w.NHbka7X1KJELD2oSRsjWL2n92E.H5aHyArhPUd4EhI0Q--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 1c8afbf5-3a5a-4de0-871a-42d3d5e63244
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2026 14:45:41 +0000
Received: by hermes--production-ir2-5dd9bf4598-vvk7z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c53c275338238f44e2bc812594bffdf6;
          Mon, 02 Nov 2026 14:45:39 +0000 (UTC)
Message-ID: <c7f88f0e-b174-4715-b148-5f9a2648bc2f@yahoo.com>
Date: Mon, 2 Nov 2026 15:45:37 +0100
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
Subject: [PATCH net-next v7 10/10] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
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

Add the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the chip table.
It is the first chip of family D, whose handling was added in the
preceding patches, so this is the patch that makes it reachable.

The SGMII/HSGMII SerDes of this chip sits on port 6 and the
MII/TMII/RMII/RGMII interface on port 7, as on family C, but the external
interface indices are one lower (EXT0 and EXT1 instead of EXT1 and EXT2).
The chip reuses the existing initialization jam table.

The chip has 8 ports, not 11. Cap priv->num_ports at
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
index 1c5f139..415468e 100644
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
+ * with rtl8365mb_get_family().
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
@@ -3996,7 +4016,11 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
 
-	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		priv->num_ports = RTL8365MB_D_MAX_NUM_PORTS;
+	else
+		priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+
 	mb->priv = priv;
 
 	ret = devm_mutex_init(priv->dev, &mb->sds_lock);
-- 
2.53.0

