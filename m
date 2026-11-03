Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.186.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748886;
	b=bn0cSrCVGfyrvo9SDHmTKBTA0U9syarweulNwLo+x97wxNCj1Hn1i9lOHy2iqA1zv+12
	 lTzifp4U3NozvLgU8TGIwGdQGTS3ejcV18Y/CQLIdSte5yNSF7cYnhfSepIilRlpApb3V
	 G0kHQENmO00JaZveKRdKWctaLrNnqleiuvbIjEif+K3KyfjX4SvNb2yIC+4WZFWErZnOt
	 axp07EilUD1jck638IiXphOG/fWACKsNLQbYvhHPSZ5ySBISN3fwbbzEJolh08w53wZS7
	 QxrEtkkavhV2KIzolqMeT3cxvJzUaIXr6s6/mck//vuUJtGPlZSICdsGm5K3B3RwYSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748886;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=QUnD5+XaP5OL+dgWLnCjZYDmkEnBsJjhUP92XdRePeo=;
	b=Nxzz/ghCyC8xdmzHrOPAyzNlJBDqB5W+Owacfc4S6My2WWi8tGrhqXMzf+2IXZdlZ0Vc
	 kN8WKdMJQb0nyK0Mc5NGX1cTl66d51Af8j+EcCu4AL1L7/iXyn8FS6BVR9l57Ah8Wn7+F
	 MAi+Pg3keQYFmJMn8+FYIod3kwgfFc1sGcGx53EiVL8Qy+K7R1SApQ0Tp4nQjcDd7GQaM
	 wWGZrkQZynrgSZXUt3HlgqIBxwJTAhQHWc0hsDci7Y2LDpo+GlK1feGRUh2x+p5tuhEDr
	 OR4BzOrJdGuVc8HlQjQK4En7c4ObBfVv+7wcYOaECqfEMxV2K4xBlXz7X2A3eDgoZaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b="n/x/M5D9";
	arc=none smtp.remote-ip=66.163.186.148
Received: from sonic302-22.consmr.mail.ne1.yahoo.com (sonic302-22.consmr.mail.ne1.yahoo.com [66.163.186.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E2606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27E2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=n/x/M5D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748885; bh=QUnD5+XaP5OL+dgWLnCjZYDmkEnBsJjhUP92XdRePeo=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=n/x/M5D9CUTVuk2z4l02cFnxXmDWsJvqF4HFc5ZH/BBb/RfgEIeW+UA+MDDoOBe9Gd58wfOxEtU3XRp1jp1XvVCY3jmbIREmut9LvV7DqgRP3DMuvVv7S+eD86fmGvi9c1/EeEgRQDPQdd31fQfJ3WAYooLWlQ5tx9QMH0+/qIC04cJdyYCngBKk0oQX0BV6rqh5bCV7mUmjoeMjLHDmNz0EwY02ZTQXoot+0pQzmgtZ4exCkkZryj7epLSRcfSR2Hv+1i3T+gyjJfeKH6O8/BXY5D6WxLAILrRgoTc8DUw8zJwNW/ilSoDUYpGvJg2xyWLWNYeu9HVbRwg+Im7mxA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793748885; bh=2kH6LjmMu30xHwlCDNJ0/EBLLLrAP+14SvsVqWq3jrg=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=ItFqP64891kJiy7Ns0xCX0cW9YLhEdxI3VVjc/w44rl8quFpcg1vwyB9an9Omw5nxQOnX3B6BAaDqcue3TUZKLPWCIoBmN650mYPyZdUsDjO1Bb2dIyb95uEO1Cw9pRmF32cvDXpslvZ6Z9TXXGmkjzWXZH6sOqVps534iA3nDrObbimI6tVHiypBkUDfSQ6MJI3DEr/G2a+OxKs6OtEAGHRjuTvcz6h8XZe7B7fsrDDO0t4ht64MdAl2yGHgPDlNKm8/lV7wj6a55MvUcn1ji0h6/1/t2H9KDLE2G7D5qDxON9JBCzllIO3/rLj082QH57ZJJAZCgOY9pLdq7Xz+A==
X-YMail-OSG: stde8dcVM1kauB0Ma0kksFhYcIuURkq34PeQWyxBOGIdpC5vKLF6YvohwkqqecT
 z9jduCTNFTsOUU2kkipbJ0zal5c8ZSAQOaaX84dQxQw2Ufni.Y.fAZ5DTwecd2drR.f.YjRIF0zx
 e4TWSwn8skv.DKacKZkfOwUtDOOoi8vdvMld1r3QsRu9b7boBrjeA9HBII58RRnAoAdNsG43yH2X
 aI32ocD9t4KNamuaxFldAXzN9TAIyZ5QKi1.ZupQBcv2U7X5vxm7Al0pZgx3Nb5F3umDqvWMAl6L
 dMtdCUn0qhdAkd6AoDuE02cnorb1Tm7W_.pHK.Z7V_DbUDfkuAAybZU_ursXoWx2Sc2ECYeQwh0L
 faVJagtvsrjOv3uy0FAWhMyulVNZ_Yz_VvcAFS1MQZAjq61LUMKdXadXQ_4vYC8.xCHv7nfnRShY
 m0N78lGKolC_1mY1R581OdSXnT5dDjLxLph51DtlBn8L3kiL7fX_zESwXiRuY46FSWpz1iOXWdAd
 eqaD48t8lXtZPhhVhOn50Cj8opycSXvACGUDByvGNs5SLClf7I5I1m0dEjHSTA7icqcUYstQC9HO
 UJTnidKgwLcRFcGqai_eEtIL_LovUbUGLCJ6emLDqepleUEkRodgOQt1JigFdBT6hyv3fAUfDFOe
 5Ym33OwOrNbvdWl55iIfVVZPne7bF0CwFH5f82gBh2wO1h7HlAX2eHZwPTyVMRFkaweKXl08u2wU
 O8LqlDoAqz7sK0QuJSuTnZixmw1gYXLS3vUgp3I2Ku8LBJkrEHWOIYe98oLjX_2S0VTlDyv6MYZY
 HTUn4r_pVXdJjxPAnL8S8L3kPJYT5a8PDg2vhsMk0XdGN4hZUEzzcHrioPLRFf.Injlbc7cweHJt
 wEJO9sKJSPanbr2qN_TU5G7PaXRLKleVSx06cN_4nu7T6jNIlqTelcWJNEN6vp556jsitVGnxglu
 36bMYk1XQCa9ohBvmqjQuX1kB3bEQpQ0109g4iqyRnhGBAnfuZF_CKHSlBdMCKcNGQTTW9ximaxk
 uLhtZjuUW07hYpkLnIYFQ_lz.guoqBI46sfCRm6nD6idsDyhAfFOraJiXKXU1VbZTVgKqf2qDtNs
 Vx_q7glD.H8P8DiQdFq1UeVdJV.X2HNTg1CFZvfC6voW9FJmaCfrZ3k7N0K97bIfAcmG8jKIKdUw
 Bf7mgffn7axzZpRiorABo8Ebk6DTQmk3JKdc74V.riLVjIyptMLn0vdN7x6YkDORIT5CEH0JdhYp
 WkWUfZPV_opbswm6B7h5wTpQbOSTT6Dbl_h4.Dmw7bUAgu91ZobM9vPU_4bbQQdyqmL7Pyp0AVbP
 lizsrkNveQ4TfFgGJRbr5gsqH1iAsKP5MyNKAAzJu2bMhnl2Nnq2Corkwg2ciVPRY8igFTAB0PpH
 RRQyB7GNtUs3hXj2scgg.JA2XiKB53uIpjTLsHH2psufzVZDEimZaCiWCcUAKiXJ2k9Sk09hrsuC
 O58XL2eo_GzUU.WhExlWe3GhMgq4pEIPtsQiWGTM5dAarys7yR0u5RO1x4nDVjBQHeEZPOUaEOVN
 wzjUUc3dO1Yb79McH_H2qFnUjrhnRIr6ulY9YHf1lQ2hQ_i9yD0_kIpDcW55uOMmbz4MBWifh_5Y
 tOzTfjxsCQmlcUeVBy.xALsoF5_AQXfHc9pn9_N4ZR7GLe1XiTts2mGFpfbbE_x8IfrGeC7vr4.S
 tiWFfcM1caIxoE1tNDZ7Q.YjyZvi8vU.cGnHDrLnkxg0z4rGbufZ3S1NW.R3aM4D_gZ0crWuHN4i
 Bpc2stLRQzTXQB0QEAaP.._8TkQpne5aqNLy50Qu1mLwWPKIF57tOJ2HN7uE1G8O7eF2NFA24uiQ
 pb3mKwgBQH8Ztq1sD2.At1jdpnEMjaX0kI1mUPPChXDEp9_kJnR4.34Rv56MN3f7.HQie7zC2MSh
 nb8gMQWwE3g9rmz5d6SgQzCY_Y9XZpt7pMCQmoMuUKpUoHqp7hzbSzEriramkhvlIS29ktQWF2kv
 RDY0o8VmFSWLgwgwwTAxhl_RCDJ334b4sNG6Ob6Nf6jckM1MOGJOaOu8i_DJ484hgE8lFtWpUegh
 Sts9FlORoytmOOj2btlYpRS6QAWIPDI75jOZbR2nargH3ilBJnY0UabsAnGY9HQo7ccXByl2cTJC
 yWBcqJM4ef5aunEGXaE8lhxwvsEEszU.QaWy9TBEeu5yTDweyp7oWYnZyozSTSKHg3PtNBGtdoXr
 kmQ5IKEShpsp_LnqsfK5qnwxCFzREze4va3u_KRLDzlgVn2zB3ePxD7MzpYDDVL0lFE3ibAobD7b
 EoUuNx_2Gq2JhfqYJb5ixNf0wXI729mlzmsu_1sZyc6kuQCM-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 146bc1be-ed1d-436d-beaa-d5418f3bfe7f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Nov 2026 23:34:45 +0000
Received: by hermes--production-ir2-5dd9bf4598-bszjv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f57d9c2c79aac9bc66fd5066224e656f;
          Tue, 03 Nov 2026 23:34:40 +0000 (UTC)
Message-ID: <4679b475-fb23-4eb8-a596-8547139d58f5@yahoo.com>
Date: Wed, 4 Nov 2026 00:34:37 +0100
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
Subject: [PATCH net-next v8 08/11] net: dsa: realtek: rtl8365mb: re-latch the
 family D SerDes
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
To: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <08611959-c555-46d9-8e7e-20b85d0c4056@yahoo.com>
Content-Language: pl
In-Reply-To: <08611959-c555-46d9-8e7e-20b85d0c4056@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26871 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

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

The far-end MAC starts when its conduit is brought up, which DSA
reports through ->conduit_state_change(), so an episode of re-latch
attempts starts there. Only the conduit of the CPU port that carries
the SerDes (port 6) is considered: the chip can have a second CPU
port on RGMII, and its conduit says nothing about the SerDes link.
pcs_config() only arms the work, and starts an episode itself if that
conduit is already up. The work re-arms itself after each edge; the
next run checks whether the edge took, rather than waiting on a poll
that will not come. When the conduit goes down the work is stopped, so
a link without a far end is not reported as lost and not parked every
10 s.

Each attempt (park for 20 ms, then restore the target mode) is
performed by a work item rather than from the callbacks, because the
attempts have to continue for seconds after they have returned.
pcs_config(), pcs_disable(), teardown() and conduit_state_change() are
serialized by a new sds_cfg_lock and cancel the work before touching
SDS_MISC or restarting it, so an attempt never interleaves with a
reconfiguration. Before parking, the work reads the link status itself
and does not park if the receiver has already latched, since the
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
logs that and starts a new episode.

For family D, pcs_config() keeps the masked update of SDS_MISC and saves
the value it wrote as the target the work restores. The work parks and
restores with masked updates over the same fields, so other bits are
never touched.

The work reads the SerDes link status through the SDS_INDACS indirect
access window, a multi-register ADR/CMD/DATA sequence that the PCS
callbacks also use, so those sequences are serialized by a new sds_lock.
The SDS_MISC updates need no extra locking: each one is a single regmap
read-modify-write.

The work is only armed for 2500base-x, the mode the re-latch edge was
observed with. It is cancelled from pcs_disable(), from pcs_config()
before SDS_MISC is touched, from conduit_state_change() and from
teardown(), and disabled by a reboot notifier and by a devres action.
disable_delayed_work_sync() is used in the latter two so that a late
pcs_config() cannot queue the work again, and so that it never outlives
the PCS or the driver data and does not touch the bus while it is shut
down. dsa_switch_shutdown() does not stop the PCS, which is why the
reboot notifier is needed.

If restoring the target mode fails, the lane stays parked. The mode
field in SDS_MISC tells so, and the next run of the work puts it back
before doing anything else. If the work is stopped before that run, the
lane stays parked until the next pcs_config().

No chip uses family D before the last patch of the series, so this code
is unreachable until then.

Co-developed-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 387 ++++++++++++++++++++++-
 1 file changed, 372 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 50a3a92..ba2a0ff 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -97,6 +97,9 @@
 #include <linux/irqdomain.h>
 #include <linux/mii.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/reboot.h>
+#include <linux/cleanup.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/if_bridge.h>
@@ -299,6 +302,29 @@
 #define   RTL8365MB_SDS_MISC_SGMII_SPD_MASK		GENMASK(8, 7)
 #define   RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK	BIT(6)
 
+/* Re-latch retry interval and attempt budget. Each attempt parks the
+ * SerDes for 20 ms, so a far end that never comes up must not be retried
+ * at this rate forever, and the interval must not be so tight that
+ * back-to-back parks starve a link that is about to latch. The count is
+ * reset to 1 whenever an episode starts and to 0 whenever the receiver
+ * latches. Episodes start when the conduit comes up, so with the
+ * interval below the budget is roughly RELATCH_MAX_TRIES seconds, which
+ * is generous for a far end that needs a moment to bring up its half of
+ * the link.
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
@@ -938,10 +964,23 @@ struct rtl8365mb_port {
  * @chip_info: chip-specific info about the attached switch
  * @cpu: CPU tagging and CPU port configuration for this chip
  * @mib_lock: prevent concurrent reads of MIB counters
+ * @sds_cfg_lock: serializes pcs_config(), pcs_disable(), teardown() and
+ *		conduit_state_change(), which arm, start and stop the
+ *		re-latch work
+ * @sds_lock: serializes access to the shared SDS_INDACS ADR/CMD/DATA window,
+ *	      reachable both from phylink's PCS callbacks and from the
+ *	      family D SerDes re-latch work
  * @ports: per-port data
  * @pcs: PCS for the SerDes external interface
  * @sds_supported: SerDes tuning parameters match the chip option, so the
  *                 SerDes interface modes can be advertised
+ * @sds_reboot_nb: disables @sds_relatch before the devices are shut down
+ * @sds_relatch: re-latch edges and link health check (family D)
+ * @sds_relatch_count: next attempt of the re-latch episode, 0 once latched
+ * @sds_misc_target_val: SDS_MISC_CFG_MASK fields the re-latch work restores
+ * @sds_relatch_armed: pcs_config() set up 2500base-x; the re-latch work may run
+ * @sds_conduit_up: the conduit of the CPU port that carries the SerDes (port 6)
+ *		    is admin and oper up
  *
  * Private data for this driver.
  */
@@ -951,9 +990,17 @@ struct rtl8365mb {
 	const struct rtl8365mb_chip_info *chip_info;
 	struct rtl8365mb_cpu cpu;
 	struct mutex mib_lock;
+	struct mutex sds_cfg_lock;
+	struct mutex sds_lock;
 	struct rtl8365mb_port ports[RTL8365MB_MAX_NUM_PORTS];
 	struct phylink_pcs pcs;
 	bool sds_supported;
+	struct notifier_block sds_reboot_nb;
+	struct delayed_work sds_relatch;
+	unsigned int sds_relatch_count;
+	u32 sds_misc_target_val;
+	bool sds_relatch_armed;
+	bool sds_conduit_up;
 };
 
 #define pcs_to_rtl8365mb(_pcs) container_of((_pcs), struct rtl8365mb, pcs)
@@ -1356,43 +1403,53 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
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
@@ -1402,15 +1459,19 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
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
@@ -1511,6 +1572,37 @@ static int rtl8365mb_sds_raise_rate_limits(struct realtek_priv *priv)
 				  RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK);
 }
 
+static void rtl8365mb_sds_relatch_start(struct rtl8365mb *mb)
+{
+	WRITE_ONCE(mb->sds_relatch_count, 1);
+	schedule_delayed_work(&mb->sds_relatch, 0);
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
 static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				phy_interface_t interface,
 				const unsigned long *advertising,
@@ -1532,6 +1624,17 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	is_d = rtl8365mb_is_d(priv);
 
+	guard(mutex)(&mb->sds_cfg_lock);
+
+	/* Cancel any in-flight re-latch edge before touching SDS_MISC: the
+	 * work parks SDS_MISC and restores the target value after a sleep, so
+	 * it could otherwise write a stale target over the new configuration.
+	 */
+	if (is_d) {
+		WRITE_ONCE(mb->sds_relatch_armed, false);
+		cancel_delayed_work_sync(&mb->sds_relatch);
+	}
+
 	/* Select the appropriate tuning table and SDS mode */
 	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
 		if (is_d) {
@@ -1621,7 +1724,9 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (ret)
 		return ret;
 
-	if (!is_d) {
+	if (is_d) {
+		WRITE_ONCE(mb->sds_misc_target_val, misc_val);
+	} else {
 		val = sds_mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
 		ret = regmap_update_bits(priv->map,
 					 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
@@ -1669,8 +1774,192 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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
+	 * only armed for 2500base-x. It starts once the conduit is up.
+	 */
+	if (is_d) {
+		WRITE_ONCE(mb->sds_relatch_armed,
+			   interface == PHY_INTERFACE_MODE_2500BASEX);
+		/* With the conduit already up no conduit_state_change() will
+		 * follow, so start the episode here.
+		 */
+		if (READ_ONCE(mb->sds_relatch_armed) &&
+		    READ_ONCE(mb->sds_conduit_up))
+			rtl8365mb_sds_relatch_start(mb);
+	}
+
+	return 0;
+}
+
+static void rtl8365mb_conduit_state_change(struct dsa_switch *ds,
+					   const struct net_device *conduit,
+					   bool operational)
+{
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
+	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+
+	if (!rtl8365mb_is_d(priv))
+		return;
+
+	/* The chip can have two CPU ports (SerDes on port 6, RGMII on
+	 * port 7) and DSA reports every conduit. Only the one behind the
+	 * SerDes matters here.
+	 */
+	if (cpu_dp->index != RTL8365MB_SDS_EXT_INTERFACE_PORT)
+		return;
+
+	guard(mutex)(&mb->sds_cfg_lock);
+
+	WRITE_ONCE(mb->sds_conduit_up, operational);
+	cancel_delayed_work_sync(&mb->sds_relatch);
+	if (operational && READ_ONCE(mb->sds_relatch_armed))
+		rtl8365mb_sds_relatch_start(mb);
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
+ * Instead, an episode starts when the conduit comes up (see
+ * rtl8365mb_conduit_state_change(), or pcs_config() if it is already up)
+ * and this work re-arms itself.
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
+		rtl8365mb_sds_relatch_restore(mb);
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
+static void rtl8365mb_sds_relatch_disable(void *data)
+{
+	struct rtl8365mb *mb = data;
+
+	disable_delayed_work_sync(&mb->sds_relatch);
 }
 
 static bool rtl8365mb_interface_is_serdes(phy_interface_t interface)
@@ -1824,11 +2113,25 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
 	}
 }
 
+static void rtl8365mb_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct rtl8365mb *mb = pcs_to_rtl8365mb(pcs);
+
+	if (!rtl8365mb_is_d(mb->priv))
+		return;
+
+	guard(mutex)(&mb->sds_cfg_lock);
+
+	WRITE_ONCE(mb->sds_relatch_armed, false);
+	cancel_delayed_work_sync(&mb->sds_relatch);
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
@@ -3561,6 +3864,14 @@ out_error:
 static void rtl8365mb_teardown(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+
+	if (rtl8365mb_is_d(priv)) {
+		guard(mutex)(&mb->sds_cfg_lock);
+
+		WRITE_ONCE(mb->sds_relatch_armed, false);
+		cancel_delayed_work_sync(&mb->sds_relatch);
+	}
 
 	rtl8365mb_stats_teardown(priv);
 	rtl8365mb_irq_teardown(priv);
@@ -3593,6 +3904,23 @@ static int rtl8365mb_get_chip_id_and_ver(struct regmap *map, u32 *id, u32 *ver)
 	return 0;
 }
 
+static int rtl8365mb_sds_reboot_notify(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct rtl8365mb *mb = container_of(nb, struct rtl8365mb,
+					    sds_reboot_nb);
+
+	/* Runs before device_shutdown() on reboot, halt, power off and kexec.
+	 * disable_delayed_work_sync() waits for a running pass and keeps
+	 * pcs_config() from queueing the work again, so the bus is not
+	 * touched once it is being shut down. If the last restore failed the
+	 * lane stays parked until the next pcs_config().
+	 */
+	disable_delayed_work_sync(&mb->sds_relatch);
+
+	return NOTIFY_DONE;
+}
+
 static int rtl8365mb_detect(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
@@ -3628,6 +3956,34 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	priv->num_ports = RTL8365MB_MAX_NUM_PORTS;
 	mb->priv = priv;
+
+	ret = devm_mutex_init(priv->dev, &mb->sds_lock);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(priv->dev, &mb->sds_cfg_lock);
+	if (ret)
+		return ret;
+
+	if (rtl8365mb_is_d(priv)) {
+		/* Registered after sds_lock, so on release the work is
+		 * disabled before the mutex is destroyed.
+		 */
+		INIT_DELAYED_WORK(&mb->sds_relatch,
+				  rtl8365mb_sds_relatch_work);
+		ret = devm_add_action_or_reset(priv->dev,
+					       rtl8365mb_sds_relatch_disable,
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
 	mb->cpu.trap_port = RTL8365MB_MAX_NUM_PORTS;
 	mb->cpu.insert = RTL8365MB_CPU_INSERT_TO_ALL;
 	mb->cpu.position = RTL8365MB_CPU_POS_AFTER_SA;
@@ -3712,6 +4068,7 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.port_vlan_add = rtl8365mb_port_vlan_add,
 	.port_vlan_del = rtl8365mb_port_vlan_del,
 	.port_vlan_filtering = rtl8365mb_port_vlan_filtering,
+	.conduit_state_change = rtl8365mb_conduit_state_change,
 	.get_strings = rtl8365mb_get_strings,
 	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
 	.get_sset_count = rtl8365mb_get_sset_count,
-- 
2.53.0

