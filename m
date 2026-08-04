Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB0344DBB
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856852; cv=none; b=ky3OR/9TGWsJabJsd/rjzZ8dwQAP2Qpj7P1JKLT+R1dbxgm6rh1G1T9EIfLu3rCd7d5Mdb3SRqY7e9P9ChBZmVU4j2Ls57d4ER2SVaFemf4VUG38x2yXu/7lZcSy9B9E89wuwW3yFQvpQtRmq1TxrREw89L+9dBFOjhPkCZN/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856852; c=relaxed/simple;
	bh=S+T5o2sQd27ef7/PPd4xw6GTuaSFG2Dg+orl5Xtrfp4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cxqU7TSE2/KbCdH0nz2O2ZQ8gxMIpR/651LxSQTZgEQd+Y8HTeCT20SKaS1Js5Nm921ptCpAYIcMJL6b+lfzZeatu5nHeGyi3e9npqzsiI6vbHFSJq89CSkuvAHdG5KwYGVDIFOZUW2bWsNouu6bRbgOKpShFRS0aNAFeafqp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUbMSN9v; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUbMSN9v"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930f5da3467so447841785a.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785856849; x=1786461649; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hsrDM6cHFgDCcftCKwVBi09aO7huvb3tC/nRdMq9zCo=;
        b=DUbMSN9vSxnarqPCxYyj5OA1OOdqaw7+gKTzfr584t/itsqp7cX8k6ibjrW8llqxYX
         vQtRYXpp5X+HnAUlQQZYBIAmWuQLjBP1EmjP4HuUInZ/D8GLgcQScLW1Zi2fAgW2FkiG
         AK33DOxHGuFTF428l+xktC2mEq5hTgv9sEclRonSE36WGyBqyO3+k975x+rcTGsvGPcs
         p76J5FNOgg+7kI/HtrmKaeT2KLQGUpYckUi47Z3UzWwlhiJZDl4dyE7kWV0Fk/EoD0mT
         1WGiK31i8/E53Oor/F0HWVHf1xSkyfz5jV//0+Umikq0eV1yMzKfO84BV3Epg+YCHt63
         b1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785856849; x=1786461649;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsrDM6cHFgDCcftCKwVBi09aO7huvb3tC/nRdMq9zCo=;
        b=mMANP3UBxO6Bhwp9E2a8QIvBSHwH7bnTxZHv1LXgiXW37d7u2e2iVQ8AfubMqm8A4N
         mI+DHkrb1jZKQFlMUjisTrCKmHWi+dvadr4gWWv669NLgzZdwUjS7c64TlkGwlm6OU6S
         P//OjXIPqTuYNs1QjrOj9Kie4bLWnf+AqwFXUKcDrD1ElHw5D0AdZPDnSnfjmSQjA78O
         LH/5rxksjhZz1q6IybHxrXwmLpTC1AtXI/mpDCd+CfXajHkMteHOxPkxft7dVfNLXg3t
         WVixDRygKurwCQ4Aau4UdEuFSOFCuleHAf/AXg5ZwRInM6kqLHCooiQx6qNljsLMoFAE
         UyiA==
X-Forwarded-Encrypted: i=1; AHgh+RrDEvUF5vVBAlk5xuiyFw8KbXgP/kRRMQgOxcOn1pq2CC6Pzz4mE68C7CTIdlx6dYdfN34GJOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqB1pJwdwAGqCTkkHRqcczuFvHTO7R1o3WNvWdMQcF6TOqVSQ
	O0ARu0Te2lYax1TFM/I+BWsTkFB+xrNLtF2qF7U4KMGMjDsif5jl4/d/x5bBDNiC40HB4GGB1aj
	StvazVQM0A9EkAg==
X-Received: from qkg6.prod.google.com ([2002:a05:620a:9506:b0:92e:9011:92f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:9142:b0:92e:e1d1:49dd with SMTP id af79cd13be357-934a078e741mr2185104585a.21.1785856849018;
 Tue, 04 Aug 2026 08:20:49 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:20:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804152048.2134341-1-edumazet@google.com>
Subject: [PATCH net] net: remove WARN_ON_ONCE() from sk_mc_loop()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+22c3218a6fa219e47321@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

sk_mc_loop() can be called for sockets that are neither AF_INET
nor AF_INET6 (e.g. AF_PACKET sockets when sending packets via raw/packet
socket over virtual devices such as VRF or ipvlan).

In such cases, sk_family is not AF_INET/AF_INET6 and sk_mc_loop() falls
through the switch statement and triggers WARN_ON_ONCE(1).

Non-INET sockets do not support IP_MULTICAST_LOOP or IPV6_MULTICAST_LOOP
options, so loopback should default to true without generating a warning.

Fixes: f60e5990d9c1 ("ipv6: protect skb->sk accesses from recursive dereference inside the stack")
Reported-by: syzbot+22c3218a6fa219e47321@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a72024c.13623e66.bdc14.0019.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index ffa73594c13c7557d011730676edc887ec1de5cb..1ad41904db25b48a914640f538760686f40eb100 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -779,7 +779,6 @@ bool sk_mc_loop(const struct sock *sk)
 		return inet6_test_bit(MC6_LOOP, sk);
 #endif
 	}
-	WARN_ON_ONCE(1);
 	return true;
 }
 EXPORT_SYMBOL(sk_mc_loop);
-- 
2.55.0.571.g244d577d93-goog

