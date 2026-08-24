Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADE3A6F0B
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559530; cv=none; b=PnlKtnEIl6iWe9n6Py4FHqWtC+D5BxSY0t4eh/YmGH50vZsoiS1qoFhbtIlY4incHtuqVUWmNcVDBHe++dMUZcjsyzbGFKbnbtUBizK8WaiepYVXA3y2FlULu5BcfYAvJUed8NBgtgRWoZnyOBPO9SvP4fbee1ywcNnb+J+CW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559530; c=relaxed/simple;
	bh=wnYG4ALRAQO+J0MRn7HBk0vlqcltLxFg91fVQD834Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUevyJEtFbf2tNiOHDEFVN94RenwDQNKuBegYoRvqhABI8w85Ozr+xc8eFq2pJKyGYjeohX4EDXcJdZ6yNQ87VN9+zIXzM42TnwE4Su28UjUSW6e9buVAvlVz+0p3YFcGe+6ZFiG/j3MtPzxd7prubf37KoEmg+LsSq/6urPuRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBuW2IWV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBuW2IWV"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so4404003a91.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787559529; x=1788164329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2tkN52CQNuLVgdDHNlEmZl0+tIMbIk59CcrWVNUVU4=;
        b=aBuW2IWVlRidGPHOGfuNHFaXQTGecFh9t6HekUpbXL8g0mqEKEXbDWkLYiOimXbt18
         vBiYmmjp55Bg5RJxr0T3J9AyBuY4Vy70/5aTjPvTO/5FV7latWAWNxtLR31Y4UqrbOSi
         1M/upHj9vgq8lg01TlEqAv0IVkDuXEBeaXBBhxbbNbQB2O4IaAK1UTaHAlANwhQbYhVP
         YHZyL/ooWj10dZ8/Pna3uqz+XkCf/HDK+PHQ85ykNVvUBowMWVublHbVIa3bgDYx1SG+
         L6aVS9VRL6guF0+mT7Gi2ctnnYAumdVUD06gYkTm0jf6qhM5N9qW/t7hV9RR793ApPmD
         WPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559529; x=1788164329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e2tkN52CQNuLVgdDHNlEmZl0+tIMbIk59CcrWVNUVU4=;
        b=OaNN7GZ+88F5tgxtCD1zwlwirvxynGn9rgQOpc5ZtvkzOA7ShFKpANwNzvjo718GKl
         Q4t9E4+o01H4pTr5in610xgHsS2hEoGxqzt2q4apxpNDq6XLCly/2LB1ZHN1fxNjMboP
         hx9B4hJL1y3mjinBdhJ07ANqTs20e+02eu/j0/UYaz0D0YwHhRVqS57zXZnl9/Q0WgNF
         HyQsWUi2XeMLGFv0HKq91DyzPfgN8Ui2ySbXZoPj7ovJFRO4OD2QxAZIl30sasZQoP48
         Gmfa2Uh3V1GAumMPO3vADrHvIIuUSbOvy0astvEjehJTBNlwZgphsz89+8zJcDqAUXTm
         6CnQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKfjSDaZ1ncWRH99S6Y8RVZx2cCwKE65z9wqHiIqxjF1A1RIbN6ZUd+/WqT7ue5CVh97uMmBM=@vger.kernel.org
X-Gm-Message-State: AFuF++kby+Jt/sEotEqpAxNl1zLLOlfcoJkQK+RNMDFX5JzotVvi2syR
	hY23shZBaAbVItKDE+tbFvSZYxsZkeZkyco3tj0Gh0eIXjtSHI9W6Ixt
X-Gm-Gg: AR+sD13XdYRH88+Pti+3KpAJQcfZ7Qa0JGEiCYEzUwkFF7bjyeZr9WcwejLHcO2v/4i
	wnIgo3JvXl0GM36/VTFbDkrkeRhas20DJi/Ht1O5wtkze8EZlhA76abmXpaQkHLPXZ3wy+B9NRi
	tRpkoxijphG5NPJ50KW+5N3wmZMXol//SdNf9yJFDhSUvj8zfKxdeAnTi8no/rL7PygybBDdwW6
	lbXb+8xJi+ouvWt1FklZDBuXh4dZ8WJAtPsHc/9VnKFLs3NmR8u5jZrBQYcD0h4Ys1uhqIzPlrF
	rmPj0hGHCY+OWWljGS02WzaLGgpIrejPCXDI8ssma81i8nrrkUY8TjOS/dZGJpTnpaCT1JPxS0b
	VaH6m3LxHzJV+4GMp1XndeZeSgrfRG2W/jtzrne2q8yEgyfS4Qu0ZO4t2HdTSA9slyr3Yt8yjB6
	74PlJAhTn8nUZZLzbbOf59c+gMPtgJNl3aBFF8nQa7A0FY5UkYJ+/cP8oKl9y5fyvccpLxnM6de
	9b902jjqhjRvdmhzjv1yO2u0VZ54sqCDVXCVA==
X-Received: by 2002:a17:90b:530c:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-395c35e25e2mr40462864a91.11.1787559528649;
        Mon, 24 Aug 2026 01:18:48 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4999471sm9079775a91.8.2026.08.24.01.18.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 01:18:48 -0700 (PDT)
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
	stable@kernel.org
Subject: [PATCH net v4 1/2] sctp: distinguish sequence zero from wildcard in reconf lookup
Date: Mon, 24 Aug 2026 16:18:19 +0800
Message-ID: <20260824081832.98717-2-juny24602@gmail.com>
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

Zero is a valid response sequence after strreset_outseq wraps, but
sctp_chunk_lookup_strreset_param() currently treats it as a wildcard.

Add match_seq so response lookups match zero exactly while the one
type-only lookup can still ignore the sequence.

Fixes: 50a41591f110 ("sctp: implement receiver-side procedures for the Add Outgoing Streams Request Parameter")
Cc: stable@kernel.org
Suggested-by: Simon Horman <horms@kernel.org>
Acked-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
 net/sctp/stream.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 34ffe6c945a4..cfca5aa28c1a 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -482,7 +482,7 @@ int sctp_send_add_streams(struct sctp_association *asoc,
 
 static struct sctp_paramhdr *sctp_chunk_lookup_strreset_param(
 			struct sctp_association *asoc, __be32 resp_seq,
-			__be16 type)
+			__be16 type, bool match_seq)
 {
 	struct sctp_chunk *chunk = asoc->strreset_chunk;
 	struct sctp_reconf_chunk *hdr;
@@ -499,7 +499,7 @@ static struct sctp_paramhdr *sctp_chunk_lookup_strreset_param(
 		 */
 		struct sctp_strreset_tsnreq *req = param.v;
 
-		if ((!resp_seq || req->request_seq == resp_seq) &&
+		if ((!match_seq || req->request_seq == resp_seq) &&
 		    (!type || type == req->param_hdr.type))
 			return param.v;
 	}
@@ -564,7 +564,7 @@ struct sctp_chunk *sctp_process_strreset_outreq(
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
 				asoc, outreq->response_seq,
-				SCTP_PARAM_RESET_IN_REQUEST)) {
+				SCTP_PARAM_RESET_IN_REQUEST, true)) {
 			/* same process with outstanding isn't 0 */
 			result = SCTP_STRRESET_ERR_IN_PROGRESS;
 			goto out;
@@ -816,7 +816,7 @@ struct sctp_chunk *sctp_process_strreset_addstrm_out(
 
 	if (asoc->strreset_chunk) {
 		if (!sctp_chunk_lookup_strreset_param(
-			asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS)) {
+			asoc, 0, SCTP_PARAM_RESET_ADD_IN_STREAMS, false)) {
 			/* same process with outstanding isn't 0 */
 			result = SCTP_STRRESET_ERR_IN_PROGRESS;
 			goto out;
@@ -927,7 +927,8 @@ struct sctp_chunk *sctp_process_strreset_resp(
 	struct sctp_paramhdr *req;
 	__u32 result;
 
-	req = sctp_chunk_lookup_strreset_param(asoc, resp->response_seq, 0);
+	req = sctp_chunk_lookup_strreset_param(asoc, resp->response_seq, 0,
+					       true);
 	if (!req)
 		return NULL;
 
-- 
2.55.0

