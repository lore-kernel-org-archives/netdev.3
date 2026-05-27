Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467553EFFA6
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877309; cv=none; b=OyIVtlsIAqfh+5sWAchJzgkJj8aZH3TgJpC1FEK8dAzAldpKKCeEyHdpWWXx8J6rjyC39m4NF4VbL2H8x30V55YQJycEWeurdp1ra7mVbtcdmbIG/99wi1UlUstWNkzsm3s/wjj4eG5T0MFS3pqD/SLBp/qC+dxHjfv+EC4IYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877309; c=relaxed/simple;
	bh=fpVAe84oI7YyX2TsRSxWdcvMjv6na3fN0+NrYN15zJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McB1wG+wSrZnF+6V9RTf4BrtJmCFER+W9rlw/NauCAF3gOkeyV49+9sj9c1WLbEY1pBY0EYIh6Ki3NqzI9p+PeYp5/p4SgyXQwMrbY9Jwp8ONAopnlfj2rbwxj+BCVg76hQnudqD/ZgDhgqME6nwP9i5vIZOZ/EEs2uKH0gbK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ/+lMS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ/+lMS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4EB1F00A3A;
	Wed, 27 May 2026 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779877308;
	bh=IbqOPMbtYb94kHOSMp1J8BCdnb9kFfqkyI5Y5M0LML8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FZ/+lMS6asIz/SMdcu/X0ed7POeHoFsFPuqzdKr1HlakeRKv7iOJu7GDEMg+2eG1l
	 TiBpRRzjZuUyU62By12RlMsrDLO57rra/GiGzRao+PO5fRUEx5MmSU4VAGuX5VtEZR
	 kp6+SrbOd6YjRt0iekynGOvmmvkUkmm4l31Rr99Ju16pMARGLmNt1jWSB41czto2lF
	 r4RxY4lndp0qdS2L1X8ciZv8RP+LOPFfaNIlJdgwEWAnIL9enVCwbxzD5eJdEtDE4U
	 BtKAEjZHT3iLmYaVw0qnq0RaN0p5iN9DXZnQLwkTFkI0lQ0r69IlwIJeunQGnvk+nq
	 bqLj5P0BknsbQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 27 May 2026 12:21:20 +0200
Subject: [PATCH net-next 6/6] net: airoha: Rename airoha_set_gdm2_loopback
 in airoha_enable_gdm2_loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-airoha-eth-multi-serdes-preliminary-v1-6-ec6ed73ef7fc@kernel.org>
References: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
In-Reply-To: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

This is a preliminary patch in order to allow the user to select if the
configured device will be used as hw lan or wan.
Please not this patch does not introduce any logical changes, just
cosmetic ones.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 72c6f554508c..6574901ebd19 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1796,7 +1796,7 @@ static int airoha_dev_set_macaddr(struct net_device *netdev, void *p)
 	return 0;
 }
 
-static int airoha_set_gdm2_loopback(struct airoha_gdm_dev *dev)
+static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 {
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
@@ -1877,7 +1877,7 @@ static int airoha_dev_init(struct net_device *netdev)
 		if (!eth->ports[1]) {
 			int err;
 
-			err = airoha_set_gdm2_loopback(dev);
+			err = airoha_enable_gdm2_loopback(dev);
 			if (err)
 				return err;
 		}

-- 
2.54.0

