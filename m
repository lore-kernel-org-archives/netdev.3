Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368433B969
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912770; cv=none; b=rPL7GPnLNQvO0Vxj7qJwhd6Lwtge91adjYx1a8FHyEHZi09Z+riH7vnLQyWe51BL7hiUe3qXaJc1ZlZppAASNyA7DKOLi7coFrT1XDVt5rslW+6CwOsEfZV3dK+t60WMeLk0f2B6a0JTu9Y/y/QdPm2eLVd54XH0BCNKEWU+99A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912770; c=relaxed/simple;
	bh=90eCmkEG/d5TI30h2nPIxISh8h8cZaee4fj2PZ/S3gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5o3vdOTGAVlZllXKy84DP6XrNJRks3AIzPumd5EKpN5tOlVaOcmkmqxgnqu6NMjDbWaym22FFMO+5qkfZVZQfJbY55OiGYBi2XUrrWYDEtACOkEpk434OTfIJGXxupNPMEOYARXd/G+wnr8siFc2hxhay9Z72lr5CmdjuiokME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uU/cwCdx; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uU/cwCdx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785912766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/O7EIpvPJh0KavpSXy2BJiApWgFpKpIfXSkU1S5aVq4=;
	b=uU/cwCdx9Yab375Iv3gcCcSxFyQnreSlGIGzoAOGcnTiekw1A5KzucgEjcIhYh0LhShauW
	nn/wmUmBrZFBYwcBn5WGsx65W4cJL9wWiivSy2mfjRErqQJvHHseSgMlxM21zv8OPjI+WW
	ehASGRdb7rQDKIjS9qQftPhcFoazQQE=
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org
Cc: vadim.fedorenko@linux.dev,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	piotr.kwapulinski@intel.com,
	arkadiusz.kubalewski@intel.com,
	aleksandr.loktionov@intel.com,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH iwl-net v2 3/5] i40e: synchronize reset recovery with device removal
Date: Wed,  5 Aug 2026 14:51:30 +0800
Message-ID: <20260805065132.148625-4-xuanqiang.luo@linux.dev>
In-Reply-To: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
References: <20260805065132.148625-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

i40e_remove() currently tears down PTP and device resources before
claiming RESET_RECOVERY_PENDING. A service task can pass its initial state
check before removal starts and continue into reset recovery after the
remove path has begun teardown. This can make i40e_reset_and_rebuild()
access or recreate resources that are being released.

Stop the service timer and disable the service work before claiming reset
ownership. disable_work_sync() drains the current service task and rejects
later queue_work() attempts, including those from interrupts. Claim the
reset bit before starting teardown so an existing reset owner completes
first.

Fixes: 6533e558c650 ("i40e: Fix reset path while removing the driver")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 28 ++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8c28788ac634f..5922f83f324ae 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16159,6 +16159,20 @@ static void i40e_remove(struct pci_dev *pdev)
 
 	i40e_devlink_unregister(pf);
 
+	/* Interrupts can queue the service task until __I40E_DOWN is set.
+	 * Disable it so no service work can outlive the PF.
+	 */
+	set_bit(__I40E_SUSPENDED, pf->state);
+	if (pf->service_timer.function)
+		timer_shutdown_sync(&pf->service_timer);
+	if (pf->service_task.func)
+		disable_work_sync(&pf->service_task);
+
+	/* Wait for any reset owner before tearing down device resources. */
+	while (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
+		usleep_range(1000, 2000);
+	set_bit(__I40E_IN_REMOVE, pf->state);
+
 	i40e_dbg_pf_exit(pf);
 
 	i40e_ptp_stop(pf);
@@ -16167,26 +16181,12 @@ static void i40e_remove(struct pci_dev *pdev)
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), 0);
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
 
-	/* Grab __I40E_RESET_RECOVERY_PENDING and set __I40E_IN_REMOVE
-	 * flags, once they are set, i40e_rebuild should not be called as
-	 * i40e_prep_for_reset always returns early.
-	 */
-	while (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
-		usleep_range(1000, 2000);
-	set_bit(__I40E_IN_REMOVE, pf->state);
-
 	if (test_bit(I40E_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(__I40E_VF_RESETS_DISABLED, pf->state);
 		i40e_free_vfs(pf);
 		clear_bit(I40E_FLAG_SRIOV_ENA, pf->flags);
 	}
-	/* no more scheduling of any task */
-	set_bit(__I40E_SUSPENDED, pf->state);
 	set_bit(__I40E_DOWN, pf->state);
-	if (pf->service_timer.function)
-		timer_shutdown_sync(&pf->service_timer);
-	if (pf->service_task.func)
-		cancel_work_sync(&pf->service_task);
 
 	if (test_bit(__I40E_RECOVERY_MODE, pf->state)) {
 		struct i40e_vsi *vsi = pf->vsi[0];
-- 
2.43.0

