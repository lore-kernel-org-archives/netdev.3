Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009A4E4C5D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611932; cv=none; b=OgEWkK+axpxc3itX7AIqCK95+h05zDsYnT70b+EbKJsVFA12hsHo2CfdRBLVXNbIJ2N+wHZ4QdQgHp5o3bTLAaf7eD30ffxMlXhPkkZ+XB2E3t7hp357q9MFg00wHicqUvfZbfEFbeEmd+pEh3asSmbqAOEW5qMX8WwGIbRPpI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611932; c=relaxed/simple;
	bh=deMRu+YMCfw+ReTJCawNn8EmrTi5q4jhSphuP+CxPdI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aATIzaAsX5MiMC7/WSVPKg1JwXv5ssyp5LkyN50CweYM7qeVZpLInGYN2Rclo8hYWhYmJFBIh+ZHTwxk/ia/wOl+f/qOG85bIYUPJDbkWp7fbhIvE9ae1WudfgLQ0jT1hRLWbLxu+lbAkTVkk2Au0pqHx46cStAurhSZvA5kjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IotlFLKP; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IotlFLKP"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c3304833so1171126a12.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790611930; x=1791216730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j3X8LbKSjMsPe4bzO+yHxQEso28H94uRdazXUsPCr0c=;
        b=IotlFLKPwOLLxY0oXolrkWxjr1+NEdKtJnyL6oH7Uqsc0bsRhV22+oioFD05JXs5VS
         vHUS0GUWNi6U+hNR0DlHuWICWm0IVen2eu0aFEpDLXTroSvH4Bimh/p/e6AvmXfzRZnq
         yLK+AloefthVtXkpBAIc27svTP30npJN26ZO8BSIjplKk2KnAxuAS2VKxjz5zvZB/g7I
         q/7kDHtZfr1x3aDxP7zOyTeLO0qxPWEDnOdiYNRpOQck/bmgTAczCRsCIK/lbO6lfs85
         P3imMEX1FLZsLwbQfXEYrN2jKRjfNhEX+OmP4QDszxIqJWFr72qaHMhdKcW2mn9Q6jsD
         sm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611930; x=1791216730;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3X8LbKSjMsPe4bzO+yHxQEso28H94uRdazXUsPCr0c=;
        b=Ex6LIOPfWdB4g0SqSKD6WsecX2yqCbYf8SKO/IvanPS/xMGDK6UHpauyDsIfaB0FUI
         lxZA3WvYSffIdf0qqvPzeIVW0ToruLLQbdAC+FmUR+X5g4jWQK1R7WI2MSE5LNM42cOk
         xNbh1fAJOJwdwSfnZvTodT6fIFUlbmnkeRbD5AtRZNJ3d/86LGtBee82q79qtXwJFw8L
         QZDMPyFi00XoAIjUD57ZQUi1kbBqH/5ipUrvQlFxvZGW92+0GonC5VRz0FoQpxolrx6v
         3S7tUFvrZaH3yTbYvpAHfSfYXwuFlBNWPnCb/IokBtMxSrumLAJlvVaYAE+jwvyrcmWE
         7NLA==
X-Gm-Message-State: AFq9FYKnoYVinv9J0Q/72p8abCjHdQ9C74JZ37J9PasSBVgC+Q2/AxSE
	Kb5XWpptlWLD1R72voZDIydh29at8+Y+VEIsTrOjmhRjJVvODBfVk80E
X-Gm-Gg: AYBFou15BazfUvkTZCtn7r9SQOBfYHViBuWnFb1QL7Y8jT4zPpbGz2d1D0lgHpVnKq9
	l/KZIZ8BJ5jckbhuO9Iu2/SUYM/NsDXVKW3QI4npNi8TjmL00XHZ+37nRt0nY0edBkiv+Qx+dj2
	uUHrUZU3n6g8+xY3Kc0Re0Ong1WaxW6rBzJz1tYL3kOBsdoK2QZocsEtoChD2VjQL6oh6WDG5XT
	h5uwbwhYe81FYRXm5QkT4VuhLXpLIZjvutejlCPzqrFOhI/GWqVM6ez7asVnk6YibXxDGQ/tdrq
	Fq6cAidW5kgeT8Vc0PlcmTSpoSH6OjU/51H0FYtCxXvK7FBX75U+YwMs+IWgCcILtuBd804mWsd
	Sw9zWe++v7z1sd8/s0fIS7OBiTYzPsXzq+hih6S1vO6kBWhY88Cfz+S0jthSHWi25iULW9JYoQJ
	hxG/aOBIsdVFycWmCV1LuyNYjHtJzyi7+YOqHgo4TezID4NN2jFSHmRECyR9vFry9ezkkMOL2QT
	IvAMY8cGDJ5kk5kr0JY7A0WXY8/vDAMOrQ3XZFWqhxOzlKuyGCqhJZ6MeSYmKmwJpDbVxFAWXgV
	pdt3Ylmuxmg4s3FCbA==
X-Received: by 2002:a17:90b:3842:b0:3a0:aed7:7b39 with SMTP id 98e67ed59e1d1-3a0aed81503mr10346986a91.24.1790611930178;
        Mon, 28 Sep 2026 09:12:10 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49804220fsm229094a91.12.2026.09.28.09.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:12:09 -0700 (PDT)
Subject: [next-next PATCH v2 1/2] fbnic: Rework the BMC state pulled from the
 capabilities message
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Mon, 28 Sep 2026 09:12:08 -0700
Message-ID: 
 <179061192791.414394.2161969547553719796.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179061185153.414394.13396934246780284806.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179061185153.414394.13396934246780284806.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The BMC side of the RPC configuration is driven entirely out of the
capabilities message: it carries the BMC presence, its MAC addresses and
the all-multi request, and the reinit flag raised off it is what gets the
service task to reprogram the MACDA and action TCAMs. Pull that out of
fbnic_fw_parse_cap_resp() into a helper and rework the state it publishes.

The firmware reports the BMC present as soon as its NC-SI channel is
enabled, before the BMC has been assigned a MAC address. Such a message
carries no BMC MAC array and is rejected with -EINVAL, discarding the rest
of it. Treat a present BMC with no MAC as absent instead. There is no entry
to steer traffic to without one, so the BMC paths stay disabled either way,
and the link speed, FEC and anti-rollback version in the same message are
no longer thrown out with it.

bmc_present, need_bmc_tcam_reinit, need_bmc_macda_sync and all_multi are
single bit members of one bitfield, so every write to one is a
read-modify-write of all four. The mailbox writes three of them and the
service task writes the other two. Move them into an unsigned long state
field driven by the atomic bitops. Putting it at the top of the struct
keeps the cost to the word itself: 152 bytes grows to 160, still three
cachelines, with a 1 byte hole left ahead of anti_rollback_version.

Order the reinit handoff while there. The mailbox publishes the BMC state
before raising the flag and the service task tests the flag before
consuming it, so pair an smp_mb__before_atomic() on the raise with a
test_and_clear_bit() on the consume. Claiming the flag atomically also
keeps a raise that lands mid-pass instead of dropping it.

Commit all_multi unconditionally rather than only when the firmware
supplied the attribute. An absent attribute means the BMC is not asking for
all-multi, so holding the previous value just kept stale state. It is read
out of the message only when a BMC is present, so it is never set on its
own and the three callers that paired it with the presence check can test
it alone.

fbnic_write_macda() tests the reinit flag to force a MACDA sync and now
always sees it clear when reached from fbnic_bmc_rpc_check(). That path is
unaffected, as fbnic_bmc_rpc_init() unconditionally marks the broadcast
entry, so the update count is never zero while a BMC is present.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h     |    7 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |   78 +++++++++++++++++----------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |   15 ++++-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |   24 +++++---
 4 files changed, 80 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 0e7ae1def5bf..1f9fbd71447f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -161,7 +161,12 @@ void fbnic_fw_wr32(struct fbnic_dev *fbd, u32 reg, u32 val);
 
 static inline bool fbnic_bmc_present(struct fbnic_dev *fbd)
 {
-	return fbd->fw_cap.bmc_present;
+	return test_bit(FBNIC_FW_CAP_F_BMC_PRESENT, &fbd->fw_cap.state);
+}
+
+static inline bool fbnic_bmc_all_multi(struct fbnic_dev *fbd)
+{
+	return test_bit(FBNIC_FW_CAP_F_BMC_ALL_MULTI, &fbd->fw_cap.state);
 }
 
 static inline bool fbnic_init_failure(struct fbnic_dev *fbd)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 47894b45676b..49b8813a3564 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -620,11 +620,55 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],
 	return 0;
 }
 
+static int fbnic_fw_parse_bmc_cap(struct fbnic_dev *fbd,
+				  struct fbnic_tlv_msg **results)
+{
+	struct fbnic_tlv_msg *attr;
+	bool bmc_present = false;
+	u32 all_multi = 0;
+	int err;
+
+	/* FW reports the BMC present once its NC-SI channel is enabled, before
+	 * it has a MAC. No MAC array means nothing to program, so treat it as
+	 * absent rather than rejecting the message.
+	 */
+	attr = results[FBNIC_FW_CAP_RESP_BMC_PRESENT] ?
+	       results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY] : NULL;
+	if (attr) {
+		err = fbnic_fw_parse_bmc_addrs(fbd->fw_cap.bmc_mac_addr,
+					       attr, 4);
+		if (err)
+			return err;
+
+		all_multi = fta_get_uint(results,
+					 FBNIC_FW_CAP_RESP_BMC_ALL_MULTI);
+		bmc_present = true;
+	} else {
+		memset(fbd->fw_cap.bmc_mac_addr, 0,
+		       sizeof(fbd->fw_cap.bmc_mac_addr));
+	}
+
+	/* all_multi is only read out of the message when a BMC is present, so
+	 * it is never set on its own and callers can test it without pairing
+	 * it with the presence check.
+	 */
+	assign_bit(FBNIC_FW_CAP_F_BMC_PRESENT, &fbd->fw_cap.state, bmc_present);
+	assign_bit(FBNIC_FW_CAP_F_BMC_ALL_MULTI, &fbd->fw_cap.state, all_multi);
+
+	/* Always assume we need a BMC reinit. The barrier orders the BMC state
+	 * published above ahead of the flag, pairing with the ordering implied
+	 * by the test_and_clear_bit() in fbnic_bmc_rpc_check().
+	 */
+	smp_mb__before_atomic();
+	set_bit(FBNIC_FW_CAP_F_BMC_TCAM_REINIT, &fbd->fw_cap.state);
+
+	return 0;
+}
+
 static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 {
-	u32 all_multi = 0, version = 0;
 	struct fbnic_dev *fbd = opaque;
-	bool bmc_present;
+	u32 version = 0;
 	int err;
 
 	version = fta_get_uint(results, FBNIC_FW_CAP_RESP_VERSION);
@@ -684,37 +728,13 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 	fbd->fw_cap.link_fec =
 		fta_get_uint(results, FBNIC_FW_CAP_RESP_FW_LINK_FEC);
 
-	bmc_present = !!results[FBNIC_FW_CAP_RESP_BMC_PRESENT];
-	if (bmc_present) {
-		struct fbnic_tlv_msg *attr;
-
-		attr = results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY];
-		if (!attr)
-			return -EINVAL;
-
-		err = fbnic_fw_parse_bmc_addrs(fbd->fw_cap.bmc_mac_addr,
-					       attr, 4);
-		if (err)
-			return err;
-
-		all_multi =
-			fta_get_uint(results, FBNIC_FW_CAP_RESP_BMC_ALL_MULTI);
-	} else {
-		memset(fbd->fw_cap.bmc_mac_addr, 0,
-		       sizeof(fbd->fw_cap.bmc_mac_addr));
-	}
-
-	fbd->fw_cap.bmc_present = bmc_present;
-
-	if (results[FBNIC_FW_CAP_RESP_BMC_ALL_MULTI] || !bmc_present)
-		fbd->fw_cap.all_multi = all_multi;
+	err = fbnic_fw_parse_bmc_cap(fbd, results);
+	if (err)
+		return err;
 
 	fbd->fw_cap.anti_rollback_version =
 		fta_get_uint(results, FBNIC_FW_CAP_RESP_ANTI_ROLLBACK_VERSION);
 
-	/* Always assume we need a BMC reinit */
-	fbd->fw_cap.need_bmc_tcam_reinit = true;
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 5f9969247e30..e542b17bdac7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -45,7 +45,18 @@ struct fbnic_fw_ver {
 	char commit[FBNIC_FW_CAP_RESP_COMMIT_MAX_SIZE];
 };
 
+/* Bits in fbnic_fw_cap.state. The firmware mailbox publishes the BMC state
+ * and the service task consumes it, so they are updated with atomic bitops.
+ */
+enum {
+	FBNIC_FW_CAP_F_BMC_PRESENT,
+	FBNIC_FW_CAP_F_BMC_ALL_MULTI,
+	FBNIC_FW_CAP_F_BMC_TCAM_REINIT,
+	FBNIC_FW_CAP_F_BMC_MACDA_SYNC,
+};
+
 struct fbnic_fw_cap {
+	unsigned long state;
 	struct {
 		struct fbnic_fw_ver mgmt, bootloader;
 	} running;
@@ -54,10 +65,6 @@ struct fbnic_fw_cap {
 	} stored;
 	u8	active_slot;
 	u8	bmc_mac_addr[4][ETH_ALEN];
-	u8	bmc_present		: 1;
-	u8	need_bmc_tcam_reinit	: 1;
-	u8	need_bmc_macda_sync	: 1;
-	u8	all_multi		: 1;
 	u8	link_speed;
 	u8	link_fec;
 	u32	anti_rollback_version;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index ab6e342ec3fa..51fd0564d33f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -117,7 +117,7 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
 	 * BMC.
 	 */
 	mac_addr = &fbd->mac_addr[fbd->mac_addr_boundary - 1];
-	if (fbnic_bmc_present(fbd) && fbd->fw_cap.all_multi) {
+	if (fbnic_bmc_all_multi(fbd)) {
 		if (mac_addr->state != FBNIC_TCAM_S_VALID) {
 			eth_zero_addr(mac_addr->value.addr8);
 			eth_broadcast_addr(mac_addr->mask.addr8);
@@ -144,7 +144,7 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
 	/* If we are not enabling the rule just delete it. We will fall
 	 * back to the RSS rules that support the multicast addresses.
 	 */
-	if (!fbnic_bmc_present(fbd) || !fbd->fw_cap.all_multi || enable_host) {
+	if (!fbnic_bmc_all_multi(fbd) || enable_host) {
 		if (act_tcam->state == FBNIC_TCAM_S_VALID)
 			act_tcam->state = FBNIC_TCAM_S_DELETE;
 		return;
@@ -238,20 +238,25 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 {
 	int err;
 
-	if (fbd->fw_cap.need_bmc_tcam_reinit) {
+	/* Consume the flag before the state it advertises. The ordering
+	 * implied by test_and_clear_bit() pairs with the barrier in
+	 * fbnic_fw_parse_bmc_cap(), and claiming it atomically means a set
+	 * racing with us is kept and retried rather than overwritten.
+	 */
+	if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_TCAM_REINIT,
+			       &fbd->fw_cap.state)) {
 		fbnic_bmc_rpc_init(fbd);
 		netif_addr_lock_bh(fbd->netdev);
 		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
 		netif_addr_unlock_bh(fbd->netdev);
-		fbd->fw_cap.need_bmc_tcam_reinit = false;
 	}
 
-	if (fbd->fw_cap.need_bmc_macda_sync) {
+	if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_MACDA_SYNC,
+			       &fbd->fw_cap.state)) {
 		err = fbnic_fw_xmit_rpc_macda_sync(fbd);
 		if (err)
 			dev_warn(fbd->dev,
 				 "Writing MACDA table to FW failed, err: %d\n", err);
-		fbd->fw_cap.need_bmc_macda_sync = false;
 	}
 }
 
@@ -484,8 +489,7 @@ void fbnic_promisc_sync(struct fbnic_dev *fbd,
 				mac_addr->act_tcam);
 			mac_addr->state = FBNIC_TCAM_S_ADD;
 		}
-	} else if (mc_promisc &&
-		   (!fbnic_bmc_present(fbd) || !fbd->fw_cap.all_multi)) {
+	} else if (mc_promisc && !fbnic_bmc_all_multi(fbd)) {
 		/* We have to add a special handler for multicast as the
 		 * BMC may have an all-multi rule already in place. As such
 		 * adding a rule ourselves won't do any good so we will have
@@ -656,12 +660,12 @@ void fbnic_write_macda(struct fbnic_dev *fbd)
 	}
 
 	/* If reinitializing the BMC TCAM we are doing an initial update */
-	if (fbd->fw_cap.need_bmc_tcam_reinit)
+	if (test_bit(FBNIC_FW_CAP_F_BMC_TCAM_REINIT, &fbd->fw_cap.state))
 		updates++;
 
 	/* If needed notify firmware of changes to MACDA TCAM */
 	if (updates != 0 && fbnic_bmc_present(fbd))
-		fbd->fw_cap.need_bmc_macda_sync = true;
+		set_bit(FBNIC_FW_CAP_F_BMC_MACDA_SYNC, &fbd->fw_cap.state);
 }
 
 static void fbnic_clear_act_tcam(struct fbnic_dev *fbd, unsigned int idx)


