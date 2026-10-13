Received: from sonic316-22.consmr.mail.ne1.yahoo.com (sonic316-22.consmr.mail.ne1.yahoo.com [66.163.187.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495A3BB669
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881578; cv=none; b=KgHqv7Xz97xrJrACW9MRJQ9nYABAamN0ksjGqy3DBGTxjOlND4s6eicTm8TOtUxrg9v4YdLzMmdjwiEvyt9QkufJwthztQV6Sv9cwk/msFzIdpHkzsFVA/lWn4NFUQXcyo+pWVdnb3tHPwlRuCrd2TUyuR6wfmwXVUuK8gzgFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881578; c=relaxed/simple;
	bh=S8J16qJVBG/vVVhWbRT2xjN9CG5nEZRxVzNI9qLbaxM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ArvOciAQ1pggbTCCXLbeDkvic+kyPJEqsuwIzrPbUv56r1pGIPqa8wqjvxODPj5m0Jw8btajK1WjbG2D3O1McRvvxFE7ACNkfTN4GSHri/OuGzhIY9X/yDJagFh04W641b/RbgNpIm+OutmcOjOqJAd2qom4IzQxgeSbpTugxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SOGP5sRV; arc=none smtp.client-ip=66.163.187.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SOGP5sRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881569; bh=L4v0LOBczl03xbEjPUOyfMtthvxuyur4aJtVaiVx+eA=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=SOGP5sRVQoZFam2IirAC37j92WecM/uCpHTQbNrFl7aet5aNJzw+iLt+vr/k4XdHx0waVm/r+zvLQ/k3RJ2vhYwJVu4+vTGOaOgmpUrRh7sZ0+0bINyfNoy3t+ejFBOGZTkLR0oFRZT1fInFIHHyi8AAHTZXWFRgwRASpgEsnsoGmnUbHGHGiJXO10QfTK3i0Nnqhl8l/qKSTgTTikwgt71nY/ZZ8TpCurHH+CoUuKsIauI543Vgkv+cS5GnTl7yEVwgNwSwjPCD2VTbT/gaJCApyooLmCy/O/+iA9SaUOv/nuR0LbwKeLBLwmTD3qVLFsdb4tfkHp/QO3u2iF44NA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881569; bh=IKdp3WHFvERsITjIRc8qHnNeDUHfkTsPT4avKUWkiiU=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Woo3s0J3SYhmFHIBKG8mfyHykZ9/tA+VPMet1bJ1+Z3oXvvWmcfIEGRhLGxIYVoxvTMoqDdC/tdGFYNPCNPe/PI4EJ75QiO8YHcRiLP2HVLCSF3WSSk4+Jc9CTnvax2LCOWYAyUwhDh3Qy8SLWLl2+ZiIX6GUYn9Gt/QqW4eicnWfAhr8qxrUn9d96MLRK+kmxJk9Hw57LjfJqV3jGz6lbZJV/aTl1deNZz570xpYcjDRU1gAGYjK7cQR15M69AEP1g98xLC61Hjc4CfA8d7pEw85nPRuHTI17z1nvcYzfPJraPi/3HlKMkvnTyFH5rwFm49Vwcmgs0Eh/9Cb/oYWw==
X-YMail-OSG: ZpicPXwVM1n5SNRP5_mcEMErpzTlA2Z1TyysWg2BgGVjh1U02VbmaV4qO6SAA8c
 gH4.ewEsSFon9PBvJNAaUEGijFdUDEnxEwRitPZ9C9945zHmiTpbOF5mSM8ef7ZQtftzWfEs9icH
 16umKPqBM4H5lgfz1pQ_fUg6elR6BgBxHh2pokGuziPFJfmRi6rDwiAtkQ6TOZH5ZmhRWCjEH.SI
 hO1.TxFq7lx_bpNe1w.SndatH8qME5fagaCM0GdNZ1RpxnMwuckAhBM1Y3oZqv8Tyl4LYLGot.7w
 6XSOD9TIyYpI7vWW00BKkg3uRRiyBcIhDNY0lcrc7P7C2pHMFNocbW2BsQ3twUMpufQT2BTgK2Xd
 liHwCcDR5x7giwgPVe9aoNsgnxhLuyV8rNBi38CcXsXJ5MeWx9wEJ1ClFUL9UKSmFCzdGtFbJoog
 Qoi8clYUhtB3NZRahKyJxRdVUTgnTRzKM1w.cdxDmwteqi.JnNIVQqkdB6kiAk76vU7uG3QJhwqk
 iybl.Y9ompvtLhzPWTKUA6T3KoFCPLa91g7KYeltzo.WKhuhOc9HO5i3G7sUoYT.9crZnRNAS6vY
 RnOb_6kdksOE15dPFItm3FqNYyLsKHsPBeqyr0AMZLXetX6trVZN2jz2li7DPuAWwRPY5NjnYwIR
 oFKo4kJ4qNDPOnzWUfXkR62O1cmrD2d5tovCRGXLy0Jg04rjscXSrjYM8AC2OuHMZwzLrKHILlpy
 svhhqeBjRSG77NI1Gm4JL3i941d6J_8GqM9c1QMODspjTU9Z5YUzvchM2bmUfNyg10ROS.ajc84B
 K_9yC52fflscPxq23Dkt9fv0.Ii6axPSkpyGt52ltylciwuO_AzhH_a13LftDmkhqrmhTbvwyIZz
 zTL2EoNXAqMUNFmKRuspC1iT9YnnU4xqaWDGVCoP2y1NrO9.UO0gVQbOcDlVkgvMG.fhk_Dkp6mi
 OsK6jvQrWEgoeSF6A3LKble6_eFUwabdPSAn7smHuDKHUec4kl2KIoee.eZJLWvF.eypJUcj3xxF
 gVfwcex6.aJsWlqGHjBL6U6r8pFH1oV7i.kYNSeMPg3pWiEqshyTMSWYXf_0wFraonmqbDJQ3u5S
 OIbltADjq4TVJLagNH9Y2Vjbei7frKvjhzrKnR8I7LzwSZVVGp8shvqPEPUCaHY5bmkJeQtQfLvH
 U91gZJq9QiFNPmDSjqK2DuBLsB9X2Zc4ynqQlBFHkiZl42956FnAdZVbwBHom7aQgiQa1lzoXKJq
 tRBv_fajQWVk.65T9jDKN4AweFxI3QMax_nt2Fo8t1X1_C5xGI_OGL_i.0Qwd4Kd4cdk28Y2ZUIR
 bgB62TxRTLZOO4tHIf236O429bOxtyXs0d1rNqlwZOXkuPEdSIRp0lCSMFNvyfOnq.GORtWye9LE
 1MEmvm4vVGlelIoRLRJWml8SdzOTUbqv3rrqEyS.fTy2P7B4PsDHXkAVtjs4d5Vadi7HasxBcLsI
 LshOGJ6JqQl2ylZe4q5Ea6uAyy4ZBVnnMS2wMl4iflfMdT.L_Rx9rtaxCV1fDQsKUHTT3zPZZHFc
 QY1HrgZtl3qSH_DlDcA5KTrIyIhpxWl0YxzaPQvcohLgKbVd7CLuTKo6m7.vXFbaOf2pvaWt48u7
 5RI.y9UOdY0tzaTZKO3fs76zCeC0krVQ.7.xs0fxOLzZVfQNX4p8kv4MXUZnFEF5RN173Xs2kiJC
 25v2AYW2Z3T2hzRsebi0_bRBCZU6Ph3ZJeBj10uFA.mHZ3dAET1pSPmDbaco1HS13mfEW913HVLG
 BZRc0cqQ19PoyytnECwiT5V.Q836W16K_qbfU37jEZiqWINnx.edbal_47P0H7IHhXSrk14jwGLN
 lW9zf4r0m6xGGJ46lEyl2yQr5.9XodvbSuJHetOP0SY2qS8Rd0BiTJ2VdrMASh37WDfaqcHjTtsj
 ZbtT0M0mwijYOieFuWPzPs986Zr.kybjf2luektQbje2YPwo6AM__58bluHu7k6b6RdvWmPufQOw
 ZxQIB0IbvkpBLbLgS1IvJAAHUL9uaNBlE7PPhAxGc8jweFO3xex5iQ2ichni.FKc9Ihaq_s65K83
 qyzRIeXFurdQTBRAsGNjIofH_AiqbIvY2xiHXjzs9WY4v1dGnSeERU10FvcTz0AnPeFbpCYbQ_0C
 n4qiRl2A00Ar8rzecppk76EmDQ8xGZJjxUB2XHdavcqCsKkmPULvd9RnYLoLkOkAY48tZKg3VQos
 6GRvdqxizFYP2CA77S.OHtIxzEG7PkQ5QpgAsX3IC1crRENUCbr426ZrSFyGNzUPlJ_YsagvSgMc
 ZHj9kCrTMIOE-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 26443b18-8dfb-4e9f-9f56-b7c22cd9e2ae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:52:49 +0000
Received: by hermes--production-ir2-5dd9bf4598-cdfcp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 36fe8aff1b21f531c1aa68371da6117b;
          Tue, 13 Oct 2026 08:42:28 +0000 (UTC)
Message-ID: <cf383ead-d169-4679-a4d0-028ea04d8a11@yahoo.com>
Date: Tue, 13 Oct 2026 10:42:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v5 5/9] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
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

The hardware structure of 4K VLAN table entries has changed between
silicon families. Family D's CVLAN entry is two 16-bit words rather
than three: there is no third word extending member/untag past bit 7,
and no priority/meter fields at all. The FID field is restricted to a
narrower 2-bit width. The chip itself supports both IVL and SVL, but
this driver always requests IVL for VLAN 4K entries
(rtl8365mb_vlan_4k_port_set() sets ivl_en = true on both families), so
both the IVL_EN (bit 3) and SVLAN_CHK_IVL_SVL (bit 2) controls are
forced to 1 here. The vendor RTL8367D CVLAN API leaves SVLAN_CHK_IVL_SVL
at 0 and only sets it from the SVLAN member API; the value 1 has not been
verified against the hardware with the bit cleared. vlan4k->ivl_en is
still read back from IVL_EN.

Reusing the three-word family C layout unconditionally means the third
word is read from and written back to the register that holds it on
family C, but does not exist as a distinct table word on family D's
die; whatever data happens to be there gets folded into member/untag
bits [10:8] on read, and re-written on every read-modify-write cycle
in rtl8365mb_vlan_4k_port_set(). Give family D its own two-word
pack/unpack instead.

The two-word layout matches the vendor switch API for this chip
family, which writes only 0x0510/0x0511 for a CVLAN entry.

The family D paths are not reachable until the RTL8367S-VB chip table
entry is added in the last patch of the series.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 175 ++++++++++++++++-------
 1 file changed, 123 insertions(+), 52 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 8d49ffa..c2cfdf1 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -33,7 +33,9 @@
  * 1. VLAN4k entries can specify whether to use Independent or Shared VLAN
  *    Learning (IVL or SVL respectively). VLAN membership config entries
  *    cannot. This underscores the fact that VLAN membership configs are not
- *    involved in the learning process of the ASIC.
+ *    involved in the learning process of the ASIC. (The driver honors this
+ *    selection on family C only; on family D it always forces IVL, see
+ *    rtl8365mb_vlan_4k_write().)
  *
  * 2. VLAN membership config entries use an "enhanced VLAN ID" (efid), which has
  *    a range 0~8191 compared with the standard 0~4095 range of the VLAN4k
@@ -48,12 +50,16 @@
 
 #include "rtl8365mb_vlan.h"
 #include "rtl8365mb_table.h"
+#include "rtl8365mb.h"
 #include <linux/if_bridge.h>
 #include <linux/lockdep.h>
 #include <linux/regmap.h>
 
-/* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
+/* CVLAN (i.e. VLAN4k) table entry layout: u16[3] on family C, u16[2] on
+ * family D
+ */
 #define RTL8365MB_CVLAN_ENTRY_SIZE			3 /* 48-bits */
+#define RTL8365MB_D_CVLAN_ENTRY_SIZE			2 /* 32-bits */
 #define RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK		GENMASK(7, 0)
 #define   RTL8365MB_CVLAN_MBR_LO_MASK			GENMASK(7, 0)
 #define RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK		GENMASK(15, 8)
@@ -65,6 +71,11 @@
 #define RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK		GENMASK(13, 9)
 #define   RTL8365MB_CVLAN_METERIDX_LO_MASK		GENMASK(4, 0)
 #define RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK		GENMASK(14, 14)
+/* Family D CVLAN entry, word 1 (family D has no word 2) */
+#define RTL8365MB_D_CVLAN_ENTRY_D1_SVLAN_CHK_IVL_SVL_MASK \
+							GENMASK(2, 2)
+#define RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK		GENMASK(3, 3)
+#define RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK		GENMASK(1, 0)
 /* extends RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK */
 #define RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK		GENMASK(2, 0)
 #define   RTL8365MB_CVLAN_MBR_HI_MASK			GENMASK(10, 8)
@@ -132,7 +143,8 @@
  * @priority: priority classification (unused)
  * @priority_en: enable priority (unused)
  * @policing_en: enable policing (unused)
- * @ivl_en: enable IVL instead of default SVL
+ * @ivl_en: enable IVL instead of default SVL (family D always forces IVL
+ *          on write, see rtl8365mb_vlan_4k_write())
  * @meteridx: metering index (unused)
  *
  * This structure is used to get/set entries in the VLAN4k table. The
@@ -185,13 +197,16 @@ struct rtl8365mb_vlanmc {
 static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 				  struct rtl8365mb_vlan4k *vlan4k)
 {
+	bool is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
+	size_t entry_size = is_d ? RTL8365MB_D_CVLAN_ENTRY_SIZE :
+				   RTL8365MB_CVLAN_ENTRY_SIZE;
 	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE];
 	int val;
 	int ret;
 
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
 				    RTL8365MB_TABLE_OP_READ, &vid, 0, 0,
-				    data, ARRAY_SIZE(data));
+				    data, entry_size);
 	if (ret)
 		return ret;
 
@@ -199,33 +214,61 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 	memset(vlan4k, 0, sizeof(*vlan4k));
 	vlan4k->vid = vid;
 
+	/* member/untag: d0[7:0]/d0[15:8] on both families. Family C
+	 * extends these into data[2] bits [2:0]/[5:3] for its 9th-11th
+	 * ports; family D's die has only 8 ports and no third table
+	 * word, so data[2] does not exist there and must not be read.
+	 */
 	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]);
 	vlan4k->member = FIELD_PREP(RTL8365MB_CVLAN_MBR_LO_MASK, val);
-	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2]);
-	vlan4k->member |= FIELD_PREP(RTL8365MB_CVLAN_MBR_HI_MASK, val);
+	if (!is_d) {
+		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2]);
+		vlan4k->member |= FIELD_PREP(RTL8365MB_CVLAN_MBR_HI_MASK, val);
+	}
 
 	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, data[0]);
 	vlan4k->untag = FIELD_PREP(RTL8365MB_CVLAN_UNTAG_LO_MASK, val);
-	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK, data[2]);
-	vlan4k->untag |= FIELD_PREP(RTL8365MB_CVLAN_UNTAG_HI_MASK, val);
-
-	vlan4k->fid = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, data[1]);
-	vlan4k->priority_en =
-		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK, data[1]);
-	vlan4k->priority =
-		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK, data[1]);
-	vlan4k->policing_en =
-		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK, data[1]);
-
-	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK, data[1]);
-	val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_LO_MASK, val);
-	vlan4k->meteridx = val;
-	val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK, data[2]);
-	val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
-	vlan4k->meteridx |= val;
-
-	vlan4k->ivl_en =
-		FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK, data[1]);
+	if (!is_d) {
+		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK,
+				data[2]);
+		vlan4k->untag |= FIELD_PREP(RTL8365MB_CVLAN_UNTAG_HI_MASK, val);
+	}
+
+	if (is_d) {
+		vlan4k->fid = FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK,
+					data[1]);
+		/* Family D has no priority/meter fields in this entry -
+		 * left zeroed by the memset() above.
+		 */
+		vlan4k->ivl_en =
+			FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
+				  data[1]);
+	} else {
+		vlan4k->fid = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK,
+					data[1]);
+		vlan4k->priority_en =
+			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK,
+				  data[1]);
+		vlan4k->priority =
+			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK,
+				  data[1]);
+		vlan4k->policing_en =
+			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK,
+				  data[1]);
+
+		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK,
+				data[1]);
+		val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_LO_MASK, val);
+		vlan4k->meteridx = val;
+		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK,
+				data[2]);
+		val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
+		vlan4k->meteridx |= val;
+
+		vlan4k->ivl_en =
+			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK,
+				  data[1]);
+	}
 
 	return 0;
 }
@@ -233,6 +276,9 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
 				   const struct rtl8365mb_vlan4k *vlan4k)
 {
+	bool is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
+	size_t entry_size = is_d ? RTL8365MB_D_CVLAN_ENTRY_SIZE :
+				   RTL8365MB_CVLAN_ENTRY_SIZE;
 	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE] = { 0 };
 	u16 vid;
 	int val;
@@ -244,36 +290,61 @@ static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
 	val = FIELD_GET(RTL8365MB_CVLAN_UNTAG_LO_MASK, vlan4k->untag);
 	data[0] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK, val);
 
-	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, vlan4k->fid);
-	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK,
-			      vlan4k->priority_en);
-	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK,
-			      vlan4k->priority);
-	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK,
-			      vlan4k->policing_en);
-
-	/* FIELD_* does not play nice with struct bitfield. */
-	val = vlan4k->meteridx;
-	val = FIELD_GET(RTL8365MB_CVLAN_METERIDX_LO_MASK, val);
-	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK, val);
-
-	data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK,
-			      vlan4k->ivl_en);
-
-	val = FIELD_GET(RTL8365MB_CVLAN_MBR_HI_MASK, vlan4k->member);
-	data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, val);
-
-	val = FIELD_GET(RTL8365MB_CVLAN_UNTAG_HI_MASK, vlan4k->untag);
-	data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK, val);
-
-	val = vlan4k->meteridx;
-	val = FIELD_GET(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
-	data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK, val);
+	if (is_d) {
+		/* The chip supports both IVL and SVL, but the caller (see
+		 * rtl8365mb_vlan_4k_port_set()) never requests SVL, so both
+		 * IVL/SVL selector bits are forced here rather than threaded
+		 * through from vlan4k->ivl_en, which family C does honor.
+		 * The vendor CVLAN API leaves SVLAN_CHK_IVL_SVL at 0, see the
+		 * commit message.
+		 */
+		data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
+				      1) |
+			   FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_SVLAN_CHK_IVL_SVL_MASK,
+				      1);
+		data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK,
+				      vlan4k->fid);
+		/* No priority/meter/member-untag-extension fields exist in
+		 * family D's 2-word entry - data[1] and data[0] above are
+		 * the whole entry, and data[2] is not part of it at all.
+		 */
+	} else {
+		val = vlan4k->fid;
+		data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, val);
+		data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK,
+				      vlan4k->priority_en);
+		data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK,
+				      vlan4k->priority);
+		data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK,
+				      vlan4k->policing_en);
+
+		/* FIELD_* does not play nice with struct bitfield. */
+		val = vlan4k->meteridx;
+		val = FIELD_GET(RTL8365MB_CVLAN_METERIDX_LO_MASK, val);
+		data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK,
+				      val);
+
+		data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK,
+				      vlan4k->ivl_en);
+
+		val = FIELD_GET(RTL8365MB_CVLAN_MBR_HI_MASK, vlan4k->member);
+		data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK,
+				      val);
+
+		val = FIELD_GET(RTL8365MB_CVLAN_UNTAG_HI_MASK, vlan4k->untag);
+		data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK,
+				      val);
+
+		val = vlan4k->meteridx;
+		val = FIELD_GET(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
+		data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK,
+				      val);
+	}
 
 	vid = vlan4k->vid;
 	return rtl8365mb_table_query(priv, RTL8365MB_TABLE_CVLAN,
 				     RTL8365MB_TABLE_OP_WRITE, &vid, 0, 0,
-				     data, ARRAY_SIZE(data));
+				     data, entry_size);
 }
 
 static int
-- 
2.53.0

