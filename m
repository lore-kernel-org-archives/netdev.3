Received: from sonic308-10.consmr.mail.ne1.yahoo.com (sonic308-10.consmr.mail.ne1.yahoo.com [66.163.187.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB390405F7
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791764595; cv=none; b=p6K30TBhuaSHphsgK0rjMfpNQ+0v4S/LNeCIaZCynuENyJD9TPqc5wGtpl82o0m5S8wW6NRKeAlI0uOIIsRxC5hMCBBZQZwNvaLVBDRofpxYHA6Wxa4AxM9o6L+/j6TwSi4VZ6E/t9CuCjbOPB9jgZce74n2zzCH7Ema9ijvjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791764595; c=relaxed/simple;
	bh=UlIZCjXa1zPszORJnRN0073HFnneuoH7s0qREYoDhdM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HSjVWCIXCd3mm4ldm8bJf4P57kcrzd7Hk8v6TSo41/5BaQiqhV+JBI0t2WCzkd5qFm9anb4kzi2O9Zj02LM/EVnGP7+E2Z7Qf2TOcuS1T+IDKPCfnVWG4hqxzxZ62sKzA/DCHnJmJ/4gFetON7/UBO79ncFLwotCld6TRdYfLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=e+PYFZ4S; arc=none smtp.client-ip=66.163.187.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e+PYFZ4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764587; bh=y7p0MJChqhSujHcvaD3szqnYZ4R9xeDjvtZZJRlFFFo=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=e+PYFZ4SO2VkcbUNqVcyVDDLT0/YkfKyV3Q2l9k5XC5JgpnpGBrO3Em/fVov6U93ktBq88mTaH/euRfkttIckkuVSgViWjEefyuqrnQ4PhSyPAcA2Bvx+vu31T81HHTQseVxZQpVlrT0jpPf2O5toBPth47A+YKBGsmdr+wUODinOq9jTDZstyEoPDh0qfpAzPxylH+VUpSEtSsn8dPBoyu/KnQ57bF6AeKNVUxq1WESmQtMcXdqpx0ITcI1n8V0FoXfyqBPofNWhOXmS7wVVR5uhFASBUR1Ew/7ctW3gOyPCNEpq351L2xUKPzLrKNEzkk/boWQxHFzhAkhc1dhmQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764587; bh=pV3tdSDQ4tobsxJwMnMFB3RyukV871Us78PVSX44/KS=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=GWfJr0yDjou+VG40jw2LkxsIQH9gyI2i0zxjxCAdbyq6CiVqnE7Am+mW/kS6qPZw4sXffXoNRGHNojI4ksaVU2jRap7egDrom45+JmeSpTAPFq8dGp1nQVAQLRrAyU5JF4Sgh63l6EGzD/OBh3j9aHR+DHx+Uqm5qDDWhaCirIQS5Gq0wRWEiMYRQboLFQtGrILTQDcuRHadoEVp6clIX6ha2b7F5yYkDzKOlvshUXm+56ptV5k4gG0rSXCV+GHV5uZEQZms6S8F41+qtbUfu323NrcrJWG7HrRPZH03j1YTVdvfundodzczbLYyb5133IeKa4Rsu//uVFXiGfWnAA==
X-YMail-OSG: 9GIf3JMVM1lXqefgdd6Cv3CQYjS8iaZ_56rOilMFAKP_SeIlGk9D7fnBfIw.0GE
 j5J8n.3KJ59hn35zi4YGoQMguxxy4XiALKl4oONc3.ED2BDULF.PD8QcRlb5GGoh_bEaravwufNB
 d9tcDAVe4elAPoQqKGLDiPZtR9t3RAenQ6qziKC8XUcNjsb8yd6Qp3x6zxPPEToIZhOM1aW2ltI.
 N0YR6GW4kpQ1PBvZcaAYBYhhWccZNhkxrUSlUE0Eg.PAHDirRRTATMVLPruN8YoqtaXyHpiD6rLP
 z92ZhCsiBQdPma2d4_A6BAOCi6Tx50HFcCFRluzkFsf_zqqbCENazgnX5VPCw3uVWMEkZQiebFcQ
 fiFHT8_RRr8_jV_o9H_BM5TU9gysn4vEY5xL3TWA5njIH1IUFPzyd7DcnbNuW_Sh8w9OE_7R_KoE
 19YGX6O6RKPsNci9Lu01Syuchc6R8xoLbEt4DoQvfYVZJ7LZwhRHv2Nt3jZBgl.sCIcJG8ehoPOD
 F_DXg_i3JabMgCCVHw87upbqJqvKki7OpY.PtY5H.FvzA63XYdRW98CJjnMwTESvzRamOqOfQj_A
 X5Wscurmwf0piQ_iPAd7LooygM2oMC9FxB.2Fq8hw4mxeGn4Bk17P0L9dDAV2G3kMmATXxbRcWkc
 SiQ0GbdLWbAzQ4l9KPLPoXiqc5O0U4nMe7SiM_J3fS29UAOGGb.VriMTXEYlimyCVInD1gdADjQC
 fpHznf4NdBDtl2qgQnYywr31y7zSkchBOT5qR2NsseQoxddaJ._VwceGfJEyKT6FSHGsDJ4WlnCp
 WdxEM_2AKCR3uVEKq_6dnS4045MgIE2O0c4YKIVCIdN1XRjG7xP_fTNY1BTbvPsfKhPUIMDBsfh.
 B14lH8ParcprKeEVcNVKInX9wxiquWyt4GFNlp_5.IjDCx6h0cuRHkdazKqQvLgYPc43XbyYHRHc
 z3Qow.80PGUpUHV7P2rtFzZYuuUhW0M.BRpDm9VJRdF_7w0QHiyApU5RT3abQgqdVJEJvVqZzbuj
 fcwC1IqCSTUPpvLU_OosVr2alaHyVisFD999IbVKDBP_u5j5st8SE5kKV8SOrylxVvE22r2vbIOv
 vUR0UZ4T9nrHEH162BC3UfhpR_sqTb11Kmso9ktyELDNzg5bW.b_e3FFd8gAzUlYMhPDg4F3_A9w
 goRgaJYT4uZI2oXhroDBFvciHc.ygqRcXXZNxVLeEW0drHIRAtRZz95v7kzU2gF9t4c6wu4HHe1A
 DFoYpBG6ro_a9u.YRbeWUpXZtIBluudaugwb9rT6aQKTX14IJctjShkuRha4oqiuqcHjMLckDBGj
 RJVImwlG6M8t3wr3YS6A7CpjCcBf1aI47KUwIV8DCiGlWFPJGiAhugmTJCygr.zx2leUFkU2Ucnr
 uYJj1XqwjgxmGjpKNdYPaO3rZXGx0FH1aEaaDMVrv6MiAzBxWqvwsKpUKjBCwPVBWa2obQvoYY.c
 LatFxCDo3yA7tnVx.2mAHkrbAIeWqCq1_lwBELxKPlNdJZW9zeNgKwfbhLFbjTjYvZMeLbYcWaSo
 c.wH6IT5.hDqW.gI3PAM3mXVy3FJZkB_PtgaDTInXuMIfWvt0EXghuxbfsI8iwjwKXdaDLVjYNjt
 _ZuYTW2wqG49miy99IZ_7PJnz6oo2y9KgAgsWsOqfDW5m8046LHxUF4nGUnQFDbASE1hrMHym99x
 AK4SJcy5sgHSY3S3ulWcvTFrXUAuJnWcMbMqE.C5PiTLPZ4fSzyr74oit2us6wj8pAFtTw3PAu2x
 UDOv.jJd8TUAAhqqyKCUq1yQnArsO.8ecNqdF2v9rr_Oiv.BpS4IvseGndBdtDM_cxjFYtAJIXeI
 adg_ODUDu7ZvEfP0g0XtFuev7o2gW3QoFrB.VA3GWtBKWls3Vl4eRLdBfOLkmQCspBRomKw40MhL
 unsaCPwf1JyzzfZhXYlgZf4h_OmfaLClP8UH4nKa0VxwvaAFzzpf4hcgdokX6taaz_wwmhqio02y
 KEFo65XX70QQcykjCY33wnQDOZCuVy93fWXKYKpRoSc_tVFgSuv8ByMtvQ.FbHNLcsggxKPKWt83
 gxZ7r.OIxSKhRAyci.CGh6VK1r4EqV6ONhB2nlhbXFo_PQpjmVzegObASQ4pDahhck3FnNLaPSgL
 1CWv6nUeZzSWXqHrT7yjSOn0NyOH78o96hrrQG2flM4OnJWiFeUWkTuaGchq_9SHgp4kLvivudYu
 tj5PH9tuexI.zEVJnQgH7JkOKZCc_kCoz_dHkxep_dwKZ33Y3MmpaRFwyduJ6_xclbNvtQzoblFE
 r02zijDnW3BGtnikjD63772K5J1aASMzvOq03gsVE
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 6c84f174-961e-4f20-83f0-b87dd729703c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 00:23:07 +0000
Received: by hermes--production-ir2-5dd9bf4598-bjqzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e5995d33ca59d53ffeb9948ddedf5470;
          Mon, 12 Oct 2026 00:12:48 +0000 (UTC)
Message-ID: <41c9a735-0688-4932-b0b2-5c41ecbc6699@yahoo.com>
Date: Mon, 12 Oct 2026 02:12:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 5/9] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
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

The hardware structure of 4K VLAN table entries has changed between
silicon families. Family D's CVLAN entry is two 16-bit words rather
than three: there is no third word extending member/untag past bit 7,
and no priority/meter fields at all. The FID field is restricted to a
narrower 2-bit width. The chip itself supports both IVL and SVL, but
this driver always requests IVL for VLAN 4K entries
(rtl8365mb_vlan_4k_port_set() sets ivl_en = true on both families), so
both the IVL_EN (bit 3) and SVLAN_CHK_IVL_SVL (bit 2) controls are
forced to 1 here, as in the vendor RTL8367D code. Setting
SVLAN_CHK_IVL_SVL to 1 enforces strict lookup engine validation for
the selected IVL mode, preventing potential MAC learning leaks across
distinct VLAN boundaries during mixed frame processing. This matches
existing driver behavior and is not a hardware limitation.
vlan4k->ivl_en is still read back from IVL_EN.

Reusing the three-word family C layout unconditionally means the third
word is read from and written back to the register that holds it on
family C, but does not exist as a distinct table word on family D's
die; whatever data happens to be there gets folded into member/untag
bits [10:8] on read, and re-written on every read-modify-write cycle
in rtl8365mb_vlan_4k_port_set(). Give family D its own two-word
pack/unpack instead.

The two-word layout matches the vendor switch API for this chip
family, which writes only 0x0510/0x0511 for a CVLAN entry.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 173 ++++++++++++++++-------
 1 file changed, 121 insertions(+), 52 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 8d49ffa..206a001 100644
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
@@ -244,36 +290,59 @@ static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
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

