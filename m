Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC703BCD05
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777292; cv=none; b=fGd4IhyC9FRyX8dCcqnILsJ94ncptaI/pw85Oty5bq+PZnMsmu99ro0/oIOHoaJoRJdzJtKl7yW0L3o7C3h9J+6xLDakVOb+BjMzM5qq4auGpFajENwmeNI4pahbMebI1hIV49RXSMUvhjypokUl96cPogs5uLbv1MRWOsOYJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777292; c=relaxed/simple;
	bh=a48o3jwP9ErVvNTdsqlBCScRW0OkUrRHaz6QshGmefc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t0nohQn+EYBv5m4AvCVnRhPxZj3Adl3CjdyZIXlhdbalVCBUb5VGsYLSuCVyBADaZ5z39p+1EXAa1Kd5qP++EtXcHz64iF+Sjs/m/IgKGR1A1eZLCXIZk2YlQ93/CxqBodFsEYRqKgtjYjpyNu+XpCmmiHUjsa4YWnhqe1WObAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZzSPsA2l; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZzSPsA2l"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso4505417a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785777290; x=1786382090; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yOW3n52VHLe0DVF46hmkA+PwFM2h9qnGl//NaQ6CV/A=;
        b=ZzSPsA2l1K8g2ell5mUcUfVAYgD+OGESmiLwFP04AYRpHlJQE7TL8o/BIZvQ8MJuXy
         prgVEgUwl426rdEJ5C5sIUHY0HtWgNON5JU12pfkQ6sunpytwdrzhNG9gG+UE2TNezka
         5cnComwJ5e5qDcIMjSnUqSJILUIUF8BGBkdQY9ASZ9/F+iUBc7Bo+AEF9ncusTWK989o
         17DghbDjC07VfLgjTGnx6SYApMYzHxSIOmRc7w+n09hYyQ/8SpVYnJF3FWEahO+JKWpJ
         2/uYcKv0GAwLkhSTKTnO1hLur+JDOK32WO6qbQSuaaO7/b7Y53wCXkfc70oYMBEuruAm
         zZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777290; x=1786382090;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yOW3n52VHLe0DVF46hmkA+PwFM2h9qnGl//NaQ6CV/A=;
        b=qxKyJ+0kLm9lU0Z7uVvyKKf4tniFnZuOmp5/gJwa6gU/AbXwe1y5Ecidbqyi11zsZH
         5MwXsK4H69Tat641jn9jXaRmlkhk35NX4i3Lxs85NQKRwWAXt5g/kcSwC92+xvgP8kmW
         Or5BRcVYlwmZT9poyDyKG9sFLojn7iR1zknVrRh8CW8u4OxbIWsT5vJEheHCZ9MtM7OA
         Ysy+HgDt+BA27AvGXye4FGGWVZ64n63umXsKvUSfGX+ybf4eWx4kW6i2fiqA09eJqbDf
         KzGEn5gliukoELs4/xblWdFJJNOBmjPg4PlmNTy9uuhrN+9A+ITVoBL22Ro54pvkNQgl
         EkaQ==
X-Gm-Message-State: AOJu0Yxt1cCj+NhtNZ4aqvZAzAVSoHqj9s7JXgJcADxz+loWHo8sBjxB
	/pjV/az4bCtsjqBM9+C5rNaDQgLQlrYziEZV/uXi/KdzdztjU7qS5rfvPWKpl5PEno9+Q0g0Pn+
	qv8z8EmWxTWYc2rjaMJufmTskra1EuXr25ef9X3cjXbYiW5R3PFARg0fXphqC9smXDLCJaaDrfX
	ym/a0JmkBfENAONLUK9MRd5QhDDLuJmOn2W/sLwI3FGuDEe8MAWI1gNdp4RDtdcfs=
X-Received: from dycue2.prod.google.com ([2002:a05:7300:82:b0:30c:1aab:2586])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a05:b0:3b4:7eb0:47a1 with SMTP id adf61e73a8af0-3c92a53b04cmr11334168637.19.1785777289991;
 Mon, 03 Aug 2026 10:14:49 -0700 (PDT)
Date: Mon,  3 Aug 2026 17:14:40 +0000
In-Reply-To: <20260803171441.408014-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803171441.408014-1-almasrymina@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803171441.408014-2-almasrymina@google.com>
Subject: [PATCH net v2 2/3] net: devmem: return EMSGSIZE on type mismatch
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com, 
	kuniyu@google.com, bjorn@kernel.org, jiayuan.chen@linux.dev, 
	kaiyuanz@google.com, willemb@google.com, asml.silence@gmail.com, 
	sdf@fomichev.me, bobbyeshleman@gmail.com, fw@strlen.de, 
	Mina Almasry <almasrymina@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Ralf Lici <ralf@mandelbit.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When a devmem payload mixes with a standard page payload, return
-EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
fall back to creating a new segment instead of failing the socket send.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/datagram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 173b5d97bd409..6f8ffd61bcab4 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -638,7 +638,7 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 	int frag = skb_shinfo(skb)->nr_frags;
 
 	if (!skb_frags_readable(skb))
-		return -EFAULT;
+		return -EMSGSIZE;
 
 	while (length && iov_iter_count(from)) {
 		struct page *head, *last_head = NULL;
@@ -713,7 +713,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 	struct net_iov *niov;
 
 	if (i && skb_frags_readable(skb))
-		return -EFAULT;
+		return -EMSGSIZE;
 
 	/* Devmem filling works by taking an IOVEC from the user where the
 	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
-- 
2.55.0.571.g244d577d93-goog

