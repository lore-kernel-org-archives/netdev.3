Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F93DCD87;
	Wed, 22 Jul 2026 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691715; cv=none; b=sViK+mX2Q+eH3Tg6vExoXNrZMbPKftrQJ8F2GJYy3OBCrz+QJ2lW9WspuWq7C3EJ/sl7/6pqtvZb7MDD/RzOKqnF/w/4cTVWVN+21vj3SYokiB2bZ6SXhvUVOvJcMv1DiVbsCsUMdlk0aS8AHfX6VKT/WVufnOyD4K/6jI/6Gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691715; c=relaxed/simple;
	bh=RdBTFrOH0vp8eKFwl55fuF71e44kh2fum0j9F5xFEU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkOHW5ZlQUNtCz2pff2VUv+uUasuFvsAnzSLx/A4YpBrngKDHCrbz+G4eb+PTHlqK5hh91kvqhCukKxIvgkS5uJ3jT9WC3GpoYhHuNAYFJGZ6Yfu636GPc0fTki+ofPm2r2ro8tdPy4rYSiuBg9/7tK8i/w9LH7FbT1T1MnJHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=ChUhbUDr; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="ChUhbUDr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1784691710; x=1816227710;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dv7gwVDN99PBj+kQCoYiu8N5BZNozYb6eeEnTWHS4dU=;
  b=ChUhbUDr9BcH0Zv4gi1v19X79FUkYD8GSDQw+AofI/id6yiVfxVtEyQo
   j1uz/YGDtMmUSDbBWZZb+oQ01OMIVytQZxjCbGyBGLsTD289Eojc99Qlw
   MbnrgGizizW4gf7V2ONTEVtXr4QYyn7yXQPCQZKoBlqfb1d0XiktxOBst
   LjSmOUjYFQAZ07Ym/FKJOkARpqvkdjFSl8INzcBcP141JavKT342VDf7d
   BQ5yO1j8GuESdAaV34o1uScdl74nUwUbShMnccdqPqRpfRB5SkSGLeDp1
   Ju+uCpVepixu69/54XB84YuLxJC2S+Scx2g8A0oMvU3L5wHFYt0IVrbw6
   Q==;
X-CSE-ConnectionGUID: MrIWxGAVSD+PZLFimksHLg==
X-CSE-MsgGUID: 3eZZ1gKlSsajt6e9rMVAGQ==
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Jul 2026 12:31:37 +0900
X-CSE-ConnectionGUID: UBWqGnFfTBuFKlVRnRxE7w==
X-CSE-MsgGUID: bhXH2+q9Ty+g8fSNkOlTNw==
X-IronPort-AV: E=Sophos;i="6.25,177,1779116400"; 
   d="scan'208";a="627327271"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 22 Jul 2026 12:31:37 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Wed, 22 Jul 2026 12:31:21 +0900
Subject: [PATCH 1/4] usb: core: pass THIS_MODULE implicitly through a macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-mod_name_usb-v1-1-96d781530f3f@sony.com>
References: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
In-Reply-To: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bastien Nocera <hadess@hadess.net>, Matthias Kaehlcke <mka@chromium.org>, 
 Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel.palmer@sony.com>, 
 Rahul Bukte <rahul.bukte@sony.com>, Tim Bird <tim.bird@sony.com>, 
 linux-embedded@vger.kernel.org, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=openpgp-sha256; l=4978;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=RdBTFrOH0vp8eKFwl55fuF71e44kh2fum0j9F5xFEU4=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhqwEy+lJErdVkl+W1psoOvAVhp74dL7RfGKypNaPt8sF/
 mw5dl2po5SFQYyLQVZMkaVUqfrX3hVBS3rOvFaEmcPKBDKEgYtTACbydj8jw4f4oxt0PaJDGu/n
 FWkc/uFocmHKruD+JdYRgg9/P1nTsYmR4Xs9a377vRfybWE3Bct3h+Y4bJ2g9f/SLZbeWetf3T8
 4lxkA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

Rename usb_register_device_driver() to __usb_register_device_driver() and replace
it with a macro wrapper that passes THIS_MODULE implicitly. This is in line with
what other buses do.

Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 include/linux/usb.h                     | 4 +++-
 drivers/net/usb/r8152.c                 | 2 +-
 drivers/usb/core/driver.c               | 6 +++---
 drivers/usb/core/usb.c                  | 2 +-
 drivers/usb/misc/apple-mfi-fastcharge.c | 2 +-
 drivers/usb/misc/onboard_usb_dev.c      | 2 +-
 drivers/usb/usbip/stub_main.c           | 2 +-
 7 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 1da4ad1610bc..2466183a45f0 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1368,7 +1368,9 @@ extern void usb_deregister(struct usb_driver *);
 	module_driver(__usb_driver, usb_register, \
 		       usb_deregister)
 
-extern int usb_register_device_driver(struct usb_device_driver *,
+#define usb_register_device_driver(new_udriver) \
+	__usb_register_device_driver(new_udriver, THIS_MODULE)
+extern int __usb_register_device_driver(struct usb_device_driver *,
 			struct module *);
 extern void usb_deregister_device_driver(struct usb_device_driver *);
 
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f61686433031..73b9b2af1ed2 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10495,7 +10495,7 @@ static int __init rtl8152_driver_init(void)
 {
 	int ret;
 
-	ret = usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
+	ret = usb_register_device_driver(&rtl8152_cfgselector_driver);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index f63004417058..eac1ff468c08 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -980,7 +980,7 @@ bool is_usb_device_driver(const struct device_driver *drv)
 }
 
 /**
- * usb_register_device_driver - register a USB device (not interface) driver
+ * __usb_register_device_driver - register a USB device (not interface) driver
  * @new_udriver: USB operations for the device driver
  * @owner: module owner of this driver.
  *
@@ -990,7 +990,7 @@ bool is_usb_device_driver(const struct device_driver *drv)
  *
  * Return: A negative error code on failure and 0 on success.
  */
-int usb_register_device_driver(struct usb_device_driver *new_udriver,
+int __usb_register_device_driver(struct usb_device_driver *new_udriver,
 		struct module *owner)
 {
 	int retval = 0;
@@ -1023,7 +1023,7 @@ int usb_register_device_driver(struct usb_device_driver *new_udriver,
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(usb_register_device_driver);
+EXPORT_SYMBOL_GPL(__usb_register_device_driver);
 
 /**
  * usb_deregister_device_driver - unregister a USB device (not interface) driver
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index df166cafe106..2559a180fdee 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1241,7 +1241,7 @@ static int __init usb_init(void)
 	retval = usb_hub_init();
 	if (retval)
 		goto hub_init_failed;
-	retval = usb_register_device_driver(&usb_generic_driver, THIS_MODULE);
+	retval = usb_register_device_driver(&usb_generic_driver);
 	if (!retval)
 		goto out;
 
diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
index af266e19f2fd..02adec28d9e6 100644
--- a/drivers/usb/misc/apple-mfi-fastcharge.c
+++ b/drivers/usb/misc/apple-mfi-fastcharge.c
@@ -245,7 +245,7 @@ static struct usb_device_driver mfi_fc_driver = {
 
 static int __init mfi_fc_driver_init(void)
 {
-	return usb_register_device_driver(&mfi_fc_driver, THIS_MODULE);
+	return usb_register_device_driver(&mfi_fc_driver);
 }
 
 static void __exit mfi_fc_driver_exit(void)
diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 11508ed4df25..c60406240416 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -706,7 +706,7 @@ static int __init onboard_dev_init(void)
 {
 	int ret;
 
-	ret = usb_register_device_driver(&onboard_dev_usbdev_driver, THIS_MODULE);
+	ret = usb_register_device_driver(&onboard_dev_usbdev_driver);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index 79110a69d697..01452f7bdabb 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -371,7 +371,7 @@ static int __init usbip_host_init(void)
 		return -ENOMEM;
 	}
 
-	ret = usb_register_device_driver(&stub_driver, THIS_MODULE);
+	ret = usb_register_device_driver(&stub_driver);
 	if (ret) {
 		pr_err("usb_register failed %d\n", ret);
 		goto err_usb_register;

-- 
2.43.0

