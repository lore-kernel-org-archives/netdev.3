Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCD1F5EA;
	Tue,  7 Apr 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583039; cv=none; b=J6dB8owLvMw1Np7ARX4exQScDhdeWrZgD83SpuB3AXTBqAjyhYO8lH3r1XJ/5uSFTnFRDpZamw+hIN8zJu1+1iGg89EekuMZA/3Z7e/8STiOFMk3TQfMHRFf9qiGV0wyN17GNt5yV1S4Nu8GDiodoAeIkcOf9RbdR4h8KAS0NgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583039; c=relaxed/simple;
	bh=tQjVTZmd5BcBF+eRMRYSIJTOXaLpx2bY8zXTIctg6DA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fAPCB3WNy6C8ROH7phniFULyZrHpgdpauD94ZAFPnAQyIJYgpUB1grOMVJ7VcBhINlDGLJmSbm9Iwo6cWK2+cTY0DtK41laPKGFiL3GllKLpMeV8PPf3XblyxoNpBc/2vIo+tHCaF3l8mTjsXS+1OF144cLlE7KwrGuK2oqHgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wAAFp-000000000ns-1y9d;
	Tue, 07 Apr 2026 17:30:21 +0000
Date: Tue, 7 Apr 2026 18:30:14 +0100
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
Subject: [PATCH net-next 0/3] net: dsa: mxl862xx: VLAN support and minor
 improvements
Message-ID: <cover.1775581804.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series adds VLAN offloading to the mxl862xx DSA driver along
with two minor improvements to port setup and bridge configuration.
VLAN support uses a hybrid architecture combining the Extended VLAN
engine for PVID insertion and tag stripping with the VLAN Filter
engine for per-port VID membership, both drawing from shared
1024-entry hardware pools partitioned across user ports at probe time.

Daniel Golle (3):
  net: dsa: mxl862xx: reject DSA_PORT_TYPE_DSA
  net: dsa: mxl862xx: don't skip early bridge port configuration
  net: dsa: mxl862xx: implement VLAN functionality

 drivers/net/dsa/mxl862xx/mxl862xx-api.h | 329 ++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h |  12 +
 drivers/net/dsa/mxl862xx/mxl862xx.c     | 793 +++++++++++++++++++++++-
 drivers/net/dsa/mxl862xx/mxl862xx.h     | 103 ++-
 4 files changed, 1219 insertions(+), 18 deletions(-)

-- 
2.53.0
