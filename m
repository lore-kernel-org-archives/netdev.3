Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD6241BA82;
	Wed, 29 Jul 2026 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357939; cv=none; b=ilSY519hWB9r3UAnrFArryV2PZz719TWzOqEXzjTr8zhcAKGYmTHBbKm3zPuFxK5IMtzb2zy3eHkeqIlsCyM4AYDmS+ZZOCILnCuMCrC4dICioMZv28y7M93iCyVFBZi8wZlnizW/3B+Xaz4wHOcOLPTbbl5NC+dVFg/5oopXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357939; c=relaxed/simple;
	bh=LKFDQYbD9Z5okZZpghlpf8fyTYfQP5dMsl6q3XvXt/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAy74P4m6AA2pLlYiDA2LLVhUVeXTbkuJr3fsikB21p/B9rbtH5edNtsbrSdz5+amjhczgZLgP3nIbbPVsB8GyNpINY0J2euBEdaOdSUNWWd0mZuBdNAe0mtFQ4PEUqonLDnevnTmXn8hxbjOhqV3/PzBOFrNWMbSXQDIP+e570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nzbz+ntv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nzbz+ntv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785357935; x=1816893935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKFDQYbD9Z5okZZpghlpf8fyTYfQP5dMsl6q3XvXt/g=;
  b=Nzbz+ntvQHZHUbBL7o4UprwE7BwLczTCBNkdLkzH9p3hNVHhiLptyag/
   LqlKG/i1G7ZfuaNUFyy4tvi83Arhfsho+iW1pw0xe/nv+w+otTQHJGrmB
   GVyAE5SfHvl4ZEZbT1KgFr3SnW5gC+4mjmFlsQ4k2s4f64tBEN252/5Zp
   WLWcg/SCFmmn7Dt+xktw5fcmci2ZNKKbi43Ja/5R+q7UpfQn3318dWlH8
   zcDtx3+G2ENl4lDF+Hc6Xta+teDM2B2gEI9tcJkGesXrYpOTotgXR8L7x
   /mtNHqGDf8GGeAjlNvelY/aMr/29LANCXjTV+1CF2OaaOthyW8N7nbq1S
   A==;
X-CSE-ConnectionGUID: FRsMPzacR62LnQ+pspVd9Q==
X-CSE-MsgGUID: 3+Xpo4GdRQ+fD0vsy/+YVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="84952463"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="84952463"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 13:45:11 -0700
X-CSE-ConnectionGUID: QeQ/SrPtTdqekVT4QaLLig==
X-CSE-MsgGUID: KOpvsUPTSpa6Lhqlf+hFmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="264381370"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 29 Jul 2026 13:45:11 -0700
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
Subject: [PATCH net-next v6 11/15] idpf: print a debug message and bail in case of non-event ctlq message
Date: Wed, 29 Jul 2026 13:44:58 -0700
Message-ID: <20260729204505.3373950-12-anthony.l.nguyen@intel.com>
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
index 2d9516076d28..f0d30b70ce16 100644
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

