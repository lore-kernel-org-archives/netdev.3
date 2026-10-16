Received: from sonic312-25.consmr.mail.ne1.yahoo.com (sonic312-25.consmr.mail.ne1.yahoo.com [66.163.191.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A554704E
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112812; cv=none; b=fZrE5QwrlKaArGR65Hc5smUh8IK3B1/dqexSetHWPSq7U8KfN++ayXTbj8gNMhTUP8g/jsBerkZgO4fWi9P5w/vebo8gHciZBy77MjnsBhe7tDqFVhT9HBwlzFMhoxTYYijiWuLgBU08GjNNu6GPTu1ScXq4vJpFyBfXwF0pojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112812; c=relaxed/simple;
	bh=nIrisqExa3+LKVrsQQHBoAmFRYsnyusTTyU3+EuI/tk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZhinwzJygh3LnDSUY7I4Db0UThdKIwaqnobq4xPn7rw9sxsNv4/dc5G5K8NBoMTytTgYQi//bC5xbMU5Og8PgExueCNm6HJ4s089gxXvxiQU/mPyTAjpRcOP5AOGdt5PRFHpx90n/nwh2xtDgM88DBQQtWadeq8bhEN4RBFZQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bw+1aBY0; arc=none smtp.client-ip=66.163.191.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bw+1aBY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112804; bh=XInlDiNU/bYj2EXXO3/+dnTal+L8DGJHibVbUEbyr+8=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=bw+1aBY0syBe7+euL+OPMiGoiQ9mCPzfj9VRfynEaeLa5Kp9L6DpMq6IBrOOcH7yLVvdHc724guBOyM/fCK1mZbAqW1Vc2f5djSSH4G1DwnQZ8JogYk3G5cchpPudH9F8bnttjcwTOVVTA1GflpS9Ahhq9SqhBUwBeqmUmnaYYdVpLsCMHBi0ufBGdqVMZttGixU+Aww/aAiwV/onx2NHIMEGuZH4bh487HYD6xEXmB2ETH2lGilxRgIEM97+91DiEikm47Lkp2nX+TmsQpy3uobecVIfmBcwpoBs44ufjx2aRLFn0or1wZudUaJXgPQED+EEww9sPE/6DHA5P4Dmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792112804; bh=IVq4vDod6ImicfqYBl3i313KMdjeBN90gj3kWK6Xu1y=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=uUspsi5Dz3+5NYpstyYOedNDpSTP55OkALBNyOQ1SYVWl7aWKsv4Ekh/K2F9WTKhFGPDru3eDjfC3v8ozhmZzz5NeF2Rv3zdYssNXJumpamyO+FnhvEqC+6k1JN2BrY7wH1214puh/I0AyWgPqk6iZXpnX+zmbHp3hPuP+DRB8zndTXeGcIxkoCzJTuQRI+AmkSGVBDzIA8XAigpElW6ZbeTegnNeZSIEDlmbxzDozi1pSP+1ZQ7vYudDnJyfchEUUM/jApQEbNXwP0yzWM5YsNI7L3g81aSlve9T83mQZmuZWJkbQQ+hJzOE2L8jfZWu3V8HQ0X4KHY9XMjQcO5Bg==
X-YMail-OSG: Qexm6foVM1ljD6Qc6haZj0I5nIwgPPad61ZhQBkLiqfdQyMuf3A46vmLwUv1dd8
 YUwu3CfYPkc5vKp65hExFpl0Jc6VhLbsoel33uTgmpyFM3O9c7ze95lf2xadmFXydr8ZacKke_a7
 dfl85RuQwFdtVX0rfR4sqraLAPqSbo7lw9YeDl2TXq2sXLfMRgTFh4_7mODFfGzCpzqVwiiSGOPR
 f9aavA6AWTV8ONF8c8hWrPtKj68wM4s1C3UQ5MtMIfrKXGpiWsLxMfZx7KI9crmbmAZhcfgDlWjZ
 SROeoVvG2EgVuVrZrcZ4WwxMIoq0UFQ.L3.at1Vy7mWODa2C4OutIJzaHuOKwv9sKeHkF0K8Xwmb
 He..twnL9UhLkvldXsCwEK_dC3AC3v7qpWbQZ1pHlikeQrp7oFSpQgqSIHDjavvVVqgeR7rSn7ul
 IVmneA3V5yAyOk2Lfwo6yjcX2LEtpVBsH9kBBaX.RXRXsH8Sjxk3TX8RERgyiimRPTqXHJjaRL6k
 wKqrjftdalZtskZ3MDpYokAGWi0y6n8LRjyR8.2lpqEVmjX87eVmNFkt9dqTF3HwNNlfMHo1qAcm
 HHAGJGK4GMaET5KHI9cc7LQndTMSO8Fox2vACcnv0x6ZkqT2k9DBbvroaznH9QZBoLarwQutFfrJ
 f9D3_eQwHH7TS7oCAuvFsODgwWfm4fK8F24hqrESmkn2ALfgZsBTWdwcLDgVXMET61aqxi2GzvlT
 X0nceVPNA5k9Fjp.8nZzhEDa9zSvuDx4DKpNHwg.qdLYSDPLp5KuEMNoxulV3VMJm2k9_5I5.qPd
 wDjFNUtr.6m.au3gMcgayr29_esEIhRRkk_B9romQOPLkGIoicNvpX1W7OaX03NyS0SAkDrUT4O9
 QhxLNDmhS5HpisyFIUtN0NYcdOBZAK36a6NYdKX.enBqiklwjd69W5mDJ6bQ_5mtyXLabI_Avkys
 GgPMT7xgFgEmxfY10LF3R2VjEMGmZuf6JtYyKqNka7GXBggXMq.XhJXF_FB1V2yjV_HqtfAfjkIK
 notZ8jAjJ9zQfulw5HzgSYvYs6IgFFBvWfp0ChQtzzWmXkp89n7imWIxQX0BkDFdLl14B9VVlioD
 jlbYGyeosyun5JcUAhzAWP3vIF83EmMGxOE7ceNp8OURjbZuIoujL.2pY6m0gZs14DSvvhZNqRHC
 K0.VX6_m3EIKe7izPeEcttx8BeOsWNaXFtge7HRDkiy.jnlECPqz73XxD0wljvJiCX05NS.uryBj
 QdsBEn4FnK9dv2FccEEow_TYHcPV4V_e0ssdgjySDJg_VKnBViVxrA2ghEJLY6ED0LtauNrvjqJP
 EMWD3c39piS4Ty8d8Q7NYsY6.bLo.xZEnWVrS2TeKFm8t5mkmum3VgEtIoOfNgpX7C7U9dIVk1mL
 qICeSpq9aglf81SGRwyuybCQg28mtPVfkZWt444wbQboyl3FI8EXOJRAGqw52lpaCaUFVgsroqsy
 dYy189iFQwvzLkcx6KHMiM.qBM12kXnk4r7XtdCKGPSA0vWm2tL7IyQAn8nF_UqHN_KhymV6HZ6b
 d77_FPlULo5U_Rw0Lt04XILcgqZAGDWzT5RqXM8F7uCzniy3ZeHJxDJYYZTpCLygpmQdXb4k6mqn
 nyM2Xdkew1RQZy2ZXIMVVya4pjMSv4Ty0FRW.9RveAZg95gpxYy46p3iWPiaBs6yEhdeg6GkdpoC
 ArqeerqkB2sy5d3fkM49Blc4PsGekXvakSas1dgOhN2C3870TNQBNWA288CVD6wtPllXU8cvAeH3
 fLPy22PciwAJaGIUttUeoz8mdkpuhKOhcuwsQATEH9iBXgKajCrDx13CkZdw5wLn1LlIFrfl5pXq
 Sj_wNxV1I1oQqTpUWO5mIhmqktnuXl2QxBAQ3EEdUP.KkbSuqnpeMg5Li4YT_q8n2cNKmlCHqePn
 Ik2iHTR0xQbvQbWRX4G3P3ijNooRPEP1huj9oxCbJrfkoC7X0HEnhAJuOgYz2.h_eBKu2O2BieGe
 zsVMtGsJl53xOajTCOBeCsCOwewnw5NYg39DHWYj1u.Ahlq51sn1j1oe1VsRrOqELUW8T7pSKoQq
 fyuQ8tpCVviV8KkxHsH93a4Uae.XZV774TqF5febCUkS5Y3mTACFLeU7cF6IA2YcnvRqStKeI1j5
 dluF3Z_6OGmyvDSlG4cFYwhZvPBUF3rrGf4CSGbr5_aMFzT2PEfFpR93Wma_u7XD4QKr4AjpZiPZ
 eZFpQ5hPHKxXpJJRTlNaey8kOa1TZnJW7d8f3FEOGvqsCI84X0Q2uAUyyACkgCZXNxh4cXy2ndTV
 hR9ZY_z2bZqOp2y1lUPFyDgz2iH2Xq0nlpPuz
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: a898e371-11dd-43d2-8adf-b242fcd60286
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2026 01:06:44 +0000
Received: by hermes--production-ir2-5dd9bf4598-zlkml (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2691edfc3e71f6adf25ccc4112c7cd0e;
          Fri, 16 Oct 2026 01:06:40 +0000 (UTC)
Message-ID: <4a8fe6f9-bf6f-48b4-b4ce-d9a1d773dafe@yahoo.com>
Date: Fri, 16 Oct 2026 03:06:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v6 6/9] net: dsa: realtek: rtl8365mb: use raw VID for
 PVID on family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
Content-Language: pl
In-Reply-To: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26740 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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
 drivers/net/dsa/realtek/rtl8365mb_main.c |   9 +
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 205 ++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |   1 +
 3 files changed, 210 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index f00c1c2..f8063d2 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -2356,6 +2356,15 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
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
index 36f0d2a..f44d7ec 100644
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
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
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

