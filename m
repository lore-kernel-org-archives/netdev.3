Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A67E477E51
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258829; cv=none; b=ph7E/aMGQy6xr2Za9GSeray/K/7/0NEvRzhsMvU/F2J/nlOO0fJNw/d/j37NJ995bUoXHjUSpzO0S01+56JmsG90cSzZrdhiMuXg16VKE8SeJmTEDCZVTKsLa7XJv+5um6wdnIMLCvt+bPKe8Z9WOEQHcVFN+VjCxWDqfalkkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258829; c=relaxed/simple;
	bh=vOIMW1U9fUy9WNBWnSKTTeuAvqM4SIyRn7lhsRt/YDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFQkV5JDNk/oi2mQg8fd+P5MXYfVOE+YbeXySUwvCOK9Ma8017TDN/ARvDrbiEZ8nVQeeXey4O0f0zWNpRBE0ratYmFvWBJNB8I4Rhz7Q5o+x3lbNJgGPxt1Gd5OJP0maZm+kaPjn556QDPRTIgpMK+qIwPqBtgkzhg7pOTPB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=CMVCezW1; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="CMVCezW1"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1228366a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788258827; x=1788863627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=28E3gzKw1BC+V11wZJETp2y9T2uBlRNahPrPaDZe6E0=;
        b=CMVCezW1sfYij2o0nwcveW7X2tEKT1EkqLYVtIcdPbp6ztWG8G8NEjhg7GNehx+S7/
         nokzes8Oq4Oy+YMX5K9oLVe9S43mhSJYzsqufERNq4G9douGLX1KLjeWexCeBOuVAuU5
         xUTR9c+KH1phr7H2+2JuXd8DdQVOKQoFVOU+Tyyp7ZvMeDqvu5FqLUCq9cKaSNfn2Pqm
         vuXhvlBkUokYrVf6bKwFrZkOnUB71ARihBFYwhlG5+rJxfRKBssd9XtQrXusVu/OnkLV
         ySLsGFif7186mwXJGnYb6Gkxf386Jk6JPokXiCwTqt/PvkNbqooltVZ6noAXTVOIHKnz
         zOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258827; x=1788863627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=28E3gzKw1BC+V11wZJETp2y9T2uBlRNahPrPaDZe6E0=;
        b=n9s4aQayBgVM7Vnern6EXogLTKLr7OVo1RPvCFsMAWY8hUnL5GV3s5WKM63g6DBbDL
         M2rn9tZZBb+xiyAAwMlMhjnRuu1jZOf8+KNXwRRp1oYPTZghsUEr5tW5mbXS1XBxZ5s+
         zXLExIvGRb2GjR+fTrEQmsCofWsjaUOR7AZ1LS0NF0vVAZo5jDvLhOEVarZ3RlHhAm7Z
         JrC934zlAV88w7qP8qZsm0x/WIkLEnkIHTF0U7H5KLVdSk0Jn89iw4OaQUzUe7FhO6XW
         i3GwDPCRhv3G4En6tf/dct0OrjPQ8ntuGWhMGSWxERKa8tddcwkjlLXgwm2jiX/WqXLj
         1dDA==
X-Gm-Message-State: AFuF++k3XgH0/aCgPRWVCWT2qmhzM+GVKAjV7oUHfZ/8DTfIxg7EFdog
	v03cqpmxa27TqeBPuFwxDB8yVPHikuYUMfHIr26cy46y8BTcCTpqWclpMdJ1UpEkI6ZKaTmMaxT
	EEjLy6JKFaG4=
X-Gm-Gg: AYBFou0gxCv5hTOB2FXlEXQl5vdQN0UycimnR19dNRlms8Tp3mT5Cm/j1BtMoWc7YS6
	GGRu8a9T1kw20mKoNQqrijKZYFLj+Z/j60+zXhwwNYeALNiviE4df/Z440bESp0HIxX51/WKOem
	QCA8+3jzZKzM20MKnmxNQjqtfM3lcgaHlBuec+cu7+l4AQVke/ziaJ/5pfG6dYHNJJsHnnWAj92
	KJaTenB+YhHKKDmhPuXpIJ6GNoQU0hR/r9JfQVKDhrVrxaQMLASFJ+WKbaL7h9K9eO5xZk2jEsH
	e+rioCwOUzB7pVHx3meT2Vb5duRvz+u6NJpcj9BBNKEudunPQvEBTyYwPxuGUKCMRvKcO9U39YL
	mH3vWdjQpkUiYIH3H1AMpaMKiiyhdWpdphgJsuvHwrlqZ6S+hmfB9/iYr1OESpArQhNX7emysro
	F6XT79SBOj4gl83ojtFRofEEWGmpmsWKk+K+zi2pjSagkO+0UfJQunNuYLcxwBaL9m6+NcAvI=
X-Received: by 2002:a17:90b:1b08:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-3990f8907c5mr2621194a91.14.1788258827484;
        Tue, 01 Sep 2026 03:33:47 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm6126574a91.1.2026.09.01.03.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:33:47 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	daniel@iogearbox.net,
	kafai@fb.com,
	kylebot@openai.com,
	david.lee@trailofbits.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net v5 1/2] mptcp: hold MP_JOIN msk ref when cloning reqsk
Date: Tue,  1 Sep 2026 18:33:22 +0800
Message-ID: <12d0c7f938729d16fcdd5b46a6a0e912fb1cd2f8.1788202924.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788202924.git.caoruide123@gmail.com>
References: <cover.1788202924.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

TCP request migration clones pending request sockets with
inet_reqsk_clone().  For MPTCP MP_JOIN requests this byte-copies
subflow_req->msk, but the clone does not own a reference.

The original and cloned requests can consequently drop the same msk
reference, leaving one request with a dangling pointer.  This manifests
as a KASAN slab-use-after-free in subflow_req_destructor().

A non-NULL subflow_req->msk means that the request owns one reference.
The third ACK can concurrently transfer the original request reference
to the child and release it, so taking an unconditional hold on the
copied pointer is unsafe.

MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all current
inet_reqsk_clone() callers run in an RCU read-side critical section.
Read the pointer from the original request, acquire a reference only if
it is still live, then re-read the original request to verify that it
still owns the same msk.  If either check fails, clear the clone pointer;
otherwise its normal destructor balances the new reference.  Mark the
ownership-transfer store with WRITE_ONCE() to match the lockless reads.

Patch 2/2 completes the clone fixup for MP_CAPABLE token ownership.  Both
patches carry the same Fixes tag and are required for stable backports.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Kyle Zeng <kylebot@openai.com>
Reported-by: David Lee <david.lee@trailofbits.com>
Closes: https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trailofbits.com/
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/mptcp.h             |  7 +++++++
 net/ipv4/inet_connection_sock.c |  4 ++++
 net/mptcp/subflow.c             | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 71b9fc5a5796..0a02ac1ed22d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -223,6 +223,8 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
 					       struct sock *sk_listener,
 					       bool attach_listener);
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
@@ -309,6 +311,11 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 	return NULL;
 }
 
+static inline void mptcp_subflow_reqsk_clone(struct request_sock *req,
+					     struct request_sock *new_req)
+{
+}
+
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6257459bcee2..896f472dcba2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -21,6 +21,7 @@
 #include <net/xfrm.h>
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
+#include <net/mptcp.h>
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 
@@ -961,6 +962,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
 	}
 
+	if (rsk_is_mptcp(req))
+		mptcp_subflow_reqsk_clone(req, nreq);
+
 	return nreq;
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..e08d1036ad78 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -47,6 +47,37 @@ static void subflow_req_destructor(struct request_sock *req)
 	mptcp_token_destroy_request(req);
 }
 
+void mptcp_subflow_reqsk_clone(struct request_sock *req,
+			       struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+	struct mptcp_subflow_request_sock *new_subflow_req;
+	struct mptcp_sock *msk;
+
+	new_subflow_req = mptcp_subflow_rsk(new_req);
+
+	/* A non-NULL ->msk means the request owns one reference.  The clone
+	 * copied only the pointer, while the original request can concurrently
+	 * transfer its reference to the child.  Acquire a reference for the
+	 * clone, then verify that the original request still owns the same msk.
+	 * MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all clone callers run in
+	 * an RCU read-side critical section, keeping the memory stable here.
+	 */
+	msk = READ_ONCE(subflow_req->msk);
+	if (msk) {
+		struct sock *msk_sk = (struct sock *)msk;
+
+		if (!refcount_inc_not_zero(&msk_sk->sk_refcnt)) {
+			msk = NULL;
+		} else if (READ_ONCE(subflow_req->msk) != msk) {
+			sock_put(msk_sk);
+			msk = NULL;
+		}
+	}
+
+	new_subflow_req->msk = msk;
+}
+
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 				  void *hmac)
 {
@@ -919,7 +950,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			}
 
 			/* move the msk reference ownership to the subflow */
-			subflow_req->msk = NULL;
+			WRITE_ONCE(subflow_req->msk, NULL);
 			ctx->conn = (struct sock *)owner;
 
 			if (subflow_use_different_sport(owner, sk)) {
-- 
2.34.1

