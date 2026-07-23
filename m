Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918F377A80
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824757; cv=none; b=cnjNjudfVhsLLPyv7UaH1JWIHR+W0+Hn82OLJVfHcjZttyRfA/I4yL8pMfe7WTTqtpnXqVJGvcD40AEW2J7ATkTzNc5JVgtS3FbBzlR6cGdiO5347qgUZTcJMQHNtcqFw7RTifsMD+jPMd3ZoPwbtWjFzj/lSpdx22/MhlKGz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824757; c=relaxed/simple;
	bh=DFI/tfLXQ29sJ7UU+c4LD7R3sDtrEdd6MRRQA3UWsBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLASiNy1UJDd2om3mmdfn8XjW+pFGmPPlIMNo7NdepRwXD2o8k5jq7gQM7XBpyyT/SFgi3eVn7hS9VBQZrPdnw0O4QOqBEXdbdUBxRgFZYbPz63hxNffMzPIYf+pIHHQwtVfAvWMlgmAdKDCW3V8WPxvc2zubqyAeCUQnGV6ybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0CLIeMs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0CLIeMs"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383cb94f742so880360a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784824743; x=1785429543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IS4dTu2jxCe4nYv13ceXlUt4LGDElZT3GxtPF+6TQL8=;
        b=T0CLIeMsJGHbz01wd5jwYL589lrJNi564eBNvSmJ2fEUFK1QlIiY0srAR7kIplfCcu
         /4/V4V3RNdteBbl7/Wdvo72rEGX9oeDVFyIV/7x6MfUHA7Qtz+Uaqx6Lq5xGVi63p4th
         dZyV+RqHI0/roZKui1LlGNmw7sW7J/rJbxJqYmx53h+X4JSjFYMYmO1oOB6limoz4zog
         tCY19LglAB6P90QDscNoemFgXo3q7W8+DhmLmyPmu8DHtABGPA1q01o17+/Tqg4jTtSx
         QRJKBIfubxCPcd2yY+U8xp5XSXqLw0izUXSII8e/Yp8yWzDIn07MBTXhVBRrcAEEtKGF
         0lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784824743; x=1785429543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IS4dTu2jxCe4nYv13ceXlUt4LGDElZT3GxtPF+6TQL8=;
        b=QNtCKvQLNxSLPCUoHR/jQK8ga7RhuYnPuhAK+cij5ETcU/un4pUlLrBdjel32//Xd9
         HhShHY+EUHT4J1LkjKnsZrbvhKqO6wtwe5xIPFiTFHSMKibB3mRSRr7I54KIsdypSQFP
         W2JzRrnvl7jgnmqSG280TDxKyYEsvAz/2upmH95pm2CK7nEdsPjBCC9WauubyRLd3FM5
         8I1tu0N66UqbkccY6WWIXvO82dh1zloH39QjtsqQflV3yDMQD8101S6b/XCYWdAJmE6l
         InfjjsSymFfmwKG6v4drcKT790H2k59pGOblWXZa+S3+hUNpEKbtDWFEbuZMIrKJnivD
         xpSA==
X-Gm-Message-State: AOJu0Yzx8a5MoEgd6F6RyytQeIoUExcBx2aNZZ9UipfyXvNLwT5AVPoI
	BGd9ZDbrT6FJe5dd+bWm1Y65ar03zM4Z8QkjG1Y8kDsEhBmnKbniYTfLKTg1FDrXD7w=
X-Gm-Gg: AR+sD11Qbzi37tI9TeYr+MQT5OqVK6J5uRZIl+8yjRlJE0DHLaPNHHkBNn4CtNUjxxi
	DhnPGfb46OlljRvm6etD+Ia9y9ag4PI34DmE7K6oPbqNQvBM4H5r6NgPpfgzasy+u8S0leBc2lc
	tW17+naNlZXMp+Xd+uKNuU0Nhc0jIk8CR0TmTq9OvOOKY/s/HFlHflNUCtbBClOahZbfFxz3RM/
	qyAhuXoafCqK4XTglCH/Frs+c10fqrw0J/K9APRT72cVZYVm8mUg1+F842Bp1D0rK/WuMYwxqZt
	JWQGIFkU+c32qRZD3sqk1UCR68qsf/QJ+1bebm/HfAqJY5E2uVrZXAQBJmyGEFrjjlg2cMwn4dD
	wVnTsUDawNnGIWLeGYF/lvLqbtRmUQRULML51neetd01Sy67qHM+d+VnV64S6raNwkQ777nT6tH
	KAVEk+e6Fb69DLWoFrrtI=
X-Received: by 2002:a05:6300:6701:b0:3c3:ad17:edf7 with SMTP id adf61e73a8af0-3c44b245055mr4475502637.63.1784824743313;
        Thu, 23 Jul 2026 09:39:03 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1ca3efsm26079051eec.30.2026.07.23.09.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:39:02 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ying.xue@windriver.com,
	tuong.t.lien@dektech.com.au,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net v3 1/1] tipc: avoid use-after-free in poll trace queue dumps
Date: Fri, 24 Jul 2026 00:38:41 +0800
Message-ID: <f8119abd5e5ecc400597de667ae9d39656de56d0.1784794294.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784794294.git.zihanx@nebusec.ai>
References: <cover.1784794294.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

TIPC socket tracepoints dump queue state through tipc_sk_dump(). Most
queue-dump callsites already serialize that walk under the socket lock or
sk->sk_lock.slock, but tipc_poll() calls trace_tipc_sk_poll(...,
TIPC_DUMP_ALL, ...) without holding either lock.

That lets the poll trace path reach tipc_list_dump() and backlog head/tail
dumping while another context dequeues and frees an skb, leaving the trace
helper dereferencing a stale queue entry.

Stop the unlocked poll trace site from requesting queue dumps. Other queue
dump trace callsites keep their existing output under the locking they
already provide, while poll still emits the event itself without walking
live queue members from an unlocked context.

Fixes: b4b9771bcbbd ("tipc: enable tracepoints in tipc")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/tipc/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..a006fc98a9b8 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -795,7 +795,7 @@ static __poll_t tipc_poll(struct file *file, struct socket *sock,
 	__poll_t revents = 0;
 
 	sock_poll_wait(file, sock, wait);
-	trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_ALL, " ");
+	trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_NONE, " ");
 
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		revents |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
-- 
2.43.0
