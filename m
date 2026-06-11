Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E63C988D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172722; cv=none; b=nktCms4orYgOijxhNzcmy1f4mONl4putciKAD2CN2DHc75KafBS2T9hDSWthVitOuG7sEvloWjXCkdCM/LlYkk52M33i5wIsSDnwS99+dviwhiLye089k95YlzAAO1/dkJh6zqBo2d/TTQryInfYnTPUjJmDoud8HZj8mRidNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172722; c=relaxed/simple;
	bh=rpGykN4vLFdl3CQ9iBYqMFry3BEQGspmI3jAl7cAsEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZNWqVBT3C+hV+3BJaSn72s5dHy69m5f0n4dj6Id2fBI4hLR1HtBJbiBjHv/J634rwdC/B0NmR3hOBB5zemiRDsD3gPbMX4Vm5x9TJdPXgXgXs2SZWhEbpVmlDTPfCbDpnFKIU14pyQi/JgPLvShhrQfGMS11RyFTBp2uhwgJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mTbPqiC7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mTbPqiC7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46066e640easo367787f8f.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1781172719; x=1781777519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89WdVHtEcEjrTXfXmO5KLfdPm+uKXRpF6kTT1kAcq9w=;
        b=mTbPqiC7Bz09opM20+7+z3nHBm153iGrYZyli7UEzfXIEybsonzyqkY7sIPRnDN1nQ
         pquWhbIlSCciiIaMAKa8oYyBxmH0/cM4AmETBz/f9nOTrRzksSwymhcHEyw6VT+f/V/d
         U5J1g+5PNRjAqtk1Pw4YaDM/RG68daKX8tEGX+/YjoN7iBWu1bQG4xxlwm27Qfq5HYTv
         qJfVVinD0sQ8fV3Ua9p7mCtY/EMvnsg70XzLuFjN/g4AluXsnGy8hcO3J3tahxsGUPVM
         kl1CAZnS/hhE5EArJhq/iT/NMbXln6Tem5Vb1nAuAMjspHzkyVrwoJkPfXen0fsabXJg
         l7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172719; x=1781777519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89WdVHtEcEjrTXfXmO5KLfdPm+uKXRpF6kTT1kAcq9w=;
        b=QItp0oTnGob1adqq+5h1WlKTSTVXXRGJWELz1kTDvI8CdVIZCN22viqt/vHpXbV6tp
         uW1g3T9ENjei4/0ol926rpGOdfoYwvCnNE5eHunSOXOAaJMjag50/PWfdJp7lHD/alyY
         jdIJB+EEcYKbDlJvwyjHKCCs13bjsE7ms1fbPLST2OETAgMd5j+mXObrUYOdBqko0YCd
         /QwI825SyampTQpxCtNLxSU0O7cWqHKXBpL92bwiz9Vd95EkQiRh28X4LWtbzw0dYGYQ
         9UJFddiajV1NNUj+dlXPEcJrN6JcWrGmORPGhmax0I06VWQGiW83+vfbnzZ//1nM7yl8
         e7iA==
X-Forwarded-Encrypted: i=1; AFNElJ9UU6Ln83+kT0UwrcMC3ATPaiVeOn3Mo4dW5s39fPrGjUvBoGocHcaqXnUQ7vcd25KVoHDfuug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeaXazt67yUsy1hXDCUbQ3seYoBfnxQfKSAoc3Vdzo65P0OJt
	sIKfwAqzaKfeUuV0kTxW8eFbUGHYJIfewf4LyIBMiHIvO0DkI8hrlMGtvWo6hLLeGEk=
X-Gm-Gg: Acq92OE4fTVB3Z9IBB4QZ3r3H5FjsoRpnKFuTxgeWx1w8DakShnn1Sgow1bdVT5wgS0
	ZantP5m05GKXOnJo7xsrZFu3lhOT7t1HFrlCgYNFeY42OUplit7/9qzdSPPp//5w5OdOnOs6Mig
	P35B/xr5IzbocrbuhWgVfsSARJjhik7fb1EB+AD5+D3QJtPr58tyhUZdf1UyT10N9BpS59DPNJe
	69eu4DaUI9StALcjyfsvrrZUqiT6KT+Ftmq7IER7SNLLaVlZTI01lvwx5voRSUQgmH5qXzB4qqe
	Kj3+IetHOZuXZI1rKd5Tn/gSeNXyCK8kf/qfBuKes/IX0vrqlipe1s5WYPyZnIPOKS6KJGevzXJ
	3XPaaHncscDMLcULX8mO7ViLjwau/v4SMyWTlzbXXRHxYq6TCM997M/gkHYcuxfeoU2JVLEbT2F
	9Trnq5hjWeAIskPKvtHVrOvBaWxWunwdatW1yPpPV1d4Wxk76NBVl5etrI5wCv7iw+jV2ZvpIY9
	sIuIuZyHtjwsTfiMN81rpP4lPSCC3Q/VtykN0IM1zsqe5bFE8PHeg2yGH4Xx0R0r1Vo/DARivok
	V4KVa3pZZbvu
X-Received: by 2002:a05:6000:4706:b0:45e:e44b:313e with SMTP id ffacd0b85a97d-460675b7081mr3135334f8f.19.1781172719195;
        Thu, 11 Jun 2026 03:11:59 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-94-253-164-203.zg.cable.xnet.hr. [94.253.164.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm78592966f8f.0.2026.06.11.03.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:11:58 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	sdf.kernel@gmail.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: sparx5: change ndo_set_rx_mode_async return type to int
Date: Thu, 11 Jun 2026 12:11:13 +0200
Message-ID: <20260611101151.426050-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ("net: add retry mechanism to ndo_set_rx_mode_async") changed the
ndo_set_rx_mode_async return type to int, however it did not update the
SparX-5 driver.

So, simply update the sparx5_set_rx_mode return type to int, propagate
return from __hw_addr_sync_dev or simply return 0.

Fixes: d90b85c23b3d ("net: add retry mechanism to ndo_set_rx_mode_async")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 2eef643f355a..d08f5a0a33ef 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -162,15 +162,17 @@ static int sparx5_port_stop(struct net_device *ndev)
 	return 0;
 }
 
-static void sparx5_set_rx_mode(struct net_device *dev,
-			       struct netdev_hw_addr_list *uc,
-			       struct netdev_hw_addr_list *mc)
+static int sparx5_set_rx_mode(struct net_device *dev,
+			      struct netdev_hw_addr_list *uc,
+			      struct netdev_hw_addr_list *mc)
 {
 	struct sparx5_port *port = netdev_priv(dev);
 	struct sparx5 *sparx5 = port->sparx5;
 
 	if (!test_bit(port->portno, sparx5->bridge_mask))
-		__hw_addr_sync_dev(mc, dev, sparx5_mc_sync, sparx5_mc_unsync);
+		return __hw_addr_sync_dev(mc, dev, sparx5_mc_sync, sparx5_mc_unsync);
+
+	return 0;
 }
 
 static int sparx5_port_get_phys_port_name(struct net_device *dev,
-- 
2.54.0

