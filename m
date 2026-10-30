Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334204;
	b=NFedpx+THGDV5lLylrIfX8G+HWcuHRjuXymNpAT8OK/CWM82QOoPwsJO16y2qjCeqHWU
	 lH4kvm9ipQY0LmhbeZSaCAWF5zM8uM+wK8v1arq3vRGKETtXA9GLivGv91JSilnjLSHhP
	 r6hVEPfpT0qo7s1/PrRO1nwTYjUfcCEOcsnDkRUdh8oIrEBblX9xs4l3nhphuCtNzV4XV
	 2wkQWJV4jOiksFqSasXJyAJqZ4j68rOxDPw8A2yptQsOly4Y+Oy6FOthI3K/ALdhHe98a
	 CQ54XBD+JHUXBkcSVNH4pEl5pjifaYyyq672jScc7+64UFVXKXkHejtWcpb5kGPG5lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rKEjNwOw3I9jkzOc5s+g5EecQmWBKoMG6BVKkxwXdEc=;
	b=X5DfkGK6XHM8wRFnT/OMBr0is3/u+IcUfRwOMJZiuN37Lx1ZxSdsmDB7lUDVfFXltvLk
	 62xTO79Kfd/erXpL2suEaHNSZ5lch92Uao3vmNIYyTz0smY1LO+uwuYy1MUIXozah3Mza
	 wdEK8QWTmMuAyleOumtIhzOWidqlowjsXco/MUhXFsnVzWLaDpDQyPA2Sbzr7BtRfJge1
	 03E6pt5PRdBO0Bn8u8DQyqIQL07THDFRWrg+/k3fowgAp6ynXEgAo4Dw17wU8fTrqITwj
	 8OhzW/R3LOCtf4VnVbcNRSkw6tYGUw499cwLx/157/BJNyvwD2TPnouG19ynsCEXmBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=FghjVlFY;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A05606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05A05606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=FghjVlFY
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6faddda49e7so196686eaf.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334203; x=1793939003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rKEjNwOw3I9jkzOc5s+g5EecQmWBKoMG6BVKkxwXdEc=;
        b=FghjVlFYMvCfSv9cB9Vtqen3PR4e9RoJraqGcWvZLvfGIXkiba4JQG4ZHkxRfkJrB7
         ZZ7Iz7JBADqcS1Krbw8sHeuFsn7LyEp9M5SDI3pVtLjr2HGPTjO/eWBpR/FoYeMy1pHX
         VkbIEYRK2Att2oPTJrEM5YSDWz6PvE5xtNKRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334203; x=1793939003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rKEjNwOw3I9jkzOc5s+g5EecQmWBKoMG6BVKkxwXdEc=;
        b=J8E8GvvPTYri49Obi3ZiFPpVhtO6IEecmGmkKkXj+4ZT+0Ef8FnBY4OLcT+NhDqQKT
         G2eISTODHonEbyp97YWA1ZIrdHpUjTj+rNtOzva+1eVVQbBbi3jTv3cFET/9Yl1MgDt6
         PCEnuOuotmPeBpe4PiK0/u7lZCiNQo9aaAB+JxeNY1XhEJhJ37CBBixGYED7WcYsSJAv
         ON5IgwaCYn2j4zG9oUa67kPp5w9YKNoUwJJE1fYSQGZ0NjYwcLIx5+HOUsRMaqPKRhLd
         3hl6Eiq4vqGbJJCtcASz55hycFMwLhUorKqTMHUzS0GcznmDIxku8fZ1R0XIn4+nyftN
         yK8g==
X-Forwarded-Encrypted: i=1; AKwUvByGSIZF4OAfCKaq60WTBBnfnytS6bLYyYh0kwSPCywReHh0p9F9aJMjv4wSND8X/LHiDHQBK7o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFOZG406/P//H3d5Vmgr8yB70XJcIPt/3aZcLEEiu884O2Kod2
	Dv/IM+U9xpk3JyOPzWYbWE8+AtL2sc5uBmf+ybEOurhlsSY8Z4bqUTTQy4+4srRE2s0=
X-Gm-Gg: AYBFou1YFg38c3XPeHDgEuWwralPKR2XqmP6k43EgT5iLDYYENTYFp+2PTqDBo7IP5f
	snFIGFOdGI8GAzulH95v4rNQ2S+uZBtcv7vRpH+kTO92TUapAQfZ1bD9PyoyAEYKikkn0FeJ1Un
	kTgsyqX918Bmg7ZZMyyNuz1M2SXNYvsGizeb6E12kRNBvmjwMDtu8XNJmdK58nnknHt4XGu2vVN
	ihjaX+RvSjddPqvEA5qcNtotrlIGbg20528otlNdSdaZMdG2f2f0/67y6+ASgKrxzSim5TdR1y9
	ys0sS3lrIO+PrXtMD+EiAI1KWqQMmDFe3pmf/DYzkBrDz76tMtqe8nTnIIxf4TwxFe59+B2XlOb
	0soWqVFwVpJqcIA5xRi4GpWU66JhpfF/nixsjx48J9Vq84DOnWEcTetYU3pHeGJhmvTa+WlC9m2
	ORECWQteWkyDe/7pvTccjpJ+GEWAx3vyBUFKgWRB04BMRMpZ5P9cEkI7Tza+qwyxTB5FWQtKZNj
	tqKBTmW3sHuKbM0qOmY5feXf6adnwuvKU53Mh53uTUh+Vncx/e2vqsuAL3ztnvi7pGmrR3d/Odc
	Mw7jnKZOq13mDo4Cgatwn6MtSspLW4JLFHTcj4+3ohban1MJJtoGGV28cfr2bgi7TdWjYiCsdSw
	zPyj0P4dw5gEAOOA04v1/6z4fEpQuFg==
X-Received: by 2002:a05:6820:8599:20b0:6b7:46fc:1dc with SMTP id 006d021491bc7-714f29af088mr598492eaf.59.1793334202967;
        Thu, 29 Oct 2026 21:23:22 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2a84854sm1052342eaf.2.2026.10.29.21.23.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:23:22 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-sctp@vger.kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] sctp: avoid requeueing pending control chunks
Date: Thu, 29 Oct 2026 21:23:21 -0700
Message-ID: <20261030042321.74407-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

The T4 and RE-CONFIG timeout handlers take a reference to their cached
control chunk and submit it through SCTP_CMD_REPLY. A previous transmission
can still be on the control outqueue when output is corked or suppressed,
or when sctp_packet_transmit_chunk() could not append the chunk.

sctp_outq_tail() then adds the same list node a second time. In particular,
re-adding a non-tail entry can corrupt the list without being caught by
the insertion-time list checks. A subsequent flush or association teardown
can walk the corrupted list and access an already freed chunk. The T4 path
is reproducible by an unprivileged SCTP socket owner in a user/network
namespace, with KASAN reporting a use-after-free in __sctp_outq_teardown().

Check sctp_chunk_pending() before adding a control chunk to the outqueue.
If it is already linked, release the extra reference supplied for this
enqueue and leave the existing queue entry in place. Continue to the usual
flush so that the pending transmission can be retried.

This also covers RE-CONFIG retransmission after sctp_assoc_rm_peer() moves
the request to another transport and starts its timer. Keep the existing
timer handling, corking rules and data-chunk path unchanged.

Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/sctp/outqueue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index e92fb9da4647..a5f9f0fcf5fd 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -304,6 +304,11 @@ void sctp_outq_tail(struct sctp_outq *q, struct sctp_chunk *chunk, gfp_t gfp)
 			SCTP_INC_STATS(net, SCTP_MIB_OUTUNORDERCHUNKS);
 		else
 			SCTP_INC_STATS(net, SCTP_MIB_OUTORDERCHUNKS);
+	} else if (sctp_chunk_pending(chunk)) {
+		/* A retransmitted control chunk may still be queued.
+		 * Drop the extra reference and retry the flush below.
+		 */
+		sctp_chunk_free(chunk);
 	} else {
 		list_add_tail(&chunk->list, &q->control_chunk_list);
 		SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
