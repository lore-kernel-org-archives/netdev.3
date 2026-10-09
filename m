Received: from sonic312-25.consmr.mail.ne1.yahoo.com (sonic312-25.consmr.mail.ne1.yahoo.com [66.163.191.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52C3B9942
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791523206; cv=none; b=t7kZAK9HmA+bxjwUpc3ZqKfWBkA8i/dvENTO9pI9M7OodQYD7WUi4u2cXA547ou7NnMWOyqBkRcle3NlzbBZS5BX30gSS0Evi+QiXZlEo66tLDAICgA03WTq9SfwbQdgiFOMoa9Xp+p7004bT9fBB+E03eMZR3ITuPlfpBZKBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791523206; c=relaxed/simple;
	bh=6T96oYT7zGa2dhkVb+D4GJAntXs3vXLAL0gIr2plLeg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=KQUfWVzEWbI8rMy7a0+YOq6mspI6Ww7T4jSJ8lA7HvxnVf1wn/aiTXw2WcsV1/+9Omz0zluvXsJ/+EL1Pk2bHjQFn6wlnRexhP4VGtIx8TQbU76OJ8OAEUkVpnP2gBTfLUx6SPpkmORm0+MU9rjPJBVa+tPICpfc395g69axIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bRAhu5Qb; arc=none smtp.client-ip=66.163.191.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bRAhu5Qb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791523203; bh=qFpiFw6MgSdv37Ns6VH+LneeKQYBHkufBN/Uv0eIRlc=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=bRAhu5Qbzoymo5vhGCT5RkabiglnwK5fLcx6cK0pSEpDW7KKjP1Pf1JDQBRVIMUPBLoMCnT/BsiupmqPBn7FRKvNmmiWxQN5g9LtSd1Woqniuv/Z6GbbV2PqqMfrQ+G7d++5ywcLG6+yd1g1lAbOTZF5GnNlCMzK4K+Knd+doyW/yDzXccprGNUKiPuUV+ArvBkZFW2W9obQ+dbaty+8sbedg2Bufci0HeROXnaQVILSjbIHyGskYR9cfowrmXtcAubRMAMrEY5aBJpBGC7jO6ehyMJDF/3Ot8JLtE6flAgYpKHAdVUqc0VbKUdmKKU+0AX70JD64jWj/aflpXkS0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791523203; bh=m4EAr9K8dJnYdISQnX1JbY95I5DelHzW/Mq/TgJL51X=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=gLKo8j+474P72OM4M1OCpzN7KTdFnf3KMqnogmnGgJ0t7VZH2ILeZd7tpN5DXPx2IwR18Wn5KC0o3C2fpP3ctEpKiL2e/IdfLy8FG9XKK4eSrmCSejzVkeaHL5vkSM405QqtWnQDx9D9SM0Lm7Ew7dIzc8K5XzWFCYF23TeVZAPImPOQ9MYPHACkgQzzFKpKWE8IqOabV3CJwrQDe+CFifDDyOKegz75eP2dlDNHtx5YZeg2zzRnBOAUl+hoAvKQ6mAOH2NjEkb/Jdh4tPc9Q7hMx8XUACq4FfafyRjIEAVmOAv6xCLkDWgFTb37MDpJICA+X6OP6esjhYdSVVh2Qw==
X-YMail-OSG: AN3bIUYVM1mJYGNDbXCdl85u5LqxlHWpZGwlzEAgyMYj52xmDBZW4Qq_goT2Dlp
 zU2Iq8BfjdCuYVbf9ThSghot_pQ14wYXJoNxjPjtzxJjq4h7q.86tL.Wqr9ylx_aOW4gNPFGPU2e
 6DLcl7sewkZf4cyxmv7UdoVc3aYzsYpsAi8K4nbCLg8w7aSjR98wnMCZQwyPO41PQwFsGcEweUcd
 TKm_e8n2pxKQ9ZOo.TThqxOSZvr8EjpZ7yc6FxbLUNGdhpwSrveqTeCXoPqk8TYHS52HEsjz4t1D
 msItvtUyatspHlLJWXYXkEyoXiHaAs0flZMtmzHmMfJte3oZwg4.jcm0DpXkCSkW4CfY.yZQ1l0I
 .nT2RentgNVeR.bg7raIEzQfDbS6X6XoE8NCOb2OSb48H5WVP94KOAmLELX9__iQrHI7dYP4HasF
 VwSEbKg0i70Ca7EqwpEICpyAM7BQ63jXWvjkOI8fOX55cwlTUtyolPIYdKtJNaI3550nzjdB6aGl
 SGBs7RtS1Wwpe8bNJrfrB4tTm0nTCWe0CQCzfiYHX3953f2hu5bIri03L_32Y5aErrfAEen2vFWA
 1bqPGivm3RQMhYnxij4fBrV7zgQxYx_fuG9OHAlsBOHVlozbciPLhe3XG0U8KfP69MoyfUE0b9Ts
 ZLMuSbutkuQQMJ4_I4zw7xTsCNEMn2mfeqSL3CNj3Y2Zep1PgpqdF9EX80v_pG09CMA18AYB5T7z
 0dJ8ais1tt4eJkpdSJ1Wcy3y_C8WQmkAG5skgSCk9g0tE66m3cCeuxMN_.nCHXIoEjRfHGozKFRl
 whuTA6ZeIMFnOqElaar_KPiLGL3Fa4kJjB_Bjo8Kyu.FXMjLrUY7OeK0hich3LwxroBLYJcjV6Ce
 t6Dc0Oj3R.aIxUncbF9PPEPAYR.AaPU7gGuYMsGSLlKZvOP1oYidl7pVLZ7evS43dFOKlmsVj7q4
 WbCAcn.h4kig9NPM8nB8FpxR2yrJRKYZmrdTABqeflVUPbXWeidr0GKsjE16F3tK7rnB_0pV6Kpy
 gVupVIW1yWpMtSNeyfp0XDgqGFvFOZr6CyvCpjPBODzOYhGSXBkDld0teOtRmrLEb2v5phBkUwJ5
 Kng_yHcOFyN7476rAw9Lkg7SFFrDTYwD1e__R_EIpNwkMCmEDDHns60DAhjrDgw9ZRU4_fqsY4Nt
 KPjEKSOvRlBYA5K.Hak3DxhepTSwIKlIkmPzicEQx7i6rz.VixWeWemVWJ_cx8tx4_edB8w_ohtN
 mJatmTdMAh5oagrSjvmkA8gybA2YYpIq4_SxOnjdfRqAoy.saa0ac8HAd6.LrTkRRr0TIxxrAk6e
 KQS2hZVm.BZfky.VNzPoZnyhtIK3jFT8GGuF1TPiwvm_hSgguE7kVedBlS1eo3ZHPBxFsYwyc35y
 DkTpIwakhKuxeeVAT0QZFMEIPKddr0hXvxhwh_IB0T6WI6QfiWn_51pXQOIDhmzrfwz4OuO7wSsO
 Ud7s4cRavTFhNKW.KnWFaG7s4pCj0yH8vMJnrqrbNqXXuDQX7Tl4QzOQeYBhhl2Um16RFBPaoiL1
 6_1O64APR.quYkzD8qmv7BtUW_BIECfgRwS25TVs5Zk9_7nnJvwKgc7kfiYPp1XQ3XMVPp2haBwf
 _gPdVgHH.8RMOsNGkfmoeg54YHEiM32jz7Qey7yC.JeDpTEr1dT2L2ubpGhPwhReS0_ehvCBLBks
 K8Hiaz1m1BfGGQ62CNOJnG2kaZZvRJ5d7wvpJ6Bm4gFbRu.GxHwVPzDeTNAANgatp2MudaPIeq7c
 O1Pde96vQ6Ly8nKeDb6Vd7P1FvweEDtZ5JdessOrwGvzBU_Jk6RBZ10LlYfYKDYvQzlBOSDsvrqy
 U9.U0BZf6B7Z_zurUKKMD6M4_PjRYsMe.5gGRuDfymwo1ZX8_vUiM4r88GKCNIMf3FjgAlVEsr1_
 tg22E6KC1YeeE1j.P_YNIFDz_v2pj3IjH19xmrdJBj9NFNxSJx0vVK932jo_BKN2DKV8gZ2JbYTA
 2mF7uv4VYKrXMn2kmVSdS8cRtPY_R9wd4Xj9qO7tRHJGEMlUPWEvOQoVn8yyMYgAOAbKMWhwRuay
 96PzGvXwSsT2mHqYPodGvOeZncLdOn4pxs5uCFvh_TdKG3JvVRnE7yCeBBWVHCxYIZuaETjBYB8o
 vudAa5YW_5cWayqM03fAzCLTvUNCRCS.VqPd9vojYbvFrX4HH7IzyGphUPlBeTjEXiMBwvjjkAsR
 nICYihB2gLbWFSSCHif50Zc.h_w8wGrzpEmHHeQJ25GvDjqh5sEKm90mTAxXzYQol1QibtLASglE
 FsOmf56Lm2D8creIxOUKRlXq6ZW1bewHrMERILw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b438b0e4-be9f-4a8a-b9b8-1cca6c13a4e9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Oct 2026 05:20:03 +0000
Received: by hermes--production-ir2-5dd9bf4598-98szj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7a0d58f9a9f5fd4a029b596fa8d6d895;
          Fri, 09 Oct 2026 04:59:23 +0000 (UTC)
Message-ID: <b65ed622-c511-4acb-9661-89ed0615e0b8@yahoo.com>
Date: Fri, 9 Oct 2026 06:59:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 6/8] net: dsa: realtek: rtl8365mb: set/clear pvid
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

The RTL8367S-VB (family D) has no working VLAN member-config (MC)
table in hardware. rtl8365mb_vlan_port_get_pvid() was already fixed
to read PVID directly from its dedicated per-port register, but
rtl8365mb_vlan_pvid_port_set() and rtl8365mb_vlan_pvid_port_clear()
still went through the MC-index allocation path meant for family C,
which on family D hardware writes into the wrong register/field
(colliding with the neighbouring port's real PVID register) and reads
back a VLAN MC table that does not exist on this silicon.

Add a direct-VID fast path for both functions, mirroring what was
already done for the getter, and skip the MC table entirely for
family D.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 136 +++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 0466e8c..da517b1 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -810,6 +810,64 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
 				  val);
 }
 
+/*
+ * rtl8365mb_vlan_pvid_port_set_direct() - Configure a port's PVID as a raw
+ * VID written to its dedicated register, for chip families without a
+ * working VLAN MC table (RTL8365MB_FAMILY_D)
+ *
+ * Reads back the previous PVID and frame filter first so both can be
+ * restored if enabling the new PVID fails partway through, matching
+ * the rollback behavior of the family-C implementation above.
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
+	ret = rtl8365mb_vlan_port_get_framefilter(priv, port, &prev_accepted_frame);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get current framefilter\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->map, RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
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
+	(void)regmap_update_bits(priv->map, RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
+				 RTL8365MB_D_VLAN_PVID_CTRL_MASK, prev_pvid);
+	(void)rtl8365mb_vlan_port_set_framefilter(priv, port, prev_accepted_frame);
+	return ret;
+}
+
 /*
  * rtl8365mb_vlan_pvid_port_set() - Configure a port's PVID and associated
  * VLANMC entry
@@ -839,6 +897,13 @@ int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
 
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
@@ -918,6 +983,74 @@ undo_vlan_mc_port_set:
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
+			dev_err(priv->dev, "Failed to get current framefilter\n");
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
+	ret = regmap_update_bits(priv->map, RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
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
@@ -941,6 +1074,9 @@ int rtl8365mb_vlan_pvid_port_clear(struct dsa_switch *ds, int port, u16 vid)
 
 	lockdep_assert_held(&priv->vlan_lock);
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		return rtl8365mb_vlan_pvid_port_clear_direct(ds, port, vid);
+
 	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx,
 					 &vlanmc);
 	if (ret) {
-- 
2.53.0

