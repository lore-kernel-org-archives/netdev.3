Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E27250BEC
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001921; cv=none; b=GsRQDSJ2aB7Y0s0tCByECetkfEdLCSmwBYLeZkjw8GN5bHHMTlOEknmNtA15NIIQ/fPNWXtzuXJm2PxF3eThYEsJnOppAoA8d7i4wBT3TFG7nhq/00zPQmPKui2fhD7N5rdQkvu7n0wiNt1YRHj70tZKPLsO/8zEOg86K/1b5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001921; c=relaxed/simple;
	bh=y7DOr5A12BnnAYpkuYcvtZ3JMxmUPfOqKnMynxUk/+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czEZf/TYTAhyRUf2+kKiFeUowGq/0vecUctGAu1kNk6VmVBh8tQsF/oUrnYUXpm8T2B641ZY2NTR6cG+WkKGn+4osRzr0IMnn7Oi6ENHFG+8qfQ5bZWg3D1QrwxlgbCqpoOkEQQrYvq1663Yquk+ByEsLdMdtjmT/pDCKvR9F5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NwBycWQ4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NwBycWQ4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1EC6D1A0EC0;
	Fri, 13 Feb 2026 16:58:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7AA8606BE;
	Fri, 13 Feb 2026 16:58:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBCBA10368EB1;
	Fri, 13 Feb 2026 17:58:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771001911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R6SDIMfe5UnhJ8zkfHfAMy8Qj6/pQcAjHduxOxcsMqs=;
	b=NwBycWQ4WFMI1xCL1U/0UNHjL3yUvoCf6F7nmWVtDPQDjEjofMdJvxcaktzolCNMWo3290
	3dRJpSu5m1c16CpfNFSboUKUb6G/sOSWPr/PHGSuLuxwn+skK9hJxK4hjE2rl4L7JR2yj4
	hly7NzwODzTpINQ3ikXAv488vP/DAiM+qaPiaf3oZEJoC3jYRRC4o2Dw6ihPMKFI3J3gk5
	W8JnjXG57TX7b0gfAEve7j8CWAi4DLcj1AccM2nmd2kViv8ikF0gWcN+cBcpAsKiifLSxp
	XJixp7s+FaTTUGMAJM4vKM2UOlDpOdisnQORR0Z+cx/5SokCfv4+LQz9+/RaAw==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	kuba@kernel.org,
	lorenzo@kernel.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	pvalerio@redhat.com,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 2/6] net: macb: drop two labels in gem_rx()
Date: Fri, 13 Feb 2026 17:57:55 +0100
Message-ID: <20260213165759.225449-2-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213165759.225449-1-theo.lebrun@bootlin.com>
References: <DG4MBFXG7GGG.3GFLWBUKH087T@bootlin.com>
 <20260213165759.225449-1-theo.lebrun@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Avoid skip_xdp goto and label that skip over five lines of code. If
received buffer is fragmented, we know for sure it cannot be XDP as we
limit the MTU to ensure packets fit one buffer.

Second label removed is next_frame which jumps to one assignement
statement and a continue. Duplicate to remove label and goto.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 70f5dc9c6529..918eee5c8a5b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1611,17 +1611,17 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			data_len = bp->rx_buffer_size;
 		}
 
-		if (!(first_frame && last_frame))
-			goto skip_xdp;
+		if (first_frame && last_frame) {
+			ret = gem_xdp_run(queue, buff_head, data_len, addr);
+			if (ret == XDP_REDIRECT)
+				xdp_flush = true;
 
-		ret = gem_xdp_run(queue, buff_head, data_len, addr);
-		if (ret == XDP_REDIRECT)
-			xdp_flush = true;
+			if (ret != XDP_PASS) {
+				queue->rx_buff[entry] = NULL;
+				continue;
+			}
+		}
 
-		if (ret != XDP_PASS)
-			goto next_frame;
-
-skip_xdp:
 		if (first_frame) {
 			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));
 			if (unlikely(!queue->skb)) {
@@ -1691,7 +1691,6 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
-next_frame:
 		queue->rx_buff[entry] = NULL;
 		continue;
 
-- 
2.53.0

