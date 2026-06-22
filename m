Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C79B3128B8
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148252; cv=none; b=lJtmoRopI/9Abefwl9gx2YGyqCYWdBH8uaCjJKZiHXjD5/mnxvX4iPfYjRal2TLzCMUbFSA2Z9cebqP5KPTV/2cVrfSQ2OtpFxnHUH5BEnRsC29nIxK64ZLGgtNcxt+qQuRH+wQMuEWStMm1hOU9rqENap4YQxeZYvpF2T6bcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148252; c=relaxed/simple;
	bh=bb5DQ2Qq195GwIzZP7LVeZQDtjHbbUlj9Svu298PNsg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nnLT/tnKQOrUYAn6ojY4hUSmmF0JB1K2Qu4BxfGbKmo5cRT28RPfVa49fWMcN4VLcd8S/u659eJ6FtpT6SOWq5carFTA6uUtUwKxE/jt32dsuFMc1Qz2mSZI1YWLmmjGaionFCdTRd1PAVTb0cnUPLquavYBNfJdDKNvIMwEOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErVUD9y4; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErVUD9y4"
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8e3ae05d649so2554516d6.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782148250; x=1782753050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=36liBa5vsPMTLVGq4X2BsDLVk2uvOvAS/4h8Oqsx76A=;
        b=ErVUD9y4DEIT3qEC4ovU0wmuXqLN1bdAzAjV4STHivMjukS0vZShFQ3sXttaLX/gO2
         53tEbMpcO/BryKTXVqq2iuLp0XfRNuFfs77zvbsEY5+lNrWZq3hBMUD0hp5bqqsX/Gi8
         9DdzWzuqfza//6aiNG1TMh56ON41WvblXsee4L3/towPq0zsMOYOabRC+DOIEgOdQTX4
         L4kHtn7JrazQTu0HuiY51FXK6RQoIAq/A8D/uUcf4jJbYt867RHRLze+k5wvA8zEgQw2
         9egPu+KWwTWHCUvNguc6f8/AE16ZRAvOwMT9TYqosNQdpa3c+YI8QYxY2iDv6vrmiiui
         NjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782148250; x=1782753050;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36liBa5vsPMTLVGq4X2BsDLVk2uvOvAS/4h8Oqsx76A=;
        b=VLq0lOX5FMpIUPW++kui4WJ5EZd1w88WYnokKkHOW6qv0T5CkrVw23/Aw3wrbnxfPE
         ZJFkwVgAQoqlSbaR/lM9/q7IEmcPd0gHbIpy86KtqVAvb+YRt9DPMZ+hGAKjPO9t/wIV
         aIfNqX7+v+VLc80frjVDq26ppqTgWhZ9o+0i+vrfEAYJy2cFcaGFwDyIzXt9xjn6+XXH
         YbUaA3pa/c6S+chVAhH3Hket12QE44f14TBEsyOiW0ASVSb6CG/ck93QqNyQSunceC+c
         PGGiqUxITn4793+RRUMxFnguuSlVCRiQR41Dm9bPXD/gjRYfHBTaw1PTglAWgmc/QFS6
         yZDA==
X-Forwarded-Encrypted: i=1; AHgh+RqiSadCTj3b5WvtbzWdlxIxomYoAl/TLd9k8SpjrHTjZdu0Co0Ix0A8yKLZ0xRhofGTsxww8Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzriKwMLUDE/EHVEvAodLCSHqZhZTOPjIYHRhVP53fpHGmIDiFH
	Q+Zg+/EBMOl6SlyVv0vtjET+gd+Ni3fmTESahVqHgh3FLhiAkLSDBkHrMkeCcutYWVZk8YMaWZ2
	2VlgN2CMZvvnRtw==
X-Received: from qvon11.prod.google.com ([2002:a0c:e94b:0:b0:8dc:f6b9:4a26])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4b01:b0:8db:4069:6e6e with SMTP id 6a1803df08f44-8dea1c7be84mr245037106d6.6.1782148249742;
 Mon, 22 Jun 2026 10:10:49 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:10:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622171048.1626022-1-edumazet@google.com>
Subject: [PATCH net] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jon.maloy@ericsson.com>
Content-Type: text/plain; charset="UTF-8"

TIPC UDP media bearer teardown calls dst_cache_destroy() on its
replicast caches before calling synchronize_net() to wait for
concurrent RCU readers (transmitters) to finish:

static void cleanup_bearer(struct work_struct *work)
{
...
	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
		dst_cache_destroy(&rcast->dst_cache);
		list_del_rcu(&rcast->list);
		kfree_rcu(rcast, rcu);
	}
...
	dst_cache_destroy(&ub->rcast.dst_cache);
	udp_tunnel_sock_release(ub->sk);
	synchronize_net();
...
}

This is highly buggy because dst_cache_destroy() immediately frees the
per-CPU cache memory (free_percpu()) and releases the cached dst
entries without any synchronization.

If a concurrent transmitter (e.g., tipc_udp_xmit()) is running on another
CPU under RCU protection, it can call dst_cache_get() concurrently,
leading to:
1. Use-After-Free on the per-CPU cache pointer itself (crash).
2. "rcuref - imbalanced put()" warning if it attempts to release a
   dst that was concurrently released by dst_cache_destroy().

Furthermore, calling kfree(ub) immediately after synchronize_net() without
closing the socket first (or waiting after closing it) leaves a window
where a concurrent receiver (tipc_udp_recv()) could start after
synchronize_net(), access ub, and suffer a UAF when kfree(ub) runs.

To fix this, we must defer dst_cache_destroy() and kfree(ub) until after
we have ensured that no more readers can see the bearer/socket and all
existing readers have finished:

1. Move the rcast entries from the public list to a private list
   and delete them using list_del_rcu() (stops new transmit readers).
2. Release the bearer socket using udp_tunnel_sock_release() (stops
   new receive readers).
3. Call synchronize_net() to wait for all outstanding RCU readers
   (both transmit and receive) to finish.
4. Now that it is safe, call dst_cache_destroy() on all isolated
   rcast entries and the main bearer cache, and free the memory.

Fixes: e9c1a793210f ("tipc: add dst_cache support for udp media")
Reported-by: syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a396a66.52ae72c2.136ac7.0003.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
---
 net/tipc/udp_media.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 988b8a7f953ad6da860e6190f1f244650f121dce..befaf7137caf642462b7203a2429a60386e64db8 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -808,21 +808,26 @@ static void cleanup_bearer(struct work_struct *work)
 {
 	struct udp_bearer *ub = container_of(work, struct udp_bearer, work);
 	struct udp_replicast *rcast, *tmp;
+	LIST_HEAD(private_list);
 	struct tipc_net *tn;
 
 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
-		dst_cache_destroy(&rcast->dst_cache);
 		list_del_rcu(&rcast->list);
-		kfree_rcu(rcast, rcu);
+		list_add(&rcast->list, &private_list);
 	}
 
 	tn = tipc_net(sock_net(ub->sk));
 
-	dst_cache_destroy(&ub->rcast.dst_cache);
 	udp_tunnel_sock_release(ub->sk);
 
-	/* Note: could use a call_rcu() to avoid another synchronize_net() */
 	synchronize_net();
+
+	list_for_each_entry_safe(rcast, tmp, &private_list, list) {
+		dst_cache_destroy(&rcast->dst_cache);
+		kfree(rcast);
+	}
+
+	dst_cache_destroy(&ub->rcast.dst_cache);
 	atomic_dec(&tn->wq_count);
 	kfree(ub);
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

