Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0EB38F65B;
	Thu, 17 Sep 2026 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677954; cv=none; b=WiPaElDFJuTUZZbc1+V4htFPEwWcjAMEbvoU450ECarQVDhtxTXU94/0ZNMUzyuFO7li6ozPnsNKTXmcBNV62biW1Xt/pptlkEDvzEPBkjBJD8MoA23i7n8HqLu5tiwTrzFqsc4VFYLF4LTOV/G6Uh4oHUEtL7r5Cmibjlr8scE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677954; c=relaxed/simple;
	bh=L3PLSv81IQcAA9uTfkLR3K5RYXFUEdg3ccmVVT26p/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0W49pSFFusYJAq2tSJV+7KPaFR4vSa3hSb9ESspJ+fSO8twtUBoaCVcMIfANFe420UGXwWhjnvKZEUCdfu+0ZaqlhAM5+a+D+oLgPB+wtV5IDt0HeoE4O0gpEWD6AgWx+u33KaoAyOzLAbLzIS2rWXFwC2cWuYHzB6iR4zCQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pb0vZqEd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pb0vZqEd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789677953; x=1821213953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3PLSv81IQcAA9uTfkLR3K5RYXFUEdg3ccmVVT26p/Q=;
  b=Pb0vZqEdJ58i5ckogkXQPXMACzWKSvCBCb190GKbxyey02uNrcH7GtwZ
   wjHZh8iVsV2id0jtP21lJq9U0l/5Vh5uavf2iHRj65nfQXiZsqQD1X5Jw
   I+4SolUqpd8ynTmOV2EgOQMM6Oq+qi3JBw8HYltEi4G7exTCB5pQ947C3
   +GbDASSIFFbb2uxh5mEtKzTXczNmd6E8YwE6NP0d2ntD5Ubl/GjwRQe/D
   fkx22X8+yBnX8q68R3EjcfInAw2fIkFK8BkpaFFABLUOM2eGIaXj4c6qS
   fegXe3/bEZkKNy7HooRlEE2MUv+LL9XNKBc8eJ71L1RsgPVmCYHqSpsiq
   w==;
X-CSE-ConnectionGUID: /i6c+8kpQVO1GlAEyk1mlg==
X-CSE-MsgGUID: lQesXD8EQkKeFjjvBye/gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100739312"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100739312"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:45:50 -0700
X-CSE-ConnectionGUID: /viJ//V8RFusFQlaByscMA==
X-CSE-MsgGUID: RZayVWULSYuyvH0v0CZy/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297502066"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2026 13:45:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mohammad Heib <mheib@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 3/3] i40e: trigger PF reset when re-enabling ATR via ethtool
Date: Thu, 17 Sep 2026 13:45:40 -0700
Message-ID: <20260917204541.3072415-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260917204541.3072415-1-anthony.l.nguyen@intel.com>
References: <20260917204541.3072415-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

Toggling flow-director-atr via ethtool private flags does not trigger a
ring reset. If ATR was disabled while fd_ena was cleared in the TX queue
HW context (e.g. after a ring reset with both ATR and ntuple off),
re-enabling ATR causes i40e_atr() to inject FDIR descriptors into a
queue where fd_ena is still 0.

Trigger a PF reset when ATR is re-enabled so that fd_ena is re-evaluated
based on the current flag state.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ef9d1e78c16a..79c2cdab0f51 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5301,6 +5301,13 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
 		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
 
+	/* Re-enabling ATR requires a reset to update fd_ena in the
+	 * TX queue HW context.
+	 */
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
+	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags))
+		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
+
 	/* Before we finalize any flag changes, we need to perform some
 	 * checks to ensure that the changes are supported and safe.
 	 */
-- 
2.47.1

