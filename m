Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792933170;
	b=QlLQMvVtlx/Lp2ZCyrmswqt6a+ZE6qXzAVRm6AqEHbSstNdDl+lsAsdsyT8uXWmuB6Ep
	 ko9L3SLSULweyWjduI1hjBvUXlKqYoRy7/7g7DlmO8J37TX0dIAfxfYWUrex3hFjrRSpZ
	 HO95OKgWlOIHDG8U5v+ltCzR6gn06Nf9rbWz+SzEY9X9gPHgcLIghaGikHPxeOeiMH8po
	 Qw3pI2vv3zpBKcpawSUEtEV4qXkM3V8YZ6wXwRGR7RROVGz09oAH3CLw5no6izvShDz8L
	 nJSXX5fa4m6HGgJLYsjoG3U8TWWchnBbB98oBtCkvtN/TjvNaCw90xX/0zUcmrh0zaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792933170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7VHZxL27tPxxp1usvovdEi4PohkLXe+WTp5TnVE1dnM=;
	b=crfueko1a4IeK8PNtZWqM/Bnm6B5lnm28g/G4oLKZcVmSR2Sez0bYpfujcQjxuUwECo7
	 VzFJS/38+LMd0QUHvjG7PY+yIM/6tSmjAaG+KuFvEBKGTlYWmUtJExkeY1/+vASDvErZk
	 YdSLdHbYNKLKxeuJ1CBnhQa4rBEU4jgjgAvAMis3mXc59Mg4sdBco98YwFvDTkKvjmV5H
	 rzC9+gnT3RQgIilgwJmylMjtcha0ImkAWq1LGmVQ8qJ7krczSBcJwvXUP5zg8Eh+9NxnS
	 TIw8Kb+ryU86VuuZ6lMdUgCsOgXnJV/j8JmxNm1ex4Vtq8eGs6PEaCp2G2FhrXqlLFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rZk08NxT;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4A606A31E
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 12:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B4A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rZk08NxT
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so9385165e9.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792933168; x=1793537968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VHZxL27tPxxp1usvovdEi4PohkLXe+WTp5TnVE1dnM=;
        b=rZk08NxTTVEpTzIZsF83JIm/vfJjHC/3TWlRjj/odwGc/R78ukigXNtW+Mu/QgSYN4
         jwiQVTMr32so9LFM+q4CL3OeKAzqOLRnDH+6lCswwFw2cNlbCkUdQlL/cjb/cR3Heb/D
         ef3iwdyultFPtA2c382MOTaCxropI+ycx/V9jBBfy51lGWhoeWDLhFZYEGw8Ifr6hoIF
         F41BB//tthWuFP/RQ+zB8NJvSlOBGMyXUeLkeiTgHbgpQjuYDLd7YdDTsPoRjnVGJw8w
         KWs9PcBS1hl0vP41aywQgWsDrdFh6Xjpimu3FJu1m2RHJonVaXzq6KJSBHSj8IzBfUkT
         FWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792933168; x=1793537968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VHZxL27tPxxp1usvovdEi4PohkLXe+WTp5TnVE1dnM=;
        b=gfrqMWbVDOOe8UUtzCiQdWFTE0yLUT6QBvqpe7qPP8B4L57+QIktd5Nw+fk3WcnJou
         l+ILzLeHsSd5WCnhcPYSwnarbrJYkzfEanTrCJFhPTQ1N/NlXX+KFAwfnJofSYoogCbq
         d2Vh18edcgxKSGd9emzii8cD6UJP8BdHRoe7RcqLx+qdoXeQL+uv3gg8j9j/N1Im0/5U
         qdnbh9NelDv6f3iRVwB4lZFLw4sXgd7K3FlKjEIhTwDK3xlMqLpOjdv8n1n9Y5g85IvC
         +LzEr7Cv+2jXdU9sxvGk6MwzpXmUETYCx8/DcGfCjc+4Sxl6pTvNXmQSqpFK8SWAzPyS
         f1HA==
X-Forwarded-Encrypted: i=1; AKwUvBzkz2JPGPFGaQQErhcaZmcTc7roG3z9fGTYsN8zXNsxLQFiMBiHyvkza4k7iYnjlfB28IS7es8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxQdPD6OC8rGSd3Ulix2tNmKunk/6QygxSTTK+/FYIgy2sTd0Q
	gPnl6nur+TjRtv3DHA7Op4bSrkr4fFXvRzBzYjxq+KNXLkGEAfZSIgju
X-Gm-Gg: AYBFou29eVDqDScQVj+8bqUDXcQzi5bhAeT40YVJ5il5iOVbVpMg9ex07Lw+9jRpbqF
	DJbGq61Xj2APhkd02p/05V7OEYdjDRzRKkEc2vNqhOBBWGqhLHNjqADLLbhI0n+t0Yj6sQlpPZQ
	3ri6KGCmWPAdhNz4GVPUssIRjXukGGB1OT/J2cBL9AZzSM5g8t7P+R/KXWzR3SoVGkqgQpw3A50
	sUne0Mpf0Qp+ydLQsnlUOOCyLv9Dr0Ce4QjYSf/pCf9zJ27XivVcqSIDJH4lIbQpyXt4fAnFUgL
	zHHm1ew9YuCzgiKUNye/EJAD7BLtL/jvJmU3oSJtM1eWqDXcnn+KzNfOcoorWrvl/OzhFRwmsMt
	XzxMlBv85BZN7gaRWScuZMhV2QBlQSfcIRFn4TWIuG+fjamcUa5/hNyPDfjw76WpFNYC/CKdnhG
	OTdpTI4XCWaiPC5C9JmNVLoH3XCRWdKsfZOTcbUTDjwfsJWtbPUAF8nVTQZhOGzJhzPm+qL1Dzz
	LTvMkQdEuaCASwS9zAmjoY/uOo4E00MYeXLeMC510L8mC5JX8wtCCQ8WhZXyxxsPbCDJxC9
X-Received: by 2002:a05:600c:6289:b0:4a1:cfa7:e968 with SMTP id 5b1f17b1804b1-4a35acc8109mr68061445e9.21.1792933168107;
        Sun, 25 Oct 2026 05:59:28 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4778:c500:4c6b:e3c0:928d:b2cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f36asm10250807f8f.1.2026.10.25.05.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 05:59:27 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] SUNRPC: Balance switch queue length on transport removal
Date: Sun, 25 Oct 2026 14:59:24 +0200
Message-ID: <20261025125923.2221205-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When call_connect_status() moves a task off a transport marked for
removal, it decrements xprt->queuelen but leaves the switch's
xps_queuelen unchanged. The stale count persists after the task
finishes and skews multipath transport selection.

Decrement xps_queuelen alongside xprt->queuelen, matching the normal
transport release path.

Fixes: 6f081693e7b2 ("sunrpc: remove an offlined xprt using sysfs")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 net/sunrpc/clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 6cedc824cf82..9b980cfd1bd3 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2257,6 +2257,7 @@ call_connect_status(struct rpc_task *task)
 
 				xprt_release(task);
 				value = atomic_long_dec_return(&xprt->queuelen);
+				atomic_long_dec(&xps->xps_queuelen);
 				if (value == 0)
 					rpc_xprt_switch_remove_xprt(xps, saved,
 								    true);

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.43.0

