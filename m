Received: from mail-pj2-f36.google.com (mail-pj2-f36.google.com [74.125.227.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC23783C5
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853341; cv=none; b=fWt8MG7SsPAjCOiHRM5UltRYxz+BGNxq2LMg2ry/Nh0uWFlbVvsZeMOjY9RaGVu34Y70eswYPDK6KLvwYperNaAuThi+OBQEVIJI0sfDGgTseGWj6hiz2TZ9UX6SgQP3kAHSmqsI+gA3VhlIeWlnBu5xYQXS7bPW4Vj2azRjcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853341; c=relaxed/simple;
	bh=RnFvdIcNU0xTNABTlDpFkW1EO3VK4LUq/3k4DINISgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k33CGH0paEIcT4cp+WzHxJisWDKnMoeiHcRR/fqYO9fTVVMo00xakI946WGXY5CNlqMhRmYt9vXNwumLzmsk8nRyXseNhcT1ifWj7mYlvRxMCtb8EFvLPVVH46K0H0wF4NkBXQ1XMXUAfQfQXp7r9+A8egzLGimYiLIznJfMpS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnxeGUA8; arc=none smtp.client-ip=74.125.227.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnxeGUA8"
Received: by mail-pj2-f36.google.com with SMTP id d9443c01a7336-2d8fdc579daso20936705ad.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853335; x=1790458135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAVSMzy8JMS98U0P+IZpm0y+aXuECbX59K3ciQwemZQ=;
        b=SnxeGUA8EfG/42WNnk+eiXMzqF1m7yVEN8s64M83pLtDDjSg/Dcy/GJv+YCuAjdz5f
         4jkUVvSvaQzMJdBExEEi334VYrEm0nA2Wh3m0jojICg6R1Ty0/G+AVEf1e0qtADU8Kgu
         ucE4ZBNkfHMqaVkXNyCswwLoyVA+GeRoCaCDd0FhHGQSraQfHlkxXRw9MOhfsKM3/jbH
         gUKW1fFEnVKPJRthvZc8XAPTJmaX7Atex2N8692YNDXoTcwbckSbiMesTa0PB8a2y7lq
         9xsChlxz/FGtpMIQt18vg52Cc7lS0aD6NfOiYo26GCIYNTur4F/Sm1uEko9oOEkJajrz
         IAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853335; x=1790458135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAVSMzy8JMS98U0P+IZpm0y+aXuECbX59K3ciQwemZQ=;
        b=F8SsCVGmlWUIMsirferxefZKFWqfYFK6bfStcX+cyfWXJVV55oYPmtujAniD+YHj8y
         qATZUAGW+zLldbrQ0OsgO5zhgj6aZnZGMT7BqnlMNiWrH2rkFCzGnmzeJxFSD0+mURs8
         1lmamS5PZScx1iMe0wPfsVjCq7PDEywqxax8JTtKFs5DdjUegfBoFT6Jwffb2/GcPYOt
         Y6mAOeIuoARqwhugYO/eZztO/32yXyg9apZQ6L2I+MmWlXs1SlHPgCFJ6hGlwnmeO/5R
         2c6qaJhAote6ETjA2hWKp8Fg4Qegee08RNNZRK2kuTYE8A3i3aalutx5jkGf6jADtZQ9
         4X+A==
X-Forwarded-Encrypted: i=1; AKwUvBzILHkUCj+8j0AIFDMDlx5VGkXIfbthmZDLpiUN9GqGlQQNmDlYyfURxcBAKJozQdh0vvL/v0c=@vger.kernel.org
X-Gm-Message-State: AFuF++lF5mSg4jw1dB6FyI145GA9/wi6XdTPx+cUNLiAtx07SmLZizbw
	n+ruBBQby/e9+Rb/KZCIN/99bLAd1Y6Sb/5HG94f5fBO87SdpwKLe5bs
X-Gm-Gg: AYBFou1mpHJlH+2tGQlE0O8xLjhz4XY+hgikFVNRBafUQiiy/UpT4Z7FmItNse7Jfsm
	yT+qKGaVWTNSxKihErqpNuLUtqOqr29SO/QJY2VpCOrpK2MZvafrMFsbwIGDNUpa3H4jLjwt3js
	qbzQ+YJDk94qZYzOvpKglVA7NqRTH/5V+G51rXa+QZ4rJPGpO9aMZbztZ8VqqAzM+xuBmESVFoT
	DCXc77n1j0sokxgCXPOIWjB2e5gO75V/Q2/J/l9Dfuo25bvop5E8Ht9Ey87KyMvgNJ63fkB0DcC
	pehDjwJUK6Dg299xaa4TREXLyzCJFHfrauUpWxRAPvYM7B6bY2D1cEWISZ6kVyfOgFPoZDRMzWt
	FHn+6Vf5il63o78+sL0TKmEFPHSOtqRAiKuUlziq1PkmVB5KaqABcbniqIjH/YZ41TbRjjU3/Yt
	aDrbBl3ET/qoiM97kCkNWABK5PXxFcTG8WzPFPY1yTJJdo50as/rXg/HY9hTvd/wG8O9x4MGnMr
	1faUKSZ5cw2GCDSi7EyCjj+AbvYHcWbO+hZ1Og5BTSsp7XksCiJqKc77mDY2cClKajpQmvZvNtr
	KV2IUL5SKg==
X-Received: by 2002:a17:902:cecd:b0:2dd:ad74:ac20 with SMTP id d9443c01a7336-2ddb1bc5c0fmr109399655ad.27.1789853334901;
        Sat, 19 Sep 2026 14:28:54 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df36806cdbsm8202285ad.80.2026.09.19.14.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:28:54 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kcm: fix socket memory accounting leak on TX completion, error, and close
Date: Sat, 19 Sep 2026 21:28:53 +0000
Message-ID: <20260919212853.3240951-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `kcm_sendmsg()`, every TX fragment is charged to both
`sk->sk_wmem_queued` and `sk->sk_forward_alloc` (`sk_mem_charge()`) via
`skb_copy_to_page_nocache()` or `MSG_SPLICE_PAGES`. However, the
assembled `head` skb is queued onto `&sk->sk_write_queue` (or held in
`kcm->seq_skb`) without `head->sk` or a destructor set.

Consequently:
1. When `kcm_write_msgs()` finishes transmitting `head`, it subtracts
   `txm->sent` from `sk->sk_wmem_queued` but never calls
   `sk_mem_uncharge(sk, txm->sent)`.
2. When `kcm_sendmsg()` fails under `out_error`, or when `kcm_release()`
   frees `kcm->seq_skb` and purges `&sk->sk_write_queue`, `kfree_skb()`
   is called without decrementing `sk->sk_wmem_queued` or calling
   `sk_mem_uncharge()`, triggering a `WARN_ON` in `inet_sock_destruct()`
   and `__sk_destruct()` when the KCM socket is closed.

Use `sk_wmem_queued_add(sk, -...)` and `sk_mem_uncharge(sk, ...)`
whenever freeing TX skbs in `kcm_write_msgs()`, `kcm_sendmsg()`, and
`kcm_release()`.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/kcm/kcmsock.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 71af69d442f2..accf0d427e11 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -693,7 +693,8 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 		}
 
 		/* Successfully sent the whole packet, account for it. */
-		sk->sk_wmem_queued -= txm->sent;
+		sk_wmem_queued_add(sk, -txm->sent);
+		sk_mem_uncharge(sk, txm->sent);
 		total_sent += txm->sent;
 		skb_dequeue(&sk->sk_write_queue);
 		kfree_skb(head);
@@ -960,10 +961,17 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		 */
 		if (copied)
 			goto partial_message;
-		if (head != kcm->seq_skb)
+		if (head && head != kcm->seq_skb) {
+			sk_wmem_queued_add(sk, -head->len);
+			sk_mem_uncharge(sk, head->len);
 			kfree_skb(head);
+		}
 	} else {
-		kfree_skb(head);
+		if (head) {
+			sk_wmem_queued_add(sk, -head->len);
+			sk_mem_uncharge(sk, head->len);
+			kfree_skb(head);
+		}
 		kcm->seq_skb = NULL;
 	}
 
@@ -1686,6 +1694,7 @@ static int kcm_release(struct socket *sock)
 	struct kcm_sock *kcm;
 	struct kcm_mux *mux;
 	struct kcm_psock *psock;
+	struct sk_buff *skb;
 
 	if (!sk)
 		return 0;
@@ -1695,13 +1704,21 @@ static int kcm_release(struct socket *sock)
 
 	lock_sock(sk);
 	sock_orphan(sk);
-	kfree_skb(kcm->seq_skb);
+	if (kcm->seq_skb) {
+		sk_wmem_queued_add(sk, -kcm->seq_skb->len);
+		sk_mem_uncharge(sk, kcm->seq_skb->len);
+		kfree_skb(kcm->seq_skb);
+	}
 
 	/* Purge queue under lock to avoid race condition with tx_work trying
 	 * to act when queue is nonempty. If tx_work runs after this point
 	 * it will just return.
 	 */
-	__skb_queue_purge(&sk->sk_write_queue);
+	while ((skb = __skb_dequeue(&sk->sk_write_queue)) != NULL) {
+		sk_wmem_queued_add(sk, -skb->len);
+		sk_mem_uncharge(sk, skb->len);
+		kfree_skb(skb);
+	}
 
 	release_sock(sk);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

