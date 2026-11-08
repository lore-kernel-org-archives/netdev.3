Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.186.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125374;
	b=BcCdtWNw3FqXHt6U6EBGEOW7DbFmUXw1knJsFsG+LNWAahDkwU3TSKZYdKPVPa4GAQg0
	 j+A1UZwKG5qijt9Z9hnu2jXmDmDfYZ5vGb/UgbJflEoNxjpIDLY60F3EDO57/X2wJUf0G
	 MnbfGAZCGLww3irGeSX09YRGi8/5QdQPG369z5oKHY2aZZPTN49W3K8htIoduDVIMa6be
	 7DFm22Jb5wNHI1Ow7/PNKl5fu2j9Bmbz2CgjrSgw98QLdGDI4HOFdSByJy9Khgap1KdhO
	 O2dqMqF81+fYOU9FAhhY0j6azh2sTzTNDXqCdlX9zWASGfUCg8HAhib8bs0HeabV39g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125374;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=uYofD6wM48UKHuiz04a1C5lvqFH7GI0kbZvASdInbUs=;
	b=hHNJFg9cshfBcv8+yE9FsLV/NVAvL7uaD/AnGrlQXILa/h7mykS9NOWCbb2F11D1lKjk
	 ZRaC8HxEygLM1NrD4laBdI6HSpNl4RALMUHp6IbfWwAsiiZxcbvQI0FlrtDQ32PJNikQq
	 I8QgpaSDME2c1JIQAUJzD6EZiNc1d8akqVUTdTQK0uGSDhYtgZbfERFVWy+FoMs5GcOEj
	 qpwx1sT8JLtadA81OoZGgYCFuQwy0uxOpsolkur/2UaRgaqpHGGFTcdKwa0fnzuzvdEiv
	 Z8VtDzT7TmHDqoJrWClOzOHRh0xwsYuIw653I3NOKb78/I2hP5cOLN8n0ffXBjenQKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=loU4G5rb;
	arc=none smtp.remote-ip=66.163.186.204
Received: from sonic310-23.consmr.mail.ne1.yahoo.com (sonic310-23.consmr.mail.ne1.yahoo.com [66.163.186.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0F606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=loU4G5rb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125372; bh=uYofD6wM48UKHuiz04a1C5lvqFH7GI0kbZvASdInbUs=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=loU4G5rbaFeLx8zsZnSmV7JINwbHON932Pn3T7owabHqiAxQhmj6Shcc6FNZRu2Y5zrPndHvNf20KPQ5bcP8uRbt/A03HaJmxMvqiayXNaSu8ap0QcUb0ru+fbA0LEkoOLUB0uUfV6HBI/1ZO8E6KQvlflCG8sMxa8hrO+bcml6hN386SqWoLL9z1lhTqtc/RAZEFTZ29/cM23hxnFdxlDpjbEH6JeRCz5Q3IzI6PBURODJBn9vz8r+dFHFiS7JM53ltAOiGjYsAF9QAD/w6Usbqqm9scjGh675ftmqPsxEj0wfqK6hyb+I3WaUeWZ+drIWHnZBekIWCB9xhW5Oj0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125372; bh=j+mzfToWyo9qwVana+NailaQCG54KjZdprf0vfgqUA7=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=P8QXcOt7+0rvg9i6osZrBf5zsLi3uIGl89iMSbJ0VdXwXsIynM7DjrteI+lXN47WBIPY4tn2vcxf5ArW8nC+e42FSkWpQHu/suGwMCkaunQoThLICaC3ZLzJjSWlAtjUf+AxEMviESiyjMzV0z7g8EUyReUYvHX5ZiZ1lNf9OZFccoIbopMaoSallvpKeSqJOwUwznuj/Pp/Is8FVf9Xj+gyLl/XhZywqVmQd3pfTK0SSZ2iVqrVOkclrtZLp+M5mfuBRzLVzU+08U2G9szk0UW2ejMDVu69PucwXMnHZEFHHUl2X0+VdOTqtFo90vuffp3SFbkj3LHA6wHynzvFxA==
X-YMail-OSG: cTZgN5gVM1lHo_Ru_WtVE9ozebBIUibgO_.M4Ij4KODAPe43Oxdp2j5aHMwJTKp
 GAH06gYRocNg8gXFKNgl_a7dBf8faCg.h_rEcoUrpqfu3NYmXcXAP0YiFzdjRLuSLekxI39tYdjE
 ETv5gHeBwlmwnbsuC0NKsPKeUZBnCGVaHNadE7GLI2fwvUJ8cawH.vC1At9NFIXoa1Ts9xVFel_g
 BJirOwOJsuunu4Kl3ynK_NvqB18iv0tuLNMhdhgDuKLExQyYsNX_i61rrYZPMSyM02Wh6ORJbjkC
 lxC5QtDGsdxVQwLPHRB.JDoGRzyY4mnGJ2b.iXZAo_eV8hFqg4_skDp3fu92xOde4Bde0rD082Mo
 _sUshu5LeycqzPU8oEcAKssIRmEnhSOouOSzPGRqzTFQX_iAE96gEGFpHC8jcWAaFq6pvbKka3wi
 mbWAokTJUGeyGd1MFq_10gsRkG0Spil.gCMlcus_Mg5amoJzCPZAX03DFWboH_1.TunxbVGfNomf
 9VsllLVksMUO4BoudUYrIDMQ1P7JjNX3tEDlF8z0UmYMObG4zUCT7U4D4e7oItW1UJYmUlfHD.KD
 mEBlKNKJKVVuUQOJ1xzFZHYagI9mQIN1uDcU_ImXJJwNkgQEBeosm18PLbIraAt2cx2HCSronxm4
 GkVX6eDePD4sXzcV9M1OQxReX0sK7m0XcGNExdrxNLu82ETqjXZs_LKyVoMfOMYhUHYrXLKY.SOI
 eSSoKnLJSR09TUgarccp_p0UYDLn5EymzzZ4_J.qLBl21haGHC4sx6gbbjpF93HfM7rQzNbYRgzx
 zPeI1__4Ozrc94YH9qri0vEf5jj2KgM.6XvMEpW9HLjT83cIH4G8p5sflQMAG34tCgR00P0txSnp
 64sXpLC5jnc42N2ujTxb0R_4VDPB2UJ0W4Q2jZuL4GGDEBYAycH6SsNxCzrjuXV.SGsaA6U59k_8
 dadAwPiqKOhfnimFIbJaSGN5PeN4hFMDz8mbeDF977aI6wxC_ca_q8vcy0iLhOl7FSbetJuGvNCa
 x5srepDnL697PLWJCa2x1a6uVm1PjNAvAKzmJQfV6ALtYjxjovLbzCI1HCjAV_QhoRhfGCIRgzS6
 zObb25r0K03ySaOAhlMoVg2oHFzgS8mA2WDlZMRT2rWy_jENZ2_QBY5jfan7zYTmMMhyjASPy.4y
 vvom2uAvMq6tm085ytsvNT2tNJBYhhGYy5Aq7YxJQH1k5VKQjbnqvoX9sl.Xfkzsvm.P5U7HARFK
 zdTsraB6CMYlpz12fyoTngYAxv38vSBAFyONpPM3c6II54OsVkL8X28ugqeKmSK0xC991YG7uKFZ
 K80BDC3xl5au3W54ugGB4glYMB5rKT7kSRB4A44LppzpXsTKY3kVaWat4VhwO5pEugc7te1AW.23
 51sj8pxQpm.1dpA9WIiFMS_tTxicxwJt2ususw2mivQxtITDt0OOAvzhSBDaVigeVCLu8nKoRMoA
 RrJikQxHRT_Bo5GZitBZqBD1sEmXoKogchtc19M7aL5m2QppVSGi56nNaaf_UeglE1YAO.9jp26I
 gi1JYNVCeP21Q5fmOJqGmdozAduoAHcsc9X0pgIxiNDvjfU0dk1T5YM1T6fQKoVafH.fvXAVgmKK
 tw2H.dKxIUBqAMQ2s2iUFXQxecJgjGvVnGNBEGt2z5rgGV_v46jzJo2DK.cEjICMQ7oJYgEuGiej
 IieloK38ORFkBsJeXLGRg3cSncLWUTYv.5CJeXp0Q1xEjbxOAwLONX8Lj.YhxOF1VdLkCgYEUgOo
 F..QFYD2A8c7nQtDMbMAc5yUD4qN_wpx3O5X2K0CHBKpkOcItHqXZ4JoQ6BwVdyQbwOM9z0vJDyM
 Xt3jT8pUoMpBHUYkkWZ1TA1DJZcTTeaT6IG27UkV8dByp57I644IFnhb9L6rya.IQ64oQ1FqYbHb
 5cBCTcxgtjqJWNaXGfK4c38AnOkUoK5OciSdN1VV0JHUK8T35O3_P2iVZ.OXPDrou0j0ts9HqvQY
 Aacpus2r7bHEuyy3u3ITm0V_M9BP_Wf0ry36aSR3qllit68Rdpt5SJQkYB4Hxr5X8cQHpp20E7SQ
 8kFaxKqwRcLXwqzj6bAgX5D.jXFxeEg1rTCl2o3wqK5iSY97o3mjp3n66Fujba.65CyAJvwZN3iC
 qa1J_JMvt1PrQG1DE9RtwMRonw2nGBzPaNRbFIcDdma8.NSaodcBO5Fbmd9c6d67Wtcm1SkxlE29
 P4IMWac7Iva6BBJxX3iz_c_HUlKfHNcYB4ObVaTQBfQTM9VUHuu6_JGC410.aXcOpwxjJFIbak2x
 5KN2c6Jc.GsC1oogsaqEFa8HMlFwegqfJAD8D
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 3a5906e6-8226-4d33-a25b-bf64dab7017a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:09:32 +0000
Received: by hermes--production-ir2-5dd9bf4598-9c455 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 004b8aa458eb80ed2dab8744d18d0b4f;
          Sun, 08 Nov 2026 08:09:27 +0000 (UTC)
Message-ID: <044a0242-18bb-4dba-8611-6b2f05f8f1e7@yahoo.com>
Date: Sun, 8 Nov 2026 09:09:23 +0100
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
Subject: [PATCH net-next v9 05/11] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
References: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
Content-Language: pl
In-Reply-To: <9b73858d-fc09-4988-8bab-fd7b88db9412@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 159 ++++++++++++++++-------
 1 file changed, 109 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 8d49ffa..351ac4c 100644
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
 
@@ -199,33 +209,59 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
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
+		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK,
+				data[2]);
+		vlan4k->untag |= FIELD_PREP(RTL8365MB_CVLAN_UNTAG_HI_MASK, val);
+
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
@@ -233,6 +269,9 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
 				   const struct rtl8365mb_vlan4k *vlan4k)
 {
+	bool is_d = rtl8365mb_is_d(priv);
+	size_t entry_size = is_d ? RTL8365MB_D_CVLAN_ENTRY_SIZE :
+				   RTL8365MB_CVLAN_ENTRY_SIZE;
 	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE] = { 0 };
 	u16 vid;
 	int val;
@@ -244,36 +283,56 @@ static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
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

