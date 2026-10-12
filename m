Received: from sonic313-9.consmr.mail.ne1.yahoo.com (sonic313-9.consmr.mail.ne1.yahoo.com [66.163.185.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8630B640
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791764124; cv=none; b=dYoY8yPxSDxBlo57pNJsWZEFBjmVNV684yC7F8Y8dmjaiD4opMKA/G0THVHC3V1R4N6fkzOuMtX7wVscqaG9M8yidZgWtttEfp7Mi0QFIuzLkaNczvM4aIZAvNbfE7jw9rDQfTtNL5xES344NZiZr+kmk8V4RYT+cW8yB2yL6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791764124; c=relaxed/simple;
	bh=b7jVNyUgqJY6hK2voW68DxYe0zIrAU447v0HJeE9CrA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Vbqe8NE+N4OFeNQ6w6kHl1Smoyk/8DVdnm/ARRbEkBkmAq8sijyXBWjMmoWETrFIJN1O2/7rob5OKexsjAuPh24H2Omtt5lJA6TyljJrHplGtaYiG6prV7LzN28Mzq8SEKW37doGTuJiy2f2xurQxW0L73LPrQrbVbHA6hNU0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DsmYPA4H; arc=none smtp.client-ip=66.163.185.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DsmYPA4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764115; bh=dYm3tzka0y0BtDEPhuysf+PUAkeiOtPH8nhB4azMCgQ=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=DsmYPA4HqaVMBaZWr0zXpXkeXYjoYmsHzGm/Yn9YKygjFBcLIDJX5WSlip2RBrd0EKE98Zcixhk7ldSDbmhHO1Z6mOuVYtL1STXtLMi6YCSKK1dvHmTVDhSHixAu+xOTB0ORgpnoLHjVju7A+xh6qPpiezlK/LbtcobdLzHClYLq4wxqdM1GDSg4Nrmhn/8gWTHzASlwbkqk2SXlqXXMYzxEWeAF1rSZfspdnE1v5NjHOchaNRvU0/BTSnqHwoTUbpNCPw3ICjdkwihDN43mehglraLaLmwwYtXwEImjluV08aWO2xtQhLhsmQPzqEljZYIQsS2ydas0uT2klFzz9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791764115; bh=WHXKPVizB3tZheWAea3ntTbQx6pGw/9uqV2caNmilFL=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=jEA2715gp06AD1V0sqVERjL++wBS95XB+fivP6lKoZBcxlVhvGEGQzzQYDi57s+p1z7HquKooW7gYhNHVkBlSXDtShBua2KiK8WBvcR7NcDvFYl2AgIzdgcV8Wu4/OZOGDDIMCuRX3ndTRLq6P5bkIiAlDOXqm+HHu1nn5IveROwGMeQcVnvBqOX5759HtM/namNhMUtW7Cv51jkzM2fPJiwjEw3PvF4S0BRtQsAyhqlTzTFZp0/PIfaACpaBso4wLg0DbLFgy4JS0HSTuRUtNBdBR32t/DZ/ykpAyu43zEYa6scSB1JNCdXiVJ3GO+L+cG2x9SDyO9fI1RPU1BDHA==
X-YMail-OSG: Q2G.NswVM1lxLsPTtLVwDC2vHlwKDNTXoB1wudVvfnw.G.QwxkZxQybrd_mp_jM
 y1sDwvbpZlLaZEUO8q3vNWe.mSTcpi3fzS9q5HeBJWhQ2y3gVKoJv0NQ3vtSid_Q2aopFjs_MKNA
 kkvGp8GlqKJJ6snuQ9XYE1iu7fAeeMOfCNOHtw5ouuz1UheYUw0IQEn6cZWk1MGaTVchwDUbYAXg
 csdTvCq5IuwGSUeGdXqu1OiTHD.vt9Shq1Qfn1mQrSSgN9ds6qqdYG9.A.SjSt.d9yBriCkKd0nL
 VO5WknhKU8PQSmG4IFX4KolrEWPcgjcW.3_Zl1cMqR22m8WHUz0V01tSIgYCzqIexP3n3NArkCIb
 M62S706N_tUiB6r_JfSqy9lyNfEdULi9vKPpgfbFt644zxBsCTYqK.PJxwdAgk3huiqt_7g94MM_
 HWgBqw8ZCmDPoBIo0mqu.179wwinIP.hHEOM0Korb0KjJRcZu6X6b3EJ3V5rE5Ivq4SBmmufsjei
 MO2AWjR5p6qczQ53D_p8KBCooyGDUSfzId0l378yts5x7p8IAvC13EPCu57Sbhh9CUtIXyH.SpNJ
 Yyyu4iynkTpQNhuGc..2CwIUScZY1lGRhhF_pMZotFeCO1jo8P5R3x_zbqy9ixUmdCl1Ssgao9HL
 uY5u5Mcq1dud5KItPStnuyon09EO3x3BZaSNiX.cpbK3CL3po1oTyIXkuHWT20WAqP.HxROtvZRA
 9i0VWOgRSHP5xQqkd_5Wo0iIDF.zMJz0xp23At4wO8omJnwspseK8XrhGowFHGMThBd9Bm3_RB6g
 lBnHopTTP6gYH_86GIE.pDx4W5dpSyV7rSGScOmCR0lXuX_oLY6XLXJFaYegMMFRP.qhnLgcGOxE
 YhtH_f4oZ3AHt0ehtaCMICgVRv7gM_LMKaRAusqh9Va51ErxraR60KKMLND2dummQ.lYZiTY7Rgr
 esGfqrRNPV7d5D5ReQAF9Lab7_Xb5tW1zbExqOUHWZI4YxxSmTnDf5z1N0cnNN7AeUD.9jG6QcUO
 Go41bQfk98N12UswTdPQ16x40CALFME0ckcbqtnWvYaWQSaqDmbEd3oY53Aeuly_I40SB8wberNj
 WCAjwPH0VcDfLe2HO2j.0IlnxP455noGjrJyzKEEYNPS.RxV.yfAYF7HpUgL2MxwcRUUwIgvdcX6
 SFrdyOw7wlekEUJU7mjpLC70PS1PqKD0GL67Fr6bbB5bdw3cChE3b.lZWfuALaS6NtNDfRsoDv2M
 TMkPAbTE6phLOuabKlyPEG4SwZYcw7ZKpaWVWOqaUgtAQIbrZMVr5siSxyC7Fno3bOeop36wQKDd
 PkUW3ocy4mY_KtQPPwb08qKF69wldvgupGv7Q0mdUmq36hoeTrBVnrp3HPg5.uB7q_nE8NZuHWCo
 5sQnEUeIHsh5WdleVFgeQ1eYngpYnxhwygU3ZF5P9hCXbd.GBPsCQFZQJ6UhE92IelMW9aGCxOhB
 DaLpxDLr7gAUT62CwJ6QtD9xP1JOE5QpQIavcHsEHJ8mu7RTqSw4rR.9LVZVkPV4TlmIHciDRAmV
 Mk1zOlnrNIAdllApWX5Po0UfJdlREv5Ch2Xv9Vfbtrye0OIkPJz5lWt2oU3gJJ2zvsDp6M8j9Qem
 tpbav_MQt33dA0JoTPN55nYviEL5WwMBApaqJ12t9s9tmiQuEwzdNBfuw5OCUMyG9uddE4hfm9ah
 LJEcMyJC230Ze7ifq12M68PnaLH3CE2XdQxlF7eIMKkN3UsI0BJq5eBet7w1jJOppnZURxDzrgc0
 AYgqk74ORt35U5OhMeRImUlvDzK7rCrvQDEVusybIn3r2vdpz3W_DpAZFOFV0qOYOzc5Leq6CvKw
 L8ZmvtE0V33jro1zS6vmIbLcbA7eaGXyjU.e4FTRASnU0wUh_OIIkL8TAythBe7SMyF0ZlWTL25p
 ZL58qnukLo2h.SOEEQE2DzYvuFtyZgLEPckYRX4Acr9DvmxBBuWYkZxpId7CsUkPL2yIADxeAVhn
 9c4N256NWtpp0BLDddwLvYXKWC15.vqzEBFq7qeMmEoFl7QwFLpQU7vXv6hafxVC0d5zK04Lx5QC
 mAk2hws.h8tLUKuxagGZBZp7YDi0t49yiyK5WD9LK8h8GwJYW50c7rKxh1iaAPzwSHHvnyva1vLa
 GoIAbqFzpuNmeDd8nGOVMn4xDIRAaRJ.nOBMQZl0j1akqdKyhPBqklPDb830bS2C6iWlatvwgcql
 bn5dhqYQUQ8jz1w5W7FuKns27cbGPo23CBHWva.gUVGKyM0TwJg0.5rkaF4LWJU5bz95onG3BFYw
 v02Dc_mZkEpD8qtbGtV3qagKlRgFC5vxEcSdpweuDEVfB2jw-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 748cd764-a9c7-4325-9dc1-d4637ede2add
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2026 00:15:15 +0000
Received: by hermes--production-ir2-5dd9bf4598-z289g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 329b165d28b30cea6a8939ad4d08cd1c;
          Mon, 12 Oct 2026 00:15:12 +0000 (UTC)
Message-ID: <98dbdca5-77c0-4027-aacc-4f97de5f3bb7@yahoo.com>
Date: Mon, 12 Oct 2026 02:15:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v4 8/9] net: dsa: realtek: rtl8365mb: re-latch the
 family D SerDes
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
Content-Language: pl
In-Reply-To: <38872e6f-1264-4a93-9f81-8212173e909d@yahoo.com>
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

If restoring the target mode fails, the lane would stay parked. The
mode field in SDS_MISC tells so, so the next run puts it back before
doing anything else. rtl83xx_shutdown() clears the driver data and
nothing stops the PCS then, so the work does nothing once the driver
data is gone; a devres action cancels it on unbind.

Co-developed-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 301 +++++++++++++++++++++--
 1 file changed, 286 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index d23e80f..bef95f9 100644
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
@@ -299,6 +300,28 @@
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
@@ -938,10 +961,16 @@ struct rtl8365mb_port {
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
@@ -951,9 +980,13 @@ struct rtl8365mb {
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
@@ -1360,43 +1393,53 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
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
@@ -1406,15 +1449,19 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
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
@@ -1536,6 +1583,13 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
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
@@ -1621,7 +1675,9 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (ret)
 		return ret;
 
-	if (!is_d) {
+	if (is_d) {
+		WRITE_ONCE(mb->sds_misc_target_val, misc_val);
+	} else {
 		val = sds_mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
 		ret = regmap_update_bits(priv->map,
 					 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
@@ -1669,8 +1725,192 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
+		usleep_range(1000, 2000);
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
+	/* rtl83xx_shutdown() clears the driver data and nothing stops the PCS
+	 * then: do not touch the hardware or rearm after that.
+	 */
+	if (!dev_get_drvdata(priv->dev))
+		return;
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
@@ -1818,11 +2058,20 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
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
@@ -3532,6 +3781,10 @@ out_error:
 static void rtl8365mb_teardown(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		cancel_delayed_work_sync(&mb->sds_relatch);
 
 	rtl8365mb_stats_teardown(priv);
 	rtl8365mb_irq_teardown(priv);
@@ -3598,6 +3851,24 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
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

