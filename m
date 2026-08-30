Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184F3A05C2;
	Sun, 30 Aug 2026 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788077451; cv=none; b=ePkwCRe5PQ4+2tekc2DU79tiQgW/c3obr4GQimZKF6S1Z3cVuDC9/BIpllSpAhLtgg9eS7xFLj4ULxUyJ8RStpwmPe4ltnPcg57IEr7ShShSE4PbFz1TUG9Ea/shwk5pM1ufvbSKqTTZ116JYW2BRBq1l1UguTIY5lYP9uqQ0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788077451; c=relaxed/simple;
	bh=zvobJzfo8005xKc0OUj3slmtopLv664TUoTq/v6mKXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISl/SpYO0qPl1FH6lhh32d1pAOodt+NhipQySzRxnQrQPMtXEDE5ZglR2Ka7Ti0p8EeZ4qgzkJqWDsJAxvIDgZckiel4Klwz89Jqy7uNNagv0f2XCyZd8eYZxCOJvIYuCHi9WL9I49Q0oh0R9s4CkyxRw6bbOK/XQVpGrUUksPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9AxY/NF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9AxY/NF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B971F00A3D;
	Sun, 30 Aug 2026 08:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788077449;
	bh=456eTZH5re1mOwITP+CRrgyuiPJU5C7OnY/8nFx1ZDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c9AxY/NFrk6YmMBtpXsB16Y8Vbd1+0AaacjabFZF0pnRDfVFy5Hmi2G6IDmZ9ghe1
	 qI7dOUiPZ4DEYk+Jroe6RyVwkh/zPP/sbJTzoC3zJuHiUCLnPW6U+1uFYfP9pTLQ73
	 izAsxvlg1XaJBB/3ahyXgXqogbE9+Y9fkZfDEw7pjb7f7/DG5uUZrWbVYNoTRPbsgC
	 meTIUd7SUJXTdoBOr99jIZfPUG4n4BgzjvQjTtwK5co9DnDlHg1kQrkmnhaBRJ6IBc
	 vFKoEf/sQnNy2S0/Vb1xiFjoJykWxEYA/7pdejplhy2d3sLlgYiF/CBdIyzmMb0khh
	 yAHkcVEJZYFMw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 11:10:37 +0300
Subject: [PATCH 1/4] USB: usbfs: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-usb-v1-1-aa349c302246@kernel.org>
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

do_proc_control() allocates a temporary buffer for the data stage of a
control transfer issued from userspace.

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
 drivers/usb/core/devio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 101cb9425480..9a7cc7cdf00b 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1190,7 +1190,7 @@ static int do_proc_control(struct usb_dev_state *ps,
 		return ret;
 
 	ret = -ENOMEM;
-	tbuf = (unsigned char *)__get_free_page(GFP_KERNEL);
+	tbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!tbuf)
 		goto done;
 	urb = usb_alloc_urb(0, GFP_NOIO);
@@ -1265,7 +1265,7 @@ static int do_proc_control(struct usb_dev_state *ps,
  done:
 	kfree(dr);
 	usb_free_urb(urb);
-	free_page((unsigned long) tbuf);
+	kfree(tbuf);
 	usbfs_decrease_memory_usage(PAGE_SIZE + sizeof(struct urb) +
 			sizeof(struct usb_ctrlrequest));
 	return ret;

-- 
2.53.0

