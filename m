Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E12411A0A;
	Tue, 22 Sep 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115983; cv=none; b=pyCGASiPIcOiQRsFeRc6RxlR+5S2RFOV8bwnRnl0LYB9UUHSZeDOMkSxHTiUBycRtQGdv+3U4+K5Qd5RSUBAmOdmwc3z1cxQMvECDDmyCATFOS4LV841bQnxN91jfkwopgLgwTZao4VFvvk5CFByxSX5q8xmYIPDsiKc6xIXC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115983; c=relaxed/simple;
	bh=8zZA/j2SelxQbyk870RC9oBx7y7qA4imd+qRsKQOl7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dwuF5im/kS0xoohGcrqyW25o7qee/38tTKLkZZaI8GnoS1aRUvf1Vrs4Xq0HfsqYiueoA6Raa21usI7MLiFFpVBRTOiWKAcbMrqq3if79hCaTmGdv+ANazzDM2pRlDbqLh92M99poLKP17DuFegSef3+1ZZhHLjeXXDY9zWQJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=md8ul0zu; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="md8ul0zu"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9E4F8C0003C8;
	Tue, 22 Sep 2026 15:26:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9E4F8C0003C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790115974;
	bh=8zZA/j2SelxQbyk870RC9oBx7y7qA4imd+qRsKQOl7k=;
	h=From:To:Cc:Subject:Date:From;
	b=md8ul0zulFvfIEIk4W4Nc2pjesAolW1BOxOb0/rebMy64WNv+y6Pgi8EXXdi6y26Q
	 9dbIe5JD+bWp4+Wa1fljrCrmKM+6P4zPZdtk2X/ygqTk8+eGtQFkS6N1JEGS1wjstO
	 QqspII7R5jc1KngzRyy+HIA9Cc4gTXa2y7BlcCJU=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 35D23ACC;
	Tue, 22 Sep 2026 15:26:14 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 0/2] net: broadcom: Couple of minor changes
Date: Tue, 22 Sep 2026 15:25:23 -0700
Message-Id: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first change makes sure there is proper reference counting handling
in case of error/removal for the bcmsysport driver.

The second change removes duplicates definitions in the ASP2 driver.

Florian Fainelli (2):
  net: systemport: Fix missing phy-handle parsing for non-fixed PHYs
  net: bcmasp: remove duplicate MDA filter register definitions

 drivers/net/ethernet/broadcom/asp2/bcmasp.h | 5 -----
 drivers/net/ethernet/broadcom/bcmsysport.c  | 8 ++++++--
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.34.1

