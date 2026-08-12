Received: from mta1.migadu.com (out-66.mta1.migadu.com [95.215.58.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E498437451
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539117; cv=none; b=HF6dpOVvAvWDxoLgFlBkcwf5sO2DUDYR5mOKNtlgB18n200+7Px2QX1lv57ZbT/H5V63ngtNjYjeEMbM/e8VNaA0Wj3gqUZ5jertSnPbZQQmM/gzkXvuHFUlcDITv2Kh9OlLsdZCT/0UZB7lRZlcg32nNjZfz87DVH3QWL5EFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539117; c=relaxed/simple;
	bh=Qjnop9j2X/1Os1KYlmKLS9t2hZUc3XxUcojFMj8CT1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDPWrXeu4yndCvvmzeen9O9o7g8YsHaXTgffaXy4yzeghGfU4WxIh24tBV/5gCpy6Uj/NfAFuDaoSWdiuQk6jHccikyXQCeX77jGjPnod+sViDZfj5QdyIfXMIFehtFAzRrMvc3IfNtd/PXEThFTkssUP9+Ss0cFnbgyzL7EB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ldM7R4dZ; arc=none smtp.client-ip=95.215.58.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ldM7R4dZ"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Qjnop9j2X/1Os1KYlmKLS9t2hZUc3XxUcojFMj8CT1Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786539114; v=1; x=1787143914;
 b=ldM7R4dZ/gizPo6JgVUufwhwUJ2Rnoi+D8g/b1D4BjyDLZuy6z1tS6UvKQBq7Qz1ysR1uwzz
 fPOszbS3WOH7us5MmyazNPIhAeoqT98fpIhKRZ7nvJISToWW1LheGxNkzy1q4DR36TkeEWuS6yc
 t8TEAwUHk06MVVeqk1P97oLA=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id d88830cc7a4eeb64;
	Wed, 12 Aug 2026 12:51:54 +0000
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1 0/2] net: phy: fix driver cleanup after probe failure
Date: Wed, 12 Aug 2026 20:51:25 +0800
Message-ID: <20260812125127.106255-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Patch 1 splits the phy_probe() error paths and makes phy_setup_ports()
unwind its own resources.

Patch 2 calls the PHY driver remove callback when phy_probe() fails after
the driver probe callback succeeds.

Xuanqiang Luo (2):
  net: phy: split phy_probe() error paths
  net: phy: call driver remove when core initialization fails

 drivers/net/phy/phy_device.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)


base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.43.0
