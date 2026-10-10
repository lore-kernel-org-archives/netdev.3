Received: from sonic315-21.consmr.mail.ne1.yahoo.com (sonic315-21.consmr.mail.ne1.yahoo.com [66.163.190.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C64BB5C5
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661149; cv=none; b=ZiDo5PQHSVCupJ7giv0w3tXmBY7b7qGlqkUIgLJELq4XIE4eVu2uyCVYWGsYJw9mWDvxCz01qVKhkkCKZ0DQgEB0gGrG1T+pSfpUiyIN+TmJD9zE4zY7N1Tf6yDJ7lqLhgz81HigQtLy1eynmlWteXI75ZqbfffpgdUQaP7Zvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661149; c=relaxed/simple;
	bh=Eac3wICY5U8s4DsFTiFZK1OKx5oqzPlirU4YY3XMDo8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Kxfq8q3tcHkx1+dTXxs5cvc5GiofXUVFjKocCxK/Qn5nEUJEnq2Hp+McNrL8vU+2woVOcHLHpgzMO+hYercmv9OokJ4Nsa3GV8v+w2v+xxS4xAXgxN9qEyEUATlgWvIrJ1/SUZEfXFqy3ozPCi3Tgmx/PImwGNAUe0/2oOiiP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QVeqOLpp; arc=none smtp.client-ip=66.163.190.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QVeqOLpp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661144; bh=p1BrKpBq82s6Zo21aLV4eC6eFRBxZHLr/T/7DEVIP9s=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=QVeqOLppx2elKkP6ukDgS8EQzXTfZgPS++F6wQkNgi2nq/gTh83hj+LYwVoW8f5U2eJQdp0J0smSc6pmcpDlFkAamiztoj/1s5DAlwRK+fQlr8BmRh1U+CFD4vtu9SP9K2ti3SC7WHypudkyTYHqp1GXPvEWRQoDcphUnzpFTxT9I1z6bCCaEPi/1Fu/bw9pdUEJinZROeEQXPdlMFuLI0VigMlOFCjVF9y6dbi8DM/BkMfgyiet1WSbcNXLNn4Z/y8YeUDkW02owtaLD+bFrqoEHU/1t1J+rVieJ2rgxcDzAUOW/8y4E009WrxfPLTWvXkHolhx0jn/2u5wagQsKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661144; bh=3tD10hvv2rPV/qJcMucQj07zWSibdMd2T/RNJFGZv0w=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=LazrcKEGnOvUEHjFbjzbhXfd7khq/kC8ncndAmMy2lBXyrY88JZPDRynBt+tVJnTK+Q9QIrtYWH7kLo8t5QG4IeK/mPAYhXvXhQrOYQbXXNd4Yl+nvfSXvFFkm4KeuuT+ULfR6ef+o6xQAbH5cG/xMwRZjSf4ltyvN2/70ft3BuNzBlkSKmtgtFqElLtty0DHZo/B2JjvU2OZN362ljnetn1ZWIe6TwPB8QDnIuFJFnO8apzMnT9aRPigirqupNTv+PwOn65ZHxqB0TbVBnxt9/FcbHi9A/5SJHJ72uR48wM2qo27eANbHPt3XKiSwP5qt1R/KRdPqnOylo+FCyWLw==
X-YMail-OSG: pUqZlG8VM1nklhjsmg3K2lGvZoUZBbns8P1s._wfMrHt0PAixkmkgeTi_kdVExJ
 901giHaaurnAGNXVcIjGzlyHqfEBM41XgVfRbAmkMqUh8t_gK.vNptNx7NW_56UVzMS13.S7aL2m
 YwhtbvCDk3_C3wC9Nz0qAqcgoQPmTp.fZi__J7zf2Hx3LB1PrMg6F5zV7rT43llqOwfIeF7NSjOj
 S0OwtYHdl8UFvPjj1xdkMEjxqpRicant3HfMGBWkPscdUfewHzeNT9JHfU.FFwcV4LWuCdc6fXkc
 AwNDLH_yRK1ybTcaaTeAAPdjmSFCSIKS8lKRNIAV1xtxTkfpGgFHrgCEjHiMrBiqEJJUtFMYkhj0
 O1GXWFuqh45X0ximRHhTeTyQkMWLE5QdzxBJ30aD1PTDSLTakiAUw9F9B9y2df7uelYnSxoTP6Yk
 dQDSK7z2YrV0PIKd19xJYB58Azm1QWrtw3j.3A666VXqm8JDmVN050ljWg1dqmoGIiYz4x2TV46T
 9oROB8ZQ2cZk2CCYcgvRTdx56XtybhcTEDFikNAfpyVBYpvESt1xz1BM_SfZ.hLrCeJRuWtpfu06
 PVUjlldsZnMbVPHgZlwQR3IONDn0XO.DHDFDOU8ykpNb9I0hDMMMuZsGFuFvPTh0bKO3LLbgyzau
 NAva_w0ZhrEaNvuwFIEm4.kJakkxmp8ayWLqMIEc3n0N6JduElheKyuoSiGuDBB_JBcaqkKoLrwi
 hwmSBtJ_p_erFUN5W6BfHYra28sMtZisB.tdlEZITjsHxaWtnI1r9Ihol3AmDxfDZnVTHvOdq7n6
 8zgf0f4yPp_TZMTsIrVjcapHAP0AFh9elEEiowfs.mK8mT2q3sE2utqYA9ng6n4CNaxWL.ZSzvjB
 nsqYPP76saKeXdG9wwPwYFvAY8KcdpQfEYiiCPBqDJNGaMwuDU1Nfn4.u8BpFs3MfLonBj.ouszz
 8EfxAHhAXV817zWrDeuHKWjBCM9NFBlEXN1luAPos9xi9AAEO6zDjlFFTUreVtg8fxnRd2mIGI9a
 cj6oQQLMrvXaRn3M0dt_NJ42RACz5HHecSYx79WHbWvjT0_7buRTlcB5uHkRFxvKySOkC5mXf0Rl
 pIBNG99I2jjSr_PLxoJgU0vYXUy6CYe4OcWE80i7ocBd.UFdzgtKddGNyT06Cah8iTMzWTARVtFX
 n.JAVwoxfnPmy7B6v.KJIJ_nvHLQUqDQv0Dn8mfpcZQojvPcgoWVwOxlypen9RBCOIY8uzJN3QvT
 .k8x4YVoUZrZCMDigdWB38ghuvcUAolJaJoc9IpqsbquNULBjB3bwYyK3gR.g2mIRoUYEg3hiI3x
 6HgxogayFeS4896IhefApEifej7A1w1BtyjCSAVuDN2BGhuEffIIDDWt7yY28mj2X0QadM8GqmuU
 V1p5rJwgsJAMYyK3wLZofwhAf3ZZ_jAcIxJp4Drg0GWSm2i3IE3EhHgQjqIxtOy1OdtfEomd2z17
 rNz8LR9FXD8LWJjRtXe0F3EPoBBuNHoG1U4vhADkTRn5GMUUBWUBxvAhxG2QmPWSnwv9sUwoBHT4
 zyOD9B8KShdm1_WLKwxhelquyJb4n8.ULVEoIFH7hPwUiZbJYGz6Yu0fKlFcQus6Jto2iJ7lf57O
 _NabdjPLVcMwB545VrGmrb9Lsl9uR0pvpDxBcRg4Xojom1imA8.k2QkJufsukcGXE69P_hhPwdJr
 3adfvhxbuQgUR3pCMjlyQ3CK02QubIZmw93PtPhUcgv68U.3JSi4qHCOKw1msV8IFRCvVTE11EnN
 Bcnm8yBkjUh.0ILR2CSheXWulofwCSKb7sTiygLPX9giQWBSGYbiHE9gCKZSyz9lWYcal6yz8xWV
 z0IAs4n3T9hPh5UWpCcfIF1lMOpW6XxGmgsepeTVJupcobINS20vbfPcWNhz0KVQz4d3tfmHZzrQ
 TljR6itjVxEFjMQ2gn7ymPaASEmYjTITW6ckbMckYiYhQO.n9zklaRZKGJ1KNAZh7gC6Fn8La8El
 hKUb5aHjhCsFR5g..mBEwUQWyFZWJvP7ray7rvAl2gfKISohLN1B5f2px65dpGILLhWT76YELOnl
 HN.zffRRJCdL9xkTM1DZjDzqXk9o3nPkGuE_azk81Vq2RI69AqPFWlr4fLK9DfOFI1itxEO7lnzz
 JYxMva8X8OYKfIf6EgFryB.nTKtMezRUNOqFe1vyRzMQDHvsx9lp5FRDM8WRsXJVnNSBTpcBZO_K
 _rHDqkCZ6CY.7HW0uTVJrq6F_NRUUaflzbwq0Hm38crW.yqw63WcSNvxzopLTkJbLTncdVeGQizo
 eu0UrX05CfZsNXyt4DnJulVCursoMseCE2yK1GbfL
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: ce0928e2-d4f7-4ff7-9f4e-065cbc91149e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:39:04 +0000
Received: by hermes--production-ir2-5dd9bf4598-xpdvn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 33d3986f890e2d8314b96ac58a04524e;
          Sat, 10 Oct 2026 19:39:03 +0000 (UTC)
Message-ID: <3fcd3ebb-c25c-45d0-83b5-3104f11247f6@yahoo.com>
Date: Sat, 10 Oct 2026 21:39:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 2/9] net: dsa: realtek: rtl8365mb: add chip family
 infrastructure
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
Content-Language: pl
In-Reply-To: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Add enum rtl8365mb_family and a family member to struct
rtl8365mb_chip_info, together with rtl8365mb_get_family() declared in a
new rtl8365mb.h so that the VLAN code can use it too. Tag all existing
chips as RTL8365MB_FAMILY_C.

RTL8365MB_FAMILY_D is defined here but no chip uses it yet; it is needed
by the following patches, which add family D handling for chips whose
register layout differs from the existing ones.

No functional change.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
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

