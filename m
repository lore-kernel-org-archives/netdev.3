Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68726A08A
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787103524; cv=none; b=PWz5BCS+yFZ/NoVAn4ZHTdnf1J3d9ffjIwFl2hchCxWH3j0OuxMILQjArISeS4HUVu9Dhoo3UnZDFos7wxpQnAtCcTpxIa+a8x9rLa1OIbMajR30b9YB4HwQYb8SngnK3SM26Yy7dPYaq3MnPgsXVv/EuSGFuO8lFAZ0ym4K9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787103524; c=relaxed/simple;
	bh=LFrAOYXYKD2eZi92nlYeYNfprg/amWabLxum55E9ojs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s2qPWlgUcLij7ZUsa1O7ClDyrCI/QdfnGe9VaU61URpFP2V1ePZEzQt3cc/5Ss7vgKFoIlxP26wC9RtQl8nMePVPQSBevVrgrRc5h8Q9TOw7tg3S0z2IzlvhYq4xaATBjyJv3am/XNUt1UkXKDGCt2+noKzb8kKXR7X7x5ar9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXitSGyn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXitSGyn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso792134a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787103522; x=1787708322; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZ8i5JGHu3nT+RVW9GRgK1v513n97DoASsTZpEyB5GU=;
        b=MXitSGynUZoA7sHL1hBAultlhx8TzO7cVZvEO56TnO44i5nD5fHo76ef8+3bNJzI5m
         eIFzg8gFLuoAkRbwN0q5LRoedFCLxQcD6rVULUK2OfB3MdjH5qRVKnjpf4bWuX+g4vSP
         Aaf0yusBz/ZUIR8f51DRO969VxG/umt4+Q7S5W2HV2+1PTiylRfxMdtswFsenkIL92s1
         x4PCs6DJEcWPvAvQHcfQy4TtTthfKp24eSnR7JeZLsHKY5Uo+5p7119Xgdw/ISJ5qNvz
         1gX88USSMk/Ls0Gouo6ABRZfxSWtbSML2rY89vkIlkHIfuDECWc1JWwOl0R09NZ5wVQT
         I87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787103522; x=1787708322;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZ8i5JGHu3nT+RVW9GRgK1v513n97DoASsTZpEyB5GU=;
        b=OPshECQDmdO+IUUjY+TIRERaeq6NU4FBSKANM+egNujtejAlAXYDNdX2WYhRIzsE9M
         jOXhkJLA8zouwimVvKJgXp/BIUGiwZShcALNO+3UwFYArx7M/Knp75d6eNxfsRGQUhod
         psFdH4375JKjSkQURTG9Cj341Az0GgTO0lRLeZdT+HYT7K2X/eYMBWQOakX6pGs4/1t9
         e9GLa0quHBG2hZfIiGWV3y3FfkWtkTUiL0t1O83Q2eqVSIO7ajI/nAaVMTLFPrtgGRJK
         ZJtI7QfhEbtnCBj7B0eFq8IgRIqRgC1S3Nt/PUNLKQWI/lKcM5F8mZp4lWFbzuFidSmM
         nnPg==
X-Forwarded-Encrypted: i=1; AHgh+RrrPaPW3gWI0UVg2jwP7A5bMGrVsGc1mxSNHoZ6TJCp+3e3ziTqJ/1Lw6bWsvJ1rrFf4jNopD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybGqEVxfa/jQojCR2MAkqx2Op4mXzmxZMCB+UyCwr0aX3xMlQV
	ZSBbuSBcus0xJCYn4HJs3nnyi43iBPJd487IgrKA4pkhs4Vcw1Q9SDFm
X-Gm-Gg: AR+sD13z7jUmrB/p7jhsBJJzAspDfbG5IgcI3/tfqMjwEHwtWAXXEOO9n5c2YKV/uSv
	P+IGSTagqifvjcPwZjJDVz2i/dBKpSt2bqDwOhs5GchNA0rBCjLMn2vIZelBUVSmiDseYHNQEyX
	2M0Z0Q5algE/gHqqffSC/iAmVdzz9IGjiOtBeNCRnQapqQq8r7qVPrnMPLsoXc7je7MJIbS20E2
	i5afEvhYb17Gsgfe+AkNxVExLumewRkaX3siV1aZYKlu1uky4kvpbeOfwA2pdxBwJcgm2fTY7ig
	MjES1DW1LrY1Lxy+un0/J+sRMJoa7UWQE8Am3JjSvKS6ohyDvLOQM+4pdjeloxTSLeWeyY8c3+d
	RFJxCvRWq/98VF8lICdR+5oMkKH/ixqLQfhWU0pBIVPlw9B7E+x7copLB7Y2yXbF3OWTSgpmreN
	RhmCnoxeIbUrhlMeGllYMlME/pTSCPeV1ocI5p5h8d9Y4FNRYLiCLlwlZIJ/nciDRC+F4Aw8K4d
	PQ1Tkjr
X-Received: by 2002:a17:90b:510a:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-395810df1b5mr2140618a91.17.1787103522343;
        Tue, 18 Aug 2026 18:38:42 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb60a2bsm666018a91.17.2026.08.18.18.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 18:38:41 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:38:37 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] sctp: drop a chunk if its transport was removed
Message-ID: <aoUJHQmxL0LFIMCw@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sctp_rcv() resolves the transport once per packet and leaves it in
chunk->transport. The lookup reference, or the one sctp_add_backlog() takes
if the socket is owned by userspace, keeps it around until the chunk has
been processed.

An authenticated ASCONF DEL-IP can remove it in the meantime.
sctp_assoc_rm_peer() takes the transport out of the association and calls
sctp_transport_free(), which tags it dead and drops the reference the
association held. There is a window on both paths: the packet can sit on
the socket backlog, and on the direct path the lookup completes before
bh_lock_sock().

The DATA chunk in that packet puts the removed transport back into
asoc->peer.last_data_from. Once the packet is done that reference goes
away and the transport is freed by RCU, so the next delayed SACK carries
the pointer into the SACK chunk and sctp_outq_select_transport() reads the
freed transport's state.

Drop the chunk in sctp_inq_push(), next to the existing rcvr->dead check.
Both paths reach it with the association's socket lock held. The peer
retransmits it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Move the check from sctp_backlog_rcv() into sctp_inq_push(), so that the
direct softirq path and the socket migration branch are covered as well.
- Correct the Fixes tag.
- v1: https://lore.kernel.org/all/an-oGfEatacPTSX-@v4bel/
---
 net/sctp/inqueue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index a024c08432471d..5f988b3a8814ff 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -71,8 +71,11 @@ void sctp_inq_free(struct sctp_inq *queue)
  */
 void sctp_inq_push(struct sctp_inq *q, struct sctp_chunk *chunk)
 {
-	/* Directly call the packet handling routine. */
-	if (chunk->rcvr->dead) {
+	/* Directly call the packet handling routine.  Drop the chunk if the
+	 * receiver or the transport it was looked up on is gone.
+	 */
+	if (chunk->rcvr->dead ||
+	    (chunk->transport && chunk->transport->dead)) {
 		sctp_chunk_free(chunk);
 		return;
 	}
-- 
2.43.0

