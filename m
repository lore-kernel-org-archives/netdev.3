Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3693A257E
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788009642; cv=none; b=jrFjFZk9SFEUaN3UyaqlL2G4zO6ZwcPj7gS3QYahauaW+PTeDNVTGvazdXpt4pY2V8jUEpMbbcyodvq9n/+QczpmUcsqb4XEOUDjWEFHyaj/oxeCeCOZJjHuhhXiGbUIZ1lAgYtVfdXqQKKu/eni1CrcRVLtajyODmRv15PVYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788009642; c=relaxed/simple;
	bh=ZmorWBw9yFgvvoPoyAAtZZMyfZ76Aag4PA6C1hXaBWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIYjWyv3xi/g8MNae7T5EPGond7EhvmMkp0awNZa477Dg5XnAN2WnNogaTxHoqIQs4WclNaoHYhlm8847+8tGQUZwrtkq74qZAfNGkAGyCmYZYtid8TqGE1oNHXfUNHgJPQjqMD1BCGc8iYwTNSEpsPB25glGD4+6bcFOoZx4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=aLSuGv6x; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="aLSuGv6x"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso19949905e9.3
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1788009636; x=1788614436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QaaYsyMk0LotJwBZ8+yTnLDDOuYKQGa1ccvtLoH50qY=;
        b=aLSuGv6xPoRRGQ+FDlm2NIt0JohyMHZormpEJ3Afxea+talYYxmMyginuBccS0FJ0P
         uzGT1YHuCWbAab2fGr1CDdC7pLKSt4LFQw12+I9C8vLf4YxbPnIODxT95RstaMstZwYv
         58/ixM2fSBVva9A9Zf61Vg2iRMMVoCCgyLFzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788009636; x=1788614436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QaaYsyMk0LotJwBZ8+yTnLDDOuYKQGa1ccvtLoH50qY=;
        b=kLao9xJ81RGtr/KXITITsQuJrF9pzPzIuVGMuF0mA6kIZRzeKRuKo1NbSqjBCwS6Tg
         kQeHqRPEt4a2WeiyK4eBypjhhdMK1qzQabEFK8QAiFwz8xDpbTi/rpPauCugur+LCLTA
         K2swkBHY9jv9UcHVojyqgkBQ1vcWPwdIw1eCZ6uS2TYh/pCxrug410eum6Z/v08jv4Q/
         hcT6fiYbslqK1DhQ/IjgUrjao2DQafPAPz0A0vE0bjsFzml7sK5TxXcyOvsPIibgTgzv
         eP6Gh+iBwFHXYjHocuPknY7CRdIPZ7ZwY9kluo3037DNK517bSaYJYXEfvLbRrhbZkFi
         07yw==
X-Gm-Message-State: AFuF++kV0uE85NoyPIoO5/4KACAHvlua2aeSqOsyPlZTi4t2r9rjN0H9
	/+8qekDt1jJZuf4I//kqu2pnTGrTF6H90Jxf1iXx7on1r3U1EPfvENVncKUCzO/5oZwiyTLLoW6
	ojDw9u2co4JIJ1WtXsNGzpyAueet+m8f9m47Yebcdhj9qjz4ch9VIWzIryfnf04SlKSiND3Yqm2
	hogs/iIYpm3wedcB4qq4V1dGtdvHJxqyuGmv8Iafb9zoPY5BvaaPeQqE9Uvg==
X-Gm-Gg: AR+sD10v37nGa/SJYyECawrSzxWURo5+o8jkLX4+z3OgjSWCgbJQf6KjociaAyb6/js
	jC/F637B2N9pq2F9Wh7DrZXv7OmkBhaavApYnjrptwXE6XGY1SVgQh7IKq/YjHq750yWjcMB/NL
	HW+hN0ozKUx67LmbywnOK/+GWcx0a6JfDnG8IcOMtwdwjopTtog/+J71ZeUxL0vTsB14zV4+9Z0
	Wlsc1c4TvCdcXLLf2Z0u/EswlfJwqruEqotVa49t/6bCkQ7ohl5my0w5zEABqIQMOoUMz+F/4ni
	fvW6oz0IUUR2lOqINfKjCQecrW6Kwy69pqVf3JTwOzNJoF4aETkr/dK+FHReJBrabMiVRQmUvQS
	VjOutDC6TlrtmxwFoGsDKvKBam+cBZR0YjlNNkZCAeFDQ2RV7VpklCuWiDEzvfBaNORvlL9hU/O
	5e8FvFUMUdz/3lsJqJlSZPkkmgcf+obsOMDEfsEWgBx+V/eGxNX0XvESI0dBKZa6NSCPq2lEO99
	rzKA2d0ozfJiNSy9MQfpb2zQmWl9oUbnsjgM37nXWpAqiKi4tFRad+jZlf5pcfjo4vZNubqm98m
	qw==
X-Received: by 2002:a05:600c:1394:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-49b91c47b6bmr178646055e9.9.1788009635721;
        Sat, 29 Aug 2026 06:20:35 -0700 (PDT)
Received: from aklabmpc3-HP-EliteDesk-8-Mini-G1i-Desktop-AI-PC.tail24119c.ts.net ([2a00:a041:e00c:da00:39dc:2bfc:bb1e:d7d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2794dsm10577076f8f.25.2026.08.29.06.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 06:20:35 -0700 (PDT)
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
	Tamir Shahar <tamir.shahar1@gmail.com>,
	Amit Klein <amit.klein@mail.huji.ac.il>
Subject: [PATCH net v2] tcp: reject completely old segments during sequence validation
Date: Sat, 29 Aug 2026 16:20:21 +0300
Message-ID: <20260829132021.2096728-1-michael.cohen3@mail.huji.ac.il>
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
Reported-by: Tamir Shahar <tamir.shahar1@gmail.com>
Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
Signed-off-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
---
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

 net/ipv4/tcp_input.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index daff93d51..1991285aa 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4844,7 +4844,11 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
 	const struct tcp_sock *tp = tcp_sk(sk);
 	u32 seq_limit;
 
-	if (before(end_seq, tp->rcv_wup))
+	if (before(end_seq, tp->rcv_wup) ||
+	    (end_seq == tp->rcv_wup &&
+	     seq != end_seq &&
+	     !th->syn &&
+	     !th->fin))
 		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
 
 	seq_limit = tp->rcv_nxt + tcp_max_receive_window(tp);
-- 
2.43.0

