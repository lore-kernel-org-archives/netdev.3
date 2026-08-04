Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D645366566
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843076; cv=none; b=TBLxPQe22W1zulkk1vbLIavjL+Qiq3jEpfRJdIciIQqVoAbeXa6fmo8idsyqkCHYCEsBrc6udRkO6215gpsEmIn5aJ8ZneMt+kLxdZ47rCdpF3tscZq0nIlh2/xrEMATjqJoFnppf18+bVtQkfYA616u5QOo5jk2jvrzy3PSMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843076; c=relaxed/simple;
	bh=QXL/gHzxZlpyMCf4Q6pO8VTh3km0jDEVMK/+HIKY7Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVJqTTfqoP4OYUCa/9RBB3fb15tz72TeiDRVfOLelpWAjsWkzHtnhqt3iEXIRGJNRv+51tDs1rhcp0fWVOCD+Lhkjrq2Za13bzEm/LkyFFEDiBJD5BXcu3AHUUYmi2Xc/66mPGsCdOIYnE1CxN8X8s1z3P6uq/+DfFXkvdQBvA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzTZbnoV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzTZbnoV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d049069377so38801575ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785843072; x=1786447872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4o+lv80XGGz7krKEIR83DS7AibCKY0cMYX7KmlT/aU=;
        b=YzTZbnoVwBQO+Otz+db1M4KOucAQCbEa/uP/YHPFY17SdWFOfFh4u08z8zScQzCQdB
         yNwrSQhy2YpPB5rCrOup1dOAlAEof6CBxZCSpWU5ZbHihNtIqmVAwgB/fMEk8OOcqMfk
         lLb330M/HmSoHLlwbUExZtfcSPxNH0v/OzjMwZRTCXYQndBdoDSAFa1dLywvnvPR/Pbd
         h9/YxcgtjfAGwOutN219ZZvxLedxfUu/Uxdhc2c4brN2TmYhi+Vrtyj4azz7R/pM8Swr
         WjgZsy2F/Q0EFBq4vksfoa8eT+T2RizV/gbGDHydDsMLxTBSTBpl1ZNNz5zBZ7rxFaLq
         Uajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785843072; x=1786447872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4o+lv80XGGz7krKEIR83DS7AibCKY0cMYX7KmlT/aU=;
        b=eHNLz3lGl24WytxM2uelOLfSB4Gq/IfmgOMPsELDb5NDQAMc0SiMgjA69b9e5Mzgy4
         7q6bidctl1A8LhgWAVq26LD+2Qvi9uIn+nuynrNV7R+yOOrsvYXZAnBqynNjWYbLekoE
         y6lfpU9hmoaKB89eSsrfRe9HlTti9tTRmnmYENXtesfVvAIJ1Y0VudGYo05JZ6Lh5gfj
         gxegjlRFEFv+8+VjxxTa6jxTWiuMUGVHI9QK4mLu5Px3qwSlx2xWtBpRpZLnUxMBnnE2
         Bqa8d6zzr8EAeFUFZR9BIYpXtenoq5q4taGOeejzEb5ILWSq/dHVXmpCUsfPHT3XS+oT
         fsYA==
X-Gm-Message-State: AOJu0YzdlmseUewhRR7yaEiGbBDq1Bk4bCYNlXUGtk4LBJ9Lj9PTjAzp
	eUh83B2MsoYBm3BnV+g4WuS425H+DB6MQbYC5plG2lLujSV9wYgZHt7v4SA3F5NCW0XU9RkP
X-Gm-Gg: AR+sD129X3z4hi6mohQnkw/wJSdDMuNyhUExIpXrvomUb8B9btHqks3gpGGgFHCS7l7
	cU40oxJeJf5Rfja9DPHVb+H6qwd9WB/36MvZIzo66W5OFl1X8DZA+/kYJ6wczD5bnJ0lXtaHRCf
	6LdYT7tpZCBEmPb6xSWXuVOOgDPv2nQH+EEYgLq1fCO6PV2pAVOL5+RAtfrkRuwTy0R799/Z4I2
	0/CW8lW31+h9RI6d+Cos9xwFULxS8klIVR6Y7pVHNFXsuTO34bbxb931OSikMvjep/xj7KXsi0Y
	k1HO0UAdIgVwvdVNDN9FjXD/+CvxyruhXNWKT3FSFNQaHlM5g1lfPTjngubEH97hhFlLjo0VIIY
	NYFYFjgTMdOfxiGEll+5x89ixYEJGKd4azQmv5pqDNuRAGkPpLEwjrSoOP8Us9FEe01WMt8pVC5
	Q7/WX4+kY4krddaKjFNh5/OmNyL8D6/cMP9It8mm0ftU52fM176dhHqYdhB7Ygvjd4TdXbpy48h
	+DbWYaE/UzmPvE2whvNVZ4WmA==
X-Received: by 2002:a17:902:ebc2:b0:2cf:bf32:b754 with SMTP id d9443c01a7336-2d05219f1cfmr145006755ad.8.1785843072018;
        Tue, 04 Aug 2026 04:31:12 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa492941sm5319615ad.38.2026.08.04.04.31.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 04:31:11 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] sctp: fix stream->outcnt underflow on duplicate RECONF responses
Date: Tue,  4 Aug 2026 19:29:51 +0800
Message-ID: <20260804113100.37840-1-juny24602@gmail.com>
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

asoc->strreset_outstanding is a plain count of the request parameters on
the fly, so it cannot tell which request a response belongs to, and
sctp_chunk_lookup_strreset_param() accepts any parameter still present
in asoc->strreset_chunk, which stays live until that count reaches zero.
When both outgoing and incoming streams are added in one
setsockopt(SCTP_ADD_STREAMS), sctp_send_add_streams() sets the count to
2 and caches a chunk holding both the ADD_OUT and ADD_IN parameters.

sctp_verify_reconf() permits a RESET_RESPONSE to follow another
RESET_RESPONSE, so a peer can put two responses carrying the ADD_OUT
request_seq into a single RECONF chunk.  sctp_sf_do_reconf() processes
both: the first rollback restores the original count and the second
subtracts nums again.  Depending on the counts, this either wraps the
__u16 or silently shrinks the stream count a second time.

SCTP_SO() is genradix_ptr(), which returns NULL past the preallocated
range, so sctp_sendmsg_to_asoc() accepts an out-of-range stream id at
net/sctp/socket.c:1803 and dereferences the resulting NULL slot at
net/sctp/socket.c:1808.  Other stream walkers likewise trust the
inflated count until a later operation repairs or tears down the
association.

Turn strreset_outstanding into a bitmask of the request parameter types
on the fly, one bit per SCTP_PARAM_RESET_* request type, and process a
response only if its request type is still outstanding.  Handling a
response clears its bit, so a duplicate is dropped, while responses for
the other parameters of the same RECONF chunk are still accepted in any
order.

Test the bit in sctp_process_strreset_outreq() and
sctp_process_strreset_addstrm_out() as well: a peer request that
implicitly answers our IN/ADD_IN request could otherwise answer it
twice, retiring the cached chunk and its reconf timer while another
request was still waiting for a response.

Fixes: 11ae76e67a17 ("sctp: implement receiver-side procedures for the Reconf Response Parameter")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Suggested-by: Xin Long <lucien.xin@gmail.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

v2:
 - Drop the "resp->response_seq != htonl(asoc->strreset_outseq)" test: an
   ADD_IN/IN request uses outseq + 1, so it rejected a valid response
   that arrives before the ADD_OUT/OUT one.  Drop the
   !strreset_outstanding test as well, it does not stop a duplicate
   while another parameter of the same chunk is still on the fly
   (Xin Long).
 - Instead track the requests on the fly as a per request type bitmask
   and test it in sctp_process_strreset_resp(), so a duplicate is
   rejected per request type, regardless of the arrival order.
 - Drop the "nums > stream->outcnt" test, no longer needed once the
   duplicate response is rejected (Xin Long).

v1: https://lore.kernel.org/netdev/20260730110225.37371-1-juny24602@gmail.com/

 include/net/sctp/structs.h | 16 +++++++++++++++-
 net/sctp/stream.c          | 30 +++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index cccc662561aa..0b48c45d647e 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -2057,7 +2057,7 @@ struct sctp_association {
 	     force_delay:1;
 
 	__u8 strreset_enable;
-	__u8 strreset_outstanding; /* request param count on the fly */
+	__u8 strreset_outstanding; /* request param bitmask on the fly */
 
 	__u32 strreset_outseq; /* Update after receiving response */
 	__u32 strreset_inseq; /* Update after receiving request */
@@ -2087,6 +2087,20 @@ struct sctp_association {
 	struct rcu_head rcu;
 };
 
+/* Track the outstanding stream reconf requests per request param type, so
+ * that a response can only clear the request it belongs to, and only once.
+ * The reconf param types range from SCTP_PARAM_RESET_OUT_REQUEST (0x000d)
+ * to SCTP_PARAM_RESET_ADD_IN_STREAMS (0x0012), so one bit each fits in
+ * asoc->strreset_outstanding.
+ */
+#define SCTP_STRRESET_MASK(type) \
+	(1 << (ntohs(type) - ntohs(SCTP_PARAM_RESET_OUT_REQUEST)))
+#define SCTP_STRRESET_TEST(asoc, type) \
+	((asoc)->strreset_outstanding & SCTP_STRRESET_MASK(type))
+#define SCTP_STRRESET_SET(asoc, type) \
+	((asoc)->strreset_outstanding |= SCTP_STRRESET_MASK(type))
+#define SCTP_STRRESET_CLEAR(asoc, type) \
+	((asoc)->strreset_outstanding &= ~SCTP_STRRESET_MASK(type))
 
 /* An eyecatcher for determining if we are really looking at an
  * association data structure.
diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 34ffe6c945a4..cb7543929d65 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -372,7 +372,10 @@ int sctp_send_reset_streams(struct sctp_association *asoc,
 		goto out;
 	}
 
-	asoc->strreset_outstanding = out + in;
+	if (out)
+		SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_OUT_REQUEST);
+	if (in)
+		SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_IN_REQUEST);
 
 out:
 	return retval;
@@ -417,7 +420,7 @@ int sctp_send_reset_assoc(struct sctp_association *asoc)
 		return retval;
 	}
 
-	asoc->strreset_outstanding = 1;
+	SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_TSN_REQUEST);
 
 	return 0;
 }
@@ -474,7 +477,10 @@ int sctp_send_add_streams(struct sctp_association *asoc,
 		goto out;
 	}
 
-	asoc->strreset_outstanding = !!out + !!in;
+	if (out)
+		SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_ADD_OUT_STREAMS);
+	if (in)
+		SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_ADD_IN_STREAMS);
 
 out:
 	return retval;
@@ -564,13 +570,14 @@ struct sctp_chunk *sctp_process_strreset_outreq(
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
 				asoc, outreq->response_seq,
-				SCTP_PARAM_RESET_IN_REQUEST)) {
+				SCTP_PARAM_RESET_IN_REQUEST) ||
+		    !SCTP_STRRESET_TEST(asoc, SCTP_PARAM_RESET_IN_REQUEST)) {
 			/* same process with outstanding isn't 0 */
 			result = SCTP_STRRESET_ERR_IN_PROGRESS;
 			goto out;
 		}
 
-		asoc->strreset_outstanding--;
+		SCTP_STRRESET_CLEAR(asoc, SCTP_PARAM_RESET_IN_REQUEST);
 		asoc->strreset_outseq++;
 
 		if (!asoc->strreset_outstanding) {
@@ -669,7 +676,7 @@ struct sctp_chunk *sctp_process_strreset_inreq(
 			SCTP_SO(stream, i)->state = SCTP_STREAM_CLOSED;
 
 	asoc->strreset_chunk = chunk;
-	asoc->strreset_outstanding = 1;
+	SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_OUT_REQUEST);
 	sctp_chunk_hold(asoc->strreset_chunk);
 
 	result = SCTP_STRRESET_PERFORMED;
@@ -816,13 +823,14 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
 
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
-			asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS)) {
+			asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS) ||
+		    !SCTP_STRRESET_TEST(asoc, SCTP_PARAM_RESET_ADD_IN_STREAMS)) {
 			/* same process with outstanding isn't 0 */
 			result = SCTP_STRRESET_ERR_IN_PROGRESS;
 			goto out;
 		}
 
-		asoc->strreset_outstanding--;
+		SCTP_STRRESET_CLEAR(asoc, SCTP_PARAM_RESET_ADD_IN_STREAMS);
 		asoc->strreset_outseq++;
 
 		if (!asoc->strreset_outstanding) {
@@ -899,7 +907,7 @@ struct sctp_chunk *sctp_process_strreset_addstrm_in(
 		goto out;
 
 	asoc->strreset_chunk = chunk;
-	asoc->strreset_outstanding = 1;
+	SCTP_STRRESET_SET(asoc, SCTP_PARAM_RESET_ADD_OUT_STREAMS);
 	sctp_chunk_hold(asoc->strreset_chunk);
 
 	stream->outcnt = outcnt;
@@ -928,7 +936,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
 	__u32 result;
 
 	req = sctp_chunk_lookup_strreset_param(asoc, resp->response_seq, 0);
-	if (!req)
+	if (!req || !SCTP_STRRESET_TEST(asoc, req->type))
 		return NULL;
 
 	result = ntohl(resp->result);
@@ -1078,7 +1086,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
 			nums, 0, GFP_ATOMIC);
 	}
 
-	asoc->strreset_outstanding--;
+	SCTP_STRRESET_CLEAR(asoc, req->type);
 	asoc->strreset_outseq++;
 
 	/* remove everything for this reconf request */
-- 
2.55.0

