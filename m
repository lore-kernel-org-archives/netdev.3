Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.186.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125530;
	b=X4zrvHk8OQUAyUmn/PXrKYOORoZOzVJRXmjlhxkb3mR3kBe2CgxcFb64RNw8iLtwM4IT
	 4ZDa9bdd3FwmAcoXxdyPDKd6V44fh6GV2FbcvM+FRqkYD2BVCFsp+hKHLfyV7O0OB/Spq
	 IcmH08s1v1gVN4qzlgtyBCXcZJyzWs91sxp2qKe/qRBueoqnZ0rQ790hAUn6u056w8b7j
	 fVeHx+Z7dVnv+FhYiMyFAEJLjhV3dqOTD0BJwJLrZ26bhJ6J4JwdO7xJ4uPzzHcm4afJz
	 iwRJotmjOU+AWc21pEvbJikmqp2Fg19s2E5xmBHDm/BTfbHmkg6U9UvlUeD3WYSnfYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125530;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=VpY936nUOaXvgGG1MYYJlN4kdqZPBHjyleXG3ciPAQE=;
	b=HnTmPfYokOuP+CPVusgGDwpSm3dWDCgjyXxKK4ErgAvZZhrELvXLZwVl/q6npAQvJC1Q
	 35zZ3nicNhE146yJ2s8WuHfy//Ypp4IeY00z92pdZtj5aNCR9GPSvhLl6bjRzqJOLbTz7
	 Sw0056NZ0hQzeNHCXQyM1r9Esyn/U17DOZvat0iH0tMzVBwXteeH6da1xEIUzegjchp3/
	 /i6dD6w3wyBi/hCL88DU5FEpk4tEytika5XYwK6ldSXsE3S+nCmwZ7bEOfldaXetytegF
	 RG64DEUkOh09+eFncRV7kSSbEOdH93xptyMGdwTTqELg+Wakn66HqZkiLCmuyFy7dHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=CPgLHhDj;
	arc=none smtp.remote-ip=66.163.186.146
Received: from sonic302-20.consmr.mail.ne1.yahoo.com (sonic302-20.consmr.mail.ne1.yahoo.com [66.163.186.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365A606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 08:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4365A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=CPgLHhDj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125528; bh=VpY936nUOaXvgGG1MYYJlN4kdqZPBHjyleXG3ciPAQE=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=CPgLHhDjsM413g2JDdpK0g0E9OV6l8EwqtTvYpJRuP7rQOaVJTJMwpkOef6lSZotq8G6WZ7fnYUfGo7eqGd1aZRpb2LSowCF5s/NICFDWgXJenxUaeDRqSilRpOJeiGa1AUBnk88ns9htd33iH6RwBkrrQpGhJqqusXEqYo/Uc3AItfS0aBbF6M6caK+DSzX5huYoKTvXJvT3UGAN2Kc6S9AK2dVb8gzU0/enWNfqbh7Ny1chI4CFTMtJlM78k938yYmA3y6tfGDzZStKUeZoCTJ99R1quhL6Y5JEyxhYQxu6S8OFVnkohK5i7IrzEMaW/m5kRdY4GdtgGLSXIKUfw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794125528; bh=vL4AKtDfsy5Ma5OfC9fSWIY8lANtPToIcZlk0WFz9Tt=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=dH+iAeD82FZ2iz+/pGE7YbbZlWrHIcLTLDUvLOLUhHQkMVDe9j4lPshrOcTQ4Q14n3bEWBRFCcnqqc5a2Prkcp4Ck+p3TBmkaLHdHTnGv4Uwsue14KXT9KH9Si9OjEo0u+FvTcawvlVsCu5x4cjvVjEEZO1KtZnQm77ADC1BmKFFH11+7QWAYQWFNm9xAZ9LNB6skbVX79gcATOmc5O5sUtIdo7kcDheuz7Y2CCxYwSDrdZJtvm2r4z3qL6Td8oYkzWbYiw2zTewALZ4JUD4bOGfdHp2gtDN0tbiD9CgL70tQ0lytStAMg15I3jUd+D+9OQVKpMcO9qc7wPKV4VQYg==
X-YMail-OSG: F2aSmDUVM1lmlAsxVhu3gWj9NKTC0K1PSidzgxlcfmj7jlXn.RI.ocQODGrKIEZ
 fLEx.nKitwcG6Nno1pNki_h3Ro.ZUxMOTsR4k1CAx10kX4DH_gsEoImcrLoPN5SI_fj4Ib1sD5oc
 eAgk2wbF1MzUKq4WfWBBN4f_u.suYvvp6YYTJKp6CjZnzhpS.Uo6Oke2kCN.KEPvPH5gzyD7dywp
 YTxevGWOTG7RxZpcQKHomE4mlzi1Wm5VS2W1NSvmhxPRAyJImT8Z7c.3WKwjdPe3JBY4H3822B7c
 d6oXuQPik9xmdRfmipkB_BWl2yK88EYMnCVPaRYPIFeY0YilKe13aJS6JDqXRT0TWRt1lBXnZClc
 wfBfGv1NXPQPT0XYgbQT5R1.gmtPJqmzVA7TFQP95MXR2vtooGLiXKfr8Yq9ALHZpdDtCfkRTMfB
 XZwZSOWIeSxF2lJ1PALilBb450pSxSO1PvWw1kpfCKr8WZYldLlQtN9aYHDRxG2iopeuxaJL1Uxa
 Y7XJGIDdgSP.qaKERC3ZtLdBS4hdv3xT.6kdE26B.W7PncbX7.GHaWR4v9vf6sjbSOrH67Z9ADEz
 Dsx8EPNQqIwtjYSeNSYrpikukZdfg0PV_hMA1bs4jhlEPPG.ebtrep4g6fdXARKmhSAnm76TKjVR
 42ctn0zouFhnT1k1edzfozzCfs40fPn0vz7XwmBe07Mm2n_KlErS7XftapkR0MTKdbldtiB_n7hE
 hHtbskdiy1PnBxpbe7qrLweFLs8B3jwUARzfWq80v8xXyNc1KQQ95UDa2VDIca.tZ1_YlnScRyaZ
 Th8gPSExAHtnFSOPuN6djKnh9QRwkl8U4EZO0xa1Pw..lF03o51uEsVbn_5.Up5c2S_ivwU14jq0
 7lvuUEeEQdwdb5ZdRzqfov7k19XYj2CrfdeLg7TuN4eArcH_bnmzJcF2as.RNe_5Wg4cW.iEuhpH
 ORVnqT0v6M5CZeHAGOSZseyn3OcB64jsGSsCQ6JTvswwqoI6efkGreqnN_oR39fsAwpG8041ALrF
 DjbaiSkyny64pIKIe_9HVbg_78r7bLpPHL8fg6QwIkRjQbiK.4YhJLTZHZXZIKw8JSRTXVyE_wCv
 GNs23MpVOfLspaLudhaUXoU0T8CjHSBA0R7aftYdsaIeqP_WXGHUqJX_k7yhOefRhc12qHru8cKl
 k626I_svVNOMFLB.bEQn9br4Qiki486fyHjhR7sEhDA2eSL5vLG1upaqJAJt9gClOuziXGlCjWHt
 Hy1wGgslrg.PhlNqS6uReebpWvBaJcfxjbPeMQhBIKNqlbK3POT6OlBxDYAm2upqmKa6pSmSlAAh
 0vK8TpbdE1HN1Rw.7SFErFHo5bcKbxg6t6uqT3dr5s3Ub6jaQ6kXE251A_lufmno52gHY0lP6WGf
 rXcBCfhA3EM6RzXqewZMos6r8DQZxzUuDKkLciqXoFl7yuo4FycM_Mb96RmNoMbgHpfSI0vxj03c
 48ZOijTyHrotWEtY68WKdLIW4dsMmbkm7_GJKehdGtZ20xXVJleHfeDJttpgVIpC4A7JvjYv1J2v
 ddMIvWZGP1CViDqmWilH7cemK7NziRCl7C.frxfyxhZtdEqm08kXzRHvoOTt0hoRogCwF2IaRqV6
 USL2LU6.VhIiMQSF.VEyvXQyNPMnP4Q705ticJaBeG6zaaBz31kxYCkKx_qWearjKAlgRNIuruRD
 WPCZ2pQ3jhAZTsuOtBHkeze9O9Qh__w67046cohWEsOxBZ473PhFGIWvGl.4IBVPia.XK3fTHKAA
 7Y6enJmv9jvexJCyazwjFGnXULDJIFk_0Xvp4q0Us60zBLZpTNvbG4Drm9t7SjVB4zHliM0jCV81
 iJrZ08N05u9wJK1Pilnk4y534vk1N11xRVi1xmt0vPZssm2epjoYIVsE3FzGEvEX0.oDhIui0TLI
 yP_oVfz54ZAQIQFahIcF1vu.J3AREkPwxSmHR8nSZTLWnGYRhl0x8iXsiCTGAwZMq2BTycm_diPA
 UOWvFIzWpqcwB9DaKSfd1AtvOwOaXvZwpFEvQrMSMX4vrCbTx9D1DNJjDDzLeAGCXSArK6fskCU8
 Z6Eg2FLJxXMQw4kJQAQMOMuEVgWsKfgt3WmILRn5S5UAVZ1uwclUX.ibig15AD5UMUsYfguS8snl
 e9WfbHZ5VmTnjq7CFHgwyHugRJqOdPfzXDyhQouNyxPL2944DG3laMXWEau22McqeldHjo4kkwgA
 6ir_vT_7KkEdNzlcT76QU6Nll48PAuqNZu8PdRk9Nd9GHK5K9Fenongd_rYjKfQclk6zRy47pn3H
 CCF.eA_KRfyvgUo._BNG0joBriiMT4Z80HtT1LntVew--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: f61995ed-f16f-43ca-a5ba-afb1cadffade
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Nov 2026 08:12:08 +0000
Received: by hermes--production-ir2-5dd9bf4598-jgkl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1b3d9d55540c0dc19137cb273596ba8;
          Sun, 08 Nov 2026 08:12:02 +0000 (UTC)
Message-ID: <39e46930-0d24-46d6-8861-5dd309bb7640@yahoo.com>
Date: Sun, 8 Nov 2026 09:11:59 +0100
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
Subject: [PATCH net-next v9 08/11] net: dsa: realtek: rtl8365mb: re-latch the
 family D SerDes
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

The work is only armed for 2500base-x on a CPU port, the case the
re-latch edge was observed with. It is cancelled from pcs_disable(),
from pcs_config() before SDS_MISC is touched, from
conduit_state_change() and from teardown(), and disabled by a reboot
notifier and by a devres action. disable_delayed_work_sync() is used
in the latter two so that a late pcs_config() cannot queue the work
again, and so that it never outlives the PCS or the driver data and
does not touch the bus while it is shut down. dsa_switch_shutdown()
does not stop the PCS, which is why the reboot notifier is needed.

If restoring the target mode fails, the lane stays parked. The mode
field in SDS_MISC tells so, and the next run of the work puts it back
before doing anything else. If the work is stopped before that run, the
lane stays parked until the next pcs_config().

No chip uses family D before the last patch of the series, so this code
is unreachable until then.

Tested-by: Stanislaw Pal <kuncy7@gmail.com>
Co-developed-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Oleg Gavrilov <gabonpivovich@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 423 +++++++++++++++++++++--
 1 file changed, 397 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 86194d5..96b15dc 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -98,8 +98,10 @@
 #include <linux/mii.h>
 #include <linux/mutex.h>
 #include <linux/of_irq.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/if_bridge.h>
+#include <linux/workqueue.h>
 #include <linux/if_vlan.h>
 #include <linux/mdio.h>
 #include <linux/phylink.h>
@@ -301,6 +303,29 @@
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
@@ -934,11 +959,24 @@ struct rtl8365mb_port {
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
  * @sds_supported: SerDes interface modes can be advertised: the tuning
  *                 parameters match the chip option (family C), or the chip
  *                 is family D, which does not use the option
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
@@ -948,9 +986,17 @@ struct rtl8365mb {
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
@@ -1354,43 +1400,53 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
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
@@ -1400,15 +1456,19 @@ static int rtl8365mb_sds_read(struct realtek_priv *priv, u8 index,
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
@@ -1509,6 +1569,37 @@ static int rtl8365mb_sds_raise_rate_limits(struct realtek_priv *priv)
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
@@ -1530,6 +1621,17 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	is_d = rtl8365mb_is_d(priv);
 
+	mutex_lock(&mb->sds_cfg_lock);
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
@@ -1566,12 +1668,12 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				 RTL8365MB_CHIP_RESET_DW8051_MASK,
 				 RTL8365MB_CHIP_RESET_DW8051_MASK);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	ret = regmap_update_bits(priv->map, RTL8365MB_MISC_CFG0_REG,
 				 RTL8365MB_MISC_CFG0_DW8051_EN_MASK, 0);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	/* The vendor driver clears the line rate bypass for all interface
 	 * modes except TMII.
@@ -1579,14 +1681,14 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	ret = regmap_update_bits(priv->map, RTL8365MB_BYPASS_LINE_RATE_REG,
 				 RTL8365MB_SDS_BYPASS_LINE_RATE_MASK, 0);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	/* Tune the SerDes with vendor-prescribed parameters */
 	for (i = 0; i < sds_jam_size; i++) {
 		ret = rtl8365mb_sds_write(priv, sds_index,
 					  sds_jam[i].reg, sds_jam[i].val);
 		if (ret)
-			return ret;
+			goto out_unlock;
 	}
 
 	/* Family-specific post-tuning configuration */
@@ -1600,7 +1702,7 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 					 RTL8365MB_D_FIBER_CFG2_RX_DISABLE_MASK,
 					 RTL8365MB_D_FIBER_CFG2_RX_DISABLE_SDS0);
 		if (ret)
-			return ret;
+			goto out_unlock;
 
 		misc_mask = RTL8365MB_D_SDS_MISC_CFG_MASK;
 		misc_val  = RTL8365MB_D_SDS_MISC_PA33PC_EN |
@@ -1618,16 +1720,18 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
 				 misc_mask, misc_val);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
-	if (!is_d) {
+	if (is_d) {
+		WRITE_ONCE(mb->sds_misc_target_val, misc_val);
+	} else {
 		val = sds_mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
 		ret = regmap_update_bits(priv->map,
 					 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
 					 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
 					 val);
 		if (ret)
-			return ret;
+			goto out_unlock;
 	}
 
 	/* Take the SerDes out of reset. The vendor driver does this only
@@ -1637,7 +1741,7 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				  RTL8365MB_SDS_REG_RESET,
 				  RTL8365MB_SDS_RESET_DEASSERT);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	/* Reset the SerDes data path and resync its PLL, mirroring what the
 	 * vendor firmware does right after deasserting the SerDes reset.
@@ -1648,13 +1752,13 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				  RTL8365MB_SDS_REG_BMCR,
 				  RTL8365MB_SDS_BMCR_DPRST_PHASE1);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	ret = rtl8365mb_sds_write(priv, sds_index,
 				  RTL8365MB_SDS_REG_BMCR,
 				  RTL8365MB_SDS_BMCR_DPRST_PHASE2);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	/* Keep SGMII in-band autonegotiation disabled: the link parameters are
 	 * forced from rtl8365mb_pcs_link_up() instead (family C), or from
@@ -1663,13 +1767,207 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	ret = rtl8365mb_sds_read(priv, sds_index,
 				 RTL8365MB_SDS_REG_NWAY, &val);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	val &= ~RTL8365MB_SDS_NWAY_EN_MASK;
 	val |= RTL8365MB_SDS_NWAY_RESTART_MASK;
 
-	return rtl8365mb_sds_write(priv, sds_index,
-				   RTL8365MB_SDS_REG_NWAY, val);
+	ret = rtl8365mb_sds_write(priv, sds_index,
+				  RTL8365MB_SDS_REG_NWAY, val);
+	if (ret)
+		goto out_unlock;
+
+	/* The re-latch edge has only been observed on a CPU trunk with
+	 * HSGMII, so the work is only armed for 2500base-x on a CPU port.
+	 * It starts once the conduit is up.
+	 */
+	if (is_d) {
+		WRITE_ONCE(mb->sds_relatch_armed,
+			   interface == PHY_INTERFACE_MODE_2500BASEX &&
+			   dsa_is_cpu_port(&priv->ds,
+					   RTL8365MB_SDS_EXT_INTERFACE_PORT));
+		/* With the conduit already up no conduit_state_change() will
+		 * follow, so start the episode here.
+		 */
+		if (READ_ONCE(mb->sds_relatch_armed) &&
+		    READ_ONCE(mb->sds_conduit_up))
+			rtl8365mb_sds_relatch_start(mb);
+	}
+
+	ret = 0;
+
+out_unlock:
+	mutex_unlock(&mb->sds_cfg_lock);
+	return ret;
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
+	/* DSA reports the conduits of every switch in the tree, and this
+	 * chip can have two CPU ports (SerDes on port 6, RGMII on port 7).
+	 * Only the conduit of this switch's SerDes CPU port matters here.
+	 */
+	if (cpu_dp->ds != ds ||
+	    cpu_dp->index != RTL8365MB_SDS_EXT_INTERFACE_PORT)
+		return;
+
+	mutex_lock(&mb->sds_cfg_lock);
+
+	WRITE_ONCE(mb->sds_conduit_up, operational);
+	cancel_delayed_work_sync(&mb->sds_relatch);
+	if (operational && READ_ONCE(mb->sds_relatch_armed))
+		rtl8365mb_sds_relatch_start(mb);
+
+	mutex_unlock(&mb->sds_cfg_lock);
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
@@ -1823,11 +2121,27 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
 	}
 }
 
+static void rtl8365mb_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct rtl8365mb *mb = pcs_to_rtl8365mb(pcs);
+
+	if (!rtl8365mb_is_d(mb->priv))
+		return;
+
+	mutex_lock(&mb->sds_cfg_lock);
+
+	WRITE_ONCE(mb->sds_relatch_armed, false);
+	cancel_delayed_work_sync(&mb->sds_relatch);
+
+	mutex_unlock(&mb->sds_cfg_lock);
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
@@ -3560,6 +3874,17 @@ out_error:
 static void rtl8365mb_teardown(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
+	struct rtl8365mb *mb = priv->chip_data;
+
+	if (rtl8365mb_is_d(priv)) {
+		mutex_lock(&mb->sds_cfg_lock);
+
+		WRITE_ONCE(mb->sds_relatch_armed, false);
+		WRITE_ONCE(mb->sds_conduit_up, false);
+		cancel_delayed_work_sync(&mb->sds_relatch);
+
+		mutex_unlock(&mb->sds_cfg_lock);
+	}
 
 	rtl8365mb_stats_teardown(priv);
 	rtl8365mb_irq_teardown(priv);
@@ -3592,6 +3917,23 @@ static int rtl8365mb_get_chip_id_and_ver(struct regmap *map, u32 *id, u32 *ver)
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
@@ -3627,6 +3969,34 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 
 	priv->num_ports = mb->chip_info->family_info->num_ports;
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
@@ -3711,6 +4081,7 @@ static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.port_vlan_add = rtl8365mb_port_vlan_add,
 	.port_vlan_del = rtl8365mb_port_vlan_del,
 	.port_vlan_filtering = rtl8365mb_port_vlan_filtering,
+	.conduit_state_change = rtl8365mb_conduit_state_change,
 	.get_strings = rtl8365mb_get_strings,
 	.get_ethtool_stats = rtl8365mb_get_ethtool_stats,
 	.get_sset_count = rtl8365mb_get_sset_count,
-- 
2.53.0

