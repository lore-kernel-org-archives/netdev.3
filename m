Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793223437;
	b=vcsl8x+gPEwJkywWYfBtZ3rc3LIgcxDueDBcLoe9Pt0EtFRQ6JuWQBo/ZWkxxqlG4pxT
	 0VM6LwYI0A5+vz3tNwSgckOGD2w77dLMNKt9p7TLOG9zUHu2AcLVVVNiuvMTAR/kwBnz4
	 lnVcdJlJkBT/5auyCD0oFyJlNlQlpITKd1XvVDdNoYnmKq5JXiTWaa7p9cSurGY0O8wIA
	 DHgtgbUHLv+vjNIXhE86jn/5UqSez6yG866Ng55nmFpciSiNRN/Nm7vl7rtDdsX5hTeEz
	 sOyaV8sCiEvGlx29BE8b3afUOZwvdir0nR95Ko6MCvWp17/0+uv/PeSjckA6b7wW/AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Vhzy7noByEX126HX+/ebxpMnW9uenIyJSMtJYZvM94Q=;
	b=kwr02WiGSqOpjUkz5nWxlAA+L/G+/dKBvJe1gI7fDXuFvSw4GZlKIM0IOGm3umAi+WXi
	 Bn+fU0vzBguViz/E3+XlvkV39YzEw8NENBAVmGGLsSRvTSLfzC39AbEqQXBqzk9nBj7ri
	 0Mt6Zl5nUb1D9xBJmyqQ/yXkGALkjXV/TFdNL1nb3lJwHAC1UcC3++4FumahIt6p+36C+
	 7O/EYuXm7m9qqpCxf1Qx8nmQ55wYvcRuN1NYkmLKlQbj8gFmv+tub3DgESUwDeLLzlcpq
	 mwzhaUSqX+hNIWNWJdwjzIhzn+a6ovl9oXJ+cCdFqOaJhwtIx7RhJPXjmOSRSZTbZWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nRX4DFYi;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CC606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D83CC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nRX4DFYi
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso938671a12.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223436; x=1793828236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vhzy7noByEX126HX+/ebxpMnW9uenIyJSMtJYZvM94Q=;
        b=nRX4DFYiR+6tfiN7dIuOqkqvOt3tyy98/MgwUm/foR2rWhqL3EwJPKLdWIcrnBvsTI
         rtZ4NlXkczP7B2dnOOO0bTUqab0r5eF8LhBhd4kplLb/Vu0rywrGl4RMIzeClgsa+ACN
         qw9Sgv5EU+B2zg3waj6oUGeAh1egFgO/kys91Wbaw4O5EGGdaeBbRcPHlftgQ42IxYiQ
         j5o7sIRt2/6fW4A61Lf1WdTHf66jyAhbGtvjEAAnyKveWMW6ouW2XTeJVkOryDSjRWLB
         uykHkrmNIHOfw83pSBhmF04ftbiv+q2XCOgv3/h6WE5uDpIhhSkbcQDIkeoBpDgvKg4n
         I54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223436; x=1793828236;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vhzy7noByEX126HX+/ebxpMnW9uenIyJSMtJYZvM94Q=;
        b=adRtQ7HcptLWP9+Gz1hSUwi7QbRt9vk3yrJOnJ6/agH0vWQ1VnE0oGNVn1eo5jDTNd
         NKyLkos7sqGDrfaTpJseig3hrPcqEHiqLr3uaW00lML+zF7dg7lWQS+hCMAh+VUmuoT/
         U7ssqct+yh0N1VYo1mKknotNtK74BeeIu3HSlH212rmNkJ/IEgz+TOVyrWI1hVqOeYt3
         ZG5T1+ZOCaAdZYnaPfLkuUMDMA7XXZYbS8jRSpSmmtmbOdP/fK6t2Y5zt6PnziCZ8h3k
         Dd6qqyTt8mJRAWAjHNmDYtA5dnkIshKdP/Qo/Gvpg1c0cf1AAR3LHqKjhmLTY/kyGvrT
         LzOg==
X-Gm-Message-State: AFq9FYJDK1N35io1nYAiyInaapCMvTroCB6zzuNGtjNUCeoOON99fDOh
	R6BKXKeyDU7hL+BoRKnZLLQ1wF7rViBApa5+kTlTiLurds+MG0TkpcRAIZUqxQ==
X-Gm-Gg: AYBFou1kn0O4fQMsDXumTZrwM/0oRAU9RZVmlF4D2es+1TEtvPJ3Nlrh+ysgzTKhUEV
	J0zGpKioMzwbytA9tVTGqjfarcZRGTPVNPFpGRbxxvkpJEF9i+O84jFBS7PJftnX91CCckPaU3G
	tRCtjfOa0JvoMztLFAjql4lTDhhgDef+rhQPiHlLwdL4YD/onUegKDPak75Hhx+/2D9swPqqqeA
	S/BG0g8jzCrrobmlASBHc7OoRq7XuO0WpkiPywrZ9K94Sb6385Gf9Mj/XqkDp+gxal+/9TPRly+
	Z+7iVZPVfUrz5XfVmctPl5bQCkC1Ry7F0KA0wJODA86Sjo4Hq8w1Grtv+TpPu0I/0uFQ3TLECvO
	X8zswM9Fl28izwg3H/Vs/Kd2P39goeoQE/287OEV/LghEEsSJE9D7kH/K54j5Iek9pArqBf5awu
	sKeQknERhUtI6VL7ErMjt7QNjVh4TrH2WUQaCweSV8RzaIsXgT2q3jNZMerpOTWRXEJpd42k86a
	fYvyX03fw2WJ4eEXQc10sehuo2MgBOx1aIYlEgiNSHod4oKgUqufBfha+6s/1+enWVl9kNrHD+j
	F4BSwRVuvI83Atf+TZeuXFYjkD/yHQ0FYhICcYEnNrw2mfi+GnPlqBBeYPG6hn0DoH/7wjdi3kE
	YKOw2dm5YnouNtaa+mHkv/+2muCeC/X/myudUvLdgqd0dtA==
X-Received: by 2002:a17:90a:e18e:b0:3aa:ff19:42b8 with SMTP id 98e67ed59e1d1-3ae580a023emr2738424a91.27.1793223436163;
        Wed, 28 Oct 2026 14:37:16 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8401casm1077253a91.11.2026.10.28.14.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:37:15 -0700 (PDT)
Subject: [net PATCH 10/13] fbnic: Keep the BMC MAC address set whole across a
 capabilities update
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 28 Oct 2026 14:37:13 -0700
Message-ID: 
 <179322343381.40667.1127592669876224055.stgit@ahduyck-xeon-server.home.arpa>
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

The firmware can send a capabilities message at any time, and the
mailbox handler writes the BMC MAC addresses into fw_cap.bmc_mac_addr
from the mailbox interrupt thread. The fbnic_bmc_rpc_init function reads
the same array from the service task and from ndo_open with no lock in
common. A read that overlaps the update can see part of the old set and
part of the new one, or a single address with bytes from both, and
program it into the MACDA TCAM as a BMC address, steering that address's
Rx traffic to the BMC and looping host Tx for it.

The update always raises FBNIC_FW_CAP_F_BMC_TCAM_REINIT after it writes
the array, so the next service task pass rebuilds from the full set.
Until then, up to a second later, the torn entry stays in hardware and
has been pushed to firmware with the MACDA sync.

Guard the array with a seqcount in struct fbnic_fw_cap. The mailbox
parses the new set into a local copy and swaps it in inside a write
section, and the fbnic_bmc_rpc_init function takes a snapshot, retrying
if an update overlapped it, and works from that. Updates are rare and
the mailbox Rx path is the only writer, so a seqcount is enough and the
readers never wait on a lock. The write section runs with preemption
disabled so a reader cannot spin on a preempted update.

Fixes: 04a230b27d8f ("fbnic: Add logic to repopulate RPC TCAM if BMC enables channel")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |   19 ++++++++++++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |    3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |   14 +++++++++++++-
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 7964ce814b8e..09d03274be08 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -104,6 +104,7 @@ void fbnic_mbx_init(struct fbnic_dev *fbd)
 
 	/* Reset FW Capabilities */
 	memset(&fbd->fw_cap, 0, sizeof(fbd->fw_cap));
+	seqcount_init(&fbd->fw_cap.bmc_mac_seq);
 
 	/* Reinitialize mailbox memory */
 	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
@@ -627,6 +628,7 @@ static int fbnic_fw_parse_bmc_addrs(u8 bmc_mac_addr[][ETH_ALEN],
 static int fbnic_fw_parse_bmc_cap(struct fbnic_dev *fbd,
 				  struct fbnic_tlv_msg **results)
 {
+	u8 bmc_mac_addr[4][ETH_ALEN] = {};
 	struct fbnic_tlv_msg *attr;
 	bool bmc_present = false;
 	u32 all_multi = 0;
@@ -639,19 +641,26 @@ static int fbnic_fw_parse_bmc_cap(struct fbnic_dev *fbd,
 	attr = results[FBNIC_FW_CAP_RESP_BMC_PRESENT] ?
 	       results[FBNIC_FW_CAP_RESP_BMC_MAC_ARRAY] : NULL;
 	if (attr) {
-		err = fbnic_fw_parse_bmc_addrs(fbd->fw_cap.bmc_mac_addr,
-					       attr, 4);
+		err = fbnic_fw_parse_bmc_addrs(bmc_mac_addr, attr, 4);
 		if (err)
 			return err;
 
 		all_multi = fta_get_uint(results,
 					 FBNIC_FW_CAP_RESP_BMC_ALL_MULTI);
 		bmc_present = true;
-	} else {
-		memset(fbd->fw_cap.bmc_mac_addr, 0,
-		       sizeof(fbd->fw_cap.bmc_mac_addr));
 	}
 
+	/* The service task can be reading the set in fbnic_bmc_rpc_init(),
+	 * so replace it whole. The mailbox Rx path is the only writer, so a
+	 * seqcount is enough; keep preemption off so a reader cannot spin on
+	 * a preempted update.
+	 */
+	preempt_disable();
+	write_seqcount_begin(&fbd->fw_cap.bmc_mac_seq);
+	memcpy(fbd->fw_cap.bmc_mac_addr, bmc_mac_addr, sizeof(bmc_mac_addr));
+	write_seqcount_end(&fbd->fw_cap.bmc_mac_seq);
+	preempt_enable();
+
 	/* all_multi is only read out of the message when a BMC is present, so
 	 * it is never set on its own and callers can test it without pairing
 	 * it with the presence check.
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 7790ea0badea..f380291a5ad6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -6,6 +6,7 @@
 
 #include <linux/completion.h>
 #include <linux/if_ether.h>
+#include <linux/seqlock.h>
 #include <linux/types.h>
 
 struct fbnic_dev;
@@ -67,6 +68,8 @@ struct fbnic_fw_cap {
 	struct {
 		struct fbnic_fw_ver mgmt, bootloader, undi;
 	} stored;
+	/* Keeps bmc_mac_addr whole for readers, the mailbox is the writer */
+	seqcount_t bmc_mac_seq;
 	u8	bmc_mac_addr[4][ETH_ALEN];
 	u8	link_speed;
 	u8	link_fec;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index e6b9b9d6511f..d64bd622e4a3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -251,6 +251,8 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 	int i = FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX;
 	struct fbnic_act_tcam *act_tcam;
 	struct fbnic_mac_addr *mac_addr;
+	u8 bmc_mac_addr[4][ETH_ALEN];
+	unsigned int seq;
 	int j;
 
 	/* Start from nothing so a MAC the BMC no longer reports does not
@@ -262,9 +264,19 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 	if (!fbnic_bmc_present(fbd))
 		return;
 
+	/* Snapshot the set, the mailbox can replace it under us. A message
+	 * that lands after this raises FBNIC_FW_CAP_F_BMC_TCAM_REINIT again,
+	 * so the next pass rebuilds from it.
+	 */
+	do {
+		seq = read_seqcount_begin(&fbd->fw_cap.bmc_mac_seq);
+		memcpy(bmc_mac_addr, fbd->fw_cap.bmc_mac_addr,
+		       sizeof(bmc_mac_addr));
+	} while (read_seqcount_retry(&fbd->fw_cap.bmc_mac_seq, seq));
+
 	/* Fetch BMC MAC addresses from firmware capabilities */
 	for (j = 0; j < 4; j++) {
-		u8 *bmc_mac = fbd->fw_cap.bmc_mac_addr[j];
+		u8 *bmc_mac = bmc_mac_addr[j];
 
 		/* Validate BMC MAC addresses */
 		if (is_zero_ether_addr(bmc_mac))


