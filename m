Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560874;
	b=DUGb6GDXWFZxLoRNx3aUKy0/Srj3gBEizDuq778uresHwMCgyExnoHTSx4CyjKFn99dS
	 c/6+ea/8SLlc65m00/i6m11mLiM4U+Ntt0SblhggiukezLsdDVaTZiEa0EIf+mTIWHABa
	 zUJ9qp/dYk5KRprMYW2V+KYwx8KG6wL6CGt4eDqZFP8gKwu1ulHbAf6MzerqV2dVSW2qm
	 WSW11+y2IjSTycNiZkIp533IYzZrowW5FA2W0jQDD1J4So7t/6YkdhrKbA9nLusXvTocD
	 oUKglVwKB8NlumCPUA/9rPhzO7RaEPULQa7mWsBZW/NyX6GyAtS5g6IbkWjpvhL4Kiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
	b=qu6CU4cVq9ErTrRoERNGfSIshjj+a/fTks9t/kZ09RnRrXZd8ZChTch8OsSmsko0DMan
	 p/oDxCw4zw5e547c8c2gTzGsVuSyaOVk457qgRiD/acYgj7p9upcSwcV8p8NS0l2kr06U
	 nHLEZqHJcuk6wc1TRK+Bmscl0DD1oPwIZLkeashIWcgN66PFbBmekEsxYCG63Hos6fl5x
	 6OTrG3LbpbiZOzy3UcwlAsw0tFTzDIZ2xaRr11HEU6qb1VXA5kL8zM8DfDnn4zbRsIARE
	 DBg6kZoKe6Itr6+RqT47n7l0JtY/q6qygTc8Kh3THoBmsVDrwllIg4r7+crwmiUTNGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylgSOtds;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9035606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9035606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ylgSOtds
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1132228a91.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560873; x=1794165673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=ylgSOtds+vKuQGO1SPIK0b4CWLnsS+qzZzgDEcEQL4+/c5pQDRfVVyh1wVdjYxgvGp
         NktSTa3+keIK+P2ZhO63JArzYwBBmykW5b1GMyNdIZsyWvxDPkgAGK4aSzfz+lGdKH/y
         TTzyps4007E8pNYrkJyHZW1ZDDLYBsRqRrwneSO9r5fj7m/68x0UteDtrFUTjODOCgFM
         KFD9Tv6cTYDLVpgDczrfmELzjRvVSCYu+i0R49+31HtabQd/Q7T3HdWdMq+9zxN/Hgvs
         VFjIT99QoAl+vOztR+Sv9tOXvf2owrGJw5Gi1ihgwYLe2eb5yDRUM7WY6J7jzAFHUDPd
         sCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560873; x=1794165673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sdirJ0jP7o+YHEJCnK7VR6r1ybPNKkJjwR4pGDyhi74=;
        b=Cb2zUPcNHhpKcdfQK4IN1tWH5yZbEUH/LFDOLj4YYXb4RnBVX5yCaew4Zt37vLfWOO
         za4GsCFn///sRPHjNx9p83ws9mNZJdxc+KqOGy4nqOeMKDeSbZCsglUUyv+hr1xcyBtY
         HuXFZiplfrfM2WO62PonFBVdLBsxC8tsYRvLA36Hbh7Kz9lnmiTcZSQGoPUbvfcE2pLK
         GPEkJTn/CMocD1jdTsiJlrdzQxelL196pQoK1OxOzRvt9gGc6mnh2Fy1H0B0RxPReGUA
         Dy36W85NXOxnQdm+x+cVpfFvpZKvLsvTfwAfNaHBTNVlhyaeg0itQE8yd6P9K7Z2NdI5
         ljBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxL1x7YuRZeqmFwPVN6464eSaQmQjTD0+iazMRAGlg78ssWs0BNsl+1a09G0VRO43l+QcMM6wM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/k9afCnLKAJm2VRi3DjMHFpWPudA9GMHTWvausYjBaEENOirMh
	BH0lGgKu6I8solvCMHJDveiVFhNTAiceGauohm3FoCGTz9TSNTFSbIrR
X-Gm-Gg: AYBFou0oCVHai8cuadQHCXMnUmpiQyF3HNuo2osq3dEVJerJYGt5OAAjfFZUbEIkcnS
	Ga2kV6kofJKwcQvYu5x1T9366syALxUIz7Kvd+PTaYAe6Ck6K8s5ABDNptu9OBXRakRk4mBlAtM
	C41ba9I8VRHuW6TNsFJi/8JzQbRavpRcaeNMLZv/AVrB/C573IwWtrLZOdT0rLZfeXu86KfRBGD
	xSBAGTfg1TpoJYGjJUZ4g76MgnOiMPBv0IJ7OSEwJ0hBIHDDP00D+jBVCv3A4UPTqKIUOUMwDln
	0hcfHGUrdHM1rMGT7OcnIZYqZCB/dTI7Z47P/U3V1dc7Sod/2dbDFzikKvftUvWSO6rSM0Yi5ff
	wvmASXxra3NH2egwBFfCm5VLkgQ8ex0qzbJTpW8VArvcMQGiCcSPp9AKT5OmqMFo2tM5R+x+MS7
	poAnYpq0xGjIk4kSFI5dXJ4FtG7wBeiU/WddGLu4GTJw6QkJYWIIrmejRpvVo2/jxq+e+i8z/t/
	46vHo8XEIJSHVpV9yBoR/k101Qg2TdkpdRjRTpUWPmozGH3YIeS2fW2LlkwYDnHzlxaFGw62F+o
	fkcf1HZ4ytNQmgqMqXizH6TW4jASNraGQY0Wf8GhwQRGx+XG/NTgEfX3CiEovDrLc13l51rDxNH
	PsLRY+lH/09xk156w4iVsVJdckNwjtCeuWI6OetsAF28aK2lIt58Gqf2bxXMFh6ILtZ9NfaY1b5
	TaGGHdn/66bwTttrpPR0c=
X-Received: by 2002:a17:90b:164f:b0:3ac:9ed8:f310 with SMTP id 98e67ed59e1d1-3ae8984da7fmr7182937a91.49.1793560873116;
        Sun, 01 Nov 2026 11:21:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f69605sm6059562a91.2.2026.11.01.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:12 -0800 (PST)
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
Subject: [PATCH bpf 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
Date: Sun,  1 Nov 2026 19:20:44 +0000
Message-ID: <20261101192057.2296489-3-alexei.starovoitov@gmail.com>
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

The verdict of an sk_msg prog is valid for one message, or for the bytes
that bpf_msg_apply_bytes() requests. These bytes can come from many
sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
that resets psock->eval is after the switch statement, but the __SK_DROP
branch returns before that code. Then sendmsg() drops all subsequent
messages with -EACCES and does not run the prog.

Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 8cf63a9e7fed..d90bcc911b36 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	default:
 		sk_msg_free(sk, msg);
 		sk_msg_apply_bytes(psock, tosend);
+		/* The verdict holds for apply_bytes, not for ever */
+		if (!psock->apply_bytes)
+			psock->eval = __SK_NONE;
 		*copied -= (tosend + delta);
 		return -EACCES;
 	}
-- 
2.55.0

