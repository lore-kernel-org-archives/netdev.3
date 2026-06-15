Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD53C4B76
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514163; cv=none; b=Tb2rEhhmq62Xqi9ieUPc+7J+KSlOMz2C6PUlhMlRM4KHemsetIiczmUQN7im4DXqqHMTMRF0SykcPV00kQuTz5vZdDWoL6faqJP1orwofyne3mZ8q9h7JbG9CMQuZv2MfCRshOQS/TaNbPZG6Q3kG4t3sGx8qp+0cvZxf08FtB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514163; c=relaxed/simple;
	bh=P0koOR9FH0pchRQmGTFL+9SxCYyq3oLtOQRb4q+NvK0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZfJxfxBhyUVlkfrakuWE/298I4TsiMjEEpoKw1PMOlPSi09qEHjMo2feUiDdkzz8vCbB79a1gXUgDIWwnvwXgcCoLszQOlH73Vl9hqs+JqvsTx8L7yocZHvJXhFoJ597NraRd1AB+iio+7znAwC4Jg97IhMR02vLoQWUrNAWOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7xWa5Ml; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7xWa5Ml"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8cce2b4c290so60996896d6.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781514159; x=1782118959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rbg/xXKt8EoObxZ+MhaOU9VlLSA6G2MuSMTpVqNSt7Y=;
        b=j7xWa5MlZgYMAZDZQKSE3EYKmvggZwgF/7M4npREQlMOxB+wzp3yJeJOOnoxuTfMoc
         0xiR9hSDdsdBAKY3wiC3Hzeyh4URiA1b2uxQux5L6O2Y7ZwfW/Jm5k9arFe4ZdOmrgwW
         2OF55r/7jZ93J2bo4ZIVC4baDd92YqTbqBS/N4Dlun8rnCggYn/c+4kdBu0HCbLZFhMP
         rTDZ37qr6jVE6f7ZRNw2FizBKChpJLtSfGOHS1YXPr/9GjhlERtm3CqLbCAtxB6yhe3m
         VqNotudklPfWZWYAZAychnYf1GlPC6kWkGgEeDb0LICAJRmx07qqAqod7z+KSewVXagY
         mh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781514159; x=1782118959;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rbg/xXKt8EoObxZ+MhaOU9VlLSA6G2MuSMTpVqNSt7Y=;
        b=KCaGE/91jH2bTNHWVaxkLtahZfrZujfENcMCLs6nTkckvxLF7l4mgb6772tKKqulVt
         goMYoqqIUJHbIjvaoO1W9B407/ytyEHE36b2Om2c4zTCz6+WbVq/iDF78D3Yn9pbywh3
         SRh7PvwtYhT/Kbk0/o30XXaeh4GGsjLBrP9H60DczwNLs9JALIE+TK0oC7/gzZXVnamm
         AhCw6B7zZxG+Us3/Fc+0NzVw2pmiCUdtPs2iRSLjyjLqoMjVfY196iyJTT0MzPdemQtF
         SUtTHdzxhK4KEGbgfdnw6tcd7aNuxYy31vdRbPNPI9GRVv9Pv4AjXa6FZ5mYJMyc7EQI
         juMg==
X-Forwarded-Encrypted: i=1; AFNElJ8AcvRpJilDmPhYctTZ8uuwtQTxwX0Em+0g2XIXIFsJnrhN86G3KFbZkoDDftz1HP30Nmeu6xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOfGVz3KrRIQJZ9jno/eVl5tT+ZI73/NS6RfvbVYPxZhNSL32
	ScmuHcjLOVIKLalv3C9uqcAJME1GVpba0571gd4jfHlqzMcHstk6XY0tH8xbdcdaq7Ts8i2iqCU
	iSu0NiQEpxRpd1w==
X-Received: from qvbdr5.prod.google.com ([2002:a05:6214:8e5:b0:8b4:eeca:74ce])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3a84:b0:8ac:8938:ee55 with SMTP id 6a1803df08f44-8d44d8fdad2mr184269296d6.11.1781514158895;
 Mon, 15 Jun 2026 02:02:38 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:02:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615090237.2689082-1-edumazet@google.com>
Subject: [PATCH net] xfrm: validate selector family and prefixlen during match
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com, 
	Sabrina Dubroca <sd@queasysnail.net>, Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a shift-out-of-bounds in xfrm_selector_match()
due to AF_UNSPEC selector with large prefixlen (e.g. 128) matched
against IPv4 flow (when XFRM_STATE_AF_UNSPEC is set).

Fix this by:

- Rejecting mismatched families in xfrm_selector_match.
- Returning false in addr4_match if prefixlen > 32.
- Returning false in addr_match if prefixlen > 128 (prevents overflow).

Fixes: 3f0ab59e6537 ("xfrm: validate new SA's prefixlen using SA family when sel.family is unset")
Reported-by: syzbot+9383b1ff0df4b29ca5e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a2fbe35.be3f099c.2836ae.0018.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     | 7 +++++++
 net/xfrm/xfrm_policy.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 874409127e292197c17dbac4686efdd5ff56c185..baa7454a0b7b8d1faffa7e8375510082b811e903 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -943,6 +943,9 @@ static inline bool addr_match(const void *token1, const void *token2,
 	unsigned int pdw;
 	unsigned int pbi;
 
+	if (prefixlen > 128)
+		return false;
+
 	pdw = prefixlen >> 5;	  /* num of whole u32 in prefix */
 	pbi = prefixlen &  0x1f;  /* num of bits in incomplete u32 in prefix */
 
@@ -967,6 +970,10 @@ static inline bool addr4_match(__be32 a1, __be32 a2, u8 prefixlen)
 	/* C99 6.5.7 (3): u32 << 32 is undefined behaviour */
 	if (sizeof(long) == 4 && prefixlen == 0)
 		return true;
+
+	if (prefixlen > 32)
+		return false;
+
 	return !((a1 ^ a2) & htonl(~0UL << (32 - prefixlen)));
 }
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 95954442569290719b9fdb7b0f9462d70b5d755e..bcc6ab6b0c183bfa90a94800c68dd0d029c2497c 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -242,6 +242,9 @@ __xfrm6_selector_match(const struct xfrm_selector *sel, const struct flowi *fl)
 bool xfrm_selector_match(const struct xfrm_selector *sel, const struct flowi *fl,
 			 unsigned short family)
 {
+	if (family != sel->family && sel->family != AF_UNSPEC)
+		return false;
+
 	switch (family) {
 	case AF_INET:
 		return __xfrm4_selector_match(sel, fl);
-- 
2.54.0.1136.gdb2ca164c4-goog

