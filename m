Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381D39EB5B;
	Sun, 30 Aug 2026 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788077454; cv=none; b=V9uv+Vahrzg2a+p7R5E1Rkw+epbO236Z/LlQsW0VL7HIZSG6/sG31q3lu6z2Ob6gtNz1DaPbXxIEeGnpYyk/AnWEVuj4FEYHcj+C2236+8zn5OyXo9pc9IKYny2sunkGUAz57S991+CQNW09jTC+2iFZ6kFPaorLhsMpyr0t21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788077454; c=relaxed/simple;
	bh=TODqA+9vMbMUCTXUsV2+Vje1sot+/vIZvxDEvSzzoxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYdVQDO6ZwjHOtOoj0x+NSaymeu0CseCFCTYBlW87U3nNnfbLxTsrVe6cma3rJwBZWKLRBUnnAUebNwtHY4jly+GQPR6cjInuWuctmkuVbstodA64W9j5O/VTCObyWsmg7leVI4haxOJfMkBbLNeMyhHzWUcAwURkG6WsGBEijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoUjINXM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoUjINXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D921F000E9;
	Sun, 30 Aug 2026 08:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788077453;
	bh=F0ab/FRyl7xwjV92cpw9DkLnKNb13jgD1FH/6y8ErV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XoUjINXM1Y4uac2VQ5A3L22S2Gg3pNsrrS2hFECFKPp3OzSpF4FX4Y1BIxnhRO+vG
	 R+V7nVfJB9UZ9GZanBQZNEpqRnktgaXbb+SX+uwrY4+p8tAqOlVX0N3XRFzc0BiV+q
	 HsD2riN4MVuw1fkt0VSmb8AQXGHJ+4/HLFB0KxqkiQhoMjJqm+ZbFQme7ieCYbADx7
	 +j6LQLKllK8zKsroDeAsT6iPmxOYelfZ7z3omirYLGaBFU4o7NAvGiCBSc9/VV9lPq
	 FLftTs4vMlF3P6ufiC8VAjl0zqzx2aFqTvUsHH152ezS4xIvC/Kcux/mIOlobgLypK
	 6b5ATDQZF93OA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 11:10:38 +0300
Subject: [PATCH 2/4] USB: cxacru: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-usb-v1-2-aa349c302246@kernel.org>
References: <20260830-usb-v1-0-aa349c302246@kernel.org>
In-Reply-To: <20260830-usb-v1-0-aa349c302246@kernel.org>
To: Chas Williams <3chas3@gmail.com>, Duncan Sands <duncan.sands@free.fr>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Johan Hovold <johan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 accessrunner-general@lists.sourceforge.net, 
 linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.17-dev

cxacru_fw() allocates a temporary buffer used to feed the firmware to the
device and cxacru_bind() allocates the transfer buffers for the command
URBs.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/usb/atm/cxacru.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 636f7886fc26..75d87c31e81f 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -942,7 +942,7 @@ static int cxacru_fw(struct usb_device *usb_dev, enum cxacru_fw_request fw,
 	int offd, offb;
 	const int stride = CMD_PACKET_SIZE - 8;
 
-	buf = (u8 *) __get_free_page(GFP_KERNEL);
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -978,7 +978,7 @@ static int cxacru_fw(struct usb_device *usb_dev, enum cxacru_fw_request fw,
 	ret = 0;
 
 cleanup:
-	free_page((unsigned long) buf);
+	kfree(buf);
 	return ret;
 }
 
@@ -1146,13 +1146,13 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 
 	mutex_init(&instance->adsl_state_serialize);
 
-	instance->rcv_buf = (u8 *) __get_free_page(GFP_KERNEL);
+	instance->rcv_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!instance->rcv_buf) {
 		usb_dbg(usbatm_instance, "cxacru_bind: no memory for rcv_buf\n");
 		ret = -ENOMEM;
 		goto fail;
 	}
-	instance->snd_buf = (u8 *) __get_free_page(GFP_KERNEL);
+	instance->snd_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!instance->snd_buf) {
 		usb_dbg(usbatm_instance, "cxacru_bind: no memory for snd_buf\n");
 		ret = -ENOMEM;
@@ -1220,8 +1220,8 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	return 0;
 
  fail:
-	free_page((unsigned long) instance->snd_buf);
-	free_page((unsigned long) instance->rcv_buf);
+	kfree(instance->snd_buf);
+	kfree(instance->rcv_buf);
 	usb_free_urb(instance->snd_urb);
 	usb_free_urb(instance->rcv_urb);
 	kfree(instance);
@@ -1254,8 +1254,8 @@ static void cxacru_unbind(struct usbatm_data *usbatm_instance,
 	usb_free_urb(instance->snd_urb);
 	usb_free_urb(instance->rcv_urb);
 
-	free_page((unsigned long) instance->snd_buf);
-	free_page((unsigned long) instance->rcv_buf);
+	kfree(instance->snd_buf);
+	kfree(instance->rcv_buf);
 
 	kfree(instance);
 

-- 
2.53.0

