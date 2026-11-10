Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316841;
	b=L0ZQxNeoqNvtE7vQuiEN5uAFBCXvd5SLrLV+A/R1FgLNX3Igk/KO5gUZBW+wwFrJf/I8
	 nM02AhIAnndG0FuC45W/gMdF+cUSKUQBAy9ya3b32qk5YhULbx/OlG8fyzhIc/zk0OU4w
	 cSjFN70BxXCPKwnbGopCMXF4rM5lTnKp/jJG+QP2RpjCRkwn/XWF+1l5crbwG5Jbku69C
	 7oeEX+URjzGDXulCmAocyB+QXBzXUSf6WEAqLd2rOpHdtbnzeb7OZ2cewqIXDlomylme0
	 MCKPveMxvPlZfIsgVUEyZeD81Xvig4Pudm0w6g9FR8m+G62nUvFOlKGtkB0ENLjZdZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316841;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o3j8ZSLUlMW9spzjCj6Lf6ZyTqWduSvktrPcGEoHNnM=;
	b=Cz+HaNHTubxAoqNduPhN3lD23k+4fYZgTwYxBcOWI5UrQASzSYMD+wjPKz4buqGxoKYn
	 IPynH8ZT6yB6JgB9ktj0STTWNn5VJ6qGi3p+Vx35yOGMG+N3YouMsokic2FuugYnS3EAz
	 qQX+/PN6rIJdaptM/VY5MPf1mTDS3JWiodUEhfvWtdI2F80Y6KX2+EBr4pSKRTN/fca1G
	 CVv1TyYkdz0m9feCPo+zfNTZtr2CsaMKLw1HFkHh5O14mrO4SiM2JSYK2cpYdOZkshisj
	 op4D6ttn5MPmHwehpfsV0tBSkh7UBqK1Ll3wcjGqUddWfYoAlGH/B4INCPxKdDeuq6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SaBByJ2B;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i+5XCEtm;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE35606A757
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE35606A757
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SaBByJ2B;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=i+5XCEtm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3j8ZSLUlMW9spzjCj6Lf6ZyTqWduSvktrPcGEoHNnM=;
	b=SaBByJ2BOzyvBmtz/rDECPHQpIhqxQ8themoKDcECSk2gEvz5hKjsQX7nRj7EDCMJ+naCx
	O18sRcfCXK871si4ey4SyVrx8qhWtpw5s+ZGS+W4U8/dLlCqHK+ZXkJ2/sufPl8G9637pi
	TT4ph8SM9UT0LcKeIi3tWv4cPUwjx6w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-bT7rl6ouNLWwPQnhNg2fHw-1; Tue, 10 Nov 2026 08:20:16 -0500
X-MC-Unique: bT7rl6ouNLWwPQnhNg2fHw-1
X-Mimecast-MFC-AGG-ID: bT7rl6ouNLWwPQnhNg2fHw_1794316814
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c210c66672eso209362066b.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316814; x=1794921614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3j8ZSLUlMW9spzjCj6Lf6ZyTqWduSvktrPcGEoHNnM=;
        b=i+5XCEtmpFWipFgZNLE/fMc723DK5Ny/xxXGHMwawP8OlJErf09CL2Kd6S1HWtelVY
         0zuny+/muaJNJ88KY68zQHVVG9rHZ+MM5Ol1hIrYV3EbejqvN/SlDmdkKKCkM5sGJZbw
         3Pt4Jh+b8OXbZ6IEOtO62/Q9QIGkkxlrHZEBib1vjauncP8CRsER39qLbpU+PIN27fuH
         cbTyBBpeEz+/4O4bSV3vEmKdMKM4qQNCqAQWTfJFpl1xJUc40dWzRhueU/nCSn4DA/u6
         hju+8l8mYQJsSUTfCExcYwzApOkH09e06ykd90tqOEJ5B3cCyFzjuXIgreztbKVEIIt7
         WZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316814; x=1794921614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o3j8ZSLUlMW9spzjCj6Lf6ZyTqWduSvktrPcGEoHNnM=;
        b=gnk94dr0xbL10zv3Wii3o02NnHpTjWMRC9vk07YCFKH5qbPpB8IbVV0XjT0Svc+Fe8
         ugQM1gJky1Oa18QMvgutQI0pzpm+K5dfUjHhr2by0WSRCW9I2NtXmHLT+IIZBE9CRfJw
         z2FEgj9lQOK53y7DvnfZN9Ezy6956YMiuHSxs5wRbuEHJPjWcpZrhHfMkgf85ePS89rp
         9W1uAekkT1E34jJkIiEObNojk9l5gIY+d6i/Mlm+Po33s7SGeCpcx40LcRJ6gZEsylUO
         HVZeO5bgNDDlSDOoDdfuGibmTGzOOQ0a26ALaYjM8K8CqxqwWhdmQCcqoPUytsSQD89c
         Qpag==
X-Forwarded-Encrypted: i=1; AL+hErFPJHYqNrQsXt1QjUDa8X93ml+dVJW68VEaJJvEmrM4VrYDKmV3mk+GJO+TL45sV9CAdaaOlAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x9/FppYajGxl5z6qgedZW7vpC21MSs6YKtpevA2SYQcYyXa0v
	BOuJyPsFq3cBf0o2tvFOtXfN8xWyt/pgk9N11Pf5pPK922+lai3SkRpZLe7lBfal7VnZ5k/AphX
	gXWBv98HD6YJEWN5+spkIFD06432OV35Wpk/f2+wNmPZFBN5SiaV+BAOzpQ==
X-Gm-Gg: AYBFou2dsfaE0JWLHGqIyP1u6QZVB7VyXkG1XkMZnIG1Xubt1jenuXlMQypmL1o4uVi
	yxB1F3sipJxnnQ9TignTom/QhoySwRRWMv3oKLrm52nzX17Yw49Ipc1939n3/IdIPH+h3E0fYdd
	mONrT8r9v1GwZ5i/+ky7uedcO6bLabj5sIpUOI9n1HqLHMHILuHDEJCjFI36/0hIedBRu5xHACn
	l+wJPvfm4rHIaM/J2Io4e13vy2wfDL2/gSFH60faI4mMB61DdVmsIUdrete6IzMpPqBRVlqACl3
	XREDsYp1MUx9IjclEcg55m37/WN0r2HXdH0mUquii14u5fSw0g+ft6ANC7dg1xnRwh3JMTmlwY3
	uKrPK8fQPtEr6plAHLAByVH3FeH4Gjk3yp7O+998UPkViqsUfBAom833KMD1qBuNCXNVXB9l5bD
	dztcXl5QUSIeg+L0leBBncR4wSKfB9EzyyUlhsBuBn7QP2Cl1fnP5yirmVaTSTw+98gK7X6fI5G
	igKvNRjJU2uajCaOjkAGG9NG354A5rNo9XJVU9pFISOSxxZXy+t
X-Received: by 2002:a17:907:d7c9:b0:c2e:2252:6ddb with SMTP id a640c23a62f3a-c50495dfb72mr227137266b.10.1794316814427;
        Tue, 10 Nov 2026 05:20:14 -0800 (PST)
X-Received: by 2002:a17:907:d7c9:b0:c2e:2252:6ddb with SMTP id a640c23a62f3a-c50495dfb72mr227134966b.10.1794316813994;
        Tue, 10 Nov 2026 05:20:13 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:13 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 04/12] io_uring/opaque: add owned-page helpers for dense copies
Date: Tue, 10 Nov 2026 13:19:58 +0000
Message-Id: <20261110132006.3280986-5-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110132006.3280986-1-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
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

Add the accounted destination-page allocator used by CREATE and compaction.
Prefer compound allocations up to 64 KiB, or one base page when larger,
and fall back to smaller orders.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 io_uring/Makefile         |  2 +-
 io_uring/opaque_compact.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 io_uring/opaque_compact.c

diff --git a/io_uring/Makefile b/io_uring/Makefile
index 81710127046c..191316972e04 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_IO_URING)		+= io_uring.o opdef.o kbuf.o rsrc.o notif.o \
 					query.o loop.o
 
 obj-$(CONFIG_IO_URING_ZCRX)	+= zcrx.o
-obj-$(CONFIG_IO_URING_OPAQUE_OBJ)	+= opaque.o
+obj-$(CONFIG_IO_URING_OPAQUE_OBJ)	+= opaque.o opaque_compact.o
 obj-$(CONFIG_IO_WQ)		+= io-wq.o
 obj-$(CONFIG_FUTEX)		+= futex.o
 obj-$(CONFIG_EPOLL)		+= epoll.o
diff --git a/io_uring/opaque_compact.c b/io_uring/opaque_compact.c
new file mode 100644
index 000000000000..b59c7cb95d42
--- /dev/null
+++ b/io_uring/opaque_compact.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Workers copy immutable backing without holding object table locks. */
+#include <linux/highmem.h>
+#include <linux/memcontrol.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
+#include <linux/sched.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+
+#include "io_uring.h"
+#include "opaque_internal.h"
+
+struct page *io_opaque_owned_page(unsigned int *order)
+{
+	struct page *page;
+
+	for (;;) {
+		page = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_COMP | __GFP_NORETRY |
+				   __GFP_NOWARN, *order);
+		if (page || !*order)
+			return page;
+		(*order)--;
+	}
+}
+
+/* Destination allocation for dense copies and CREATE. */
+struct page *io_opaque_dest_page(struct io_opaque_store *store, u64 pages_left,
+				 unsigned int *order)
+{
+	*order = min_t(unsigned int, IO_OPAQUE_MAX_ORDER, ilog2(pages_left));
+	return io_opaque_owned_page(order);
+}
-- 
2.34.1

