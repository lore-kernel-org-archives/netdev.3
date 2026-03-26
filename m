Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D02D1303
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528618; cv=none; b=fvM+d9vUZdkK1wQmRpI68s2mQqgyXQM7HKgactIVAyW8bH8lWAhAf7pBKNzLR5hc09Sb6duFhZTmbqvvUSKJ1kq1w79I53neZPfa98YXFG1Zxi0Gshhf39pHIPAiiMAFzWJc0JWzQU3osEwnIE9pyOyrm4Hn6b+0CKvRWQEZyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528618; c=relaxed/simple;
	bh=teTLwcxsQHwnI0K7HDYdZgjYhUAv4+o79ZGuNq4qBbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGI4ysLe/HJxNANkLZUdWsSvpDjwgUHE+AuQdZVeHy+pthrmmNnfvIQSFCUXXpwGof7yPHHMt0PI0FrDPnLdt3PtpYJTtNPd6SG/OHCuSd7mYfe69uzs2wRgSl1VRlAqHomnsyYRaRozCflN54ke3rOu0cngoqgQjAAqYIJmeGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUyyU6WW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUyyU6WW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296d553142so496899b3a.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774528615; x=1775133415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=niF418V+ZD+AMHTjRkvi6339V7JwejnzPOFyEn2reUM=;
        b=MUyyU6WWqXhjxPAu5cQn1caSTw2244G4xRJ03+7I0bK2JjVDtLFTmDCusDXibr8Mgw
         qH2i3+8q5SN6l7MZvcwh127pfT7EpmWArcn9NMlZVW74fLHpXXGl7Fyvz4qOGu9T1LpX
         KVzYJuFoYVkTr3j6gw7A76PtB4XFs2zNkmNr3Q2405uiCrjn5IDTYM0CeDkrcJWs/AEY
         5xaK8C2eq1E2i+9Ns3fxnP0mHc7N52kTBiuB2JmtTm73c/C5leQwCANFggj0paQJSURV
         qWhDpxJNIc89CRtF1uWXxXpH/3RS57etr+jx2QcllIxVnUfcMZ+FNCST7YfV3QW/P8tw
         KZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528615; x=1775133415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niF418V+ZD+AMHTjRkvi6339V7JwejnzPOFyEn2reUM=;
        b=MHD6DEZDTLczQ2ItKLPqYoIKDr/9aqq4PZgEHKfN4Xn40mcaMQoO5CuuZB3PXCwexp
         gFqd/ymD6BuLfyRMNbkfQqT4wiH46TGmVR9Q4IjSpbZ9xFFqtelildpXtp5z5Uzv4aC1
         jMFb2gL/TdOD5FrL1JNR9nuIsgz8cVeMVcgobgg3p5j3+WHY+Nq4f9nj5xoVYmFT/2Gk
         MYMAI5X04tIH6a6qzgDbgIFLxJYmQJLH3CaNoCvH1UCclwcp+fGAPbeKLH9JqOaP9CaD
         Ov0nzUTpMhRYkXikIr0NTOKt/khfJF8ilIp6ArLnboREkogZdcpfd6GcVqKgWk0fDmlG
         oyOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Wx8+hDci+1oJeHpOdj8BNN36Gq2mHm3cSLDjIK7hNUuspI+P+DSnMW536SReSwxLbBpcF08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0eFrLHa9G/Yzg0Kp3xH+nLgNZnfMj5Q2OqZPyBCdNVK8aSBtf
	nhIQdqDBNRiFq7kQuH2zAdzzoJKozVLWQemq2bB9Tg0gkzTyqGcRqbcu
X-Gm-Gg: ATEYQzzq478NX8g/GewkN0N7xCvXo+It6JTYRRdxjwVRKLqlz22c1eR0RkjGrjFuMkf
	TxghVCNge2eCVYfNFKeQ45d2HcUAvvx64/JG9uPfaNtGy2sDwljfM07qvFO/989IwJpWymKab4f
	N8xl0z3hiG2L6Peyp5tCv+DjtTVCkjn8+cIF6j8SwqeS7g1xrBNWNC7boiESq+81HbhE4GV7fQA
	hPJAkcxf8PL1jPlFNplLtuE3pUg4vFzY4MmvatNHLfqP+s+Jp9E+w42qD1YKr2fKOKkFutCIJ+C
	8S/PmLgjxTycwTNBcrIciwX2Phtxc9xvbHqbnZuRbWArZHRZRDQiDilYcn611T99+drP1rJz8Vd
	qa5Y+QRAqygQ9F2QwrrUdNxJvAfPG8QdhIlWSnE+W8kzBmGdHLATKzuYw3cnckjraoIZwiqCv9P
	v8p315jZ3LxKcUHHHzK7LZySVNBsl3zU/XgEY/eGNgxFjfkF27yi6vb7kiSNYhpUO+Sw==
X-Received: by 2002:a05:6a00:1c83:b0:82a:6b97:34a1 with SMTP id d2e1a72fcca58-82c6decc5ccmr6470779b3a.27.1774528615053;
        Thu, 26 Mar 2026 05:36:55 -0700 (PDT)
Received: from LAPTOP-KU1E7KI5.fudan.edu.cn ([2001:da8:8001:864:716c:ace7:5131:288a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d38d7f5sm2535796b3a.29.2026.03.26.05.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:36:54 -0700 (PDT)
From: Keenan Dong <keenanat2000@gmail.com>
To: steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Cc: keenanat2000@gmail.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] xfrm: account XFRMA_IF_ID in aevent size calculation
Date: Thu, 26 Mar 2026 20:36:39 +0800
Message-ID: <20260326123639.94056-1-keenanat2000@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_get_ae() allocates the reply skb with xfrm_aevent_msgsize(), then
build_aevent() appends attributes including XFRMA_IF_ID when x->if_id is
set.

xfrm_aevent_msgsize() does not include space for XFRMA_IF_ID. For states
with if_id, build_aevent() can fail with -EMSGSIZE and hit BUG_ON(err < 0)
in xfrm_get_ae(), turning a malformed netlink interaction into a kernel
panic.

Account XFRMA_IF_ID in the size calculation unconditionally and replace
the BUG_ON with normal error unwinding.

Fixes: 7e6526404ade ("xfrm: Add a new lookup key to match xfrm interfaces.")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
 net/xfrm/xfrm_user.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 1656b487f..d79240a1c 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2677,7 +2677,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
 	       + nla_total_size(4) /* XFRM_AE_RTHR */
 	       + nla_total_size(4) /* XFRM_AE_ETHR */
 	       + nla_total_size(sizeof(x->dir)) /* XFRMA_SA_DIR */
-	       + nla_total_size(4); /* XFRMA_SA_PCPU */
+	       + nla_total_size(4) /* XFRMA_SA_PCPU */
+	       + nla_total_size(sizeof(x->if_id)); /* XFRMA_IF_ID */
 }
 
 static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -2789,7 +2790,12 @@ static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	c.portid = nlh->nlmsg_pid;
 
 	err = build_aevent(r_skb, x, &c);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		spin_unlock_bh(&x->lock);
+		xfrm_state_put(x);
+		kfree_skb(r_skb);
+		return err;
+	}
 
 	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, NETLINK_CB(skb).portid);
 	spin_unlock_bh(&x->lock);
-- 
2.43.0

