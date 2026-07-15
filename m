Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAF3CB56A;
	Wed, 15 Jul 2026 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138466; cv=none; b=Kc+HUD8Jd0OfjXRyCDChvIYF9OfoO4jsRHgWiJdGALvgXYJPI+ZsplwrCi+YAsCXHbRtnkNaRN5mIQC7bqwgtHnuogYjUmG96mhRPN4e8VPy+p4zONi1OA/Ub7tgnKQqfru8FHSCnwiFbHzKFc0RHJ18zVX4uMr/d5cHF1T3NWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138466; c=relaxed/simple;
	bh=zeFNlg+Jqu/extEAPQx7wr3dHGwsr/NGMEnESda69fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjJP/126YxttiBzRvwDmEjEWcQHaQXpUCZpKgQ4joD651Cwu3SxhfYA1jcAldBFo9ML4dX3npmLxH6Ep/sRTIry6aLzRQaFzNGoqYt8MlnRJ4Rlbazp1cXMiWHTLZxnAYm4fd+z7PDzU3jzQzL8SbzB5KPBhKLKKnDglfFVhwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5c/Du2P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5c/Du2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784138461; x=1815674461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zeFNlg+Jqu/extEAPQx7wr3dHGwsr/NGMEnESda69fY=;
  b=a5c/Du2Pov0wUywYO5MBCtsSmO9Y7vNKHh+w3BXVxuTCirNTu4i37p+r
   Yon0TqR2pFDC4zFeJekSnr9s5/zEI0Hau59hS5XFcjIWWNyp7MhPhftHM
   Mmk/l1t3TgaWLg+c96AF333+bM3F6U1H/xB1fbPbeLQJnyBOHtwzKE6yB
   TAhv1JFVEHj1+obhhYN1ctnhIH8ttRJxAOr81htnGrUdjUwZDxiUDQ9bx
   Omh6X+6JIu0+/YBuy7yyp70E+lhudcAhUpW+EY9afNVDnc2JeZb84WBYd
   sv+C1538Hf+9C6C+p/ibZ8LyoTyMuSq+BN6EHqnNR+oEBsq+XD5uLPmEi
   A==;
X-CSE-ConnectionGUID: IK3FNUgATbqpa58vRau6zg==
X-CSE-MsgGUID: X/NTY6UzR5mxQ3gEmvh79w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110336706"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="110336706"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:00:53 -0700
X-CSE-ConnectionGUID: EX+mOqeZSxacuPIFyEx1Sg==
X-CSE-MsgGUID: zjglZMh2RgKePTkeG6rsrA==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2026 11:00:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Pavan Kumar Linga <madhu.chittim@intel.com>,
	anthony.l.nguyen@intel.com,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Bharath R <bharath.r@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v5 03/15] libeth: allow to create fill queues without NAPI
Date: Wed, 15 Jul 2026 11:00:28 -0700
Message-ID: <20260715180042.1972010-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

Control queues can utilize libeth_rx fill queues, despite working outside
of NAPI context. The only problem is standard fill queues requiring NAPI
that provides them with the device pointer.

Introduce a way to provide the device directly without using NAPI.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libeth/rx.c | 12 ++++++++----
 include/net/libeth/rx.h                |  4 +++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 62521a1f4ec9..0c1a565a1b3a 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -145,25 +145,29 @@ static bool libeth_rx_page_pool_params_zc(struct libeth_fq *fq,
 /**
  * libeth_rx_fq_create - create a PP with the default libeth settings
  * @fq: buffer queue struct to fill
- * @napi: &napi_struct covering this PP (no usage outside its poll loops)
+ * @napi_dev: &napi_struct for NAPI (data) queues, &device for others
  *
  * Return: %0 on success, -%errno on failure.
  */
-int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
+int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev)
 {
+	struct napi_struct *napi = fq->no_napi ? NULL : napi_dev;
 	struct page_pool_params pp = {
 		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order		= LIBETH_RX_PAGE_ORDER,
 		.pool_size	= fq->count,
 		.nid		= fq->nid,
-		.dev		= napi->dev->dev.parent,
-		.netdev		= napi->dev,
+		.dev		= napi ? napi->dev->dev.parent : napi_dev,
+		.netdev		= napi ? napi->dev : NULL,
 		.napi		= napi,
 	};
 	struct libeth_fqe *fqes;
 	struct page_pool *pool;
 	int ret;
 
+	if (!pp.netdev && fq->type == LIBETH_FQE_MTU)
+		return -EINVAL;
+
 	pp.dma_dir = fq->xdp ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
 
 	if (!fq->hsplit)
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 5d991404845e..0e736846c5e8 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -69,6 +69,7 @@ enum libeth_fqe_type {
  * @type: type of the buffers this queue has
  * @hsplit: flag whether header split is enabled
  * @xdp: flag indicating whether XDP is enabled
+ * @no_napi: the queue is not a data queue and does not have NAPI
  * @buf_len: HW-writeable length per each buffer
  * @nid: ID of the closest NUMA node with memory
  */
@@ -85,12 +86,13 @@ struct libeth_fq {
 	enum libeth_fqe_type	type:2;
 	bool			hsplit:1;
 	bool			xdp:1;
+	bool			no_napi:1;
 
 	u32			buf_len;
 	int			nid;
 };
 
-int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi);
+int libeth_rx_fq_create(struct libeth_fq *fq, void *napi_dev);
 void libeth_rx_fq_destroy(struct libeth_fq *fq);
 
 /**
-- 
2.47.1

