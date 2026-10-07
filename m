Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0513E0081
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791395095; cv=none; b=W5pxX1yaQcpyE64JsaOl7p6MynFQWNHnUYzN3JRKNXBhNibX6IKE9B5hL2tPZqmnJ9Dfx+JbFf0CP5usZ1AzBLKLb1TO6zmxMDnf35aRtXlevTBZfES1P8gWitlvKphNXvXqhm3B89d9AuY5wVcKd2W7rvGWONFYxgt3FQVeH2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791395095; c=relaxed/simple;
	bh=pc5Ae4XMXNmBx9H8gciWl+eQULBxlouB7GIIhqnjQaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnmWZfpY7i4OTUFRbi6ZYtAB3pddrfcxor3oT4lEvze5EiY36yHFvbi9yo2BBSORVUeT1fzxlGQYRubdZ1wLBcawLnuwxDRxEYXgYSZD2CMbqtFVIC/kfsl3ZuzfoabH5ggiwWJ7cUD1JH8EMe31zNPe2bydhxM94VNv05+ecqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S513z8oi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S513z8oi"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-88b8f0a1bcdso1626913b3a.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791395091; x=1791999891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=COSK+hA3alzfROvx4Il2tMQOlgkjSw8oub0vSseZINs=;
        b=S513z8oiF2o5pcmDawwYyCx3FxgWVvHO4Ffb1cIZW9gWIvlfD+vxz3gb0Qz0pt8Oqz
         tzBle3cSABOg8LWyvVkDSXuhHG3p1WNq5mvk3u6Pen9b8LY6aecY1IwR3xWcE2NBZyqF
         Fhl+knrfqqvB8tR5GXCFterV7T4NDrE0KotpXs/LmZoppJkCWZOux8Q2PXrfhKOY83CJ
         YPHfSbvTsq0yi+I19ST9sryTQy7Efgdqxgatl1456ndtTLsb5Z2i0KTUsF3KBNQ07Int
         UlFjQEgvfBwC4/27TIn6HXfqCIdg9yUtkNrZyaJJOfntSBy5eZ1c5/eApDlsWlL5J1Hu
         gk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791395091; x=1791999891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=COSK+hA3alzfROvx4Il2tMQOlgkjSw8oub0vSseZINs=;
        b=KRaZd2uWc3si9gREle+KCBQLudTUhVMIVorqG1nS8QdxUN/RHzi5PI93/sK9e6wZcA
         QNud0Toov5qGfl/5vfv+tXLc0oZ4e715zDIODYbOxkPSto0KxpNmWVZmH/74GrjED+4n
         yQeVTZ8BMMW8BewxzA1T6nqOEwucAinTTodBLr7ADuK8RjxzkWAq9YGBRFsVuZz/Orbt
         TGjsLOdzf46pdZqKEpcNGeSS7OkXK1hFrZvEhHjcs8PPRW7uVQPdXVzFuSUs/YK/VHN4
         0KNof2FRnMOpeUFbsq5dbsNAsRPvxS3UI6+yP9GMxAnP2YIX7MfsC2sAn2BwBGUnVfEw
         JuYQ==
X-Gm-Message-State: AFuF++nCZj1xzNU39wz1OdJiPNAK+lZ5355kg2XCZ/YPFhQrnns+I2pL
	FZUkezjuMdcruUMMPCXNH0A5psQlcl3x7bbZD9x3oyPFoCdPMdi5XYnDlaYvleo/
X-Gm-Gg: AYBFou0jdFN7ntJUaSBiep0ql9Hr3WcW47KehR3ix+uaVXPqVN2Ef4HoX4fO4QdJuEB
	miiEabVI32gFmHk5kJmun23IhbBl6KDGAu0jod5/SP/mDXR8W0bMhACZHg6iKjyx+eZeC1OOwcs
	aN8+KaMOyM2FS8iu5tI9HN3Ru+ey1wqwkR0AtHrXQ98k1IczdMtvejE+vMvlz5SGikBF43u44l0
	o7o7wNsN6dTVwA8R/k1tSOUwMqa9EKEYe6UZPpax38Q2HDgCCynRRwQfSuqoMFGDlkO7f8BRRLz
	LFyIroCHuA19KBQu7ULfGLM9ea2QoKL+BFRB9kok2yW4gRkmK0idrECxKE2hiHCP8iTNz6h96uV
	DDM4nO6d+m6GrjBTxNVojxMAwFXXOYu29KwFOYk26Pn94dcx8rWg5PJdp5fTuyUauHt+E54gcYb
	Jq4BGM8FdBiZ5HNXI/JldEOoAKzo0j8u4dBM+pMbiaUSiwiChGTqOCSvmfTCO5aUoD024Nb7RqD
	9Bm4T8WKenaF55WqVQYWM4cPgKzwzQW8ndhVvZNEBaz4GKXIdUOcFAsIKI5z5i4RNIao93obU3U
	c5fWxlStpCZOkvnjMYIEAtO68SybiODxpL0ZOTQ+/ILgLHhy2OWFiLMzjlg=
X-Received: by 2002:a05:6a00:2995:b0:88d:501e:eeb9 with SMTP id d2e1a72fcca58-891b0f8ffa8mr2420530b3a.7.1791395091464;
        Wed, 07 Oct 2026 10:44:51 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bbf7df7esm616653b3a.57.2026.10.07.10.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:44:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: ag71xx: align the IP header behind DSA tags
Date: Wed,  7 Oct 2026 10:44:49 -0700
Message-ID: <20261007174449.671416-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive buffer offset includes NET_IP_ALIGN to get the IP header
aligned behind a 14 byte Ethernet header. Most ag71xx devices use DSA
switches whose tag sits in front of the EtherType, which moves the IP
header by another 2 bytes. Every access to the IP and TCP headers then
traps and gets emulated by the unaligned access handler, around 6 times
per forwarded frame.

Take the headroom needed by the DSA tagger into account when choosing
the offset.

TP-Link Archer C7 v2 (qca8k), median of 3 runs, Mbit/s:

                       before   after
  routed up               743     855
  routed down             660     749
  local receive           554     572

The unaligned instruction counter no longer moves while forwarding.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 8a3c689f6825..414d26118d15 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -38,6 +38,7 @@
 #include <linux/reset.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <net/dsa.h>
 #include <net/selftests.h>
 
 #define AG71XX_OOM_REFILL	(1 + HZ / 10)
@@ -1396,6 +1397,24 @@ static void ag71xx_hw_disable(struct ag71xx *ag)
 	ag71xx_rings_cleanup(ag);
 }
 
+static unsigned int ag71xx_rx_offset(struct ag71xx *ag)
+{
+	unsigned int align = NET_IP_ALIGN;
+
+	if (ag71xx_is(ag, AR7100) || ag71xx_is(ag, AR9130))
+		return NET_SKB_PAD;
+
+#if IS_ENABLED(CONFIG_NET_DSA)
+	/* A tag inserted in front of the EtherType shifts the IP header,
+	 * compensate for it to avoid unaligned accesses in the stack.
+	 */
+	if (netdev_uses_dsa(ag->ndev))
+		align = (align - ag->ndev->dsa_ptr->tag_ops->needed_headroom) & 3;
+#endif
+
+	return NET_SKB_PAD + align;
+}
+
 static int ag71xx_open(struct net_device *ndev)
 {
 	struct ag71xx *ag = netdev_priv(ndev);
@@ -1410,6 +1429,7 @@ static int ag71xx_open(struct net_device *ndev)
 	}
 
 	max_frame_len = ag71xx_max_frame_len(ndev->mtu);
+	ag->rx_buf_offset = ag71xx_rx_offset(ag);
 	ag->rx_buf_size =
 		SKB_DATA_ALIGN(max_frame_len + NET_SKB_PAD + NET_IP_ALIGN);
 
@@ -1874,10 +1894,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 	ndev->min_mtu = 68;
 	ndev->max_mtu = dcfg->max_frame_len - ag71xx_max_frame_len(0);
 
-	ag->rx_buf_offset = NET_SKB_PAD;
-	if (!ag71xx_is(ag, AR7100) && !ag71xx_is(ag, AR9130))
-		ag->rx_buf_offset += NET_IP_ALIGN;
-
 	if (ag71xx_is(ag, AR7100)) {
 		ag->tx_ring.desc_split = AG71XX_TX_RING_SPLIT;
 		tx_size *= AG71XX_TX_RING_DS_PER_PKT;
-- 
2.56.0

