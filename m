Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F74A2A64
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263561; cv=none; b=Ie8KKvqErq1lXcWUIVvLwSOhZWp7jIoJ0DQ2cyGuHd4yDKiF2xwcA2rmMIcdAkbR5zAGl0h0pHALURLO55an8rWkua3ZvwkV7oHvTnh4qMwyDFpfdmuG216kEC+psj2g1rkYbr/peveV/adDDTvER9R/4HHNmAhN4wq0gaZ+PQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263561; c=relaxed/simple;
	bh=Y9qjCjqHfKXYGilp2qzLf4Wx4Sj6lCjwTXIsDpS91PM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=duRNqDfzAGXsd0RiGWRzeSfXgc7imffKi8scdHicXmdpkBV/D1YXv3e/1jM0uyrA8/OLWiCTQ0kk1jBOboWAfaKSvIn33zxFXNpLo36dKFF45SDVAe5vUvX7u86dnn2jSwV9/Okq2rUt5NP0Xs/Co0af/bdpe0RTFGxorF4/RtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m62m1C/3; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m62m1C/3"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso1474028a12.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790263560; x=1790868360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=243tpiIMClagsl6CRGSGD9PSBO83Fk5wM4iFcQ8ZqbQ=;
        b=m62m1C/35mdiGruNYAQ9h3cE4L2Yn4WXGFyQJ/SHAJsvqq8ye3149H49AZvwvQlMm1
         0COsxxqf7zyiLRh8ePXyTgWPcb1TfBWI8oy0cUU1YPXJJeg4dSDsYZWssRdCvUS43ZMW
         4jCSQSt2/y8KrBH2F+aXlYzUh2bTxA2NyYd+b3ZuJkNTIGhJaLiLPyagZbkh1G6OeIzs
         tjSNz6Dk0ieYn2fOWFdR3Qj4D4zqLsuKvTKH1c9fmVGZE+21VUs8u0qFRktqUep4hmCw
         wZTU98RrPzMkdupJ/tXQQrluKgU0s/T86KdvfXpZ8gh6zAzvAya1C1XJqVxg0u3w3d7p
         fAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263560; x=1790868360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=243tpiIMClagsl6CRGSGD9PSBO83Fk5wM4iFcQ8ZqbQ=;
        b=00af5A/TNoFnhlvNQx0w9fKHRStSMNuxZr8KXk1rpk/Oy6ctO/xJQ172dM4WkdxnAJ
         E6z1uXk7oP4Wvr9+xGM8MTa/D/eYiEGvevD6D2kvQs+rj9vwDDVUVB8hH5YPzmP0PMLB
         oFkK+MqM2hVy+xNImvWKXn7QpJowOw8Tjlxie3Rsgjt52ydZtd37uX0nh3i7azxocegd
         CJaw0KHn1hlRVgAXSO2thJjOW/3oV50QmzQaAb6LbmMl8QZWh0wp5xEK08Nmiw3RdX7W
         1PNziwHhKdkUwT44q7xpd/41SQugHm6Oxhvs17NMlF3aExTfckFSpRu1Fy74dAevCGEj
         KqCw==
X-Gm-Message-State: AFuF++moAgLhalYKi14FBLnqVbl9RanS2nX8nBQld3oEHn0ba0r2zUzJ
	gEZY2Mq/4z113KO8m4pFLw62XvxxqKrhorom6BTifiSueVyZALs+geXg
X-Gm-Gg: AYBFou36JF6wfJiGIhhC0lmKupwUZz7nA9hoqujqULoY2mi9PCQwYQZ9m7iSSKyhUDW
	UpR3Hmx8E0rnr03T6SKaSkSr1zjPS9kcrh8j1/fF2873UFLQB4NH06ZgcBs4Sl4IgBJa+kIDjF2
	Hj13/hLSeL69CjGCtZpuQEzNJfVnPf2kZKdF49FB3CGAJ2Clb8rSgruniqfUJSHs533tUSBc4Qj
	se5biorIdOCbpQiRn1Cw+TRPjc9RJVCX7prwrsEbOjU5lpwS7rJcQ6EeExH/U7VauNkEkPbI0dr
	aemxp09hvmTgWIguJogS7V6ae/zjYbtHA6pblOVFX46cwFE+q6T9aH5LKRH8XQHXeSuFvmVlk4s
	MBvdrytIx7vz7DYK2wulL5Ni5lT3P0XDtJPvBhVBt+lUPiltBSghl72KvwdXA0XYdcrVNxSq2Ef
	cXMAwzzVjnPkQZTSkVlikW6u1IPcKDJAhoFuZt8H/CIct+lOqx1/ZXaoIJU9SkI8lWn//cdJ/lW
	9dZgsRSRSdPRucDvok/8JlG+w6Do2m9gTgaMKlH8M7+A24HidqrYl1vEztAPFeDKe8rPHfUelDq
	D+utkHhAUIBqFjzdthrIpUczImP9AVPB8b7730nJ+S9LNL8Big==
X-Received: by 2002:a17:90b:3d81:b0:39e:6c6a:6574 with SMTP id 98e67ed59e1d1-3a09896f002mr2788309a91.55.1790263559740;
        Thu, 24 Sep 2026 08:25:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.38.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0aeb2659bsm385735a91.0.2026.09.24.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:25:58 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH v3 net] tcp: preserve timestamps across receive queue collapse
Date: Thu, 24 Sep 2026 23:25:29 +0800
Message-Id: <20260924152529.5689-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tcp_collapse() rebuilds skbs under memory pressure, the copy
process doesn't include the right tstamp and hwtstamp from the
old skb. And memcpy(nskb->cb, skb->cb, ...) copies has_rxtstamp,
but nskb->tstamp and hwtstamps are left at zero, so
tcp_recv_timestamp() ends up emitting no cmsg at all.

In net timestamping case, if such an skb happens to be the last
one consumed in a recvmsg() call, the application receives no RX
timestamp for that call.

Fix this by copying both tstamp and hwtstamp of the last skb to
the new skb, matching tcp_try_coalesce()/tcp_add_backlog().

Note that the has_rxtstamp flag can still be inherited through
the cb memcpy from an skb that contributes no bytes (fully covered
skb left in the ofo tree by the tcp_ooo_try_coalesce() ->
coalesce_done path), so set TCP_SKB_CB(nskb)->has_rxtstamp to false
which makes the new block the only place setting it.

Fixes: 98aaa913b4ed ("tcp: Extend SOF_TIMESTAMPING_RX_SOFTWARE to TCP recvmsg")
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
V3
Link: https://lore.kernel.org/all/20260917132742.87117-1-kerneljasonxing@gmail.com/
1. revise the commit message with more accurate description (Eric)
2. fix a corner case (where a skb can contribute no bytes if OOO happens)
   spotted by AI and Eric

V2
Link: https://lore.kernel.org/all/20260916124153.43457-1-kerneljasonxing@gmail.com/
1. add one sentence in commit log from Eric's reply
2. use the same semantic as tcp_add_backlog which is to sync the
   last skb (Eric)
---
 net/ipv4/tcp_input.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 92bc60716f33..f58954ddecee 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5834,6 +5834,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			break;
 
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
+		TCP_SKB_CB(nskb)->has_rxtstamp = false;
 		skb_copy_decrypted(nskb, skb);
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
@@ -5854,6 +5855,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 				if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
 					BUG();
 				TCP_SKB_CB(nskb)->end_seq += size;
+				if (TCP_SKB_CB(skb)->has_rxtstamp) {
+					TCP_SKB_CB(nskb)->has_rxtstamp = true;
+					nskb->tstamp = skb->tstamp;
+					skb_hwtstamps(nskb)->hwtstamp =
+						skb_hwtstamps(skb)->hwtstamp;
+				}
 				copy -= size;
 				start += size;
 			}
-- 
2.43.7

