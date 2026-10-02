Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456F32B115
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951306; cv=none; b=gRq3j1xxkYBlwq4T2ITYmX8NFqAnLVQskmrvehWs8XbW9J7vwh0bIvYjvvQxeeQ4IRbZgT0wtUO0JeFjgxuqcGN0qOjgMNe1Jizq9hgwNN4BaBSOZRfBGFRMOFjWVZ0Itzu4MdAVBvUdTMMUx6le/KHTP9pyk6NULsYE2CGvxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951306; c=relaxed/simple;
	bh=L7ol1ikwj5z7l/6pBy/4SyKPZTjf7kJTdt00bJ1idkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OROX9sBdXuImxqZ+W9zfQCB6TCyNf7aYqmEmhlrlsxgrKQwXrry974BPIR1C5thb8pZEAGLc4gJ6vpzNyYMTU31GpsrnZddVTf5rUehV5ny9B7KZvl4YHtLqUfapR+WbDzTm8FAeYjCtfmXdlTKZwXzLokvXIxdbM6YkZnV6Ck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jlmd7t0K; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jlmd7t0K"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A8814E41105;
	Fri,  2 Oct 2026 14:28:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 690BC603DC;
	Fri,  2 Oct 2026 14:28:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C157F103281DB;
	Fri,  2 Oct 2026 16:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790951300; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=cMgf3Fui9Ix2ajtwXUt15vsAOgVEpm/AVvj+X+LKiz8=;
	b=Jlmd7t0Ksr8v1Qb0dLbT7iFrN4AKKOWXIWqi32LAo4iTjEQOQkZY/3JVUTAJP/t2i/uUuk
	EoVQ9ipfm85i0zt38mUyUnBwpdg9xN8xHzdgl5na8J8ciaLCpiyqHZuTASsaa+aXFEu0E9
	K2mZlHYUhw6omq0RaX0kZMDjZxCGAd6O3gTLk5LtEyKUPWDeo5qBsuTYtI3eSmqF8QjrxC
	/Q2nASK8YpoS/59jgV5Vtvbj/bZoPd9Ty0FUwkGgdn7J3WEO9jd8vfCW0Frthp8pjSU6pW
	Qfe87rRqfmfP2JzQzLX5ieK5f1ZSs0SkifFY45Wi7itJiqiNKwmbSLCIxLssPA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Peter Robinson <pbrobinson@gmail.com>,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v3 0/3] net: rss: Consider RSS not supported when key and indir sizes are 0
Date: Fri,  2 Oct 2026 16:28:00 +0200
Message-ID: <20261002142806.1299041-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

This series follows what used to be an stmmac-only series to handle
devices that don't support RSS but still provice the associated ethtool
ops.

There are a few drivers out there that populate the RSS ethtool ops, but
don't always support RSS. stmmac and mvpp2 are such examples.

Following discussions with Jakub on V2, patch 1 makes so that returning
a 0-length key and a 0-size indirection table means "we don't do RSS".

Patch 2 introduces a helper to check for RSS support in stmmac, and
Patch 3 uses it. Patch 3 has been reworked so I haven't applied the
review tags, sorry about that Joe, Lorenzo and Nicolai :( I've drop the
-EOPNOTSUPP return from the rxfh ops as we return 0 on the sizes.

V3:
 - Add patch 1,
 - No changes on patch 2
 - Removed the -EOPNOTSUPP returns on patch 3

V2:
https://lore.kernel.org/r/20260928145043.1228968-1-maxime.chevallier@bootlin.com
 - target net-next
 - Add a dedicated helper, following Nicolai's review.

V1: https://lore.kernel.org/netdev/20260926093343.292181-1-maxime.chevallier@bootlin.com/#t

Maxime Chevallier (3):
  net: rss: Require indir table size or hash key size to support RSS
  net: stmmac: Introduce a helper to check RSS support
  net: stmmac: Don't set or get RSS parameters when not supported

 drivers/net/ethernet/stmicro/stmmac/stmmac.h         | 5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 6 ++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 4 ++--
 net/ethtool/ioctl.c                                  | 6 ++++++
 net/ethtool/rss.c                                    | 7 +++++--
 5 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.55.0

