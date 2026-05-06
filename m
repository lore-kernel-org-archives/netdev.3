Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE63B3C0F;
	Wed,  6 May 2026 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104164; cv=none; b=HGOjsc78TcmiR5pbEhEsNdBb2x0atgSSnW0fKcirdG8mwf9j2EoVp7hDitEtanMQNU6nV3Dk68MOfQ2Y+Ae4fsQP/Zo8ZBVG6aQL53LqbVZPUPjJ5JeRaIDnI8cbjovLv/3BYM0IrKGAX6ApeAj7PBl1XK2zM5w+wKdITwHfi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104164; c=relaxed/simple;
	bh=wHo5j9nJDIamG49pqy+qz+6YnpC7rg7uJNijoxFDE5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQa8NHydw5/yBEBviCQk8H32dza8ePvp6s6fSNWk5aMUxGAWpasTan07e+XLgu61PG9R34TymW+LTsV0GFH5/8JemCq4VK+z/xwNce0BVRzAvlHk8O3O8eE3gavLStnEeSh2e1DbfCQfmxhbOr3oo5y+w3J7bdOQxN6Q2fqVQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISPg85Ez; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISPg85Ez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104163; x=1809640163;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wHo5j9nJDIamG49pqy+qz+6YnpC7rg7uJNijoxFDE5s=;
  b=ISPg85EznD+MLl4J0Sk6n/LsE0TllqVK7Z02lnwJnVXUz8DeDyAB6GbN
   M9F6i9/ii7uG2bwBXITyrhcL02+FJI44TFPlEGN1yntcQtOLx1DX/jBsV
   vs2g1NpU0azjHSokrdCbHeJJuwjCUwtYEUl5Nnjo0IyButmGdOr+yNpn4
   dIQdi3iLvXcv6jPSuKJLAdU4zAH06ByYGBvqRNHF4MTFzVezF5/Vcfe0a
   xKoHJTQyu5nnXXjtoSqS2oOv0v1ieqZk6KyGskxLjxYkRcGvvBoCa0JvJ
   g4yAs8c3ddpOAD8Byfz7Nez6TM0i0O4t2rf5+NMni2aUu/rMSPv11EM2S
   Q==;
X-CSE-ConnectionGUID: xmQcutZxSQufPnex8NVa4Q==
X-CSE-MsgGUID: ID2iludmRQehr1GRM8rBQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982528"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78982528"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:20 -0700
X-CSE-ConnectionGUID: nPhameQnS2Ou1tX9cJfYyA==
X-CSE-MsgGUID: 2/ScJ5N8Sx+F7NHN+N/1Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259698631"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:20 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 06 May 2026 14:48:15 -0700
Subject: [PATCH net v2 6/8] ice: fix locking in ice_dcb_rebuild()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-6-a5ea4dc837a9@intel.com>
References: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
In-Reply-To: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org, 
 Arpana Arland <arpanax.arland@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=8xxRBB2hCfnptncdvaHpAb1aQ37pmgCfaRqlFzs73jI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf22OO/D7l3rj4qSeH5b37OZaCsr5F+eXrrxpFGyss9
 GnSkFnQUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwET6pBgZNueofLSVcovk38lW
 +pfba5m08OzMlpk3Xu3cbHPM49N1BUaGRUekxa4Y302+cDnj/P4NYl93qmS4p0zcb8MRN9WNWeE
 vOwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Bart Van Assche <bvanassche@acm.org>

Move the mutex_lock() call up to prevent that DCB settings change after
the first ice_query_port_ets() call. The second ice_query_port_ets()
call in ice_dcb_rebuild() is already protected by pf->tc_mutex.

This also fixes a bug in an error path, as before taking the first
"goto dcb_error" in the function jumped over mutex_lock() to
mutex_unlock().

This bug has been detected by the clang thread-safety analyzer.

Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 16aa25535152..0bc6dd375687 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -537,14 +537,14 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	struct ice_dcbx_cfg *err_cfg;
 	int ret;
 
+	mutex_lock(&pf->tc_mutex);
+
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
 		goto dcb_error;
 	}
 
-	mutex_lock(&pf->tc_mutex);
-
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
 		ice_cfg_etsrec_defaults(pf->hw.port_info);
 

-- 
2.54.0.rc2.531.gaf818d63126a

