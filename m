Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1A43E48C
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363537; cv=none; b=KLRWZ7HNPrwV0m7+2KzE4C/BUBNJQ06zlq4AwO45nXIK0rqj1lCA5fxq6etdr/N2/STW9vu5HdUxMK4vR9x5GCl5+ZR3hMcOy4dUfzN+diPLgtV01DR+zF2FQcIyHY5ytnjTCVe9IKWQBapJ+KWyo1a1XmEW4J3zqqoX/YLiA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363537; c=relaxed/simple;
	bh=UmyFBuNz5X5Hyy0U3LR+Mq37vswOtP3oWtdCOBjjgA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRZLbkfPwK+x6bP7CI/9S4dM9v7lTUtoJONkT8tHXnXGUjbYpR9HdHTjlzviN0yjpXVJAujwsYP2ibdscXk+GrZt43cWDVfMWRLYjVmP/YUqeelSg695VMhf8osrqKIGJrKW5yCZv3nGQ3wDPy+Cqb4mCa/qEECjxK1QAooOK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OLz3Bmb4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cPpKfd95; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OLz3Bmb4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cPpKfd95"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5544F7A03B6;
	Wed, 29 Jul 2026 18:18:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 29 Jul 2026 18:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1785363535; x=
	1785449935; bh=ufTrcvY/DK0DEwSsselNdijiTnLcHUJsYKTgG4UIkBE=; b=O
	Lz3Bmb4S4XXMBAfiI7NEjnk21OEg/Y9JLRB1mSiVcqSyxGkWR1dYkzLYkV28rgCB
	W4J0C397g5tACxw61sKk53IEC3WLlfYNmnIM2c4pLA9ra9qNmXgvHoSLkSGZM4hY
	D7kuGsitLJae30shoE9pXp16fLyRGuHiC0rqt1w8s2rcysId3NOCoTPeFI9gnaWF
	Mh7wNEAUWfObqp+nmjcepCn+WUJf6PhRFLR8ZtFqF0u+EH9ykrYiqLbqrIL1mAwT
	rrCWvpwsn3WY4pguiMo+t22jVT09E2BMlAgkfM13HtLmWAEumowrhoEe88JkAneU
	JOgCwvHIPpRO0VJg+AJcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785363535; x=1785449935; bh=u
	fTrcvY/DK0DEwSsselNdijiTnLcHUJsYKTgG4UIkBE=; b=cPpKfd953AHAXwAES
	w0CKzQSRmKLxyBKgniWkyO1+PUiCLPNk8566TRlNlg2ApX5KaTuhbbauHs/lB650
	1eEpFJFSiY45MXpnYnyXGmN3vAYZyQ7DKcpawGc3BdKH2HGzhXXAL94wb2a8xtn0
	PxJCer/cc8j5HVJLGOxzCkbZq/3b9N8bqgX7T0qnm9oYcR3ZXQPJ5jmutlZ4JCHh
	3fbTV/xF8IpMpn+GbuCYVFSpUSpMZPBVJVUzbA36NdCiX7zcA5CZtKMXKXPticnx
	xqccIK8XxIhk/blJl/AG9cAcRQ+JUgZoidxQ9yG1LuNAmHvQ3AeIHZyqLg1sRRn/
	KHCSg==
X-ME-Sender: <xms:T3xqarWa4m3ZcM4o-_ebwvHJLt7Aevha4eJzZxLOxhwsp866gWrSSQ>
    <xme:T3xqaqdjgxAPYuXTByncg2KWm9_Bgst6vOtvfMICyz2J3Ee_IewpRsawqCc8cl1dk
    hjhMNz2NyWeTEOXF-08LOvDyfkYLskhzea_mrD9a5wpFYWiias1Qg>
X-ME-Received: <xmr:T3xqavsKgGaI-C_vjP0VI7V5YEZTv1HZsY2zN8phI2DRoYYdwq11Q8lhkDy1HFv0YaFsKT01x7mHUPzjxH4O>
X-ME-Proxy-Cause: dmFkZTFO9U89lTC8Db4KEME+S+308jztbtzjZ4plkGygnxBaPMqN4mfnSXcwfNVaVXNfqy
    yZUBlmn6qAx5l9iATeGPDpjG4odzGLJt9y2dieu0gw5jtQ9zRvlWRjGVvXJ0w0ea28GNVY
    oF8c7LPAbQA6AzHJuFRmjJC8stwWJ1lVDO0zLWHGppiDwGJKqdFGob0Toh2+AZ0hRT5vdn
    YfneAB7FpFiaaq06ME+cKedDnlcSNK2UAVtWW9VFcORlqvtCu4vVTyebNRNflzVpaYP49c
    +TuZOW32uIb74m0LV4T8TmkC6IaeXvAPjT+gJcvYteseZr+X9xCkCzFeoA7EDgF9ZHGpn2
    v+WU7XPPtcm79voIH4JCg5WJTzlrDDQpB8TIIPvyyJlncjVrtxvxj/miyaSDd2fB4XVDtl
    Dro++Dp74dgiTHmvAttpmE1bagPuX/3p/0deeVYtbKIVB+ipSdWDI5X+IkvhcmQ6vMHmcQ
    FB3S1OUlzepSmTF9O9ynfS82u+6Y26rKna69xL06GxrWOypdK+x5A3wfp55JkJ2o+U51Vb
    YI8y6N18+jaNQgB7i8epXPiON+dbEz4yQOFtsl4Z66m4SRQnB2N1W6U217Z4Tf3i+ctrDL
    SOjYqytu8yyyK55zS46rShBCZbzaZqnk47VS20qTo0CUwj+Fvm/s6RP9Mcpg
X-ME-Proxy: <xmx:T3xqah9ZZ_3asgJMWcKHWfw38fomTJkjmBDbadWnXHx6qiCIkvgcxw>
    <xmx:T3xqai2JvP4pw2ffvsrURXxgWxSecz4xoOsAGH_NHfOs1QWGM16UTg>
    <xmx:T3xqauAv_ViO23exoUhwG7pOLOzGCVFNg54zJeuR9OxxOR3JS8_l8Q>
    <xmx:T3xqamfqiRVkqkteRqz4ZPB8MPRcNehjpDuv3rUapvTYJ2c4T4bRTg>
    <xmx:T3xqan-Uf9ZxhypsTjLUd53Px0yeV6ZjDQo_SlJ3uc2Sdje7nIvhczTc>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 18:18:54 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH net-next v4 2/6] selftests: net: remove unused variable in process_recvzc()
Date: Wed, 29 Jul 2026 17:18:21 -0500
Message-ID: <20260729221825.42773-3-juanlu@fastmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260729221825.42773-1-juanlu@fastmail.com>
References: <20260729221825.42773-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unused `sqe` variable in preparation for the multiqueue rss
selftest changes to process_recvzc() in the following commits.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index df6b622043438..c6dbd0ad53681 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -269,7 +269,6 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 	unsigned rq_mask = rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
 	struct io_uring_zcrx_rqe *rqe;
-	struct io_uring_sqe *sqe;
 	uint64_t mask;
 	char *data;
 	ssize_t n;
-- 
2.53.0-Meta

