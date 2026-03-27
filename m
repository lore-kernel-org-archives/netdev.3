Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B82BE641;
	Fri, 27 Mar 2026 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774590063; cv=none; b=IQn7nYz23fSLDKmQIXHPccZ381juIX0SqdAbg7mZgcyOE5u63DhtPtkRHLiBcq0cDR5vs3pAElO2wftslDzu3WSF7G/gN4LorC6nHtwTtKf5d95WkibSIVkfBz3Vqo4P2ZIwOHNB8vjHTlYEa1fA++8hRBQgkZhucXp0J22UtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774590063; c=relaxed/simple;
	bh=WfxxW8kN7CO6dRGzFgBDSHBCJRLO3FSDU9x7tOvc5lE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mNJEVDQrrW/W+Ba3ALRC8KwM42z/2DqMQZgRlMPMm7WHV3/4QgGZZxOePqcxVhOeRB7yLb+yUyHD2ZgVtS3wq8Ukgpq5l/StmXNtoXssg5UefEz+zXfoCwwHYNqhgQlH1qX7nsqZEqT4vPc2vn+/mUF6biNHxtzIfS9LuzdLq50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lpQkXPJu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lpQkXPJu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774590062; x=1806126062;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WfxxW8kN7CO6dRGzFgBDSHBCJRLO3FSDU9x7tOvc5lE=;
  b=lpQkXPJuNMxgPlK4bb1VDamjcgoMBxd3927Dwl+hw1c+zuN2mFx7lats
   mJij9JINYdQ6y0HWlLMHeO64n4aZjeDrIEBQ6ilQGDVCUzptBc9+quAwP
   uFp8fQXkSbKMjshTvg2jeq2ZtRJCZ7fdMCMbE90CZVRm2/9v76ZkMBfat
   /ozZ3nRDsHCw+RPxIHnhU2x/tkq3lLGas71KS1U7Ui2vH4MDIakb9Of/r
   PrhDYsMYZyEPYNZhqKW7DR7UyhdZJXJ4qwJDwFja2AQqpRFeAlvEPsxy0
   yp1wrXesxWqR28Tra4y9n4GIt0XYQV6+R2ORVROrhqwfLU7pspR8Nkney
   Q==;
X-CSE-ConnectionGUID: xm++kwl8RKeu0DdLYypW9Q==
X-CSE-MsgGUID: 8g3cwKRFRjynbO438X3N1A==
X-IronPort-AV: E=Sophos;i="6.23,143,1770620400"; 
   d="scan'208";a="63044332"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 22:40:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 26 Mar 2026 22:40:25 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 26 Mar 2026 22:40:20 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux@armlinux.org.uk>,
	<Raju.Lakkaraju@microchip.com>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/2] Add RMII Interface Support
Date: Fri, 27 Mar 2026 11:10:06 +0530
Message-ID: <20260327054008.79294-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

patch 1 reads strap register to check if RMII enabled
pacth 2 adds RMII interface support to the driver

Thangaraj Samynathan (2):
  net: lan743x: add RMII strap status detection for PCI11x1x
  net: lan743x: add support for RMII interface

 drivers/net/ethernet/microchip/lan743x_main.c | 25 +++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  6 +++++
 2 files changed, 31 insertions(+)

-- 
2.34.1

