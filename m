Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C63AB498
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860170; cv=none; b=jHgLlFZl7p3M+TyWgOcN1xgMFQtCBIazN3rRONkB2KWBmzrxYr8JVTv1JW1Dt32/KUwGEc2eiUfL2TGnCEiXFX+5lc2LN9MEjgXTGdu0jULxe4VuiUB+vwgeTdvk2voA8UpjP4I8R4im5MNSaSvq3sRJw3HvlWc7Ii5w6rnDQmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860170; c=relaxed/simple;
	bh=CJIEnX0P5e5vEIvo4jO29/P3pon7RQPwtjkdjcPRZxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBOZjDWOb997iJmydpEfZzTFSrpuOu1ZFWCpfKg8qhbfxeOdYh32C0LgKKD03xIEDGpQ/NeX8BuYl4U9ip1RUH5PA4yaREsWZ2zkbgOMH3obZfWsaSNcwhSnA0xA2OMOX4GUi0BwD6rR+PMaHfVzXSHmIWGlScCdoHf1SRa9RJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnOvKf5E; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnOvKf5E"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35829219da8so2195224eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791860168; x=1792464968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hIfDhWm6ixjJFnpSOj18AG3Xc7oniyYktxCnB0/d6hI=;
        b=qnOvKf5ELq94ypZS2VjJ8PEaInQHRwYWgWhyIQAs5Q3NxgGlGr5imEc23RLGU9SRM6
         3ns7iOBLUkLzBusN7/lFnsD1UO6c+J+M2yo7TkxfXs+vD4gClTaIq8Ivvjzp8tGUjexa
         UeQmY3C4X/kCEuo7O4ehgKAPKclFPXyyGXhUy0QAJNo3ms3CCCMRK9iym5SQKht5C3/2
         CuX+zBXjHrMGc4ahXzZ92JTRk5FW36k31Bc4W/C0/dPDthOJFRwYEdLzPcjlFenmTAuy
         u3XroaTcEND8U6oTrOV+qEYNN//QLnopjUNsTA3hnHNaKI1TOXLbW2PcXUfBfg7ozPo+
         4S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860168; x=1792464968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hIfDhWm6ixjJFnpSOj18AG3Xc7oniyYktxCnB0/d6hI=;
        b=ifXeXsJUiMnky4uTAdX0TDZk8cCJnVnlmuZMmPis2L1YWn0nowrvKmzsus3mbqCWiD
         WX6GdhgO+vH9f/qXQdj2vZxG1ywnCsrL9mgNgQFLOirXXu8nfUgs4ABQpwMkNrdu0ptT
         H8KpzoT1KakiXgTstYYv3C7PsrJy8ABD05Fqm+4o5AdT3TS2fLMrLqsGlr8fZt/LqsGl
         X3m3O+ydkHdsHydtGv348hYQ9jOIWoPfXbr9Gb535zZ9O4jPAASerjCzYKf1f914tDgt
         X5Ye7N4BVdyje6+bc/EltmTOuimcckXBb/RAarb+PAZSl9QUpKprPBuf/cXoZdnUMNw1
         vikA==
X-Forwarded-Encrypted: i=1; AKwUvBylNBYEU+xHE+FoGTPvTW3GHLIJWROq4S/oPDShFhs9UH1NWZwLGvEgCam3FJi/k0zEzWoWklA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqS7Av+hg84EfF9O+Ct2WUZtSfIuM3S9+3uKh7AChnfujXxFkK
	cVMfL+sr/QzK80ivPbQ/QGnYY47VRrCc41q64BqdcwNJZzMrjfxwl6uV
X-Gm-Gg: AYBFou2WS2wdV855XCpw1VH1Y0cx3TM0FkJpI2G3Op2+pP3QDoqq123XI+TGDHvbPEc
	71b3SD5NOkrMgticDnT6RlCYjpwQcThWD8CKs4EV07/v9uCD9KT4Sp103AA5zAHzhabqVHJEKA+
	4EUnGEiSRIBsxPzy0OCHxg8WIG1r3K+XvfALhmMoNnsCVQ9Hh7X8mEszHEGIcxceCNnUh5rU7Ck
	cYGKcx2TGZ/xdjuCslHujqrurJjauyGFa64/B1oYaZzwO8yIG0KE2T966Ygs3zb4ZPnRYSK3AnC
	XG0IXKQu3uVMSy3kxnKGAixdBWK1IikRF3OqGFGAJoRe3YphEoEl5k9Aawzhfw7iVOovWvsKxK/
	psRyw19gLIqyHwWDPmOKreivZaXekoPOp6LdPHQKhSrLjq4OzxKTssiI7CxoiAtpzBn3Z4iwFOr
	8PsgUyy5aK4pvoIZL0EO7mc8spmPaMfMCoDahYkywYfv2E1X3cGI11Ub4aPWNBGwvbsKXn8y2mc
	w==
X-Received: by 2002:a05:7301:4694:b0:351:694d:9ca1 with SMTP id 5a478bee46e88-3537b3c7ed1mr16260351eec.27.1791860167835;
        Mon, 12 Oct 2026 19:56:07 -0700 (PDT)
Received: from [127.0.1.1] ([2404:f801:8028:3:8056:897e:dae3:8e2e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm50889219eec.9.2026.10.12.19.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:56:06 -0700 (PDT)
From: Subasri S <subasris1210@gmail.com>
Date: Tue, 13 Oct 2026 08:25:39 +0530
Subject: [PATCH RESEND v2 3/3] usb: typec: Use %pe to print error pointers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-usb-ptr_err_patchset-v2-3-f83351b3fc3d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791860140; l=2977;
 i=subasris1210@gmail.com; s=20260709; h=from:subject:message-id;
 bh=CJIEnX0P5e5vEIvo4jO29/P3pon7RQPwtjkdjcPRZxE=;
 b=CqTrpBWOFP7IoNCOlvIrFBD5UbdJH+gppg/u95/nDgGJAjX+b/exGfLDCfXtlh5uuq2LH1vXW
 RiZAV3SFerPA8GsjssqIRbmCZ+Q0/MSnQEOT7IZw/FpnBBlI0t3pHAb
X-Developer-Key: i=subasris1210@gmail.com; a=ed25519;
 pk=6C4wavGFy/OsR8yQQKNWuDXoYPHp2L3sfgNfyzTruTk=

Use the %pe format specifier instead of %ld with PTR_ERR() for printing
error pointers in various typec drivers. This prints symbolic
error names (e.g.-ENOMEM) instead of errno numbers (e.g. -12),
making error logs more readable.

Fix coccinelle reported warning:
WARNING: Consider using %pe to print PTR_ERR()

Compile tested only.

Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Subasri S <subasris1210@gmail.com>
---
 drivers/usb/typec/mux/pi3usb30532.c | 6 ++----
 drivers/usb/typec/tcpm/tcpm.c       | 2 +-
 drivers/usb/typec/wusb3801.c        | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
index 985683fe49e9..b32f4c433de9 100644
--- a/drivers/usb/typec/mux/pi3usb30532.c
+++ b/drivers/usb/typec/mux/pi3usb30532.c
@@ -139,8 +139,7 @@ static int pi3usb30532_probe(struct i2c_client *client)
 
 	pi->sw = typec_switch_register(dev, &sw_desc);
 	if (IS_ERR(pi->sw)) {
-		dev_err(dev, "Error registering typec switch: %ld\n",
-			PTR_ERR(pi->sw));
+		dev_err(dev, "Error registering typec switch: %pe\n", pi->sw);
 		return PTR_ERR(pi->sw);
 	}
 
@@ -151,8 +150,7 @@ static int pi3usb30532_probe(struct i2c_client *client)
 	pi->mux = typec_mux_register(dev, &mux_desc);
 	if (IS_ERR(pi->mux)) {
 		typec_switch_unregister(pi->sw);
-		dev_err(dev, "Error registering typec mux: %ld\n",
-			PTR_ERR(pi->mux));
+		dev_err(dev, "Error registering typec mux: %pe\n", pi->mux);
 		return PTR_ERR(pi->mux);
 	}
 
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 89eec20a2064..ad10470ea73b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4796,7 +4796,7 @@ static void tcpm_typec_connect(struct tcpm_port *port)
 			port->partner_desc.accessory = TYPEC_ACCESSORY_NONE;
 		partner = typec_register_partner(port->typec_port, &port->partner_desc);
 		if (IS_ERR(partner)) {
-			dev_err(port->dev, "Failed to register partner (%ld)\n", PTR_ERR(partner));
+			dev_err(port->dev, "Failed to register partner (%pe)\n", partner);
 			return;
 		}
 
diff --git a/drivers/usb/typec/wusb3801.c b/drivers/usb/typec/wusb3801.c
index 6062875fb04a..86d13ab41670 100644
--- a/drivers/usb/typec/wusb3801.c
+++ b/drivers/usb/typec/wusb3801.c
@@ -277,8 +277,8 @@ static void wusb3801_hw_update(struct wusb3801 *wusb3801)
 		if (partner_type != WUSB3801_STAT_PARTNER_STANDBY) {
 			wusb3801->partner = typec_register_partner(port, &desc);
 			if (IS_ERR(wusb3801->partner))
-				dev_err(dev, "Failed to register partner: %ld\n",
-					PTR_ERR(wusb3801->partner));
+				dev_err(dev, "Failed to register partner: %pe\n",
+					wusb3801->partner);
 		}
 
 		data_role = pwr_role == TYPEC_SOURCE ? TYPEC_HOST : TYPEC_DEVICE;

-- 
2.43.0

