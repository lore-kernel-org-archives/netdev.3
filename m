Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609723CB570;
	Wed, 15 Jul 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138480; cv=none; b=mAgP67nGCogFfiTq8IDCInLu6/lET6ZiF1U3dwpgp2NIR9dSErCWW8mxomvoVGR6+dOMfJrwQ349J6Ij1UteCtUjCCoHMKypdQxiSNROos9DZy+WDJdQXoaLqIQTQJHKvwpSmgs5QUoDll6ZEdGe0IrljQkpzRy+46UX3p1ANio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138480; c=relaxed/simple;
	bh=NmpWfgrsNxsEPkJOY3hk6CKZn3+0rSzRmsChJcXrN04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mob1LyErcyoHdJ+354DNo/RnDHkVjiBm6MFKV07fKHkZrAdCEyYNkL9V6x3ydmLgUGw3fpXJYqdgODpej2blRPpD6laqDcu9HyduqWbSZBpAkKUGXXcCoLKHLU21SLIqfrVVMB1fohJbYwEKpgmmKov9A20c6R1/FRJaHcMgcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRYdG4H5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRYdG4H5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784138475; x=1815674475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NmpWfgrsNxsEPkJOY3hk6CKZn3+0rSzRmsChJcXrN04=;
  b=aRYdG4H5Y50XH1BrzyJaKneNbR4cOrksfn/TgS/Zk2l3ocN3lUgam+GX
   7QgKkDjTd1KHMfMwudsOXkVAOjFn+CaAK9WL11/BNOn+4VPjn4G50nIvK
   bRSoXBWaxau6OixMAiR6ZYiXdelcdo3hoSMd1TE0EtLwUmTav60R/lN2C
   xXkhS8Zq/jG6Id1vTpwOQ1J6tO8JDYYIfgIL8OTLcxOIqYsMKydArzoak
   nyLzGRSHGTAk9kfCyr2mtFZsOb1vp8mb8Wu1Mhs/Uadj8EsNCrCmpxgRG
   Zlgzy6pEH6W+zcAN9WgGRPJ+rtaTONThqIgRQh+JFxxAeX0zBKZr2P/dC
   Q==;
X-CSE-ConnectionGUID: yMxdfJJnQlqtD8trLPquyQ==
X-CSE-MsgGUID: YCVpHwxFQ4mkCNNpldPqgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110336798"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="110336798"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:01:00 -0700
X-CSE-ConnectionGUID: syA8dRK9Q2O1J5+QcpX9gg==
X-CSE-MsgGUID: ZgDW5BXMQlScGjYeaA3qtg==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2026 11:00:59 -0700
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
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v5 10/15] idpf: make mbx_task queueing and cancelling more consistent
Date: Wed, 15 Jul 2026 11:00:35 -0700
Message-ID: <20260715180042.1972010-11-anthony.l.nguyen@intel.com>
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

From: Larysa Zaremba <larysa.zaremba@intel.com>

One of the assumptions of libie_cp and pre-refactor idpf control queue
handling is such that all Rx processing is handled by a single task, which
is to be cancelled before the mailbox destruction. Aside from cancelling,
it is also important to make sure that idpf_intr_rel() never reschedules
it afterwards.

In order to comply, in the init path, do the first queueing of mbx_task in
idpf_init_dflt_mbx(), and in deinit and reset, always cancel the task in
idpf_deinit_dflt_mbx(), in every single flow call idpf_mb_intr_rel_irq()
beforehand.

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h          | 1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c      | 9 ++++-----
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index d7d751e2a781..470bc23c844c 100644
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
index 6751534e022b..1c19cd1f9dd1 100644
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
@@ -1939,14 +1941,11 @@ static void idpf_init_hard_reset(struct idpf_adapter *adapter)
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
index 84155d683773..7c166651f90d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2931,6 +2931,8 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
 	adapter->xnm = params.xnm;
 	adapter->state = __IDPF_VER_CHECK;
 
+	queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
+
 	return 0;
 }
 
@@ -2940,6 +2942,9 @@ int idpf_init_dflt_mbx(struct idpf_adapter *adapter)
  */
 void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter)
 {
+	idpf_mb_intr_rel_irq(adapter);
+	cancel_delayed_work_sync(&adapter->mbx_task);
+
 	if (adapter->xnm) {
 		idpf_mb_clean(adapter, adapter->asq, true);
 		libie_ctlq_xn_deinit(adapter->xnm, &adapter->ctlq_ctx);
-- 
2.47.1

