Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.191.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125428;
	b=wOww6js+2XtvBBK+9ejqXy2Qup7IrvXJwiqTHo6HXzsc7gtFSxc40QGg+jmSw9F4FFKY
	 arv/Z5vDrbJtkZ+HMnln3e6X9e6cyAVCBencX20Qig7WWKXwdLkGhnmex8CxtGEakHogF
	 w3h3ep/QgJRIh0d2lGDpdFPHvuUpw0+ldtr/bkIOd8Nve+S4pyoufV041Lz3V4ZRahZaD
	 6nU0cdCbVkYd4TfOSONZ4RhRx0R5dc2SwW3EC/gnLLy6n+ktcVdvoz5jtv9vT7sJi1uZB
	 5vuy7aCMObpCBPBs4ksrfyVzPVy26RF4N1Q9VFhphKJWRYkFUvuOrmyDHT/E+RTyR1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125428;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=N3Vg9FgEGqkt8equYffIE4vcekv4VCQLRHAKTzJVNzI=;
	b=tsvELNZJqld1mp8RAKJXfXL+84Jl9lxK004vL9zUyGtYgPFgJvqXQ0YEJhtSAexEWwQE
	 J1ofRbVGS9X0vJN8u5y13CjDnfqLpol2gYrhY07JMkrBGR1W+shXRNoJ5I36pF9P9dfe1
	 wpzoQ5kHt8eUDnQbi6mGW+EV7YlXHGqqGe4X1i91m1hDJEaWnovwyRq9XM7p3ImV8HITG
	 z5ei3gP2zKlGM4t7vV+fZ0upvpXCqIMduuTU4okyX3t43nMTqGcx8PsHv8+FZHBgmJoHW
	 18hT4mAz/oozcrIlWaZtjvNGlka61QvPUwAwsONglWHGkctxQivFdUisoRBiqPoEiTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=EECYDHpP;
	arc=none smtp.remote-ip=66.163.191.146
Received: from sonic304-20.consmr.mail.ne1.yahoo.com (sonic304-20.consmr.mail.ne1.yahoo.com [66.163.191.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB7D606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB7D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=EECYDHpP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125427; bh=N3Vg9FgEGqkt8equYffIE4vcekv4VCQLRHAKTzJVNzI=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=EECYDHpPWkIw2v0KJayIntbwJnIjq8cPaGB3J2OFKaAGgEJYc/KVgZ6kE9qL1cxMmo7xikxHxrT78Brq+M5yNRzwPUaXI66jQTp5dxH9kGkoSAOS/Bq597HFC+uDySMveQ1Nz70mtk5Qy7PTRiAVRKrk0znILU1ony2HIOK6sw0SvgZHE//CnFD+ZC1kEnDMqJIbeZdAIYNCimp11dor1tCKaNaQLrnlmzEdMyhx+OARZW9bBpMAKbniK8TQMrsOTRcuhK3cSUhl1n9jalqgeVafkFX4aMG1xUY8oKNCgNtyDxmDfK9pTonRX//AWhIF4Byv6vBY7D9mXEErNoh3ZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125427; bh=h0QL8lhyVACg/ocHQPr+w85gEKpPecepdnp6D2Ktpcr=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=exm4cxT4vFA4XANSxIsxUUXl7sugJ5tnhV/UcqtOzAFmDMTCbMZxWQMdRU71jg6pQDO32LVmMLXf/REXnbSBRmHiODcL7UiFzWlodMwMky44GTfbbGHLPX0ysK2pOXhyPEXa03HgY/rsLdSI7zYli1fRccDKJPKYRccILNzDEYEMkzxfwbu7zTyqAhNHyucW5FkxZN5j5M4luGfTFq1Mxzbk0o8PkHrQDHOM74l1Jd+gqjyrB1EsRr7HXXY9lqgKkiXxRwZI96gZfVMEjnOrxfqlzZtKIUbq0zUgZVnNpX+2u0V0O2DV/rVsZFdlv0jQJxlDPZeL/eFFm7kvb1XCGg==
X-YMail-OSG: 0lBGGH8VM1kPvAMgD3BvvF7hNlYQtNyAI_eI6Us_UEgAvIDJBVIZJuhrjJrUlwj
 QA9_ZTMhxWvi5G2Iqs1E8W54B46wgp1B.Uyse49I33uiQcc.4TDpvXoJpyguhKI5hq1e.xA_OR_H
 g.8X35qLmzdpHolqB56UV8CTm5e4q8z06zak6Zzr_QoYVMisfL5p91JiOce7oc82aghEwj0ETD1y
 EgrRWGnhmPxYy_AMmHUGI26DkkQkrotXfTSu3Spq6F7UacB75iRK1v11ZaX147VQLdsJh87f1S2t
 tUdiLanlIwyHEC1t4e1svXlHtr3S23zhALgK.1uYRKfetcHYO5T2QosUSBgg2RoyTpG2a9.8lTSO
 ub5Y_iX3CrMnBBvx.WqY8_FWKGdOv4TlLuna1146DySR1cLSD9zS6TbckFeDyBt18p4XxSBMwp0p
 vJee2aZeCfQxewwVfEM7Sy16.6mZIxjf45t2fIh1SMKvXDE8BOQOxGYsperysdcPIDZZHxsm7jlk
 XVMZqlHt5PpUCFJjQD7v_Cbf04rnxsqaKNvXRtpSH5X1m3dX_vtzK6wot7bsnR3qE7BGjSnJMkmS
 SJc07NizcJp2yibTAMUcNNVY6tA8D5vnDVyRttkrjxC3V.MVfRr3hmC6vETKzlufECYvVGYgHbf6
 .SNOLzwgmAYoFzm7EzBQu.IUZLRDxTqudKbuw3iyrMmc.8rPej17xGNVzv3FcmKxLQbSTutEx94A
 rD5CfkZaFFTmtjIvOLgaNt8RnEndO3Xvxhre1WU6XkuU._6tLOQJsSs7nX9YnP05un2t8UzriiJH
 3VypzCaxoLq26nEmNIJaifPq53kEZF1YJCVux9tlcgRbLqZkRwJUriFku1qN38zPoOb9NJxGJB8t
 gyaCLTP3fXSBxw5iQxBrclapCuJZlHDGzV6IdupOo2iPW1QUWGBufIYO79P1yazDBUkQf_TCjCMy
 vH1y88wTOhpOphj3aO7VJzVaRqJ6phGQggHYMEuVWamkijkzyaUtnlqamcQj8U5B.I9DNbjEvvRB
 .e14GDq7.YkOgfBOn3RtrCSKvKV3RaLAlGZhOQdAeLtpjyCSj0rIXFlfsSc.jPbGISl0AFQL8vTM
 2CnG8aP1zcAuSeGobNHzICTpo2vBv3_maK130deodN2z_5IW0kqADBwruGX7wrdR961Ba9QQ8yJn
 zSSrCwDGrt_lxoxyAiVLFHFXibMA3iLunYRTwUfPqf9EeJbJhOBzFVZvC_1gopdWdGb7Q0chxBWw
 JR61WmXQ8y6agAIWhjmpfOECA03XeJiazWyEUsR6m639kdtRJIiJkZbJ9djtFTWzjHDSYvBuleJl
 .Kw522b20uWRb_QyRBT3kLZ39nkDp96izViD8ufjNMtAZU3JeBNpGdGl7MVape.i_TBk2tWc_mxr
 pPGktqTKiouWnn_VVvtNGOjIuXmZkwawKk1CrgF_Khdu3IBQnfdAe4JKeO2XvYrdeujwFHt9hESo
 UffUVppfLHPElu8pXVhFkQ1CZ59jx2UUBdji94HqabR855wRHAOTOIyBaoUZaeU4OmVrgdlzcf2c
 r7kK7eW8yhXvi0.cF0EEuP_1OU29POvca48ZYy9aLxOlISQTo.FsMV35p3L47IABhaPzk8BwMuJd
 ZnZ34cfTz_pEIJHStCyR8atnqP5BEUsdbrIJ0e36sr5yLZlqTx938UE8VVIkFYYUSU1oLNdZ8FEk
 C6kuiVnaNZsZsEeP65J94afaFNMOjMF1UhsmdTuwKsHTuPZkyRI4MF16ZsDB0uYzE61T6lhDWo1L
 pS146kpUBv4lc_pxqhXBZI6Tz3htsDHpfNtCZdBfpRt66M5P.BjCQkgJbOCMFmD841YM2oWC6DtC
 if2fv99YHMTHQKnqwMEONUERu.NiArpURqioz2f3YVbLhJKYTwpbyS3fkCMr9ZDYFJlXzTJS6X1B
 EqgAYaSL73VCjGVTOzAxVjAkfoTcqa9_AWczx5oaFRCVx11A7CdgvNu3LalD_NJwXvY5zsrgc.ex
 AzSdqk9P_vao420bAbLk5O3dv_OVTjjU8YzbjbEkozjqUuAqFu0q9NCXACjB2Y2XRafYOYXnhN_n
 FqkCRSDn623ySauu5RmP9IGjU0iQDBRvO3kSfbKiphDgSmW.K16lnDs8AFyInI4Oh3aBwYtnQJL1
 0t9WtYfXrm1tWjVa34lHspUQ9c8E0z8.L9Zwa6.q6mSDhC65DLEfl5scbscRp_TglyTb52ezA0Ma
 dG8ZmX1kvK.Nq6GSZorjN0t50clNCqES.9Jbitj13AQ4eQHD8t9fRtiBqJ_MB8WnABxKSj2z2v4b
 ZuRbC5Q799Nc9oq3GMqGeR0R.V9Xs2Wc6X1s5mJvDvw--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9ebe2c48-ba39-4b67-b313-057067c5c0d0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:10:27 +0000
Received: by hermes--production-ir2-5dd9bf4598-bjqzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 197b7d06647ad2ac2bd4a586489a0672;
          Sun, 08 Nov 2026 08:10:23 +0000 (UTC)
Message-ID: <153177f1-357a-48fa-a2a0-8a54234885c8@yahoo.com>
Date: Sun, 8 Nov 2026 09:10:19 +0100
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
Subject: [PATCH net-next v9 06/11] net: dsa: realtek: rtl8365mb: use raw VID
 for PVID on family D
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
index 0b7c124..a87253b 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -2355,6 +2355,15 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
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
index 351ac4c..340230b 100644
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
@@ -738,14 +747,51 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
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
@@ -807,6 +853,68 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
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
@@ -819,6 +927,9 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,
  * PVID. Gracefully unwinds and restores previous configuration if a hardware
  * write operation fails during execution.
  *
+ * On RTL8365MB_FAMILY_D there is no VLANMC table: the VID is written directly
+ * to the port's PVID register and no VLANMC entry is allocated.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -836,6 +947,13 @@ int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
 
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
@@ -915,6 +1033,77 @@ undo_vlan_mc_port_set:
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
@@ -924,6 +1113,9 @@ undo_vlan_mc_port_set:
  * Resets the target port's hardware PVID allocation to 0. Cleans up and frees
  * the associated VLANMC entry if no other ports are referencing it.
  *
+ * On RTL8365MB_FAMILY_D the port's PVID register is reset to 0 directly; there
+ * is no VLANMC entry to free.
+ *
  * Context: Can sleep. Must be called with &priv->vlan_lock held.
  * Takes and releases &priv->map_lock.
  * Return: 0 on success, or a negative error code on failure.
@@ -938,6 +1130,9 @@ int rtl8365mb_vlan_pvid_port_clear(struct dsa_switch *ds, int port, u16 vid)
 
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

