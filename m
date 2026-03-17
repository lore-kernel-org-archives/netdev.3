Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E13FB058;
	Tue, 17 Mar 2026 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788969; cv=none; b=Gj0wAUd/mY1MsVgj7ewHExz78CkfsxnUyHlC1m+sRCz+67hIe7DGob+Cer7MJ1Tldk2833EPVQyvEqcK2uSnUJs/4oTqT6IcyUe+OLsGx6wWG7LUKHtX3apFepHqjckqgw5QKX3uFQbzURRB4SJ9avYgwjfRZ7Zj6IV9EpSmaoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788969; c=relaxed/simple;
	bh=3/Wk5e+gQZ6aEqChW6tJBqin5gpf+uc+Sfo6UA2XTfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZAE6/1oVsABkoCXGcLaZ9+71O8pvBmV/2DewN6ql3C9eKjGD9oahV2HaPP4v31wgHIIpPczG3IkzWNPRP8uNBB81Lx24/BsccBiY6kJBR5F4wOAc3cAfq30tfE9CP78H6yjkDqhVj4NbkNuEHB0F5mReJZDAKFeKZWdB4Zdj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHSRWdmi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHSRWdmi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773788968; x=1805324968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3/Wk5e+gQZ6aEqChW6tJBqin5gpf+uc+Sfo6UA2XTfk=;
  b=nHSRWdmi0ZhntQNgHNWSr8yD7+y5QmQ2BWUMBJLzjAydEQhpDA/swN/T
   Xhy88BZvHXzzaVXN5Nuz4XPK//BtGjSN6JWUjRf3WuPbBdYwCoDX9cveX
   S7fNCHgj9Z626c2B4q0AyaLrzh+5njCzxUxeBMJrgtd8Sk7l97vErNvAk
   O8LQmJrmWN9V5UayXkinOQE3CfSTfeM+q9hhJZ4ewh4EX7zBNf6c9THlr
   MnU2pfZ6OIEl5FbRL9i+eJfHPkvhEkiiLAnuy92y0cpEouDc4vE7f+K4N
   DPyDAlmdqykaSGh8n2Vhisq9iVJvJVHsVCrmkWazshPv/Db0ZSBDX85Fj
   Q==;
X-CSE-ConnectionGUID: Zyh0NUJ/SaaMHzGUXtiybA==
X-CSE-MsgGUID: 1LPWz7uwQkuobuvm57+k9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74811656"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74811656"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 16:09:24 -0700
X-CSE-ConnectionGUID: Ajo/pFz/RNulC7zb+EBzYw==
X-CSE-MsgGUID: Kkfwgr0NS+arvWEMDQt7eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226566405"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2026 16:09:22 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	natalia.wochtman@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next 10/15] idpf: make mbx_task queueing and cancelling more consistent
Date: Tue, 17 Mar 2026 16:08:58 -0700
Message-ID: <20260317230905.847744-11-anthony.l.nguyen@intel.com>
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

From: Larysa Zaremba <larysa.zaremba@intel.com>

As a consequence of refactoring idpf code to use libeth APIs,
idpf_vc_xn_shutdown was merged with and replaced by idpf_deinit_dflt_mbx.
This does not affect the Tx path, as it checked for a presence of an xn
manager anyway. Rx processing is handled by the mbx_task that is not always
cancelled before calling the new consolidated mailbox deinit function.
Moreover, in the reset path idpf_intr_rel() reschedules it after the deinit
is done. This leads to mbx_task referencing the freed mailbox and causing
KASAN warnings.

To remedy this, in the init path, do the first queueing of mbx_task in
idpf_init_dflt_mbx(), in deinit and reset, always cancel the task in
idpf_deinit_dflt_mbx() and in every flow first call idpf_mb_intr_rel_irq().

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          | 1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c      | 9 ++++-----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 6 +++++-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index b06640925fb9..9606c0de018f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -984,6 +984,7 @@ void idpf_vc_event_task(struct work_struct *work);
 void idpf_dev_ops_init(struct idpf_adapter *adapter);
 void idpf_vf_dev_ops_init(struct idpf_adapter *adapter);
 int idpf_intr_req(struct idpf_adapter *adapter);
+void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter);
 void idpf_intr_rel(struct idpf_adapter *adapter);
 u16 idpf_get_max_tx_hdr_size(struct idpf_adapter *adapter);
 int idpf_initiate_soft_reset(struct idpf_vport *vport,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 0d131bf0993e..7988836fbae0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -68,9 +68,11 @@ static void idpf_deinit_vector_stack(struct idpf_adapter *adapter)
  * This will also disable interrupt mode and queue up mailbox task. Mailbox
  * task will reschedule itself if not in interrupt mode.
  */
-static void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
+void idpf_mb_intr_rel_irq(struct idpf_adapter *adapter)
 {
-	clear_bit(IDPF_MB_INTR_MODE, adapter->flags);
+	if (!test_and_clear_bit(IDPF_MB_INTR_MODE, adapter->flags))
+		return;
+
 	kfree(free_irq(adapter->msix_entries[0].vector, adapter));
 	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
 }
@@ -1938,14 +1940,11 @@ static void idpf_init_hard_reset(struct idpf_adapter *adapter)
 		goto unlock_mutex;
 	}
 
-	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
-
 	/* Initialize the state machine, also allocate memory and request
 	 * resources
 	 */
 	err = idpf_vc_core_init(adapter);
 	if (err) {
-		cancel_delayed_work_sync(&adapter->mbx_task);
 		idpf_deinit_dflt_mbx(adapter);
 		goto unlock_mutex;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index c5aa54903cd2..6f5be8cee5fb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2946,6 +2946,8 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
 	adapter->xnm = params.xnm;
 	adapter->state = __IDPF_VER_CHECK;
 
+	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
+
 	return 0;
 }
 
@@ -2955,6 +2957,9 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
  */
 void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter)
 {
+	idpf_mb_intr_rel_irq(adapter);
+	cancel_delayed_work_sync(&adapter->mbx_task);
+
 	if (adapter->arq && adapter->asq) {
 		idpf_mb_clean(adapter, adapter->asq, true);
 		libie_ctlq_xn_deinit(adapter->xnm, &adapter->ctlq_ctx);
@@ -3209,7 +3214,6 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 		idpf_deinit_dflt_mbx(adapter);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
-	cancel_delayed_work_sync(&adapter->mbx_task);
 
 	idpf_vport_params_buf_rel(adapter);
 
-- 
2.47.1

