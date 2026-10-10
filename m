Received: from sonic316-20.consmr.mail.ne1.yahoo.com (sonic316-20.consmr.mail.ne1.yahoo.com [66.163.187.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C03C8C46
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661352; cv=none; b=t00juWVNL1elIfLO+PM/WWdOmouWUoxeDkcn29JdjQpdAgYdKpCR68TCJ9FGggYq8ZhpdsWnkhgNjaocqkvQ8UAzSYw9IvUt818sOr3oTJkhqA3RHpovHl8MpJsYBiIzWFBXL6Hd7plQv1uKwEYuui+RglZwZ9yJVPTjdWnpIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661352; c=relaxed/simple;
	bh=hkqKwIm61hBmXyffS4Yq1MoeFi+Jw+1uOqOzS7uu63U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Rx7KWCI7F/xZuvIxX/EgWCV065gH009SCpSPnhOcgp+guXvDR4KvnDqTq9BYR+Q3uFTxozDZMVcuQZN01pqR4vyiX4m+jyd8hVU56gsGxQgElAGtZhCcWiasnT4ar1yiRyr7ftGtwKTi+gnawmQGZvGGVGRj54BI+o0COrBf/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AtYRCVko; arc=none smtp.client-ip=66.163.187.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AtYRCVko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661350; bh=N4PeKtjj0J/1fDQzS4uC9qHd1EfoVcz13vG4uV7ge7k=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=AtYRCVkoIuRTU2bvwBYepBT0WXB/4bOZTFYVFd/JYM/B5KfpzbUFubzr+cYIsu4EAHFOuFh2oZIf7qNx4hU05pQTZq/FPfe3ic2wZ94sJ4w9d/wVhZaPqITs9GiFrX9m2t84OF/cwb/A8RSYRDSCuLKvZi/j0qVtEj2UNbtFV2PHY32thAvQZ9PpoM2f9iNVzj5ZWX0SjZJmuPsV/rx7pkyeWcq0Xi+HgpvTLNCRLsfN5sd9DOu96d64EraAmhO8gEjrUVC96gkg0v/Uwkf2hhKFsl9PLDzveyToKjyFadVGjMxB6oNPQbae4ulQ4e9IY7Vr7Tnolku2p97sAx+IFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661350; bh=Xys49Xd25hXf4MNrvTlCihy6vMYa5X6q+a9YmIlc1Fj=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=d2F4x2XvF+arui9Cxyau999oN5w5Q33wKLp+62y3IR9YHhr3eTmCNM/6ohR3M52OBLe8kFnZ1kyPi8JjSI0oxJf/WlWPYP8VnPgJBnuOupHdfX+hcYr5VyLDEVkFtJP5cOx16S9fK9x7UHKCsq2GiHmAqbDGejCvSjSl5aayE0IFtfevvPiy9EO/BInXmVif9P8lOkHIbfRIhs7CN/pdz/iWpvHj63NmVaeUCgu9bubLM2kGcYRGP219C/C9+F6EDB66WEtuZ+LcT7fFq+ssgwpDLIuKFcsUzlf2QOJausPlArR2BEyEXeGoLsovnlWk3ZmVjdDzLzPTF50+5NY/9Q==
X-YMail-OSG: dMZOJDkVM1mapa3WEA97Ah66OjvU3Bp3fpxs.dBvPmUhHrkmXnXE8.S.xYnb05V
 d3Y8xPDRLHBpsgTNcvePt.MNNpGC0BJo9cXfrWaxE9vJ1FIjlq2YgL__UtqGc3u6B8oTKbufZ6yC
 emAXJxJh8ZxmiDDvOlPYB4YhNGRE3xlbSzKMcJ5eCx8d7xw2umi06VvdmKSiwbsJCz6B93k2T8gn
 kBCRf.pNVX39IMd7Ic3LuJLFYiwx7whyejMBFw9fkASzmrxN3taLovtXlotbDlYqVDGDVyiRGhsj
 JbGTXd1FnQJ854Jtcm_qxvQSZgYypOwMG_yuwh6NAnFeBJEBwY_hz1y5rjRtUY1dwM3Sp388XxpK
 18wel7nMuxOQ2GqX_zBfobfZZzTYSUGwQg9MF1ybyYBEZpcOj0TWC_bBSKLuNopfm_J9_fwYBeor
 cdKefxo1t1ompv6sboJ45hj_oHuohHFvmtr5M1n2GkTAfLXtOKCUfSiYm0GxHdINHkpq4m_5_grc
 4P1swIkRc86ttoTPrFtmygVR0JeixvMnw8_Hj_ajADsZexh1oq4KstZbyikkmy0SfIeIJcB_s9xq
 bkdz9tud1AZmv4sScBiiWgXPSzf1JsOAzRhkcVdQ_.kU3qNpUdRTKxyxtfcbvb1FiH55K.b4XaNb
 _5mIe3Ozs1IasoadqSA49P5ifCNlEgrnXE.EUdcnO7vCR1r7RqETW2s.hlYGR.7PDTVY6fjEGmPt
 DJhGx0B2xNqQx4pcF6jJ5hXVmBIbKTmzueKsZyz_MRi4UM0mf9xkK_xZgQglaW.JN09KSsrYp6JJ
 9fDFJei92WfyHkunl6uSV_zwAfpags5V2jJS_70YhgdyF8nWBsHCFrV4bT2qnkHrWZG5WUq6u9QK
 nf6DrRj6TKETdCgvYwVppBgZ2Y2chcghvU6HN3O21PoKVihM5DuFPCvvSweUXQtQgPaqxVKX3ZTS
 mbLCYe0C8CdmUWbiL2eUWYhSRGShh9CUilN9k41DSBXYX7HskY2_S89IxoHZoSm6HFBqBBq.pImz
 YNZ8F93rTJRJ1hAU4CibV8h69Rmp6bLsLPaPrPn14DsD8DvneOKf6YEq8LxfhwO53ZvWsg12Cxl4
 2CuQa9jJkp4bQMV4iuaRCegFh8ImL.sD19dHWr0J7piLAwX9dUBDgsxxlkSAvhmPm9I3VF0nJpPZ
 R8f0kZrkc5uz0mFDRUccduK3C8s3Bef4SkpuKjhPRroWzdsufwl8iKxKUP9BOF_WWNZ52K90TElh
 10jCwO.xBC7zPqs6ZQS85scNfzWm1oG7H1lB9wVE1YPk8Y_XaznHVW27Vc1iqYcxixcoFGYTh9B9
 do2l0d79USQ3f.k1vskhb8IoY1IGcNdOvWv2hx_Jw9E2lMxzXy4t.gSPmIc.DsPFU6Z7jBOpGKT0
 8yMvi4WUyO0HOkAeB4VuIQrp6c8OD.KTne6V5oytA7y0BaYIAlXThpiO4qzGwy_BF1cGM957paP.
 3VnXy_dAIuucwX__uuLMi7Vy1v1e5fIZ7CKfe5KCx7bK9BC7FdTkGOjAuigfBm8wMPHXHfinciIc
 rv9kA8JsYB5_4veX34Yvoogen36XleXJjflLV5hqOQiTPTdi_4JME5LLhp8DnubfDh0sIoZl9gIg
 iJLIGk8e5BwxJOOaTjK2yfKEv8RrhiyWMneojaYLqGqyXWq_zZrLtnuzm2h6rbkr0SAxqeO7pQek
 kSVNuOQ6YHEVUg2qIGIlouV66lisJYL5sNelAjtz_Pe6SXXP6qmFXCRgl0rXx17.qhpuiF1bznTs
 APx_h9umUMgo4x4RR9BD8.m8FXXffCcrNnI8TSzLMvxHH25lzb.x9aqAtW1fE1117YkZ3_sp2fG2
 Sxw3cuA9GAOY8__Hm4hJVVCeVXapnbHJAJFuC362Hd12qf6zjmk6MBRLER_GynmqJYpVXO6e4AdD
 edorazZsoo.0jl0xebq4TjT55LQ8CiWQwlAE6DNiITp1DaiSd_ZhP4uD.Lka1Z0O57Zuvl8t2IPd
 DiV4ndr5rhtCOvgcXd7OftPtRius_aVBncr7UWOza.r14.9jBQ64OhPKOBcJLPiDA3AlpvVaX.Jj
 1EXiKsJMlDhlDUok8BD2iYIPVK4wyW26RwXkWt_9aybCUBTPreEMmLTDYnyUmvcUobqynLQNCvZu
 W0OdF4bmSFUDBoDGwWw_F_urTb0NOCzsJ4BAwB71cNWUBmfnNnkMyvAw4zFoK2vrYqhbTsjy4Oun
 _fro9v0.XJV4Xxpb3rpHbe9RaAFovbYQP4TXDrG1gTZDmMSmeBX2GT36JJb8xItN5z0O.U1trdbP
 8FYpLvdplKufglZUAtf4t4_giutzNrCQy_lkOBq9J
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 853b78c6-1af8-4791-9d96-4958f9f5f005
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:42:30 +0000
Received: by hermes--production-bf1-6d6877594b-7nfrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 55fa94b2cf9f695bdba8e1d9a5f276c0;
          Sat, 10 Oct 2026 19:42:25 +0000 (UTC)
Message-ID: <13e3fcb3-895e-4c1a-a8f5-70dd9a0ed345@yahoo.com>
Date: Sat, 10 Oct 2026 21:42:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 6/9] net: dsa: realtek: rtl8365mb: use raw VID for
 PVID on family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
Content-Language: pl
In-Reply-To: <e84d76ee-03df-49b0-8c9a-b289dfae8728@yahoo.com>
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

No functional change for family C.

Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_vlan.c | 181 ++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 2c4c5ba..ccfa764 100644
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
@@ -119,6 +123,11 @@
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
@@ -170,7 +179,7 @@ struct rtl8365mb_vlan4k {
  * This structure is used to get/set entries in the VLAN membership
  * configuration database. This feature is largely vestigial, but
  * still needed for at least the following features:
- *   - PVID configuration
+ *   - PVID configuration (family C only, family D has no VLAN MC table)
  *   - ACL configuration
  *   - selection of VLAN by the CPU tag when VSEL=1, although the switch
  *     can also select VLAN based on the VLAN tag if VSEL=0
@@ -742,11 +751,25 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
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
 
@@ -811,6 +834,68 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
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
@@ -823,6 +908,9 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
  * PVID. Gracefully unwinds and restores previous configuration if a hardware
  * write operation fails during execution.
  *
+ * On RTL8365MB_FAMILY_D there is no VLANMC table: the VID is written directly
+ * to the port's PVID register and no VLANMC entry is allocated.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -840,6 +928,13 @@ int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
 
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
@@ -919,6 +1014,76 @@ undo_vlan_mc_port_set:
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
@@ -928,6 +1093,9 @@ undo_vlan_mc_port_set:
  * Resets the target port's hardware PVID allocation to 0. Cleans up and frees
  * the associated VLANMC entry if no other ports are referencing it.
  *
+ * On RTL8365MB_FAMILY_D the port's PVID register is reset to 0 directly; there
+ * is no VLANMC entry to free.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -942,6 +1110,9 @@ int rtl8365mb_vlan_pvid_port_clear(struct dsa_switch *ds, int port, u16 vid)
 
 	lockdep_assert_held(&priv->vlan_lock);
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		return rtl8365mb_vlan_pvid_port_clear_direct(ds, port, vid);
+
 	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx,
 					 &vlanmc);
 	if (ret) {
-- 
2.53.0

