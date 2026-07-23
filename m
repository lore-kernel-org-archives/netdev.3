Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9063612F3
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827770; cv=none; b=HFGnGCCU3XTbE7SsbH0dzkoe1SzFPC49FrQUnP+kLRcsFaOQpX043TY0jWalOCfxYRq/yizIbChlqyflH+cBQMRZ29XZGvKyJ5i4zcSyqxZ9Vgx88XgodxkXW5OjE7WmVzfcLeCWTgBgNXMXMA0cc7Qe/JU1OZNMzubbQgBT5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827770; c=relaxed/simple;
	bh=aiAo/V3guZ18jP0VXbJ0M0cftnxQocvyM2ecRUkZLwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkIKu/5SuLlvvBZQ89LSj3Gbt9M/uXDxrT4zgazRUGNuem13Yp+XiPUJNjW7xf6BJgFCdBWapjXeshKIvXIAki6sRZYeS07IqzbmGoBkBSxN4SNmwQ6JcGFOsWTjFkspPiMam9j359c5MRDmx8ZFMXbEG5SVXN8P2AnWkpyXp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLPdjocN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLPdjocN"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8486672f03cso960592b3a.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827769; x=1785432569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/w8qNJy/Z6X5B0+ftqwMYJq9aZyi5qiwMaO/rqFlYig=;
        b=kLPdjocNonWUZrXZv4lZZWkRQ4q8A2Rh1HNmIQi1+SMmxvzI9pz4KJnYFfHqthX8Zk
         bc20HY9mfiec8SJUaU7QoR/8Xvrzc1Q8P7OQ18N+HuXPVWL3tefZkineLUo/9J2Q2n6f
         ibd02K1zs+YtOEjAFdbS2bp9sxbcUPBO2ysSqfqLYl3QbK3TNO4gprjjJEqR7LKHy/o7
         /2VkVOme2sLio4Z4tR0vthztjK2Uf6iwEig0bY0A8RVptcx7OsjTW6GGVLCInDBZ05x6
         6zpfo6Atax1uqDj5ktYaIRoDpAUTYL01YOKNf/DLKoH1UGUDEb1IAUeTvqB5qyn4tpJC
         QxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827769; x=1785432569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/w8qNJy/Z6X5B0+ftqwMYJq9aZyi5qiwMaO/rqFlYig=;
        b=ZaZvbna2uygWLQv7jM31h9ZMail8gmlCjNihCoytAv9PXFF0B+Mi0t8AP1Wmv/wrNV
         nC2p/eiwWybOmr8J31/ZOgJxVHQTFZ8kcB1iLqogfzum5Sf9oeQaFwEvIHD3gnpKrhDK
         IhatIVrM2AiA0rQuNJ1bCyMMpnCEBjvsAF1QA7amk8Xb/+Yb7IdyxRjscyd9tIfh3/1w
         pghzRrV3ezrQLU1i7juPbFw4a1U3ClmFsjuWOpjnacnoDmNrGLIc2FTKLKTWL+cVFrJ8
         7etDDiEVo8e/lKGQdx1wU5ZgHIU8o76/F80j81bKTaKnxgP3r44uaZpOXkmkOyrEfJin
         XVMw==
X-Gm-Message-State: AOJu0YxSikoh68/W6Ix409S6FuUh2lPMj2AOlWZjPNLmLx83cpmHPN16
	MctYACBewWsZ7k9Sl0YKalMnxWGxMaZMKCbELeB1WKhiORhAor0cqppshTSuMNtjHNM=
X-Gm-Gg: AR+sD10FyLhTY8eX3qpw1LVgbQc/wiJCAMiMw1kF/7ZbL/ZKUmvNBg/FAdephmX9+se
	2Osp/XbEK1bihwj6XOC2HsUmqqExZLZ7ep5SB21du944ZZ2mdxXjqoAX7+RPw1OqkiyXsvDE7gg
	8Ysdnc69VsDCKdKAf5JQzoJ4or2yfxXB4LBOPARmOpaLBHffIuyYqk4zflxp0gqjJ7SNyPE4ibn
	EExU35e0kUkaWVBlWbf7CI0q4qByu1frfq4IBZ2U2ZRzb/zcVJIF+IXcZyVk0xzVEbnHnYA3nhc
	wdBkz97iYFgBXveSqHsv8S1CBJTZk7Hx1b736ba6TXuKSp4xF5earKZYS8GeyU+yV4ZV0q/IhIE
	N0oD3TOymNr4WrESYdKI5Cs801kgu47sGMxMivON/MwB3zog6M6CTMGKrWqeo24r9sz/zM3yENM
	L2e7PJ3iV7PNCpkwHeJSY=
X-Received: by 2002:a05:6a00:1d95:b0:842:2a81:4c63 with SMTP id d2e1a72fcca58-84e2b858da6mr4690869b3a.25.1784827768784;
        Thu, 23 Jul 2026 10:29:28 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237704sm3446098b3a.2.2026.07.23.10.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:29:28 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	luoxuanqiang@kylinos.cn,
	tim.bird@sony.com,
	acme@mandriva.com,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] llc: fix listener child socket leak on non-SABME frames
Date: Fri, 24 Jul 2026 01:29:09 +0800
Message-ID: <631a34bdb0c1e1ab47ba75a4be94b5129b7a122f.1784725007.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784725007.git.zihanx@nebusec.ai>
References: <cover.1784725007.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

llc_conn_handler() allocates an incoming child socket for any frame
received by a listening LLC socket before the frame is validated as a
real passive-open request.

Non-SABME traffic, such as DISC commands, can therefore create a child
socket that is immediately driven through the ADM state tables instead
of the passive-open path. The child remains hashed in the LLC SAP tables
and keeps its device reference, so repeating such frames leaks sockets
and memory until the host runs out of memory.

Only create an incoming child socket when the listener actually receives
a SABME command. Non-passive-open traffic then stays on the listening
socket path and no orphan child socket is created.

Fixes: d389424e00f9 ("[LLC]: Fix the accept path")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/llc/llc_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 0a3f5e0bec0..a235748e36d 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -801,7 +801,8 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
 	 * the originator of the new connection, and this state has to be
 	 * in the newly created struct sock private area. -acme
 	 */
-	if (unlikely(sk->sk_state == TCP_LISTEN)) {
+	if (unlikely(sk->sk_state == TCP_LISTEN) &&
+	    !llc_conn_ev_rx_sabme_cmd_pbit_set_x(sk, skb)) {
 		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
 							      &saddr, &daddr);
 		if (!newsk)
-- 
2.43.0
