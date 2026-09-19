Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BE383999
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853803; cv=none; b=CfzTlWAO+wRj+NlxY0YMxd12eAJXyFhdtHf4+EuzRG6D608GKozd4WigsEogpXn+5LPDWZ/zLxKNXJkawAUwfdmyfz5FEGRE5/CqAWdijq96WRd7G/nNHmp3UmbKTD19GDUJcCP/IOH02eEMvEKE5CEoY8q+LpgeJMxorDucc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853803; c=relaxed/simple;
	bh=CuaJfRC3s8HMt44kpfIb4IYt4PN36HkZGGz+Qw7uYxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxvIApRA2RnQSsNjMpFm0cTU4z7VIkRu9p/xB6Sa+HBOXu4O+ua8wE5QV3TPhYWxzM+kQPoxoM6iENravixJkCi/K783pwMEmGmMDAOfm3fVHQHzQxkggoU45c04c1B8cUeXayRqWFmU4qSzNJbZKhos34+MNxV9ag5Ff44yF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC/DqhTF; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC/DqhTF"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso20375965ad.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853797; x=1790458597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jVd51dSNga942NlwtDE+a/szNXscAQ4nPUGJDNwj6j0=;
        b=NC/DqhTFME6DtyNyZr4bACagogGG6UWcsjdfAMsqfxWTWzqERw86qokjvLNiUapGVV
         9DNVqdPOHT9EtEyvCCVavwyU94tbLjSgYL0fqCHfrJ/8VMbFeOgzZhnNGlPDw43njAjN
         lTpwTLrU+ZnoIZuyd3vfg7yiqLshSyegMd+kSYoVzb6hmr1Xm1J7ClhdViv3ddG7qW6S
         OXhdsKELqjVg9P+xHQDNnPqPEfb9S0eeCE6AQZDmBkoI0sAXT79tp0mUWpH09yQ9pKc4
         L483uGqQ99bN0ywLhoEfIyCKcFJfuDqZMSscBhjvJozMGJuUynytpho7YzY89tH0ZaiN
         CdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853797; x=1790458597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jVd51dSNga942NlwtDE+a/szNXscAQ4nPUGJDNwj6j0=;
        b=k4ItNT3RHFf6NCXjNOH0AzorU1F8nyU/72Bs2ee88fXVpNg/k7WsPHSF3ZV2ZUbuW+
         ir6o0LJS1tMiH4FiYz0a3FkuB5iW9UpbiocYKUvUeXjENJvAhX2SHL3eC5hVaU4oizki
         TEmOXkjjbT5PSvnVaMVQb/bO4UPGqiIcyjUuBwtFvBZVSZwRSjamOBJ2OheNGKO0kpg+
         ReVsDmLJGKfGj6rh4VeAEOOs4gxk47qN55TnKda+2W5tMIef85YsE1pjRDnRbbXT9wx6
         6NEvAR/BAlVkhh5sHJEPEzYkpS7SkkttCpVzb16z7DxcSJo+pKTbV57XJD3N59eGPYMM
         +aIA==
X-Gm-Message-State: AFuF++k6EYbXORLMOcSdxnpTk8A2MjKpptxDzqIcTZYlOru/+HOFtoaD
	Bb7wcqb11AkkrtZRoL4PEGCXc3u3KAyH1J3FeTwEcqENPTaMqHj12nUn
X-Gm-Gg: AYBFou2b9e53SC9Gqxdc3oKLY9cVgf3sYbUbREeIWxgxs8vPaVl3kHbKDyT/Luga6jX
	PN+xFNT7vKXhECxTj9suzn4xhRQqq88hzxHPonGwHkkipesH1ShAneCi/kWrbGGG42fb/ZEc2te
	7cW9Lolpm7y2fb7LVNhE38Rn9q1BOnFkQnjdGQjW4CAq1UmMeRcbaDjE8m4omy0bR3I0W8HRMuD
	w013Lof7BXgYI8+lnGVf9/+Fl7A0u5VPolmd9RG1K+EhnGtZGeJ3bonzlwKgIPVCWcDz7pithkl
	j37DMZtFRlV1Q6qN9c3MyldJBRf/1xzShIO+TXppyXB0Yh6SgcJW5/vhh/IwgpPX1nnjF8SV4zD
	DeWK7WterJYNwcxtniPbfrCWiChsXnDwLY8A8UgjKhi06c3ppAx6HBvBwrbbzt3yvwQUoySax3T
	FDXsHXOglFoklezbMR3oG+bKTiG/fRZ+nMSXMaXAIrrFbg31xSIMshrOxGUQKVAr8HO2DxW+LMm
	j0Lhl8a4VxzrAp656CjuAu0UZ1X182g+Nj1oeHnXswgWsVfzcMbIcFg67/E/UBQrxsTQ5fRxF+h
	KBRaLYn3/A==
X-Received: by 2002:a17:902:c941:b0:2d9:3bee:4f32 with SMTP id d9443c01a7336-2ddb1b9a350mr112593105ad.20.1789853796692;
        Sat, 19 Sep 2026 14:36:36 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17e17e0sm12949795ad.70.2026.09.19.14.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:36 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: llc: clean up unaccepted child sockets in llc_ui_release()
Date: Sat, 19 Sep 2026 21:36:35 +0000
Message-ID: <20260919213635.3314344-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an `AF_LLC` listening socket (`sk->sk_state == TCP_LISTEN`) accepts
an incoming connection request in `llc_conn_state_process()`, it
allocates a new child `sock` via `llc_sk_alloc()`, holds a `netdev`
reference on `child_llc->dev`, attaches `child` to `child_llc->sap`,
sets `skb->sk = child`, and queues `skb` onto the listener's
`sk->sk_receive_queue` waiting for `llc_ui_accept()`.

If the listening socket is closed without calling `accept()`,
`llc_ui_release()` calls `skb_queue_purge(&sk->sk_receive_queue)` in
`llc_sk_Component` / `llc_sk_free()`, which frees the queued `skb`s
without removing the unaccepted `child` sockets from `child_llc->sap`,
releasing `child_llc->dev`, or freeing `child`. This permanently leaks
the child `sock`, its `llc_sap` reference, and the `net_device`
reference (blocking `unregister_netdevice()`).

In `llc_ui_release()`, drain `sk->sk_receive_queue` when `sk->sk_state
== TCP_LISTEN`, and for each unaccepted child socket, orphan `skb`,
remove `child` from `child_llc->sap`, release `child_llc->dev`, and free
`child` via `llc_sk_free()`.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/llc/af_llc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index b0447c33dbf0..4bc7839127aa 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -204,6 +204,25 @@ static int llc_ui_release(struct socket *sock)
 	llc = llc_sk(sk);
 	dprintk("%s: closing local(%02X) remote(%02X)\n", __func__,
 		llc->laddr.lsap, llc->daddr.lsap);
+	if (sk->sk_state == TCP_LISTEN) {
+		struct sk_buff *skb;
+
+		while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+			struct sock *child = skb->sk;
+
+			if (child) {
+				struct llc_sock *child_llc = llc_sk(child);
+
+				skb_orphan(skb);
+				if (child_llc->sap)
+					llc_sap_remove_socket(child_llc->sap, child);
+				netdev_put(child_llc->dev, &child_llc->dev_tracker);
+				sock_orphan(child);
+				llc_sk_free(child);
+			}
+			kfree_skb(skb);
+		}
+	}
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
 	if (!sock_flag(sk, SOCK_ZAPPED)) {
