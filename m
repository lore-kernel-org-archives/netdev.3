Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.189.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748728;
	b=AteTDKqTKtdSitOhylAy8ImQcdQXKN6fhDdiJfuDBSWxP1VhH5oOSmGjlWo3YP+QEzoJ
	 xOAUWN+v5LwUkoPV8i5HCvOvHYFODjUBBIfgKwIFzn6ENRo/+rLRxRnm7tuiC4o2uZifc
	 +rQvhTOALRgYj/kesABWW5sbiAvtX+wyBzL48o7LKrqN0DDytGO1PIBRDcdRQwKTPSY8s
	 Cjlp+h/+8CIke2CAHrd+8pR0qOib51bful8uk0R4VjYTy4FWBaJ6+ptRjpRKE4toGpDVA
	 cmOgQyDDTFaT7ETp4oF/1g82nBermCosYL/IhIGZiGm2nkhiyQ64Tp+35It1zNaS5WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748728;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=a50grKPegPoLNI6Eu3x8wvmKnYCgrsG0nwH0ORIKAtU=;
	b=BR51+/Tm2AfUDx5s6RduG2K0ZtwJggnfhssI0b3BZBG5TaJCfQBnBcG/zzb/gORM28QR
	 LkcdCBXOy3kjxMj9sGzqaqsQHFuOEM1DjoJ9o2TVq+eMRnvhyFfYv53w8ydCUNbDg3TFC
	 WwLejhu6DC+WChGkoUCxIiV1xR/H9eAqYF2DwYSS9ABVSUgOznFmUV15MiGNQ7Q8NikQP
	 9W3+ICqEMNEArOzahMkvmqc2hzt4VI0f7v1XcBYN6dQuyP066BZUE4b42Xw5pCEpFYt6l
	 poN8DQTEmOJUbUQxpu4LBZ9REkaw8xc1KbekIOz7XPKkb30845Oa8c3plt4gP4jDVZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Wxh3VYx2;
	arc=none smtp.remote-ip=66.163.189.147
Received: from sonic314-21.consmr.mail.ne1.yahoo.com (sonic314-21.consmr.mail.ne1.yahoo.com [66.163.189.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90EE606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B90EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Wxh3VYx2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748708; bh=a50grKPegPoLNI6Eu3x8wvmKnYCgrsG0nwH0ORIKAtU=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=Wxh3VYx23S6EcxPXR1i4at088v72P7RkPnf+8lSqdFzQFQ4J20F2IX6Ju+9XIWvsLszRKvQw1IG3fGPvMdn9onypR5HuIrxfjlS63uQ/owysf4mFlfoHhElAkBRaxiRiTBcaAu5igxRADQfsiM8tKX3nT0o0BaThbE6vYUyeKhvCiZIMd9XHH3yAzbUwtwU6ow0vrfbcFGgHgDkhuiVrki1ZjGdInmQGazej9J8BywNBY02/W43miqsSZq2OsAHe0PQQfee4vVlhDi+B5V/St0VgcURHPl9Lf4NCUYch4HIPjIufYUxXfSjXFaC4PhxubkKU0YtTKG4HowVQxo/4xg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748708; bh=0h8skmp9BHOHviCS+YY5BsU1U9Uwssny+T9d+F4+AAd=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=X4tZmOYr7MR/A4iSogisuku2UDBBSsuEM7CtqLl5pV4yOFIRdsbtWKXWjZsU9HUKFl80X0Akdqumsy+0oKCLq0BigWHbfRZOybTJXmDg7AyUDIhuO/z4sGZJKnR32huYJb7BVez+MoHqHnIIMlBRMydYOwzvMe35xeoT6Dp/fx8U/TUrL+zuMO5Kfn9aWz+9pyOKk7XrNK2iQB/u5nybqWnPn5CtIjfqMflVvislTGwt8/vG/Vm7S6uG++Vh7exfOjnfe9GoO7EgIWC3Ef3fLZOZ86bzXunAuFLepXz+yha3KraJxcfjtcieG3NygQeiu+rC+NVdLePb+SkfS0W+7g==
X-YMail-OSG: iOejgSUVM1kcWkIcChUDitUq2cneqM31AUENN7HVYBR6eDLhXGpwGQYuGBglPS8
 P8jt4jmVwGKaQWnj7_uKdMY8F0P3OlFQOQ5GCrM4zO.NZtQ4PWewRyIYzouQmfvZEB7MVbIppq7m
 ypPr982N4FUx2lEV4JJgsAAQAz2Gw74ihAOebYyFFYaq6_ZCKfqh0jDzcYPfhF5wwWHSK56z.Ec0
 K6ZDLR08C1DRQ4GW3s361q3b7wGMmK4ihVQzq2oY5p.qv78gPjI4RSAFeb4Y6MIAAbSz99XFbPKs
 7.7mzYcLUheoAfpPopo8d8QNuqs7fj2PqsIouydIXtSnQG3fNgfHkNa2ZgLAp5jFk0xG1yJn5WxX
 2cKgo91JgnIvmAb0JMSb1RLOOeQ1MqaKR8K.pJUhvoKlCq8GNXSKYpWcboAzSYrOJkcGO2SROmPc
 VkBEqSX0T3NI0mbVzWXwhVsvHxXV3eQkX7PvrHFyCj284yLS_lUYskUkTtWzF01ybDjPN9AV2HaX
 gH8p_q2KStFYEjRw7rkVujg0EK3Is4NN3SBXJWbtCQZQPMKo8SvAQsMW53Mh7B.bZtqsSs9HFfq.
 aaAJb0jeTe7aIVzBg0_5grvWE4MEdN5Z5a0JFwTPqemyuqiJwtecdDMBWNv.zyQCuUEG6MiI7ADp
 mfirWp1XFGT7HGJ61lsuvmBDDbWwT4n16Zm3x2VH_DGTa0pY85jY8B2VS77e7DLR6jegaYbk0tU.
 QSDICLGaETY_d8UN2SWSrDevq2a6DOdBgwTbmyQ_wski0Dns4WVX5_BjHmuygH4ndljNfTA3Ml2i
 7a6wuaLua8PG8LSDMQh0WqXC2_rR7pozkrFonZVa3PP5opUkiunShzCZYl0Yx2nuJkv1axtB6jq_
 pgvRmKNroLdf5UVdNNIb6g.jIEg1iVNAZiB8_fg_Qu5SmSMj.jgrt9PzF4QUxLeh.41_OUXBesm.
 dHqC28LcaJ.exTUQGSzIg.KR3q0PEXtzkk0B.T0nrnTZnuMlLdY2UINgX2EH7Bl5OIrK6ZQNLIdk
 Iwe3TPWeMsY1h88qUvxd3SfBEwRFPoEJZEd8NHtg7GhcoCWrnIZp3EnCYE5yGMAMuFs8npig7j13
 O7O7cXTCdWN4AbZC.AtCcJAQ2UZR0IIvqPuT8ETDyZ4y2Vy.2wNvf1DQOUuPlKpOtAcqUpo0hMsE
 C6lCZL6YdwYt6R5Q0.GaF5t.W6pfsZZubRrVoIYph7U9TtJ.Vxj2untBnSRGzDC_OnbCXXNdqFUi
 wiCR90gBVTNwpkcOW2XSutkHkXNdJQZ5ugbCv7.QHUYVumIOwu9tSqIUzgThY.vvt.Idl9kNmXz1
 jqvZWKzKobiG9cr83UUCWYOGUWB5qrsB8VcT2z4qk54a_aU2NLk7eKJXjjr8m6hNsxogTbfxCoYc
 C5.j74EaQYFgpvUa0reJxMWb1pGaUGv7EHXwwUgM1hxEeGO8pWmoKzY2D6HHdDJ4q0yXEMK6Xzio
 VkPru3.MvHDYA4V4Jwnqo3qLGw6acC3JY5GYl3NUT.DwHw59AuBn_21y7btCckVINdCLokU.aVem
 7F_KrXRGwsHkJxAnr8cDUckaVtj7sMYYc_VqTmFCpkX.ucYtKHfjlNapmiy_6kv.nn6FT0Xt3VVb
 2vLwF8BAZ9aELeMkSIZCeb3U.aNlnpBMiuSjYFiqmh.InYKPvULV609IdqwIYsVS0UoE_2LVUs9I
 GZCLUkMG5ASCtthe.uenFsdj2pdN6I6vrjNTTKXGzgJ1VVS0s1DZAFSN8GftIqmpBD5V3XFrQGrn
 d0nL6QQrHXFZiDvqQzG1Fbl2jUo3PMqynzE.jrQ0_Wka5_6LS.dZbLJZBAay1LWN5hsdp7ag1bYQ
 XEV7Ix0W1tZvJNJ__IdaJbMTkBnjFcAtOIVZUFyM61B00khZADOU0_2ePnD.els6hmpzmOjJvpRD
 18AvKoK55CrpDcKZnlldS4S9IylT03nftvHMFUojZsk.WfRsju.RCXl_9bZIkCy9HVIkzzyyhoOM
 6VtjhdT4UUoPv8Jx8PcE4hBRGMykJHbyhU2oFrAEvyI3W09BpbjcZLBicYkeLSo4_Ofh9dsnProa
 uTCCm5x90ZBndoBP5JdlIPILpqdY652u9D9reJsspDhSYSTTAzKxdKD64kBmxdd0nPosNK8JJ6Yn
 bOwYbAy8w4pJJ88.xVgoZf2EwFUM.xNgpT2qWG0PjWX9l1DTeYt40MnbEpYpo0NwdgS4YZdHkAji
 6QrSATNeBi2FxAhRjlz4JBjRx0B0e9Fu_H1UTdiJvL_C4zs50zzQf2HD6fr0Lr0oc2fVlR3iIyql
 PQ688vwR_GcPxxPWM.s_jrUlahXYQbIBYVgPMhUpm
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e2748799-7453-4344-9997-cf19ac4793a7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:31:48 +0000
Received: by hermes--production-ir2-5dd9bf4598-hl2mf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 42f7c5e70bac18d66cf133edf60abf9b;
          Tue, 03 Nov 2026 23:31:43 +0000 (UTC)
Message-ID: <a520d328-ddb5-4616-8d9f-9dd8c7164c32@yahoo.com>
Date: Wed, 4 Nov 2026 00:31:40 +0100
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
Subject: [PATCH net-next v8 05/11] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
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
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 161 ++++++++++++++++-------
 1 file changed, 111 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 8d49ffa..202c181 100644
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
+	bool is_d = rtl8365mb_is_d(priv);
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
+	bool is_d = rtl8365mb_is_d(priv);
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

