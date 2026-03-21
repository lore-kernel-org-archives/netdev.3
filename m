Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35431175A74;
	Sat, 21 Mar 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132233; cv=none; b=iWylcG/6zMu/kJoykzzk0tvG65DKs59TSa9mlI4p1OT42IfdYKgVpFJ0JSnA/yylqXivjqFHodY35KjFGhCGtu1W7vTwMK4SigEEPD5m5hE96+alueiiQlxQjG4gbe+/9CSCIQ4CO9yvluQBtt66gaK4eQhcP0eSYCogizfapM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132233; c=relaxed/simple;
	bh=Izbqb6M5jnyKGkCx6C0FAG3R4OV2Dm01nNdm0f5hBzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EiUn1EQSVdjpVVp/bI5d5bSh6MiXEy3/xj2RtMCILa1nvUgK06dIKndm9I/uYTM3Se+he3tWgQZIsc0LjDi7nYU/nCAwfSXp9zmypMFaFRCv32+dqhAMKnULDyq7krAPBMjBLybUB0j1B2JABdqLluKGOKvtKNl+J5EHaY3QqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/Uqwa/w; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/Uqwa/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774132232; x=1805668232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Izbqb6M5jnyKGkCx6C0FAG3R4OV2Dm01nNdm0f5hBzY=;
  b=R/Uqwa/wzzMIHf8GPFjq73fydZDK5+xIN169yWdcr+lBmTWJntXcPLmL
   uVh3DOWMolqY8kPG16Q6pfclgeLnXixDS5VAj7r1EUgw5Aqg32qZ5b0P2
   nmLebMrE29I6Zh6W9vK2/bxelAcJ0xNtWk4qTg5G00C5wtxDW5zZ+4s0K
   TvdQld4U1q4ybho5tqczSm5wPTYY9hpO5ABz8fK0OSDjQTloTRXCJNaHh
   CEJYLNsTEiUKRVsnZ+1PtjGxUcenyypiJsekoV9yLbi1VO7sIxNOTl0Y6
   AZuno+BX1dPf/D/nbxRTCLU92IVJyO8Yxnkp50FLkob0vfetGjzbHUikj
   w==;
X-CSE-ConnectionGUID: vHQFrNaITK+qk4CM2baH3Q==
X-CSE-MsgGUID: GElMtsP6SXiyrXfWdxv9/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75150422"
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="75150422"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 15:30:32 -0700
X-CSE-ConnectionGUID: /ayHjL5XS42qSsaPwo7RLg==
X-CSE-MsgGUID: 4xPuHQRNTuOjHNqaYaUdRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,134,1770624000"; 
   d="scan'208";a="261543963"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa001.jf.intel.com with ESMTP; 21 Mar 2026 15:30:28 -0700
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
Subject: [PATCH v2 net-next 4/8] dpll: zl3073x: allow SyncE_Ref pin state change
Date: Sat, 21 Mar 2026 23:26:23 +0100
Message-Id: <20260321222627.1193603-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
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

