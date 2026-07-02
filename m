Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032183D3301
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032118; cv=none; b=AlSvst8+IcBi0ForKi0rNErF8rugJSjXC9BeZNSCmbU1J/S4bC6/2tyV1/18x1+2TLmouIJvbxKSamsLKlX2a+jhGzISsdMq/6pghoNnc6MAkjnMLrS06mJNaQsY47VwzUHvXjWvq8eQaHe2J9JZf+hnPvnOocF4edPVhIG9C3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032118; c=relaxed/simple;
	bh=+Bck/AIRrSuAnBk1w2hhYEDp6AJYcc5dryvZH3onWLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeQK65UZj+qS6/ygkThQ8+XwOSZpwFJymTpDJeelLVkUy0FhlpIoMfpcIvmM1+Yyus7iUNPs2bNa8Dn+WbE7pff74pjkThS++Oc+4b2bi5FkC763sNiKsLMxhJNKuvjtyiVqvKInMZxyL6lCnvAAm/lS2GuZyblpmcGpFZ2ibHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMEbFhur; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMEbFhur"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca034c989e2so46582a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783032114; x=1783636914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbiP2ZDbDEF7MxMBi2Cibr1JyKAUZE0Nd+Glad1yqDU=;
        b=QMEbFhurb9Tfuu8L2qFI6MiF05JFhILZczEgqGKNhpa+pXgkT/+2Fd7PNj/TmQ26Fo
         LA6IxQ6j9OsHq1MC/YGR6R1Q7Inq1KAxyvuhQJmRGIgaJuTOLOQ91REpHsXvFSHtucvu
         +mydSuLUyLoyIqXUm1+JEQ/nFfQ7bnayvBEY+rWwKwyaxA3zpQKDuwGT0e0RJFQM1p2L
         ryOu/6XGCSDWt2SGM0WrHWCTiKggF2I3qg8J+OTwqmcAiJ1/MLXQN2rfbPCDaKn7NV8H
         uanlpCninZc8gY9NTjLcthkawlbb85eB1cQdoQVfXIwm6UQ9q4ihkmX9upiVz8c6VOwY
         UjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032114; x=1783636914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbiP2ZDbDEF7MxMBi2Cibr1JyKAUZE0Nd+Glad1yqDU=;
        b=lFaReE0AxKA6/l8fceI7C52eNraery2H8BQhONHT/4MqA7yx9TAnNn/kRp3mVynLCv
         BBiCpXVIor8bmdlxP456gfmLlXg8DDDOEcpvtu7Cg49S6ZgNDTwUY4nQHK7AVlWsqqtE
         019h4RubHe1+LbvD+C9iW7PTVBYP7aVQEQtYrGuqnE/I7EjYxRlAu6RNl0tUFvLc7R2i
         QRH3okQSAdEI1YCVKFDBOoL2+lh5YFruX18coCDZdKiHJW5kl7isBuSnA7HS1DAKIRqK
         QDOg0dAtW64SIS3ucsnd5IZis5Du8mEJyldkrwK0D9u2eeOw3lYwrmkGE4bjArHFGUDZ
         +QnA==
X-Gm-Message-State: AOJu0YwWfDBgcb8jz7k/+TYHP2aVfRpFRjQQyptdHCaxMbOa0IOOJCvF
	5Tzc05nYIluM9wQZRmG50IxrijV5w9e44ukQwhkn6pSwJVa8PYkzEbXW9woZagt6
X-Gm-Gg: AfdE7clmLJXYsXWCjV9bBF1OEiCxQHyS/Ksq0MaeBFL5dMFloE/MrNbfvYzaTR7Rz+M
	7LWIo18LVShVtmfkQQNViRoklQnGUbOqvrwo4eB+bHy/BOoJGVqJ2pK4dMBV8jhZ6tHZm3H5SAe
	6KdyZMcAitlHJONbz+PdwH6piCagl20uItBi1fPy5zKO/II3AlsySpDI14EEZxHkKDahVcZOIdh
	dJNxG04rnlg+iZ2qhkb9dbrAUIY4xfEBg+fLJoo5I15SZtsFt9pLygP1u0Io8Rd+0ZcZqcALa57
	Hp7OhA4zzvawnp3QVikbBA7JL41xpXEJCbf2FQ4Es0Ohi09NvqpUsyyoVGczTMus6P5By6IJWk1
	J86HbSf1CcES14Op7tt2InDaM/0xVYM51iUm9TMyXfWEAwADu0FI7p9GQW7WY0aVvNrDiKzx5I8
	qcP5pG0oxAbN2rIMY=
X-Received: by 2002:a05:6a00:b51:b0:845:ce5f:c934 with SMTP id d2e1a72fcca58-847c075ccf4mr8451389b3a.2.1783032114241;
        Thu, 02 Jul 2026 15:41:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9edf07sm1988855b3a.58.2026.07.02.15.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:41:53 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 3/6] net: mtk_eth_soc: hold instance lock around DMA-device-swap close
Date: Thu,  2 Jul 2026 15:41:47 -0700
Message-ID: <20260702224150.3730033-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702224150.3730033-1-sdf@fomichev.me>
References: <20260702224150.3730033-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netif_close_many will soon assert ops lock (for locked DOWN/GOING_DOWN).
Update mtk_eth_set_dma_device to manually grab and release the ops lock.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 5d291e50a47b..fe7610c42e5d 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -26,6 +26,7 @@
 #include <linux/bitfield.h>
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
+#include <net/netdev_lock.h>
 #include <net/page_pool/helpers.h>
 #include <linux/genalloc.h>
 
@@ -5030,10 +5031,14 @@ void mtk_eth_set_dma_device(struct mtk_eth *eth, struct device *dma_dev)
 			continue;
 
 		list_add_tail(&dev->close_list, &dev_list);
+		netdev_lock_ops(dev);
 	}
 
 	netif_close_many(&dev_list, false);
 
+	list_for_each_entry(dev, &dev_list, close_list)
+		netdev_unlock_ops(dev);
+
 	eth->dma_dev = dma_dev;
 
 	list_for_each_entry_safe(dev, tmp, &dev_list, close_list) {
-- 
2.53.0-Meta

