Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737743B8BA5
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788690945; cv=none; b=WiV0A8jIuydnGalbSyaqJBHJFpLWex7ulxpA9Oeug7B61iGqB/ZzBN0rbKo1qUr8jqxs/mWq4N0IjzxOx5QRXsbyRYcZCNynKjZhopkcLoUMOi1Y7cq5tvO4JjTL0JZzMwjct5imOt4bKZAjk0Lz4BfcWSkORb87TQTNKDnpllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788690945; c=relaxed/simple;
	bh=njZCQcvSaSuZs1PoIW8muMQ4poItt04rCi/Fk5qKhUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTe1InvMM7OXyIWM9sqvwzmHt51NDppkqWfwQIM2w2VCWEJrSjYnfIP5qTN49h+jnf/BguXhVmZq0LOo2Tme6G8XyKQ5I50rXZdpZcfLbVPa28FklTbE+q0szOmHqJUhSpd2/K1KLv/N9+dO8Q9+acsccNympbJVCckoXf9wz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=gGdvGHN3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="gGdvGHN3"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2985814a91.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788690944; x=1789295744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3nwE0kfnx82zbxAQ+VvoS1Ge3uYxRjNjXvEgD4eRv5E=;
        b=gGdvGHN3PZLRYL3a4UobcHUykd5OhnTMb24HE/KhKK8ksMq+Xa5xuFdEXNeF5HscOg
         mLLIudhWvv1Uk/jTWWtL1HdfsGZMROwqIIcbPbALFFcx26BoVBEIpHIytrKTE++g4v7d
         HvjJp0m0K4zAqrXzGQ9wLNx+vQYL/JhVkD/vO9DsGSpGgxIg1pFJo8Rt545g+T748E9E
         OZK4CtqhqKRbObfV5bpoqtOair/0ZM0sOgXExmgYQX/yrLx5AdcVebxgL7BBT/othJfM
         arMSoVon+HBBrB/d20+xXHQpt/jecoDuNVtdY+dVTryj5DBQGtRCmxoQ8t0Vshwg3CXz
         A8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788690944; x=1789295744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3nwE0kfnx82zbxAQ+VvoS1Ge3uYxRjNjXvEgD4eRv5E=;
        b=FIM0dZ9ykX6HP942Wp88jMo9ZXHoX+LQVQDacwHWwiiI6rSQ+8H4yLUSPZZFWCYJQA
         407mIZQBS2z9KAu/Y41N7fTpP/Xl9VkQF0Puj6k3YWjeWWvpdhbmLJ8NzmqfEE/QABF1
         PJ/ECI9znpcqNiGHKY7l7ckQ+Xcqwt/O5NH8b3MDayX0DWUt9Z8/dGV85wL0BvBoEoQG
         7Zx7ACgmLI+v66hzvd08q4Kt18AcTGJQRywpAFBgahQOHTKo9/T3MpfZ2TBVHkjZOnkO
         FyxeMtDDBhqZZCt4F2hWxXnhy4mTtSs7dNoq/HrDuIOxE4uJSJIIzV8QPUpbvQfkDa4C
         B+YQ==
X-Gm-Message-State: AFuF++kmHajr2FuxvDkK4Jpw14x2jrvqLpF16bp0wrCK78K/Bd50YS96
	GV51UlGctlKZwdaZRPI2sJW3Jt/O/ug9T5lSw+QwdGFE85BfEexyE7AivBJewT7u8iEziXu365l
	HuZga4A==
X-Gm-Gg: AYBFou16RVv6uYyShnVgAz2kegkjWamIFa3Ih1L4CWgyIyWVBncUJ+A59f0NwkAUTrq
	rXxKC+fyZdtxsDOMZCiy7GgG/pOKfBpae0jndfyeTUenu4kSkYGDcOt+rwk3HacnfjjwaYAvGDs
	bUEl13Ba7ZmPOK0ylglNZ/4M+T6LnfSy4gdmqwDbas7CoKkZJtEaMfsoMftEkImCCXoTkReDyfk
	ECHBR+zBF4vVBxOqQwipIfWd9n2GHz/KR7Jyn3soEQMWuCT/mZEXUBIvDRI7/PQzO/zD/TFcEFF
	9zNVLAq7bB6s92XFQeI4JqnDqnueLTh1ptEpL8PddP5XQMeaUusEayBZT9Foctw9uVi1tOvC81Z
	WLXeGGob9ZUR66QJTleDGrI8+/tcGltYxiTJeS3LIxxPgyTFZuj3AyS76jSCbmKFM8AMIEKdto4
	ebjUxGthKg6cZcywvp9HUuCfguIFeYR0BxnsOb0QTebpR7YhyoHJK0ay+lCguqSiB6jsJXGeKiV
	PBqm4h+ncGNKWN0pfE=
X-Received: by 2002:a17:90b:1343:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-39b261b1bcfmr29604631a91.16.1788690943726;
        Sun, 06 Sep 2026 03:35:43 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25c974cfsm14755810a91.0.2026.09.06.03.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 03:35:43 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Pavel Emelyanov <xemul@parallels.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v2 1/1] udp: diag: bound bucket lock hold time
Date: Sun,  6 Sep 2026 10:35:30 +0000
Message-ID: <e8782427d0b3cd1854ab8d141eea224b53db55b9.1788668475.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788668475.git.zihanx@nebusec.ai>
References: <cover.1788668475.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_diag_dump() currently keeps the UDP hash bucket spinlock held while
running the request's bytecode filter and filling a netlink response for
every socket in the bucket.  A large filter and a heavily populated bucket
can therefore keep bottom halves disabled for an attacker-scaled amount of
time.

Collect at most SKARR_SZ matching sockets under the bucket lock, taking a
reference for each socket, then run the filter and fill the response after
releasing the lock.  Resume with the existing (slot, s_num) dump state so
the next batch can skip already-walked sockets.  Leave bytecode filtering
until after unlock; unlike tcp_diag, a rejecting inet_diag bytecode program
is the expensive part of this walk.

Fixes: b6d640c2286d ("udp_diag: Implement the dump-all functionality")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - Drop the hash-list cursor, dump_done callback, extra module
    reference, and inet_diag core changes.  Dump state is only
    (slot, s_num), so the existing handler get/put around dump() is
    enough and udp_diag no longer manages its own module lifetime.
  - Batch at most SKARR_SZ matching sockets under the bucket lock
    like tcp_diag, and run bytecode filtering plus netlink fill after
    unlock.
  - v1 Link: https://lore.kernel.org/all/133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai

 net/ipv4/udp_diag.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index f4b24e628cf8d..f049204abdf85 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -86,6 +86,11 @@ static int udp_diag_dump_one(struct netlink_callback *cb,
 	return err;
 }
 
+/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
+ * with bh disabled.
+ */
+#define SKARR_SZ 16
+
 static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			  const struct inet_diag_req_v2 *r)
 {
@@ -100,13 +105,18 @@ static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 
 	for (slot = s_slot; slot <= table->mask; s_num = 0, slot++) {
 		struct udp_hslot *hslot = &table->hash[slot];
-		struct sock *sk;
+		struct sock *sk_arr[SKARR_SZ], *sk;
+		int num_arr[SKARR_SZ];
+		int idx, accum, res;
 
 		num = 0;
 
 		if (hlist_empty(&hslot->head))
 			continue;
 
+resume_walk:
+		num = 0;
+		accum = 0;
 		spin_lock_bh(&hslot->lock);
 		sk_for_each(sk, &hslot->head) {
 			struct inet_sock *inet = inet_sk(sk);
@@ -127,14 +137,35 @@ static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			    r->id.idiag_dport)
 				goto next;
 
-			if (sk_diag_dump(sk, skb, cb, r, net_admin) < 0) {
-				spin_unlock_bh(&hslot->lock);
-				goto done;
-			}
+			sock_hold(sk);
+			num_arr[accum] = num;
+			sk_arr[accum] = sk;
+			if (++accum == SKARR_SZ)
+				break;
 next:
 			num++;
 		}
 		spin_unlock_bh(&hslot->lock);
+
+		res = 0;
+		for (idx = 0; idx < accum; idx++) {
+			if (res >= 0) {
+				res = sk_diag_dump(sk_arr[idx], skb, cb, r,
+						   net_admin);
+				if (res < 0)
+					num = num_arr[idx];
+			}
+			sock_put(sk_arr[idx]);
+		}
+		if (res < 0)
+			goto done;
+
+		cond_resched();
+
+		if (accum == SKARR_SZ) {
+			s_num = num + 1;
+			goto resume_walk;
+		}
 	}
 done:
 	cb->args[0] = slot;
-- 
2.43.0

