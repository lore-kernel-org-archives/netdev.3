Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099284078FF
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236418; cv=none; b=P8DxmYwifhCp/qKBcRHsulu70TlnR7W5yeBCRJ/ontPI1lEHacxu81gd4Kk5xQA5+hHEPEWZ8Fm/sSKnV/ocbS/ko2DmdaQu5UhJp+OqUZihBKCCTpGhf4nnP8sMmZ9uPTdK9FMAMLtBK/2RQQQW4g5EfWcU8C8WZWMs8gpuXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236418; c=relaxed/simple;
	bh=hZ72QiBX9jr5EaifXwSBZkKDY7OHjW1ZuK993j0M4KI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Fhs5hwbQDShkI6M+WwD3Dj2vNWJS3yU+1uEt9lDRaMtZ82CgIi5eNkdeDcF2QXG5xtSMN/z/Qeu43wK8yhSqQyg1oxdN6+ctBXqwmgIlWvSnR+iL0HmRG2OS3LJNUzrXdTGXZFpCCdmj5pckcik4uOH6uaxEBm9ipasp+/FqIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaifengw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DS6qLBsK; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaifengw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DS6qLBsK"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso4391909eec.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791236416; x=1791841216; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tdubeg5f9M8doijKMCBDu9RikmQV/qCGF+3oJYA6B3A=;
        b=DS6qLBsK44y0c0q/ywZMvw1KaXkNzptjHeuvauTSUwPSwAXkkB+xPqcSdkauabnh3D
         8Alnrukeufrk8SnpANsr94mKRg3LUTLK+qbM8lUlp47whmL32E52Q+L3TqHrM5qMcVE4
         IpZuU6lmWuQfizwM/CGtmRMD20zfqo1ABY8Q+yskFR95cfliz+NSrReMV25YGdB98nPj
         gfCeqlnLOjrAYt5fm4yYOfDTBg1daD1cONxXrnBqbmsdy4MutlT7oYRughhoLtYpmrZU
         Ot8F4BqeQ0WpBlQBp1dTZHMcg3fR8exopOCWYRW2w5n1uZh1/AZhgIdP/yIxC7jzY9z/
         RqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791236416; x=1791841216;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tdubeg5f9M8doijKMCBDu9RikmQV/qCGF+3oJYA6B3A=;
        b=jMUKadYx/lKhDyvxLIxeMq+pHzOe379UYLv6tJt4NQ6qg3m6yZE+kSSObqGWp0LbXR
         132v17lza39NZ3dle2mal4NnAjjBJm/ExrrZaEm+C2mxXcyZGcMMBzHq2XKs8wg8oN/m
         YYwvKZFZP3zbHALEEz1goSrQvudblWg4P2JXrGWyq08uw7pV8NY+i8QsKiN26km9lr7R
         VfQaU0RRDiBSUO3ZNrFQOJY08Wc2cdS15A9ue4XNZQMTS0hceMM5ZmKQ+4mYYHMSzSek
         1ZDOUZR2/DnbOwpJQw6pmrhQk7y5jhVUuHciX/sAoig/f0uIXfAqT9xg6pBiS0vfVtlj
         Mhrw==
X-Gm-Message-State: AFuF++nAYFj4+0Eog1VAdvhnvQhO4Gz79JKSrW3/7/+tVkb319CffgJx
	NG+/BmeTcew4eafKczXRfh77dDz6OYPNiNUgrzw5y0oJj3yzwG1wiy1Tx3Gjleu31+yboBbXhfM
	HKYW1vUUA3EIIFj/sg6pTsjKXPGvlOEC9o+CrfqCTDYTo4J/8HTBoNKr4lX3vN0W+yXRwkrz+WK
	pE5RK4mup+c98KkFnZu7BJt/eypi5cWz1fOq9F4wt5lese7dk=
X-Received: from dycqw17-n2.prod.google.com ([2002:a05:7300:c011:20b0:33e:51c3:47b8])
 (user=kaifengw job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:41d4:20b0:341:c6ca:1df3 with SMTP id 5a478bee46e88-34f150bd707mr14349688eec.14.1791236415510;
 Mon, 05 Oct 2026 14:40:15 -0700 (PDT)
Date: Mon,  5 Oct 2026 21:40:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005214002.3226574-1-kaifengw@google.com>
Subject: [PATCH net] tcp: reject devmem tx with fastopen and repair
From: Kaifeng Wang <kaifengw@google.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	asml.silence@gmail.com, almasrymina@google.com, willemb@google.com, 
	kaiyuanz@google.com, sdf@fomichev.me, linux-kernel@vger.kernel.org, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_sendmsg_locked() enforces that devmem TX can only proceed if the
zero-copy path is active and a valid dmabuf binding exists. However,
subsequent branches in tcp_sendmsg_locked() can still intercept the
message before it reaches the devmem zero-copy loop:

1. TCP Fast Open (MSG_FASTOPEN or DEFER_CONNECT):
   If TCP_FASTOPEN_CONNECT is set, the socket may have a valid dst with
   NETIF_F_SG (so zc == MSG_ZEROCOPY and binding is present), but
   tcp_sendmsg_fastopen() -> tcp_send_syn_data() will use
   copy_page_from_iter() to byte-copy from the iterator. Since iov_base
   represents dma-buf offsets rather than user virtual addresses, this
   misinterprets offsets as user pointers and copies arbitrary user memory
   into the SYN packet.

2. TCP repair mode:
   If tp->repair is enabled with TCP_RECV_QUEUE, tcp_send_rcvq() similarly
   calls skb_copy_datagram_from_iter(), byte-copying from the iterator.

Neither path supports or makes sense for devmem transmission. Reject devmem
sends if Fast Open or repair mode is active.

This pre-existing issue was identified by Sashiko AI review on commit
125755776bc6 ("tcp: reject non zerocopy devmem tx") and has not been
hit in production.

Fixes: 125755776bc6 ("tcp: reject non zerocopy devmem tx")
Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Kaifeng Wang <kaifengw@google.com>
---
 net/ipv4/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 87ef6d5cbfeb..225e758c194a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1169,7 +1169,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			zc = MSG_SPLICE_PAGES;
 	}
 
-	if (!sockc_err && sockc.dmabuf_id && (zc != MSG_ZEROCOPY || !binding)) {
+	if (!sockc_err && sockc.dmabuf_id &&
+	    (zc != MSG_ZEROCOPY || !binding || tp->repair ||
+	     (flags & MSG_FASTOPEN) || inet_test_bit(DEFER_CONNECT, sk))) {
 		err = -EINVAL;
 		goto out_err;
 	}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

