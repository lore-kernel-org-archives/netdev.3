Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F673BC673;
	Wed, 29 Jul 2026 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357923; cv=none; b=WNBxHPdkhIPzoVzJmth/FsPxv3hV0V8uRBEtvjk08ezm+tmvgSI0hPZMEit0oiLx3cxgevpYFmDZHHkWyhTTV++UEQ0Jy1AQMR85SOUp89/CopM1rpsR0zHsQOrmVOU+2T2CrV3WuQKWXTJ0SiH3ih6eIYwYPPvo6zuTkj+TOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357923; c=relaxed/simple;
	bh=zeFNlg+Jqu/extEAPQx7wr3dHGwsr/NGMEnESda69fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TodsbDFZqjeWY9iwiGN2afDrSIxwqclnirOhWUp4oLiCSgvVUWFILioq9F8ufv5s3kX6wTgIX4Jbqrb1J9V+Ozz2DGEX6AhFEXRNu5W1EW3+UnTHpF2EBpBadkMSsOzsqMprlU0qvcAobTMqBShodDUNGle07BZSVwYvxZJ2OnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EK0fuCin; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EK0fuCin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785357919; x=1816893919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zeFNlg+Jqu/extEAPQx7wr3dHGwsr/NGMEnESda69fY=;
  b=EK0fuCinj37zXCH0LffIw90u5G9SQZxsN0bB1nqzjS2dFLPmpci6ZMPV
   j+hSQMXGJ71cJBJGBrgd9xi1DaKmuJH9TE4ELAPO49BwC4dt03Yj++H5F
   WEeMyB4itbk7EOH9MFeTLMGCdWLcNMUYbJIy8bHSRMVb+WIpWqQ0tRdbo
   dvgY6UinEdNcyRzwDsDt7I5XN9Eab1DnPzfVDhGKLNHCRBpndtju1Nhn9
   QpOvc6F8SL7I1npnmx8A3Tp9KGiCw44lAZVMkEYOekeus12COWrQWfnP0
   yWhsndG9oehyLg+XphoE6QkZv5jeo/p6VNp8bNy3/lNcR4tD3JXbjVbzz
   A==;
X-CSE-ConnectionGUID: +OEN393wRCSnTJ+rOMRJww==
X-CSE-MsgGUID: 9fuudN8ST+a//ar4JE+mXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="84952379"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="84952379"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 13:45:09 -0700
X-CSE-ConnectionGUID: FhzweqL1QeuVCp3neZdCMQ==
X-CSE-MsgGUID: mbd9d3iSSg6E4wcMY82dtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="264381333"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 29 Jul 2026 13:45:09 -0700
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
Subject: [PATCH net-next v6 03/15] libeth: allow to create fill queues without NAPI
Date: Wed, 29 Jul 2026 13:44:50 -0700
Message-ID: <20260729204505.3373950-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260729204505.3373950-1-anthony.l.nguyen@intel.com>
References: <20260729204505.3373950-1-anthony.l.nguyen@intel.com>
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

