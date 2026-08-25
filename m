Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAB36C5AE;
	Tue, 25 Aug 2026 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686518; cv=none; b=GwDktpZsi7b9qEzEGYTu1eDL89FXTXCRjloFzxxLOpKqhQB2XARfN7OlbosQds7sFANPVtVgIcyKu0PzI6GhBg7Iqecqp3tRNaU6gXyc7KiBeKKDvvgOMBPHqa3rj5FPJX3u2leYCQ3FcvGjnqPaapFGLPYenvXLFVdcHGRgDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686518; c=relaxed/simple;
	bh=9oHgSdoPKrIRHt9vzeYkL6cGvVJAN8EHyVxHBnW7ZV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bp1O6L9Qz/i8Gan6AzPHj0jvTHy8BLh4NfXatTvi7RJ5YHJaUWkNNwwfr+p8rRBJjZUiSwJEWVPVihqLcNdK3fnrMjxcz00TaApWoYTMNDfIGrIqKsXYHFAnYcKgXZ5SBGgpsxZxdNwUP6j59lgtCqoNaOzF4mZlGDpYincUoro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=XWq1gi/F; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="XWq1gi/F"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B21E1BEEFB;
	Tue, 25 Aug 2026 21:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787686509; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=3kUsWigyCxlVGhk9F264e3SUeGKkjTppBYBtED+IPmo=;
	b=XWq1gi/F1tNldGLcCgF7FSNwjsuSxPNwaCX1oVWR6SjlQ4XTL/8CEnI9ZAVJqhOuTuOW52
	SCzt70A8w9cAx55f9xmTgJmXqvjNl9r9EC8gZ/bz0uateg0BG4KXOVTraRoCascVPm/flq
	nA/HjNPbtuKT6dUupQLdKXma6VJ5WTMAqq9MrcIW2hWcKdxfYHmJM9GQY0DSstXsuyk6oi
	ZkihEI1ehOyGsqO4paNd53IPdx67EvsO7cEy1kvZZip3Kh00rsw0V8swkQwwcDSElL+OmK
	xgjv235fgb6ANjTlejoFsD6Ra4X4SMa0vHw7Jo46K3BJU5n6EvYm7SPpIF0m3A==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org,
	ansuelsmth@gmail.com
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	SkyLake.Huang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	cjd@cjdns.fr,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 0/3] net: phy: mediatek: support EcoNet EN751221 gbit SoC PHY
Date: Tue, 25 Aug 2026 19:34:53 +0000
Message-Id: <20260825193456.1823985-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

NOTE: This patchset bases on https://lore.kernel.org/netdev/20260708102341.53919-1-ansuelsmth@gmail.com/

Add support for the EcoNet EN751221 SoC gigabit PHY, as identified by
product IDs 9451, and 9471.

Caleb James DeLisle (3):
  net: phy: mediatek: move mtk_cal_cycle_wait to mtk-phy-lib
  net: phy: mediatek: bug fixes to airoha-ge-soc.c
  net: phy: mediatek: support EcoNet EN751221 gbit SoC PHY

 drivers/net/phy/mediatek/Kconfig         |   9 +-
 drivers/net/phy/mediatek/airoha-ge-soc.c | 215 ++++++++++++++++++++++-
 drivers/net/phy/mediatek/mtk-ge-soc.c    |  27 ---
 drivers/net/phy/mediatek/mtk-ge-soc.h    |   5 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c   |  29 +++
 drivers/net/phy/mediatek/mtk.h           |   2 +
 6 files changed, 250 insertions(+), 37 deletions(-)

-- 
2.39.5

