Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27437577E46
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097647; cv=none; b=AYL7VS3w5mxxQVOWOSrYdZsewac2/FX/4ggC9ol2naJKlRycTws7aV2ftyfpdzgBb8dvlG3tiVdSYD7zU9ux+rXKXDvVLGP/UtWPzYgCpMus9mxIlzLW3Wn8gEQ+wbNgeM3VtIyBlKXJChWbi8w+TkW8INK1gutPAFEO4vwRy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097647; c=relaxed/simple;
	bh=UyVsKi/z/KsUsM+tJ57iW2vmtY2QlPdWiKWL4HrNgb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTZNHeYp5WRPuXV0R0YAEfIFMzPci28jOSDuS7UC5sTNrm9CcNHCKQOEjKSa2kqpLy+RZjM+UlFgjS2IVMlX4G/xWgI4UAkvURMMqpFnpK43uJltsK8mKRGnkd6y2dnNTLB2H+g3n35mh4e7KeHPOb09cnWLSQtLBeiAT0+BfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=oaDHLkM+; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="oaDHLkM+"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so122054a91.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097644; x=1790702444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6jvocuGAG0VoEVU1ra59j3nMXDz9/LzPeuMPZJ7bQhE=;
        b=oaDHLkM+0GRNKT9nLSk/jo60n28sJNmB7wnYjVBCktTxr5wcrus9BWfuq6Wmj+QMB6
         K8vfqa2jloqzLTT+cnNaj4vLxLcsi8D+s7goXFQye2tr+07J+gLu3M3YflkYLKOvFQY1
         oHTcET1bwmtPTweSpy8cCROdfH9iIshqnyUDUsQIbOoZ3Q7LHQSeweybme4WkQdI9ANB
         cvwdjasZ1d3I20KYSmzNjK6l5Bo0U6TH6WZOhmtkLAfGHDqkJ345FzrPW5jFkz+5NmqQ
         50b4NOLk+VTptg5Oj2owNdB4rJwzd9YD8P4W/dCToUND99t9MhfFW8OSxCBr+nGMj/Tp
         4M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097644; x=1790702444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jvocuGAG0VoEVU1ra59j3nMXDz9/LzPeuMPZJ7bQhE=;
        b=t9osBI0UVjHqW6t1/Odj8390kkW1gtVfxSEI1i5cu4fg45TVdznqe2JJnsoclmch55
         DBY8I24awvx54eYdo/AkPaluXsIZLHANRCVw0Yp+h3NYj0peO8l4oahEQF9LPjyX6Z4g
         twUkJd+lFbqfuP/nK42Hqx/v1NwZcNvkJ74GATVSBuY0AcyMovFIwrYsNNbn/bVyuOc7
         xyir/PU60CwVSbDMtJ5Y+zT6eFjPcbKdXivahgr/p6sVkHFW5T22w112PyMj+O9IFdvc
         baKaV1FdDy8slYGSbbiUNFExI9SCAE+It/qbsxXXDV873o4qGoKsE5bHJVEaqtaylNk3
         rQUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnp4nAp6+i4qTcJITC4ECr2JpHiSQ9jVAP8buWQATYGGFWMA2gjjTdplPvdjJmMADC9qJMFmc=@vger.kernel.org
X-Gm-Message-State: AFuF++lcDSwIKt4Os8UKGstMShXt1vZZUKHoIeWWPDKm0xy1t3b+7N/B
	2Ned9SzutwqamLhIzDk6dmAPTX6C4ZZwBxhLirTA4L9sHOauTlXRB2uiYUOMhU8r6Jg=
X-Gm-Gg: AYBFou0lFPUWi7RFQbvFr+vjBgjKm5WNismF8Yb7y96JGfZ/Y2pGXQKmoV8byQxuxmk
	meb3D2ThBn2hAR7LPP7ojzK/lYzdeTFH/D1lwePLx1r9OI6npU+vmE+UzZYq3YGi0oig0jePkTi
	1GAv1nYCt5e4Pa1tYvcPxduex4F4heiGiIkUagTlRqcU2XR12O+oIvUiDlbHjE/xFsZxifdJ3Xe
	Kenz2m5UBEBnDhBFXWczWxCzIDf1yXzYcyXWiJTlaSoIIYWb5GgLq1FxG4EzA1S5BCq9Q0j52G3
	MJRS8JoIxzFua8vFM2VjIfOQMt3XK6rtofKaT6Zms8AbgMXCXMAaEvXawsmgSv8CS1AY75bvvY4
	heXXglQyTj3ya3TSwJ2e5VuaE6/u9XYTFB8kEpUeCuOt7EFUb2jovMi0EhrF++Nn9Vp0xvLvWAd
	H9frwaRwq9U0qDD25GE+wAQGWuI82BU5F11S+EgWr75pRdP1ATSpLN3/qzb9jqAB7KX8EVoQWMd
	HVOvsiiVayKIzJzzjZY5PJHUfufiXmBP/VLWypTkrfR55RfEp/XrATsWbohYM8=
X-Received: by 2002:a17:90b:2f88:b0:39e:6a81:f349 with SMTP id 98e67ed59e1d1-3a07e6bc44fmr119066a91.35.1790097643516;
        Tue, 22 Sep 2026 10:20:43 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:43 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 04/11] selftests/bpf: Add selftests for rx_queue_mapping context access
Date: Tue, 22 Sep 2026 17:20:21 +0000
Message-ID: <20260922172028.6269-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to ensure the verifier properly tracks the 0 bit state
and width of the rx_queue_mapping field read from struct sock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 2a136c917..565c4d8bc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -88,6 +88,44 @@ l0_%=:	r0 = *(u32*)(r1 + %[bpf_sock_family]);		\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("skb->sk: sk->rx_queue_mapping [no sign extension]")
+__success __success_unpriv __retval(0)
+__naked void sk_rx_queue_mapping_no_sign_ext(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0xdead;					\
+	exit;						\
+l0_%=:	r0 = *(u32*)(r1 + %[bpf_sock_rx_queue_mapping]);	\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_rx_queue_mapping, offsetof(struct bpf_sock, rx_queue_mapping))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("skb->sk: sk->rx_queue_mapping [narrow load mask]")
+__success __success_unpriv __retval(0)
+__naked void sk_rx_queue_mapping_narrow_load_mask(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0xdead;					\
+	exit;						\
+l0_%=:	r0 = *(u16*)(r1 + %[bpf_sock_rx_queue_mapping]);	\
+	r0 >>= 16;					\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_rx_queue_mapping, offsetof(struct bpf_sock, rx_queue_mapping))
+	: __clobber_all);
+}
+
 SEC("cgroup/skb")
 __description("skb->sk: sk->type [fullsock field]")
 __failure __msg("invalid sock_common access")
-- 
2.54.0

