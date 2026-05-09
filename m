Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858C2BE05F
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778360945; cv=none; b=jYr/58oRwO0FWx60BsUGELuTdnNUGbQVPiyLb2Pego+7M4mBfVwNX2qjtoLILfyfAGJ1ZqiWS2Qp7KJQ8GeYecyaCD96I777NWWcOIRE/MSbKHUZ/TaqU7jDbrct8lMMVDQjPyyK3WOlNGsUFAoOnU6r/OucpLGtdmBRBqphu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778360945; c=relaxed/simple;
	bh=TnETIFk+H+8tFUV13FM4oJ1w9TnIrYEjwMApf6M/IHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJzcZ6W2xvmDHwRdA0DOAO5EZQocaBMG9L/7TLP7Zh7khnZFTi2HpV4Hp2WUWVn43ZRkJEKN9R7iKTA6PmfQ83tT6tJ+xkP2sST5GUE+azwdQ0flYPcyPo4JShaTBgUDWIfHQVTcyn6i2Uh07ys9sWmkIchuer8M9sj+j7g3hKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=i3Rtj8rG; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="i3Rtj8rG"
Received: (wp-smtpd smtp.wp.pl 25985 invoked from network); 9 May 2026 23:09:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1778360942; bh=gektusWab+Dwz5t/8ZFnnYC7/F3SD8mSHOJYB5NLfQ8=;
          h=From:To:Cc:Subject;
          b=i3Rtj8rGEPQ2iHp4KpBGA7YzLlVMQJ4a/vStc4aJtmyoy4cDeNU5ahCx4N2qTMFnq
           ZpMBK4ZCgBaCFxkCo5P2qwtTNTNI9lI5qiAnS/bPhxuxqOVuRa6s3JzNVjIZ6CxbY7
           owVBik88b/AOU8h5BRbiQCPdvEUm4ysiLwzwleZ9oAUO7OoHWR6lmhbtUQSAy/f2w8
           AdU10AVg90cy3teUBY6GuQjEOf27nWfn6un9vRq93eqSskhSvNmd5ILKfg6J1nD3fH
           UW9FoyKcjPht+u/Hz/m4LZWl6w5i9ICPC3T3XG+/bQaQhdGJ/YtZuhwZooVe2RUzX5
           xkXyx42rPSCSQ==
Received: from 83.6.112.20.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.6.112.20])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 9 May 2026 23:09:02 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	dumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH net-next] net: phy: intel-xway: fix typo in Kconfig description
Date: Sat,  9 May 2026 23:07:22 +0200
Message-ID: <20260509210900.3968447-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: d7069f540c84f6bedcf390eb56133077
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YSP0]                               

Replace "22E" with "22F" in the description.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index b5ee338b620d..8b51bdc2e945 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -238,7 +238,7 @@ config LXT_PHY
 config INTEL_XWAY_PHY
 	tristate "Intel XWAY PHYs"
 	help
-	  Supports the Intel XWAY (former Lantiq) 11G and 22E PHYs.
+	  Supports the Intel XWAY (former Lantiq) 11G and 22F PHYs.
 	  These PHYs are marked as standalone chips under the names
 	  PEF 7061, PEF 7071 and PEF 7072 or integrated into the Intel
 	  SoCs xRX200, xRX300, xRX330, xRX350 and xRX550.
-- 
2.53.0

