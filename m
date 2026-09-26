Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2823C553F
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790417054; cv=none; b=g80lJ2nTkAgHtQugK0efMoZPtFOfg3WEE19XGy34kw00HCY4e2Ru3np4DBMDqlMNYwRJzBodQHsd8rOFA/vzMHvB9bnspSKP1C1XeC874yGRUS3pDm4AOTV6bGB+6JoT/Qbc3gJd2G7sO26y/KP5fc02LtC/sVoSfvhi3jHrYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790417054; c=relaxed/simple;
	bh=RtcseYG9aV+ITJZ61o92g0FqmHI/+STKqt0//tmSLMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlVEt4Bwpvu4lVRHutll5P8CHhY+1gvBtQwfQ2Y3eUIzFIlV9ln8IZsLlnZ/k9gSO/3JHto6QxPPjorb7V4tf2B3c1cuB/VVxfac9UoopRMhdh0T4ZIT4SfG0LMdWKrJbrnsrUZzyQj1YnCuE4nBE7mQ5KX7lr7+ALJSpeJ+aTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBUF9oao; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBUF9oao"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so803969a91.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790417052; x=1791021852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpGJ2l/O3/mIRy9LzQ6XSr4TtWxUOpBwbRMVXQJYci4=;
        b=NBUF9oaovb5HLvyoojTvf17U9p9KX7kkVhRx+kQOeFdTkzX9QbHp1P9a782Bd7irHh
         rCHLXRYhTznaU+4ONc5QBaY1Uo/DhBewJG6/mkqYdjAQEDdE/e2FAqH2dHGP6b7VNR9q
         iCcYMw9TZJbsq34MAZOJUh2J7/cJiR4P/ZGIItF3fz06gtuNUMmLgurJ7T7BfyI57hMS
         DsBK4nU4zslaWX0tYMADnxUqMh2YEoYJXPf/I10rY+Et5+ABdeNaIgkO21/eUKGAbVgS
         6LXsIEiAIH+T95D9pgka9NOI8Il6dCwPsZOlbWWQu7BiwNWOVgc0dAycr65jfB250keM
         NhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790417052; x=1791021852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpGJ2l/O3/mIRy9LzQ6XSr4TtWxUOpBwbRMVXQJYci4=;
        b=TcEjfmTKvooQl7PSUlRnTE6hjUXqcy3RC2Y42+2u7f9wax2ejJxRis5Ul+79zD7TuM
         +3zO14rRwnn9yuWhHLXLal5u0J9zTrg3wrhMV8UIPAKRJ7YcFZ44XGRxs0mv1Z4Wrvou
         EBa+ZtYt32XtbBm+wSYve+Im98pbg9SY5LGIBJKVl3KsS/vef13bWyeJurJWE1zAtv67
         iXbe+byDP9gLLOcs5w2zXBfNrhWBZ57nUiIxu5YQn85R/vtqeer8KB90lK1NbQCp5gC5
         p+CBFU7+UCahvy2YHBbIW3HOnN5mXwR6xzrzpIVpZXrK7fhHDiD27vODaS3ufTUlLgLV
         wFiw==
X-Forwarded-Encrypted: i=1; AKwUvBz/WcuNUR3/JidaDFd6+j2yOd5cO86sBEQ537+holiRwmcoPXyLoUP45oZ4DWFMLhKCBScuBSw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcmLrLBU2m5Sr1AiScvrBOkf2kNn1VYPnJbm7KFRVW37SO42i9
	eO8pWXKispc5vog9MjcXTnlZn/J2IpDxsRTabRH7WaGTURzJxisNEqmx
X-Gm-Gg: AYBFou2oYdS8Xgzk3FLUIS/bvIs/AOOQ7cYPCN8NZmv4Efyli/Fdy5BMdZFOtfjqCtz
	n8XVAA1l1lzB3NgxB3u9qfAT31BZ3dIj4j3a/VekfvwjhtSF/tZkpsb7B/32dWSj616BGVL9kVM
	An0GZ+rxSca81AasIUo3JLhYf1liMB+1xULWzk7vPfIr9eVOAUBXeW5ebUWeTxKHy260AOcHqGP
	iRR69Dsw7ujBkd1ICqt173HnTRiSFL7YdKG/LQZgQnvvdXgj/OPgE4Ajj+QflXbTF0D/s+2qE9p
	fJ7oToffpjysH06TdvjUiG+kxyGDJnjTkKyv9EKiOeefeRPo6jrHZL73HrWVFm6rAo4Df37/8Re
	jBfIEhyklWixdzDH2bnDihFkvo+455I8bAl/FpITiXQAcn0O6naaAEe3FvQHtW5toQib6VO1HNI
	gbxZV7PO7JvCtmB4m0f9T6Ej7VRfGGvfufO+0632/VWdh3OlKs6pkfUcHjrHlzyMZkbcOIj1nVB
	4rxH9bXngwvz3tGMXroUP75nxzaH1/MPSimEi7v8fvwEDA=
X-Received: by 2002:a17:90a:d88e:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-3a0985b8f62mr6876795a91.15.1790417051743;
        Sat, 26 Sep 2026 03:04:11 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c719f86fsm6730826a91.7.2026.09.26.03.04.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 03:04:11 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net v3 2/2] sctp: re-point retained control chunks on association migration
Date: Sat, 26 Sep 2026 18:03:58 +0800
Message-ID: <20260926100359.78731-3-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260926100359.78731-1-juny24602@gmail.com>
References: <20260926100359.78731-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

sctp_sock_migrate() transfers DATA chunk ownership but leaves retained
control chunks pointing at the old socket. A later retransmission can
therefore access the socket after it has been freed.

Extend the migration walk to cover retained control chunks and use
sctp_control_set_owner_w() to assign their new owner.

Save the old chunk->shkey before setting the new owner and release that
key afterward, since sctp_control_set_owner_w() may select a different
asoc->shkey.

Fixes: d04adf1b3551 ("sctp: reset owner sk for data chunks on out queues when migrating a sock")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

v3:
 - Call cb() directly for control chunks.
 - Include the shared-key prerequisite as patch 1/2.

v2: https://lore.kernel.org/netdev/20260804113705.45754-1-juny24602@gmail.com/
v1: https://lore.kernel.org/netdev/20260730090537.27629-1-juny24602@gmail.com/

 include/net/sctp/sm.h    |  1 +
 net/sctp/sm_make_chunk.c |  2 +-
 net/sctp/socket.c        | 37 +++++++++++++++++++++++++++++--------
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/net/sctp/sm.h b/include/net/sctp/sm.h
index 3bfd261a53cc..76605d1ee839 100644
--- a/include/net/sctp/sm.h
+++ b/include/net/sctp/sm.h
@@ -252,6 +252,7 @@ struct sctp_chunk *sctp_make_fwdtsn(const struct sctp_association *asoc,
 				    struct sctp_fwdtsn_skip *skiplist);
 struct sctp_chunk *sctp_make_auth(const struct sctp_association *asoc,
 				  __u16 key_id);
+void sctp_control_set_owner_w(struct sctp_chunk *chunk);
 struct sctp_chunk *sctp_make_strreset_req(const struct sctp_association *asoc,
 					  __u16 stream_num, __be16 *stream_list,
 					  bool out, bool in);
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 84a4c97d0f75..b2eb7568a58e 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -94,7 +94,7 @@ static void sctp_control_release_owner(struct sk_buff *skb)
 	}
 }
 
-static void sctp_control_set_owner_w(struct sctp_chunk *chunk)
+void sctp_control_set_owner_w(struct sctp_chunk *chunk)
 {
 	struct sctp_association *asoc = chunk->asoc;
 	struct sk_buff *skb = chunk->skb;
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 4a08023d52aa..efee9e3e671e 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -155,9 +155,15 @@ static void sctp_clear_owner_w(struct sctp_chunk *chunk)
 
 static void sctp_set_owner_w_migrate(struct sctp_chunk *chunk)
 {
-	sctp_set_owner_w(chunk);
-	if (chunk->shkey)
-		sctp_auth_shkey_release(chunk->shkey);
+	struct sctp_shared_key *shkey = chunk->shkey;
+
+	if (chunk->msg)
+		sctp_set_owner_w(chunk);
+	else
+		sctp_control_set_owner_w(chunk);
+
+	if (shkey)
+		sctp_auth_shkey_release(shkey);
 }
 
 #define traverse_and_process()	\
@@ -173,9 +179,9 @@ do {				\
 	prev_msg = msg;		\
 } while (0)
 
-static void sctp_for_each_tx_datachunk(struct sctp_association *asoc,
-				       bool clear,
-				       void (*cb)(struct sctp_chunk *))
+static void sctp_for_each_tx_chunk(struct sctp_association *asoc,
+				   bool clear,
+				   void (*cb)(struct sctp_chunk *))
 
 {
 	struct sctp_datamsg *msg, *prev_msg = NULL;
@@ -198,6 +204,21 @@ static void sctp_for_each_tx_datachunk(struct sctp_association *asoc,
 
 	list_for_each_entry(chunk, &q->out_chunk_list, list)
 		traverse_and_process();
+
+	list_for_each_entry(chunk, &q->control_chunk_list, list)
+		cb(chunk);
+
+	list_for_each_entry(chunk, &asoc->asconf_ack_list, transmitted_list)
+		cb(chunk);
+
+	list_for_each_entry(chunk, &asoc->addip_chunk_list, list)
+		cb(chunk);
+
+	if (asoc->strreset_chunk)
+		cb(asoc->strreset_chunk);
+
+	if (asoc->addip_last_asconf)
+		cb(asoc->addip_last_asconf);
 }
 
 static void sctp_for_each_rx_skb(struct sctp_association *asoc, struct sock *sk,
@@ -9640,9 +9661,9 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	 * paths won't try to lock it and then oldsk.
 	 */
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
-	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
+	sctp_for_each_tx_chunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate);
+	sctp_for_each_tx_chunk(assoc, false, sctp_set_owner_w_migrate);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
