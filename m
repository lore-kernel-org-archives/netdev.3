Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4C35CBD7
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302291; cv=none; b=O2ivt9c4H/7KSEKgN9KrarbruQqYTPJc6LD3TjkN4HDrJZkccfZyF1dMlFmjz/+U+vF+GJ8unXngQvlBKHr6yVsHQVCYumbuEQIz4dxwM7cuO6Ol1DlUCw9e0xHchpXnXKvE2EfM1SbpjLWXprjxN5ZKqF7zOzCvAO/k7tXGb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302291; c=relaxed/simple;
	bh=fSDgN2HDR2odiw01b50KzrxrsWNrFw7Mh03Cl3YKyzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWSl14PX0xrFyn2p9LkBlWP+CrqmblpepNlEkaNx3XgSmPjvPWJEL5MOOCsw4VsrGiXBWpiWP8+dN5hkKjcoY9E75QwrB/GnjqnLvKfskPiPvL/YvnGEh4g5X0w7rcRadxGpxPbnAAhd9mUfa0ybFSRiK0YhEH8G6tOZeRJRn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=LNmlk/1G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="LNmlk/1G"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9e53d011eso115055ad.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792302290; x=1792907090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7h2A8700zumE01FJsT9uGCOexbDUangf8yjuLR7Nhbc=;
        b=LNmlk/1GPXnLf8KQTvJsDLkTnTkOp3YynOa+06uPLibP/9rgx7iVz1O3eIEVtn5ZjZ
         bRq1oETTOLGjNe1qGk/5//HGJ4ndgMU3RbCPj9s/IiH3FCm9R2TEYNhsEqHcRdr9RTsH
         8IqpTOIwuaQngzUHQm2zKPHo3GstfpGlwQa7M4jJ+9J81dNGo8dZCa0CxKZZNbtsZlUi
         7GLG9ziAbWe/QCnlQtaMvmxlhIwgYN5So+5kAgs34GK8M7AgH9RVFcvpI0Q3U9ixpKFO
         xYp9Awbw9tW5d4rKsOleQVePa+k+CE1GTHmWk5OR/eaMFY5qi8HKbhsfSTeMOl7UpPxo
         h0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792302290; x=1792907090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7h2A8700zumE01FJsT9uGCOexbDUangf8yjuLR7Nhbc=;
        b=royCfBI+BGIjGjytaxNcp/ZfLhoGoWcsPHFMwGv/pjJcrAIZADf1khZNO+n9V+n8Lr
         W5caM6N33Pl0LaeE3LeY/w7z/aaeHI/EWFffM0Kokif6STnhtzbIUv58ZV+CyiN8UM66
         99ljO77MgRYq3RTjoIqUDWx5gtOOr+VJT5c7Fo0jjASaeIMljHLheAApkXicTA3+AXSX
         nNhprvFQq6ygYMvAeRbkj/ecApOftFK3IAmgCHYsYZjf5MdrI0mrAX8jIPiT21HgMGRe
         06Ow9qK5ONuq7dSNwPAOBzH1jk36fd++j7ZEN2EV187chDozk2EyHGNGD6pk9OsX2t/z
         TNtQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlyl8YV9t5W7eDERB8BdgzeuJUXHypvr9wYsGIqNwZoEezWgkiI1miWZkUrKuZN/8QtP9Ne/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7rCnQ7rnM2/fbt17lPfsx7p7wX6UMmBVNi43Zlea5Bv3XZom1
	ezRdWDA+tsaF0VzY9EmW01w4iDsGjUp3fJhVZQPgw5YirfBEBMiQ2vhz0OqY2Vylg3j3
X-Gm-Gg: AYBFou1+G/QrAWKWIrwHlgMY+wm6TEkj/DCzg9ToQm3V4htwMMNYnrYkHrgY3suzNfE
	8EM8CCZsex2xjCeY7GNHODwVfblXsvErqtUkbd0Y4v7r7eZio2rg0cMJ7U39LeqbTOOcLw5O91C
	WWKJP0z+Nu3FEGHMVA4erN9WNlNMG/oKIWtR24/K1IimeHM+QSMvhfYJAfX4qQu0PODuYu9bY6M
	3aZiSh6LGvalYBjLc4ucuEx/eynrZamAdCiCj6W3AHdZbQ8UCPgjYYW50C6kFgKwM2cHVN32aej
	WO0LD/+JfOPHNF+OizPGjYiI5G9RWpEHDmoAH0sdoMl8AiLwQehOC7jVgBgxUJwXO1eez0CU0Q2
	jKJdz5iZNKUQzrENnGnpYmR13BtIk+1Gamu+ncFJDxnrz0gu8TB5f1KcQ61gIxfpOyes7/6a6by
	H4pg585SnaFmh9q6WEUK1P+3ZGtP+eByU9siYX66CiHr3DPk5RNP47KyCW3IWmG2Fq+n8MJBsUQ
	CiyOK54Kgw=
X-Received: by 2002:a17:903:2284:b0:2dd:c100:943e with SMTP id d9443c01a7336-2e9a6d36770mr40348685ad.60.1792302289702;
        Sat, 17 Oct 2026 22:44:49 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804e80sm27011525ad.23.2026.10.17.22.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 22:44:49 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	sdf@fomichev.me,
	drosen@google.com,
	ameryhung@gmail.com,
	xyx2021@mail.ustc.edu.cn,
	chenyy23@mails.tsinghua.edu.cn,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test rejection of packet dynptr slices in mutating helpers
Date: Sun, 18 Oct 2026 13:44:22 +0800
Message-ID: <b5207ca47760c74788f0da5643494f8594bdfce7.1792222148.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792222148.git.rakukuip@gmail.com>
References: <cover.1792222148.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Add negative verifier tests in dynptr_fail.c to verify that:
- Passing an skb-backed dynptr slice to bpf_lwt_push_encap() is rejected.
- Passing an skb-backed dynptr slice to bpf_skb_store_bytes() (with
  constant and variable length) is rejected.
- Passing an skb-backed dynptr slice to bpf_dynptr_write() is rejected.
- Passing a packet-backed dynptr to a mutating global subprogram is
  rejected.

Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
v1 -> v2:
- v1 Link: https://lore.kernel.org/all/cover.1791433504.git.rakukuip@gmail.com/
- New patch in v2 series adding negative verifier tests in dynptr_fail.c
  (Alexei Starovoitov).
 .../testing/selftests/bpf/progs/dynptr_fail.c | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index c2247b38c849..11699d87ad2b 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -2279,3 +2279,93 @@ int dynptr_overwrite_ref_clone_slice_valid(void *ctx)
 
 	return 0;
 }
+
+/* Passing a packet dynptr slice to helper changing packet data should fail */
+SEC("?lwt_out")
+__failure __msg("cannot pass packet pointer")
+int slice_pkt_to_lwt_push_encap(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	void *hdr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, 20);
+	if (!hdr)
+		return 1;
+
+	bpf_lwt_push_encap(skb, 0, hdr, 20);
+	return 0;
+}
+
+/* Passing a packet dynptr slice to bpf_skb_store_bytes should fail */
+SEC("?tc")
+__failure __msg("cannot pass packet pointer")
+int slice_pkt_to_skb_store_bytes(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	void *from;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	from = bpf_dynptr_slice(&ptr, 0, NULL, 10);
+	if (!from)
+		return 1;
+
+	bpf_skb_store_bytes(skb, 0, from, 10, 0);
+	return 0;
+}
+
+/* Passing a packet dynptr slice to bpf_dynptr_write should fail */
+SEC("?tc")
+__failure __msg("cannot pass packet pointer")
+int slice_pkt_to_dynptr_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	void *from;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	from = bpf_dynptr_slice(&ptr, 0, NULL, 10);
+	if (!from)
+		return 1;
+
+	bpf_dynptr_write(&ptr, 0, from, 10, 0);
+	return 0;
+}
+
+__noinline int mutating_global_subprog(struct bpf_dynptr *ptr)
+{
+	char buf[4] = {0};
+
+	return bpf_dynptr_write(ptr, 0, buf, sizeof(buf), 0);
+}
+
+/* Passing a packet dynptr to a mutating global subprog should fail */
+SEC("?tc")
+__failure __msg("cannot pass packet dynptr")
+int packet_dynptr_to_mutating_subprog(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	return mutating_global_subprog(&ptr);
+}
+
+/* Passing a packet dynptr slice with variable length to bpf_skb_store_bytes should fail */
+SEC("?tc")
+__failure __msg("cannot pass packet pointer")
+int slice_pkt_to_skb_store_bytes_var_len(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	__u32 len = skb->len;
+	void *from;
+
+	if (len > 10)
+		len = 10;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	from = bpf_dynptr_slice(&ptr, 0, NULL, 10);
+	if (!from)
+		return 1;
+
+	bpf_skb_store_bytes(skb, 0, from, len, 0);
+	return 0;
+}
-- 
2.43.0

