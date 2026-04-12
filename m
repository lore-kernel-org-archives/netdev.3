Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726838D;
	Sun, 12 Apr 2026 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775952123; cv=none; b=QZBYMrmjNZMAJMR8h2t1mrRtvP0nAbnkmepFOtFqS+tEEzXcDT5wHiV1KZOB+qOisr8+Cio4ZEmDfqswL0lgCPc+afgYYQU9pBbI4mUj5/CUlh7v+MRMVuhBazLML69j4BziTFN9Nac5KE9lNxLLCGFR/fuyyDQHNeLwgqMzqtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775952123; c=relaxed/simple;
	bh=cwL10PrR3GXxmukoPOvUSq4mXtRMzXknFvBYwkaVzx4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XLr9u+iN1TMV+0wQbZdJmikHubs7NjhmA6LfDXmyV9yU0z79O/XS4ZLTCmUwAaBlfFz6yT9i+MG+OECy14JRW8Pzp2GB9bwciAcTi3czQPVagXVe25Pidx18LFy7CnSbHS95R8wPNcVfrHnnrXt53+/NuexKieSojlncQIPtlUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wBiGt-000000005a2-3AiZ;
	Sun, 12 Apr 2026 00:01:51 +0000
Date: Sun, 12 Apr 2026 01:01:48 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 0/2] net: dsa: mxl862xx: add statistics support
Message-ID: <cover.1775951347.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add per-port RMON statistics support for the MxL862xx DSA driver,
covering hardware-specific ethtool -S counters, standard IEEE 802.3
MAC/ctrl/pause statistics, and rtnl_link_stats64 via polled 64-bit
accumulation.

Changes since v1:
 * trim mxl862xx_mib[] to counters not covered elsewhere only
 * remove histogram counters (moved to .get_rmon_stats)
 * remove RMON error counters (moved to .get_rmon_stats)
 * remove counters already in .get_eth_mac_stats
 * remove counters already in .get_stats64
 * add mxl862xx_rmon_ranges[] and mxl862xx_get_rmon_stats()

Daniel Golle (2):
  net: dsa: mxl862xx: add ethtool statistics support
  net: dsa: mxl862xx: implement .get_stats64

 drivers/net/dsa/mxl862xx/mxl862xx-api.h  | 142 +++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |   8 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c      | 348 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.h      |  94 +++++-
 5 files changed, 588 insertions(+), 7 deletions(-)

-- 
2.53.0
