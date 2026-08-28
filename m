Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D83C0A04
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903958; cv=none; b=LYJAl3OncjisBVKZ2Qn6iPMJAmQKIfEoONAnL9eXq1pTcZISYo+zwmJ7HMWLGntd1AyOblNOzLED5SHeEt+l324/TCmyg5QiJAny9HNrmlh1CjP3wzgXFjwocWEVeW9acDU8aOXYfAwcA3HDRUHG2c+0Prk1OCWPoIE9MYe4a4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903958; c=relaxed/simple;
	bh=1GPU0BWMOwmqInTTjh9l6XuuMTaDwPJpNzEpLt9Wx50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKTbONMzX/PR/cbDjpFAXmNmigwCGusYckiuLF94nqPNiYND97NlVPuiUAnp78s8a1Fulg1d1IT7BlIbBgsTth30/nGW7iGvSf1hGQNvcYOEEP2gxdKCtC2SCgYVtMV2ZV0jIZh8qvAjehLaG5UWRb68Wcdhhgx8LVmfNPJcqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNB43xKR; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNB43xKR"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso914506a91.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903957; x=1788508757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xc2kLyqHA8feBVoBxWUFDrEB1k3VVg85UTOGkhcrHS0=;
        b=WNB43xKRewMCYrEDJMHB11hiRdWpw67a5Wt03xAaxWy6POdsAt3OZt98hkhcabtdFb
         MlV2lp6nDQ+9oMkukd2pbut4OBq91B576XUhcc2PH9yF+360n/MalvCAOQjb8Ixda4yq
         8YgHgZw1Z+I0Z6FuleZ3IBwI04C7lLBk6m1JfD6YsniGwmBLEMj7ugqituBBOX/8nY6A
         lzBKwujjlbs3416THKC1yOXD4ilFjSJlDzTX7bEswviIOY77RzKWHLshS1Z/uwNUNssU
         KktQOGvxjCOzv+r0LuL1j1RlvMxc/kPxGtdK22LPVZXBJ+2bvSzZeBd5CmY2FD3tsfCm
         MKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903957; x=1788508757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xc2kLyqHA8feBVoBxWUFDrEB1k3VVg85UTOGkhcrHS0=;
        b=pOmjvhy1wUqbWb7mlCWOigj4PW2LxIm2lV1i65vFjAtcroxYNLyE+XkDcMN1R3D9BL
         1/GzASzOKYL2EIDUOT3KoJF35XmzActgoQxlDvRByP6xxQYPpZ8b1fxXSz7QB8B7m/4J
         8YuccJW3WQSIYXUzG/09pP1UKJVmVCpmjVWKdILSD6IshOJD5Wo8y8Fik1tCpw7vPSg0
         TGZrl6nZiO+JVi9dGOXKkDrcPoETYr+9OuLg1MXx2RtXXWQTUUa+gpfJkYFCF8Y6uB7R
         A8+DJJQduRuHAlNlMgIFBPjgL2RH9AlQjJIyIsBqgf9zr2njC7dkJYi+yJ8wTSYGhHbP
         l0Tg==
X-Forwarded-Encrypted: i=1; AHgh+RpcH2BARGMrJWsX/3yGJy9RJPBMWVH3s7+ViYAL0mmueJs/853Zj9W+R3n/9ywbLVWl5Kbrm6k=@vger.kernel.org
X-Gm-Message-State: AFuF++kP+o0NrsgbUW1Q9o9lfK+rp94kW1v41lSHa9IWfwqZcFiJggBX
	lugBDaB4N8+yW5ZTZ3K9h5odBmWJwLPM9WKfP3dG5dTFWDILyjapiNrk
X-Gm-Gg: AR+sD12vaVbK6/bxTzdEyXJjfUzZJYp/Vl4PFwCfFknLwW25ewAdiDWhxAfK969lfja
	A72dyJ0u22Fnl6Y8ez5PGosQLt1wq/Ldd31cYCrgRMDKSDj7iqEqWa4+T21fMXPRQ0TA5roY1cx
	SVs6sMgG78In7oUiEaSYnEWUxaz+RvMklcsnVcaPs1J6d9Cv2AUCBaxraCwi76pzz9eV/5ROJiK
	WoBiYB9fZ4wdju/p7p5WbrB1tOgyTdU38PuI9xj4hk+iHrSVtMTX7gdYhPOFZrJ43DjUXuPlhhZ
	HX/A4Thvi8aDMUkrHI6vFs/xfD8gj6Na4mE6HqGD2UEruu1UTtzCTXfXnAzAcOpChT8ClH2j2o8
	96vKl2L4E+zJlPBn976RWuxFK/oa+U5Sli1PgCmUG9MoxyGRuEzVvfupYOc/3D2D24DCAZAVrZz
	uFr6dQg5u414pK3WfL8SVYh1aGbAqvCHLFjmjn4uJ/MdHXA1VBmhPlPZG3Xo2/AvVWs3oHQSpV9
	z4G3mCYcweZhHeLpb46xe3d/PtpHtUsEl3XICquBYoz8pjxEqPHQZ2D07kV6xbDjHb8NKg=
X-Received: by 2002:a17:90b:582e:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-396d0fabb3amr10246158a91.13.1787903956616;
        Fri, 28 Aug 2026 00:59:16 -0700 (PDT)
Received: from ian-lin-DREAMBOOK-PRO-14V.. (59-124-157-10.hinet-ip.hinet.net. [59.124.157.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b19927a1sm6539128a91.14.2026.08.28.00.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:59:15 -0700 (PDT)
From: Ian Lin <jisayme@gmail.com>
To: bjorn@mork.no,
	johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Lin <jisayme@gmail.com>
Subject: [PATCH] USB: add Compal EXM-G1x modem support
Date: Fri, 28 Aug 2026 15:56:44 +0800
Message-ID: <20260828075644.6228-1-jisayme@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the USB device ID for the Compal EXM-G1x modem.

Bind its QMI WWAN interface 8 and expose its vendor-specific serial
interfaces with protocols 0x30, 0x40, and 0x60 through the option driver.

Tested on a Compal EXM-G1x modem.

Signed-off-by: Ian Lin <jisayme@gmail.com>
---
 drivers/net/usb/qmi_wwan.c  | 1 +
 drivers/usb/serial/option.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 8178a8758..e17afb22c 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1451,6 +1451,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1312, 4)},	/* u-blox LARA-R6 01B */
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
+	{QMI_QUIRK_SET_DTR(0x04b7, 0x8217, 8)},
 	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
 	{QMI_FIXED_INTF(0x2dee, 0x4d22, 5)},    /* MeiG Smart SRM825L */
 	{QMI_QUIRK_SET_DTR(0x2dee, 0x4d63, 0)}, /* MeiG SRM813Q w/ Modem(PPP) */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index e4ad14375..56b43bf1f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2547,6 +2547,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
 	  .driver_info = NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2949, 0x8700, 0xff) },			/* Neoway N723-EA */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x8217, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x8217, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x8217, 0xff, 0xff, 0x60) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.43.0

