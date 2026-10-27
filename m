Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103304;
	b=H/ZxSwtd0rxRyVluSi8gcviHYsQAE2nsyuK9T6ANVPb6eP0wViXoIJMMRLBeC5uRp5Jz
	 HsKwT99eMHBoMJr7wRrrMXYiOeNw51xqtAuQIEJOzeni6qwQjOSwtrIMx21qcXfU0amHj
	 ITacxxr9l+WsWAjN1+J/X0rYSNgZuY+t75K+5mZqQh0QL420klGNCLMrJISH5BbKytXEd
	 kF1C/Eu91EPtpzfg3wownLCwvSckTOH3Lxsk6mAC0hmruQjPc4J7uSJ4zQY2oSQZyBvAq
	 7Cnr+eBSW+l40xEAu3aSTpa0ZAHWFbh6eqmSjQvTPtFcRpakak3x+/XQaV2OIBMF+WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103304;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eorL2S94yMk59argX2jOXPlj4JIfINkPUowuH7b8Yt0=;
	b=t6fg+i/FUxvB9GHm4lAOMr849+QPqNkchQQOObNy9xWV13kl3YDAs8F71Chb35fcpvlM
	 rfhVqWo989TEEziBxvima1uZYNWGKOm2EovdyqcEDXAEEke0/46yfLOWVJ9UOC9Zl5oos
	 CgOl8Uz8JpR5M5KGe0oBVui7dGeWUUHhqFAs9g582NQ9j89rSdhfMAfvEznrQ9lbWmLBE
	 2acqCn/IFO0Mppo1J3lzIE4/ww+QGVck9S9DnDqOq1G1OXoUBFqPU5ZnTLV1LJhZr7QIa
	 pKq6GGHIiaS6mGxtJHNdGKhx9NuTg18OqsxkfKKa5+oF8Dxa3rfOT0XEp/pJWW6xzLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l3oc+DdB;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD360A5BEB
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23DD360A5BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l3oc+DdB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793103303; x=1824639303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3D7YT8EUbWoQcbBo6UbB5/fOvhkRhwSXmON4p7yEjnA=;
  b=l3oc+DdBzoJgRi45BBPCoQrx26xgaa2UTiTK+d0Q4XbjT8bJaGPx5TyU
   MaQgod0j3j4S5rEst8fDpDF2fYW9lLT4Yw0iXnMvQsZp1bbI0vqfLkAIr
   4+ws5C4CeZE8k3llpQranznTVbeMYl4ki2zEGKxu1zcxEMQ5dLr1j3oTP
   wg3IbB2SGCNhTD3Z+LCOy7eQUMDlU8l+Guo2WenN2xpgxJsOfD1LcWygo
   CY7VF/yAeidC0UQSgDuui5uGxU7QRa17+fVsHdnUktXYzGhKqsOnmNGDU
   4l356//oaW7vkiqcFFsbiElu1dDCGV7yyCUNhoNs+yuUGSo+mZynstdB5
   g==;
X-CSE-ConnectionGUID: LeUYZD8ATeehPVYQyi9m4w==
X-CSE-MsgGUID: 2WO/FGo7QsuFN4wLhd9t/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1709363"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1709363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 05:15:01 -0700
X-CSE-ConnectionGUID: YLizwNoLT8a07mzwBxLnEg==
X-CSE-MsgGUID: rmuuHRhYRWGzCHL9UvjfLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4529810"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 27 Oct 2026 05:14:59 -0700
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
Subject: [PATCH iwl-net 2/2] iavf: fix USO for 32-bit systems
Date: Tue, 27 Oct 2026 13:14:42 +0100
Message-Id: <20261027121442.907414-3-magnus.karlsson@intel.com>
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

Fixes: c91a4f9feb67a199c2 ("add support for UDP Segmentation Offload")
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 8982cf75466f..2c290d7788d2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1807,7 +1807,7 @@ static int iavf_tso(struct iavf_tx_buffer *first, u8 *hdr_len,
 		csum_replace_by_diff(&l4.udp->check,
 				     (__force __wsum)htonl(paylen));
 		/* compute length of UDP segmentation header */
-		*hdr_len = (u8)sizeof(l4.udp) + l4_offset;
+		*hdr_len = sizeof(*l4.udp) + l4_offset;
 	} else {
 		csum_replace_by_diff(&l4.tcp->check,
 				     (__force __wsum)htonl(paylen));
-- 
2.38.1

