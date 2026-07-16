Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE12BDC2F;
	Thu, 16 Jul 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170321; cv=none; b=MVh1/SiqN1vaIvylupyUc/ZLjLUv8YgYlg6aVpH0IB53VAXcoykZCyNcOE7g7tdnc/TUXBFU2BtADEsK71VAE6vIJ0uxM9J4U/GTlrELvH3wMtkIrrazFCwvgKLbcjiPXcgSWn8zjT7jdNwKWAgE1acTHtD590Qi8oC1z782Vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170321; c=relaxed/simple;
	bh=15NdmIwmDh4914lys0irwqsoFWtZ/39X9Zm0kkVUunQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZmbMfXj/mvhdGBvuvtRtgtQj7rIjn7f0A+/B4TvB/bgSUFkEpcmXaswn14FWKInKwkUWGZi2HDFOENGskcb3gXp/1NlegWgyUkKVFVnQa87tHSpmv/T5kMvL0HvT/4TquCKBdfITiJgiMUODgETyPQYieELpaXzuJftBOfOn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EHGna4kz; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EHGna4kz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Yq
	uquUgbdI7gwVNs7i7179IVeRHZuzDb123mlIh3OX8=; b=EHGna4kzKWvw5CIaJf
	nvJzd8xaxDU0WR+zz+QU0IJkIqSi97+nPX03UrUsglBkjA7a9uk1YAf23hxZo2HP
	xLxqcm7qU/NEPEkwy3NTsgTcvY/vo6Wp8ttg3jmgxRiSMob66kq5mnu4GPXYCYN2
	CT0WXsEz5tqUVEncMmOXt9KxE=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCnj5oPR1hqcsnBGQ--.45933S2;
	Thu, 16 Jul 2026 10:50:57 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Weimin Xiong <xiongwm2026@163.com>
Subject: [PATCH] ice: parser: use array_size() for table allocation
Date: Thu, 16 Jul 2026 10:51:00 +0800
Message-ID: <20260716025100.118145-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCnj5oPR1hqcsnBGQ--.45933S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4xuFy3Wr43ZFykGw48Zwb_yoWDZFg_uw
	4xXr4kGFWUKr4rGa1SkFyxuryFkryvqr95Z3yfW39xZ3WUArs7Ga4kXryfZr42g348CF98
	ArnxAFW2k3y5KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_0tC3UUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8BGGFmpYRxFyPgAA3Z

Use array_size() when calculating the parser table allocation size so an
overflow in the firmware-provided item dimensions is detected before
allocation. Include the overflow helpers explicitly instead of relying on
an indirect include.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
---
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index f8e69630f..c109d3c32 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2024 Intel Corporation */
 
+#include <linux/overflow.h>
+
 #include "ice_common.h"
 
 struct ice_pkg_sect_hdr {
@@ -102,7 +104,7 @@ ice_parser_create_table(struct ice_hw *hw, u32 sect_type,
 	if (!seg)
 		return ERR_PTR(-EINVAL);
 
-	table = kzalloc(item_size * length, GFP_KERNEL);
+	table = kzalloc(array_size(item_size, length), GFP_KERNEL);
 	if (!table)
 		return ERR_PTR(-ENOMEM);
 

