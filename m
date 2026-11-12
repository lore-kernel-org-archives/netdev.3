Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.187.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505215;
	b=GPeluzuj7jmntKK9ndyad7KDog0fMk6OWj5TrZc6pDai3gFeTZYYeRbejhKZxt+AauwB
	 FGHisqGmNCPcbaxzySuBmrLDKslTJFORg6RsXa7v4IPoFDHCkTOFplLqt5dm7JjryG5dC
	 /Y42Pq1vFFLD2qp5X9Q0nINZFbueZmjC1bZbhfAYpP5TgCk43XrB9EXbNzvpMgaXd8drX
	 HK1hrnUohJwCRx4HozUjzUVasseI+7PhX5iietAplMDrLKSylQT86aRNsgtteyt0VX8ML
	 TlyYF7E/skXbcpHTIAEDrkaSofxQl8RKsp+w54iRtyhM1j/JCeP9vuwuTEPp1gDiu9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505215;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=uABMJc3UAX9eMuNm2tEdNudbSNYpxLyPxhA6SaxTHi0=;
	b=cGwcXpPK/VwcTWR2que8YhnTfAKwVjFs+P6haXM8kS2w9CRhtFvEFIzNeMaTlZv1Cy9Z
	 m7U0ihZad3yhbdDuM+zmMF1iYGLy5xBbqRzJgWaJ9VEU1/6Lk5o3+l718ieSKoYpfUXiw
	 ZcT/fB2MPnZ5h1gEWOpLjuA0X4U6b//cWDy34gHBmDJPefIE/T8SvMiQ4rvOhDnyv9N60
	 Ut8Z0F6/xWWMdLLN1blMqXiR1QhP4oc4kamifbGSQsrr9J3DtTLRslZA3+nUt8vNpZsvl
	 Milk9TmyRlCitfQV4wWGC5wbfcHoRMLcubIhp3fZ8qnvOzX13ISUWfVS7GV6LJBRKOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Jb29Qjmc;
	arc=none smtp.remote-ip=66.163.187.32
Received: from sonic308-9.consmr.mail.ne1.yahoo.com (sonic308-9.consmr.mail.ne1.yahoo.com [66.163.187.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F35606C365
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11F35606C365
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Jb29Qjmc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505214; bh=uABMJc3UAX9eMuNm2tEdNudbSNYpxLyPxhA6SaxTHi0=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=Jb29Qjmc9m1smdjbEOwYZTNzwp5y0j8NVaExqBDET+IKR2mHsyvlBeGw8JqSlPQMAFL/CCyuoYyX639S8vMnCXOBzYljhjJt7qYawSnNyB9Qp+3fVTJz+l2e2rVBl+sTELkX77too17Qu8j/GbLBH9ig7KV1B9Q0B0EvF1BwaP2AHfhF6nvHdWXfdVdO4/aVaXrZJ4fv2dDulk4lvHYeXpL5c8BXoy2ZIk4yOTpzZRrEqeTuC594ye4L4NuNaGmTiyOWHMvR1c5/afGssSutR2FbOnCjMQwCBVGV3LWwX/t4sHJhD6fwmTUmgs4Kh5Hh9CbZ2frG8uIZ1uP7LMgypw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505214; bh=dNpQf2pH2pZVjshZMFFYrcmldE3p9uL2TNfPkt5ai0q=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=e+3XWXt9n082TDlA1LbMOexYYw/+8hb8VFJtEqD+hr+B4TeTwPfk9fNxaHoH91uCp0k27bgqGHkaNtJbx9e4fbTsfmI1a5EmBX4GP4p8jKjk2Y+eD2nZR4IduSBl4fPpMSdoWGPAQCKexxWGf60xDhE+UJ+eOjBrmojP/8lIwxARslOP/vDVwwxzdfdddTofIXz1Ci0ueKgDAb6Tgx+oKHN9094WdbDKUUM/DXXxUbixJOnq4mAWfRXbV4aY8zYMAnKhpVFgYkMwUWpMZ83V8P/AOMBxgizzhlitAy7rDmMBUcRY4590OdaJ2AGbcaIeFuvu8TX9H8oSL6exxxKOPA==
X-YMail-OSG: AS.oCZUVM1nqyqmZrtKhX5v_KrW74sdEtJNX9BvbY2kGs1zStNzztzEcoockLAK
 pJ4t2ITTz2rwFk_FkHNMmMM75Jy9TKGsqoN4w9aZ4PEEUDIwr2eYo2t1L5yVtBJ55VfOqYpTio_O
 xYyCPL4QEWrAVk7cWbhrBk3AsYiXlN2J09xdsgMTWB17GaL5yQs4YuLk4p1JvGHZYShMVUWZP2eg
 W2KK3BX0Nbb.bwg0tFwUdMbXeUTAOglagUaT03gyDPUA2wV0bTal2f7vKQSCj8sC275O4hnjyxtg
 XR_C00iu81cK_pqBTN.dzqvZxrTGy6LloKzPHQavbuhGQmdiKWOVRWhK8d33JoxbscRoLy1W1jwS
 2aAeeFQ7wIh40T9x2hy3BYXFTg2cI6c0dpmJV0Xb_A1xBR0MLgjB3FQj56cymyR_ImEwuiIIuNRo
 FOcBys3_6JKHfX9oraALQGiQAwK4s0n7R5ojZxVk9x8aRHp46P64GnsiEBtkcej2o6N3ZI_7ZFWM
 Ny2HuXO_Db7ejt6kX298C8VjLeEeTSiDPDltgDCOcQ2tNs4lBfprBIkIGFO0NCkY9Lh.1HjXyU8I
 RklRl7.wHcqc8D5.h52kFsjc8MkuEUkFzgNtWMPb_5B665RdlJG8qWv6H.aDq1lvx5G_K6UT5.4V
 szKyjsCNBJT.tTsrEotmTExLsu2TtNX5EftV_swY4iLkkn8gDZCEv9qZOGxfbbBL9S0CiiztUZgT
 N20S6moqUWb.DK_tvMb8l83rZZzn65NIM3kV5D6fe63JTMQglyxKYelTW5RAxmZjfIRhMSlrC.wu
 txIq_.K.YCDgsj7GBDAeFn2WODlYaRlPjfPGnGAY2EpfhUbc3Ks_PmkX_OAEBF.XtxCa1a8IpptC
 gnIRkyxyKpXpQMJPnFSIdC.S1OaozyfoC1kB6VviQa.LtzIzHAxHBtJYpT_cDrPGx3OfYLy9aTQY
 EE4mfXS1Wyp82mJ4DebuJUiGYSt6_xeGu43o3.DP8OdLT96w8ouRdTFY6nOGQWPj6qeSQcE9gGd.
 fBcDtcqeXgdIwCcSo.Ik03OyPc6G6ctTQxZ6iPfNVCkt_H7j4KTb.S2MkViJzeyji2pD_wQTdgSP
 OvJIuPkkQLKJZO9LM.gg6.SS7mT5duXpnxwAre9YcfKQsAv_UPChVPcT7D2yNuSTkxZsS0i5xgqS
 VXAUcBXAM_bMWtscUuxS0wmR5myB5X1vivIS.3VyZaLXMQ2W6st_1Sdv3wTF27idH7tyimkeqFOY
 cca1dmOoJkuT2TamIsqmVj4DlBllAys8HrJReVqIGR8EqRZa_LRxhS_jQvN1k5eQIRbSAOtxUg22
 B3F1NXj7EesCUln5.hJc0Ukk9GrNAWo5yVE8MNvqJD4EIhc_033lxjBqnw.g58iOng0G_zHb79xg
 tky9MBz4Z1Mp5As6MNo1zCQEcZJQKlZpmaU3Uj1VUIYq9SDK6KTPoZRqURiRI9MVfGYGrzJr9Jmn
 HYecZjqTg1KxYLM9ikyLTFJR.xpacjPsGpNMorBmJJZKeKvBu0YrPjK1nmUDDq4sevNbVJ2ftYVT
 XWZAZXbUO3Dk_HwHBO3gt0SRWq5Z6KgckhSGtssuIEkpzIH1X3MLOATUrhJXz3DPoUoEOQAArVe7
 F_GiOb.wLkVfzUEZjyBtB6HEpadZGPWWS4W.xxkvXdefL6QY0jtg_C3IHTcgaMkWEppJfqiKAQKS
 5yhrQ9mXpBSBc9cvlg71fretvfvCE7c1v2sVgiaElqrBbhFeMEWe7wJba86D8U.abB8lJkaV0M3m
 ngus6UPAE_QPp87FT0zjwfaiep0lsyb7_Xh2Cet7nU9YPVKTbUs0Ij9qV4zQPnPvdnOekWLJdImE
 Q.ADos.ATKVN772hD61x.B.p_wldS8rYdNGpxMAoUD2frAbw5XOMfUgoc0J9sJB5JdrD_3V9AsE1
 2lBeGqkFL8UrbDIEB7Ej0W0Khk4RSLN.9.lOBJ25aG8hNm7elmfzacMsUIsfV2WwPm7WBFudF.u8
 fwkZDRxzV33vVnbq8umX3kw8LcFDw1sVm9.10ewB.OPSWB8B9vUaQFLOTNvcmaKOuF8UFoIS6RxF
 v_Ag.4oDP0FmMUKAxUn7VkqFTRuPhmmOunejVuElxofXjXy1Ee8mtiTRNNRuuzitZVWgmMDghD16
 9sOYSJRPnVmKh2pkleXTHwmzl5KBQkOXEmlW1ebN2xMBc5sD_NnHB5QJ5MBFZXJLahZlY1UC1DT0
 TZJ9xliHj1SNw8q0VucwsK_8ExzqjQNn9XUYkIiH37qYs8L1d1CZZ8vJv8QTYFpdrLYqUuHI7OSq
 pLr1Yxn7kZM4tTp2duvwc1gBgtS1vXZWzwMi2v40MH41OTWio180-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 5591e028-dc67-4300-a236-509c4bdacad0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:40:14 +0000
Received: by hermes--production-ir2-5dd9bf4598-nf4w7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ba000756083527cbefbd251de16e4836;
          Thu, 12 Nov 2026 17:40:11 +0000 (UTC)
Message-ID: <9b7b42be-6cc5-467f-bd01-62ab74de3523@yahoo.com>
Date: Thu, 12 Nov 2026 18:40:09 +0100
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
Subject: [PATCH net-next v10 10/12] net: dsa: realtek: rtl8365mb: refactor L2
 MAC handling
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

Add L2 MAC pack/unpack helpers and use them in the family C
serializers instead of open-coding the byte packing, since the layout
of the MAC address words is the same for both families. The now unused
per-field MAC masks are dropped.

Rename the family C serializers to rtl8365mb_c_l2_*(), export them and
reach them through function pointers in struct rtl8365mb_family_info,
so that a following patch can add the family D layout without touching
the family C code again.

No functional change.

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Tested-by: Stanislaw Pal <kuncy7@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb.h      |   7 ++
 drivers/net/dsa/realtek/rtl8365mb_l2.c   | 125 +++++++++++------------
 drivers/net/dsa/realtek/rtl8365mb_l2.h   |  12 +++
 drivers/net/dsa/realtek/rtl8365mb_main.c |   5 +
 4 files changed, 83 insertions(+), 66 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.h b/drivers/net/dsa/realtek/rtl8365mb.h
index d3d5fb3..244e896 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.h
+++ b/drivers/net/dsa/realtek/rtl8365mb.h
@@ -11,6 +11,8 @@ enum rtl8365mb_family {
 
 struct rtl8365mb_jam_tbl_entry;
 struct rtl8365mb_vlan4k;
+struct rtl8365mb_l2_uc;
+struct rtl8365mb_l2_mc;
 
 struct rtl8365mb_family_info {
 	enum rtl8365mb_family family;
@@ -24,6 +26,11 @@ struct rtl8365mb_family_info {
 			    struct rtl8365mb_vlan4k *vlan4k);
 	int (*vlan_4k_write)(struct realtek_priv *priv,
 			     const struct rtl8365mb_vlan4k *vlan4k);
+	size_t l2_entry_size;
+	void (*l2_data_to_uc)(const u16 *data, struct rtl8365mb_l2_uc *uc);
+	void (*l2_uc_to_data)(const struct rtl8365mb_l2_uc *uc, u16 *data);
+	void (*l2_data_to_mc)(const u16 *data, struct rtl8365mb_l2_mc *mc);
+	void (*l2_mc_to_data)(const struct rtl8365mb_l2_mc *mc, u16 *data);
 };
 
 const struct rtl8365mb_family_info *
diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.c b/drivers/net/dsa/realtek/rtl8365mb_l2.c
index 0494d8a..cd5b333 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_l2.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.c
@@ -6,18 +6,11 @@
 
 #include <linux/etherdevice.h>
 
+#include "rtl8365mb.h"
 #include "rtl8365mb_l2.h"
 #include "rtl8365mb_table.h"
 #include <linux/regmap.h>
 
-#define RTL8365MB_L2_ENTRY_SIZE			6
-
-#define RTL8365MB_L2_UC_D0_MAC5_MSK		GENMASK(7, 0)
-#define RTL8365MB_L2_UC_D0_MAC4_MSK		GENMASK(15, 8)
-#define RTL8365MB_L2_UC_D1_MAC3_MSK		GENMASK(7, 0)
-#define RTL8365MB_L2_UC_D1_MAC2_MSK		GENMASK(15, 8)
-#define RTL8365MB_L2_UC_D2_MAC1_MSK		GENMASK(7, 0)
-#define RTL8365MB_L2_UC_D2_MAC0_MSK		GENMASK(15, 8)
 #define RTL8365MB_L2_UC_D3_VID_MSK		GENMASK(11, 0)
 #define RTL8365MB_L2_UC_D3_IVL_MSK		GENMASK(13, 13)
 #define RTL8365MB_L2_UC_D3_PORT_EXT_MSK	GENMASK(15, 15)
@@ -36,12 +29,6 @@
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
@@ -131,16 +118,29 @@ struct rtl8365mb_l2_mc {
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
+void rtl8365mb_c_l2_data_to_uc(const u16 *data,
+			       struct rtl8365mb_l2_uc *uc)
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
@@ -161,23 +161,13 @@ static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc)
 	uc->is_static = FIELD_GET(RTL8365MB_L2_UC_D5_STATIC_MSK, data[5]);
 }
 
-static void rtl8365mb_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc, u16 *data)
+void rtl8365mb_c_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc,
+			       u16 *data)
 {
 	u32 val;
 
-	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
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
+	memset(data, 0, RTL8365MB_C_L2_ENTRY_SIZE * 2);
+	rtl8365mb_l2_mac_to_data(uc->key.mac_addr, data);
 	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_VID_MSK, uc->key.vid);
 	data[3] |= FIELD_PREP(RTL8365MB_L2_UC_D3_IVL_MSK, uc->key.ivl);
 
@@ -200,16 +190,12 @@ static void rtl8365mb_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc, u16 *data)
 	data[5] |= FIELD_PREP(RTL8365MB_L2_UC_D5_STATIC_MSK, uc->is_static);
 }
 
-static void rtl8365mb_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc)
+void rtl8365mb_c_l2_data_to_mc(const u16 *data,
+			       struct rtl8365mb_l2_mc *mc)
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
@@ -228,17 +214,13 @@ static void rtl8365mb_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc)
 	mc->igmp_asic = FIELD_GET(RTL8365MB_L2_MC_D5_IGMP_ASIC_MSK, data[5]);
 }
 
-static void rtl8365mb_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data)
+void rtl8365mb_c_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc,
+			       u16 *data)
 {
 	u32 val;
 
-	memset(data, 0, RTL8365MB_L2_ENTRY_SIZE * 2);
-	data[0] |= FIELD_PREP(RTL8365MB_L2_MC_D0_MAC5_MSK, mc->key.mac_addr[5]);
-	data[0] |= FIELD_PREP(RTL8365MB_L2_MC_D0_MAC4_MSK, mc->key.mac_addr[4]);
-	data[1] |= FIELD_PREP(RTL8365MB_L2_MC_D1_MAC3_MSK, mc->key.mac_addr[3]);
-	data[1] |= FIELD_PREP(RTL8365MB_L2_MC_D1_MAC2_MSK, mc->key.mac_addr[2]);
-	data[2] |= FIELD_PREP(RTL8365MB_L2_MC_D2_MAC1_MSK, mc->key.mac_addr[1]);
-	data[2] |= FIELD_PREP(RTL8365MB_L2_MC_D2_MAC0_MSK, mc->key.mac_addr[0]);
+	memset(data, 0, RTL8365MB_C_L2_ENTRY_SIZE * 2);
+	rtl8365mb_l2_mac_to_data(mc->key.mac_addr, data);
 	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_D3_VID_MSK, mc->key.vid);
 	data[3] |= FIELD_PREP(RTL8365MB_L2_MC_D3_IVL_MSK, mc->key.ivl);
 
@@ -283,17 +265,20 @@ int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, int port,
 			     struct realtek_fdb_entry *entry)
 {
 	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	const struct rtl8365mb_family_info *fi;
 	struct rtl8365mb_l2_uc uc;
 	int ret;
 
+	fi = rtl8365mb_get_family_info(priv);
+
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_READ, addr,
 				    RTL8365MB_TABLE_L2_METHOD_ADDR_NEXT_UC_PORT,
-				    port, data, RTL8365MB_L2_ENTRY_SIZE);
+				    port, data, fi->l2_entry_size);
 	if (ret)
 		return ret;
 
-	rtl8365mb_l2_data_to_uc(data, &uc);
+	fi->l2_data_to_uc(data, &uc);
 
 	ether_addr_copy(entry->mac_addr, uc.key.mac_addr);
 	entry->vid = uc.key.vid;
@@ -307,6 +292,7 @@ int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
 			u16 efid, u16 vid)
 {
 	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	const struct rtl8365mb_family_info *fi;
 	struct rtl8365mb_l2_uc uc = { 0 };
 	u16 addr;
 	int ret;
@@ -326,13 +312,14 @@ int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
 	uc.is_static = true;
 	/* age greater than 0 adds/updates entries */
 	uc.age = 1;
-	rtl8365mb_l2_uc_to_data(&uc, data);
+	fi = rtl8365mb_get_family_info(priv);
+	fi->l2_uc_to_data(&uc, data);
 
 	/* add the new entry or update an existing one */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, fi->l2_entry_size);
 
 	/* Assume the missing new entry as the table is full */
 	if (ret == -ENOENT)
@@ -347,6 +334,7 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
 			u16 efid, u16 vid)
 {
 	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	const struct rtl8365mb_family_info *fi;
 	struct rtl8365mb_l2_uc uc = { 0 };
 	u16 addr;
 	int ret;
@@ -358,7 +346,8 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
 	uc.key.vid = vid;
 	/* age 0 deletes the entry */
 	uc.age = 0;
-	rtl8365mb_l2_uc_to_data(&uc, data);
+	fi = rtl8365mb_get_family_info(priv);
+	fi->l2_uc_to_data(&uc, data);
 
 	/* it looks like the switch will always add/update the entry,
 	 * even when age is 0 or uc.key did not match an existing entry,
@@ -368,7 +357,7 @@ int rtl8365mb_l2_del_uc(struct realtek_priv *priv, int port,
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, fi->l2_entry_size);
 
 	if (ret == -ENOENT) {
 		dev_dbg(priv->dev, "%s: %pM vid=%d efid=%d missing\n",
@@ -451,6 +440,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 			u16 vid)
 {
 	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	const struct rtl8365mb_family_info *fi;
 	struct rtl8365mb_l2_mc mc = { 0 };
 	u16 addr;
 	int ret;
@@ -463,16 +453,17 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 	 */
 	mc.member |= BIT(port);
 	mc.is_static = 1;
-	rtl8365mb_l2_mc_to_data(&mc, data);
+	fi = rtl8365mb_get_family_info(priv);
+	fi->l2_mc_to_data(&mc, data);
 
 	/* First look for an existing entry (to get existing port members) */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_READ, &addr,
 				    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, fi->l2_entry_size);
 	if (!ret) {
 		/* There is already an entry... */
-		rtl8365mb_l2_data_to_mc(data, &mc);
+		fi->l2_data_to_mc(data, &mc);
 		dev_dbg(priv->dev,
 			"%s: found %pM addr=%d member=0x%x igmpidx=0x%x %s\n",
 			__func__, mac_addr, addr, mc.member, mc.igmpidx,
@@ -487,7 +478,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 			mc.is_static = 1;
 		}
 
-		rtl8365mb_l2_mc_to_data(&mc, data);
+		fi->l2_mc_to_data(&mc, data);
 	} else if (ret == -ENOENT) {
 		/* New entry, no need to update data again as it already
 		 * includes the member.
@@ -508,7 +499,7 @@ int rtl8365mb_l2_add_mc(struct realtek_priv *priv, int port,
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, fi->l2_entry_size);
 
 	/* Assume the missing new entry as the table is full */
 	if (ret == -ENOENT)
@@ -522,6 +513,7 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 			u16 vid)
 {
 	u16 data[RTL8365MB_L2_ENTRY_SIZE] = { 0 };
+	const struct rtl8365mb_family_info *fi;
 	struct rtl8365mb_l2_mc mc = { 0 };
 	u16 addr;
 	int ret;
@@ -529,13 +521,14 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
 	mc.key.vid = vid;
 	mc.key.ivl = true;
-	rtl8365mb_l2_mc_to_data(&mc, data);
+	fi = rtl8365mb_get_family_info(priv);
+	fi->l2_mc_to_data(&mc, data);
 
 	/* First look for an existing entry (to get existing port members) */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_READ, &addr,
 				    RTL8365MB_TABLE_L2_METHOD_MAC, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, fi->l2_entry_size);
 	if (ret == -ENOENT) {
 		dev_dbg(priv->dev, "%s: %pM vid=%d missing\n",
 			__func__, mac_addr, vid);
@@ -547,7 +540,7 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 		/* Return on any other error */
 		return ret;
 
-	rtl8365mb_l2_data_to_mc(data, &mc);
+	fi->l2_data_to_mc(data, &mc);
 	dev_dbg(priv->dev,
 		"%s: found %pM addr=%d member=0x%x igmpidx=0x%x %s\n",
 		__func__, mac_addr, addr, mc.member, mc.igmpidx,
@@ -565,12 +558,12 @@ int rtl8365mb_l2_del_mc(struct realtek_priv *priv, int port,
 		mc.fwd_pri = 0;
 		mc.igmp_asic = 0;
 	}
-	rtl8365mb_l2_mc_to_data(&mc, data);
+	fi->l2_mc_to_data(&mc, data);
 
 	/* update the existing entry. */
 	ret = rtl8365mb_table_query(priv, RTL8365MB_TABLE_L2,
 				    RTL8365MB_TABLE_OP_WRITE, &addr,
 				    0, 0,
-				    data, RTL8365MB_L2_ENTRY_SIZE);
+				    data, fi->l2_entry_size);
 	return ret;
 }
diff --git a/drivers/net/dsa/realtek/rtl8365mb_l2.h b/drivers/net/dsa/realtek/rtl8365mb_l2.h
index 9470cf0..a9f9ae4 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_l2.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_l2.h
@@ -12,6 +12,18 @@
 
 #include "realtek.h"
 
+#define RTL8365MB_C_L2_ENTRY_SIZE		6
+/* Highest L2 entry size of any supported chip, used for sizing */
+#define RTL8365MB_L2_ENTRY_SIZE			RTL8365MB_C_L2_ENTRY_SIZE
+
+struct rtl8365mb_l2_uc;
+struct rtl8365mb_l2_mc;
+
+void rtl8365mb_c_l2_data_to_uc(const u16 *data, struct rtl8365mb_l2_uc *uc);
+void rtl8365mb_c_l2_uc_to_data(const struct rtl8365mb_l2_uc *uc, u16 *data);
+void rtl8365mb_c_l2_data_to_mc(const u16 *data, struct rtl8365mb_l2_mc *mc);
+void rtl8365mb_c_l2_mc_to_data(const struct rtl8365mb_l2_mc *mc, u16 *data);
+
 int rtl8365mb_l2_get_next_uc(struct realtek_priv *priv, u16 *addr, int port,
 			     struct realtek_fdb_entry *entry);
 int rtl8365mb_l2_add_uc(struct realtek_priv *priv, int port,
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 6f9c12f..525588e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -793,6 +793,11 @@ static const struct rtl8365mb_family_info rtl8365mb_family_c = {
 	.ext_config_forcemode = rtl8365mb_c_ext_config_forcemode,
 	.vlan_4k_read = rtl8365mb_c_vlan_4k_read,
 	.vlan_4k_write = rtl8365mb_c_vlan_4k_write,
+	.l2_entry_size = RTL8365MB_C_L2_ENTRY_SIZE,
+	.l2_data_to_uc = rtl8365mb_c_l2_data_to_uc,
+	.l2_uc_to_data = rtl8365mb_c_l2_uc_to_data,
+	.l2_data_to_mc = rtl8365mb_c_l2_data_to_mc,
+	.l2_mc_to_data = rtl8365mb_c_l2_mc_to_data,
 };
 
 /**
-- 
2.53.0

