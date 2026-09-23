Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA535F602
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127851; cv=none; b=uXTcT0cJAthaWevpKLDA/TzfG30PxWXhMa8N0kztlns4qAQtioG8q5UqeuYfjrH4XoE2s61s0N7CBjTTDNbFnbIkgihpJDRKPaF4rOzdywnQKy6cYd+U3pNnFdihU+b8aRmFQLHXQZIQ78fCkAQcwERUA1D2e8hq5csyeDgcr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127851; c=relaxed/simple;
	bh=JLREV+8jTK9SZ0OiGjrpJVQPy0C9Bb/geA6QzFNVlok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMlopIxRK164DOX4HUD2hOsvKQ6JSBB2iZNahOEDt1v2zAUIhsXtjMhG1vAZXSTuh7sVuxKxzDJOHzcZavG0z7y08O4WhC2PFH0YME0ifNsivwka/jxWlF/O97J4crW311jzz4k7wBsmRDUfYCBK4IyUOcrqs2vFe3EexAmhjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ0y3qdl; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ0y3qdl"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0c89e33so342937a34.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790127847; x=1790732647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CP0iNzv3n/vDsQDDI+VKrwNL7s5RWy3LXnanNrQWAnU=;
        b=KZ0y3qdlrcepn0AVSIwO3MUnBo0iBlF9vJ7RyOrWLnQ6zgg1EcYNJzG+Lil2n5I0H9
         3izkO+v1hIbmcEErYx/mfy+onjQtn5jN7Ejxce5liO721yOXpxppkJKhokj8XcNINg29
         yE4z/wKELoBhg/VVqOrskgGFsGPEmtQctfUdxJM2OP3OclUUD97/lmdUOA6kc9+fJoHm
         UhDkF6l/ZWjoCYDKcy8G0PEWfHZCpTPcUZPjUZJ71dk88D9p2Pm64SfMQqdcS7w2S7ji
         SG3ijuyccRU7FHJ41nIkJ2ZjpMvd4ahzUXkQm3qTUOIfxuKQT7SEvnsoj4rIY7aEzn18
         qMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790127847; x=1790732647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CP0iNzv3n/vDsQDDI+VKrwNL7s5RWy3LXnanNrQWAnU=;
        b=jsQMe+IovWda/KMmhRIGWF5/K7JCCy87osfOCyYMEzyHUFHxKmDXSFbozT+uKgHSOq
         Arnu4MSZ1d/vF0LasISXUD9sNN6kfQG/IQw0JrVzTP1PEjkYJrCD9w+B7JdxZw8CI5JX
         6XTTDIECwFfG3CaFlZd6vzuDNpf/H0o5js3s7m2M6x/lGwXUch4uSSHLFyRvea023bvH
         wb77nSJrjpGhRtVMrhmK612Xe6Ld5LC7zoTmSeHTcjE90/rQcBuKwC0iz0y2NYNGOGgG
         aLAPw3tG5mZfg/Wl3+GokcMANyoxJxHKCSfrl1z0+/b+JcTIALif/m4aHBiJq6heQ4n9
         Dn1A==
X-Forwarded-Encrypted: i=1; AKwUvBz3dSIMcDgQdJRi+2u+NZPS6AcrQsYuSXADo8jKJHt4thJhg7vC8U6OsJxZUKe/nt3v1D6rUcs=@vger.kernel.org
X-Gm-Message-State: AFuF++lqIchmu7FYhGC4YTUIycu0oi6nNQvRn5uBiwnrpYP1oa8TuK4X
	YREIMj1Ee0vdq0d3tK4iOaVuASy0VjyW4pKwtOOvGrh5gi0nryyl+rou
X-Gm-Gg: AYBFou039v6HZSuUbvmAjaiGodyfMLgYcQPNQboJAWByZvw1cy6sIUqXnzcYIFdmgMc
	sQqaelROx9aUy2b1nFvNF6OaV+NO3sIoOf1FZmuXo2AY9cYrnhVTrAFLZY4/a1mbTvacHnqiQ2U
	Ug2xOl0/99SMATFGGjGG7cXEz8TscNHGK97fC+F7jmLi891LqeHItgkvMs3EatNQIiTD3gsuBS9
	ETwnj0MZ1oNPYEDvuuypC3+eQPtHNch50a04tQ1aW6dm20wNedvxDm34ya5l3cf3aL4i+RIrSok
	3olABQr3I8thMLOBQzSIBMcnXJ5upZmOOl0b6WFBeFlY8cGxYciOAUmzHVWFu/3i1RDnow4fjQf
	IAJj7mhSJQJf3RV0//iOuwWm/1aVRTk7PaFw5p5x4BLGfPp9RVNLgxlI5bB51oiyHebGNCoeTK1
	jgeVrZbstvQq5LU2edjs0TyTFUJyEH5s6nfsGi31aLmFjEX2PiquCbTg9s1kuuGZbPcEURuMnyt
	1/ZgEM=
X-Received: by 2002:a05:6820:160a:b0:6cd:3fcc:96ca with SMTP id 006d021491bc7-6d2d3c08a6bmr1047859eaf.72.1790127847301;
        Tue, 22 Sep 2026 18:44:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2ce25c058sm1369513eaf.5.2026.09.22.18.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:44:06 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 22 Sep 2026 18:43:41 -0700
Subject: [PATCH net-next 3/8] eth: mpnic: allocate MSI-X vectors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-linux-mpnic-v1-3-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
In-Reply-To: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Request one vector for FW generated interrupts and then one vector per
CPU to use for the completion queues. Nothing requests a handler yet,
that comes with the NAPI vectors.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/Makefile    |  1 +
 drivers/net/ethernet/meta/mpnic/mpnic.h     | 15 +++++++
 drivers/net/ethernet/meta/mpnic/mpnic_irq.c | 64 +++++++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c |  9 +++-
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/mpnic/Makefile b/drivers/net/ethernet/meta/mpnic/Makefile
index 9dcaa1c72605..3aa7c6a5ab5e 100644
--- a/drivers/net/ethernet/meta/mpnic/Makefile
+++ b/drivers/net/ethernet/meta/mpnic/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_MPNIC) += mpnic.o
 
 mpnic-y := \
 	mpnic_init.o \
+	mpnic_irq.o \
 	mpnic_pci.o \
 # End of mpnic-y
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic.h b/drivers/net/ethernet/meta/mpnic/mpnic.h
index 67d48b7ce315..628fd48c997d 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic.h
@@ -4,6 +4,7 @@
 #ifndef _MPNIC_H_
 #define _MPNIC_H_
 
+#include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/types.h>
 
@@ -14,11 +15,19 @@
 #define MPNIC_MAX_TXQS		1024u
 #define MPNIC_MAX_RXQS		1024u
 
+/* misc IRQ entries are allocated before the completion queue IRQs */
+enum {
+	MPNIC_FW_MSIX_ENTRY,
+	MPNIC_NON_NAPI_VECTORS
+};
+
 struct mpnic_dev {
 	struct device *dev;
 
 	u32 __iomem *uc_addr0;
 
+	u16 num_irqs;
+
 	u32 mps;
 	u32 readrq;
 	u8 relaxed_ord;
@@ -28,6 +37,12 @@ u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg);
 
 int mpnic_dev_init(struct mpnic_dev *mpd);
 
+int mpnic_request_irq(struct mpnic_dev *mpd, int nr, irq_handler_t handler,
+		      unsigned long flags, const char *name, void *data);
+void mpnic_free_irq(struct mpnic_dev *mpd, int nr, void *data);
+void mpnic_free_irqs(struct mpnic_dev *mpd);
+int mpnic_alloc_irqs(struct mpnic_dev *mpd);
+
 static inline void mpnic_wr64(struct mpnic_dev *mpd, u32 reg, u64 val)
 {
 	u32 __iomem *csr = READ_ONCE(mpd->uc_addr0);
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_irq.c b/drivers/net/ethernet/meta/mpnic/mpnic_irq.c
new file mode 100644
index 000000000000..bcc33655cbbe
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_irq.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/minmax.h>
+#include <linux/pci.h>
+
+#include "mpnic.h"
+
+int mpnic_request_irq(struct mpnic_dev *mpd, int nr, irq_handler_t handler,
+		      unsigned long flags, const char *name, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(mpd->dev);
+	int irq = pci_irq_vector(pdev, nr);
+
+	if (irq < 0)
+		return irq;
+
+	return request_irq(irq, handler, flags, name, data);
+}
+
+void mpnic_free_irq(struct mpnic_dev *mpd, int nr, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(mpd->dev);
+	int irq = pci_irq_vector(pdev, nr);
+
+	if (irq < 0)
+		return;
+
+	free_irq(irq, data);
+}
+
+void mpnic_free_irqs(struct mpnic_dev *mpd)
+{
+	struct pci_dev *pdev = to_pci_dev(mpd->dev);
+
+	mpd->num_irqs = 0;
+	pci_free_irq_vectors(pdev);
+}
+
+int mpnic_alloc_irqs(struct mpnic_dev *mpd)
+{
+	unsigned int wanted_irqs = MPNIC_NON_NAPI_VECTORS;
+	struct pci_dev *pdev = to_pci_dev(mpd->dev);
+	int num_irqs;
+
+	wanted_irqs += min_t(unsigned int, num_online_cpus(), MPNIC_MAX_RXQS);
+	num_irqs = pci_alloc_irq_vectors(pdev, MPNIC_NON_NAPI_VECTORS + 1,
+					 wanted_irqs, PCI_IRQ_MSIX);
+	if (num_irqs < 0) {
+		dev_err(mpd->dev, "Failed to allocate MSI-X entries: %d\n",
+			num_irqs);
+		return num_irqs;
+	}
+
+	if (num_irqs < wanted_irqs)
+		dev_warn(mpd->dev, "Allocated %d IRQs, expected %u\n",
+			 num_irqs, wanted_irqs);
+
+	mpd->num_irqs = num_irqs;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
index 68a64377e6c5..127b71b44b0f 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
@@ -112,12 +112,18 @@ static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
-	err = mpnic_dev_init(mpd);
+	err = mpnic_alloc_irqs(mpd);
 	if (err)
 		goto err_free_mpd;
 
+	err = mpnic_dev_init(mpd);
+	if (err)
+		goto err_free_irqs;
+
 	return 0;
 
+err_free_irqs:
+	mpnic_free_irqs(mpd);
 err_free_mpd:
 	kfree(mpd);
 
@@ -132,6 +138,7 @@ static void mpnic_remove(struct pci_dev *pdev)
 {
 	struct mpnic_dev *mpd = pci_get_drvdata(pdev);
 
+	mpnic_free_irqs(mpd);
 	kfree(mpd);
 }
 

-- 
2.52.0

