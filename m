Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F32C026B
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706902; cv=none; b=iVAynDOi/ysPrLS1SbEOBtetnc30USl3aL38EwfS5KtsUYKD8B1WdsbDwktE1+WxWm/srRnSmRgaCSRk+9B2DK+BZHTck5BoEO/lHEDwyQe1ZDleMbUYDxNTbZRdBI35S5XajugLLn5LhhGxmgJry770mwxoOP7gR7mWTz1+SGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706902; c=relaxed/simple;
	bh=QgCume/YiIZbU+pOzToRDP4XAUZGi51tXSf2VGd5oSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SJF6tFGZOlPYq6Y/CLgrUWurqfX4ArykHmKUKdFU8pG/U7uRkuGwuBe77zDI3UmP3hwhezFNumRRweffjPZMZZ0XXYlnZppOsomVYlXuzOfuICRq9L6+1CTBBHomD16qZCwTWOXihqXT7tX2QoGSMu0I0rdnOi14ara7yKeqTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RM4PXbMB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RM4PXbMB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761706897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q5JfqfTkgCgxYK5Fma50onse4VKplR92+gT5f4dX0V8=;
	b=RM4PXbMBa0GsvaYsG7gTCvdRaCsRnQrdimv3XkajbuU7Ed6yFyjBce1col0m3dPV/Y+Wwj
	T8rcLZTrxJQJZuUr/J/lYf7R9KUjhZKJL8WA3Wfleh8iWACKsxONshtchsU0ws6IchCy3P
	zn4uxobfX3Mou+L6YD4UgtocvFuRunk=
From: Yi Cong <cong.yi@linux.dev>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH net-next 0/2] Correct the config according to the motorcomm chip manual
Date: Wed, 29 Oct 2025 11:00:41 +0800
Message-Id: <20251029030043.39444-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

The default RGMII configuration does not match the chip manual;
this series of patches fixes the issue.

Yi Cong (2):
  net: phy: motorcomm: correct the default rx delay config for the rgmii
  net: phy: motorcomm: correct the default tx delay config for the rgmii

 drivers/net/phy/motorcomm.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

--
2.25.1

