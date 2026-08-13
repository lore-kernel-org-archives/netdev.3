Received: from mta0.migadu.com (out-32.mta0.migadu.com [91.218.175.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BE412BFB
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627824; cv=none; b=VdDxNAedfq6jHE02vSAFqSv4I47X21P0GlToEyzG68+QPYq4Pyi83ZKNayZtWTo3FMzWculWSbk+91tSAEP6bUZ5ijxYa25r4ETVOG5LMO6vW7D3BuQf4CiUijcS3O1f8wyxGrB3gGzzTl3YuxD18LIvBoqrb9nnjlUspDgwZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627824; c=relaxed/simple;
	bh=84ItSrTAzDge5vQVE0g9FnTODG6xfS9Fw3jEzj4j7/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgqEp44ikxo+27Gz4XBxeKKbZcxD3jmf7Nc3HLBXU13YAaZpK9ESbTibQVvWgJo0Eg40dEPbOLMDCaqJcsTjIHlVpqlDtrOq7URRvU0MdFxUUNSC9rtRGB+U3012hljPheCE45Hwm0UkjeSrdcUgmvYOoBgWyfNuqQLGJZafD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqhaRfda; arc=none smtp.client-ip=91.218.175.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqhaRfda"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=84ItSrTAzDge5vQVE0g9FnTODG6xfS9Fw3jEzj4j7/M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786627821; v=1; x=1787232621;
 b=RqhaRfdaM9G2P6dJH2Pb5jbXUvml+V2Jc686CotHuVzy8Ss8svUXn0c6j1FbWcpUPNbA0TNb
 PU9/rLhw++fBg0L3WvcG9LrRzFraldAqmGlXIJx1CX8hSJZip8061/scPpGs8hFB0hU0CVLUPwD
 gg844TYbuGGVgru6ca/CJMvU=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 170d6f0a33b4d479;
	Thu, 13 Aug 2026 13:30:21 +0000
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v2 3/5] net: phy: restore device state after probe failure
Date: Thu, 13 Aug 2026 21:29:43 +0800
Message-ID: <20260813132946.116176-4-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
References: <20260813132946.116176-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

phy_probe() sets phydev->drv before calling the PHY driver probe
callback, but does not clear it if probing later fails. It also sets
PHY_READY before of_phy_leds(), leaving the state ready if LED setup
fails.

Clear phydev->drv on every error path and restore PHY_DOWN after LED
setup failure.

Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/phy_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9c7ed9c61e6d5..c9e75bd3b81a2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3821,6 +3821,8 @@ static int phy_probe(struct device *dev)
 	if (!phydev->is_on_sfp_module)
 		phy_led_triggers_unregister(phydev);
 
+	phydev->state = PHY_DOWN;
+
 out_ports:
 	phy_sfp_release(phydev);
 	phy_cleanup_ports(phydev);
@@ -3828,6 +3830,7 @@ static int phy_probe(struct device *dev)
 out_reset:
 	/* Re-assert the reset signal on error */
 	phy_device_reset(phydev, 1);
+	phydev->drv = NULL;
 
 	return err;
 }
-- 
2.43.0

