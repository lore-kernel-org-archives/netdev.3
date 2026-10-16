Received: from sonic302-20.consmr.mail.ne1.yahoo.com (sonic302-20.consmr.mail.ne1.yahoo.com [66.163.186.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37BE2D2495
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113367; cv=none; b=WUQ2qaY+RAvF4xXEgQdep7T4XmiwMQncoMdNypvH/qNuncR6q3bKlDPcBt60wsXh5PQK+xQDXe2cpa7WPqGndKlWxeeQ/xlRlBJkJcbiJS/0a5WvzACA3iyC7OTaGjZqlTSrPodzwOVp4Mtv/Qrp59l7yg/TCzFRDwnHLQc/A5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113367; c=relaxed/simple;
	bh=42Lf/sw0plHJ8/s6MeN5GFUW70sgRrJto7N0UM/Mx7Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=q7/SuBsXB5UZyQOQP3F0Sjw2Hhvil3H4KAZXLdGRklAm2+5amTZj/OcJld4PE94/a7syzNEPQ3BzNMuZbBZTHZirpfbdvCijF+JS2vzywY37IIEIZUyfXDNjrCgsC1S7/yfWK8Agw/vLjHGwWJV2gylqtgMmtWIFPbPXCP/2ADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=doMzbpwM; arc=none smtp.client-ip=66.163.186.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="doMzbpwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792113359; bh=igLvkAi5VhUNveoP3EpKMyeQPAq5qEjNObJ6SHZe0pQ=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=doMzbpwMHgBDCJAEmTvZSjdeLLMelhP1kqGWdk1aozjmIrYM9wkmA7XEtADQFdW0bC5y7FOkZ8PTR+35ztIa7+0ylk/NHFonWSNWwWlbBxpa3ueda6GRV0wa4vyaPpMIFjZTqXDScgUlYGWcGZutLjJOrVWXzWXZ11HDoHrUgB3qXr9kd/18Hf8M2nkTpD9hES7vXdo1rFJJjytw4UoMvCZ081lViqppjV3T2Cv/m7gGkkh3JRGvcePOdBj+XJVEds0pb79uAsx5mG0/gYXeo/N8OONGqROTXON1+A0MfpnYTdkXRJB0+tT82veL9VymbS16IqvWe0AoquRnncDJpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792113359; bh=NKI4y8xJBPEahWdvrTZG2283S7eowTn0LHnEcKlDWmz=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=tuoKFwvUNgH8i93DGasUjBrFi2qlZFEMKAbp7VbYQFTmmqJ9Aask0Sl87umYbmSKDB1kUIbwa3AnqZtetvkwTuMGSbnQdKlf2r4ys/ks6oL98D4K6zj15ks0dLIOnzS0anQS9S54WC6/GCr3lqfAD44WszV2SRucpm7UyR8YkK5VGJVBi8HtlYfYnJRdP5DNctMtkA71nAzm/lTwDRDvrXm88fVNzt/4gr8ARVZhVRYIVsIlp9ebLEmY90IslQfFdFxd95FimC04gMkQjTEp6e4QjiQVmu94hpYZzGTSAx8vsA42LKZtng7h3KHg0o2KUnu8mplplKLKb9LVOX97Gg==
X-YMail-OSG: fyfUxQ4VM1lLm4sC7wvjBcrbgVlCeQwMHq22vatuF1gr8zNX8dkSFXItcpUUEWK
 Y_57FvWpMgjtdXMiAgZdkmPo_pzJCHOH0mpM8aAuOBUI7C8qTarQouQBja9ECqGRMK9W8CQdrhgS
 lg4zLe00r5R2YXa1zCN8nPH6VmBicfDVVprir1F.LtoMcPqQOMsZhHhJx.4uWn1H9ezhpTnjQoA1
 3su72KDDJ_4TEsHjMbCIzeMWz.pifuIoUfbskIS5HQZA3kMN7_OhixqU5n4gr2IpKYf2Ee2RmCPS
 Y.a704OQz6p4RRResu5FDcrEaYnZLtToDYz5zK55risTMP9d6_Yavg1S06eOz7etC0.rEDYRJLpm
 l_DEJnnerjEHHq6aqZv_W8LgrDqyEb69lSLb72ZDf4WNLVSj1olKs6ubyvoxKQWYJRl9zlE6G1ij
 NMVQ7YWbhWJuvTX88KMONB_Yv5eo3w1ExrqN.SSl43DNCYEq7cZZ7q0SpKba1HyGceeIIhcqKsNc
 epUxFSUHhP9yHq2C02ETkmEccbgjyNl_77gQD7B3nnc1VAgX03bJHm2.kCPtnL0_fIMH7Jk9U6TW
 nVCOjqqXXLp9J4IxqDLHlSWHTfVmDsyav6aP.Ahr.O._WDZDN8wWKr9gU.xAdgGqPedhX8FLE3d7
 lb8zDt9oSydWUJihnnCZpnuQxyxcXXEkD9pYacUmcs5jEq4MWaWDgxmGj0elosPuWB7Y6Mcsy5eU
 8bYNfcJC2Ql220jF5miMM67i_csKkwOpO7GwHNiL_FbWEDOVsby2d0BRd05KCNd9MHoHV9mJ5wl7
 D7rrNciGeAGomOxol3KmOR6J4rN0JUPRDlFKaMlJrPG.LroivYBPsdZFeWz6HV0a5po3lYxSgjhS
 OG1cmgJUesDwRYsTbTgD0rkYtvpxQz_X89zwTykcJppj5GKNkjmZTVx6JGF53m9QUQQIAtZNG9Cg
 lc_3zWeMHEF3RNr5gHjs.PX2wDWvLBd545TlzfN5UMV2TTpKkuMmrE7x66JlTB159C430voWN0bT
 r0pOQw00uUdFTSdp9HeraMTetFjNb9eG_Dnu0LC.G6kNzRzXxgGeoAMjxPUonLt219qZaNuBU4Bu
 sDI9FHtKp85nO5nEwsu3T9BysOQ1bl4T4ab1SZ8GOEXnYAjhIgk09SxaRWUmDUaDK2zKtdsxtTtj
 DYgKMgtGJSCg1AE4fdjAxx.K8LSsk_9om78K3swJUo1HMChbAfMWlZKRw5coWwgTgagw3difBbqz
 Gx.atZkGg9vQks8vgTGQU_dsPBFz7PNZ1VD4oIfleWC7TITpL08jqmEDJJQlxe3DEnwt1nq33e9x
 yUr5U1QLz.9cTOOBcPAG0Jitue9IwndQ7Xu34NpGwSa45y3MTKZPrtduZekY8Q1q885XYxXpm9WE
 sHMrtnIgGzBgJrXrNsKs9UrDkjj.f8lWNjv.q_3aynX_TrPZdJRJ_wm_1N0xo34lRAYV2pQ_WTxn
 oUCE1MDpjTsberZHeQlfWU9ASagKblRR6zSZxNlzJlfZBScz78rZHOxTbDIi8gMPaIImHMiTS_Wl
 KShwlB0.wqAj1ozZBu1j3u2hd8Uxu5RYPHJGJgC9w8iY00M7m1S9YIa_iDOEsfQ1R.wHjeMpeJBV
 jqzU3VbMHD1xurSRT5qJnVnPI_rXfxSXtw1pCeWbyXb2cGcnhCNvTadCNAjMuYdZm9QLRASFDlLY
 fgHoP2vcOunfE1tauI32qFEiDu3p66aHDxYgVel8w6wHDO78W6nS_f_.bxYP3O1WEwjJ.UK9j6.P
 PhKgkcFjHAXCam7F9SHtaogrIdRP9nUVolTP1ncGyO5K.k1x4DVf1iXuLEoFSz3kKweVK6zld9UJ
 TTCQ2ObZAIRw1FYL2SDU2SoroDnHHk6wUHbrRoJQEatl5GXCXa_T0H1tXZrHq_57flMwSkprX_6j
 Wnx6ADQ2kRQk7ANUZxPRijsVXMnjVBSnkEGKZ_mcDXnQ_3s7vKrT5gtKJAsWEAxwk.BXJaCFDjR4
 ZkUSKV3LedfzXSn0Vce2nKKbDFrzkej3k9bbWVBJTFvd5N8.XLiLGWD84Q8LM64iNQWYQzRoxw2.
 lDLcOI8tIijuNCb8NeoR5mhPvi0ev2MsHNSMIu2_vGMZtV9B_NlrUJ_lT9Dr7qBH07mdWJyzaM1O
 LQSLE.rffQdb2BW6wlyJwoUeK15XRo1uLGwrCvSx_X3VAHzUwo8INcbdHwEFV6FFJI6gn5pMaIYl
 cxZg2dR2Pv05i6NpRrpXcSpnfdKppUnHdYChHhguSYJiHIFy.kWNAjxQWRpCNtRyfp_kk0gVDd8O
 xI5IA2HBYplF5g6nOGC2dvQ5GldbEZIO5tk8-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 533d70ca-b31c-4b06-9e0c-ab6da0e374a6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2026 01:15:59 +0000
Received: by hermes--production-ir2-5dd9bf4598-bgsl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fb9ec7770ed6915d583301cf3bd2249c;
          Fri, 16 Oct 2026 01:05:42 +0000 (UTC)
Message-ID: <6c9542eb-1411-4c1e-b678-f5ade2f5628d@yahoo.com>
Date: Fri, 16 Oct 2026 03:05:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v6 5/9] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
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

The hardware structure of 4K VLAN table entries has changed between
silicon families. Family D's CVLAN entry is two 16-bit words rather
than three: there is no third word extending member/untag past bit 7,
and no priority/meter fields at all. The FID field is restricted to a
narrower 2-bit width. The chip itself supports both IVL and SVL.
IVL_EN (bit 3) follows vlan4k->ivl_en, as on family C; the only caller,
rtl8365mb_vlan_4k_port_set(), always requests IVL. SVLAN_CHK_IVL_SVL
(bit 2) is left at 0, as in the vendor RTL8367D CVLAN API, which sets
it only from the SVLAN member API; this driver has no SVLAN support.
vlan4k->ivl_en is read back from IVL_EN.

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
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 161 ++++++++++++++++-------
 1 file changed, 111 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 8d49ffa..36f0d2a 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -48,12 +48,16 @@
 
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
@@ -65,6 +69,9 @@
 #define RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK		GENMASK(13, 9)
 #define   RTL8365MB_CVLAN_METERIDX_LO_MASK		GENMASK(4, 0)
 #define RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK		GENMASK(14, 14)
+/* Family D CVLAN entry, word 1 (family D has no word 2) */
+#define RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK		GENMASK(3, 3)
+#define RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK		GENMASK(1, 0)
 /* extends RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK */
 #define RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK		GENMASK(2, 0)
 #define   RTL8365MB_CVLAN_MBR_HI_MASK			GENMASK(10, 8)
@@ -185,13 +192,16 @@ struct rtl8365mb_vlanmc {
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
 
@@ -199,33 +209,61 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
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
@@ -233,6 +271,9 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
 				   const struct rtl8365mb_vlan4k *vlan4k)
 {
+	bool is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
+	size_t entry_size = is_d ? RTL8365MB_D_CVLAN_ENTRY_SIZE :
+				   RTL8365MB_CVLAN_ENTRY_SIZE;
 	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE] = { 0 };
 	u16 vid;
 	int val;
@@ -244,36 +285,56 @@ static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
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
+		/* IVL_EN follows the caller, as on family C. The vendor CVLAN
+		 * API leaves SVLAN_CHK_IVL_SVL at 0, and this driver has no
+		 * SVLAN support.
+		 */
+		data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK,
+				      vlan4k->ivl_en);
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

