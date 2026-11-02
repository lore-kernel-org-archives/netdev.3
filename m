Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604156;
	b=DT30Zwfsl4fVYpRNyP0kY5wIAn9XKgskiAIbahHdA4G5Coctk1vqAmxeCRwsAWS6n6TP
	 vEG+GcK70yRymRWDwEtbM4UhzdPQoCuvl7PpK9o0bUyrwkOt1+MBFjaQhVnWiLUGO8tJk
	 LI+Jk+w8gpVrBn9tG7bA+op4LJdgqu6Jm88l/pPM8i66yy2yL9w7smklusv4/04qW0Reu
	 jnfdoXp+nVTsIgnFDIR6pghPFWsfrerLvW8hrLxguhCyc5nmU43IMx1XgLCmL911bG1ps
	 TOBjF8sxHjhLcyU3ahGmZUb8ptuYmfpG1WaXwDzZ15FBusR51IM7wJmxxttJhCeoiHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
	b=RoAIOmx5bBCoQxUqugwnxLAur7sWECueUC5WQ5LTdAuNz+EonDAFo/H4TL4tThDrcAlg
	 hoDOq4Rg4ZGaM6PlAwMNswSizVl2cM3fOrCwFG6n2l42WXpO0DxrRBlpWh6xjqu8YaVtz
	 o5eC5IPhNhLmfSCJvQvexhFIg0lPy+B00++2l30scPBoWaWzWhUIedtzNttBjF0axWF0R
	 I/aL2/0+mgiqikMXGcK8C8ZczhLirbEB+qhJGIOcNuXdXW/Hbbz3VF0CJS2Dmvok182yv
	 xSFzn/1+V3iDydlt/QhT5qN7WstiSAmd2kyGJ/rQxj7FvCOvaELx12EIVqpMJ35eMbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3rdKFsI;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54F606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C54F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3rdKFsI
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e831e86ebfso15387735ad.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604156; x=1794208956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=J3rdKFsIh/VOU3Z9IujXGcPGdVqgLtYrJgw5MIy/igWi/drqwsCdxEDercaQEmWYp+
         ez+wjhkhPEvqWhoC/fRrreXVBpTFG1SvmN9jH3tt+xHwP3FPllGpuZjSYY/wjgTb+gKp
         tLJpYe0c5Wyc2etjb4T+lz/0EgyIdsIdsCcXooSrGCl49SBZhvJpvH/E5dO+UhmIlW7Q
         UGU92AV2r0r35s3H7OEkypAJWtaZBRs+IKLDAmBMsOYy1Yx96K+V6mi8BXQzkWWcVgDC
         85Dz3eza7tcOQb3D01HcA1MC4bK+EBV30UjO5g9XcEoG9ToUMTXWYttYK78L29wO9L/b
         d1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604156; x=1794208956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkvPy8BTXAWTFCLyRVJ2sIoHit4yKU7xsRMx7Je7ku4=;
        b=bpEazqeU7x0fRmd9zARIFijZ1RJt84lam7omAqVfEdN0D8A2KMxXx3IjmG+eFCmCPX
         3flItsPGnbhgrGlIZ7vFACgY1ytDBzBFVwVkZ/FDGAMokHxVD+UiFhk6wDJMbj2whkaa
         Y5Pe/9HTqIhc+7os1rIKXX04tZIZGYA++bgJqWARYNyDG24qFTgZ5QlXFRb68QahP60a
         LZlmOVR2c4eHGyZtTChJ43MA0sLg7r/x/F+nt97SKHJ78CaguY5BA6LIj+DlmlxOKkEQ
         5jh/3BYSKsLoPSuasvTZcZ9Xb57voSzc4o8sy3qtttykjq5o3XLAFuuznkK5Quk5B4oB
         lAKw==
X-Forwarded-Encrypted: i=1; AKwUvBw7dSMAWqTHZXGi0qP/LhyZrtOIHvk3yOkbMtvgN4NLFd2rlvwEuSm+1iAXeWkhEH1+pPLYBBc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/CK0i7ypvBZRXQqYshJ69b6yOQXTCL72+fSX73IcKmmTtzfv2I
	o4o8/mqZKbsjr0l4IBCASnxORT70bUtZ3zxZXohqppeBmGfVU3+XNqux
X-Gm-Gg: AYBFou0l+32s7H/G2jm6/9rNXcmU+ZEeVP0W/Uh0W0K/dEpd/bA9Qk3vVhYRSdgdgfO
	moTlMHkaXw9n05iEC589gZHcOphTlMC1ZO7z2tqR0Sg/tk5woCpQgUKgNsIdGdwjAIJBJBmJNf4
	XmffkkJZr4RgO4V4N2+GQhxbg4bJSZC4ybjhqphb4XIsu4Qo8I1LKx+bqgxykJKmDxc2Em3AOPt
	Qd861e17pnuQBBorrfKb1z1MLMKXpH4Fqo7C5ggDcwd4+13SDHy97gW0Vw3cmvYYuRPhm8OJBRT
	Q7D40/UjOt+2GDrOueKNbZMFeEjYwDkYoJT87LfsVrD6A2yo9wl2mSPw05xaXdN/ErP9TmW8j9/
	eZKdnE1D/y/QYiEhM7JL5estIgR9LG9D4DJ8D1d+EQLE/Gy2LkCTIxMjmyKyACLzWhVW3fowJPq
	/xJv26udm3OeyyMKUDuBO/HbOY/amTQgFtDCYE09d05bBoF9d+o0UrvWR4JAuZZGYgr1BJl0rkZ
	Jcr05WINlQqyCQjP2zY+I8VwNNJgWmF7B8eV8SQ+UXEnCPR3k9HJx0K/lr3yFLMvOJlRuKL8NNM
	6CGrck2S/VO6jpbLaX3ATkFldyEe7A3p/s5GN8JwQRc9fI8QpfhtVugbp97YOxiD8rcqxFj71GT
	DIg8TJoMAxWAloQtuoJM2LVuf3IlIPJvyXlK0O6kYpD/nRkCzjyh+X41bOcD8GglgiZlFnvqRgg
	==
X-Received: by 2002:a17:90b:2e51:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3ae8983f049mr7620183a91.47.1793604155368;
        Sun, 01 Nov 2026 23:22:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm3292338a91.0.2026.11.01.23.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:34 -0800 (PST)
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
Subject: [PATCH bpf v2 12/15] bpf, sockmap: Clear the redirect target before the sk_msg prog runs
Date: Mon,  2 Nov 2026 07:21:09 +0000
Message-ID: <20261102072112.4160195-13-alexei.starovoitov@gmail.com>
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

bpf_msg_redirect_{map,hash}() store the target in msg->sk_redir, without a
reference. After the prog has run, sk_psock_msg_verdict() makes SK_PASS a
redirect if this field is set. But tcp_bpf_send_verdict() runs the prog
again on a cork, and on the rest of a partly sent message. Nothing clears
the field between runs. Thus SK_PASS without a new target is a redirect to
the old target. If that sock is already free, this is a use after free.

Clear msg->sk_redir before each run, as the skb verdict paths do with
skb_bpf_redirect_clear(). Only SK_PASS without a target changes. It now
sends the data on psock->sk. Then sendmsg() can return another value. A
redirect that applies to more bytes uses psock->sk_redir, with its own
reference. The counts msg->apply_bytes and msg->cork_bytes stay as today.

Fixes: e5cd3abcb31a ("bpf: sockmap, refactor sockmap routines to work with hashmap")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a5d498982848..8a3b8536c0c2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -936,6 +936,13 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
+	/*
+	 * The prog may have run on this sk_msg before: it is a cork, or the
+	 * rest of a message of which only a part was sent. The target of that
+	 * run is not the target of this run, and the sk_msg holds no reference
+	 * to it.
+	 */
+	msg->sk_redir = NULL;
 	ret = bpf_prog_run_pin_on_cpu(prog, msg);
 	msg->sk = NULL;
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
-- 
2.55.0

