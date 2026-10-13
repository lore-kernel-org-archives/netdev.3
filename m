Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F34718C3
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860164; cv=none; b=R+8zy6EgNa85ZWGUjiuPij03BaN0TXa15LPRLuYXGzAee186GYc+LjoADSbl/AjaIxUXcrvZOazTzmXXbJ/Sd/Q2ByEb6Z1G8k0jsrvSoGRFRgrcqRGhoo45L2E9xCDcoIfVniVmVJUFWXvLsTD3smXlkLzKA5CqnTOV0fQX6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860164; c=relaxed/simple;
	bh=Ya5+fvphL83LzsYbeWDighc3P/K+Pmb/K3isgCaZrDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwTqQxvaWx7GbJOOBbAxSiARHaEM+F2+CkYo0lNNw+VmZtbZqIan7Px0eynInil1FNuj9HyWN+vpyaHsi46Sc2wEvreTbQud60eAvxN/WmRwAm9fdRLuXJTMgqmGPLu48SY3qoxFtMmJYbH93BbgKmQwkPIXpGquaJF0OHSzpLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA4/nC6h; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA4/nC6h"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35834f72d94so4399916eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791860161; x=1792464961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9ESKYxV8GDdBDHayP7DuLtJAcpKYYeJY6d0DDX47M0=;
        b=YA4/nC6hwGw65yxsnoB4IpZuqRkEdmsNMBSm44I0Zn7iFkPOsAsGexX3UMz/BKtKnL
         TVbgqJSFFlNPCMkT2CE6boXgVmWasN6x+rCuv2sydJgHB5+5tcbmbs/lmyNoIdH1+O41
         MBJ8+s2zi9WmsEi5+r2ek2BjhLR3DxlmjDUUIukkvcJmkHY/TjadMH1ssxwGFLKckTXB
         w/8RHyWr8EoreChCKLGsHkE8MJiukdxsKjjUDrTUVbU+I3ktYlSmEv5iS63t9wwmDes4
         XKAKQfN1ZgE+txydwBBr3wWpTLDYuQGhMmR7wnhRz5qXjoZqftuC2hbJg1vye4nxrr9V
         rPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860161; x=1792464961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9ESKYxV8GDdBDHayP7DuLtJAcpKYYeJY6d0DDX47M0=;
        b=NfKjRFaLV9yZIJujRvVo9ef3GBxL7NCjc045OKXpmStvJovCkeRyyk1t5YpHvWIH+K
         PE8tUlD3wcmspUP5JKQJEBjtcna6wF6wMNG2B97JBZ8euQGOnhRMNl+sevCjmMCX7jna
         Zje4WZu/tij1+e0CQ+ougyb/v1TnAzEQUKgecKBddD2okX6bNutzoaVBk181Lje/btf8
         8uF5zH+QJwNv/DxVfW3xOfd330h9Kb3GSdhpXErIMBCoDmvY8/XxOG4Mdb3mrwXCP6KO
         /fbuPPqUsE+CPZ2ty+lYLAroWPxAiO+Rm0yQv0RYTjjuhq9IhCnqoWKyfS+f1wZYYNX5
         t6ZA==
X-Forwarded-Encrypted: i=1; AKwUvBw+hZ/a65bQHs77YL6mDUDyUtLWmzbrJedqPtzRlOnt0mXGFaPxSOH02pHK7cg4bLuae3GRZ2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqOnAXfsXtNhrwY/BGOIm2BqiYrLn5urTyUbaobsiy3BzdJY5U
	wLwYpQBtbbWJcY+QhvZqs7mFFy3LdA2+NkiOB088/Ea5lC9Bm4Y2Nag+
X-Gm-Gg: AYBFou38hYQ3cS32YCzXWsvmjJbqBfN1XVpgpTrvNyXcFEAWePEQMlL9scf2ojyOoPx
	1T6vqNvTp+3MpRDHvQnMDU+jIOkhGTHW0Q79yABCCG53Oj+0PtZuaniu4xeNOipHG5kS/WwJKQV
	IcNWE0hBudBesWDjlq+W+VnBEIm4cE9Cy5NpUUA9MmgynJf33YA9Fmt52Ri4Fx2CJlFu3RVpALN
	0l2+tnxPFJ9kr3qwbcftpx7TEkDIUl6sjWoFiGq9WA+D/XYtfu1Nmhs8fNkBqB6AD0ZqwKOV9pv
	RIJMq/ANHXx4RCVF0QqnVGV8QdR8fWekt61jClQjj/cw7S/+3kLjRordCPYG+7s4G3FC0Ufi/78
	ATJvKzOtjc6sVlR0NTLL7KYbU2g8jMsZW3i9oYJ2DLuBd0PvwbCvf2z60zglIU1pidFxES2ubVF
	C3bfjHlwx0D2EQPiv+aGO69t6sXcm+YWnin6YQO6UqfkffKiI84mYbKpA4y9ONEeeXPkKQ6TxMd
	Q==
X-Received: by 2002:a05:7300:b913:b0:358:cb31:4277 with SMTP id 5a478bee46e88-358cb3169e2mr16120027eec.28.1791860160954;
        Mon, 12 Oct 2026 19:56:00 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:3:8056:897e:dae3:8e2e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm50889219eec.9.2026.10.12.19.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:55:59 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Date: Tue, 13 Oct 2026 08:25:38 +0530
Subject: [PATCH RESEND v2 2/3] usb: misc: Use %pe to print error pointers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-usb-ptr_err_patchset-v2-2-f83351b3fc3d@gmail.com>
References: <20261013-usb-ptr_err_patchset-v2-0-f83351b3fc3d@gmail.com>
In-Reply-To: <20261013-usb-ptr_err_patchset-v2-0-f83351b3fc3d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791860140; l=3600;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=Ya5+fvphL83LzsYbeWDighc3P/K+Pmb/K3isgCaZrDo=;
 b=hlAZNUAuOTsOCAcw7zt+8hO1U/tGYbvnh2BXSwkSTK86cUrFuDH3pxAH0GwvU2uFV4yX9uS5k
 NwCZWiPoNpnD57qx+VgjuMV4QznO8vvH62NNJ4CmZrOD6ieNz9KrL7c
X-Developer-Key: i=subasris1210@gmail.com; a=ed25519;
 pk=6C4wavGFy/OsR8yQQKNWuDXoYPHp2L3sfgNfyzTruTk=

Use the %pe format specifier instead of %ld with PTR_ERR() for printing
error pointers in various drivers across usb subsystem.
This prints symbolic error names (e.g.-ENOMEM) instead of
errno numbers (e.g. -12), making error logs more readable.

Fix coccinelle reported warnings:
WARNING: Consider using %pe to print PTR_ERR()

Compile tested only.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

