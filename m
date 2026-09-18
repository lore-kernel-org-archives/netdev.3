Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940C42931C0
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704715; cv=none; b=r+U2p4Oc0h1ILvX6d8bn1qWfmOUoZZFXZTMf4oMw1pKnRYewY/jhCCXsKCuw5hHRj8qDkMtOy77BMsbn4lPzXs8EX9oqq0jip12elwZBt545b0i4f4Y2y+C7U9+0607KtX6PiBNXw2XpwXG7J3A/ehm1L3QtvlxTv5i/OnTss5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704715; c=relaxed/simple;
	bh=UEUGvWnLmOamu0pTBgkEFgMYD4FBYYk7egJy0kl7eaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bk9ImnHECRNLOLUz2zWFyjD1GbXqYb2zGW2tN18nVxCSwG1T2hZLK2cYJ9gIl8RUcdDCW3K7fmMJFMOywE4NENaFPcwzG6v0BOVkKSysrk0xYOpQNEftnrEls9gH3r7u+6+FxVmKafp8X7SgyTN2d1DCaYGu/Bc7ztXh7cjh65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9d7womG; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9d7womG"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so134605a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789704714; x=1790309514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+XdyMw/cwUfbmJ3KUmFebC21zCmtXiVZ3PCKhns0RU=;
        b=p9d7womGPrpa1YbmZrfRaoHEQ6zQ1kyqmOHdc+LI5RhjAhSEigs07bTNzH6uWb/6zw
         X9Km5hCUc/pwGKj8qIPVOOmCokneXk3MA5AUyoNZwjJyZt3jKq2+egoiFUDx5hKsmcin
         TH9j119cg/3XF0yJmCvh5c8YJxr7mPleI5IVPfurPZl0+ehRdkIAOVN2mLxRu+2XEyq1
         gfZdalEZ76st897KWqTbUJM7riQtynzgjitppSK15VzlEEX06A734ZDm0tF/+Q0Si1rd
         baxCkpU/ix9KlxKiYel6HrBdE7MELDkzjDMWDIeM8c8aaFmPWQjgsLf78Za/xcEf1/Ox
         qP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704714; x=1790309514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+XdyMw/cwUfbmJ3KUmFebC21zCmtXiVZ3PCKhns0RU=;
        b=clx/HOZv7X1iGdx0G0EybWwvH28s9NuYK8FpVwEPCadNLjeisOjXXnte+nB7skhfuz
         ekxGbOvwew+hO1jaww8ZLY3QVSjqnS5q2vlpY9nBwhxYLR1HygnEunvWb35EcgOgBo/O
         ji8iIbc+M1g8Mydq9wyvmMCYEebHfGRkKC55/To8M1rawOh2RmXmHgpZIP2DwVrB/jni
         X156Agt43o0ByB9L8bXuOX4k4Rxe02aPdrt/kFAQfm7D54yf4j2vBdT6hbeyzNWCna8Q
         CVNihizLsXVb5rftN67d0oCGnlz1sGcmOxmbyUvDryPjoko/oNh1XbQHNePdtQnSc0GO
         qXNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxL8xrRCc4doEQTb9qiIPAT8vR3iBgQYNbjmSAhNq5hH5COUw3yUoyvwAFw9C+09qqSNwO5x/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nCj3jgfGWwFXyIzHbNrzKGm5/EcVW1bCFVPM1/TNk34vfRi5Oj
	rQoKKoj2OD6Y60zH52me8pdsbBfnmX0ysFTEmKMb+NwSRfb+gFzhZbat
X-Gm-Gg: AYBFou15DB6nHSCsgA1SHtam+ALqVE5y/EVrRzhtuQJ2yvrXZSP+eVLiA5mnGwXrDaX
	7x3whvCWRr81IgJSu3oFZj+IvS88bRWBxsj58BmNKHQzYHPW2wAbC1kFlgur24FtoabTNnTS9w9
	OVeTswpQtdPsMieb5kqU3pVwlFOnY9yRGWLEBw3HPZO2WJmkDGPqEe/rlE83g1ZxG4t9c+YbgMb
	mcNZToEpJmfjlXmjj/a/xLp+GR69IxF0KBnyQlkG68awMS1iqyrE9J76D3SjVW1dDo+qUa1m3DS
	ixDCqjjLXsk4bH19IwzFC3xNsmJCUb4srh91FgcN6MLwp6ezx2v9d8ux0XlCGr64jKuTi8NfbHJ
	XnkI2ZUrbOi5FtYrIFQVkZdAJ3r9DsIz/HFI4KhN2vnrcSTkV+ZMV9UrUu1B1p1ra8mM/SVP3Ja
	dI9A1gWYAl34gCTRQFzOhBDMr6nZrj/eftG/Lcz7KD2eC/ktQrEJ0D5vh6egf2ab+sbrT/nuk0G
	tNiNUqfgL+qW7plAJPb7oS83vVUyF0oF/lZvf7KRE9y0iSorkAClFNN9EhBmtTT4VkMwLn84LGa
	aba2Ecfe9ZnK57ayWg/W223Zd97hfFSVh94Sxppc5z3UfS1C+6kIiUzVZ/b/VirXLQ==
X-Received: by 2002:a17:90b:2b8e:b0:39d:efa9:cd25 with SMTP id 98e67ed59e1d1-39e54c59c74mr5120122a91.2.1789704713961;
        Thu, 17 Sep 2026 21:11:53 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce046d96sm1126081c88.11.2026.09.17.21.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 21:11:53 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] samples/bpf: remove unused hash_func01.h header
Date: Thu, 17 Sep 2026 21:11:45 -0700
Message-ID: <20260918041148.602323-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

samples/bpf/hash_func01.h has been unused since commit 91dda69b08de
("samples/bpf: Remove the xdp_redirect* utilities"). Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 samples/bpf/hash_func01.h | 55 ---------------------------------------
 1 file changed, 55 deletions(-)
 delete mode 100644 samples/bpf/hash_func01.h

diff --git a/samples/bpf/hash_func01.h b/samples/bpf/hash_func01.h
deleted file mode 100644
index 38255812e376..000000000000
--- a/samples/bpf/hash_func01.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: LGPL-2.1
- *
- * Based on Paul Hsieh's (LGPG 2.1) hash function
- * From: http://www.azillionmonkeys.com/qed/hash.html
- */
-
-#define get16bits(d) (*((const __u16 *) (d)))
-
-static __always_inline
-__u32 SuperFastHash (const char *data, int len, __u32 initval) {
-	__u32 hash = initval;
-	__u32 tmp;
-	int rem;
-
-	if (len <= 0 || data == NULL) return 0;
-
-	rem = len & 3;
-	len >>= 2;
-
-	/* Main loop */
-#pragma clang loop unroll(full)
-	for (;len > 0; len--) {
-		hash  += get16bits (data);
-		tmp    = (get16bits (data+2) << 11) ^ hash;
-		hash   = (hash << 16) ^ tmp;
-		data  += 2*sizeof (__u16);
-		hash  += hash >> 11;
-	}
-
-	/* Handle end cases */
-	switch (rem) {
-        case 3: hash += get16bits (data);
-                hash ^= hash << 16;
-                hash ^= ((signed char)data[sizeof (__u16)]) << 18;
-                hash += hash >> 11;
-                break;
-        case 2: hash += get16bits (data);
-                hash ^= hash << 11;
-                hash += hash >> 17;
-                break;
-        case 1: hash += (signed char)*data;
-                hash ^= hash << 10;
-                hash += hash >> 1;
-	}
-
-	/* Force "avalanching" of final 127 bits */
-	hash ^= hash << 3;
-	hash += hash >> 5;
-	hash ^= hash << 4;
-	hash += hash >> 17;
-	hash ^= hash << 25;
-	hash += hash >> 6;
-
-	return hash;
-}
-- 
2.43.0

