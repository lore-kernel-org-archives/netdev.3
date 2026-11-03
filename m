Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.189.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748944;
	b=PMflxAa1Ow/YkhHFjwro/m1q+4eYQ8VcQ7K3N6h8qkqM9K4ds1DykIo7BRDdAMknbx53
	 xfp1hrkAq0Wlzm5B1CZVtcR+AmVskX6+7hOqY6OYbSnYVVGH9ibZwmarA0O72b1fhTlqQ
	 M97uqSN6qyoq1On+a4kugX4Ykw/Myt5Q8JjMAj7QPcAQKuwZB7LOdBNYujCNkI2jWGI2P
	 9JcC56BIly9j0ml/k5VLiWc2s4P/xAokCzHQ2+RN/wfxG0gjicAMBZkRmE0yprmIDDqCx
	 fva1jZm3OP0BSR2ibv29TAdq+u/h2YeRmSP+9nt2lrf9G9KGzcaiDr3zFpHXp7vNvwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748944;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=PL9qczLM2vePYzFGhXvjJjFfnm/7O0KesC4zQojdSF8=;
	b=X7LiyR4l0aBYX3e6fLa3qkEDdf/0S61T+fVWgy72uZw6UXnPHNOqFy9cwlRBEO/E4N5r
	 /ybWLAY4rB9hQ51fkFEtLLQI1ALv0KfgQ9McA7bsAC2AMASnHaBADApMB2prcM6SH9tEN
	 INhXLD+GCV+fl+hbRvhjfxGOOHiBpOGQT/b7DO0lEK577dp20OhL09ATEqIlImzsVonIN
	 x7pgd5O33Ix0MVAT4t1a/3leCkp3Y9W54pe6Ruk2VZ7c4F6tUeOF+iLaaUKwQ5Gvj/dzl
	 0+AJio8QfLWAcJRrSaHiwDlXkQXtJ+00jQMME3RkI8YxilL3dhZCFmB051thHQ2Uo8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=XHN9+Kkt;
	arc=none smtp.remote-ip=66.163.189.84
Received: from sonic306-22.consmr.mail.ne1.yahoo.com (sonic306-22.consmr.mail.ne1.yahoo.com [66.163.189.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56B606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA56B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=XHN9+Kkt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748942; bh=PL9qczLM2vePYzFGhXvjJjFfnm/7O0KesC4zQojdSF8=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=XHN9+KkttPbOsIBTzJZISZqKGyH0VP3eaKcM8ItuoJ2XshdqB1cEWn3BDUEyxSSJDm93DrOj8CE7US3hwuxnyKM9Jtr5ALk6D0/SlRjBHsfhraJI8/G33kbSknT0ut5sqQAtkwA2hP1KZKYg/VI2GhedenY3cmxa84qxjBTTIdkSnWZuBWpacElbOX4/e+oUD47t56HqypgEG+7FrK6K+wxidAtWFP/Vt70cQBJdmx/5MwV6Z4urhvj6j37Lcspoxc8Rn0wiMSOC9E3i8cctyMI39neC8OF5p7ZpXi40WnJZ9yIjUSD/MZ0PgAhJYG8AnH2LK54f40WerewWEFGtIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748942; bh=wwpTX1lMHzJJRr9tiCjHeeBu85cmABqgGqUdwagFot4=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Pc8leTZEXGQbhChuFwwpZMpikunBYhKX34Gq8VthtGN8cZmoEpkmbtXDxa7QG463+eCYxGBgh17t1tvomMDCz8Mba5xdyXKVwH2xVKP9AH+18DZCiWckpoGK5DFOTfx+tl0Pocab1N6SzWA0gmM1wPjxoJnK6FEZgc+1bluF83MudS/yBNQ3hleXga86rLy3c0d4G3ZO2Dm7q3gMjbDh75CKYCOw3yElzvYCOV3bcFd4DkCuezv0M7PdoS0cC/JaAVy1m/affWK+lz9eAMGwJ0pXTBAGDOmO+5fZ86KyVyKVmWl4+d/A2NrUeMJ5RgQTzXZaygnWvq3+WgVySjhMEA==
X-YMail-OSG: 75neefEVM1lry92bN75.8jqsptLS8tFoLnO39ub3GhFFdAQlZAObdULuFDBiSH2
 HmZb.YJ4w65XaFTYP_CfH9.uzCT.We8l98K.7I42Qi0G.73OVJ5rynVsdoE8hEgjR6XmL6Yhzotv
 QjZWCnhserrsR7VPuLK_uIs8quSuqqe2JLqQUqWiT3eR4yF80L.dG_3zsS6o9qtRc9._lRvOQyUT
 XNsyCPW50RwbK1XDbTnHqlUmPM1YP_2EZdDl0HBzdVcH7T.0WwyFmxfLbsxywAcwwQYo.IYsUSlL
 pZycqeFsnCpgENy.8MzXAxKfzyMwPFW85zGStJFBgkMRU2u9oU_i3Y3SoNI_h5njCjhrGTkLxhI.
 T4y5ACVYALcpOrfgLcnJcI1JAUFTYCJuVSrC3T73m37ppVE9b5SqW7Qypzio7tLd7uhdF3XdLUPv
 wlfPqDPkC4UQBRSl9ueMqn2xaHQl3YYqXgLZBXi2deGB7LkWMvWG9rQoTUF_.3DvobkHggqfdaCd
 VoSfE_JIkcLDiBdYdL8roZvCOHUOqwyuNISC6GNIaMaZmn5DTQYrFARyP5nOH8miEL0FcQwhK4JD
 PafRSh8OFVIAxxX.gszOIouD3UQ_AYNgrHW0h5dkSGO4PHJoHDue7mu7xPqji_i6UBRW0yF.bbgx
 pwWbXpIQXum5L1LsjRuUfenUBT8OTW8bqr9kbh5tMeiE3EPxlNFOu66uGyJ1yY9xd2AD1RM6Ztqe
 J5Vt.ScjzIE6Dk1Y0PrLqZhXRqDHitAVgYJoUCLZdNVIZhTFQsU5gLrkr9LQiiIkBVHXck0MFumS
 mq7EKR_1u32IXxfhMpoV.0iAsUI6ZlAK6fPH0elhaaJ2JL_cQj2Oa_VTQT617E_MunecXrVMZrvJ
 dLODzpLXLqRCuJ8KJqukAE2z060GtCbovURCCyq_Wgxrmdipo0aijna3UNFiHf51tbDm_7AbuIl1
 lqqDFHnTGvuCtGmwoBZultFgstPcHWC671ZeEQbRq2KLpe.ErXrGDkoNN4FL_3Yu722CdC4n4lZE
 E.Yjq8pTh0D7gq5TJQeRhBB9cou3oItR6t7lwHR9JWrUqtF1alPUMHpZZuN08aVcB2EJHWk5vpVw
 Ain63rrnZFZw.wSy53SIEjdkMzbAdKjxC9drNIiJBZgbj7XKFVmjr6BncaFw_CwBjISPWuO9dX2J
 z_GNZC_94kl6WdXD7mQKkejKqVsjGzn6_alNqYASalUl7YTDXXmJcBD0578hOc97JYMWzV5T2s3T
 7Fsi3NkJnoLBwuB.214q5Y6.zPTDKCo5gwXhTA2HOoQ4VaGH3Zoh8LnqtkSay2Rim_obQbxTXFUT
 YaDMlWy34LsJwVny_q5uXfQ1ireN8872MESk0YarwTjt87aa.I2SLs6hGCoAwrpn_FWOMSOwvcCg
 Pk8EmCBRX9ThYRt6NBwDnNgcoDlPoXYUMkrkWNgTm8y2n8dPVqroc4o8ZNP1Wv01OkqWMELZNaWv
 YeI5YRgg0QvR9TPDlllfA7pCI9xixZ7EOJ7AdcA528qntuP15rAbmAU8o5frpz0wX3AhoH3Q_pvG
 R_aCVwIFwEdIXEyWCRXFOioMFz_FDq9NnN4QYYbgGcjb1Ul0NjcBI0XJPcqKmaBtHyTvDe9M1rbk
 xU0yKy5UblLTlaJbRIPwRRvkbEj1YkeJbA5UKzDKkeWnGxmgUiLWx.QTFl2ufotQQGt4hRa1i7Cc
 Zp2SVVOYIJyl8CloD7kBfC9CAdNL0kld3lTMu0eONha8Cpv_F9xWLwCaYJX6G86DNwCxlhfxsyT3
 L_0_Z0uIyvwv5jTpoBJpyTDcg.9Ue97w0KEjE6AAlf15zjJ.3GJ4cUYLdssPj4gW.OgTNRaZkboz
 u_NDRuTrKu6.BWVgvsK1ScxuYj9UvMeVevqX32O5qJk5Fh.grwrl6DM5NZZ.UxiWVrYVX3CgHjHn
 fnJOd3jNEUSI6GsQ4pi0AgAa53BPdq0CrrNcxw25KPXyqQOxuCeSso1fTo1JIHD9Rptf2GvDaJUr
 fkw95buy.Aov6AY8O8L3Bj4ARQM3wVneWqKg95X36hHM6zJ8LNT64ekWrWeTmMPnfKsj2amwCf9x
 5qGs299UiBV3GjR2nrbY1WrOXzo5Issqg2_DmRhVslJjZXPxuGp2EWAEQFgB6R14xvai7C08ubgB
 en0PHY0kpAbKR.R6_kKGYsVE2J3o6hlYqlKku7ALzkGrwOaqZcCxmzq2BlWPNGeAcWVJOhAc5Kwf
 y.SLe3GX7gETOHaHap7VR.g2VBbexSzgGGCy7e0PmN9QqlNXAkG6Z.ZnEPbN4vwfk3tfAxiOL3Jz
 UpVowugU0XXrfp0sy9oIf1ofc_uEfAfopc_2h0c_cEOJ3OUQi
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 038ae7ca-bbce-48f5-9b72-58330aa70dc2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:35:42 +0000
Received: by hermes--production-ir2-5dd9bf4598-hl6xw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2582614db1dba6081b7cea4524be2424;
          Tue, 03 Nov 2026 23:35:36 +0000 (UTC)
Message-ID: <3685f73e-0c28-4ff1-8c8e-3c39643a6649@yahoo.com>
Date: Wed, 4 Nov 2026 00:35:33 +0100
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
Subject: [PATCH net-next v8 09/11] net: dsa: realtek: rtl8365mb: refactor L2
 MAC handling
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

Move the L2 MAC pack/unpack helpers above the family C serializers
and use them there instead of open-coding the byte packing, since the
layout of the MAC address words is the same for both families. The
now unused per-field MAC masks are dropped.

Rename the family C serializers to rtl8365mb_c_l2_*() and keep
rtl8365mb_l2_{data_to_uc,uc_to_data,data_to_mc,mc_to_data}() as thin
dispatchers taking priv, so that a following patch can add the family
D layout without touching the family C code again.

No functional change.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_l2.c | 117 +++++++++++++------------
 1 file changed, 62 insertions(+), 55 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
index 0494d8a..01cf2d5 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_l2.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
@@ -12,12 +12,6 @@
 
 #define RTL8365MB_L2_ENTRY_SIZE			6
 
-#define RTL8365MB_L2_UC_D0_MAC5_MSK		GENMASK(7, 0)
-#define RTL8365MB_L2_UC_D0_MAC4_MSK		GENMASK(15, 8)
-#define RTL8365MB_L2_UC_D1_MAC3_MSK		GENMASK(7, 0)
-#define RTL8365MB_L2_UC_D1_MAC2_MSK		GENMASK(15, 8)
-#define RTL8365MB_L2_UC_D2_MAC1_MSK		GENMASK(7, 0)
-#define RTL8365MB_L2_UC_D2_MAC0_MSK		GENMASK(15, 8)
 #define RTL8365MB_L2_UC_D3_VID_MSK		GENMASK(11, 0)
 #define RTL8365MB_L2_UC_D3_IVL_MSK		GENMASK(13, 13)
 #define RTL8365MB_L2_UC_D3_PORT_EXT_MSK	GENMASK(15, 15)
@@ -36,12 +30,6 @@
 #define RTL8365MB_L2_UC_D5_FWD_PRI_MSK		GENMASK(4, 4)
 #define RTL8365MB_L2_UC_D5_STATIC_MSK		GENMASK(5, 5)
 
-#define RTL8365MB_L2_MC_D0_MAC5_MSK		GENMASK(7, 0)
-#define RTL8365MB_L2_MC_D0_MAC4_MSK		GENMASK(15, 8)
-#define RTL8365MB_L2_MC_D1_MAC3_MSK		GENMASK(7, 0)
-#define RTL8365MB_L2_MC_D1_MAC2_MSK		GENMASK(15, 8)
-#define RTL8365MB_L2_MC_D2_MAC1_MSK		GENMASK(7, 0)
-#define RTL8365MB_L2_MC_D2_MAC0_MSK		GENMASK(15, 8)
 #define RTL8365MB_L2_MC_D3_VID_MSK		GENMASK(11, 0)
 #define RTL8365MB_L2_MC_D3_IVL_MSK		GENMASK(13, 13)
 #define RTL8365MB_L2_MC_D3_MBR_HI1_MSK		GENMASK(15, 14)
@@ -131,16 +119,29 @@ struct rtl8365mb_l2_mc {
 	bool igmp_asic;
 };
 
-static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc)
+static void rtl8365mb_l2_mac_to_data(const u8 *m, u16 *data)
+{
+	data[0] = (m[4] << 8) | m[5];
+	data[1] = (m[2] << 8) | m[3];
+	data[2] = (m[0] << 8) | m[1];
+}
+
+static void rtl8365mb_l2_data_to_mac(const u16 *data, u8 *m)
+{
+	m[5] = data[0] & 0xff;
+	m[4] = data[0] >> 8;
+	m[3] = data[1] & 0xff;
+	m[2] = data[1] >> 8;
+	m[1] = data[2] & 0xff;
+	m[0] = data[2] >> 8;
+}
+
+static void rtl8365mb_c_l2_data_to_uc(const u16 *data,
+				      struct rtl8365mb_l2_uc *uc)
 {
 	u32 val;
 
-	uc->key.mac_addr[5] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC5_MSK, data[0]);
-	uc->key.mac_addr[4] = FIELD_GET(RTL8365MB_L2_UC_D0_MAC4_MSK, data[0]);
-	uc->key.mac_addr[3] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC3_MSK, data[1]);
-	uc->key.mac_addr[2] = FIELD_GET(RTL8365MB_L2_UC_D1_MAC2_MSK, data[1]);
-	uc->key.mac_addr[1] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC1_MSK, data[2]);
-	uc->key.mac_addr[0] = FIELD_GET(RTL8365MB_L2_UC_D2_MAC0_MSK, data[2]);
+	rtl8365mb_l2_data_to_mac(data, uc->key.mac_addr);
 	uc->key.efid = FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MSK, data[4]);
 	uc->key.vid = FIELD_GET(RTL8365MB_L2_UC_D3_VID_MSK, data[3]);
 	uc->key.ivl = FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MSK, data[3]);
@@ -161,23 +162,13 @@ static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc)
 	uc->is_static = FIELD_GET(RTL8365MB_L2_UC_D5_STATIC_MSK, data[5]);
 }
 
-static void rtl8365mb_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc, u16 *data)
+static void rtl8365mb_c_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc,
+				      u16 *data)
 {
 	u32 val;
 
 	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
-	data[0] |=
-		FIELD_PREP(RTL8365MB_L2_UC_D0_MAC5_MSK, uc->key.mac_addr[5]);
-	data[0] |=
-		FIELD_PREP(RTL8365MB_L2_UC_D0_MAC4_MSK, uc->key.mac_addr[4]);
-	data[1] |=
-		FIELD_PREP(RTL8365MB_L2_UC_D1_MAC3_MSK, uc->key.mac_addr[3]);
-	data[1] |=
-		FIELD_PREP(RTL8365MB_L2_UC_D1_MAC2_MSK, uc->key.mac_addr[2]);
-	data[2] |=
-		FIELD_PREP(RTL8365MB_L2_UC_D2_MAC1_MSK, uc->key.mac_addr[1]);
-	data[2] |=
-		FIELD_PREP(RTL8365MB_L2_UC_D2_MAC0_MSK, uc->key.mac_addr[0]);
+	rtl8365mb_l2_mac_to_data(uc->key.mac_addr, data);
 	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_VID_MSK, uc->key.vid);
 	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_IVL_MSK, uc->key.ivl);
 
@@ -200,16 +191,12 @@ static void rtl8365mb_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc, u16 *data)
 	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_STATIC_MSK, uc->is_static);
 }
 
-static void rtl8365mb_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc)
+static void rtl8365mb_c_l2_data_to_mc(const u16 *data,
+				      struct rtl8365mb_l2_mc *mc)
 {
 	u32 val;
 
-	mc->key.mac_addr[5] = FIELD_GET(RTL8365MB_L2_MC_D0_MAC5_MSK, data[0]);
-	mc->key.mac_addr[4] = FIELD_GET(RTL8365MB_L2_MC_D0_MAC4_MSK, data[0]);
-	mc->key.mac_addr[3] = FIELD_GET(RTL8365MB_L2_MC_D1_MAC3_MSK, data[1]);
-	mc->key.mac_addr[2] = FIELD_GET(RTL8365MB_L2_MC_D1_MAC2_MSK, data[1]);
-	mc->key.mac_addr[1] = FIELD_GET(RTL8365MB_L2_MC_D2_MAC1_MSK, data[2]);
-	mc->key.mac_addr[0] = FIELD_GET(RTL8365MB_L2_MC_D2_MAC0_MSK, data[2]);
+	rtl8365mb_l2_data_to_mac(data, mc->key.mac_addr);
 	/* key.vid,key.fid shares the same memory space */
 	mc->key.vid = FIELD_GET(RTL8365MB_L2_MC_D3_VID_MSK, data[3]);
 	mc->key.ivl = FIELD_GET(RTL8365MB_L2_MC_D3_IVL_MSK, data[3]);
@@ -228,17 +215,13 @@ static void rtl8365mb_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc)
 	mc->igmp_asic = FIELD_GET(RTL8365MB_L2_MC_D5_IGMP_ASIC_MSK, data[5]);
 }
 
-static void rtl8365mb_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data)
+static void rtl8365mb_c_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc,
+				      u16 *data)
 {
 	u32 val;
 
 	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
-	data[0] |= FIELD_PREP(RTL8365MB_L2_MC_D0_MAC5_MSK, mc->key.mac_addr[5]);
-	data[0] |= FIELD_PREP(RTL8365MB_L2_MC_D0_MAC4_MSK, mc->key.mac_addr[4]);
-	data[1] |= FIELD_PREP(RTL8365MB_L2_MC_D1_MAC3_MSK, mc->key.mac_addr[3]);
-	data[1] |= FIELD_PREP(RTL8365MB_L2_MC_D1_MAC2_MSK, mc->key.mac_addr[2]);
-	data[2] |= FIELD_PREP(RTL8365MB_L2_MC_D2_MAC1_MSK, mc->key.mac_addr[1]);
-	data[2] |= FIELD_PREP(RTL8365MB_L2_MC_D2_MAC0_MSK, mc->key.mac_addr[0]);
+	rtl8365mb_l2_mac_to_data(mc->key.mac_addr, data);
 	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_D3_VID_MSK, mc->key.vid);
 	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_D3_IVL_MSK, mc->key.ivl);
 
@@ -258,6 +241,30 @@ static void rtl8365mb_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data)
 	data[5] |= FIELD_PREP(RTL8365MB_L2_MC_D5_MBR_HI2_MSK, val);
 }
 
+static void rtl8365mb_l2_data_to_uc(struct realtek_priv *priv, const u16 *data,
+				    struct rtl8365mb_l2_uc *uc)
+{
+	rtl8365mb_c_l2_data_to_uc(data, uc);
+}
+
+static void rtl8365mb_l2_uc_to_data(struct realtek_priv *priv,
+				    const struct rtl8365mb_l2_uc *uc, u16 *data)
+{
+	rtl8365mb_c_l2_uc_to_data(uc, data);
+}
+
+static void rtl8365mb_l2_data_to_mc(struct realtek_priv *priv, const u16 *data,
+				    struct rtl8365mb_l2_mc *mc)
+{
+	rtl8365mb_c_l2_data_to_mc(data, mc);
+}
+
+static void rtl8365mb_l2_mc_to_data(struct realtek_priv *priv,
+				    const struct rtl8365mb_l2_mc *mc, u16 *data)
+{
+	rtl8365mb_c_l2_mc_to_data(mc, data);
+}
+
 /*
  * rtl8365mb_l2_get_next_uc() - get the next Unicast L2 entry
  * @priv: realtek_priv pointer
@@ -293,7 +300,7 @@ int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, int port,
 	if (ret)
 		return ret;
 
-	rtl8365mb_l2_data_to_uc(data, &uc);
+	rtl8365mb_l2_data_to_uc(priv, data, &uc);
 
 	ether_addr_copy(entry->mac_addr, uc.key.mac_addr);
 	entry->vid = uc.key.vid;
@@ -326,7 +333,7 @@ int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
 	uc.is_static = true;
 	/* age greater than 0 adds/updates entries */
 	uc.age = 1;
-	rtl8365mb_l2_uc_to_data(&uc, data);
+	rtl8365mb_l2_uc_to_data(priv, &uc, data);
 
 	/* add the new entry or update an existing one */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
@@ -358,7 +365,7 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
 	uc.key.vid = vid;
 	/* age 0 deletes the entry */
 	uc.age = 0;
-	rtl8365mb_l2_uc_to_data(&uc, data);
+	rtl8365mb_l2_uc_to_data(priv, &uc, data);
 
 	/* it looks like the switch will always add/update the entry,
 	 * even when age is 0 or uc.key did not match an existing entry,
@@ -463,7 +470,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 	 */
 	mc.member |= BIT(port);
 	mc.is_static = 1;
-	rtl8365mb_l2_mc_to_data(&mc, data);
+	rtl8365mb_l2_mc_to_data(priv, &mc, data);
 
 	/* First look for an existing entry (to get existing port members) */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
@@ -472,7 +479,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 				    data, RTL8365MB_L2_ENTRY_SIZE);
 	if (!ret) {
 		/* There is already an entry... */
-		rtl8365mb_l2_data_to_mc(data, &mc);
+		rtl8365mb_l2_data_to_mc(priv, data, &mc);
 		dev_dbg(priv->dev,
 			"%s: found %pM addr=%d member=0x%x igmpidx=0x%x %s\n",
 			__func__, mac_addr, addr, mc.member, mc.igmpidx,
@@ -487,7 +494,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 			mc.is_static = 1;
 		}
 
-		rtl8365mb_l2_mc_to_data(&mc, data);
+		rtl8365mb_l2_mc_to_data(priv, &mc, data);
 	} else if (ret == -ENOENT) {
 		/* New entry, no need to update data again as it already
 		 * includes the member.
@@ -529,7 +536,7 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
 	mc.key.vid = vid;
 	mc.key.ivl = true;
-	rtl8365mb_l2_mc_to_data(&mc, data);
+	rtl8365mb_l2_mc_to_data(priv, &mc, data);
 
 	/* First look for an existing entry (to get existing port members) */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
@@ -547,7 +554,7 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 		/* Return on any other error */
 		return ret;
 
-	rtl8365mb_l2_data_to_mc(data, &mc);
+	rtl8365mb_l2_data_to_mc(priv, data, &mc);
 	dev_dbg(priv->dev,
 		"%s: found %pM addr=%d member=0x%x igmpidx=0x%x %s\n",
 		__func__, mac_addr, addr, mc.member, mc.igmpidx,
@@ -565,7 +572,7 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 		mc.fwd_pri = 0;
 		mc.igmp_asic = 0;
 	}
-	rtl8365mb_l2_mc_to_data(&mc, data);
+	rtl8365mb_l2_mc_to_data(priv, &mc, data);
 
 	/* update the existing entry. */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
-- 
2.53.0

