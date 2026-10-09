Received: from sonic316-22.consmr.mail.ne1.yahoo.com (sonic316-22.consmr.mail.ne1.yahoo.com [66.163.187.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABB3A1683
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522516; cv=none; b=G0kUfrHYGSqLGksZyZMx6idhrnfdSMceWygRvrjPi44o78E+UWABdwdGe7F5fzFsWwgQr47KCsLL5TlbASWK0rjlVAdIjpu1vIQJFvWZoeJRIvzQH3ReokMVI8c4rnJ6h9MoGkcVjwwyohzhkI8M76+V+NScTvi+O0+iw1h9fc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522516; c=relaxed/simple;
	bh=7AVDf+cd+H9nJHUXiCYHhK6qvhIv/dFxa6OyCLYYsYM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Cwx+luduLa1XS7B9X9G95ILvuWc/QFt7gX0aTci4gQsEUiDH36uhMJxt5jbeXQ3bEyoH3VGCYa9uaFlgNOqFhCChNLLRUT5n0Wp/ZozySHR/xvhBB9VZ7NOesZrqEN4Gdi2c10jQ+xce3vk7ClAQZFDX3je3mrmwzngs79VefXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GYR0YXKc; arc=none smtp.client-ip=66.163.187.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GYR0YXKc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522513; bh=/CGFxfspScNEru1DCcSEEYzxs6UMvCMmdT1lQpVZ0mE=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=GYR0YXKcLtHMuxu8h66rzTs9+cuI3h7xDjfz4XPagucslx4MmLNyfJ3bmcuNJ7vEbtL9MMqT+fHkniKIDZUIb8Pb1xFm/vgxq02HUo89tr5xat5wAnJHtIr9ZBEyXsnudKA6u6DOzmrQqBktKjThROa8PSD+ILNy4sqg2vOMOaKNBq9H1tpauXJQvr1AcHpR6GFvqrUkDvx3Wp3J1J14pu4MXoEeITbzm8YupAGHF3adgidyUpjK9vR4w5SSaO5szerpBWNTLak7TKKvilBh4w5BIvzA9A81KuQWAvHjooGvrdGaRpBA+HZ6x3huldpJWDfNTACuALBTls0uSY5rvg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522513; bh=z6G47wkCWS795Mj49OgHgacrydwK5J7Xh4+bQKcUQxH=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=U6FJW/FPV90FjeemBYgYLal+vyQek+NV16t29XpI1gQFemmq+/sthjfUxOECSRvx91iiNEZonueyOdfNyyLM66F1JVXOrGOmVhNe5kC6Xy/HrQBEI+SZ2TxiWv7AlhhRFjYSNWF24GnwsB3Hj+4mTBc6cPhungrkTS9IeKlVX9RMIdG87fuVHv1W9tE7wrxi05n1fYcThv43gruKg13tYlo3ab9wyG7Tf0GY15F0Tcta5QYEwy1oManWbeXPbO4mVLFrfJQRPIADbl0bykFy7pqASnsNJcn4K6EBm5P8CRLoRhRrhC7oCtlilTI9BO2zbuAhIW0JYbs3fA8gB6tY9g==
X-YMail-OSG: i5MUdZIVM1njHS9MMfg4rLJVlp5xpDXqyOXCebAmihnaryBr_D5rveov7Leshp_
 vTsHtAPbg_P6dtPbZFeZpfAC_gqqJeTxciL28ijaeJyMqjGmRW00ffHpY8oZAJKOgOWdolIcNq_L
 1MXYaaiLEVo3wWlocp4mGHGIYzdVJqwOpT80sBbpYJEeZ9M0k30ylCJJ7QMXCFAAxbvkF4ickWXL
 7SRMA9823DXeGvfn4jl59PF9o2fp9_4DALNC5CmPFViRtIaAf6yhIR_7ls1Cmie_pKasnJRERZc9
 D2lMeagKGrhBm8Q1mqW0oOENxmrcxnkJE8zRWnncCACo7TlxlnaJJISNUGd5B3D4k6_n77HRFhAE
 GnFQque3._0LqzUHrNnEw59xMNt48HM1il1hRjzE3pi9Exa2RMGWOYzh9e2oK9SEFeSO99HcBCNz
 DLsqDsy5AQICnemR1S223A2eCCiiI540hxGe7g1IOR_NUsUxup79YnBUvB0Nb8l2Mr5K8PQ0UCsZ
 qdp4DFRGRnFbqbaxQLkoJ_d62wceWUgjQ6m6VbsLugmmEd0rCZYQv0Rb6GrOx.mFfBBKYoM.6Mw4
 evVyqUQFTN5VXR4DKeEUy5KfA_7jdM151QVdWT485KIhcNgGY2pYWgzfLDB_s_65nvvPJlvLA..L
 JLzLYLVAUqb_mWi8e8Gps5rha5wHQg74nTY09if_IV6zqvDc9dYz8_B9bkbGkogUE6d0XIEI6gcV
 ZnGpv4CR9y9xjwwFWgsZeQn1IpCc5oxwjaZMZJtedwLKu6QSGkcF9pY2moM3w7U.d28reU2Rl1N9
 N07SYHl5BmyZ6L3hs.H.CAkHJZyjrg4LnNa2ngykumWdhsJADwczRsJkjIyTtYhGLrZ91px1u8tU
 ZvQUb6CImWFJIeXwTGippgyiXbXdnTPYTgjaiySDBdfbM2piUGEM0AXki3D92SWBcLsmOy3uA001
 w35oA6USixKljzET6AmTNs2la7vPlsbaMsiOpITGXkDN7Skc2dAy75zPbN9LdfpTaTrb1BWsWfPa
 4.J.KtD1mhQoz78GSZVXdAovVrJxCiwlWIT_PjoAj2ZS_9djXagOMM55DnRPccZqPUSFbxTXnEzW
 b7V5.z23h6NHrD.RlEzpGrxcPLsSLZ90qwJBVVkIYuAifBITAf74DKjUNaWYvc4tVPlGJ30ZxMvH
 WHUYqtkjgHErXRLoMtDurz3idVDRJzBqg0phfhYQvE58pQOuI_QkKFzEagiHLb5_GYZMfCIZMbxb
 VgglkygZNApaWTiI161V1Z3vc.cI40yBgzj.aeaiBB1ITxhwaFkCxewVZ5lhlxLgJwYKgoFUBg6l
 YmBcjmkZb56w7i.xpvQW9rQqmEbRg2h5CGS93Z.a3JzZrznhxK0d5E4hqjFDtMQ1ki7ZBZcPaDBa
 hvjteu6LPmv4RPG7M0POW7odLSy9o_hwFWid_fjUEmM1NObGEWTn5Lww2yArcjFQyEHjtND3m2YD
 vV5eN9rW3nnAhrVmz6GPwkTXdrVCytO6Ns45kFGLUmQWmlm9hbFcq55ogMqZbJTOwkVWDyUsUbpH
 Vl3GijwB4HCHup3r7t5npAOkj9imhv.K4T8WUbGYLGPw_cqU.APUH49gIZs9onon7Sr_VcIL36Nu
 5bKd3kyOps41pbSRX2PWBW0Y15DJds2PMcgN6h_slCXxsOyXVhTbOmfG1oTYE8T0g4NhRNe8WUUq
 9ug56zqYUtuoZNe8rXiZpS56INpu9KdtTMD4yo7qHhLYUgKYcQayiANyJuti.MJwFFmtvaXJrei2
 5bvK0jdj0WcQhEp3mrG5ZiGEs3JQcDj00S_TEo8gORLjhdpP9cg7h9ZYOucQYZFiDJnIukobpIgF
 EXPdtB3EcrxnMWr8o9E1JoTr.wWq3KlwdwO3cQoidupyMMLlvNfqKMWm7Clv5BitpjbvotH5E2c8
 nmeuJsojjowkwi8LYhHoOY97rT7dp7PgAl8fjfnN0lRDYgHMR2nyNuYZ_Nawt0aH5iPqrcmgg6XG
 EtY9keJlurNFhugVGipsl3zX8geaQc6HfsuXSjqd.lJcZexZfsQNTZb.0x7dBKcyePrd.liBtqTO
 htRwFcpfmTY76xUoQWo91iKAJg3.3flYBlS5Vm7D8P6D06.L8c5DDCH2VPCAcWalRag.O9dwQwDP
 NIepZ.GrGboigF3TTHoIKOioWgfA3F2eYM0TURNs97OZoDTKDKZRK5UtrFl6hI6Oh3giapcIzxan
 l168fw3a06JW8.2NQl5ZtS3vPsHPNBhd0_JD29T5f4E26dWfDcQRggHqTt0MKv0K8zJAQUmxFJvH
 yf6A1ffKM.GDApZR1DtUWTK6IiHWsH9xPTwo5oCw-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 154aa56b-7716-4e9b-a17c-1cecf321e8c6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Oct 2026 05:08:33 +0000
Received: by hermes--production-ir2-5dd9bf4598-cdfcp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b726fbcd986fe7e966ab16a9c91a2ad7;
          Fri, 09 Oct 2026 04:58:13 +0000 (UTC)
Message-ID: <b18469d9-caca-489f-a9fe-27853f1dfb0d@yahoo.com>
Date: Fri, 9 Oct 2026 06:58:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 5/8] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <28382f3f-03c1-4606-9b11-86f118abeafe@yahoo.com>
Content-Language: pl
In-Reply-To: <28382f3f-03c1-4606-9b11-86f118abeafe@yahoo.com>
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
that control bit is forced here to match existing driver behavior,
not a hardware limitation.

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
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 143 +++++++++++++++--------
 1 file changed, 94 insertions(+), 49 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 7add1fb..0466e8c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -55,6 +55,7 @@
 
 /* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
 #define RTL8365MB_CVLAN_ENTRY_SIZE			3 /* 48-bits */
+#define RTL8365MB_D_CVLAN_ENTRY_SIZE			2 /* 32-bits, no 3rd word */
 #define RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK		GENMASK(7, 0)
 #define   RTL8365MB_CVLAN_MBR_LO_MASK			GENMASK(7, 0)
 #define RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK		GENMASK(15, 8)
@@ -66,6 +67,10 @@
 #define RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK		GENMASK(13, 9)
 #define   RTL8365MB_CVLAN_METERIDX_LO_MASK		GENMASK(4, 0)
 #define RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK		GENMASK(14, 14)
+#define RTL8365MB_D_CVLAN_ENTRY_D1_SVLAN_CHK_IVL_SVL_MASK \
+							GENMASK(2, 2)
+#define RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK		GENMASK(3, 3)
+#define RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK		GENMASK(1, 0)
 /* extends RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK */
 #define RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK		GENMASK(2, 0)
 #define   RTL8365MB_CVLAN_MBR_HI_MASK			GENMASK(10, 8)
@@ -191,13 +196,16 @@ struct rtl8365mb_vlanmc {
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
 
@@ -205,33 +213,51 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
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
+		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK, data[2]);
+		vlan4k->untag |= FIELD_PREP(RTL8365MB_CVLAN_UNTAG_HI_MASK, val);
+	}
+
+	if (is_d) {
+		vlan4k->fid = FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK, data[1]);
+		/* Family D has no priority/meter fields in this entry -
+		 * left zeroed by the memset() above.
+		 */
+		vlan4k->ivl_en =
+			FIELD_GET(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK, data[1]);
+	} else {
+		vlan4k->fid = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_FID_MASK, data[1]);
+		vlan4k->priority_en =
+			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPEN_MASK, data[1]);
+		vlan4k->priority =
+			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_VBPRI_MASK, data[1]);
+		vlan4k->policing_en =
+			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_ENVLANPOL_MASK, data[1]);
+
+		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK, data[1]);
+		val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_LO_MASK, val);
+		vlan4k->meteridx = val;
+		val = FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK, data[2]);
+		val = FIELD_PREP(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
+		vlan4k->meteridx |= val;
+
+		vlan4k->ivl_en =
+			FIELD_GET(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK, data[1]);
+	}
 
 	return 0;
 }
@@ -239,6 +265,9 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
 				   const struct rtl8365mb_vlan4k *vlan4k)
 {
+	bool is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
+	size_t entry_size = is_d ? RTL8365MB_D_CVLAN_ENTRY_SIZE :
+				   RTL8365MB_CVLAN_ENTRY_SIZE;
 	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE] = { 0 };
 	u16 vid;
 	int val;
@@ -250,36 +279,52 @@ static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
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
+		data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_IVL_EN_MASK, 1) |
+			   FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_SVLAN_CHK_IVL_SVL_MASK, 1);
+		data[1] |= FIELD_PREP(RTL8365MB_D_CVLAN_ENTRY_D1_FID_MASK, vlan4k->fid);
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
+		data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_METERIDX_MASK, val);
+
+		data[1] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D1_IVL_SVL_MASK,
+				      vlan4k->ivl_en);
+
+		val = FIELD_GET(RTL8365MB_CVLAN_MBR_HI_MASK, vlan4k->member);
+		data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, val);
+
+		val = FIELD_GET(RTL8365MB_CVLAN_UNTAG_HI_MASK, vlan4k->untag);
+		data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_UNTAG_EXT_MASK, val);
+
+		val = vlan4k->meteridx;
+		val = FIELD_GET(RTL8365MB_CVLAN_METERIDX_HI_MASK, val);
+		data[2] |= FIELD_PREP(RTL8365MB_CVLAN_ENTRY_D2_METERIDX_EXT_MASK, val);
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

