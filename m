Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.189.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505120;
	b=OkRfVRrVvOg6cwdS/pup/zxQvfZXj/MnH7xpIhKCYJ9Heb8bJ8MHduKvNE4MLuia0JCE
	 yo1q/f9DInQVjTbkpghVCiWtREEYyGJPehZg+TOwsSFR1/j8REogqRUjkG+E0vJpL8ucD
	 F/S2Nr8TkGaM+mXJJgHsz/t95LNYvJbnVHtFVsCCmQj5uGcJqDt6ICNv0DGXZMB045ki7
	 exrbZGxfAcdbaSmZBhOG4OVtwqoVl8iEpwF1hv+Cd5nXHZInYIX51oDCLilJAR82xLxff
	 f9Oz5w8uuMjk076/bEpyqmDQ8c/7wrDXMEO/pZfmpiAcMkFVEnO8cLV+xqv6pj+c4Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505120;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=Vfyx/5l/DdFU3U6MgeX27V+poiCtxAdWMXGJbpv7Ye4=;
	b=jOevOPCKfPBcXIuVNn7uxeH41GUSlaX6wOraY/R3+R7gvjGjIB3Y8dv1MaKB40uhXlmB
	 729Y6JWAsvF+++2vHvAq1NQA/idJF10KgoU7Xl/iXOXCAoBYrczpVkHWRLbNo+nc+LoYH
	 Pjj/w32H4tD1EczYKwjdah+mypYwtSvIgcMO3yg9vpMLR4QtPUrq1Gzl1S0WfXFQtDZyL
	 KONV1KDoFzDWm1/nJiwmIlkck/JZFEKGtnQOvhSxM3YG11mBr83xbGzQk4wOZBrSKCOS8
	 v/zWgtO/i/7jiAZ6KIzZ5R4mOdC5qMyCx+aU5tYMhp89VuXmuUyehk8ymd7LGrocVbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="L3/09Ptu";
	arc=none smtp.remote-ip=66.163.189.146
Received: from sonic314-20.consmr.mail.ne1.yahoo.com (sonic314-20.consmr.mail.ne1.yahoo.com [66.163.189.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B5606DF2D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 173B5606DF2D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=L3/09Ptu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505118; bh=Vfyx/5l/DdFU3U6MgeX27V+poiCtxAdWMXGJbpv7Ye4=; h=Date:Subject:From:To:References:In-Reply-To:Content-Type:From:Subject:Reply-To:Content-Type; b=L3/09PtuoYa+3L3emZIPFyS0ycGpnAdRonommUsfxTWLWPFh3ViCqr/LDOkBv82YS9Fvp478WlqTimpsTAZZuR+EwEDI7GOn3BUtI2NwsNp9NcodxcV9WctO+BaYALHDOKRugQZJ3pvbAzhCpZnPqOaEmFsxWbgVc5xr9ggffbcFlIFxYDcFLcnbXQhlcxatynFAmU6obQLXsDmSol+80F+PZFMZNiWxHj7A+mdD9mRzqBBetw9NF20DOJLL9Jwmfh/pPZtGhjiNgoA/kdA435nJgEeGeqqK2cLxHsaBb4WQNSLYvzHUaNUzdBqbWuJaowIg4KKYfgl1IQKRB8WegA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794505118; bh=0/P/V2HX2ciPgWlI3Z8ltWfzRCJt5Y4WTJg2GrzhArX=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=VPr7+4fc9Ymo7BULVWtFXasVoKgDbcBrhG9B4Gd+wrkRseftM1Sb1EL2OFdlyC+wHnkuWKiwaUaZtrd/s1EMZ4zBzu2ohPwvX8pBtN1XTFfokWEwgBL5Sv9BM2b7qnVlm0ygZ+tRWlhohHJMaxK3YV1mSleIw8TdQ4DPRJ05Q8MVCJdKiLLyBNqGIA6AN7bTKpcVs7p9wkK3oMS2nBcdNzE+98cwpZ/gq2c3rkDUQiNheXteOZEPbh4q+kL4OzPCPM1a/W2ltX+z42i5+29xpMrPke4FJ/VamTXAc7unD/EIbQLTlL5LAHV5IJDZL7zL6Re8ouAGRigAHswd8/Wwiw==
X-YMail-OSG: cvYnicoVM1m2zJtooJb.FSnqkvipAsYPL8z9J1AGfo8gFRXT0PS.mF3L_shNSjx
 vQhkekKnOBzitIjpjsgkceg.BA04drpZYA4nhrudtdMqHHD2vAZwr8ALN_r2OpngZToDCwxyH8Sp
 L4flsBXiDq5KOGQuCPI65bPCUeSNWsNzjC0YkXmKw6Re9OWg7o0YsfdwR1dJ8EEJCpj_76Yaw.3C
 PTJCACoHqFWWclDjWo7xBBPHDc.tpGqZV0WN_q8HzEo0RpK6LYu3XNwdOyzH5QNEqvzTuHo84k6K
 h4eEI0bkiGJfEz4oKPaSzVQRhn4oLCd4T0wY4DUs_.ktXwMQeLg.BBu.mVNnm8M0JRTlUto3T6Y3
 W1FSFhGY6JheSa21DzPnIZWN0RvGcm.kT0fRAGOgR6sMOXGiAZX3pt1wR5rVkSMXmEzwChrAdjZ3
 emMHRYsBPBZT0xqgRF9gSUXHq4ry6qfzWzZ4fMWiOzMkjUsuJBVye_J3wjrCOuAffmHlBvhwGPtu
 HDZBp3VmBAk5CWlg54xGhxEmfWGVQ2htWB4oTyy23JhtgBMpd8i2uj2BgXVRXXJDICBWLRakTZ4x
 xgPRbKtv21lhizFgZNtP_sKsJZ04m7ldLfiTfxStuBq4.ZZbDk6zG.vgmJ0r2fWXM4oQgaKs2O7L
 8sYD16UfnyF0rGMzid1e8LGcxe5MI2djBTER8h7NDJIEEl9F3bv9JWRQ_opiWf_OY6viXW8iMUOk
 r9LqoQPPGWbI9yh8VjuV8CseEtgdB1MBARjQBKYOGbbjhGq8uZpn_YYtQVcWO3aCyxftEVXk0ioq
 9vANihKp_bNQnDYYQ9R8Lspuu1zodxc1DZjisjiEaNdF2XskVE1UVQ3U3TGgR1DxZBVBqusg2oYj
 wsyr8VJe0J.JnxZ_iISn2dw4.c2OoxWX0Je5zLXAHMYg4cxtZZJ5qN9tuyLZKNj58GVRy3KHSlxe
 VbVBy4BH.kZDkvDvAJccSTllgPnA6xtTscYJV4HxrMnbzwDuUg9hCY7NsK5vfCxsr3SSzPQpnTT_
 nVoKHWKlKNsyryXlzFQLcoxUbSjNCOyZElf6cBKfHnet.Lk2BSPu5tABIrc.6AYx12QZbuiHu4KM
 Kgk5cOBA1hhu354O86R0KmwkoxS.v5XtU.2jUSxtOPZkF76egYGgKlRpoZnFKCpPnXHV0ctXDOXX
 qJtU.3Ejmt9_ygH2vO6oWip34TSN.rROzA37NVpJBDyFBdGArJFTncfEuN9B8EOsUkndfz8knbiU
 iO2ha.Xw5wEsKUWuwaaocl6kDjX8oOXVOACwgIJeqEadad9FTl.WjHc.2XEuMAm._eEfN240TSFp
 c2A4tDjcZJsFjmymImLckHSQZjnUcOJksedMcXkhaQ_LOptGfwg4sSKieYCUwpOWkiGWmK8LFYkS
 WXwS83ugIk_Cgq.p7Acqrs8LQD7oajB.46QO9qDI4Oc50MG7QWaIGOACq5Ev0xODuMKG3BtFlJ9I
 Ut7ngEzICKa8zfhqJdhcH5Bk8.3oiH5vQr6hL4r5byf_PmGPbiQ8ASWRZKFjO_hFBFIreW5f3CoU
 plCOsvJ8c2EJZCZTS3_i2Ns23iedlVGnQmwPRFB.RAxMmyhIxeU1qN87jyNPuZarv9z31s_6gWbJ
 xD4ZVSmA7AU2o.XcMovQ1s7Zt2.f4V4CODMITHhq3kNwyAiIlpR8l1huWuIfoSbIkWx4IKT6MUmR
 yZVRWq6.UNQNjsM_kAFy0H39AelTKjBidlXCxB2P_BSNOK4avZVUuIjx4fqUCu0eUQCzNwYX1H9u
 2ktzX1yTOVyTnXDnLyBl7gGrP0aAX2JI_ykoLhFShAORhL.SvokAK1fGliIDwN0E0PqWvgYuS0w6
 pLnw1.34lRl6F4WmakdiQlOAoAmvh9ejt5pR1OkeriAbSa4XjJ503EFT.Kp62FMgNXe_y6.cvyoD
 6VcgPVMsV9tf.GvRTLWgbaReg6NiQskAW40SPjxtCWQvzemrnF5ySotTJe8Y_slREDq1a.K_7q7e
 6tOOXhFilxFmJHo_hx32j8SmzgqYuxIPVC.oElSaqKjWQDKQMAfMF7Quvrs24rsunxT7VZXauDmm
 OYmMWTLfCxY0IGgHYKJtCfc1zmdGFL8.p.huGxOicTqsq3VhUf7KD_TKwpvpDUSDX6i5CoICNcaU
 D0by3zGFD4XxJHG7pJUuXycmJXnTWLJ7gNNHG4cZGnp8KT06lq_CxvKn.O.sE_UsIFoeFldDGB6s
 Ms39MSxtrPbnSqXVlJ.9OjlbO8TRrJwA3Lb4hUu3LYE..103nDGAZrVasWj5eC7ErjVMc2VBOCvj
 bwuj2zR3HUXGI3eqOL269NAIWwFbV.dbN8XdsvSFe28NImXg-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: d25be1f1-cd36-43cc-966a-06efae38ba97
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Nov 2026 17:38:38 +0000
Received: by hermes--production-ir2-5dd9bf4598-nf4w7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 33c7a8cacccdcfec2d0f9fe14d5c3ff0;
          Thu, 12 Nov 2026 17:38:32 +0000 (UTC)
Message-ID: <24c9870b-1991-4817-90a4-e41c5bcac09d@yahoo.com>
Date: Thu, 12 Nov 2026 18:38:30 +0100
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
Subject: [PATCH net-next v10 08/12] net: dsa: realtek: rtl8365mb: use raw VID
 for PVID on family D
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

Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c |   9 +
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 205 ++++++++++++++++++++++-
 drivers/net/dsa/realtek/rtl8365mb_vlan.h |   1 +
 3 files changed, 210 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 611e58c..a13a5e9 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -2420,6 +2420,15 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
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
index bf1a6a9..7d805c6 100644
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
@@ -773,14 +782,51 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
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
@@ -842,6 +888,68 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
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
@@ -854,6 +962,9 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
  * PVID. Gracefully unwinds and restores previous configuration if a hardware
  * write operation fails during execution.
  *
+ * On RTL8365MB_FAMILY_D there is no VLANMC table: the VID is written directly
+ * to the port's PVID register and no VLANMC entry is allocated.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -871,6 +982,13 @@ int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
 
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
@@ -950,6 +1068,77 @@ undo_vlan_mc_port_set:
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
@@ -959,6 +1148,9 @@ undo_vlan_mc_port_set:
  * Resets the target port's hardware PVID allocation to 0. Cleans up and frees
  * the associated VLANMC entry if no other ports are referencing it.
  *
+ * On RTL8365MB_FAMILY_D the port's PVID register is reset to 0 directly; there
+ * is no VLANMC entry to free.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -973,6 +1165,9 @@ int rtl8365mb_vlan_pvid_port_clear(struct dsa_switch *ds, int port, u16 vid)
 
 	lockdep_assert_held(&priv->vlan_lock);
 
+	if (rtl8365mb_is_d(priv))
+		return rtl8365mb_vlan_pvid_port_clear_direct(ds, port, vid);
+
 	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx,
 					 &vlanmc);
 	if (ret) {
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.h b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
index 012c07d..c84b108 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.h
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.h
@@ -31,6 +31,7 @@ int rtl8365mb_d_vlan_4k_write(struct realtek_priv *priv,
 
 int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port,
 				 u16 *pvid);
+int rtl8365mb_vlan_port_reset_pvid(struct realtek_priv *priv, int port);
 int
 rtl8365mb_vlan_port_get_framefilter(struct realtek_priv *priv,
 				    int port,
-- 
2.53.0

