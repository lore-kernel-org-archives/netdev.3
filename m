Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D3478E5A;
	Fri,  2 Oct 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935242; cv=none; b=gdS+CBXbFE4rSeNg8spRfJxsNvtdedcO7tH05fwACCXqqdl2RMIeLErsGhrrKlM8y+e7zswAhHd9pnwAJlXo2JuCc8noMvpim/65nNx6o8hIZx8UCD5ILNHrY/8T6dc8H5+vWJ3VIO86zE5VevQ4KONlt1os6f9t1F7gMwo8vAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935242; c=relaxed/simple;
	bh=ogXDivCxRiPGITKF1nL7p4Z2Jai609DtCCi3zdHwRf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtGPsSIMGdr5mtiU0UfIaVMNWjjW6xnaKo9oJXxLLZ/FzwVP1va4LOnJP63jB5CUL8ErSwSX2Ex7DoJfptRHAtr8I/UulTIRybY34R5PSk7xIzKCp3cS8oR5suYiddGUvvyXzFW7QFnCcMTmntM5X/CBgItQefVTfXR8RdB5kSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YY1mCrbS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YY1mCrbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790935241; x=1822471241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ogXDivCxRiPGITKF1nL7p4Z2Jai609DtCCi3zdHwRf0=;
  b=YY1mCrbS2h8lN8+pToOx3+RyzLJOQtJVaB/DEm7M97eVTQZ2aktmMS9x
   NycD8irigWKtH8evpDE1RjI0dBTC2bzSHBNUspMvjpayMAQXWzuntWK2w
   KlQpf2GfUFS0oC3Rh09DDABAmcQlH4Yi2PjsYVT1vGP1e3zlNeLPpgYAP
   QltOcq4aCYuBIWu4vO5SNXnOkVI9smy60ax+lwpV6mw4KSS4vSiWmIWjn
   hNbsRllR7LAkrC92LlMR4ye8iGM0uyZBE57O8cLbO0DuKuU1Go9uE51Rd
   RA635jIbng40cUcBplkTFwmP/ga1sTTca9VKLqnM4PbibzZ89uQ+H+wao
   Q==;
X-CSE-ConnectionGUID: Z4o9xvXQRvS3tu94fF8SsQ==
X-CSE-MsgGUID: DB/D+ZsCRIqe74w10vF5RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91563155"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="91563155"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:00:40 -0700
X-CSE-ConnectionGUID: /mnfhdFMTHmISrUf2+gxIg==
X-CSE-MsgGUID: cFYGq5sORVSmVMBi4btGBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="314204943"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 02 Oct 2026 03:00:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 47B3E99; Fri, 02 Oct 2026 12:00:36 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 0/5] eea: Improvements in the driver
Date: Fri,  2 Oct 2026 11:59:18 +0200
Message-ID: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My attention was caught by the explicit call of string_escape_str() which is
not required in this case and saves a lot of memory on the stack (see patch 1).
But then I noticed more to improve, hence this mini-series.

In v2:
- addressed Sashiko conserns
- added patches 2-5

v1: 20260929082722.3368741-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (5):
  eea: Drop temporary buffer by using %*pEhp directly
  eea: Remove unneeded assignment
  eea: Refactor error handling in eea_adminq_config_host_info()
  eea: unify return code variable name
  eea: Use 2-argument strscpy()

 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 65 +++++++++----------
 .../net/ethernet/alibaba/eea/eea_ethtool.c    |  4 +-
 2 files changed, 32 insertions(+), 37 deletions(-)

-- 
2.50.1

