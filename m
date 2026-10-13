Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95BE3AF646
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877596; cv=none; b=g6hAbMlFBYBqXauRJ+0NcsiQ2+drpeFpRuNn/2JGRchB2FP3csmB+KAULHdCwjVQQxPy2vFMsaGUcNjQQWSwz9B8g9lQitWHrOdHMkCeIxFrgjqoVpAGmkxD8Jmx60FYx/M4vf4j9FGl4b6U6RQxIzNgnbqymw29YrvuN/joMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877596; c=relaxed/simple;
	bh=9QX4kqkvidwzuY8xcIKwrbEmXYMGZ796NnK3r+ozrhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBHhqsTVjjwh0I/MTRHQLAhVYlcDmZ0mYmedJyjOFurjMDskk2CRIEQ77qIOeOy6oyXc24BJAfeizZf0lJthzzrbRDi5fWX/ZFnmO//hzzDfto4Kes0Ls8jYyuw3WcSfVMTxpf3r9B7WOctRQM2wS0hFxhgtk6xPxp9Vz4cIbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFDJp9Ry; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFDJp9Ry"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-887d902c651so274917b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877594; x=1792482394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYtvZLNjrHnFaz8zy1ctOMbEeK8TK4DS4HnanjJBXOk=;
        b=dFDJp9Ry7StAoi6JfcvCnMf9VbasAvAxccW/9bw4iFANO79eILt0q9LlyWINsN9NpU
         MwawyADrgXM2p3OKJZiKmFiB9pAgU3u4dW969vpLzK2pVLpdEd+09wVPePuUetOdAbk2
         BHX0XBsM4hugOOnB3KrxtfuG3SAhAIUANT6CN0Rk5wd3FyJBGO7yDbOaF10TPjQx4Unj
         FW+kzkeJ5EKajO3BYtzp0yXW8oIl/m7ZiNsxbxhaS2CdmnXjXth19B++0RpFafxvQ10a
         BO6UXqW0azbqkoFXOeqj4mj2109eqxKo4OXK6pr0mumjmqq7fCBaVqmL959otKTXShup
         muPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877594; x=1792482394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qYtvZLNjrHnFaz8zy1ctOMbEeK8TK4DS4HnanjJBXOk=;
        b=k9wsUlvZCDqbMszULNVkRe4IueU1KMQNdffMU+d6eBZyL8QFuljGzCfHFyiYXPkKdq
         p/PzlPU3dIsanjmB+7WuJK/iPiUlooVLcFUVEMig/tQ7HKfmbMocfSsPE8MjeAtYis2Q
         +3X7/aqop9m1qyDOSHK1Air1PhnIm7quky6Ak3iVXwGKpwDNEZ4n0SLJFfffxWOWaZxr
         T/VglYL4ZhyRs+5GveAUUY6Ez/ejWNOL+NnVn5v9XInAk0h6p4IW5/J+GnEmBVX2DvQC
         UEChwzhDEqLq/FeaOx96uLtYfsjpC+GmH769GNXHQpAlyC5P5lXr3sxmdDbQ258oIPgh
         GRAw==
X-Gm-Message-State: AFq9FYK9tQfXc6me6YjtW6tdxoIviDUHrIZt3e8acUG/cob/UhNP+Cch
	piHz+a/4voRnffxFuoVTBddlUSzGvyHLEaXplUT+mXk1RvEbl9OrXfByG9ZuuA==
X-Gm-Gg: AYBFou04t5UVsNPseS5sUswgtNKaMXaAigCrDY4iGCdLgz1+doK5hSReaXPOP90bENp
	gOPB2RR2/NMgC+gGZHuDW7naZE3HxlS6qX4QyIiVoSRmOxtSqFGe+rtltAJ+lkc7jQakPzUvnLw
	94fmq8TmK/SFhqSIGEHZD1mcxGpL2Qsll4V81rYp+0F58NmgTq12rPLUgdaGb0Z4GZp/8z4qIj3
	9PUvanhEqhEVQT8jt2MeyT5totLAXjazDvgkV+3XcJLVx9riF0rYOeio3tWN7hQgQ1ivw7swWv8
	dMuk7gqjRN+2i77nugFpJFSkjNXn1CK+O7seNsAekEvKAuhuX65IrRvLxHLn3z8DxRqKjmKebpg
	bKSTU4uU2nMXfacoisPX5DXjAW/uvulsO6NA9CLnd9nJubOIjnJpeH+nvwwiLkBDJyVZOzRzSSp
	1CojDMB4Cr6mxuorIoq08yU9H2mQDHsYKDymOHK4jZTBwPY5vJ7Qh1UcA+LyT6oqsBpWEYrbmlb
	TclW1L55izZ7Mz018DJmLZCXRwGKkhxcUaZqHoPxSknXhAJToEidRHJ44WLrQ==
X-Received: by 2002:a05:6a00:4695:b0:89c:5165:6ea6 with SMTP id d2e1a72fcca58-89c51656f7cmr2749144b3a.3.1791877594068;
        Tue, 13 Oct 2026 00:46:34 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89805c75343sm4459011b3a.38.2026.10.13.00.46.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 00:46:33 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Christian Hopps <chopps@labn.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/3] xfrm: iptfs: run the receive callbacks before freeing the skb
Date: Tue, 13 Oct 2026 15:46:09 +0800
Message-ID: <20261013074610.17808-3-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013074610.17808-1-q.h.hack.winter@gmail.com>
References: <20261013074610.17808-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPTFS consumes the outer skb itself and frees it directly on several
paths, so the receive callbacks registered for the protocol never run
for those packets and whatever they cached in the skb control buffer is
never cleaned up.  Add xfrm_input_drop(), which dispatches the receive
callback with err = -1 before freeing the skb, and use it for the
outer-skb free paths in __input_process_payload(),
iptfs_input_ordered() and the reorder-window free list of iptfs_input().

Fixes: 4b3faf610cc6 ("xfrm: iptfs: add new iptfs xfrm mode impl")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_inout.h |  2 ++
 net/xfrm/xfrm_input.c | 19 +++++++++++++++++++
 net/xfrm/xfrm_iptfs.c |  6 +++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_inout.h b/net/xfrm/xfrm_inout.h
index efc5e6b2e87b..be1f5e569ae7 100644
--- a/net/xfrm/xfrm_inout.h
+++ b/net/xfrm/xfrm_inout.h
@@ -6,6 +6,8 @@
 #ifndef XFRM_INOUT_H
 #define XFRM_INOUT_H 1
 
+void xfrm_input_drop(struct sk_buff *skb);
+
 static inline void xfrm4_extract_header(struct sk_buff *skb)
 {
 	const struct iphdr *iph = ip_hdr(skb);
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index ddf8fd75fd20..f293d5e124d4 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -120,6 +120,25 @@ static int xfrm_rcv_cb(struct sk_buff *skb, unsigned int family, u8 protocol,
 	return ret;
 }
 
+/* Finish an skb that is freed outside of xfrm_input()'s own drop path, e.g.
+ * from IPTFS.  The receive callbacks must still run before the skb goes away.
+ */
+void xfrm_input_drop(struct sk_buff *skb)
+{
+	struct sec_path *sp = skb_sec_path(skb);
+	struct xfrm_state *x;
+
+	if (!sp || !sp->len) {
+		kfree_skb(skb);
+		return;
+	}
+
+	x = sp->xvec[sp->len - 1];
+	xfrm_rcv_cb(skb, x->props.family, x->type ? x->type->proto : 0, -1);
+	kfree_skb(skb);
+}
+EXPORT_SYMBOL(xfrm_input_drop);
+
 struct sec_path *secpath_set(struct sk_buff *skb)
 {
 	struct sec_path *sp, *tmp = skb_ext_find(skb, SKB_EXT_SEC_PATH);
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 6920940a35b4..4b3d04e531a5 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -1211,7 +1211,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 		 * either be save in ra_newskb, trimmed and sent on as an skb or
 		 * placed in defer to be freed.
 		 */
-		kfree_skb(skb);
+		xfrm_input_drop(skb);
 	}
 	return true;
 }
@@ -1298,7 +1298,7 @@ static void iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
 	if (!consumed) {
 		skb = skbseq.root_skb;
 		skb_abort_seq_read(&skbseq);
-		kfree_skb(skb);
+		xfrm_input_drop(skb);
 	}
 }
 
@@ -1751,7 +1751,7 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	list_for_each_entry_safe(skb, next, &freelist, list) {
 		skb_list_del_init(skb);
-		kfree_skb(skb);
+		xfrm_input_drop(skb);
 	}
 done:
 	/* We always have dealt with the input SKB, either we are re-using it,
-- 
2.54.0 (Apple Git-157)

