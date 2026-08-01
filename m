Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F037FF53
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785580014; cv=none; b=W/7lY7z8taZyezCSraotuDAhwGpNaM1PUsgQJz+hoFsDedStx8g2d7IBVQnJ34sly0I2iArXR+m1ElT5xlqNYjW1yMYDlTUa7Ui5eEq7Yke3RqSvzkCkb3lykbb/lZfS99iTzl/c3SLwas0rh8TrqwxNVnOmupaFzblImq47vLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785580014; c=relaxed/simple;
	bh=s50HQiVyrsCromL2L3q/RiNQ/gpasUsy6U2BsrMt2zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmaOfaL/YGpDpHdQZmkb2jlqDKj7a5Lbumd5l8dH7rS+3o9Nj33JoUsW/tTzqijVWBRrrBrwdCTKDaeIxZOrps5kSeZK4AzzOY9PzwTn5GeUDJ0Xd7pDJfl8S0lBZNQjbrWRPq60ThmcyvRaz1jAVxak81CAh4XB2kKzG4GI3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRbcxWaX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRbcxWaX"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8484f229529so1588892b3a.2
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785580011; x=1786184811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AwaHtEcTDpeuOMoaChwOIDZAJW1zODbpeMqtETGYSvk=;
        b=qRbcxWaX0CyLMPbwSkZiZohfcb4iKjeaCOGeQ+X61FadKLPgVliQeajveZP16axz6E
         HHUSKbT0NdEmeH2DxdOU/wqjevmUeAASgCoBW5qFFs5WrPt3NXe4XPRDYA01Q2bQA9MT
         c/ARQ+E++xjC44BjNNgomQKjlLH2HXq/pMVm/jTxHXZ4HmIoaYf5kusTkJy67O5QUXHt
         T2O8s9Ac9N3pk/G3U/l/sk0/kNz5OpDGlfZ75Ja6EhwsWW+XkfmpjbRXFBsR7gL1oaR2
         nlHV1YI5RQqIsDB7RHszf+bYvfNp3hBh6dDbbBXsld0eA9fJjV2mcdjLmD4096212XiH
         D2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785580011; x=1786184811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwaHtEcTDpeuOMoaChwOIDZAJW1zODbpeMqtETGYSvk=;
        b=LASWGPUhAg3BEw3Z/vFseW5O8kQSlomQWUHfA3z08H6Oy0s1ol3zRm98d3s5pT7NYm
         0U23F+8wL38QCbYrwYfBQOlqRTvGm5Nc/RVpTh00OfWJy0YMF2Qc5bAvlHJa0/3vTXwq
         sfeOG5BK6+C9nA19utD4y1ozA56UCBOUEZkUx880mI20WbyOYLG3ihyUXrdId08mstIR
         vyvo3WvsF1at2ZjqdKGoPYmEw6MCtq6NGFupUAvyg9yz7iZnjWzyokfDBaabBQThlJ7z
         RO1CzcfaoNdgUtmINVv7yMVE2dbiEmdowFTuEVakvs8oEkO9/O6DwnLPnWi1SU4Rsjbg
         fkyA==
X-Forwarded-Encrypted: i=1; AHgh+RrNHwY450bkcMSIQhh43h4velxbKjdCL/vTQt9er+7lnsnj4tV/sBhu6DzWxyxuwEXcJvRg0c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPb5BatEPmzUOj62cnds9gchqPEaLIyXfGjadAkDkkUiK+2tX5
	pFBaKwS4W8/WLnTKePVENun0PylgKcV5plMWjhywcSIewKtHlGfTdl1sf6A1jIrB
X-Gm-Gg: AR+sD120NSRAA1mkNYZEX4Z4858QvE8zcLnW5HiFGQ1POzuwezm3mtFo0BFIeovXGCR
	3RsTRUpLyfIa1vVH7PetzAjzU0ufsfvr/VK6DaUbnWyMBK0UMHDKJczbHj9Q/90VC7O6ehri5HP
	W6cpuJd59G3GVasoDd/v9K423ftLvUupYbPduq4PXcoY9A9R+nh5ZvlxfWSjyb5aVkKnjH5ws1m
	Jsd/lOddHQ3NEzXOQekqvS80EMw98fxVJK1SaDsmKnNbIsShYGTnl6xEU77ry8ua7bijifDO8Lm
	DfU88BeKh/nbkMnCr1XL3yTwuDh2E1RWjOc/5P+8ETTqM5otM/GJMDxa1j4Wt9bO6GRSZtJckF4
	C8fcq+e3ZD0nrNtHqWHG9hqLIk7r8xCtTfcgJF4Va46SJlUNezloCqW73AVc5pp6zoNjEywZF+P
	IHqaucBjPhs64cq+L/JGsV9YaHIkDO2Yhbw+0XbNuqLS+ze/SvFvsEX9I=
X-Received: by 2002:a05:6a00:4190:b0:847:99bb:b6d0 with SMTP id d2e1a72fcca58-84ee479b0cfmr2404289b3a.15.1785580010742;
        Sat, 01 Aug 2026 03:26:50 -0700 (PDT)
Received: from omen-arch ([147.46.174.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc51cca2sm1526886b3a.61.2026.08.01.03.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 03:26:49 -0700 (PDT)
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
	Emil Tsalapatis <emil@etsalapatis.com>,
	Junseo Lim <zirajs7@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf, sockmap: settle sk_forward_alloc for strparser SK_PASS
Date: Sat,  1 Aug 2026 19:26:32 +0900
Message-ID: <20260801102633.1872012-2-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801102633.1872012-1-zirajs7@gmail.com>
References: <20260801102633.1872012-1-zirajs7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strparser SK_PASS path can queue cloned skbs back to the same
socket. A single TCP receive skb may be split into multiple strparser
messages, and each cloned message still carries the receive owner from
the TCP receive path.

sk_psock_skb_ingress_self() reassigns receive ownership with
skb_set_owner_r(). That first orphans the skb, which runs the existing
receive destructor, and then charges the skb to the socket again. When
this is repeated for strparser clones, sk_forward_alloc can already be
in deficit before the next owner transition. Releasing the queued skbs
can then uncharge more memcg pages than were reserved and trigger a
page_counter underflow.

Call sk_rmem_schedule() with a size of zero before skb_set_owner_r()
for strparser self-pass skbs. Use the zero-sized reservation to top up
any existing sk_forward_alloc deficit without reserving the skb's full
truesize again, then let skb_set_owner_r() perform the receive-owner
transition. Apply the same handling when retrying the skb from the psock
backlog.

Fixes: 144748eb0c44 ("bpf, sockmap: Fix incorrect fwd_alloc accounting")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Suggested-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
 net/core/skmsg.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2521b643fa05..ce5ad8160282 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -586,7 +586,8 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 }
 
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref);
+				     u32 off, u32 len, bool take_ref,
+				     bool settle_fwd_alloc);
 
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 				u32 off, u32 len)
@@ -595,12 +596,9 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	struct sk_msg *msg;
 	int err;
 
-	/* If we are receiving on the same sock skb->sk is already assigned,
-	 * skip memory accounting and owner transition seeing it already set
-	 * correctly.
-	 */
 	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
+		return sk_psock_skb_ingress_self(psock, skb, off, len, true,
+						 skb_bpf_strparser(skb));
 	msg = sk_psock_create_ingress_msg(sk, skb);
 	if (!msg)
 		return -EAGAIN;
@@ -618,12 +616,14 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	return err;
 }
 
-/* Puts an skb on the ingress queue of the socket already assigned to the
- * skb. In this case we do not need to check memory limits or skb_set_owner_r
- * because the skb is already accounted for here.
+/* Puts an skb on the ingress queue for psock->sk.
+ *
+ * Before assigning receive ownership to a direct strparser SK_PASS clone,
+ * settle any existing sk_forward_alloc deficit from earlier clone charges.
  */
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref)
+				     u32 off, u32 len, bool take_ref,
+				     bool settle_fwd_alloc)
 {
 	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
 	struct sock *sk = psock->sk;
@@ -631,6 +631,13 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 
 	if (unlikely(!msg))
 		return -EAGAIN;
+
+	if (settle_fwd_alloc &&
+	    !sk_rmem_schedule(sk, skb, 0)) {
+		kfree(msg);
+		return -EAGAIN;
+	}
+
 	skb_set_owner_r(skb, sk);
 
 	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
@@ -1017,6 +1024,8 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 		 * retrying later from workqueue.
 		 */
 		if (skb_queue_empty(&psock->ingress_skb)) {
+			bool settle_fwd_alloc = false;
+
 			len = skb->len;
 			off = 0;
 			if (skb_bpf_strparser(skb)) {
@@ -1024,8 +1033,10 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 
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

