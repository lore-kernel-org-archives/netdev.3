Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5416F38B15B
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758020; cv=none; b=NLujuvwDvAjLSfC2+rEdx05294y+8yDfW5USHfQTt4ffSZ6zCYkJlJdE+p9Js/5UZFuspeyopbfSywfGicA33OD5NN8pFkt+xZidnIrg8qNZUYrj3WKcCYSSzcFePlBxzKbOz/LX67rN6ynHnxIrDU0lbOiyTO354UOjt19kmW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758020; c=relaxed/simple;
	bh=Ch/LDCIDv3IKM5zL2vkfGT7d+5AyR1ksEVvau8a3dEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDs1X7CenPSminuOWu29y0Ij2COfTy7DKdNxTmz6J68I6eGstg+E7Zt82uJLKdUpUuki7gUJFC6zTN8UHcEAiU/fleTRnq6wOy6H/ePS8XHNV/9pdfv7MKRe9p3RkoDNp9VEKT5QARnoXnAn6alOOgZEfbjIyMEp9IlsuTiQDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ufInTINr; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ufInTINr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778758015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8nmmdHYURy0vtUiZFRXJX0t9EU/Y8BNbZBNat5kWmyo=;
	b=ufInTINrXZbsqxb/x0gsHnQlT2CHfhNVYmDKQr7bzdOyp9A3wUYc1So2/OOpnmKGMmqwRo
	rxSyBIlSQDOhS7DVVfF9vfpMXY9bGVUC80kNNp1+wDEdNWfd6563FwFrQwJfplJaxSwsSE
	iY2abEKuxlAzP5N9d3UlRcIGJF+gC28=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Rodolfo Giometti <giometti@enneenne.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [RFC PATCH] pps: make number of PPS devices configurable
Date: Thu, 14 May 2026 11:26:14 +0000
Message-ID: <20260514112614.2016026-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Modern systems may have more than 16 PPS sources and current hard-coded
limit breaks registration of some devices. Make the limit configurable
via Kconfig, keep default value of 16 devices. UAPI has to be changed to
support maximum possible number.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 drivers/pps/Kconfig      | 9 +++++++++
 drivers/pps/pps.c        | 6 +++---
 include/uapi/linux/pps.h | 2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pps/Kconfig b/drivers/pps/Kconfig
index e1651d51cfc9..166c157505fe 100644
--- a/drivers/pps/Kconfig
+++ b/drivers/pps/Kconfig
@@ -22,6 +22,15 @@ menuconfig PPS
 
 if PPS
 
+config PPS_NR_SOURCES
+	int "Maximum number of PPS devices"
+	depends on PPS
+	range 16 256
+	default "16"
+	help
+	  Set this to the number of PPS devices you want the driver
+	  to support.
+
 config PPS_DEBUG
 	bool "PPS debugging messages"
 	help
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index de1122bb69ea..d3eac77b4cb5 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -370,7 +370,7 @@ int pps_register_cdev(struct pps_device *pps)
 	 * Get new ID for the new PPS source.  After idr_alloc() calling
 	 * the new source will be freely available into the kernel.
 	 */
-	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
+	err = idr_alloc(&pps_idr, pps, 0, CONFIG_PPS_NR_SOURCES, GFP_KERNEL);
 	if (err < 0) {
 		if (err == -ENOSPC) {
 			pr_err("%s: too many PPS sources in the system\n",
@@ -464,7 +464,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
 static void __exit pps_exit(void)
 {
 	class_unregister(&pps_class);
-	__unregister_chrdev(pps_major, 0, PPS_MAX_SOURCES, "pps");
+	__unregister_chrdev(pps_major, 0, CONFIG_PPS_NR_SOURCES, "pps");
 }
 
 static int __init pps_init(void)
@@ -477,7 +477,7 @@ static int __init pps_init(void)
 		return err;
 	}
 
-	pps_major = __register_chrdev(0, 0, PPS_MAX_SOURCES, "pps",
+	pps_major = __register_chrdev(0, 0, CONFIG_PPS_NR_SOURCES, "pps",
 				      &pps_cdev_fops);
 	if (pps_major < 0) {
 		pr_err("failed to allocate char device region\n");
diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
index 009ebcd8ced5..1088dea65e12 100644
--- a/include/uapi/linux/pps.h
+++ b/include/uapi/linux/pps.h
@@ -26,7 +26,7 @@
 #include <linux/types.h>
 
 #define PPS_VERSION		"5.3.6"
-#define PPS_MAX_SOURCES		16		/* should be enough... */
+#define PPS_MAX_SOURCES		256		/* should be enough... */
 
 /* Implementation note: the logical states ``assert'' and ``clear''
  * are implemented in terms of the chip register, i.e. ``assert''
-- 
2.47.3

