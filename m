Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BB41D13C
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777293; cv=none; b=RW8S4jelHPGJwt6hnOlM5zHM1obiQJBayJ7rpoycOrbyuRHQH0nL7m0EbrY49E7uK1Gn3nIu8/x9+wS0up8d4Gr2etdjiCr4qjQ02hK3r8xbmrLYQFoyvgVVeZx15LGI8BU6vo1xGswy99vvAN2v8PcYkYo85iXmYTuOeVbJWrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777293; c=relaxed/simple;
	bh=xCtLQfO7i3h7hjuYOa571cRGsYCQ9xhqqG2TcoRt2cY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XQWm9+qBuqZVtnCR74yisMs/ljkjQHTZOr3pqiyH2S3wB5lFImHTbGcErxSt39np8aaJkU+3JfSb0iAsW/3A74rteBpXbme00dEaUWAn+y80A5XaoeMQWOCsWz654uCP5aEECJ8NbSYCAPNkn6sdkzXO/k10b7IMviLr7fXtaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRMc8T66; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRMc8T66"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so6374198a91.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785777291; x=1786382091; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4qOTDVzwbER9fL0vi9nKhS6LeuDpek4gYREIpOukIEM=;
        b=FRMc8T66wFuzZIv9KY1RTOh/qGMDUjRHGZH+2ssfiHxNGVU5xeV56xGinFhUKdg5B8
         8k50AROozeEf54o4V59jUgYZgCwSNs2GtcOUKBs9IEU6Ed/8L5+kiLSWH3DXKhH366bO
         5+KlOfd5j2e2Tfz8T2Yx2NxqiB1ZSJFGWrA4aaw4CSZ4F9ZgvF2vEvgT81q5y1PB//e+
         PAoTxzv+tKi54khJBReUKDqUIcFpwnB6uPMOcJ3WirSv9j5qP7Z1UqluIyO+Xs0wskmw
         sAAbtqLtKXflAcl07n6fyPd8cs5TvOr2wJCoxb4twSllrRcYmcHWQajGvXK7gmEChqMT
         7iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777291; x=1786382091;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qOTDVzwbER9fL0vi9nKhS6LeuDpek4gYREIpOukIEM=;
        b=JjSnnXuvY4j5uNdYG9+0MsRT3uCwvXeNhnCt2ObEZIxcfYlva0UkLcxnK6uF689yq+
         tBXdPV1jZzuswP6ddqTnQ9jqYfDkQ+1NAfA1HAfiKi0EeCzpspEYKyWBzH8FGTBvNm0P
         jTN0DOHExwGmIeGrn8w6/JgTYLU+W668sOX0spZk14rgWmf8W4dAfcmn+INI3/At1J2Q
         w/o9V5Z6QUb2l5X7DTgQyMo7NewjIJiELGsdTZp5wFTr4tp4QdVBtyGT5T8KhOJhHQD/
         zezWffL8m7AumXuhMZa8umCWUMEwgST7mJpO5I95IJxJOqENuaV+0NAQxCxdTnH6uy3p
         OYqA==
X-Gm-Message-State: AOJu0YyRh2L8l1/SKvr2fTsxR4xpVccJ5wCX3r10i0ioQ0bbz/Xdqx5f
	qTnOuqjGoB4MMD0/nLLDMJ8pXgumlg1yZjwZqSxYVHiYcbU/hI40XEjunwlwfMV6SuuctpzgJcB
	TGXtc6eLo+s3TIAnMyj0SJG/ShALnuEOMt2Z79mNo4Xj3zrKN1QjHyItsiNCVjoZ7+7T60n7OO5
	I6YlVnZQ7R+yGnYmPXViLVvmPChesCGagMFAVUdyDtOmsPQ8G93QpFTLasbVpBiJk=
X-Received: from dycqb8.prod.google.com ([2002:a05:7300:fe88:b0:314:7bf0:c459])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:590b:b0:38e:8896:4024 with SMTP id 98e67ed59e1d1-38fbc56c5d8mr10214568a91.40.1785777291008;
 Mon, 03 Aug 2026 10:14:51 -0700 (PDT)
Date: Mon,  3 Aug 2026 17:14:41 +0000
In-Reply-To: <20260803171441.408014-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803171441.408014-1-almasrymina@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803171441.408014-3-almasrymina@google.com>
Subject: [PATCH net v2 3/3] net: tcp: block standard payload injection into
 devmem skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com, 
	kuniyu@google.com, bjorn@kernel.org, jiayuan.chen@linux.dev, 
	kaiyuanz@google.com, willemb@google.com, asml.silence@gmail.com, 
	sdf@fomichev.me, bobbyeshleman@gmail.com, fw@strlen.de, 
	Mina Almasry <almasrymina@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Ralf Lici <ralf@mandelbit.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Protect tcp_sendmsg_locked() from mistakenly appending non-zerocopy
page fragments to unreadable devmem skbs. Create a new segment instead.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/ipv4/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b6949..186a36c698798 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1278,6 +1278,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (copy > msg_data_left(msg))
 			copy = msg_data_left(msg);
 
+		if (zc != MSG_ZEROCOPY && unlikely(!skb_frags_readable(skb))) {
+			tcp_mark_push(tp, skb);
+			goto new_segment;
+		}
+
 		if (zc == 0) {
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
-- 
2.55.0.571.g244d577d93-goog

