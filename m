Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560929;
	b=Td3VunvmXdkve4DHfZO8BXCR86duNwc/PdniW6b4Q5ShYLsO7bjVJUuLFPLfAb9he/cl
	 Wxgnd13laNan0js1+9EzDkVbJs+WS3HwWvh3tpHU1H0PLBhsv29fu7AqlgUJv4OPmko3L
	 NtXv6R3to3PSXKyZ+MssVe+NrXzSgoOTu49ymjVYpIfc69WzcYgelC/Kdw26oypWZNApB
	 bBKhg84Y/YBk/I4cMKCgtciUOUXEoKio/Dy0FJyGF5uqVqcuJyHs5kl2OpPEG9/d6bD92
	 +09IKbhlhO/+pJ8WHpgZ1dd7utZhZeBZ/LVVqGmlVWgb6sfl1dpw8D2NU1N3wBgpdrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RP1aCEqwa+3rqWDejhsGdqflKxU5qcv1t4TwDR4XEcI=;
	b=HAghHYAqmCXMEShZgyFGzuU6cXwbKlSO6D0QkH58a/jrcwQglpTF4Yii0PDhpt2RHKqt
	 SB8f4xAajR46fvWai//1SUFI8RwxDZ5Ti8SVSD/Y9DYOfSZ+jPR8GG/xb0L9U2yRm5yQN
	 qFSWV0v8xc+xwZbDNj3/Ns/7CXUitjQxtVSirLY4RRsGu24+PqGbTu9O7vsOR6mC0JVko
	 ZBt3v8ju8RxVnCqpBKB9kU4i3IkgKVrbNoVDyCA41xmJsNfgt6Ia7B2PLJnwy5LbtmAZT
	 WzQf5v+xZBjDJ0lQkazmT3L1eWdiXwWkh2XXx3YQSjcPlcSymQdSSWmeU2K7k5Hdu+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPgy3HlT;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF240606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF240606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPgy3HlT
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea138a3497so13475505ad.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560928; x=1794165728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RP1aCEqwa+3rqWDejhsGdqflKxU5qcv1t4TwDR4XEcI=;
        b=tPgy3HlTeayvX5KW1y64gvoAsMeqEH/3fl3Zm+t5kRsDrUMW1vXzEGVUan0IigECWP
         bveTbSgp/iEs/V6dFqAqDBHS95Qgd9utyE3x82RBLrFr7bQsEDYe8vlkXNmQZkI+XvaT
         5vIgXKGMCL4J4bC8YbdORLXs72TqanOIu6mZlJJ9k1Uv4xszY5yAbVuUf+Oi6FuUqT+/
         zf2eTCL4rvmVqnUu7zRuhC/REgWimEGwCGmzbQTLF9Ig3hGjMUYx3jckfo5JWZWyVw/U
         siGPpwK/8GLESd61rQhoyDs7EoUYsMgZGjr1p7hvUx2ouTSGklU8M10LB2iGVluYMgGN
         bUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560928; x=1794165728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RP1aCEqwa+3rqWDejhsGdqflKxU5qcv1t4TwDR4XEcI=;
        b=N6OB0ArUCUprGMPW/pUNcN91NqEgkb2lqWwuS4MymClOL9QwVobSVZHwqAOmE1D7Ln
         h5ycYxNmj6ZVOXIhwyHHaF2Ek+2xmJYjoq6ZRsurBhQyfBCVG+bnlRoEenHmmG9NeaZr
         g3Ts4yxIJRBNZNONVtF+5Og88PLo6p06/qew0FxyAPMaV6J6BVstiDFywuF0lxXZ+e8m
         FMxyq5258ap6f/fTsjfU3hodgyHnqfNgHD2qxgvc8GITJ9hNM82F0tdFRIJl1fNY7V0X
         X/qXByjSA0SUjcTyEYP+qD96JIIMBJcHXIVPu95GoK6yS2jWO1FDyThGSwwIpG1kDYLd
         dT9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxSy2oo7TG0GHH5+VUxCBdY+PT0QoNjIqdlT2a7IVENHB34QbEWHNmYNunLqOS3IyRKJQP3MuU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FFjaARosMmi1r7DidBcEZuZEd7cTbILi0cVUX5yELdx5EX7FV
	yqw7mmCQUaITKZe4q62ePZOMH3A50ATtEcHunXlrXVpP2JgvDLOLhs8HdFVzuA==
X-Gm-Gg: AYBFou1hoxCC/QXYa53eG2tkMKgPJal67pO6Kv0wK8JbZKJaC69QYMB915Qcoui6E0Z
	GXrKXeUMx/tK+Iby1YaAaiPq3lZihRhnRbE32kdnUf0Zr07Q/VBOMYEeJuiqJWlB1o0uzeAIteS
	i7XMw2+rbV6atywB5+IKMnkKXgooODLCDwVe+rnPFWYYDWWRMvFox3hnxEPLLMmp64CClHetsvv
	1UBnxYrqdeycFuZ3Z1S6gTeYpXefFB70TO3aX8vuqYghpVQ0c5Z4DXHx0++7P6HwmcYbb+X8LyC
	k7S5lJJ8NElTnjnhWyq1ji+2DC8kkFuZqpAtQCy9V05jiSi9u3N03w0ubWrW4m6gCsrF77IkiNu
	RZH73LMBhPkj0v0N5yaO9JoCLgP6rmklYjEO7pgc5iRJ7H3P3KGbgzeXFkoasnscQ+x7Lq/hPTH
	YjkpuOPiOFqzMD/q5tdzZH580Jz+26n2gNO+cdWZZOnQ+3SGIHRvVfLLepjR11yTpy/WcFVC+x8
	yAfvz2V0CGGEzoJ42KJPqmnuA1QcIMZUn2pBfJKGonIdaVwl+ka9Xw5nWmbTR41FKD6cyqNLFnR
	zcFlAbtTZxkYVY++D33MpooMlTzZasD5N59eMYTZD/yNTySY6LwkYRxZqOPlrrKMNFBABT7KaUE
	VJJ4cbHVWShZBMVMDBs/VNwQ5QVUvBQXD363z8MMm0xUKwVyLCCUSHwlZY6T4gFaXeWI++tSCZw
	==
X-Received: by 2002:a17:90b:46:b0:3ac:a11a:7c91 with SMTP id 98e67ed59e1d1-3ae8983f065mr6222829a91.44.1793560927932;
        Sun, 01 Nov 2026 11:22:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8805ebc8sm6392012a91.3.2026.11.01.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:07 -0800 (PST)
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
Subject: [PATCH bpf 11/15] bpf, sockmap: Don't copy 0 bytes into a full cork
Date: Sun,  1 Nov 2026 19:20:53 +0000
Message-ID: <20261101192057.2296489-12-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

psock->cork is a ring. sk_msg_memcopy_from_iter() writes at sg.curr.
sk_msg_alloc() adds room at sg.end, where a full ring has a spare element.

When only a part of the data fits, tcp_bpf_sendmsg() copies this part and
flushes the cork. If nothing fits, it copies 0 bytes. This copy writes
nothing, but it moves sg.curr to sg.end and returns -ENOSPC. Thus sendmsg()
fails without a flush. sg.curr stays at sg.end, and from there a copy moves
it past the spare element. Then a copy can skip the first new element, and
the peer gets memory that nobody wrote.

Skip the copy when sk_msg_alloc() adds nothing, as tls_sw_sendmsg_locked()
does. This pass of the loop flushes the cork. The flush empties the element
at sg.curr, thus the copy in the next pass starts at the first new element.
Now sendmsg() on a full cork does not fail with ENOSPC. The prog runs on
less data than it wants to cork, as it does when a part fits.

The first Fixes tag is for the -ENOSPC without a flush. The commit in the
second tag added the spare element. Since then sg.curr can move past it.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Fixes: 031097d9e079 ("net: skmsg: fix TLS 1.3 crash with full sk_msg")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d24ebcd7633b..a450b1ff3cfb 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -611,8 +611,15 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = msg_tx->sg.size - osize;
 		}
 
-		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
-					       copy);
+		/*
+		 * copy is 0 if the ring of the cork was full already and its
+		 * last element could not be extended. Flush the cork below,
+		 * and let the next pass take the data.
+		 */
+		ret = 0;
+		if (copy)
+			ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter,
+						       msg_tx, copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
 			err = ret;
-- 
2.55.0

