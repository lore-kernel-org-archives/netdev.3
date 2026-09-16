Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848A3D7D80
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539244; cv=none; b=Hw4E9UVb35tU0GPVLN/zlHbEM8psPvY5JyauP/Fk6m9jKYeTwHU1yEIZKoJL0gET6q4alxpKdKAcE+xpBGmcwhkKYgxi6e9WE1YV9cxYG55Ql9e1gu0zBvvtqTmrXDcC98eM+zL8VCweAEhGckJpEdbbizglVK9K4OvKEv4Sfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539244; c=relaxed/simple;
	bh=LLzBbBkz5tWZR3ZhSpBolX7VKFLBJ6xHU2KE8wVP/Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B4IPNJefkxKJGgGpi636M6wlKX9ULlryW7QQsuD6UM50KcDyZWTadSkRRpprkxNGMlAGnORF3sbcuGMTUmAwrwdg3owGBP3jkjMDt+PVKDjf47jKpz0fUlC10ThQZAQh6Pe2sMRFxPiJaLu7MkE8MwfUB86Qvpxd1BTtlVSAFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J//aWbJx; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J//aWbJx"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965683e9e9so3192219a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789539242; x=1790144042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LU+SDKe8XDop40dOPZ/GCJDL1iYFi9OwTAHjmzwbdbw=;
        b=J//aWbJxQFefE+MlZP9YwONbDIMW/5TUZm7IWJuNz8wd3EOCByk+pqjKxIKb3Yedbm
         VFdWSKwbKkQXw5Rdxy/GuqH2cxv/Ph9xoXTOF6xCU6O9Y1LbHS6AKl6ktYJh/hhae4js
         t1EDWMvpVOeVC40v6gmJfWhMxsJ3oinuD8g3Y+YtWcFYT7zlMe7qa7OksTeoDOUin2nN
         V+L/q9NO7beGarVpmWyWqmWNVQ/6aOSlm91Oe7w8qA+5N5Q3o0Y/eCAE1Y2MJWTjxcL6
         4M/kBzUc5Nyc2MfhRpNNlqLYrQ3Yni8cXkDYeHoxBHeHjxUG9Iv9GfiGvFJ5x0m2nUtj
         Yk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789539242; x=1790144042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LU+SDKe8XDop40dOPZ/GCJDL1iYFi9OwTAHjmzwbdbw=;
        b=NqePRwMhhOIs2+UQXJfHtY65bxdUUFQFkdJIdIaO7lEvu+U0SpFoEwo2I/tFkyEimS
         vTMRpWra+azTcfBvBvuK0g8mq9XL4zc00Zo5M0o+z04kFvfKebJCf93897e/n40ammhu
         a94MOckOPwcl+lBP/9OqjoaW1j2xkTGdVUuj3YiPKB1BbAdIYdBFSHqXHTJUVDUeSMxm
         W2G9uLfTX91m2kNelkKJnR31UWCJOHlxky01aZqS6Pmrb2Vdz+/V851sYlXsLalp23C6
         BVIzXn3kmHNci2bbD76UlOy2GBcSH49F4Mzf5o/TIRThj0ymEnn5DKaXJ+AjwZ5vf8Bm
         71OQ==
X-Gm-Message-State: AFuF++mGtZ0ervlXcFXeqseAGx7/4n/3HWaM5zUUBd2wQ+XJTbIKbKtB
	ZxzQ3MyKGH7t4L7UopiZCMAx0SGohmWUT0fm6hMetYMEHj3uyXOBFtHd2pvNzObcuWwKnw==
X-Gm-Gg: AYBFou1/0tsZOQs1H2Ey5XliCzC4MJqX0dPmF+BNRjI+jCGlm+Dl8+jmE8a5joEgqyg
	7jbe1lktZYgsUbNn03fx51JjF7zRVV3ocBORQ/fc++/6PKldTw97FzWqxk7nOUSpIySJelDmQYK
	VhY7kbGP91s3VGmHOz2FaezIikHhA9DLxoBMGQCvWzhQbPpr5ke0lgU9OFuwTwlh0H6iNOS66fM
	KM0iukYjQDDGb3XkXMeETkmz3C17hLaJUkMWcOoUordIv+JCIluzPe2bg87aUcEFDV20sKWTQmL
	ngVx3ez5E749tIYOjY1hggNL4X7vXyiQKWeYR7wEkqwlcZDwx8Iz17g2rdq0BNIvfihwQ4/tudh
	cuF8vUOrjXXPo+QTNDReS5uSBRDdn7DTNEvEiy9shFqs/J4murEpxo9xK/M8adMHGrn5EXS2eJR
	isJB7DDuVbYgjJZF3QQW9OxC0DzLRRfdPlgKM0XkgOVpPE4391tU856FSSaBZGQMEUgS2HNlDK9
	9edxdKhb0KkvA==
X-Received: by 2002:a17:90a:c105:b0:39e:27e:2f09 with SMTP id 98e67ed59e1d1-39e1e284ff2mr3519225a91.8.1789539242253;
        Tue, 15 Sep 2026 23:14:02 -0700 (PDT)
Received: from localhost.localdomain ([112.49.236.217])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d4cbc9sm3664359c88.11.2026.09.15.23.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:14:01 -0700 (PDT)
From: xiaoshoukui@gmail.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	w@1wt.eu,
	jmaloy@redhat.com,
	tung.quang.nguyen@dektech.com.au,
	xiaoshoukui@ruijie.com.cn
Subject: [PATCH net] tipc: fix memory leaks in bundle and fragment paths
Date: Wed, 16 Sep 2026 06:12:20 +0000
Message-Id: <20260916061220.798324-1-xiaoshoukui@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xiaoshoukui <xiaoshoukui@gmail.com>

tipc_data_input() returns false when an extracted inner skb or
reassembled fragment is not consumed (e.g. unhandled protocol user
types).

The bundle extraction loop and fragment reassembly path in
tipc_link_input() both ignore this return value, leaving unconsumed
skbs unreachable and leaking SLUB memory.

Fix this by freeing unconsumed skbs with kfree_skb_reason() and
setting the drop reason to SKB_DROP_REASON_UNHANDLED_PROTO.

Fixes: c637c1035534 ("tipc: resolve race problem at unicast message reception")
Signed-off-by: xiaoshoukui <xiaoshoukui@gmail.com>
---
 net/tipc/link.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 49dfc098d89b..3278a559347b 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1306,15 +1306,18 @@ static int tipc_link_input(struct tipc_link *l, struct sk_buff *skb,
 		skb_queue_head_init(&tmpq);
 		l->stats.recv_bundles++;
 		l->stats.recv_bundled += msg_msgcnt(hdr);
-		while (tipc_msg_extract(skb, &iskb, &pos))
-			tipc_data_input(l, iskb, &tmpq);
+		while (tipc_msg_extract(skb, &iskb, &pos)) {
+			if (!tipc_data_input(l, iskb, &tmpq))
+				kfree_skb_reason(iskb, SKB_DROP_REASON_UNHANDLED_PROTO);
+		}
 		tipc_skb_queue_splice_tail(&tmpq, inputq);
 		return 0;
 	} else if (usr == MSG_FRAGMENTER) {
 		l->stats.recv_fragments++;
 		if (tipc_buf_append(reasm_skb, &skb)) {
 			l->stats.recv_fragmented++;
-			tipc_data_input(l, skb, inputq);
+			if (!tipc_data_input(l, skb, inputq))
+				kfree_skb_reason(skb, SKB_DROP_REASON_UNHANDLED_PROTO);
 		} else if (!*reasm_skb && !link_is_bc_rcvlink(l)) {
 			pr_warn_ratelimited("Unable to build fragment list\n");
 			return tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
-- 
2.34.1

