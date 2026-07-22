Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5232FA30;
	Wed, 22 Jul 2026 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691715; cv=none; b=hvYEaQYdNkJRlomUfvnUWGmG/+96BwaZMtbvNT4IReCNKrHiosYswe3MrtADrzpE0ufkaaDX/yS3BdaTpjpTqnSVGOUzDyeOIpfARGz6uA1QoXbNlnrkrMwtAMt/cVLawDms6rjpJCOTGhXLEGh+pOLGllhLsIaTDClN/qjJR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691715; c=relaxed/simple;
	bh=hOS8XrwclxRNkO7pPFLDST+6/ZK1IJP08TljEpcZ0bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VicOoXmfWf1xwciLaxMNiUuqNkq9XYbh2zYvzBdAocUCHWYkukC+I5kPm5kXKiellpAZPxTrExn/oEwmaCBsUy8YaX7cWnA5o/idkd4MSq2DArS4xzCWTmR5W3cCwNiBiTOcV8jn+4hxqn0YZChrXMinE8/upTl/zOwD1kKAY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Vb6s5khh; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Vb6s5khh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1784691713; x=1816227713;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iqmt42izrnM/a72EVSBeh8/+uskpoymt+jEbjjfbepg=;
  b=Vb6s5khhhf7IdDnNGkucT/B9BYW90+W82M4fNyT2RhO34EE4+lgjbzGy
   GczcQUgf8QpSILE4Sj+gh1RAYJvru1N+p+f14554o1Tq6a+NyS32MA3x8
   RW0VA0LfHas3L98jQxip82TSk6Flhy2LQMuO+zLeSYXyFu3tWJVx1RKI7
   XysTvOcmsM8qNJm8OzAbJFFo1oitWOGiMEVMrcfXUS8C/MhY7GHmgDC9Z
   Qc4bTR/58mwNN74aaiX2Ts74vTxyxHJtGdaQ+6iciMC0Zf99Aeqm4/P7q
   cGRA8DxARVzfkyXJGPSIAfmn7BZO3sBtb4kTpqkjS93qd3hoX6d1EtPGr
   g==;
X-CSE-ConnectionGUID: 8xD1GDHxR3i3TDmy3oGVFQ==
X-CSE-MsgGUID: Gze+wwJNTx2RAVAzamQXPA==
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Jul 2026 12:31:37 +0900
X-CSE-ConnectionGUID: hLuUGiCXR4SiNpeaAZLfzQ==
X-CSE-MsgGUID: y4C7/ckmQIiW/XZeBRm+Dw==
X-IronPort-AV: E=Sophos;i="6.25,177,1779116400"; 
   d="scan'208";a="627327273"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 22 Jul 2026 12:31:37 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Wed, 22 Jul 2026 12:31:22 +0900
Subject: [PATCH 2/4] usb: core: set mod_name in driver registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-mod_name_usb-v1-2-96d781530f3f@sony.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2731;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=hOS8XrwclxRNkO7pPFLDST+6/ZK1IJP08TljEpcZ0bM=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhqwEy+naHqLdBxi/ZDq7918ztNZ7ciVbIyDHa/5XMYtbr
 UfDPnl3lLIwiHExyIopspQqVf/auyJoSc+Z14owc1iZQIYwcHEKwEQmz2BkOFurfzXAcUbWUtvt
 6Rtjetu2LX+lu6L2xL9bK2cXGcZkFzD8T7R77T31Rso1ObkPhx4Yb7HO8HwqUCY9eeKe/3tn/HR
 VYAYA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

The driver core only creates the sysfs "module" symlink for a built-in
driver when its struct device_driver has mod_name set (see
module_add_driver()). This registration path left mod_name unset, so built-in
drivers using it had no such symlink.

Set mod_name to KBUILD_MODNAME during driver registration. Built-in
drivers now gain the symlink, while loadable modules are unaffected.

Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 include/linux/usb.h       | 4 ++--
 drivers/usb/core/driver.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 2466183a45f0..6507c217bca7 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1369,9 +1369,9 @@ extern void usb_deregister(struct usb_driver *);
 		       usb_deregister)
 
 #define usb_register_device_driver(new_udriver) \
-	__usb_register_device_driver(new_udriver, THIS_MODULE)
+	__usb_register_device_driver(new_udriver, THIS_MODULE, KBUILD_MODNAME)
 extern int __usb_register_device_driver(struct usb_device_driver *,
-			struct module *);
+			struct module *, const char *);
 extern void usb_deregister_device_driver(struct usb_device_driver *);
 
 extern int usb_register_dev(struct usb_interface *intf,
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index eac1ff468c08..ab809cb6da26 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -983,6 +983,7 @@ bool is_usb_device_driver(const struct device_driver *drv)
  * __usb_register_device_driver - register a USB device (not interface) driver
  * @new_udriver: USB operations for the device driver
  * @owner: module owner of this driver.
+ * @mod_name: module name string
  *
  * Registers a USB device driver with the USB core.  The list of
  * unattached devices will be rescanned whenever a new driver is
@@ -991,7 +992,7 @@ bool is_usb_device_driver(const struct device_driver *drv)
  * Return: A negative error code on failure and 0 on success.
  */
 int __usb_register_device_driver(struct usb_device_driver *new_udriver,
-		struct module *owner)
+		struct module *owner, const char *mod_name)
 {
 	int retval = 0;
 
@@ -1003,6 +1004,7 @@ int __usb_register_device_driver(struct usb_device_driver *new_udriver,
 	new_udriver->driver.probe = usb_probe_device;
 	new_udriver->driver.remove = usb_unbind_device;
 	new_udriver->driver.owner = owner;
+	new_udriver->driver.mod_name = mod_name;
 	new_udriver->driver.dev_groups = new_udriver->dev_groups;
 
 	retval = driver_register(&new_udriver->driver);

-- 
2.43.0

