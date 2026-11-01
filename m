Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560886;
	b=A+JO3Wx2AUUxEMz4BQ2Ln1n+QaRj5D+7ruPeWdgA4T2wCg5rWwnGiQDxFVz0tJovfHEB
	 jO3Zc46fL3x9LQ6QnBKouxe2KfQKmCByW9qUR0w5T/4lMLTfyFLUa/mM/Uq8w+dXHDIlg
	 Ow4UDonNt/RkxtrNRx2cXJhN2etTO+OICWW/EaC2jVJHZXaE4+XmgxRwcYnW3lIz7mPVT
	 xEo0WQEtc6HFZoENi0BneC7lCK17+ceaSNG7ktmnQNsNiQyv4FMM9zklbdyZ0xT2x39JD
	 uvhRQIRowY/pBN6Fp51WQ262Rg5xjCT6I8dBIPX0zX3meyYilsDqfWiGBbXQiyO/DAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lvky38gqrvpjSBWUSg+Q6mjoyF0URntzlHpSfOxGZkw=;
	b=DZUC3CHpTWBHX9CZNe0AdMjJUWbB2cBUnhqVlFkMl6qzLvcAPVHtfCUT/QjRqCnskTvd
	 Zsib1dFg0K/DkJ3UJ83e7eRFbqB0DM1L+2j0R//kk/jv5klFshwg6aSxFhJkp0KuJofpB
	 6I0wn37B6zqKB8teXeJ4+GiAWhiKEtlx+YztCb7Hg8LA8UDXtXJSxNbrkVt7v9yNHcwJh
	 mZQOGJHPxDoMMxGUNU99X8/NAvcK0Fq2wd/bCX7idm3mP31qcSt1BJxCU5lj/5q0BBzBM
	 c8Y5qvCiuhpo+tM2LAogIgLa8bIHtgQ9WPFMOmOKDzImUg14cUNwaFpajPaJIpsZ25w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MHPRMyqo;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36B606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A36B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MHPRMyqo
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so695355a12.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560885; x=1794165685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvky38gqrvpjSBWUSg+Q6mjoyF0URntzlHpSfOxGZkw=;
        b=MHPRMyqoIsk3DMepJwMJiQh56erGBhgHXLKbEURm9bkZWMVHT30zKppI2hHc+JnsJ3
         Q+Pvz4jGDYYHeX8DGKpXZ588ob4QygXkx2HB+lwlZKLUx1S3xh9jA0jsD9VSGFphV5Ha
         h2Znkj9CKN8x73WNuyDpg/ht3OK1955vXU/rn8WFt9x2tNmULuj54TBsLvGOukFmszvM
         U81SbOKNSCjOrk+OoS7eAkJhqw30AyOyN9lHVomsN842AFS3AKCUKBvHTm9d6BeoEfbe
         DrrVQPFBtJvrlkWQ97sX84eq2xwVk1R5u39MRX/ba/8OQtUvK3y/60KfrwCTaQubsl9m
         l2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560885; x=1794165685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvky38gqrvpjSBWUSg+Q6mjoyF0URntzlHpSfOxGZkw=;
        b=ub7+mgsG/5AVfv549j8gdZ5Jy4yjWfFvPZXecfxwB5mxjmp/PGVaXykhK+s3JkV34z
         1qsl4T1SP7paHvO34S5tcMDA+F3JnGnqozQmjgGJS+pD73M6ZShbruYfNOza2p4FqTAP
         M3KBymlwz9KairVI3htEf+eWyEDXKb/6lwTTIAmXuIJo9KKlThv3eM9MKzQ6N67AiEME
         nBWAEuVPLzfd/jsfTxGbPeM2mgHgduC81Bsl+XZrZq74Ekeb0OxqPrLJyuJ/K+r4st1d
         +65VjujkIKNe2/HEzA0G5DB9T0Pn953giHsaPPSGUKUiTRQTuvvWEB6jHypLzQs2Tl+g
         XcTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHFgnciXMHTccR6drpOwhHIiFcvQ2EjqGb8M4sKhd4x2PsG4x6OsyrK9q/LiRlgobkrBwEndY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/J74VvEbw3IwpwuRyo7oRwYcgBJfV1jNDl0eW4ZnXO/6mM6fLd
	Bf6ckIANG2fFo+r2qFLpy0rP46RMcuU1rcvW3a3gZDZ3foR2dPgacefl
X-Gm-Gg: AYBFou3g0vEf0JAzCottbvABpgn0JQbxKoZ9ZcuAV4r7at0HO7omjjHaJ+BAIHNc6yD
	eeqAR82UMLBHxXjC89PRmW9GWifLxxEgmT3fWDHq1O9CxJv+5GyzQXffGf+E16/faYxg24czknH
	W9Rrx9tydomcvb7Bmb/5NBg+3r44qv774brgKxKkzpe6mST41g0GDjECqfv6wGZWw8Kg5mWEOgZ
	4NdZTdXoLAF9j817otIAcnNEPor309ItjTS+5tMlV0JbF2bLYWdPDLMYj89MfgBY3EQZB49oFBM
	4qNOE64D1y7IEIob6vtuuKrkanb8JF1XYzGHLMYaLOOW+Uz3l1Mh5+n4ACAGUgn/cKQyyckzooN
	BHZaqc3BCFMlNUoeWEteA3osgpXC48Caund76tpxmnvNXzQH92PNnlyCuYIzX7AcunEuBRPMNmp
	vu5PBdcb78qM/5Uh74OA/Xk5oUTPTuB1LEFmGPtTZe/U7W1zZV6XxY/2GghXkL3b/VHYi0XI5Yj
	Wbza2elgTQ8PeY2ZPSaYgbE0S8yTWWYYlJ4iaCXL0r+GVD/MxNgkeu75103nmDyrMPB4baDp2dZ
	Ho+RStHeG6+Hys2UNfLHCK6CMGJ9J4Hgm8j+hyeeAjUsOFpB9C9tfYC1ibvLRwT9DHS4LeZ2iyi
	3vAR9XuopEFZ80lbsy9+mw89vzz6anNoWdpLOOpWF0kLS62WmmndJYFp4rGgfMHsWhLPRxacqtQ
	==
X-Received: by 2002:a17:90a:ec8d:b0:3ac:b7b9:6484 with SMTP id 98e67ed59e1d1-3ae897ae130mr6233275a91.45.1793560885317;
        Sun, 01 Nov 2026 11:21:25 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm11151183a91.9.2026.11.01.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:24 -0800 (PST)
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
Subject: [PATCH bpf 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
Date: Sun,  1 Nov 2026 19:20:46 +0000
Message-ID: <20261101192057.2296489-5-alexei.starovoitov@gmail.com>
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

When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
message. It then subtracts tosend bytes from *copied, the return value of
sendmsg(). But tosend is the number of bytes that the verdict applies to.
After bpf_msg_apply_bytes() tosend can be less than the message size. Then
sendmsg() reports dropped bytes as sent.

Subtract the number of bytes that sk_msg_free() frees. After an error the
SK_PASS branch already does this. The SK_REDIRECT branch does the same if
the message is not the cork. Nothing changes when tosend is equal to the
message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 072ffd8347a6..b9761af13989 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -513,12 +513,12 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		break;
 	case __SK_DROP:
 	default:
-		sk_msg_free(sk, msg);
+		/* All of it is thrown away, not only tosend bytes */
+		*copied -= sk_msg_free(sk, msg) + delta;
 		sk_msg_apply_bytes(psock, tosend);
 		/* The verdict holds for apply_bytes, not for ever */
 		if (!psock->apply_bytes)
 			psock->eval = __SK_NONE;
-		*copied -= (tosend + delta);
 		return -EACCES;
 	}
 
-- 
2.55.0

