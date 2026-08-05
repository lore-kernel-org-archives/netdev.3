Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6FE46D2DC
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934671; cv=none; b=Wvcjp8MrrBgYpC7t99JKg1C//+dlRcPBH61t7MbD5UXATROiN0d4gQO/C3orOJWqaERN1cg9C4wdb6Stp3ISmE2GZiibNeE8/9wlILbNF+UB+Eljg3Wkpmq3QzkFK/TLsOEhw85ZYdIaAa6qEjg+NbKE3wbU1S0Pqz/+t9k0JBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934671; c=relaxed/simple;
	bh=C0712y9v+3Cnwu+fzKHEe+5eb6C88dqmH0oQugUbpT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnS0blAThytSHYykjR+gxVgak/Q6RIlVQoj+i1jE6KEcEnKlpmXj+/c+3BK9vucPr6EyJni3YqqAhXgjGvxBbGz773e6d+h3q0d1SCZQoygvxOJGozb9RKeEYW9JRamJR4C4cXIXMT6itlZmZ8a5blmGI40dL5fUe9pBfqd5l9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6o/DhpC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6o/DhpC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d027b7c8easo2080645ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934670; x=1786539470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=88i/kpHkeSfRDq0C8BDJPfVUyr9cy+9c455SwktNUuY=;
        b=D6o/DhpCa7F3Gf6lMk3xz0cyN/lpPnM6qVwCAybzNxlXzAcRxVUrAu3AdmkUeVJFKJ
         8/E4AKQPZlrBEMRZMug1q5oakvsabD5gTDxPlf/wblvuvqtn8GwRjFOLCKA7pqktQary
         ZVY4kE+Kc7HvGLCIppIuR8yxktLCwtllTB49aWzaX0emgt+fzQKUQcuC80OGJre0gLUG
         uOSt1E0ODR/cV6RnMy4RqB+rHAqlwPxB1Om9MfrxBw/FDu1JozixPpRpDc4Ml7NkC1Jt
         5UiXSHynkAEIE2/yjIiD2UGxUvxo+OUsBRcemKTdCkiPViMRXESmCdBHC0M3Mw5B2wb7
         LXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934670; x=1786539470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88i/kpHkeSfRDq0C8BDJPfVUyr9cy+9c455SwktNUuY=;
        b=YWVKR3ev2+2UwEnYm3YcjFw1qrgOaOvruNBzTdFldwt5k8PyuvbDkj516p/RscnzTN
         xKHPHGGviiaw2MZpNWwfxtAuBuqOdy4EIfmdqzOK3z1CaMyl2C+TWLwfaeo2G9JMAKcY
         gnJefjV1tO0jG57Cn7qZGXAPDjaScWb7fjZIyD/NLeOYYfyn7ml7CO3qh9IOlyIA8U0m
         zWR3WJLPARKYlxQl+kIdD6zCVIacMi8NX+285TtmH9iPRQSXLIRv0NjH8qK5oEoYg5do
         gafLr5zj3cuc8uFmdY/KhPpYq2UwoDqhbeL5MFqwlc/BrJbOJ0pWVdLkNmfV/8RyJfxs
         J0oQ==
X-Gm-Message-State: AOJu0Yw18HFpiNuFWl5mKby5jI2L+3vwJeFvWTSc7oJvUi3yHDFTMtFJ
	tJMqlXzKoGB2Km/IuK4YbUIYLhBc1FQsNzr1IaVb1JNwF5ZlXAqrux6QXuoYW/2dJwY=
X-Gm-Gg: AR+sD11PYmGCE+6ogZxDESPvmRiZTLsxza7xMFuFyRzg3r2db6fnQm0TcSEw6e0v9XZ
	f3+vejO36gELG9VSDdxGIgyoMJ6Rd4bjRpGm2ze1ZWbPg5hxP+En9rHdoO2W5EFmCZuv1xWujHj
	eHbxlUVZ6jjLcQGNM5RNCPubM90ACLCiXKrdglwJc7UH6C2qzot8vjRx2UWfiWqga4M6sqF35Vz
	vQg5YrVRbZmMBeWHAvZa9RTDEFj33YS40woP7VRQiPfHqbQjVo4voTPOq9TN8WbSHGjrE6UPbpM
	9M59Err4tNJUM64X5+Dn93mvtEzrQUmCEzTxvXTzZ5N+l+BtnbKW79K9j08QyDI2enlUVjIHBOq
	tDREw4JhPx+pp7nzThDq/r4heeghJyXAPl+3pnrLxGgbcwXyBDH58qeh7bahA/guSHguw5RoiR7
	9l6ZwyVCC4Qqzlp/P+bXmptj8jxabSkYPZb1qHdWsx24D5dcQEOa3/XksSb2G9+FeIOXQ5QpLSH
	9LehY72zSwd555w/pjoVwfY0IgePcOzFwT1XhC0WzuoO0+GLb0=
X-Received: by 2002:a17:903:2f8f:b0:2ca:d803:5c8f with SMTP id d9443c01a7336-2d0ca73a210mr51760455ad.1.1785934665055;
        Wed, 05 Aug 2026 05:57:45 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f8fb4bsm16514625ad.5.2026.08.05.05.57.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 05:57:44 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v6 0/3] net: fix hard_header_len races in packet send paths
Date: Wed,  5 Aug 2026 20:57:26 +0800
Message-ID: <20260805125729.19220-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

The packet socket TX paths read dev->hard_header_len independently for
skb allocation and header construction. Concurrent netdevice
reconfiguration (e.g. bonding device type changes) can change this value
in between, leading to mismatched headroom and copy length, and in the
SOCK_RAW case to out-of-bounds writes.

Patch 1 removes the CAP_SYS_RAWIO zero-padding branch in
dev_validate_header(). That branch sizes a memset against the live
dev->hard_header_len while operating on an skb whose headroom was
allocated from an earlier hard_header_len read, so a concurrent increase
can write past the reserved buffer. Removing it first keeps the later
snapshot fixes bisect-safe: they do not replace an earlier skb_under_panic
with a silent overwrite.

Patches 2 and 3 snapshot hard_header_len once per send and use it
consistently for allocation and construction, in the non-ring and TX_RING
paths respectively. The separate SOCK_DGRAM consistency problem between
hard_header_len and header_ops->create remains out of scope, as noted in
the commit messages.

v5 -> v6:
- Fix Signed-off-by to use full name (DCO).
- Add patch 1: remove CAP_SYS_RAWIO zero-padding in dev_validate_header,
  before the snapshot fixes for per-commit safety. Suggested by Willem de
  Bruijn.
- Add Reviewed-by from Willem de Bruijn to the TX_RING patch (given on v5).

v5: https://lore.kernel.org/netdev/20260730082925.93759-1-q.h.hack.winter@gmail.com/

Qihang Tang (3):
  net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h | 11 ++++------
 net/packet/af_packet.c    | 45 +++++++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.50.1 (Apple Git-155)
