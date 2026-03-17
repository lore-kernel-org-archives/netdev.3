Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78662349B06
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782362; cv=none; b=pC8XsFV7s1eD4K9euSh3Yoa4iH7ddwL9nLsXI/p7CAp7iRXbEHhMXpHrSZjSRkz2bgr8CxwiMOlbKfH0RZiz6wmZIYTAZS4Kfe4/m6qpjf+VqGBYn8T53bbrmLLNYUQhQR5A1gsturEL2zJ0oW539+6CfKSoopBEZ6kkcJpy7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782362; c=relaxed/simple;
	bh=CW3Uufj1yyZo9C/fNxOh86kcdkL9BMr9ffzUXlUe+HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2Rp/tFLUPxLw56aCijSOdr0oJx7i8427a8ioKwU9OlgutPteuWfjb35jb2rQ5IbGW/erKpEphXxfeBXvAmbMxxP47xBJO8C7DTO3VSEyzuT9mky1LbLDdZd/lCz+/XVHLJ1NkpfA+LQASE8A8EinHdPLRBq9us3woekpmx9eaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCkazCu7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCkazCu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773782360; x=1805318360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CW3Uufj1yyZo9C/fNxOh86kcdkL9BMr9ffzUXlUe+HM=;
  b=QCkazCu7FKMuT3jhE5kbxLEdNAQ9rbCoFTAT2K5xULITllE0DvXpQq1P
   RnRUgRjZcv847ZaWdkuYG91+0DRAOhs85I8sFgmVAmXHIJWbi5LXxVzYQ
   qOQZHg1uj3CDbSZU/OhDC/nokbaiLvjn4pitldccUDd+MJ27uxu4XSkA2
   iPn4QAQKzNl8PC++aCRm4R2Zl182rK/srGthnxYG0nmh8ZtCy2SeIO5iM
   Ko/LlVkvCbjpdevI1ERLLMqwn9yJZgpBsUjibBi/+KQvOU7i/Cb+4RsD9
   qgDny/tET1tFkXgiIKZJ3CZVeDxrNJVpZ0a2dbAIoBAj+0kSPhEPdhEIX
   g==;
X-CSE-ConnectionGUID: rP/L9xd4Q8Ghwhz+K96M3Q==
X-CSE-MsgGUID: vpp7ppksQUOa/jMmBfmtrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85524761"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85524761"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:19:12 -0700
X-CSE-ConnectionGUID: EXEu2wXXQ3u8+3QSXIlEyg==
X-CSE-MsgGUID: AGC4ofpfRsaYdXJ/ypOraQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="219477572"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 17 Mar 2026 14:19:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	dima.ruinskiy@intel.com,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 1/4] igc: fix missing update of skb->tail in igc_xmit_frame()
Date: Tue, 17 Mar 2026 14:19:02 -0700
Message-ID: <20260317211906.115505-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260317211906.115505-1-anthony.l.nguyen@intel.com>
References: <20260317211906.115505-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <kohei@enjuk.jp>

igc_xmit_frame() misses updating skb->tail when the packet size is
shorter than the minimum one.
Use skb_put_padto() in alignment with other Intel Ethernet drivers.

Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b2e8d0c0f827..1c5d7b23f225 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1730,11 +1730,8 @@ static netdev_tx_t igc_xmit_frame(struct sk_buff *skb,
 	/* The minimum packet size with TCTL.PSP set is 17 so pad the skb
 	 * in order to meet this minimum size requirement.
 	 */
-	if (skb->len < 17) {
-		if (skb_padto(skb, 17))
-			return NETDEV_TX_OK;
-		skb->len = 17;
-	}
+	if (skb_put_padto(skb, 17))
+		return NETDEV_TX_OK;
 
 	return igc_xmit_frame_ring(skb, igc_tx_queue_mapping(adapter, skb));
 }
-- 
2.47.1

