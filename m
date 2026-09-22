Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEAC577E57
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097657; cv=none; b=R9ggr6pOTfjoiK+kHiZUmvW7L0/NezTOR4m8B59aVTgYFcmXfR9otDedqTiz1IKXQa7AoT3lGbO3BFhYeOLKb+qCmk7V8Ybsco1tImxAouLn8fZh0dkKZoylBA04EVW1r0HEWM8JLNcUl6XOgBEaoCGVUiBaIRPDCYv+9rEOg7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097657; c=relaxed/simple;
	bh=K1kPVhalzK2p/Oi/++MfwlZAsChdgNM2Rym6IJuVlIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYhlFsa+CGG7UIAZvLAhQJBbIOUEe6xNK+4/a6ghapJVNyunvArjz7SG+8F0c/of4BnAwewFaXlxKO8zGChre5atU3+xjrN6GlQ/bMucJZXOyowrBRAsQ02nRc+wJIjkGjcNFNM0CmN2qRO63y9XRG/tpFaafdux3VauMzWR95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Ckanra5P; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Ckanra5P"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so73485a91.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097650; x=1790702450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqY05vLt4ODQV/QJgRg1j8e1nKXlf81O3e+mqZS/iH0=;
        b=Ckanra5PxxbZxie5E8MY2JKit7FD/FM8Fx/J+pbBUx4pd+Xpt2mlCPXZsUU6ghTyGm
         O1UHFHV7drCk3PVZ2CjTukoohLiC6ThARPSY713tuA7U0tdW2+zns+XTD0baf2HBqy8D
         jXuMTj4PCtpTAnlUwVD0k7rHb2cBiVRVKGxUKRCsf1Mi6b8kMz8q4xlFD7K+RYWzAaNY
         ZTBVuf3y0EnHNIN0spQsASeFn4tfXWgjdEzkuOdS/RAS+2A+ayBYXTh4mszZeZDBV8k2
         wWOHPHCcQ/vx0Jq5SlFT5o4jxK2Bq29fR0flpDLvHBmZNETlqTwjj4m4UyRJ9ru3XYV/
         egtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097650; x=1790702450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iqY05vLt4ODQV/QJgRg1j8e1nKXlf81O3e+mqZS/iH0=;
        b=I8YjRsE5dXmCc5f9U1LgcrrGh824eEmowWGcKSU7FLy5OK74dMBiqlRPDfT/263WSj
         NRuCJCBOSxggKFaL7Wub8nziw4TXBDKjQSSz+G4TS+3UV68wZ9trpsDw4kmsb3S0RtTK
         9eY4e6Efe/2v1FrLuBfmisVEVaujTTWsQh9YGpjQ4U4GSiYJ7uBUz9y3bprUEtPnFbYw
         zhWlm5dTXFVO2MTeOUWUarlXlawE22MuYqPdjvA5e1GOXCWMyWJVZx7oZm4rd8Htrg8t
         b7VpHcJPoK41sp/LHkb/5KYJ69St7BHhmFN2Iw/PsX4VA3yJ+8Xe/8mmrs794qxcp62e
         Dzeg==
X-Forwarded-Encrypted: i=1; AKwUvBxDY//7Nxw/Nb5Zfm9Eox0ni+5gNNWm9HHqT2WuzQwhX4lqPRUN4ESj2XgvVQznypKVSuWHdZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++nXk60CCN+zDwAPHGzuiqAhJtxu8aJtHOBRnERUFkrr25Rs7iuN
	qUjCo2E1lMa/RmngS+OT2AXHnfAYieTdv37GdcqMLc1WGGMGNBXRGiWi+qkYe/Nt5X0=
X-Gm-Gg: AYBFou2CnZ5IMOOFMUrC0stwn+FGPJ0ZZ11MS3DKnnHjxjUXbHt+3IdFEVaYUkThfjN
	80OakxHeGzn4InkY9UuJ/2ORUxxMgjVrZ3QhErmr1XvSqfXLuSI95neRMV15Jgyvj59GnVdpRjo
	D1vn9cBIKQ44ZF5kLtiKWbhpjSQV7hnzJOX+2xns7wyhv8yMCzHw83lYVIOcjYAesM0j24FeGJJ
	IOrMjNKDzat/ppZfvxKB1um8qhjI9aTUye/E7hftdJTZNT/V1PkIVPd59CPGoeRTixK31RKZEu0
	CboLjU8W/o/4tEcQgRhPuitTDzxvSbM2WmVxujYmuBWv80LXQ6Dayf4vQ1COLe3Rwok9FuAFMwI
	Wh8ksI2UVjaCfF861HMhzj6PTpUeusQUNfUNzrsZD5pbOGt8f44y2BzPVp+4uGJMpDA+cZ44WGI
	TRZ5R66eD3f5l86s2u/jsEA0MXBcYT5PVLYOcxKCL7/gHnd4Wn8O/42L2WO9ItrTsQazdIpRm2l
	0N1o0ag8akr61Xw3P0PCO0pS4AtZjkZ6SPrP4WQAw==
X-Received: by 2002:a17:90b:2f48:b0:39e:4c7e:bc4 with SMTP id 98e67ed59e1d1-3a07e4d8773mr89611a91.18.1790097649947;
        Tue, 22 Sep 2026 10:20:49 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:49 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 11/11] selftests/bpf: Test dynptr slice invalidation on skb clobber
Date: Tue, 22 Sep 2026 17:20:28 +0000
Message-ID: <20260922172028.6269-12-emil@etsalapatis.com>
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

Add tests that ensure that dynptr slices backed by skb memory
are invalidated on any operation that potentially moves/frees
the backing skb memory. Also test that only skb-backed dynptrs
may invalidate pointers into skbs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cd61d72c..0f030f397 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -13,6 +13,9 @@
 
 char _license[] SEC("license") = "GPL";
 
+extern int bpf_dynptr_memset(const struct bpf_dynptr *p, __u64 offset, __u64 size,
+			     __u8 val) __ksym __weak;
+
 struct test_info {
 	int x;
 	struct bpf_dynptr ptr;
@@ -1274,6 +1277,186 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/*
+ * A kfunc that may clobber packet pointers must invalidate skb data slices.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_data_slice_after_dynptr_memset(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+	char buffer[sizeof(*hdr)] = {};
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice_rdwr(&ptr, 0, buffer, sizeof(buffer));
+	if (!hdr)
+		return SK_DROP;
+
+	bpf_dynptr_memset(&ptr, 0, 0, 0);
+
+	/* this should fail */
+	val = hdr->h_proto;
+
+	return SK_PASS;
+}
+
+/*
+ * A dynptr kfunc that may clobber packet pointers must not invalidate packet
+ * pointers when called with a non-skb dynptr.
+ */
+SEC("?tc")
+__success
+int pkt_ptr_valid_after_dynptr_memset_on_mem(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	if (bpf_dynptr_from_mem(&val, sizeof(val), 0, &ptr))
+		return SK_DROP;
+
+	bpf_dynptr_memset(&ptr, 0, 0, 0);
+
+	return *p ? SK_PASS : SK_DROP;
+}
+
+__noinline
+int skb_dynptr_memset(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return 0;
+
+	return bpf_dynptr_memset(&ptr, 0, 0, 0);
+}
+
+/*
+ * A global subprog that may clobber packet pointers must invalidate packet
+ * pointers held by its caller.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_pkt_ptr_after_dynptr_memset_global(struct __sk_buff *skb)
+{
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	skb_dynptr_memset(skb);
+
+	/* this should fail */
+	val = *p;
+
+	return SK_PASS;
+}
+
+__noinline
+int skb_dynptr_memset_global_arg(struct __sk_buff *skb,
+				 struct bpf_dynptr *ptr)
+{
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	bpf_dynptr_memset(ptr, 0, sizeof(*p), 0);
+
+	/* this should fail */
+	val = *p;
+
+	return SK_PASS;
+}
+
+/*
+ * A global subprog must conservatively treat a dynptr argument as possibly
+ * skb-backed when checking whether a kfunc invalidates packet pointers.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_pkt_ptr_after_dynptr_memset_global_arg(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return SK_DROP;
+
+	return skb_dynptr_memset_global_arg(skb, &ptr);
+}
+
+__noinline
+int skb_dynptr_write_global_arg(struct bpf_dynptr *ptr)
+{
+	int write_data = 0;
+
+	return bpf_dynptr_write(ptr, 0, &write_data, sizeof(write_data), 0);
+}
+
+/*
+ * A global subprog that calls bpf_dynptr_write() on a dynptr argument must
+ * invalidate packet pointers held by its caller.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_pkt_ptr_after_dynptr_write_global_arg(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return SK_DROP;
+
+	skb_dynptr_write_global_arg(&ptr);
+
+	/* this should fail */
+	val = *p;
+
+	return SK_PASS;
+}
+
+__noinline
+int skb_dynptr_write_global_arg_with_pkt_ptr(struct __sk_buff *skb,
+					    struct bpf_dynptr *ptr)
+{
+	int write_data = 0;
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	bpf_dynptr_write(ptr, 0, &write_data, sizeof(write_data), 0);
+
+	/* this should fail */
+	val = *p;
+
+	return SK_PASS;
+}
+
+/*
+ * A global subprog must conservatively treat a dynptr argument as possibly
+ * skb-backed when checking whether bpf_dynptr_write() invalidates packet
+ * pointers in the callee.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_pkt_ptr_after_dynptr_write_global_arg_in_subprog(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return SK_DROP;
+
+	return skb_dynptr_write_global_arg_with_pkt_ptr(skb, &ptr);
+}
+
 /* Read-only skb data slice is invalidated on write to skb metadata */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
-- 
2.54.0

