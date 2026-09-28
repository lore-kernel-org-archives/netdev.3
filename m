Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30D4E01E7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611939; cv=none; b=qi2PMYHd9RNed3f6G73JCX4Wf/9ETTlfKNw/xEVJ52yDYK4BhXGTrUL1t29Unql604cM0nMapIpa9EjlI3N0mERihDfd6iA/gf6KTAHgsyr8bXEwi0QKMkbGkgFRuD37ITYa7h88gPUgw119vRc9r1MISe1hd8Z76wsdKxYD1so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611939; c=relaxed/simple;
	bh=TpHseWH2Be1F4sOFJKgSd1vKOAUAsPB+fu8d4HRmN3A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXFUK5HPJlkVq09u3efU3QMouahJzn4poKxpbfULycDPWLMOV1gMn08qLV3mk+N3s7tZX2Dx+sYRc9YW8qzLhEC2PCPsfXbghXjwfG6Y5Yuv4FaL7lZhhgZO5i2H/SRFTfwIquM6mlmp9KC3ocJxZjcrNauhsLeYcJYPmMRQkb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG9vrSat; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG9vrSat"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so945007a91.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790611937; x=1791216737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W2hgEYmJ6ir8iY4MLlfzllEXMfY0EKUdDFTYeJvnBmU=;
        b=JG9vrSatQAgMUAXzIv2rgq8KduOAJXA6HVehK02DGgi1xhjixX7iCbFXQkaFgjoFsI
         XDAmYMpMYhFjXZUA5H1U60uguPl1VeoRmo7yjAnW8+Sht1ibUXWQoBQZvjXmJlgbp2tr
         dCPl4zlIkMD4jvCQt0QmVWOV9u6otT1LOa7+/ZRe25w4Gdr4MzJLyR4dBnczTZoW3se2
         1SMBXAgkvwu4E2TzjrYYe9dGDhlptIw4tC8Hzex3N+2uyVplO58wvW2+hBSCQC5tli26
         V/Epx6/hX9XzX3E4zFN96+ZMn8A1bfN+ajvhf9bQkhBjM99ZyNz/SemlX+/wooziQn7F
         3X+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611937; x=1791216737;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2hgEYmJ6ir8iY4MLlfzllEXMfY0EKUdDFTYeJvnBmU=;
        b=p4U9OuDZYhJw9djTdnGz/h68hKoBmBAbBNDjjmJCQQGizbuToSJI4oHRHT00EqwLPN
         WMU3tOaw76iF6Lh5oTd9Y8URD5Fz+5IVh+EgP1YSUzEuSGeNZ5tv0jnvgvrZWzlOFxBN
         wPm3ELVovPKvIhYDu9TKDwniOw6LTrK7UdnqV9UvUql4SdW7JH/u5J3Mk8tD/JL2bWLB
         R5gBbDFLPEmHlD9SurHloqYie9AeYeHDuJI+/UCHAJc4rGQPThdNLqIrBxFHLy1QmCl9
         8eYyJk2BZsbimnmb4bjhqy+S2GilnOJc00G4BBGDWI14867xrFd8VCT4ht4e3qpdMSxN
         omEw==
X-Gm-Message-State: AFq9FYJ4iCStZxnW7OcI0YiZe8F/gC8J32bT9fHLB0DHlGSyoXcWs+zY
	yf4GQqRIE5KK44Z4qJ4BGffwlM31OQUyLlaCKYSM/vk3pgEZUT9/0fo+gzqpfg==
X-Gm-Gg: AYBFou2f7G2fa233N9dGMFn2uhivS2MhFCregsnY47l10KmY8e2ywJc3kBiZOhYCelQ
	jNIxy6KnFzzD2IY+V2SkxrSYuqufzlbYkrMbMgkmMcbss1i6SLcEMngkeyAZZca+OcgzFq/7YOB
	UAzzSn34XCp7vU5NqsAY/s/PwCMl7q3KVZ7HlzCyoejPharrd9gNO2o/sMeP6j14aSjM/Cypg4v
	+svGYYn1pq8mHbHsqjUlN9vDtXf8DlqxW9zZIF2QyOlian8G4Pl4wcjCW0aRpd4+rLtAgE72koC
	0Sy27HlSVoBAcQ6vKac+/fWy227aQx6p5AkUYhF5zhxEh95oQ6LlHaeBVimL8GnRDrgSXmpXcyF
	q6AchdsIQLouWTe9wrL90GkpncvsI4MdqR8xfglXX54Q75G30wGfQk4G7nvcS9ONvO0RuzF3XIS
	HpOccHWUOPHE79YYQD9qRUM2xiI1J5DXcwL9PMDSYSl/Zv6JNH5qI+Fq29PZkOO6m1HXjRdyM26
	OEOfMsMwesn5vW3YnWeKjPLDPhxme8wJVrgF4VUlSq0OvA5e5Y14c3yCKuBGZx3z8wq55/MN4Ay
	dADhIrpSdqJFyj3wCQ==
X-Received: by 2002:a17:90b:58ec:b0:3a4:8e0d:3948 with SMTP id 98e67ed59e1d1-3a48e0d4048mr510281a91.25.1790611937041;
        Mon, 28 Sep 2026 09:12:17 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497d9b117sm276906a91.3.2026.09.28.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:12:16 -0700 (PDT)
Subject: [next-next PATCH v2 2/2] fbnic: Remove BMC routing rules when the BMC
 channel is disabled
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Mon, 28 Sep 2026 09:12:15 -0700
Message-ID: 
 <179061193535.414394.10077526689774524435.stgit@ahduyck-xeon-server.home.arpa>
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

While a BMC is present the driver programs MACDA entries for the BMC
addresses, action rules steering matching traffic to it, the DEST_BMC copy
bit on the multicast/broadcast RSS actions, and a host-unicast copy of the
RSS actions. All of these are only torn down when the host interface goes
down.

A BMC can disable its NC-SI channel while the host interface stays up. The
filters are then left in place, so the host keeps steering traffic to a BMC
that is no longer there, and the driver logs "Found BMC MAC address w/ BMC
not present" at the next interface down.

Detect that bmc_present dropped while BMC tagged rules are still programmed
in fbnic_bmc_rpc_check(), and remove the BMC MAC entries, the action rule
and the host-unicast RSS entries. That needs three supporting changes:

1. Action rules must be marked for deletion in any live state rather than
   only VALID, as a missed deletion leaks the rule for good. The same
   applies to the BMC all-multi rule, which ifdown leaves in UPDATE.
2. The host-unicast entries have to go because fbnic_rss_reinit() only
   programs them while a BMC is present and would otherwise leave them
   stale and valid in hardware.
3. Recompute the RSS actions for both directions; without that a disable
   and re-enable cycle leaves the BMC without its multicast/broadcast
   copies until the interface bounces.

Take the instance lock over the whole of fbnic_bmc_rpc_check() while here.
fbnic_fw_xmit_rpc_macda_sync() walks the entire MACDA shadow and the
teardown above rewrites it, but the service task they both run from holds
only RTNL. RTNL used to cover that, back when ndo_set_rx_mode() was called
inline from dev_set_rx_mode(). fbnic is ops-locked, so netif_rx_mode_run()
now calls ndo_set_rx_mode_async() under the instance lock alone, having
dropped netif_addr_lock and handed over a snapshot of the address lists.
The ethtool NFC paths are in the same position. The instance lock is the
one lock every writer of the shadow holds. The flags are tested once
without it first so the lock stays off the common path, where the service
task has nothing to do.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |   97 ++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index e542b17bdac7..f47669129c9d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -55,6 +55,10 @@ enum {
 	FBNIC_FW_CAP_F_BMC_MACDA_SYNC,
 };
 
+#define FBNIC_FW_CAP_BMC_PENDING	\
+	(BIT(FBNIC_FW_CAP_F_BMC_TCAM_REINIT) |	\
+	 BIT(FBNIC_FW_CAP_F_BMC_MACDA_SYNC))
+
 struct fbnic_fw_cap {
 	unsigned long state;
 	struct {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 51fd0564d33f..939d56585b26 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -143,9 +143,11 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
 
 	/* If we are not enabling the rule just delete it. We will fall
 	 * back to the RSS rules that support the multicast addresses.
+	 * Delete in any live state, not just VALID, as ifdown demotes it to
+	 * UPDATE and a miss there leaves it to be rewritten to hardware.
 	 */
 	if (!fbnic_bmc_all_multi(fbd) || enable_host) {
-		if (act_tcam->state == FBNIC_TCAM_S_VALID)
+		if (act_tcam->state != FBNIC_TCAM_S_DISABLED)
 			act_tcam->state = FBNIC_TCAM_S_DELETE;
 		return;
 	}
@@ -234,10 +236,91 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 	act_tcam->state = FBNIC_TCAM_S_UPDATE;
 }
 
+/**
+ * fbnic_bmc_rules_present - is the BMC currently programmed into the filters?
+ * @fbd: Pointer to fbnic device struct
+ *
+ * The BMC tag is only set while a BMC is present, so it doubles as the state.
+ *
+ * Return: true if any MACDA entry carries the BMC tag, false otherwise.
+ */
+static bool fbnic_bmc_rules_present(struct fbnic_dev *fbd)
+{
+	int idx;
+
+	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
+
+		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
+			continue;
+
+		if (test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * fbnic_bmc_rpc_disable - remove the BMC MAC and action rules
+ * @fbd: Pointer to fbnic device struct
+ *
+ * Undo fbnic_bmc_rpc_init() when the BMC drops its NC-SI channel while the
+ * host interface stays up. Only marks shadow state; the caller's
+ * __fbnic_set_rx_mode() pushes it to hardware, so ordering here is moot.
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
+	 * ifdown demotes VALID to UPDATE. A miss leaks the rule for good, as
+	 * fbnic_bmc_rules_present() keys off the MACDA tag just cleared above.
+	 */
+	act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_BMC_OFFSET];
+	if (act_tcam->state != FBNIC_TCAM_S_DISABLED)
+		act_tcam->state = FBNIC_TCAM_S_DELETE;
+
+	/* fbnic_rss_reinit() only programs the host-unicast entries while a BMC
+	 * is present, so the reinit after this would leave them stale and valid
+	 * in hardware. Delete them to converge on the no-BMC layout.
+	 */
+	for (idx = 0; idx < FBNIC_RSS_EN_NUM_UNICAST; idx++) {
+		act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_RSS_OFFSET + idx];
+		if (act_tcam->state != FBNIC_TCAM_S_DISABLED)
+			act_tcam->state = FBNIC_TCAM_S_DELETE;
+	}
+}
+
 void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 {
+	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
 	int err;
 
+	/* Nothing to do unless the firmware raised one of the flags. Test
+	 * before taking the lock to keep it off the common path; one raised
+	 * after this is picked up on the next pass.
+	 */
+	if (!(READ_ONCE(fbd->fw_cap.state) & FBNIC_FW_CAP_BMC_PENDING))
+		return;
+
+	/* The rx mode work and the ethtool paths rewrite the MACDA and action
+	 * TCAM shadows under the instance lock, and this runs from the service
+	 * task under RTNL only, so the two do not exclude each other.
+	 */
+	netdev_lock(fbd->netdev);
+
 	/* Consume the flag before the state it advertises. The ordering
 	 * implied by test_and_clear_bit() pairs with the barrier in
 	 * fbnic_fw_parse_bmc_cap(), and claiming it atomically means a set
@@ -245,7 +328,15 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 	 */
 	if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_TCAM_REINIT,
 			       &fbd->fw_cap.state)) {
-		fbnic_bmc_rpc_init(fbd);
+		if (!fbnic_bmc_present(fbd) && fbnic_bmc_rules_present(fbd))
+			fbnic_bmc_rpc_disable(fbd);
+		else
+			fbnic_bmc_rpc_init(fbd);
+
+		/* Neither path touches the RSS actions, which carry the mc/bc
+		 * copy to the BMC, so recompute them alongside.
+		 */
+		fbnic_rss_reinit(fbd, fbn);
 		netif_addr_lock_bh(fbd->netdev);
 		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
 		netif_addr_unlock_bh(fbd->netdev);
@@ -258,6 +349,8 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 			dev_warn(fbd->dev,
 				 "Writing MACDA table to FW failed, err: %d\n", err);
 	}
+
+	netdev_unlock(fbd->netdev);
 }
 
 #define FBNIC_ACT1_INIT(_l4, _udp, _ip, _v6)		\


