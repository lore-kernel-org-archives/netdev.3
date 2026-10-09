Received: from sonic310-25.consmr.mail.ne1.yahoo.com (sonic310-25.consmr.mail.ne1.yahoo.com [66.163.186.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B033A3B52E2
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521810; cv=none; b=i6am6jFX0GqmuNfX22QZ1rvOnIOqrfJS0gwNyYBBKM5DA/z8uX8Kbjt6LLB4MVrLbf0Z1e6PKxhDwjv/akj+GhAuGA8/1B2InXYOlvUpfGgT16+TlivN3YCbDO7ejgVF61wo+X7k906rHlNjMkGDNhjX6Klxs+VTdfBo8B2e/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521810; c=relaxed/simple;
	bh=KHBKZV98yYA08+ZL7X7dKAIXH/Gv0G2UDPWYlhnfxuM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VImo1LYFpRZrQQKFZ1PS9zCWOTEaSdhyVo39ZCJIPbV/34UcUgLAIkUwQy+/42WVM3+uDLdkussZiyH7h+N2+DBQ8NDMpQZsToip0usL0VlR1qEnERgmoGAwZoBTV5ZlThZCwgbjW343oQ8+E14hk0JxsZbe8ZfYrzUO542BXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=f2rvTqIB; arc=none smtp.client-ip=66.163.186.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="f2rvTqIB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791521808; bh=O27JOzWh6mETQuQpkTKBCYx0gCFJmBvdtJFOBTBoTvE=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=f2rvTqIBdTK5RiMLZNj+lh2uRNZBdXgjpJMMS1p2Rrkq26/FmQ4kWMShpv77nUDjJQoqfREsBXUrguAQCsttpVH8ynFF3xY0IEAgSnqtNyULW65SBwX3IuU7lgSQBWearXt+umuw6QsOd/Ztk/SCDvBzepNWohmbugRV6Q3YmZwaoZVjgxP89FR+jdpnW4ed2FUpaYDUFq3RXNcm2BlXrM4qIWLBxukwGlEsnQjDVxMKtdFJnZjTDk/dL6qZVk44h1PqXL7lBNCHn9rcwpr/EdCx4YSblz/C+fbsprpzIdf7fY6uEc6px139K6xjXuEjCEBIgEiLP3Wr285wchy8UA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791521808; bh=u6vp0uCScn0SNnr6HlE8+P/y+QHlqhN9r3mD+MBbcIF=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=g+b2l9W2Uj50mxWkWSM1XNnylZ1FdQN9af9cJbgQUyvPy84pzBFEnMFHgM7QshEtvLlZtTnhk4TNMIF3upILq1zHyKsCtOaQpvReS/5zH2ahWG/7n8TGWlUQwNf6Dr/kzZrxZTZh/ACeetymY32L7ocLrDCFAqLwv64WZqBcDoe3HbJBluHY+jUi/MXxvWzS47SvyygWMg0UcYHIe8TD9ig4Agko3TfP0wM7/ongzLY2dTnp2Gd9vGQDCgIszzNHAUc9yewyHYDvWg2MQE8sQP7JfgwLItWikHlzjeHZUFAPn/7UJ2WtmXxH9VxFlpeB2h/PZbKKn/Q9lHiMtCYIPw==
X-YMail-OSG: MPFRqj4VM1kBrhMWyLs6B.bO_JJHaosckLGTysQ8a.55DbNg7cNzUExpqEWE.5B
 nwGp0pcar5lCjh5.1m40VHYTfRYtG92Y3YYfwyQNzk.wSZJPJ7ofPIhEbyAZ6X0qjDYWWv8wFy6A
 pVNEKw7bbmTgOuMdy0borft1r2i7yG0Cv0D8Rhw0YuBk8fQHb9fkJAWewsR4WShsY_6F7DhIE5bE
 o8tlJPJVQijccQbnmUGppojMjxw5zHCMjx6ZwIFaYmHcx4A__iGcXSd0ZCVX9dyKdWvtDAGtA1UV
 LQ2UDlDEwNtkno2ETw62Egt8ksWC8yWPIByO88oLfLmThOZGk_D6VJ76LvATiKDvU0T8BaNQRPn4
 by8HEWLbkeNXDx8TTNqhpv.mW7fKXf99JGuuEyehQisYHuTV9hdnNv6KxKzg3kB9c3h_9VBqGXDm
 ._Bg0L6gJN0gQa9FS5lfwQR0doVl30uxPRO_i3MdIeZPLjDDkjyPobVhgRQBiFT0lu8wBI.olVEv
 PMAGNJTYxjtvZ.YJHf2jb9DtrwhJaK8KPFecf9kYz6FE_x7h_mqG.m2ROu9OddT6hKRp2ze5iGZV
 0J3Inc.OvQO2eLDIweuLa6kFOCjqsu4AHiCnHkij8lCLtV2WMv2gubDvvnHcVWidyH_b2B0k7WtD
 Kxqu_4MqyRt2YdRYth64Pz36zObV8ij.GZ9hZNaxdYZk1DFE4dFmGfWwkNVOd_eLBEKBy6aSTVOH
 OWaMnz67o2b9Y2alTxh7xdjurdKpBEflamOBIuUKUFrlgk2DmvP9_qfIldUsHGok3LdeNQ0Dnoq2
 YlJ74kqcmr15fU_utyYW0zacNUgkUIJ6Zp3MkgU4ppk_zaNNZ3UCbRbgZqjuoDLVN.RhZ5RBoioJ
 82hCLX7qugynDfxanFBaQgdHlz58u4HUtkg5thAg1dvb4O9MIukkbbyMcFmytlDbCdGMoXV_9kqj
 NU_OSHjJQyC5biX1_QJUkswyxGy5elQlzI0Mixm0LIoWgRfAsJYboPdorEAAwYF5Bdb_yC_s9eJn
 _NUjCoOCeEA.1MqccDy2l01TQ.GjxR7S_u5yRkJG..4MApslXAFnLSFuOskqSF4oXsaxAuxE_IUE
 ugJxYpj8pOss5xDA1Ru1INv3.bMOMSvYe78Qm5zZ8LWx5fs6GjwoqpZR6B59VtDBjTnTQtAmCNsE
 mywb.1eH2N4LDpQmJ8GI5LiR0X8m4bxpYOPa01wDNUZ0VOdZfTUpq74.8Mp9JUS7y3quplVHOgoj
 1x1Gp8FiAeTpKFXSVCGgO9tnysap6T6M_ZlEsnStI8WFg1NDYl0cDdfNTKmTYBqFf28KuTkIU9k.
 8Jcqcc9ycz0qKKxwbRgSMyawXLDmJ1ZT8feFh5tzSSrnqhFv1a5DT.DUcrrCGAzLVQuicN3Z2mmA
 1Z7xGxJac_Qy3UeHliUPeCfWb1p9ySDR1Ch4eB5jFMr01_68mw0HqtYztmKuqhJxmo6rRend9MkX
 UAKt0JmdDW2RsWrd_sa.J87UxP5BTf9q9xTi16I9o9YjkN02WrihFg_h3RF.uROJs5InjUzcdyKA
 _V77EBGzRWRTdypGUIBd7cUIXczLq0Ag.zOkiEqx_56XlGdXDW.hhO66AmhN5SnyKkV2w2ZlVsjq
 Y_TYhAhZgoRtabE1Mf_pEZE6d27wYFicy.1PhUUYVkj38nmiIpgNzS4qdVo_4Xbv4ukaoyhXqYU.
 GMANnHxmp2LcfLcminLnZVl6ICtpldr1raIvtZohDLg__94dfFoOkETukhTFdXbGb8fEK2WaM_IR
 B9hzF5Gz0mbYQSOt9wfRHqYEK1AA1bpIfbRu8hgMMyGDKfWx4X.MiDnts2LG4u6wFpTfqkVRKipD
 z4utXYdOCF31LsJNNGR27mEBsqrN4rYsFlcio2CBxKwLOt7TfVcuuo2h3KChdx6QCDS7Al.rMqml
 aRd25I8yI98XSOtVNJmrGg1dBQ7347frUNC_nywfZnsmqDbjI7cvx52sRTR1buE8_2u2kolp.R4n
 nmJC9fneTngq3DbBOlNqE3joekFETJtDVyiaHitUS5V71xH_KgLw_z5h0x8xwzF_uevJzjPe.2xw
 Vyv5hbZ44PQfj.QHORerHc6JQosFsjRVwF3ST9bHLI5ZjvQkohYrQEyXdHDf66SSe8MrBcsgO2q5
 n9EupxpDFKjOPVI9hwkBVArwkmHXLi8SsUoIw1nYf1o4WoCbDVDx0i2eTtArhN_4MpnUAAy2Pamq
 zMloOE9PpVAPG4uvZQB0Qb.JO.I_26UAcKELHLJbY0ZEx8o_kME.xVq4PJLwRdyv8DsYxKL28uk9
 RiyR1EIvEFlmmuKLJxN7BuNy9lzaaD6gIpCth8Q--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: efc1338d-2278-4e81-a777-c4503f22a554
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Oct 2026 04:56:48 +0000
Received: by hermes--production-ir2-5dd9bf4598-6rrk6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f4b1cf359925760b13107b24f80aa51;
          Fri, 09 Oct 2026 04:56:46 +0000 (UTC)
Message-ID: <12685d28-1953-41b9-9cf5-3698bf31c1ee@yahoo.com>
Date: Fri, 9 Oct 2026 06:56:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 4/8] net: dsa: realtek: rtl8365mb: set RGMII mode
 for family D
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

On family D, RGMII on extension interface 1 needs two things that the
other families do not: the EXT1 RGMII TX clock delay field in
EXT_TXC_DLY (0x13f9, bits [5:3]) must be cleared, and the pin mux in
the top-level configuration register must be set up.

The vendor RGMII setup for EXT1 clears the RGMII field of EXT_TXC_DLY
(0x13f9, bits [5:3]) in addition to programming TXDELAY in RGMXF.
Do the same. The init jam table writes 0x0090 to this register, which
leaves the field at 2, so without the clear an extra TX delay would be
applied on top of tx-internal-delay-ps. Clearing it makes
tx-internal-delay-ps the only source of TX delay.

If the internal MAC4 block is not occupying extension 1, bind the
RGMII/MII pins to MAC7. SerDes 1, which shares the pins, is always
disabled.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 47 ++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index b1ea8b0..3819a48 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -334,6 +334,12 @@
 #define   RTL8365MB_SDS_OPTION_ARM_KEY		0x0249
 #define RTL8365MB_SDS_OPTION_REG		0x13C1
 
+#define RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK		GENMASK(4, 0)
+/* Shared "disable" encoding for both SDS_MISC's and SDS1_MISC0's
+ * 5-bit mode fields.
+ */
+#define RTL8365MB_D_PORT_SDS_MODE_DISABLE		0x1f
+
 /* Embedded DW8051 microcontroller control registers. The microcontroller
  * can run firmware to manage the SerDes link, but this driver keeps it in
  * reset and disabled: phylink already performs the link management that
@@ -459,6 +465,20 @@
 #define   RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK		GENMASK(5, 4)
 #define   RTL8365MB_PORT_MISC_CFG_CONGESTION_SUSTAIN_TIME_MASK	GENMASK(3, 0)
 
+/* EXT_TXC_DLY holds a 3-bit TX clock delay per external interface, for
+ * RGMII ([2:0] EXT0, [5:3] EXT1, [8:6] EXT2) and separately for GMII.
+ * Only the EXT1 RGMII field is used here, and it is cleared in RGMII
+ * mode so that tx-internal-delay-ps is the only TX delay applied.
+ */
+#define RTL8365MB_D_REG_EXT_TXC_DLY				0x13f9
+#define   RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK			GENMASK(5, 3)
+
+#define RTL8365MB_D_REG_TOP_CON0				0x1d70
+#define   RTL8365MB_D_MAC7_SEL_EXT1_MASK			BIT(13)
+#define   RTL8365MB_D_MAC4_SEL_EXT1_MASK			BIT(12)
+
+#define RTL8365MB_D_REG_SDS1_MISC0				0x1d78
+
 /**
  * enum rtl8365mb_vlan_egress_mode - port VLAN egress mode
  * @RTL8365MB_VLAN_EGRESS_MODE_ORIGINAL: follow untag mask in VLAN4k table entry
@@ -1208,6 +1228,7 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	struct dsa_port *dp;
 	int tx_delay = 0;
 	int rx_delay = 0;
+	u32 data;
 	u32 val;
 	int ret;
 
@@ -1277,6 +1298,32 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 	if (ret)
 		return ret;
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D && extint->id == 1) {
+		ret = regmap_update_bits(priv->map,
+					 RTL8365MB_D_REG_EXT_TXC_DLY,
+					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
+		if (ret)
+			return ret;
+		/* Configure RGMII/MII mux to port 7 if UTP_PORT4 is not RGMII mode */
+		ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, &data);
+		if (ret)
+			return ret;
+		if ((data & RTL8365MB_D_MAC4_SEL_EXT1_MASK) == 0) {
+			ret = regmap_update_bits(priv->map,
+						 RTL8365MB_D_REG_TOP_CON0,
+						 RTL8365MB_D_MAC7_SEL_EXT1_MASK,
+						 RTL8365MB_D_MAC7_SEL_EXT1_MASK);
+			if (ret)
+				return ret;
+		}
+		ret = regmap_update_bits(priv->map,
+					 RTL8365MB_D_REG_SDS1_MISC0,
+					 RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK,
+					 RTL8365MB_D_PORT_SDS_MODE_DISABLE);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

