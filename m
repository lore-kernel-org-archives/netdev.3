Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520533065D;
	Wed, 22 Jul 2026 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691110; cv=none; b=FOE6FiffMZcWK1N4h7TDT+xE4nFnfItZN6v1IOsIVd71XRGl5Mx2kh1/WTRp5ReVvtb5vU0kJfAPLBgm8+Ma/zMZ5ZAbR7wZ9BbhqPilOlpIyXciQdaaUXcH5MlEmk+7U33v/h9qezyz8APTIs9oS/TYa+EJ1yKALYT0KGM7nK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691110; c=relaxed/simple;
	bh=ojbQadbeSqjTJ0jmN/K6CSt7HZAxMUg6r6Eq5hbUMRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYIoPBJMjKpvU1vnqnSrxIcKoCwbPEVMbObN15K99gHrS1PeWSaqsAx1mTz4aERDsurBmjK9M8eXGGbRpqBB6nnElXo6FbbEFpNQ1ev8/t7PcvMNdKfkepjXQLjo+yEPclu2avk+6myGm+hChdygy+ICLmHrZ6z1TU3/zUXa9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=oa27+A7U; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="oa27+A7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1784691108; x=1816227108;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RWduDFciZbpwE+xzPcLgZdrOaRq58lmGj88C0MiHbXc=;
  b=oa27+A7UpQ0+Hk0312KI1DLR04aH8MUxvR9i4bEluIu4JcGBkk5kF8L5
   FmVkPRi9w2ZWGlZoHM/uyyqqKVKUZSXjiL5fvJCirNVrtrdhF4/om6fPb
   eDY1dIIyaeiUHzpvTq2LYaIVDEv8+Cc2FAcD9AmTKUj5IwGsLgM8w/7y/
   uZPiSUl/4FuHUTgsI//bN0fpwKTvlpJYBtVBIhwIQkmQR8V+pzIot7AWU
   QS3A61LDZ6oy1mewosv7zojuC47xoOpkQyfdoib/NDDCgyWNVdNELXCeX
   3L0rtEKnBKc6TJI1Gjy2PitN0itx/WzhnNil7uwb7QvhtvaAGOPxMNu2l
   g==;
X-CSE-ConnectionGUID: 9BoVPK9UTAOKNY25oOAw0w==
X-CSE-MsgGUID: B7OvezifSUiM7/CA55YMzg==
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Jul 2026 12:31:37 +0900
X-CSE-ConnectionGUID: PvdEH5T2Q6WRlnnZQ7dmew==
X-CSE-MsgGUID: 3qTt16CYTNS6ocxsYwwDcw==
X-IronPort-AV: E=Sophos;i="6.25,177,1779116400"; 
   d="scan'208";a="627327274"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 22 Jul 2026 12:31:37 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Wed, 22 Jul 2026 12:31:23 +0900
Subject: [PATCH 3/4] usb: typec: set mod_name in driver registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-mod_name_usb-v1-3-96d781530f3f@sony.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2114;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=ojbQadbeSqjTJ0jmN/K6CSt7HZAxMUg6r6Eq5hbUMRc=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhqwEy+nbDeaXpHy755MtMmVzKGdafEmLdtZRuyAOhvQdi
 7gNPmp2lLAwiHExyIopspQqVf/auyJoSc+Z14owc1iZQIYwcHEKwERuXGH4zH7vPsdZcUbzvPT7
 i6ZszdhlrO9YukGpl29V39/L8+MeMTKsn/vuMKfIfG57Uf7HksYHH2/eyvJxUeNyp0mill5nWXY
 yAQA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

The driver core only creates the sysfs "module" symlink for a built-in
driver when its struct device_driver has mod_name set (see
module_add_driver()). This driver left mod_name unset, so its built-in
form had no such symlink.

Set mod_name to KBUILD_MODNAME during driver registration. Built-in
drivers now gain the symlink, while loadable modules are unaffected.

Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 include/linux/usb/typec_altmode.h | 4 ++--
 drivers/usb/typec/bus.c           | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index ef21ead551be..92309b569c3a 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -227,9 +227,9 @@ struct typec_altmode_driver {
  * handle all SVID specific communication.
  */
 #define typec_altmode_register_driver(drv) \
-		__typec_altmode_register_driver(drv, THIS_MODULE)
+		__typec_altmode_register_driver(drv, THIS_MODULE, KBUILD_MODNAME)
 int __typec_altmode_register_driver(struct typec_altmode_driver *drv,
-				    struct module *module);
+				    struct module *module, const char *mod_name);
 /**
  * typec_altmode_unregister_driver - unregisters a USB Type-C alternate mode
  * 				     device driver
diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index e84b134a3381..587d3b06ee8d 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -383,12 +383,14 @@ void typec_altmode_put_plug(struct typec_altmode *plug)
 EXPORT_SYMBOL_GPL(typec_altmode_put_plug);
 
 int __typec_altmode_register_driver(struct typec_altmode_driver *drv,
-				    struct module *module)
+				    struct module *module,
+				    const char *mod_name)
 {
 	if (!drv->probe)
 		return -EINVAL;
 
 	drv->driver.owner = module;
+	drv->driver.mod_name = mod_name;
 	drv->driver.bus = &typec_bus;
 
 	return driver_register(&drv->driver);

-- 
2.43.0

