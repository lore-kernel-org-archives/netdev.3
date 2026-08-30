Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5439EF39;
	Sun, 30 Aug 2026 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788077462; cv=none; b=F4veIyFg95dpASS7sWPpGvHv/yHgBLVE2iM67NvQOfQ1heBlZLnzH7KjJ9kShido9j4D6Ya/mMuUJxcecNdzMOq5Prlx1mA6sPEoe8IZGqsLzzwnNiZ2iH7MMlHAMftup6Hp3JiktRDVn9LnGuf5N9g4r44r1WVZR2i8StFb/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788077462; c=relaxed/simple;
	bh=hp8Mv9znBXG0owYcEsdy0ONGYwkVYXiBqvsLRzebEfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TngBwlCmKfXta5XEmrWK5mVfFEomrxr6k1Ahge4pdJL2CZl9Kiz167TIM7sfoS6SNWFXHUM7ZSadNC/7+VfqoZhkYDLR0eLSoK4yZjXc0SUeAxQpN6UkCWDUZoJ3muCGy4oz5gvbIfdGQdMXh2ybBZyhScymAOOq8m6hE8Rjvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQvyf6PN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQvyf6PN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8694B1F000E9;
	Sun, 30 Aug 2026 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788077460;
	bh=8L0DQGDXoOlsLX4qSHAjD9TzK8pF9McDUOUSa7CuY7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gQvyf6PN3R9q93P8546a/NefC9aYrfJGhZBZdpjV6Fe3KOAasOetNmw2TYaKTIaWd
	 ti9JZzWYYUJf25XhXJF7aw0PJbG9VTxfr9PXW1aPVAuYV6OCwdRidp5UtsJBXocH7b
	 pwkLM2eskU8MTxCy51CulWv6QW3cQOT8/GPPLXzGp3P9LspNcN5B5u6tJjV6v4Ohl8
	 9+AKGZNxMpWbcTaP7/ArMhsnOsBzCs83PzOlR/o2TTMC44Y85jBGh5cpjIdkpH5S//
	 VpoNO+wsaqsn7AI+FJrQBIynEb9zdVELyRUKuEX9qJX1WsSKvPI8vgK61eeT2K36So
	 3LLd3zSMFkfOg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 11:10:40 +0300
Subject: [PATCH 4/4] USB: serial: wwan: replace __get_free_page() with
 kmalloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-usb-v1-4-aa349c302246@kernel.org>
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

usb_wwan_port_probe() allocates the transfer buffers for the read URBs.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

While on it, allocate IN_BUFLEN bytes rather than a full page. IN_BUFLEN
is the transfer_buffer_length of the read URBs, the page allocator was
only used because IN_BUFLEN happens to equal PAGE_SIZE on x86.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/usb/serial/usb_wwan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index a183cc4515ed..a3929d3a3ec1 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -455,7 +455,7 @@ int usb_wwan_port_probe(struct usb_serial_port *port)
 	init_usb_anchor(&portdata->delayed);
 
 	for (i = 0; i < N_IN_URB; i++) {
-		buffer = (u8 *)__get_free_page(GFP_KERNEL);
+		buffer = kmalloc(IN_BUFLEN, GFP_KERNEL);
 		if (!buffer)
 			goto bail_out_error;
 		portdata->in_buffer[i] = buffer;
@@ -492,7 +492,7 @@ int usb_wwan_port_probe(struct usb_serial_port *port)
 bail_out_error:
 	for (i = 0; i < N_IN_URB; i++) {
 		usb_free_urb(portdata->in_urbs[i]);
-		free_page((unsigned long)portdata->in_buffer[i]);
+		kfree(portdata->in_buffer[i]);
 	}
 	kfree(portdata);
 
@@ -510,7 +510,7 @@ void usb_wwan_port_remove(struct usb_serial_port *port)
 
 	for (i = 0; i < N_IN_URB; i++) {
 		usb_free_urb(portdata->in_urbs[i]);
-		free_page((unsigned long)portdata->in_buffer[i]);
+		kfree(portdata->in_buffer[i]);
 	}
 	for (i = 0; i < N_OUT_URB; i++) {
 		usb_free_urb(portdata->out_urbs[i]);

-- 
2.53.0

