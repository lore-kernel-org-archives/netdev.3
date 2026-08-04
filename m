Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414CD3FFAC0;
	Tue,  4 Aug 2026 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813407; cv=none; b=hgQScJTgyBGRXh/5ZBSX6thlZ0VcxdzDXwUQ7bmoC6D19bHq7JQeG71jLaQcpJhQtVIdR9pOr+mQgL4ihnFVDgY2KtFhFMGU+IMcbw798fFyFixW25rV6GNf0EhyEJ30x/S2wlLD7KGc0LojuL27B7waop62HmSNqMqT/kNS2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813407; c=relaxed/simple;
	bh=zeFNlg+Jqu/extEAPQx7wr3dHGwsr/NGMEnESda69fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWnxLRWeEsEABXt+Qs3x7uIzzxKYPPR72NEavqz3nQStCJXuCVNDkxsw6jxDVOqXkWdVR6/7j+t2KjQPseit1Br5bl5TCZ5FMmXo8zkFD/AwLi0g1LC1w87NJU4I6ogVXNiwPJoMUdT1XhgYpHlGGLNL6qG84YG+tjU4I0NnC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hy0Ap3WL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hy0Ap3WL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785813406; x=1817349406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zeFNlg+Jqu/extEAPQx7wr3dHGwsr/NGMEnESda69fY=;
  b=Hy0Ap3WL6J3ee8Qgp28Fvxelxdl6XAoS9s5QeQe+kfXh8b+aKsoB14e+
   Emmp6kJ2sxw+4Itv0RQlnLBEWiYTtRFsFV2UPD4mEID4dKjHLUwIh5iO1
   /iYLhaw91wCHUd4nKx+oidUO08odgvIrDvHTN+c0AlbYN1dOfrdHvcCxN
   el3aeUbqmz2Mvxv0zDCP8qivRNFDwQcOl1BayTxJqjf8RVQkm8NTbWNGq
   S8zaDVMhLnXqJ+nqK6Gu33sI48ewsXy1g2BrlLGYovDzSmw8jmkfMltmD
   07IXXiAz9gwrQKytyOCw3/6vjqjn86JPfg8sHdCLBMEsijoxj+75FQBZr
   Q==;
X-CSE-ConnectionGUID: IvJojNyNQKOJbVV/h33cHA==
X-CSE-MsgGUID: 9wpNLPNTQLu08q14benCfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86555024"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86555024"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 20:16:43 -0700
X-CSE-ConnectionGUID: s7jgo6/YRRSJSoFHUPlk4g==
X-CSE-MsgGUID: hCm0irnKST2LgeDHuuP27w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="299613746"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Aug 2026 20:16:42 -0700
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
Subject: [PATCH net-next v7 03/15] libeth: allow to create fill queues without NAPI
Date: Mon,  3 Aug 2026 20:16:23 -0700
Message-ID: <20260804031638.1531994-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804031638.1531994-1-anthony.l.nguyen@intel.com>
References: <20260804031638.1531994-1-anthony.l.nguyen@intel.com>
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

