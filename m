Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43727238D52
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493371; cv=none; b=FtWuWullllB1X5zYS12KGTVCNULEPw+XcnT0AGaOqxeoOKVHCtOPRWbOY++TPDMnWX8eglIvEGH0scMohLIKmQJKFILGqGV7srTOrBa0zEN99UDf5uT96/uQePClKKfGeIyG+iBIN+XhQubyxKsgCEwz9BEG3cViHPuazg5l1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493371; c=relaxed/simple;
	bh=+KEm/JE82H8s9fu2mfdlUhZiqY5aZ7cqAQiEgjgKT+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VG5it/00XvHXyK+TX7IaJJJ+1ICcMuZp0+VopJxWX4U0VmBkcoYCNmte+iyKVdk7LP8DEeuGi/NOx0FFi+ur9ayFI0vrl7we51+RIHCbfeDYb5CNZyOlkalHzMBzliMO8NAPHU7Jnb5Sg6kzp35035K6CWD5xTIAR/dHiom07bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8nlnTzZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8nlnTzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786493371; x=1818029371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+KEm/JE82H8s9fu2mfdlUhZiqY5aZ7cqAQiEgjgKT+8=;
  b=W8nlnTzZU/zNdxeult9eIimYJbxTKjIJp2LbF6K9Wa6q29fTsxY8ULeq
   ytY64Iyju4NxKrrTNqjACtqda+2mRDbJNHoLIQTrPr8tzOB26dYt9dqAF
   0puEd/sTQrGngnqUvypDoL1fZiepkgT7/1c8ubUO9KnojZODtem3PciCf
   BQQbsHNl/8TIyluK1crRiSqxfiK3eNFZb+02n7HU2WW0kYxTPv75roDFJ
   tIFixDRU/1/EUcpS0aGoGfHDFbfBlT3+vo5eaqhNRfUgm312/a15OpTpd
   rVN/ut/a11xJoBfwmyFtQR0x7jEkSRcfjHA3EXBHTta+YTFlVNrKvLT2H
   w==;
X-CSE-ConnectionGUID: ar1yvM6BQi+kteTjpJ7aDw==
X-CSE-MsgGUID: 2wFSAXCfTwKHoLTQEItrQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87110575"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87110575"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 17:09:26 -0700
X-CSE-ConnectionGUID: Ty/XbQCyR6ekZfgcQCEdeQ==
X-CSE-MsgGUID: l3TdkMvUSQi/32oWUhpJLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="263522984"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 11 Aug 2026 17:09:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	konstantin.ilichev@intel.com,
	richardcochran@gmail.com,
	poros@redhat.com,
	przemyslaw.korba@intel.com,
	przemyslaw.kitszel@intel.com,
	robert.malz@canonical.com,
	Jason Xing <kerneljasonxing@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 4/4] idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc
Date: Tue, 11 Aug 2026 17:09:17 -0700
Message-ID: <20260812000918.220714-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260812000918.220714-1-anthony.l.nguyen@intel.com>
References: <20260812000918.220714-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
field in a single operation.

Descriptors are in little endian. Add missing cpu_to_le32 and cast to
__le32 to ensure the fields are written correctly also on big endian
platforms.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c724d429a7aa..91ca75e45463 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
-- 
2.47.1

