Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560898;
	b=czLLb5y7iEsqyeNlV+oYj79ucCOHX7MCIsaMisXxAW8P7gyncEFwby+eY+pko6d2KT+P
	 CqRE9yMuZ2PdYEu499uqjNg7pwI6cdwTBKgkSUrKMagyC+m7tPnUbV5rZfzMuFUwsLVTY
	 zC4fpYic8BqGugEC5KwZITEWQmgMPMM1C18EhHzROkZyDaPqDexvMSK0NQOZlXPRaap1d
	 wim3bbAzWDNBFhudZdIteZG6ibhyOjMrpTr7HBcYw1iKTEh4yn7VC4HqGrAoKm+ZPucOF
	 B7uU17aPN/hkIaLUR/2NYKaki/33UmEfqVjmG59D4jVWB9YQrOVyWeXCqjYGniFbhgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
	b=LQVVv1PJtDJKviBVgAf+jG2vu0xjmMlSVYnXioz7T+o3KDIt06uPPbnAy74+HWPInvch
	 NvCzlWCubsYxg64ct9KupcITZx0eFFxs03xhlQXwuPOcqQOtCH/XApVACf6GgR/ue7Tx3
	 dbFgJNb1lE7l1ZA14qLcGdtrPL1QTg5cy1XnUY8Bm6HRM+ZJ3qu38iPwNkj6i88rH6gKc
	 CmIgoJo0+oCM0JgOmSZB6sDCzgfaIP+4lgbetBjin7Euj9Sfj/uxtgL2NPslMZA2L56VS
	 zk1QOzLqYYNxHqvdQeH6FO76GB2NCTIf/KSzMWEhFeFak645yv+D31AKzf5fW5/l4NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r+GOKGNN;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18F606A331
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE18F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r+GOKGNN
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9d7791b00so16769355ad.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560892; x=1794165692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=r+GOKGNNS60DMc/LKDFnqtHAQT/kDfV0JBumv1Y+EMzDQWPz30ElureYT+n2N05qI5
         fk5lDACxZUQFvgmGzvdoQq5vDWdrXjFh5U9HsFnafQ36bcsyeM2jprdTypSylj1mTqiK
         mFykJwUQlwyEX3qPcDt1XR755tk9RrLMBKmQ4k1GIZ4vNNmvzc63sumFv4wB47jz1tCf
         BHu1c7smkjVoesQEZnDio3gSqMRz5XwzoDS1kdnHvo6NJL+wi3KzE+PY7uSq8wBA9cov
         iHy131TrP+UAqeLJtIeFIGvKsYcwPPlpdoW/3zv0rHUDQiNeQdZSgTi5/BCVknTbp917
         6eOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560892; x=1794165692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=rjvO+dFjT357BLtRmuTCmWURU1rVEEcbuwPN2Ab5W6TBZDU3MQyGBQSeHvLNthftd8
         mCJAEfSk5jzMty4WdXyDMdNF7IE1o+7C4uD2gsSjDKkC432A//KNC+hA8XiJszZN6FdC
         Dmyp5wXK++yxWJon62LRT7KyUVaETWiY+CGifSiH+8acSjheIy4QLehg3Ajk/shP4IOc
         gW8UPz1MovUl6NJ09O/tSwmv6u3Ob3aEd+ckD/tkqETxH6Mxieu5ArBt4yi17fxkMhZv
         v3qiLU+IpYxgaMOghEurSkPXzMyOs2ssAhwcXGHNoaZ5rJQZXdJXICuFfUcKEgFAwEiJ
         5IdA==
X-Forwarded-Encrypted: i=1; AKwUvBxWOkw/fCuKY9DKGBwv2Bhav5lghCXrxNP/nEbOa0jPAXqO4E3iMb27sR29ic48sAFaBubWRIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9C8KSFzkU+5OyDQ2Tdjbhj+GkOdtCSRwXni7M4RvPsskk2dOOe
	2cVda/okC1eh5uB502DkLhyBe7pjzOmy0A4Gn33uzZlU4ILQQYPfnCCxJnzMrQ==
X-Gm-Gg: AYBFou01zEwmDGaxcXAiMWZZ31z0XlO7GgCi30dxr5nr8Y2w6Q3SilCXJhGbz5ci7SO
	TZnJaah+efQjQoQByoYTm18YmRyX7qb5dqBMmSiiJLMI0evPB6WhzRyHUXnnZmsAUv/aXWQrkuC
	V+o4qOFM+8lsSnPeYRPqmf9Obuj/BdJrORnyobpmiLPcqNmDUoRHGYOylqeEXEFnAjpQxRRgOlj
	sE1SvsJiWzDUItG3J1SvykvjPdcik+UTB5dWmsGyXY7q1Iy2fXl2t6xAeDW/BoZYnF5wVbngzQC
	zK42sA/xmdUk2n4yiIcrhEsQNKLhjuwly0maKEm/njRaY7VHHQvR+rsiSrqJaS3ql1kMRYglBht
	VEVYnL0LTsFcHDGGtUj5SdNxt5qqOWLxIvnXGyWpzNoGwdwBAq9ebfQ6sAgORH0zwFVxhVYwRm3
	TZP6WxzkWIKSrSEpjR+spqIf9MxBKR7IzksFCrL2WFZx6sgKu3Ezvu8GMjRkN9MKHV1cjuoOZVc
	UolkAAEWCdIKqqkm57A8hiU4m2OgHHmq+BOA1nQmGpos2//WS+kTRmShbl6WaQoUqZxTFOFZgHX
	X0vnoDRaDupqnQbdzOtHuAdakSiRjUBjH6NtPzwrbWmClUo8qL5PFsLcIkLK1FoAJurcJiIrxVS
	Kxk6t/9RtKCg9UrgsnUjP020I/3yr+/wwg3TZKfPCb2EQ+wC9fGFK0Fwb0j5T3zl42bwWKCji79
	j5EDcUH9/6WBNKl/bSEHyT
X-Received: by 2002:a17:903:38cc:b0:2e6:5ef:abe9 with SMTP id d9443c01a7336-2eb364b6332mr64259095ad.37.1793560891567;
        Sun, 01 Nov 2026 11:21:31 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39248621sm18975285ad.28.2026.11.01.11.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 05/15] bpf, sockmap: Clear the resume state of a stopped psock
Date: Sun,  1 Nov 2026 19:20:47 +0000
Message-ID: <20261101192057.2296489-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

sk_psock_backlog() passes the skbs of psock->ingress_skb to the socket of
the psock. When the socket has no room, the function saves the length and
offset of the remaining data in psock->work_state. A later run continues at
this offset and clears the state when the skb is complete.

sk_psock_skb_state() saves and clears the state, but only while
SK_PSOCK_TX_ENABLED is set. sk_psock_backlog() does not test this flag for
each skb. If the socket closes during the loop, sk_psock_stop() clears the
flag. The loop continues, but the state of the completed skb stays. The
loop uses this state for all subsequent skbs and sends only part of their
data. A closing socket may lose the end of a stream, but not the middle.

The state belongs to the skb at the head of ingress_skb. Always clear the
state when this skb is complete. A stopped psock still saves no new state.

Fixes: 3b4f14b79428 ("bpf, sockmap: fix duplicated data transmission")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index f03519468ad1..a5d498982848 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -664,7 +664,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
 			       int len, int off)
 {
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
+	/* No new state once the psock is stopped, but never keep an old one */
+	if (!len || sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		state->len = len;
 		state->off = off;
 	}
-- 
2.55.0

