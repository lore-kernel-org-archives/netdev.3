Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD945442FCB
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981825; cv=none; b=vEYvGnwqDbhiwg0NKLgmhtWQIYzLwGKv9qFDpBFMku8vfzHpMSsUDyjDjkR8z1SKCxQFnzlSxl5oPyaC/h1EKLzRWZTpRfUpQvGFTay1qKGJYEXjbpGqJhYRvFvH1nZYWBE2c653ctPjaBMx2pKAbIxifSJL6RX/FZtZ7BNIDuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981825; c=relaxed/simple;
	bh=58qHDIQxG1mH9BFRk+cF81U+5YtKWcf5WSKvxO+dbgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRw9RvZXqM2x6dSxGkrjxJ4Y4SOpfdvhOZ3vFiO9NdO535ehu0JQDZQohk9hyZAbEjwjDuHiKfNaaykzWl65aOAHw6lD2s7trNwVnWTE+LYrBPJMHaV52m/NwPBaVzHRVTFWrb37AA17npq9kdyHj9ynW0vjJGk+qXUU2OOAHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNpgLNoV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNpgLNoV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so45451225ad.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786981823; x=1787586623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BSs30Y1kdXLL3xvxTGvOte+LNauCnr30r4k5Jmngzo=;
        b=KNpgLNoVZvcByzeaHHUb3PMBdc8C4fkpFqVNoK8EA/ZSLK3mqotcksKqtNe6UXkWER
         18syHiamDFLLtag4zw/0TyYCXgCMaShVGNmz5kqfuw9PBLVnh844hMctJTtFEZAuKTjn
         uulgITXT0ZLsJi3GMC3b8f9lJdFBRBM0v9cF3eaNlkZmyfWNevHjdeLJWfXZVX8zpILa
         RNyg4h43whM8YCADD9UnxqO8ufYYu3loaDb2x+qAl1nkX5sZHsQGCwEmdpglYMfYUzti
         DGUZhxTR2w169hbxCZRtJaLDgex3zEMoYf2B2jx47orOvuWyc35eXT9UvdqQ2arp0Wjl
         QLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786981823; x=1787586623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1BSs30Y1kdXLL3xvxTGvOte+LNauCnr30r4k5Jmngzo=;
        b=ltKz5xHhcvn2SDCbrDJQywndpLShIGg44aMLbPcj5NH81bYf6DL1t44fptYOml2qnW
         U7s+mYywZNrpGx+smUZ1W0tl1zMOtO6E1+yPgQE1N/rPEdDJm7jTUsuHhkwyOBvsvMOb
         XtQZHrmMg8OBitsuUttgHz+nbQkvy2UR+uhrz/wTmh6ep8idOPlQfR5gbdMeJ7Q+AU7b
         uAZbPiMqUje3Y+MtkDTf5vyy9YCTgJmNMqiJk6mFypS6KO/lkwlmF14ERa+wvjnfQpA4
         xC/ViNxoTGEdylPhm1f8Z8t7LG12/9szpVt0ghEc4XNnt8Puzao/6VDLkGMFA8vNIqqF
         Adzw==
X-Forwarded-Encrypted: i=1; AHgh+RqbV/VI4ybZsupdzSBmEPZJU2wC+AGls8GKuNYUdY8gorw6Zz33HM7UJjlFL2xOQYhAPghoZTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbf/eMNHH2bLP5/ofeKcthuyzFv8wGzMiv3JEwuHPYVx13OPF+
	zO0cGMdt4fuXzLYjpEFdTPcCTrsv1EbddCMLzwBbLaNqiMjpE/41nrli
X-Gm-Gg: AR+sD13ch1WPIQ69QEy12UmJJeJANYk3mUqevCckSfN6aud3zudkhf/ROlJlno1AOTf
	0KSVZb/W61MzoHLyDKfwSMi4cl9Nz43D4X5fk2ubZFQAbiHTxdLCddqOvPu1kE/0owHC/DYj2Zc
	B0+9Qwh2O66OLnWWtXC4iYo6jz+TCu4svNqOvzDIPhHSQ3Tka7JGbDnvLdiGDvnBLn923ZqdeWr
	dtNlexMXmTYqbgQVG2kwaPcGwQIhKt9Cmrl5cfEKFYLL32APXftmJMS9oe8rskx4EN/Pbg4KbiW
	m1AFPnsbG/IGaS8XklADE+hnXXEMK1CvQwGl+qheW9fEW4rpRf3vl7GiQlhekKqwV+FZMo5mJQr
	qA0l3j7ZxErA3cxt6hTl/sHfdzDJD6DlyINzKRnbHm7l78uJO/HcodnQdbDRnbqwgrOJEJsv8qM
	NosU5mElvmAhwi5AB4SdLB56zZkfm9+jqAoahI1VZ4Yi1sXAfe+NkatjM=
X-Received: by 2002:a17:90b:4d08:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-3933b6f0622mr25492398a91.4.1786981822988;
        Mon, 17 Aug 2026 08:50:22 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339b0d6f4sm4682766a91.0.2026.08.17.08.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 08:50:22 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 1/2] bpf, sockmap: settle sk_forward_alloc for strparser SK_PASS
Date: Tue, 18 Aug 2026 00:50:08 +0900
Message-ID: <20260817155009.232670-2-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817155009.232670-1-zirajs7@gmail.com>
References: <20260817155009.232670-1-zirajs7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strparser SK_PASS path can queue cloned skbs back to the same
socket. A single TCP receive skb may be split into multiple strparser
messages. The strparser clones are unowned, but keep the original
truesize.

sk_psock_skb_ingress_self() assigns receive ownership with
skb_set_owner_r(). That charges each clone to the socket. When this is
repeated for strparser clones, sk_forward_alloc can already be in
deficit before the next owner assignment. Releasing the queued skbs can
then uncharge more memcg pages than were reserved and trigger a
page_counter underflow.

Fix by making same-socket ingress preserve existing receive
ownership and only assign ownership to unowned self-pass skbs. For
strparser clones, use a zero-sized sk_rmem_schedule() before
skb_set_owner_r() to settle any sk_forward_alloc deficit without
reserving the skb's full truesize again.

When the skb is retried from the psock backlog, preserve the original
_sk_redir value across skb_bpf_redirect_clear() so the deferred path
keeps the same ingress and strparser state. Perform the deferred owner
assignment under the socket lock because psock backlog work only holds
psock->work_mutex.

Fixes: 144748eb0c44 ("bpf, sockmap: Fix incorrect fwd_alloc accounting")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
 net/core/skmsg.c | 125 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 20 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2521b643fa05..347cb168f749 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -586,21 +586,24 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 }
 
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref);
+				     u32 off, u32 len, bool take_ref,
+				     bool settle_fwd_alloc);
+static int sk_psock_skb_ingress_self_backlog(struct sk_psock *psock,
+					     struct sk_buff *skb,
+					     u32 off, u32 len, bool take_ref,
+					     bool settle_fwd_alloc);
 
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
-				u32 off, u32 len)
+				u32 off, u32 len, bool settle_fwd_alloc)
 {
 	struct sock *sk = psock->sk;
 	struct sk_msg *msg;
 	int err;
 
-	/* If we are receiving on the same sock skb->sk is already assigned,
-	 * skip memory accounting and owner transition seeing it already set
-	 * correctly.
-	 */
 	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
+		return sk_psock_skb_ingress_self_backlog(psock, skb, off,
+							 len, true,
+							 settle_fwd_alloc);
 	msg = sk_psock_create_ingress_msg(sk, skb);
 	if (!msg)
 		return -EAGAIN;
@@ -618,34 +621,100 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	return err;
 }
 
-/* Puts an skb on the ingress queue of the socket already assigned to the
- * skb. In this case we do not need to check memory limits or skb_set_owner_r
- * because the skb is already accounted for here.
+static int sk_psock_skb_ingress_self_assign(struct sock *sk,
+					    struct sk_buff *skb,
+					    bool settle_fwd_alloc)
+{
+	/* Leave skbs already receive-accounted to sk untouched. */
+	if (skb->sk == sk && skb->destructor == sock_rfree)
+		return 0;
+
+	if (settle_fwd_alloc) {
+		sock_owned_by_me(sk);
+
+		if (!sk_rmem_schedule(sk, skb, 0))
+			return -EAGAIN;
+	}
+
+	skb_set_owner_r(skb, sk);
+	return 0;
+}
+
+/* Puts an skb on the ingress queue for psock->sk.
+ *
+ * If the skb already has receive ownership for this socket, leave socket
+ * memory accounting untouched. Otherwise, before assigning receive ownership
+ * to an unowned strparser SK_PASS skb, settle any existing sk_forward_alloc
+ * deficit from earlier clone charges.
  */
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref)
+				     u32 off, u32 len, bool take_ref,
+				     bool settle_fwd_alloc)
 {
+	struct sock *sk = psock->sk;
 	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
+	int err;
+
+	if (unlikely(!msg))
+		return -EAGAIN;
+
+	err = sk_psock_skb_ingress_self_assign(sk, skb, settle_fwd_alloc);
+	if (err)
+		goto free;
+
+	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
+	 * data originates from the socket's own protocol stack. No need to
+	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
+	 */
+	msg->sk = sk;
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg,
+					   take_ref);
+	if (err < 0)
+		goto free;
+
+	return err;
+free:
+	kfree(msg);
+	return err;
+}
+
+static int sk_psock_skb_ingress_self_backlog(struct sk_psock *psock,
+					     struct sk_buff *skb,
+					     u32 off, u32 len, bool take_ref,
+					     bool settle_fwd_alloc)
+{
 	struct sock *sk = psock->sk;
+	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
 	int err;
 
 	if (unlikely(!msg))
 		return -EAGAIN;
-	skb_set_owner_r(skb, sk);
+
+	lock_sock(sk);
+	err = sk_psock_skb_ingress_self_assign(sk, skb, settle_fwd_alloc);
+	release_sock(sk);
+	if (err)
+		goto free;
 
 	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
 	 * data originates from the socket's own protocol stack. No need to
 	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
 	 */
 	msg->sk = sk;
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg,
+					   take_ref);
 	if (err < 0)
-		kfree(msg);
+		goto free;
+
+	return err;
+free:
+	kfree(msg);
 	return err;
 }
 
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
-			       u32 off, u32 len, bool ingress)
+			       u32 off, u32 len, bool ingress,
+			       bool self_pass, bool strparser)
 {
 	if (!ingress) {
 		if (!sock_writeable(psock->sk))
@@ -653,7 +722,11 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
 
-	return sk_psock_skb_ingress(psock, skb, off, len);
+	if (self_pass)
+		return sk_psock_skb_ingress_self_backlog(psock, skb, off,
+							 len, true, strparser);
+
+	return sk_psock_skb_ingress(psock, skb, off, len, strparser);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -694,9 +767,14 @@ static void sk_psock_backlog(struct work_struct *work)
 		return;
 	mutex_lock(&psock->work_mutex);
 	while ((skb = skb_peek(&psock->ingress_skb))) {
+		unsigned long saved_redir;
+		bool strparser;
+		bool self_pass;
+
 		len = skb->len;
 		off = 0;
-		if (skb_bpf_strparser(skb)) {
+		strparser = skb_bpf_strparser(skb);
+		if (strparser) {
 			struct strp_msg *stm = strp_msg(skb);
 
 			off = stm->offset;
@@ -710,17 +788,20 @@ static void sk_psock_backlog(struct work_struct *work)
 		}
 
 		ingress = skb_bpf_ingress(skb);
+		self_pass = ingress && !skb_bpf_redirect_fetch(skb);
+		saved_redir = skb->_sk_redir;
 		skb_bpf_redirect_clear(skb);
 		do {
 			ret = -EIO;
 			if (!sock_flag(psock->sk, SOCK_DEAD))
 				ret = sk_psock_handle_skb(psock, skb, off,
-							  len, ingress);
+							  len, ingress,
+							  self_pass, strparser);
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
 					sk_psock_skb_state(psock, state, len, off);
 					/* Restore redir info we cleared before */
-					skb_bpf_set_redir(skb, psock->sk, ingress);
+					skb->_sk_redir = saved_redir;
 					/* Delay slightly to prioritize any
 					 * other work that might be here.
 					 */
@@ -1017,6 +1098,8 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 		 * retrying later from workqueue.
 		 */
 		if (skb_queue_empty(&psock->ingress_skb)) {
+			bool settle_fwd_alloc = false;
+
 			len = skb->len;
 			off = 0;
 			if (skb_bpf_strparser(skb)) {
@@ -1024,8 +1107,10 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 
 				off = stm->offset;
 				len = stm->full_len;
+				settle_fwd_alloc = true;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
+			err = sk_psock_skb_ingress_self(psock, skb, off, len,
+							false, settle_fwd_alloc);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.55.0

