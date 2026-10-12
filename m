Received: from sonic309-22.consmr.mail.ne1.yahoo.com (sonic309-22.consmr.mail.ne1.yahoo.com [66.163.184.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0F2744F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791764021; cv=none; b=FdOlZnj4E5uQJjczrJLteTauwJBVlocl1ffNeqx8x2qSPITAVC9p8UlX/iaxdn3kRQ6Rp6x49fDDs9qlZ6lBWgOGsrFPjuB+XysItR3z1gw966bvsg9Cm9tY0zvp5JizIvOqN6Sjp0NmcYQ7DGH3EPhWYO4C1okdxub/4z0Q194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791764021; c=relaxed/simple;
	bh=pJk8DxSjSaUWmpt63rnT4nZOoC4lkecacpRVxv1V95A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=DzUJ8OJQTANYSufz7uD9BnRxHCRaQ9FabbFB+KQeEOvmYExNLdaXlEp5J31qDnA7bUNCjBFpeyLrV180mgvEQW12X0GbaIC/kPalifnbahBhCR1G+4wNSkkVO5uhKlUdvfTh15NxYWLyzxvIQ2U2908eRDxCejXac3mWVD8CFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YJaXXWYZ; arc=none smtp.client-ip=66.163.184.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YJaXXWYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764018; bh=Q1HVYu+OBSWg+vptNxlcQ24WWLgaVCEZ1570/SllREc=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=YJaXXWYZlLRuDop30U3YVUnZsEH0u9x+iDEbgE7RaaHORGjkhGGgkNn+f/xiw8e+Bc4uwjN7+vkHjXdlBEyKfHcXBOJR3OodY5X095bPKwWdfNWnzhxeJQoRoyps2UR6EzfczUIcuU+9uF/6hpyE0Eda70KzfLJT/7idxPhJWIYowgqS9hMEocI9q/P9XyTdiRwSGIIuoGZTyXR5+sHP2+v6aOgm6bNYQXHKos2QiV8sX3IIrGYECPOCS0LlJFMF9z8I1R/KeUEwAgwaEMb5/yZETFDJdGKmrO5fg223oF2o3WB7gTbNFx0Ek5GKQnfKES/MU27HvDIfmUiwvx/IWw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764018; bh=wwK2FmOf9/k7Mp+FEdYzTORrePXr9Zj570pGhTs9gje=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=hs9+3sMXk58r3WoRiMXnfLQSBqi2PIQuxBEs9apBvIir3Kq1mjjmEBpAuDqLV7ifEeppZrb1ATgQrLvpWqiWhHPTHlggyLeovAqhaNEiXKKhDapkOf+uEZgrXwXJjb8ZLLmbui6WOqALPFrp1v0LL2+bOTLiQT6qMj/kutH1yJFpvRyn7WlJx85GmI9vvb50fMBFUgyAy+PZZTaHNJEaOz2vDUnaauWHMMxoIcvaIYuxE/R4YKxQ1Fge80SsfofJRiywXZskXxu7HdgG62tgjXHPOG5pQW52+seRIotycpJC+Sf/rm1FsjZTYvQaUHN3Si6iMLohsgn3W4FZfk+wfQ==
X-YMail-OSG: .P.jVKwVM1lHmHnEiOMC.MDI0r4aK8VpzDWlZcS6vA.kazSOljnStT5vuYwzZUS
 rVYznEWEhejtV1twAFGKxcIvqr2K6JNmwp7d5wOpXfjoPJiV8wltbSZGtRfWFVn6asJ.FJMfQt7I
 SYw.28QQQ_GOPOXmJ.rAflPkdfc1LQ.yWGha1Tp21tUjAnj6jcUKAz3ttctLKFxDlBUNPuas0BAH
 2N0V4NlVTuCTZ0t0r3e1BQtgdLF4M2Bhihu76ym0fooCbGzX9MzO5U9pVLpdBZsL84uf3Ebbqzqg
 WIri3jQjn5FyPVeqsR_AW.CO_dWFlGvOZblpXxPCh3vbTcDr_1APbyxVKUy9tL1FllUGWSxeBCNR
 qEladKSOhpoUPec9zssXHyxv1gEVDBPc2wTnrTOM9moCb3WEWMRxH6r5OednBiNe4bhxmngnWVSi
 qGfmVHJdq6_jHk4DsS4yjljprX0Dn81hE_tvTvnvU3iSxG3._paRAX33vjhZOY7i8SnoaC9G62aK
 UEtjCzchfOi1685LpOF3p8O21AzVq3KcQH5qHfbiBFTVAHBbz_xBGZa6RDi3jzMQK6ldwLU5ZpTr
 YB8HIjrydl89zjqXxVxFGcuHA.86LphuGQp.Fks4RVvLgQEo57slr1OMucUlPcnNfSY2ipYVikIe
 Sj7IMuRVGbpm1s85WH5ZX8J_ZvlM6LqFBY70jYfUvMgMaOvoNlZLrEhRyKt_L9LXqUkqJXNGXXGH
 s3jav1lazEXOKzNsv7IhkJrbUsh5aA8EdbmhN0y_1L2tM8UvbraMjD6uOUb842QflYwZhq0X9Nrj
 oDrOqlbWx2rtJ5zpYIN.1akJ4Oqd0xoKAOCICNdjiyQCawfwCpbLkkUnHmYZG592VCxAldcZVzf1
 c1NLjmXq6SILzqBDC_5438Zx.QxWz0nj35KdGYsqKTBAM_lZ73AM8w_2myIyiZJJs7WtMiQW2_H5
 OgJgVglznJ_X2dmvHpbJEYizd.R05tA_3KgBWROhFWvjBmjXi2xtDZCVfwzUHSZlyTg5JWVTUzYG
 0A59SYEuaglqpJvPVcKd2awEZA89DCNbXcAIGLzW7TDJRRi7HNKcCcG.So0AXL9cZ8BhLdOtG3DM
 BcSOntMYaRU_coIeMju8LCCVCwuhQLyZqt3eDBJuCQ1ahuQTcokMOKZ_QH1wodaJNU3W9nGyRItp
 RNU9IzBgw7ppZrxb35wUd0Wq7lMZoZGepu2tjcKHI0MKQPymp2IyN9Ngehp8S6bjkIuFLfGale1z
 GGPaPXm7gkxbnkRlIZtVUqxF0ME_cb2shXEe6wqQQN9j47kzuBR_j70Z2A5Dsp5rnij9c0wYdKVn
 XK_RS4SKLyg9bG6IHQrnhUXoUAiCsAW9XkSCrIk7q7Ob.fM1Pb9z0O1GzVHcLf.tvBUu3nz1pBK3
 7bHtebQGChGN92sr1Cp8rrCltL9KcosjiaX9otrvNb2GE3qwjlNm9StGFCQ2gKRJoY671ytz_eOh
 .13wJeP18Gkmnh.5fBNLsh5ccFh448SYFR89ZCiiKVjWT1Fxi3XqtkNV7M6MlQ2AFyJIAF06IeQh
 O6jC8C9YDrm4e49sgvol7jfuLuCKYCClDaBYBe4r8T7rvXK1RGPuGEZxA0H.Wfc4R3B2nwzmleVL
 Kro2SZMHB7tHLCyKEnWezFvMy25DrHWNOAm9TbGnEWqFZqp35Vge93O6tD2uMqgqcAjEt63S3lJS
 L6auEZ83Ax7hw0CZyY.Lk.L0Ri6bsSCeIoXoTpj_ACyTyN7HmxkxfeItqbWiIOxPxYN.brn7iWKz
 XlLSWgJgNbx708DPdpmUyVDBy4ArRzNbVbLNK5rs5COIx3OSEJp79H_r2FY0XX6X7AZZtMhy8LO_
 SP5HRBOht7Si0TaV8LmPtEVx3Fw6wM4g3zeu2DlN77fx.krzIhfRpPH6ohiTp0Dmp6019rjG_2wq
 VF4Ckn7nKV6UtnyuhKm.4cHA6ZStxYnSKle5AudncjpPLRkTkC3hvIbTp9oLwH9y.MrssSV_4Ohg
 itbVyi12M6.aOctjhUQwUE7nLFeFSQiKWm2IITU0MVH7pjBjaTm1WM.kPvgk2poXAjEFSmI6q4Uc
 I8aiW9bqQgNap86smKh.D99IfhlszN6P33OkeQBjcfl1yhEGJZNEWCNFw2Gq1ff4WlKIFirIO5wJ
 6ZCZlJK8vV.X.BUpV46PL.NPCFgc_qe3c93Ygn558VziurGsm6tTzw14iTBebVHfm0C_le88fXnK
 18tnp8znHZmatBeKqb1WzEq0JHwvzpZC.RyTY9rs8.tainQwiR23fFqXc2o2XHCxqVhwtEqYy8WK
 hz6nHGLwEerEzhEgaR_pWvEHRh5sJP3rUJ7jOOr3Z
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9d972c87-0285-47cc-98ac-32bbf881c6bc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 00:13:38 +0000
Received: by hermes--production-ir2-5dd9bf4598-bjqzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2e6f8ec0eb3abf57efc6122e66fef47b;
          Mon, 12 Oct 2026 00:13:33 +0000 (UTC)
Message-ID: <345719b4-e20c-47ff-b203-86be15e4e871@yahoo.com>
Date: Mon, 12 Oct 2026 02:13:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 6/9] net: dsa: realtek: rtl8365mb: use raw VID for
 PVID on family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Language: pl
In-Reply-To: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26668 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Family D has no working VLAN member config (MC) table. Its PVID is a
raw 12-bit VID in a per-port register at 0x0700 + port, whereas family C
stores a 5-bit MC table index, two ports per register, at
0x0700 + (port >> 1).

Running the family C code on family D therefore reads an MC table that
does not exist, and writes an MC index into the VID register of port
(port >> 1) instead of the one of the port being configured.

Read the PVID straight from its register in
rtl8365mb_vlan_port_get_pvid(), and make rtl8365mb_vlan_pvid_port_set()
and rtl8365mb_vlan_pvid_port_clear() use direct-VID variants on family D
that skip the MC table. They keep the family C frame filter handling and
rollback on error.

Also clear the family D PVID registers when the VLAN support is set up.
Unlike on family C, where VLANMC index 0 is the neutral PVID, the
register holds a raw VID, and after a reset it keeps its hardware (or
EEPROM) default. Without clearing it an unconfigured port could report
a stale PVID from rtl8365mb_vlan_port_get_pvid(), and
rtl8365mb_port_vlan_filtering() would accept untagged frames into it.

No functional change for family C.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c |   8 +
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 204 ++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |   1 +
 3 files changed, 208 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 996ba2e..f31d72a 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -2342,6 +2342,14 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
 	int ret;
 
 	dsa_switch_for_each_available_port(dp, ds) {
+		/* Start every port with the neutral PVID */
+		ret = rtl8365mb_vlan_port_reset_pvid(priv, dp->index);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to reset PVID on port %d\n",
+				dp->index);
+			return ret;
+		}
 		/* Disable vlan-filtering for all ports */
 		ret = rtl8365mb_port_vlan_filtering(ds, dp->index, false, NULL);
 		if (ret) {
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 206a001..486b9b2 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -46,6 +46,10 @@
  *
  * VLANMC index 0 is reserved as a neutral PVID, used for standalone ports.
  *
+ * Everything above describes chips that have a VLAN membership configuration
+ * table. RTL8365MB_FAMILY_D chips do not have one: their PVID is a raw 12-bit
+ * VID in a per-port register, and no VLANMC entries are allocated.
+ *
  */
 
 #include "rtl8365mb_vlan.h"
@@ -124,6 +128,11 @@
 #define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(_p) \
 		(0x1F << RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p))
 
+#define RTL8365MB_D_VLAN_PVID_CTRL_BASE			0x0700
+#define RTL8365MB_D_VLAN_PVID_CTRL_REG(port) \
+	(RTL8365MB_D_VLAN_PVID_CTRL_BASE + (port))
+#define RTL8365MB_D_VLAN_PVID_CTRL_MASK			GENMASK(11, 0)
+
 /* Frame type filtering registers */
 #define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_BASE	0x07aa
 #define RTL8365MB_VLAN_ACCEPT_FRAME_TYPE_REG(port) \
@@ -176,7 +185,7 @@ struct rtl8365mb_vlan4k {
  * This structure is used to get/set entries in the VLAN membership
  * configuration database. This feature is largely vestigial, but
  * still needed for at least the following features:
- *   - PVID configuration
+ *   - PVID configuration (family C only, family D has no VLAN MC table)
  *   - ACL configuration
  *   - selection of VLAN by the CPU tag when VSEL=1, although the switch
  *     can also select VLAN based on the VLAN tag if VSEL=0
@@ -748,14 +757,51 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
 	u8 vlanmc_idx;
 	int ret;
 
-	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx, &vlanmc);
-	if (ret)
-		return ret;
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D) {
+		u32 data;
+
+		ret = regmap_read(priv->map,
+				  RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
+				  &data);
+		if (ret)
+			return ret;
+
+		*pvid = data & RTL8365MB_D_VLAN_PVID_CTRL_MASK;
+	} else {
+		ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx,
+						 &vlanmc);
+		if (ret)
+			return ret;
+
+		*pvid = vlanmc.evid;
+	}
 
-	*pvid = vlanmc.evid;
 	return 0;
 }
 
+/**
+ * rtl8365mb_vlan_port_reset_pvid() - Put a port's PVID in its neutral state
+ * @priv: realtek_priv pointer
+ * @port: the port number
+ *
+ * On family C the neutral PVID is VLANMC index 0, which is the reset value, so
+ * there is nothing to do. On family D the PVID is a raw VID in a per-port
+ * register whose value after reset is not defined by the driver (it may come
+ * from the hardware default or from an EEPROM), so clear it to 0.
+ *
+ * Context: Can sleep.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int rtl8365mb_vlan_port_reset_pvid(struct realtek_priv *priv, int port)
+{
+	if (rtl8365mb_get_family(priv) != RTL8365MB_FAMILY_D)
+		return 0;
+
+	return regmap_update_bits(priv->map,
+				  RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
+				  RTL8365MB_D_VLAN_PVID_CTRL_MASK, 0);
+}
+
 /*
  * rtl8365mb_vlan_port_get_framefilter() - Get the ingress frame filtering mode
  * for a port
@@ -817,6 +863,68 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
 				  val);
 }
 
+/*
+ * rtl8365mb_vlan_pvid_port_set_direct() - Configure a port's PVID as a raw
+ * VID written to its dedicated register, for chip families without a
+ * working VLAN MC table (RTL8365MB_FAMILY_D)
+ *
+ * Reads back the previous PVID and frame filter first so both can be
+ * restored if enabling the new PVID fails partway through, matching
+ * the rollback behavior of the family-C implementation below.
+ *
+ * Context: Can sleep. Must be called with &priv->vlan_lock held.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int rtl8365mb_vlan_pvid_port_set_direct(struct realtek_priv *priv,
+					       int port, u16 vid)
+{
+	enum rtl8365mb_frame_ingress prev_accepted_frame;
+	u32 prev_pvid;
+	int ret;
+
+	ret = regmap_read(priv->map, RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
+			  &prev_pvid);
+	if (ret) {
+		dev_err(priv->dev, "Failed to read current PVID\n");
+		return ret;
+	}
+	prev_pvid &= RTL8365MB_D_VLAN_PVID_CTRL_MASK;
+
+	ret = rtl8365mb_vlan_port_get_framefilter(priv, port,
+						  &prev_accepted_frame);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get current framefilter\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
+				 RTL8365MB_D_VLAN_PVID_CTRL_MASK,
+				 vid & RTL8365MB_D_VLAN_PVID_CTRL_MASK);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set port PVID\n");
+		return ret;
+	}
+
+	/* Changing accept frame is what enables PVID (if not enabled before) */
+	ret = rtl8365mb_vlan_port_set_framefilter(priv, port,
+						  RTL8365MB_FRAME_TYPE_ANY_FRAME);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set port frame filter\n");
+		goto undo_pvid_write;
+	}
+
+	return 0;
+
+undo_pvid_write:
+	(void)regmap_update_bits(priv->map,
+				 RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
+				 RTL8365MB_D_VLAN_PVID_CTRL_MASK, prev_pvid);
+	(void)rtl8365mb_vlan_port_set_framefilter(priv, port,
+						  prev_accepted_frame);
+	return ret;
+}
+
 /*
  * rtl8365mb_vlan_pvid_port_set() - Configure a port's PVID and associated
  * VLANMC entry
@@ -829,6 +937,9 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
  * PVID. Gracefully unwinds and restores previous configuration if a hardware
  * write operation fails during execution.
  *
+ * On RTL8365MB_FAMILY_D there is no VLANMC table: the VID is written directly
+ * to the port's PVID register and no VLANMC entry is allocated.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -846,6 +957,13 @@ int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
 
 	lockdep_assert_held(&priv->vlan_lock);
 
+	/* This chip family has no VLAN MC table - PVID is a raw VID in a
+	 * dedicated per-port register, and there is no separate membership
+	 * table entry to allocate/track.
+	 */
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		return rtl8365mb_vlan_pvid_port_set_direct(priv, port, vid);
+
 	/* Read the old PVID exclusively to undo in case of error */
 	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &prev_vlanmc_idx,
 					 &prev_vlanmc);
@@ -925,6 +1043,76 @@ undo_vlan_mc_port_set:
 	return ret;
 }
 
+/*
+ * rtl8365mb_vlan_pvid_port_clear_direct() - Remove a port's raw-VID PVID
+ * configuration, for chip families without a working VLAN MC table
+ * (RTL8365MB_FAMILY_D)
+ *
+ * Reads back the previous frame filter first so it can be restored if
+ * clearing the PVID register fails.
+ *
+ * Context: Can sleep. Must be called with &priv->vlan_lock held.
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int rtl8365mb_vlan_pvid_port_clear_direct(struct dsa_switch *ds,
+						 int port, u16 vid)
+{
+	enum rtl8365mb_frame_ingress prev_accepted_frame;
+	struct realtek_priv *priv = ds->priv;
+	bool filtering;
+	u32 cur_pvid;
+	int ret;
+
+	ret = regmap_read(priv->map, RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
+			  &cur_pvid);
+	if (ret) {
+		dev_err(priv->dev, "Failed to read current PVID\n");
+		return ret;
+	}
+
+	/* Port is not using this VID as PVID. Nothing to remove. */
+	if ((cur_pvid & RTL8365MB_D_VLAN_PVID_CTRL_MASK) != vid)
+		return 0;
+
+	filtering = dsa_port_is_vlan_filtering(dsa_to_port(ds, port));
+
+	/* Changing accept frame is what really removes PVID. But only do
+	 * that if VLAN filtering is enabled.
+	 */
+	if (filtering) {
+		ret = rtl8365mb_vlan_port_get_framefilter(priv, port,
+							  &prev_accepted_frame);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to get current framefilter\n");
+			return ret;
+		}
+
+		ret = rtl8365mb_vlan_port_set_framefilter(
+			priv, port, RTL8365MB_FRAME_TYPE_TAGGED_ONLY);
+		if (ret) {
+			dev_err(priv->dev, "Failed to set port frame filter\n");
+			return ret;
+		}
+	}
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
+				 RTL8365MB_D_VLAN_PVID_CTRL_MASK, 0);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set port PVID to 0\n");
+		goto undo_set_framefilter;
+	}
+
+	return 0;
+
+undo_set_framefilter:
+	if (filtering)
+		(void)rtl8365mb_vlan_port_set_framefilter(priv, port,
+							  prev_accepted_frame);
+	return ret;
+}
+
 /*
  * rtl8365mb_vlan_pvid_port_clear() - Remove a port's PVID configuration
  * @ds: dsa switch instance
@@ -934,6 +1122,9 @@ undo_vlan_mc_port_set:
  * Resets the target port's hardware PVID allocation to 0. Cleans up and frees
  * the associated VLANMC entry if no other ports are referencing it.
  *
+ * On RTL8365MB_FAMILY_D the port's PVID register is reset to 0 directly; there
+ * is no VLANMC entry to free.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -948,6 +1139,9 @@ int rtl8365mb_vlan_pvid_port_clear(struct dsa_switch *ds, int port, u16 vid)
 
 	lockdep_assert_held(&priv->vlan_lock);
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		return rtl8365mb_vlan_pvid_port_clear_direct(ds, port, vid);
+
 	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx,
 					 &vlanmc);
 	if (ret) {
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
index 27a526b..9971fb6 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
@@ -20,6 +20,7 @@ enum rtl8365mb_frame_ingress {
 
 int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port,
 				 u16 *pvid);
+int rtl8365mb_vlan_port_reset_pvid(struct realtek_priv *priv, int port);
 int
 rtl8365mb_vlan_port_get_framefilter(struct realtek_priv *priv,
 				    int port,
-- 
2.53.0

