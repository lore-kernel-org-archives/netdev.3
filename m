Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223422;
	b=hOoWe4ITVGJiK0m+WvzKmPbXh1KfNgRA5CL8AFxuoxqwv1anHhXe70k4ykS1XgXqhoJq
	 E0jtK9LTCKlb49kstoLYghelLdOzEdrl+qahUCv14NTvI/DvTzzQM5PiG221xj3O0RwR6
	 Krp/InzfZoCDuZFtXX4XVBiGLxyxspn8lS76zbcBg/E6kufHP+gFA5n5ou3Xuv5fN60Ud
	 b5sUpRNGmCKEWHAGVngpmQcZaL7ql6vmU324iFTrPeajGsoP7K1b+vdOZUvPHzoFlmNE8
	 DzGTFq9UNBVQoj+nFztnV5/kKKHFVBOVjF7myygNnLDTm0+ONsGAEMJsoFmZjFipaFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dkfhppQAawvSVhTmAiRPZynGr0PY6/fO2/7yzytcwYg=;
	b=jhvKgNNWsyWRfWzwh04kTG1r+FY1U0xhlug5Q9UVCUL+B4f503Y5q83+sHnrrBMVzPIQ
	 HKxkIxjDtL/Iwkr4qCfSC3fcy46WzVX1L+FE3PcWHn1n3Oh4Ok2JGSueY1xE33TJZCor4
	 JmCKHVT0stWXV8ZBujBsEn2fbW9smIWnsI6E1aHUlTuz3SFw6sIdsYVJVrlpBI5BB7yO4
	 OPglGCk6ykfZZBbUkevkbPrhzMbJ93i1uwQl1NgNi043pH3Bb+gg+ZcXqdftNbw4EyDB0
	 h6ot1OeqR7dYH/EuWACWwxbFwnLh2BO2PMg/0rtc0il9EEoctVFoCkptM8Nw1dUdX6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FzFgLqo6;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550ED606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 550ED606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FzFgLqo6
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so933313a91.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223421; x=1793828221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dkfhppQAawvSVhTmAiRPZynGr0PY6/fO2/7yzytcwYg=;
        b=FzFgLqo6G3G1+81YFI6Rg18pbGRX3WnYylrBjaojBUCYXWeZYrULhMlQ5K+FDaHgmi
         4Do22HDsNXvROjGD9Hfc4EsoBklj26PHKSkvEI2sm6FNYXeAw3xQ6od3MRytXQHv1f1i
         0/9CXwQUZMLa69U36KOj6eaLEEtJxNa37yrxYd1XRX9pOwIr3P15OcQg0C7R1bDuk3WT
         NR9RN3e9Rcxz2MhE9MmJ5zAa+Qk+N/TLbIbD2IzKZNuLWKZfLkGZykbX1zxZBSB6URtZ
         DExldZRKisrPBTeLCPkC0WqWeBNHGJKaKqzqKAzj0AQgONuJjq0PLtDInWNcg/EyB4E/
         8P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223421; x=1793828221;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkfhppQAawvSVhTmAiRPZynGr0PY6/fO2/7yzytcwYg=;
        b=QX8oJxh++tB7PBkcY6flxxsXGYsZt//wa4W5YjsiBKtkF7nMMo5W0T4LVED25W7AhJ
         p5ThsIS9b9c5/qpeSil/I4MTLLW+gWD+2Hg4ULsBfiSYcYaf5HtT1gC+Nqz983SQPLrO
         /gusGdJyWlgWTWisUsRxZdq6PsmHWRyX8gixE3UhyggFhc8YMBUGJG6chi0AcdAQbc/q
         qiihwkFD67CWQ0kDU2+dyP7f1h/Bp+GrEds24Z5QB3XIu2s96+WTETY5H17wsnWkr4to
         gcKm/Izr845AYLQZoMg7m91Krr19PB+VsFWKcbQUk0weP4Z5kc+Iu5i1De0U3Sl6NQ+v
         V8Ew==
X-Gm-Message-State: AFq9FYKA4x7PUkbGKU6lNuRBffOzBH9VI46PrrGjFaHhY77gkVFHLbOI
	8Kvm7H6Y9+evadCDkGrY1jCxlmtW73LUv/utw+4g1tYt0oEMtiaM5KtH6/ziow==
X-Gm-Gg: AYBFou0OvpF8QtsIHxXl9Q4UQ6HplNgmxopJHAAyh5Xqt0BZq81VCCb2KYSvHBrt1/3
	UDb3hNedpvH0Xwt5SwjmiLNxFJXjFFCfVmv8zNr++5aYfrqYfwiIa6XIyAMM46xoWT/2S1OKjdi
	NYSgU2y6L1a8EMz/RtqFzpA3nimx6OlpLA/brdw109aDqSwHySow/hp7eHlJAjvdVAPZl6oq+4C
	t81Ksc5n3x1UwvKdMqz/H8DfTEZAxJPcJC5cAMLaQDTo6m71VY6SGbZvp1CaCfLN/8fnVrtvGtk
	HWMabilmlN30NospefpcBQIFtlFC9YH4B9UBXoUVv/fS7LjZ9heEf1RD9rlYn/RzRdJnb2QbvLO
	5Bvez28gwz0+6yEIoNQOWyi1Xp41KviFVP2qcurrkn4ztUrAMxx8acxcKbEiof4yJ1K0rchfAWZ
	F+m8ztFdYCWmy7rm2GQ2r+5Y+KCc65RhTbVxtndL4ccUdKtfAjVt2wzZhM1c3e7l0QWdrgCWfUN
	xxr9bZlrQuIGemtiUBEJHU9Ciz0LWsn5BYMY9Ioxs77Pu6pkf3R9cWM8ieh2EzobLe1uLAg3DkU
	QZlJcYbikh4wq4DoRY0QuaF1UpUV4rv1hAFt/zMYSE1BrGx79r70svtnex/6nY6WPycbYHJTAzp
	x6ZeArDsOyqJQLDPIGmaIBXKp9mZx69IkofWJanYi9FqLNg==
X-Received: by 2002:a17:90b:6d0:b0:3ac:7556:8ed9 with SMTP id 98e67ed59e1d1-3ae58169cf5mr2583326a91.10.1793223421473;
        Wed, 28 Oct 2026 14:37:01 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8401casm1076801a91.11.2026.10.28.14.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:37:00 -0700 (PDT)
Subject: [net PATCH 08/13] fbnic: Rebuild the BMC rules from scratch on every
 reinit
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:36:59 -0700
Message-ID: 
 <179322341925.40667.5355631858927438954.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179322311834.40667.5383039334126572422.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_bmc_rpc_init function tags the MACDA entries for the MAC
addresses the BMC currently reports, but never untags the ones it
reported before. If the BMC changes its MAC set while staying present,
or drops its channel and comes back with different addresses before the
service task gets to the first message, the addresses it no longer owns
stay BMC-tagged and valid. Action rule 0 keeps steering their Rx traffic
to the BMC and the fbnic_write_tce_tcam function keeps looping host Tx
for them to it.

The fbnic_bmc_rpc_check function only tore the rules down when the BMC
was absent and the fbnic_bmc_rules_present function found a BMC-tagged
MACDA entry. That misses the host-unicast RSS entries when the
fbnic_rss_reinit function programmed them from ethtool or SIOCSHWTSTAMP
while the BMC was briefly present, before any MACDA entry was tagged. It
also does nothing at open: if the BMC went away while the interface was
down, the __fbnic_open function writes the entries left from the last
ifdown back to hardware and they stay there until the first service task
pass.

Have the fbnic_bmc_rpc_init function start by calling the
fbnic_bmc_rpc_disable function and then rebuild from the current
capabilities, and drop the conditional and the fbnic_bmc_rules_present
function. The teardown only marks shadow state, so an entry rebuilt
before the next hardware write is rewritten in place, not cleared and
re-added. Both callers already follow it with the fbnic_rss_reinit
function, which puts the host-unicast RSS entries back when a BMC is
present. A BMC multicast address that is still reported is found again
by the __fbnic_mc_sync function in the DELETE entry the teardown left,
and one that changed can take a freed slot, now that the multicast sync
reuses entries waiting for deletion. One that the fbnic_sift_macda
function moved into the BMC region is only pulled back out by the
__fbnic_mc_sync function when a shared slot is free, so with the shared
region full it is taken back in place by the new fbnic_bmc_mc_reserved
function instead of being lost.

The all-multi wildcard is rebuilt by the fbnic_bmc_rpc_all_multi_config
function instead, which only tagged it when it installed it. Tag it on
every pass, as an entry the host kept for its own all-multi stays valid
through the teardown.

Fixes: 04a230b27d8f ("fbnic: Add logic to repopulate RPC TCAM if BMC enables channel")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |  167 +++++++++++++++------------
 1 file changed, 91 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index ee781a3e1528..e6b9b9d6511f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -123,9 +123,12 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
 			eth_broadcast_addr(mac_addr->mask.addr8);
 			mac_addr->value.addr8[0] ^= 1;
 			mac_addr->mask.addr8[0] ^= 1;
-			set_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
 			mac_addr->state = FBNIC_TCAM_S_ADD;
 		}
+		/* Tag it even if valid, the host may have held on to it while
+		 * fbnic_bmc_rpc_disable() stripped the BMC tag.
+		 */
+		set_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
 		assign_bit(FBNIC_MAC_ADDR_T_ALLMULTI, mac_addr->act_tcam,
 			   enable_host);
 	} else {
@@ -172,6 +175,77 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
 	act_tcam->state = FBNIC_TCAM_S_UPDATE;
 }
 
+/**
+ * fbnic_bmc_rpc_disable - remove the BMC MAC and action rules
+ * @fbd: Pointer to fbnic device struct
+ *
+ * Strip everything a previous fbnic_bmc_rpc_init() programmed. Idempotent,
+ * and only marks shadow state; entries that are rebuilt before the next
+ * hardware write are rewritten in place rather than cleared and re-added.
+ */
+static void fbnic_bmc_rpc_disable(struct fbnic_dev *fbd)
+{
+	struct fbnic_act_tcam *act_tcam;
+	int idx;
+
+	/* Drop the BMC's claim; entries the host also uses survive */
+	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
+
+		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
+			continue;
+
+		__fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_BMC);
+	}
+
+	/* Delete in any live state, not just VALID: init leaves it UPDATE and
+	 * ifdown demotes VALID to UPDATE.
+	 */
+	act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_BMC_OFFSET];
+	if (act_tcam->state != FBNIC_TCAM_S_DISABLED)
+		act_tcam->state = FBNIC_TCAM_S_DELETE;
+
+	/* fbnic_rss_reinit() only programs the host-unicast entries while a BMC
+	 * is present, and does not clear them otherwise. Delete them here and
+	 * let it put them back if they are still needed.
+	 */
+	for (idx = 0; idx < FBNIC_RSS_EN_NUM_UNICAST; idx++) {
+		act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_RSS_OFFSET + idx];
+		if (act_tcam->state != FBNIC_TCAM_S_DISABLED)
+			act_tcam->state = FBNIC_TCAM_S_DELETE;
+	}
+}
+
+/**
+ * fbnic_bmc_mc_reserved - find a BMC multicast entry in the BMC region
+ * @fbd: Pointer to fbnic device struct
+ * @addr: Multicast address to look for
+ *
+ * fbnic_sift_macda() moves a BMC-only multicast entry into a free BMC slot,
+ * and __fbnic_mc_sync() only pulls it back out when a shared slot is free.
+ *
+ * Return: the entry holding @addr, or NULL if there is none.
+ */
+static struct fbnic_mac_addr *fbnic_bmc_mc_reserved(struct fbnic_dev *fbd,
+						    const u8 *addr)
+{
+	int idx;
+
+	for (idx = FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX + 1;
+	     idx < FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX; idx++) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
+
+		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
+			continue;
+
+		if (is_zero_ether_addr(mac_addr->mask.addr8) &&
+		    ether_addr_equal(mac_addr->value.addr8, addr))
+			return mac_addr;
+	}
+
+	return NULL;
+}
+
 void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 {
 	int i = FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX;
@@ -179,6 +253,11 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 	struct fbnic_mac_addr *mac_addr;
 	int j;
 
+	/* Start from nothing so a MAC the BMC no longer reports does not
+	 * keep its tag, then rebuild from what firmware last sent.
+	 */
+	fbnic_bmc_rpc_disable(fbd);
+
 	/* Check if BMC is present */
 	if (!fbnic_bmc_present(fbd))
 		return;
@@ -191,10 +270,16 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 		if (is_zero_ether_addr(bmc_mac))
 			continue;
 
-		if (is_multicast_ether_addr(bmc_mac))
+		if (is_multicast_ether_addr(bmc_mac)) {
 			mac_addr = __fbnic_mc_sync(fbd, bmc_mac);
-		else
+			/* With the shared region full, keep the copy the
+			 * teardown left in the BMC region in place.
+			 */
+			if (!mac_addr)
+				mac_addr = fbnic_bmc_mc_reserved(fbd, bmc_mac);
+		} else {
 			mac_addr = &fbd->mac_addr[i++];
+		}
 
 		if (!mac_addr) {
 			netdev_err(fbd->netdev,
@@ -236,73 +321,6 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 	act_tcam->state = FBNIC_TCAM_S_UPDATE;
 }
 
-/**
- * fbnic_bmc_rules_present - is the BMC currently programmed into the filters?
- * @fbd: Pointer to fbnic device struct
- *
- * The BMC tag is only set while a BMC is present, so it doubles as the state.
- *
- * Return: true if any MACDA entry carries the BMC tag, false otherwise.
- */
-static bool fbnic_bmc_rules_present(struct fbnic_dev *fbd)
-{
-	int idx;
-
-	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
-		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
-
-		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
-			continue;
-
-		if (test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
-			return true;
-	}
-
-	return false;
-}
-
-/**
- * fbnic_bmc_rpc_disable - remove the BMC MAC and action rules
- * @fbd: Pointer to fbnic device struct
- *
- * Undo fbnic_bmc_rpc_init() when the BMC drops its NC-SI channel while the
- * host interface stays up. Only marks shadow state; the caller's
- * __fbnic_set_rx_mode() pushes it to hardware, so ordering here is moot.
- */
-static void fbnic_bmc_rpc_disable(struct fbnic_dev *fbd)
-{
-	struct fbnic_act_tcam *act_tcam;
-	int idx;
-
-	/* Drop the BMC's claim; entries the host also uses survive */
-	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
-		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
-
-		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
-			continue;
-
-		__fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_BMC);
-	}
-
-	/* Delete in any live state, not just VALID: init leaves it UPDATE and
-	 * ifdown demotes VALID to UPDATE. A miss leaks the rule for good, as
-	 * fbnic_bmc_rules_present() keys off the MACDA tag just cleared above.
-	 */
-	act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_BMC_OFFSET];
-	if (act_tcam->state != FBNIC_TCAM_S_DISABLED)
-		act_tcam->state = FBNIC_TCAM_S_DELETE;
-
-	/* fbnic_rss_reinit() only programs the host-unicast entries while a BMC
-	 * is present, so the reinit after this would leave them stale and valid
-	 * in hardware. Delete them to converge on the no-BMC layout.
-	 */
-	for (idx = 0; idx < FBNIC_RSS_EN_NUM_UNICAST; idx++) {
-		act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_RSS_OFFSET + idx];
-		if (act_tcam->state != FBNIC_TCAM_S_DISABLED)
-			act_tcam->state = FBNIC_TCAM_S_DELETE;
-	}
-}
-
 void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 {
 	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
@@ -328,13 +346,10 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 	 */
 	if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_TCAM_REINIT,
 			       &fbd->fw_cap.state)) {
-		if (!fbnic_bmc_present(fbd) && fbnic_bmc_rules_present(fbd))
-			fbnic_bmc_rpc_disable(fbd);
-		else
-			fbnic_bmc_rpc_init(fbd);
+		fbnic_bmc_rpc_init(fbd);
 
-		/* Neither path touches the RSS actions, which carry the mc/bc
-		 * copy to the BMC, so recompute them alongside.
+		/* The RSS actions carry the mc/bc copy to the BMC and depend on
+		 * its presence, so recompute them alongside.
 		 */
 		fbnic_rss_reinit(fbd, fbn);
 		netif_addr_lock_bh(fbd->netdev);


