Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.186.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630252;
	b=mIpKeFxJQIqNlTzK5hn2mMM/teRw/Yjfd5OcfndZjgVxA4t+Vn+n0rBb/x606ua9E83m
	 dJMb9h3f1/EUaxjgx1Xo41HiSD06v1U1IMgAAI5OUn+ypGOiuF25zeiwyViBSGEmy+HUS
	 2C2m+YeKfsgh3oiKJzRfpT0ZxlyxlI22yM3ukRrDg/cEOK3I4p0+OGnhaoqwyWInWW8by
	 1BaWISiVyWa5CX9qDhRoMIevNni47NyMD8+PoY7uHI6MNiGKAJObOR5KJW/bS7xeSgp2u
	 w1K1NvffKjM+8xDGSMDYXmcKOOJTSoXNDDvsACwNJq3J02cA+BmNBw1fLuCKZf6leyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630252;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=fsVj3hxzeirRIgZE+RZYsaZz4/Dc/lZVagD386cTX60=;
	b=ruNpnxawclxUbWcsrjTUPx3M3XqU10A7wr9KoU+M+XpExHdZzT96verIvMc3f9oPvMhp
	 mvsCyFAMJ4ilRZBTPG8vz5ZlU35Ld9RTHRVvN0WbEJA2ukUqO/onnFB/fL6ymzGP9j0n+
	 Lq/oSlVfRM8kNsaWtTdwWmM+1m/VDUbIPLTF+RQASmoUDGYWSNH4gOvr/VqGnj0mYrwvS
	 bKkKaPi6e3hnDWXZjioPN8rBnaL6QVuJ2xMkn3fF55wXZ2Wzf+xtnzsMrhoS76wyQlOdw
	 8N1hw1qyolTJkkFVM59VfElv6v3AQl5cHv4rHpUe75o1YW+SbnypO1LWoYhY/Wsf3Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=fXWyI2a9;
	arc=none smtp.remote-ip=66.163.186.147
Received: from sonic302-21.consmr.mail.ne1.yahoo.com (sonic302-21.consmr.mail.ne1.yahoo.com [66.163.186.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A10606E03B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A10606E03B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=fXWyI2a9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630251; bh=fsVj3hxzeirRIgZE+RZYsaZz4/Dc/lZVagD386cTX60=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=fXWyI2a9h8qNwLYysyO2mYR/W5TWGvcStkxPYw9xiXoGJBrOiCwlVpkBQCzLuT8Yh2acsvErOonptIrO4lqjqByEeMPVxtaEahW6iNagUJuvm3VEzhLzRWBzSEJ1dKpI1FTT4AybXi95/Z9D8p5tfPcFLyyqXcKkPioX6zRbhujUw1xRySmYwUu3K66lwXD0onTRwT2rA9Ah2EMss7womuhzQHmNTrQpza3rsF44E6aAHFNUewUTgThHM87yCO/RYIxwMLB+Hs/da6zJuCBQ1Z9C0NR9W9KaSonc/KObdXTmmW01ImoAJQ9mx4T1iwWNNC4tLPf+PBNUeI5Mq3kotA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630251; bh=rcWvC5iRD40rp62F2XaD+DxMpp3BqmAH48tCiHXuDd7=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=f0hku8tyMptUKOOMToUQxj1xQyYh1IHy0bSij31+f6s614j1/cU37TNWysesn0Q1yPgktcMo3B/Z/4Z2FGO+Rj3+eV/BjJFkMXS42/cLurmJVlMZE3O9xuJaLmyQTn9BEVw2fJnRfxmezNF6KG6nTfiBBV0Ks2kJlZOPHggFIWZl07XSdMApZumxyLZ+FaLqYnxy5kRxGY2bfYTCdRvRu9AEvobK5pUeweI2JN49P6Rk+hbpmSFCzlTIBvOX8Wq+9XCt9wuAxKTfuXElZywt/FtG1kKZZGdXTWI5xKrVYr+i6i5JA+nG3GRBIQCuIIvgOli8tAjFxhww5NFmbiAW+A==
X-YMail-OSG: 7tpMgVMVM1lWoKzyE7tSffxhqXnIACVoNRk4MC8dT9cvBAYfPkIWSU.ToQSPdKg
 NdJ9ySUux1oIayGvDdlDTuTwrLCOagg7BnmdU8C8gXQFxaEmyEAUZNl7vOPoB3Wu66VueVhSufws
 Q1zlCZfyRAwYXVfFFqS944agsxot2Bmhhsr.GrAw7coHaJ4IN6k6VkxLzl0E5HEuRGQ60Twk0Zx9
 2Qlc4.rC9Tn6g2UELYgCrHo2L1OzB3CvGQtfz_vsz25LzoFEltEovrcMBJgvi6k8oAL_.P5M3cqM
 DzyKgUp.t0qn2XKXeaHniLXfCnSLbUtQMZx5.jyhfDKVbQlgrycBf6gEA2MsdeoqI6eKgOYa74hx
 wO1MyXgosi8xh_WMuTR.hj_HnhLYwfKaew_JKuGKscybWr5YzyQiqMn.Y3ERiDBEt8pRZilY5bCS
 28GZcU2Tt2173XInFE5N7KyXuLcW37puP7_9o_NoSSBuFgLTwWgTugHP26k9eIHscL1RiLJiK2dr
 Lk.KN7MbOvtZ5PGIfbYbKtTUuHOku1e3pABzTQSj1Ewn18ilkdsPy9WqPvMRpRh9Z6iU2hsSn9_k
 rsW1YSdKsM0r63mXyQsAKR38xirhrgcKNQiBg2o86_bDMSnbVG_a1YrrTHL3MnLbmnBnNhaJP3zu
 wleLbT2GODo24tENnjoE.0tlytgevmmkluh.TJiAp3BCiWbBTg6XsjAYwTM9iLFMmb5d9GdpaakT
 ZOmSq4GQTFlj8GsHrod695tojQsWidSjBlbamI_t5aKWqBQoEkSWOMbZVmFlgIlQg5n6zknzwqwE
 aB_KeGNQuINUwJjqu4msmJ7HDzEhCvdPGZdVMkAzDxEGeHyZLm34_vxEZpHquA4Dsm6wyqQ.d9u0
 .7Dg0c6yaIo50W6Cp0O6j8LRgNUDC0Ivcf5gL.VceywwfaiUvoDTfurgA3nhA1d9ysDz_V9.sZPG
 GX9gehHinOAg9uAZWnj6JLAV1NtkADAwEjUtiBHQq68alnicgpJ4KbjCA1ChhvkdPrnnWdlvqsji
 HmBlS5cJlzLO_OwcE3ExJzma76KH7X2PZusm9r.39e.QhyPPCqj4X71Zu5AJwdrIELopf_8BxCGj
 CgpP0vqlMOKeZ_aOW_DVbhHgQ0dMusBzknWy.a1CcUkPdBxP2jm3KxdxWm9HK.hKeRl7.vhGxy_R
 PQd8ViswLpCo.4APdmPiZQ332KlesUjDufJN7BR_7XQQScX1ZJTDaPYdU.gSUvvt31Ai1im5mOa.
 u4Fbk1X1dmm3gRAV4c4IMbVDy6IWarQdyvcrK9e9HmQ8wtT6cHcDl47kejTpDb_Z6uuMo_SvCAs9
 GEwt4JoU3oPJenog4xq4ZIMkSM1x7WLKty3gTDRL0u8yPEk8s5qZUUV0mY1HQZPOPLYqNEtaJQxY
 gmBQzkQrLHmnp897jYAHB1XEGdpr_zkS00c78dDpzmTj.fe5O8kcn6DsDxuqr0zcfiTiVv0VXTLK
 ecvorSyBLBw2OAoimymtmJt0eiLt1x7.qB4arXu2QEwN.RAvhM35bJYzIRa0x1vgLBb7HLJMXNIx
 KE_vaIOl2xdD7k26TjfUN4_qdQmILQhzzpYNGJVkwtMx1WwvKZ1XPdgs7SVuuZ2ijlBDBkR0p9oR
 q.A9YQpoQG13YtC1RswTJLPFEeGmiB0o2iDTtqZh9js_4NhgNp024ikw6U0PcSQDr5.YMWjJyomm
 7RYf30SDmpp0dPGd1qJ9JJS3wL8QDcQl3roPQComyeK9oJh9asnWa84Gm4oQ9S1oFSDlJ6MAssrN
 box0dndpOfjMlMdMXwhaSYpatDBo3ZS.tKK9LJjyAiDvmvG.jL6NAi4cmQR0EXcMox644ivNH497
 2_sJ4KDS4cmBP4CMXAUZYO5ocniwtP0d7cs7wvZJTrztrNxzfeVD1rcFNU7mtNNE3cynIM8_Sfht
 lc0Cegult9kwS_zsstWOxSEGe5j0DOa_G9qrR5ixBaI2IbEEFmjlZNQIjjp6wbE.BrI_y6yrh3ht
 xNNs6aNtjU27qmxTQJeBfsbIR3zhvaKivWJ9fOZfhFiPJw1xYa4o5yxMvy2xe1qkCpx4Ie_WRuD7
 9zKNZERpHZosBpk59e3sICOa_.nt6YlzgVm4oGQGmCsw57OH08zWvTb_YvvH6MqBagaRh5mcr5eN
 vS2X474CfrEBimleva3VPrsZXaJ70xU0QhtXkDto8lfpXvnzEe00dOvmynKDU2xjJBckwLKmvAu.
 jrC5sZtGNaQc9Yqf8mYVHatbVf17kbNAIKUR48TOiwxp2siS_Tou060JOLn5c7DczpclBxu9qtUQ
 pxfqkWBu5JKcta8QUEN67cs5HIh5D_fjKprrqJx0-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e44086b1-f3f2-4c3e-9b04-b668cc2e3524
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2026 14:37:31 +0000
Received: by hermes--production-ir2-5dd9bf4598-ck52d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f616fcefc6d1d6b60b4320b13af0f986;
          Mon, 02 Nov 2026 14:37:28 +0000 (UTC)
Message-ID: <dab43e48-182e-4b6d-93d9-919f6a7b6902@yahoo.com>
Date: Mon, 2 Nov 2026 15:37:26 +0100
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
Subject: [PATCH net-next v7 02/10] net: dsa: realtek: rtl8365mb: add chip
 family infrastructure
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

Add enum rtl8365mb_family and a family member to struct
rtl8365mb_chip_info, together with rtl8365mb_get_family() declared in a
new rtl8365mb.h so that the VLAN code can use it too. Tag all existing
chips as RTL8365MB_FAMILY_C.

RTL8365MB_FAMILY_D is defined here but no chip uses it yet; it is needed
by the following patches, which add family D handling for chips whose
register layout differs from the existing ones.

No functional change.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.h      | 14 ++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_main.c | 14 ++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 drivers/net/dsa/realtek/rtl8365mb.h

diff --git a/drivers/net/dsa/realtek/rtl8365mb.h b/drivers/net/dsa/realtek/rtl8365mb.h
new file mode 100644
index 0000000..315de4c
--- /dev/null
+++ b/drivers/net/dsa/realtek/rtl8365mb.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RTL8365MB_H
+#define _RTL8365MB_H
+
+#include "realtek.h"
+
+enum rtl8365mb_family {
+	RTL8365MB_FAMILY_C,
+	RTL8365MB_FAMILY_D,
+};
+
+enum rtl8365mb_family rtl8365mb_get_family(struct realtek_priv *priv);
+
+#endif /* _RTL8365MB_H */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index da06f95..840db5a 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -110,6 +110,7 @@
 #include "rtl83xx.h"
 #include "rtl8365mb_l2.h"
 #include "rtl8365mb_vlan.h"
+#include "rtl8365mb.h"
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -707,6 +708,7 @@ struct rtl8365mb_extint {
  * @name: human-readable chip name
  * @chip_id: chip identifier
  * @chip_ver: chip silicon revision
+ * @family: chip family
  * @extints: available external interfaces
  * @jam_table: chip-specific initialization jam table
  * @jam_size: size of the chip's jam table
@@ -719,6 +721,7 @@ struct rtl8365mb_chip_info {
 	const char *name;
 	u32 chip_id;
 	u32 chip_ver;
+	enum rtl8365mb_family family;
 	const struct rtl8365mb_extint extints[RTL8365MB_MAX_NUM_EXTINTS];
 	const struct rtl8365mb_jam_tbl_entry *jam_table;
 	size_t jam_size;
@@ -731,6 +734,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8365MB-VC",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0040,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
@@ -742,6 +746,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367S",
 		.chip_id = 0x6367,
 		.chip_ver = 0x00A0,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
 			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
@@ -754,6 +759,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367SB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0010,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) |
@@ -768,6 +774,7 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 		.name = "RTL8367RB-VB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0020,
+		.family = RTL8365MB_FAMILY_C,
 		.extints = {
 			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
@@ -874,6 +881,13 @@ struct rtl8365mb {
 
 #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
 
+enum rtl8365mb_family rtl8365mb_get_family(struct realtek_priv *priv)
+{
+	struct rtl8365mb *mb = priv->chip_data;
+
+	return mb->chip_info->family;
+}
+
 static int rtl8365mb_phy_poll_busy(struct realtek_priv *priv)
 {
 	u32 val;
-- 
2.53.0

