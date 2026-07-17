Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4C390C9A
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314435; cv=none; b=JfKHgAxoIMvq7Sa2axlwIxUMzNl/wzBLJnL3qXkcvLBn9zwot2//EgmfAnoiq8yKuky/E3T/ewT+GGMExqr2H5XdOPKXcNhkbqOpw4+Kp0zMvOH72nTSfPO/Izjm+B7kUVDq76H1q8k1cP5GtbMHMYBGLkvVPMpli3SIBOQuymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314435; c=relaxed/simple;
	bh=DmNH0RNZQVGoqO1TYtQNEdlqxMRLhvhILwcKh/VKmRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G26Pe1PUjWewFeZTsn1wJDvUua2KY7B6xRCOyaW52nkSyhMDu6M+S+RZhSqOnsdwzVneoKyrz/j9FpETAbTh2V5fJtFB1B8XrJw1Qb03rD2O/o9CDBYD3sWuV8qKTTYqzWhN7Viu0M+7Swj6cAhIBURLccB3bPUsNh23Vhl/wkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FONirCaD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FONirCaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784314434; x=1815850434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DmNH0RNZQVGoqO1TYtQNEdlqxMRLhvhILwcKh/VKmRU=;
  b=FONirCaDjITtGq/nEPqCI0YhRIBOFI3Ye+SoJNkq1Yc5v2PCQubF5ZHi
   vnrA3VtY1srKxMUt7okW/adCf5b+ARs5hrxQl65rORRCE1qNJKJ5zMwXr
   4W56Q3d3VaAyOjg3nFykyVI4q24D1fxRY0E8URNkRUNlSRRUuJb66leTa
   gWnYrEch+qi1MP9gdMfqi7kEPCTuOp3foABAc6z38l1tJEcelvU1Enjjt
   b2OWezXzcQ1qTU1mGBRRvbVTcwu6LICWCmxuq4jwjSkQ9wi768J6W0nuF
   2WClCZ70bYdbCl0oMGjKgRNCdr/EQpw+boAm+/8OI6W3objtw1+Rv0H0g
   Q==;
X-CSE-ConnectionGUID: LOIgEd9KQTqnVsj9PwM7DQ==
X-CSE-MsgGUID: uVJ2EFr2SHeooqbGw4SegQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95347659"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95347659"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:53:50 -0700
X-CSE-ConnectionGUID: gwSXJwIPTVmzSXBRjbSARw==
X-CSE-MsgGUID: N0FB3pFDQQunLMsbrTvmQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261827263"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jul 2026 11:53:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 12/13] idpf: fix max_vport related crash on allocation error during init
Date: Fri, 17 Jul 2026 11:53:34 -0700
Message-ID: <20260717185340.3595286-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Set adapter->max_vports only after successful allocation of vports, netdevs
and  vport_config buffers. This fixes possible crashes on reset or rmmod,
following failed allocation on init

[  305.981402] idpf 0000:83:00.0: enabling device (0100 -> 0102)
[  305.994464] idpf 0000:83:00.0: Device HW Reset initiated
[  320.416872] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  320.416918] #PF: supervisor read access in kernel mode
[  320.416942] #PF: error_code(0x0000) - not-present page
[  320.416963] PGD 2099657067 P4D 0
[  320.416983] Oops: Oops: 0000 [#1] SMP NOPTI
...
[  320.417093] RIP: 0010:idpf_remove+0x118/0x200 [idpf]
[  320.417130] Code: 8b bb 98 09 00 00 e8 17 0f 5b e5 48 8b bb e8 08 00 00 e8 0b 0f 5b e5 66 83 bb 28 06 00 00 00 48 8b bb 20 06 00 00 74 49 31 ed <48> 8b 04 ef 48 85 c0 74 2f 48 8b 78 20 e8 66 58 91 e5 48 8b 83 20
[  320.417183] RSP: 0018:ff7322212903fdb8 EFLAGS: 00010246
[  320.417205] RAX: 0000000000000000 RBX: ff4463de40300000 RCX: ff7322212903fd4c
[  320.417228] RDX: 0000000000000001 RSI: ffffffffa7f7d100 RDI: 0000000000000000
[  320.417250] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[  320.417272] R10: 0000000000000001 R11: ff4463de3a638f58 R12: ff4463be89ac7000
[  320.417294] R13: ff4463be89ac7198 R14: ff4463be94fc7198 R15: ffffffffc0f10f20
[  320.417317] FS:  00007f963c0e6740(0000) GS:ff4463fdd65d8000(0000) knlGS:0000000000000000
[  320.417342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  320.417362] CR2: 0000000000000000 CR3: 00000020ba674002 CR4: 0000000000773ef0
[  320.417385] PKRU: 55555554
[  320.417398] Call Trace:
[  320.417412]  <TASK>
[  320.417429]  pci_device_remove+0x42/0xb0
[  320.417459]  device_release_driver_internal+0x1a9/0x210
[  320.417492]  driver_detach+0x4b/0x90
[  320.417516]  bus_remove_driver+0x70/0x100
[  320.417539]  pci_unregister_driver+0x2e/0xb0
[  320.417564]  __do_sys_delete_module.constprop.0+0x190/0x2f0
[  320.417592]  ? kmem_cache_free+0x31e/0x550
[  320.417619]  ? lockdep_hardirqs_on_prepare+0xde/0x190
[  320.417644]  ? do_syscall_64+0x38/0x6b0
[  320.417665]  do_syscall_64+0xc8/0x6b0
[  320.417683]  ? clear_bhb_loop+0x30/0x80
[  320.417706]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  320.417727] RIP: 0033:0x7f963bb30beb

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index be66f9b2e101..dc5ad784f456 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3555,7 +3555,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 
 	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
 	num_max_vports = idpf_get_max_vports(adapter);
-	adapter->max_vports = num_max_vports;
 	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);
 	if (!adapter->vports)
 		return -ENOMEM;
@@ -3576,6 +3575,12 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		goto err_netdev_alloc;
 	}
 
+	/* Set max_vports only after vports, netdevs and vport_config buffers
+	 * are allocated to make sure max_vport bound loops don't end up
+	 * crashing, following allocation errors on init.
+	 */
+	adapter->max_vports = num_max_vports;
+
 	/* Start the mailbox task before requesting vectors. This will ensure
 	 * vector information response from mailbox is handled
 	 */
-- 
2.47.1

