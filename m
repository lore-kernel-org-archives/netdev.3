Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A53A4F32
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880788; cv=none; b=SAcLnuF/zJwn1+4xC7fyLhdbvhhbT1Ur9l/tx5xBr54jQmpF71ZBZsU5LMxSdD5GzTEZ7hMvz8LhH91cp5ndFX9u9WiWO3UAnECohqE5Y1odgqi3A0fIELWgOWf+Zq4DH5fWqjC+JJ6uLnPmyOPWEZOmKa5wGmlzAUooyfnTU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880788; c=relaxed/simple;
	bh=Eac3wICY5U8s4DsFTiFZK1OKx5oqzPlirU4YY3XMDo8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=aCBJ7Bt7x6DPVpgMo1OIoWKkznRW2WjAvKcaVMdiyXQ7XFIIh//Guo3ZpAeyog9+yKrHnKGudi9eQur6UCE362uR6Bzt+kmFxaBTME7W2LxVKZgVwKMlxnYccxlJNn/RmhabXV3eZsTCE3iqNSmizXcStAMsGW/TlNuCHEDnsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GAzxbEVB; arc=none smtp.client-ip=66.163.191.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GAzxbEVB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791880778; bh=p1BrKpBq82s6Zo21aLV4eC6eFRBxZHLr/T/7DEVIP9s=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=GAzxbEVBgoJRlf6i5zejICXRuzj5zZI3SP9nyqv3UjEc2KRhhqkhqniUIwgkhTaergCodFSH6oyNa1y3xSI2korYipZ3fQpymaMaG9QLNtobKzzTgqOJtUJ+4mN7wHQw+KwoEizfYAGzA7tZmwoBYR9QqCnyOS32IqzSmp+51tCYgOKyAVDnYqd65ejMnEdAFZcYlLEYSujfoz+l4Q4LhzXnkpeQO/+eA+djTKp3BM0fHUsaPDSr7rzaoyGSOxp745wBzsgqxXClMMrj51GnEKBYw2gRgYbRbmbh04F1tnCsOLgrf6CezeGFzONYcUJ/mzqtwoxKEh3OeR/v9ntWzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791880778; bh=8XAy6nhVaopEPf8DxaysvGr6hDcWFMhjUKOrzk12eNy=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=EgVsJeROy+3xSG0ANZY/i9jrn42aZa7CokWqMTkWSLau61Cs1dWCOen2sY8vG/qSJwpBGaAgOm6DMPt1suUK8+wbAa14f3IGtjoRAPqm8yAmuL7iTp++mwd4EkA5OWlSzDQ55URx03i0OWDwlh2e8WyU95kGxN29SfixBDcyzs/vLqvNph1MWdBk4Ts/okxtY4mUwsiim98hqaCSS5LygdzSq6kkoErPRkAr8gEuQcQ40g3uSpqG28/SIEnOdGPpZ2jqSIGFJgDvd6EALBXMi71xTnWg1pvqLLm8aDx201i4cV/dd8ZHP5aVUi1Vv4DDec+VHYz72R/DzZMV4a6EKg==
X-YMail-OSG: Iq._P4MVM1nSKgOKaVwI7b5IrVgomSZN6B5P3THJl9x5RI6o_tOtjVN97yeR6kX
 RB2uWC280KYFj6vssEHFUG8fLH1scAN4eITAufcDzFLd7J4IMHDPD86GxPnLpzFnZKbm4fiB22Ey
 F4Dkv1wnl3oMpOvd8HjO0Xdcts780FhlL45u.Hs5.o1ciJOw20nr41YoP2JVVcnv7BsLcaNm9DfA
 0JyPmne6afxv4jdbWmgaNoowMh_SuFV9bHMoXQnPjYTYstzo70Ucdaz0C9MCMi13x3uwZTGuQ5Yz
 ltZBI5KNCrg.yPXjRYfdi.K7nCM4yYyY4GxcO7UNul36GBVF6rBwkBhcgKKIQA7Vy_ahxLhiIQWm
 WfGoI8GmGjBtlCekPoWm8gEQUW81PXVqZVPR7yN4T6QGXdk31Ziaxd99a080VIy.DifHaCdcA0On
 aHccFxjf78Wh5RstWojzSq_DpLdu2rIiqDqlbhLF_F.hIuA69zjWT6x3VsAZOfYfsObnJEczy0aX
 eQA3WkC1T6utGGXBO6HItUM3rvYpIvwGDtr3SsXG2pJasi2OXLkQan7C84emQcIIkY8vgi0SLnbx
 _JmQWDqGKW1_e5sXm5OVrbcSQnR1VbAyLwWFHwUNp2z4B0Ui_0k_jl8ebFnmRGe261zhK0Dn4Uc1
 AVZDcImxmehii85cW6FimIIdQqiCtqW6s6CPauHIUQ5lkvLdWht6P_5JCSMECW.2gy8nZ1R_dn2d
 l9NYmOPNDPlWbQLFsErkiCdb9toOMS6JFH8yuKq9K3Yj381kg84nA1qXTVSXLHiBKnbOiUdoVG4l
 WW01nMz0MdMuQ2BrZ2Zuy0oAnvb_aZODPtbmwkFg_oejgVtHGE.EO5UzXrNte1VqKCmwHcdzyO5B
 MGLLftJwEGDmqZ63xee.ABdIc0PSCihTLOCpfhXZn2._ZF1OtcAqD_wjd67SFRp_0cBpeVNvflL.
 XcwdYyyF.mZyRye67aW1yhc2.WM.SQx1WkjPYZCM.Q2AWoBVxVkry88eKlmvzxNTYDNWg7Df13gy
 Wb2FUK1zDC8nKtewHLNrkUV_y__mh_0gWPt3Or4X7ai9nKqKw8j4gXtEed8zNDX582LZy7mcrdOd
 mg5WdeWFLZrS6sqZyxYHR_K.v.CfBq01FQjn1hRt2LVLAXV165KwGEzIsHTVLok1gwuw1gyzEsBt
 Gdq6Q7LbCewoUEXcsllkfDDu8y.Znz8YY7DdufGvSSfxskcso3fpeHxxticCl6VAxJRAEzzo9DLN
 BIyvPrE.tb1TMPQfR2ZgJD31YhhnhwUoTFVapab.2OcQTqoFcaNyBuejjcAMi3SSqzARkFc4sKPB
 NoNxRFuCDtHU0gAjH3aI02zQwqor8fzsbZ096PMizSJ1D4Ne7dCOixSDg1Iqo7hRK0pf8Wsg1W7j
 rUE1MgYVNfk_Ao2MR2Xx8jmgoa7A.c89WrqfO7CJ5rseqq.XYvvoUZQP0fRn1Zu6l519EfnqQleh
 _1w_1mvWISZ2qP28UQayP9TvP62CllahNXaPzSiEEV8LZykYDBPuvrE0ut7nOy1_mJs.jp1jJW43
 kIjnaH1XfJc.xdYZISbkgO1GPbvKTBY3aRIBPV0R7Gx3EXCj8QK.KiJDtaw0kykQ2Y9Y59aFsDh3
 ppbqSxexBOA7KrwhWKvaBHoyKsESN8VI.rgoVebZfRRsZb6DXcs5h7ITd1GZDgZzUovmMO46YEeH
 Ye.r8BVN7k.ijGZ2MGyuwixxAOwZl2X4XgGLQjp5pu6dwNKPaJe0NYwblbRa_CGzWyKC2Pzci53P
 HlyEI9wocDe_flo5G6YDDGikJLnrfWwpVU0rl_JiKnDVkR5xKIFRAVMUktcViw5GER1_7jXSNvAB
 6NwZsG59iMiHdRL5UhSLOWxWVYsn539nYHISxKdwwOp1KnwtwqxuohouF5wMjkCXAQyM5QzIvQts
 Dxoh0AllryNpaf3ogBJssvVxbzIOwSRIRm1uQ_Gm1fxQnQJXSr1Db0ClHPbYBWEc4XxX2NjjjHKz
 5oAMCfrvQeC0p7KBHkae9bFXVmHHXm_CD4_quscFP0eJzl_p5QsnNY1wwHL0TOtudga44PYY8jBi
 kpbjFznhkClEDNnoG3iGlo07N6a49h5YfiReikXib88D1Da8fRs.tkFPcI5gUE4dx9Y7GQYiO9II
 2NiMRyA4Xb0MCADeYEfyRb7uaPc_mt01KPqpIJd6PsfgssnkS15ZKayY4eBZwcmnf26Cr6mI1ohl
 eIQ4RNU.1uuPJq_Cm6QdeCx4bhg18iStmeug2Qw0oEc5xp.FdngDLuRG7ckG.odMR5GPrDN32f15
 VWfUURQbe
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 1c57f9e6-a986-4b50-b76c-6e82a301c7e6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:39:38 +0000
Received: by hermes--production-ir2-5dd9bf4598-jgkl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ced0aa79affbf0f8813dbeabb82c3a65;
          Tue, 13 Oct 2026 08:39:34 +0000 (UTC)
Message-ID: <56fb70c5-9e8c-4d7f-af47-46ed3c860694@yahoo.com>
Date: Tue, 13 Oct 2026 10:39:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v5 2/9] net: dsa: realtek: rtl8365mb: add chip family
 infrastructure
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b45a3350-44a3-45ad-89cc-452c25edbd7d.ref@yahoo.com>
 <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com>
Content-Language: pl
In-Reply-To: <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com>
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

