Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611556;
	b=jPRjrsOH2ms3YHKwXfJrN4nWNFbEfSjKQZqcIhT4uHse0bx28/IJWZ9CQvjJtZcQ9JMI
	 XsaCyT3umAuioQuYybxNBJaRsCCZQOj5tRtoQvDm8e78VtoGGjKn/qZNy6qiEAynQUesQ
	 0jWU5QHJlVc3HW7Y/uTH/bb2fsWcJEHVGnwluVjoBw8Ps1JUbZcmQoE1Mi9rckyai1S9M
	 04tLIZ8Cee8YcGbmgYRHKBOm3z1lIEsJ3j2dtrP5THbe5xfEreSkQs4dQZCjYbJk3i118
	 qubjeD0In3tS1kDdLTW1GN8i+LYSr4nA3heSJl7mT0lqBIgQU/XrO7ZnQ6XxOrJLrJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611556;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+6yVjCRm7kQgtN/Ys75rMDZVr3H3S+6MSu7jsNw554M=;
	b=3IC+4zx4nqZjNRM9Qa5qUL4K8OO1MvDTxhmYGtit/0eC9FY+R9FOOy/NHAHFEY7hMuvT
	 adofQfmRgZ0jE76J6KnVbwXZhFX3ewhykSowdp734F75Nq8vhVFEdCpSQchZOUrGnL+Qu
	 GXqyp9vJ03gNp+SXzZsyyqxc9VjwOFFqwC7IbNgGrVyDiPF0X2eiY0D3qZfWr6F1+X+6y
	 TQyVIfwS7eHG+SRslaiSkmujXawL12yk7eq5t0nvCgKn78iE2HvZKTVIy0ISu3WFW/lQq
	 zC2x6ef5KA1M23md6UQfOIB4f7bpDwGeDPwBePeYpp+ltjscRak9SiAfT9nvqDP7uTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="dzcy/VVE";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DC4606A882
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80DC4606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dzcy/VVE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794611555; x=1826147555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q5S2vgA+hlGkYzq/6hM0YQLcDcI7ndlB8d2K1+nqqAA=;
  b=dzcy/VVEV6XkZIxQYiMJLgvYfJdhhLy8V14abw0r161cnNLD/gXQ4XKr
   SetpyVK2JulIOTAIxNNY5iypBktGOyje/sAcoF46dbsM6j0w9zGLuzZZy
   1Y62ynXTX1zkdw+mSIG0H2uGaiRrvh9AEEj6RsjhMcWZgQjx+gq2hry23
   TeTt6+4q3trweCfg66kFEDtsVzi8wAJFPVj2K0aZIdKJKG7BRulh+xofg
   ZrhiE4W9OZvniK7wofbtvL158AS1TkEbuAbFF72Qj0qKCLZS5d/YPgMFb
   rk1cVcBG7F8KIJ/07kRo26rMfD7AOe/+wJTQVkzpvfdrN0UPr/JCUGZeB
   w==;
X-CSE-ConnectionGUID: NRlJxO8GTEG5AVIeKsXvqA==
X-CSE-MsgGUID: wqWkEzirQQqMnv/ByskWbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3443137"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3443137"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:12:33 -0800
X-CSE-ConnectionGUID: 6DCgbTnMSzSoBHMgsmUc/g==
X-CSE-MsgGUID: YJqEoMG5TCSDwqVWqF5Ihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9360979"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2026 15:12:32 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	poros@redhat.com,
	david.m.ertman@intel.com,
	pengpeng@iscas.ac.cn,
	przemyslaw.kitszel@intel.com,
	vinicius.gomes@intel.com,
	sridhar.samudrala@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 1/6] ice: use global queue index in TC to-queue offload
Date: Fri, 13 Nov 2026 15:12:18 -0800
Message-ID: <20261113231225.1864810-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
References: <20261113231225.1864810-1-anthony.l.nguyen@intel.com>
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

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Previously index within PF was used, which caused rules to fail on any PF
other than PF0. Switch to global queue index by adding first RX queue id
from caps.

Triggered during code development. Validated on HW by adding different
set of to queue rules on various PFs

Fixes: 143b86f346c7 ("ice: Enable RX queue selection using skbedit action")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index d20357c04127..6f49ecb4165b 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1202,7 +1202,8 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 		break;
 	case ICE_FWD_TO_Q:
 		/* HW queue number in global space */
-		rule_info.sw_act.fwd_id.q_id = tc_fltr->action.fwd.q.hw_queue;
+		rule_info.sw_act.fwd_id.q_id = tc_fltr->action.fwd.q.hw_queue +
+			hw->func_caps.common_cap.rxq_first_id;
 		rule_info.sw_act.vsi_handle = dest_vsi->idx;
 		rule_info.priority = ICE_SWITCH_FLTR_PRIO_QUEUE;
 		rule_info.sw_act.src = hw->pf_id;
-- 
2.47.1

