Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.185.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748544;
	b=WcMxqvlWpSQOlFXX8DeB1lxd2ds1MDj6NVKbcthwJkt+dw+oWrbuROU4n1XXcrSBHsAB
	 dTWFpY2YU4XtuyTfTUhi2P3Px0ncDcwYdl8rEiI6a+Im4PdjcYP5h2PSlnOyz9Xbt2ZRj
	 YUIRIrZy8w9OEsQQKrJQS0CuNUks8de3TItBGb8IbquGuu30ZETgqt+drWuil8HpOcv/w
	 ebj5YxBWv/Mto2NMOwDy6wSTaaPw5viRnypSynUiTjw+3VH0pKSEE8aN8zyRugifSl5Ks
	 YYnt2pmtYjLiiBk5GDwCFDOhEToyigNy1zYLg5h1QhIUzEx23k6+PX2wDYhce4hnI8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748544;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=rI/BNuvLLywLjMridPlm4wUzzlJbHwIEDK19efFNSM4=;
	b=AIpzZnLqZwLUmy0LBmRyxFI5kaLYQZsELG/icG1CL5IgCuE11GQJyUsg/MFHEGmWUNDX
	 TjCIzPotZRF3jrv+7X3PExv2rByFcPWRHvdyikOwz5fC2DW46gFtW0CZhXCQbrFwT7XJP
	 K7PMCki16hb5Tyq8mSFhv9yMlH6DTE/J0N8U8zzFR38wf3K8LZngI3kplEJ5oxNtmpvfw
	 HTorXv9paHwQ61SD5gg0M3etwJLThCrDu8q30EHuQ4IXSc3RAsUGyOP7wd34fIGB3PLDn
	 hHDVY/OTtwpVu0nb6RkE3FB4WHWgVZbGYr39495/RHmF/gVEQS6/85SjsLtCDV93EFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="jyj+/RY7";
	arc=none smtp.remote-ip=66.163.185.32
Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24B606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE24B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=jyj+/RY7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748541; bh=rI/BNuvLLywLjMridPlm4wUzzlJbHwIEDK19efFNSM4=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=jyj+/RY7aovCNmPvqB2plgc5VqbUM+qIRXPkI1bd05qxZkgFXhudieT0CCXEAThz7YCaoqEl9o5f6anA7cJrpiB90a+j/vSMYdPZFnMxlh3VBDA+3YvzxCabBDl2FE2IiGCFcRD7iucNoFAHEQTZUkLlA7CwgQyB4RX3YDoX4n8+kecfJo5FiwKZcw/k4Gw2puW7FD+UilTjJ5+YIZR8xbtmkZjvyk/2IjMaInCOGC9fs5Y44TvAA65D3W9K6W7EZRn5StI69qtOB9YhR/d9Yvk1pjOaQN9l/T/liZi4GnWgd5r3DsNPiHxHJysBpxNQnGUt29wzOkMY7pP9bFHCYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748541; bh=epImaX+4FWLA7iBtKOaGJct8kxr7wuuPf9eSu25ECq3=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=PBHaTvN0qwHv2UZOYn5WlNlkQU0rYWegvNSG+60YUKUK3xXDpUsJ0lfzIj8ci/zLW5z49g8qgLvbrRFz2CdEj02J1wWLeIWuS6k3nb+VZy7jpV5KsH9A1E4FBOReRA9G45ZQtSG4rMTbYdahbeiIoGJYHcVYuPMjfRUrFuUCabFev82HaZbQSfulrfSUmKn5/9ima0uQESk4oi9u6n+f/wIFRdxawAqjo/2KZ8BUOI1RizRj8MJasi3GQYPpcsVkkS5AWi6XCSOhHtfd/B+MWu0/4PWYR1Px4t1WPTylv/Cof1y5/zTXp/eSU34JgyInZGJrj482bjx5rvCeJanHrQ==
X-YMail-OSG: M6NsgFgVM1l7LSDkA2zQVWZOzCqThrpqSCnpw9VTS5xI84I6Z2MfpogKmzrnT5f
 SGWUyr6rMCfdXaGgBbd_COLcGFK0ArO5rjgcUnxIfuCLxWzbE456psG3xF0.i6pg_LeRzLgJWJjH
 agPNeUqg77ae2rc4gO5wKC3KA.52KlufCl6ZhvOyRUxyPDxS6YjvIgVX06FvwFWtwCO5p7i3KtHd
 irbP9Ymy6zu4kno.7TPeFJF1cTpTYMvKiIJiB8cqXgEBhkdMFrYbOeYS0bvTBfIIyAEy8LqiO2aa
 69KRuvQgAjHFt6HS8cyEFpmPsA7s_dGsWgKBcNFD7RXtJMJd7F9ZA4VY4vblmsM8UgrKlZH3p2Lx
 Tz3Ke7Muhy4tPbMW29CKPvY6aWkZNBshuXXkTMSXTOh3cCuvz0.OL0X7nIfXyDJrkxeHEgehf.Nu
 3.6Xcy3iiR2kyRp1wiL3eO4ATkzXFlbqpLu99zj4i25GJ_K9FVgNDhcxa4oGRy0m3f0Ltnq4GBRc
 K2rYBMxZgArZHC91kzyCnh6GLByAwQ73n4osoug.xSg8n.sowuEotmrweDMJyzuxPxypVL5jGmGW
 W9nYNFhha4zgV1d6.wpOOUEug11oF1W4PJpCSiPrtSd22j1LmWMCz1ray39x3mQcudHB8ufozdMb
 tXc.kMFzpnnryL9Pwi3dcYQWIhE6kBeiJNR4NE_zMYUh0zHiPYAFpx9Gq3pOBKwdS6b8HHrbWzNn
 qUpB3.1XFX8fLeumGJOJ9VP4ONzX17TEX2A9JfkEEvSZ1PNpUuQN2Uo5F4zVmcCJfGW_PWJV170k
 35x.kBRIqtnjNmSLUSuMtWRuslGubq59DXLcwFOm0YTC_65PfV_7Sn0fudSjwtYQzh6wsUqKiiuW
 FoqbCJHk5u5x8opST7KzBaC1lW.D46wBMOkPePZk32BOu_QvvZX.wmFzOLNuY6xzeQP5aIXpmq0g
 0I7SeC2x7jCOdmqmDc7C79as_vnzXV_YgEdjajD9JFgk.vujkq2zptRGtyLiBT0yew4EqRknEEFS
 OVRS1xtIkFDmL3t6WN_zF7kV0.vNd3Gj505WujpxcvIlcw9FCIN7aZ7jcRh25tm7f8IgMUQSNch5
 409lvnIA8krWZQU4iAgEC8va7nBTEZLVRCOEkWVAWSsyRV7qiDZTdojcOnoby908.oop_yh9miC0
 A1QAEMQVFemi_.G44kaF11UwI8wTuwyS2iQpi2lwjKvztf8rKom2PLeHt4EY.lQtTHezZ.CNKG79
 mrQSmCBn1_MeuZz8RJBk2U1HlZBvZHhT4UJN8zuKzOfX03jmf0xOzx3w0mLn9f6kTeg.0nxkJYFa
 Zd7X3l7OULroZgh0_7DXs.7QTD.tbR5y6pwOfp4RGnBdwuoKit6YMS0M_LtznukgGm83CjiRmvO8
 .7mhPJETqEfIpz9CIT0z6mByXzyTtl86dum3cC12W61aQsh0ZOmT24Eow1GqdEoCIO3n2eCGEUE1
 7mE6tMxhRrvk_Jjb9TpA1bF3fWHx9roRVK.vTXnrbyafZbwJx5hFk2SZtowfvWL0.qoOaQ6sMmNc
 .fQXhivA4QsXXin82Cxy_zc.nuv1PhK_nM__xwt4r.R8c4tcOAjB8Ppt_G7eX7Qdq2hre02Ehl1A
 zGuM0kOFo._Ri5inWb5Yi2pprvfcpP8XemenU0qh8Prq6m.kRSCwecToMnsPoG8j.BfoFQealzoI
 uzG1opXqfTnbGZqqeKlRU1tdD20B5486RMZka53klsj2p3wirsHAYBU.rE06cB.zZwAAcTpBAbvl
 o8K4TIdz9oO33WFN5uUKocjsxCRlIav0eUp74vOOFfqs3ShBJRE4EKBE3Dl0xaSuj7XxalwdgABC
 bsl.JoNBzIzom4XFPejPRlqYwwpjFiea08TttqcDFgu6IAo7rwaYtln53QCAaz3YwygQ7NblOX3C
 5elD6UFHkV2vl7oThIKEEOgLFhlVq6tlJKG_EK8YT.ZjkRG07Wj5hN1NXkd15RRxptfp46cR8BAw
 AH2E8y0K4_VPrzii1zTNsf3x_P8Sog3nHkD8NLX0qPqZM0bQQILppmX3hkxIJqB.Fy.Gg.THCduL
 p94dlNvhesdhN_WtcIcvOl8yfCObWKerzM09yDEuhinxYdAxscSWcoaI5ZFFAHWsDSH5hmlg4bvm
 aM.eHhTPWMD7whuNz8zWE6VGwSGY8FKLywZNxo8dM7MPlwmrZfPBBSklP.VLMdXBYF9GfZ5P8WE6
 jO0PiOSMGDMe9vU6NowyjXNPxcGr1SvIpv42yKFulrz9iWsaaFm.yULh06_QiaSedCkK3ZpChVSX
 zW6zIo2haR9nX0RCdKI_90AvcDc4eT2aXtTjCfxg-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 4e4ab46a-6a8b-4b82-a544-d5cf4acc36c0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:29:01 +0000
Received: by hermes--production-ir2-5dd9bf4598-czvl7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e23b1b2398671793e4df6f25b8f51bae;
          Tue, 03 Nov 2026 23:29:00 +0000 (UTC)
Message-ID: <4f18b386-d264-4492-816d-9474fb97a883@yahoo.com>
Date: Wed, 4 Nov 2026 00:28:57 +0100
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
Subject: [PATCH net-next v8 02/11] net: dsa: realtek: rtl8365mb: add chip
 family infrastructure
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
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.h      | 19 +++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_main.c | 14 ++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

diff --git a/drivers/net/dsa/realtek/rtl8365mb.h b/drivers/net/dsa/realtek/rtl8365mb.h
new file mode 100644
index 0000000..8c00591
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb.h
@@ -0,0 +1,19 @@
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
+static inline bool rtl8365mb_is_d(struct realtek_priv *priv)
+{
+	return rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
+}
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

