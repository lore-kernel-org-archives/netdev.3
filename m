Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6B414A2F
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406383; cv=none; b=uUA0oRqrDtT7ipOshb0ZJb4475UDo1JT0T4ywtIQoyQ7xY3wJjHd/gFspvgYHE41DFIyrOgbICpaYzevgxJR1//A187Wt1XA9rdLz+devRjeT5GNcrPwNSSqo4heC6OLwUfVTo8BtFS0JZsG5/msajUiPCJWYLdU7RNeAYy10zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406383; c=relaxed/simple;
	bh=wxgSGzMLm4dtphI1SRu9FvsQcqrNgupPjrySMBjKdt4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=kWLOSe6BuGJF5xf/2e/+2KG/z1b5iE5Dl5yvwv21TfxpFvTo8vFxRIlFPQU2Gvs//a1hl8tuBH1DqRDNH+XE0h3Dx6CpSNJwKILADhBTe5qsGtaYz2UQEl3dGnvgkCNlQa9HCenACGhWV8MNDdV/mnJGUDRga6rI06gpFGUtZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=iLtmN13P; arc=none smtp.client-ip=66.163.190.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iLtmN13P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406379; bh=akmwxgiOOBQ5kXIUh8KybBQGY5HzFeQeiRK2FEfXED4=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=iLtmN13PF1xTlgthiOZFsQgojR0HB/ZPXELY2EzycJyuZa0Ox6r9lO6zvCvR1PKwVC4U/D0MmO/c8Yv2BPgL3TZ/1E7jsRFjlNxZ0jj6tkq0GBOac35TBfo1kk68OHRNBqZCmOfsjSeHus/pKbd5YDzhfayAhBkJ6wGMZKIsXYhb+hY+Tx+DuZDcKmMYu154nb52Ua4EOCgcBalpJ/Wz1+IXoPWm6TM+tuJXO78a0k7JD2n3epRZhFg83RwpHeHmhR3Jq/I8XegO5/AWFK8HZSMSKELweE8NqC/hZI6JlXr2mP0O97VAQl8eHfUjjefT08d88ODAESVdICbEGsMAOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791406379; bh=gzQwqpyY053n/ypgNvd6ZHmvLAbn2yGw2pZyoO2rtBK=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=m8VWP5TSMtI8EqwUbvGMDLEI7nBIWyP3k0WY9fblkt+uOCVCOL/HZ2mBWnBYxlHsSJs5Q/pOXvU+kFobTsIraZvoJ9QU0QL3pX7A1NnNzYC5hkuFSRij7y3GqP6/wzOpqGko0kTYMj9txY8QtZLWphf/KbqVFl8dRI9RG8jJGco/GyFQkaPLphotmne1YoK8mX4ZICeK/WdwaV3ljglma4BvCDRLk7t46RPJi0QYpqpAytkS0ckINa4kZ3tL8l8ZsGVS/vJ+JY1q7iMHIGGNbXF1JjZBkS9asRtKv0KioxoYxT5xeGDrqyyq9aTATvZCfgCZYnnRJbeeWDSf0hCfKg==
X-YMail-OSG: 8xplk2QVM1kmSva8dCtGgK4gZmTfxZFjafbbev7nf6piZ6zuJxwb9CSe6AUjz.Y
 4vd88l3ACN_Q4XYRbg.SSeF5aIB8Aynzq3u1iJW3xHMlrzf1SA_mXKISenY5cDoux8Po1QfVTjCA
 xdpkzK3grIafvBWTKW_r3KqiisKmlDzULZuUIfRozDbLYHjoDt5jWmTn_zNYTxwRkb4KclXMhzgy
 dZL8Kz7EVF0et1fUM_4Pg3EiDqnoR3YHfiyC4tgu.med4HvjlfwGHedpy1N9oVv9DPuttudQlxKN
 PLzU2bn0_vVfEM43hYtFNF_5Dq_dMfaNuGPVNYLYiwqNT.oORSYF5DtmUNSPwIPiLpsURULKCW0E
 4G135uAGgxN2l4Nm8.42tZ4.Z3BkWs8nTvMMt01FeHfTQFHQEKZLXhXpiR7Wo9ULUr9gbRjlTv2v
 ucVjR9vQQQ1nCMgmS1RpxrE3E_jReUVxquVgqU9n.9O_G0JTFkDQun5AGq8WQjW1YK.viZ__hed7
 jaOvhSvTT9Ubzkwa1FvJwlwnfL7OKzy6l1j6yGzV3LQtxTtthepFo_XpQreY3.CeDwyWuILOlxSN
 Ca05BuoEhB7Q9kLzYXZpmNeW5hMGdO3ciUUxj7IHocJ28ahZPoPEp575JvkqzYi9iCPG4.A8jgFm
 ItF9IPMcpJEWdvtFsHdvgFZZU8QjGPzTvaUjUsBigyKxbrCHUaQyIaMgYPV3KMNrvQVShxzajsYg
 HMukL42tOCEmZCt.n79M7mzGRWQ7FcIrkYUGhWi0uHZQt6XE6JrqtSSQd0ZCz49Sd4RxBhlO7EWU
 EalGUn5Ds9ZTmoDFtxSOdu9tZh65NN1GoZC3_5CSulcHpAi1Aq7ArBiyQxg4uJh6v9NzoNWHKTo1
 Ob1Y9xr6qmVPxzCRu2deQlJQZG1NI3q_evkpAsOpgTKpH4iUaQtbICpJjjENEJ7Q0WwZ4OL6kF5E
 u6c44KwXU35hfsLU.3NBu54SGnquigtA8lgMH8Ttio_6vqadlWuRSVil_mdZmzaDl.OEkSpe59Hl
 vl3fPciTFXzSVVLSkroIU85IiLvQV_.hC0cjxZgf8ltrfWazo1qg8AbeW_jAx2Y4Nc01tdx7Xlqx
 HboZVa2IsGqJqKeP6KycgxmsazriycnOcIVc_.a4137F5eO_Y4fnOTAwu8klKOThplYaEiBXwA.E
 eqEkk21e54uH1qtkQuyQnu4gBHFQ4XK10rJyoEikMBXv3V52lnb_nAHTeAsMObLA7d.hVEynB3zI
 D8JH6zC.GQmoDke5ahDPY6zArDD8D4hj4h5n1t7IpmGu8kOVjBppGD3TpczR8eqwg8KOUIQaLooz
 _WOmRIUko_vnEfSM5aT3OOtLzh62Chzq0u2Ntejl.nFN.pYAvIhscrS1Wh8zWCXMnTG7NfHXUB3c
 g8l22iKVwFkMMKszcq0pfv2RrgGr4Fv2vNFNIpGpLKZgqKPP96YabWrg.wCV8BP.g3xlAED_8.nH
 A_9epZoL5JURledjoOhDlps9ZpMbKkN4nIPr2AB15OZh2Z7UQA7SAVl5H5d_FO_9j_6w34CeaPf8
 Mfo6jbiurDhTxWRiRIymoqpdk5YrZhaEk4fJ5ahPizEScbky3YENDxJYxxH_cGan055l1dltaXRc
 pGRVVQxJJPEe6Xacem5jZ0Zexp70piGjDzoNLPb.V32RJfDPQ08AxiF2TWibhf3RxzrpS3zWbxml
 p4YCuyrqPQErO0nriHK70YSHJdAE_iyRS9S3mJeNdqjeAHbISriZ7HxZxb1NsEps28fuga.sWmy6
 UYpUeUbqfY_v.aOMVJHCrXkYJaQODNrafrGQj19g90KstiDdLpQHNf.jsDuOL4r3MAnwY6XvMzBa
 GtCQ02xOeUVG9gNpcxkzDqVk4xhrACKEhNnoBGUDXDFXqY0je6Z6q4nQxzm3EEGgJuwlcRJMvdeS
 J1qOSzGcluOQ.gZpqNbfstLOL4JOsDasxIicmn753iHmMTTy933UxnIqG6aR5Cd.iWwyDUtydGeT
 3HmVhFeT4nW5Gdd52hSnvKfLU9gNIQIl6iOX2gc0K0KTDdGW7_bG84CozV7J.ORf9NrUX2GHDt7i
 2OfTrJ1FO1uP.CgFCDXPHrdQifexBscfzyTlp08vd1rlpM1KAxfBBScK3evDFmMSwE0hNI7IbHni
 htlx6uc4yhcQuFlgNVLy1JxXJWaDBbg9u57S0vrnKS5cCTfSCSwFRPrPARFO.kugWZM2.H7D69ha
 .A2dPH2i4DLxefMog7QioWpSLEg3u5pujBjn0BEwr_rQtfJuj_mEU47FLQDV3TFi47Ypxjgkae6L
 7oilJv0JteZJINe4AqkJpc2RrFT1BJHyMMHs7NHryRzdu.w--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: e82a5f18-ebfc-4987-ab11-77a7bf9276d6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Oct 2026 20:52:59 +0000
Received: by hermes--production-ir2-5dd9bf4598-c2rmk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2102fc31c199ea9497d916c954f0569e;
          Wed, 07 Oct 2026 20:42:38 +0000 (UTC)
Message-ID: <7e3518aa-4f99-4aae-bd9b-3984bdc4b548@yahoo.com>
Date: Wed, 7 Oct 2026 22:42:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 8/8] net: dsa: realtek: rtl8365mb: re-latch the
 family D SerDes
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <84fc7483-b22d-45ea-a3b8-3285dc357265@yahoo.com>
Content-Language: pl
In-Reply-To: <84fc7483-b22d-45ea-a3b8-3285dc357265@yahoo.com>
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
 drivers/net/dsa/realtek/rtl8365mb_main.c | 231 +++++++++++++++++++++--
 1 file changed, 216 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index aad26ba..a322c42 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -104,6 +104,7 @@
 #include <linux/if_vlan.h>
 #include <linux/mdio.h>
 #include <linux/phylink.h>
+#include <linux/workqueue.h>
 
 #include "realtek.h"
 #include "realtek-smi.h"
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
@@ -950,9 +968,17 @@ struct rtl8365mb {
 	const struct rtl8365mb_chip_info *chip_info;
 	struct rtl8365mb_cpu cpu;
 	struct mutex mib_lock;
+	/* Serializes access to the shared SDS_INDACS ADR/CMD/DATA window and
+	 * to RTL8365MB_SDS_MISC_REG, reachable both from phylink's PCS poll
+	 * (mb->pcs.poll) and from the family D SerDes re-latch work.
+	 */
+	struct mutex sds_lock;
 	struct rtl8365mb_port ports[RTL8365MB_MAX_NUM_PORTS];
 	struct phylink_pcs pcs;
 	bool sds_supported;
+	struct delayed_work sds_relatch;	/* re-latch edges and link health check */
+	unsigned int sds_relatch_count;		/* next attempt of the episode, 0 once latched */
+	u32 sds_misc_target_val;
 };
 
 #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
@@ -1356,43 +1382,53 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
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
@@ -1402,15 +1438,19 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
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
@@ -1532,6 +1572,13 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
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
@@ -1612,12 +1659,16 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1664,8 +1715,140 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1730,7 +1913,9 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
 	/* The speed and duplex are forced; read them back from the values
 	 * programmed into the SerDes MISC register.
 	 */
+	mutex_lock(&mb->sds_lock);
 	ret = regmap_read(priv->map, RTL8365MB_SDS_MISC_REG, &val);
+	mutex_unlock(&mb->sds_lock);
 	if (ret) {
 		state->link = false;
 		return;
@@ -1800,7 +1985,9 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
 	 * force from rtl8365mb_phylink_mac_link_up(), where the resolved pause
 	 * modes are known.
 	 */
+	mutex_lock(&mb->sds_lock);
 	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG, mask, val);
+	mutex_unlock(&mb->sds_lock);
 	if (ret) {
 		dev_err(priv->dev, "failed to force SerDes link: %pe\n",
 			ERR_PTR(ret));
@@ -2108,11 +2295,13 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
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
@@ -3324,6 +3513,10 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	 */
 	mb->pcs.poll = true;
 
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		INIT_DELAYED_WORK(&mb->sds_relatch,
+				  rtl8365mb_sds_relatch_work);
+
 	ret = rtl8365mb_reset_chip(priv);
 	if (ret) {
 		dev_err(priv->dev, "failed to reset chip: %pe\n",
@@ -3508,6 +3701,10 @@ out_error:
 static void rtl8365mb_teardown(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+
+	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
+		cancel_delayed_work_sync(&mb->sds_relatch);
 
 	rtl8365mb_stats_teardown(priv);
 	rtl8365mb_irq_teardown(priv);
@@ -3578,6 +3775,10 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
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

