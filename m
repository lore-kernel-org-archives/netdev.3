Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.190.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125685;
	b=rdaV8XZOrrYNgkeXHb9w8P80LPtqKeYkiXAabpHKMV4931O0mT9qdRVUYHZGv2UC7lz6
	 xk+4i7IU3kDHFZbTdMBI4zU7rhix8maYcQONlH8epcJ27DhheBS2zzGYe2Bt4nOg9uNaH
	 CpaTFXtf9U3zfUZvnAyGXwL7k4hNsWddSZBgUt0tuO3DJHPVZztYSTISOOMZQQ/w29PZz
	 O0axUqtp99Ihxtg/EhaJgyzqHVQeSW76WbWLEVuJYyyt+Vm3Sl6pEXjOllXwJlcajxUeT
	 mKmykBDu0XzpFh9V6m9JomKsv/tMIJoNq5+etsnEc24ZO+pj8C7kc/zi+6bdb/kTOrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125685;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=QrS6m+RQL1xNIGfxBRUV3wCT9wxl4E9yhKCTpR1sTUo=;
	b=L50LgcN3mBWs9LARKpP6U4wnasxIrw/BQ8H4yEF+iuFuItXlTyWyEspnCARKy8HvePeL
	 W4Wp/34w09EJzhlrA65U6FGWZTIX+dA809eqcp5GYXpr37kHAsSf1QM2w12SbuaJ5ekcn
	 KE8tbilxFS/5oaklKb70PwlazzGE0ACM/dCEocKzxypwbShtkOjim0o4tcpeirNbGrtKB
	 ONgIZ1dVbRSRdNDCni1z+iX7S7LppI7Rs/eo8AoqG78wfB9ah+E7Xb+Y+ry5flf8o4cQD
	 DOg+yZVlO8LM7AkOtvTakJVuPdVd1qlvc/IGLlBB0DALhs0pnVI7AuDCCnPOJpgcE+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=C81xKJ0R;
	arc=none smtp.remote-ip=66.163.190.148
Received: from sonic315-22.consmr.mail.ne1.yahoo.com (sonic315-22.consmr.mail.ne1.yahoo.com [66.163.190.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D06606A321
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D06606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=C81xKJ0R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125684; bh=QrS6m+RQL1xNIGfxBRUV3wCT9wxl4E9yhKCTpR1sTUo=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=C81xKJ0Rd6wNVDFGRLX73J4xdGCFkWYdhM0MQJGtuLB0cxHzR1SC26Ho8R8uBbl+mQin0/p5110XjlPhEhqtAEPDJ+UTO9CpS9lghN8kp0jav0gWf4Y64RhmL1orRKI0iCoi2vaqKfbTHXLE4xx8FYiBakfF8Y2WHJNglWfzaCwKmTRsQFZniuB87e78rT0ZkB8Z4EN2AgPwCQaweUcy2Rmv2kLATN2nbLC/RU/PtpmuA40Kiq3+gpI311UcboanhgloDlxbMtfK4V3DBdSZqDxGptaiFw29S3aQSaEfubrwlZpCtnsdNxP/Tfd7H51RNk15a1umsu7qRhAm+J4qDQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125684; bh=LlZwqdGDyERDCiI13AMmE4hy6r8DNj2qcH4kMHQgPhk=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=ikhdlXmqWthopDMT3eEg+W7MUzPv7316U1mKFao6CKWmv+U7TvjaOujbeYdongD8PL9c50cEUKHmyvLGi2U2KpuxaQVBKnhbSb4laSUMlSD2wENQtKhlDszMS01SXt3aZrZ5ueGm8f5gEh6QkYWrs/k9HeI6SbSoPdbAn0rySQRUnjDSenodiEgJ8sO+eaKWjtJb7rPvmNhaRM0VvPpMFbCnMYeQX3YbNuj9/ekkUf2wY1dyeDKe7nWkeuOS5/Kw/TaUbjoVxfnghP65no7kBg8jxc3snjEw6p00OG6XBQmJ+K+ooz+C9P8cpDQ3ulPDETpyp0pe4NuK8SiIygMU/g==
X-YMail-OSG: _hYBzv4VM1l1YvzzDmNygzVAo8MYHjCMZ71ESC8fFlT1cGYrGYva3ocdsQmmR9P
 XZ8nyCWDhGYcHacAOsipU7tdNH6d8Shm3vKkOQUtKW8KyzqphH9imm.29wGs6i1xc5aHtBVqhqaF
 YTb.Y3Dqp0bpbnKu4TkvwPim81onjgR2VY4nnILTSBzNyJDFw6XEWs3y_0gmZRLdVWZ39jkOmFe_
 L7r0SF5tYAoHOzqGvOcTqqPW0vnFOKZAGOR8BrE9aLkPlzBB2miTCn_QvxNQ6Ry036vIz_B8eTR2
 uoJdjanRnGtXw4VmyQjsRBObjyRmO7Pkt0IQQ6xA05O3MzGYt3ZgmOl51pbo_42iMCPp78i_OBtJ
 4CB8AsxEdcrzL5zGHMHwOnCgGmVxWz85x8FK1p1HtF3uTh2MjLFPzhtdkOB5paT3MFCoH6sdzKua
 8bnzi3dFhVFzYhwbOgRPR5KzC4izufxwk4DMKJPsi3ArNplDF6UqEGZEAEmEY6guQPwQFwk5GfY3
 Cjn3sdhH9Ga93tKu1tXMp.WbHqiXFJ.Xb6CLix819n_ALlzBUWTxFNhOlObUFu6kfOg.AA7vpsSo
 x6u60MPkQw7uuoIuUsTI3ne.26OILqlXRTjeTi8oNaCTcCyW1DT1cswPw_9f1IXhoS_gvjzgsk2t
 N7__YhJsy72JSbkjBu4kcuu.NISh.vcVwM78P9_BKfzMmYFnvZajf9KqmOd7.noiua93P1kfcQwP
 fsWGXow3fluo8bmymsaVFZXlUk7uhdLDtENV1VEY4NGeNCw_ouiSJE3bGrXopB5QAKrU_GICeOF_
 BY0lwoo9Xlf3O8qO0_ZhSYt0898DderevMxa4XVefTRf1R4CnID5F8MxSqkSMSlVpuo6beF9zK3u
 tz73hcwloajQOkrPKkomvlLqIX0PamybPtWkrcBQ6Cl86esfTlzpSqhCQSjag2YYn.91g0WbVGSW
 weo4s7qHh_PUTKV2h2xYyIKTXuEeTcBPDPZcqJyLxX6DL2LkPYbeLDDdgDQ64G6fwT3r8ALtS90N
 J6t3_hjjY4OCalQdZvSDuReQc8bzV5XxR2pj8AIHxy7NlfY7emoyZlWSsa0G0_TGOamFTuTPIM2S
 fTVCZ1i84JvtqJEKUvAr9n8RIWy7ovME9SuYT_HZ6lUoQoepF7x2.pmmzFpcCJqjxLK0d36ZtEmU
 P2.o6uz47l1N8QHs3sg2nLpOy0z2udSyJROABp0iCNTmiLVuONbG3u5wcVR9tB_CgMxQ.QIM5mWo
 Uhe82zLVvk5ANVrhnaLMYpPFgDUEDDObMfcprO.8MJ36aXEMASUt8Cj8bUM5eSgPJL0jUd9lfxjq
 zTY5Z.cGk9WfQbFi8iyE0PYVK.xxyiK_7vqo8uyZ3EHUNYnMt92oyIyyUlBEhESvmCoYUBbXMdw.
 38nJoYF2VkdLiqs1ak70LGeCZWA1gzAhLPigSJtp6w7ceaRDcTExKjeI1C_ebcfkwoh1dN0FSd35
 3J.CAWZnZYXz1s6YKIE51ixeWdg5jXdz2zGtkljS00p2QqOjC7vtn5S1gNKAuv5bKXIl1NcgPcTs
 IYcXbUCKix2aopWuOXoXfEdVdnOoMQPl.LfmzFMrkOFdRezH9gE3ttgNwGfTZHDRxbyCcV7axWKN
 Vz5IOPNBkU09iAoUlugYwc86WXCSqIybj62wgGkcWcscBNnNyXfBdS3pDJ6O1y1EczATGCBs4qbf
 ppd.R2bYvmN.9nfXpQZ7u6hs8E6F4.7DiTRPb3sx046JKvOojR1Y0WlrnflRJDOWI2OaOBOAizA3
 zCjMYVq8zgZFEtvi7JaHeoQ8vG2iXJddOTsM3IbMiwC1.W03pJcIgd2uUrmwcCAQbDve125WqTEy
 sUiuEUHS.sq7cRDSw7UMDNvYJyc6bw3VMp9.EG8ZRgw2TvAgP0BGNk1lcd0JTIIR8c3q.g6xcHlu
 3ClEi4DtTtEOTMKGy.qekFnv45yKzcald8SPiAOrIMzsENtmtI__aaVrH_kyqqrUEFmNUp4TKN6p
 or_VK_T5LqCWHakjm.fEw8YqZf_eTCVmA3fckQTR10XWXzx.kO09iSBfyeJXsrfpZCa19e0Z5djw
 9ZdwrwD1muHkCcMsIQ_B_Q8lqw3e.qUUdIgo8dyQyOHWBZC6h0syUx3nlIQTMw37tD4zMXGUEEvJ
 qbpabZ0zLEJi7wKMmBOtLkW_762R2fcYgzLhvuCOFROeHGXbZIR0LwBPNE2uR3zRDgL8.iohsd4I
 W8AxIcC_ahAX.hS9aE2K0BG0vtoZtA0tJmiB0DdGEz8zKCwPDzUGaurl7xh.697QIXfgxFadZTbO
 HpdMYm.XSebGmGfaj.rkeqzWZ44ctCfMabfBiT8tlLaGIzg--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 7d6a2ef6-2545-46f9-a300-c3f689c08ff3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:14:44 +0000
Received: by hermes--production-ir2-5dd9bf4598-hrqwh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ba7694104bd7e58fa4191b79df5ce567;
          Sun, 08 Nov 2026 08:14:42 +0000 (UTC)
Message-ID: <7bdfd66c-3492-45ce-93e3-2c9e5a1a5872@yahoo.com>
Date: Sun, 8 Nov 2026 09:14:39 +0100
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
Subject: [PATCH net-next v9 11/11] net: dsa: realtek: rtl8365mb: add support
 for RTL8367S-VB
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

Add the RTL8367S-VB (chip ID 0x6642, version 0x0010) to the chip table.
It is the first chip of family D, whose handling was added in the
preceding patches, so this is the patch that makes it reachable.

The SGMII/HSGMII SerDes of this chip sits on port 6 and the
MII/TMII/RMII/RGMII interface on port 7, as on family C, but the external
interface indices are one lower (EXT0 and EXT1 instead of EXT1 and EXT2).
The chip reuses the existing initialization jam table.

The chip has 8 ports, not 11, which is described by rtl8365mb_family_d.
This sets ds->num_ports, the IRQ domain size and the bound of every loop
over priv->num_ports for this chip.

The L2 learning limit is the same as on family C (2112 entries), as
given by the Realtek rtl8367 common API (rtl8367_common V1.4.2), so
RTL8365MB_LEARN_LIMIT_MAX needs no per-family handling; only its
comment is updated.

Tested on a TP-Link Archer AX55 v1 (RTL8367S-VB, CPU port over HSGMII
to an IPQ5018) with bridge VLAN filtering and per-port PVIDs, and on a
TP-Link EX511 v2 (RTL8367S-VB, CPU port over 1G SGMII to an IPQ5018).
RGMII mode has not been tested. See the cover letter for details.

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/Kconfig          |  3 +-
 drivers/net/dsa/realtek/rtl8365mb_main.c | 38 ++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index d6eb671..98b1727 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -34,7 +34,8 @@ config NET_DSA_REALTEK_RTL8365MB
 	depends on NET_DSA_REALTEK_SMI || NET_DSA_REALTEK_MDIO
 	select NET_DSA_TAG_RTL8_4
 	help
-	  Select to enable support for Realtek RTL8365MB-VC and RTL8367S.
+	  Select to enable support for Realtek RTL8365MB-VC, RTL8367S and
+	  RTL8367S-VB.
 
 config NET_DSA_REALTEK_RTL8366RB
 	tristate "Realtek RTL8366RB switch driver"
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index c2b83b7..3fa715a 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -89,6 +89,14 @@
  * things will work out-of-the-box for other chips, and a careful review of the
  * vendor driver may be needed to expand support. The RTL8365MB-VC seems to be
  * one of the simpler chips.
+ *
+ * The RTL8367S-VB (chip ID 0x6642) is not part of the family listed above. It
+ * belongs to a newer generation, which this driver calls family D. Its
+ * registers differ in the VLAN table, the external interface speed and RGMII
+ * configuration, the SerDes, the L2 lookup table (FDB/MDB entry layout, no
+ * EFID, LUT configuration registers) and the table access control register,
+ * so the code paths specific to it are selected with rtl8365mb_is_d() or
+ * through struct rtl8365mb_family_info
  */
 
 #include <linux/bitfield.h>
@@ -119,11 +127,12 @@
 #define RTL8365MB_NUM_PHYREGS		32
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
 #define RTL8365MB_C_MAX_NUM_PORTS	11
+#define RTL8365MB_D_MAX_NUM_PORTS	8
 /* Highest port count of any supported chip, used for sizing */
 #define RTL8365MB_MAX_NUM_PORTS		RTL8365MB_C_MAX_NUM_PORTS
-/* Valid for the whole family except RTL8370B, which has 4160 entries.
- * RTL8370B is mentioned in vendor code but it might not even belong
- * to the same RTL8367C family.
+/* Valid for the whole RTL8367C family (and for family D, RTL8367S-VB)
+ * except RTL8370B, which has 4160 entries. RTL8370B is mentioned in
+ * vendor code but it might not even belong to the same RTL8367C family.
  */
 #define RTL8365MB_LEARN_LIMIT_MAX	2112
 #define RTL8365MB_MAX_NUM_EXTINTS	3
@@ -829,6 +838,18 @@ static const struct rtl8365mb_family_info rtl8365mb_family_c = {
 	.l2_mc_to_data = rtl8365mb_c_l2_mc_to_data,
 };
 
+static const struct rtl8365mb_family_info rtl8365mb_family_d = {
+	.family = RTL8365MB_FAMILY_D,
+	.num_ports = RTL8365MB_D_MAX_NUM_PORTS,
+	.jam_table = rtl8365mb_init_jam_8365mb_vc,
+	.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+	.l2_entry_size = RTL8365MB_D_L2_ENTRY_SIZE,
+	.l2_data_to_uc = rtl8365mb_d_l2_data_to_uc,
+	.l2_uc_to_data = rtl8365mb_d_l2_uc_to_data,
+	.l2_data_to_mc = rtl8365mb_d_l2_data_to_mc,
+	.l2_mc_to_data = rtl8365mb_d_l2_mc_to_data,
+};
+
 /**
  * struct rtl8365mb_chip_info - static chip-specific info
  * @name: human-readable chip name
@@ -898,6 +919,17 @@ static const struct rtl8365mb_chip_info rtl8365mb_chip_infos[] = {
 				PHY_INTF(RMII) | PHY_INTF(RGMII) },
 		},
 	},
+	{
+		.name = "RTL8367S-VB",
+		.chip_id = 0x6642,
+		.chip_ver = 0x0010,
+		.family_info = &rtl8365mb_family_d,
+		.extints = {
+			{ 6, 0, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
+			{ 7, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
+				PHY_INTF(RMII) | PHY_INTF(RGMII) },
+		},
+	},
 };
 
 enum rtl8365mb_stp_state {
-- 
2.53.0

