Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908F3803DA
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232171; cv=none; b=GWU7xP21m59SPnMmCDwLmNi/S7h/ezomrjWe96fir6/VZ4ANspoKemXEBKI9dbpGzqyQLBpa8RUwuvfrjWrV+Q5iHGyewcr8v+NaOaHFmgfRyvlGoHINP54xLB5aovWMqpwUCh1X8f2ME5N7BKcu75mQkaKWzWazTcev1RZDnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232171; c=relaxed/simple;
	bh=D6T1BnUVP19jsiJD59cO0To3bqaFaDe3yjQSupHUgrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=doCEy5hKQNkYpRGgjoRYfFrzxFJFmAq/r0L3X0jN9QEy96b2LRVYqcY2VdOWrpDz7FGewkz9NsnkRVQ//mxQlLe2GQXavCUjNuywlrljvUCjb+WziTfWMAby1HAByXoViqu0kcTjaBYEjbhQTfTejfTLUrAJ9JAp5vPPMiFmcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGCVUxAP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGCVUxAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776232170; x=1807768170;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D6T1BnUVP19jsiJD59cO0To3bqaFaDe3yjQSupHUgrI=;
  b=cGCVUxAP0qYxI7dM2h+VuJ7qdrxoJMkfJzCgpjj1tCiqoNogtXtnAHsh
   PIB1mu/dWg8I+1hFvazA9mskJ4Q/sxbowE4NCY3mjCbIIgrT7K6+Kdb8A
   gWVg7DRJi97OJRbXCb6nNLc/q5tfBpBGeZWDUGgeL2uNwKYvsuxx13xvx
   XSuvcXZUmyGiLPuIWPX3Gw6jUye+cfLlKlqWkjsJMZbVGSH5aG1ANbO3r
   5rqSTEnieGvA6Leq3PJQOzsn77cu1UKmhrG3ujvuCuBbSBr55dwvxXNFq
   HdT5ReQl3N/e8W7/9SfbelGyUbqdNWW4SNMYZvbSLG8985py6CnwOnN9Y
   A==;
X-CSE-ConnectionGUID: TQ9NzUFgQSShteH8uOmjbw==
X-CSE-MsgGUID: aF0JL0kYR0SNXsYIXR7aoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77105966"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77105966"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:26 -0700
X-CSE-ConnectionGUID: FGtSmkUYQTSjigGabDTkOA==
X-CSE-MsgGUID: pKvfQ2wjRHWfRKaxQ3kheA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253714817"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 Apr 2026 22:48:04 -0700
Subject: [PATCH net 09/13] i40e: don't advertise IFF_SUPP_NOFCS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-iwl-net-submission-2026-04-14-v1-9-852f38e7da39@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
In-Reply-To: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Kohei Enju <kohei@enjuk.jp>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=zwFIZLDIyRM3UOEra1+ICLGk+NE/k9VRf1vkjVcK0Zk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsz7ao92nX7zds2iNX/ffrgiyrfT3GfesqNC0dWN531jK
 pmPdPzY2FHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBExNoYGZp/1jD3bgwIYXrs
 Ucm+492GhFw1yTfiPycf2GilzSuW84iRoW+Krryo5zy15ddj7EKtSnjCl6ya7zNt0q+znzPOxq5
 SZwcA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Kohei Enju <kohei@enjuk.jp>

i40e advertises IFF_SUPP_NOFCS, allowing users to use the SO_NOFCS
socket option. However, this option is silently ignored, as the driver
does not check skb->no_fcs, and always enables FCS insertion offload.

Fix this by removing the advertisement of IFF_SUPP_NOFCS.

This behavior can be reproduced with a simple AF_PACKET socket:

  import socket
  s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
  s.setsockopt(socket.SOL_SOCKET, 43, 1) # SO_NOFCS
  s.bind(("eth0", 0))
  s.send(b'\xff' * 64)

Previously, send() succeeds but the driver ignores SO_NOFCS.
With this change, send() fails with -EPROTONOSUPPORT, as expected.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 926d001b2150..028bd500603a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13783,7 +13783,6 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	netdev->neigh_priv_len = sizeof(u32) * 4;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
-	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	/* Setup netdev TC information */
 	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
 

-- 
2.53.0.1066.g1eceb487f285

