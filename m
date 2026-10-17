Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB63C7E19
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255327; cv=none; b=EBDR5gRd9pdSm02hNHVhufK35JENLoOTDc7045CsmX4yUyNVTM5olX2RvGmE8lCv5wdFGc0PvsQNwjOv3xEZZB2ugV+4Je8UlhVLxxTbLf619OhNBk3MgvD+z9huzV7aFaRb90V0BQDrXbhSYMb7lTTTD5hi1RxqpR6ooeXAYck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255327; c=relaxed/simple;
	bh=uJWFQogm/k+VnArKWm1Oiq+0VdAnIUrLmIl1JTgGPIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu8hAwTWu/V61cms5ChqKUR9zqYdPHK6xbfs8y+tMZMGjG656ZCBszTd/PDJjz4gfIh+gNraZjq6yiX/TPbYM8Bb3IblQ4j5479CJtiO49eYwEnvH1aKnnzXASW1KhSTjxE3vWPS4CO58IKi/XPLqNYjIEA/9iPadfRPuytByDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj0KhZeY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj0KhZeY"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so405051a91.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255325; x=1792860125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=erSNGXOexzpuTgq9LWuAw7nFMGwzuwSRg4vna02B63c=;
        b=Uj0KhZeYxdi7ouc+gIBvZfFBVh/s/APmc9fMv3ZwuAENYMezab47bnkkcn2etQSzuZ
         78fp9OmkB8GGq/do2YmK9Yx1sTASfMrpfDbEZziPKqpP8TvaIib5KnT8J+K6DO6KKEQ4
         Qk0Yn5YAoCFyHYX9nMVMZ57/0d8tYR5qgNFTz4oU6eYTj2wL2N6wCW1G3S7ADKqxcRbV
         VhM6dSBLy0rNDjN7GyEWGZpHeYTd/5MgRn45uBJHTYaq/xPqOeY7J4O9/qe4+Q6xa+48
         Tf/FZ7bCEPmzPm7PVf4pELoaOLoh3vZdv5jM1WtReB18YIcqo2IXqiXVI71ceQwPHCNA
         /DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255325; x=1792860125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=erSNGXOexzpuTgq9LWuAw7nFMGwzuwSRg4vna02B63c=;
        b=fy9LaKWQJpwLeGSOFzItBIefzNKnCkYbKx3wYNbcL/oe8c3BAtKVXkza0qQ60c3nGF
         89zVcplraUnC2ndJzOPNSjyEzZOI2d/Z+MTWDq6yT5cHbseAxuU9o/zQ+39NKTqU+yLx
         HI+wsa/oYxy0gNTVQkem+ARKrgMuGfODgtVqYHcAZSZCvR/Bnau2v3sYyYBxobz9ED6E
         LoJQ87W2vuFy/p0TVZkrtKk4WTygTtEApG+aw7aXDoh4nD7jFbQkSbIejUyvuXWMHzv9
         BHM5awo199NlvZYjEBGOMLlXmdiSx7c3Ru8GQifOYxisFYJYIEuUdbLqCrUkT6nFCQFi
         H0xw==
X-Forwarded-Encrypted: i=1; AKwUvBxnGSWur77aEkkYei5Q+Om6YaFHxu90sKo1fG9qWYRPPSHz45ey4rH2+3qn1HK2A9GVQsPcrDo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpzxyUL2QYRpRtLGEsNtKmte7ilJik/kM6JpShjZMLy8xuJbJM
	4QZAsg1K7KWbWyCPDlCHA5BskHiW+p7GV0XqhHBJVQayugDYUaUEVa0q
X-Gm-Gg: AYBFou0O99WSYqpDqLiQ3+Kq0bCJNH7LO4cc1W/YsR5eFjCalRnEdq11PmSvydxxYHL
	Ls2j+OMlPX3lHBBblJhm1IlY3f0MrvbmS8Yq8GAZLfdf3ltCaO10DQkHsH99djGT7O6AkBkgOIA
	RggwU9OzItrin/ezOS05ez9DPJrzRpal4JBI6DUKi6Yso6mfETdaE/wzG1bxn2rD73tTekC17cp
	B4AyTyXA1MeA7nbapxM801+hphka7xWX9Unk0+P8rKMjcVvTO2RCUqe6ZzOdJEaYt8S1Ky7duic
	TQOQP8peyKvYyhQBgf64PHr+YBjL4g/5QhKr8kpSv+XYo2ftWlliHbkPFUdYPFnvJZt/V2Y96Fe
	R4YWuxD4irFl5lUVaKWw4kntSx6RqxZPb52YDCbhmFyg8IkuZAztbMQ9E9O1sW6tlj8iBTpAecF
	NPJw57wKjHdvRWQxT82M0LxTaJaZvSqT+YgbpB77b551RtTQizbjc8f5WKVXguI/pBI98We/WLb
	6zMtWrc6I+QWLzRy4NXaUf668Kq4xnh0i0AQJudvFo+l3u2nirFkvsK86flr+T9XJ9jA0u4hqx+
	47Ddw+nK+u/ADKKets5iWv1xUSUV4EujNrFk+tGKljc=
X-Received: by 2002:a17:90b:50c4:b0:3ac:9ed8:f310 with SMTP id 98e67ed59e1d1-3acef5960fbmr3173920a91.49.1792255324812;
        Sat, 17 Oct 2026 09:42:04 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947d2706sm13829980a91.16.2026.10.17.09.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:42:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 42/43] bpf: Use memmove() to store bytes in an skb
Date: Sat, 17 Oct 2026 16:37:44 +0000
Message-ID: <20261017163745.3341787-43-alexei.starovoitov@gmail.com>
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

Through bpf_dynptr_write() and bpf_dynptr_copy() the source of
bpf_skb_store_bytes() can be a slice of the same skb which overlaps the
destination. memcpy() then reads bytes which it has overwritten already. On
x86 with FSRM it repeats the first bytes of the source instead of copying
it. The other kinds of dynptr are written with memmove() for that reason.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 12a5e530a81b..a9b641730f13 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1749,7 +1749,8 @@ BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpull_rcsum(skb, ptr, len, offset);
 
-	memcpy(ptr, from, len);
+	/* through a dynptr the source may be an overlapping slice of the skb */
+	memmove(ptr, from, len);
 
 	if (flags & BPF_F_RECOMPUTE_CSUM)
 		__skb_postpush_rcsum(skb, ptr, len, offset);
-- 
2.55.0

