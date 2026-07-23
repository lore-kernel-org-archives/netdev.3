Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD3356772
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784775422; cv=none; b=Q8Pak8ps66WT7/FqMJvxjy6jqt7UxYYD5lD/WVfIAuZCyVzTdG30c645TwX2iF1Fzh/pquLWWckyF+otbqMKpV8wtZmz/IlWiIFCjZAFxOYnA/6fV1Hp2vi0VkwdwUlvqmONW2Cz5wMg2fn6wzMCWYLsgPl45QSkld5o0n42nVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784775422; c=relaxed/simple;
	bh=dLng70vdxtqTyWqz2fvX/4qqcKPgc+3OOklAYpZZ3QY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/M+A4X1VCXLgQ15fScaR2AGOKUqS1dak33fJwkYh2p2GwADMlPksKdEN/gOGExb5qVG+Sx91HBAiOsXLzeOrDO9AbP9dZydI0JdVKg1o7MtA6nkpt6x9n6Rh1HFFaLZkyd509YP9CbE0CVKq7Lkv+k+zgVqXcocyLIvUkiAU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS81gxrw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS81gxrw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso1726365ad.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784775421; x=1785380221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQ7fGrrbmgVKPnaajNv3wPBv3j6RA+UeMPicfkwZeBs=;
        b=lS81gxrwfaMCPPVFJLqn7AO07Q4uEyBnTJl8Dcr0hJ3fHz/CkKSHmFC2DQuNc8k3YX
         K2x6qp4JZurYYVeONDeYBrMko5j6VAKuOvfhCP0v4FG+E8j2umwzoJ4twiYdjIGbRK4g
         NaPKR5q8bE1qOJ4o9/tdZUV9s7PE9S1Td+3OMFWeDxG3zhJrpsv6F2wdpIVZfdtdImGY
         Vjyy1OJwozP2xyvfYt223hC4sdUubfhP7PtmVmfnZkEhHyOL0QnS35WffvjFLQ9oSk14
         jNq+857j2pjHwxb7go8eVL/o2DmuIWApEkDRte+2ra9zIsnY+qoqAFXr4XCBLtZeDspF
         F98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784775421; x=1785380221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQ7fGrrbmgVKPnaajNv3wPBv3j6RA+UeMPicfkwZeBs=;
        b=boBrenzlbbPjJJSL8KuQ/297C7HSWAsTMj8v+i7UQXszNgcDCkUkbIbIbEOgzgzN2/
         S3RIFQbC+6+LA71XWwu4trdGpjthu/Pem7i09XlqCCgKtOM64fZK8X3cGl49iBVRPiiw
         2fEJ06nx6xKzWwtH4GpR4QdfNnAUVFhrBqydb1qnfsNGsVeNF0MBvFT8JKmLrrsgmtSX
         DrKXC8bQ0oAhvW/dIl8qvVuMIVlfRpnWaS890s380PFy1o9iRcKuFkimJdYODVuOmbPy
         nR+sg+fWM124jfs9XglJPAFF7MlFl4mwtBlv+TtqUjz3pGW4FsTeG5+mRP6sXXgu6pOP
         LPWA==
X-Gm-Message-State: AOJu0YxzenP5K4DdrhnVWZb5kBC1IxMYhySqdYf2zGajR1hwBSCxOQlS
	f37ovGIiywa+qxiIN7MF8MirKb0LkBN6BpzlmqrwJAD+nmLvCVQfV5UOfFWn6+0=
X-Gm-Gg: AR+sD117Dn4uzywtNK+L0XDA6yRnLmUm8WyReKrN8Vtp6G6g9pOK9l+Z/C+EV2AQnng
	XkmN+TWEJhoh37zvJ5DXBrnF8FAgGHYTGqximWyXPLMKUJzLWiaA5DCmvtgHSy3J2ZNymWau+H5
	nOMs08nG3ZviX9yF0xDdsOBRtBMSxEZY8DkRHJd75mCKhfMwEh4ycaH4ksVviG47QaJmtZ3udak
	5XUaabHAqUtGR75/S5zGIFPjCz0vCK2wvVNf8IL+vj4yEcja3ryM24gPnc7PFR4/c+zjPWLsHkQ
	uH5ai3Df+3OiAEOoOUtIR+PdjFgu8arHQDKpZRIrgp/oW3fDtwfaSscmgEpAm+YRrxO2r6iEDz9
	07SwsV2qL/gW54vJ6UIGO3XTS/rdAlXzKKHlfaVo2QgwaATvf5HNUzKiiUaZmJq1iZQveg6yA7/
	M=
X-Received: by 2002:a17:902:e801:b0:2c9:8f4a:90b with SMTP id d9443c01a7336-2cfa6a54e47mr16797205ad.3.1784775420671;
        Wed, 22 Jul 2026 19:57:00 -0700 (PDT)
Received: from jplife-black.. ([171.3.84.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa38aasm24126505ad.7.2026.07.22.19.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:56:59 -0700 (PDT)
From: faliye <fy15309206903@gmail.com>
X-Google-Original-From: faliye <faliye@ymail.ne.jp>
To: netdev@vger.kernel.org,
	michael.jamet@intel.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	FAN YE <fy15309206903@gmail.com>
Subject: [PATCH net] net: thunderbolt: do not enable E2E flow control on the Tx ring
Date: Thu, 23 Jul 2026 02:56:49 +0000
Message-ID: <20260723025649.7112-1-faliye@ymail.ne.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: FAN YE <fy15309206903@gmail.com>

Commit a8065af3346e ("net: thunderbolt: Enable end-to-end flow control
also in transmit") started passing RING_FLAG_E2E to tb_ring_alloc_tx()
in addition to the Rx ring.

Per the USB4 spec, a Transmit Descriptor Ring with E2E flow control
disabled does not require any credits to be available before the Host
Interface Adapter Layer transmits a tunneled packet from it. Once E2E is
enabled on that ring the controller must first obtain end-to-end
credits.

The ASMedia ASM4242 USB4 host router (PCI 1b21:2425) never delivers
those credits. The controller does accept the configuration: reading the
ring OPTIONS register back right after tb_ring_start() returns exactly
what was written, including RING_FLAG_E2E_FLOW_CONTROL (bit 28) and the
E2E HopID field. No credit ever arrives though, so the Tx ring's
hardware consumer index never advances and the link carries no traffic
at all.

Measured on two hosts connected point to point, onboard ASM4242 on MSI
X870E and X870, v6.17, stock drivers/net/thunderbolt/main.c with only
this patch applied on top:

  before: 100% packet loss to the peer; thunderbolt0 is up and the
          XDomain handshake completes ("new host found"), but iperf3
          fails with "No route to host" once the neighbour entry
          expires
  after:  0% packet loss, 0.28 ms RTT; iperf3 4.21 Gb/s one way and
          5.17 Gb/s the other (5 runs each, stddev <= 0.02), 1
          retransmit in 10 s

An instrumented build additionally showed a frozen-Tx-consumer watchdog
firing ~30k times in a 10 s window before this change.

Rx-side E2E is left untouched, so peers that do return credits keep
receive-side flow control.

ASMedia does not look like an isolated case. The out-of-tree
thunderbolt-ibverbs project disables native E2E on AMD NHI by default,
noting that "Strix Halo has reproduced TX completion wedges with
multiple native E2E rings active" -- the same failure mode, on a
different vendor. Since the driver has no way to tell in advance which
host router returns the credits, defaulting Tx-side E2E to off seems
safer than adding a quirk per affected part; it can be turned back on
for controllers that are known to implement the credit return.

Fixes: a8065af3346e ("net: thunderbolt: Enable end-to-end flow control also in transmit")
Signed-off-by: FAN YE <fy15309206903@gmail.com>
---
 drivers/net/thunderbolt/main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 02a916505..121a42a4f 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -930,7 +930,15 @@ static int tbnet_open(struct net_device *dev)
 	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
 		flags |= RING_FLAG_E2E;
 
-	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags);
+	/*
+	 * Leave E2E off the Tx ring. Per the USB4 spec a Transmit Descriptor
+	 * Ring with E2E enabled must obtain end-to-end credits before it may
+	 * transmit, and not every host router delivers them. On ASMedia
+	 * ASM4242 the credits never arrive, which parks the Tx consumer index
+	 * forever and makes the link unusable.
+	 */
+	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE,
+				RING_FLAG_FRAME);
 	if (!ring) {
 		netdev_err(dev, "failed to allocate Tx ring\n");
 		return -ENOMEM;
-- 
2.43.0

