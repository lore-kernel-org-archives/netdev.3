Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC53399892
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209786; cv=none; b=Z4gWcD43wQJACgaQcFnw0xX8+dyEAhoANnxnYoy9pZzxqx8ScbQJqbpqgtq5grcVDXvOrJt5ezt5swvUI4OYSKM90VOVXpKSq3lAsHXTYYz3QBq3qbNyin7LlkIaantJ7bhmV5jfqNETWFOY6ZwtKEuVyRT0LnuyCTi00yjymS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209786; c=relaxed/simple;
	bh=8qJhOhfqHhlTiVNjv+IZSBivkraPw433ud3j/vbQmY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMlK4CpjnLWcZzSVedUH0Un2nAIfYanNDJy2Bd+g3n5OSTDmZzQO4ofntELpwptffbq5y6ZmkstBQ9HfIdOpJ0nzS0LRk80bdoSzqdXeYsRPguVNNIa+MkyOA2ln9XWwp/M5HjN3M+oQ4GE3tLxxWwbIJ0XEaW8UpEmlPG0fmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=OrdJ3VmD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="OrdJ3VmD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so31344825e9.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1788209779; x=1788814579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9hr7S0IH/zLRsvjQy3dIKyRdluF+19qDBE5mVEQcFbo=;
        b=OrdJ3VmD1cGGJn1+0vnCWV/cSGxgiG6geV5W1M0Phb0z/zs/HbfExgXFy6QON7LOBs
         qsLDqb6tp3lkbuMJ0f4JlHDE4BOvH4buOpnLV70106FAnVxkH8n/semlKK9n1632B8zb
         /+rKUB75UlA+CyGeY0EhjKN5MSo9OYHf1JmsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788209779; x=1788814579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9hr7S0IH/zLRsvjQy3dIKyRdluF+19qDBE5mVEQcFbo=;
        b=ahA5KdNauAmqbhYApgaMy+6D1GyEMoYYLuw6uyCskuOBt4NHVgH33kakhbGbZhnW07
         sLlB0M4FWs7Gr2QdCAOiIkaRSldNZHSFMj+AsEMbW5nCpS1PPICQG2rkY7KIMuF45Iwz
         vynR8JkdUOh6vWCGgkapsjBBuIrdZPUMuiC0bBndBkCiKoBcrHRQWwoWKHGrvnBZ15b1
         JBAdviduM6B9Jp3hd4bsV96rCKZY6wKluCvaIprKewj5Jq1AfOh7LRYTjsjDNzjXKvqO
         eKlrECjQZn2nFzy3vY1prS94teqSPzJ3XlqZxWAr+QUeS454jLumnYOlRXg4w/F0j38b
         TnYg==
X-Gm-Message-State: AFuF++mEJyRqpiBLLbg0Bex/3yubGFSSddr9sfjjQMxrIIimqwYG+xZT
	LPj7xUJYSJkLXtX2gravqlrsTfgCKUIEQHUOwYrgRvvfrfnmwi9EdRkoHSZYE9yvAtnojr6yKLH
	ZFOzcNhtKV711j9oA/ZZF5dZGFMax00bxyMepQa3PkZA5I9syPOOiR10nd6EkSlJtpBwxWY7Gfn
	s24XBX2CjzMQqHo7cyZGMMoFN07Q2ZEw9isOcpAewVyZsE62w0kQ02N0BuPg==
X-Gm-Gg: AR+sD10zHwQwJZa0uFSYHF1hjQdPRJQcUOWwaeIBpuzOTueb9oyKHYH90VLSbW/y9WI
	dQQ2M82EndJcran7+MjDi9MByWv4rHkXDVong3E8d+uc5RBr0H9cRZPYJnQxzv3tuBdqemhOkUW
	BPqNrfJUHa58o1exnf3VdfG7PjhahPAyfOqykl29pJQciX5tPutvCxympBT2n30hzktRdKJ2Oca
	yM0eWHtQjRV6l3phyOmYqqbhZ+cnL4htJ3IiukwwAhd8OhtUFRc72DhRZJGseMssH9XqMd0QwNE
	NfnSQusV1RwAlMLT/qHCuiiM7keGtz7JMtKGmGa9xi1NTAdI1YJUbuZyiW3J8jtnZozWcAX8WNH
	f1NKHsFCwfpvyZzLzLN1ElBmpevJTRbBUSfLcwgGtIxLe5QjHwObopyNAUek6k9wA2YNse0wxxy
	GLlrxdPGL8HvJGDBOhWhv2VWkkizYYr7KA2JnheoDfCeUCygcCgQ+ApfMplH1MkzoRWVAllob1z
	Nq+AQElHzdiVp8XrfP6aCb6z0g8VXiAdVIDSjBvZdcLusE/xCqRcVyPmTTHkVj6Tqv4uhdkD00T
X-Received: by 2002:a05:600c:8107:b0:49c:d26a:cf70 with SMTP id 5b1f17b1804b1-49cd26ad005mr247844775e9.15.1788209778962;
        Mon, 31 Aug 2026 13:56:18 -0700 (PDT)
Received: from aklabmpc3-HP-EliteDesk-8-Mini-G1i-Desktop-AI-PC.tail24119c.ts.net ([2a00:a041:e00c:da00:9e07:298b:4cc:74a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1e1ebsm18246385e9.14.2026.08.31.13.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 13:56:17 -0700 (PDT)
From: Michael Cohen <michael.cohen3@mail.huji.ac.il>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Michael Cohen <michael.cohen3@mail.huji.ac.il>,
	Tamir Shahar <tamir.shahar1@mail.huji.ac.il>,
	Amit Klein <amit.klein@mail.huji.ac.il>
Subject: [PATCH net v3] tcp: reject completely old segments during sequence validation
Date: Mon, 31 Aug 2026 23:56:11 +0300
Message-ID: <20260831205611.2439538-1-michael.cohen3@mail.huji.ac.il>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_sequence() rejects an incoming segment when end_seq is before
rcv_wup. Since end_seq is one past the last sequence number consumed by
the segment, this misses the boundary case where end_seq is equal to
rcv_wup.

A segment that consumes sequence space and has end_seq equal to rcv_wup
is therefore allowed to reach later processing, including ACK handling,
even though it should be rejected as a completely old segment.

Reject this boundary case for segments without SYN or FIN, while
retaining the existing behavior for control segments and segments
that consume no sequence space.

One consequence of the early rejection is that, in some cases, a
completely old duplicate data segment will no longer reach
tcp_rcv_spurious_retrans(). For IPv6, this may prevent a retransmission
with a different flow label from triggering transmit-path rehashing.

We accept this trade-off because the segment is completely old and
outside the receive window, and therefore should be rejected before
normal ACK processing.

We consider preserving the RFC 793 and RFC 9293 sequence-acceptability
boundary for such data segments more important than preserving this
side effect of processing an otherwise unacceptable segment.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
Reported-by: Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
---
Changes in v3:
- Group the old-segment checks behind a single unlikely() branch to
  avoid adding unnecessary cost to the TCP fast path.

Changes in v2:
- Exclude SYN and FIN segments from the boundary-old check to preserve
  existing SYN/FIN handling, including simultaneous connect
  and retransmitted SYN+ACK AccECN processing.

Packetdrill reproducer:

// Off by one bug in tcp_sequence()
// the negative test before(end_seq, tp->rcv_wup) has off by one error, since end_seq is SEG.SEQ+SEG.LEN,
// whereas the RFCs require SEG.SEQ+SEG.LEN-1 (their positive test is RCV.NXT =< SEG.SEQ+SEG.LEN-1)

0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0 bind(3, ..., ...) = 0
+0 listen(3, 1024) = 0

+0 < S 0:0(0) win 12345
+0 > S. 0:0(0) ack 1 <...>
+0 < . 1:1(0) ack 1 win 12345
+0 accept(3, ..., ...) = 4

// This is not mandatory for the phenomenon, we just do this to increment SND.NXT (set SND.NXT=101, retain SND.UNA=1) so we can show
// later that the problematic segment is actually accepted (via the tcpi_accepted_bytes count).
+0 send(4, ..., 100, 0) = 100
+0 > P. 1:101(100) ack 1

+0 < P. 1:1001(1000) ack 1 win 12345
+0 > . 101:101(0) ack 1001

// Now RCV.NXT=1001, so according to the RFC, a subsequent 1:1001 should be discarded.
// But in Linux, 1:1001 is accepted(!).
// Note that bytes_acked is incremented to the packet's ack number, which shows the packet is accepted.

+0 < P. 1:1001(1000) ack 23 win 12345   
// +0 < P. 1:1000(999) ack 23 win 12345   // if you use this instead, you get an assertion error, as expected.

// this assert will succeed in the presence of the bug, but per the RFCs, it should fail because the packet should have been discarded
+0 %{ assert(tcpi_bytes_acked==22) }% 

 net/ipv4/tcp_input.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index daff93d51..10e49e6e1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4844,8 +4844,12 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
 	const struct tcp_sock *tp = tcp_sk(sk);
 	u32 seq_limit;
 
-	if (before(end_seq, tp->rcv_wup))
-		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
+	if (unlikely(!after(end_seq, tp->rcv_wup))) {
+		if (before(end_seq, tp->rcv_wup) ||
+		    (seq != end_seq &&
+		     !(tcp_flag_byte(th) & (TCPHDR_SYN | TCPHDR_FIN))))
+			return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
+	}
 
 	seq_limit = tp->rcv_nxt + tcp_max_receive_window(tp);
 	if (unlikely(after(end_seq, seq_limit))) {
-- 
2.43.0

