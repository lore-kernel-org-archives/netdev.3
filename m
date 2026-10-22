Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692995;
	b=yMctdwTl/fCNxnwyi61bNlWvaxFZHwTAj/FN8HcKjNWfLYm7Q76o2ku3J1CP9Z362v7a
	 XSlodKryaHVK8L60gxDWuiJW3O4VC0TfhOWrkOKFjk0+Sutg/DHR2YkWvxW4TPu/zfjqv
	 u4St36eZWa/YPsBlxec1yAhOxkgSZwrn82ZXV/qvu3gUQCnvL06LYug/BkXAeBB+bAE7w
	 V7mVhnEfalnolesVO3ZjZLeNIItxnn43WhbuUeNLseoK3jx6rGPmJP6FzzrS+9E329qOb
	 t/yZawKo+p3KMMKDjWqwxkI2oWdhERAChHl75s2+kS6fuqzayMMHnKFeigssHBXN8gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QeAE/97LSA+alBszF2d/9US4us/V4a2d1RN7juhfoM8=;
	b=cbLq0dIVpmc+zWy3Etf+TH3S3WX0TwaIbicqm8B7m/EJ5PN1j8wYhfXGoQAxxX7aeEgn
	 7RMlTi8v9//1x4ZPVlVdJC+IqlJsWtSEOYVr06PGx/a5ut6x1kvqGJqbAhu8tr66NCC43
	 42rYysuKsKqUZvmq5g82v42vIZQu2wiCOnKoouew2PIHbkDB+KwVHQT+qGcXB+iZbkhxk
	 mYCl1Ve0mQGblxT6jwfht5VrzBX9VaUubhF9j7k93cHJyoUHfHAfOlVd7xgkllqJ3tFhW
	 YCDFlfUC5tCT8hlh8m1RuzaKfgr83j8GgntKBrJLhk2eZozrNUNRprc1hTT/ErGs/XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="YKhRC3q/";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65CD606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D65CD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YKhRC3q/
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e011d370dso85082f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792692993; x=1793297793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QeAE/97LSA+alBszF2d/9US4us/V4a2d1RN7juhfoM8=;
        b=YKhRC3q/p2rLW80Q2JhcknkVIWplOdKZw10QYqUbrLJ//XuZVCmBH4rm6MChmHL+Ju
         X8jWc+nftxbKSDqEUP4esKdNDIF18cTPUCkTqv9S1agUql2ky1HVZ4bQSqr+lfMRz4F1
         nh5YIE9aQ6hAw+yC23fOq70aHFhGCfWR8wYenT2iZ5w0H7iicikHpCqgo8ivOIvROOwE
         sE4OZ0D7D/5YhqYaJs0jeVjZQH0eGY9Ay5a+RDrnWGtmL/NkI6bhYgL8WFYyr/7JkWr1
         o1zMi7DrDje01CXwjtLLZqDlwHzuLLbOZwOqx79fByblZs5+rDxr6IwUsg9vTFsNuZX2
         Incw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792692993; x=1793297793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QeAE/97LSA+alBszF2d/9US4us/V4a2d1RN7juhfoM8=;
        b=USyeTGXzYqF+nGT/2GTEvSTZxjrCztd3RLscKtNjrCnqcQ4zlstKTOMkkNqNzTwJCW
         5FjDmp/YGjZ5RLtsL5P6FEhPoa5td8s8BoPXZeiF9jdFhR9hlJOJWtwzt3wYIpN1ARnT
         CTH+GvrY3VgB/rP61kv89ciMK8eQdxqRAmoeHoTRDGKA+0bjz6IA8d7rsG+EgmYyPjTL
         bOht1CoOYJRiqVR6eNuDrOP97KZypW6n4dMuYj3YdOaHOh8eKBWwM209aNdOg9AtELhv
         lZdji9Dn2kreLWyx+MqPiSTXgNGkEJyd30m32FMajyH8ScA7aYAaE//COakofb/+wFjf
         Q/rw==
X-Forwarded-Encrypted: i=1; AKwUvByUtYgHzcjvX9JwElH7PJOPjgbHItbTNi8qPYsqYXAPakFfinOzWx30AY3aRgipSpkKDZfMBI0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpAe8LQfvb0wnXRMKczUx0c/eCqRkHSpYVGfEC5vA2gMVHf+Ck
	T9t5XcuqtCPPMKJnwOJ8H9aHaV9pdGvCW/tLdyI2x0S3Hsxx8ArkpD5A
X-Gm-Gg: AYBFou1k8wzxkzGq5u+gh542tB6EhYVCE2jmU8kTzP+UG9k1qPRNo7BtTQwmx81h7aR
	SnB31IKKt+S0RYhF7vjjNeOwinsCKs3sKGyR1pWGcQZi5aWHvYGCcNWOzTYwsgd4iwA0ypdD9qb
	0USY2B0VeHyCMZE97TSRNAd8eZrTWNww0ab5X61pK/UOi0P6MI3+9fQkBc70VEJz2P7muBOhGVe
	3w39V2iumDhB1csb/araFY8xOJvZWVDDb1NRxrRKiDobJJDYvHYhbqoJJCYkN5bdk8N9RYQuuCm
	POIsByaPow+MHleAUKaYRwI/LWWSpZEQ6cejk4eSXk4saLqu6aaAHcdjDGBvxRSu9FBK8FoQqKt
	1Bo3bC1DJm8iX7G1kF68iWpyi6QNELr7azMcCIGGDI1cTczFSlHqvMECvPpr31xqWjaAkqmv+R8
	qr195mUffUuN46A21H0bwj64xI2iihx3/opJpgi9LTCo/qOQ2BzxdHra8RjRdFC/JxmuVxzcXD0
	r6RUe+9sEJamOAzKHaIxY3NXXTXeCb1bVC4v4iz8iS0GX9sgkdaXkoTzZo1herI0CurEe9HWqd/
	cc8pO4V8yHWkTpiA4A4rPjf6Nqg2aD8ablg0QIXhCKoAItk/
X-Received: by 2002:a05:6000:240c:b0:48b:f92:1f67 with SMTP id ffacd0b85a97d-48e264898b6mr12509309f8f.21.1792692992923;
        Thu, 22 Oct 2026 11:16:32 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3796b2b4sm18451f8f.7.2026.10.22.11.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:16:32 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_ksock_bind() kfunc
Date: Thu, 22 Oct 2026 18:16:19 +0000
Message-ID: <20261022181620.247201-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Part of the effort to make ksock have all basic socket operations. This
is for example useful when replying to a peer which expects a message
from a particular source port.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 37168f43c16c..c7b487d90cd0 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -178,6 +178,33 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
 	return NULL;
 }

+/**
+ * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
+ * @ks:		The BPF kernel socket context.
+ * @addr:	Pointer to an IPv4 or IPv6 socket address.
+ * @addr__sz:	Size of the address union.
+ *
+ * Binds the socket to the specified local address and port. A port of zero
+ * selects an ephemeral port.
+ *
+ * This function may sleep, so it can only be used in sleepable BPF programs
+ * (SYSCALL).
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
+			       const union bpf_ksock_addr *addr, u32 addr__sz)
+{
+	struct sockaddr_storage sa;
+	int addrlen;
+
+	addrlen = bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
+	if (addrlen < 0)
+		return addrlen;
+
+	return __sys_bind_socket(ks->sock, &sa, addrlen);
+}
+
 /**
  * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
  * @ks:		The BPF kernel socket context.
@@ -285,6 +312,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_bind, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)

 static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
--
2.43.0

