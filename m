Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041433;
	b=og9v0xtkFNvzkcOLBBEKInXF40OQZNLcsWbzjhz3rCESccqbI/MGTPTIxgLIqsqPSmOU
	 mo4XF9EYdqSlazwNmwZtKTGc9zVzKsz3MrTWkRN1ThRZZeyIh/TbxbiJpqz+nBKIMZw/I
	 itC4uNPVhlZ177ZKoCnjAw185aan21xkZMpFflYCy732E5nIIyrltav/xKtzE5WjBPJ3B
	 VnHUD3iCPc5NR9/UakFAGc5l/DN28MrIUzpY0s0XtUKallBAgn9/DreQsqHg1H8Ut/Jmw
	 GsUenMxsAV4/9QSssjg6GNaWccMjhXI9ZXF5Ma7DJYndu+FlST3MzDLHszA81CHHbeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DOZJrjKX63ZevYgJMuO7XQKY8YyD3Ep4iAtbpx4Y4is=;
	b=Z34AKoMscF9AoDSh5/7INq+1kkEjE1Agg0Sbx09cl3MX1lr2kolSZtSkRZNJfXYm6Xt2
	 U4x+hPKpd8hgl6LgRtSOsb6lpSuN8ZK9SmVbjz+ftLX27SjjnaWzaCWyjspQ47cY1t450
	 rQ8+8pCc52Ke+dZEt+JQ3qi7yKEpqCKNhKjDLh1mmxMHqgT/VMgNdz5PDxMvjdWNgAGHs
	 eEq59YI/vDKev8zPrBZFcfVBOs0sZv7kGwHbpYOf5eZon5G7CFTmS0xy4gmAIvZ7dtZ2J
	 CeiQdd4QaBMPqoroewcDrulCg5bXa8CqjJTbO5vIRJ60AFONpyBsu0jZlyG30vk4Cyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TucQYsfO;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5E606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 19:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F5E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TucQYsfO
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso17286325e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793041431; x=1793646231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOZJrjKX63ZevYgJMuO7XQKY8YyD3Ep4iAtbpx4Y4is=;
        b=TucQYsfO6gw6O2eXXY6yhDRXPe+AFkM8MRluiZeiMaP415jhVwdH+vwDuaPsXx3d/a
         apKVsIYyDfucp16PujRxv7sL/Z4kov6GaCDaiUNTV/+cRt49WVrpibi1V7c2rcgJfdLs
         Mytqn9PEbiPwu+DOZu1Bi9GJdY7uNyj/YPEV6Q2ImOlv9oiAlDNwAgB0mnjqOda0Jp2M
         SYvbuawLhTKVqmheMyhW+y1hKJY8bRb1CR3SYbWJJ/WA21zveh4TizfLePQqfCm+Vw0q
         rvTogdLQLaCU8OjkOEZVGFw4bWu7PAN2M95fSj3YF0bAxqM5Y5Q6gaZjlYOUOXzoGoU0
         S9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041431; x=1793646231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOZJrjKX63ZevYgJMuO7XQKY8YyD3Ep4iAtbpx4Y4is=;
        b=PYNGhASrCFp/sBWHJXYnU8IWxNbegdoyptQ+w76vewXpMgKKNB3uJRpyFbAM26NbsY
         nxVv+sgNaMSVxqJecseChiKViAZ7s+34WQaw/TJHJvRCjo+osMhEW43HQ0PDzYwaQzNB
         /1yoUctSiJOkS/5VpNPaklME2JtxEDdfCv6bvPVz36KvcF9pLxBzI87IN0xpMy7ISLYK
         XaNiawZpKp8yxy6Ui0rFPBgSRL0Z4x3higLMUtcYoeQqhBsB5lHAnz6jWSwut8GbYham
         tHejLPc/bZEwv3CdpKvBarg8g2bpIFU3oE0Iixi9dt8311iBBFAyTz0GaF9WK86tz+Of
         jZ9A==
X-Forwarded-Encrypted: i=1; AKwUvBwhLNQPH/oeCbiIee2121LGKqf2DAUa0Of2dlZmEPAhmgA8jOif34Zt7YsxKmqFiFAHIVE7Gxo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxUjx+I6OkSOmDnZxRVtRTLaKd88+Xoe7HglZGOr/gskcQKcI/
	+LiVAeNfCoagrf56N1iGCirOn7pcdFfYsvHTikiw9zp+T2vp65rnyXHk
X-Gm-Gg: AYBFou3j0Pz8BUEgzmfLRHpZAcRD1L5W0jfU7XKbQ1YqE1SGqAi0yy6JlKRv29cmiYh
	8qbHhM0OFfcXPbBHavQLU+tAyYZDZof4a8IqxRGx6qT3LAIpqI0lPv0xiWM43G7Rx3hga0IDUCL
	q939zbNKDiaZJXrREEOcJhiR3O347C2nJtuSbXZP6Gf5onBNPna92JVnmhHCN/1sQvdceeHnsbX
	9Xg7bnTKpbkiAz8TG3J6I9YiViyA+ppJL/POMCTtlWV5j5SwP43Jl+K6hqbNiQXHcjtJTVwLJ+5
	TUpDwi8JXBKc0h8AZ8Lsqs9ijHL+SJbyissdKPuzgtA7dca0aLONOhxfLmEmaMgv+DllKBP243M
	/tywm210ykQbDJA23eLZeLnJPO0NgqMoA+epB1N9YLINjt/t1RVBB5i+RwwYEdvHfm1+vgYMLZQ
	itsi6SI8+HX8IeF7MHDyxH6ZA2xO8yAr0vowSm1d+usvnOC6mHAOImUm3aS5t+4netdH4q9hFXO
	d0wE3ZhcBFGuSzflAFzfY83sxcGDJC/axFhVhF/pVwNaPtutnJuImEK1OAVKb3640fYSG3r2K3L
	MkA9BrKP9P7ymXCzL6mFIOpHDLA=
X-Received: by 2002:a05:600c:190c:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4a35ac394afmr147153975e9.1.1793041430904;
        Mon, 26 Oct 2026 12:03:50 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm21145713f8f.44.2026.10.26.12.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:03:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Add bpf_ksock_bind() kfunc
Date: Mon, 26 Oct 2026 19:03:41 +0000
Message-ID: <20261026190342.137069-1-mahe.tardy@gmail.com>
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
 net/core/bpf_ksock.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 37168f43c16c..25111712b944 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -178,6 +178,37 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
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
+	/* Prevent wq kthread context for CAP_NET_BIND_SERVICE check */
+	if (current->flags & PF_KTHREAD)
+		return -EOPNOTSUPP;
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
@@ -285,6 +316,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_bind, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)

 static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
--
2.43.0

