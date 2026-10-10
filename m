Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C935348C7B
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661448; cv=none; b=SICX3qmR9HdPzxlD1Qyli2ejVrQVuPIdIYhPdFOqwHtf3lo92CuOPLpegF+rBUGRR1cj2MQhAgvuwbX6JL8FS4PVjHqKH5BZaETvWYGIqeXNiQ4Q91vuX0fGa9UeVKqcKX9ToyOiKNVY+FcdX/1WK6tb/s4KqPH8octJ/WlD3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661448; c=relaxed/simple;
	bh=wIqo9BCNvV8w5SPKWgCd8awdr65K5KBzCTYPZJGWbeo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=S9REyvBJU0e7kAInduDYbycwZO12qdnf+miKO2/D2TXOgtfOLYmRzRMHXd54GVwjRhfeE3yAJx2Qb9PmQCfsRRl4SLezeOhukpIe/YA5mCbPa8FvWD94NMHFCdyEMVS5rpmYE3JVKmSAiWN1B9zoUaDhREy81aD2CliskQleZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TsMVcK9H; arc=none smtp.client-ip=66.163.185.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TsMVcK9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661445; bh=NkePJ/eKajBxDn/tnMMJUY8j4Rvy0B9cMSJbDL//dTU=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=TsMVcK9HzdzwxkaP95kKazlHznLl7DyLU8VMdnfnen7TdvDnIt2omCqaEdyDdu0b8PshpRuI7xzdgbQBvNFC0EGNPzoBORuPCPmJWDl1L64olEnVNesq5/ES1IJfsTqoUvQRS855lF08o5qtoguZCHO5yoH6AyJQR5t2gMf2EwdxBsSCXim/T/ZTmNGIv0vEYAwOEveb9PcNBPLcbXLX76+IFWAe3gr056aMFjBmHZm1VMnSM+3QVfZtykRN3xcEfFmmM4IfVPl8pO0YbCYLfNT2SnVQTnY8QB8xi1lZ2VIfcGklEIyYFC7nnAJyIL7jtyO442DEJNXzkx7SQ9ZMLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791661445; bh=Aq1yFJOndcUpj8ry0MgdmSwkIem7HwFFsUtzANpJaml=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=mPDI82HdIHNGFu1o5thDj2lMLxzIgyVXrw70cNUP5YFJcSbSxhUUyRFdH/Pq0iO8/llAjUqTcCE3ERklm/8feCUhI1oqjM5LOKhjFFN6PE8RNaPLMAAgJpTCsPcPwSq6L22VdR3fGsREs+o658uEiIQJKXqbmtG8pFml6DUGV6F7ku+X0ib1OQJ0LTgiZ9B7Nor7yrvTWv8/7rx8JQqqXwcwAXC3kblP/FS9c4ft+uMcglKtrTBAPjEMFLGsf1rsS3c+FxbIJiZvpVITiTUlK4qjmmLza8iirJgSln4DEbqIkgKtvvkVE4Bq7olv4GzYc+055xRoBUUbHAhCexhrcw==
X-YMail-OSG: bzmf8AEVM1msgzndfRyJMujEk_mvr607GY1wq9Ecer7nbs8btNDqFn1GgRdHET4
 VJGBWQTTmXhBOkjw2ouZu7EZ5t6K2mbgj5j7jyqG_3Pj0n5OvtUcWRvCAzqQMJSxG0FEN45ulOv4
 XmgzryKlMnyjhqFGXGtbaUp45Pp1hhC6q2bDqER9PlmkYqCE0_ow_Gpf0fU91yqW_2tNcOUw9oAk
 Fjoly0BfuhWl1VxWkQZCL.ufQ71UrGDGuNv5dGRAH1IXwGitmN8jM1e8AHTfo2mV.fMyn6ihRfbQ
 CdjB5EavuB2bPkIN9iZzvKeQMZoArTbHhFuUfRlYOQDaJlwhHzNJoA1dmkn3tINA77qFVxby2jPZ
 nxhDI1Jcms6LwwbCy6a2AICxX.BB58ktlvsyy7.lMTqb1pfVwFcloXjTQgFG.oRAcCCsWH6snLzv
 CeGtxU1yfPT3hOXWj.3bTSo5VFRgcR6eNpX0l.S0XsWeLWhePhntwNWFnwXN4RKbPfHgRDFgTuik
 YPf22bX30Zp62SYV664hHGV5jDiTaTMcxugsgzlCsB6saKLJ3ayKgz7JKMVVYDh.g72ZzzyPj6Bt
 MljxxiQCfnBVLePHAqMonwOtS2f7vWtbDMg6HORFf7SIaMi5oM2uVi.G79pfGN9UXL1qpupWvLBy
 ZfVmKSBsyYgXy1EJcOSPpuvDu8gI9CKBXawCdJSo6KSHmXtpOcYc4BGu_KPvSTcQ1Y.GAme1NRzg
 AoRWZr3mYKEOKn9a04tfNw.w7XDLUKxOsG61qwD81iL_3bEPVZoC9pU3MP65ptqCvQkXeEYOHsKY
 P4Dy4qa6hkd0QFJ6J8xYo1Z6xZX5yjZUjYjaPyNfvtl.Gpt6WP9iAhPKY.McRHPRLPiCa0vp9rI_
 YRhLUhSfZ3vS8yrivS23Mq1rkUQoVhmpud.252XfZ1CzhR9_UXRYDLRqvZMNVNVsWAaXlSYDdfRD
 7YyFeIXtI.gCAq.ECCUgbcQr3pWFP21oG4DCiU3BNh3QrCslCdwjypZQPZLoEqh.ZjJL88cm_lUW
 bVkQKCCgRVu47MuKwMdII8LZVtens2.VsVLgYBitcrShRX5yfLimu33gjNlM.DPU0CPnZFXLge.z
 kdsgqKUSqQw2UEDo2Av0N7PwFTlAFatblJKuBi0pRqWNuL9xWNh1.5Ju1YlCOe99Vya3OMtYpLkE
 wkLXfaUSWcinyXYtgc6V56PG2t4i4qXdLpy5tXinWrV.43wAznIf9srE.K4kO5n.VZxy4WxPf3ff
 AyZ_JHOTcEgpTIy2OzvVWI046rOF5ZNP_hOs.lOnlZimzWEcmioTMRfsiQoAFWbTZdyyIiaEVpg0
 c7H6tw1A8HTqCMS5Ya1Fy1DFHwUl29UboL_QM3RhJfjIiys79vFrPKUJICR956o4uany.QNEw67i
 1uuB9SwZUh3G1qkxOduiHVbts7kzauu7iCvsSEuukGijyjC5.OsF9SLFxasvAYF8A09hdvybDblW
 l938ePLX_tTfzqRy8fK3J5wa27Q9R9UQ2g4HIHkOpfLdLZi6W6D2ZdT_tLFyzF16sAraweeJOZZ0
 AmyrR1ibtis15h_cS0W1s1D0ykRmkXw5Og1g9voy6JrsF98aDgtGmtvWEq_1QBFLv55QA4RqqxJ7
 txLJOnBP5RGW8Yt4z1OZr8vnObr8tGeFoufhBsffIsFBiakXK20C05hEq_SBAWOAHPSVBJTYflPq
 InRPyiLWWnFNqkTgf0PXWxrZGUvCyCJ4ubJRQs_zuX4.vB7WvGUrEPdflgPJWalJ33ycQCrBPq3B
 IbN1jSQdavYJPyBqV9Jhj7kw0WYUmEk2wKFqUM55B0u5DSpmnPiAiXDB0LMgC521HNqe8fRuaPj7
 Os5d6GBNgthD9xpmmOaTCBE.a.j2W_cybAhw3N4qefsoNUfog4gR3IJWeAPuOk4H0s1O_sSF0iQF
 TjKdEicOsPTqU7qp.SQdF9kWHil1onmrFHBy2UKIqTWIe8MJ.uL5pcwRdIrjeOF2G1pvZEGYWXZg
 gGM8Cx2fkPq7MXquqcG48tFwpLL6a4aZ0hwMPmZ6ppE0SlG9iOK4ryLa5TbyI7wWeU8BztiJLm.5
 lN7h2ELhLLVUmOk8qczIhR4VTp5_gQPqunernWCmPm28OkojEWfQ7qBvsiDnLMltkqUCVRkzPlsi
 vEGyh8QE4xMzBUC62rnuEgRxxMmu2aItKAR6CAM0RZEcKtwH9gv16c08u7G9ssr507HD3p9zoy8b
 EQBQiZvwafZYjFM_26_drucGbItIElkMY8qwZCOC3CSYLq0BCRoEFuxya5G_cEcmFsP78Ukhs0zq
 gJ27mbFzT2K7XsO4.0RVOzgWICdMLKd5UbJIQCkzaKSzQ7Ss-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: b22f7f13-db49-4a95-8086-bc41c832298a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Sat, 10 Oct 2026 19:44:05 +0000
Received: by hermes--production-ir2-5dd9bf4598-fvbwk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1116e2803c667d355160b1f9f9bf9040;
          Sat, 10 Oct 2026 19:44:03 +0000 (UTC)
Message-ID: <2a637a34-6d4f-4a07-88b5-04475ebbba2e@yahoo.com>
Date: Sat, 10 Oct 2026 21:44:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 8/9] net: dsa: realtek: rtl8365mb: re-latch the
 family D SerDes
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
pcs_config() before SDS_MISC is touched, from teardown(), and by a
devres action, so that it never outlives the PCS or the driver data.

Co-developed-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 264 +++++++++++++++++++++--
 1 file changed, 249 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 0d3a2a3..5d80409 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -97,6 +97,7 @@
 #include <linux/irqdomain.h>
 #include <linux/mii.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/if_bridge.h>
@@ -298,6 +299,28 @@
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
+/* The SerDes stays parked until the restore write succeeds, so a failed
+ * write is retried this many times before giving up until the next run.
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
@@ -928,10 +951,16 @@ struct rtl8365mb_port {
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
+ * @sds_relatch: re-latch edges and link health check (family D)
+ * @sds_relatch_count: next attempt of the re-latch episode, 0 once latched
+ * @sds_misc_target_val: SDS_MISC_CFG_MASK fields the re-latch work restores
  *
  * Private data for this driver.
  */
@@ -941,9 +970,13 @@ struct rtl8365mb {
 	const struct rtl8365mb_chip_info *chip_info;
 	struct rtl8365mb_cpu cpu;
 	struct mutex mib_lock;
+	struct mutex sds_lock;
 	struct rtl8365mb_port ports[RTL8365MB_MAX_NUM_PORTS];
 	struct phylink_pcs pcs;
 	bool sds_supported;
+	struct delayed_work sds_relatch;
+	unsigned int sds_relatch_count;
+	u32 sds_misc_target_val;
 };
 
 #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
@@ -1350,43 +1383,53 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
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
@@ -1396,15 +1439,19 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
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
@@ -1526,6 +1573,13 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
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
@@ -1611,7 +1665,9 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (ret)
 		return ret;
 
-	if (!is_d) {
+	if (is_d) {
+		WRITE_ONCE(mb->sds_misc_target_val, misc_val);
+	} else {
 		val = sds_mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
 		ret = regmap_update_bits(priv->map,
 					 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
@@ -1658,8 +1714,155 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
+	int ret;
+	int i;
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
+	for (i = 0; i < RTL8365MB_D_SDS_RESTORE_TRIES; i++) {
+		ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
+					 RTL8365MB_D_SDS_MISC_CFG_MASK,
+					 READ_ONCE(mb->sds_misc_target_val));
+		if (!ret)
+			break;
+		usleep_range(1000, 2000);
+	}
+	if (ret) {
+		dev_err_ratelimited(priv->dev,
+				    "failed to restore SDS_MISC: %pe\n",
+				    ERR_PTR(ret));
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
@@ -1802,11 +2005,20 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
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
@@ -3506,6 +3718,10 @@ out_error:
 static void rtl8365mb_teardown(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		cancel_delayed_work_sync(&mb->sds_relatch);
 
 	rtl8365mb_stats_teardown(priv);
 	rtl8365mb_irq_teardown(priv);
@@ -3572,6 +3788,24 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
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
+	}
+
 	mb->priv = priv;
 	mb->cpu.trap_port = RTL8365MB_MAX_NUM_PORTS;
 	mb->cpu.insert = RTL8365MB_CPU_INSERT_TO_ALL;
-- 
2.53.0

