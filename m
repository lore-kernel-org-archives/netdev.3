Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DD426D3F
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234198; cv=none; b=rZOSZnBReC1zVlLWrxERTs1K4wMjvJ5iN11fbogVMLEd3IYHc+IKEL27qihGHIecjQUeaNoOJskeAOvZiZJYE96mv0cVIbdjJr9E9rJ7y0mi8v0vAY1eYURCPg+v4uxfVRB6cgI3c0y4NCAAqGDakBh+KABXBWl/tVUfa3zd+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234198; c=relaxed/simple;
	bh=6frqMCwNqJz3N3QZ9P0MlfVB/WAQLVZicQlCmLK3YWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMd2p1JH1J+RzUKJ2TlXYpfRxugz8DNyhNU0qAmrmMqnkhqnBeTsdlGwJxuf8+3PZ3kO/y4mSaB3B5pqo/kJwSv3KYmmWno8obtLTeh1yxyWDQX5hEm06hIHuvy8iBw/csO8ZJ5dX/DT/aNvYLEhsj/ReVxxsu4kIz+UUDp8TmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtqYSsk3; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtqYSsk3"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so720279a91.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790234192; x=1790838992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3DzxIn9zZnPR5YaGs2TT46i5wRUo2UQR+CEo7kDWoE=;
        b=WtqYSsk3DCCvoPBSqg899SYkAn2gcdsR2D1g4AqKFx2Pq3ar2Gcfj3NgsVW/GA5jEK
         z24Dljt5CxPmnAA6O6HK9NzSPHNzR+9WfLRVKFVaXjXHmzrE1qvtrQu5tf1W7vURXxzL
         CfuY9KSUeu6JJ+DsktKWjpVqWDLnCaoGtflbDtL0rkxiBHFuue4MDa1eJ7oK35l6hPG2
         yj9yQhOps9zpW7rpczgVKEzGO57t73sxymF7L29Ea7R5P4YOwVh2SrDHxePfYnYeijss
         EtXNAi8kQ6Q0zFijvbvIZoBXqUQ75PsseRvoBWojvPqhJoFwf8Yq2tN9IjBKBFsOxBiM
         U8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234192; x=1790838992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+3DzxIn9zZnPR5YaGs2TT46i5wRUo2UQR+CEo7kDWoE=;
        b=21KPxChkZA8LkIgMpw9yjYoXSwQWehdeF0PYRLlLxG40SRWv8pJmjN/+D/+ft0cmJb
         Ir8Nypv7pqjIYnpfZet1W6BE9YPGbd26oSlAgRw2ATz4wx6DpNgLTyNxgvAMB1bBfqx+
         f8nSh4vRAUm3X9/Lms+1oMRLr7MgtrrV+IwfE6cqOeGNuFWw1awhfVgnvybQshQLYk6i
         Va2QsBUcHxCcFqTjgjEJQz9SzA0pct80Cs4DFDwS24lmIByCLA/oQRzqV3zmJZAqizkH
         oqZRUM0auJcDUM0KeOMPZnSbxTp8hgo0s/By5fgx/3wWH4yJlG5M2C+QZK5cv1piZbq0
         IE7A==
X-Gm-Message-State: AFuF++kAp8aUelnfrB6klwg+bCtwafvt5DEGCCNnFT2OhaIlf0uyvZmh
	sKENqalSSWx4ioxPK5/uPAM6yGnbNiQ8+/VZiXAmZ7bi1/leG7LWg+br
X-Gm-Gg: AYBFou1xduG22lDaYmoJtZzPOxSBBpQ5CqHsExsQmp7pbm8458lwR5aWULwxxDBQ2B0
	OXnCd34VVh9IngNkqyPSQ3+ekx9cWjIcjO1RgHJYW370HrladmmKZ5gWCuMuUgJ/4/5iRyRDYap
	9XwwSngIg4XeXc7bLykJpIiRcMSI74PZoVbXqy3Wmkc5cGJdWdQiVcIJKcg6NKE83XN6M9WnEmc
	QNF5Im8ER472BgNHxjj3OSracTS2L/wK5L3+9HZlphzwfkp0LdzlKz6/7lNnUKaOig3djzuwMLL
	7erijQwlqpev8e5qiB1oahqhsZByTdmaayOcOSl6ktjERPikSUrS1R+DKo79Ow45B6zRZaZshWm
	mlYbPRIs0fUmV5stACMnikX80YuHFwMSKbDz31BoyZbd9tILO8dY52ba6YISwPMZXUllG3Mw3Qy
	XC/EECBhWJ8sKMg5FMITPjxnbbqOtbnRi85aHACXAR5BotHnyGWSesiZxmJUeqcdWp6032tWOBO
	x63oDmojUgZrzmAj6b3FTw5ljWigZsn9/6WN5Ov6Aj3TgqEQH3ESw14t9YMAlD4I4m4ZNHYf5Fr
	IHq5z3FqeQ==
X-Received: by 2002:a17:90b:564d:b0:39e:6c66:cbdd with SMTP id 98e67ed59e1d1-3a098acb900mr929337a91.21.1790234191974;
        Thu, 24 Sep 2026 00:16:31 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972efa00sm4003402a91.5.2026.09.24.00.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:16:31 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: kuniyu@amazon.com,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v2 2/2] af_unix: skip consumed OOB skb and pull consumed bytes in unix_stream_read_skb()
Date: Thu, 24 Sep 2026 07:16:29 +0000
Message-ID: <20260924071629.2683160-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924071629.2683160-1-benquike@gmail.com>
References: <20260924071629.2683160-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an OOB byte is consumed via recv(MSG_OOB) in unix_stream_recv_urg(),
u->oob_skb is cleared to NULL and UNIXCB(oob_skb).consumed is incremented
to 1, but oob_skb remains on sk->sk_receive_queue (with unix_skb_len(skb)
== 0) to preserve the OOB mark until normal reads advance past it.
Similarly, a partial recv() in unix_stream_read_generic() advances
UNIXCB(skb).consumed without pulling the skb header and leaves the
partially consumed skb at the head of sk->sk_receive_queue.

If the socket is subsequently read via unix_stream_read_skb() (used by
BPF sockmap), unix_stream_read_skb() only checks skb == u->oob_skb
(which is only true for an unconsumed OOB skb) and ignores
UNIXCB(skb).consumed. As a result, a consumed OOB skb (unix_skb_len(skb)
== 0) is handed to recv_actor() and re-delivers the already consumed OOB
byte, and a partially consumed skb re-delivers its already consumed
prefix.

In unix_stream_read_skb(), skip and free zero-length consumed skbs (after
calling unix_orphan_scm() so SCM_RIGHTS fd accounting remains balanced)
and pull UNIXCB(skb).consumed bytes via pskb_pull() (which safely handles
both linear and non-linear paged skbs) before invoking recv_actor().

Tested in QEMU against Linux 7.3.0-rc3 with BPF_MAP_TYPE_SOCKMAP and a
BPF_SK_SKB_STREAM_VERDICT program:
1. Consuming a 1-byte MSG_OOB packet ("Z") before inserting the socket
   into sockmap and sending "HELLO" re-delivers "ZHELLO" on the unfixed
   kernel, whereas with this patch applied recv() receives "HELLO!".
2. Consuming a 3-byte prefix ("123") of "12345678" before inserting the
   socket into sockmap re-delivers "12345678" on the unfixed kernel,
   whereas with this patch applied recv() receives "45678".

Fixes: 77462de14a43 ("af_unix: Add read_sock for stream socket types")
Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Fixes: 638f32604385 ("af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out from the manage_oob() fix into patch 2/2 as requested by
  Kuniyuki Iwashima.
- Call unix_orphan_scm(sk, skb) before consume_skb(skb) when dropping a
  zero-length consumed skb so u->scm_stat.nr_fds is decremented, and use
  pskb_pull() instead of skb_pull() to safely handle non-linear paged
  skbs without hitting BUG() in __skb_pull(), as noted by Sashiko.

 net/unix/af_unix.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1770af3c2684..f5d64e7b5c1c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2885,6 +2885,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return err;
 
 	mutex_lock(&u->iolock);
+again:
 	spin_lock(&queue->lock);
 
 	skb = __skb_dequeue(queue);
@@ -2894,6 +2895,13 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		return -EAGAIN;
 	}
 
+	if (!unix_skb_len(skb)) {
+		spin_unlock(&queue->lock);
+		unix_orphan_scm(sk, skb);
+		consume_skb(skb);
+		goto again;
+	}
+
 	WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -2913,6 +2921,14 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 
 	mutex_unlock(&u->iolock);
 
+	if (UNIXCB(skb).consumed) {
+		if (!pskb_pull(skb, UNIXCB(skb).consumed)) {
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
+		UNIXCB(skb).consumed = 0;
+	}
+
 	return recv_actor(sk, skb);
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog
