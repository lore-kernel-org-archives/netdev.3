Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB63D8104;
	Fri,  3 Apr 2026 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245796; cv=none; b=d9txXl8NwotlY13cXlXJ8E1OvucmT/e7dOLF0wZB/h5fbXfz0Y431niCqhz7CBNtgAKu2NtZERApj6v8npMZFaByn1XsIs1TrKl2Nxgk4qZqHoPcwZAPFsMRcyuFkJ17gpnHDkfJyMlhD7cogRBUSXzzNl7WBBvDNH48EPGySpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245796; c=relaxed/simple;
	bh=karQgKyTJPH3+C2cJlyeOYlDApnFfq/3MAeWG5hq5TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sInEDNp3Gd6yaLO3pzrDpbBUMKh50Aqz8UU8K89KGCQBN41njgAsKJubkQCrHnMsLFe+AXy+/jUP3JK3CzImurtJaX6/IikDWgNK72O/8njIKcCkB1LzVLT28Z0tc9TjAcXSB6APeGnXqff9AS+WwPG4ckKrDiPYslhEJnNguhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UixXY0E2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UixXY0E2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775245792; x=1806781792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=karQgKyTJPH3+C2cJlyeOYlDApnFfq/3MAeWG5hq5TE=;
  b=UixXY0E2w1liMYErPu8+XYHiv7GpE4AjNw2KI3ALvv/jH+MCuhkyhsSf
   LFL4oJY8RLJTMSXkORWUQ8yH0H7hlU3fJkvdemGTkWLjmatjI+c0o7N0E
   tbtr/oFTyBnbsSiQwWzvc9pRg7xcD1aihduTpetQQIh6oZxS8WdUQhX1z
   lZWRrIv2bG+UfTdHRbzlOFedYLM3UmsLgJhITl//lrTLCsPuImYpKvYJO
   MuflzmeUpjlShKpg5jpfS4N3slZefiB2jOgG46rBj2yca9YcArIYBccL3
   gM1BpA6VUGqFkXsv2GTx+HEn1Sf8mG3sjtgrM9Osqy+wqKtWshDz19nrq
   A==;
X-CSE-ConnectionGUID: paKnJPNtQFqkRIxRLpn5QA==
X-CSE-MsgGUID: HBgOyAatQ+i6BmTkyglttQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76428821"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76428821"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:49:46 -0700
X-CSE-ConnectionGUID: T94vgxOjT+ybrwoBhY+aFg==
X-CSE-MsgGUID: eRWF6/pATmKSVn3TDLW6BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="265266137"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2026 12:49:45 -0700
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
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 09/14] idpf: make mbx_task queueing and cancelling more consistent
Date: Fri,  3 Apr 2026 12:49:31 -0700
Message-ID: <20260403194938.3577011-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          | 1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c      | 9 ++++-----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 6 +++++-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 679539a1b947..1d0e32e47e87 100644
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
index 47eb8b521755..412159bb6259 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2974,6 +2974,8 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
 	adapter->xnm = params.xnm;
 	adapter->state = __IDPF_VER_CHECK;
 
+	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
+
 	return 0;
 }
 
@@ -2983,6 +2985,9 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
  */
 void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter)
 {
+	idpf_mb_intr_rel_irq(adapter);
+	cancel_delayed_work_sync(&adapter->mbx_task);
+
 	if (adapter->arq && adapter->asq) {
 		idpf_mb_clean(adapter, adapter->asq, true);
 		libie_ctlq_xn_deinit(adapter->xnm, &adapter->ctlq_ctx);
@@ -3237,7 +3242,6 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 		idpf_deinit_dflt_mbx(adapter);
 
 	cancel_delayed_work_sync(&adapter->serv_task);
-	cancel_delayed_work_sync(&adapter->mbx_task);
 
 	idpf_vport_params_buf_rel(adapter);
 
-- 
2.47.1

