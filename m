Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADDE3A1E67
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881086; cv=none; b=NzZCBC2dgeyxRTorEbwbU9J1Kbtuc3uPBX/52Aw3mjDxYWv0n7+elR2nJzZoeqrSKLpRI1B9oJRckg2wAlFaSkDku58R0rvaUY/KeanZljCpPENDQ5r1ceNyipoUFJJfO7KHNikdprbZaxa80QCYw7WpBj/hrM1sEQoHf68pudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881086; c=relaxed/simple;
	bh=QvAg3mRyVxnWXG9E1hx87J27hX4fjsF1f3Kt3LHIB/k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=QXHkYJ7oDn03GKRU/WqSPrM7CmueMRtVpJflaqBYyvPYq+bND1/RMgMSaBkofzpIlp/h4rEGAj0lvVOU8BQ7SB9X3M8Fva+k1QdAWn69Yq12l8eRO0RXjkEGOXyiehlN8a6vjWlKayrS5Dn11D/NtXeCvpv0FOoFCZ0GBP3VC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oAIKvuTW; arc=none smtp.client-ip=66.163.191.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oAIKvuTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881083; bh=V13eBKWWYAAbx4Ulf7Vzu5J7P7aiuByj8Fyg/WoeDcg=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=oAIKvuTWkqSAOR3xlDzHMWZSz1wrvOkzeQaIx2ePcIFZ845N1Yf6aOfrQLXw/Wb7/U6xKue2ynbE1QM4Q4+PKrwcaYLcQweBJjivLVjHIXWZmQWbGmL9+hMp88o0X8lgWSpzSYQMJfBeBtp/I4zscLjVlxBtXtBSTGvWQdO2yOq9gkYNtZKBjTZnovOI6Jewt7NnGlVXdQ6dzz+RU4n/1+a4w6qXay25feh+NaSL3RL/A4EaDu6RiSExq8RYQD/wOgCcYvGEp61qlOUrGM2MpQgoELR6sXQ2g4poallJbNByc2BGuNEbFvCQ63ms2OJvFzew3iS+QjpqxETz50FS0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791881083; bh=YQlDEGLv2AJwx5kpQe93OSyRlO4W99XVqpo87tEleeF=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=Bv5IJEtki5cA+nZHdHTpjURKsLzqAhRWsgZYyaARe9quGfz0d5W78CZNU17AJeJOy5su0sAckL7UaHZEYKw/7KO4M84xoaYuyxKdeyOwk8RgigOwCiL/UmKjoV/B/50qhJMkzz6D/HDYKxVh3nmsjDWO1hZiIqx9YjQDz4ft3axVLCBP5YQqCKfpg9+dY8UtG9RAfYsQH458lG9EYO+gum2FEW6SzDd+EFsEv98BCS4/ToFwNh9ONAR33OShQb0YIt/PVtTiseN2+VagjxDp4mdtZiCyzhNdwhUpuLD3+y3XkpRoovZIBYU6EZzZSqiiTflc8AlKUdYJNc2RjyblEQ==
X-YMail-OSG: goUpBWEVM1mAcu.fLU9U6K11hnbBHVj2NjE6X2DFur3vzPFsh65u9VcBg5iPjW1
 _sfjzhclYfP_Hd43pzcCG4AnQvtv3bM88oueMr1_2ZQO78U63UTUHXT_QIGYQwvfLL8RdYT7FkN6
 b7ZLVyHbSB.2Oyrr0j8EdyV4eMmWZ2CmWbdiHILtyt1H_p81uSFblWg4PIk9HuSUiFnOtCVHpNqB
 OWHzjkZ2pNGhCxi5CY_m58.DNc7qGLqew3_FCiO8xD_zbnOq1iR6rzvXL0YgHa_f55oM9zXkrtmM
 TeRh7HCmrPxktgIamI52JvBEsAT.nSzOYrQjfLzfOHLKoJT5pYCpb30WeCkc0zQT5DGxPEnxFxKs
 .B8rIG7WxCic4MW4s_y.GGZiOb_iBy93d6b3QhJdjKOWsogbU7sefsniERwAjHB6r7.4ty4d5bSH
 D5lYO3pzQsoBXIfXZ5EjDAyBYYGjNdNptS5T02lcykpgT9p2AfCmWKTNj1yoML5ONf_7cGDJe8eC
 sEuDS6SK0Rzzi091vcvcdsjTA2x0aN6y5uvD3ekWHI_XoUbBexdaO1yeVnJ9MjGUt4rKHwGHzv0B
 YbibZ4e3P7i5sSzb4m2Hufh4OEc744xR2izesw2khi5jXvcGv9.RitriBS31u7gNR1NEC3sY_RC7
 aPsFyzPNu0Ic_0tNR75G98ulm_xBDMC_ODlmThoIpG2w.ZJcg.xRPYjej19pe0BSDzcbbueB9OFo
 s3K0yi9y.3xxLJjNPY.Y.9Avc3g7eUoo0vByZYrJcF6gqTcsN5h0y580tATEPjC6kMXil4sdhDFX
 bW2lKz3ktOZ_EMMZTSarz8GrPwFM4T2Uk.eQ8Ad950H2pP74cWe9kJRXoX1YFZjiiqQMYvHV7ueM
 9wL07aqB.Qr5gGg9B7qYzJHPbmbBPv2vK0RGeLtJ3_GAEYkrVGGra7KNrk155M_.glC97k5jIIdf
 nCBwmooFvLi2tVYd_pm9KR8zPAjXfrvBJFJFNsyLpU9ER3XdVgjEZqXqq7pTP48ESxYQwq3IGCaH
 NtmQLA1WrI9G1BJaZg5XhwnK4MFe_HNS7FVb00mXJzxRB0uJykZpcu1uKn237Bbo1Pwe3PZ_HqTv
 X8AfTyFCUORS9Iq8FIDfE8QjbNOXMyWHx2ziVnOx.qsS95ttfPoANATcD75yfcex.GzjHJgOQTfP
 pmwNswhpUJXAtuc4RMmbJ8WGplXkV8jWJamud3utHD2q_641_Y52TSgpuLismivE3wGn5qAn8csf
 HcsL7hda6fxckl5lf7JS8XaDFrVLh6BQrmdE7ZskiyERyyIr.w.Fe9ZFNgYfuIMHjKLn1LZ3iUmY
 k7.anO6JwVqgJeiwtbdogfLVKVEfW6kdh5qWLiWtpNZB.iz4f7MnZbJ6bXrop8EXccYI2wDts82p
 sDO_sud1HndWO9xYx0nDDr0tZKa6OFqFy4uVdL2IpS5ri7_zbnifgDtuCCUMlgJadhn51IQsCb1E
 MLYucLBuRduwjrXhVrC8sJ88u.9ugpjGTTXpkjkHN1EES7_bCctiz5F3j4h871rJpzuSPWENV8.S
 2q2pvlh7Sq2kVbyk7_t4XxYmSysir05Qd2SJJqnxpDsQc1YccgudjZka77Jn8fvobqwF78663km2
 Pu1_4vsH8x5ncJYB3nvWfo8NllJyxOckj10nscGK_39vDB6BI3UtqoFrLsgjcFqrqqvjr_K99_Uk
 awbuXJZAPyYr1ibnBeN_RkOeul_vnS4mT5k.1wCoPVVOmVC60WkARSVrdN8rypAeQTV_DlElPZ2W
 kE1vBKgbhwBWUMbZDZS90zXpqWjJCUEhdv3QU4k3Xi.rRPKk9WRWWTWBAWKn7_nSFKTobFsfesCQ
 P4GHsrXw93D7fTudxwAPWhqO.yRQ_CvRrp7363I9_LnLOZy36yOrBYhV9tsYnNYEai0GqMhG2bUf
 _RdPOhxA4RIy016lOAoj781uAdollmXbyATDBXu6cpTGgxesjRTG260iLgpIBcLe91Qwt7Lvd1jX
 hBnYXSn.5vwPEuyDyQdHsTDtzrHfpPewe.gsKbncGuhu8jR_S0Ke_50NxpA_hWL7zztt0YnntaV9
 wQRHnqPKwhqj5aSB.6H17gySve56kHxbzuE5oQAS8SkjosAM_Hp5KYVZX.rgbXD1OmEJrcRy_8ac
 JNuxJF.vz1IuAZhm_k6GOzgY1qAzN2wlL9m3u10nCWDpGUdcdVoNwkBOjeCmlv4FwVwxPL3Cf21A
 qsPPganekDJyb8CvE9iXzvblfr9lOBz4YTTf4J4W434uCgdP0WavxOQMM34U4CLSEPE8cF1vwJyH
 0gztAUMMPudY-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 774c811e-ab4f-4631-9b84-891fb5a2a632
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Oct 2026 08:44:43 +0000
Received: by hermes--production-ir2-5dd9bf4598-xpdvn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 94d6825eabd19038479c9a09644aacb2;
          Tue, 13 Oct 2026 08:44:39 +0000 (UTC)
Message-ID: <dafd0519-0659-4898-8a6e-7121b5c4bf78@yahoo.com>
Date: Tue, 13 Oct 2026 10:44:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v5 8/9] net: dsa: realtek: rtl8365mb: re-latch the
 family D SerDes
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

The family D receiver latches on the DISABLE -> HSGMII edge in SDS_MISC
rather than on the value, and it will not latch until the MAC at the
other end of the trunk has brought its own half of the link up. If it
does not latch, the trunk reports 2.5Gbps/Full on both sides but moves
no frames: the CPU MAC transmits, the switch CPU port counts no octets,
and there are no CRC, alignment or FIFO errors.

The two ends can be seconds apart, e.g. on an IPQ5018 board:

  5.27  rtl8365mb: configuring for fixed/2500base-x   <- pcs_config()
  7.72  ipq5018-gmac-dwmac eth0: configuring for fixed/2500base-x
  8.02  ipq5018-gmac-dwmac eth0: Link is Up - 2.5Gbps/Full
  8.56  SerDes latches

pcs_config() runs seconds before the far-end MAC even starts
configuring, so a single edge driven from there is not enough: the
receiver has nothing to latch onto yet. Neither is pcs_link_up(),
which is seconds early for the same reason. phylink does not help
either - it never calls rtl8365mb_pcs_get_state() for this port in
the first place, since mb->pcs.poll only arms phylink's own poll for
in-band links, and this CPU port is a fixed link.

There is no local signal that predicts when the far-end MAC will
bring up its half of the link (bit 8 of the SDS link-status word
does not change ahead of it), so the work cannot wait for it; it can
only tell afterwards, from the link-status bit, whether an edge took.
Nothing external re-checks this later. So pcs_config() kicks off one
attempt, and the work re-arms itself after each edge; the next run
checks whether the edge took, rather than waiting on a poll that will
not come.

Each attempt (park for 20 ms, then restore the target mode) is
performed by a work item rather than from pcs_config(), because the
attempts have to continue for seconds after pcs_config() has returned.
pcs_config() re-runs cancel the work, so an attempt never interleaves
with a reconfiguration. Before parking, the work reads the link status
itself and does not park if the receiver has already latched, since the
condition that queued it may be stale by the time it runs; it then ends
the episode instead.

Attempts are spaced about 1 s apart and capped at
RTL8365MB_D_SDS_RELATCH_MAX_TRIES (15) per fast episode. After the last
attempt one more run checks whether it took and only then warns that
the SerDes did not latch. The work then keeps driving one edge per
RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL, so a far end that comes up late
or a link that drops again is recovered without a reconfiguration,
at a bounded cost of one 20 ms park per interval.

Once the receiver has latched, the work keeps checking the link every
10 s (RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL). If it finds the link down
outside a reconfiguration, e.g. after the far end reset its PLL, it
logs that and starts a new episode. An episode also starts at every
pcs_config().

For family D, pcs_config() keeps the masked update of SDS_MISC and saves
the value it wrote as the target the work restores. The work parks and
restores with masked updates over the same fields, so other bits are
never touched.

The work reads the SerDes link status through the SDS_INDACS indirect
access window, a multi-register ADR/CMD/DATA sequence that the PCS
callbacks also use, so those sequences are serialized by a new sds_lock.
The SDS_MISC updates need no extra locking: each one is a single regmap
read-modify-write.

The work is only started for 2500base-x, the mode the re-latch edge
was observed with. It is cancelled from pcs_disable(), from
pcs_config() before SDS_MISC is touched, from teardown(), from a reboot
notifier and by a devres action, so that it never outlives the PCS or
the driver data and does not touch the bus while it is shut down.

If restoring the target mode fails, the lane would stay parked. The
mode field in SDS_MISC tells so, so the next run puts it back before
doing anything else. dsa_switch_shutdown() does not stop the PCS, so
the reboot notifier cancels the work before the devices are shut down;
a devres action cancels it on unbind.

Co-developed-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 320 +++++++++++++++++++++--
 1 file changed, 305 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 6c51f48..238a3fa 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -97,6 +97,8 @@
 #include <linux/irqdomain.h>
 #include <linux/mii.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/reboot.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/if_bridge.h>
@@ -299,6 +301,28 @@
 #define   RTL8365MB_SDS_MISC_SGMII_SPD_MASK		GENMASK(8, 7)
 #define   RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK	BIT(6)
 
+/* Re-latch retry interval and attempt budget. Each attempt parks the
+ * SerDes for 20 ms, so a far end that never comes up must not be retried
+ * at this rate forever, and the interval must not be so tight that
+ * back-to-back parks starve a link that is about to latch. The count is
+ * reset to 1 by pcs_config() and to 0 whenever the receiver latches;
+ * attempts start at pcs_config(), well before the far end MAC is up, so
+ * with the interval below the budget is roughly RELATCH_MAX_TRIES seconds,
+ * generous enough to outlast a slow conduit.
+ */
+#define RTL8365MB_D_SDS_RELATCH_INTERVAL	(HZ)
+#define RTL8365MB_D_SDS_RELATCH_MAX_TRIES	15
+
+/* The SerDes stays parked until the restore write succeeds, so the write is
+ * attempted up to this many times before giving up until the next run.
+ */
+#define RTL8365MB_D_SDS_RESTORE_TRIES		3
+
+/* How often a latched (or out-of-budget) SerDes is checked, and re-latched
+ * if still down. Much slower than the re-latch interval.
+ */
+#define RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL	(10 * HZ)
+
 /* SerDes internal registers, accessed via the SDS_INDACS registers. The BMCR
  * data path reset holds BMCR_ANENABLE | BMCR_ISOLATE while toggling the
  * vendor-specific low bits from phase 1 to phase 2, which triggers a data path
@@ -938,10 +962,17 @@ struct rtl8365mb_port {
  * @chip_info: chip-specific info about the attached switch
  * @cpu: CPU tagging and CPU port configuration for this chip
  * @mib_lock: prevent concurrent reads of MIB counters
+ * @sds_lock: serializes access to the shared SDS_INDACS ADR/CMD/DATA window,
+ *            reachable both from phylink's PCS callbacks and from the
+ *            family D SerDes re-latch work
  * @ports: per-port data
  * @pcs: PCS for the SerDes external interface
  * @sds_supported: SerDes tuning parameters match the chip option, so the
  *                 SerDes interface modes can be advertised
+ * @sds_reboot_nb: cancels @sds_relatch before the devices are shut down
+ * @sds_relatch: re-latch edges and link health check (family D)
+ * @sds_relatch_count: next attempt of the re-latch episode, 0 once latched
+ * @sds_misc_target_val: SDS_MISC_CFG_MASK fields the re-latch work restores
  *
  * Private data for this driver.
  */
@@ -951,9 +982,14 @@ struct rtl8365mb {
 	const struct rtl8365mb_chip_info *chip_info;
 	struct rtl8365mb_cpu cpu;
 	struct mutex mib_lock;
+	struct mutex sds_lock;
 	struct rtl8365mb_port ports[RTL8365MB_MAX_NUM_PORTS];
 	struct phylink_pcs pcs;
 	bool sds_supported;
+	struct notifier_block sds_reboot_nb;
+	struct delayed_work sds_relatch;
+	unsigned int sds_relatch_count;
+	u32 sds_misc_target_val;
 };
 
 #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
@@ -1370,43 +1406,53 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
 static int rtl8365mb_sds_write(struct realtek_priv *priv, u8 index,
 			       u16 addr, u16 data)
 {
+	struct rtl8365mb *mb = priv->chip_data;
 	int ret;
 
+	mutex_lock(&mb->sds_lock);
+
 	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_DATA_REG, data);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_ADR_REG, addr);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	/* The SerDes indirect access engine completes the command within the
 	 * register write transaction, so there is no need to wait or poll for
 	 * completion before the next access, matching the vendor driver.
 	 */
-	return regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
-			    RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
-			    RTL8365MB_SDS_INDACS_CMD_WR_MASK |
-			    FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
-				       index));
+	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
+			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
+			   RTL8365MB_SDS_INDACS_CMD_WR_MASK |
+			   FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
+				      index));
+
+out_unlock:
+	mutex_unlock(&mb->sds_lock);
+	return ret;
 }
 
 static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
 			      u16 addr, u16 *data)
 {
+	struct rtl8365mb *mb = priv->chip_data;
 	u32 val;
 	int ret;
 
+	mutex_lock(&mb->sds_lock);
+
 	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_ADR_REG, addr);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	ret = regmap_write(priv->map, RTL8365MB_SDS_INDACS_CMD_REG,
 			   RTL8365MB_SDS_INDACS_CMD_RUN_MASK |
 			   FIELD_PREP(RTL8365MB_SDS_INDACS_CMD_INDEX_MASK,
 				      index));
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	/* Wait for the indirect read to complete: the engine clears the BUSY
 	 * bit once the data register holds the result.
@@ -1416,15 +1462,19 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
 				       !(val & RTL8365MB_SDS_INDACS_CMD_BUSY_MASK),
 				       10, 1000);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	ret = regmap_read(priv->map, RTL8365MB_SDS_INDACS_DATA_REG, &val);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	*data = val;
 
-	return 0;
+	ret = 0;
+
+out_unlock:
+	mutex_unlock(&mb->sds_lock);
+	return ret;
 }
 
 /* The vendor driver selects between two sets of SerDes tuning parameters based
@@ -1546,6 +1596,13 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
 
+	/* Cancel any in-flight re-latch edge before touching SDS_MISC: the
+	 * work parks SDS_MISC and restores the target value after a sleep, so
+	 * it could otherwise write a stale target over the new configuration.
+	 */
+	if (is_d)
+		cancel_delayed_work_sync(&mb->sds_relatch);
+
 	/* Select the appropriate tuning table and SDS mode */
 	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
 		if (is_d) {
@@ -1635,7 +1692,9 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (ret)
 		return ret;
 
-	if (!is_d) {
+	if (is_d) {
+		WRITE_ONCE(mb->sds_misc_target_val, misc_val);
+	} else {
 		val = sds_mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
 		ret = regmap_update_bits(priv->map,
 					 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
@@ -1683,8 +1742,187 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	val &= ~RTL8365MB_SDS_NWAY_EN_MASK;
 	val |= RTL8365MB_SDS_NWAY_RESTART_MASK;
 
-	return rtl8365mb_sds_write(priv, sds_index,
-				   RTL8365MB_SDS_REG_NWAY, val);
+	ret = rtl8365mb_sds_write(priv, sds_index,
+				  RTL8365MB_SDS_REG_NWAY, val);
+	if (ret)
+		return ret;
+
+	/* The re-latch edge has only been observed with HSGMII, so the work is
+	 * only started for 2500base-x. Start a new episode and kick off the
+	 * first attempt; see rtl8365mb_sds_relatch_work() for why this cannot
+	 * wait for phylink to ask again.
+	 */
+	if (is_d && interface == PHY_INTERFACE_MODE_2500BASEX) {
+		WRITE_ONCE(mb->sds_relatch_count, 1);
+		schedule_delayed_work(&mb->sds_relatch, 0);
+	}
+
+	return 0;
+}
+
+/* Put SDS_MISC back to the target mode. The lane stays parked (mode field
+ * DISABLE) until this succeeds, so retry a few times before giving up until
+ * the next run.
+ */
+static int rtl8365mb_sds_relatch_restore(struct rtl8365mb *mb)
+{
+	struct realtek_priv *priv = mb->priv;
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < RTL8365MB_D_SDS_RESTORE_TRIES; i++) {
+		ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
+					 RTL8365MB_D_SDS_MISC_CFG_MASK,
+					 READ_ONCE(mb->sds_misc_target_val));
+		if (!ret)
+			return 0;
+		if (i < RTL8365MB_D_SDS_RESTORE_TRIES - 1)
+			usleep_range(1000, 2000);
+	}
+
+	dev_err_ratelimited(priv->dev, "failed to restore SDS_MISC: %pe\n",
+			    ERR_PTR(ret));
+	return ret;
+}
+
+/* The family D receiver latches on a DISABLE -> mode edge in SDS_MISC
+ * rather than on the value, and only once the far-end MAC has brought up
+ * its half of the link. No local signal predicts that (bit 8 of the SDS
+ * link-status word does not change ahead of it), so the work cannot wait
+ * for it, only check afterwards whether an edge took. Nor does phylink
+ * call rtl8365mb_pcs_get_state() for a link without in-band signalling
+ * such as the fixed-link CPU trunk (mb->pcs.poll only arms phylink's own
+ * poll for in-band links), so this cannot rely on being polled at all.
+ * Instead, pcs_config() starts an episode and this work re-arms itself
+ * after every edge, its next run checking whether the edge took.
+ *
+ * An episode is capped at RTL8365MB_D_SDS_RELATCH_MAX_TRIES edges, spaced
+ * RTL8365MB_D_SDS_RELATCH_INTERVAL apart, so that a far end which never
+ * comes up costs a bounded burst of 20 ms parks. The run after the last
+ * edge only checks whether it took and reports failure; from then on one
+ * edge is driven per RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL, so a far end
+ * that comes up late is recovered without a reconfiguration. Once the
+ * receiver has latched the work just polls the link at the same slow
+ * interval; finding it down then starts a new episode, e.g. after the far
+ * end reset its PLL without a reconfiguration.
+ *
+ * sds_relatch_count is the number of the next attempt of the episode: 0
+ * while latched, 1..MAX_TRIES in budget, MAX_TRIES + 1 for the run that
+ * only reports, and above that once out of budget.
+ */
+static void rtl8365mb_sds_relatch_work(struct work_struct *work)
+{
+	struct rtl8365mb *mb = container_of(to_delayed_work(work),
+					    struct rtl8365mb, sds_relatch);
+	struct realtek_priv *priv = mb->priv;
+	u32 park = (READ_ONCE(mb->sds_misc_target_val) &
+		    ~RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK) |
+		   RTL8365MB_D_PORT_SDS_MODE_DISABLE;
+	unsigned long delay = RTL8365MB_D_SDS_RELATCH_INTERVAL;
+	unsigned int attempts;
+	u16 status;
+	u32 misc;
+	int ret;
+
+	/* An earlier run may have failed to restore the target mode, which
+	 * leaves the lane parked. The mode field in SDS_MISC says so: put it
+	 * back before anything else.
+	 */
+	ret = regmap_read(priv->map, RTL8365MB_SDS_MISC_REG, &misc);
+	if (ret) {
+		dev_err_ratelimited(priv->dev,
+				    "failed to read SDS_MISC: %pe\n",
+				    ERR_PTR(ret));
+		goto rearm;
+	}
+	if ((misc & RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK) ==
+	    RTL8365MB_D_PORT_SDS_MODE_DISABLE) {
+		if (rtl8365mb_sds_relatch_restore(mb))
+			delay = RTL8365MB_D_SDS_RELATCH_INTERVAL;
+		goto rearm;
+	}
+
+	/* The condition that queued this work may already be stale by the
+	 * time it runs (e.g. an earlier edge from a prior attempt just
+	 * latched). Parking an already-live link would drop it for no
+	 * reason.
+	 */
+	ret = rtl8365mb_sds_read(priv, RTL8365MB_D_SDS_EXT0_INDEX,
+				 RTL8365MB_SDS_REG_LINK_STATUS, &status);
+	if (ret) {
+		dev_err_ratelimited(priv->dev,
+				    "failed to read SerDes link status: %pe\n",
+				    ERR_PTR(ret));
+		goto rearm;
+	}
+	if (status & RTL8365MB_SDS_LINK_STATUS_LINK_MASK) {
+		/* Latched: end the episode, keep watching for a later loss. */
+		WRITE_ONCE(mb->sds_relatch_count, 0);
+		delay = RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL;
+		goto rearm;
+	}
+
+	attempts = READ_ONCE(mb->sds_relatch_count);
+	if (!attempts) {
+		dev_warn(priv->dev,
+			 "SerDes link lost outside a reconfiguration; re-latching\n");
+		attempts = 1;
+	} else if (attempts == RTL8365MB_D_SDS_RELATCH_MAX_TRIES + 1) {
+		/* This run only checked whether the last in-budget edge
+		 * took. The first out-of-budget edge comes one healthcheck
+		 * interval from now, not on this pass.
+		 */
+		WRITE_ONCE(mb->sds_relatch_count, attempts + 1);
+		dev_warn(priv->dev,
+			 "SerDes did not latch after %u re-latch attempts; still retrying every %d s\n",
+			 RTL8365MB_D_SDS_RELATCH_MAX_TRIES,
+			 RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL / HZ);
+		delay = RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL;
+		goto rearm;
+	}
+
+	if (attempts <= RTL8365MB_D_SDS_RELATCH_MAX_TRIES)
+		WRITE_ONCE(mb->sds_relatch_count, attempts + 1);
+	else
+		/* Past the fast-retry budget. The receiver latches only on a
+		 * DISABLE -> mode edge and nothing re-runs pcs_config() for a
+		 * link without in-band signalling, so keep driving one edge
+		 * per interval.
+		 */
+		delay = RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL;
+
+	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
+				 RTL8365MB_D_SDS_MISC_CFG_MASK, park);
+	if (ret) {
+		dev_err_ratelimited(priv->dev,
+				    "failed to park SDS_MISC: %pe\n",
+				    ERR_PTR(ret));
+		goto rearm;
+	}
+
+	usleep_range(20000, 21000);
+
+	if (rtl8365mb_sds_relatch_restore(mb)) {
+		/* The SerDes is left parked: come back soon rather than
+		 * at the (possibly 10 s) pace chosen above.
+		 */
+		delay = RTL8365MB_D_SDS_RELATCH_INTERVAL;
+		goto rearm;
+	}
+
+	dev_dbg(priv->dev, "SerDes re-latch edge driven (attempt %u)\n",
+		attempts);
+
+	/* This edge may not have taken either; the next run checks. */
+rearm:
+	schedule_delayed_work(&mb->sds_relatch, delay);
+}
+
+static void rtl8365mb_sds_relatch_cancel(void *data)
+{
+	struct rtl8365mb *mb = data;
+
+	cancel_delayed_work_sync(&mb->sds_relatch);
 }
 
 static bool rtl8365mb_interface_is_serdes(phy_interface_t interface)
@@ -1832,11 +2070,20 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
 	}
 }
 
+static void rtl8365mb_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct rtl8365mb *mb = pcs_to_rtl8365mb(pcs);
+
+	if (rtl8365mb_get_family(mb->priv) == RTL8365MB_FAMILY_D)
+		cancel_delayed_work_sync(&mb->sds_relatch);
+}
+
 static const struct phylink_pcs_ops rtl8365mb_pcs_ops = {
 	.pcs_inband_caps = rtl8365mb_pcs_inband_caps,
 	.pcs_config = rtl8365mb_pcs_config,
 	.pcs_get_state = rtl8365mb_pcs_get_state,
 	.pcs_link_up = rtl8365mb_pcs_link_up,
+	.pcs_disable = rtl8365mb_pcs_disable,
 };
 
 static int rtl8365mb_ext_config_forcemode(struct realtek_priv *priv, int port,
@@ -3548,6 +3795,10 @@ out_error:
 static void rtl8365mb_teardown(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		cancel_delayed_work_sync(&mb->sds_relatch);
 
 	rtl8365mb_stats_teardown(priv);
 	rtl8365mb_irq_teardown(priv);
@@ -3580,6 +3831,21 @@ static int rtl8365mb_get_chip_id_and_ver(struct regmap *map, u32 *id, u32 *ver)
 	return 0;
 }
 
+static int rtl8365mb_sds_reboot_notify(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct rtl8365mb *mb = container_of(nb, struct rtl8365mb,
+					    sds_reboot_nb);
+
+	/* Runs before device_shutdown() on reboot, halt, power off and kexec.
+	 * cancel_delayed_work_sync() waits for a running pass, so the SerDes
+	 * is not left parked and the bus is not touched while it is shut down.
+	 */
+	cancel_delayed_work_sync(&mb->sds_relatch);
+
+	return NOTIFY_DONE;
+}
+
 static int rtl8365mb_detect(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
@@ -3614,6 +3880,30 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 	dev_info(priv->dev, "found an %s switch\n", mb->chip_info->name);
 
 	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
+
+	ret = devm_mutex_init(priv->dev, &mb->sds_lock);
+	if (ret)
+		return ret;
+
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D) {
+		/* Registered after sds_lock, so on release the work is
+		 * cancelled before the mutex is destroyed.
+		 */
+		INIT_DELAYED_WORK(&mb->sds_relatch,
+				  rtl8365mb_sds_relatch_work);
+		ret = devm_add_action_or_reset(priv->dev,
+					       rtl8365mb_sds_relatch_cancel,
+					       mb);
+		if (ret)
+			return ret;
+
+		mb->sds_reboot_nb.notifier_call = rtl8365mb_sds_reboot_notify;
+		ret = devm_register_reboot_notifier(priv->dev,
+						    &mb->sds_reboot_nb);
+		if (ret)
+			return ret;
+	}
+
 	mb->priv = priv;
 	mb->cpu.trap_port = RTL8365MB_MAX_NUM_PORTS;
 	mb->cpu.insert = RTL8365MB_CPU_INSERT_TO_ALL;
-- 
2.53.0

