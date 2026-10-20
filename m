Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511942;
	b=a+/bFk2wKx4Mq6kKPnURap463oazd5jBl3xRVEElrNG1HAXf5FyPRjb+GFO/N5XUl5JO
	 9W2VfbhpxZGzU/sj8YdCsmdOHronip7xLMI4XOUfGUWJ2z1teXUFAEbAIfSiLY8kbTZ8/
	 bEF8x0ud6yNidgMY92Nhk7GHNIwXI8EoZTwHR2ggd5vXdRyJ1RT833KTGiCrT1IEgcFDI
	 y/rIaFAjxeyGIIrCSrlxiUhkrYdkiAIFdh7C6d8woLUedvAAzzfIKKq4jPOup6QHCWl00
	 0oQL+zRJwxSut0F4ih6aMqX32Psc1VGU/ebiK3mMJ4SiQGCVOVaeXCqs69rtzFXIs3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hkgVqWYUuUzLDP7QxqnS40Mb5Zrh1ZPW2NmRfQG0dH8=;
	b=UebAU3levSV0WBU3fa6hscaQ+Za3ByMnK1NLGy+ycefIB1uazrGh8i0tfVEf1U3rJBYH
	 YCPQaZ2PkV2u2OTspcdRyldFfozN/W8VVIl0C0eAuHXFva+RKrL3+QxFc+jOapGD3wH5q
	 CDVtGN03U4v5X/9DQ0lIYOO5NOfGGc4XDL5e6VjrOb37ziAnETgJbOYsmtyNhbPH4NNgU
	 3jr+lgSGj6oLIqxrPHfV3Xis4oAIY5QIQWDtbTsuPceSk3UgkNe+QzJY6+L5SStnbamqu
	 ncVcMZiLcEzdCbBDKsl8xk46+dOe5vWFuhjsagUVavtAzuQFPiURiDdgDWxZiX5GiHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="YB/kKZf+";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCF606A326
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CCF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YB/kKZf+
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so32276575e9.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511940; x=1793116740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hkgVqWYUuUzLDP7QxqnS40Mb5Zrh1ZPW2NmRfQG0dH8=;
        b=YB/kKZf+2zDLE0l1rDMj1rAlhC89gSpo8PQV+lHjiAidCvrYVVX1tz4U2xUJ9TQU5g
         WLZ0l67wZFln/UoDptumliUJBACbySqbNGqz2pn97nLTAiHH6Owr0ML3hj5yVWB5nfeA
         /x7Ajw+ljLaCrlfyCKJhc539APZkC6jQgNQMQ6i+il+RLhPKtQt1Z0/Khad7IbYiHBSA
         AIIPqqSeI0pGdHy1DL6JF82eCe7hqNkW8RtcEt/x+oBl9pJQ3rmcSxJUY67LNt4C8n2i
         SCGpypZIBEz6X85qas5DHIc5L0GBKCGpM3HVlhDqU33GLjzjdphigz/AviV0MkY6pFgs
         L1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511940; x=1793116740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hkgVqWYUuUzLDP7QxqnS40Mb5Zrh1ZPW2NmRfQG0dH8=;
        b=U70fgHELzZ3zdzzDrcQzS599pxXiQreYenCNbz4S3gr4ETUjb1c88yuZHjqc/JPeE1
         Zz+SxdIcdv5mNHoJS03Zgw3HsTwT4t4yyfwZigR5TxDSXag5YizVsIvhBIBLU2pCS01T
         F4oGFLsUxcedN5SHzGWXOglatuJp56aSuk5pMLGGAF4HSUe/D5shpQ28ODVKUx2zo0ZH
         osl+5J8wTS0mwl9OB7g+0y9NKPlCIiqE8uV28UQ0rYvqKNQKkgJId/Z6WFdBcUXtJaJ5
         af5SZh+bOLrPjqfJ54NBixGs2PkKhIWCAyfxoQsa9icG1Z9H1Ec7hjL8hJQHmXFNScbm
         FD6w==
X-Forwarded-Encrypted: i=1; AKwUvBysvhvJybPxhu2I5SSqdCFIU/4aWcDPg33nz6M3jaVDqmU+zsf2fDrQgmbcBmZgkOelJs8meNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBF6tApe+UIztYS46sThH24Mbjo6cxRb/+5MwkbdBUFlAU0LqF
	MYr30D1QEC8cKppJHc66+UeJ15oTEPFXulHlogE+STEr5FSHIC83hBOu
X-Gm-Gg: AYBFou17Q2CwnDmcBv/cpzQu+yHjiALRvT4LTQ0BGZKF515rSGWuNx9qdNkmWXlHwW7
	vW4a+zISNr6uJ4oI+JM73EPOaNcm5Rc+NKTT2M4duelSqbIT6v9lptDFjrtc6V5LQSAY9V9bMra
	udzLAP54cp6D4v6kRD32zozlHeR6/UNSFOCt5mTWvwgab6vX0foU+3QCitNlIIMFWLDN+EQF9h8
	TQGORRPpyUTQrfaZFjRmtqBJzUWGC6byoIqY5WXOMAkOS9qXknsn8qbo93MpJjn+F1pBZ1T856c
	QkeL1/eoMM4pzpFqLNI4ZHNZiARA/JwOI1eQ0YWUyUsHOJh5f9Hi5Zn2Dol9iKJfRcPupFcvsdI
	B/FTgrx2A3ItdII4lliOU37wBwwceEXvxO0hfcnYtOHbUz5iHjlSgLX4ZLJN/B0jfrLrW8evi8W
	g+lb5+jLrC03sZYbhNyPIOiq5Pj1OXmAXFNNWhk9GkQi7iWJ2TzHoZqs8cVpJQy89Gu7G7JYG4R
	w5Tc7eMhJjueKi1zB+Ecti9f6+m1m0TTAEKqirYnP9aZMCxPDlD0DxB
X-Received: by 2002:a05:600c:3b1c:b0:4a1:9a97:c88 with SMTP id 5b1f17b1804b1-4a1d7600183mr239776625e9.5.1792511940352;
        Tue, 20 Oct 2026 08:59:00 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff02sm5627335e9.6.2026.10.20.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:58:59 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
Date: Tue, 20 Oct 2026 15:58:48 +0000
Message-ID: <20261020155848.75711-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020155848.75711-1-mahe.tardy@gmail.com>
References: <20261020155848.75711-1-mahe.tardy@gmail.com>
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

Similarly to '7b0dfbf5776b ("selftests/bpf: Test forbidden
bpf_ksock_send() LSM attach")', tests that the verifier filter prevents
bpf_ksock_sendto() to be called in a LSM program attached to
security_socket_sendmsg() as it would create a direct recursion.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
index fd2ccfdb5802..9533570eb340 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -12,7 +12,7 @@ char send_data[11] = "dummy data";
 SEC("lsm.s/socket_sendmsg")
 __description("bpf_ksock_send is rejected from socket_sendmsg LSM hook")
 __failure __msg("calling kernel function bpf_ksock_send is not allowed")
-int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
+int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
 	     int size, int ret)
 {
 	struct __ksock_ctx_value *v;
@@ -32,4 +32,27 @@ int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
 	return ret;
 }

+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock_sendto is rejected from socket_sendmsg LSM hook")
+__failure __msg("calling kernel function bpf_ksock_sendto is not allowed")
+int BPF_PROG(socket_sendmsg_ksock_sendto, struct socket *sock,
+	     struct msghdr *msg, int size, int ret)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks;
+
+	v = ksock_ctx_value_lookup();
+	if (!v)
+		return ret;
+
+	ks = bpf_kptr_xchg(&v->ctx, NULL);
+	if (!ks)
+		return ret;
+
+	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
+	bpf_ksock_release(ks);
+
+	return ret;
+}
+
 char __license[] SEC("license") = "GPL";
--
2.43.0

