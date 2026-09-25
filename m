Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0632E729
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296537; cv=none; b=cux2gzITPHlKFB0QImO8BM9IpRKjCkjzyxlRnFNfiTlmbZ60Q1QFoFtrSSYmftKzwXV68BaIB2LZDErwEnWiamlGahKQ0ayInK9iI5/Xe4StnW2NZVUesl9l9ap0SfISkBdANZP6sIYHTzK8oOnz9v+kGYDZH4vgXK7LHl7xFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296537; c=relaxed/simple;
	bh=JLREV+8jTK9SZ0OiGjrpJVQPy0C9Bb/geA6QzFNVlok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOQzxltJkCTRwvmUbbbYhh8r2imYOkqPWkgG2z6Qi1kP0u0M09piAmUzNjDZsBANEs2/WmQJG5llQGs7mQ1vF1BPhEJ9oG3w2+3MBvEjYKKWRiZd5zUn81ILVuw3lNXiUjLwcBM3KRjdW3O9JMnuFYz/0fljr1FoM0sjaxlG6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxMUizTG; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxMUizTG"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-81201ed7d35so243094a34.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790296534; x=1790901334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CP0iNzv3n/vDsQDDI+VKrwNL7s5RWy3LXnanNrQWAnU=;
        b=hxMUizTGvbbjJKhz+oFv23ihBxvAE6yPmHR6sr+TCbZRVdigZ+YNkZRvx8Lp6oIEtq
         SeLqYBfBjCx+XX9uJYnTsrzCHnbT0JdVfMnm6Uq7c6QEXj+V02NDhbrRwOOIY8+g/Qdt
         2ieAFogA+ggty9jpd3rwuCxVQTCSvrPhS79JTI7Rb4hTALgz2gsWTCW/Knv5abhYZqTY
         QO7tr9DQYXjvfuKu8RVnUw/wgLJeg3wmtzmI9Pdk/CEmgFtFo+RZd9Kbd2vlj2Lg7zyJ
         S9RF5n+pLjkh44EBp+K1OZ46HtiUzw1pXHF1GL3hJDT0kiGqGK8+/UYO9DT+8olHRbAT
         nBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790296534; x=1790901334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CP0iNzv3n/vDsQDDI+VKrwNL7s5RWy3LXnanNrQWAnU=;
        b=qLL5ynLH2EJAP+juWgW3lmpWHyZZBlJNhcwI6HXU6ltSHRR8ESVhD0AvOczWOEbxQs
         SkX9WrobkyPK4pihugRy3CaNYGRpZWqxxvN2+IFUZA7m7Ajl3bhUD3+128CaZF1xxrrR
         OtIM/PFNyS8IUX7Q0joB4+PPQfQL6IOjxpXfrXkyUvmnic0HEsYwbR4le2hzWST89Rcp
         Oiz1Ye7S1Q2CGvgmLdrhT6cKBQr5QpnhFZt2sO6jIwN93BGnpoLdfEQTFGu7Xxyms+AZ
         VeRivZC6VIKYuEmJ9gLggmhMFQonlCFuD5bs/gsUhUFxOsAGYL1o8bLvqppIESYFbwvX
         kt7Q==
X-Forwarded-Encrypted: i=1; AKwUvByQaxASaAXQKa46hd9VG5W8ON9/nVhD1sayZZLlywtbWwGE6Y7qrwoF8b7H1MXNdrJku/k38js=@vger.kernel.org
X-Gm-Message-State: AFuF++lie0nCi577zERPcj4fXJBwS2rCQ1CuP7LKStYldd3Ehelzkipi
	pPK/QytFFwG18bbz5dc0zxo41+/W/W3Jb/kZTY17nKrIVRxbJgcHnR4v
X-Gm-Gg: AYBFou14yAfrHoowkpww8rkaMwR3xml5fLdii3iiyGKpA/76HLZdfXmrytxgTQDuXHQ
	KT7crPyLoPqHITYuqcIlineK8rj2xinP9uy/tTndwky/zo2iCZPYzmwMspzbUh/v0ocn1GdjOeK
	LC1tv+yvytLbOcY5W/1IgRcTkIXR7JOu5/tSLoZRWurkkViM/a2kgtbmTO4Oh2B9Q0UjOBkUZXu
	zy3M1nVdGK+4RiL4n3CXEeNjvs8y2jWzl0rqDn6eTEMa/YnTQRQ9zVt0xPN63o7+WtZE14M6ZXj
	rgn0nsyzifreQb4duiUqazm3CXsHAFbIWmeBqNjudNV/HgeVLW2l9JI4lDnOsfTmlpy65U28mMS
	Ovh73Rl+uPgvoF+VIT+0jDGEePw4EP7WET/HgVOMdXIlp9HssLuFN05PTRG3IGLEbRg1eC/daLw
	aBSvxriWyCHY41ywFIwljdvBNa/vS043Gby9/VOvRX88JedrfReY+DF1MrOLh1uNLNuQwQ
X-Received: by 2002:a05:6820:4d09:b0:6c9:80d8:a201 with SMTP id 006d021491bc7-6d4415b3f19mr4270125eaf.62.1790296534500;
        Thu, 24 Sep 2026 17:35:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d583542ffcsm1219347eaf.14.2026.09.24.17.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 17:35:33 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 24 Sep 2026 17:35:16 -0700
Subject: [PATCH net-next v2 3/8] eth: mpnic: allocate MSI-X vectors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-linux-mpnic-v2-3-4badc9b58b9e@gmail.com>
References: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
In-Reply-To: <20260924-linux-mpnic-v2-0-4badc9b58b9e@gmail.com>
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

