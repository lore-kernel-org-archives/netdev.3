Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9E35E1C5
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969707; cv=none; b=hjbt6C74WGNBjsOROV+7iodRs6lU7UpqbwFGXnbmKnAl9W2RKj/bjpljienlYNaB79N0+7YhRuGuDLjsI8JovsEIOjUdp9QlknNOBLPZ2DyIWszgWJITrAsiwyZWrnYTg65XBnEtbFe04EhHvnkeDPa0c1RPviUUgmH0eKIxmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969707; c=relaxed/simple;
	bh=8xMxHrMZKCLWCGtEEIoMvriov/njsTTmxt2LdeiMaus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtF49QCrqsLcickXzhEE65t92QiWkBlQslczeBvBhoieEpxeH7BNi8PRmKChDotN8aN4Yf5Z0E/PARdHozsxMYj6O7wtBCAdT2OU5Yco1/chQYyf2nlOlDAqFUlixYh8jnMVbMHhzohLzidsepzjCUSGIn0LMew7HLt/GNfONSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDT/XQ1l; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDT/XQ1l"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so2253977a91.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789969706; x=1790574506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtXVDzTY65CAD90qKovN60KJ+n6IiEH3Afd2IJ+KCWA=;
        b=TDT/XQ1lb0FF0Y08AP9AVy6AFcnOfHQIubQinRsgQdDZove8/2McJbXs6PnzK0NpPe
         g/s8z7IrvuNVYpHjuol1qX/1xrC/vfRWwzq2SXXH7gnfN4Cs1aoCHzPVBXotIYIkVMfo
         aXYbcFBzxFDPED3j/JSywl590SCu8MRgcdjHElL2vJpWhJ++qfbzexpRsnS3EQm5DMh5
         sMlgE2MhtiwxvBqjdJInJlN1uG5TaA1gGCFPCmoN+2C3rjnIRYu44ZofJwkh2iEIv6td
         4j/KA6uRFJ12g9mt6waezdAbjAhSiTmEZS0G2MizFEBEalfJ2B0k6fg0qmzX19JTTox1
         Ws/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789969706; x=1790574506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtXVDzTY65CAD90qKovN60KJ+n6IiEH3Afd2IJ+KCWA=;
        b=RDKoRAlpLlNUEdCGjNeMNW2Bx2E0fb59r8BSMBL155VCqNYKR1Ui2g8zelH/EPHsHL
         yAQzxZV+a/3asE0Z9YgECxDwRuqWBV7euYPPxLLbW1IFuKJaK8E1KZCpk2yNc4c/SAjo
         oclZCzuBPTnS4XydaSzt5tIFqz6fCGwzBcjseH5nwV/BujDRWWA5YA3E4XqUKlcXFDcD
         giwEdolP3mXYfCiXB1ePZfT4Y+lWes9ttt02cOLoB0xoR3DFltsRZrbrQltlMs6hqMEZ
         xInYsm7SHi+RAvVEYa5SBYbgaDTADINBzWbTQIDrDFsE2vdbVkEAyXx7KER/B5d+roz7
         R2nQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuud+LGjSfk7QM5jZNzJhtgANWND6mKJATlcH94o4e9kFF0QZm+MtMXZtqUw0RLv2z5dM/dnI=@vger.kernel.org
X-Gm-Message-State: AFuF++myz5DIkX6TsMdsyjAZJgro/m/8y9UgwO8EaVpnsWv+lRlhMEEL
	NDdGH9uLNPkgDIWA5/FzNzkNt4f/nUa1Dud37R32EAk+L4uvF6wq3JEOATppm0t3
X-Gm-Gg: AYBFou2V6erooyW94uVRkp/iR7yrKyuwxdsPYJ8fHFspsNS8jmRHtalnBfjJtzXBlvn
	bjJDdSdTQ5pcla76uo2gX23KIx3AEp84zOGEE/eQ6P71mKBt0WFaNGLib1ssZZkTBvtFQjZUg7g
	qW4Lzm2+e9TZKz0xSJzcQAQAllZfFxYFhE06Km2FjWYKr9EV3BmQ1r0qYXD96EzES+I0KudMbGU
	alVyT0Agi0zmkSOHapOOlDLXc8WPqqf8yWcGM3sY5E/njipL+iSiG9n/4nNpAplq4FOasA8DN7S
	KZz3xngznhOEHve3IKY4oF9hqkbMVvuEho8hcE1+WAoES9fgQTTf5mTpOqjaSrKBollSg3dxuai
	EWdtqADLKsRZciCd6BO0t+5MgS3HSxEDKSIg2KIvtbn+8GJS9/3182wAv1KUH4b0hUtAMTqLPFJ
	Ia18xskUa2dBykzqD2ZU9EVkDj3BjMsfrNFGdKaSoL/SrwOQLcenGo5mhJHMYbTFQdeScP/XA9V
	uyXniaEb7xv/4xDPiNIfOy7dQSork20eFi78timsf7O2Jkm0QmHKjsXXbKjO3MYb8QxTDr3Bk7q
	bqCEo8hYXg==
X-Received: by 2002:a17:90b:384d:b0:39e:6c6a:4b67 with SMTP id 98e67ed59e1d1-39e6c6a5448mr8150645a91.49.1789969705649;
        Sun, 20 Sep 2026 22:48:25 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb372b7sm12640514a91.15.2026.09.20.22.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:48:25 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	willemb@google.com,
	mhal@rbox.co,
	jakub@cloudflare.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	benquike@gmail.com
Subject: [PATCH net v2 2/2] af_unix: skip consumed OOB skb and pull consumed bytes in unix_stream_read_skb()
Date: Mon, 21 Sep 2026 05:48:23 +0000
Message-ID: <20260921054823.1822122-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921054823.1822122-1-benquike@gmail.com>
References: <CAAVpQUARH-vecUojrXJWHp_C_rCpyxkB-HMBhryfxB-S76BAiw@mail.gmail.com>
 <20260921054823.1822122-1-benquike@gmail.com>
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
2.49.0
