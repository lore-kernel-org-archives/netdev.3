Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B003A16A2;
	Thu,  9 Apr 2026 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778932; cv=none; b=ffRSEPglllhqLfVf87/nBpu907FAHUSQGYTv45e1dSTDgiIOsWrjnid1nFWrwc/0Fob72qu9L1sDWeucKprGL6S5dQ2uxpTOp+HqXqv5Ks3v8jwHlFo42Rzf2O3FBwM5uBaw99AXLy2TyaPFqvAv0BlZMFWpVzPXOVPynjGFGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778932; c=relaxed/simple;
	bh=Izbqb6M5jnyKGkCx6C0FAG3R4OV2Dm01nNdm0f5hBzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnGbNpmHWBpe9X4J3SXxXND4jPn6PEwSrPNMFpDOWQpCIuUIVVfvc6dsnmALOdRbqJTwzDN7wS6rWAtaV6i3wxHe4+q6OBC9dq8QVG3ndgXns6qjph/bcuhLSE+LFQFw6OlsUfvG2KIHjKTKlaxGQhiAoQan/Ab9dCPRcIRbR8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTXk+n4Q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTXk+n4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775778931; x=1807314931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Izbqb6M5jnyKGkCx6C0FAG3R4OV2Dm01nNdm0f5hBzY=;
  b=BTXk+n4QMOO5eKcgI6PDDDqCTEM1501x12pMoO614NGdYYncHZsPnsPm
   KDyXlVxMyAP/Rp1w3x4f+RY+tMs2jS7lcthe65/dshR9nHZBGdEN9gaUd
   X4F5Jx95NKGOn33jlqN8OqlzFKCEcOB+3tU+cVi76r4T4AA0laSyYsNB/
   vKop3wbsauAkK8SDD165zXJ8ucec60vCFbsBKT2zL+HGk8flDOLxFd59F
   yXWh2tVue9GE1Jigxap5DEhuBgZ6IXr6N+pEJoMfGCWi6ovKzuhyQt7lb
   x/6TUtIpom522V552m2PDQoTUjPwUpGDdChmCbQzH2VWOP/pzLUdS9JRH
   Q==;
X-CSE-ConnectionGUID: FTG4jwpESLSAnVc5qyZy6A==
X-CSE-MsgGUID: 7JG6FwP3SQKEnqAGxEjwmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87424088"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="87424088"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 16:55:31 -0700
X-CSE-ConnectionGUID: pf73FnfEQ+mevuxvhkhcyA==
X-CSE-MsgGUID: T51/c78DQ4qkZb8+z3uMyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="228860093"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa008.jf.intel.com with ESMTP; 09 Apr 2026 16:55:26 -0700
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
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v6 net-next 4/8] dpll: zl3073x: allow SyncE_Ref pin state change
Date: Fri, 10 Apr 2026 01:51:18 +0200
Message-Id: <20260409235122.436749-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260409235122.436749-1-grzegorz.nitka@intel.com>
References: <20260409235122.436749-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SyncE_Ref pin may operate as either an active or inactive reference
depending on board design and system configuration. Some platforms need
to disable the SyncE reference dynamically (e.g., when selecting a
different recovered clock input). The hardware supports toggling this
pin, therefore advertise the STATE_CAN_CHANGE capability.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/zl3073x/prop.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index ac9d41d0f978..acd7061a741a 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -215,6 +215,15 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 
 		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
 
+	       /*
+		* The SyncE_Ref pin supports enabling/disabling dynamically.
+		* Some platforms may choose to expose this through firmware
+		* configuration later. For now, advertise this capability
+		* universally since the hardware allows state toggling.
+		*/
+		props->dpll_props.capabilities |=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+
 		/* The output pin phase adjustment granularity equals half of
 		 * the synth frequency count.
 		 */
-- 
2.39.3

