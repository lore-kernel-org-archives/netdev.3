Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8737996C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845235; cv=none; b=N0CnbuNG8W3Vv6i+u8JfrrNDlG8zVdDxMEa1nuJl3k6Rx6GrrOr9b0b3lsOtZ1wRklsTh2vzOSvICIsfDlGXptOdEvFjqStgnWcaETxwmk0zRcI5uAcMVko1AJgMxbdLaF6GLoN0RfSQ4PJ5E2vpg+vvTkz5LG9n+rJIKh1CoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845235; c=relaxed/simple;
	bh=CuNmVJCuZY2+JNGzwafB/YLT0mbdir+vx/GW+DTkJ50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqeDvNa7PNp5ka2OxjAVZafdvjxo8mHDBWO2qYBPPAilUXTC84M/Y/5PrS/cFj6hyJ78WL9KpBi2VcNp3pcmspua4B68dCtsA0+wVeiPSb9bVRHDCC+YGfL0cKmeOmdB6nSNqehwJqO/aeqWljSAOM+XJf6VKVHXb8qmcsGmpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2ZvVZd7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2ZvVZd7"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so3384536a91.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 22:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845233; x=1789450033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5EVHk0NXXIU8EHUIjtyFuKryvLqKxApr9W8JeHmHPt8=;
        b=H2ZvVZd70iCPfPoCSLZlADFiW1q+a/Aze/2RpINRvuMX+Bvsz5/qVcRjgd/m1cRVGF
         dqOxnZIEs4vdUAx36Xb8Rn6XrIOc4EMJcwMwwVTTwXeQelc00ihyk5BoeYyjifSe82nE
         2slQLfQycBdqDcv7PqDrP8dbkhGs6wI0v7EOh3pUAL6iHFU5cm+CMAKVaTHPH/MEOwGd
         nK0pXq57kuprz3pF9kQ9/ZjAvIpu2AnjONj28J+LPMJsRGiC1oFg/W8qlPaKaHE46DGx
         dJxTy07Rhn4B/geyAmJAXkRdK35xIKEiAnwo77SBpStfmmtzFPA5LWP8k56jy10ln7ac
         frKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845233; x=1789450033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5EVHk0NXXIU8EHUIjtyFuKryvLqKxApr9W8JeHmHPt8=;
        b=g1Cu6I0dGD1aO2UWr1OKekJiSnqJ3CytVBIgXid+3iNjK1PdZGmNLrjisSs1jhG4Tu
         cSIlb6xDnYOCUdokVrNxf1pRxDO7dh0tIyyOweOFGm45tJeQV5D1Oz//GaRZup6h39Ua
         y5dE/bfCYzOcCaUKo9fNWv0Hl0h5uQ0+HWCShZvB8d2GhlxlqkIcZlG5il36eykLel4F
         14VCLn1clBt92Ki2TGOqjIWmrBJ/or8PlIn4smHLOXzywojt0ZuqnTd3+i2OMuC21gy2
         cRivxTVtVK9mk321lnOdFOKT9qYDAywXP8C9fUGZ1yisTpZ+uLsWFOtdMRkrR6Q8FeJz
         ZQzg==
X-Forwarded-Encrypted: i=1; AKwUvByoel8EbyCpdXnMszbK7LoWtPnsDq68lTMmHo2FUOhUru4NwV6aWufDmnCxKBKVd9oeZtzZTNM=@vger.kernel.org
X-Gm-Message-State: AFuF++lA/h2/TOq2gCh8m3TJF3fNM4+l0qSk3CDeRxD2L/9vX8PLHClH
	pqTlj7t72x0LD+QJczZe7Xv63emgCDoaTNtJ1SMtTG3biJ27Ox5eZSTO
X-Gm-Gg: AYBFou2OAdcijpZkO4r1/K0WRqjU1wMo2nc0UhjuBCw3uHwhEB8CEMk+rMKzcPGuLLB
	H2A+UbD6vRzAvxxLqFlZpZH0C6c4J+WmEbwnjx/B93bg4UR1pM+QhYkMLR4ey5SyRxUNzdEEBAB
	OFoWevzcT7OkRokE2EaTRFwTi63eD9rzvWAGj0xREpp/R/kCvyfVJ7H2CbeYIfz6c/XDhc5DZe9
	EnTIZdTUCoa8DBacXVOjbDX7zXE2cnmE0Zdjri2Uh4J5q8oZbt8BbK8SWJzMuSTrDqYz3mkiUQB
	HmtwEwwIY8/t00Osvt19QBUf0iy6eWpju9NFvo9SqphScoZQOW35Uj0gKUxlGvK1k69w1gEmhqm
	gGGkUBm4D71P5pKOegBC9DmC/LLMBFgg2iyUi9ldxui0SZ13cEokZSFP6XylvbL3dO+lKb5RRdj
	Tfy7DQ2GZ7qi4fgbyD5wt+r3G8nweqYAirugXh38QgW5P4MkoNC2nrBAhVlEUmRL5XqfQXRlwMf
	neu8CK6th10eFzKSShRl9I4
X-Received: by 2002:a17:90b:4d06:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-39b2614df74mr38607866a91.1.1788845233163;
        Mon, 07 Sep 2026 22:27:13 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm11720586c88.9.2026.09.07.22.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:27:12 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Chris Snook <chris.snook@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Geetha sowjanya <gakula@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Manish Chopra <manishc@marvell.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Verma <rahulv@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Russell King <linux@armlinux.org.uk>,
	Shahed Shaikh <shshaikh@marvell.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 07/10] net: marvell: fix typos in comments
Date: Tue,  8 Sep 2026 10:55:59 +0530
Message-ID: <20260908052602.27497-8-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908052602.27497-1-hemanth.selam@gmail.com>
References: <20260908052602.27497-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspellings in comments, found with scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Comments only, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h              | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c          | 8 ++++----
 drivers/net/ethernet/marvell/octeontx2/af/npc.h         | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c     | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c      | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c               | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 061fcd444d50..3ed5670f01c2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -729,7 +729,7 @@
 #define MVPP2_MAX_TXQ			8
 
 /* MVPP2_MAX_TSO_SEGS is the maximum number of fragments to allow in the GSO
- * skb. As we need a maxium of two descriptors per fragments (1 header, 1 data),
+ * skb. As we need a maximum of two descriptors per fragments (1 header, 1 data),
  * multiply this value by two to count the maximum number of skb descs needed.
  */
 #define MVPP2_MAX_TSO_SEGS		300
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index 93e978bdf303..ad677cfddb4d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -382,7 +382,7 @@ static int mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
 	struct mvpp2_prs_entry pe;
 	int tid;
 
-	/* Go through the all entires with MVPP2_PRS_LU_FLOWS */
+	/* Go through the all entries with MVPP2_PRS_LU_FLOWS */
 	for (tid = MVPP2_PRS_TCAM_SRAM_SIZE - 1; tid >= 0; tid--) {
 		u8 bits;
 
@@ -1212,7 +1212,7 @@ static void mvpp2_prs_mh_init(struct mvpp2 *priv)
 	mvpp2_prs_hw_write(priv, &pe);
 }
 
-/* Set default entires (place holder) for promiscuous, non-promiscuous and
+/* Set default entries (place holder) for promiscuous, non-promiscuous and
  * multicast MAC addresses
  */
 static void mvpp2_prs_mac_init(struct mvpp2 *priv)
@@ -2241,7 +2241,7 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 	struct mvpp2_prs_entry pe;
 	int tid;
 
-	/* Go through the all entires with MVPP2_PRS_LU_MAC */
+	/* Go through the all entries with MVPP2_PRS_LU_MAC */
 	for (tid = MVPP2_PE_MAC_RANGE_START;
 	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) {
 		unsigned int entry_pmap;
@@ -2539,7 +2539,7 @@ int mvpp2_prs_def_flow(struct mvpp2_port *port)
 
 	/* Such entry not exist */
 	if (tid < 0) {
-		/* Go through the all entires from last to first */
+		/* Go through the all entries from last to first */
 		tid = mvpp2_prs_tcam_first_free(port->priv,
 						MVPP2_PE_LAST_FREE_TID,
 					       MVPP2_PE_FIRST_FREE_TID);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 719b3618eeb5..309244fe8754 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -84,7 +84,7 @@ enum npc_kpu_lc_ltype {
 	NPC_LT_LC_CUSTOM1 = 0xF,
 };
 
-/* Don't modify Ltypes upto SCTP, otherwise it will
+/* Don't modify Ltypes up to SCTP, otherwise it will
  * effect flow tag calculation and thus RSS.
  */
 enum npc_kpu_ld_ltype {
@@ -140,7 +140,7 @@ enum npc_kpu_lg_ltype {
 	NPC_LT_LG_CUSTOM1 = 0xF,
 };
 
-/* Don't modify Ltypes upto SCTP, otherwise it will
+/* Don't modify Ltypes up to SCTP, otherwise it will
  * effect flow tag calculation and thus RSS.
  */
 enum npc_kpu_lh_ltype {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 153eb57bad06..d80d2c00bd84 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4974,7 +4974,7 @@ static void rvu_nix_setup_capabilities(struct rvu *rvu, int blkaddr)
 
 	/* On OcteonTx2 DWRR quantum is directly configured into each of
 	 * the transmit scheduler queues. And PF/VF drivers were free to
-	 * config any value upto 2^24.
+	 * config any value up to 2^24.
 	 * On CN10K, HW is modified, the quantum configuration at scheduler
 	 * queues is in terms of weight. And SW needs to setup a base DWRR MTU
 	 * at NIX_AF_DWRR_RPM_MTU / NIX_AF_DWRR_SDP_MTU. HW will do
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index 3e1bf22cba69..f98ef5431c90 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -301,7 +301,7 @@ static void cn10k_get_ingress_rate_cfg(u64 rate, u32 *rate_exp,
 	 * policer timeunit * 2^rdiv ie 2 * 2^rdiv usecs, to the token bucket.
 	 * Here policer timeunit is 2 usecs and rate is in bits per sec.
 	 * Since floating point cannot be used below algorithm uses 1000000
-	 * scale factor to support rates upto 100Gbps.
+	 * scale factor to support rates up to 100Gbps.
 	 */
 	tmp = rate * 32 * 2;
 	if (tmp < 256000000) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index f110dfa42360..91d346d114af 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -67,7 +67,7 @@ static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 	if (!req)
 		return -ENOMEM;
 
-	/* Request one schq per level upto max level as configured
+	/* Request one schq per level up to max level as configured
 	 * link config level. These rest of the scheduler can be
 	 * same as hw.txschq_list.
 	 */
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index bbbbbba63e15..2370b2ddba6b 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -514,7 +514,7 @@ static int add_del_hash_entry(struct pxa168_eth_private *pep,
 /*
  * ----------------------------------------------------------------------------
  *  Create an addressTable entry from MAC address info
- *  found in the specifed net_device struct
+ *  found in the specified net_device struct
  *
  *  Input : pointer to ethernet interface network device structure
  *  Output : N/A
@@ -806,7 +806,7 @@ static int rxq_process(struct net_device *dev, int budget)
 		stats->rx_bytes += rx_desc->byte_cnt;
 		/*
 		 * In case received a packet without first / last bits on OR
-		 * the error summary bit is on, the packets needs to be droped.
+		 * the error summary bit is on, the packets needs to be dropped.
 		 */
 		if (((cmd_sts & (RX_FIRST_DESC | RX_LAST_DESC)) !=
 		     (RX_FIRST_DESC | RX_LAST_DESC))
-- 
2.48.1

