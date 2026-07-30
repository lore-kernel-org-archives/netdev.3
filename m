Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88CE4052CC
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409374; cv=none; b=jWi47LTJ91ynxC12NYSs7qO4tGmvbrGgM8iJJjP6QrDHI27w/2b2bGUoDx/62tEoeLQaJbUyAwpgnO7Wo3REwbc0V593Tzhtsp0AE/zOZKTeHMe8QwO4LgtSIZ07hP8QwSOrZIGhiEKDSYKOEZiquw0g3yyxvAyilIAA+o5wj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409374; c=relaxed/simple;
	bh=GLYj4y9qOcb+4URpLy99dPxoLwMSgIMPJmTKMxy/yBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6F13N8Vh0F4onLue3JzHxawFFy/v1be1kh+Sk5vbIjP4xZv2XQhjPdcJIVb3MLxzJX9nnJB0LoRPItKbsPyYLIpD37I3yRiIwwMRctE72BsCTF07wyscrqw7hHwZr/z09Y3tPTZlQCuDuxcex7V+a0kNZovhSA8jBK8SMrUKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrndH/qH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrndH/qH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d004f135b1so27283375ad.3
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785409372; x=1786014172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VfJWXRx7XSYo0yICaQTUNXgfXIN1L4L4orSeuNAFQFw=;
        b=QrndH/qHpZ+8ow8JHFOzfd7VxPOoxsnV5fWjh1y4C+0yKoYXcu8ucWsqPXKsXEo8jx
         EJeff6KZBkWT6EpKYOmOYjo1T7OFvPr+NBOQUD8rcGgYRQjwiFpJtw4z/Tlh1PRgdO9d
         V1973WuA7sfnZWUkvoCbHrWI5NDScGTt1kszomAmR8wMak2ZPBq/fo3GGOFaTxY/6Gzl
         qHQWmLo4/T17xN1EpjJKswmImbFMdh8jiTcEFD9pgqigHwwdXpFXucYaKfMD4l3SVgHK
         arfx5o4QnXqb1xZ0c1PzbGrf3T7iMqw1GtEmOTmIjrUHR2dJrjuriHBAbQsV/NdFfQeC
         /oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785409372; x=1786014172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VfJWXRx7XSYo0yICaQTUNXgfXIN1L4L4orSeuNAFQFw=;
        b=ngL9qm6IxmvuKA6Uy9fCS6Z8Rx8NsMer4/0XVBmUJxtwHEW3SRvnzqr+ISikj4Qynk
         SMc1HisEezOcdCEU8LTO9UG7/mkVgxqvytjNqg3RiR2uByTIrOvPhzr+2sJRxLDR4++H
         cuDaMM8jmfNma+Qblpog5w6KEq9h466shs50qleyvAruH6p5YGoF5u8PScPBOpnMxzuZ
         vn8gxs9gI8jtT5AjZ734GDBuun/hG1uY7yftPC1fUz91OrOggXaepCwdUvSd4V21DUk3
         jAneOfyc89ZjdeY24tgitWmgrYZIrjGITjLWyjalqSBE5wXZcnbJQc2dBh3psE4VeZio
         okZw==
X-Gm-Message-State: AOJu0Yyewkn0pSh+DhoKiJgTfKmGNvGllzAQmkLHLF15i30Ejv4PuGJ4
	mZS+xnGSjUAxO+jDODAkZJCdr3KgZKY+mNJLBOFXBIfUcorfJ7St/o1s9zF/GmcoRXHz/4Ku
X-Gm-Gg: AR+sD11492bBWei0LfWrTDRN/d7I6ci/bFMbJw1bf1Dohrvmir2mTeL8p2CbdMFRxnv
	ieqsHJNTKwxLp37xkrMgRgEHnC1SktNOiqHO1SAeJNKJvGkvS9rM9ppKmka+Sqc75sr54CwAKrC
	m+YW/KqRLW0gb0AO6aw7U8LJ/uyUlFf2qW/iik4I4Ug3REBWqepFygBV3QvKn5C9SuTui2XITld
	nNZmq7+JjTNhs++WO1u9kwUi4YW5QAejfNJdVaNB5T4PoiI6u4EsyxVmSsiAzQbJZmd3WjIkoKh
	80SjeX6cT2O2V9jmEScLdn+YuIN25Ew2PZKYbGrQuZI3WrqCJUJ3I1yYfCnxPoqlijv3YIc7nUv
	sbjA6Bwc6sEppFm+URWBDY9z6ByiR676mc6bU9vZZRswGgXtEnnydjaEdZVSYq2F3vY1p0nIHF+
	aqSHKfmimGCbKLlQDGJRLmEK+geEyuCt42Le1COWMl6cey98AqnYRm+McaDBp10Z62+GdG5WnpY
	4bYWgEbhC2lS31uvUJcdQa3sAFUFPDPVS72/Pw=
X-Received: by 2002:a17:90b:4b8b:b0:381:f7a:2e0d with SMTP id 98e67ed59e1d1-38f9bee90e8mr1637384a91.33.1785409371973;
        Thu, 30 Jul 2026 04:02:51 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b42d1a3sm873014a91.2.2026.07.30.04.02.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 04:02:51 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sctp: fix stream->outcnt underflow on duplicate RECONF responses
Date: Thu, 30 Jul 2026 19:02:19 +0800
Message-ID: <20260730110225.37371-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

sctp_process_strreset_resp() rolls back a denied ADD_OUT_STREAMS request
by subtracting the requested count from the current stream count:

  nums   = ntohs(addstrm->number_of_streams);
  number = stream->outcnt - nums;          /* net/sctp/stream.c:1050 */
  ...
  stream->outcnt = number;                 /* net/sctp/stream.c:1060 */

This undoes the increment sctp_send_add_streams() performed at request
time, and is only correct if it runs exactly once per request.  Nothing
enforces that.

The function does not check asoc->strreset_outstanding on entry; it only
decrements it at the tail, and asoc->strreset_chunk - the only thing
sctp_chunk_lookup_strreset_param() consults - stays live until that
counter reaches zero.  When both outgoing and incoming streams are added
in one setsockopt(SCTP_ADD_STREAMS), sctp_send_add_streams() sets
strreset_outstanding to 2 and caches a chunk holding both the ADD_OUT
and ADD_IN parameters.

sctp_verify_reconf() permits a RESET_RESPONSE to follow another
RESET_RESPONSE, and the lookup accepts any request still present in the
cached chunk.  A peer can therefore put two responses carrying the
ADD_OUT request_seq into a single RECONF chunk.  sctp_sf_do_reconf()
processes both: the first rollback restores the original count and the
second subtracts nums again.  Depending on the counts, this either wraps
the __u16 or silently shrinks the stream count a second time.

SCTP_SO() is genradix_ptr(), which returns NULL past the preallocated
range, so sctp_sendmsg_to_asoc() accepts an out-of-range stream id at
net/sctp/socket.c:1803 and dereferences the resulting NULL slot at
net/sctp/socket.c:1808.  Other stream walkers likewise trust the
inflated count until a later operation repairs or tears down the
association.

Only accept the response sequence currently named by strreset_outseq.
Each accepted response advances that sequence, so a duplicate becomes
stale even while another request parameter remains outstanding.  Also
reject a response whose count exceeds the current stream count as a
defence-in-depth check on the subtraction.

Fixes: 11ae76e67a17 ("sctp: implement receiver-side procedures for the Reconf Response Parameter")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 net/sctp/stream.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 34ffe6c945a4..b751d0843b3d 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -927,6 +927,14 @@ struct sctp_chunk *sctp_process_strreset_resp(
 	struct sctp_paramhdr *req;
 	__u32 result;
 
+	/* Process responses in request sequence.  strreset_outseq advances after
+	 * each accepted response, so this also rejects duplicate responses while
+	 * another parameter from the same RECONF chunk remains outstanding.
+	 */
+	if (!asoc->strreset_outstanding ||
+	    resp->response_seq != htonl(asoc->strreset_outseq))
+		return NULL;
+
 	req = sctp_chunk_lookup_strreset_param(asoc, resp->response_seq, 0);
 	if (!req)
 		return NULL;
@@ -1047,6 +1055,8 @@ struct sctp_chunk *sctp_process_strreset_resp(
 
 		addstrm = (struct sctp_strreset_addstrm *)req;
 		nums = ntohs(addstrm->number_of_streams);
+		if (nums > stream->outcnt)
+			return NULL;
 		number = stream->outcnt - nums;
 
 		if (result == SCTP_STRRESET_PERFORMED) {
-- 
2.55.0
