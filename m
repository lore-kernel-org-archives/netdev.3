Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095843;
	b=Xm7dudnxN84moHhZKhhT4xX1SjQKvutUPyA70VYOJcipfVdsmIRtloBLtzK9FgWP4tmb
	 pCf5jTZVRPDiRG06XFTUd8j4FxqHT7ZxaUER1D4vx5moxgjKdv7ozF+GpnR/KytrMuwyv
	 qWZArqmaU7faX+I1vZwuXbxPoFOeTROLSX5ZG5kBE0gOSXmuON7HbQsSdketZWOZ/HXnS
	 48RtdOrAkn+ZcKXYj2kU33A2FBjxHmHynySw+U6KZWu3oZ1oQnd4921ppEOQmTVUgSYrg
	 NYF4BeTkPr4TjL1m+nsWGBmbkhxzJD3hajEnK6TZq8oancur6bNrVvEjS39vKyCJ2zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=isuxB7ekklmgxlSi7H5wdnoasfh7JyHlhiJPgh4yZyk=;
	b=CjKEvDANXMmBeSQbETNkwNCBC+FXQh9b6jYniCQkzkwQJoKaYvujYhoCSJGLrSnziTQW
	 oh7c4YO+Bl31BMC3e5ApsjkLF1dWqKbZ/4qvd/fJB2rUNZiA304xUHBxvykKQyWuqzlfx
	 MnuBCtO+yAj0mEvXGAlYEi7GSZv15fwhnq/y31zJ33Ug6rXkeu40Rp2JnKDRtBapQcCvn
	 OAv28YrBksWdWxV8vVciMqp1R/ja5jk/BiboXE7BCs4MagFcIYrENEr6VVf2puDlH14Rn
	 AEYO1obDPql65G+5BcOuqRCHAwHdFMTD9RqpXBsFzZh2e4MMiGMpHuG+Pc+AEhStq5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WINwlAf2;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E319606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 23:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E319606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WINwlAf2
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e942b1cc86so586325ad.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 15:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794095842; x=1794700642; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=isuxB7ekklmgxlSi7H5wdnoasfh7JyHlhiJPgh4yZyk=;
        b=WINwlAf2o+F2X7PIAK6qawp/DoIoMmGCK+0+WvjrokvsmL+I52OyqXnaEMLvxinHnB
         nQqpKPJ3zCLOHstOtGM4BqU1g8ZoU5p02zGvRANwMAGdQRrNLtupVSLSQKsUMhw21GKj
         AeIg3W0NqGFhoRlIU36GKTYxIeqbFirTjkA2Cdvd/1srcuODjKcv6eO36ucWLYXH03Sk
         96JYlwOMsQQHdLYwmcqHICDvM+lgktaQhbMEhod8uBFnsa7HtEvFL1uj4YI4eLXnBjX1
         sBIpHnDGVGApTN8pLD41MO2IR3uSf55fa97j6aTInJvVhjtvLSdT0UZBtrKP/eP6HiLA
         CsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794095842; x=1794700642;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isuxB7ekklmgxlSi7H5wdnoasfh7JyHlhiJPgh4yZyk=;
        b=dIrucd/Fao66OldU21Xgtz/ckO45DYSffI8sf0zVbPejFmbNtEXODWpLhZGK4PemfI
         b1dFQbhRn0Ob8RE3IKf+AeI5dBEAqvcZQScTBqyRZQw3wRXb03FRv1SDIRxMoBT8kL5p
         1CfnfoJxsrTl/5GWTPkAR96gF1WjUnAsWIXPivpVzhqHt7F4WNve+sJpQrU5GgZih9US
         v278DqTUUAbCZuIf5PKH6DrQTGqQsnVxb0kUDIF4D5jEnuS8EZ+oPlQMl2CFfVJJxwEK
         umdcyYguji+CucCYVSG7VpsxekOrWoVd4a2MFNJMvq9pAs0vzsh/QmMtXl/gwwsjw+Nx
         Olrg==
X-Forwarded-Encrypted: i=1; AL+hErEdN09P4xLDZjj+sA7l8LSdXhSTTNfX8u/v8lnjP/+1zSIeVrpXElZpdrJ3N6mNp+R/d+JeNAk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+j4JDcClHVnhh/a6J9lgNPpm2NGaU7ekHvWtKAoVw8tbinH8gA
	lDtaEw3jVkxBBLaDLM9BAbGzNcnG0qTA6Dh3sAqVvxo6eDS2O0lvHRU5sAUAa+XGVeTRtnl+gnB
	YN2SJGw==
X-Received: from plbl21.prod.google.com ([2002:a17:902:eb15:b0:2ed:5534:d103])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54a:b0:2e4:a2ee:a4a3
 with SMTP id d9443c01a7336-2ed833c3408mr1560955ad.5.1794095842215; Sat, 07
 Nov 2026 15:57:22 -0800 (PST)
Date: Sat,  7 Nov 2026 23:56:07 +0000
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
Message-ID: <20261107235720.3129212-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/3] tcp: Small fixes for DEFER_CONNECT.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Chris Mason reported a bug that TFO client socket can accept
segments even before it sends SYN.

He provided a patch too, but it needed some adjustments (Patch 2).

Patch 1 is a prereq fix for Patch 2, and Patch 3 is packetdrill
test for the reported bug.


Chris Mason (1):
  tcp: Drop any segments if DEFER_CONNECT is set.

Kuniyuki Iwashima (2):
  tcp: Clear DEFER_CONNECT before tcp_connect() and in tcp_abort().
  selftest: packetdrill: Add test for DEFER_CONNECT.

 include/net/inet_common.h                     |  2 +-
 net/ipv4/af_inet.c                            | 10 +--
 net/ipv4/tcp.c                                |  9 ++-
 net/ipv4/tcp_input.c                          |  9 +++
 net/ipv4/tcp_ipv4.c                           |  2 +-
 net/ipv6/tcp_ipv6.c                           |  2 +-
 net/mptcp/protocol.c                          |  5 +-
 .../tcp_fastopen_client_defer-connect.pkt     | 61 +++++++++++++++++++
 8 files changed, 89 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_client_defer-connect.pkt

-- 
2.56.0.455.g6c5a503b38-goog

