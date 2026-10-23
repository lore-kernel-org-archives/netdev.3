Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724168;
	b=eAlBkrzViaUD6QYGPwEaB4MGyLmGxX2jBp4wK3RZf5i4oQWoYwxAOpIyrJG6Goh2ByKI
	 SSbewummzhOfxotNodv9HqJlHfFfsN46Dl93Nuf35jgzBga7DLHMosXouSpUl4NcpB+LV
	 3nMN3ET+JT0YZ3APzF747FrJafqKyptiRCrEnLQ2i7EtkBYrjbag/l65TiwgyV/PqFJUd
	 6qzI+xD17Eo3WppQCdsbv+E+2S/1hq5RRgVEVu2066oIkK6J/KOuotI63ysaH8JBO0BAI
	 3LaralcAiwwIPhMoYrwdFryLvw556wnEemL5DWoRkKhg5/qx3c64pQmYBxa/XKVpzhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724168;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0NBcZ8Dc846NXeDzPbXmnfnDZIArTs349/6UG5CKO7o=;
	b=3qmX+aMs5Xt6kmuG2xrLwF03FtngpGi08XaLw1tVQbu5Cj1yOWDvNpWiHtTPBXy8Fx/J
	 hWnmBVvKbZlUfz7iROkFIcalcSWfBZxfHiI696UAeRa0wEsiPeYN1YKStqUDMgBmwOlnI
	 uYVJ2l6SV1buS6b7KS7vaD77ED3YmjHWhcJncLPCEfq+kzUMaqlVUzDalU2J82lSEzj+o
	 ZbPjIOzN1P7LDNTQCSL+zk+MSr6oDtFycfGAcbrz+10m1DlpYrqdcUe16/MZLUuKh31ti
	 TonOeYWVxIF29pvZc3P6AWw/FSf6k7Hlt7Sr/eoJ5hMaoYQItr+/WtF34uzRx8B5wtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="c8T56d/I";
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7625E606A319;
	Fri, 23 Oct 2026 02:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7625E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=c8T56d/I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=c8T56d/IVwOVEiGDGP+d67JiBMotllZbmhksB3AjIxXFLd9XffVu+1eBpWLrRXLfs5L7rhxTFTWZY
	 rqvRAPDeY6dDVKuCDCI4ban534MC0T+gv2iqlL6GH27/OvPKPLTJnXUavOivb+Q7xIT8L1VwZ58+K/
	 vdb26IpBuaZIi0sI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36adaccc3ecd-0090b;
	Fri, 23 Oct 2026 10:56:04 +0800 (CST)
X-RM-TRANSID:2ee36adaccc3ecd-0090b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56adaccc2da7-3146d;
	Fri, 23 Oct 2026 10:56:04 +0800 (CST)
X-RM-TRANSID:2ee56adaccc2da7-3146d
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Subject: [PATCH] nfc: pn533: add timeout to USB frame send completion wait
Date: Fri, 23 Oct 2026 10:56:02 +0800
Message-ID: <20261023025602.1746-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pn533_usb_send_frame() waits indefinitely for the out URB to complete.
A malicious or malfunctioning device that never completes the transfer
blocks the caller in uninterruptible sleep forever -- e.g. during
device probe in the usb_hub_wq worker -- triggering hung task splats.

Bound the wait with a 1 second timeout.  On timeout, kill the URB and
fail with -ETIMEDOUT so that probing or the command in progress fails
gracefully instead of hanging the task.

Reported-by: syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=1c5368988052dc2d8201
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
 drivers/nfc/pn533/usb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index 0b7e3b118d..c2633b5da8 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -30,6 +30,9 @@
 #define ACS_VENDOR_ID 0x072f
 #define ACR122U_PRODUCT_ID 0x2200
 
+/* How long to wait for the out URB to complete */
+#define PN533_USB_SEND_TIMEOUT_MS	1000
+
 static const struct usb_device_id pn533_usb_table[] = {
 	{ USB_DEVICE(PN533_VENDOR_ID, PN533_PRODUCT_ID),
 	  .driver_info = PN533_DEVICE_STD },
@@ -184,7 +187,12 @@ static int pn533_usb_send_frame(struct pn533 *dev,
 	if (rc)
 		return rc;
 
-	wait_for_completion(&arg.done);
+	if (!wait_for_completion_timeout(&arg.done,
+					 msecs_to_jiffies(PN533_USB_SEND_TIMEOUT_MS))) {
+		usb_kill_urb(phy->out_urb);
+		phy->out_urb->context = cntx;
+		return -ETIMEDOUT;
+	}
 	phy->out_urb->context = cntx;
 
 	if (dev->protocol_type == PN533_PROTO_REQ_RESP) {
-- 
2.39.2


