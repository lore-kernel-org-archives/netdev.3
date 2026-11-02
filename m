Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604097;
	b=NoN44kmbE/gh93xjL1C9vdjFDcj6dnpVikf1ogOvE7TtRW5nh7zAnrBQV6fz1RLXNA1o
	 wXI8ipE1irIVkFGgOMt+Xim+feZk0JvEPfzyPDGWjp4XB775QzxgHE4Z38MRoDzLEHaVQ
	 Kzq4yEBu/NPQopmW1iV2Dd45hLVE6GKtHYxcuVT8skSJPDXsXNXOKeDu/k9dvjyVsbpiF
	 EIHDtw3K4RWpf0fos+bJpcuS2uycPi6eQVTX/x90C76X21CQ8Dx2etF0ebY4qGYxonIVd
	 hWMzpXg+cys24nQlYMWl3H8OOy6EvuxhCWPkCiGH+CAeY5nV5s+CPd4St2BYjax0cGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z7Peb9UAgZRQMeYI4B90l1wzrMCTNfd6vqfD72GCEUg=;
	b=s2ryvo4XJfSVzejvSiLkXOHlV0vJ2SqpU3LhB7tn9ep/YbtmXX2ThUXYzYrebekpIuiM
	 zyAKPqcHi3yRIdHzHPa0W+d2/5Hv1huJyFpPtN4ixV2xWAXw3VtSx7i96pBgOcmZeccbM
	 PfsAymRf0+HosZ43OwT0K/vRzOEjh/QrJ8iifK+mU+j/S0wCelA+hlbC0ZC/sNLCgmZ9L
	 xiATiIOpli1VDLimdgNzvGZtuD1UYL1OqbRglWaKDmRH0BMf9tHOc/c4cnhSmjkhUTUDR
	 relILVKzSh4F0nX8AhDoIfqyEVQJTWdLUuhcXaC85YOXWv6ZZA7RPIdtCOVhBS02BGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0iMfdFa2;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92858606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92858606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0iMfdFa2
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8fe8e343fso17596035ad.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604097; x=1794208897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7Peb9UAgZRQMeYI4B90l1wzrMCTNfd6vqfD72GCEUg=;
        b=0iMfdFa2E4giR6+L/RbyruUN4ugedAklyuqkewA7kWBIFjtADNmDS7ohqIWv+A18g8
         Vr5JUv+UxVJ7/BaA9BooLtpJi69L2LS22ew2/4UPxWh+tJQ2RJFAqcRcLrAaPb3kSeAB
         QyrHU2T/s1Os9GDCrrkN1864+RxS/qYCSiHUshnroVOxbeZwcGW6QeP278+pw8CkbKQF
         etkP4hJtYvFs+8GoeloS9+bmU4UvMTIroZ7/v/ajesGA2xkkKOSzegcZxgSHJ/jV3LZJ
         POWRp3Vmx+EjHThxTpb7S8LBtQ6j4JmOZ1scqou4VLy/S9IPVWD5+IWhvG5iO6f+zmHf
         fXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604097; x=1794208897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7Peb9UAgZRQMeYI4B90l1wzrMCTNfd6vqfD72GCEUg=;
        b=r1tCFGEZgRlWyf+7vy5zX+z+hs2dGkDLrV4HCmnCsO+xj1vTeAqmDR+MmfvQbhSlfX
         6GvW5zufGC+XkDp7+HPIDEvoMHy5O0uXbfum8CP+IpBZz1Fz4NHjYBa5bzuLXPtTvIA1
         VCZ4XS/4bAQOs6lwEXRuCamNotcIzDMOUw+GT95WsAlZxNBJSFnxl9lE4xgnOTMnlz1T
         pQtXeQqvfmPBK0il2lQEuZIIgL41Jmrhjp+czjLp7nD4XZdy/gZMm7R9XDQxN4rcJfry
         4cIxixHAq7LYjroiATmWlTe0V07KqJL9x8rHsS6QgtetJ6xRvhEiZ7CfomD6tPaVskh/
         R8Rg==
X-Forwarded-Encrypted: i=1; AKwUvBwZVbGJFrqPyB266XtQ/h4FnqdW+ABg5wFS4Al3u5y7Yb0K8an4Ci2wu6wfjxG9unetxL5XLB0=@vger.kernel.org
X-Gm-Message-State: APuU4Z850mgElmMRAsz13+S4nD0wbjBCX3M8wH1rmrYWcLHRYwlw11Q0
	3BBAqkBMCkR52eZSsgaNX5GESEofo6VyHQg4nx4ipu79ljrfJQUwPRj3
X-Gm-Gg: AYBFou0tcYIDo2jqzYo+a+n4NexPQ6qbcZM3bE5RZnnjph0uIRR7tlJAeTO9DegdZkG
	AiHXGg80IXXjIp1AKtaZnDdKq/h2Nc+ZN25jyRK7WSV6yEG+7IDox0lH9REClcSMS/E343N1VPV
	h7fGCoS9EvRjFdld0tWBMNA/2c79sKY6r+OD4p4sJa9ZD/2QtU3lUYuCa4ixdqQTxK35YY0EU/o
	NIqirDMTcKQhc9uOKtEnpAQiPxBzqloBeU6SnIw+OW8NgyvqFo70GbWy8DgBUzzAGXfaou3VtU8
	cqxOhtRpVfvk/Vc7Mw5ttpqvKsCZ5e01GsFpTf15OMsPkSHJ2mbpGvLHFgIyduTQMXpJNuQsnaw
	Y+3L+nR9BuciOU1dh5KXSCmrvWGRv1HzqGi4oCjxA96nLau5wOnYrjnBEEQ/YrVvoOXxsLJlbtV
	XzgdDOLO6AXwEJNrfRjF5Fr9QRnHHMoyp/foe4iM/Eu9rbBoPwJE/ddkDSHfXf3dLG0mi4qVeRs
	9X821SG2V9e6DvLXLXiIBvebCNHBQO8pPw3pix6yhz0Y0n0tme1YCG5J33zfH11W9ycXYEW0WDw
	wGIwKVxbGlhgCX+yFW12WqAuCpD+JX53xtPuZ4BRqbq75SHV92CI1qxnPKrL73B/2ImYt/XUTyq
	CiOBDtyrR9/rfGcRFV3duHKP0DFqBebll1ZQ3iFwG6bQ9Qqx95xyRvkP2ThnvzHY3Fop16tkcaR
	o=
X-Received: by 2002:a17:903:4b0e:b0:2e9:9a19:c54 with SMTP id d9443c01a7336-2eb3646ee38mr76369615ad.50.1793604096781;
        Sun, 01 Nov 2026 23:21:36 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3924c858sm24478145ad.35.2026.11.01.23.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:35 -0800 (PST)
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
Subject: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
Date: Mon,  2 Nov 2026 07:21:00 +0000
Message-ID: <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
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

tcp_bpf_send_verdict() keeps the verdict of the sk_msg prog in psock->eval
and runs the prog only when eval is __SK_NONE. For __SK_PASS it resets eval
only after tcp_bpf_push() returns 0. But the push can release the socket
lock in sk_stream_wait_memory(), and it can fail. Then another
tcp_bpf_sendmsg() sends its message and does not run the prog.

With bpf_msg_apply_bytes() the verdict covers apply_bytes bytes. After a
failed push, apply_bytes still includes the sent bytes. Thus the verdict
covers more bytes than the prog requested.

Reset eval before the push when apply_bytes is 0. If this push fails, the
prog now runs for the rest of the message. The same already occurs when a
message does not fit into one sk_msg.

When the push fails, subtract the sent bytes from apply_bytes. When
apply_bytes is not 0, eval stays __SK_PASS during the push, and the prog
does not run for another message, as today. The verdict must still cover
the bytes that a failed push does not send. But such a message also lowers
apply_bytes. Thus, if apply_bytes is 0 after the subtraction, end the
verdict, as after a push that returns 0.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d90bcc911b36..b016aa419fb2 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -457,8 +457,22 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 
 	switch (psock->eval) {
 	case __SK_PASS:
+		/* The push may sleep without the socket lock, and it may fail */
+		if (!psock->apply_bytes)
+			psock->eval = __SK_NONE;
+		origsize = msg->sg.size;
 		ret = tcp_bpf_push(sk, msg, tosend, flags, true);
 		if (unlikely(ret)) {
+			/* A part of it may have gone out */
+			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
+			/* Another sender can use up the rest during the push */
+			if (!psock->apply_bytes) {
+				psock->eval = __SK_NONE;
+				if (psock->sk_redir) {
+					sock_put(psock->sk_redir);
+					psock->sk_redir = NULL;
+				}
+			}
 			*copied -= sk_msg_free(sk, msg);
 			break;
 		}
-- 
2.55.0

