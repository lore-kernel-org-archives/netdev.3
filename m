Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604163;
	b=IVA8N+jPRvB4aPWsKHWXBfs0Pm1TrrnM/CeflLDtMY9VwVHUQB1HeikX2s0c5imZLlly
	 QN+qGyPamSSirBIZeHmq6MSRbwkKHMyx51yUDzMRbX2Wznk20L7rig/Yk63ImiiuRjkbN
	 ZUQ3ksnLCHdsRR3rE/Rl3Zv31Hsief4J2RhexsyLFY+jGAT3cMqm6SfI/AhqlPUlyuWIS
	 PXYMR43FRkFHnWDFZBgUBBttAFDz+iI3Qp/wjk4KnnWXP7cu00S7vYe+tp9f6HT3z/nvG
	 RdOhYLw2wDwmNPGQQEJyCQZIzgG6FWUCV03pjbKfsrhPvv5u+tHl49d+djnnECpBBMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kV0Z1USHTSrdHd41dgedNKXyUstH61hWM+CBeGfT+gI=;
	b=lu14gvJoEmhc/Z3ta863mrXnfX3NCnZ+juZH08AD8KhYkeuJ5CQtB+UJTreABlCfy19y
	 YtObcRhkC28IXKXmJmv6SDkk0TAkgY48Pm2wfKdjNGoNi1TU8ViVGNwcOg88INoPmU1TZ
	 WyPwsqMXaODab/orF+vORsIsMw7qH83SJp1Af8gxMRWX5zR1QMoSKXAeP0Oe4fLqiwRIq
	 PohstGAjCQ27Q1nzARsLWPJTEGj/NtqY3aY+LRd6llL165PLxx7654RTnrDAXAslN8kJf
	 oE9BIohSP6zdqGuGcWcIP+0oy2I3mpz6/nwZuZbUIsDCnWJh5Mb4vv1rR5l0SP7+r+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n723iRKO;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ED2606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6ED2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n723iRKO
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8246b13cbso22201165ad.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604162; x=1794208962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kV0Z1USHTSrdHd41dgedNKXyUstH61hWM+CBeGfT+gI=;
        b=n723iRKOc3RenQYZgKJq3yYeYR2XHXCsPK0uiL9Ltt/p0Hj52c3Sc7ajFo6I+VPql2
         Jm8i5TkRp4GbWVvboaKYRU1vIC+H0r/dQWbFkDqN900rtWP6gh8sQb9HKQRZMVxwgbp6
         zhXCBnY++CzGMtktaWRIF0tMYl4VM29Hg+3LD+L8Z12U2PIZM6S5szj9u2b4CwO52kjx
         dEJ8SLgFZ141A60mK3ZoU5SsidlzNoe2deoHpiUZk1opqOJpnTh++B/98NM+maMQmW64
         iYTbHJqBQJEeaPvEIHpcwCxq38XSDyFzkZBAXHSliQiG5iAvXYOBrADNZXBdIJWFC3G8
         HBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604162; x=1794208962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kV0Z1USHTSrdHd41dgedNKXyUstH61hWM+CBeGfT+gI=;
        b=M2JS64Sc+TrWYf0JJjF7DFY4HPYuK4E8sp4tYU5Nr4me160cCHF75GY6rTa37e1dnY
         nYxl9lB8nsAaqeuzbxOuyKvHzOk6k0Gh9KlYl4dWGzfvzBmQPD6YMY8IjRJGsbRAQ2lO
         88t4bvxY2YP5Y18hTUL87TaUbQVPLBxulLZv+srZwmzyY8TFJB6uoXE2P7M4uLX9Dwqk
         Gr0VOIu1n3NSs7A4S5D42qkjPoSwlB9t3Ew5SfWp+o+yOEhUxMDPvyI/Z3cYh1yYRxXh
         qARUBl3IqaKod+8h3ks9oZcYogkY3RUbO10t3qFvWuttch8fiZHQ8K+tX6ko2pDekdJo
         gOxw==
X-Forwarded-Encrypted: i=1; AKwUvBx7Hj/13uvIKHYtLVWFcf9K647iVZXghNVvufgzuw7ZiV8n2nAVZWM5JyLz96x+6wzXxWKj1js=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/LJoI0KzlllN2va3FPDdrEg5y/sCstiGQA45sRpmfXXkkKiSG
	RvrJ7WzQVM6T+ddyUZ9xykTK6V1ifkpqda2zUReMcXCeUEEBVdrqa7bI
X-Gm-Gg: AYBFou16+ibwwsLg689SiVp63Cq/gsSR9hF8agFuSMRe1TADwMfatFHS+ayFkIGXqaH
	mheZsgOtvVM6kMMyWx/hyUt+VMGDOqmolB+DtElcbQIoDZ0MtmplLZfnZsvM0pU6diWNLKB9fn+
	EKIW5aQAKk2leDrJDiRFm2kh9Sm4LyDAUyzAUquhcrdEi2berZ9jxXJZlRQTz+1ka2fmWm+75H9
	p7/h6KMR51PUH3lMwy30hk4ffo0THYU7dXMjJlI4qA1tlsaxkVaOA7KFCMLvYAktEELp56ePlrq
	X++VUQ0oMxbr3yZu31qGpqVDLrFWYuLOfbKcPkmNiBeSb3Iz9auVKNPjXsfTZ5TVcoYsLgUiSEu
	e++m4R5Rmw6FtrpHVbst3q+VAe69qaQEsIOh45PXSCL6hA5Y5gg0rZw8LByjN+5ZmUahtB9rcUI
	SXUpVpY/b3Y08l4NIRGKfS5KEpJJmD+Lz/dNugHMlDXGQ1liw7Pw5dUxmLkJJiaxtxa+MkxKdX8
	TSYT2dFj8b1k8+Ayx3OOl07zuiWQeAb709MyVmpodNqlnYZHHFbvNgIq1aAD7Kidpcraktz6djM
	Whf1ai1E4FrpkL1g+jAUZkBp7a2ifXRqzyPRHZU0DbLZLsvo1ynKSjwFBJJwR9NZ5AI97Q0x6xs
	/3P10Q+qbRdXd9AVG4qO35J7ZLQHenJ9NntMKEZopJwQ6dl1q/3w3+Bs0l2ZMsAdd2SbeuKTK6A
	==
X-Received: by 2002:a17:90a:d2ce:b0:3ac:9176:e83c with SMTP id 98e67ed59e1d1-3ae89720616mr8312885a91.12.1793604162098;
        Sun, 01 Nov 2026 23:22:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845df666sm13045987a91.14.2026.11.01.23.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:41 -0800 (PST)
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
Subject: [PATCH bpf v2 13/15] bpf, sockmap: Check that the redirected message is the cork
Date: Mon,  2 Nov 2026 07:21:10 +0000
Message-ID: <20261102072112.4160195-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

In tcp_bpf_send_verdict(), msg is psock->cork or the sk_msg on the stack of
tcp_bpf_sendmsg(). If psock->cork is not NULL, the SK_REDIRECT branch sets
it to NULL before release_sock() and calls kfree(msg) after the redirect.
Thus the branch assumes that a cork is msg.

This is not true after release_sock(), because a second sender on the same
socket can make a cork. The first sender can run the branch again, and then
psock->cork is not its msg. Nobody sends or frees the cork of the second
sender. kfree() gets the sk_msg on the stack, and the kernel crashes.

Compare psock->cork with msg. Nothing changes for one sender, because
psock->cork is then NULL or msg. The other branches do not change, and a
cork is still not safe for two senders on one socket.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d8e29b09818c..b1071b0960cf 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -517,7 +517,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			psock->eval = __SK_NONE;
 			psock->sk_redir = NULL;
 		}
-		if (psock->cork) {
+		/*
+		 * Another thread can make a cork while this one sends msg
+		 * without the socket lock. Leave that cork alone.
+		 */
+		if (psock->cork == msg) {
 			cork = true;
 			psock->cork = NULL;
 		}
-- 
2.55.0

