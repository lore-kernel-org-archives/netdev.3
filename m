Received: from sonic306-22.consmr.mail.ne1.yahoo.com (sonic306-22.consmr.mail.ne1.yahoo.com [66.163.189.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B24D5A1
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791763839; cv=none; b=M1s3U0mxDfFdj8iPM3n5lXAvSDMv46gFxsmIf6t/Nwq02Tw3L6zGqJofBEcOiLjcfBquDozWSY5kjYn8p9oTCgPtci0LBBQgx522DK2PdQdfHv8W4m/0Go19uENIOXvZ0tFtPFZLBbcPHoow6ABw3p+W1AAnwZmQOgSftjIsDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791763839; c=relaxed/simple;
	bh=Eac3wICY5U8s4DsFTiFZK1OKx5oqzPlirU4YY3XMDo8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=kxWFjZWSmOwx7P3sY8Z6LbCgQJ7ltSehgSUfsRdOEEnGGbCepAeoOPooTMMiibW3J9NV6YzOU/3Xio70lLN25SoncVrj/khL+0COSJn/iS+s26mXaM97ThjkpblHGDsu6bGoRQwYz4uta7LTXbIlsI5lsV9CW6N5oVPsOCZxJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AqdEHkP4; arc=none smtp.client-ip=66.163.189.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AqdEHkP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791763830; bh=p1BrKpBq82s6Zo21aLV4eC6eFRBxZHLr/T/7DEVIP9s=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=AqdEHkP4LerFcpFyO+hSsESaoIQgbZWUOVQUNBzjd0C9b8N9/2JLMMMvFHK3KdcDceBnOa33OcAnJsFlAhHotIHSEgsQp9qwLp8l++Tzc24QPM6IoYlnZwbhHnG+vVBQJqTq8iERSn2dE86zyk2nSANAVIkPBX3KtKoC8D/svbwD9Rh1wlo5rO+eJsnia4Eji6K5m0lPkighWaM7c7IOhlgp/RfUc/QJ3VexN80rsphsrWv+k4HcSr+9CuiCMbaU2AGn32NaF6+X3lz8MytNPS7U9ImuxjScyBeHNRS3z2GbMf3t6CsXpiIdUWXq1Ix601DOVtyYzt+ughifmvHYYw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791763830; bh=CVYpRT7z+IRIWblEBZOXhlaSp0/h1/GRW3oczH93NIP=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=XnHoeSQpjswnIJ+JZc/3+CgzsNlviWkSMSeQwf5eHznRX4g1y1SJzI+gvl5yoHYJiSggPbPavjXW9QVkPt134ymh5Ee3e7QxK9uSfRYeAR9Y5s7NIXP654ktNgLBUtm8uJ6gQdygSn/cA0LeMK1nXRIla9ysqSso1pv1EjX9OjicV9SXjAhTbqCoRQX88maBh6for108K7TJoZSrJqdP26764j0JipjN6F9ftEzzdV/YQL1C4Z82W5cu+8kMtfUyPXuwOH0G4rLYGkYGOOe12fSYtWGB9vyyd3+XhgznCZUn3o6PhG+7kcgajcOz7fWMiTvVEVtg7Y4A432NmvsCjA==
X-YMail-OSG: e7xnIrMVM1ksjIzVzZ26CI8E0WFq7mcku9kqmf_ZFagxDSjRKXS.p7mH53RDnpK
 c8Gu8ROZEBjatWH5459EkL6EKuD92x84qTkQESCwb.eeDeUCbxYA8xyvlepnrqanwXy4n3DaxX.i
 ZGJ3mqwCS_pfLd9O.vGemqYiDReZ.5LB7qGjWjx59NjpmIgDjqUiRwyar7p1OBMJiaSsFCrP4.pn
 JdMAiupcUQ5Ct1LX4iXuma1tpyagji742_qoZ2NugQ94JY1TDaHruVSKnncaG.qkQwOpmPOxFGrk
 QRbc2q02SNYp68QhyNdsljd.5rGHY_LTr5JOugvx.ft9FBt3g1vDjtEg_3ptaRCA7sp5w0hhIaCB
 iEL5i7tpSN8_C3DFFSBAjjugCspNRpOBzNgP32gB5XwnaXpNz_AsXXG2zV912giLamw7M74lT9XK
 ENQREjNsnQ6e79ZZjloCf4w1SekR2DuSXk2OCUlDag4D4Jc2otf.R8mTdPvkxk2SxBe7UbsvLN_y
 3X5kwjiJqai0BohNWJsQMLvdITWJH1dP3xWot4cSW9v9Gt.1KfXYOsd_RdiRvZukOWGfNHfjAwSO
 fgnjBe1Uk1ejfC.pdx62R9xHa0yWa0WIkZNiizRVmYkEBYLbiav3JKatjkPraSBqPnE9pPfMgY2J
 NMfuaZ58LQ4h65A.t2WE8RIYQTbZhNEHXDWuC1DsTWD8cMyuP.IFzQEzznh4mcAWFq006cF9Gjx.
 wg1dscP5RHyk6P6XbgGSKnpy7LGpKtsOh0xX792CFc0Bp.EilCjQyCR0SChFQOaKlbec7oOrq.n9
 CPG9a5mIAL2noD7by0A9dqwW4NIbXWoKoX08svboUTr.7xo05bhrfenBOtCxgzzg7Jzc87Yto.VV
 RqX.2o6FeBdGSXo62Dj3QX704OqEF5okg3EDu5WGks5dln33P28ZoUgays6TYHwhVNDhnc6GGc00
 UqU2b1THBjBrM0Xa5DoOUpBbHJbuYICEVrpglHL7HlTIx4UW3OY3Dyo1FvKtttcJRfbjNxwWB2Y1
 cAIGSE_gSt.l.WUWYNShl1qT.Pt633zsGUSilpaNOheqAP_NIYvfzqmiCwonCJWhxhmL_1NKNO9R
 p4xSXtpdAvEgUQQ7tWPpV3MJPa9hc7y4634IJzcn_5GlIhAhJymitWESoCIMTfMiosp.Pi2HaPjj
 ZADjbtxrKm5zMOv9uUWd7aM8dmg8rmd9A3qm0LcTbyEgwyqk08PPwq3Vf6vR7Mr4qxHEDCODcCKh
 ROYOq42dkyGIXgVw3Paqu8cww3KCBaHjk64WGhZRjqHj_D__qPDcvqHDNzeIuJbhMHSg6kOy7_F_
 8E0J5KQHJRvFj3Ulhxd.ut.Yx4WmYif2lK341_dFPNa92.EeXLmi9VWwc.St3lLkpyYDoLJO66I0
 kaYN6DefPYUmb2ZP0MSFmDTLir6JpAZ0ihcDDeUwh4FJ2tykNnnk447hfRRHC9RzKYKddAtlIVln
 5v60YaULiBKZeU.ORDey1bOmOW77HsdgdDwFHMgm8hCjqXqZcr6QXJwpaxrXqa228ad3DfKQMvUn
 RCcKbYEpqxG5ghxbkhMpVb0lQHoVZCQ4Z0UuWnxKS8V.uYuUk8YG9tKG1bJGLnYrXDUlLSiKPkvB
 onvLdtvDlGNCXyvmXVwVTcSAkDYWb2zlgQ64cdx1M7cgchTi_siy.nwsKoKwUptjCAbntvfZ.O0R
 PJG0cFmLQsQ2wmKXXhzKwuJcCrM87FcvX.3EO1WZCM54J8JV4uZ2LoTdecWHmLmlgjNlm.BjqTdO
 .nczDy3ZUearpG0RNgjoq9a5ENw_5CJ1uQC_A4XJ6k2XqAfWELqkgppoDvYQnBv3cd_wvRKA4fem
 Ncf8W6e6Ernfjoi7wkcHXYnSJpuEwHuL8v4RG.Bvppheb6.dkgkmfwIKRCk_T5ibV.AVrCVKc8Kh
 NkWKffTebl7Ng9R.xk9Fs3GTJTesMWyARYJW85GgoJHXdDI2HVY9SNACpZUxSMZMKqeBcsTemND2
 gJVtMECDeGUAnHikUgS5YXDCmPONY7qPon6FpZgQcBu34PwP55Kfd8OjhKoz2SaKl6KnmtTR_lE5
 dhzm0uWb01f_DRHD0QhkeFXLRseX0shwskEJ.096pvz1FJ.ZCvwAgqEPOQpejLkAVrYps0JwLrby
 XVV8_oSBY1u5Tii_0I6zVtQdGvZubp0T_dSzrZ7zTTKOktvrLZDZbKo1265TmHt0yawsN.mu9R8p
 ef4hs.D_10AFk03hOnT7r198kXKVtYQefGsT7_ZgB1KfiNF.ILnSQfr3HtgsO5.Kwf_q9a4zi7Ep
 yfj0BmtpToR.eBUl9ypF.zzWCJlYOdqyTlXM8bLc-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b053fb2e-9966-4b6e-9714-915c4b0d626b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 00:10:30 +0000
Received: by hermes--production-ir2-5dd9bf4598-bbdwl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 617c75f26c93a3d75c32121c24dd32e7;
          Mon, 12 Oct 2026 00:10:25 +0000 (UTC)
Message-ID: <7825e3d1-5dc4-494d-abe5-f2459f0b8251@yahoo.com>
Date: Mon, 12 Oct 2026 02:10:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 2/9] net: dsa: realtek: rtl8365mb: add chip family
 infrastructure
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Language: pl
In-Reply-To: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
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

