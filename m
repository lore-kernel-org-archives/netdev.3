Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.191.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505067;
	b=i4k2D036AVCikE00m3vy1tnvkpkzfB2R8QjA8XZAV9cadRCdRo6huFCKc/NPhWNMFqev
	 iQX6SEKVSxI9AgWMW+IbXqHEHyHZu8RIUMiGVT1jWqL3vai21ZU4rBNZpZenalU3eLATm
	 LtjbCOEQ19eeI2xbiSOs96k8Cc9aCe+p7EeLSxYRHfZumvhlkLbgE0LxN8PCkzL+kQ2gd
	 hIf+hZsNgFvAdKUxMke/zzi1xGEUCluhIAYGRnQihQN8D/U1Jz+vGcYTttbEmSSIu5aAU
	 cVUG9u45WU4NyeHgfVaWukKJP4vpSZKGFV7g2+o+bTjroeIP4yhDASPttBuPBxa7BCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505067;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=diytamQUMIsvhu7SSiv2EcPyNPlyBzwkF5WLWQigtPc=;
	b=yHpc8MHZof38Zhjq2zI2521NLZZKaxkKExU1G6EIihcwXlOxqmDjuysVELB7VAeZ5Hun
	 kb46WMXz7jgpYsfu9kDiwt7fLcHpw0xXfzY7e9mQywecjb3PP0beUtfEI8oF9uVaXxqD6
	 6lZBpPeYtjG/GTaLZwFURk67nNEm9btp+PHAv7vTbuOLWU0cxzxW6pJ5ZHp0VJfRmD218
	 E+G8zBEhiAzVgtfAewhyirRCWrTtsaZRUYdkHuDCo6t9RMXL8H4GWsiXCCpHJL4HkXsc1
	 eeEIwr18ODb/PNh9MMwwLjfbd1fV1jbYMrv1VOdquN0M2YjPfMtk1PMeQNpSttk/+0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=IaAyUJEv;
	arc=none smtp.remote-ip=66.163.191.205
Received: from sonic312-24.consmr.mail.ne1.yahoo.com (sonic312-24.consmr.mail.ne1.yahoo.com [66.163.191.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF3606A215
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ACF3606A215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=IaAyUJEv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505065; bh=diytamQUMIsvhu7SSiv2EcPyNPlyBzwkF5WLWQigtPc=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=IaAyUJEvBYHxu+8hl9GtJmkcHUBjTfj85VMgjkmnPvNr2Bf+dQZF8vw0XmvPG7wYOTZCPj0jzXXE0g1LNlh8oPGXCEs6eeMEP5cs7HaH+3K4+IJAHb69OsTmwuWBjktkOIQQKpP7BpRAnNhbU2dY75dEuNInqrVpaPhtKB55dAPTcIf5VBicuclAqOAJfbCYP+KLz4gsMHhLVcGHyklaxahHiYsqi2bKOVpGVikhZKrm41ukGNHtlyrY0C2MjXFgaROS004T2X5Z04uqELgdeHvh9V6TnkazWO399Fr9gujTOuPOnYQfK5VIJlEYbiKLHOUlDxT2dE3l+fAdYx0Qsg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505065; bh=9DKo4w9p02wE5SgQTW0/oZtEsXTa2PUjdofKdtm4pmK=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=iHCFAq/tzy/3BOaD/+AV6XSKtQzNUHvwB6OHmlpre87r33ftw+y589MPUauKzM5Csso2eW7DPLEuUVmCNR/sCDPdHLiR4IlPkOgpHT5EI4l7PLX5fEupsixexQVy5Ay1I2bv5I1Ec+qj5IJayUCosmLGeleeFOusf9lqO4+bi9wYAfwNznqf3MNdMXCgyEr+UKlnBVw8e49kiKCWyNhij98jhD8DFo8yvKo8BZp3WIMpRE7e7ZUrCj9Mb8ffbBWDyvrdE3+uO0WQkkMUBqzaS6U5k5R+yvGDY4KGZebkZR0TGeesBoGp/RCs/c/aZFPTJuEXh3s42Bboz4/z8C7Xhg==
X-YMail-OSG: 91k2XcoVM1mn_ZYXS7Vz9JXeFsDAXhQPCPcrs_SO3AC41cHji4WEFYTSC_XGS6h
 mRNPHwSAwjK0gayN9zebiRH56rm_D48OebMprT816dc8fEXL.yFDROOAjnNucUvneWUJ9ka2XZug
 wf8p.wNZ1f5oeRZW2ga.xAhmErwVjoVM_27sgt_zEVfLRsaGf9qff8GACAx3609tybL32Yl9GXVu
 FeOr7yknpLWo5xJMHFfj8ihJeqr5oE65i5dytGfMY6aR9HPAUwqtePZBjw_v5xQfg6XbpZrQsGFL
 u2ozgNkV9FQouMfZOF501wyhOO.BPYUxtbkydbCxNgesgTuEG0mJS2fYMMvWGvRXHVC6MVe2N3qI
 bhLirNKhbxm1xhhJ0p0X9qkIUeS79I9pMnYo.cJ1cwqrhFq8muICrkN78IrbuP24KtoQK_w.qRph
 Jtw5O9u.gFjH8erUaGec5ZxUaoSTfP_imFIZ0r.ixY5_xhiw1UsGv61TjE6eTwn1g.qFFqXCS963
 nQxd.jV9KCPcDiavlfbSXhHwGM6AMgG5MKr61P4aZFSOz.9ulpltBPcEitZHRG4D_McKchmNFQzf
 vIlJ3KDVYNBbFBS8ogVLnsaTUTGGgMZuy1cGW5Da5t7bD_lyVWcUvGZI43B8QLQ5b1tfmpbqDXug
 VmVjvX7i4gVK.b3f9Fceq0wisgO82OP28YtLMLY0b9g_VrKqf7UoH9lQp8Ve7Pp6Mnz805GyHxPU
 cZ4MntYBQeqx5W0spMJQQqRn5YqZVMo4sScZlkfv1LlQAVTrpBGzDADNObqGWZ1A29lzoRE7B7yT
 x_TT3.rlc7T4_56ptEthKB1TzULYM8c7quVqK8j_8rpwWfEL4lPVLPrwiDa5vbNn2aac5pyqzZ81
 gO2kQd7jLXCgf29AVYrbsJJzT3yx1ud6WtX8UCoVAtCsEgA_lmz5nsGTRU69Qso1LBSRNeALeS.s
 WCvjjsRxhvlT98fPrfBXZNQuhEZXlUHAQqYlzCuwQ29q6J_zMv8siLmiAwIENqnvEzoLXN20aSDO
 0Ys6Lqu3kH8lvIQ4pmTdskfmXMLOkAEqQM4rIhbWZetC5l.6WqJqFpY8RP1tGRtSryhCOkhyWWo7
 APPLkV0Myv6wou90CoKG31MnMmVJG1EvbNzdGs0NqpykKFuYp30O8CpyiBW1GSh2oZ2oPkarHqIX
 5LZm8S4TxtrC37Y5DoQnq3j7hmzJdKl2hzfRktzWxs5DjpdPKksr_y6n1Dm1dVwlVCB9jyOFPF8P
 uPVgtPeFjDimmcrfAVFy1a.oDLnvVJ2u_N9hFLAb3JK35zNTcBaWFcacAOCfvqrVQp3DdadGEvj1
 ki44Ev2YxPEjX0r22BKnRfesuVrl64NVBInhux3nqbo9Mvq3zsDukGQ9cLPS47fzNLGLDWxYxJiY
 nbkm6Jq61eI8SMkIqwsyERAv_B402VidCBeMME4rWZIZ48rKzhwmPGWPw8OJ0ONRVeykGAwhbDsY
 LhPNfa9g8LuyQBXUnSQ8oI6a8NaQo8RaC4wYB33fSW273WV4XZkodDJSD8GP_DmaxcYmC.GTGdOh
 5EXymvgxvuMUQsCrymwXtQEXhul5tT0o8hM2qcP2kDI.ePhFvBIKqjR9.v.Om.30Hlm9qlBtz5dL
 HM8OIODEQX_HwyFEmx6xSRmj6z9r0p1XYaYN2K1L4GLIOaNZFa2Qa6MFeIC1o9Mltk7ZAymaqSxC
 a2SRYRumRQRQV4T7qG2Q3zVdc.sGt0jb_BCmaIhASKrXLbEj3YKagM_M22PNmC.QrgQCecQo18T1
 8hvPDSJcJJZU5_I5yvShenyCvRYhj370.eN.BlnC13yPnlWDATCJxqxWgxPIxq7nx8REBvxYgCwn
 1oXM4Rw3AzKfA059MAe0evwQp3qk1jISmWT3cB5B55dYET9Rog4aW0YTMYALAiR9sl5OAZ_XO1hc
 SloWZF86k3CsPhKPmRzTy_0NLOC0S9Z8MMHpMKgXXK7rY6M2taskVxNGwJA8RocHLMI5CiwydfYe
 ECy8WurdVfKsJm1fsYAjJWFzIZz1.NBclkrhZJLaHMvywhyuA8pgmbCkLWKptsLGkN4mWTWiWzPR
 Zqb8.oStJ.ingC9dwzGtn4IgpVGhsZ4ya3Ec2fj0n7GPlHrWw311JdmGuWtdAYvFz9HtmrWRhzYr
 8oyuayAgdw3zkloNNOesj4iT.9Oi_djc3FgSETSrjNAX6h1diAfZS.ZG3lEiqiXJGVlIli4PyzdF
 raN3EaYtddUmPDj.VyGkbzkSDZbMDu0wGQViOj_L1jXR2o5xvkhvmB8LbC3EdGy5EUZeZ5wMqQv2
 ON5DHji6XTaC3PpZNATELug9gk7FWXgVW3rrdSmGliJuCNw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 8d815c84-8dc7-4a0f-8d40-f14e05f556b4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:37:45 +0000
Received: by hermes--production-ir2-5dd9bf4598-ck52d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 92480529f98ca63e8f9d6a80b1861c26;
          Thu, 12 Nov 2026 17:37:41 +0000 (UTC)
Message-ID: <915a9103-82e6-4504-8d6e-3d12c4e7af1a@yahoo.com>
Date: Thu, 12 Nov 2026 18:37:38 +0100
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
Subject: [PATCH net-next v10 07/12] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
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

The hardware structure of 4K VLAN table entries has changed between
silicon families. Family D's CVLAN entry is two 16-bit words rather
than three: there is no third word extending member/untag past bit 7,
and no priority/meter fields at all. The FID field is restricted to a
narrower 2-bit width. The chip itself supports both IVL and SVL.

IVL_EN (bit 3, versus bit 14 on family C) follows vlan4k->ivl_en. On
family D, rtl8365mb_vlan_4k_port_set() enables it while any user port
has VLAN filtering enabled (dsa_port_is_vlan_filtering()), so that
static and learned FDB/MDB entries use the same key. Family C keeps IVL
always enabled, as before.

The stored IVL_EN is refreshed on the next port_vlan_add/del for the
VID, not on a vlan_filtering change.

Reusing the three-word family C layout on family D would read a third
word that does not exist as a distinct table word on family D's die.
Whatever data happens to be in that register would be folded into
member/untag bits [10:8] on read, and written back on every
read-modify-write cycle in rtl8365mb_vlan_4k_port_set(). Give family D
its own two-word pack/unpack instead: add rtl8365mb_d_vlan_4k_read() and
rtl8365mb_d_vlan_4k_write(). The shared code reaches them through the
vlan_4k_read and vlan_4k_write pointers in struct rtl8365mb_family_info,
so the pack/unpack code needs no is_d() check.

The two-word layout matches the vendor switch API for this chip
family, which writes only 0x0510/0x0511 for a CVLAN entry.

Nothing points to them until the family D info is added together with
the chip table entry in the last patch. Until then they are not static
and are declared in rtl8365mb_vlan.h, so that the build does not warn
about unused functions.

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 95 +++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |  4 +
 2 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 566c6bc..bf1a6a9 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -53,8 +53,11 @@
 #include <linux/lockdep.h>
 #include <linux/regmap.h>
 
-/* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
+/* CVLAN (i.e. VLAN4k) table entry layout: u16[3] on family C, u16[2] on
+ * family D
+ */
 #define RTL8365MB_C_CVLAN_ENTRY_SIZE			3 /* 48-bits */
+#define RTL8365MB_D_CVLAN_ENTRY_SIZE			2 /* 32-bits */
 #define RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK		GENMASK(7, 0)
 #define   RTL8365MB_CVLAN_MBR_LO_MASK			GENMASK(7, 0)
 #define RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK		GENMASK(15, 8)
@@ -66,6 +69,9 @@
 #define RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK		GENMASK(13, 9)
 #define   RTL8365MB_CVLAN_METERIDX_LO_MASK		GENMASK(4, 0)
 #define RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK		GENMASK(14, 14)
+/* Family D CVLAN entry, word 1 (family D has no word 2) */
+#define RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK		GENMASK(3, 3)
+#define RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK		GENMASK(1, 0)
 /* extends RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK */
 #define RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK		GENMASK(2, 0)
 #define   RTL8365MB_CVLAN_MBR_HI_MASK			GENMASK(10, 8)
@@ -231,6 +237,45 @@ int rtl8365mb_c_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 	return 0;
 }
 
+int rtl8365mb_d_vlan_4k_read(struct realtek_priv *priv, u16 vid,
+			     struct rtl8365mb_vlan4k *vlan4k)
+{
+	u16 data[RTL8365MB_D_CVLAN_ENTRY_SIZE];
+	int val;
+	int ret;
+
+	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
+				    RTL8365MB_TABLE_OP_READ, &vid, 0, 0,
+				    data, RTL8365MB_D_CVLAN_ENTRY_SIZE);
+	if (ret)
+		return ret;
+
+	/* Unpack table entry */
+	memset(vlan4k, 0, sizeof(*vlan4k));
+	vlan4k->vid = vid;
+
+	/* member/untag: d0[7:0]/d0[15:8] on both families. Family C
+	 * extends these into data[2] bits [2:0]/[5:3] for its 9th-11th
+	 * ports; family D's die has only 8 ports and no third table
+	 * word, so data[2] does not exist there and must not be read.
+	 */
+	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]);
+	vlan4k->member = FIELD_PREP(RTL8365MB_CVLAN_MBR_LO_MASK, val);
+
+	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, data[0]);
+	vlan4k->untag = FIELD_PREP(RTL8365MB_CVLAN_UNTAG_LO_MASK, val);
+
+	vlan4k->fid = FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK,
+				data[1]);
+	/* Family D has no priority/meter fields in this entry -
+	 * left zeroed by the memset() above.
+	 */
+	vlan4k->ivl_en = FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
+				   data[1]);
+
+	return 0;
+}
+
 int rtl8365mb_c_vlan_4k_write(struct realtek_priv *priv,
 			      const struct rtl8365mb_vlan4k *vlan4k)
 {
@@ -277,6 +322,38 @@ int rtl8365mb_c_vlan_4k_write(struct realtek_priv *priv,
 				     data, ARRAY_SIZE(data));
 }
 
+int rtl8365mb_d_vlan_4k_write(struct realtek_priv *priv,
+			      const struct rtl8365mb_vlan4k *vlan4k)
+{
+	/* Unknown bits of word 1 are written as zero, same as the vendor
+	 * API does for this chip family.
+	 */
+	u16 data[RTL8365MB_D_CVLAN_ENTRY_SIZE] = { 0 };
+	u16 vid;
+	int val;
+
+	/* Pack table entry value */
+	val = FIELD_GET(RTL8365MB_CVLAN_MBR_LO_MASK, vlan4k->member);
+	data[0] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, val);
+
+	val = FIELD_GET(RTL8365MB_CVLAN_UNTAG_LO_MASK, vlan4k->untag);
+	data[0] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, val);
+
+	data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
+			      vlan4k->ivl_en);
+	data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK,
+			      vlan4k->fid);
+	/* No priority/meter/member-untag-extension fields exist in
+	 * family D's 2-word entry - data[1] and data[0] above are
+	 * the whole entry, and data[2] is not part of it at all.
+	 */
+
+	vid = vlan4k->vid;
+	return rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
+				     RTL8365MB_TABLE_OP_WRITE, &vid, 0, 0,
+				     data, RTL8365MB_D_CVLAN_ENTRY_SIZE);
+}
+
 static int
 rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
 			   const struct switchdev_obj_port_vlan *vlan,
@@ -314,7 +391,21 @@ rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
 		vlan4k.untag |= BIT(port);
 	else
 		vlan4k.untag &= ~BIT(port);
-	vlan4k.ivl_en = true; /* always use Independent VLAN Learning */
+
+	/* Family C always uses IVL. On family D, IVL is on while any user
+	 * port has VLAN filtering enabled, so that static entries match
+	 * learned ones in a VLAN-unaware bridge (SVL).
+	 */
+	if (!rtl8365mb_is_d(priv)) {
+		vlan4k.ivl_en = true;
+	} else {
+		struct dsa_port *dp;
+
+		vlan4k.ivl_en = false;
+		dsa_switch_for_each_user_port(dp, ds)
+			if (dsa_port_is_vlan_filtering(dp))
+				vlan4k.ivl_en = true;
+	}
 
 	ret = fi->vlan_4k_write(priv, &vlan4k);
 	if (ret) {
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
index 009b127..012c07d 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
@@ -24,6 +24,10 @@ int rtl8365mb_c_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 			     struct rtl8365mb_vlan4k *vlan4k);
 int rtl8365mb_c_vlan_4k_write(struct realtek_priv *priv,
 			      const struct rtl8365mb_vlan4k *vlan4k);
+int rtl8365mb_d_vlan_4k_read(struct realtek_priv *priv, u16 vid,
+			     struct rtl8365mb_vlan4k *vlan4k);
+int rtl8365mb_d_vlan_4k_write(struct realtek_priv *priv,
+			      const struct rtl8365mb_vlan4k *vlan4k);
 
 int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port,
 				 u16 *pvid);
-- 
2.53.0

