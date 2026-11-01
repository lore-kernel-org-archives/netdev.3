Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560946;
	b=SUyY9ejs4Ycn0ts9kVntoqsv3Jwmp9DoTU9J+TAte1CuIXAM3JdiNfyvkaG3Z7K7xAUl
	 8ryDDalcNYWrSW9SD+E7zBTwvQJwtIF4cm34qE50z2nuR8p0wtwxYSVT46ie/PF+qTi/x
	 aHnuiPdwonYlUmLILEyTSiBsUel9bJsNPxdIJd4SyMUt+bND4NNTUtsRhJ7cWyLSKm+Z0
	 WcScgiXArpc7/Cg61b5fr8rMZnr1VQu0KIuIfDBfZ/XWZk9YR4z1/wpcFcR0bTMnnNOg6
	 JMzU7WInIHo4OJouAQkHGXQgoXcsnPzBzOvvu8f89re7WOhLRQJ8DQia3r8UJauzTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ri0soL3Qksj5Kdn3SrP3no3I/aeDctTXiNHb2hYcsPs=;
	b=a3OhI+LlqLKwmESGxvWhXim9oO2NP0mh+UBjP9Vz/ajHN7U3viUf6tsvuQYT7XCFe+gt
	 N+MyArYZLPFf91KBObFmCQTTx1/oqS8spl94YCwcrcOodY9sLenXaluV/vzrQ75Rrk2aU
	 k5wDEioyrLsz036QYY3ZzEExWlEbm7CUuKafCiHAimfX4Jj9FVfJW9PsliL6G4rAQNq+l
	 lBkxBKru/HI/6qk46jCtDbFNMDCGJVupLBS9m4DEL1HmxuVDWgVPx6B/9rnXlcGahh4Wg
	 FTlEZdJq6qBWzux7VblIOXnyCUbr3yhF35PQVhBz9tYq196O0/2ykjLeOGS1t9EW7BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8RnCTWe;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE0606A334
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5EE0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8RnCTWe
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso1647048a91.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560940; x=1794165740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ri0soL3Qksj5Kdn3SrP3no3I/aeDctTXiNHb2hYcsPs=;
        b=U8RnCTWeqbriWyJ4wA+SJW6sW/lRM70HU6Wvu6t5u0N7HzsZ88wXdgwZUNBQ3GGSlX
         HKni+7mF8TjN9eQRmQTa6DpOke6A6jw4PMq1eJOVUi7T0VDOQsclBdema0zjh9euAoPf
         TFtUcAxr6czo1jdtOFfi/ULYXXT6A+E/iIugK4w666SWqyua0mnWwZQfdkJJAIopf97/
         LNx5O1Wl2MZ/424TgxAQWV1+v0Lps09O0muDkjiI+OSGZZDhKMUQlRvIYckHqJ+DGCLZ
         lnzDPrJIZ30eFE62scLpqOL13GrsP3SRZNlkoXCtFGLyOVbpJI/9qzxdPTGH9tlWmr1H
         6Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560940; x=1794165740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ri0soL3Qksj5Kdn3SrP3no3I/aeDctTXiNHb2hYcsPs=;
        b=Ew1Vg98M4f/a9JwLITqLRkWGXvi8LYKPpea+cscTPSv0SZv/sDBb5P5u0LT+rMBcsS
         aeuVoIBOKj6h4TsoUAJFoWm5d1zrInE6w3pZuHJZj4xSjaI9SwEOPpILIYVwumiWtVuy
         jsNcX/fgdwYE7IxRjfeRxRmbGYVCVdLUT2VlI1F+t53uwzJMgEA83SYrAgJpkl5WjiNM
         Eww9VAUqfi+cv74D2JhsInhAD+Z0Sb7e5yBdZxt2ydWeOynEAokbYD58Sv90W9DH7fJD
         BbN1boWqej+NOVpXqkB3wst+f87y8feeUmVF1FWWtJHWyjylquELuaMSjr3jlD/kiH0f
         rKfg==
X-Forwarded-Encrypted: i=1; AKwUvBw0YLoDL9NhHT6hFzkgKeVYxrVE8pRvNmZWNSaDooo9E8263Ud8swOeyCMqrFlF3VmNCAwhtD8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HFHCvk7shQu8gg2oEHcoiu66xmlYvWuIbIb89MS1QWUucg3d1
	LmOcIuG3RrpGBnUvlVtCB/zcbne9adL0rzzL+A1EtJTNxIhiX26VZ5Bt
X-Gm-Gg: AYBFou2co9ooxjnJxiLwboQVPExZ03a/sqXi+3hYQXBx+Pd3PD6zt5h3b+pFIS6CoXp
	vWzsx2DKCIqHXRNH79UhqLXmHOkEeoRtMkC5oYffeiJeWcMLCc9k7S89HGcnu7B6gYLgxsOSew0
	c2SUqgRgex1r0polkU6j1wh4VjV7KYMduaWbbnyc4DpJDBQAIe4a1NbrBALo+nLBpOF/zYWYVBm
	4Vte9tgxLtlg6KjqTf03VlBrKxZV/q9OVn1TTrRhtkUzflSWvcFb3nnTYKpChSuRTDyjxHwSKGT
	uVMQQsvj72GOUELV1VqvIe4uNOM68A3660liJQ0CjtfdrxsOmjmwOlfZ+09fuNJ/gHxl0WHJvpu
	q6Qdx40B1kjtFjzsQHLE2zCJliEqV/sLg99cZMm5XncIDfbxAIiBZx8eTcCf1kEI9qi8r+XsbTj
	h7i+OqRigys0yOPzwSywVJRGHDgGKyXEBCPYtZlCfeVXxTkazLtepgXfJhrzOwiOrmzqmBX5kC1
	TTdicWTt9158C85F4xL4ZWYV1bdEUzo6w0WKuZmxa8qOQj8Hh5J+RDFsLqEDR8MuuC0QF618E9H
	Jt42OY3hYF3sVU2Ap3TtUrrRvRQbkXySlaqL5IDc0F03FvF5wTHfbzyK2zqhQ/FNosjAOzc+OQG
	yoLiSugd3Uk7vGjy8bC5UY0XIF8RMJMiG2L14I+KIiTOTUpmKF3y2Y2BPkPziBIhztk9aL9IGpp
	U=
X-Received: by 2002:a17:90b:5344:b0:3ab:a3ee:33ad with SMTP id 98e67ed59e1d1-3ae897eb378mr6384359a91.22.1793560940036;
        Sun, 01 Nov 2026 11:22:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm15190285a91.2.2026.11.01.11.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:19 -0800 (PST)
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
Subject: [PATCH bpf 13/15] bpf, sockmap: Check that the redirected message is the cork
Date: Sun,  1 Nov 2026 19:20:55 +0000
Message-ID: <20261101192057.2296489-14-alexei.starovoitov@gmail.com>
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
index a450b1ff3cfb..9bdcbb0a5998 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -509,7 +509,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
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

