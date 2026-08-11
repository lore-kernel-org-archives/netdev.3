Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077DB36C9D9
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478049; cv=none; b=MsxEQW4CTwLWLZk0Yg5+QayqZ2yR8/PVboodiWHF6CDT3yVNuGFc4a7LSX0inXEs8NywhBvNLDCI1b7RtVsSKmAPz81J3f2unZqb0kE5oCsAeQXQ3VuZnOzGcDpynlczeQQPNT0aXCgACW4MZ+bn0yrjufns1S8nIfFthRHOKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478049; c=relaxed/simple;
	bh=28XwPiTnc/bQviIDqY6ionfhJmC/QatzIK3B9Agw7WU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QVFwMmR7vTfHAVUNE0Mlgw3XR1EkcFaOi1XU+7wFtXjCtQPQYghbfDdnAOhjphJOCHujsAzxhNgS7Acwkb/XEJ5rck7tFBomXDr3BU9aAHB2/b5+9onyeuIdV4UP2zxMp9M61EdTTbg8YzZsaFfFgz0Ln/SFWmUSWvSRjcUqPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QmRxwjB9; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmRxwjB9"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc640dfde3so4340565ad.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786478047; x=1787082847; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FD4i/S8HEvVnfQ1viZFcuK4hcEaWLd5tD4+oJ4rJGX0=;
        b=QmRxwjB9MDBe5sgV7vNNkHouQzvT1E2yzsp8Feb/MTpVk9DM2/EHKcRWNexb8vuY2c
         G0Y9md9EjcfhlQBh5sgNsJEv+YKV4pOdYdxlKRBPYwqad7m6EBH34PPV475+G+/NZZNL
         OBoPsSa56VbRmo1KxI3+I35HuLF61KyPE9sup5sthpsgFoo/pxIdr1wpfGit94aLN8De
         KvOEjX6APOfXsfPHYSwXET96e7ZAFJsM27RRcxMbzarKdq1XAoL1jTcTMK9jL4mKKOYN
         2Dzv2vHRx1TELySCOD5jlZ8dupioA6VFgnxdDHhLnzhJVHzoufljD13Ccn8xmu99rOlf
         +/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478047; x=1787082847;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FD4i/S8HEvVnfQ1viZFcuK4hcEaWLd5tD4+oJ4rJGX0=;
        b=CqJow9UWCH8bJWK5bFAIyu4lF5dqStFPqvAr/YMyOwT5H49DNya1UuZPXPK8RPY6Ks
         OemAV5TT6QNFP9sAW1SzdR2uqItGcZacXckBtEyEMadcEzkVMBQcVxCCM34LdrOETqtu
         EPQ0yWA6plmbl5TXUPzRBHfBYxTsMfC+P12K4ciP9Mxvj4wkzCWIQfg5X+KNkOoeOHm/
         avulEoiH+fRszKbfDwdSLa8sNePM7DPB+lF3u9xKT3fbYlMZENOGYk0f3ca2NKRJF4tV
         R+uHAvibaXEvoaXr9S6lFTtmFwBZfgaeq3W5Eq3YbtX13DqlbTDBP6Y9KpII/od5kWDk
         nxdA==
X-Forwarded-Encrypted: i=1; AHgh+RqU/f9Bw+77iSzJ0MXQOEbKYDM8Jb9xdnl9asb27cgNoKBUIsQb3M6+geIOoJ6iqefYUZI9/OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwGnGrP37lTYjY4V6PGCZaqer6DUVXoqIJsMhXWdU3TFkA/WIt
	LRFsjERK8R4ewJW5HjZqB8CoU5wS8c8cOnrPDDVa2p/g2h/5a7kDDtY6JRnAocFxxyUHHhhSQok
	vnY/GHabq9D4ss07wMk6FwcCaPA==
X-Received: from dyjh11.prod.google.com ([2002:a05:7300:560b:b0:313:fb09:e2c0])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f0c:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2d3177e63eemr80682875ad.9.1786478046955;
 Tue, 11 Aug 2026 12:54:06 -0700 (PDT)
Date: Tue, 11 Aug 2026 19:53:39 +0000
In-Reply-To: <20260811195405.3979177-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811195405.3979177-1-almasrymina@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811195405.3979177-2-almasrymina@google.com>
Subject: [PATCH net v3 2/2] net: tcp: block standard payload injection into
 devmem skbs
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Mina Almasry <almasrymina@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dev@openvswitch.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"

Protect tcp_sendmsg_locked() from mistakenly appending non-zerocopy
page fragments to unreadable devmem skbs. Create a new segment instead.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
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
2.55.0.679.g6767b8d81c-goog

