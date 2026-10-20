Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491924;
	b=peb7iUReO+BOhrIE+tcm+moXLxSkb3e6SrYzVT1viszz3RrEkbJ+/ni+3k1FuDnsVd64
	 726yPhub/8k0NwMs4WnEqBqun3L6NPvlTLABL2uXJns5N3gXKYITsquPTX79dqr92BroF
	 ngyWrvkhpSFPJQlU9yoi63ej7u1fgiwN/xCtnvDz51JXOcLN9KjZSetPpVwGloHKXyEIa
	 Oqj74d/N1RAKZGX+YYAwUY5/cti/gyTIgyD+UnRjiNYd2qRbn2AmI2xrwcroLaMKPrJea
	 6xvQP+PwZRaQfKnHhd+xmqtyZhiOajyp2GJIXD8i/Ry4M1IbB9hsta6qEvy3bQI66vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TM2nirS6qLCdfkEXwJGzTZRWTT5VvtzmWaq8aIlT8Es=;
	b=43mTqzkCKwJ7y/98pmsV1tEZpEn+mGlfigiUxkjSsVpatPrbGuvJ/Lefi530MY1JRhQ/
	 q9/Xo4R/joT3H+W0oxyYzUQdncbs9vwrJMhyGIGkm4q5adXQdc6TemF4W13K6b+K5WM0z
	 23+IyFn8GhL1qmRwpL5xxn6XjEL+AtVNGpfzMV2G/ysSmOEhf6n8gO+eL1mDoujDS2Mrk
	 P+LYSWgPJlANA1u7dY7nWtoZ8JRy9IM7wNoit9gD+4CiFAPTDoXTn3KDA4WEF8MwpvW99
	 AKLR/zM2S9sXsMcB/9GZTNaVeQy3qBMpZstWO0Qt2Ay0VnXodkpoQ9lVpsrpC8xPRig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rN+ZIgn5;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240F606A32D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8240F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rN+ZIgn5
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso14871615e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491923; x=1793096723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TM2nirS6qLCdfkEXwJGzTZRWTT5VvtzmWaq8aIlT8Es=;
        b=rN+ZIgn5UDsDN7iYJJOAzOWGo+ZnZO6ByKmA+QRfdhWJfLlAoTB1Pi3HTkXvmNziCv
         Y9CRa7/HjbBvVGW3eMSQZHfdejFDKvLBH+xRMeHqu9e0KNgblNBfkrEPfpUeIUPmL6nO
         4naGbzrVV/c5hvWSBpiawmbKBBYYbRUdldYkPEqxcg+VgcopB4dx1x8kCTvLcIScPMjW
         Wpx3uY5XsAR0oXYO0UGidtjSIjQ0NKLUGmoyVpqBHPP27xJUATGs6yfGMd2kLApfHdw+
         OYIQ2JdoWP00tPo0w8DNTWHP2+xMQAvrMrK99/w+39XcRuOYJMxou1TZFfV4gVILlkJR
         CMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491923; x=1793096723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TM2nirS6qLCdfkEXwJGzTZRWTT5VvtzmWaq8aIlT8Es=;
        b=lfYTNdWi8f51m5cxVmu0/4KF1RFYs6n3CHlD69FaazYjcDhJnlDQ6RHjJcZwNv9xo5
         p0GGudIMjszQTAYYXSXrFA0TCqK3E+S29Oyzjm/i0LSz8grtzK/QMlxylk/gXqrjV/Yw
         fpoyxPblcApb50uKgwW7QLc4dkp43mNoJMoCWNAt981RmodPYN/gA39uxT8mUNsiqdKv
         WoZdgX9DVB4ke7Inm1cXqiAwqPzuY7aFaKdJTaAit1wheLsNBefNRbfQeBwWFyv15h5f
         AgvX6Pgfr30mnGY74Tp+bN9/rncELlUkrSfdq+etA4TMIT5dHL74ptb0fAf8AXkMm+p2
         ovhg==
X-Forwarded-Encrypted: i=1; AKwUvBylzvvHS05TO379vDi/Ekl33J9YXaG4KciFHiKbroGrlKt4ki5v2bo7a7KMm2vh7VnREeeR4ko=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKd4ajtV1OMo4yPSXv1VyeVBGNfM79bK2SCt0/ZTk3DxINxE9T
	A73x7JvSEGZv6cwAOYxslNfbr0uNIeLOd19GXW2N/4gXQbnB/31lAXRp
X-Gm-Gg: AYBFou1OM4vzVzpaQtl8Fa5V920afdwBZ5gaZQaM3iTv1cZRl5C1cc5vTOYR/IBs+o6
	UxHXGHtd63PM0jLeFCn+ptkY7Unat+rykE8/sVjIrrDyQLeOksAg6d/ENbfvAqhuW8dwCxyO2u5
	THZT+aCJb5Mtkjdh90OskE/LJn239FoKdfaurdG1vsEc0wyxZII07VyyqrSpDpL1yiwIHd9TNKL
	0Olz6BEdd0AchpdK1Gckl7nfcsZo4oUN7eawzHgBLdHlIFTre8JxTPAkIi2ezbMofTtfdNgalx0
	salxt9GG0tQaysPmW9PtjakZOVCvCO+cm8iiIk03ccliQ0I0CZ4s9zUZtSLjxq9/RicCKUUQpQN
	ZT0eoXAog7bqCyJ0LfEQlA2zRLs9Zxx5s9c1NUSYOpZKfdG3cxK6VuyaOnFEVbh2weSdVQmrjbM
	xRpOCbAedTuuxnbdBNylrMaClMTv8RbhpeI6Pn7jgFGHm+ckjxGJ+RVaiDEE0R/byRWsms929Iu
	nepONKu4PiJq6UMVgb4x9e1YvzabBmemQB0Vtm5MEhYAw==
X-Received: by 2002:a05:600c:a10c:b0:4a0:1a7f:2abb with SMTP id 5b1f17b1804b1-4a1d75fe221mr175698025e9.11.1792491922422;
        Tue, 20 Oct 2026 03:25:22 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:21 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/8] bpf: improve ksock_kfunc_set LSM recursion filter
Date: Tue, 20 Oct 2026 10:25:05 +0000
Message-ID: <20261020102512.518479-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020102512.518479-1-mahe.tardy@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
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

Improves '7ae4eb14c5f9 ("bpf: Add ksock kfuncs")' verifier filter to
avoid recursion from calling bpf_ksock_send() from the
security_socket_sendmsg() LSM hooks. The filter was unnecessarily
restrictive, this makes sure only bpf_ksock_send() is forbidden and not
the bpf_ksock_acquire() and bpf_ksock_release() kfuncs that are part of
the same set but are safe to be called in that context.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 48a2e2327ace..6c508c7a0adc 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -264,6 +264,7 @@ BTF_ID(func, bpf_lsm_socket_sendmsg)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID_LIST_SINGLE(bpf_ksock_send_id, func, bpf_ksock_send)
 #endif

 static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
@@ -275,9 +276,13 @@ static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 		return 0;

 #ifdef CONFIG_BPF_LSM
-	if (prog->type == BPF_PROG_TYPE_LSM &&
-	    prog->aux->attach_btf_id != bpf_lsm_socket_sendmsg_id[0])
+	if (prog->type == BPF_PROG_TYPE_LSM) {
+		if (prog->aux->attach_btf_id == bpf_lsm_socket_sendmsg_id[0] &&
+		    kfunc_id == bpf_ksock_send_id[0])
+			return -EACCES;
+
 		return 0;
+	}
 #endif

 	return -EACCES;
--
2.43.0

