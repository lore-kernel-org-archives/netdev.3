Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73F364EB0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019404; cv=none; b=Lc8cZmb5HApYDiwmLui9QSx2QRuHdd998xzQq7a+Rrm8cWbURrK/T9WC+YdQJRueZyLk40V8xYFy/q6QJkpFvsKvmGPPBzpVEalvw0G1BfZI1RSVStIwHXZFtNHuHbBL44f0M35bussc4ca8dAQh2aq5TLeZrdrb1kfRn3UgKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019404; c=relaxed/simple;
	bh=Yy9nxMqDxlsi2eFEMJmHQMFtl2AvZuZ2+2rqjXag50s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fe8Rs6uRIwgJx/zvtjR79agDOCDCvR3mvIqHvtpb3UOu6YHR/MFl+qfzYKFNIS9MV4ZatTf7z95wgDEhGY8h+qNonmSjL9NZ2vsQ/O0bgBc2rMSVrGQk2p1RWXcHBZ7Pyf2W5f/yu36nwzA1NL+tRRnCv+dJMNgubG7SJqbqLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gbe5vBZv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gbe5vBZv"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf02708e8fso10110715ad.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019390; x=1780624190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QecDNGP+w/3sDQd+DHV0ny1tRHbDSeV8L549ZYAjJFY=;
        b=Gbe5vBZvSUI9HPG3SwbeWZWp7oy00US3QkgGtoDaet9DSE5PujHg5HTsnAvhAqYfyE
         hf8t2uCVzOyUVVpM7fvzjMjmjx5b8IC6Xg8kEC3Ble+iJ+HPT9h0RkFOagqkVQXFU7JF
         SwVFE4gwNtrSo6dkA0M17gy1yGfX6GteA+3XYWYeAKXHJG12/avVAPxD/pKahCuBM1wb
         G1sj5gmYY4zNQIuF99VglQiyfQ4jewOInZ1Vuq84RxUFl8MUNdLYuSt5II88sco4GLEE
         5us6+Q4KrSN5uDddVL1Ic2WDCnSlYJwIkxxtPpGGyAcqZLbIqlpOtl4Mez8dhtzDmIwz
         U7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019390; x=1780624190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QecDNGP+w/3sDQd+DHV0ny1tRHbDSeV8L549ZYAjJFY=;
        b=o5crb+L1ti961JuJCCinAHOhtJIXNaGfxJZN5XSbC96KTAmzHZevUwFrdAdAT69PQS
         UoDwCuwwmbZ/uwlqK8WJ1t/cgi/06YUeF+ysEawB+RH4qJkpBmpPqYiEwXIXhXXi/PxT
         tKIN9qc0DGwtrE1YzLCBFZCGJDaljj+53OhMoxLg4XjT/2V/dnU373WwsbPff3Pu7DhZ
         FguWW4sb+ZSBEH0+2Be7JjqFzJFA7ySv2xjRm619BE1VBKtYc8VOJR6m73ozdGXZUS57
         e4av89oo6s5BJbQGw9YUhxRZbeOGH5HW8wWXifICKNZx68T+zpX54QWddombyPaQe0+w
         2/Aw==
X-Gm-Message-State: AOJu0Yx55667y9MA9thr3JEUOio+26F+882LFbC6VJxe67VgX4ydVoTN
	+2Fvfc4PHNCZb3mqmxvoe9rxn7SH5K27N8t0fDAm6g+47fHKY1CFAF3h
X-Gm-Gg: Acq92OG2ut0c1IR34VvW7bewAVFwRE6EGmVHOVPkjsjEjUjXPvhXnUSyNrCe4d/dmlk
	FLY92EVtqGU6sDvVTJDjdVr9HFSk9raQynih0KMYJGMBumJbMa9IBXk/Q1x2qxlDmcfOcP88GCC
	/xdFS1FUXv06Xik9RWNv92D40wsq4hjD78zDh711JS5gY/R2mZjeBNY6wXYQlS7yGfJj3IlnjDK
	hQGQkzlWl4XQcWFFTRb9yo+MQLm4fUG9PTTBAXFonBf9n/H1I7Gntq7p4lD08ol49omqNxGysdv
	LYBPmLuKbTUQbrIBa6PCVR28vvYQ1kMCDcBdFaMJxhzIWjfuilvdjIp7Rj8uAqlxvUNNA/caUwE
	Ljqh1ocUAzosKsXqZkNOUk0T61tQwVnvAHrteFzUOKFBAfoICWRg3eDPMmDKNIcb8wqCdeg7DOX
	ALmE0mnQN/YDqFMkc3VTD/JKnn
X-Received: by 2002:a17:902:e5cb:b0:2bd:7684:34b0 with SMTP id d9443c01a7336-2bf2062d5b9mr11330165ad.15.1780019390284;
        Thu, 28 May 2026 18:49:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c3eb31sm559805ad.75.2026.05.28.18.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:49 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 10/13] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Thu, 28 May 2026 18:49:33 -0700
Message-ID: <20260529014936.2811085-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier currently does not allow creating dynptr from dynptr data
or slice. Add a selftest to test this explicitly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 40a14a5174a5..344fb2aa0813 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -705,6 +705,48 @@ int dynptr_from_mem_invalid_api(void *ctx)
 	return 0;
 }
 
+/* Cannot create dynptr from dynptr data */
+SEC("?raw_tp")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_data(void *ctx)
+{
+	struct bpf_dynptr ptr, ptr2;
+	__u8 *data;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	data = bpf_dynptr_data(&ptr, 0, sizeof(__u32));
+	if (!data)
+		return 0;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(data, sizeof(__u32), 0, &ptr2);
+
+	return 0;
+}
+
+/* Cannot create dynptr from dynptr slice */
+SEC("?tc")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_slice(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr, ptr2;
+	struct ethhdr *hdr;
+	char buffer[sizeof(*hdr)] = {};
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice_rdwr(&ptr, 0, buffer, sizeof(buffer));
+	if (!hdr)
+		return SK_DROP;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(hdr, sizeof(*hdr), 0, &ptr2);
+
+	return SK_PASS;
+}
+
 SEC("?tc")
 __failure __msg("cannot overwrite referenced dynptr") __log_level(2)
 int dynptr_pruning_overwrite(struct __sk_buff *ctx)
-- 
2.53.0-Meta

