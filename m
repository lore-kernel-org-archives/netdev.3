Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008373;
	b=yOpNjDJP3UJAqKu3+j+1a+5Amq4iTnrlE83RdI9uMXdKCKa5BWgG64bhoW+V+h+pk94l
	 6ZZ/a/oc6Q1zGyRnWfSlh3ZP5zFY1b2sQmClrkmIrUGCwsdJ5uKayI2iirKx3JYKk7odw
	 ZEtHrTe1xQu/FOWlewaug4WDXDuMTtKXh/6jDDH957B40P3sT7/UYzr2GvmyLvPOHVox2
	 2vtrKjPXbNN1XvxESKTu13864n13Cob0n1xZ5O4T0nkqo9Lr1mwrRsjj5YCyPQk/WpyZX
	 2ZqLYvVmYQxx2czAjQV6VnSqlVMRr/2nv8V/xXZNZ1PsIBrpo9T4qMhbuEp8hDto8rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ru2m+eMCX0FjLxa4pELR8RW+a5n6pURQSPpGAy5s8lE=;
	b=cSvXehaCPtMM96aXkP9OqgWF7ypwyJgs/phweL3GETsL9j3qArQwn2b0bOY9AASOZ/O5
	 BE9iqj+GQ+ueuJGOlFuCRGYyF0EiERTopoTocsU9zBxJiYup2P5PGSDdvo4/bupuvF/RD
	 PsB2pcHcO16AVnIZtkRY3Fi94Ks1SLDCh7/Yl856xglIE0bYPxmR6I7CoWTU5+Q5VAKzr
	 a0Uramt15RhH44ne3kFsZCIad8sU8DElys84z6PL3fqIeqnGA7hx13vNDRWswTtuJzqGG
	 jhM3DTaImduRHC6hWkOCJL/Oh0mOmSRfh92rLax8qWM0hdFUYPJvtGNtWp3A6aPmKiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fBRmqHQm;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488260A2608
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C488260A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fBRmqHQm
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1169925f8f.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008371; x=1793613171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ru2m+eMCX0FjLxa4pELR8RW+a5n6pURQSPpGAy5s8lE=;
        b=fBRmqHQm9FmItrZS3o26UQLzMWLRuYch9xsJch0E/yb8WZhp0HON4hBqgZUzN//CH1
         AuVCJZfNXn78BcjOf9z3dbEMffeVkvxz2kcscpeF2PyFVY0tbFPsCBtWfOOZ9B7YhXDG
         6mIiJW12tMUSc0GMixbFeCq13TGesCf3QQ8md5FXtlb62NPXCR4DmQfSDIINf6GYeaxM
         45OBZ7981GqFZEmYz5R0NOd2nU6gsY4Dkfbuv4DhyRYUQiBI2tTFVVo4C1fUDWQxmHnh
         0OFCDHVYVGYms1oiFkrCnIqpfPKCSLqAWoZmIK9H2mWLrzmaZR89fCMgZ38V6gzn3FhM
         YknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008371; x=1793613171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ru2m+eMCX0FjLxa4pELR8RW+a5n6pURQSPpGAy5s8lE=;
        b=HaFLVZec/cvFrrppDis3vg8OhTiPlzgYb1FqCqVqwBJQBYuXPscg3+8KtB54V7diaH
         1NPh2ff+FkCtVFzoH9ogJKjqzSYrkIchyWbaPskTpx3Hpoc+t3JGGerS9YHYO2L921yN
         3nw0x8B/F9MdOD7hLVUm6CoGvcJMJL1JSioyg1cSv0OKaHgro95WPcCC2PifqQEYIcPd
         M+NyfoXpyNZxUtuzoODpUqoRu4P+GXhYtMwzhVwLDNaKY2sYq5zdeNiFQ+FLBvya8UId
         glYdDrAfJ3I1qSUz4XodpO3hGXRvBWSO85jDUGcQbMYOhyqwdSHngi+EpSlS/XXYtsUn
         UW9Q==
X-Gm-Message-State: AFq9FYLHq1/SOAWeStGDfqLSgBqq+Notl6W6qLejTriDJnMZy/YszXWY
	UdsVtWNeZmw8V+s/Bmihwz4kAVgSDIuDWL6SzX6z2MDhlPgVxG0CNkbImkB1gDjh
X-Gm-Gg: AYBFou2U+AQ7+n8aQmTW3DBRtDAGkjUri4T04wmkH8rVhYFX9kC7KaNw4hRDpRs+imm
	JyLpPaxoSJLOE/KP+L7RBaBTcaNAPsnWH0XGE0YtEMrOEg3uVNI5PTj6qieZU96DJMEmno5Q2sp
	GvlHg7M1cRD+ryd00IFEPgyDg4buh3SfDCg39/QCXqX33cabgEohJeuwvxZS+ntAQDfl1H7/BoL
	md4Pxv2AZtCkcqGrfDy12iW7CrAyeB3L/aUIHdk3iDk/v0td2x3v+uBiSjpi2YRpaMmc4JEwdnM
	YiOAggM++JY5E6OIsbdxHSeGPjZhRRK2na76pmyfkO/a7sbySJso0W2yHbUwwe9RKl+kFIQB8A9
	9E5gfLlWy+ihWzSdkZjjTrowc1eENXz98k+98aabVfVCex6JZjoJeJkJqw/TBIxQ1q+N0sOipya
	xYxLpmaF4BQaT5k5EpbDTMLOXtwWXZOw+5oI/+c0GyrK11H1VHmjBtkRNEQHMqm+r5lQLlz7kce
	XcgL5x8IH3uym5y8I7rYgk5C8tgzOp1fQUnEk2KldzTrq8zPOe+W5OuEeOM9hoV3y7Pp0anT1ai
	X4xSOQXPptnIqTUzpgmXv1SCZ/TazKjStStRtGW4bJae+6q5Mac=
X-Received: by 2002:a05:6000:144c:b0:48e:4318:8854 with SMTP id ffacd0b85a97d-48e431888dbmr10254651f8f.20.1793008370716;
        Mon, 26 Oct 2026 02:52:50 -0700 (PDT)
Received: from zheweiy-mac.corp.tfbnw.net ([2620:10d:c092:500::5:7f66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e542ed998sm494513f8f.13.2026.10.26.02.52.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 02:52:50 -0700 (PDT)
From: Zhewei Yuan <yzwlhm@gmail.com>
To: netdev@vger.kernel.org
Cc: Zhewei Yuan <yzwlhm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] tcp: Fix fastreuse cache initialization on first bind
Date: Mon, 26 Oct 2026 09:52:07 +0000
Message-ID: <20261026095208.58504-1-yzwlhm@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_csk_update_fastreuse() initializes the reuse caches only when
tb->bhash2 is empty, but both inet_csk_get_port() and
__inet_inherit_port() link tb2 before calling it, so the first-bind
branch is never taken.

As a result, SO_REUSEADDR binds never get fastreuse=1 and keep
scanning existing owners, and SO_REUSEPORT starts in STRICT instead
of ANY.

Initialize the caches when tb2 is the only entry in tb->bhash2 and has
no owners. Timewait sockets are also linked on tb2->owners, so this is
equivalent to the old hlist_empty(&tb->owners) test.

Found by manual code inspection and confirmed with GDB. Binding 16000
SO_REUSEADDR sockets to one address/port in a KVM guest takes 4.18 s
before and 19.4 ms after this patch. Existing bind/reuse selftests
pass. Analysis and testing were assisted by an AI tool (Codex).

Fixes: 8002d44fe84d ("tcp: Check hlist_empty(&tb->bhash2) instead of hlist_empty(&tb->owners).")
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Zhewei Yuan <yzwlhm@gmail.com>
---
v2: drop the KUnit patch and the cover letter, shorten the changelog,
    add Eric's Reviewed-by.
Link to v1: https://lore.kernel.org/netdev/20261025090048.27870-2-yzwlhm@gmail.com/

 net/ipv4/inet_connection_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 8151c638a24..93b306d91b6 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -446,7 +446,8 @@ void inet_csk_update_fastreuse(const struct sock *sk,
 {
 	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;

-	if (hlist_empty(&tb->bhash2)) {
+	if (hlist_is_singular_node(&tb2->bhash_node, &tb->bhash2) &&
+	    hlist_empty(&tb2->owners)) {
 		tb->fastreuse = reuse;
 		if (sk->sk_reuseport) {
 			tb->fastreuseport = FASTREUSEPORT_ANY;

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
--
2.52.0

