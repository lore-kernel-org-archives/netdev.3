Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAB63C8724
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838028; cv=none; b=keAKqH+au2vMfZw7AqlxSEmv83sts9Pd1uQA2BepvguWKdup0G3TqoFawnZUjI7sv2JS/NnkLWRi9t14atvVI+c9HsVR/eqV9pliSXFMdkPLC2bGjHgPjKuqopfITMDL/6feFbo2996s5NOS5FpFCjR9lz90p6pHaHydkfyJs7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838028; c=relaxed/simple;
	bh=rmXCZFpKxJzazxmjn8bzq96ps74DVqbvt62SKSYliVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbCxy0w1dgspyesGzII7VoFhNyt7Tk/nc8xOU+1mPIz+UIdeAduvQqFd4JDbeF4S5JjcZGWIz69oP9UZtuIOg8UzLBDa2hrhHWFNkW52Fsm3LY1rndP1e+d7SPNQqDYsISu62Dc+MYWxA1eWQ1PYqt+6ofpng6AnbgeNDIo4M48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpFZN77J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsZjcXlq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpFZN77J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsZjcXlq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782838025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xiOPZVlIWXYiaqpOQmyOxWG5vDCdJG1lOjq1LsrNa5o=;
	b=VpFZN77JDZRPgZtWHOgwD2AJXkEPaqlAYkqmIAhBlwBLVpKTHSibRUY8Z60p2jjAnW5qRg
	lMMEKtshu+C48sAxKemtBYuo5ICyIr1Y9aFH1bPja3p6UIF+ryi5kby1+yypTi+K5GV+IX
	6gHylxwKFF+d0Rw7Zhgvz79WwLDPaXU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-StrHZVLiNNW00esmhhJilQ-1; Tue, 30 Jun 2026 12:47:04 -0400
X-MC-Unique: StrHZVLiNNW00esmhhJilQ-1
X-Mimecast-MFC-AGG-ID: StrHZVLiNNW00esmhhJilQ_1782838023
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84622d6102dso2819937b3a.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782838023; x=1783442823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xiOPZVlIWXYiaqpOQmyOxWG5vDCdJG1lOjq1LsrNa5o=;
        b=VsZjcXlqCcjXoIe10ZpdDfp6Yui8Fhw6oTXgUZapYMULjzdl5CJ3E7povb2zv5ZscP
         k0uT+EztKLZLE/Du4UtXRN0dJS/m3ASwny3u2xzkT2Bq5vAc6hjtHz8mDn3iVtbyacfD
         +G+JrMfpleTKRFrkPfelK0Mx+GGoocwlZsY8O1AXwK+EgKDnn2yzuGoiogwSxFS/LQFL
         746qgmsd8upwRraSoMg6GCNrCLVcvzcHz6qMkVO+AiHomiQY+YMTzva+w7ym4LO2O+PC
         SyVQpz4PPVcmMoFHvktU7V07tHhPiCkJFbjvtjjyPjOcdoH1lZMk9K9zm3Xe5gplzLdP
         rdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782838023; x=1783442823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiOPZVlIWXYiaqpOQmyOxWG5vDCdJG1lOjq1LsrNa5o=;
        b=VwQWAIeB8HsBvxjLTCscED9pieAy7IYMO6tpPohcUTcNfryyduHEjukc5Y/5gK8KEJ
         vXpfmIyLpZiUQw5vm0npjSu3LGRZULl182+QxdKsZVx+H6Kyi/FIcCJzOsmyuur5qWV8
         DK1FZWSnEsFQTkPMOMWc+5uzTeY3Di4K9p2WpZd7gHi6XCXvaPvaOcyIZt7abe116dNr
         2wkLAoBXKmiwLymkua+7xVFIKLITET3lQ3CgoXofP91f90blGprJGNM1xOcNT3Euv7lu
         y2OVlMWi6ZMCDU+/P26pDM96bkxvv6NxNNxhwX8rcBJiOvnEdbXJW12WFI3YDHG2lDQk
         lujg==
X-Gm-Message-State: AOJu0YxUhpftiRb6hfqkOKFlGdnEUZDlIOdiZtdJ9xfwQR8FXlA1Y0LG
	2f695+aotgFbXdYTYwsGfWalNd3WmQK1yQOpVTjOKO97TGZInqNb3RuliHtkLkaw0tLCOc/CuQr
	SfutihrVfMdfu+sM49JLMgqqNzoHY1w49bK7REyncDt+12n/657zi8HxBcQ==
X-Gm-Gg: AfdE7cm+g/SWLpQe4EyiP9a/CuyXDKfnHACwWFQHPcW5MTPaGFLPyi1JXfteLcVguHX
	sQuTP9kXIriaG7pNlLE96EgHKDAqkpvfkXhRNCxsyrnT91fTPpalVGbZ5hGUOHsrPyI3z7lxqxL
	pMmEtceJDDjHKbqTnDURps7oVF3QY8+sZ/R67DtRJFX9aVnSwxPlmdsWBGp2SZHVVOIQ6KWV3Dc
	o4EZUZjyeyTk+bk0naHGejkkUbqJ4n+DW6hFyWj6KXNy4bMJSmGUsx7cE6rBLg32yXRoQTpyglO
	PV5sHcbAJSBbgaGMYRSPN3L+aa0pGqIRZMahV7W1FjW6AhWQb9VOjq+dhNAu/BOAsoP68+3m56S
	EuRyRW9+gC1dDKVTVWKnUreeRxpETnp3gzls=
X-Received: by 2002:a05:6a00:92a5:b0:847:8337:64e4 with SMTP id d2e1a72fcca58-8479f1f553amr3419022b3a.30.1782838023343;
        Tue, 30 Jun 2026 09:47:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:92a5:b0:847:8337:64e4 with SMTP id d2e1a72fcca58-8479f1f553amr3418980b3a.30.1782838022460;
        Tue, 30 Jun 2026 09:47:02 -0700 (PDT)
Received: from kernel-devel.tail62cea.ts.net ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03b9ffasm2378390b3a.59.2026.06.30.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:47:01 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matvey Kovalev <matvey.kovalev@ispras.ru>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] qede: fix off-by-one in BD ring consumption on build_skb failure
Date: Wed,  1 Jul 2026 01:46:20 +0900
Message-ID: <20260630164623.3152625-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qede_rx_build_skb() and qede_tpa_rx_build_skb() do not check for a
NULL return from qede_build_skb(). When it returns NULL under memory
pressure, the functions still consume a BD from the ring before
returning NULL. The callers then recycle additional BDs, resulting in
one extra BD being consumed (off-by-one). This desynchronizes the BD
ring, which can corrupt DMA page reference counts and lead to SLUB
freelist corruption.

Commit 4e910dbe3650 ("qede: confirm skb is allocated before using")
added a NULL check inside qede_build_skb() to prevent a NULL pointer
dereference, but did not address the missing NULL checks in the
callers, making this off-by-one reachable.

Fix this by adding NULL checks for the return value of
qede_build_skb() in both qede_rx_build_skb() and
qede_tpa_rx_build_skb(), returning NULL immediately before any BD ring
manipulation.

Fixes: 4e910dbe3650 ("qede: confirm skb is allocated before using")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 33e18bb69774..c11e0d8f98aa 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -765,6 +765,9 @@ qede_tpa_rx_build_skb(struct qede_dev *edev,
 	struct sk_buff *skb;
 
 	skb = qede_build_skb(rxq, bd, len, pad);
+	if (unlikely(!skb))
+		return NULL;
+
 	bd->page_offset += rxq->rx_buf_seg_size;
 
 	if (bd->page_offset == PAGE_SIZE) {
@@ -812,6 +815,8 @@ qede_rx_build_skb(struct qede_dev *edev,
 	}
 
 	skb = qede_build_skb(rxq, bd, len, pad);
+	if (unlikely(!skb))
+		return NULL;
 
 	if (unlikely(qede_realloc_rx_buffer(rxq, bd))) {
 		/* Incr page ref count to reuse on allocation failure so
-- 
2.54.0

