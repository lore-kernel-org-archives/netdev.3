Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530773;
	b=etsCoHoSGp/La3iYw8zgkwnHrXyvWDoGS/e7z8dP1AEStoH/9hAmN6HmR7AviPwc5+nP
	 4y0N1z4PSiZ84JyIwAA8bJQmgT+me6RaJivS84Wxs4AzWjot5vvWbcQ59MbJ5rigYYdV7
	 m0XrGKa7AEvp+HIxZdmpfYreNONQE9rRQhd9vZkL5wl4LMx3ihau/MkArkyJFCPzIW3/7
	 rZV84PV5T9bzAJM04b6HmjRqKtbbFX2X5eAyciP8msw/3F1eWanxzns+4R0CRDG52Z/k1
	 Hil5C8gnwwC7GetAHryT7CyI+mvlPXwQ5D/I6fQpPZFa5F4UvjZGcKvuJIvTk9IXlUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530773;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QSE3XTl88TG1U7AIDSjRmgt7/Wi5/LDqfL0SgWMp0qo=;
	b=uMcQkfrCq+d9fxrPEbWbbmJFTeKhfwLI65P+JtStlrgfXAVus7ijvKalc3AjobrwtU8N
	 9B58Rvktgxeen4ZnrXXP5NPNjNL0znWm+46P9DCy0yZTYyYXRKiZxeiAT22DMgm0HuUsx
	 /zI+mVJJl7fEW+uE6qS+gvRoF8YkLfdHUcNkAinA8u7husdX8Sls4ziKqt27eod3Gj/rT
	 t3arcyQcVyz1Xk4QM12q5ohgyodIXB6mg0e8LYBEv6POvCp0SxEMYhsLzyjZeC5l1x3WZ
	 gU18BnQD1N87ur/CmX8jYUeSvZQcwfhPBD2pVAq1bhayj6okc5pyXFL2ZWKSiAHhvrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WfvZS0M4;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4687606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4687606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WfvZS0M4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794530773; x=1826066773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJQE9epBMVc/MXuW3py+m6TKEBuBsezMijmtRzO6ErA=;
  b=WfvZS0M4hKAgiZvgktxDy21Afj+RBz32ojH7qQfEpHWbolVXg/XZqNmk
   q2+xhObeFIJtuiIt86ORHii0TcPy8Ui+wcIazNqmkGTE+LhIY2uhZlYOP
   4xvt4BRimEAZ3ZGj1Q7Uwap+HSc/1TAeXUMwo/xCI/AqdUzgkcQtdjfwi
   VwuSLS1GW7wNnMIleMDZGzVXwxgU8WD6y1xLKOstdQr60ltM1tXVSOrXi
   zlW0iDGqDDVvGeW9sLID/M28pQmjbXV4Tt73iIeZTPl6GhCqUUtlVa4pg
   9o6WndeIcK+Xjd9gLKuyajnKcqjWBKKZDDhM8QQcC6vf1iuEO9Sri7qdS
   g==;
X-CSE-ConnectionGUID: ilO+XLZVS9mhK1+omnzMkg==
X-CSE-MsgGUID: T5TYfvUZRlK09H2abGvS0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3361661"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3361661"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:46:12 -0800
X-CSE-ConnectionGUID: /8D80C9dRterk8OTynfT3A==
X-CSE-MsgGUID: bQAW37ZfQryjjeqorwb7Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8724611"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2026 16:46:12 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mohammad Heib <mheib@redhat.com>,
	anthony.l.nguyen@intel.com,
	fballuch@redhat.com,
	aleksandr.loktionov@intel.com,
	luoxuanqiang@kylinos.cn,
	jbrandeb@kernel.org,
	Joe Damato <joe@dama.to>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 1/6] i40e: fix napi_disable hang in i40e_down() during firmware update
Date: Thu, 12 Nov 2026 16:45:55 -0800
Message-ID: <20261113004602.129864-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
References: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

i40e_down() expects its caller to set __I40E_VSI_DOWN before calling it,
as noted in the comment at the top of the function. All callers do this
except i40e_vsi_reinit_locked(), which calls i40e_down() directly
without setting the flag.

Normally this doesn't cause problems because NAPI drains cleanly on its
own. But when the hardware is in a bad state, like during an NVM
firmware update, the ring descriptors can contain garbage that
i40e_napi_poll() sees as real work. Since __I40E_VSI_DOWN isn't set, the
poll function has no reason to bail out. It keeps returning budget,
napi_disable() keeps waiting, and the whole thing hangs. The thread
stuck in napi_disable() is usually NetworkManager, and because it holds
the RTNL lock, the system can end up completely frozen.

Set __I40E_VSI_DOWN in i40e_vsi_reinit_locked() before calling
i40e_down(). i40e_up_complete() already clears the flag when the VSI
comes back up, so no additional cleanup is needed.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Joe Damato <joe@dama.to>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abbc71e815ae..dd729776c64d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7461,6 +7461,8 @@ static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi)
 
 	while (test_and_set_bit(__I40E_CONFIG_BUSY, pf->state))
 		usleep_range(1000, 2000);
+	/* required by i40e_down() */
+	set_bit(__I40E_VSI_DOWN, vsi->state);
 	i40e_down(vsi);
 
 	i40e_up(vsi);
-- 
2.47.1

