Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E264DD3BB;
	Tue, 22 Sep 2026 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119498; cv=none; b=ranRK7UEYLhb45hb2TrwMEVpl1Ji1k0zutrTVlqcQSXOQQlA6COOaBW3YNbhycJjXSs37yxn7jYT6Keu66jc/OYZSFdC8cHJpZ3InGlhAEVe2sLQxWO7Z/mDgm8W0KcsB2Y/Vh75mGfz/K5by/8WR6UlXbrcwjWkUeUXSsmhWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119498; c=relaxed/simple;
	bh=3ESlFTVnQw+iGUBUwrnIaZYqwZwtzk2k5d6ED93Qe/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JO3KAeZBoUp706oo3ZNxpr7B3yifWejS65wHQnXV2NJEPG/kko5pqfYIzYVZkdQaUIonITF0E7KU7DpTt5iymeYpGP+/AK+fQkpS/tStlJxo6W6vo+SwCDNcuWVZn4RKewRm+CFpNUBkrcyKRaPfYz6k9h12xnqO+SVsIi5LK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=v5JGT1LE; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="v5JGT1LE"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D979AC0000E3;
	Tue, 22 Sep 2026 16:24:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D979AC0000E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790119486;
	bh=3ESlFTVnQw+iGUBUwrnIaZYqwZwtzk2k5d6ED93Qe/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v5JGT1LE0Gv4CkFMucBUvuoc3xoleYSO1r8fKZyM5ROprS30Haqbm4E2q1Qz0Qfo6
	 Nkvy6Hy6XWADvC0ZHfacE6ADxR43dSbkkeJN9f6b/P4BDizhCSk2Kv8mzGKVr3Saq/
	 lCvorKbMA8b5UZHYpTMefMu/Zr6hW3Af9Amu/BK0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id B144CB04;
	Tue, 22 Sep 2026 16:24:46 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 09/10] net: systemport: Fix unbalanced Wake-on-LAN clock disable in resume
Date: Tue, 22 Sep 2026 16:24:39 -0700
Message-Id: <20260922232440.598918-10-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bcm_sysport_suspend(), the Wake-on-LAN clock (priv->wol_clk) is only
prepared and enabled if both device_may_wakeup(d) and priv->wolopts are
true.

In bcm_sysport_resume(), however, clk_disable_unprepare(priv->wol_clk)
was called whenever priv->wolopts was non-zero, regardless of
device_may_wakeup(d). If the system entered suspend with Wake-on-LAN
disabled at the device level (e.g., via sysfs wakeup control), this
resulted in an unbalanced clk_disable_unprepare() call on resume.

Fix this by mirroring the suspend check in bcm_sysport_resume().

Fixes: 6328a126896e ("net: systemport: Manage Wake-on-LAN clock")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 11b2cb4cc792..dedd49ad6c4e 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2799,7 +2799,7 @@ static int __maybe_unused bcm_sysport_resume(struct device *d)
 		return ret;
 	}
 
-	if (priv->wolopts)
+	if (device_may_wakeup(d) && priv->wolopts)
 		clk_disable_unprepare(priv->wol_clk);
 
 	umac_reset(priv);
-- 
2.34.1

