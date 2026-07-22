Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16892357CEB;
	Wed, 22 Jul 2026 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727722; cv=none; b=uP3aBsZoWtW+c5fGV+CbhWNgOwTdlHFmiuY7p4tmS/ur3XMa7MCoTpNcxq+w1whN15MLR9xtbbod5krwo/DELs3ToB5AlaWIIIlQtcCelSR2JXfmSgBYM3eOBPbW8yMmofDgpI2dyK8x9fTiZJYQ7m45g36tRggjtvLsFmAM4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727722; c=relaxed/simple;
	bh=Nk5yNrIq2b16SrY4DsqCe134Oj8WUqTZDJ8V3R4F07M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L168QRDDol+Hmv0+rnWg81PNcILC83cNW9v76FOZbOz0IXjxl9nNYz9zYw4x5MgZXFjlLCtQrkuhBqAie613CldMlVKfQNdH1VQErYHnipkLpOPQv4bSq4Ew/GOxeax4fCYCcaZ323Oz4Bew5iWWihFc+m5y74Dm60dZ8n+UWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=lwGhmCXZ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="lwGhmCXZ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D53C4A0043;
	Wed, 22 Jul 2026 15:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784727709; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fx9Zm4a+drnSa6t9+l+HA9whVRyNfQ0OEOV5Pg/vEMo=;
	b=lwGhmCXZKrVPj78vEtuIUsm/H6nbY2M0NjHTEMeCgBxv6E/O+nY///9J54l8bMY3BhlftW
	TmaxlpmngaLZX5IoHV1XZ0ggToyf9RHHCMmp5PUPekduVgHnHCUNPMM4tRp0PaMOkN5hpP
	2bSV04XkU1s6EYJSBz1GcMM3C7P17OJE9BuarN9Q6HszsZtGggsaQEDHoiLjF0SKGGV5sZ
	CJXXZgcrt4F6DP1AWOYZMoTFl4y0VNUKk8pxsCTUlkjm61VfLsUbnPKFA3VlUSevK1fXZH
	XBNlUExegr19Rg4vT7XbYXncRvnEV1UqbhJo7aJvSnQFTGAjOoc7yklpPhLh3w==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next] MAINTAINERS: remove Rengarajan Sundararajan from LAN78XX
Date: Wed, 22 Jul 2026 15:41:43 +0200
Message-ID: <20260722134143.4141579-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Rengarajan has left Microchip and mails to his address bounce. Remove
him from the USB LAN78XX entry.

Link: https://lore.kernel.org/netdev/DSWPR11MB971547088066C2CA91638F3BECF42@DSWPR11MB9715.namprd11.prod.outlook.com/
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3218abefd0c..81f30ad3d616 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27922,7 +27922,6 @@ F:	drivers/usb/isp1760/*
 
 USB LAN78XX ETHERNET DRIVER
 M:	Thangaraj Samynathan <Thangaraj.S@microchip.com>
-M:	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.53.0

