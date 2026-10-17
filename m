Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578533BB9F1
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255333; cv=none; b=I4DCzzP/qBhENyLB8K9B4Pz0vign9qblnL3qe0esA3TSh8VVUtKlXRcamMRelCvFmIFMAJxW1L/WCh86lnb6pDdsphDY7rCZ8SN5tiUrag7pN0Zz2yWxBLqAgr77OL+0JILEDvjvW/5A0yImJir2fLk9tIkdtwwHSOlCgRqM8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255333; c=relaxed/simple;
	bh=cUgZPO6rDmBAZ3TBd8ca2pe/kBrG6oSkTuzTM3KDQjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAOMqaYb+w/IkKOuoOfaJx2UyKoJVRVd83gmpM8VfOnoOFCULeAuCY9yBLSTR24wEDvASLdM4M/R2kwi5e5F9hf8RrmF2GTxEO1qgwG1nSHszIlZxuSv3xfSXnKQBIlABykTWRo+mLl+gRHbl5/IF3SDUVsi8x6YkCNNVCw1/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN1M9dk0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN1M9dk0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e98798cbddso2807675ad.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255331; x=1792860131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GSrpwkIAy4RJ9hTxdnQg9rKeSuvGVvr1IWVsPK04zY=;
        b=VN1M9dk064FciW2mgKlESZLEwCCmji+U23+7liI25UK+weYxMucQ0HnyFGVmwUP2R5
         lVp11PfrtHzcnIX+t+OMVq/HmOMglb3aVr2TuY7XS0TLpud+ylYOA4zCncHrMTAvxTsz
         jr+49TwzzeTQTYEio4wqBoeiG8o3tVDUkiBig0dWoZNHhqLDSkT5tWiFRA46Flgumgz5
         sBiGjEKG/eDwkZQRvAfGxFrwVAe8LtP3t7Hnv7Ocq4J9jS3N7UzuY4etvZU2aj2q64lg
         tXIywV9DEbwgoImgNj9YLKmwH7BM8gEsfjjNtWWa1piqeewAOytUwBaZLw4NmH0G4owA
         g2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255331; x=1792860131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GSrpwkIAy4RJ9hTxdnQg9rKeSuvGVvr1IWVsPK04zY=;
        b=bdv/588gtxYNm/gG0HX75Y+wP4wck2J2rIvTiFhqaZFICVV7GinpB7aYZquXXjFAk1
         960k4MrHXMkNIz5X/eQqSSQvBJlpXHq5SfuEkNWSfh7ZZMKMFYFxBysYErKXbhLBSXQy
         xppukeYeTaJc1NdBF8X0BOsFMMywskOMUJuxkTAyNfORfkk2oQOm46vqxvUcihgIs8/V
         oL0/MqT8gxcQqqT17DK+rjLlrvBE9xpM3pYSIXhh0durT7OU7CiW42lVKGzH1SHcLoD1
         q2jpYWhgisgwzRfJwRITZ6IQqt4HH/HwrFnHHZOT+BZ5qLRkzImCFIW8jSI6gGX2iIeD
         XYDA==
X-Forwarded-Encrypted: i=1; AKwUvBx78tavA6YuNWdlHiUNmGxJb9nUonJXxYTvI53RfZWH0mxZ3xfjIYZvYuwoSf4RPHlDtK7C0qY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZOy1YVxTeUJPjiLheIlkIMxC08sg76KEtS1W6TcrQqHf7jW3o
	IM7+0PCvCuVPQy2SrdE72x9ePqn+TizzOwbEyr6/V1ACc884SFG3yedS
X-Gm-Gg: AYBFou1ml/vjTIujD28OcEeQg85Z5TK9NR2xl+oANOkLEcU5rJ5if9XqHAvN3g16F8I
	V/yXgPhVrYp5GkXwvDuqtgRiwXeKRb7q953kNsujUlmNr66ICiB/GI2u0u9BnTNo6s3y2PrcnCv
	D7Fvb2FAUOLA1CT3PPbAoQA6bhni4wOJQdph2C2WVV44mpgq3+HqT0HgbS9v4wrRZOSXDUXYnhv
	FjlzzRA+4dfH0WkpawP/QJCmNMp4vuoXfIs+LdMcCxN8BonuiqKg3W9zKADhCL/lElC9wy8rvmI
	SB6nLwXMrjXwoqlNYY/noKQ9rZpmhTiK8tFBOP/KaPrQu8j2RfpYG+jm9432BlPl0yvUgRf89cj
	VYRsGd/3Ow6hz3zORAcdvzi01LdOgsWvqL1mbAAfituimiwwK+ardRYmUtQNtj5IKXuYFmgtd0I
	2uX3UgS60xT+rFokevDsvF4vcx5Fn09OQMd4V6Rdq/PRBhwnLveMvmfWHgY16n8hrS4xmZzfy9o
	zkmwBY9IlP+9sHxaHL6RHu0q/HfsJ4CtNyKxziKlaIvFcRO77alKV9kNff80nu5pCbTQI0D4Wi7
	/N4L6chdkR+RanP8H/13C161MKq1g9q8K51/XbUuK2Y=
X-Received: by 2002:a17:902:d492:b0:2e4:a360:fcc6 with SMTP id d9443c01a7336-2e9a6c18d0dmr29946625ad.35.1792255330703;
        Sat, 17 Oct 2026 09:42:10 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b35eesm21952125ad.73.2026.10.17.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:42:10 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 43/43] bpf: Refuse packet slices for packet-changing helpers
Date: Sat, 17 Oct 2026 16:37:45 +0000
Message-ID: <20261017163745.3341787-44-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The helpers which may change packet data do not take a packet pointer as a
memory argument: they have no pkt_access. bpf_skb_store_bytes() makes the
skb writable before it copies from its source, and that can reallocate the
head which the source points into.

A slice from bpf_dynptr_slice() of the dynptr of the skb points into the
same head, but it is a PTR_TO_MEM, and the verifier lets it pass. The
helper then reads the old head, which has been freed:
bpf_skb_store_bytes(), bpf_lwt_push_encap(), bpf_lwt_seg6_store_bytes()
and bpf_lwt_seg6_action().

Refuse a slice of a packet where a packet pointer is refused for that
reason. All other helpers take slices as before. bpf_dynptr_write() and
bpf_dynptr_copy() can be used to copy inside of a packet.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 47e2969928a4..8cddbcf079b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9693,6 +9693,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
+	/*
+	 * A slice of a packet is packet data under another name. A helper which
+	 * may reallocate the packet must not go on reading from the old one.
+	 */
+	if (is_helper(meta) && reg_is_dynptr_slice_pkt(reg) &&
+	    bpf_helper_changes_pkt_data(meta->func_id)) {
+		verbose(env, "function access to the packet is not allowed\n");
+		return -EACCES;
+	}
+
 	if (arg_type_is_raw_mem(arg_type))
 		meta->arg_raw_mem.mask |= BIT(slot);
 
-- 
2.55.0

