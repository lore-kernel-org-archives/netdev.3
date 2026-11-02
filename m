Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.190.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630462;
	b=5FmP/LmwVrUaMdMRgTXEJwQOcLIUUlpCPEEXcaUGMHnhieEYTmPIUrWL88AKTEDXF890
	 y9JJGfOumawXNHZLpfLds2qmw9umwz/nq1PfRphUWUKYhjUAXgTOTUrAlbpnTicwVrxk4
	 ++Acr92EA3vejmWffP+bLVyJ2gTXAUx8GP/1/wrq0bdZtV+eirgoMggSa+bES7UOt0mPF
	 7tc2wLet+mcFJeytGGGP7CDpcun/uOSsxIDrJXsGJJikeeYIKHMUztKIiG4188NFFeuIl
	 /YYWasHmVwLSJWCI1qoSIv9ak3AT4q6NjEjj1TUNbIUTMR0bGLUzKGZtImVxXhcg4IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630462;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=Du8xU6dABh8hXy0wU5c55NgOX6RcmGqexkWz1A8S7FM=;
	b=AxK10WN0w1TmFFhdn7v9NiJuucRVSObphsCD1d+at5/776UOpaBKgPrGtbp+xEp7lnqf
	 D2IJije26uHv//RXuIlX/OKTDLfL2ACmwDM8D/xYTyd6uJKGQA3q5Z/SMegecIZ65SESn
	 sL4uiQDLGBk6X4l559ohDw5vQxMi/jWJTGsK4nClkoGRfEmnTolap2O8QmDEUaoZL7IoD
	 VJfnyRaMHxkT0TNrNHVmj8Ajh+2LSafqdXungMTmk9XX+rY7clnO8G0S8qa5JfswSMIR/
	 yGJNDucoZ686RDrHJ/HfpsEMkjsUpoM/W8XIPG4Kd/mjqxI20vucHxkV4QhEtwOBZjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ajmdbWaW;
	arc=none smtp.remote-ip=66.163.190.146
Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EE606A5B9
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0EE606A5B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=ajmdbWaW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630461; bh=Du8xU6dABh8hXy0wU5c55NgOX6RcmGqexkWz1A8S7FM=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=ajmdbWaWaQa0BuoI5CrtU55H1YDwJk+SCCocHbdnoN2OPCQJUnN5TCTcPZJLo0Y8fNIjabDYLhkNg5/1UU4zP73A5x3d78S8tKiq5kL9M1j5pVs1ba9HaispOrVn09Mh0kkQGyw9zlKHBuLXbc4qxP8juvrwnPXvBMCQnxBU1ZeEzarZN69Bbg1iUn4uoG+OGnunCTspbzqq+JtCw96SQx9NxzvD1YM8CORB5p4/GR4+IgNNhUo8FLA5e7tHa4OFgNWUfNpDX1gLI5BahdkqMoPsC29IxhhUE37+OXW1JfVbIb9Zu0BWZNMzecGXgwyqINC0yfcCYlVYbU+RyV9MNQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630461; bh=livqoE7if8Ff7z+hCbNp42k7VnHrJ5q/qbZF4I4xIGU=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Y6jLzgHOFfJXa8LntjnAC2Xb6+zwYDbt+1ldx6cg1QKImNn4oztm21o2cNrZYJZOvbD0/84IiJuUx4/0uryME3hVnsgcsKqfveASv/V5/Ox3PUcuzdMS6uRfi18HEByOz/4iQYRNwC165YeqfwJEbS12MBL1GjgWRgKMFsRZgMZac+u9Dv0gnbK+9g8FCIGSoASWmXvpiec5tsSqsvlTfdTNkFZnatO1UFzk60fJgopeJ4D25IJm1kuYhhlEA1c4aaKJ8GP5KZb9ivWTYswBszMZ7iZrRQurlPfeX49dxLigLhTQq2wXrMqql0A8bhTzGTLPLLygecQ9BinJZ2tYUQ==
X-YMail-OSG: 2V49DGkVM1kuNMmXm7CgJYmmczh1NhBGzP.RmkIz.PQ4Px6n5IzBO382P3AG72V
 t4jIvOoFPK.kro1R9kIWo3hk9flBAPYjJHBxz9nQHuQxDQ3qhp37VsKWBWDfGyUlKEbC.ZYhqAjj
 Wf80Ox6c2FXLUe_OLM_3efrjGWoEflFipMJM4vst9RNKAvccImhLA1IKFA8JMeeyPzab8pIATyXF
 7L0BdYX824mRqVOG5QsVuQOCFtaOKClj36ILC4UR2Lr_phbC.D6xZfkrw3KeKtRTcFfKWoxvLhiB
 pUn1KBkz286r3yT7_QzVYetctFHFU.ZG8tJ7aQl1WRv_1fJg.JM.0yKaIyeGqyXS8UqRU52FKEK9
 nMz053w4yCpYjIZdbOgkZTLO4ftA3Yq1_WaY5zs7Y2ZXbs0atVwzMAY.72IKYwX911ZeS2N9UgeZ
 Qw4aAkTPS4jZ_yPsZHJhXDAck9storl7Apg_VstfkCZeuNmgYcZ4fChFZnbmqyFF2nx3pqnCKeDj
 yp_r8dQT0BxqzfVV1x_MfgpwlBD5lpzM2kK8ciZRvTgPuyzvj3.OY7UGWEAQR_l7catzSYbUKL_7
 8vkEFpweNwAEm3WJnI0gDW91w29hIebl.j8683aWd3Z39r3yIwJFfkHcYiWU74KIDl19hEvH7hBG
 Z73KCmQgwu2eKJkTdYBXhymcL8mnsgwefjq1_s_qzqbxRNGkqCqj_g9xEdDxsNiSO5xp31katuom
 iCgCQA8uWkWEvitXL9dCfOkNSCwyjOXfr0Fjxw8b3CrgV1YSCkpxUthYY3.ltYBDsSg0JRwuy_qt
 pwF4P9vrIwavnnofWKxu7k.Z_uUMYykqL9C1NcvKU.rYbiZBgGKw7xV3DgRzqRm7xuyQUpN4mAVB
 UjQyy0ZCkNqzvtZlVG3AUYbzXJ3t4rhoqzl94Nh60Bpm847Z0lwX_UPvIQdW.vnrJrVO.Pd99liC
 VHdkMSzdBB3ckIhkOYOBWiCDfBsbF1FoB1V7eDgiErjFAbQoBSbxi0w70j.qPmqQGWKMso0zVzu6
 n.5.xWFwKrDwFLfkMQDXF9mkQQiUimnyZKM7h_6xhYs2Ht1o6TkTXyWB.9bVDpS2ieQjsI9SGiFS
 QDzeTPLfhmpxpl5r2yE1XvPLGxfFLMcPPA82_2jr6pbTINLS8R2a6j_uC7b_s9AG3NE3LqaKocCl
 TI0ADVDsyM.UHDaztNJn8UnQL.mR8o796roLp_augEL2LJh6s223u50M8Mjlg3wIw0Z3Ni3ZEAZP
 UHglv4P4kUwPDqMxi8jbQ60DSj1P.HSpu8cXimmBCynrN.zsY3qIGYAZ9l2BaixQNJyyT47M6b48
 Cgbbpu2e_5OqXPe9wolIv7yvzNhgudz2bmRa7A0ry95Ok5TID5_Tmv0qWoxyvFXGWGWqMd1vnM4M
 TrYDpWNvuuA0uC9R1MQZomDe.yCFSojhbFdlu0hUYxPzDw2a5uwl5uTbbNEB0T9KeZ0DDCfiIS4u
 LfIGIXVgxomx_TExuCVbryncUU237Lg_KVaVEX_12KY_e0vVNvUufn3q7t6NXCh0zI5smW.ymk9i
 77EiYmyUnaETojZBCXAKQE9dhRq2ADV_x40QaE7LQ2YaIJFmgbW8GNK7fnLsoYXA8EtZORLHaMXM
 gt94sZbzKcpZb148fU28iYtb0lNhaE6B9DNSO5ZBIaGLxjM76TiPtKv00cYUJO3T.AXuCdaA27Yn
 oXI3rN9QgsOJkJplzfTB20vzbqRmx.8P3kbdL8pZebvENhqo5.YJ3Roja7m0ntG6ejJghAwM2ZTz
 XRzS3vcQYVLYX.fnHn_G7bg3zobCIovGiMH9fq6xp96QE701yZZe3dXEJtF56bGTML_JrLJCBv9U
 viCByZXIALIQH.zwmxAdyYnhiZ2A0aq4Jz.gPeJqzChsRhWwdENUsRaeB4MyT8QHSFU7qsdYDshl
 Zy_wFyPvj1G3SJO_FSaXEL39xzTWUf0AEVYoso17DoqzMmxWcqAu2MbqtNIqOjJkPAFCcLz5FL9j
 fZcxoxBbBClxyikMO9CGKfc4FZxFHK1_Pt35fKp2JtNwD2L3oePTQyFWBhum97GhzQ8pG5CgAPA5
 6OaP3OU6YHOWhslaj5ISfLtiTFpc5wA3NFMBRZjrG34ilbNnGJ9ODfYoQhkTsks.ibXgmx38dnMg
 o8qnvYMfmmUd2eVXGp6u85_uv5UEo6BfYMyWra1SpnjnEUhScYeWL3GIpGwp992cEJhoNTY6sI0j
 VjQnst0hyVhquC2tCGzD0LJfHy9OSiR0nKcNe__Cgwg0UNQOccxTiRI6CUDrpxXyeK5nsY_qRS6D
 HPQ28cZYTym0FlYWO1LTjMQ0cjwnLoneCT7ajkWrDGA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9dbb2bc6-a25c-4bf3-b770-9b946c80460e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2026 14:41:01 +0000
Received: by hermes--production-ir2-5dd9bf4598-c2rmk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a3bf5a534ae30d4b3c7bc20def6fe78a;
          Mon, 02 Nov 2026 14:40:55 +0000 (UTC)
Message-ID: <1ccb6acc-0809-4abe-8443-576f6727a6d5@yahoo.com>
Date: Mon, 2 Nov 2026 15:40:53 +0100
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
Subject: [PATCH net-next v7 05/10] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
Content-Language: pl
In-Reply-To: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
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

