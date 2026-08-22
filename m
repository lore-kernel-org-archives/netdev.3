Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4D343883
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787416877; cv=none; b=ijVMZfX0MELNEE7q5vWK+WteHiDEiY4e6WIcSH823MekmGLwH8CrPI2oPUu3r9OJ+Wt7Bn0bZL0Zpz/Jg2cryvudAGTZezzzCkG6i3r0L1Rb2W3kFldt+2mUSNAKWUvaCrdJ02/LEIkiwDU/5K5lB+zBMxBqDSFJ/B0K5zy8vHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787416877; c=relaxed/simple;
	bh=kP1cz0Wgy8H1Vo4OIydwD7cCtpRNRp7He/gqzqKUjIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNsDK2ehBciESmAfqWxfa7prqDlXW7azTLPL7QhD7qeYep+uX1a4dcbPXZtTbA14yvN+JkDxDzRRC7KsTcZMTFLqMrku5MW0Ah+LyQ86bLD8iYRB0yQnoSWG6cO4LPVFtIRKwPa07oU5+hBn5jGcr8NXUSYBmAaArHvgxp9GlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faXOmRpa; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faXOmRpa"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-392af6bda98so239255a91.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787416863; x=1788021663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5sYAzT/WtRiW1Ix2HTkpoXUx65zoV0tVj4oWbHryfc=;
        b=faXOmRpadohKzUHTIGVP3KXy4KgLAxTUGEBvD3IMZwehSlXZ/UPlHrmFCWrYybWih2
         R5v1gpqGxBwTja3lqPfU6in32uG3AFRNrh9cA1s9QJ8l16kUyvMXrNTcmHppcoSbJswv
         OtcQ1NsrtSufcYRCAvNdcuMhscyK8YAflrTpPcGteNhvBEVGtb9z11iegG0//c1xtmvD
         OQ57nyh6v7EMopgtS1TuRkWiX3BKnAy//wK0slUE4U2pEPF/dNATvH91xvRZC9PYTk73
         +7dlVNVbeVa8f9p2HoPeXtMn55wFty3lq0loZi+0vWih6yUzygTkDTBy/C7OAzXNq9up
         JtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787416863; x=1788021663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5sYAzT/WtRiW1Ix2HTkpoXUx65zoV0tVj4oWbHryfc=;
        b=YL08ZhnIVGF592/jOn4nysUHa3Wld2RLowlT+qHKmgiBJHz+bfTCS772IsdU9Hv71p
         wuK1DYdCdv8d7QpGxmJs8LquzFdQAWAQ9/6mk/8p/LdCJd0szWHlXevAlnPPpRSj/JaO
         AmmoNfi6XAW+e60RF1YbIuE7XOBaCE0Y1dkx6TwpVMnnPMIG7ZYbVrBLEw267dL4kTxg
         Ql7DwJ9J8xJZj9c6xrS7pv/q/FTAKF85j1t4V+xEelYxNqq7V8WokAjtIOj1zfU4HHGk
         i75mEJLUTAQO0VQJxHAo5+53Kn73ZicR1cF6hOfEmmlsP31gWeWiweb/tk/0LyiP7xOK
         tg5Q==
X-Gm-Message-State: AFuF++kX2xtuULnR4UN52d4MZydhS7/CjqtJrSfAJA4DB11XbE1JpBkC
	7iO11hocFdg0h8zLAYxnqjec31lEibDyZYDaLeoJM3sW/+7btMCW5+5z
X-Gm-Gg: AR+sD115xP3NipqnupHevuv4vngv2xNquGIWnVfcLCwDF4U+9awTo+Xoduw6GkSEzpH
	J2UK20+W7RpXbVlqzpjNINrFx7ssBNcqMwmqyR5TJYcz9TyPn72xsp1IT9okeUIGepnKP92yDT1
	f0N8kHU6iZlRI4cPfGO4yvzsc+LdwyXmermfWiyu9CKh0MopPid7VHN0p/G2/51LrKA7JTRrQ6E
	aOdYpDFk4g5NxDf35/WSLskotQ2Ou6D4frYfCqM2dwEEYiKNkaGRk8Kb/bvZMjaU/wzrGxcwuGf
	EGvBI5ExaveSRfPV5SGtC9pGV7Irw4027J4pUJY912yG0faBIJz//YZCs4lmhRNzpMhzgLVo1BX
	yHkLDr6X2j/M2sOiXGfxKvlcS7GgmwU9HjAYA/+EBflmfBeKgRn0fpJVY8vdRATOo6QiT5xOa8d
	EJB8ppDUqU40bIwHx9Z09XWmZ36n6dJvQfw0/PGrm5fw4ELunnJXau7oBEJEN2RoAHPJWc0PkBr
	m29cQeD6cw97RycEZlultgM4o6Tk3Twl14nIA5flSijY+vsfcwK09c=
X-Received: by 2002:a17:903:1b65:b0:2d5:3f09:4126 with SMTP id d9443c01a7336-2d64b13195dmr134518165ad.4.1787416863141;
        Sat, 22 Aug 2026 09:41:03 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9209fafsm15580796eec.23.2026.08.22.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 09:41:02 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tuong Lien <tuong.t.lien@dektech.com.au>,
	Ying Xue <ying.xue@windriver.com>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tipc: protect node reset trace dump with node lock
Date: Sun, 23 Aug 2026 00:40:55 +0800
Message-ID: <20260822164055.3750284-1-nicoyip.dev@gmail.com>
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

  BUG: KASAN: slab-use-after-free in tipc_link_dump+0x10cb/0x16b0
  Read of size 4 by task ksoftirqd/0/14
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

Take the node read lock around the trace event. This keeps link pointer
loads and all dump dereferences serialized against link deletion while
preserving the trace contents and reset flow.

Fixes: eb18a510b5cd ("tipc: add trace_events for tipc node")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/tipc/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 683a136e53ef..127848e8a644 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node *n)
 
 	pr_warn("Resetting all links to %x\n", n->addr);
 
+	tipc_node_read_lock(n);
 	trace_tipc_node_reset_links(n, true, " ");
+	tipc_node_read_unlock(n);
 	for (i = 0; i < MAX_BEARERS; i++) {
 		tipc_node_link_down(n, i, false);
 	}
-- 
2.43.0

