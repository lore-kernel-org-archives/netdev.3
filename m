Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB8481AAF
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909942; cv=none; b=G+Z0L/mXOpnPhW5ev/6Z3KqYi4h8DS2JgGI2KmNHhqXN7+zczVi4TbhGKIwYmH4UPHunBRH/A/9JFTFJH2p402jmia0uhLmTVo8YVHakOUUHEN4Sds275onMHk0swyLPpnvjdGJiR7vQQAtlb6HFi6jYg0kChWtuEEU80OowQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909942; c=relaxed/simple;
	bh=v9P7/6NHV1OYqx1b6O4LwdxncKZIH965VKOqbFUDLyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulOdvDqYodtp5mNk6QKpPEdguUQHsc7+OdPn5aTW/8ZcaIVzvlSNhyZ0UXXQAlqCSaRR/n2NFOaehHR3elWDVLajdics0uCOxOzRw/7QAaiN6Usv0t04N8PaVhgewivzUHUhfHrViVdtZcANKLMG3bXq9V0iAnrioFgolyKi5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1t4//NA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1t4//NA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909941; x=1814445941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9P7/6NHV1OYqx1b6O4LwdxncKZIH965VKOqbFUDLyI=;
  b=I1t4//NA98V/fsQB7ZEOJN1j67NgdZCyqwzNqgk+gJpcqNL4q199wz1o
   VfVA4iO8wl4jeEeh2wu9I1+EZg2dXWNOkWPd4/b9cj0k5TMDjlrt31Fat
   n1Vx25FfujgiQTmxbeFY83Hh65iCd8B4ydRHJXAjLMrz80pwKuLgRm/7Z
   drS0dYDMYw4ZDckX7WGFIo2yqfETRdd9BV3Pkg1S0JRPkgNd6ZHOSvrtx
   1zv5Ol2yJMKK3O5AefkJRdbHgrpdJV/e2rO4YCCdkOK39ZLTX15Bjjwx8
   sd+9CWAEBKkRG/aUD36YBfbF+XNXs+3fpIJxVizRrWpmX+ekjbwHKVHX4
   A==;
X-CSE-ConnectionGUID: E7erLp4fRS+nvcoDIF+HTQ==
X-CSE-MsgGUID: aZfP9fXPTRiikGFtONI3Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839247"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83839247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:45:41 -0700
X-CSE-ConnectionGUID: ky2i92M2TQqZpfYl11eLEg==
X-CSE-MsgGUID: 2s2ilFaMT/yhpKQpjL+RdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276864931"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:38 -0700
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
Subject: [PATCH v5 net 5/7] i40e: fix potential UAF in i40e_vsi_setup()'s error path
Date: Wed,  1 Jul 2026 14:45:22 +0200
Message-Id: <20260701124524.13644-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
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
index e88cf7cfbd84..fcdd13af08ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14466,14 +14466,14 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
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
 
@@ -14493,10 +14493,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
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

