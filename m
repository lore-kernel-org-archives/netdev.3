Received: from sonic311-25.consmr.mail.ne1.yahoo.com (sonic311-25.consmr.mail.ne1.yahoo.com [66.163.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2C2253B0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112575; cv=none; b=ZESZ2SFJrX8IOqAqJeCax2Z7DH7TP/rOugA19ppNi0XlN7am6Bd/KFX/Auoeiuoyr1cjX0qeXk9NgRsW4Jez0OaYmrmJ78sGCQOPTKVXdcmO+m2hlaYoZHWCi5YWO9JZg/kDQmTwVXhE3IWqxNYHCsiAVdUdCF8y7zSG34uzBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112575; c=relaxed/simple;
	bh=HovB5dFCWWz+oudbpLrRuV3ugyOho4lYqHwfbtTl0KQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VO3WB2HhSg3BVJ7xVBeerDhR84Yu7manUaHGAfox/xUfzzxBWUCzjYDxoiFINqIpe4Zj3KSljfgpZ7nUqpYIt1ZaV21LyagQpIU7bLEJTk2kUmeQunGWYJGYEbzcBOJIxTlqbstseSPQpeh68tAu7+UFVY5VnKob69CtoWo5bLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KNV+Biew; arc=none smtp.client-ip=66.163.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KNV+Biew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112567; bh=cW6ATuZ0bfQlDgpqWY6vmLOsqJhUXfoecpKwzz+QlHA=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=KNV+BiewCFI+NwixeNb6NC3K9RtirLY6lTNTZi9HdQDJm9Xj47kbNyd09rZITuWSlay6NVUTr0SsTx/IZxCYURI+sygoHyd8aWWL1314+1ejAuXPipBkLTPvRvSvf00lmER6ZnUTIDRVcVhti/SNyRQf9gc8rh5Bdnz56hEov9ST/bKO/rJnnQGM+oxmbUaggaU5YldRlPce2bGNpVM2RLDbY77EIhy9epjZkUZtL9i9DHBg/nDcYoJI/DCr3VN129W/Vu9hrK94JFazI2mbH/Euh7UWDpki6UL/An3AvR7IXG92vbPcCv2H1iiAmImI4o4pQKQWCEOQDTThILmZAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112567; bh=iT+wyI6W2oIMR5iAnNXt6BZlAbmPNZ7lUjsregyaRt3=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=oV74GHkHrzLkOdKVS/bAC6VgbRaI7U1wXnk/7hdQIdrPM63wge91WN+nTRN9DiGp8TumWVqmvjATOf7Vbg6Vuu1mIZqibGz+irPYcTvGa+6CLlIUUkBzLd85YfeOBQd6etThUjZHMJvJf9Wayhe2+3+twJUZ/DlMSMgWOpbX7xD82DVgvDpwwuEmvVKdXUtdOZmPK5BFmW06DG8oRsGz/bI0PKGtg+IG8E0AlrvNA7I/UXxfiDxZ3rQ6VoSiN+Yu/xQb07BDWn9Woiyozm5NY/Xl3187qJhccc+GEtLPlqmqaL8yX5k2MiDyCRh+j1r2kTaHphaF+qjthLC/XYEAaw==
X-YMail-OSG: TyBnN60VM1nOxg.iM5grDnDOnIrcNL2QNFTxMzubVErG1Q_V9XIdw6OIda5Qcc9
 UeU3D2VOP0b9XiIefkcRCYegg2o1R4dPPaOrPFBgpUoJsevp.FVBN8QvG6bVowTSwLCFUJNOwHKN
 IkSmtJMs5NJ.w6fEgPDQgcjI2QgTGe8HagnGqocKbMDKMiVHjwQhxeGPcVFFRgMO2FXvAaGfoDOL
 INTg5xTxHhqihjltO33pOzR08amLUn2HBXZ.ZfbgwhmugdJWc4eYzFgPqPJW2pIxUzJsryZn6lQA
 tr7p3lU5dPXbTr2406qhNfDypB5awC_W76L4B5EES5CWTbjG8FVJ1uvUOJnVNZIYZP1uPvntdlQu
 S9wBBdCQqcGWXr1m5o57tQh5SEj83RiWSkBwNMkxqFxdNw4fEbHv0AImaYIhkCUTaGZYRrhcEAtn
 FVWsUUcoGrRsCBO.k5.VBYFsML.RQ41.xtrqdo8IX1S6E1zOynE5zyOwDqxXjzqPVHRqqnr4VUms
 aCIj6S.wwtZobXJMVJ6kPU26mV2INm6BlQcS.pJniMW57ce6ACA6Hdx26lL6jtXFwB6O8EyW4lI7
 SDYMt2Idirls2h6LHjRnoNlIDThSyivqU901MrtfylW8L8CIUVHdnaEO6xS4P8Lw9eoaJkkVG4hI
 bBG_3FuqKr_iqv1Hm6agP5c0Xe70eD1qtsJIlgzDgpzXBWyfQh52TpMMNRGxNNFCtzfrL3F41TSd
 OM8ge7u.AONXrMorte8U9MpYq3s2FCq07yCZLdwqF3TzSiFLh8PBKUq14cziR_shCkIPqY80nos_
 xrH4qEEPLnA74FJRfFAjhAgDXdMe14jUVqwGqELbbSYCm6267IzhyYV7MVa7CGStHd7zOEDDa3OZ
 Fm8XIpw4DqicF3w7LXSncgJ3z1XDRkyl3MRFTEOa7rkaHKe5zvSvav2io.CQ6IuXqQ9O2SrNGmn5
 M2LVbiIFpHStsDcBR2zp0ccroRnQZItfgHkvS05dkS3qWZP38HCzL4Pjwexx8huayoRs_LTABJTO
 RQSLU8u2N5hV0EZZuD5saPkfz5q3g9HWBnJPpPPM4y6BMw2Yp.W.xQfONuADMK.pk9XZKpBqLKND
 fbYoBni3_D45KmXC3MT2l2PGdKPqVXWjSR7UYJvMFwVQScr2JMlN1p0Y6mK2K90S0MS7n0iLpaf0
 oR4OdlloEq4hE5gt2Vw6FsY.ii5O_6tskr9D6vb8cYtyVWplGsWUVsVkw4ytLPnD8b.QPLsHuovb
 wZP3wu2hrjkBQybc4RYOAyn9PSdu527eG.V5yL0xD7Xefq.UGIbsMHtZvQJeGoTvXop3vg5mcRxR
 AMUnkRN7heTcQZpubFGmBeTabFmGKx23ZArUbMw9gPdChQsNjKWSI13vjRHFKzvV2bfcfJ7X4Xop
 LXG6W9VtTj0dDzPcSLZafS2.Uf50Izhu3IO65ib2mYCcKsCvxq4A0QQmdPm0gFCFVJuLoV4jmbnE
 hjtM.47kO2Ijj3rZIOEa.HFdYqaEreygg_I_PFXQNoO9n_tgmZDJaY0s4mXBGEGsKciI6NY5FlCS
 KcCEnaaN8a4icdU0obNsgwTfS0KOSMUbQND6JJAh1lNV83BPaJMsb8Sj27cEnQDI5Jq9RUO58wS2
 CZOY3XSQb7_JMW.kvtqmwNXrtCWe7TRb3rGDk7uRvDOiVa6H19Uxkh1Z72ATImSPhcVo5deICLnM
 aTBcANvcSpBBhqLWYrBZW9NK1Z0d0md4leMLcT5W2gwKtNYq5Lslqsy2JKGAlCd75IFlXSPtatRL
 2e80ImwT0p2hYHB7Efl4S4gaVfnV.EaifoVbpJOfQc2CnJpOxL6js.tKJDmlu9_IxQc3b4dpL7Ot
 v14rCDG6uegJEsyTvD2HmTH5ViWalPOTYrVLEp_aSUpzmW.vSUzuou_LXjmxlDoUAxNZGvOEXNOs
 iZRmV76y7ZNami5MWPdDYm_ep4reCAH3olix4p.XhoYM5zJk4OT1clN9n3CdigEhCIy9hpXnv5r6
 _41l3b9Rex0lqQH..VulD5n0d0kMTkSg79Q_irCIWFmqNhTRpS_lCKaB4MXP8C8exjth4HFro4c0
 KUwMH85oTGAbKOISrCDIUmRL4jRwVa0GiJ2SiKdCVPFEICu4Z8x0M1c3keQ8.JzPe1VNvwPS9dFn
 fbxK6RcHdZer0ZjiNybtMyUu1ZEhp_jtsjqhjNMdDE7oJnyDB.ZqUiYp3MAOvMhQRDdSlvhUWnfb
 HM7fBRkdR3Fi_RgWRhRp10n05hXzuWWlC5ppkrHHQrM7mm2Euocov4i13680Hnsq6lRKzz5Q3O9_
 XoOxEVfl4uJ7UWP4Nw0OD6DF3.mQ1uJKuwvM-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: ab0b9a3a-a572-4845-b16c-c699c26b994b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2026 01:02:47 +0000
Received: by hermes--production-ir2-5dd9bf4598-nf4w7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 153a889adb1dc6ddf4f6b70a98e72e09;
          Fri, 16 Oct 2026 01:02:45 +0000 (UTC)
Message-ID: <8a7eb315-b8af-45b8-a0a0-52814a5341de@yahoo.com>
Date: Fri, 16 Oct 2026 03:02:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v6 2/9] net: dsa: realtek: rtl8365mb: add chip family
 infrastructure
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

Add enum rtl8365mb_family and a family member to struct
rtl8365mb_chip_info, together with rtl8365mb_get_family() declared in a
new rtl8365mb.h so that the VLAN code can use it too. Tag all existing
chips as RTL8365MB_FAMILY_C.

RTL8365MB_FAMILY_D is defined here but no chip uses it yet; it is needed
by the following patches, which add family D handling for chips whose
register layout differs from the existing ones.

No functional change.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb.h      | 14 ++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_main.c | 14 ++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

diff --git a/drivers/net/dsa/realtek/rtl8365mb.h b/drivers/net/dsa/realtek/rtl8365mb.h
new file mode 100644
index 0000000..315de4c
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RTL8365MB_H
+#define _RTL8365MB_H
+
+#include "realtek.h"
+
+enum rtl8365mb_family {
+	RTL8365MB_FAMILY_C,
+	RTL8365MB_FAMILY_D,
+};
+
+enum rtl8365mb_family rtl8365mb_get_family(struct realtek_priv *priv);
+
+#endif /* _RTL8365MB_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index da06f95..840db5a 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -110,6 +110,7 @@
 #include "rtl83xx.h"
 #include "rtl8365mb_l2.h"
 #include "rtl8365mb_vlan.h"
+#include "rtl8365mb.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -707,6 +708,7 @@ struct rtl8365mb_extint {
  * @name: human-readable chip name
  * @chip_id: chip identifier
  * @chip_ver: chip silicon revision
+ * @family: chip family
  * @extints: available external interfaces
  * @jam_table: chip-specific initialization jam table
  * @jam_size: size of the chip's jam table
@@ -719,6 +721,7 @@ struct rtl8365mb_chip_info {
 	const char *name;
 	u32 chip_id;
 	u32 chip_ver;
+	enum rtl8365mb_family family;
 	const struct rtl8365mb_extint extints[RTL8365MB_MAX_NUM_EXTINTS];
 	const struct rtl8365mb_jam_tbl_entry *jam_table;
 	size_t jam_size;
@@ -731,6 +734,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8365MB-VC",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0040,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
@@ -742,6 +746,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367S",
 		.chip_id = 0x6367,
 		.chip_ver = 0x00A0,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
 			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
@@ -754,6 +759,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367SB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0010,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) |
@@ -768,6 +774,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367RB-VB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0020,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
@@ -874,6 +881,13 @@ struct rtl8365mb {
 
 #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
 
+enum rtl8365mb_family rtl8365mb_get_family(struct realtek_priv *priv)
+{
+	struct rtl8365mb *mb = priv->chip_data;
+
+	return mb->chip_info->family;
+}
+
 static int rtl8365mb_phy_poll_busy(struct realtek_priv *priv)
 {
 	u32 val;
-- 
2.53.0

