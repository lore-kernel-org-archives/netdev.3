Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B113E7BA1
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400489; cv=none; b=Arw0G5ODLswwEugxU7ivp+hYhVnravZlSFpIcrsDTMkZFwMeWvIxk88DawcsGctxBZqShbJGEH77N99pUk8UDIiru4oSGHSlNzhs2iyZGjo/GH1mBwReLLo2m4+qSXJKQOJjeKzftO+2nUejGBHSa2QFiuoWHYE3EiRwTYN7QkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400489; c=relaxed/simple;
	bh=mE/Hmqd+/GGDcneby51MV7lO/cMbj7228JSmq4Fr2+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+jac1fOJm/833ESRCvRQbwmMqell4SyFqfZMYVqf7+uB2AKmb5EOKNK+qO0VS2OI22YjAjUWuKNVGoBSDLpiPXubvxi/N6s5o0gKpnIFcBHBgwbhz0mW/EarWCCNNwRznHOcV7pBKgE8ykI5GtFgWJvoXUdL/RABM0bQpdrIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0I6JmpD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0I6JmpD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782400487; x=1813936487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mE/Hmqd+/GGDcneby51MV7lO/cMbj7228JSmq4Fr2+Q=;
  b=R0I6JmpDjWUJSCFGWG+3QTo72PJ6q+jtvUzo0jAeNEUAMshNEsYs9hqd
   PWdyxPAujy9vOnJY/Mb329cZyhaS88XftcBi4rSV2NibEDEKHlG+JU8Xu
   uE5btcRDZAAZryJsxQz4Z80yE2ksAIn41Mh/n1me70yWI2l+jOkI1e0YT
   WTaSVfc/q21BEAgJB5C0jHxai0uYqqwZT1FNqMUZO2p/CwySLkY2pAxsF
   HEbGSEMPKHAIaoShwAavGjXUf0V3LhiEYWA7BDBtPR8RuldoQGWbtPfkZ
   P6vz4/nXTIxbPGSvhmtSFx8Ba/mFOhXv1sK0WGYN06aQ6BjV30Bsl+EHC
   g==;
X-CSE-ConnectionGUID: nu7tHD2fSLmc2K1hpeLL+A==
X-CSE-MsgGUID: bSK3PTb4SJmTWp1uADTu+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83304545"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83304545"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 08:14:47 -0700
X-CSE-ConnectionGUID: sjgAQYJhQI6IrtFoX7I55g==
X-CSE-MsgGUID: k9WgKcSATlic965BMKa0vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="254866966"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2026 08:14:45 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net 2/3] i40e: fix potential UAF in i40e_vsi_setup()'s error path
Date: Thu, 25 Jun 2026 17:14:30 +0200
Message-Id: <20260625151431.1102838-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
References: <20260625151431.1102838-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko pointed out an issue where error path in i40e_vsi_reinit_setup()
released ring memory but then when freeing q_vectors, the rings mapped
to q_vectors where touched which implies a regular use-after-free bug.

Apparently i40e_vsi_setup() has the same problem, so swap the allocation
and freeing order and fix the 13 year old bug.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 471fa7f7b643..4adc7b0fb2f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14460,14 +14460,14 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		fallthrough;
 	case I40E_VSI_FDIR:
 		/* set up vectors and rings if needed */
-		ret = i40e_vsi_setup_vectors(vsi);
-		if (ret)
-			goto err_msix;
-
 		ret = i40e_alloc_rings(vsi);
 		if (ret)
 			goto err_rings;
 
+		ret = i40e_vsi_setup_vectors(vsi);
+		if (ret)
+			goto err_qvec;
+
 		/* map all of the rings to the q_vectors */
 		i40e_vsi_map_rings_to_vectors(vsi);
 
@@ -14487,10 +14487,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	return vsi;
 
 err_config:
+	i40e_vsi_free_q_vectors(vsi);
+err_qvec:
 	i40e_vsi_clear_rings(vsi);
 err_rings:
-	i40e_vsi_free_q_vectors(vsi);
-err_msix:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
-- 
2.43.0

