Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4634B4908D1
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980585; cv=none; b=EtQ+jjANYlU7zPFBhf83DA2mt/zlkyh0kccngarj2vR6ptQDM1aH5QsVZtHgDWJKRpBDpLGy0R7UvaFLueZNM9Agm4dxvQDDQCPpQ/3gK8pivACuGZD9ROs/4y5bkgMvgg8julxjEi1Xt8ogtgTAyEB3TKp4qlUDyrjxZ5SPztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980585; c=relaxed/simple;
	bh=HoumKy1SZGGYhjHhoiDceuBl9nlvS4cV0Z64vMRnez0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tDNSHWFSQT1DWbtLoW7KVVcBJcf7nK+juz/eSpvoEBBWe0o9yLaHo5BASvKsFH7a+mqPun4RvI1bZw8ComjqFkf4DaTQirlRfGkqua7bqDZ6HKwb0sayraKhrRuUQ+OfCakRkaNGV5JT6VHDuk4i6myjjbdbQ/wo7X2D21duqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1dcWblA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1dcWblA"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81eaf3709b4so12440977b3.0
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784980581; x=1785585381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8pMX2F7Mtpmm/z0irFwhF72qBFAkYFT3rWJazByM9SY=;
        b=d1dcWblA7rYPY8jRvmLsUH9cBNjLtmrQ9s0Oo3hV0JD0lErtlmfDe4Fuis5z/uAqeY
         2ZqnUxuM9rIa6NbbbwunkLbvc2SaKPMLuPJwzRq1Op/A9PxmilCLL2+pzyS7PAN5r+6O
         FhJT1LfRcsNle44i/60Ajw2eVHkSWQTD6UsVqnyl88RXg5aeebfCCa7MR5K6U5JOWcH1
         SlMzFpBMrEG3Gi2rOe6LyWL5wDxK0wQqTEW4gwsl6itEHISLpFwOO6Z+Okkf0syepMcT
         aeha/grkgFkU8E7ffaYzRTDXnsPVz2FbMSQOxPSh89nyj9wB5n+KDNbarmNaSNhlwABZ
         5Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784980581; x=1785585381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8pMX2F7Mtpmm/z0irFwhF72qBFAkYFT3rWJazByM9SY=;
        b=QFizpMEebLJh9o3rcbDvNbtUUsCM/w3cufjA0CoKiZ9oT7lDcbxQXJnWgj6epP0S8R
         DTcN8OjBUuzM+SQOaslG/Kt9TKk2CDb9he5uqA9wXDByUrT7Onqxk8Px59LZ2VaFx9Ds
         O2JDqlknyfe/usnSYMjpP1VOPqbNYGEGQ/D7Y+NZQIUOpnn2PfThU8SuWmrYAVCst/s8
         3EkY2BK+jnu8enW3hOYB44V9hWMuXl0+1aqUYaz1pnw6Av+Vk0oTcsZX+DtP6TGdmykp
         8tTymjCAm1Qnq9pRVwh4hQIOe8DUrmFmFchieOZXUqXhWlOvYF9SO0I/pd9mYFbve6Tt
         od3g==
X-Forwarded-Encrypted: i=1; AHgh+RqU4JLKErt56UABqO/DgNoTplN5HBIEaOonIcYwVSd1aJgVmRsSVt7eY5pmI3snnDmmz3Cxq7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLxTPffl4AvL4fIjTxLvCX1iQIFjLIcrPFwY2mLcc1xWQQqjYa
	FNG0euf+cTo7ACVI5HhuGNF8rvX+wLmlmVSiTUa3ztwKR93O/MXXWoewk19lMcxG
X-Gm-Gg: AR+sD13BcoYdv8iDv/syK/swuoJQ4kgLqj2hv0aGMjisr7IET8FMY5yOaYEu8i9uObQ
	oCjxRdfzwgvdfeBY0mchYihAKJwn90RmkuNIs1LCmiYuwh2TVTVU4rL2vag7xFkzpjrag0wtnZT
	mW+gDuf2HPD3ovFoSlDuzRGa9Qpchvnn740KMALLhyxDELa8R6EPVpCQGM9wz/p8u7k9KZTZCh2
	NE++s/86OMnyL8hu4EEvwG5VT/TldqXbAgAiYVwov3MfyGtPDDw7sHyR19gWmjgxNa34ZPSauTV
	Tbh3vCGqOvSBN3pBUHXKUDYCmT+5O4Lr4IP/qTuB/SUBDwlPW0PhquS44I83JnJRTiiVatNX5IG
	sNeySYZ22DEdn0s3FcjlVyLNNHlGo4aUQ8S8ElvJFLEhp8NCOnhdbYOog1pMuI2f0dp7HEYSSOY
	JuZbVmGAs=
X-Received: by 2002:a05:690c:4483:b0:7cf:f14e:bf5a with SMTP id 00721157ae682-81f69d151b2mr6955017b3.20.1784980581193;
        Sat, 25 Jul 2026 04:56:21 -0700 (PDT)
Received: from jdoh-CompSec.. ([141.223.124.60])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm11259497b3.13.2026.07.25.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:56:19 -0700 (PDT)
From: Junwoong Doh <jdoh.kernel@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Junwoong Doh <jdoh.kernel@gmail.com>
Subject: [PATCH net] nfc: llcp: fix NULL pointer dereference race in nfc_llcp_send_ui_frame()
Date: Sat, 25 Jul 2026 20:55:56 +0900
Message-Id: <20260725115556.1250160-1-jdoh.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_send_ui_frame() checks whether sock->local is NULL, but it is
called by llcp_sock_sendmsg() without the socket lock held, which opens
a window for a race condition. Between the sock->local check and the
sock->dev use in nfc_alloc_send_skb(), llcp_sock_bind() can run
concurrently and set both sock->local and sock->dev to NULL, which can
lead to a NULL pointer dereference in nfc_alloc_send_skb().

Take the socket lock in nfc_llcp_send_ui_frame() so that the sock->local
check and the sock->dev use are performed under it. The message is
copied from user space before the lock is taken, to avoid holding the
lock across a user space access that can block for an unbounded amount
of time.

Fixes: dded08927ca3 ("nfc: llcp: fix NULL error pointer dereference on sendmsg() after failed bind()")
Signed-off-by: Junwoong Doh <jdoh.kernel@gmail.com>
Link: https://lore.kernel.org/all/a89d0419-8bcf-40a2-b52d-3e5d911f11da@gmail.com/
---
 net/nfc/llcp_commands.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26facbf3..cfd5f6aebf8d 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -730,6 +730,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 			   struct msghdr *msg, size_t len)
 {
 	struct sk_buff *pdu;
+	struct sock *sk = &sock->sk;
 	struct nfc_llcp_local *local;
 	size_t frag_len = 0, remaining_len;
 	u8 *msg_ptr, *msg_data;
@@ -738,10 +739,6 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 
 	pr_debug("Send UI frame len %zd\n", len);
 
-	local = sock->local;
-	if (local == NULL)
-		return -ENODEV;
-
 	msg_data = kmalloc(len, GFP_USER | __GFP_NOWARN);
 	if (msg_data == NULL)
 		return -ENOMEM;
@@ -751,6 +748,15 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		return -EFAULT;
 	}
 
+	lock_sock(sk);
+
+	local = sock->local;
+	if (local == NULL) {
+		release_sock(sk);
+		kfree(msg_data);
+		return -ENODEV;
+	}
+
 	remaining_len = len;
 	msg_ptr = msg_data;
 
@@ -763,7 +769,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		pr_debug("Fragment %zd bytes remaining %zd",
 			 frag_len, remaining_len);
 
-		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, 0,
+		pdu = nfc_alloc_send_skb(sock->dev, sk, 0,
 					 frag_len + LLCP_HEADER_SIZE, &err);
 		if (pdu == NULL) {
 			pr_err("Could not allocate PDU (error=%d)\n", err);
@@ -800,6 +806,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		msg_ptr += frag_len;
 	} while (remaining_len > 0);
 
+	release_sock(sk);
 	kfree(msg_data);
 
 	return len;
-- 
2.34.1

