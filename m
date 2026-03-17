Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179903FA5FB;
	Tue, 17 Mar 2026 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788966; cv=none; b=hPSrTKGnbve9zZCMgFwe2eUuy8YDko5GlVOVUxz4OHbeAvASvOlzzPJk9pemwI9ryxuDbNVeZFIP/uGlUb6eq/Sq3LpULj0l/syG2tuERf/JPnzbWl8mjwegRfv7sggqTbPvJ+K8n7w21zX2xl73cYsdnsrS3OXxibzsj28VTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788966; c=relaxed/simple;
	bh=AdQJjUkXDUJ2CI4yvppoHZwCNbuZ27FtIKfIGbCFovY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/qfA3awHjQRM7hls4of2OIASz8YdAnwCOB/HU54MPujKvK/DOhetTr2T/VdJekrbg25K0bgLpAtyjIsnPCenERwoETjvGTnSp3HZTSxAg0s+qx9GKXNVPBTq+b865PJTXOyCJEIg6X+uiwVP9FTC+a+O8XNrpwtWcyrnjEY1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNdRjo9I; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNdRjo9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773788965; x=1805324965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AdQJjUkXDUJ2CI4yvppoHZwCNbuZ27FtIKfIGbCFovY=;
  b=NNdRjo9IWpBZBbFViB6sNPef8ukRufHPORc1tiGUjUq4xlnnlQwr15RE
   3c8deBMnGqI/UIVS7NqrdNnX3Ud80pYjIMwoNZZHppB272FSwySkXxZPz
   4dZTzmVg0NyMvMOoCO9idwwB1TPjiAIHk9TUNAlQ38p01IpOpdwRNlo03
   lDIoifYQxfO6qJ0DDN5yu47t9d3LChZVKNKxx98m+5m1W0neBaP+yY/P2
   ggJoIfjwpSafNp2YeOVRBcAJFWrIUrkROnUufIlj6/ejJHZtbIzQ26uL1
   oUP8hYwNaKJugJ/CWIUXUeflXmvStRysnO46qHdE7A4Y4bZ6HmuZ3SFtX
   w==;
X-CSE-ConnectionGUID: +k+m+YerQfmire6CMwD/hg==
X-CSE-MsgGUID: 2XapjhjDQWS5iWXQD8tskA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74811600"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74811600"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 16:09:21 -0700
X-CSE-ConnectionGUID: TGIt2HMaQ0K504i5WsADLQ==
X-CSE-MsgGUID: kgCDNzD9T1Sno5ZRebmdJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226566383"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2026 16:09:20 -0700
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
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	natalia.wochtman@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Bharath R <bharath.r@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 04/15] libeth: allow to create fill queues without NAPI
Date: Tue, 17 Mar 2026 16:08:52 -0700
Message-ID: <20260317230905.847744-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260317230905.847744-1-anthony.l.nguyen@intel.com>
References: <20260317230905.847744-1-anthony.l.nguyen@intel.com>
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
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libeth/rx.c | 9 +++++----
 include/net/libeth/rx.h                | 4 +++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 62521a1f4ec9..1d8248a31037 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -145,19 +145,20 @@ static bool libeth_rx_page_pool_params_zc(struct libeth_fq *fq,
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

