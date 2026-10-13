Received: from sonic301-31.consmr.mail.ne1.yahoo.com (sonic301-31.consmr.mail.ne1.yahoo.com [66.163.184.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71C274B46
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880998; cv=none; b=j2g1eR8Yn8CuwuHqRhL6eDIjm1l/TkNRuLd8UMaMXMDbo94isC9Pb6MP3y3NVUHoCRnmPF2CBiZWukubHZ2RNiEZNZzWPBT+stBOjHxPsmPyBXRp5BIPYpnXF6OPH+zOimqBLOzl4N0yuSiFYLGdYBkoihNa8CVmHlX9BuYWizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880998; c=relaxed/simple;
	bh=/Brp7QSRdQO6frrmqNgaSElgY15n23slStx0IslDLoU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=U7UStC6xNeBicR1lJhzvki1CX/Opfl1rThrYFVfCWFNpgageN9FOjyzZmX5s5C+oLjo1hQO0bbOgzexj+OF7XFMSVXYAW/Lw9O0Kw7HA8aKP3tZ/v0fvfNmhUjo82IrpKdyii62dVaVs25051CpFxapo3YXHtnQVhBdPLrZMAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FesvdzT1; arc=none smtp.client-ip=66.163.184.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FesvdzT1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791880995; bh=ZItLrASL5vmf81Nt9amhNwkA1b7RHqEl78Kz6z64tM0=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=FesvdzT1Sc4ReiGl5agEwGXDOvmGVzxh+Vu/k9yfD/7rMBMeAvLGm3tIrk6NAVvzUuTNtgz/R3YA4JsOGTx9NJqUzjXXnBc3Bbarsgeiy7zK0NbS+dZpSnt5pQcFBBHROEpMfFAZeHfBKk5/cdrqXIRWMfpfuJLGMOPS+a6+jc2vcHUbFQ7X7F4vQYU7YNgK4hlh5l3UlC/SKctjo0WIQ2FN9O/xe+T+bACJJZ0njUiU4TovO/NhUZpzItleHMsMFG+SaiSwygrKYF0k0MWhKuGuNk9hKGGloDbHJI30eeu2cxMKvLQIvL/u6OrzdOoLfbic1JIzAZTYZzf7BiGaBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791880995; bh=3N1GikIzotNohaxeCc3FWHcwc0yyNoVOjSQMzQciAAK=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=h0FcqUiy8Stku5ZptM9aPpT9xlD7cNrw1GAIDTKIPebBP8XKds8zNFRCv6femywHkDnO0DIYSfmzFt8eRwHKd6yvkqBP+TzcRas0KHvlCnRG/wngrmoiKJpJuwUfDyOhX3pJemgkUq4nUbSR2APC55YYqt+CUR00ixpFiynIsgVutglKnuvlhtHUIIQqg8Mttj2DL46Lio3AqK2uBR7n3yXtp8d/x43zvmxPEUglT4mqq3znoqR7GCFju7/E1Y6EqsbajdzL/YWNFGm9v78ODxhAxhyf0OSx770bW91EfVHMhSQgXvwZ8k2zT3/t1sHk82pkY1csE9h/+rP8sPymAw==
X-YMail-OSG: 8UihROIVM1lShCztWuLzVvBEO2fVzfKnWsasIfscklkmo4KzM4NtDjuFnr814mx
 L8eqjqU1TD85phwsjQS7Ykk8kjOx1pPFaqYW76VuJi.opF4t4PNocMgLGdeBqiy1oPbj7ms9.6aL
 pLRxmCZ4pz6CQvP.Al1LeLHupljgZHYJX0VnWGNqM1qmu8kmpLxuajjBovLgLq6qLMpoWiHECTM5
 28UOXEBSY_Enc7AEJBc_Up5DMvcxydYU2nxxK1IGHfQ0g4oX6fV5ywsjH0oVrfWiUNd0Wl40SZW9
 kK56yRdYh63MGYeRkGNZgpnCLo1X4PX3wzlUlI_vL0nEY7c8JBf8Ro3TiRUeuNNc_LG9.RCPWH3F
 cIngvwlQImHunSaKtJ73bcBi5kpAdwSKWQsXJXK2xo8k8jGN2QpGTjDw4W8VrDtcrvL9ezmX5p2B
 9nwDHSPifOYy_E_jB_cqW7mzQ4d2jrd9ZY9Q0Q2bIWCJ4l.bb7mLEnqUk4nBMY2jyOOBMrJgGhS6
 sssPXld2PmKL4xs3Sv_WouDV2vRMQYdkOoSSbQdXoONVRFg7uXk6BWa6ZByjFka.SHZRur0bFnwx
 9xYDKT4rjaIZaTCUCSOf_6kSQ3MlMVARQ2K7FCOEW4kyb4QeNbcbC.mHTgI1pkxGJwfTUsZjcDhN
 0XurSYoCLgzSVSYRaJDTeNf9o_KiMfoa4QD9U.o9HCZmfvusym1gW1TfBEY3q7Lqz4S472edBYdp
 4Nou6LdqXXIKH7nzUdqFiR151spxXBmStMTTRa8v6WFMQ5uZMBunpOHCiQdmQtdj.loilif9Ot0S
 OPjSpT5nrItaJwuiny9QxSvPvOaFqyamAqnNtwia_s6GZ8t0a6Keku7yvZ0.1SfKgov5QITobD3P
 ymOxdcqnPbmomphYnEDJTb5wr1DYwGpAaJiDl7N.NkiMMU31o.3h9j2yfqTMi11ziZKt4.gez3ZI
 RoufgWY12CXlhsJhEgJYibyCXWtCw5ftzVMsNyS.kQHaE3juWfQvqOEmZTQhDh58hfifBS4b6rHI
 Q0WXR..JGKpTyC.ikDVZQAy19BLNdgqQ7Or23H.ZAmn8YXHK5IQBMJcp2UOzF6BIPPllB4mZl2o8
 gURqeHIa4Z.LXvGJO3nGxjx.k_lSXy_CxuoJHcPFLqe2S10xAC871DGEQowm.5XeYLLcaWZkUWG6
 fB9oJ.Nw.vDpbVRPpHrrmkZU1UtRc3trg_0GtFzPrAbjnm.r8KiGPyvZrp8h0KorPe0dthAZsaCr
 dG_nf5BTRWcyV7PC0KVtpGktqJXLPQVR674JjKNlxfE1a_E9HbVwBy00VTKMHNV0Qv55GNBeLDLA
 eVO9aLYH6MoBsfwLd7a0T3FlPuYx7UE96i_q2OcrkkopPy0.5.Au7TaW67dJSTmmY6cxapU7cAUk
 TtplP4GyUMBdsxy2c4RXPX7hoxrOlVERZKaf_ZwXTFcF1jyR8RIxUKwgIqvsssMr7JvodDIncn_9
 EeGGEgLV57l6S0Po.sfG3AXi3JHqpKk.qL6H20TG3okxmyxVEbzOMF4b9s1DtapEKEuQaL0vrEx9
 qhPIt4wpiIU9MqUFk8qgAxWJ0z4GRe9boHctmcz8pdLa5Y5ChChqAznbwnuFHfh4TcWZkcCDPkU1
 8x3UYbVCwkWkn4r0PD6yuAGUui4euAgHk1DhhMT6OhAl8Ztczx.cSK95yIccIrN2RCOnANUiZOQP
 .DeuRI1d.xrLW7wfpvh6WAH42JGdc2uym_VkT6nDc8KG8lr6K65gdtaJdQb39VSgCMgWG5X3lSNy
 0_Jl4_8FJEoUYBp8fJCv8bVhaj88EEn4kzU8EuNJE_8KkVFT3ebhCWz81ibiOoKBgUdQg0qaC_tE
 WDU63QBUdNcUUelGEB01GMBNfqvQpEyhXjYtT9w2X7WalY5vBxsCT3vTOr8Gp7uHauPmjWz1fpG3
 5JOEWlj6R2S6Peo_PRx689hdMOdmIg2b0GPxj90rdeEwfNi3.QwCh41NLsajgklf.ze.3s4R9Hkw
 j41kDazZ43V7k9Xafj.cdWDXczxONkrL9ki7enKRhOeEUn4C2slsuJnmG0cXdtzg4r636Zoxoang
 lzVpNThjk.aW9FkkitNpVvYWgUnSq3y_VbG7_RyaC1BH_6IwcwUQkmR5yxr5oOqcD0Fp2O4o5A6P
 3jitboF1hWXN5HMJIAddSBTF8Wkti4R3tv5yJLUckx0NqtvcdKBAPSnEeMh5uiFlRQTNKPHtyJF.
 3YofhYBRAN7GdhtcenxnJHU2224IsT8jHToYYq.bTW3MxhmBdLSqP8NSs42bsJjxO7HAP8Vy1_nV
 Om2ZeB7W9pJo-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 94a26fc7-be7e-4af8-85ea-558534f38e98
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:43:15 +0000
Received: by hermes--production-ir2-5dd9bf4598-ztwl7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b02183a943c6da54d5064f6172ebb300;
          Tue, 13 Oct 2026 08:43:09 +0000 (UTC)
Message-ID: <eec9ace8-57dd-418d-b26c-c64fcafb6f83@yahoo.com>
Date: Tue, 13 Oct 2026 10:43:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v5 6/9] net: dsa: realtek: rtl8365mb: use raw VID for
 PVID on family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b45a3350-44a3-45ad-89cc-452c25edbd7d.ref@yahoo.com>
 <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com>
Content-Language: pl
In-Reply-To: <aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4@yahoo.com>
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
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 205 ++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |   1 +
 3 files changed, 209 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index ff9d9d1..9ba31df 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -2352,6 +2352,14 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
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
index c2cfdf1..037cf92 100644
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
@@ -750,14 +759,51 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
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
@@ -819,6 +865,68 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
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
@@ -831,6 +939,9 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
  * PVID. Gracefully unwinds and restores previous configuration if a hardware
  * write operation fails during execution.
  *
+ * On RTL8365MB_FAMILY_D there is no VLANMC table: the VID is written directly
+ * to the port's PVID register and no VLANMC entry is allocated.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -848,6 +959,13 @@ int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
 
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
@@ -927,6 +1045,77 @@ undo_vlan_mc_port_set:
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
@@ -936,6 +1125,9 @@ undo_vlan_mc_port_set:
  * Resets the target port's hardware PVID allocation to 0. Cleans up and frees
  * the associated VLANMC entry if no other ports are referencing it.
  *
+ * On RTL8365MB_FAMILY_D the port's PVID register is reset to 0 directly; there
+ * is no VLANMC entry to free.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -950,6 +1142,9 @@ int rtl8365mb_vlan_pvid_port_clear(struct dsa_switch *ds, int port, u16 vid)
 
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

