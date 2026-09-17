Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD334AEBED
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687959; cv=none; b=Zo2fP/TlOm6DFz7lD1dMXItq6WOf/ICf+L+t8fyHQ8H7ooEJ9aOJw7pj3MlWzvI4QmKX64x9ZsVRbzlK7udBIGJ45NLaIX5lIM3x3EbZE3hNvaQAFS+xdVlSLYz4VMJrXVBcfL1QouME77W3mH2RXjI3bQBMbSvCL64ebaslVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687959; c=relaxed/simple;
	bh=sdHiZSQcwDmTnX6Et7HXspjldNqHhSXb7LofLpr5s+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WecOQG/Yo9YklL51oqwEpM7cEIGXwOSUk74fi5rqFxB2u4JEXrhJ0LYsLW1flMTyQzn4YE/qh+cZ1cXk2e5vAoH/Hhy45APsNIHHe4aSA3lTuYy8yGeX27yvRbvH2wZ0p5xfPBqQMRcWh5knPjwIXdkPTAQlG8Bw9Dan5iy99aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=DzeINSAw; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="DzeINSAw"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso214587a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789687957; x=1790292757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q6EHC7KNKJFHX8CkGrJ910HitU0NKfeJ5n6UhbOzNZ4=;
        b=DzeINSAwd9u6fDOKsMqhO8TtcSaAKGv/70PvhCrYsxZYTTWz/WHzIcB3LOcLXSTb3p
         B4ie9SMo1E7mIdvFs/eJmW2bpEz2gTJ7Wmv0ozggA6fLnz2ikoLlFpPTxShkVZG94IfI
         4AvTpN5KSJ6K+5Vcbx+9nv6X2n7fOFYKS6M8nAGZGOfJalNapFkAP+baYrAPVAs5te7F
         bhqxzbS+ThI4QcwOdqmiXYFHE+ISlqVJAh2Vm/bwLxle+9DM0nH/r7FEAa8AdohmeUhi
         dBUKh9spxRHvcVwjmjzrvwM8J+DP1/Pev1Kso5IQLXvOw14KfzBiBjVYmJ3cdgJcD01X
         K9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687957; x=1790292757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q6EHC7KNKJFHX8CkGrJ910HitU0NKfeJ5n6UhbOzNZ4=;
        b=Ra1IQlXVe/RYfGmJuz4p9aLNO3pyxzkSvSDH0GV1I9Ui2JzxsZ6x4U1H+lSJ9yvW98
         j0x60RBHUC6YgfL7+gkrayNcokO4iUZuosZ+Et0VoUyamvI/MnkbcceAy2qSnPX0zbZ1
         qcxiE3OW5P8sSNtjNhFKjsB9Ax9NzE+MICHrQbQGlYz4z1bnG8npiP2E7/2TXkL3elU+
         X2YASHCYOBJuJ19LbUhaEmeSs/q5vUnqGEslhi2/cM5vsaKjMQ8gWKEggfMWGI/TAHbw
         bwyCLP/cKtUG+S/HyFZo9FUqeyo4ugT1hJeD1VezUZLgKk19WinGnk/3Eb3nL/8T7qd2
         OENw==
X-Gm-Message-State: AFuF++npHkrET3bS3C4xkONKVmqhHMAi1uVjsbODTrcOShXxxmlivsMG
	zqNvSUVv+iSI75dEHTqf5VpAAB7Na+mbO1A4gEfzUOPqpRN5tFtz1vL2MM7bAHyUB2GPzH/VxLM
	Jq4Rq
X-Gm-Gg: AYBFou27mlb+KnvSqVndzsW/kenQHutgNlH65+1lvoCuLJEkzLNbd6U07xBPIKX0mHQ
	puEwBazU0EqPS5l97ggCAHfwJuNqcamMhp63OSq0XHCrqqtJ/XTOFwPLU+0raJxHoEatexBfhr8
	5mEmAYkiQduDNIPt+BYn4zafX1FQ4JSjsPRiky2CervvwIgwRyUlNGYsqrwU53FWasl58v1cknL
	Sb3AJEbnU/001qXp9W03878ubGpbtRDn/0TYwJbgh2R3XOfEO2tp/ITshFlEkDI7qPybfvP1g+M
	PMVCOO1GiE8pLj4zPn/PdYdZsvsRy6ZbrsVVZzQBE2H03UDl1KQaZCOxoV3bHdjAtPkp/GV/k1W
	1r5/2Rp30EsRdhfpi/W+yiepxUy8Jfi4Hl1kqpjLgGuFyEnK9O+34zrjG/M7kouVGGbKlcqU59k
	c7Br2lS3qHg2x8dPdBCr0gbZ9r+wyM/d2lUb6tOxC0Uaeql4l8Z0Js
X-Received: by 2002:a17:90b:2f50:b0:39e:14db:437c with SMTP id 98e67ed59e1d1-39e54cc2a95mr1546398a91.4.1789687957166;
        Thu, 17 Sep 2026 16:32:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e50a4bc22sm1713050a91.17.2026.09.17.16.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:36 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next 2/2] bnxt_en: recover a failed TX RING_FREE with a ring reset
Date: Thu, 17 Sep 2026 16:32:15 -0700
Message-ID: <20260917233218.1160001-3-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233218.1160001-1-joe@dama.to>
References: <20260917233218.1160001-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HWRM_RING_FREE is sent with a completion ring set and the completion
never arrives, hwrm_ring_free_send_msg() logs

  hwrm_ring_free type 1 failed. rc:fffffff0 err:0
  Resp cmpl intr err msg: 0x51

and returns -EIO. bnxt_hwrm_tx_ring_free() clears fw_ring_id anyway and
__bnxt_close_nic() calls bnxt_free_mem(), unmapping ring memory
the firmware has not been told to stop using.

On a host with an IOMMU the result is an IO_PAGE_FAULT or a DMAR fault
against the freed pages seconds later.

A TX ring whose completions have stopped will trigger the netdev
watchdog, the reset closes the device, and every RING_FREE routed
through that dead completion ring times out.

Try to recover from this by adding bnxt_tx_ring_reset_and_free and
bnxt_hwrm_tx_ring_reset.

The intent here is that bnxt_tx_ring_reset_and_free will try a TX ring reset
in polled mode (assuming the completion ring is dead) and, if that succeeds,
retry the RING_FREE in polled mode as well.

Bump tx_resets in this path. A non-zero ethtool tx_resets value on
a device that never tripped the netdev watchdog would identify a
firmware that stopped answering RING_FREE on a completion ring.

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ac7716dbf88d..c47f6f24dfa4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7660,6 +7660,44 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
 	return 0;
 }
 
+static int bnxt_hwrm_tx_ring_reset(struct bnxt *bp,
+				   struct bnxt_tx_ring_info *txr)
+{
+	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+	struct hwrm_ring_reset_input *req;
+	int rc;
+
+	rc = hwrm_req_init(bp, req, HWRM_RING_RESET);
+	if (rc)
+		return rc;
+
+	req->ring_type = RING_RESET_REQ_RING_TYPE_TX;
+	req->ring_id = cpu_to_le16(ring->fw_ring_id);
+	return hwrm_req_send_silent(bp, req);
+}
+
+static int bnxt_tx_ring_reset_and_free(struct bnxt *bp,
+				       struct bnxt_tx_ring_info *txr)
+{
+	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+	struct bnxt_cp_ring_info *cpr;
+	int rc;
+
+	rc = bnxt_hwrm_tx_ring_reset(bp, txr);
+	if (rc) {
+		netdev_err(bp->dev,
+			   "TX ring %d reset failed after RING_FREE failed, rc: %d\n",
+			   txr->txq_index, rc);
+		return rc;
+	}
+
+	cpr = &txr->bnapi->cp_ring;
+	cpr->sw_stats->tx.tx_resets++;
+
+	return hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
+				       INVALID_HW_RING_ID);
+}
+
 static int bnxt_hwrm_tx_ring_free(struct bnxt *bp,
 				  struct bnxt_tx_ring_info *txr,
 				  bool close_path)
@@ -7675,6 +7713,9 @@ static int bnxt_hwrm_tx_ring_free(struct bnxt *bp,
 		       INVALID_HW_RING_ID;
 	rc = hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
 				     cmpl_ring_id);
+	if (rc && cmpl_ring_id != INVALID_HW_RING_ID)
+		rc = bnxt_tx_ring_reset_and_free(bp, txr);
+
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 	return rc;
 }
-- 
2.53.0-Meta

