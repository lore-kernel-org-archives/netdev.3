Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A613B71A5;
	Fri,  5 Jun 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673141; cv=none; b=PV6H9rzL13amc/soycW10pJIWdmbrAoDDn+SyX7KVTPwdtphMqNvzKL0iBFupxvwT8fdQX4wRf+jsEGfwVVVPZ8+7sTGdkYZb1Dz3uGcSAWNOPAiSDSZ/WtWjSKcEUA7QlGxfAvx2+pE68GevQ6OqvPf41wTHMQ+uu0bRfsYQqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673141; c=relaxed/simple;
	bh=jDp4eSRwMsigpbrYQb0dTY3bkMQJY0JpBLge9f19z38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aF2vXzKVzNTfTCVn1+Z88SOTiaRoh9YiF/aV8V5I60mqpszct6eWHlml8RNfrLLilEznT5q667ewHRfquIGffYx4dt2M+FLX8jtLpuTN3ySBF8wRet4ArSwBqhFhyNEG7uv5scOfSmmy0vivmiVoUvvbo5ai/PJ6Ej/Xy879PqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dySHH3gN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dySHH3gN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780673140; x=1812209140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jDp4eSRwMsigpbrYQb0dTY3bkMQJY0JpBLge9f19z38=;
  b=dySHH3gNtHz8k95qWA+lZorMPCr4E7nsRRErqYxkdIWVenLS5FMs5hbp
   FL4hBozjzy2Whb6ivM7yOcAdPlY7kJihXv8H2KXE7DSVvuGXKD7SYcHsx
   PaLND4Wvx5S8Y+9NHeVVugFG6Wil6+RWwgE5l/Wxb1eQ1jU3ZqOVbAy4Z
   7a4XHVbPa2pOiX4ofvI7XYbIhkXfsJXVj0/lknqrRLfD9mnjWXTiMThjd
   253ILP/uGkZin3NkUp1UXe9Og5o45rDgec2szaivrNGa8YC/xxilfBS81
   RAty9qHjH4aXL5/0m9msQr6xl2zgq/FtIBMgo6CDtMlY0T4YwDuq4+f1z
   A==;
X-CSE-ConnectionGUID: cDs6X4fARFi0FNDiwztjqw==
X-CSE-MsgGUID: hwfeQw2RTq2X6cHQGuT3Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="106948937"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="106948937"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:25:23 -0700
X-CSE-ConnectionGUID: 7RDuMiYbTG67Bi9z/nLyjg==
X-CSE-MsgGUID: eQ91iIsdSIGvAPhqVgAGzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="249798799"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa005.jf.intel.com with ESMTP; 05 Jun 2026 08:25:19 -0700
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
Subject: [PATCH v13 net-next 03/11] dpll: fix stale iteration in dpll_pin_on_pin_unregister()
Date: Fri,  5 Jun 2026 17:20:22 +0200
Message-Id: <20260605152030.891570-4-grzegorz.nitka@intel.com>
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

Neither parent->dpll_refs nor pin->dpll_refs on its own is a correct
iteration target at unregister time:

  - pin->dpll_refs includes DPLLs the child was registered against
    via a different parent or directly; blind unregister WARNs on
    the cookie miss in dpll_xa_ref_pin_del().
  - parent->dpll_refs reflects the parent's current attachments, not
    those at child-register time. Another driver may have (un)reg'd
    the parent against additional DPLLs in the meantime, so we miss
    registrations that exist and visit DPLLs that have none.

Walk pin->dpll_refs and use dpll_pin_registration_find() to filter
to entries whose cookie is this parent. Symmetric with
dpll_pin_on_pin_register(), correct under any subsequent change to
parent->dpll_refs.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 6dc7e93ece75..cea7e2be2cbc 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1031,14 +1031,19 @@ EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
 void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 				const struct dpll_pin_ops *ops, void *priv)
 {
+	struct dpll_pin_registration *reg;
 	struct dpll_pin_ref *ref;
 	unsigned long i;
 
 	mutex_lock(&dpll_lock);
 	dpll_pin_delete_ntf(pin);
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
-	xa_for_each(&pin->dpll_refs, i, ref)
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		reg = dpll_pin_registration_find(ref, ops, priv, parent);
+		if (!reg)
+			continue;
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
+	}
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
-- 
2.39.3

