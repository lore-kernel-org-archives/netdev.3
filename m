Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B094582E2
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698564; cv=none; b=aA1UDXAsPh+3dc//DlyAQGGfIGqN6n9KGIQme1qVUj6NhI5J3UKskYgXKFbLNJU5+XdD3XZ5LA2FLEtPlqn0gK+uL3vWlWU6yB3kTJv1IyxGJVs+XJUTzWpYaLxUsYx9fmN4iT5Oda3knL5ZEnT4YNB4HKYbDht7XSXmTfM7gF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698564; c=relaxed/simple;
	bh=ajhbPbhhFDopfE+pfRmjoiyf+z5rmdgu/+yBZgxSJn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U17/xNgZ9ei4gf5AYVxe7rZha3lqjBuimIIrZMBOqakSJ6Eh5vfoyep80Rl8efXjS3ZIA9bL7USYrFCCXKLb/TcBsFW26gmupPZZR18msyH49teVmEwjEKrh3Sab7/0ItV9enpEPvLsCOMelFPUpFCuRfBQqTxh3vl9/7Dp+GJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=L8+DGK+m; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="L8+DGK+m"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260814090909a120f7058400020721
        for <netdev@vger.kernel.org>;
        Fri, 14 Aug 2026 11:09:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=G0t4G5gv+ZWxMZdsCXrUvBl9B11OyaGMOviXCuRt+tI=;
 b=L8+DGK+msJ7hvV0zCpHlpoTSEbQOk4zqT96RCUI6bgzHAuMSfXR7eampmcl23y830PLb1N
 1n5cX7QopuN2I3LYm1Qh9K0HxqzvqE+L5ZUS/wFbgKQH6Cd59XH8SUPsOcUNlBh+U9Dfudcx
 XFt9BnVUs3g6zSKvJ9Fu5ivnc4bghdw303xrqMHz/8Iezq5p2lFr6XgTRXP60BgRQ3PbyDUm
 7Q746Bfk/2DmzFctcMVeejlwV6Z7keBOQTktbVayMUz4Op2S5f/Gv8Ge2HJkeTc+eShXr5ln
 Djg6mSwrSZtkRtvJTLw2hg1Cz1WgxPCPITWwHx7RGJp/Shw6Flx1magA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Linux Team <linux-imx@nxp.com>,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: fec: support RX flushing via fsl,rx-flush-queues
Date: Fri, 14 Aug 2026 11:08:59 +0200
Message-ID: <20260814090906.2225075-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The FEC/ENET controller can flush frames that get stuck at the head of the
RX FIFO because their destination ring has no empty buffer descriptor
(RxBD[E] clear or ENET_RDARn not set). Without flushing, such a frame blocks
the FIFO and stalls reception on all queues; with flushing enabled the
offending frame is discarded instead. Flushing is configured per RX queue
through the RX_FLUSHn bits of the QOS Scheme register (FEC_QOS_SCHEME).

This series adds a device tree property, fsl,rx-flush-queues, listing the RX
queues for which flushing should be enabled, and programs the corresponding
RX_FLUSHn bits.

Erratum ERR050395 (e.g. i.MX8QXP) can lock up the RX path when flushing is
enabled on more than one queue at the same time; recovery requires a full
ENET reset. Rather than encoding that hardware limitation in the binding,
the DT property is kept generic and the single-queue restriction is enforced
in the driver: a configuration enabling flushing on multiple queues is
rejected unless the controller advertises FEC_QUIRK_HAS_MULTI_RX_FLUSH.
Future parts with the erratum fixed can set that quirk to allow flushing on
several queues.

Example:

    &fec {
        fsl,num-rx-queues = <3>;
        fsl,rx-flush-queues = <1>;
    };

Alexander Sverdlin (2):
  dt-bindings: net: fsl,fec: add fsl,rx-flush-queues
  net: fec: support receive flushing via fsl,rx-flush-queues

 .../devicetree/bindings/net/fsl,fec.yaml      | 14 ++++++++
 drivers/net/ethernet/freescale/fec.h          | 14 ++++++++
 drivers/net/ethernet/freescale/fec_main.c     | 34 +++++++++++++++++++
 3 files changed, 63 insertions(+)

-- 
2.55.0

