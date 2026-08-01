Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1A3148A7
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785587413; cv=none; b=q3Gj4md3eyQsf37hEbjs2YAdPIZkYx6YVirp2dG32xF+ej9kUP843mlEt4VrIN9jFGxCs5c7P3AgRcdIvbB+Br9500QyOjoxCKVGZ4tkpLm2ECcZdWwamaQa0rdIHrRD49T2r5z5EHprM2Db04CRuypQv22M3uQYewd3Wx9JVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785587413; c=relaxed/simple;
	bh=44OfuOpRWkEpwE39qqs/5tw6fhh8iyUcWoHJyKnfJX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KD9zwG4BH+eX47UoeapvJjVCyVloEiotaTUNY3n0Edn1Y+FXfN2QVSDMV1fOgC7aY4hNbfbewRMNvI4rZVyJcyA1fh6kXpXZcbY4Po2Q4VwdTIMLkClGQyCCx/xdQ9gnK6ujFUgxCQ7Rvl32YHQZge8yQY34tAUsRGrddkaOCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYfixcfP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYfixcfP"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1420657a91.2
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785587411; x=1786192211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f8RUZZ0a/rFvTsN1FZHwK89Bz0TUluu/ex7Jb2jpMwI=;
        b=XYfixcfPoKlos6CkE4ExU5sjT/+L8DS68HQi1gKjsMQmZ7VhoN5K3Ca4uHTXgp2r3C
         GR9VoGtUOSaP1SF+49woFti22o9K7DBGbaxKxzCFnvk0gkx8wwNWsR6dN1xCqABxhciV
         ZQtQoLCHKa2SUyhc9GbsjxKYc8om+Pin4rMdcTm9Yqrx/JC70yrk3ir5DVQo2J2Eph0O
         bC5Mknz4/2VND894rLmUZhvaBUmCC/61/B4sgmLWfzCccbV3r/S0RvArvYeznezpJPT8
         2in+Rt6L3X4O0JqdJRUm6kXXddeOQxGnWsD1wNaSRV8jiGj8gkl6EaY2f42HlufoUaLO
         EDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785587411; x=1786192211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f8RUZZ0a/rFvTsN1FZHwK89Bz0TUluu/ex7Jb2jpMwI=;
        b=pcy6V3uKj2T/NaLprNcXzgfLDRDe6feGtOBfx03grLumY53NICkEtJ8YiMHcvxA88o
         G7KVJABT7bwxGlLZaDwM7cIouCIhggd/pKTgKsGvISHD8ZYgm0QPp0EzWGOFVv8mHfPD
         B3N2n+xNYgBIJDO7P5itQSzTT3uUAO9qHesdPTrPq1H5rgKh6J2ox5SUUN6dhVVrEhud
         Y/wa4+3zEM5MepPVK1Se/h3jQyk8DvJG12s0TAaENjm1ONkF0ed/Mt7/iB79OnWo/60+
         LCFqip2V4WSI/eSs5eb8G6F3KJrnSAdoWaYvyHK/dFq3U4ABszp+FRjH8VnfTxN286j3
         uF5w==
X-Forwarded-Encrypted: i=1; AHgh+RqbyEL9JtQQD2c5S5XcR3yz9YKPk7NJayHYPLk09ooWD/STt0fvnEY8Go6IqO15iZw8nwuVnjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcfHhOU40SAuqS05Hd3f+EiWpOXBXb3EeF9h1pNdkIPApzl3a
	mScou8NsJZ0mBgtEz2sT+xPTW7x13iHbLjRAb2wcj259tkjRtk8hGcjp
X-Gm-Gg: AR+sD12UAJs8N4b9zzrfPE2n0n088Por2McjjbXp8h9wAEJ8l7J8OybCl4veYMnaFa+
	3Gyi6LriAwfcbK9LvTGBq0t91hqrwuAz1AAN83zm6Ef7nE0JzxSb/Z8jRkghL4yHSn8vUrrlZtN
	GqG34y8EwKgzfJwlahLc2ehlxMtLuwJhxhtLDugKnJQheF1y1BxuU6KiM7VXPBZJh5iBL+vfkF0
	sUL7xaH0+skMNUZ06c998ELa1p/h/w9a79Jqx1LzVuaNj2KMWlRr06vFclAL040xgjkMjvzyOkf
	KCYlPyqSlcI/Ox3RaC2jFv0LRYe3Iun+NngnXHnpCbzZVBzrnz1fhu21TDHaFy85lt4S28lIms7
	Y6DZuvRNU/blo31QH6ynnXEm8seAGqM2f3tFfQmIB6ufI7FAm9B8Br/ebhIIdyJeRTmIrmenON1
	Gmr+0XIj78ioFItVUUKbY8kxKnevy+udUBhyoTo+BvVyC0AoDNNgAIzmV2fvRg0+ieOr0vJhRRi
	A==
X-Received: by 2002:a17:90b:17ca:b0:38e:59c2:cbc5 with SMTP id 98e67ed59e1d1-38fbc472132mr3131442a91.18.1785587410830;
        Sat, 01 Aug 2026 05:30:10 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:3:9df5:1cd1:f108:c202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e045022sm16174086eec.18.2026.08.01.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 05:30:10 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Date: Sat, 01 Aug 2026 17:59:51 +0530
Subject: [PATCH v2 2/3] usb: misc: Use %pe to print error pointers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-usb-ptr_err_patchset-v2-2-1698e298c1e3@gmail.com>
References: <20260801-usb-ptr_err_patchset-v2-0-1698e298c1e3@gmail.com>
In-Reply-To: <20260801-usb-ptr_err_patchset-v2-0-1698e298c1e3@gmail.com>
To: Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Duncan Sands <duncan.sands@free.fr>, 
 Chas Williams <3chas3@gmail.com>, Minas Harutyunyan <hminas@synopsys.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Badhri Jagan Sridharan <badhri@google.com>
Cc: linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
 Subasri S <subasris1210@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785587393; l=3558;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=44OfuOpRWkEpwE39qqs/5tw6fhh8iyUcWoHJyKnfJX8=;
 b=TT73Eu2ymiE2sUt+275pzPgJnLbNlahPwI6ZFyNJ56z2bu3NfyqORVptbO5eyf0pSQGK3vZZN
 w27WafvA0koAljB6/mzo4JrJfu5+4nc2cFmixcor+YIUhAsL+un9F+x
X-Developer-Key: i=subasris1210@gmail.com; a=ed25519;
 pk=6C4wavGFy/OsR8yQQKNWuDXoYPHp2L3sfgNfyzTruTk=

Use the %pe format specifier instead of %ld with PTR_ERR() for printing
error pointers in various drivers across usb subsystem.
This prints symbolic error names (e.g.-ENOMEM) instead of
errno numbers (e.g. -12), making error logs more readable.

Fix coccinelle reported warnings:
WARNING: Consider using %pe to print PTR_ERR()

Compile tested only.

Signed-off-by: Subasri S <subasris1210@gmail.com>
---
 drivers/usb/atm/usbatm.c               | 4 ++--
 drivers/usb/core/hub.c                 | 3 +--
 drivers/usb/dwc2/pci.c                 | 3 +--
 drivers/usb/gadget/function/u_serial.c | 4 ++--
 drivers/usb/misc/usb3503.c             | 3 +--
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 9600e1ec0993..c78caa1b57c9 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -979,8 +979,8 @@ static int usbatm_heavy_init(struct usbatm_data *instance)
 	t = kthread_create(usbatm_do_heavy_init, instance, "%s",
 			instance->driver->driver_name);
 	if (IS_ERR(t)) {
-		usb_err(instance, "%s: failed to create kernel_thread (%ld)!\n",
-				__func__, PTR_ERR(t));
+		usb_err(instance, "%s: failed to create kernel_thread (%pe)!\n",
+				__func__, t);
 		return PTR_ERR(t);
 	}
 
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 5262e11c12cd..8c750a93c350 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5671,8 +5671,7 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 			descr = usb_get_device_descriptor(udev);
 			if (IS_ERR(descr)) {
 				dev_dbg(&udev->dev,
-						"can't read device descriptor %ld\n",
-						PTR_ERR(descr));
+						"can't read device descriptor %pe\n", descr);
 			} else {
 				if (descriptors_changed(udev, descr,
 						udev->bos)) {
diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
index f3a1e4232a31..7ff9c4df941e 100644
--- a/drivers/usb/dwc2/pci.c
+++ b/drivers/usb/dwc2/pci.c
@@ -68,8 +68,7 @@ static int dwc2_pci_probe(struct pci_dev *pci,
 
 	phy = usb_phy_generic_register();
 	if (IS_ERR(phy)) {
-		dev_err(dev, "error registering generic PHY (%ld)\n",
-			PTR_ERR(phy));
+		dev_err(dev, "error registering generic PHY (%pe)\n", phy);
 		return PTR_ERR(phy);
 	}
 
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index cdd1dfc666c4..da31e5cea0a5 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1311,8 +1311,8 @@ int gserial_alloc_line_no_console(unsigned char *line_num)
 	tty_dev = tty_port_register_device(&port->port,
 			gs_tty_driver, port_num, NULL);
 	if (IS_ERR(tty_dev)) {
-		pr_err("%s: failed to register tty for port %d, err %ld\n",
-				__func__, port_num, PTR_ERR(tty_dev));
+		pr_err("%s: failed to register tty for port %d, err %pe\n",
+				__func__, port_num, tty_dev);
 
 		ret = PTR_ERR(tty_dev);
 		mutex_lock(&ports[port_num].lock);
diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index 759770a13260..1160dc594b1c 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -202,8 +202,7 @@ static int usb3503_probe(struct usb3503 *hub)
 
 		hub->clk = devm_clk_get_optional(dev, "refclk");
 		if (IS_ERR(hub->clk)) {
-			dev_err(dev, "unable to request refclk (%ld)\n",
-					PTR_ERR(hub->clk));
+			dev_err(dev, "unable to request refclk (%pe)\n", hub->clk);
 			return PTR_ERR(hub->clk);
 		}
 

-- 
2.43.0

