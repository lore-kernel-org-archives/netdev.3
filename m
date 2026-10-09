Received: from sonic317-34.consmr.mail.ne1.yahoo.com (sonic317-34.consmr.mail.ne1.yahoo.com [66.163.184.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D17361651
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522764; cv=none; b=njnSU3ha/HFVfw33FOWHvBoR+/i1UVWofiKYaFd4jJ5cHO9A1PP4777nkb6LoGQSf9JAKTNuNvgXJ+pPsryfqD9bneMVIHrqmhO6M2AvJaHxdOI3M9F7AoQoNcw86j1cx0c4zXpOlcgF+3Mf2sbS8XHxLkvB1T+pMcXAK0f0M6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522764; c=relaxed/simple;
	bh=lJB0N0I70OUihiO7CMKPB5wfmmJd3nJQpYgsCVQI94A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IkIqQkUcTTIgkIBFf6FWpf9zbU4VaQZKd3+vDtyesTI55SdGpFOnSl8xAy1cvKGhTH96oSpwhcs34E8R7ophbvNxWAh/lKnuPf+K46E+TdqgB4COrBNwH6RrZ5D8cQJ+G2n/zU8cBpxH8TSGIqUtGlkroNGSvz4pFDh/Pz+99HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CZ13Fgbr; arc=none smtp.client-ip=66.163.184.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CZ13Fgbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522762; bh=F+o9qzHMCnihkSn+PBS8dbsDPlOBnPHvcmza+dTNC/s=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=CZ13Fgbr64fQ8wIbSrGh2osp3j9OvyvE0pLR/dmMWwIPRZIv9ulVr024Zju//ZqHrJBYPswxIrbLHNwt/Ynd6RXkSDQ6sH1JESRkeUE0Vc6iZVIX9wCz0rtntUzejdpI91/RBTnO/fMNrTgQugIhnHIyJOIv3ZWlDQ85gTccVQ8zYDqzgGkVLzACktf0Cnd29BiXEGPQS1TOamJcjnNhFalZRwtApnJXd3OnCqfG1mmC+e4GRomaWxLAqpiiAGbtRvvQ8ZM9j0oh1jN3X6DG0caNXUcuZvTYREo5VoxaIxLP6nHbh0QuEoXZAcCWw33HxdTZ0xY4C3VASoiHPEba5Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791522762; bh=M2MZgIeIR5pzm7zSwYYo7Y3p0RlqzYg/7h7lwrTs2c7=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=EuA6erJAc8ld6HtOZ6xbofsCmuF/0rb8dQC1W81QzGEW7iqqAFIxHRaM3TAOyfPyG+v6zOXB/+XXsD+gY8YHjge12KHoGZRvPYtNcrF/nU+VBNKiRLsRCL5gYD50+7IDtKLAGtx4NVWUsFhBvdhMURpQHQ4pkcqooOvnxGpplYc2cUb0mW5AA4NRf/odjZJZv/rtCJrnEBOiEfJ4WF0Yyg9koG3l55FB/zzfkJvE0M97CVSKu56lPM89ZLtfBaoZNpl0woOefj98iQq3AP6XwfMILtWbHZCxMXp8s7LS+GpKAq+RWszAaQK/MNcf4apDaM/H5VhFiMYN0chRtb/N5A==
X-YMail-OSG: Fa77bf0VM1lZOgFVX8eH8JKZqCF0_3WWUpnbr4EsxyoOf__50zAEq7UqaWI08c5
 6rCv7KeRyOEez7LtK36moaQrb7QJkOTNGHPnWboYlqpM14a3QdI.NEffCw8myrvIU5FYMwwM3inY
 cGXY9HYmCuL692D9y_QYKk_vRmLzv2z5YlWuFOHy3dj8Mk6mDo5UE8fVUm2y5xgliF6k_Qe.z.es
 fMp4QuU0OGfCktc8e8byC.ogRIn_3Q.BzW7bKsxlfExD18kF62vCXdmY4xxRFmkJo0CWxigdMNxP
 Qo7Q.MbOw_BYrsQOwOcCcch838a3AEec.LjctKVmRfmC20wL6oBxyp5UWUkRV3PP8_fNx7n69bia
 kQaW2V1vVrqH4KMYEHrvVsG_Fv4dublSBqm8QpgbwxpbjMkx1n0MSxN3sGoL6vfJwq9nFebuCN1f
 2RAmlwILMyBxLSbNbe4cPNgShVe6gIBZqWCueLsHUBqaPN1IOvao6NzGF94FADDqaUmezfFIm1My
 KlSNhORKFDr_ksAfCC5humzrDzzQNdfDYXcbHRlOOrIJzsgQ7MRk.JziB6nnSkuZ1iBIIhs4gfqN
 YR7vvGqwWqqltx7FDiJEkuPxyEmW9J_26d4uV_nFKS62mA41Xm5OiYZfPOIuNqSZA2tz3zjxlPlH
 KkdD2KWmTjKbBuzRQ4ecZBWcXH68jIDstlRgingUX8lDLOhIxfLX5rgG9.klAw03_WzmqhHjxvph
 QEJufp7sX_5UNChSPlAcoBptx.DhbrvhYOfFaA8EZ35hF9DuHIgTeH0SH51KfFq0M8Qvx3kIoyKB
 7EjRAYK2FtZricIwysuIMrt.SkjQxVlOVCIJjcZz7l843uN0.cEIzTkUmMPcEOTXZWJ9kpVInBQc
 t1ZgvpyrhBUZTcwGYPu2.SzDuCIwNlUMSiTQwnONsRLo2ODrQHFxEkwC2YBmMY_zzc_x69ipMd4d
 DnUCbCzNrr2liMZnPkETNJc226zCVl8OfiWNq.Uiw1lZcuAoR4Lcam1NHsHs5leOpR2JYgvc5IRb
 Y99p35.HTlEvpGTvzOll74Tycjfz0rxtO4_S1mt_yuSCp.Hv7KslLBi53RXZPDpn_iFGbJSGFahJ
 .0QpTElyBlc16Vs0Kk_vQu_Mb4PtYU1huLDeaT.2GV9JcZphy9i9zEgiCemT_Y7Q5J44qqYO7XdV
 PsB1r6xK5Dw.LdMkPXeZpj3hT7q4XQ8wPCG72WChAhTYLRFZcJAYh_K3JoiXb0vClsZbtLYnJRwp
 GgpxvEc2n8TncGeMdKH.QEvJf1rjPx.E3ncWnJfLSEkDwfe8UNfRGe59QOmat5FGuaF3NS08uyOd
 5nQc3bHMJ0LyMqSvRDDx8PnkqTAiqLOM9bmqopfDiDaBjmtCIlq5bVrGZ6hPqZ5JdbjC5iAolqks
 vElEvM1HYUCOBQ38rslK_WdukdUR8CkZ8zRpO7d.l5mw34Q7FC9OeKhgkkXGdT0Pw_ySRz5Nrnc2
 RrBWexBqLPreLjDNjejaODEZOn.7RDKXzi.exjfMcNFnIeiS4ZgDLPzvgQf68CsDDL0Dss93.lOJ
 J9BJzokAMfVmTHH5nv9fcM7C2U.vG4AsbkGN5tmSqGsd3t1jGJVpMxMRUw8QH.bBiBfZVWbICFE0
 b_xTsYBTxclaSrQeAUCXw2fU_5QO8ELTrhw5FgKDGsh0euZ.dDyVgs_DLyFA1cp1L_y3Y7bgPdgZ
 TGOz2Gt9nU1DZr.x3XPgy3KX6RBcl21Q5c8JhQSnceVQktv_h0CBbCgk_AIJ4jsFg5KPe9nFQI5B
 4OFkOrhg_G0jD9QOzLTTZLl.DPqhsBzPsaPtc_2BKjpgwUbfIU8IJbJ3FUiqCZOeLjw6QIhlZGkI
 jR3uyPlwvOkiXM9CVYK9G.d4sUPLHIyETLT694owZmRjKyDB6IEHpvGcaqJpgj6SWUJ5nWht1zgx
 vwrkzhwyKetnVn_u3.4ZmDLzld5EZfPrXs_aEm2HwP30NXp7bzzhF_3N7Nh6KNT8hjNWsHQSWYHx
 ON4qO6TbeWfA51lR7rXeN2crhUVp4OMSZwNTCdW3IWp7w8sq3zjM6Tt0zibwfxfnnFBT908Em5tC
 qbmFWklWxJIVq1MPvDvuwmJ8gjFgnRHp9uvGAlPC3gVhPfJvEPoG0MFCx4X2qZjgwDgE5Fgs8MnZ
 Zp6Xue6qXGF9tv6G42utH60HYsuubcOpKm1Ka8bqtGGjkNUVs3FUC3ePOwtHrU2OPGGc_jbdzOMs
 xiltr5x0m72fh0Ac5Z9iPU0d9eIBgMkHydV3h3srBtrHQyw86xR6C1Dr_rxnhL9JzhEKwzfWiPV6
 EDBd2B3yhqQN5JLu0TmKBux5RXgxCXYgOmTEjIRJldCE-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 0a6d6526-ef11-4014-aa54-fe781818809a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Oct 2026 05:12:42 +0000
Received: by hermes--production-ir2-5dd9bf4598-b6ftf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b2d561c4a9a0e54f102a2678d063df87;
          Fri, 09 Oct 2026 05:02:25 +0000 (UTC)
Message-ID: <af4b65e2-0fd0-4bb7-b34b-d64ec0f91955@yahoo.com>
Date: Fri, 9 Oct 2026 07:02:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 8/8] net: dsa: realtek: rtl8365mb: re-latch the
 family D SerDes
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
performed by a short work: sleeping is not permitted in the PCS ops,
and the work also serializes against pcs_config() re-runs, which
cancel it. Before parking, the work reads the link status itself and
does not park if the receiver has already latched, since the condition
that queued it may be stale by the time it runs; it then ends the
episode instead.

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

The work now accesses the shared SDS_INDACS ADR/CMD/DATA window and
SDS_MISC concurrently with the PCS and MAC link_up paths and
pcs_get_state(), so those accesses are serialized by a new sds_lock.

The work is cancelled in teardown(), and in pcs_config() before
SDS_MISC is touched, since a link that flaps would otherwise re-arm
the sequence against a half-reconfigured SerDes.

Co-developed-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 233 +++++++++++++++++++++--
 1 file changed, 218 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 4cad90f..eb71c89 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -98,6 +98,7 @@
 #include <linux/irqdomain.h>
 #include <linux/mii.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/if_bridge.h>
@@ -300,6 +301,23 @@
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
+/* How often a latched (or out-of-budget) SerDes is checked, and re-latched
+ * if still down. Much slower than the re-latch interval.
+ */
+#define RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL	(10 * HZ)
+
 /* SerDes internal registers, accessed via the SDS_INDACS registers. The BMCR
  * data path reset holds BMCR_ANENABLE | BMCR_ISOLATE while toggling the
  * vendor-specific low bits from phase 1 to phase 2, which triggers a data path
@@ -942,10 +960,16 @@ struct rtl8365mb_port {
  * @chip_info: chip-specific info about the attached switch
  * @cpu: CPU tagging and CPU port configuration for this chip
  * @mib_lock: prevent concurrent reads of MIB counters
+ * @sds_lock: serializes access to the shared SDS_INDACS ADR/CMD/DATA window
+ *            and to RTL8365MB_SDS_MISC_REG, reachable both from phylink's
+ *            PCS callbacks and from the family D SerDes re-latch work
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
@@ -955,9 +979,13 @@ struct rtl8365mb {
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
@@ -1361,43 +1389,53 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
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
@@ -1407,15 +1445,19 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
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
@@ -1537,6 +1579,13 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;
 
+	/* Cancel any in-flight re-latch edge before touching SDS_MISC: the
+	 * work drops sds_lock across its sleep and could otherwise interleave
+	 * with the reconfiguration below.
+	 */
+	if (is_d)
+		cancel_delayed_work_sync(&mb->sds_relatch);
+
 	/* Select the appropriate tuning table and SDS mode */
 	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
 		if (is_d) {
@@ -1617,12 +1666,16 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK;
 	}
 
+	mutex_lock(&mb->sds_lock);
 	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
 				 misc_mask, misc_val);
+	mutex_unlock(&mb->sds_lock);
 	if (ret)
 		return ret;
 
-	if (!is_d) {
+	if (is_d) {
+		WRITE_ONCE(mb->sds_misc_target_val, misc_val);
+	} else {
 		val = sds_mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
 		ret = regmap_update_bits(priv->map,
 					 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
@@ -1669,8 +1722,140 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	val &= ~RTL8365MB_SDS_NWAY_EN_MASK;
 	val |= RTL8365MB_SDS_NWAY_RESTART_MASK;
 
-	return rtl8365mb_sds_write(priv, sds_index,
-				   RTL8365MB_SDS_REG_NWAY, val);
+	ret = rtl8365mb_sds_write(priv, sds_index,
+				  RTL8365MB_SDS_REG_NWAY, val);
+	if (ret)
+		return ret;
+
+	if (is_d) {
+		/* Start a new re-latch episode and kick off the first attempt;
+		 * see rtl8365mb_sds_relatch_work() for why this cannot wait
+		 * for phylink to ask again.
+		 */
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
+ * ever call rtl8365mb_pcs_get_state() for this fixed-link port
+ * (mb->pcs.poll only arms phylink's own poll for in-band links), so this
+ * cannot rely on being polled at all. Instead, pcs_config() starts an
+ * episode and this work re-arms itself after every edge, its next run
+ * checking whether the edge took.
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
+		 * fixed-link port, so keep driving one edge per interval.
+		 */
+		delay = RTL8365MB_D_SDS_HEALTHCHECK_INTERVAL;
+
+	mutex_lock(&mb->sds_lock);
+	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
+				 RTL8365MB_D_SDS_MISC_CFG_MASK, park);
+	mutex_unlock(&mb->sds_lock);
+	if (ret) {
+		dev_err_ratelimited(priv->dev,
+				    "failed to park SDS_MISC: %pe\n",
+				    ERR_PTR(ret));
+		goto rearm;
+	}
+
+	usleep_range(20000, 21000);
+
+	mutex_lock(&mb->sds_lock);
+	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
+				 RTL8365MB_D_SDS_MISC_CFG_MASK,
+				 READ_ONCE(mb->sds_misc_target_val));
+	mutex_unlock(&mb->sds_lock);
+	if (ret) {
+		dev_err_ratelimited(priv->dev,
+				    "failed to restore SDS_MISC: %pe\n",
+				    ERR_PTR(ret));
+		goto rearm;
+	}
+
+	dev_dbg(priv->dev, "SerDes re-latch edge driven (attempt %u)\n",
+		attempts);
+
+	/* This edge may not have taken either; the next run checks. */
+rearm:
+	schedule_delayed_work(&mb->sds_relatch, delay);
 }
 
 static bool rtl8365mb_interface_is_serdes(phy_interface_t interface)
@@ -1735,7 +1920,9 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
 	/* The speed and duplex are forced; read them back from the values
 	 * programmed into the SerDes MISC register.
 	 */
+	mutex_lock(&mb->sds_lock);
 	ret = regmap_read(priv->map, RTL8365MB_SDS_MISC_REG, &val);
+	mutex_unlock(&mb->sds_lock);
 	if (ret) {
 		state->link = false;
 		return;
@@ -1805,7 +1992,9 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
 	 * force from rtl8365mb_phylink_mac_link_up(), where the resolved pause
 	 * modes are known.
 	 */
+	mutex_lock(&mb->sds_lock);
 	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG, mask, val);
+	mutex_unlock(&mb->sds_lock);
 	if (ret) {
 		dev_err(priv->dev, "failed to force SerDes link: %pe\n",
 			ERR_PTR(ret));
@@ -2114,11 +2303,13 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
 			if (rx_pause)
 				val |= RTL8365MB_SDS_MISC_SGMII_RXFC_MASK;
 
+			mutex_lock(&mb->sds_lock);
 			ret = regmap_update_bits(priv->map,
 						 RTL8365MB_SDS_MISC_REG,
 						 RTL8365MB_SDS_MISC_SGMII_TXFC_MASK |
 							 RTL8365MB_SDS_MISC_SGMII_RXFC_MASK,
 						 val);
+			mutex_unlock(&mb->sds_lock);
 			if (ret)
 				dev_err(priv->dev,
 					"failed to force SerDes pause modes on port %d: %pe\n",
@@ -3330,6 +3521,10 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	 */
 	mb->pcs.poll = true;
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		INIT_DELAYED_WORK(&mb->sds_relatch,
+				  rtl8365mb_sds_relatch_work);
+
 	ret = rtl8365mb_reset_chip(priv);
 	if (ret) {
 		dev_err(priv->dev, "failed to reset chip: %pe\n",
@@ -3514,6 +3709,10 @@ out_error:
 static void rtl8365mb_teardown(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		cancel_delayed_work_sync(&mb->sds_relatch);
 
 	rtl8365mb_stats_teardown(priv);
 	rtl8365mb_irq_teardown(priv);
@@ -3584,6 +3783,10 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 	else
 		priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
 
+	ret = devm_mutex_init(priv->dev, &mb->sds_lock);
+	if (ret)
+		return ret;
+
 	mb->priv = priv;
 	mb->cpu.trap_port = RTL8365MB_MAX_NUM_PORTS;
 	mb->cpu.insert = RTL8365MB_CPU_INSERT_TO_ALL;
-- 
2.53.0

