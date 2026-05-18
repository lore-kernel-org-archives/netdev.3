Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066D38757D
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080851; cv=none; b=pti/lm0rLY0K54v07jHmCutY/nCEJsnHzUg42Sg5iOUJpUHPWZaxnq24kBC6y3B9UOfQj+ay15Wud6aQWSeoCP3ojv/O8N7dGLPZWBNCeOvpmbgzjuyoBAw0tCUJnyRh/zfOHxcdpLr0xPUBIubMc5wrgwRU5Vz/SvMZlZOIVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080851; c=relaxed/simple;
	bh=9Sbkg544vUWxbwdGYWepPL11YbwGVqyy1dj6Bb5qFQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qacMu8TvduJTYE1q9FgEkEn88HtMfQHHlp6/izAzgG+L3+NQeAD7coihaGtWvmB0oWtP1GuBVmjh0QlbekJJLPUS9MOsr04gV3BG6Ugs0ixNUnMd4dvPSZpYGyp9mEZ61ICkbApY9UqUdQ+CpMqXfgPipcMzY58zbOaQsnzqOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3K+1EH7; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3K+1EH7"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8024fc7032so1029821a12.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779080850; x=1779685650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffPyApXuW8AJv14roerbUG+TS0S5kpTjBJqFFLouP9o=;
        b=s3K+1EH7INs0rfmxUQ4/5UQumR1FE3HzMUHVbbA5qj8Du5azBatrtRKwyjaHn613WS
         rGG/bvl6uSgmeX22xOYAgYX3pDZuZwrt/OeEaPTqgDJ2124rlFMcvEdqgTfyebdxBgoH
         GM4QhwbkZwZy3AkGOExX+V3TF5wtcHrgfd7mOSQpSVAb4t+Tc1M7xVLWiJBjzEiF2/0V
         NfSFd9eUQiALPxYmQMyLyDeO0BJ66CtXUAg31pcDVcWyyTkN6xgyecLY3Fdloyl1pmi4
         TjOtbZNn3fmGLUQnDbsw0WZXQRSUqgUtofRFlbzvpGASIX8s+w0rBFO2m+6LGOgceiJK
         Thjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779080850; x=1779685650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffPyApXuW8AJv14roerbUG+TS0S5kpTjBJqFFLouP9o=;
        b=fJxE/CTLtgfJwTOYQRtmuBw8Ha7It9qKZQ/kB3k1C3/N4hgr4wvmO92qbxVyaiiqXv
         Zqc2iWnU3fQIR11+Ul2ACWSW8T8M6HP5foV+XssKo2cBdF/HHVsSL5F9oZBd+N+Van2U
         Ha1qHhNLOm+EZ0IECPTbqxiF9hssG1t1asLbwnD5235F4dE4AlcpMOFK5CSbu6zisq1n
         PDDCwb+8gmAQy3fZqA6qTzfyBE4F+Jro+oH43pwJmaRxGp9+Z2qOqf4O70BxFUD5Sz76
         d+H16hs5GySj9gJcrCqZzUuLqb7MGc/dZpVP6CUlB3Lxv9dR5sJGVQS2k5ZzO40+OALo
         kt+g==
X-Forwarded-Encrypted: i=1; AFNElJ8qoMq9v8nsGj83yw3P+PvjYI1y5qyDk/GVY68uru0Rk8c7Ti/AotKvZu3VebmYpC7kdiQsIB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfuCLTUs2Px5oMCNdH9OpZHJWerUOxwV05r9n71KKbMP67xSS
	JI4WzN2cerGhuHxLyGoTh6PsvKvphUh50KsFvO47gOdFZI+wUTtZVmyxMkY1OBI9X/gGvKBiORh
	8QOarwQ==
X-Received: from pfaz9.prod.google.com ([2002:aa7:91c9:0:b0:83e:e8a8:71ee])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:414d:b0:83d:446c:2a8c
 with SMTP id d2e1a72fcca58-83f33d8a4cfmr12443212b3a.25.1779080849957; Sun, 17
 May 2026 22:07:29 -0700 (PDT)
Date: Mon, 18 May 2026 05:07:09 +0000
In-Reply-To: <20260518050726.318824-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518050726.318824-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518050726.318824-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/5] geneve: Remove synchronize_net() in geneve_sock_release().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

vxlan previously had an issue where the fast path could access
stale pointers, which was fixed by commit c6fcc4fc5f8b ("vxlan:
avoid using stale vxlan socket.").

geneve later followed the same pattern, and commit fceb9c3e3825
("geneve: avoid using stale geneve socket.") copied synchronize_net()
from vxlan_sock_release() into geneve_sock_release().

However, that change occurred after commit ca065d0cf80f ("udp: no
longer use SLAB_DESTROY_BY_RCU"), and geneve had already been
using kfree_rcu() to free geneve_sock.

Therefore, the synchronize_net() was never actually needed there.

Let's remove the redundant synchronize_net() in geneve_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index b36fad833724..4e5d0a09a82d 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1032,7 +1032,6 @@ static void geneve_sock_release(struct geneve_dev *geneve)
 #endif
 
 	rcu_assign_pointer(geneve->sock4, NULL);
-	synchronize_net();
 
 	__geneve_sock_release(gs4);
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.54.0.563.g4f69b47b94-goog

