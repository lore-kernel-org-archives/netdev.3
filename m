Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA5490BE8
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872764; cv=none; b=pOtFoEChP/bUlnF/gP2p/d9OSOmhw1Qkak+LLHcwGNGc6uDOu6a2HlrQN6E2oFIn7McYyeDitBA3YRH0BOqhq2FatOq/B8BXYuQc3CJLy9pDLs3JzordKAOezDYNP3bh8P/77XKHDnRv8d4S4t+fzq1J0Aa6TVYr+W6ih62B9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872764; c=relaxed/simple;
	bh=BFjkNjtYt9dwhHdxJz55WsZjKqRIQOJlE+Th0INQzYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KABVQcNS25saKhUJmNMfTjeu7l7+ignShwtjOP2eSD9rVZxjlzJl1xFW/GneI+dzNsN50QiLPJHsBe7o4WD2gvBwN8nQSeY5Auk35PNMAXfOvA/ZnRA+fl5R7X2sA4PxFVF6+Qi+J1sNmK28sT5iYdzJxtkiFMAWVQTs/zvezIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFBrfoW3; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFBrfoW3"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fcb425fb68so4203770a34.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872761; x=1791477561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsBpaqoe1XdrxTwlbUTe0CHLVjnjs1N8TCf3+hW7KOs=;
        b=dFBrfoW37zKvkCd+ZKET2VF8axWGQJ9/DRbiqNweUMIm0VfJhlnB/1+pKNYRTOfaCJ
         6TcJDmt0+dALRsDUuJm2D2XobbQB6BYBOQdKoVtktiEX+W0SiiQUSU0r++BFdRU5VqTC
         BSIdW6L8s+h2xSGHaDNsD9aTLXzVOJgY9R0Z6YhVc0cLWb/KRQQYJPDUPenerLnWoB/r
         pVFBOcZXHHEcnJxyMEGXXG433UXVaP7BRUnu8IK5+R8cYOEFdZHISEhoFa1HIZWSuRvG
         0iRTGgVwavusXv4swsdlznQJrq4U4Q/5oyGJRszk30+XFmFUgPfOSoRsRfUVPZJ3CNUc
         I4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872761; x=1791477561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsBpaqoe1XdrxTwlbUTe0CHLVjnjs1N8TCf3+hW7KOs=;
        b=uKdmL3Yce7NlQWhgf61xQzNEFUfQdiyUa1wtx8RGcYKhPWGKkXJSyDKFZN48inIM4M
         YvzFgXka6mTl5PPiKi1Tc2LijGhqkDVPyATIJHVi9B9xn4mhjU0V/dnMi4syFxzTQ4VE
         P9otqnn72t0QWCB+Xzo7QCSaR/8jeCAxWcKlSV151ISVL0a7goKuJ/5jySf4NHfaRzwu
         EVIah8quG4t4VkBGiEMxfl9XDHqEKmm8h/N+vdJfBlzEdBgGN2i1ol/PwJ+WzinLEsEr
         erFWSBlLufG7+PN1xGQuTpqXCJbemMU6xNcqRyosZ3cRqiaah72m2PaBmhAMk/S0QZsX
         oBzg==
X-Gm-Message-State: AFuF++lDnvulfWAtxF+vvhLQFugVxXiPUW+cWW+wOWZ5PdBQcAIlLH4N
	6ExDDGohEsc8ZEQVRT49dC6X/5UDQOMgmdcGvtGuTzw5u7/+QltFHt+g
X-Gm-Gg: AYBFou3//f6AEqQKGZXHmIiV1gRKMmwtbBKtIKqbRfH54hDRqNM+Ji8lCDBVIWnej8l
	iBWWD0zVh2S9nOzH7VTHtOJGx3wV4x58cZNtG/BPb3bYpg0BhxnkoLj0t0JS3Io1BKgZmw2UnDW
	ombqk2NjHUB6p1IWQXGEaLZjLUdWujhPuCONfqxp1opARaYU2adIMhfC2MHxHNnuKJbp8LnGeYa
	DIA9AdtI1+i/vvnAXB+5EHGxGvLQeZU1e1sJyuBqKoEs58uE4kUQKKWNeWveGrr3nJS3VaYVsi8
	UxVjtvDl0RotIpTIaoh3qtnD0AUp1AuWM4rOhoQHtTDS7DpcG3LBhFwxnfT/4BEp9JVhRJY4rbZ
	xlIbBAsw+q/9uTCXZKZF6rNCDJKE9jOgLwPE1gOPIi9rSKfz/lLiDGFunM+X4Yr9Dp2c2qP9PPh
	JQvW46tVQb6xyaEP89d3Av6gpy19YKld0hweJqinDP6tc0y7XVDiEYSA1aGRqP1rq5sUPO
X-Received: by 2002:a05:6830:3747:b0:81b:a5aa:e82b with SMTP id 46e09a7af769-82286250332mr151999a34.24.1790872760868;
        Thu, 01 Oct 2026 09:39:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a874654sm276142a34.25.2026.10.01.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:39:20 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 01 Oct 2026 09:38:59 -0700
Subject: [PATCH net-next 2/4] eth: mpnic: add a service task
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-linux-mpnic-v1-2-6422ee74233a@gmail.com>
References: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
In-Reply-To: <20261001-linux-mpnic-v1-0-6422ee74233a@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

Add a service task that runs while the netdevice is running. For now,
the service task does nothing besides conditionally reschedule itself.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic.h        |  3 +++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  3 +++
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c    | 17 +++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic.h b/drivers/net/ethernet/meta/mpnic/mpnic.h
index 78359ab6abb1..8b08af0fadcc 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic.h
@@ -7,6 +7,7 @@
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include "mpnic_csr.h"
 
@@ -27,6 +28,8 @@ struct mpnic_dev {
 
 	u32 __iomem *uc_addr0;
 
+	struct delayed_work service_task;
+
 	u16 num_irqs;
 
 	u64 dsn;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index 2c0309d0c221..bd10df4a9d46 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -35,6 +35,8 @@ static int mpnic_open(struct net_device *netdev)
 	netif_tx_wake_all_queues(netdev);
 	netif_carrier_on(netdev);
 
+	schedule_delayed_work(&mpn->mpd->service_task, HZ);
+
 	return 0;
 
 err_free_resources:
@@ -48,6 +50,7 @@ static int mpnic_stop(struct net_device *netdev)
 {
 	struct mpnic_net *mpn = netdev_priv(netdev);
 
+	cancel_delayed_work(&mpn->mpd->service_task);
 	netif_carrier_off(netdev);
 
 	mpnic_napi_disable(mpn);
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
index 968cd611b8ea..17eae5a9ba16 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
@@ -53,6 +53,20 @@ u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg)
 	return ~0ULL;
 }
 
+static void mpnic_service_task(struct work_struct *work)
+{
+	struct mpnic_dev *mpd = container_of(to_delayed_work(work),
+					     struct mpnic_dev, service_task);
+	struct net_device *netdev = mpd->netdev;
+
+	netdev_lock(netdev);
+
+	if (netif_running(netdev))
+		schedule_delayed_work(&mpd->service_task, HZ);
+
+	netdev_unlock(netdev);
+}
+
 static struct mpnic_dev *mpnic_alloc(struct pci_dev *pdev)
 {
 	struct mpnic_dev *mpd;
@@ -69,6 +83,8 @@ static struct mpnic_dev *mpnic_alloc(struct pci_dev *pdev)
 	mpd->readrq = pcie_get_readrq(pdev);
 	mpd->relaxed_ord = pcie_relaxed_ordering_enabled(pdev);
 
+	INIT_DELAYED_WORK(&mpd->service_task, mpnic_service_task);
+
 	return mpd;
 }
 
@@ -162,6 +178,7 @@ static void mpnic_remove(struct pci_dev *pdev)
 	struct mpnic_dev *mpd = pci_get_drvdata(pdev);
 
 	unregister_netdev(mpd->netdev);
+	cancel_delayed_work_sync(&mpd->service_task);
 	mpnic_netdev_free(mpd);
 	mpnic_free_irqs(mpd);
 	kfree(mpd);

-- 
2.52.0

