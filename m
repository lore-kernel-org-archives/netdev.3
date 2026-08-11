Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4A37BE9F
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428183; cv=none; b=l+5dziY6/a3G3LOq6FNFGB8u6XZX/QIYnT1HtDxwM5qz/fBLggYaoqlLsaBKKtZPVOTkm9dwXedxB07DeVaQIZJ9S1IvrWxgMJzZcMIBO8CtfjB99m3LUNoPnIlx9Por53BS3y+ILTXHi6/Zi8BV98dLWC538FLMCWj9f+k+vaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428183; c=relaxed/simple;
	bh=z5M1iQBHWGNYPKU2rWv5GB+ulrPmwzpYzCQQIEGjsLg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R8oLZ3txxwGxd5diJJPFt2ZNGeYGDVx/VB1YFMhzxLj/mrKcMaBE8uPhIEww4zchYsA6j1xu5K5eZ4VqYWr9+JgHVTAuMGx69TS+ReZfjZ6/ksEK+gpKxko2UD9FxzctSDwzFzR+xE3O7UAIs2CVJJYTHhIM5KTVeIhdTJvtsjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjHWgp7H; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjHWgp7H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786428169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OLDa6A0YWiRXYrThzPVgL6POAMWtNwIFEcHWM4ceiiI=;
	b=LjHWgp7Hm/hxqNArnnmJRrQpcKJCbDdw7c0TmebmXe5ka83LFFA3ThG0WglGRIJFo8+wPs
	EmdtnA1xelKwUK27qswu7BJJ1nzqUdMnWLg4fYemuR7l42N/9I7EMypV0GeZGnD540PA3h
	Ck0J2AUo49kHtOEh9Mp9nFepcO43ie8=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Taegu Ha <hataegu0826@gmail.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ppp: annotate lockless queue empty check
Date: Tue, 11 Aug 2026 14:02:29 +0800
Message-ID: <20260811060236.322284-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ppp_poll() checks whether pf->rq contains a packet without holding the
queue lock. skb_peek() requires appropriate locking or a private queue,
neither of which applies because ppp_input() can enqueue concurrently.

Only queue emptiness is needed, so use skb_queue_empty_lockless()
instead.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index e1013621eb1d..1a610a18893b 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -556,7 +556,7 @@ static __poll_t ppp_poll(struct file *file, poll_table *wait)
 		return 0;
 	poll_wait(file, &pf->rwait, wait);
 	mask = EPOLLOUT | EPOLLWRNORM;
-	if (skb_peek(&pf->rq))
+	if (!skb_queue_empty_lockless(&pf->rq))
 		mask |= EPOLLIN | EPOLLRDNORM;
 	if (pf->dead)
 		mask |= EPOLLHUP;
-- 
2.43.0

