Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D85540F736
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272966; cv=none; b=oc58lQxbu9gNyd5KbwSAuXun3rhoW8nyqlbkF3/6fgyPG/2RkQZjxrs/qCDVCqMOVTIS2DEHBwDjBEZGpdkylHsSV7Jmi7n+y2ZUVuRqlOG3J1NJjSiotmRBHxOjivtNGPGcarLhTTBhcmtNcayDsEmPeL6BLZOp34ashAOwH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272966; c=relaxed/simple;
	bh=ejCKC2vfqzH7Cm5y2mtTG/KqMJo3d0oH0LX1mhx+AMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UI96x0fUo4ec2RKm6xmIRExOLVfW0j7eOXQWuLoFP4maKQlcdRKX9BId6lNVGpMJdsewL6cSukAaADufIQLALZprITpEFvJiFdFfbLsIOva95qkcVkMh7qHCuxaBROJm4T1oTeBh6TrNSeNA7mk2FDFVuLIpURWGTAQmmmV2Zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ef5wH2CG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ef5wH2CG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272965; x=1816808965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ejCKC2vfqzH7Cm5y2mtTG/KqMJo3d0oH0LX1mhx+AMA=;
  b=Ef5wH2CGCurl3MA3MUpRsOm55eVEAj65tHoxpB7axsxCOxK9EvlrGWLA
   tnQ3sjWrXyVCeC+lR4qNvdmjxjGL9RSBJOVCy2Ogogc6M1nD/D6wdYBO6
   W4Hc2fRTrVNWk0BvkIp/ZZYYnCP2IhDp0LQQzuhT4qYGg9qF2UR3m7TnD
   auygjQNyXtygKSb7gvpqzMmrJMb6arqoIS6uRCl+D8k1DJ2GicAckYt7t
   pT8qkquDr9SjdjQBQDR2AlZoMt5EkqPD7nwVW1qaxu3XJbKDVL7lXtiyE
   Grul3eLCcgnRLHWQou2PA8yZfBuVpAnjgXH2Ni86oFslxWLwS2eLDQOT8
   w==;
X-CSE-ConnectionGUID: GynL1ATZTNGIEzjkKL48CQ==
X-CSE-MsgGUID: DhqpMUxORxeROHRjog5D6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85885023"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85885023"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:18 -0700
X-CSE-ConnectionGUID: ghdFMAqhQ/eFej+ufihp4w==
X-CSE-MsgGUID: 5OJWo/KIQbSBMEaQhY0FTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558946"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Yuho Choi <dbgh9129@gmail.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 03/10] idpf: Fix mailbox IRQ name leak on request failure
Date: Tue, 28 Jul 2026 14:09:00 -0700
Message-ID: <20260728210909.3042004-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
References: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuho Choi <dbgh9129@gmail.com>

idpf_mb_intr_req_irq() allocates the mailbox IRQ name before calling
request_irq(). On success, the name is released later through
kfree(free_irq()), but request_irq() failure returns without freeing it.

Free the allocated name on the request_irq() failure path.

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..bb81e620c5c8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -139,7 +139,7 @@ static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"IRQ request for mailbox failed, error: %d\n", err);
-
+		kfree(name);
 		return err;
 	}
 
-- 
2.47.1

