Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768543A3E97
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426565; cv=none; b=lMpQwGXPiC5ZJNsng2Yv+c1ZsKowjsRtEkf2nMoJ7gfwiG78P2vPe5/a4YHRd3Cpox+Zb+BqQD+2IjZVIJPZ9GqeyUeEXjcze+dt18KQ2OcXA+FIwZMWKIdaBRac+FRv4QTUcIudDQCEtET3K6a8Mz5iIVP+wGm8KaRlhICrRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426565; c=relaxed/simple;
	bh=8g5sVw7LgI28H1lF/6IkIvLtR3BzqkWWOa/ZXwuoDos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBL2P6b1wZovkN5J0VUTTjdBvTKdrCJjufsp4y3S8ZHoqqjBM4KCukQaC05Xt60b+OO/gj/eZCjN8vK5KUQEuOgdOYZde1xXGRePp/uiAamm5Q9XfFGNpLsW0yzrUP+hWL6tsFgF8gjd89RwzoLr0wvWtGiamW4rCuXyU5ePbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZqIXa+t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZqIXa+t"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e81738d24eso308505ad.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426564; x=1792031364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ix0mpplBwU1S+BIW8OSYHid9teBN6VPfjdXj8f3U0XI=;
        b=QZqIXa+tqg05b4O/exwhqqu816h2ZCXRW0nxbqTxDYJAkIjjJllZ1Nsgj4ghjN/vS4
         wGtLhpgB4iTM0nbSSRYwPhPz9fUvkvU9/ftF73M6ZlKBo5VOwy3gYgOxlcr1dV+9FrdP
         1TfHUQ6D6axiyMEMTak7MlCUPAt8/ZV1S5/ZcHU6neNcK6eXaFll/E7mOQAHr0tqucow
         jVls1lMG1m/nFBITiVSucwdgvC48WrkZljOnjGvCIk02UKBgBvUPfI0EVoq6ocDA7xRl
         YUb0qdCnBiA9fdENhFLkxyXumLz9QlCsEZjufxqm9FbaGI74vWlQp8PDFDkja1NK/1L0
         CM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426564; x=1792031364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ix0mpplBwU1S+BIW8OSYHid9teBN6VPfjdXj8f3U0XI=;
        b=Zkfu1XRFWRpfzBsZw4aOtZP7DEH1Pz92Pu8dES1vvsahrZJzK0JFZPFmebNr2BaTwC
         NSvw7xfmguzCkR/fTOFQfreQjS5Umlyp0KU6B+kyKnKZDORLJ4i6eRZgFb/AJvZ69ueb
         kQesUFeZ7IXN2tquyJ/3HZUzIiQPXA7Cg68lyVuLr55Ju2000QF9n0kpOgJgBlvWrjv3
         Uh3Zq8fmzcb3JKvEHii6dYvfyQ0W+DcYAu/CvO3+5R99EswUsheR9sNgeQMTmMnzHhMG
         S3p+sPZn9LCcO+k5jnebW9N8M0f8eKVYr5Sg6S3SwLB30T3HjxQnmEn44vQ9KAVOcsGZ
         tuEQ==
X-Gm-Message-State: AFq9FYKfmZJ/EVVkpdtf+cEvMqhBZqAdJAjaJYctIIzNF5xgyWSZ8u7h
	+E4pSREKChpETlfAL5NPJrM8EdXINZT7669/zREm/YXkLDRSfw/i711BdxNWvIZJ
X-Gm-Gg: AYBFou2yPYyQAVZS4y0x4mMf7bBsG5yZP8jkVc/kFulKsambzyT9mKRt9fff6Spz2Ca
	oIS915M6X7bfWjH+HI6F4bLrrA4ypJI9UQlkGMkeiF5U6wZBtKl4puEo4IQM53AYdAfeoMtdMC2
	A2r50irMhTlwxDDoBQA0x5Da/KPcfdPHpQdbGmdU2tbp1trHoJA1xUiuBEsShWzEZpp3kyWJEI8
	Y394NN1p/K7MdFDrhcZm0IiSaQveZvQjvzom+up44HfVmr1SZcis+51Gq7s6U0RbdnPc+APg+1f
	s2EOgjNF9gbd3EC8bumNUofIcapk86oefYSCItaP0JjZmN9bEU/X/Q6MxsbncwX89Gyx6+sbmpy
	Aja7MHWuERU8+VtVQqBp3LKqmMkZaUXQcrYkoMdFpwZTdZ49FjyqWFPuLNWsHfVk1YCQPpaF8g1
	cGy8EEJSmXD34H9rDiw8897DapUcqRDippyU5dFgfZXT13vHDL2CgYPFmQG4g4hxjCS9+xsggSy
	zr7y100j/aIeAS9w74IC+NamA==
X-Received: by 2002:a17:903:2984:b0:2e7:4a2f:68e6 with SMTP id d9443c01a7336-2e74a2f695cmr13802655ad.39.1791426563684;
        Wed, 07 Oct 2026 19:29:23 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm18045865ad.50.2026.10.07.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 19:29:23 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 10/10] microchip: lan865x: move setting of netops to fix crash
Date: Thu,  8 Oct 2026 10:26:52 +0800
Message-ID: <20261008022656.3592191-11-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008022656.3592191-1-mmyangfl@gmail.com>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan865x_probe() assigns netdev_ops only after oa_tc6_init(), which
connects the internal MAC-PHY through phy_connect_direct().
phy_attach_direct() -> phy_link_topo_add_phy() reads dev->netdev_ops
through netdev_need_ops_lock() since the commit in question, so probing
crashes with a NULL pointer dereference when CONFIG_NET_SHAPER is
enabled.

Assign netdev_ops before the PHY attach, as was done for emac in commit
7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 26a2761332a5..633d00857774 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -346,6 +346,8 @@ static int lan865x_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, priv);
 	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
 
+	netdev->netdev_ops = &lan865x_netdev_ops;
+
 	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
 	if (!priv->tc6) {
 		ret = -ENODEV;
@@ -397,7 +399,6 @@ static int lan865x_probe(struct spi_device *spi)
 
 	netdev->if_port = IF_PORT_10BASET;
 	netdev->irq = spi->irq;
-	netdev->netdev_ops = &lan865x_netdev_ops;
 	netdev->ethtool_ops = &lan865x_ethtool_ops;
 
 	ret = register_netdev(netdev);
-- 
2.53.0

