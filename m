Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB9332637
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086397; cv=none; b=GNEdRoptguJpY+nYoBfBkXW5Rw9Cs4xb2Pk17wxybVHDslh5ga51cay3K4tm5Tf5Rd0QStQywf7zm6qlZclJ1RMEzYnufTMssKPkJzXcxyJWzzO9Q23hLM/yqtbGNfe7ry3ih4+OOWgIc5zdcg6ThJmgsHCeDpoRYonksFreZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086397; c=relaxed/simple;
	bh=BwbZjpSEasdedzhM/UoNb4cReBikllIg6lQDvd43RQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvWz0Z95m6C4SP/ZvOBKUPpLfWo+250lNdGNsHgENGZKI6VAJlpJ+DMzgG1POOKXdfhRqhS7nkPtD5Ywl9CVHsFpBUWfH5enLAZIOUMoq5I6/wb9nNOMbenkFHeZD6Ujn7gLjLkwt20fpj8J6QnebxxN4oqKuJIEVQH+c1tiRwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=K0Wq4MXw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="K0Wq4MXw"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f703a9d05so190493f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1787086392; x=1787691192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PniXs5IS1h6xfus/VCQ43sbnKG25IMDV2ouZ/Ios0xM=;
        b=K0Wq4MXwczB14AAEhtioecz+IyV8dWGFF1mOwyppk+VsUixFR6MmgH0FsqtCoGco2G
         KGSC82eEeysMxVCd6IZEenIjkk3zHeLz44fhTc5NcJepIeHLPpV/afozani991EdQqEp
         Qe/0qSyEPwEffNJDmxNeJKgJ1QYClyIUaVj1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787086392; x=1787691192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PniXs5IS1h6xfus/VCQ43sbnKG25IMDV2ouZ/Ios0xM=;
        b=fTqKF5PH4WmqdiWEqWgMah3LVd8Y656fR8v8WtDqFWoE4IoOCmx0VDL34NRdiiIKMi
         Pw5ceQ8RhdUTxwmbQsZ3jnlQUSKMAgCjE8onqQtC+6berBKgJJh2zAnVZGcx+PHZyUqx
         cc5gJEd2uEtZA4Fwq58zxg++12+SsSOz+HiTBdLV9S2BFo4wKRyIn2LD4z0MlPORoDGs
         bw65yhO1B9GqVlxV0NiknqbGaqOGCaZN9xtzxw/VH3Q9AJasybVawZh5mfDwHRCGw7TN
         8KzA8YWUTwwTZlCO/EJA307jUo7J9v9OSfGQR/bG+VinBLvjhLk83rFlPzTPShnMeLvZ
         zbuw==
X-Gm-Message-State: AOJu0Yx8Dz8FMmgd7KS9lJXeDN6nxEqkC7xqF3Lg8JQXiqi1sbE7JZfa
	iq7aTUvMi7Tl1Ir9xFhapaW7HfeHVEdZ50BGCrYmSnMGg1yfaRSAUJDDHcpmu+7zD1C4AX15oEP
	PvzZ6JB4XmtvXcUyWEhZA/Ci4TrVHI+iSETqjuLfwoRfj/z20Dy/bWkLy3SWZ7hTBcCDuBd+gRN
	Iy7V1VmxriKFXqGYKjPq4eyD9rP8qO9sfwpfgNr2ssINOmhAoFyDN5DbUarg==
X-Gm-Gg: AR+sD13Dwqf+OlgbaFlQGz6NHQzMnNeJyPW5ct5A3R0AZG0AAgsd27z6sC67tdYrBUQ
	O3fnI7rdilGFxAbLVj222u4m1pSqkmmA4jhpqdkeOqwv2Ap4ZIz0fyYGrZ+zBQD1so3xlJ1qOVj
	6nnX7c5XHNjNw+s9vuHwNykgkGIvOO1jdcg6M/7r8O9eexnG2OeNHcQIuOYtkj/MUXz86jxMaDX
	EwfWBkT6MsHSsGGvXTip1lYqcuyZslpV8i+vU/nWd5O5VX6bvBbyU2DvtlQrYtugL/mBrwTUYjK
	RM4kAlUdUJszkKmbisexQRyCpuoaAPOx0Q4W4aHheUTV6FVL8FDxvq/YiCYiEIffBcc1LmOtQSu
	G2424Q7g/9MM00r+H5uwoA8oB2nyzceKwviGfVeSW6OkHOAMjQR3dyGdLFsq5IkFqjhTNvnzoq0
	O4BGjS5ts/5ZtxMDWXqsumlfMxE5Vdx+FXNo6BkxgB/GhwBub4Tqi97xWms6MoCbA45s/UxF9AL
	31paO0ls9kdoJAwSox8fkD2YpOMDTlni34ymxTjV8V9W9xGUJJ2cm2AQaNkdD81F60QAZgJpc0W
	y2k=
X-Received: by 2002:a05:6000:710:b0:47f:5369:bba with SMTP id ffacd0b85a97d-482b07f24c9mr1239668f8f.15.1787086391848;
        Tue, 18 Aug 2026 13:53:11 -0700 (PDT)
Received: from aklabmpc3-HP-EliteDesk-8-Mini-G1i-Desktop-AI-PC.tail24119c.ts.net ([2a00:a041:e00c:da00:7999:8ff6:9261:c537])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b77fa3sm14199953f8f.26.2026.08.18.13.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 13:53:11 -0700 (PDT)
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
Subject: [PATCH net] tcp: reject completely old segments during sequence validation
Date: Tue, 18 Aug 2026 23:52:30 +0300
Message-ID: <20260818205230.1146138-1-michael.cohen3@mail.huji.ac.il>
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

Reject this boundary case while retaining the existing behavior for
segments that consume no sequence space.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
Reported-by: Tamir Shahar <tamir.shahar1@gmail.com>
Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
Signed-off-by: Michael Cohen <michael.cohen3@mail.huji.ac.il>
---

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

 net/ipv4/tcp_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index daff93d51..3bfa0f07d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4844,7 +4844,8 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
 	const struct tcp_sock *tp = tcp_sk(sk);
 	u32 seq_limit;
 
-	if (before(end_seq, tp->rcv_wup))
+	if (before(end_seq, tp->rcv_wup) ||
+	    (end_seq == tp->rcv_wup && seq != end_seq))
 		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
 
 	seq_limit = tp->rcv_nxt + tcp_max_receive_window(tp);
-- 
2.43.0

