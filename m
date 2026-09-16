Received: from mail-pj2-f31.google.com (mail-pj2-f31.google.com [74.125.227.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2673C063C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535320; cv=none; b=hzmqOw9Ktqfn5xm2V3iAfMxFEOWUoDaECQXfdHd/E197HgKTLVwwSTofsOKaGbJjJmPBFzIZKBvwa85zNjHqjPncJt8zgMXYkZFL+fYiQZCymvKpDF061lgRn5Epoz6AWCY5zCFxTEdbIZ/Xh5JYDlNmpNOV8HPR9kdEWlzTjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535320; c=relaxed/simple;
	bh=UyVsKi/z/KsUsM+tJ57iW2vmtY2QlPdWiKWL4HrNgb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxoxxRdeuEniIkkH54EGz4s1dAFwE4drPq+OJNdFmMsk/kvPYJuZxtRUELIjxcaWeIRlr0dC/KfP97XDNqlxjH/e5QRGePTLJJAIVIritJhAyM7xb3FxGilmYgztY60OIDQVy5FNrp19JNqA/ODj9iItLF7N6iPRAZzrkmlNZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qR3omIE3; arc=none smtp.client-ip=74.125.227.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qR3omIE3"
Received: by mail-pj2-f31.google.com with SMTP id d9443c01a7336-2dd53691be5so5372025ad.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535319; x=1790140119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6jvocuGAG0VoEVU1ra59j3nMXDz9/LzPeuMPZJ7bQhE=;
        b=qR3omIE3i2b//8R1jZSwzAhhoeAqucjeBZVGf6PZ9AmB2ixvwfyOs3TLGbXSplBDWk
         MeZVBG889TAr25ekx0iQ6UipvoJ2AUydzTGqJP837L2O/LpryvNQpNf/aYScyvIuYWgo
         RthQvZCIqz7c4NuQmg7idKH95a7iL8I/6/b5bhHKw9KxKNeZ80ODWa98JqnPMZKpLQsV
         YVBwZLFG/HHgEwvrjs9rBqp9PX2j0Y0zGorns/YyqgMrfQAqZG8J1Tu5mJJpvwJj0yLp
         vLLu+8gcOS/Kh/i9SMMucdhkH5K4b8KNtiGuE0LwBhfRKPbjh0Pw6NjO+wP6Ssv53SwK
         p8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535319; x=1790140119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jvocuGAG0VoEVU1ra59j3nMXDz9/LzPeuMPZJ7bQhE=;
        b=u/adenYCdacr27Qiq1cRKsUNLfU0TOKK507h9qI2o2in0Nf59rVC2BfnLlcD8JZkyG
         +7wVVMT3iPc30UtMc7Oka+Mlu4s8KTQZJwab6vJVtPLMROuhTufVGtvwZQ/We2N0Ewmo
         oIzViuZ0ZHCNGNcY96Wt0ux/hde/KMZubrdpJBaE0EEJupfS296Sh5BSOFYawUkzLSyl
         jQw8qWWOkbUoS8EqbGyBn5wBJAuI9qy8vmFQnXtm7nPXK2iwTIVuMVyCm5v8Fy5bOacY
         /ezhLX8Po9kfqccjkoOxtzC1UYPSnadbuC3J5IDh+2XAa41FEyERHpiRlQvy+vv9U18Y
         4Xdg==
X-Forwarded-Encrypted: i=1; AKwUvByVKSI5iI59AG+zuSd4WpNTf/8NK2ASKCBI4tjxfa7LwJaz3ugXA/d9UowqJTmd1Qfajc6b638=@vger.kernel.org
X-Gm-Message-State: AFuF++m6yk7rXs2oE//sEUFsW3glSr9UD+rTcPwCVVFZQMShsUD1RH+O
	SSXKPtRql9To4kS+BadKO8BxK6K+p0kPQ+V8Ubfy08g4313ibd8p6J5NwbKxnCUt/iQ=
X-Gm-Gg: AYBFou3X9oJjPYA4l+f6PAs9Ucy+sFv7zLK9ZJPYzrZF1aUJf8N8YRvPMm4HwMh5HuA
	cfZImz61VsCROZS87OUctvLlxlSIyNgeyynr/UlkXcSwZaS//xuJSLFqsHYbt2riIiH7Xe1efKG
	i4B2sRk3Y3/8rw6aor/UFUhjL5Tqwp/31DnA+/+VOWsrcP7yG88KnXybJ5Bm5c8L2SRUCucUwx9
	JolT9QwDA+xt6ofla5zTbxcnbiCYhVC422kJFArS5CbSsYzVlFTHHU6Nm4dnEfBBkZqgisZnqys
	W1vzLQqFispp94oX59/1Vs/0A2hEFEPcqlk52OMljXtEa++KHIUUZ+t9FHSmuEOGzs81hZaalih
	8mNNfVK1JoHc/JM6bZtS3vf8YjBjsVa+tBa9DctLKt0RlHuCo0tEIA+PN5355IV2pQCnnKMQWsw
	xyyWCR/O2JT4ss+7SD4fycepBxJEyp4dcF5P2XETHqooOZOOwBSGbBJ0kByVjldtwF08vGLtMCI
	VsPCwQJl7Qb+rtXEdXsNLPPcoADmupWxWK8JA==
X-Received: by 2002:a17:90b:5105:b0:39d:eca3:e296 with SMTP id 98e67ed59e1d1-39e1e49a1e1mr2791049a91.17.1789535318721;
        Tue, 15 Sep 2026 22:08:38 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:38 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 04/11] selftests/bpf: Add selftests for rx_queue_mapping context access
Date: Wed, 16 Sep 2026 05:08:22 +0000
Message-ID: <20260916050830.8774-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
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

