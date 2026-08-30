Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676639E9DE;
	Sun, 30 Aug 2026 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788077460; cv=none; b=pNE2t9HZD19vM181lrTq3ta1yniePUrTVNv5tuVxKS6nkhvyOeE86j2PzEIAkHTYVDFwZwCSt7AW1Aiw678vKuMkWnpkTzahGdzl5p+mPJuQGLHNojwu8sPk+gA0BkX1AL2OecjYOoeWIevP5uY6VtTQcvFBZKQgN4E0yEX/fmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788077460; c=relaxed/simple;
	bh=51Iq21KEmwY2b/eHw0eax2G6n4JFK+f/r+vLOJ246mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9s91N11+REVsEzxmdMqNcPOecg3cJxJEBXLtYD2h56CKthtzUEEQ+K2y/UTtIgW2j0VY+ikub+CzTtNmRmHgljlDU4Lcb8TfoKaxavgQpcLq1oqJKTMNryLl/b8BhwB0nPJ9/9RDdNCX5iF0PXO4J7KjuGOsXIivFntJT2q0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIROzJlE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIROzJlE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F3E1F00A3D;
	Sun, 30 Aug 2026 08:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788077457;
	bh=nOm9eBZiZjf8UMoAxzpiMIxa0Bir8gKmGDsW4008HnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lIROzJlEfhe9fXXQpOEPInD3L5t2aTRzsfV9UdXXzCDPi7W2cE8UBPf37fFvWjYQk
	 rCrWVvOSWFf1MGY+NG2XsmSU2+4zrmFZy5rS0+NKX3id4dcLkaRlhkC0G6NVYc5IrR
	 X3kCd0YHNLYFzhlJ4Hbny1wOWbDi/TPHNbWoaaJ/8RArHJbyjT24E2QQ+KMa3ItzQK
	 QdVfGyePaxH3c/pt9RxT2iVoXIFkX9DF0GQLhVvrRLgRPgoCwX9N0V1oPug2oha87a
	 l5r92IFro7ZgEnUErpB3y45+eNIVtSfjOB/WNOuWl1by5KYRgXIYnwtgQvqHnl29YQ
	 +ovxDN+LpS1gA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 11:10:39 +0300
Subject: [PATCH 3/4] USB: speedtch: replace __get_free_page() with
 kmalloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-usb-v1-3-aa349c302246@kernel.org>
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

speedtch_upload_firmware() allocates a temporary buffer used to feed the
firmware to the device.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

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
 drivers/usb/atm/speedtch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/atm/speedtch.c b/drivers/usb/atm/speedtch.c
index 9d28c652bcd8..e5e021aafbd3 100644
--- a/drivers/usb/atm/speedtch.c
+++ b/drivers/usb/atm/speedtch.c
@@ -241,7 +241,7 @@ static int speedtch_upload_firmware(struct speedtch_instance_data *instance,
 
 	usb_dbg(usbatm, "%s entered\n", __func__);
 
-	buffer = (unsigned char *)__get_free_page(GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buffer) {
 		ret = -ENOMEM;
 		usb_dbg(usbatm, "%s: no memory for buffer!\n", __func__);
@@ -340,7 +340,7 @@ static int speedtch_upload_firmware(struct speedtch_instance_data *instance,
 	ret = 0;
 
 out_free:
-	free_page((unsigned long)buffer);
+	kfree(buffer);
 out:
 	return ret;
 }

-- 
2.53.0

