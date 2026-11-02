Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.191.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630523;
	b=jRvhlV8Hfu0ZGz0qH4EoeYli7dzxd+xGbRBa0VaOjn79oOc3yn1RpNujI3CbLDRhw0vh
	 p9nxx3QFJ9PUAb8jLlCzeJ74pmaVC7yFUb/mki5o/IvHTEkChG5XmBoo67Tv+6FpnYQ/6
	 qXmr3shNdyWzXGqFpE16YoyHoFIMuEo8T8hhgm71cawlFiqJuKad4OMpnHp9caDCf3Tv8
	 jt1joyWUdUcB4+6xP3wn4NFkbX/qcVKmIybeCIobxk7CGV6uE9Iw69vqol8vRNrxtwNul
	 GInDfmnqzllv2L7jU7IvWm4TuB3rWrmgJ1MgSsOYvwCI0lb/TdrbtvoiEIf1FPApJlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630523;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=ddepU6UjPFclcUs8qpwVkoHTl054URjuubLuc883ba8=;
	b=iKia2BPnyadJG9wUE77tqpA8hZJnr+kxOPNuX40y550DX9iHG/C0xkrblTkvclkbqK+G
	 O5iI2MSz6MC0IcsyrcO1OZQkXXzG/Wgm/uqW8GtmmeaA3jJ0PoIopDc9TXMbGatwJncmR
	 Y9cpv34m+mOowVgdaBd4yAhcu/Ka3TQL6avnff/Os2PB2ipTfZq02c+rTS17vbzJN+GGl
	 3g2K2FspJZbFrkxOJhUhx+9DAdF+lguCQUmZwOw5rqJW2RbK/6Lx4HXSb/Z/SHDlFfRES
	 wGtJMkCDxUIWHIztpO5PbbOwOWGC+m5r5IF4jlLjk1NxYz1kON7NsqgrspHlGFvt9OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=NUwwRUuK;
	arc=none smtp.remote-ip=66.163.191.204
Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10200606F21A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 14:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10200606F21A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=NUwwRUuK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630521; bh=ddepU6UjPFclcUs8qpwVkoHTl054URjuubLuc883ba8=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=NUwwRUuKfk/s9H/lmf21Q2FyFaTJSX3Rznl8C+CSR4WQl9pXgxSQawXcl7XZaonX1R8qdTyXsCwermAi8W0rmPZKMipM8lNijYLlKeHKHjeqlLH69EG8XxDNbii0ezqTpDayBMRTJ97ltHFg3P7e7gGW3kybtjGJ4kfzOBnC7MPJ7MuDI9YcYikDM12V70f8ONQAaF8WIYz6beV7RIHFeqM6esiizpP+NmES377OxM3ZbgAAKjfwWoTbRyS/46X0R0snYdwRJsxjsnCo0ELFIaKOZ4qnz4yWHNKm8QRyWv0bKG9Xn4pfaJTMlGUWfgeYEv3OVMbSRv+xYYOs19CPag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793630521; bh=jTMbBA62ETDBKm6TTTGAxFFLf8V26fUW4CE4mI1xDk5=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=tpKVJe65XF2cH2AJ0UKJMsIkLnEs/aR99OiHhCHsRurVCzMA1BaXCeNDBsuX/SjGa9qgiRQ5tZbsXHM/KqBjV7+7GipLHU3relWQlpmrz+tc3Hvu2YgjrQhN4Qd7JtVM5O2haWXNMMbk39qAd8tx7kcE293C0Eo5FJ/kS4shtReiWJGKp9SpqRwPQNgRtoaRoQQkQ7piwJ5JRcp0WlyFLGZ/WTlb2ogDfOdu+JinlP6RIh9flxOVjuV96nqqZAGuB9erhuLzpbdnjEdM0I5abblIyYsdLp6/l6AKWWngfqurIgX5pVkvrxtA81cedl0eMHyb6FQj3/puB/QJcUX2Yw==
X-YMail-OSG: 1fbtEd8VM1mk_HhXHVgN80.asyavju76B.8hdGq2APuqtHb4_X5EnJPcXVMD3ix
 XdnNSaxQjhMSgpS1c1i4aArnuJGW4KU1VNIsZ8jhdFZWLTAMxkHW._5BmbJXAZNnrOR6SAwPmJiB
 cqzXGN7wPvZxyGgto1Fchv1I6vKL_MSWt7Q1uOTFnnh3lEGt8dKrzrRqskTD3drBnwjXdhZdefSU
 otoeZTqnaYV7xwhr6VkB_WEAdd1_6KiZgVOwV46PdPBBhUuroPHf2J3ESnXv1u.WUHGeA4VfcQWq
 oPvjeiuNNeGrjra5bkLBVxRT8.QbmFEIEUJ8uCRFs4zGTglIsXEVfJbJfqTKmKAvD48_JgyQK.Du
 OuHVxalEM8Wnpd7AehGkcnTJAC8tGnDZE85cgpSCy.dAWqabK_WJ7CNnJNM06hCl8JZNdVLchLiT
 94zw_qrJB6SZ_kQ6748ecc4ClgAWZlTYgVLfmtYxL_NrxNac7HxXHuOazm.GMOPss_n4IRn46ntr
 4DPPlbmtl8_uuswOKgCSRVKCcDRebAGuh.0St9KDY.Ecfg3kxOC.sU9ha61jwg8gTDRWcfjvuyFc
 YV0oyZ7seLYJlVNmKOJ4Sc1gzAptNyr8PPMucNl7equ2SAJ_tXbjC.2R08iFVNOIUlN2OcgCKJ9b
 UMvo.QHbUtOPaiom16HO2ijyW0xKi3KcyxgpSU8ikOlD5mqiej6evetUg.hX5lV0vKQwFYpktIBI
 xX9g4n6iWO527qpKjP5.HAsp7chuBeRw.s9Vd6qd2RzAMbrUfV095n1Cy5vTWxYKQ2QMc3ymfEsc
 pXCQzGC.10Z_kh1as.PfDNRk_a6JNGkG5d.Og3RAtYh6em_tooayiszLtF09yEe1GIjbhNU1BrCO
 c0WcVk58YkFr4G9atfXsU.7oMirbji7MPJkYXPHqHp8N5YvOVTFt5iCIag1m.OPuxLsngeSzW57K
 03Ti20P1LpQ3VeaHa5OlyQgTGcSeMh7YWYQGya5NjRDSvAD3vbb1WjlCsbbCyUzty91Cd9HSdT8N
 Uebzgxbj6z3RgVjd1LfW8UfEtrEyC8KW5Q3fbM9jE66ihv.mUSOEJpaYqp4uoMOEVVylBaiZV8U1
 vHvhzunz9CDA.K4hQkxV0SslYcuDBCTqGkugn73NbFWaQ5_yfPQsoOnOXZHFILEV8BYrmQz8NvBq
 cd3OlEzZJPOobXSB3BPzJ2OO96clRiVTZL2MPiW9dcztGSy8LdAGRSG3Fk84TeH82XxFN2B0IuqE
 r64gOG3zV_iHO9zx.zpfF5OaDEs_NsMO1OfzlSJ7E.0tnviPSYE9xO5uj2I6YuZki49zR.ukDgrA
 HS0bLXxqhl9Xeo_mo9a_I9Utx2Z4.c_1VaiJowADrPOlnT7V_hVsKWqXSDt2o2KWx2opBMV9oO0z
 xWJY83wXTp0YshGYOyEi_R.gPD7WnZEBGgYutuwiltJo04BOMH3jXJYO37oYnuIMmgspiuaI1ZQl
 wH1NXTvX9NodeqNuF6OPfuulje5gOfX1MOcArwzhdz__LMDfB5OkhIvSp96flgqX6de8Ua6saw3C
 zl2zioZ9obFFOHWGBwccqKn809slwSyyHpkrW_JcnxuKK1MjB7mgoV.P5iRPYhs8a7cthQI.blsf
 rRfc5m9rcZJ1goIl8bwo.C8c5o04U2fprTODkVfhRCn.DF7r.9jvOy0EVFOfQ9db.BIaj0HuJye_
 F4DcKMR1NJvMQGTgEw7Xy3bYM0qBuM25jLJc.TzAPyBfLbP6SmqLagrwE0H0WtmvJmsIyO5o4UdP
 NTultQA8OkUTMwYZRFwWi837P.IHgsVt_.fbsrk1wl5johXbEyNcipnw9pQ2dD45RXYgm.G1CdQ9
 19zM2y7PkJhQl5F0CnO.ult0sUjlMN3ypYL_Y_A8hMYfAmqsJPYcO9E_6dD4umUvLtjrHx9abW4i
 yxS3vY_LANRFin8i2YUF5CMFPj09bkheTAZbE8C0TXF_HjYOIxE1qmWgIDlquOM7ZN3opJAzVfcE
 9LkhQfvBGCBrPkwCzHB4Z6R1Pwnk1.3jUvj2h3MYbL3h5xD8ra.hHhrtQB04vF.uAfQVfmexZr5F
 UrmMa6TGF4ZDME.aF3aOBf7BwYCmQdOZjmjLtjPmNem0_tVkkCrWMdOgSpv5IU9gTAxNWEcd3jCz
 wr._bZrdww6ZiQUy5tyKIfchAh5uenIMdOMBzajutf17IrEi0rgABS.MO4ir9LWfnsYzeYvc_8rE
 NovSGSrtbSvYk.CX0eWQlPKQYdDHHVHsNSrLJfP4jUm9j2ifVeH.wrNtK57pZaNI9fSxRnzZnXd9
 vm8jXVj7TI_7fRBqltkX.xkvXAThBsrexkX3GoirT5A--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 7fc9946e-e7d8-4c8f-a85b-27b0f2498253
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Nov 2026 14:42:01 +0000
Received: by hermes--production-bf1-6d6877594b-mcfwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2417f91d7e5627cf22b4d14816a2d6f0;
          Mon, 02 Nov 2026 14:41:55 +0000 (UTC)
Message-ID: <7ebd9453-4af4-4ebd-9cf7-8422755fc4aa@yahoo.com>
Date: Mon, 2 Nov 2026 15:41:51 +0100
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
Subject: [PATCH net-next v7 06/10] net: dsa: realtek: rtl8365mb: use raw VID
 for PVID on family D
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
Content-Language: pl
In-Reply-To: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
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
index d69eed0..e82205c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -2360,6 +2360,15 @@ static int rtl8365mb_vlan_setup(struct dsa_switch *ds)
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

