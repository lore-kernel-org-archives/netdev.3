Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398D36D513
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657495; cv=none; b=okwrYRNzz6BXmCxZwpAPyfesbCPdcDaOsZKbnBShOceA8jd42uw/j0Iu+tezeBJgMls2/aNNXpSYRELaQT1Zh/13Ztg4xy3Wlk4Z6blhdTzHSd+cUl+TvRJsi34FEBe7ELjEhUFVRgk+duIof1+EwyqcfMfSaDNyMzD1h00TUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657495; c=relaxed/simple;
	bh=GPwFzpTvBiF3jKktciwDCPbF0OBWYg8gevnawRjSxWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoEKAAkZFbSqVPJprwSUya3FD6/iRfcgY2vzckSIhODGzMGm9P5vXv2p1JDFs5Sfe1aoPIZ7vX9ux0Kdn7PGcRnxC1rcLEdNlrnGT8xG/ujfO4OVTkmN2efGfiPQjqYXt2Wg+97FBBKA9iZ9IfnQeyxx7VrUGSXJ1CRlizF1B8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gib/WhKV; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gib/WhKV"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-44cf70de986so156442fac.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657492; x=1784262292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+8MO+ToVYh+Lu407Nxoyj43Y+ENbeqP5Ch5hj/v43w=;
        b=EI/d2VV8/w1Pb7USSonjiNh/3h0GdxqhpjmU+x24SggCRXooCiucRrUd/xjW9ac+4G
         w3Oo6HzkPdOWXhh1FDg/ByD0W4jllIB55dsq9weQfZisxhhH5JpVMcRznOhoEvQbXe9h
         QJWCBYtXOwNbYWh7Xzvtzk2f5wH65X1EpxVfUicD88JUkhnidv2ryyC7yTxsntg1wFHg
         V9YGUzIPh8300RXalI1QBwE9Z/0w//aftXW/PsGkFeHilCidZc5BASdBGeo8ZCzo3aW1
         zk4RXmhV1g77gjhLIaewj0NcGeRZ+uns1X7g9HCqyJSssW7qDKTP3RuREj9SXxG3JUek
         zT6A==
X-Gm-Message-State: AOJu0YyFGcOt6s+zyvdbciFfc9Xt+vSufwNRuFr/v/rnPAStbeM1irX5
	iK8qIcGacp+/8wcMkRWpSiYWOj/eZhC2JTtcC/rjXi0G3dsDQM14ZAbvK7Nxv0hwpje4xCwCr9+
	O97L6KnpypFMG9IugNzHI+jYc+M5/Lmlb6pfStRpQd9ffAIJRDjOeyGyvkalt+rxx3ognDjGwBU
	YhVMH5paA3SeoZxe5NoZdsnPKJjCKKoXP97vCaXdwCJceQPHjY2qg95aixRvy4g99kpjQ8wpE/K
	WNcyI7cyQ8=
X-Gm-Gg: AfdE7ckUk5Mo6diwST/xn6Fy7ByW06egk+J5ZlVpkx93EFUucR5euYgloc+G+2CVD6y
	ECe6cPktwFSxNlccSniya1sDpCau6SY5thQKV982824o5u2cuMtNYE8cqc50vfAQ0DBNkEvbOrs
	SRGPpjhCRRrBiSxiB2QPUW7zPXmvYRKEHHpHdfBYPgjeIkpwWdGIR+fu7IPouO3TeX7TByD01uj
	sUHSbUo3GldWqo/1PZI8/+SVHTD8jduCgICLqJURjhyKAgehen/Z7NWLFCdRvLhPp32h1nuqgxn
	4dhCzORiV0HtzN7V/+6zIEE2FdaV9eeIL+bM5G4Q7HBWh7Wf3sN3pMRTZa59eEDsOO7bYf1xGK5
	gkgkHMdO/IGb7aywWWSy4RjLDB+Vsp137381GXiYuEKNkCkTNbjNVvPOFyeOtXGtQxFEi+ZyMGy
	bex7cPxBksVRf/7E4vZ2EjKoYMPy5vBGZcYC4M8Kzhxox43A==
X-Received: by 2002:a05:6870:c183:b0:448:558c:d825 with SMTP id 586e51a60fabf-45163d970d9mr6521867fac.40.1783657492436;
        Thu, 09 Jul 2026 21:24:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4519133e54csm367107fac.4.2026.07.09.21.24.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:24:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so731622a12.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657490; x=1784262290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+8MO+ToVYh+Lu407Nxoyj43Y+ENbeqP5Ch5hj/v43w=;
        b=Gib/WhKVavpdLA2SceILmRdx5TBVf72wIqpiWnkGQObFxhbXW3nk0IfYZgSWU7mO4Z
         QNJuVZ7zYqfaahnvIQa8wWhVuYzuz+xT811tJK9pC83DeIh2KWeajYfCVWOVWhJe4NeL
         XkGxL/pNR55rmXUAcivD0LJMNYFtARKdTWd1A=
X-Received: by 2002:a05:6a21:670b:b0:3c0:9c19:65b5 with SMTP id adf61e73a8af0-3c0bcc3ae41mr13223579637.61.1783657490074;
        Thu, 09 Jul 2026 21:24:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:670b:b0:3c0:9c19:65b5 with SMTP id adf61e73a8af0-3c0bcc3ae41mr13223544637.61.1783657489619;
        Thu, 09 Jul 2026 21:24:49 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:48 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v5 04/15] bnxt_en: Rename xdp_tx_lock to tx_lock
Date: Thu,  9 Jul 2026 21:23:49 -0700
Message-ID: <20260710042400.3996847-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710042400.3996847-1-michael.chan@broadcom.com>
References: <20260710042400.3996847-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

xdp_tx_lock in struct bnxt_tx_ring_info is used to serialize
XDP_REDIRECT on the same TX ring.  MPCs will also need this lock
for a similar purpose to serialize sending multiple messages on
the same MPC, so rename it to tx_lock.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 56de663f3027..22770751567c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4154,7 +4154,7 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
-		spin_lock_init(&txr->xdp_tx_lock);
+		spin_lock_init(&txr->tx_lock);
 		if (i < bp->tx_nr_rings_xdp)
 			continue;
 		if (BNXT_RING_TO_TC_OFF(bp, i) == (bp->tx_nr_rings_per_tc - 1))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index fec88d40a606..91016684c02a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1014,8 +1014,8 @@ struct bnxt_tx_ring_info {
 	u32			dev_state;
 
 	struct bnxt_ring_struct	tx_ring_struct;
-	/* Synchronize simultaneous xdp_xmit on same ring */
-	spinlock_t		xdp_tx_lock;
+	/* Synchronize simultaneous xdp_xmit on same ring or for MPC ring */
+	spinlock_t		tx_lock;
 };
 
 #define BNXT_LEGACY_COAL_CMPL_PARAMS					\
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index b485e4d9b26f..d1873124893a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -352,7 +352,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 		return -EINVAL;
 
 	if (static_branch_unlikely(&bnxt_xdp_locking_key))
-		spin_lock(&txr->xdp_tx_lock);
+		spin_lock(&txr->tx_lock);
 
 	for (i = 0; i < num_frames; i++) {
 		struct xdp_frame *xdp = frames[i];
@@ -377,7 +377,7 @@ int bnxt_xdp_xmit(struct net_device *dev, int num_frames,
 	}
 
 	if (static_branch_unlikely(&bnxt_xdp_locking_key))
-		spin_unlock(&txr->xdp_tx_lock);
+		spin_unlock(&txr->tx_lock);
 
 	return nxmit;
 }
-- 
2.51.0

