Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.187.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504995;
	b=FzTa5Zinaa+jmGNrEq5VbpZRtX7ZEMBiE4uVW5lUvzylyv9u9/06Pf9PZukVkGtY9GKt
	 NJFyz1XFnWZPg4GWaqybs8WBdlT2Xl1lVSwLqIukg8C6tZSLXuzqgbuy+MJGu8hkEA4NZ
	 qd4mVfNn1kn/MptPAcgpes4Il4OkFTT29DqWnl63tAIM+DX+Ie5jGNlrPOub44MGvejyf
	 kFcFyeSQkAWQ9G8SFuKnGjwru3LzhiYm6YojehaYP+eSRIHJfqN0V3AKpad9XnoLp50UF
	 WI0MSxiibYr2lCfOQ2ui0JL4TktEI1nToOrQUjdOU48NtHtKqPTAp4TRWaZcvNUlI/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504995;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=ikw2BYebt9ZKpsO8CDmhNDhYdn67npmb8kK0wkUU9w4=;
	b=Pkw2wuCF2NEC+i8i0ftBLDujl+OwV1lcyFp/sZhAeFdW3trdpgXJBwvu2Wl8cpLvYBD2
	 gmNHq0cC7dSvWjgrhALZTje6vHbRv3ssrGQ0eUJl2+hhSBLLbDcZ0/hajVw4LtaTR9vj9
	 4FvO3QI2/kjn+C/eiN/KFnqGbNx5u0vrpUlfjGajT7Lk7YSIDWNncWk88fpNRbuZ2fr7M
	 RbKG+otdq9Sz8OZOwf1p18lOmLAh1GlmKY/6Zoj3Fe5DApLrbIeFWcmnWN1CmfiVzJyZ4
	 9Kmbe94OVlTPVMie9+NUsrY1FNoeiemnzaoQl9Q/PnpOVs/8ge4VhwR/FUk/JubX6Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="uoJ74BS/";
	arc=none smtp.remote-ip=66.163.187.32
Received: from sonic308-9.consmr.mail.ne1.yahoo.com (sonic308-9.consmr.mail.ne1.yahoo.com [66.163.187.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AC606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C81AC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=uoJ74BS/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504994; bh=ikw2BYebt9ZKpsO8CDmhNDhYdn67npmb8kK0wkUU9w4=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=uoJ74BS/m/g2yozRo5+mRJI6GWE5PmE/ipywpVkhO6DLtctEZG39MeNR7Lc2/UHSsexLg33PufCf8+HtbZ6+mc/ax9AMcEp7BBtto4n1hC+SAPZaOU1MV8NRZanxCac95NejEIMKktAKv+d2rZb7omp2Kkxh8GhkrEWRs851Gtcd/aRIDEU5pwOl3/m5gs7i8NIXV4v3gdpteI4MBw3MKtRNSMFiTIct7xoqMSJZFT8QLRy8RzP28MHLgMVbdpXbIGS14ADLdQNHUEnFW1Zh0oaX5TZmeOcxTx/t2Nk/Yyw2eRW1/IPA87QdVjNFvEn2iVk3ekxX85baQ1JQ0CvtlA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794504994; bh=rppyylaTQ+zkPFoMVoq+yhw0vVGqL5JnvofcjpyYKxq=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=GQaNCR6QaabPJLl4Lt94bnkHjJgQ5yz/jdzJx1O+seMhrhQYRz2zysPKnVOmoZAJj4gKVAyrHVdiowR93wgEZ9Tq977Hhnlkje/Mv6q/IoQjpzVGDXxfslY5XaagRmcc7RLtOkA/FG6+AIl6codeMIfPYcRey8O7lJQpnTX8de4pwTBmBvB5drxhovq8ntD+9LlB+tzlyORiNULWC/Jp3685uwB+4tl8yestLf+8IsEf0FmyrOFeKpHEU/4ZJW94otz/5T+G2T+vAIy/4jfjuA01fqbZrZ4z5VaThTvUX8RVEfWgtdt5yuSnNuL90sJs155adjl+HgHsJ0VO+lK6Lg==
X-YMail-OSG: 9sDkl.kVM1k26AmrQmA6K89zZNtmoXmvcHY4NhzcA.NShhFFNfmUGV3DH6VSV18
 Pu8SCmjSqTLNOxO7MOjiptcMrN1Uni0sbpuhwKcM8qcFTGNmGtrReiiwg.fcjASfk1.OK38J75oK
 q5rmm2qJeusOsGUDTGHpP2IZ5wLerW8ys5UzSrthlpnffTruepKNd6bJ1.j2pNYYKX8g7viDI7vt
 MNjwel7NJPQR44QE8NqpHCdpo2sbZ5dvN5BwBI1zOwt0QRzlWnCrMiFuBEw_IzwyjTLpDmaBGT5P
 rT52Yqo9v8sEGn7y4FoXMc_PZW6.spOj9K.tkQsf_EqnbUg6UW8qlOGjL67w6akasfH4pdjequ5N
 izdXMBih1j2pd_39a0T19Y83r7iVpMb4S1RVwbZkIZMVabwBmoecLAySg4xj_LYeBLi9njgR72lF
 goKfCsw3KStFNpOqPD6EvCCPbwhg6Jqq7RxpwfL5azH0OY1eStXjc1WdEu_lf7U0xMv.Kito7LXH
 zrI7kQU6zmUAI5DWeHzp_ve9.egNa4_m9pDD9kYK67mqaeDco2.u6ztZFgoKwrOM2oYpguO8W7l4
 STPUPa_G5YPoyFbFbicZsqWh_vdF9SpGNNTSGkRqoKvEQL8BlB8Zm3t4nYZoznsZGWjqXpZotd5b
 _FghOYySvWthu639tOTIplhnwBmiw5XQz1uuZWfPq6_onqVQhvU_GW60.xrfQjjBRphi2tVDdWzD
 OeZvccQB0p8wNIeMtISd802pLmubBrenlSX.t8fKQ7fYQk7ndYliG0vwRMB.u5j3quVXV5.hNT1F
 hlv0D_Sy4AM7.0xw_TmpPoE6K8fP52xyEVXPAmQUj7fAaWZxNfWrFkAOJiIGlmimMy8hYXfjEj2J
 ADMdaXeu2Ct3X9VX0rrdfofu3jz5ru7C0JYPq5djzinUwy85AP6jJa9xBZhn58Y6qaD2.VGCjfD_
 1uFDlZE8NrT6rjDcaDMe87PyU1NesywwO4GoHdDUqv9lrJQ5b0CxST1PRnR86sDsSvUMYlpFSUNV
 GYQDPtmHhWEneaBi1LrI02KRmKJJY1QZC9T30L62kARtw1zL72MYsAHkfK7NAbT94xZ9TstB4kly
 aN3g9j9ufmIb0.0luR4qMCG3CtOAciOZCBATe8RT38S7eIzEwusXVQJ0jCR7Cv0OyMrTHU6QTtbK
 8SL63yse3QHI8mvf_Dm4lIfS1q84qTCKRfrl4WIS85KBE8yIHz3F1ZIPNRHdHJ9FHE47FThMsTkR
 Jzi9L0s7NCiQ12yG__ZEsRlKBpDX6uR_GYXey9tGsMTg4cS8bxKMj2eEy0y_aC95TvWeEOqnT81X
 J7G5d7GpjCqkDn1GE70xRbPP0srSasscZOo5kWxWcVYGm_Gg5hHLyT5f0TNKUj4xNHkfHvdSxOZ6
 eWHNAAxH5ugg9_u4ttP56NaixRIGyRKq_H8e6U0UGUPJnl_.6w2lwDf02tlL3JELvfHtKuzq26p5
 fcSVBUooOVM8.q6fLeT3ImWMAKg5YJov2_wg.djPwuDQC8TYYAG_kBck8fSBAj1ehnmKFSWS7Mns
 kI8LmDyyR6LRw01CwKFia0CisAI9ZAHudGclu4LtYckj1OaYhb0Iuy4MbslchcSIqonDGEaQ3Vlu
 1fwHVPYSD8toaBFu8bzm6OmW_F8uZ_QxX3QyF3dkw9eYEwNhi3Lzx1U4WEqvMeDUfl3Eoovywel3
 d7kDzMczOWu_3_PCd19mrV3AjnxUtN_W8JDnoL0ARrLl848whrvoWjudIpv6HgoMb2_YC_W_IQbW
 QtTSJvMhArjY3IxInYpLZBYQWx67sGmrJs.Im.ZGusnfqQPJjgI65c2lkQTSZChw.htaKH43ryKq
 F1j7kWiKoWNTuXbE5uyd2rTNeTP59XCei._PLlAqyQqjBfxP400vsI9RxgpdAqdeTnk4I4.BKuxq
 ohlqMVKxb_.js2l3PxrcTcotIp2WDlQsV0s5bEQNHBpvwILbQeTdXyxGGxP.r0.O7EdYNU9hmILO
 xTv75OOUm21VwW_1i8k9w93g4z0l6.Dix1wlwSBplkhih0SgkTIs6usWYnPjQwRR1wOvCBqz9Er7
 cLabw8ie11u283KMs4LiMgOG38a_drCPgbgyQCqMiklilSOTQJyx.5X1bPr.ZqcAxuK9Y4uPDT1c
 mQlzFhpJ88Spad5cDsEDLSaqusQ8QODX2XdkpNGThwsJzx4Jm613pvTd2cyC_cnpQ26tlGyDlMr3
 VkR8FWwC9meYV97AmicOagZsgQA0_5uLWGsjPe1pBx8oq90iaEyGGsI.MiiFefjtUEVbKnaBFXbN
 3cbOh7wepBUCh1.dmBNZSKM9uh_QJv4uOecNL2N6zqp3t0Yw-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 50adf8b0-aeef-4f03-93c7-84d8e154c627
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:36:34 +0000
Received: by hermes--production-ir2-5dd9bf4598-p4sz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1b62bc055b37b782de662dc280a9a32;
          Thu, 12 Nov 2026 17:36:27 +0000 (UTC)
Message-ID: <c76ba49c-a962-4838-b8d5-75c5b3bcdc2b@yahoo.com>
Date: Thu, 12 Nov 2026 18:36:25 +0100
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
Subject: [PATCH net-next v10 06/12] net: dsa: realtek: rtl8365mb: refactor
 VLAN 4k handling
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

Move the family-specific VLAN 4k table accessors behind struct
rtl8365mb_family_info, so that family D can provide its own versions
without is_d() checks in the shared code. The existing code becomes the
family C implementation and is otherwise unchanged: rename the
functions to rtl8365mb_c_vlan_4k_read() and rtl8365mb_c_vlan_4k_write(),
export them and call them through the family info.

No functional change.

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Tested-by: Stanislaw Pal <kuncy7@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb.h      |  5 +++++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  2 ++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 21 ++++++++++++---------
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |  7 +++++++
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.h b/drivers/net/dsa/realtek/rtl8365mb.h
index 3d607bd..d3d5fb3 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.h
+++ b/drivers/net/dsa/realtek/rtl8365mb.h
@@ -10,6 +10,7 @@ enum rtl8365mb_family {
 };
 
 struct rtl8365mb_jam_tbl_entry;
+struct rtl8365mb_vlan4k;
 
 struct rtl8365mb_family_info {
 	enum rtl8365mb_family family;
@@ -19,6 +20,10 @@ struct rtl8365mb_family_info {
 	int (*ext_config_forcemode)(struct realtek_priv *priv, int port,
 				    bool link, int speed, int duplex,
 				    bool tx_pause, bool rx_pause);
+	int (*vlan_4k_read)(struct realtek_priv *priv, u16 vid,
+			    struct rtl8365mb_vlan4k *vlan4k);
+	int (*vlan_4k_write)(struct realtek_priv *priv,
+			     const struct rtl8365mb_vlan4k *vlan4k);
 };
 
 const struct rtl8365mb_family_info *
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index bdc29d0..611e58c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -757,6 +757,8 @@ static const struct rtl8365mb_family_info rtl8365mb_family_c = {
 	.jam_table = rtl8365mb_init_jam_8365mb_vc,
 	.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	.ext_config_forcemode = rtl8365mb_c_ext_config_forcemode,
+	.vlan_4k_read = rtl8365mb_c_vlan_4k_read,
+	.vlan_4k_write = rtl8365mb_c_vlan_4k_write,
 };
 
 /**
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 8d49ffa..566c6bc 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -48,12 +48,13 @@
 
 #include "rtl8365mb_vlan.h"
 #include "rtl8365mb_table.h"
+#include "rtl8365mb.h"
 #include <linux/if_bridge.h>
 #include <linux/lockdep.h>
 #include <linux/regmap.h>
 
 /* CVLAN (i.e. VLAN4k) table entry layout, u16[3] */
-#define RTL8365MB_CVLAN_ENTRY_SIZE			3 /* 48-bits */
+#define RTL8365MB_C_CVLAN_ENTRY_SIZE			3 /* 48-bits */
 #define RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK		GENMASK(7, 0)
 #define   RTL8365MB_CVLAN_MBR_LO_MASK			GENMASK(7, 0)
 #define RTL8365MB_CVLAN_ENTRY_D0_UNTAG_MASK		GENMASK(15, 8)
@@ -182,10 +183,10 @@ struct rtl8365mb_vlanmc {
 	u8 meteridx : 6;
 };
 
-static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
-				  struct rtl8365mb_vlan4k *vlan4k)
+int rtl8365mb_c_vlan_4k_read(struct realtek_priv *priv, u16 vid,
+			     struct rtl8365mb_vlan4k *vlan4k)
 {
-	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE];
+	u16 data[RTL8365MB_C_CVLAN_ENTRY_SIZE];
 	int val;
 	int ret;
 
@@ -230,10 +231,10 @@ static int rtl8365mb_vlan_4k_read(struct realtek_priv *priv, u16 vid,
 	return 0;
 }
 
-static int rtl8365mb_vlan_4k_write(struct realtek_priv *priv,
-				   const struct rtl8365mb_vlan4k *vlan4k)
+int rtl8365mb_c_vlan_4k_write(struct realtek_priv *priv,
+			      const struct rtl8365mb_vlan4k *vlan4k)
 {
-	u16 data[RTL8365MB_CVLAN_ENTRY_SIZE] = { 0 };
+	u16 data[RTL8365MB_C_CVLAN_ENTRY_SIZE] = { 0 };
 	u16 vid;
 	int val;
 
@@ -282,6 +283,7 @@ rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
 			   struct netlink_ext_ack *extack,
 			   bool include)
 {
+	const struct rtl8365mb_family_info *fi;
 	struct realtek_priv *priv = ds->priv;
 	struct rtl8365mb_vlan4k vlan4k = {0};
 	int ret;
@@ -296,7 +298,8 @@ rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
 		return -EINVAL;
 	}
 
-	ret = rtl8365mb_vlan_4k_read(priv, vlan->vid, &vlan4k);
+	fi = rtl8365mb_get_family_info(priv);
+	ret = fi->vlan_4k_read(priv, vlan->vid, &vlan4k);
 	if (ret) {
 		dev_err(priv->dev, "Failed to read VLAN 4k table\n");
 		return ret;
@@ -313,7 +316,7 @@ rtl8365mb_vlan_4k_port_set(struct dsa_switch *ds, int port,
 		vlan4k.untag &= ~BIT(port);
 	vlan4k.ivl_en = true; /* always use Independent VLAN Learning */
 
-	ret = rtl8365mb_vlan_4k_write(priv, &vlan4k);
+	ret = fi->vlan_4k_write(priv, &vlan4k);
 	if (ret) {
 		dev_err(priv->dev, "Failed to write VLAN 4k table\n");
 		return ret;
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
index 27a526b..009b127 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
@@ -18,6 +18,13 @@ enum rtl8365mb_frame_ingress {
 	RTL8365MB_FRAME_TYPE_UNTAGGED_ONLY,
 };
 
+struct rtl8365mb_vlan4k;
+
+int rtl8365mb_c_vlan_4k_read(struct realtek_priv *priv, u16 vid,
+			     struct rtl8365mb_vlan4k *vlan4k);
+int rtl8365mb_c_vlan_4k_write(struct realtek_priv *priv,
+			      const struct rtl8365mb_vlan4k *vlan4k);
+
 int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port,
 				 u16 *pvid);
 int
-- 
2.53.0

