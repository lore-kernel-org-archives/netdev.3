Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3F5C613;
	Sat, 11 Apr 2026 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866416; cv=none; b=hw+tVCPzaOkLWMxYWR0hYxR+JWqIDZUwFhuN/3OjxX5s8405ZJuBIOIhNCylPdbFsAU8d+cQ4W8oQTk7UP5qo4HIEBgdwJXjw6Ekvvyxdb+WEIO13N9pue0ydyUUr72KDNKPp4jQSvBSDC3qW37myNCqvKKNV/uB6L1KHUHSV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866416; c=relaxed/simple;
	bh=yAAdmOZKpv99C/luaQ0g3MwLJPzvqepHXiaCtGJ1Xck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FZ9tJbpSMR1Ff2U8kTJR4tZT3AFI1KOlRCbnu3tS165Dxthxnr3k9o1Pnu/K6wvEtSs6+xLoSelaUSTWde2MQez1CCbLkIIdrPzKn+KljAWXzdOOIWoE2fdCPsAzweziFAEwADdAFA033uNAO0wAW5KXE6sjjL4zVXx/TGh2IB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wBLyX-0000000071E-0Jzd;
	Sat, 11 Apr 2026 00:13:25 +0000
Date: Sat, 11 Apr 2026 01:13:21 +0100
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
Subject: [PATCH net-next 0/2] net: dsa: mxl862xx: add statistics support
Message-ID: <cover.1775865049.git.daniel@makrotopia.org>
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

Daniel Golle (2):
  net: dsa: mxl862xx: add ethtool statistics support
  net: dsa: mxl862xx: implement .get_stats64

 drivers/net/dsa/mxl862xx/mxl862xx-api.h  | 142 ++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c |   8 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c      | 325 +++++++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.h      |  94 ++++++-
 5 files changed, 565 insertions(+), 7 deletions(-)

-- 
2.53.0
