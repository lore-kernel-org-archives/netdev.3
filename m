Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A43B47F5;
	Thu,  9 Apr 2026 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728621; cv=none; b=e6V1JB36j9tspm4eLUb62CT/fj3RyMgGMFt65nEavwxRhZ6LX8FLwJp89uSl8DLyslMz0oQ3oSo4WkgpIfpQSCS+DVznrngh0o6tsj6tcRSKpL4ymDvzAj6xEINgjxwOYA+A88UADoPUNyfuOqBYgcjq3JXCooRdhvkCmcvd4y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728621; c=relaxed/simple;
	bh=6/h4nzITUu9B5uG7FUZsIHiO0Nm982jwMre1DXBqc1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a39O8XDcFtqv8u2Rjoi24tIdoYQzY16pCY1YEs11ByO4gKfjZpoRleXBv5Ofz5XoTGgEqgBOCspI8GzbfDLORa/sby6ywyJyFYpNxN0H0NMmrXJVej3BnSHk7LGIQoEu7Tb3eZMl3lB+m7llOAaMgatfQ9E7jB1OnsJzTutPrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 3cUZaMjER7253qknEBP1kw==
X-CSE-MsgGUID: lHICckQDTYGKmcyDspLj5Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Apr 2026 18:56:58 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.4])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8E45E417383D;
	Thu,  9 Apr 2026 18:56:54 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	biju.das.jz@bp.renesas.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net v2 0/2] net: phylink: fix PHY reinitialization on resume
Date: Thu,  9 Apr 2026 09:56:31 +0000
Message-ID: <20260409095633.70973-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mac_managed_pm flag is set, mdio_bus_phy_resume() is skipped,
so phy_init_hw(), which performs soft_reset and config_init, is not
called during resume.

This is inconsistent with the non-mac_managed_pm path, where
mdio_bus_phy_resume() calls phy_init_hw() before phy_resume()
on every resume.

This series adds phy_init_hw() to the phylink resume path to ensure
consistent PHY state regardless of whether mac_managed_pm is set,
and removes a now-redundant workaround in the KSZ9131 PHY driver.

v2:
- Moved phy_init_hw() from ksz9131_resume() to phylink resume path, as
  suggested by Russell.

v1: https://lore.kernel.org/all/20260403111738.37749-1-ovidiu.panait.rb@renesas.com/#t

Ovidiu Panait (2):
  net: phylink: call phy_init_hw() in phylink resume path
  net: phy: micrel: remove ksz9131_resume()

 drivers/net/phy/micrel.c  | 10 +---------
 drivers/net/phy/phylink.c |  9 ++++++++-
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.34.1

