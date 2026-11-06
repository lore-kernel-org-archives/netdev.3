Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991725;
	b=cKP8Kl26MCgDCrAiGUTHFXIWWDPtubF/hRIt/KztFUmPVugtwcNzYWyLr/B0eytOXWkt
	 m+uwHQgaiiluKal0D1Y7NWsQPJ0VmwHadywU0je+fpIqo+KdA09M8mThSjaGpgY9M5I0E
	 ltxlQ47L2/NZgFIHCWZMovbikPEvwXdhoypTmmnUCXpqcBrSVixZderB+4yfb/ZHFa0Gz
	 /TjrHe60MKGFgE9UE3zQQFe06H8jUbAbDh30udJbCL/e1AD/Kjbhcewe0gqHU3b1fyiSo
	 JxUy3QHRMhEa1JZAHdZxRSh5LVcewtFlGQmhzbozgcR09ygzl8jf1Ya79/i7cLLpiYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pYGk1FmNeczBhQn1UsPHPRZrRnoHl6R7CQH1054vTrI=;
	b=ALThAh6+pt63fz7YJbwbSAOfAPWssNReyHEELSGDMUtYNTG+uMNVk0GlnwBCeHxtaE6h
	 vQObdtFv4TWj91jLVNx5omxuh13BXFciwTGpEWtr88RP5cqvM6Ok84QT4/WDAWUz1Vf1M
	 mnLIe1nfTukLB37lypQNaohvL4fozdYDdypa7skLD+f23D377z07/VBWrnijetbOOWIAx
	 2xKtBIIXaH3b2e+zFJJaxByvYFuGi4AxnBMh4W8BPntRnsj8hFt5Ku7uu+1uTglffzoEZ
	 ULPX1hQc27E0sZrKPrLbKZ8bPMcaG65BKqBcAdzf6hGDnSzH8Pijob+1EKoyjG+sVsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sB+77iAN;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D2606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 832D2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sB+77iAN
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-49318428d98so506240f8f.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991724; x=1794596524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pYGk1FmNeczBhQn1UsPHPRZrRnoHl6R7CQH1054vTrI=;
        b=sB+77iANu4sBWjq5Yj/DnEHrpn9VnrFWqHUW7OkwAaP5dLc8utiQsZqaecQaKOdGOX
         Q4+YLZPOMKYqvmOABAc90Vccr32jqVaSkOBSxS+s/+AsTxePDtP8XmblR2dveY8+/to5
         mIDAhZEivhtnUi4ZtXSwwXSYZ9dwUNTgZOKuFOhYI/HaxFUpoovbO4HKca+AV5ZsSg05
         FGP+lReTTOoEA2viCc/mBuVGHtXkY2t1NIT6/fdzKdPMUxloD1TpWuXq4wWIvNrKEc+5
         yZE9OJyfk5M4Jbsruh3NSL4rwpNEexNUJrjbJO1xLbXq+Qos8Jxpx+tW2cy6kmhGx9E5
         oQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991724; x=1794596524;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pYGk1FmNeczBhQn1UsPHPRZrRnoHl6R7CQH1054vTrI=;
        b=cEAunhCV+RgFwsZo9vWNdxWwP9Ygdcv5c/gVm60BX0F6v7wpyHYjkKekF7qTp360bS
         0mExxTNTQNXQUdcCOzXE2FqnoNOOwM0ilgolLsCzONhLf0ET8zWLXksAQDqMh1R5fXW/
         lBTGCaIHAnDeXDEI3y26InpL3UQgV5/Yb4aRcS9bynuIN+k57T9a/wcElO6hFCGokhSl
         VeuCC49DM3xv2Tc3VOP5Uz+SB05bRM8LUobEhZGOc0gVhaZbvBjJDDCBMvFbIwSuwolX
         ZRQ0LyxKyfkkSZ6GzYjIoIcm8uSAs3w7YbjN1n1kb3vLwxaWZy/v0oR7MUogCVfE//6x
         QgGw==
X-Forwarded-Encrypted: i=1; AL+hErEKYxjsfw1PMZhnHpoeWEnWhJpcTl8ihx2Xd1Wrt58NqGIqU8uzRMFGgYVfc/Mt1lEBjKmyCi0=@vger.kernel.org
X-Gm-Message-State: APuU4Z++IdXegltCPQXu6ECxb/50fcHiwYeFTfO4vT6JRHeWfXIXKGkM
	puf7u38FYiAvdLNwqSHrvFUMmocF9qv6OnaYp6L4IVFXqvsUBozbphL6
X-Gm-Gg: AYBFou3tBuraONEl/O9SUJJT+x84GgZ471MMVHCAFZOUtPFqf0BmgtsVLp2xCpAsId9
	BXMOnmUoS1SktP/ZUSqQSU7KVg5h44Xy1yRP10L+3wiusr1CKyBU1r+q4XAp96zC57DgelLC7eV
	/hG5VnkyFYkMDj6VEwImB7Og8asp5NMnFmn65JRqxnuxx9kYewFlFq+p8SNrTwTaOsyEIZGLav8
	irPoMSnGsvILtZeaM7B5XQEanudgCMvvsUh39PxxDlg5nv73ihPYGYpzKYa0CHsck4Kh+0dvZO1
	R9cSWQIEP6rNsqw0s4/mm8aYbO2wc90Cf+UBHx/kCA3vfCgogqJpXssa4JOSyPRNrdkTisHZeLx
	99pmWrnEGlPe57amoiuFTnhv5WBCqDuZtckPoNMPYQRT/P/wcpzXr+0OOg/UVzXI3BTOzHgoZ7o
	Aw+/QG+AHw1rv6zCRsbbfghdpJyIjkz8arb1o5g/q/ND8eQ//ni3oq2m5jWPHd1sbvm6zZdDjdJ
	DeHoZ21wUDe+TMZpRmScBDZLVySaQDJYNXu6Y1CZPHV4jr/UlwGmwN+hhiPbzRChltVHpc+HsMv
	j1lSU3++oTUnySLVs1HDpDVo7nbK
X-Received: by 2002:a05:6000:386:b0:490:7fb3:cb41 with SMTP id ffacd0b85a97d-4927527d892mr6225482f8f.24.1793991723615;
        Fri, 06 Nov 2026 11:02:03 -0800 (PST)
Received: from metepc ([138.199.53.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d72333f9sm5175028f8f.29.2026.11.06.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:02:02 -0800 (PST)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH net] netdevsim: take device_lock in new_port and del_port sysfs handlers
Date: Fri,  6 Nov 2026 21:57:54 +0300
Message-ID: <20261106185840.774601-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

new_port_store() and del_port_store() access the driver via
dev_get_drvdata() without holding device_lock() or checking for NULL.
The sysfs attributes are attached to the bus device type, so they
remain accessible after the driver is unbound.  Writing to new_port or
del_port after unbind causes a NULL dereference or use-after-free.

Protect both handlers with device_lock() and a NULL drvdata check,
matching the existing numvfs_store() pattern.

Discovered by Sashiko, not triggered, not runtime tested.

Fixes: 794b2c05ca1c ("netdevsim: extend device attrs to support port addition and deletion")
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 drivers/net/netdevsim/bus.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index b792ee10b1c1..822651e00776 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -93,8 +93,14 @@ new_port_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}

-	ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index,
-				addr_set ? eth_addr : NULL);
+	device_lock(dev);
+	ret = -ENOENT;
+	if (dev_get_drvdata(dev))
+		ret = nsim_drv_port_add(nsim_bus_dev,
+					NSIM_DEV_PORT_TYPE_PF, port_index,
+					addr_set ? eth_addr : NULL);
+	device_unlock(dev);
+
 	return ret ? ret : count;
 }

@@ -115,7 +121,13 @@ del_port_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;

-	ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index);
+	device_lock(dev);
+	ret = -ENOENT;
+	if (dev_get_drvdata(dev))
+		ret = nsim_drv_port_del(nsim_bus_dev,
+					NSIM_DEV_PORT_TYPE_PF, port_index);
+	device_unlock(dev);
+
 	return ret ? ret : count;
 }

--
2.56.0

