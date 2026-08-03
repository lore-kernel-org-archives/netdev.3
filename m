Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEFC2FBE1F
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742455; cv=none; b=Kk0w0cYXvCZtKynVjyoz7QH9Vt/jXN/TE38u0wp7A3j1FM7PMWZRjtJqAek8TDzcCCLnHe0DZWujzlLwVNUJOHV0phg59/M5N047tQhQxOkmyXQtB97G8isEwb9gQR1cwtVoUQp9LEEDrimDCg/HqEOX4Nl3ajSkFzOm0Kw8nU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742455; c=relaxed/simple;
	bh=OYpKDRPJ5QqkKzY5a0l3W1nbybixDlewt8wC1thOTG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDhATtJmQg2NXDdW0Q+E78szhSfhhRKorb6KfuWVKqh4j6IKivAXD6vm6nW6vrPaaOeOta02alme0t8ANCHTJUqetXFeYV0JJ177CtB/BEB2XtCdt6zbRSO7LKmLU18hyL7BMFUFcKQ1qTUhTyV4JvUuD/LbuvUk1YVJQOsVO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hriKuh8m; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hriKuh8m"
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4961058e787so964449b6e.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742453; x=1786347253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q5ykELDhJxT1ChCufXvrVdtewa2pltNuabVAzU3EqHM=;
        b=hriKuh8mdz20fVX19+/EZvXo4LvBLCh45zDrsdGDl2dQWAzjNo+kbDfKpk8pOUzOya
         eSjmG7UM0YRj+fF+0KYmisT6kCNNchPLlVghgqykJOzet/WjcxKzoD7iHbLpQp1BDFRn
         Q5pBmrBQjUPvzTQLez9IOVufhl3J7JTYI2hYHfbVPb6KNP13tNxiQ4M0f1319djc6aQK
         A5lMpWutgvxawWb5BUmG5Xy4Myo262VZ4Lriko6Xi1Le9xUgj+q3lNyeMzcDoaHgKvhp
         oilwqw93K/UKd5/aKWUgsTRbwKJC9zjgq9QxVwg3oCrzGGMyBuR/dzVN1HIBe7Fv0iSJ
         UgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742453; x=1786347253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q5ykELDhJxT1ChCufXvrVdtewa2pltNuabVAzU3EqHM=;
        b=OWAB13y1wJh5tgAFLLhOdNgYgc0u8imcJQZHeaViORUZUhTO9bP0/MghSNIyZjVN9O
         AgstnJjMMP5cJwwiKjFEbNNhRESjKDb4kZPPmc1ZUSnUkGw4G0rAp4gSxpdFRIaia1el
         s2hQAXbxllaCaex5Y3A9d7J3enZvbRymDJP59FoE8zK+ZoG+3aghSxLpUzu5Ojt9wog2
         PXK+hzbTaL+Bi13mvYKzs+vpGVCgMm1kOQXvEnWCICK50TRZ5OY5kZRz1hYFq87/OVVX
         1XQ8CQbmnlddr/ywhUhkuiWZ+CeSUCWdD5oLgBKJ/fEuH2mTrYpnGSkTb+JG9tM5gW4+
         aOiA==
X-Gm-Message-State: AOJu0YxvF7Cjf+GPtQ2RC1XNPVs3Pfb9BPZ5YD7fisEuq45M/IcRc0yB
	YNtsaYHTdTs6/nZG7V2iuO3UmJzbgwSz68wBr3BS1Bltvsyct9xMDKlciN6mxLQPGhlwTw==
X-Gm-Gg: AR+sD13OISUs8uSE9rNIxQxZSxNzFrOwFq6o3Guzi26NVUKPRhsnlmxZCac7MAJguiq
	aHI/mR+kqqIylfEhDYK2A/iBaiNw7SFGCKTpoXV/4rB1X9pYPVSLRZss2uVR3D0UjsxCPC/u7NF
	GRoZoxn0SEzH0j2Savq5WywzkNfw2SRQbctlOvyOKowG/oBYAtcmhTRrcVqTGL9+yzwYUgCHY3C
	wQekoTLJNWF6PsbYJUMrDI4i3v4v+EvwrafaGzUUFLCCQtamUCGzSNBwAcvYL+5ctyg1oHxBI75
	etj1JCYrXvJ5hB+pRDCS49I1HMT0Y/W/xwOfBiDP4kUv2YzgOyR5mi1Jq3PPjcjy8rGOKPEgi8S
	Mgb2e40TWxJLgNU2QUA1HgBF7tXa5cABOmDd0RDbFrN9Piun35aw9QzIb3tw4/ndRKWt3h9dC3p
	mgVkR6ZySDIQ4kDmv2JN8tp+FiBlY08LgBuncG9VMP6OYEr2s2e1XpHmkjIcMI36/rRIZA5EE2o
	l52lgc4mwfKkEHaEgLvLKjosVomiu0Q+Cca
X-Received: by 2002:a05:6820:4b8d:b0:6a3:7ad3:e728 with SMTP id 006d021491bc7-6ae433335admr12912174eaf.28.1785742452708;
        Mon, 03 Aug 2026 00:34:12 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae39e2f5c2sm6173749eaf.8.2026.08.03.00.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:34:11 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	linux-afs@lists.infradead.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH 1/3] rxrpc: fix stack OOB read in TLP soft-ACK processing
Date: Mon,  3 Aug 2026 15:33:53 +0800
Message-ID: <20260803073355.3895949-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260803073355.3895949-1-bsdhenrymartin@gmail.com>
References: <20260803073355.3895949-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_seq_in_txq() is meant to test whether a sequence number belongs
to a given txqueue segment, but it compares the in-segment slot
number (seq & 63, range 0..63) against the segment's absolute base
sequence (tq->qbase, 0/64/128/...). Two consequences:

- For the first segment (qbase == 0), any seq that is a multiple of
  64 is wrongly judged to belong to it;
- For any later segment (qbase >= 64), the test is always false, so
  TLP probe handling is silently skipped for them.

In rxrpc_input_soft_ack_tq() the first case leads to

	test_bit(call->tlp_seq - tq->qbase, &new_acks)

being evaluated with tlp_seq - qbase == 64*N while new_acks is a
single unsigned long on the stack, i.e. a stack out-of-bounds read
8*N bytes above new_acks (KASAN reports stack-out-of-bounds at
offset 40 for tlp_seq == 64). With a large enough tlp_seq the read
walks off the vmalloc'd kthread stack into the guard page and panics.

Turn the broken slot comparison into a real range check. This bounds
tlp_seq - tq->qbase to [0, RXRPC_NR_TXQUEUE), keeping the test_bit()
inside new_acks, and also fixes TLP probe handling for non-first
segments.

Found by the autokbug dynamic kernel fuzzer at Tencent Yunding Lab.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/rxrpc/ar-internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab9..27992e10d82ad 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1580,7 +1580,8 @@ static inline u32 latest(u32 seq1, u32 seq2)
 
 static inline bool rxrpc_seq_in_txq(const struct rxrpc_txqueue *tq, rxrpc_seq_t seq)
 {
-	return (seq & (RXRPC_NR_TXQUEUE - 1)) == tq->qbase;
+	return after_eq(seq, tq->qbase) &&
+	       before(seq, tq->qbase + RXRPC_NR_TXQUEUE);
 }
 
 static inline void rxrpc_queue_rx_call_packet(struct rxrpc_call *call, struct sk_buff *skb)
-- 
2.43.0
