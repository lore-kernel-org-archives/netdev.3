Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C58417D8D;
	Wed, 15 Jul 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138490; cv=none; b=nU+yboFvBHBG9iHoQdlPBMKJZXIw3h5EAgwsv2A6QNzom0fkrQi50Z7uBF/7h6gfiq9LLiy9FWZVNZIqQdegTO5znqEKMWkShFaPQBv+iskiWCkxjlOD7NIVFXnFa9/86/GjbaPy5/M99OpRZypDnMkOp38RNgXxBx329/harVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138490; c=relaxed/simple;
	bh=/O8sPeIjC2jiVZL0U+vcxTIFh6WzUEMPkP7Sl6RlPd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4+818ci4NS9dNeHHgLmh2/Ew1prxeW1og7VY/Q5Toc4+mlgqritNeWIRSEUsy+7s9zfgsipIBqpQY0S/bCDK2OW7+dUTz0tuFng5P2ZFLUsd0PHC4SqMOWmjiQcb8OY+UPXk63IO0zM08ZNQafMTPPsP4i60skFVBOP/gNGPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ww8wD8f4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ww8wD8f4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784138485; x=1815674485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/O8sPeIjC2jiVZL0U+vcxTIFh6WzUEMPkP7Sl6RlPd8=;
  b=Ww8wD8f4hqVlYYAr+XeQCqp9z3Qeyiv5uH5AqP5t8zHXafAhWLjVWyp6
   2D7NMeq1Tc8024YQd+FHTk8T7NSAMds4ir87HEFgXn4WY4f+hljkRHBxr
   1KKAm6Wo4K3KM6PB6opcw7BLSvAn0aEQb0+9FuVcc4r9XguawujOvTiyY
   +G1trvBp22rAbXSSk8s+zwXk4gfyHKOsCrKtkLqp1T4Asqa0BImHUBUgL
   46kKqry9DnsUoJrDaUC9XYmb6WTLKv2M0LkteuuNoJFfIvJ3cfFzglIhi
   h6eGKWXpsBUETczT8irRn3dw6n79HCc9K8lM4YiobVkD5vb4SJTz9ORHW
   w==;
X-CSE-ConnectionGUID: g0F7oWNHScemJyXDi4af4A==
X-CSE-MsgGUID: qKJxz+p+QMmfbiNXLo0HtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110336814"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="110336814"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:01:01 -0700
X-CSE-ConnectionGUID: 0ska0FDrQuyuSX6ubh8zlw==
X-CSE-MsgGUID: OA5AlYz0RUmdU1kC2EvukQ==
X-ExtLoop1: 1
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jul 2026 11:01:00 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v5 11/15] idpf: print a debug message and bail in case of non-event ctlq message
Date: Wed, 15 Jul 2026 11:00:36 -0700
Message-ID: <20260715180042.1972010-12-anthony.l.nguyen@intel.com>
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

Unlike previous internal idpf ctlq implementation, idpf calls the default
message handler for all received messages that do not have a matching xn
transaction, not only for VIRTCHNL2_OP_EVENT. This leads to many error
messages printing garbage, because the parsing expected a valid event
message, but got e.g. a delayed response for a timed-out transaction.

The information about timed-out transactions and otherwise unhandleable
messages can still be valuable for developers, so print the information
with dynamic debug and exit the function, so the following functions can
parse valid events in peace.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 7c166651f90d..13f38d03411a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -84,6 +84,13 @@ void idpf_recv_event_msg(struct libie_ctlq_ctx *ctx,
 	u32 event;
 
 	adapter = container_of(ctx, struct idpf_adapter, ctlq_ctx);
+	if (ctlq_msg->chnl_opcode != VIRTCHNL2_OP_EVENT) {
+		dev_dbg(&adapter->pdev->dev,
+			"Unhandled message with opcode %u from CP\n",
+			ctlq_msg->chnl_opcode);
+		goto free_rx_buf;
+	}
+
 	if (payload_size < sizeof(*v2e)) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Failed to receive valid payload for event msg (op %d len %d)\n",
 				    ctlq_msg->chnl_opcode,
-- 
2.47.1

