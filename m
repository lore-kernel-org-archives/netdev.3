Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103301;
	b=sDNAkMUwah3sP2IuUu6ueU5nw4P9TLwC7un1+CS2q39rPLGPOnwu/PTk7rYJtVmB1auU
	 j5fCAzW42JgeLDJRr2blfVYg9nMpeHEFrdhAkatR5AocdD8C3/tjQ3RoeIQDMXTyACQ3B
	 gWkIyZbsY0s2IJBmL0l/uZvYd20usCZdetsOIu+EgTUGEHAdJ+KDPOoHVfm34TI9R5wZ8
	 pb5FHqdeJvTPawYULB5Ib3WDUhCPC9V1iMTaBtgY6hcZxt/x9WHmfZEBcKrd4yO2lIIm6
	 4YqZltbb+QrRuHBi223D/fxpyTJSfMMWYZbY2EoYTYTAs3btqkn56TXbp8LkEQjFlcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103301;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BViwE3dfXKqpkwdZwEdcio9cXmtdv8ApzP+/cAcGPKw=;
	b=UQL5S3fk/ARBqp5P7vD6HGsZOM14tvS0Yus8ra1gUrQbvUD5D/zPcVPhVa4vS9VCYYFh
	 X6AEcODGNBc05CRYx6k1yD9t+EcxtrglXSYTZucVkUb8eVGROnZ6M2+bTGWrvWMJS4goY
	 GEhG4W9TkGAYBeCFCB7OZ+K4fWZoChV5u28mEzlY3+C9nY5rEBDk3A884op2yEobO6Rk8
	 E2vP6ThAwX7wT3n2y1I0ZkDvwXuDiVRUFVdmu5df4Ta9mIaxTAmRoxTIzY2oep42ftDO0
	 s8mklISDJ7YUoxsA70CQZZqCbSfo4/pRlNACMuAM17njNC/dU+zkaYHXuzNK/kWFM5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d2eK9i3s;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54560A383F
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F54560A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d2eK9i3s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793103299; x=1824639299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YyLWB1wW4GQLOCVklLn2VyX6mM9SGN+V9to/Vkzquwk=;
  b=d2eK9i3s01LxRuz5f+deLXwWVarnWOOJCqwaNwcl8lFEJK2fCWAxTSyM
   MJ2KXDpWU70obQQC5sz01mFU23qOpb9TyOTSr2f+8SuF6fqWLGWE21kWT
   sqRgEEpnfDrVRFF091GO1aHj9D1ZXrQ7fi9zKC2rP6jWIkIEB2XhXmWlj
   e2I9AKIBTpYuND2WIPcKd6HhgxiJCZ7vV1Nt4dfjz0psFg11fR2o+ogNL
   ejQ8cSovfmM6nycSavb26UOamS2bcN9XA7ZgtZLWTnASCfz3q9d3TYaaU
   LL85udnMpvefo/3GnDfgRpy1BTuPdBXKuGBdKXyGS41pen6hWRUVp8w7H
   Q==;
X-CSE-ConnectionGUID: Yci9TRwJQhO/a/iVO+3jOg==
X-CSE-MsgGUID: z6PP3Dj9SKiax2OM5WDNqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1709355"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1709355"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:14:59 -0700
X-CSE-ConnectionGUID: 81Nx+QqnR5y1NH4EymS6tw==
X-CSE-MsgGUID: 3scPnqK2Smil7T5i4hYtsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4529800"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 27 Oct 2026 05:14:57 -0700
From: Magnus Karlsson <magnus.karlsson@intel.com>
To: magnus.karlsson@gmail.com,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Subject: [PATCH iwl-net 1/2] ice: fix USO for 32-bit systems
Date: Tue, 27 Oct 2026 13:14:41 +0100
Message-Id: <20261027121442.907414-2-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261027121442.907414-1-magnus.karlsson@intel.com>
References: <20261027121442.907414-1-magnus.karlsson@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That USO works for 64-bit systems is just pure luck. Currently, the
computation of the UDP segmentation header is performed using sizeof()
a pointer instead of the sizeof() the UDP header that the pointer
points to. Since the UDP header happens to be 8 bytes long and a
pointer is 8 bytes long on a 64-bit system, this works on all those
systems. But no such luck for anyone using a 32-bit system as 8 bytes
!= 4 bytes. So fix this by using sizeof() the UDP header that the
pointer points to instead.

This was found by an LLM while implementing something else that used USO.

Fixes: a54e3b8cffd6 ("Support UDP segmentation offload")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a2c7c4962882..d9ea812c5c4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1925,7 +1925,7 @@ int ice_tso(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 		csum_replace_by_diff(&l4.udp->check,
 				     (__force __wsum)htonl(paylen));
 		/* compute length of UDP segmentation header */
-		off->header_len = (u8)sizeof(l4.udp) + l4_start;
+		off->header_len = sizeof(*l4.udp) + l4_start;
 	} else {
 		csum_replace_by_diff(&l4.tcp->check,
 				     (__force __wsum)htonl(paylen));
-- 
2.38.1

