Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3459D626
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892338; cv=none; b=th9R859pEoLe5SfLJC4x/bDVZy//sOSvELAbRszxDmRdoHqwwX49//StlvlkE8T3t6Bhe3upX3N6mlA+h8bWKAREpb6x8E9V1OIiiKuw1zK97FDINReX6n8tjG2PDcgLmZQ2NpkXouIofUo91+OJ8co05LDnZnOpESTx8iMnGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892338; c=relaxed/simple;
	bh=l98TkAgeRUcUVIdXQumhCofyR0H2mlGjy0nRUh6qV0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZJQSClt38bzHvl3z+thmW5K8T5tZoceZ6mWFPb0Kv9JNp+xPYpjq8GP34HIfZCUoD/QfJ0Ah9Gmdttb25HnAVUDIz30tBFcTQrqR+M1Ibm93MMWY/Oh3YuM8VGsSm5E/PUPWtu4IGedbQ9LD7XfHo88Dn/Ol9j0YELHG6bI4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edQlpvki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edQlpvki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE071F00A3A;
	Tue,  8 Sep 2026 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892337;
	bh=nAlSDVQ2myqePZnyqmMiMzeXJ5hT0zXso8AsNDRd2xo=;
	h=From:To:Cc:Subject:Date;
	b=edQlpvkidMbMD92TqSeZ0U+XWyAJdnbMJlqSKLXeqZqc48Lr1GB709pakzqClYzoh
	 /vdJDMPCZzrZTcHpOr7U70PDeECfxhMDgQpdJu4lWo17wMOl0iwXBbZXvwb3O0+N0x
	 fpTJSfk+uskqFhQIqosEyI1+QAQTpd4OrriJ7Wg7/wBhQeVkqQH5uxq4tJFlmI6yJo
	 I3kS5ayMeGH/3ebHQEGcQcg17Lxm5mFA6Kpup0p6LtYyg908WBG2up/zw6D7kCpFLh
	 Zlq1W2cwB8JjxNV95PIvnMxfZML+emQNhI2zKh/F0ZhumIrxt5doOi6khZfuh1lZEF
	 jGrTuqnY4u89Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Subject: [PATCH iwl-next] eth: i40e: sync MAC filters before restarting queues after a reset
Date: Tue,  8 Sep 2026 11:32:14 -0700
Message-ID: <20260908183214.1367355-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A PF reset clears the VSI's MAC/VLAN filter table. i40e_add_vsi() only
re-marks the software filters as I40E_FILTER_NEW and lets async
i40e_sync_filters_subtask() in the service task program them.

That works for resets driven by the service task, which reruns
i40e_sync_filters_subtask() right after i40e_reset_subtask(). Synchronous
callers - i40e_xdp_setup(), the ethtool private flag and ring paths,
i40e_setup_tc() - return to user space with the rings running and
the carrier up, but no unicast filter and no broadcast promiscuous bit,
so the interface drops all Rx.

i40e_rebuild() does reach i40e_service_event_schedule():

 i40e_rebuild()
 └─ i40e_pf_unquiesce_all_vsi(pf)          (for each VSI on the PF)
    └─ i40e_unquiesce_vsi(vsi)             (only if __I40E_VSI_NEEDS_RESTART set)
       └─ ndo_open(vsi->netdev)            (netdev && netif_running())
          └─ i40e_open()
             └─ i40e_vsi_open()
                └─ i40e_up_complete()
                   └─ i40e_service_event_schedule()

but __I40E_RESET_RECOVERY_PENDING is still set at that point,
which makes it a noop, so the filters are restored during next
periodic run (1 sec later).

This causes ~20% failure rate in XDP sub-tests in NIPA (meaning
that the full test is almost never fully clean). After the fix
I run the test 6 times in a row without a failure.

Push the main VSI's filters to the HW before the queues restart, and kick
the service task once the reset state is clear to pick up what the
rebuild deferred.

No Fixes tag, this only matters to workloads which reconfigure the device
and immediately expect traffic, i.e. CI rather than anything real.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: anthony.l.nguyen@intel.com
CC: przemyslaw.kitszel@intel.com
CC: john.fastabend@gmail.com
CC: sdf@fomichev.me
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abbc71e815ae..9215bcaecc4b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11084,6 +11084,11 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	i40e_add_filter_to_drop_tx_flow_control_frames(&pf->hw,
 						       pf->main_vsi_seid);
 
+	/* Reprogram the filters the reset cleared before the queues start.
+	 * Avoid the wait for the service task, best effort.
+	 */
+	i40e_sync_vsi_filters(vsi);
+
 	/* restart the VSIs that were rebuilt and running before the reset */
 	i40e_pf_unquiesce_all_vsi(pf);
 
@@ -11115,6 +11120,11 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 clear_recovery:
 	clear_bit(__I40E_RESET_RECOVERY_PENDING, pf->state);
 	clear_bit(__I40E_TIMEOUT_RECOVERY_PENDING, pf->state);
+
+	/* i40e_service_event_schedule() may have been called with
+	 * the RESET bits still set, requeue now that we cleared them.
+	 */
+	i40e_service_event_schedule(pf);
 }
 
 /**
-- 
2.55.0

