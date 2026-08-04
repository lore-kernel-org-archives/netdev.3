Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971F368282
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785802923; cv=none; b=eDHP+WXBdj0MUskKw6+Q1loW8gswQQHoxtkSUHqKlEZHI8vqn7makROmBEaaZVuv7LgIt5yJ59Di9oeBf7a4Aqbr2ThI+pM1StXv/fHvtywSwV9HNOv2Bmy3rryccA99K8tlvXfLqOr0tZG/VKC1Wk6jH6SYYEzVIHmk1f33EUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785802923; c=relaxed/simple;
	bh=nLTuj7zO+Dlww18YRpPOt3g6M5SipOZdDOMuG7636CE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BdkOAArsGRO6b9JUqwh6I5UHBrwiR6GXPzRTeZH+2FkXmh0stdiFdo2ClyPRuqZ2ydZ4w2Kmf//UgK+QGDcJqJ0FdfJfGT3F7MUtSzdMPDQqFc+oP0wbYHca7VFizfaaYCdCsP1+vg6+CTj5uH4CnBPpBZa5gA2ttBG3g4JH4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLnWHbbG; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLnWHbbG"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso5627004a91.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 17:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785802917; x=1786407717; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0IcuOiHYUxGVt6PVfk0+bFOdmJFhXMi6fCP50Tj/Kk=;
        b=iLnWHbbGMktau0dsKo1djo2x6+kO+NosL9SUiqAxkEoJ6Z+oMYn6g1zUL21KbFpaqh
         ohgZvtSiEOwuYDAX8q26n7b1pxLGwoqE+HLqMRB2b/oIViSjhxPs9+bFjEZ1d4ktEBDN
         fTsmoViIRC9uEbJyTdEMpknESiiRlG0FMJ0edn3q3CqbkCnWJSoLvFon09TAvjIZnEOG
         KSi4D9dZZKymgBQ4KkklY20OPtAdchzAJ5eHWPEmDhUu3+pWPSqkfGlNy9Gmq8XVU1Wh
         bOwlg1BhvLEgx31dPHiv9yTc0S6PiPSn+OkuLUu4CPHfuTg/EXu/aj7ud4isbzqtEpJP
         nAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785802917; x=1786407717;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0IcuOiHYUxGVt6PVfk0+bFOdmJFhXMi6fCP50Tj/Kk=;
        b=ZHhQlGgWyHvKldEJ/S9POsfBEryDlTx6hxb4li40JnOLEhzWJT21Hvj1ZpALxcvhMb
         ZKEz3z6sVWfoPqbxh0xui0cdqSKGMIyH9S8NW+Ho33gGlY35cpLuM+qanAMnqfGyEhHX
         1hkH5ePitq/Fnrwbk9/gUa8v3FUBau4GX/W5k85IJDhzcZEuPG07cxIMqnOapkKKrLCG
         ++lqh5T4x5pFYwHKR1qp0Yl1Ma00/UXryDsz5Yt3zCkqjh3QFs7pgQLprZfaCj8O+KVN
         yPrWX1PwufMEMj7opCq3nIBgVKEmFPHF6CSD716thFBHoU4NsdQA3HTtqQu/HGZtCBxU
         CdEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+/5B7fwjySma+mAuffUI3ZfVe/lLGzYfCRrR7taSfeb6tX62Dhz2kAESP+bhv56YVAp92Zj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0FLtKZSKHZAnXObKEQ2CLg5+cePEOXkUvMm76AIgH1HrGqhy
	itc4Gj3bpJYCe4fPMkaHnk0YOiuz4tFqdGNCRJ7dxqsIWrlk8qJMa+WfdC/2BAmLAu8hyIzxEB5
	y4eBQtg==
X-Received: from pjbgg15.prod.google.com ([2002:a17:90b:a0f:b0:38e:7810:7590])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:524b:b0:38f:2168:b9cb
 with SMTP id 98e67ed59e1d1-38fbc3e5c67mr10378955a91.9.1785802916676; Mon, 03
 Aug 2026 17:21:56 -0700 (PDT)
Date: Tue,  4 Aug 2026 00:21:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804002155.2233594-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] af_unix: Unlink scc_entry in unix_del_edge().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"

Kyle Zeng reported that GC could free a dead SCC partially.

The scenario is as follows:

   1) Create two SCCs:

       X -.   A <-> B
       ^--'

   2) Run the following concurrently:

      2-1) send() sk-B to sk-B from sk-X
      2-2) close() both A and B

At 2-1), there is a small window where unix_add_edges()
publishes a new edge (B <-> B) to GC but its skb is not queued
by skb_queue_tail().

If 2-2) completes before skb_queue_tail() and GC is triggered,
it judges A <-> B as dead, but B is not freed because GC cannot
collect the not-yet-queued skb holding the B <-> B edge.

       X -.   A <-> B -. This edge is visible
       ^--'         ^..'  but skb is not

This itself is not a problem since the next GC run will judge
B as dead as well and free it finally.

       X -.   A <.> B -.
       ^--'         ^--'

However, X's SCC forces the next GC to call unix_walk_scc_fast(),
and it iterates over A through B's scc_entry.

Let's unlink scc_entry before freeing the vertex in unix_del_edge().

Fixes: 4090fa373f0e ("af_unix: Replace garbage collection algorithm.")
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/garbage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0783555e2526..9fcaaf55cba5 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -186,6 +186,7 @@ static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 	if (!vertex->out_degree) {
 		edge->predecessor->vertex = NULL;
 		list_move_tail(&vertex->entry, &fpl->vertices);
+		list_del(&vertex->scc_entry);
 	}
 }
 
-- 
2.55.0.571.g244d577d93-goog

