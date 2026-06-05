Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0B3E3D80;
	Fri,  5 Jun 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673142; cv=none; b=qXkjb4l7lyhfmufM4qO/7AraPZwuGpBLtPBCtoLqS1F7qLWn4dih98EI3pDnWJD3rQ4dO368fz/1/lLTBbAKC+OBai6xYjMLUNG7rumqt9JWRghrdfX/YVcM0rEDS9kMPTtIEPnplSbrN2tgM3ULJ5bJg36N3WlwNWCXArc1pu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673142; c=relaxed/simple;
	bh=7SLLTaGR04kcGW6NFlVhrv/kbAI3IG9DGTQq1xYnrM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C2oTIOZMVz9wnTVEJxe3rhHwi7Fm9SAbI+9siRJspPyrIQKzS+JyvdADGBZZDzLd8okwM2m26VNkW5kBjBge5LbBua62sWeR0DTIGFSnZvh6Kdu6kzL4leVWsuj3M+V5BXh5k1pTxS+aL0wL+nc8R7+PJp3q4W9fHYqZTAQXg/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nninRtio; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nninRtio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780673142; x=1812209142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7SLLTaGR04kcGW6NFlVhrv/kbAI3IG9DGTQq1xYnrM8=;
  b=nninRtioncW+uO0HT7f5QSevXpWf7pRcfsPBnGKx5MCwMIn8bAw5bLhT
   3YW63KdZ8dSJyxBbe3eUA19fQdxbXDsnTKvKiOb4XK/ijf86VCtHA3pBg
   roT2e6AdzTNCfwM5eiR/i+heRTl3b4qwrFUd4pyfugADaya1YCDvNAaeC
   JTBBDN6bcAuh9okFRV74McfIVdLgSnAdIhIn2P2rNH3RrEnKk2Ex7/FLS
   03wxlSURe+WHyb9aE5zMPUbujOm/0Tv5w204gXVBamFujyxdlvJTp7a8j
   BdgaKwVU3Y3k58HO3whEpI4ruivOdQmxkhxTqcezFHXRtfRp9LqlPIY24
   A==;
X-CSE-ConnectionGUID: 2XazGvOGT3ev47m5sNVeDg==
X-CSE-MsgGUID: spYkNfi0QpCMePci8nTZJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="106948953"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="106948953"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:25:30 -0700
X-CSE-ConnectionGUID: LoQvJZlRRBS5HP+czXnLZg==
X-CSE-MsgGUID: oSg8k8s7TcaV2eR8wKFdrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="249798833"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa005.jf.intel.com with ESMTP; 05 Jun 2026 08:25:26 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v13 net-next 04/11] dpll: send delete notification before unregister in on-pin rollback
Date: Fri,  5 Jun 2026 17:20:23 +0200
Message-Id: <20260605152030.891570-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260605152030.891570-1-grzegorz.nitka@intel.com>
References: <20260605152030.891570-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rollback path in dpll_pin_on_pin_register() called
__dpll_pin_unregister() before dpll_pin_delete_ntf(). When the
unregister dropped the pin's last DPLL reference it cleared the
DPLL_REGISTERED mark in dpll_pin_xa, so the subsequent
dpll_pin_event_send() failed dpll_pin_available() and aborted with
-ENODEV. As a result userspace was never notified of the rollback
deletion and remained out of sync with the kernel.

Send the delete notification first, matching the order used by
dpll_pin_unregister() and dpll_pin_on_pin_unregister().

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index cea7e2be2cbc..80195f3a84f3 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1007,9 +1007,9 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 dpll_unregister:
 	xa_for_each(&parent->dpll_refs, i, ref)
 		if (i < stop) {
+			dpll_pin_delete_ntf(pin);
 			__dpll_pin_unregister(ref->dpll, pin, ops, priv,
 					      parent);
-			dpll_pin_delete_ntf(pin);
 		}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 unlock:
-- 
2.39.3

