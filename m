Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47848EBF7;
	Wed, 12 Aug 2026 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570014; cv=none; b=XfZnui+jenbXBGzJMdOi15+PcrmxG15yc7wWRA3q42INem9DoyjlzGKqyZTZPvEIUWi1LzUeCY/ZEccW75coBigaRn+qINZjIfGU/sNXqTH5czXeSrfWcaGookiGAmg93zFFg7VP7q+OJFX74UGhDpW1Y4gvhzgjbiC+VIWU/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570014; c=relaxed/simple;
	bh=Cgan5Md0eXMnTwZJP64y6LcezjDz8UHtcAxLI3+BiRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjqfmMjk5GIkqlfdl8W6Wt5nOsup1WZ8XASewuaieZNiBq+GPkMO536/X+nrmVCdhCEw2mEehe7G2cN65PK6GsmOc2DRnpainY72u4vySSAbne7G4giKHLijXkqTxBQnxLXEl+zw7foIrTvqNd0gAssDcA7mWbR21/eUaM3mS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjM7IOsr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjM7IOsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786569990; x=1818105990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cgan5Md0eXMnTwZJP64y6LcezjDz8UHtcAxLI3+BiRg=;
  b=VjM7IOsrBR+OSf7YkWmEtnBqgf/pk5Tyw0aWn6GxdlOu50HBm+VJZeaV
   LW/11phK+o/H1arJtx7934gymKQtgfMyn01PdnEw4RDIWPZyal2s27LFo
   zJ65/F9xRm5UW4K1P6ErOHzLylxcG3EtXNDFE6kRy/oB3OAbkXQVIkA8A
   /5XQY1+eXqPKkzlA7TUFQnz+PMeMdqTpx2JkQo7HVBCmIJY7vGdi/i9J4
   ol6Dt5OW5WZ/UySFIhRiIx/xLIFRUSuZOJRMGB1ZbqBiFbwWwRkIYBKwK
   O3NfPLCUSSocbWMVEDinuC3x24VBRBU0fWe0S1iOZ6Ekvdb1Q9Jmdl/gW
   w==;
X-CSE-ConnectionGUID: L9Y4/lObRFiacNRM1RykAw==
X-CSE-MsgGUID: 53CM9zIOQsaaaQpPEOmOSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97485609"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97485609"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 14:25:43 -0700
X-CSE-ConnectionGUID: S91Fb16XTn+WT5W/SyQj8Q==
X-CSE-MsgGUID: NNqZRKH9QAm0dWWMSz3yyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="257546260"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 12 Aug 2026 14:25:43 -0700
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
Subject: [PATCH net-next v8 11/15] idpf: print a debug message and bail in case of non-event ctlq message
Date: Wed, 12 Aug 2026 14:25:25 -0700
Message-ID: <20260812212532.905873-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
References: <20260812212532.905873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

Unlike previous internal idpf ctlq implementation, libie_cp calls the
default message handler for all received messages that do not have a
matching xn transaction, not only for VIRTCHNL2_OP_EVENT. This leads to
many error messages printing garbage, because the parsing expected a valid
event message, but got e.g. a delayed response for a timed-out transaction.

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
index 03b371a6aa2b..1caf52706973 100644
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

