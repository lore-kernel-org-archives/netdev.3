Received: from cvsmtppost28.nm.naver.com (cvsmtppost28.nm.naver.com [114.111.35.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29D41D12C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447937; cv=none; b=SI6ndUQF4J+h9bG0JqxrjCZGRbu5mAguStu2rRkB6cMwxaJeLkqRibwZFMNLAZWvHmc88EwkxhUVxlTCoSBl5hgyQcgz2EyTsPCEYQscCgA1IOGAd167A9FpV9i0cYMb5yKcz5qdNEHFDGlmoESXR1sL146NlBEIJw3VFFXO08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447937; c=relaxed/simple;
	bh=ZaFNBI9fd7vodGbEU+jo7hQ4HNN89K1CXiQN6lAy+bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OeqgIvxwLupr50yci77Utolt2zTLwUdwwuojFG2qm8Zh3a6YS25vFhYT0vxgZ4r6Xxvs5BTFHEWnxZwPeFVt7CO1NEu9/IpDcUuk2tP0fB7H9K7kpO/qx1lVBxMo/1sOb3n55GQNgTPS0oj2e4fwsWoFfHhCC2pABP7ZEw3+MUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=K7IvSy2A; arc=none smtp.client-ip=114.111.35.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="K7IvSy2A"
Received: from cvsendbo009.nm ([10.112.18.55])
  by cvsmtppost28.nm.naver.com with ESMTP id 8Hf3iLyTQc2cPfxxJJFJSQ
  for <netdev@vger.kernel.org>;
  Thu, 08 Oct 2026 08:25:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791447927; bh=ZaFNBI9fd7vodGbEU+jo7hQ4HNN89K1CXiQN6lAy+bQ=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=K7IvSy2AtKHHmxUke2+l9vyeIVLtlt9LoE274rcp7j4uu+XjQ0JvWElKJn9OYRK0Q
	 KHhv6ex91KySgxHGx1jdi+dRMvvPtuGgr/Qn1j5zuQRNd/nwO9tl2G2se7xvdw4QaU
	 Oc1NduyHDlgNnwtZS8J2hCg9epLmkBt96u2sVqZ0jrZRoN+TrL95ob5QKVZYH3VbCF
	 nOt5S9TFahcJSRE1aFvhMZehiFhnaD5m4lW0NcJu+QnFH02p4eLI2pXrrP9O1GuhIw
	 yNGYfKcMGSpqIVU/m+c1ZXC1luO7bVan8aeT4Vd5uBSHelo44DOADaEXe2dguv/l1V
	 aTb7fTNEdqUrQ==
X-Session-ID: whKhY+sxTCOwLYicnlopUw
X-Works-Send-Opt: OlewpzGdjHmdKHFOMr39Ko3YKHmqjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: XqYwFAulFqJZ+HmXKoE9+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp005.nm.naver.com with ESMTP id whKhY+sxTCOwLYicnlopUw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 08:25:27 -0000
From: Sung Byeongchan <tjdqudcks0424@naver.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net] qrtr: make repeated lookups from one client idempotent
Date: Thu,  8 Oct 2026 17:25:18 +0900
Message-ID: <20261008082518.347350-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QRTR name service counts every NEW_LOOKUP request as a new global row,
even when one client repeats the same service and instance tuple. An
unprivileged local socket can fill all 128 rows with duplicates and prevent
an independent observer from registering a lookup.

Reuse an existing tuple owned by the same node and port. Continue through
the listing path so a repeated request retains its notification semantics
without consuming another global row.

An isolated AF_QIPCRTR test blocked an independent observer in all three
baseline runs. The observer succeeded in all three patched runs. The
127-row boundary, repeated-listing, and socket-close recovery controls
retained their expected behavior.

The demonstrated impact is bounded local cross-socket service denial. No
memory corruption or privilege escalation was observed.

This change was prepared with assistance from OpenAI Codex. I reviewed the
source change, test results, and this commit message.

Fixes: 5640227d9a21 ("net: qrtr: ns: Limit the maximum number of lookups")
Assisted-by: OpenAI Codex
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 net/qrtr/ns.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index bcb090ee79d49..ae0dc2474e5e9 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -547,6 +547,14 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 	if (from->sq_node != qrtr_ns.local_node)
 		return -EINVAL;
 
+	list_for_each_entry(lookup, &qrtr_ns.lookups, li) {
+		if (lookup->sq.sq_node == from->sq_node &&
+		    lookup->sq.sq_port == from->sq_port &&
+		    lookup->service == service &&
+		    lookup->instance == instance)
+			goto notify;
+	}
+
 	if (qrtr_ns.lookup_count >= QRTR_NS_MAX_LOOKUPS) {
 		pr_err_ratelimited("QRTR client node exceeds max lookup limit!\n");
 		return -ENOSPC;
@@ -562,6 +570,7 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 	list_add_tail(&lookup->li, &qrtr_ns.lookups);
 	qrtr_ns.lookup_count++;
 
+notify:
 	memset(&filter, 0, sizeof(filter));
 	filter.service = service;
 	filter.instance = instance;
-- 
2.43.0

