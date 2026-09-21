Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B904483A6;
	Mon, 21 Sep 2026 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032477; cv=none; b=Z4UXHuXvROx1NUKEOJdiqO+m/mc7WHcjAvDWAN8dsGtlaJSyNsUKIxIHdbLI4gUgzXe9/SvidFVsiAxZoMJEGmCXIqc8rnqps+ecfNLnHwGAIkhFyBfLd7nuiyEIoXnSVjwxYXrJQKcySab4TUG+vjgs9HRCyzcukGgvD92epLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032477; c=relaxed/simple;
	bh=ADyxWm85hREfXI/zUlXqlXz0qUfjpUc+UolH/uIxQ+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzCnFK6ANwkuGUG9mekJYtH1LMI/8s3CO0VrWlqvTgKgTS1mcAH+6ViHHcR+uy7m4TM2aOrfZHn3+JeQR6JLcHi2veC6Eg7yBOfie+3SZK7z6Yesuqu2E5Ks09bJl2uEdyhumjq1Rm67Rvl8/WB8vmC1x5aMPHqtYbyb/wC6vMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CW0GtAQp; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CW0GtAQp"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1C0BFC0000EC;
	Mon, 21 Sep 2026 16:14:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1C0BFC0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032474;
	bh=ADyxWm85hREfXI/zUlXqlXz0qUfjpUc+UolH/uIxQ+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CW0GtAQpDchjq9pY3an9AD0456XcwutFiMwDaLFKoYPqHMU4AHsmM7F72j30bgn2F
	 jbPajRMukBiXhjoee00O1pWu+PId3ud/WFAjH1ETyUEkHZL8SJskp/5YIYYh1oUBQc
	 WdpX8iil4MfOVCIGqyeXzPsuADZnd0GwoxjFEZ2M=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id D6C39AD9;
	Mon, 21 Sep 2026 16:14:33 -0700 (PDT)
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
Subject: [PATCH net 10/12] net: systemport: Fix unbalanced Wake-on-LAN clock disable in resume
Date: Mon, 21 Sep 2026 16:13:03 -0700
Message-Id: <20260921231305.394773-11-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921231305.394773-1-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
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
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 384423b312ca..dd5a7c9dd90f 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2803,7 +2803,7 @@ static int __maybe_unused bcm_sysport_resume(struct device *d)
 		return ret;
 	}
 
-	if (priv->wolopts)
+	if (device_may_wakeup(d) && priv->wolopts)
 		clk_disable_unprepare(priv->wol_clk);
 
 	umac_reset(priv);
-- 
2.34.1

