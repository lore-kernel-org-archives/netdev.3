Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ACD32E73E;
	Mon, 27 Jul 2026 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161315; cv=pass; b=tTdPMXwkYECUyYSrmwywKmgrYe5D45vuapQvqzJBDz0DsCLicLLeD0CztYAOzBJMl7MzIoWWkQAnWgxniFiATJaQ8Nytx/hImbE+8Ulxk7D73S030WX+A1AZwHt+7RuDp6gFmUTT/77b2XeL2sNQI5CbKPfctBDfKmjrKgFXGZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161315; c=relaxed/simple;
	bh=kvSdIrZMGkIRyAAwiZNQ61NLS5Bti6oQq80aJ3Cthj4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=bnpkhzJ6H45scg+dH34vMKNuAf7AFsupysqfv7yD2+JfUOqj1FI5cf+AnqM9nDZCKM3jGGToTx3TzJKOVHFnfdAWO1v0/jhXtkX02/Bl4lw3oUG+TT0ZzNqJcjTds2nUvDqRcT201gGuqMoiDeBblt9JhNJCwLM33Aa1+LWcI/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=vEqS1DUp; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="vEqS1DUp"
ARC-Seal: i=1; a=rsa-sha256; t=1785161300; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=GtdiY2KKufa23kORzPWKTcAeYIE+s4gNeyqrpYlPjmg7fvOPYERf6zdwMamJmIAY6BweL2VB7iz/jPEEHqsAy0wYGHzqHOYllM3GQUvTlctUIkFhpQzrwUrf4MjTJbKa8AAPmNv4tvVZQhKN2dbHoMuK92G2XZdYP+XrqgV24TE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1785161300; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lIY/J3Br0onnCRgvjGkCZRca6lfuy0ImWKlrySbVVr0=; 
	b=c7sBrnhiEN5uAc4WFAKr4mRk9jAAMBRczgNYULDQ+G704MRhLZq37MUG6tehO+1T+7iafz4/U09fCrPhs0bwXhxCs/fWXWCj7D/r1DuL3uxO8cTSpk0TqrlU8z13kmIiTGGFqguv1zm5EYc4N+s5QDwNeCOmYpvdh9Moe2HZ73U=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785161300;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lIY/J3Br0onnCRgvjGkCZRca6lfuy0ImWKlrySbVVr0=;
	b=vEqS1DUpJ6tQsfzLvcvoqaQXPCZopvN+DO4W+9izH9ZuPmCRXB3JdO1f9W5qw+2v
	+RNeX6w1T3yctBq5rt2h0DCbbLFPrtX62PsYAH0IIoH5AKjtaiLawNZAu/51MytgJrN
	b4jdhQzzdZ6UOQ3RkpHhJ465NSr1MdBPCZVVC+U4=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1785161293062468.87794575975374; Mon, 27 Jul 2026 19:38:13 +0530 (IST)
Received: from  [152.57.173.177] by mail.zoho.in
	with HTTP;Mon, 27 Jul 2026 19:38:13 +0530 (IST)
Date: Mon, 27 Jul 2026 19:38:13 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "netdev" <netdev@vger.kernel.org>
Cc: "linux-usb" <linux-usb@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19fa3e79cfe.894831784405.7828961255432177577@zohomail.in>
In-Reply-To: 
Subject: [PATCH] net: usb: net1080: add error handling to nc_vendor_write()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

From a822037e659f6c13022062b399a96b7d72780090 Mon Sep 17 00:00:00 2001
From: Ashwin Gundarapu <gundarapuashwin@outlook.com>
Date: Mon, 27 Jul 2026 19:34:16 +0530
Subject: [PATCH] net: usb: net1080: add error handling to nc_vendor_write()

The nc_vendor_write() function currently ignores the return value of
usbnet_write_cmd(). This can lead to silent failures when USB
communication fails.

Change nc_vendor_write() and nc_register_write() to return int
instead of void, and propagate the error from usbnet_write_cmd()
back to the caller.

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/net/usb/net1080.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/net1080.c b/drivers/net/usb/net1080.c
index 19f6e1222d93..dd9f1361aed6 100644
--- a/drivers/net/usb/net1080.c
+++ b/drivers/net/usb/net1080.c
@@ -113,18 +113,18 @@ nc_register_read(struct usbnet *dev, u8 regnum, u16 *retval_ptr)
 	return nc_vendor_read(dev, REQUEST_REGISTER, regnum, retval_ptr);
 }
 
-static void
+static int
 nc_vendor_write(struct usbnet *dev, u8 req, u8 regnum, u16 value)
 {
-	usbnet_write_cmd(dev, req,
-			 USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			 value, regnum, NULL, 0);
+	return usbnet_write_cmd(dev, req,
+				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				value, regnum, NULL, 0);
 }
 
-static inline void
+static inline int
 nc_register_write(struct usbnet *dev, u8 regnum, u16 value)
 {
-	nc_vendor_write(dev, REQUEST_REGISTER, regnum, value);
+	return nc_vendor_write(dev, REQUEST_REGISTER, regnum, value);
 }
 
 
-- 
2.53.0


