Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783E481A84
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909939; cv=none; b=q4uXtkERPCrEDw398goKUsZZ7y9bheadiIgEwbuQhunQ2Hrvj+NWrynVrExgRR479eiv8pGiLKPIPII13dHOgVs0x0dO0zc+NHnRi60kW1Yg/9E+O7wSgSD9g2+EcvDS7Nu6sWeHVtWaJMO6WKn0/YvFaBwdoO3jpWouXzwFb4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909939; c=relaxed/simple;
	bh=eRQgpL4qfxEAYee/aiq5vXUQEARM1LUI4g4CYk+FfSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqajRoOHKIX1nUzWx3zy+WyF90ioy1vhTE25WJPgMNZdyPMwAvIsT2jHp+T0eyP2XKHPpGf5iqn5VhPmkKd0BAkhwNccGOPzwWcimuUuS15RKxKyF2hCT7WxjDQO2l1zi5A1iurn474f+9dMZINYtM0vdg5Y67OOwOToyoVB1l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuHkTFXU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuHkTFXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782909938; x=1814445938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRQgpL4qfxEAYee/aiq5vXUQEARM1LUI4g4CYk+FfSI=;
  b=nuHkTFXUcJxXL58wUhayqnfd3D9JeNrPNhrljM6C93icWhSQR+4KJ4br
   RVSgCfAD6CUBpEiS2PER5D69tRMfBwXXs52TJfq1Umjv3ck8tBDaJHU/b
   nqQjZS6gQn2nk9+Vik3We14MURDrDlJxqsE9jvdgl6GcLWeHDkN7S5ksF
   HnsooTUo1nC63JqVJlgoVoZhCyP2eJ2qplG0SXHEOXd8YSPlC+W98N5JH
   wLOjZ0G3At4QSdKG6AshusCxvZdKv7zaNotw+EcrDkUjhAlWfc80VBkzd
   VToac9rv2xS9T71C8e+EX0F1g6Ptf2+ydx1h+PN6zMuui+I8IgVNLiAgb
   g==;
X-CSE-ConnectionGUID: dh+MOk8dRsi5iE4HIwFR6g==
X-CSE-MsgGUID: nsW3FKqzQ7ui9vUUQv8drA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83839241"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83839241"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:45:38 -0700
X-CSE-ConnectionGUID: LS2XpwoSQtC3pq2UN3bcmg==
X-CSE-MsgGUID: zuC5blPTRHinkJVHV7WTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="276864918"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2026 05:45:35 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: [PATCH v5 net 4/7] i40e: avoid deadlock when calling unregister_netdev()
Date: Wed,  1 Jul 2026 14:45:21 +0200
Message-Id: <20260701124524.13644-5-maciej.fijalkowski@intel.com>
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

Sashiko reports:
***
> +err_netdev:
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);
Could this result in a deadlock when called during a device rebuild?
Looking at i40e_rebuild(), it explicitly acquires the RTNL lock before
proceeding:
drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_rebuild() {
    ...
	if (!lock_acquired)
		rtnl_lock();
	ret = i40e_setup_pf_switch(pf, reinit, true);
    ...
}
If i40e_setup_pf_switch() calls i40e_vsi_reinit_setup() and takes this new
err_netdev path, unregister_netdev() will unconditionally attempt to acquire
rtnl_lock(), leading to a deadlock on the non-recursive mutex.
***

Use unregister_netdevice() when the rebuild path already holds RTNL, and
keep unregister_netdev() for callers that do not. This avoids both
recursive RTNL locking and dropping RTNL in the middle of the VSI unwind
path.

Fixes: bc7d338fbb3f ("i40e: reinit flow for the main VSI")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a29a89192a7a..e88cf7cfbd84 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14257,7 +14257,8 @@ static int i40e_vsi_setup_vectors(struct i40e_vsi *vsi)
  * Returns pointer to the successfully allocated and configured VSI sw struct
  * on success, otherwise returns NULL on failure.
  **/
-static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
+static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi,
+					      bool lock_acquired)
 {
 	struct i40e_vsi *main_vsi;
 	u16 alloc_queue_pairs;
@@ -14314,7 +14315,10 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 err_netdev:
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
-		unregister_netdev(vsi->netdev);
+		if (lock_acquired)
+			unregister_netdevice(vsi->netdev);
+		else
+			unregister_netdev(vsi->netdev);
 		free_netdev(vsi->netdev);
 		vsi->netdev = NULL;
 	}
@@ -15036,7 +15040,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 			main_vsi = i40e_vsi_setup(pf, I40E_VSI_MAIN,
 						  uplink_seid, 0);
 		else if (reinit)
-			main_vsi = i40e_vsi_reinit_setup(main_vsi);
+			main_vsi = i40e_vsi_reinit_setup(main_vsi, lock_acquired);
 		if (!main_vsi) {
 			dev_info(&pf->pdev->dev, "setup of MAIN VSI failed\n");
 			i40e_cloud_filter_exit(pf);
-- 
2.43.0

