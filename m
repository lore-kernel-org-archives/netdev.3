Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491925;
	b=ks8OTQcM4daiyWFznWVIdAaaECYXacaa6AiGv1GbTAQh0vRIdHnxkkWVfThO07lKppEP
	 9C7ahLm+hA69EsGmE7gcYKq+1u43h2htHueuGFWVXxu5Iys2Mzfxa8bYG/ZfBGUI7k12M
	 aC4HeMO+z0qum6Euk9/wpQmEPpYEEiZMvzp0aTuFF0Jw4xnHfhFSTHgy6TDBdBIvYLZDk
	 GxW7/tjVQJQTCTBgOdhowa2waWROjfDHKhiYIw0GS3ZyMhdxhEYBzuvnC8c28z1l1eXNg
	 BSnL20CR7loK+JPcz35m0Y3ooqv5lFifvAkTQKM/cne+MUd86v9gTEiwpZ5bASxZ9xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z5XGNpGXK3qSx+5JfcbKid0ZtLDq9NM4nm/EIul2pTc=;
	b=MP0sDADvqLAKcrHUoRxMpbfUbcArLcmhEb3MGVpWM7PX4g5KOdErOFXLWMsjcwyMFoYg
	 9Y5nuv/D2nmUEBoT/oC99H+US655oV2W+gG0ttjCiHAIatBqlRiItrLk3/GAUwD2hCxEt
	 r3FK0vA7H5gWWR2ze0QBbI9Cx1zai5ZXgtAJUR9x7fcmezu1iw6HLPnM2FgA3L57B1l8O
	 GmeNHG5wsCqxUVvDk0K1Kb6ruDa5Ib6YRGW35Lj7ii8N9QZGtP0eArf5giGk0/63IPpqi
	 1SiozTy7gn70DbA8rKqPLoOQWSTyCMqUivhRCvn1i7Fp+uFvBvAHmzX75O1wO0o27Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JlmqurnS;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110D606A334
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2110D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JlmqurnS
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c5358fc28so2616324f8f.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491923; x=1793096723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z5XGNpGXK3qSx+5JfcbKid0ZtLDq9NM4nm/EIul2pTc=;
        b=JlmqurnSfs9uNHxOetvntBvp9V1dThkS/Kric/sKhgYqj/a16I+EmevTE1wjd+IH62
         CRxqRGICq0AktlX5sURhJxNzwhyER3TB6ecKcyKLZ9lNO00iQHRT4f83CDUijLx0fmcF
         1ylzJu9PCKX4pFYIJzY4CW3lPgSVyYS/KrgWzLCz5LdDDxbVJB/y9M74yPjDQlWlKY3c
         wQGsYwzlSMEBaHdtwtqrFJojIKzdXOVeT5AuBt2Y1M3Gsyshc6MS6emtcs5+seEhsau+
         KmsY8f+eT7K+A+a7DRE7GUOpz5ZIcrIz4rPhzRf86+5xGoFrgFKd6pikOYJHmut/RDZk
         Zg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491923; x=1793096723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z5XGNpGXK3qSx+5JfcbKid0ZtLDq9NM4nm/EIul2pTc=;
        b=U1po+HvzYS9oiEU+Cx5j0Ik4g5z02TYiiupQZDiELUlltohPfz0vyDDCeS3g800tAb
         MDhMipbrWfYMGjYKj2WjlUcoIZ+s/slO+ACixvE0Z46diNJCs9Ou5Dsd5Wmr2Lg6c7gV
         jXvq5d2Z+cj9nqwTHW/2P/Q5QsXolntz0KwqYfCGLS0teroTVComB2sgK/9XS3QhsisB
         VU+i2hGobinVvSUrPjLzrjbjy4jmxHCdKiZ60MRjl2TTNz0mZO/1PAWunBfoYQnXnRoC
         JlEpxqLPbFJIo7ezT9FE5Sk9mNlIvTudr/0M4IzvH6ZQcoM7MMs9vrBopzzGGV4/5NLK
         GTMA==
X-Forwarded-Encrypted: i=1; AKwUvBz9RJjeMtpF/2N22sXIax5oXe58J/5KySTrLp4pPTHY5HuAo6O6JtNZanWA9wB6rLlLkanZoq8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfHuqcbnJ87J1lWZ05saWAsDcmbL4hbrPvB02nYlKbBviUmUqN
	zJCK+ERbM+zXFfkqncNL6saSoRHGyBAqEZva4c99juAP4IABiINAwfvS
X-Gm-Gg: AYBFou359g2Yi6UDweLYeM3/coc6zkLF7cb4X5NuMimxU0usKXHGtd6v3BZcNXzax2x
	aWqGeFt0Rt6GKJZ9pMJD5WSgfXTxGiWtVgrrg5zalbe/rLo2mELNLszE8vOnn+J5iRv6b6uu5j2
	YU+MuOPXkQmAOC1CYzQER5xHmUVn1OxJlTuJjFRDXCkCAkvcrrXX0OhwQEpWXkQKu48zBaZgVHC
	12CkhgVv3NboAjIv2+I2hlGHjR/50nxVIPeKFcSkdVI7Du4id0FkmOwaVdRDedAyoTIk8Kiim+d
	19rnZVciJh8fZeZ+4KyXAFBx96t+9oKRuEACK49ouWuVZrwMZKMcEJ9xe43vDZLybeQuPUYncTN
	XZcZQEgm2BDYBw0lgI6ngp+VYPgsz+MnqCs0ppwl5nlIvsPyUnqEntDxN/hO6OUQS5Lk9MrNwDn
	e79AykizhKi6WxfpWJL2j73QuAReKhKiSfzYurdLQgSYRDU10yamXaaiDMx8mnzHxlpRl7PcXFN
	LdPK+jiGLZes5A7NeZogElZ6fO0eiyB6eI3O3Pb9h8rfzbdUubmXnvO
X-Received: by 2002:a05:600c:1da1:b0:4a1:6425:be69 with SMTP id 5b1f17b1804b1-4a1d7614e61mr231916665e9.17.1792491923358;
        Tue, 20 Oct 2026 03:25:23 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:22 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/8] selftests/bpf: Test allowed bpf_ksock operations at send LSM attach
Date: Tue, 20 Oct 2026 10:25:06 +0000
Message-ID: <20261020102512.518479-3-mahe.tardy@gmail.com>
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

This test makes sure that bpf_ksock_acquire() and bpf_ksock_release()
can be called from programs attached to ksock_socket_sendmsg().

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
index fd2ccfdb5802..740ed370d28f 100644
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
@@ -32,4 +32,21 @@ int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
 	return ret;
 }

+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock operations other than send are allowed from socket_sendmsg LSM hook")
+__success
+int BPF_PROG(socket_sendmsg_ksock_allowed, struct socket *sock,
+	     struct msghdr *msg, int size, int ret)
+{
+	struct bpf_ksock *ks;
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		return ret;
+
+	bpf_ksock_release(ks);
+	return ret;
+}
+
+
 char __license[] SEC("license") = "GPL";
--
2.43.0

