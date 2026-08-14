Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653F4582F5
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698565; cv=none; b=GXj9PKhlLe5Bx7rIH/TVoLAbzG2p8AOoi6qDjzOuKe0RCC0KFEyTYdJGkhJZ5iVYAXgloVDWa0xXYdchA3wvZLUC3mfGCRqLP4xg3fUEoMQQYRFkWurAwTZQekZjfLugLk0qvccn1oxxQfmLH9i7KH7WKxDzki5/VTUYU3bSyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698565; c=relaxed/simple;
	bh=wFOJGu0UcuBUmUcbX+jWOx9GxjPqzlP3B2t1idchaHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqz/iD2e0XrGtwAHi02YuGNfNQ8qBx5Oa99uVG+fzq9bZkv72ScoPsXKbb/0N3APduj78ZxA5AQ7vFP331Rst3UfxYMAw768Sgf/enJn8sEQRcIdb3WgTXZmg4lDVT70cNmY7/jDkFPu+oRKmIYLrT6uQYbQ1IzCGNYXbdPBn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=LFdHQEFD; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="LFdHQEFD"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202608140909103fe946e880000207af
        for <netdev@vger.kernel.org>;
        Fri, 14 Aug 2026 11:09:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pEAWZMUCnZp1tau2mG/PHGMRuIUt+oO0/JiRyASXCtg=;
 b=LFdHQEFDUTsy9clQdzxNN3VtB3DUnvu1rePp6wmNr2syJu3qs/TojC3ilL6l3VqCMCILnw
 L7MnxHTK3m89bqzitvYKxLgKqJlmOobg7/7+2pO7Tgb6WKtB3Aby9vkpg96y8u7mGtObo/Rx
 esPt0htQrs0ijpDd1FGRNZL2EQvHKC6q9A6iM27B9bSaepS4JVx/Unoq7Nzj723pI6Mxey1e
 8DL5Ac4cmnDDoebF1lmzSsgs6VdWT7DplYJ1uMjWJqEdB7JDvHBb3RaSr/FFsEdu16ejAPLO
 auV33AXlSmR4+BjkfHaEB/KrAcXKVikWOpQFszkwrSZSu845sIZfYFxQ==;
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
Subject: [PATCH net-next 1/2] dt-bindings: net: fsl,fec: add fsl,rx-flush-queues
Date: Fri, 14 Aug 2026 11:09:00 +0200
Message-ID: <20260814090906.2225075-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260814090906.2225075-1-alexander.sverdlin@siemens.com>
References: <20260814090906.2225075-1-alexander.sverdlin@siemens.com>
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

The FEC/ENET controller can enable receive flushing per RX queue via the
QOS Scheme register (RX_FLUSHn bits). When enabled, a frame at the head of
the RX FIFO that cannot be forwarded (because its ring has no empty buffer
descriptor) is discarded instead of blocking the FIFO.

Add the fsl,rx-flush-queues property to describe the set of RX queues for
which flushing is enabled. Most controllers are subject to erratum
ERR050395 and support flushing on a single queue only; the driver enforces
that constraint, so keep the binding generic to allow future controllers
with the erratum fixed to enable flushing on several queues.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 .../devicetree/bindings/net/fsl,fec.yaml          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
index 24e863fdbdab0..808aaf3fd9f27 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -162,6 +162,20 @@ properties:
       Should specify the rx queue number, otherwise set rx queue number to 1.
     enum: [1, 2, 3]
 
+  fsl,rx-flush-queues:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 3
+    items:
+      enum: [0, 1, 2]
+    description:
+      List of RX queue indices for which the receive flushing feature (QOS
+      Scheme register RX_FLUSHn) is enabled. When enabled, a frame at the head
+      of the RX FIFO that cannot be forwarded (because its ring has no empty
+      buffer descriptor) is discarded instead of blocking the FIFO. On most
+      controllers erratum ERR050395 restricts flushing to a single queue. If
+      absent, RX flushing is disabled for all queues.
+
   fsl,magic-packet:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.55.0

