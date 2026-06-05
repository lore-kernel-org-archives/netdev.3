Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F73FFFBD;
	Fri,  5 Jun 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673143; cv=none; b=QdB+rwJsrSdKkLCEmE/CqM5zixGcDv1AGG0bclpY6XtcnWEMDxru8qpSKLgcathQ6r3gIWdMXuBq2aUTPl0oMf1a/6dNwpPslJF6Ry515BwH3H4fBb78bv3Tt8YB1pSpMPq1l+m5m007LVqQ61BtSulfEVjVYddBsZ6Mk6A96W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673143; c=relaxed/simple;
	bh=IlOl2lTbjJvzf3VEWq4GBVISiao5ux55lRmLsq8H/Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CC2jM9VV4SM7A+pFwOpmV29PrLNba3DWJ2/AlHVNWv4AegBaNkllH9XfRBtvZ7uXqxuN9SCvoOnMSSfoLFHx2Kn6TP+RIGiWG8kMbnhNoDpdjfiSuI08wdE0BjujrzB9g38LqPEhgCI8j/vBi6PMpvxNTstVu5QtL0mFtl20ILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TD/lzOUB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TD/lzOUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780673142; x=1812209142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IlOl2lTbjJvzf3VEWq4GBVISiao5ux55lRmLsq8H/Qw=;
  b=TD/lzOUBg5cZ5LwsjcTlUlQ1Q6a4sPko+u9Akl3NuzvuhxKAj77JE30V
   Cxbdxpx33jkUsxlXfywN6gbiKi1tNsnDu16qWTAhB5gy444z0h60nWK2h
   sZZ00W1mGmYRQ8s/ctwsfGL9SCgHYcMToi/ay/yD9vpo3S/VP5PycfKj/
   MLnNQkVm1BixtywxFmr79S+4YsaTRP9DnC9s68unAQYI1N2jJZbaBgyOy
   /rVaqVK4R8yGqsZj0jOP/MhudfrEK26EVwiPoVd34OOQjSIecYMqe2fYI
   u+9/mcl5e8YAo33ZaBgllRvKCTlj2k5w9ipyZUJR9Fro+5uAD43bjf0dq
   w==;
X-CSE-ConnectionGUID: LAYWh2A0TDmwv/6aSQps1w==
X-CSE-MsgGUID: awEeleQYTVuycAXDuGF0GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="106948972"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="106948972"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:25:37 -0700
X-CSE-ConnectionGUID: 59Ny/TS+RIWX3hsBvbBD3Q==
X-CSE-MsgGUID: OaCPqyhDSLG05ma0avE3rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="249798860"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa005.jf.intel.com with ESMTP; 05 Jun 2026 08:25:32 -0700
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
Subject: [PATCH v13 net-next 05/11] dpll: emit per-dpll delete notifications in dpll_pin_on_pin_unregister()
Date: Fri,  5 Jun 2026 17:20:24 +0200
Message-Id: <20260605152030.891570-6-grzegorz.nitka@intel.com>
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

dpll_pin_on_pin_register() emits a creation notification for every
parent->dpll_refs entry, but dpll_pin_on_pin_unregister() emitted only
one deletion notification outside the loop. When a pin is registered
against multiple parent dplls, userspace sees N creates but a single
delete and leaks per-dpll state.

Move dpll_pin_delete_ntf() into the loop and call it before
__dpll_pin_unregister() so the DPLL_REGISTERED mark is still set when
dpll_pin_available() is consulted.

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 80195f3a84f3..58034be07080 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1036,14 +1036,14 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 	unsigned long i;
 
 	mutex_lock(&dpll_lock);
-	dpll_pin_delete_ntf(pin);
-	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		reg = dpll_pin_registration_find(ref, ops, priv, parent);
 		if (!reg)
 			continue;
+		dpll_pin_delete_ntf(pin);
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
 	}
+	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
-- 
2.39.3

