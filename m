Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544C401A08
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763868; cv=none; b=YlIE/cbZBNLGxCM8SRe/2Js7F82NEkr+cLOpdtJU+98cpyAdwMJ9QL+sMrZNdz5NHm43BKiZ8+e7RYcEDdTuhnb6Cg5af+e/cbn5bOzTpV7vX9wc1FlPYb41s+lQf7G9lOMPdKaESAax1LuzHQaPjyB82ybUGK5cykMKcAyJkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763868; c=relaxed/simple;
	bh=s7sVT5nQKfhO1MYQ+cpOMkikgu6fjfHMzycska5FUMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBZpGFbmjEoNt424avaujIjmFkhe6CiFgCjsWFgWJS4JSYpJihzwYgyZMNPNylwqppBPC/esVYa0LEG46enQD9DEBXvTN8wlJp8q6a28X5SZOuN0nuuiovRtqN1ZI0jdCg3ha9AZwad44yd4z/hKmpFS4XLBJzXMm1RsT+USuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZLcmUBA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZLcmUBA"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2245762a91.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785763861; x=1786368661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NaH5rfBTvvJEbq+DmDZKDP4NbrrXRvHP/DgwMEdPwTA=;
        b=eZLcmUBAWfCzhIdeH6fNswwvhJSuwlsTVOX3tAzn+2tvQdbqDH5+SXplD09H6kd2Wg
         YdOVkLjdSzzqIHV2mlf3d95lLLmfvzqkk5rxjfwiboeF3FlrKtgKo+h3+bPRi1HkkIg0
         QJVIFQwGq+NYQh7qvAL5HwCpEOKkli1kosPW5ihIdqFgeHDsltcCIpObfVSmB6XytIHB
         0FfaQM9CyHpAaJgW5qIC4iOH4EvjSHiSXAWOF47ZRuw000cJnAIXX1OLt52Jsp8bfL6v
         /hK6K60QYJb+zSeB6IsytGKCU7CVFKqRYwxxBczU7X0do2m82AWnZ+nsYp0Nottz3Nkm
         gPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763861; x=1786368661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NaH5rfBTvvJEbq+DmDZKDP4NbrrXRvHP/DgwMEdPwTA=;
        b=D4j4BtPk27qvvPrEF0ZI7BSfTfpsmJJd/DeljE/w89JYApIFg4r7iuEcJP2VzfzlNy
         yRwMcVUDAVB/eFQCl824g9mnX6/HYFOexbSizAg1TuxSjbsDTNzqGAru04njwLbEfisb
         0bAE1T5ogBWwNiO2iwoJwzJMfA3iykX7+ubKUEkpGFQZxQLyZMJBs11plmi2Aq2AVGTi
         +pbPCOLUhkuW6Ob+Gdk21l23t+XBtQ+A0g49+gQWhF1F5VYRwxb2/RaqLXaZ94yhD9Rv
         iGm5/lcqVAeWKmm+tapqOgELJA/F30syor6ixILiiIJJQmcp+/Q0N8rXLTERjAIQTjdb
         w8RA==
X-Forwarded-Encrypted: i=1; AHgh+RooHQ+V/urMu1pDo9BcMbOYoUcAbCnPZW9UJmTaQxpuNFoNf3OucfqE3euwXOuvCraaE9xroBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyrCpHsb1eHKkfHTI+J6gY1q/OMDHyt+CZlIkq97AReo1/v1K
	cPv8/c6cU/gVSGqMKpnVm6bv+QdOXC/cIFfkFw4DIYe9vRxojDAGSVs=
X-Gm-Gg: AR+sD12YRbUuhi9DMSUr/TWatGmgfM8SXCIkteSGXUHxXyoEnhqgk979pZ1uXPeDFh/
	PY6rZJYGtg4evYfXmdkN8XwrbTaD8Px//e3diEjf6fHUpifaLEBZXtLuglF2mM6TQIXxQbBFDBn
	LQNbPnXtd4MjkJ+4PFjo+0XOffYdEGpOClvoGTrh2dR5Gwy8t7BN4cwUJ/RNC32pk34EmmYW4yR
	Dr98Fgi581qoeOVzAqN0HYbYrUKo2ASoER8FHTHvqSeIQlu7k8+tjY35+e8A0TooOqjb9wzsdUy
	zQsv02128M3tXRn+9rPE/aB8ZgaKwUJQ393OEiFdVYl9K52NHAgcJwcqfJPtKlAIBmFyZSmEPZT
	8VhpXBxwNPhAGAeA891GZY6bnqwu+DM7fxNd6KOEFOVA4sqc6VmHBDOU1keErmafPeuzw9tDkPg
	S70jYd4BVHVj7Nk105OcGB7y+6Q44qKlK2Yu4D5NJ37EAdjmn73BZV9ROpbRgQOLf5RSEZrk+6n
	3oC5s41CKJJHOv/GyJiyI2AnN/4VQRj8/eU55D2YcSE/tU/+nU3uWX9AEwEZOVzoo07Wc8T3x9Q
	aLdpuCJ5G6B9/DjWTA2rNPSlUBBfPGFycQ==
X-Received: by 2002:a17:90b:3947:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-38fbc3f246fmr8665430a91.1.1785763860528;
        Mon, 03 Aug 2026 06:31:00 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb259000bsm2531459a91.0.2026.08.03.06.30.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 06:30:59 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net v2] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Mon,  3 Aug 2026 22:30:48 +0900
Message-ID: <20260803133048.42650-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucc_hdlc_probe() registers an HDLC netdev whose private pointer refers to
the separately allocated ucc_hdlc_private object. The remove path frees
that private object without unregistering or freeing the netdev, leaving
a registered device with a dangling private pointer.

Unregister and free the HDLC device before releasing its private object.
An active device must be closed before detach_hdlc_protocol(), because
the detach path resets dev->flags and clears IFF_UP. Otherwise the later
unregister_netdevice() skips ndo_stop, leaving NAPI, the UCC and its IRQ
active while their backing resources are freed.

Close the device inside unregister_hdlc_device() while RTNL is held and
the HDLC protocol is still attached. This lets uhdlc_close() disable NAPI,
stop the UCC and free the IRQ before the remove path releases the DMA and
private resources.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Close an active HDLC device before detaching its protocol so ndo_stop
  performs the NAPI, UCC and IRQ teardown noted by Simon Horman's review.
- Link to v1: https://lore.kernel.org/netdev/20260728171545.49247-1-mhun512@gmail.com/

 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 drivers/net/wan/hdlc.c         | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb93..4c843c94cf 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1255,6 +1255,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
+	unregister_hdlc_device(priv->ndev);
+
 	uhdlc_memclean(priv);
 
 	if (priv->utdm && priv->utdm->si_regs) {
@@ -1266,6 +1268,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
diff --git a/drivers/net/wan/hdlc.c b/drivers/net/wan/hdlc.c
index cbed10b1d8..a38f90d300 100644
--- a/drivers/net/wan/hdlc.c
+++ b/drivers/net/wan/hdlc.c
@@ -263,6 +263,7 @@ EXPORT_SYMBOL(alloc_hdlcdev);
 void unregister_hdlc_device(struct net_device *dev)
 {
 	rtnl_lock();
+	dev_close(dev);
 	detach_hdlc_protocol(dev);
 	unregister_netdevice(dev);
 	rtnl_unlock();
-- 
2.47.1
