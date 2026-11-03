Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748763;
	b=ZIFgKU50xr4Jq6ILBUeuraYju2rbXCmlXO/HxtnCmin0DdlwyWcTi6MCoN83KIc6IeUt
	 55oHqeMsMhFX2Zvmk1I71LNUOm/VaUpfVc7RuY37PlV04gu4fsdFyx0rSwP8Ugh6XnBnH
	 8NvDdcSX0BIQulzxAFFvHP3expPPcIQtC5LYKMWY9fKLCEpgN6GFxZzh5jXl5orSY+QAC
	 lNkYt8XVjqEHpwhLViTKPSrpmkNTxpiboVkOKMJLyZzD9AZVlDxde31YjuT+78qXbe5kX
	 9PkcfsnspDH8ds6/FQkUIeCJMykDFpAeYqSD9RnKq8XtyxgkhcO8q8XBIzsoASTKIAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748763;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=YRk1Tssn6jvKUb5zEjyPQmL2nqMAyJnl470rdX6+KoM=;
	b=coUSvRAKnNpAspCpq2Z323n9rqNWlqzLXxsgZrpvlFKvPLBA6NZoPQRm6aI5OcWNFB0R
	 aYEGSOnQZC1Bmj4HFtKW3hb9s1kZInGHKt4b1oLSej4HA25zGdsHm5iyQOYFF+lk8nBNa
	 PRenARwJWisqUmlzOcOgHM8Vu6WAabGPSeq7S9I+0qN2uuOGEmHqtxqfPGU99CYbfJezN
	 Ai7srTEofGatbmfCIv8SWETsMdyeJ0Q+7agw6QKVR8yxCGqrW/BANuGCJH+Xk9blphzRz
	 Yb2SSXYBI1H52lY/iUOd2ET+3TzxxCKVbPlXibCBpKgWf37SOu/08maf9afC+Twxa7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=DzLDxyDR;
	arc=none smtp.remote-ip=66.163.188.206
Received: from sonic311-25.consmr.mail.ne1.yahoo.com (sonic311-25.consmr.mail.ne1.yahoo.com [66.163.188.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DEA606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26DEA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=DzLDxyDR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748762; bh=YRk1Tssn6jvKUb5zEjyPQmL2nqMAyJnl470rdX6+KoM=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=DzLDxyDR+Gk0/OUYazlvjb3AcWFXJntWjc3R/TeXXrvPIwmCvzP2qOdUhoIrnnAeU0Z1gWc2wHD0xDOFI5oIa3pi0CEI7id4XIfPM/jUYyyb4AYCG8BVV08IhnFlOxi68eNVS+W+EWsDXW7+OOA5LOtqPO/fky190n5IhW4NVy+TM+yplZCoX5c/9pfw8bIpKgxIlWP1Jbg/XnRVGHa9Uzs5OKbtSknVRFHJmNA6J34no5sAyOfhw8gA3HOfdkgmDnUbmoVCHdgmNS5SPO4eIFLxE4ZA874RYEfZGN7dFUQk7ZMpAYVd0Qq3BA9j1KutBWM8UOIklpoSiHGcLmAxMg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748762; bh=jbLykxhG/2gkJG+og9AHkWEfUH0pfLC4PqQeCFjAZ9/=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=gnp3wey6Q1d0ysRJa7NLoh6c1zDdvVv/iB68xDyvF1Xqcd4YHI59G6yxvwUDR/dpRUsvZ5KGHiCPtVKTetvEoWpqgj3oPLiFcaGSUhEGifGi0lGpe4oS2NhCneB9zcBJuVxd5pR+Fu4d5zibIyDbf3zLgkxp6CUb65vnkUuGLc/mKkotMp5ioqZGe1mS8xEjh+JB4/V1C2PVcZGmkwA9bTmfnr+4KJYKULrybKi4NhaJQ8gVVt36G7o9DPtsTE+I7WHgjX0AnVlEyuNDFnH7uw74MmEZmuuD8CrCaaXQDCsHPbxy2z4SMQhzjODdfykgrDmpLmCHw7QS/u+V1GfEBQ==
X-YMail-OSG: 2Y1UExEVM1mLvs.1Bjr6JOlpnZmmGgSDU6ajFux534ou96wKfALXilefnoqloyz
 4g7S8dgUhqZuXdqDoEc37uKR5gg6nn.7rdieLBD7aFQXVvonOSq29a7KbA1SX5Yy2KFq3AX4GVv4
 547_Dlm11j0OdyrypFPQgxt5CjBBDS.O_0lzqlY_9rhA8_JpgzNb.6jIEOKmFICLNw6pVp7iNtpr
 J99Ll_sSN2SPLLsmDUdUuv2CX11YsrZ2.6fPB1m8wFafgoWrXgc6lv63oUjACX8ErtKPNWGywvbh
 uNc5L7YyhoWY6yH0Yk9Ro2FOD.nSaQgCWksGA9T_HT0FB7P7I7OAUFUjziNAcKSWotWQRVjjEJdj
 RiQJVIWandpPt1il_ToXvRDNR8mQc.yJKFJvuMPunlbxoaU083WjaUeUPTUHKO61AWx0SmOU1hLo
 29KW0cSkj8I0d4OAss0DMQAHQQ.rfDBGWE7sRQHJr9lHeokQ_.fj174ffLDbhqQSUfGmOH0lnH4e
 JFheO20hwzW3x4C3heGYgcf4.Iw_vEp3K6B_yJ3k5Vp2jmLOsPPxss6DoD6UVDlfsoAOpPVtSVUl
 DbLPWwChf_lzb_RrmLcCfO.4qegu879ZGLQc4XKGSdf0fiBzvQyqLhxMSnGsS788LowCGriW5z1h
 Jg.zr3FgoEi0M.QcrHGlC7c.vyr.ImK1bCqRmLVYbLE40Ma7rxCdUgsZoth62agD7ZvXyqsuZ6XS
 gNxs56oEfL_uzvfdORjd1PEdSfXRqpnTIDZJzM1N1J2vOqsL09IR4NJ5bmBcIpkEqkTgMR9Nod0W
 7p5.9ZgYYAMPY6RD5HCsOgOktvpiPhxLixXYnM3XA43VDwz4f9WOK3n2XMpQvv2BL2Qe8LBN1RZo
 mJxEXUwcxajOF3GEdlTJaC1DGAqGuHpkgNlFKP_8M9lUYxNcdZAKTG6hu608LSTWDc78z9XrFcXQ
 M.AAr15q69tAQAGARsQPFfHf4.W9aVflXx1jTsnDbkSa_EzB3XLRoDNRYWDjB7mXaExMJ6_rkA0e
 Vj72q_GTs.XFbTcK9iG4uVgphNzF9sHLMcd..5_XiiyvtYqknMoe10JW5D2ffALhLNqJ_3ZjAzIh
 _1.vWZxgyXg2B5LXVTKASXeDzalaC3vmMpOomAO_K6Aq8Is4qW59NLmwOLReYUIE_kCOSfRs_HfD
 hu.Ne7maHNZugIedktHyrdy_036hIrT75PFaKoCSr38HzIKHvpoF57c6Xh1MyBuZpoKe4FUq83XF
 1JBycgUhEBNLQTL7dHSQKejc_lt.HSzB70AxWdiwHlWeGQRSzQODc8_09HCNrP9hBlsW5llTXsA7
 lf_jnB42PPpmBWrA9LiBp2YVwOExPGh_3K4lKNCmJJXi5NOBq3qwv3XPEB5qCHx1DyoNKPjKj.DT
 3UP1Olw_uuUqijQo9R0CfK3dlmRaJuuHHT7njZ1n30JV9yXVOHnb0YKH_5ZqB9DS0VJlsyoOClMh
 jlSMCdul0MwBjDumUNd_NDdPekHAGSktfB7bfIMNixvDqSegwKpN80uw.A5QD2kkFRV4UBEpahpI
 GhXorPbHE0UPznKsvz6Ep5q0GCU8vIkx15QIOPghHZ3StEfvSRJcZQlfVJhl4YzeKKojh1GYYxoy
 0jEHsnMUD20LFz69cQ7byjU8Iz62p8_V_rOPG0k4Ht9J8NpOS_2sSCSMXYGFzkF99XzkXbysH8ri
 kO.y4Ug7CiuF_stNvu.U22opL033dncoq9u35ErWusKhYYgppY5Y_ZC4I3zKvK3XowDdCUdE5NqN
 zQ1g5QcjVWI9sXEyy_oOAGWxW_v8nLGihC1wlIt.dzmSa9YU87tQvKjTNtqyj8goAXjOxOrY9eTr
 zs5rRN5_yhDei8GwJ9vzvxj5D9yMS2yb2BBv5Lox9K0gNhwJ0YAOTd.24.c48I9WW8mXR4sVoIBy
 3itU310hkUqAJQI.cfEsZ3KUwSh5WndZJOMHL.yIidp0TOJ4Lqbuvy9Akmo1oqYjSCqkeIbSsXSJ
 l19SC725BFUVdJY3qxftmWfq1v5qJacTT5NPoUTvuhiCIJXOqImdp4EAtIh9dHx9x8QiSx8tLSsQ
 f8nDyLO0DsCl6AQdVayik9Bhpa4wQVCmXJfM6_0f0cYbzjGY.s2wt5MEnE4nsdTW6gGPGKJZ4W65
 xRKNbB78RTjnsOn3I85llMYj8o3zzqXAPmcmcBsKlq4dWsbqq.hwn_.WBtiA4rBk2KLWG60zjOY1
 tODguWrgun.QedZQilq_ZdiCXXcpPRONyxDnPfbvYm4LT_TTl3nX96NhAcmyXdMd34t66P9eAZFt
 Rc7q5U9Co0gx_6j3WcIxzbt89L1r3787nqlDlimbH3Q--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: cf362972-f8e2-4816-87ef-bb9a90b7bf05
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:32:42 +0000
Received: by hermes--production-ir2-5dd9bf4598-czvl7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 081e1bfee864d295cd594b46812e525b;
          Tue, 03 Nov 2026 23:32:40 +0000 (UTC)
Message-ID: <61ed4770-e99a-4715-a147-a4f9d438e1e9@yahoo.com>
Date: Wed, 4 Nov 2026 00:32:37 +0100
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
Subject: [PATCH net-next v8 06/11] net: dsa: realtek: rtl8365mb: use raw VID
 for PVID on family D
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

The family D branch is not reachable until the chip table entry is
added in the last patch.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c |   9 +
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 205 ++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |   1 +
 3 files changed, 210 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index d8f406c..de8f5a0 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -2358,6 +2358,15 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
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
+
 		/* Disable vlan-filtering for all ports */
 		ret = rtl8365mb_port_vlan_filtering(ds, dp->index, false, NULL);
 		if (ret) {
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 202c181..fc2c67d 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -44,6 +44,10 @@
  *
  * VLANMC index 0 is reserved as a neutral PVID, used for standalone ports.
  *
+ * Everything above describes chips that have a VLAN membership configuration
+ * table. RTL8365MB_FAMILY_D chips do not have one: their PVID is a raw 12-bit
+ * VID in a per-port register, and no VLANMC entries are allocated.
+ *
  */
 
 #include "rtl8365mb_vlan.h"
@@ -120,6 +124,11 @@
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
@@ -171,7 +180,7 @@ struct rtl8365mb_vlan4k {
  * This structure is used to get/set entries in the VLAN membership
  * configuration database. This feature is largely vestigial, but
  * still needed for at least the following features:
- *   - PVID configuration
+ *   - PVID configuration (family C only, family D has no VLAN MC table)
  *   - ACL configuration
  *   - selection of VLAN by the CPU tag when VSEL=1, although the switch
  *     can also select VLAN based on the VLAN tag if VSEL=0
@@ -740,14 +749,51 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
 	u8 vlanmc_idx;
 	int ret;
 
-	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx, &vlanmc);
-	if (ret)
-		return ret;
+	if (rtl8365mb_is_d(priv)) {
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
+	if (!rtl8365mb_is_d(priv))
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
@@ -809,6 +855,68 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
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
@@ -821,6 +929,9 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
  * PVID. Gracefully unwinds and restores previous configuration if a hardware
  * write operation fails during execution.
  *
+ * On RTL8365MB_FAMILY_D there is no VLANMC table: the VID is written directly
+ * to the port's PVID register and no VLANMC entry is allocated.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -838,6 +949,13 @@ int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
 
 	lockdep_assert_held(&priv->vlan_lock);
 
+	/* This chip family has no VLAN MC table - PVID is a raw VID in a
+	 * dedicated per-port register, and there is no separate membership
+	 * table entry to allocate/track.
+	 */
+	if (rtl8365mb_is_d(priv))
+		return rtl8365mb_vlan_pvid_port_set_direct(priv, port, vid);
+
 	/* Read the old PVID exclusively to undo in case of error */
 	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &prev_vlanmc_idx,
 					 &prev_vlanmc);
@@ -917,6 +1035,77 @@ undo_vlan_mc_port_set:
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
+	enum rtl8365mb_frame_ingress prev_accepted_frame =
+		RTL8365MB_FRAME_TYPE_ANY_FRAME;
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
@@ -926,6 +1115,9 @@ undo_vlan_mc_port_set:
  * Resets the target port's hardware PVID allocation to 0. Cleans up and frees
  * the associated VLANMC entry if no other ports are referencing it.
  *
+ * On RTL8365MB_FAMILY_D the port's PVID register is reset to 0 directly; there
+ * is no VLANMC entry to free.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -940,6 +1132,9 @@ int rtl8365mb_vlan_pvid_port_clear(struct dsa_switch *ds, int port, u16 vid)
 
 	lockdep_assert_held(&priv->vlan_lock);
 
+	if (rtl8365mb_is_d(priv))
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

