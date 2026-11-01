Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560880;
	b=iHa52/lRLm99B2nLss2HlJnIgUjMKIWR/C1mws0pkhtukiR1aR4YP93bLSp3Vsth2Bej
	 mf1vVCG3ionHyN8jCD2m3QKA7b5lpYqRrXewgCDZjGyGqW93gyR6IwueCa8zgEQxD+xpl
	 Nv89eVpIPJgrsU8MTbFOmUqBGgPLWlSRJ1jtkX/kOE+3nyBqRlG1mBPZHNzDAA38ojyhX
	 tVKTfoz5piDyFF2pIWiTsee1kpSFFWbcIBN8W0K7Up0g9INrpO0xBBFYGP81/NtWDDGxr
	 Z87tjSBJYii5EkM59kEugUwkwsfSGDUX+bgEHH4CtZsnHVlTxjHwEFh+pnIQw+Qy1Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SU04LGyxjuYA40ODCW0YIdLfmYd9WdxC4UJ8kuxQrGc=;
	b=eIkn3LsWqdmLhy+3GBJPjvTemQ9WIw2r6ollxSib5kGpPg0bJvKWkeVInFNPEcXhdRvr
	 b+dJHAOJUv3Uiqkgsri7XxNe0ec771AxwVsJmPArHr42lVzf6iWeel2+J0h6zotOmffE8
	 8loRqqAGGPNT6Oe3D9ewnKradQQMWkgBmznBQsAHqAZiAGK0IXSAuwtqYus8g6f6diR6K
	 U15ouPmlN43noSbHGR8xvux2bLLWVW6hnu2TQlHn1Dt/FBE/v6Sc08b8JeCGgsq7wdiJU
	 P3W/A3pWmN4pLgp8NMP80FimQaxi+FCHqcW/mOVPiOaxzZLSucrlg9r11/EyxbTTcAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0k6C5UD;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C2606A333
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 043C2606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0k6C5UD
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so1681994b3a.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560879; x=1794165679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SU04LGyxjuYA40ODCW0YIdLfmYd9WdxC4UJ8kuxQrGc=;
        b=q0k6C5UDMNe1C6d3mTmkiZKi0BWsORdfyjICBG73Igf1sUZT7WmjgV/a6q5XYH/SEt
         YTx+/WYzBGG2oTcLyb3QokYl7UKPC0/XfaWfJX9/LFqtIxmqN+mQx1J98DDJBt26lFOY
         XgUK61lM1zT2cULkT1D3iW65SPqJUYLUfRZiBCH4OLPmXjkdTxLvDmTxHAJHRqGEyk5/
         M3nG+pmSGjnDjsujY7RexCuJtfL2NLIFJeyBuCAjZ40wMIiQhTQ2CB+0q8vG3PBZURR6
         lFO8nrq49MVtUVDaKQGlO42I3Ki/YtnAbVjYxg3mY61xd3diYlcQtWNrpL32K3SfRdt2
         Vj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560879; x=1794165679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SU04LGyxjuYA40ODCW0YIdLfmYd9WdxC4UJ8kuxQrGc=;
        b=GYuSOzw4YmllW+u9R1UBgESnxwvqfPwLIWnulRKJNYBGmEdUFCymopOdg/XuwPF60c
         Y/0FCrASoqnuBSfzjiIrEaCCHIpqUVpWtfGckENkqswXJGUtC4TLpRROLGGYL/8Shzf6
         mLLllQpuTDfC3En4HkQqfwEVc59VkIIaoOYv8nDOOmS7vy/OyAF5KZ2wYEd9hiop4fbB
         jyhmLLBWdy0sW71zi2L25qx5E2zHQ6MDAztWzqnpaK8+3drQSlK2VmrVJ3SqaSbVx4tB
         J4gq0O8SzXFVbc19rmgEZ6Dsz44edriSIQJQO2w9ZPx4cquZ4HmnJAC5j1U94ONd+RDt
         IPYQ==
X-Forwarded-Encrypted: i=1; AKwUvByW51/GVI82mVBgNso3FF2jpps98lpbsTT9B9H62JzuQQbNqPwQAT42lZcfI6VfEf5gWxG86Yk=@vger.kernel.org
X-Gm-Message-State: AFq9FYInxv0N4DmQU54m5oEqs9eJWN2PAnemfexa8oZUniEq9/3A6A1E
	67KNsjxiQeqaRwqhEoaWXAfML1E5wt61TtX+rtf3rWRHLdndtKjmOWUd
X-Gm-Gg: AYBFou15yWcWp1NQd0W5lQ1zyIFwKG4bZ27HMqJC1paaYBLCkfveGML0LpTsiUtm1Me
	mBIM5fBAmUgJ+yTFCfijMGbDwf+W7FnkwlwDxG6MX1a8TiCQmHeF1EKRM/JeP7j+TA2KvcJIGg4
	MHlAsOGg6aRblifT1N6tFfBhNXYXCDIOJuZ08m91y23ev+lpU5YeI7dVx+jh+sYFPc73Hjqd7YA
	XTxWL+L8ZFY7umi8d9rkLyU1ov59jzFILMvNUHfrNtZxGdtnFIhMI99bKpOUC3GJ1SkCHUQpDfg
	7tppcSqtgZxMFFoGSck1b3fISKpuFitE53e9k2cjU7lFo9sHosfUqOPRC8sF917cW4fyD+f1x4X
	pQeALq0+9xgw7bA/9UrDKs6MP5Y1UVHEDgcFKn6SmKAAIIUsPgFW8KdV4L1sIek7He38ldPAA2m
	I+9q9W5lp/ZFbBK+WZcqshfFnHz73RfxDN9KH7iPeLQXISWH853n0/d19lwrg/rjOH59ZgCxFYs
	1qKLasC1epowmJOaLHXOn4IyCls20u15/VGA5T7s1toJAQW69iUIkMfcxJlTyFO6d10/0UXxkZC
	RCvz89tXdhq11WAZeUK5WL3mfZrmI8RKoMK3MEm+WmJSEotagLKTprMh+dGAuqMJ+eWuXCkwtwa
	7zBIbbC01Hf2DXXAJD7o2G+m4qBVoTFdq8AAlxgv9nYKoaxo4YKCaBZ4gIPUs+sdYD7lAjqwsML
	k=
X-Received: by 2002:a05:6a21:1bc1:b0:3e2:1a3e:395c with SMTP id adf61e73a8af0-3e928a51d5dmr7646160637.59.1793560879239;
        Sun, 01 Nov 2026 11:21:19 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963d055sm1140810b3a.14.2026.11.01.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:18 -0800 (PST)
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
Subject: [PATCH bpf 03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
Date: Sun,  1 Nov 2026 19:20:45 +0000
Message-ID: <20261101192057.2296489-4-alexei.starovoitov@gmail.com>
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
the bytes that a failed push does not send.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d90bcc911b36..072ffd8347a6 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -457,8 +457,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 
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
 			*copied -= sk_msg_free(sk, msg);
 			break;
 		}
-- 
2.55.0

