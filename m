Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA1403B1F
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574586; cv=none; b=WI7DLAdwu+mh/G9xGt0MtSpfrowgRCbG57VH/S4ZUNfb8p6PTmmt/yuKb4HWRva8K4K6vh8NyYSoBn8h7C4de0Z6msbxXf6l3KC3SD/c7ix+3EW0Te3c8/voav6IdlbASswQ1MKTEurkGZwDiziSFIvefpO6ELDxiQooGdbgi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574586; c=relaxed/simple;
	bh=/p4Yl9cRrA/08EFs7XUHDyj23xIlq6ZPP0gzi9wHapg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9cl1r0YlzJYdoJfmLSuNnetuLzC0M+VndE7afsvzD/HYv9mI+JTxcri8obTEd0H2V6+/vfuqgNnHsPULQRUiKW9q47+tNkKNeCSJF4Y9j91DYiWv+/lPe0sStrJZhtwFf7fbPP+ygCKeHnz2kzu3XjXKF4JJmNksEL01/DK7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USrDBV0b; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USrDBV0b"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-451fe9bf738so481975fac.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574581; x=1788179381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=udVPUe6IPHcf7p6BJaM0xcgin13VVHNN5Zpwgn/hQ6I=;
        b=USrDBV0bKQZq9JYtrMP2fBafqLKGBeX/fy3asHPsvY+XBbwv3V0sRSF7QKlk0w2al7
         cFw5Vwd2IYBOPkmoYH7USfKgKZCXUrYkZh5cDr8FPdRI8jLgtYhCJjMVv0Ab7yBxQhF+
         TTZCTwi/oZlqCukP8q94ImTs0zoQrorFjrM9hBQSJIJqdUasGIg6ihcck4D3SYuV14p7
         /1L/PgWtRgOQpDdjccYU/3O8a7HMI0LDTM/nu1DxeUY29gmUzV7DhVZF/X3E+jv0Ytwr
         XiIX5vSx/WphTevs3Zrw307wYpgD0scVEuOagsdam7X3Ap4PTmyuWMP3C7kYmhhInOcf
         QcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574581; x=1788179381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=udVPUe6IPHcf7p6BJaM0xcgin13VVHNN5Zpwgn/hQ6I=;
        b=mFhau4sjz7Yfao3eFkS0+8jIkmMYXprPKknaXTdAJPEA1yVFcPZ8giuRNfgcIY7Ung
         N0qWexEIoq6rBKE1PyIadba4inoIXdgRoWfVA1QXCXfymfTOOJSjMWQdft7WYPWbyAp4
         gYN5BwUMpVE5WYeowIx8/NfYC53ETPP1rD+7YUesrMxvnaaC+tIXwmYy9bkyIdY29aRK
         XyqFW7X2eGHPToiI6Hr2u/uQcII1M9kOOX9p6v66w644RGNMHGMk6TKIc8Z2kyR12AJ7
         vl2dXkFQ2Yc2JYBtPL09xplcAilNDl92Lp/ooNEd/IpB+2HkskKWlpX6ZLvcagoVBzvo
         Pwrg==
X-Forwarded-Encrypted: i=1; AHgh+RoE3jq7sPxde4ZCvQNxDtpg3Dgr0/LGUG0wGrYvP5NA/ZFfXb859NehZY1isbp5qAfKcdFTLVc=@vger.kernel.org
X-Gm-Message-State: AFuF++m+XWz+q/lkO5nbXtQtgkTp3aByoDlFLqvKAnPi/FJSYv0zZklN
	Q6JN+95zRqkwrva4EHZRyayIBrmzOduJPgdNobVD/OA8nq/44hNQahZ6
X-Gm-Gg: AR+sD11btsflI+Hf+Ww7pRwv5snw5V41PCOW3FGSMJVA8ijeNZ7HTPVRb3p4IJJpvXo
	lLuHMKpMUvfoFMFe7E6xA4FdXCaFLWdHHdWxQGlBOUgMOA4n1bEfiarL0XnJgC6iibVkjdHK99j
	ra0r8y0C7iOwpullwfJrIsxgpURc33OklUy+YN83enNWp7tb3mgf+qbOTqu9J7TJQgpy+ypCgg6
	0b+gtXeEiuEASHlLIqbXNHpEXZKCXV1HSGKsH3B7VCoaye5IBbN6rXGXfRk9zlk8gHIsxNk3e4a
	D3475L2EP06C7yXmid/si92QPF11anM4sG3mkq9PRk/pOrQi1tBF7ac1OLGxpdKjdt5IR5KF7U9
	+TeVeZ5LKa32wWCEUopeHA48B9r/3tJSS79s7MwKOL6VJ+CsK3CoaUDoqYWgMaw4rThNEPGnaNv
	FJ+z30tRLDNJ2umC7UI+TnDOdzCVtuQ6H7mX8zNABWCuGC2z6UtRwaxf4aleOb6iB0+XscHQWQq
	geOuPz6zfyww7LKuDMNaZfeDRpwlnuJAdbr+17HhEY9i7OnLETu5X87
X-Received: by 2002:a05:6820:341a:20b0:6a3:6bb0:e584 with SMTP id 006d021491bc7-6b1592c253cmr9992591eaf.1.1787574580793;
        Mon, 24 Aug 2026 05:29:40 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b17c832d31sm3598839eaf.5.2026.08.24.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:29:40 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Tuong Lien <tuong.t.lien@dektech.com.au>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net v2] tipc: protect node reset trace dump with node lock
Date: Mon, 24 Aug 2026 20:29:29 +0800
Message-ID: <20260824122929.210431-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tipc_node_reset_links trace event asks tipc_node_dump() to walk the
node's link entries. Unlike the other node events that request link data,
this event runs without the node lock.

This permits bearer teardown to free a link while the trace callback is
dumping it:

  CPU 0                                CPU 1
  trace_tipc_node_reset_links()
    tipc_node_dump()
      l = n->links[0].link
                                       tipc_node_write_lock()
                                       kfree(l)
                                       n->links[0].link = NULL
                                       tipc_node_write_unlock()
      tipc_link_dump(l)

tipc_link_dump() then dereferences the stale pointer. KASAN reported:

  BUG: KASAN: slab-use-after-free in tipc_link_dump (net/tipc/link.c:2910)
  Read of size 4 by task poc/115
  Call Trace:
   tipc_link_dump+0x10cb/0x16b0
   tipc_node_dump+0x4bb/0x740
   trace_event_raw_event_tipc_node_class+0x258/0x360
   tipc_node_reset_links+0x14d/0x1a0
   tipc_rcv+0x13f5/0x3030
   tipc_udp_recv+0x4e3/0x670
  Allocated by task 0:
   tipc_link_create+0x1e1/0x1020
   tipc_node_check_dest+0x7d2/0x11a0
   tipc_disc_rcv+0xdbf/0x1430
  Freed by task 89:
   kfree+0x131/0x3c0
   tipc_node_link_down+0x267/0x4b0
   tipc_node_delete_links+0xec/0x160
   bearer_disable+0x107/0x260

Take the node write lock around the trace event. This serializes the
dump against tipc_node_link_down(delete=true), which frees the link
under the same write lock.

Do not take the lock inside tipc_node_dump() itself: several dump
callers, including tipc_node_link_down(), already hold the write lock.

Fixes: eb18a510b5cd ("tipc: add trace_events for tipc node")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
v1 -> v2:
- Use tipc_node_write_lock() instead of tipc_node_read_lock() so the
  dump is exclusive with link deletion.

 net/tipc/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 683a136e53ef..127848e8a644 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node *n)
 
 	pr_warn("Resetting all links to %x\n", n->addr);
 
+	tipc_node_write_lock(n);
 	trace_tipc_node_reset_links(n, true, " ");
+	tipc_node_write_unlock(n);
 	for (i = 0; i < MAX_BEARERS; i++) {
 		tipc_node_link_down(n, i, false);
 	}
-- 
2.43.0
