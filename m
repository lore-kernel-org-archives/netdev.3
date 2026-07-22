Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE63DBD5B;
	Wed, 22 Jul 2026 03:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691113; cv=none; b=PkpD/buPzpjsW+e+mJ804HZ9DwbyVgjUYP24lznLdYAeQurOGNHkeZxJ2jecbFw5QHVRyqjZaJ+GlqrAT3ME6984jL8lO53CyAUgrcrMwQj+eqo2/dN7QbEe5SZzeYnRYH5OemH6B5XCgVXz9WyeHwdJkXpuKRaGinrVevvz6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691113; c=relaxed/simple;
	bh=MfTcypu0xmgn6dV7pRLzNTXZ80KHazJgygRiUlYhcPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ag7xz8aTqFWGUWDJ+M9tdXO/yK16xKZ35dyfd1s5Npaoqy8nAaJHu2pyU7A8/uIVDIvI73cGLjyt8KUp+sr/xpDHd6PSlH27tues1U73cFd9lTpxEMjKkc4Y1JkHIc/IYESn6h9yh+QHoNsqFc+6KcXny4D0QocK+RpFE4Lv/xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=uz+/oE7R; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="uz+/oE7R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1784691111; x=1816227111;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=caj1f0+EQ2UBY0cWiEaPgfnHr13PPMYZHTOfF6hNr3g=;
  b=uz+/oE7RrhRF4EN7y9Lk+5G1IMHFZ3u4qLfznoNLqDawpiFeut02caFm
   XnopeLI3ZgWK2h40UqtR+FBPfrMCZ1X79ipsh0UepKlh+z6FahcTjaTDQ
   EeX6jh/rctVJAJshCfBR1RXdHmFxMGaqywxystGHLCiuU2P/t5LctkpG4
   t/ysmwwbvkr9n/DuND0jrlzPQlnbumzJbjiViMgVhO2I94C1PESJ68Lmo
   F87oEqOS+pXT9IYzqNFqSu9rCiSMCQQ41QKV9KvKjFZIaKuEEGTgb0iNq
   bceJFovjMiOQG/FtZpHeJ7AqcdN9bUWr3XgiBWq2wi+jRt0u6trtf9sjs
   g==;
X-CSE-ConnectionGUID: Uqbz/TdySemtTC23GndMTg==
X-CSE-MsgGUID: ww7wza9OS16tbuVEEpj5zQ==
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 22 Jul 2026 12:31:37 +0900
X-CSE-ConnectionGUID: AIyn8/KgS4u55ssiYoTicA==
X-CSE-MsgGUID: c/wzc9eFTBKuNh3NpiIrUA==
X-IronPort-AV: E=Sophos;i="6.25,177,1779116400"; 
   d="scan'208";a="627327276"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 22 Jul 2026 12:31:38 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Wed, 22 Jul 2026 12:31:24 +0900
Subject: [PATCH 4/4] usb: ulpi: set mod_name in driver registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-mod_name_usb-v1-4-96d781530f3f@sony.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=MfTcypu0xmgn6dV7pRLzNTXZ80KHazJgygRiUlYhcPo=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhqwEyxlyXvFC/kplQTx7+H9J5amv75otuOhuGuuZnbfWV
 GZGl7B3lLIwiHExyIopspQqVf/auyJoSc+Z14owc1iZQIYwcHEKwEQWVzEyrLg57+jdt0Ic3w2X
 3lbz9m40nRL919pOJb1XyfHcW9fP1xj+J4ULzXnEfaioWequRa5px49ifds/mdaRaV223Yv+Ns/
 iAQA=
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
 include/linux/ulpi/driver.h | 4 ++--
 drivers/usb/common/ulpi.c   | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/ulpi/driver.h b/include/linux/ulpi/driver.h
index c668d9c8d876..c899197e0aa8 100644
--- a/include/linux/ulpi/driver.h
+++ b/include/linux/ulpi/driver.h
@@ -51,8 +51,8 @@ struct ulpi_driver {
 /*
  * use a macro to avoid include chaining to get THIS_MODULE
  */
-#define ulpi_register_driver(drv) __ulpi_register_driver(drv, THIS_MODULE)
-int __ulpi_register_driver(struct ulpi_driver *drv, struct module *module);
+#define ulpi_register_driver(drv) __ulpi_register_driver(drv, THIS_MODULE, KBUILD_MODNAME)
+int __ulpi_register_driver(struct ulpi_driver *drv, struct module *module, const char *mod_name);
 void ulpi_unregister_driver(struct ulpi_driver *drv);
 
 #define module_ulpi_driver(__ulpi_driver) \
diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 7e43429e996e..dec4baca1c53 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -147,15 +147,17 @@ static const struct device_type ulpi_dev_type = {
  * __ulpi_register_driver - register a driver with the ULPI bus
  * @drv: driver being registered
  * @module: ends up being THIS_MODULE
+ * @mod_name: ends up being KBUILD_MODNAME
  *
  * Registers a driver with the ULPI bus.
  */
-int __ulpi_register_driver(struct ulpi_driver *drv, struct module *module)
+int __ulpi_register_driver(struct ulpi_driver *drv, struct module *module, const char *mod_name)
 {
 	if (!drv->probe)
 		return -EINVAL;
 
 	drv->driver.owner = module;
+	drv->driver.mod_name = mod_name;
 	drv->driver.bus = &ulpi_bus;
 
 	return driver_register(&drv->driver);

-- 
2.43.0

