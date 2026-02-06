Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656441B34B
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399283; cv=none; b=HCHgq4+QdLApYcSYdwtDQRr2aL31oU/gSmWqN+bkp34EF6fxN8nH2U3lpOl3MXvQbxneEJYqhDA0RxG9swQF8tHwyncmF1X3pCYYj6WWKx5C1sbarOhyogPZ7sV/xlAueQTwYCsxzEGA3kbO5TC7Nf553lYBzZOYynPpnJ85l5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399283; c=relaxed/simple;
	bh=HWNhCY6m2dWbkMbTLJPijBh81CFeOFWmHuazF/CpGsY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m9UPYhNtzUChzFVZN7LKbAO4wd4Bu9w5d6FRiCsLwbwvQ8QkM+3Q9jsVPjZa/836ogMrPlQnA10DamnDMXRRt9qLQkk7fAlB9SZYqcg271eN/LFOfhqRBECn25r0HnuRUEgUSgGJ68D88ih7uNt0Vx11auVJ/jZfQ/flplqVpCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6iFMx4Z; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6iFMx4Z"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8ca3ef536ddso804703085a.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770399282; x=1771004082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cyqC0omdUo48bSWfRkb+wefgLCctSvsUDsQURQCNp/M=;
        b=l6iFMx4Zqq0R/63lG89I846OLa63gbWK0dzpJmJ06Hg0T1e0m6g0A4R3nV0l4DZZV7
         Dj4SwD2gmmUCPRxEPPXgTvh/35Ro/s0abyOQ2AuhHIyq7o/mzJ6+mIIgUq9XI0fskWSs
         pDp7ngmjgEqXHbvMqb3Ugt7Jsd5G69j/qjVr4vy+o4ILtaSO/RNEb58D1cl1+PR0zVRP
         BEdG/zWKRTEju0fmOvcoFCrwqisjmeXYla+JHk4IHXnBnX21mMO2ZvVJTpfe6xavsNn/
         eRKK2dPykvY5y1K1szXxivZyxvIeJj38vug4+hRrzLnwy/suztmDgdMt7QQBSCKYzLF7
         b53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399282; x=1771004082;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyqC0omdUo48bSWfRkb+wefgLCctSvsUDsQURQCNp/M=;
        b=d8gUkzlJWSqno6ThiB5278xNL3g65wv0u/5MiDyej7RXbw6VdUQmnXR0L8Q2dAS3Bm
         W52H/wnJhPzdJ7o9oEkAFsxGxN+JSwXW5BTD0kJX6S2TPJAgBly5C/sgwiWDHh/CECmE
         VI+VYUsTXEwjAFB326b8N5gfzDP/GnY579pZ4GfQnrgLhPRs4+guodC1WYY6oiwr2fge
         m1xTXxWqp2Yso7Qn93rcbhtrfqckN6/NTMQqWtaEKyR6QkuCjFhgBhWfqbZc+odDpcmy
         G9PLgi0GTGkEPrZtHp21kssbQKlAm48srvJFWm4ugmDcdlwHeoV6x8nkIm+3dhaLVC3N
         v1FA==
X-Forwarded-Encrypted: i=1; AJvYcCUCGBHfG4uGZRfEPvxlbwFHHdhAxmkYrAxWh/fq96vVcUJ7L8dJURRqF3HgTjrSzCOf0T84Ebc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQ+4tH5lB+4R9ct1sQbuZFLwvt486SPx0QTkcTaCxaFU8tpH9
	38vNkMT1d4FqblLsPKNwkLyEHho/sFBXWD6af1f1ifQb8sJlv95xGubDIm9RqIzgtEwEUI/orQK
	gw6vrG1EQal5Zlg==
X-Received: from qkkf16.prod.google.com ([2002:a05:620a:15b0:b0:8bb:50ef:e76])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7085:b0:8ca:2cf9:819c with SMTP id af79cd13be357-8caef7e7112mr443736685a.40.1770399281862;
 Fri, 06 Feb 2026 09:34:41 -0800 (PST)
Date: Fri,  6 Feb 2026 17:34:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206173426.1638518-1-edumazet@google.com>
Subject: [PATCH net-next 0/7] ipv6: tcp: no longer rebuild fl6 at each transmit
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP v6 spends a good amount of time rebuilding a fresh fl6 at each
transmit in inet6_csk_xmit()/inet6_csk_route_socket().

TCP v4 caches the information in inet->cork.fl.u.ip4 instead.

This series changes TCP v6 to behave the same, saving cpu cycles
and reducing cache line misses and stack use.

Eric Dumazet (7):
  ipv6: add daddr/final storage in struct ipv6_pinfo
  ipv6: use np->final in inet6_sk_rebuild_header()
  ipv6: use inet->cork.fl.u.ip6 and np->final in
    ip6_datagram_dst_update()
  ipv6: inet6_csk_xmit() and inet6_csk_update_pmtu() use
    inet->cork.fl.u.ip6
  tcp: populate inet->cork.fl.u.ip6 in tcp_v6_connect()
  tcp: populate inet->cork.fl.u.ip6 in tcp_v6_syn_recv_sock()
  tcp: inet6_csk_xmit() optimization

 include/linux/ipv6.h                |  4 ++
 include/net/inet6_connection_sock.h |  4 +-
 net/ipv6/af_inet6.c                 |  4 +-
 net/ipv6/datagram.c                 | 21 +++++-----
 net/ipv6/inet6_connection_sock.c    | 57 +++++++++++++------------
 net/ipv6/tcp_ipv6.c                 | 64 ++++++++++++++---------------
 6 files changed, 82 insertions(+), 72 deletions(-)

-- 
2.53.0.rc2.204.g2597b5adb4-goog

