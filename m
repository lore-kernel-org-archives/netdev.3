Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664435;
	b=bKrtiGupCLji1H4ZeGWQlkw0SmTzFkq3ADkDZUCWjZF2SgRCEI6K40NtTr9LULsHMxQW
	 KNmbMgugzxgd6+nGLx+y1uSKQcpqwpVASEZb6o/cAiyMyGX6pTVRogfBzee3ouyADqciN
	 wMAHJMLsatCiChV7rz5qU9/HsrqfNr1X+mD1AFLLUC19A1eN7IGFf2fQOotpsSTqmUXYd
	 pDa9m5LE/PKAVooY6ItwRPmgpRMvQXEO/soPK8dw/F5Iv6ccaP29BmsunVhgrb5ESRBqU
	 mbaYQcBi7P3DAKSfUzz7VeKBj5wNNLxI4/0zfDDTyTqtCTPmvR06JGr61u+hCkJ8lwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Jpc1yBaUBad9Jxti8efnsx2LGU146MUenHkfKAf2OgE=;
	b=1UEVanhzMx1oW+Fc/lkNa/te7/9KJ3OPpB4fkom7PiJiOa8PVvGPpxoP28vFkqqdue8N
	 UK/5/GOhpn7/mx2sdXJWS1Jtwz7gyzCSU9+Vy6SVeIB2B89Y8RwL4ZPytJpbO9vCvU5lO
	 hwKhGx8GivK/EBCnC5F0dKbHIIdpvDcbqYhFXib1jO3hEJTDw2wPKuP/iutv6fJrqOMZ0
	 vMPlgVrFbh3n6OTJxj1CAhW24ZztNS04IfF0o/yBHVPFPC7nQLaOGqLp4hSMR6mK8kkYd
	 DQKTr6hNXOwXh3nZ3J58mc15LcV4YMgKYB/6Fh674k9y+DxDlfvv07iZbPnzVCFD7EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KgPAghLS;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A65B606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 00:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A65B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KgPAghLS
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdac99e77d0so1512000a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 16:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793664434; x=1794269234; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jpc1yBaUBad9Jxti8efnsx2LGU146MUenHkfKAf2OgE=;
        b=KgPAghLSudY3cHpuKbB/xQtMociOCNqxSUjD2d2RHbQGh9mVA+a5CXceZv+2cKPupE
         vTMHFrXnAnx3Hv8rSZ3Tc0IZYVOEDgu1rYwiLqkgWRCXHFwwm2aRd20zoATl2bCE+FYH
         tF1qgAG5b7lhnUarBcoZgF6joMRW4HJyJRq3uLtlxXsBMdtFDeJ4iIPbmnvWWtOk0c5f
         DbLQRq9ghsJi07I85ifpI9MD8umO4zf+9c3c4P9LyIaKGixOnKjPvHW4bhpUkrEXHKOv
         jG4gUt3+V/GoIpdfWQRw1wB65dbTBqvz3tyOmH/VR1rvCJYXKl6Vk8EMmC7RkPs9cgXs
         SjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664434; x=1794269234;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jpc1yBaUBad9Jxti8efnsx2LGU146MUenHkfKAf2OgE=;
        b=M1F95ijB7A6NbIfOfllu19tN6kapnf3MyiU6zRCkWyu4UtcdzUNJXidzg0oOw6mx1E
         2tHNzAM762B3ec3x1miKP6RpMx7iUIBmMIbY5sEBzRFQ8n4IzgZB2fEUSNn/SErK8yd8
         LuKDJMKnO5dcBih8XBBfuairaWr/sh8fhHOZlxs97C0piCP06zfSjxGVynQgMKecU+V4
         9soy4xKbC/BDmN29yNGosYL1s6O+K11Qur2JjkgoQt4cnLTwxz0mvXLKtoLTGwHsQu2l
         53HFNfDi9bISafRA05fw2H1R1D9lHS6vW7Z/HXlSWcRzv8InvkHHReBojEYiXTT56Jek
         4kzw==
X-Forwarded-Encrypted: i=1; AKwUvBwGUbzTy6CwVsZ2UTvuOPNssnNn3/WiWhRz97DoknD2p9Y/e5/zxm/KOOXPgquZtY1F6D4DoSM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9GWfsaBpCNb0Bb3Xf8iP82K29cBtJ0qK/xS7IupaEqaaM6FOm
	l7lf6ZcE4WTV92M7wzLnvlqqbc6xrle9nXBIp/ZP6LaiXzK7iSLCbUR8Q0VmSnHBhLem80jPXzi
	WT8XOQQ==
X-Received: from pjwo8.prod.google.com ([2002:a17:90a:d248:b0:3ac:16a7:52de])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a45:b0:3a4:e735:b39d
 with SMTP id 98e67ed59e1d1-3ae897d28eemr8698750a91.64.1793664434362; Mon, 02
 Nov 2026 16:07:14 -0800 (PST)
Date: Tue,  3 Nov 2026 00:06:01 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103000712.658501-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/2] tcp: Let non-PSP and PSP share mtu and advmss.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Thaison Phan <thaisonphan@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since psp_sk_overhead() is added to icsk->icsk_ext_hdr_len,
which is subtracted after clamping in __tcp_mtu_to_mss(),
it is impossible to configure a route that both PSP and
non-PSP achieve 4K MSS for TCP_ZEROCOPY_RECEIVE.

  mtu 4220 advmss 4108
  -> non-PSP gets 4K MSS, but PSP gets 4056, breaking
     TCP_ZEROCOPY_RECEIVE

  mtu 4220 advmss 4148
  -> PSP gets 4K MSS, but non-PSP gets 4136, spilling over
     4K and also breaking TCP_ZEROCOPY_RECEIVE

This series subtracts the PSP overhead before clamping to
let both flows share the same mtu and advmss to get 4K MSS.

Google's original PSP implementation has been doing that for
years to allow both flows to coexist on the same machine.


Kuniyuki Iwashima (2):
  psp: Check pas->tx.spi in psp_sk_overhead().
  tcp: Subtract psp_sk_overhead() in __tcp_mtu_to_mss() and
    tcp_mss_to_mtu().

 include/net/psp/functions.h |  4 ++--
 net/ipv4/tcp_output.c       | 14 +++++++++-----
 net/ipv6/ipv6_sockglue.c    |  2 --
 net/psp/psp_sock.c          |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.56.0.385.gac671c819a-goog

