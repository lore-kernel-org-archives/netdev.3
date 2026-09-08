Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2E36B912
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845209; cv=none; b=aJaYrFvBlKSu5Tw9UvGzCGQ4GSNuKwFzu+GEzi8oTu0OcBUlen11Eo8O5NS07fraVL1c4XF71WJ4vVeXd0UkrZDlkP2YJOhpA/V6lcvdyFCzertyteuarfIQj5UMdRXmPkZt7WQpG/kGb4awfTOhPYu+y1Dv8k0lznNKStBawvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845209; c=relaxed/simple;
	bh=euwZzd/VFR4HBBLlVmWUOsKqBJWwNbfBplF7gYP2uQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm4MAN/057EYx4cHepmyfw9L0MJwrsmbo3oJpH7Z7jKj4MLVTRfpU87PSpYaoH+QNVzx2DE0LwLq7SRpc7ZraZ789yara9YrQGsqot9uDa4jkcMCau/KASPIs959/arZFVt/Y9AT2Ijz6skrzDANqQasozFkJDjm1iwRLRNtvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqBDloLS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqBDloLS"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso5409533a91.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845207; x=1789450007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1z6Bj27I27t4pJmuJ175AefeQtd/kOqAphoJXB6vZBA=;
        b=QqBDloLSVafCHnAlsUsq5XcwBtt+XX1R7bRNH4j6B6tWCKT9uEK3rCaO1L2/OTOWGB
         AdSSr6xnT4Xhm0i87tb7YWrjToGKZz+yfSHQ4zZGiko4yXH2wfAPzyCbzXstvGgVXbgp
         J2ricQyJDxB/mpt8Q0OlID3DWPPntbl1HWp49mjswQ0AU9739U5FrOvIoWHDu5wQzMxn
         +K0CEZ1W/PHroneZG0N4JMd4e0GzsF/6pRehAoXpGpaPHNrX/t4w1/vlGM5MgTaF6kqU
         tbIyXd4+bUg7O7TAJyjMnUqig95IiFdjiHFoNENsgX5skakNNbsiQQ6OmakcOiOVUoMQ
         kKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845207; x=1789450007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1z6Bj27I27t4pJmuJ175AefeQtd/kOqAphoJXB6vZBA=;
        b=A/v9YQSLH19CpFEIN/Jz+aTz2Y9DwOD7RWvoF1CnI0D/q9p5kNepapbxjPPg5bZSnz
         UZA03QG0rdnpHRQBJxN4RrzeSpd8WPi3GiU7GTXPulzbNLWxlVKxmWXQjzaViNDzYjkW
         ay2NiAuZdzQmEHYCJIkIalLfJg53wtU1Bb5THJvyGEMehnCh+mzfDRb11Yof1QWnY5LT
         acNkobToWRZPGj5101nCM0jWSO60Y884P3XMS7CKHf9tblV2EG2DuuHmiNcePxC2LZVx
         lFgIkxS6m6aTNIgZZvUUjwIeK45/RAXeVank+keDEs4+1kNbuv10RTBx2tsyNf9qDqkz
         8kLg==
X-Forwarded-Encrypted: i=1; AKwUvBxFEb2AVHH7s2BKtggOUE9iuM6tdKiqiLbr41/R4709Ao5yAct0yuJWafxgVnt05rZBhHSCzFw=@vger.kernel.org
X-Gm-Message-State: AFuF++nVY4rXouBOiTqJWp1+BZ+c97msVMVjxfFw/Ysse8Uar/ae4mqN
	cVxY87bPLgAWNpTiaGIFlKBYjRqxiKOh+SUSjd+KBfNcHnOFNX2Gzurn
X-Gm-Gg: AYBFou2/McNxIPRJzVK4wXvMYi6+XiwwiX01B7cnYiFq94cgkQyEvN2N51BC/tcihrJ
	wHpXITBEtQxskIkTlbm6fO8gJ28pagEQN1nycxvIf7MC8C4rGjVo66jMitkC7LN/KbzbjB2oADX
	5nokFAjcWQ28r5XsJmv4rtMuPNxhRogIbLQB8A5g4GfDVz2bsogt7YGf433ZO6jMPCPcy5agyAF
	YeV7zjIMRz4crBWUxGSWlpy3Bc+XxGenoiTEhi4/x+84VdBGZp0924OsEbIz4VzBhUNMTFveOMy
	73GI928k8Ps9+wMOT3rGVwjaKFkiOF6LhxngN1+69azoY49hDIhxHN4LFL/fclfwmOJmSvvbt0w
	GxiFenQQq07Rr1q3PeUi/ihnwwqQPoTV/IE1202Sp5/qXmVscJ2TJpqsBywtJcxaRQStiPjZHhb
	q3TxUjO9Hlxmb+YgrwZ5WscAKnHqhbXaMRBt1Zr689itn2l9E3WcstwOjlzzx0WcEbcEK5EmIPe
	7ItdGhzI+R3H9EfoTmwoDr/
X-Received: by 2002:a17:90b:3943:b0:398:d8eb:cb2a with SMTP id 98e67ed59e1d1-39b26273e31mr43805291a91.23.1788845207542;
        Mon, 07 Sep 2026 22:26:47 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm11720586c88.9.2026.09.07.22.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:26:47 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/10] net: cavium: fix typos in comments
Date: Tue,  8 Sep 2026 10:55:56 +0530
Message-ID: <20260908052602.27497-5-hemanth.selam@gmail.com>
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
 drivers/net/ethernet/cavium/liquidio/cn66xx_device.c   | 2 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c        | 2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_config.h   | 4 ++--
 drivers/net/ethernet/cavium/liquidio/octeon_iq.h       | 2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_main.h     | 2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_nic.h      | 2 +-
 drivers/net/ethernet/cavium/liquidio/request_manager.c | 2 +-
 drivers/net/ethernet/cavium/thunder/nic.h              | 2 +-
 drivers/net/ethernet/cavium/thunder/nic_main.c         | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn66xx_device.c b/drivers/net/ethernet/cavium/liquidio/cn66xx_device.c
index 93fccfec288d..d3ebbb40579e 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn66xx_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn66xx_device.c
@@ -177,7 +177,7 @@ static void lio_cn66xx_setup_pkt_ctl_regs(struct octeon_device *oct)
 
 	/* 66XX SPECIFIC */
 	if (CFG_GET_OQ_MAX_Q(cn6xxx->conf) <= 4)
-		/* Disable RING_EN if only upto 4 rings are used. */
+		/* Disable RING_EN if only up to 4 rings are used. */
 		pktctl &= ~(1 << 4);
 	else
 		pktctl |= (1 << 4);
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 93b06d599eed..bed450bfad38 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -565,7 +565,7 @@ static int octeon_setup_droq(struct octeon_device *oct, int q_no, int num_descs,
 }
 
 /**
- * liquidio_push_packet - Routine to push packets arriving on Octeon interface upto network layer.
+ * liquidio_push_packet - Routine to push packets arriving on Octeon interface up to network layer.
  * @octeon_id:octeon device id.
  * @skbuff:   skbuff struct to be passed to network layer.
  * @len:      size of total data received.
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_config.h b/drivers/net/ethernet/cavium/liquidio/octeon_config.h
index 24c212001212..d2d64edaf3bf 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_config.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_config.h
@@ -254,7 +254,7 @@ struct octeon_oq_config {
 	u64 pkts_per_intr:16;
 
 	/** Interrupt Coalescing (Time Interval). Octeon will interrupt the
-	 *  host if atleast one packet was sent in the time interval specified
+	 *  host if at least one packet was sent in the time interval specified
 	 *  by this field. The driver uses time interval interrupt coalescing
 	 *  by default. The time is specified in microseconds.
 	 */
@@ -296,7 +296,7 @@ struct octeon_oq_config {
 	u64 oq_intr_pkt:16;
 
 	/** Interrupt Coalescing (Time Interval). Octeon will interrupt the
-	 *  host if atleast one packet was sent in the time interval specified
+	 *  host if at least one packet was sent in the time interval specified
 	 *  by this field. The driver uses time interval interrupt coalescing
 	 *  by default.  The time is specified in microseconds.
 	 */
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_iq.h b/drivers/net/ethernet/cavium/liquidio/octeon_iq.h
index a04f36a0e1a0..fdd7d3a77a2d 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_iq.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_iq.h
@@ -70,7 +70,7 @@ struct oct_iq_stats {
 
 /** The instruction (input) queue.
  *  The input queue is used to post raw (instruction) mode data or packet
- *  data to Octeon device from the host. Each input queue (upto 4) for
+ *  data to Octeon device from the host. Each input queue (up to 4) for
  *  a Octeon device has one such structure to represent it.
  */
 struct octeon_instr_queue {
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_main.h b/drivers/net/ethernet/cavium/liquidio/octeon_main.h
index 953edf0c7096..d2a52673cac5 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_main.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_main.h
@@ -166,7 +166,7 @@ static inline int octeon_map_pci_barx(struct octeon_device *oct,
  * errno -EINTR: user abort the command.
  * errno -ETIME: user spefified timeout value has been expired.
  * errno -EBUSY: the response of the request does not return in
- *               resonable time (LIO_SC_MAX_TMO_MS).
+ *               reasonable time (LIO_SC_MAX_TMO_MS).
  *               the sc wll be move to zombie response list by
  *               lio_process_ordered_list()
  *
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_nic.h b/drivers/net/ethernet/cavium/liquidio/octeon_nic.h
index c139fc423764..8341faaa0c24 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_nic.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_nic.h
@@ -277,7 +277,7 @@ int octnet_send_nic_data_pkt(struct octeon_device *oct,
 
 /** Send a NIC control packet to the device
  * @param oct - octeon device pointer
- * @param nctrl - control structure with command, timout, and callback info
+ * @param nctrl - control structure with command, timeout, and callback info
  * @returns IQ_FAILED if it failed to add to the input queue. IQ_STOP if the
  * queue should be stopped, and IQ_SEND_OK if it sent okay.
  */
diff --git a/drivers/net/ethernet/cavium/liquidio/request_manager.c b/drivers/net/ethernet/cavium/liquidio/request_manager.c
index d7cfb20eea00..a983e7f79461 100644
--- a/drivers/net/ethernet/cavium/liquidio/request_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/request_manager.c
@@ -40,7 +40,7 @@ static void  __check_db_timeout(struct octeon_device *oct, u64 iq_no);
 
 static void (*reqtype_free_fn[MAX_OCTEON_DEVICES][REQTYPE_LAST + 1]) (void *);
 
-/* Define this to return the request status comaptible to old code */
+/* Define this to return the request status compatible to old code */
 /*#define OCTEON_USE_OLD_REQ_STATUS*/
 
 /* Return 0 on success, 1 on failure */
diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 090d6b83982a..bb3f4fa6b995 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -97,7 +97,7 @@
  * This value ensures that once a packet has been "accepted"
  * for reception it will not get dropped due to non-availability
  * of CQ descriptor. An errata in HW mandates this value to be
- * atleast 0x100.
+ * at least 0x100.
  */
 #define NICPF_CQM_MIN_DROP_LEVEL       0x100
 
diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 0ec65ec634df..086f32b61580 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -595,7 +595,7 @@ static void nic_config_rss(struct nicpf *nic, struct rss_cfg_msg *cfg)
 	nic_reg_write(nic, idx_addr | (cpi_base << 3), cpi_cfg);
 }
 
-/* 4 level transmit side scheduler configutation
+/* 4 level transmit side scheduler configuration
  * for TNS bypass mode
  *
  * Sample configuration for SQ0 on 88xx
-- 
2.48.1

