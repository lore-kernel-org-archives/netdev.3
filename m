Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07EF331EA4
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787464428; cv=none; b=Z3YaXbrp/w93nr7faFA53+l2342GTJjxDr6RdbEszTO+tuCKoRidfjHIwtBO8hRpyXlCc7WEo+hBh0AvkKaWOqSEP+BGKhZoTg11Vf1uGO6DdXZfmP6Qyks4iO0Atj/h+28NkyhyJrovUNhwWqaZm7cQ6cAH3kcKpsPpQQJGywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787464428; c=relaxed/simple;
	bh=OYpKDRPJ5QqkKzY5a0l3W1nbybixDlewt8wC1thOTG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tA+AryCBcZMBXFhsCwaRveT10Fi8HMwX+1tY+4ZTruXjpQkXZx9uZvRVwbaL6HDfk+E/RFBnMOoyCTkT7fKhapBBFWOXnx3uQGXuNyqU/0zWwGVZALWH9+AebmFk4vvCaEYSGvLzeEaN+55Jnc8Q691zmrQQNQ4c3tyOYtY3fUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3HpT4vF; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3HpT4vF"
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-45e2c1e33e1so1762512fac.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787464426; x=1788069226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q5ykELDhJxT1ChCufXvrVdtewa2pltNuabVAzU3EqHM=;
        b=D3HpT4vFCYaeWHezvW5SX+ghaGjDGjGXDMGDBHf2NsaKD32DV9cL2cVp5ZedPmWrQb
         hFoaRxvt9J+rtEZcPhAJ7rioencWr9Twa0gs4WMWQ002cAPxPWMWu2g9WQWbwc7//jb7
         /RZtjD9Ay0BSVQRBMptYyxC+SiYIEpxNkScYW0plpm7A3+HiudOKBk+4YWMibJky9ZXV
         zzboJdvzRRODTBNV4tM1iYtnb52Q1s+GYOlU5P97Z0Ne+5oF7WZIuEghivz3wsk6lXXa
         t90NyhJSctg9nzjK/iI3WLlefUuoIpTdh42/LTxmHnc0eevWi5qO/BtSFKmFBW5CE2jf
         XYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787464426; x=1788069226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q5ykELDhJxT1ChCufXvrVdtewa2pltNuabVAzU3EqHM=;
        b=EwMyVxgwRLj4QksAh65CzdEjU4/zDD4XMNcmovewRP1stKVLicwxMrAt6666DZFHL8
         iii6YA/7QerZ7bLeoR3HEhhYfc/QUtodLKNDW0PmU20Dj3OmsJWmsUqGLbnyRhqaTYEJ
         XP4QfWj20bB9J/3N5plzvt/nmDRd9l7pIet5Nw4mIAyGqAxY1vr/vLYL36ZYdCa8IZ6B
         cBOTsoN+LiSWW/HEmIzO/DZH2C1HjrIaIPgoDnLIcPWTol7Vt22awv00/9YS51gXV61/
         QPRhtLqCDZYQmhuZU/W87yoibJYJocWWsahB/DRXNcv81I2KQ2mkIeq6AowFFh3vYe9y
         ckTg==
X-Gm-Message-State: AFuF++m4QPB71+fx7Z97dIe1Pcn8/R4Z4G1ycwei5xxUZov5k7bj4DJ7
	KDUj7mmc54Kj9znJk//urZ0bPLCaueGVzBW+fTYtzeZENYKKr0M6BmRQ3Q7HsKjX2W0=
X-Gm-Gg: AR+sD13kuugRvYvvUocelQlk13u8RoII+HHM8yof0ebR3g1dFkFJbEWtK90XRga1eTr
	OJVgnhQji72k7GqJH9tHetQHpCrCT9sZMRs5GRXBv8iDtrV1JQkSSibPLhmLW6n0nDhXowMz5d1
	32ZEAH4JVWEKj2HMY4H8o/yerfe4PlzZlNrsT1eJpz6ybN/PM8yFbpdjeATsxHWdKRoP8ymnIKd
	9701RzW45tm70RK6eiHcSH5uhq7yJkC8Gy6KcFkzRYq5WOTcqd13Ce2EVCt47nRvEtVxa2UCSTf
	n5PDUnDHIuGsIv84ammaGajLtta7nezdtev0lvO7cazCSXBuhBSx5CS2CINhuO8lrJR6+ptLBF2
	ZgKjQzG3XLJK6tkURI/ONmSr39kmVO1yFfX7FyiRNTZfhYnq8nP/QXdEct8N7SZa5vdBvcKC8aG
	ZCAuFYbQiOyf+H0gicpWBCF2utBnlPfKGrJqj9SWqYDp5MdIkUpS9+RZHHszxyJVIaAljgpeoB0
	nA5OFS4UiD+wxIdPADwFpSckakpIS5o47Lz
X-Received: by 2002:a05:6871:14e:b0:459:8f4e:94f2 with SMTP id 586e51a60fabf-46351380696mr16991206fac.10.1787464425834;
        Sat, 22 Aug 2026 22:53:45 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4638313340dsm2791832fac.2.2026.08.22.22.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 22:53:44 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH 1/3] rxrpc: fix stack OOB read in TLP soft-ACK processing
Date: Sun, 23 Aug 2026 13:53:16 +0800
Message-ID: <20260823055318.371374-2-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260823055318.371374-1-bsdhenrymartin@gmail.com>
References: <20260823055318.371374-1-bsdhenrymartin@gmail.com>
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
