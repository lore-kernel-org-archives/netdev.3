Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005B3A6418
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559536; cv=none; b=lpuZ/nIdZtgcOeBrlX+407WSsXEblpLxYNp/5gqGllEQKpRNETPqF5wW376StBut8ruEeyjrFSCiZk5Op0RVQRd6Xuynxns9aXkJc/iira3OaVKXhVkI7zumZYPqstP9qmtohsVgdZhTKZ1ZZryRpBEjVn5fWItJYLDBvp+a+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559536; c=relaxed/simple;
	bh=yLhHPgd/yh8E2Ja9eAUCpNVcamrYT4itwboX79+K8F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCnIxTNQMjxeX+BSzVqTstRPCIxNaUxCacTVGbbmHduJFVJPC6RkwybiIKptpKYm+DijBXPNTf8u9ebqdpMP66Ww7913D66fpotxn1KHDp6gHkoJZ/RzUxm158G6HQvGaxkSNEyXGfERwt0IKupwazAmM+cotCmMLvr0Os6HxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DduRgjdN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DduRgjdN"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso2815719a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787559535; x=1788164335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xODi2FrfSQv/ArnvkoarclXsAeWviGOdZYyP3yEE9Do=;
        b=DduRgjdNw4tFL154PQMMRe1QX7Bo4Aat8pV8JwAp/xnA3NaVaO89JYEyDZpa8Iu1uU
         ZfdrT+1lFtLeQygXnA6AkNMwg38tmsGOFEQ3dtoN/spvvVgvM7UjM7yHZCCWnzcudXLR
         rcb+JkWEJslrH0hJaWHflYCGRQjuq2S5jzBjM2rQjHZwl5p7MzorDsUcYCJx6OmmLO7F
         cSpuS9cYrnyJ9elXBsS7Rm2bKnggVziYdz0alvOo8LUU7rsCBKBv3VO1FkC+PKuTfDXh
         ThzcUfU1hK+/fbUm2Dtib3lZCYNrVc2adMmk9uomSFppC6Y0i6WvtMLn0bLJLrU8wBv3
         kpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559535; x=1788164335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xODi2FrfSQv/ArnvkoarclXsAeWviGOdZYyP3yEE9Do=;
        b=jdOPyQ2P60pXjU/hGECIXYs2hsqNlQmAVbByNRWoaTyQbxFSYIQ3ytfzi6E8qFTAJ3
         tq+wtninGkDz+581KKIw44Fbh/Nis7bEDQmBLUPBqUOV612SLS4S384R0gsWavbXWQvz
         N1mEOcSQcFXx5B/mCygG9EkBdEb0qW9qbzrZjJ/7SpqOvRpz38MZD6TkQzkd0uDxwoh5
         +K7EJKCXa3lrOHIph3fQPmM6lUvs614pNy3AQ9FHm0CGeVsFBHoPZi0IeveHpqNuEWql
         r3Jq7P2g5mzyb00ZK4vhuXb/eE4ga+UUL2mkZgTpT9Dg8+6eywlC+w8JSOU0SSZYmVt6
         IlUg==
X-Forwarded-Encrypted: i=1; AHgh+RruNqbV/0GN/gQtdQknvSx5zGLuskQ46MN9F4C5Chz8OKBtTCriU66l2DRxr6MjAblY/f36Gv4=@vger.kernel.org
X-Gm-Message-State: AFuF++nmX5L4+87OZCWQ3Yw0pXuAfpzZO8O3JqdQKAbg1s7Ef1UB7tbd
	Kjj3o+LxCcz9OsHoWM2oAxOzbTlPAOJlC7C9f74GT2VRCHDqCY/wwqWHJkz7If9W3iw=
X-Gm-Gg: AR+sD120u9mmD/Joj7IzxaHZa/M4Y9IZGh6iAZHhDRo81FDTQHTya99iwtnI1KVvDMA
	cx+EYa7k7yJRIC6KHt4kke+zP5ckTByNrDL17k1q4LMt+JF2w2WC6yVs+DnKhtKQA++80FRwL5j
	hsJWK0JzbEtW0XLOwL8XnPyWrTnDLu1P2zGGEShZN/hgzskob2Zzfw/YRUgJXPwaNXS0+E9ijtl
	+z6a7c57JePVp3Jg+KzL2hJjbgG7o1PjBtBSvre+izD2xW6g+b1rbrFRd8DcGuoYnHjgb0WkdmG
	YZJy3A7AO4mwuVEIxnldosTaqvnCafMrleE1n6kCX3sa3XmpXN3Q4EfVoSFka7jYXNQshwaILwE
	h5INCxf6jXmTf4QxBOHGAxHJjBLYAKGWdDf34Fu7u2On5DsNv+T+WvOcRI9QACIwpqq1pTyaf2M
	wgWpbwP6+HxJMcNa90jomjLJzA6o9z+QUvGqhyq5D6X4cyyZY2aCMJdnu8/wdcDohR+tPxvRTn3
	/5de4VdtcOBjlskhtGXEVvFvz8=
X-Received: by 2002:a17:90b:4488:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-395c5114895mr20160987a91.9.1787559534365;
        Mon, 24 Aug 2026 01:18:54 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4999471sm9079775a91.8.2026.08.24.01.18.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 01:18:54 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net v4 2/2] sctp: fix stream->outcnt underflow on duplicate RECONF responses
Date: Mon, 24 Aug 2026 16:18:20 +0800
Message-ID: <20260824081832.98717-3-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260824081832.98717-1-juny24602@gmail.com>
References: <20260824081832.98717-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

A cached RECONF chunk may contain more than one request parameter.  A
duplicate response can therefore find and process the same ADD_OUT request
again while another parameter is still outstanding, rolling back outcnt
twice and possibly underflowing it.

Track outstanding request types as bits and clear each bit after its first
response.  Later responses for the same request are then ignored.

Fixes: 11ae76e67a17 ("sctp: implement receiver-side procedures for the Reconf Response Parameter")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Link: https://lore.kernel.org/netdev/20260730110225.37371-1-juny24602@gmail.com/
Suggested-by: Xin Long <lucien.xin@gmail.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v4:
 - Restore the SCTP_STRRESET_SET/CLEAR/TEST() helpers, each of which is
   used more than once, so open-coding them only adds lines.

v3:
 - Split the response_seq == 0 lookup fix into patch 1 (Simon Horman).
 - Keep the request bit helper local to stream.c.

v2:
 - Track outstanding requests by type instead of sequence (Xin Long).
 - Drop the redundant arithmetic guard (Xin Long).

v1: https://lore.kernel.org/netdev/20260730110225.37371-1-juny24602@gmail.com/

 include/net/sctp/structs.h |  2 +-
 net/sctp/stream.c          | 39 +++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index cccc662561aa..b21f23b736fd 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -2057,7 +2057,7 @@ struct sctp_association {
 	     force_delay:1;
 
 	__u8 strreset_enable;
-	__u8 strreset_outstanding; /* request param count on the fly */
+	__u8 strreset_outstanding; /* request param bitmask on the fly */
 
 	__u32 strreset_outseq; /* Update after receiving response */
 	__u32 strreset_inseq; /* Update after receiving request */
diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index cfca5aa28c1a..9fee0da78845 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -22,6 +22,15 @@
 #include <net/sctp/sm.h>
 #include <net/sctp/stream_sched.h>
 
+#define SCTP_STRRESET_MASK(type) \
+	BIT(ntohs(type) - ntohs(SCTP_PARAM_RESET_OUT_REQUEST))
+#define SCTP_STRRESET_TEST(asoc, type) \
+	((asoc)->strreset_outstanding & SCTP_STRRESET_MASK(type))
+#define SCTP_STRRESET_SET(asoc, type) \
+	((asoc)->strreset_outstanding |= SCTP_STRRESET_MASK(type))
+#define SCTP_STRRESET_CLEAR(asoc, type) \
+	((asoc)->strreset_outstanding &= ~SCTP_STRRESET_MASK(type))
+
 static void sctp_stream_shrink_out(struct sctp_stream *stream, __u16 outcnt)
 {
 	struct sctp_association *asoc;
@@ -372,7 +381,10 @@ int sctp_send_reset_streams(struct sctp_association *asoc,
 		goto out;
 	}
 
-	asoc->strreset_outstanding = out + in;
+	if (out)
+		SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_OUT_REQUEST);
+	if (in)
+		SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_IN_REQUEST);
 
 out:
 	return retval;
@@ -417,7 +429,7 @@ int sctp_send_reset_assoc(struct sctp_association *asoc)
 		return retval;
 	}
 
-	asoc->strreset_outstanding = 1;
+	SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_TSN_REQUEST);
 
 	return 0;
 }
@@ -474,7 +486,10 @@ int sctp_send_add_streams(struct sctp_association *asoc,
 		goto out;
 	}
 
-	asoc->strreset_outstanding = !!out + !!in;
+	if (out)
+		SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_ADD_OUT_STREAMS);
+	if (in)
+		SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_ADD_IN_STREAMS);
 
 out:
 	return retval;
@@ -564,13 +579,14 @@ struct sctp_chunk *sctp_process_strreset_outreq(
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
 				asoc, outreq->response_seq,
-				SCTP_PARAM_RESET_IN_REQUEST, true)) {
+				SCTP_PARAM_RESET_IN_REQUEST, true) ||
+		    !SCTP_STRRESET_TEST(asoc, SCTP_PARAM_RESET_IN_REQUEST)) {
 			/* same process with outstanding isn't 0 */
 			result = SCTP_STRRESET_ERR_IN_PROGRESS;
 			goto out;
 		}
 
-		asoc->strreset_outstanding--;
+		SCTP_STRRESET_CLEAR(asoc, SCTP_PARAM_RESET_IN_REQUEST);
 		asoc->strreset_outseq++;
 
 		if (!asoc->strreset_outstanding) {
@@ -669,7 +685,7 @@ struct sctp_chunk *sctp_process_strreset_inreq(
 			SCTP_SO(stream, i)->state = SCTP_STREAM_CLOSED;
 
 	asoc->strreset_chunk = chunk;
-	asoc->strreset_outstanding = 1;
+	SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_OUT_REQUEST);
 	sctp_chunk_hold(asoc->strreset_chunk);
 
 	result = SCTP_STRRESET_PERFORMED;
@@ -816,13 +832,14 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
 
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
-			asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS, false)) {
+			asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS, false) ||
+		    !SCTP_STRRESET_TEST(asoc, SCTP_PARAM_RESET_ADD_IN_STREAMS)) {
 			/* same process with outstanding isn't 0 */
 			result = SCTP_STRRESET_ERR_IN_PROGRESS;
 			goto out;
 		}
 
-		asoc->strreset_outstanding--;
+		SCTP_STRRESET_CLEAR(asoc, SCTP_PARAM_RESET_ADD_IN_STREAMS);
 		asoc->strreset_outseq++;
 
 		if (!asoc->strreset_outstanding) {
@@ -899,7 +916,7 @@ struct sctp_chunk *sctp_process_strreset_addstrm_in(
 		goto out;
 
 	asoc->strreset_chunk = chunk;
-	asoc->strreset_outstanding = 1;
+	SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_ADD_OUT_STREAMS);
 	sctp_chunk_hold(asoc->strreset_chunk);
 
 	stream->outcnt = outcnt;
@@ -929,7 +946,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
 
 	req = sctp_chunk_lookup_strreset_param(asoc, resp->response_seq, 0,
 					       true);
-	if (!req)
+	if (!req || !SCTP_STRRESET_TEST(asoc, req->type))
 		return NULL;
 
 	result = ntohl(resp->result);
@@ -1079,7 +1096,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
 			nums, 0, GFP_ATOMIC);
 	}
 
-	asoc->strreset_outstanding--;
+	SCTP_STRRESET_CLEAR(asoc, req->type);
 	asoc->strreset_outseq++;
 
 	/* remove everything for this reconf request */
-- 
2.55.0

