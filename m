Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1C3EE1FE;
	Tue,  4 Aug 2026 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813413; cv=none; b=oQHBuFlC7k+PGMKCQrX6QhrZtHQJOEhP5EXDVF5XwphHhby7YN4OnCOpRHF4lRvc92UHSuG6fjcFSk/5s0CzOG0tmriLXv+4laDhKEmjVzExzR3kiLLX4dmVpBnORr96dFJL8MHDuBckKrH4YB4Ohc6fNc2KgERNHWWuVD1XD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813413; c=relaxed/simple;
	bh=jAVsiDfymLgCR/8Q4K7Y2kRg4L0jDxeqNLYmvrrEUeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYpO4zmPtIqLA31djAoetdUPraYWEe2r6gOqD9GSHqaF8J2XDBEg4b6MpxeECzSR+QezFE/CRLE+T+6x+fG8H2a3eANW509QN5PEmm5/2CTFeKjHskDOqn1U8EFjoMa69FBLR1skYVYtBZF9JTIa6TnJLMhj3RWEQx64Vb3MgO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiipRmib; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiipRmib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785813412; x=1817349412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAVsiDfymLgCR/8Q4K7Y2kRg4L0jDxeqNLYmvrrEUeE=;
  b=NiipRmiba/g7XmIuWk82Gp1RvVK5zdQGXMWXa1PfIrVXm+P+Qivw3iea
   xJV5rMdfiWlFqYHInfEQFVqpSz/j1622blpIrY7xPsTmy0FZiCNb/YWzQ
   8jamgK2k3nmGZTkFi0HvAnYQzSdVefbdCgdaKedDVKWPSoQdUaXJ8oq9b
   lN8IXisFTN0+p/LJe+fxr/0H1IlKmrFsJ9P+LHGoj9PsdfagWxi+5JemO
   DdqZCkOOfBICCBVQdFhy0TUcVX/eFlFIOHgHKQnGyQpde8qSuAn9ZAAyD
   sCWm+WKf+WinygS/YEj/WYhz+aemUCE8aHq+p77sXC3Gm3XxSRy2XzraR
   w==;
X-CSE-ConnectionGUID: SKDMluAjRfSLwowfXd7m0w==
X-CSE-MsgGUID: lo4ToGEQTz+CcBrnRmpHNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86555109"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86555109"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 20:16:45 -0700
X-CSE-ConnectionGUID: YjnFgC5bQRK8lPN+SkpAjQ==
X-CSE-MsgGUID: LDfRPxIDReSpfdSJzbFLaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="299613774"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Aug 2026 20:16:44 -0700
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
Subject: [PATCH net-next v7 11/15] idpf: print a debug message and bail in case of non-event ctlq message
Date: Mon,  3 Aug 2026 20:16:31 -0700
Message-ID: <20260804031638.1531994-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804031638.1531994-1-anthony.l.nguyen@intel.com>
References: <20260804031638.1531994-1-anthony.l.nguyen@intel.com>
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
index 9b7451a81497..f32f8c65dc2b 100644
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

