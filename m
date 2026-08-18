Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE05440A13
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061266; cv=none; b=e8QaegjfoH6h1zKQNRBxNRsV6N91z3xp69Om8/62M37COSa/IqBicYiGMo1XaTDecyFLfQ0RD6WOE5myxEmvJLye50MxFWbx6/Ksg5v+xkpZS54BBmGDCNLfX+UN0/JUQYRM3dOHVWE80XM4gAkY2txpMhOs6FmNe6Lt7sCa738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061266; c=relaxed/simple;
	bh=1XTJMHORqJ2wFunzykShatjYkKBFknM2dQKtqWIEXJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ3AJIKpyhiekatu3pDRssQSMMyZ9C6aeheexVVP6W4r+fjxkQ2jkz5sfnbYyB0NqcwTSIeXSY1Tv7M1gYJj+JWAFUJbaIYjd7z7VMesPGlJ3Ycdh655/Zoq5XD6T/JyHVBZTYCJytPpQjIsHrfTVO11swPYASNT7vqtzQHhE0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9xpGnJZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9xpGnJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787061263; x=1818597263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1XTJMHORqJ2wFunzykShatjYkKBFknM2dQKtqWIEXJI=;
  b=h9xpGnJZD7hWhRVMGS45tuKDplJWNVnZMV2b1ajwzuse0moE3hf5AlQ8
   IdebOLk/dIhmHhTOJiteE2e98jwOw2wHbZKYf5i3ehREm70bWNqn7XSoc
   KAf1CUI9/A427n7LUpUgX0TrwCcRR7FG5gujS1+OAEvCV0vHTh6VoLu7V
   ssunttYimQr02PqARLtrb3Xkxfkvz+A52e0oaSvqHoSMeH41Lc9DDFkGc
   ALz3ZQVOMyEYrr4Gd8Ok8zH0AWsTKSDbtCFsZiYGKFKa/V1nBzlZxL8Wq
   vQR/NAXToF7kordmMgX/sSIitvKcIUg0sP0n7x82Jk9sObYgdeJNBT9Cv
   Q==;
X-CSE-ConnectionGUID: sy6S0ndNRTCAplzC7+rXhw==
X-CSE-MsgGUID: YZ4RuqblRmuS5RyD84lmWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87315110"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87315110"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:54:22 -0700
X-CSE-ConnectionGUID: U1IIre1OQYKwqiGi6GsB5w==
X-CSE-MsgGUID: NppMlLOWSF+fCO7vjG8KCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261021583"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:54:17 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch,
	airlied@gmail.com,
	kuba@kernel.org,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	dev@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	mallesh.koujalagi@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v6 1/5] drm/ras: Cancel and free message on get counter failure
Date: Tue, 18 Aug 2026 19:22:05 +0530
Message-ID: <20260818135304.497098-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818135304.497098-1-raag.jadav@intel.com>
References: <20260818135304.497098-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

doit_reply_value() directly returns on get counter failure, which results
in stale sk_buff and genetlink header that aren't cleaned up. Fix it and
while at it, consolidate error handling using goto.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
---
v2: Use goto (Riana)
---
 drivers/gpu/drm/drm_ras.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 39155fb514de..4fa1a257b0ed 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -234,25 +234,28 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 
 	hdr = genlmsg_iput(msg, info);
 	if (!hdr) {
-		nlmsg_free(msg);
-		return -EMSGSIZE;
+		ret = -EMSGSIZE;
+		goto free_msg;
 	}
 
 	ret = get_node_error_counter(node_id, error_id,
 				     &error_name, &value);
 	if (ret)
-		return ret;
+		goto cancel_msg;
 
 	ret = msg_reply_value(msg, error_id, error_name, value);
-	if (ret) {
-		genlmsg_cancel(msg, hdr);
-		nlmsg_free(msg);
-		return ret;
-	}
+	if (ret)
+		goto cancel_msg;
 
 	genlmsg_end(msg, hdr);
 
 	return genlmsg_reply(msg, info);
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+free_msg:
+	nlmsg_free(msg);
+	return ret;
 }
 
 /**
-- 
2.43.0

