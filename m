Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F3273D77
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777698469; cv=none; b=rmkuCD3KL24l5aGRdNCLGqyRqWefA69C03+rxQOeeIyKnMu+yAoUBRmuo+aqFTQVm/uvYptKw5cyEWbKbYC6jUeDhLJfi8cJzW4GVQbWn+s4QXdfYPxkHl+LyaR7WjUPSRLTru4Ls3bs+26bHeqw3unTBjcDuinwCIYSF4uhe/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777698469; c=relaxed/simple;
	bh=M7eXefBZbvtTLvDUAWBFVtM+mK72e8gioWagVIzC0bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ne0dm8b0Ofp4CiEqpAXkPyfD+sl53ODesKtTf93WRpAFu/DXMJFMS4BH+d2gIiufyC+AScFxzUxPH3ILX80Zz9lrJPtrFAxvD14z+dLF+vJo40EdVGEHYHpPEmed8W09w6twgbG7sOVji2MnqBjVzS1x2rlQFeUFm98mCE3gFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2g6+uwd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2g6+uwd"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a8fba3f769so9810755ad.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777698468; x=1778303268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9PB/D/JhFEvy+R3A7+7Tb+xDlORxmPJZApX2c7GDnA=;
        b=H2g6+uwd/ompmj3TnorczF0Jjk7X5sLjKaPhBIwkMvYy99jCJhTaU4XlLYdnWwrvwc
         gT23Ym2dLMHTVsmKS9dxxDADWLzLVyYhyaGhbwMLl2KEHfn9gOxItyF16HnMr3XY/KW1
         kl1l3zYWwiEYgeRQMq1l/19RqCdiPyyhfbc4/LJ3ssEz6Kvr2avxXNMmULIMuNo5fZnI
         62oxsZdsMayc9bTwVpuKvDF2rdJEhzL3qPNu27W9DkBNt6OMGfu6daqHBAqzqLOpnD1r
         UjlD9Hn9KuPpi3V1lIrQTpFCI+Rled4k3/vDXb9iOAWIQWMZCvN43C2Gooc0avZFYuEO
         VwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777698468; x=1778303268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9PB/D/JhFEvy+R3A7+7Tb+xDlORxmPJZApX2c7GDnA=;
        b=UkXyw86LV8ehK7zo9QNys+HIA6B6doPrWfC01uOthIM6lOtacD8QRGbhbwN8PiwF3T
         3e3hmrdvQEC3FMuNDzhui9qteKitwDbeL/r67m7xGI4l6tgAOHZavOwGQgHacADbz6VB
         MWCMQmMHCEyGsNTCEGFQfzY/ypEYjn3FOHqMv/Wh4ojI8YPjYUmFkE1qK7KXt2SB3+pI
         uFBpyXt5EetnC4y5yLFC4ydKbj44fA59sQv8EGcyLhAIvvMUounvqjWuSI9inx1K2/TG
         nmDqsVvjYiyq90ta0DEZnXViiIBSdAqTL68pMRMdCDRB9QPfUsagr1RsLVyQtb5TDbLd
         2PvA==
X-Forwarded-Encrypted: i=1; AFNElJ9fjqcbEp/9H74FdDiDsHdHkuWrcCSbRRjHe59ZssWm+iZt2m/Eiva0K1N9xKgZKjx4A+uubyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM9BnMwJT8Hr31IT1m6mo3rNQZqzqk8UAcGR4HFxRYPrbcGPuH
	4crXC9R9RcnNJphJBrvP/zYk9JDj7dAV9l9UJuCRUKQyh2T+OvdKqX0=
X-Gm-Gg: AeBDieuRI47mNaD3nvtLCrxuacSFdN0WI4iaRzyqP0ZQjaaIQZTWQYbUTkBeUto0fDr
	WzOqik1f9OemVUsDYevRDx2vZjd57Yr7VO1/Gfur3YnQhuc2Fl2pWoxGuXF81EKl/pE54NLf4kJ
	pZZqJa8VKcu/uCoZNxX4J097QURCH4oDz383Tw2RjenuIshvWMw3OIrjXmCUXIboXD/0biNgEUN
	SuFfFC03l4hqfMoErHS5T5RWsHnMqpwqnXR3hDYTfnCI0l3LuY9UxyFnAxcR3Yehd8X9evVOq3r
	ESSSOsDJNy6fm/+hScBMafwAO0Rt3ZUR5HU0RVAfro2ChuZvYWFMu5OHpxAsTGAyxqsbTrG5UFk
	JJhRAtj0duuihoJrNgMwh117h/pEnqOyAAIe0dE+Mz829RLn0GUmUhJ4iNjcVgg/yVlft9Pojwy
	vUAyvXJ5NH0p5rUJbcRzdGQaktKTEruM8tWGVTwaKk/BeKnBzGeUWwzfEkihSrIFuHoPMqGfEy5
	4IDbth4CA==
X-Received: by 2002:a17:902:ce05:b0:2a9:e8b:5326 with SMTP id d9443c01a7336-2b9f2808c9dmr18991085ad.23.1777698467520;
        Fri, 01 May 2026 22:07:47 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e44bsm38263715ad.11.2026.05.01.22.07.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 May 2026 22:07:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ijae Kim <ae878000@gmail.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: lan966x: avoid unregistering netdev on register failure
Date: Sat,  2 May 2026 14:07:27 +0900
Message-ID: <20260502050741.76945-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan966x_probe_port() stores the newly allocated net_device in the
port before calling register_netdev(). If register_netdev() fails,
the probe error path calls lan966x_cleanup_ports(), which sees
port->dev and calls unregister_netdev() for a device that was never
registered.

Destroy the phylink instance created for this port and clear port->dev
before returning the registration error, matching the existing guard
used by the common cleanup path. Also require port->dev to be non-NULL
before matching it against the FDMA netdev, so the error path cannot treat
an uninitialized FDMA netdev and a failed port as a valid match.

Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Require port->dev to be non-NULL before calling the FDMA netdev cleanup
  path, avoiding a NULL == NULL match when register_netdev() fails before
  FDMA NAPI has been initialized.

 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 47752d3fde..22c496f588 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -756,7 +756,7 @@ static void lan966x_cleanup_ports(struct lan966x *lan966x)
 			unregister_netdev(port->dev);
 
 		lan966x_xdp_port_deinit(port);
-		if (lan966x->fdma && lan966x->fdma_ndev == port->dev)
+		if (lan966x->fdma && port->dev && lan966x->fdma_ndev == port->dev)
 			lan966x_fdma_netdev_deinit(lan966x, port->dev);
 
 		if (port->phylink) {
@@ -873,6 +873,9 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 	err = register_netdev(dev);
 	if (err) {
 		dev_err(lan966x->dev, "register_netdev failed\n");
+		phylink_destroy(phylink);
+		port->phylink = NULL;
+		port->dev = NULL;
 		return err;
 	}
 
