Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163337207D
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661301; cv=none; b=L3MzHD983VstN6DPhz6GGTW654qzMdds6KSSHvVludyBiIRwi+CxrU8UCJXfZYta3ck4EF2cX2Fbq+3MPm5et9Su5cCgsOuX5j0aNrdvVF+s+0fnzbUKi7juje0LLx88GLR2m52uVGUYT0j5iX9WORjS0EuRSoKOwWPiRPNdIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661301; c=relaxed/simple;
	bh=BJO9+Gme5q/ewkR5bVEyitirSxC9rbiAC4HDCP6/ZPA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=E20V8wyBkPT2dZcdam7e4u/zI5FUlsEbaCObnQDZM6yZC3cSjNqTml65shkCvvemmh1V599XeHPo5eCNnCadW4O3a4TKS9g8ef5WvKpkjhr4AuD8LiJ8oU4QEpSRrQQkNPDygon1lIbjSQM/pLc4/TFc+5k26WP7Ve1u8wxG4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lj11Vl6/; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lj11Vl6/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661293; bh=QrRx06slJp15leTJoi2UpgPG8pZmT4ZjWMwNpU2EPJg=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=lj11Vl6/vnysgwRFJ6bGZk818RYRwd/dTPTaovgUQZHnzrpasKGs8a2AdD2Pw6cPZQX7ylH8FOtkoO0e5t05U+Ce73V0U4FzuiPP3/VxEzeFqmjGHiEL94KMt7+zGOWFoYkbNO9CcGSu9P/Dh5z7lfp3OHxs2gt2f2MU3pAIiRigYqVYJ4mtr0fVm8V1j7ncqLuGQa7A7n07JJoAIwsZpSmYsQKyB8PLZXnWiXSvX/WBHUVUnvtnq2wD8x/0+ILk5SfyO5/r+DVCJTPq2cBYf315dpwBJpZKUYJ26OKxpdNPrqFSb3THqN7LNsFgmMQEQyxvqcgW582g5KndWU3HxQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661293; bh=bPjpBsdz4YCnjRRNPUu5S4LBljTtePOdizWDEO7WcxP=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=GYyUpOVPGXp5nswDASGoAqddbsbb0yZukd1RpxxUH0k1ZSUJpY7HLo9/M7zxxuAjv5K+uJkC8Yv25Ylziho95w2Zbt9AlR+aRL6V0pc1SHx/bjYpdHSFJJn6qP1duwNAH9HLRtfDUkGYeBkQirvkPTHBrlnIoAyRpKK1Cl+XohBPRCBD+Gyy/l8MzFaqU4odKL9aNKjNTi/x7rqUcHLlZqDkNDIQdf9V2wgXsoh52wt7DZIStalgOnTTur5q2IkXC65GeFiScUcPyY195DM9NtytcB966iPQDsXIUw1Ie2HUsdbjE9qkgJZAC9nKlSNxlvuL6jm58qCe4zs8ZIZa8A==
X-YMail-OSG: McQuW4MVM1mtLtHC606l_lNgdI2E5qOoHgoZTavPocD7YTZIJUOfncHmH4D0pjX
 js1FRVZ0JYf8CI6mlxpEkb3g0wcbvJYrtjJ2P_NfbMFbt_1hOGCKVlkr3kKPWjpgTMokGUQKz241
 J70GeQdyEUyb.2ic3uLNR5LEpBG_A_Lz_CM_No37.AAQCAibW.gWRWQ.kbEoBF9sM2B1254nkGm.
 6msesUUIYiESxUClV7d51juZfS9wTDJUfPTTQ_T6J7oIjXCUvgnw6QWI9.Wm3RdnlBV1YD5m5e7V
 3ec3KSArlDnz.a4pttX8zenCfCOgd.q78VrshA8xEWFHnoHPKCm4p.VUfXvz4KzvdiE2fWQ5f00p
 dLJzp4mnREkrlF35uGLZewA0z34NUPRYstP.YnNsXXFf.26vlXc72fH3Z.tbPGGnwOA8Wp.jAdYQ
 2CQAH0BONKrf3SpCpDoEiRW2CcaVc6H_.wFgZV2jEJuSisNFNpr6LNbAY8bCAtVeuG.BcwTvGH5D
 0SCgaEMjKRdraOD3t2lgidAXoGacTr8D40AiFWkEQ4QE5QPFGEtNAQF5hTNXC1ShOdA1aX3NSDW6
 jAPdUZ3dmDGKL6_POvEStsq7TV7CxszzFWJx_ClKPvMypSAohuDuabDrDHJImfa.oJw_680AiABh
 pnBL5s.iEppdGaiRdzimSkfNkSfmf5h_fUPLFl0P2ZItE58NPHs94ikWE1cnV06ZvQAL80Hdv5wm
 p.F6PoWQAQc0qbqxYuCF9.VbGfCxyP6V.87zHlDKtn.Nrd0kZyo_hIuxgmYDX_g96v964mpUmac6
 tXC2OzBqYJymw03uFwZCqBibfoRLWCIXvoeemhKWXameyO9ekpRNze0cJ4WrlhHyMt10r4HEKxyy
 .hpk6xnMA9LE3sGgBPZLR5Hl14k7U2oClGXtA0qOkzYLESRQq_vB_d4jk.WDiZsj6BRj5LyxJM7n
 npWV4vg0o5eN2L4fRkPG0bBX1Io75vtWfA8ZqaO2CziyFsc5DmoQVvhrNhaBpw9fEpmcALl6sJku
 3ktQxybTlW7XEOqyZrcEzEMQWRnevsvi0z_WfnRPKPwVwOCkmGFKaywScdqUxvS700ECViJCaidr
 JKf8X_2vZ5UWHXov6kWhL7aZnZGDRA7VoCPwhqQE4gKZc2teNpKorFDJ6QZ2BuE8qpwLBSv1KsOj
 iYItQvddBtiS94CA6.engVCfXxOoOheNXjjAqQbqOoC0GK3PE7OTwE4q5hKViDPSQPNhwEuFMFHR
 Zrf0tj_sxCpz38oixKM5RbZg1kVlMZZS8idsWr3gZlWgKFUJhnUMXCCYsUkljiGfa0nkRx.bRd3H
 zaIBaaNXRyUV_XV0IUKcoHJ3ItxkOgINaxUZ6S6CCDWn7BMaqa6WxomFAoK7zo19XE5x36RmrW0C
 VjzTxUZSfgm6I9BnGoRnY8bMheUbK_oeG6aaNyKxlZsgHDSdmfbLXYEU1zErtOQEtJkMShEtNdbO
 AwA9Edo72GrdDm7JoWjWl.aeJcOcR8KT1cofgxbJtBuKoB7l_uaZFjHoU9wKz06BfX9bV1esb6cW
 mKiVUHiroEQRmuhkFjeMk6WzSvDUn4veY.jyBTuWXY0wuWZpntMen8NsrRot6NOtHWeGEx7FvtVI
 1ttRP2kjIDlHmH3V2BpF4TWSOcsvMWGAGuwOaVY_vxW7nS87eeMxNPG.K3jRXDo4lm33qEBR0Y3w
 40A2oSbbzr8YS9kqZMERxsl7VU4s2QZHKA93NYfMyWk2DhFitNL38VCn6X40DZxkXcXaMRiU_JVH
 0efedRCv0D8r1pnFsooXzL4UcqhvUuVjUteoz0xzxoky3lgXOJnPasJjip1ukns9D1tCfHEAEtqp
 YDUIMFgGtP_UtMtiHcXmMwM4DQ7cMysh2Z7zfu2kSrE6UcKLxguhEPms3rjvHOArTUuKAF1Y_8vq
 s8soET14dqf3eNVmC1RGH1mqGqTTorJisgngW.wYijanE5qUpKuyBPSm5OEmVLcMzpj_4yFIXBGA
 J0PVN7ch1hT7xZ6VXBEPRMSe5lihnRUFcvUA3iaiAk4DvxeqoPh03h1Y.MzZQwd6lOKZYG3O6vO8
 zhwExEayxT1bo6197fzuiPbYw8KbpnSYilqHN4ARvBkdiD9wkBHOpTBvxBkgeQlgzoyMGclZW6cO
 ApD28BzHML16xmWFBQLSgT5la7sM7KUpBBPKw5K9x9SVA_N_NvMmw_MEAFF02xF4pcAK.SYgaiBT
 YasOhBbBty3bK2rDlZKATEa5Nb5PWqbZ2SUFmqVb6IL27QkimxHa8225D1hK4S2Zap5xVLjO0Hc3
 23eKwlO9LUVzkg8qf2bDZhigN5sysUG8I8acV2EYkbg--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: f35f237a-f60d-4a8c-8e33-7c945590d6a1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:41:33 +0000
Received: by hermes--production-ir2-5dd9bf4598-z289g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3b7a5762e9fdbfa714ba8c0383ad01d7;
          Sat, 10 Oct 2026 19:41:31 +0000 (UTC)
Message-ID: <22c20407-e6bc-4171-92b5-33650de94a49@yahoo.com>
Date: Sat, 10 Oct 2026 21:41:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 5/9] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
Content-Language: pl
In-Reply-To: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
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
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 161 ++++++++++++++++-------
 1 file changed, 112 insertions(+), 49 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 8d49ffa..2c4c5ba 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -48,12 +48,14 @@
 
 #include "rtl8365mb_vlan.h"
 #include "rtl8365mb_table.h"
+#include "rtl8365mb.h"
 #include <linux/if_bridge.h>
 #include <linux/lockdep.h>
 #include <linux/regmap.h>
 
 /* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
 #define RTL8365MB_CVLAN_ENTRY_SIZE			3 /* 48-bits */
+#define RTL8365MB_D_CVLAN_ENTRY_SIZE			2 /* 32-bits */
 #define RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK		GENMASK(7, 0)
 #define   RTL8365MB_CVLAN_MBR_LO_MASK			GENMASK(7, 0)
 #define RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK		GENMASK(15, 8)
@@ -65,6 +67,10 @@
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
@@ -185,13 +191,16 @@ struct rtl8365mb_vlanmc {
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
 
@@ -199,33 +208,61 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
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
@@ -233,6 +270,9 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
 				   const struct rtl8365mb_vlan4k *vlan4k)
 {
+	bool is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
+	size_t entry_size = is_d ? RTL8365MB_D_CVLAN_ENTRY_SIZE :
+				   RTL8365MB_CVLAN_ENTRY_SIZE;
 	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE] = { 0 };
 	u16 vid;
 	int val;
@@ -244,36 +284,59 @@ static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
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

