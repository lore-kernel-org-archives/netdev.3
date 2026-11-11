Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408664;
	b=UbvyN9/CjmTUyzXk86Vt0GZ8Eiix9CcwmsNLSeGyn14M4P8DrWO1yv2IkDpMUMTONe46
	 nMCOrK7KIfDv89GzTSWL7qlLS92r8ayA2Jz4m9jY4o6Mcq5RyrgBG9xooPFvrs4VRE5r7
	 jKbRsfymsM0WflcZvro0dNa5B6geL8Crvup1tt0Pps7Dg49D0yqdNDJ2bw2LWUWa6EFIf
	 2RVhLIPTFpMuWMVnho/Z/tWzLSJaZPkLgGfYD1X+a8HkGThJQodF+JprfjUR7oq/8FmUM
	 alJqrgL6fpmg/LQQ3I7KrDHBSTNn6hOaBNZsjjYFTsiFd8RE1SbSPxT4kNJwQX7cDZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6WfCGz4ZjPmddG0dbi6Us4o9/q38fFN+mJXbhqZsP/I=;
	b=R/nYyjCSFwuct8RqXsz99fTniFVVDZIwVy0iNOZbfdomNIKOMaYd7f/DEW6ISWhTcCOi
	 n80+N3CDzX+wz8I1jT2Nz1BjeCcorM8LlpomlMKnkANbUNRO14iNX/oFLpSkN+mF/sxLi
	 TjHrcbKHk73xmPKS5x9m+siM6e5EVEKDYYxqaAIHnEPSEEm+BZWLCinQ73Py7og7rMTtI
	 0tkcc7RbkxsuMQm82r1wCk9LuZQAJ7zUy3FlLsPfIeWGdbcuyLTdhC+Hn4D7I7fPROhlV
	 m9PAcoQWnf1JyLKEt+BBmhj5abkxZNJDfr/b9b/JEEe3U4e00uqyRI87BWTG61zWO+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFo3Cmz1;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191B606A8A2
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1191B606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFo3Cmz1
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so3265392eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408663; x=1795013463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6WfCGz4ZjPmddG0dbi6Us4o9/q38fFN+mJXbhqZsP/I=;
        b=rFo3Cmz13G8lkK2BxA9LdDLJ32eb73Ah96Ugi3iVX2wy2UNzsz9vuTqTzUpfTR1w2h
         uNZOFdBEgt5nWqaPvTU3L4ZH0s7a/QVy1ecFeTx6rXaFNpf3FhxGXN0D0f7tuy7TA1Hi
         988lhLO08auSF5u6MjfG+NwWCROuilObQpFBBTYwAohQz10tHgwCtfEzzJN1IsgT6R2G
         Rjc4fsat6fv2RO6ZQaoma1aiPkUdNEHxRMlWhT4jNXLt90N7rTFHBPHlUE5RtMP1+Y1A
         DAx94KUVSjCZ4ZwB2qhaGEqQacBceVvyj70WQ+fshDg4LfYieKAWmnP+VtY6Wan08mRH
         mQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408663; x=1795013463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6WfCGz4ZjPmddG0dbi6Us4o9/q38fFN+mJXbhqZsP/I=;
        b=lWDh0jyKvbyHyTAxcMJhDBgsyPmngNt1L1oPsuMsg7vzv0aCmGZiq16GAT6QtR9YZK
         BFanBWmXLs5UUn7OXLQ2PLXMsNihCJknFagRh6ZfviQ/4I5RmcFiFYfj/o1lsYneaURm
         vrNhYsKQ7v2l/ap1MaTVhuLs3cZGA/O6j8EylAr/zeKOsUoeLjRaLuf8Fkr3Ri+15RIH
         DEwUxr8LClZBRvuNTJojcU2qo6oEJYEavTJeJBImKcXrTMbhul7aaVj5F62Qzged94sv
         9nq4dG6Vr97nBLMrqKHOwLXDqKyvBKR5Hrt/qUqrFEevrE9/D6iG25TsdbvTsokE76im
         t1eQ==
X-Forwarded-Encrypted: i=1; AL+hErF0tqRB0CLQtJflmK4MFbSDsfT4XpLMhhljKjniZFf9u2kkzEAQIGwflWGbOgiXVtjf5ZMUWUc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FDiH4JxSVwHvfaSheZJUw9IAOi4hdAlmmvCGG5PrbBjnawEV5
	0LMxT+tQts6/bueDkWdtGKkmnt78o2DbSPy4YsNO6czI3t1146h9Pfj3
X-Gm-Gg: AYBFou3P+0ZKuhgviM+2chMhcPAfg6ZcoDdeJhEC4wlZlih+LJPJ8G7E71EeQydvlvn
	nZrBZnVQliit2GBmRpf/S48rFOOlwOSZ+yxZi48KjUwvaglQcM4v0XeulaMjNjv2wA2rRVixpTI
	73ZOUUWXIoY0AbWJ/s3KIV65BKhwz2vc+yu2z5sZePB2uU7N9kMwCmCLMXOl+y5xyGxkh/0UQnq
	rS2c/8RIU6vBE9aarEw60ecwpuo5f3//dl10LCFf/R5lllme3LNSoJ+/XDL8sEVMEvl9iVW46hB
	53tG5V5379I7sQ/3XORlOJeTBnf5SHXg0Vc13FghLvGZ03pc/VOU7d7ryCkCbdDvId0f/iPgnSE
	9YXX5GlXptzHri8wWjfQf0rfzGiHJcF3EFyradXNDZZm8aWDmO+twVZRQr1tojy8r2c9oTLPXVO
	lGoI6k46N+syQKR3gW01QM103KtZT2qcntf0qy5AW2aS7KuLn1l6UY0AgUe1KihIHaW7TB3kMyl
	9FAszPYLQ7Kcd0LkojwiAqahvky/24rdTF6cmFeiq7X/QASsn9XmMgcSSgCvSuymfX201OKz0uz
	27Rhj9AAxpMc9UEGcKIWfO0V/TibGrBMKIW1kLN6I6kp0Q==
X-Received: by 2002:a05:7301:490a:b0:377:1ad4:193f with SMTP id 5a478bee46e88-3771ad41a6bmr1288341eec.12.1794408662831;
        Wed, 11 Nov 2026 06:51:02 -0800 (PST)
Received: from spidy ([110.227.61.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ff2ab59sm17067180eec.6.2026.11.11.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:51:02 -0800 (PST)
From: Gowtham S Bhushan <gowtham398gs@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	syzbot+0cd6f4783442ac67b56d@syzkaller.appspotmail.com
Cc: Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Gowtham S Bhushan <gowtham398gs@gmail.com>
Subject: [PATCH] rxrpc: Fix slab-out-of-bounds write in rxrpc_send_ACK() during PMTUD probing
Date: Wed, 11 Nov 2026 20:18:46 +0530
Message-ID: <20261111144846.838278-1-gowtham398gs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When rxrpc initializes Path MTU Discovery (PMTUD) parameters for a peer,
it computes the usable payload size as peer->if_mtu - peer->hdrsize. If
an interface has an MTU smaller than the transport header size (such as a
virtual interface configured with MTU 0), this unsigned subtraction
underflows to a value near UINT_MAX.

As a result, peer->pmtud_bad and peer->pmtud_trial become excessively
large. When rxrpc_send_ACK() builds a padded RXRPC_ACK_PING packet for
PMTUD probing, it appends PAGE_SIZE zero-page entries to call->local->kvec
inside a loop until len reaches probe_mtu. Because nr_kv is not checked
against the fixed 47-element capacity of call->local->kvec, nr_kv advances
past index 46 and triggers a KASAN slab-out-of-bounds write past the
1584-byte struct rxrpc_local object in the kmalloc-2k cache.

Fix this by guarding the subtraction against unsigned underflow when
peer->if_mtu <= peer->hdrsize, clamping pmtud_good, pmtud_bad, and
pmtud_trial to the usable payload limit, and only enabling pmtud_pending
when the link supports more than the minimum floor.
Additionally, ensure the padding loop in rxrpc_send_ACK() checks
nr_kv < ARRAY_SIZE(call->local->kvec) before writing to the array.

Reported-by: syzbot+0cd6f4783442ac67b56d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0cd6f4783442ac67b56d
Fixes: eeaedc5449d9 ("rxrpc: Implement path-MTU probing using padded PING ACKs (RFC8899)")

Signed-off-by: Gowtham S Bhushan <gowtham398gs@gmail.com>
---
 net/rxrpc/output.c      | 12 +++++++++++-
 net/rxrpc/peer_object.c | 20 +++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 88cad087f13b..a3dfba0a3bbc 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -325,9 +325,19 @@ void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
 	if (why == rxrpc_propose_ack_ping_for_mtu_probe) {
 		size_t probe_mtu = call->peer->pmtud_trial + sizeof(struct rxrpc_wire_header);
 
+		/*
+		 * skip padding if the base ACK packets already meets/exceeds probe_mut
+		 */
+
 		if (len > probe_mtu)
 			goto skip;
-		while (len < probe_mtu) {
+		/*
+		 * pad the probe packet with zero pages up to probe_mut,
+		 * ensuring we never write past the fixed capacity of
+		 * local->kvec.
+		 */
+
+		while (len < probe_mtu && nr_kv < ARRAY_SIZE(call->local->kvec)) {
 			size_t part = umin(probe_mtu - len, PAGE_SIZE);
 
 			kv[nr_kv].iov_base = page_address(ZERO_PAGE(0));
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index fa9a406e1168..a2f87137bb7e 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -207,11 +207,21 @@ void rxrpc_assess_MTU_size(struct rxrpc_local *local, struct rxrpc_peer *peer)
 	peer->tx_seg_max = dst->dev->gso_max_segs;
 	dst_release(dst);
 
-	peer->max_data		= umin(RXRPC_JUMBO(1), peer->if_mtu - peer->hdrsize);
-	peer->pmtud_good	= 500;
-	peer->pmtud_bad		= peer->if_mtu - peer->hdrsize + 1;
-	peer->pmtud_trial	= umin(peer->max_data, peer->pmtud_bad - 1);
-	peer->pmtud_pending	= true;
+	/*
+	 * Avoid unsigned underflow if the interface MTU is smaller than the
+	 * transport header size (e.g., on virtual interfaces with MTU 0).
+	 */
+	unsigned int max_mtu = peer->if_mtu > peer->hdrsize ?
+			       peer->if_mtu - peer->hdrsize : 0;
+
+	/* Clamp payload ceiling and PMTUD binary search bounds to link limits */
+	peer->max_data      = umin(RXRPC_JUMBO(1), max_mtu);
+	peer->pmtud_good    = umin(500, peer->max_data);
+	peer->pmtud_bad     = peer->max_data + 1;
+	peer->pmtud_trial   = peer->max_data;
+
+	/* Only schedule PMTUD probing if the link supports more than the floor */
+	peer->pmtud_pending = peer->max_data > peer->pmtud_good;
 
 	_leave(" [if_mtu %u]", peer->if_mtu);
 }
-- 
2.56.0

