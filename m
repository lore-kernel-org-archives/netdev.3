Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915532;
	b=zeF8RQaUbJBfNa3zTcZEqgIKTYuGmOSrFpJvoyyJoohM8ZMatkna0e1Dd54cmp6vRq/v
	 TyUmKrcMdMFym4VW0EThCMAEJMcNHEg8Jtt2ZeiSdYmaQlqaiV59vnBO0PA4xWNtm106l
	 VtG3YN/fMF/ztm9zVVmDXfeIuSDy9p8dhx4lvFFdFDIAtcOqtLbVWJwIIbQSkCKdOoccE
	 nn/+wcR5lQodPqzx1/WUriqMDY7lMRlTap10vU8GenxOKBAikwnsum/lsuN4d9NS72TMY
	 beeBP9si/GkM3ne6/n2tPJJY5FM6aIsrzTfHfAv9zC8eG3f5ReeHWvwljobiuyOsVJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=OTww/XSdqYiQIljQqsO26b/Gy2E9KYvjVroAIaVMNxI=;
	b=Rw2Klt7LzF5B1vX541YGuQDvh+Czn8UnJYjZqAbUDdiXp38/7XTTUlY/dBj707Ato9SN
	 qGTDxbU1s3yD21RXgqf/blDVXOJ/sZMa0aUnLlkjGx8WgpuaL4cQIYyEZnxvF6uthwCux
	 3xUxoUFd+Uhi5X52Nuw52MrxVBGBum2h5WXHJPeq1lRYvOjzjYbvqau4xmYU1KuKro0Uq
	 oe8bivi6vb3rTOQAJD1yX0hTvopY0/Zz00zP0zJBpEgQQuVdFhunwO3gtZvd1QlKkYWaF
	 Um5yekxwycj4poyHHzzI7BRRzuzgwob85VmW1j0lpUEpjprho2pp4+acr6JpK7YM8og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="qE/VDgGm";
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4850606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 21:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4850606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qE/VDgGm
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed08be1c84so35294855ad.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 13:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793915531; x=1794520331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OTww/XSdqYiQIljQqsO26b/Gy2E9KYvjVroAIaVMNxI=;
        b=qE/VDgGmKhKY/NvMoHVvkwKSShWxPjQz6OJnWNf9Xv7zdP6RXVyKOHoiEAShj9auiY
         jexkPfeuUBKiP63H41xgBoRwRR1tmZPJKe9C4OajtGpos5SfJUk2KU2KkJTvL9h+gGck
         JtOMMUtRJX2tJAio/MdT6MWWAPsV7GCAflSCI2ERZsRtzSl65VwfRkFjqt34H6fGITz2
         IJOaUO0W6zIiz8CrDDexyqNnEz6J4EvEKHYacHLPZL1JAeE20fadjdbIvNHh/C1CbeES
         3ikBMIGBS85wuzNGi47EdlG416K17aZEJGgvDWw0yCLxK7PPY298hplyrUR9F9HYF6JG
         jA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915531; x=1794520331;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OTww/XSdqYiQIljQqsO26b/Gy2E9KYvjVroAIaVMNxI=;
        b=kAPIxBMbqMOR4lqw+W6OzIcYPpusunZztHskG2eLKUIfj3VRuolbLb0QAnxWFc6k3Q
         w5jgJ8G9BrojpF+3KEmZRJCol4vZY4v0rU/GsXtgLYZwFykPO0+MoLwJiieu/moS5CFD
         hH3AmZLMSH9P5BWR9qkM6TdODfj/e3T0l8tyPdVQVEaLS3+77iozfS/UZN/UueXsULkf
         G/Lq8BdRYh0wy5CwqOij54n8ZyoNck7ctFBku5lqHLqkyhCARoZlongfcT1ngI/5WdaH
         GjiGLOB1ZKhVC+G3jxIuhNGOc/ck2rLxQ0MsqK/YxAR30TcfRS96WWr0deMX9whV+wmE
         lrkw==
X-Forwarded-Encrypted: i=1; AKwUvBzU0z0hCXnwUK3DU7rKVkD7K3qfVqTBLcVlsVqrvEYfGJf+XUY0KICOV5oi/jC0PDR7w7foVnQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Vmmck/eiankOvDP7cLekoyi9wt5BfdIu301ejuE8t55qbAxNy
	w6UOooaP1bjHUqifT9sOaHy0uwDOatAG2gijmLUvli85rIjZjqYl9fknbbC2qkW3G6/asKdgpSh
	EDuIgcg==
X-Received: from plbbh3.prod.google.com ([2002:a17:902:a983:b0:2ed:19c4:7ea7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3ba4:b0:2ed:ebc:460f
 with SMTP id d9443c01a7336-2ed40c559e3mr10550495ad.33.1793915530965; Thu, 05
 Nov 2026 13:52:10 -0800 (PST)
Date: Thu,  5 Nov 2026 21:51:44 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105215209.3160316-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/2] tcp/mptcp: Don't call tcp_update_recv_tstamps()
 if not needed.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When RX HWtstamp is enabled on NIC, skb_hwtstamps(skb)->hwtstamp
is set.  It is also set when one socket enables software timestamp.

Then, recvmsg() always calls tcp_recv_timestamp() even when
sockets do not need timestamp.

Since it is called after release_sock() and touches sk->sk_tsflags,
which shares the same cacheline with sk->sk_forward_alloc, it stalls:

   0.31 =E2=94=82 403:   test   %al,%al
   0.02 =E2=94=82      =E2=86=93 je     4a0
  12.40 =E2=94=82        test   $0x2,%bpl        ; if (cmsg_flags & TCP_CMS=
G_TS)
        =E2=94=82      =E2=86=93 je     48f
  11.59 =E2=94=82        mov    0x60(%r14),%r15  ; sock_flag(sk, SOCK_TSTAM=
P_NEW)
  12.25 =E2=94=82        mov    0x170(%r14),%ebx ; READ_ONCE(sk->sk_tsflags=
)
  20.70 =E2=94=82        mov    0xd0(%rsp),%rdi  ; if (tss->ts[0]) {
   0.39 =E2=94=82        test   %rdi,%rdi
        =E2=94=82      =E2=86=93 je     44c

Commit f0e70409b7eb ("net: avoid unconditionally touching
sk_tsflags on RX") introduced SOCK_TIMESTAMPING_ANY to avoid the
issue for UDP.

This series checks it to avoid touching sk->sk_tsflags unnecessarily.

With the change, tcp_rr -T 128 -F 10000 gains ~3% more throughput
on AMD EPYC 7B12 Zen 2 Rome (2 sockets, 256 vCPUs).


Changes:
  v2:
    * Patch 1
      * Mention software tstamp
      * s/sk_want_rx_tstamps/tcp_want_rx_tstamp_cmsg/ and
        moved to include/net/tcp.h
      * Use const in tcp_want_rx_tstamps()

  v1: https://lore.kernel.org/netdev/20261104165025.1026357-1-kuniyu@google=
.com/


Kuniyuki Iwashima (2):
  tcp: Don't call tcp_update_recv_tstamps() if not needed.
  mptcp: Don't call tcp_update_recv_tstamps() if not needed.

 include/net/tcp.h    |  7 +++++++
 net/ipv4/tcp.c       | 13 ++++++++++---
 net/mptcp/protocol.c |  3 ++-
 3 files changed, 19 insertions(+), 4 deletions(-)

--=20
2.56.0.455.g6c5a503b38-goog

