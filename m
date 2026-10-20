Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491926;
	b=pcHUHu38gJu//DdgAySHBh169V0a/0W5gzt4cifwdY+BpulIIx+r+ktVePBGsgBtsT3K
	 tfn/SaS0c8krke66UetZdh4y+UcV6f0FhQFfIKwxs8OhtLxLQuNj/Q1U7EiD4B0WP+Cq0
	 vZ5uSZn28WSuoZgmpj5T576YuzvAFVEyYqYGKLOU6E4+qmChXxNpq/BSPvbHS9sUFkkH0
	 /OGsOi6bsqX9VwG4zeMBhTOIEpn4THO5nBIlGVhxutRWKWX7edkKWEr4Pa28H0UL40BfX
	 mmoIReUq8cj2QAsB42W1XaeU4A0Mp2FhBlj86IEolcX82J7kqLvjcBHaXdx+QJg4pcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9vmVUK4edB1q8I8ZmjVfaRKyA02pZXb5Eagp0UVPZCg=;
	b=e50k3h2qhs3PBZFi3Mf2bzA+QOLxlHKoBv0V1cZOr9zeQMbAuISEVhKE9Mu4VZ6AiAkc
	 XZ05w4UIB81PLbyd+dJKDglrFzzaSk5jzx0Fnep6p2sOMVi003pwHxnq04TSER5YASayq
	 P8Rck/M0OBJVWQeRzg0+cbHgDLxF0JZopqF0gyiAZYN8SKMXYs+oz0WkBXIzkwKikukLP
	 zn+PTSCgslXo/v++XD3UPXrW81CvuuzV8mN0QFAkO+hFWtNme38BQ4Kts4MscJ3lyi2D1
	 0VcalKjlvupXqzz4Ixt2y/IC9DmEnB956+yxiq3wsmm6WRz2nC0tS5VBdKSRQdfCpfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecWKua4W;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE160A2601
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04CE160A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecWKua4W
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so37785955e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491924; x=1793096724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9vmVUK4edB1q8I8ZmjVfaRKyA02pZXb5Eagp0UVPZCg=;
        b=ecWKua4WoxWV6QYeBGtoAohC4EHnMx5TsMOGXQLQsqiTcayHaCNRt5EARml8kYO3Vx
         QORwP5ZDmqReZBd6kabaWNNPBgxgBfgaBThfAr/VPrNs/jl13SkQbRY4XMUc/ZyzNSzy
         vlnJTB1Jy4uESsxqRC7OYfg8jKKoT8jJPPz9Qjau0QaVofMxNqbQh4hX/SkWjUbSHcMr
         tzyY4eiwCGcxzZcjLnBVc5BfHTDLUuWLTW6ZwKnk8lyNHg3bbte9JuAGQMIi27gIBszb
         cYn6RXyx21YEBKqJvl9CU2dDC2YbPR7bccBlUMeO1/UB2ji9vrBPj928hgwAqHd5cc72
         edOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491924; x=1793096724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9vmVUK4edB1q8I8ZmjVfaRKyA02pZXb5Eagp0UVPZCg=;
        b=hpeKX/PkAGQ2gZgnWTaPVvdPuDWNquVZMT3UqnUgjER8rLFFWrrbdQepuPU3+HD0Bs
         TKWrq+D4rzMEMzmKwM8BX+XDvjMDqGGKLGmregsyIy5M/e3NaWpPHXkId8Dzzjytl9fN
         76KTJ9fdcbrGIKX0hT60b4cXJGBeeb42wc0y64Dqmt/W3MvqD2dIY3U5jWH6b94n0afb
         r1m0H9jTiqSNO8ZnW/RkizC7dHhglLIXOIApybSowLoqDV87eo/HUEFVK2eiBd4MwRoA
         VnYK8Likr4jUoGQIVu7HAIUN855YGJAZsS1KbA0TBPfGi6r0ZGfVSKg/03Lfszpjuffr
         dQ4A==
X-Forwarded-Encrypted: i=1; AKwUvByzYg2i1yVHNqSZblGbAz2V5VfxWvUwI5JrMj3TMBZnp8vH3XUARQYIomo6zgdozkzLndUenW8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK09yp9ic7XjMpu0ScuH4Str294tIrgYiHWUiBsyUg36rA8llXk
	hcg4K9glYG1uR0jjpwiJTAYBfvNKp1wOQ1WlulLHMEdR75U3rIm18TUJ
X-Gm-Gg: AYBFou1ceQpMwf5eEHSevfI7UxiU2OxglE5D+Pfd4e7M2PZlpCCnBoIcUxCUSAvjlz6
	IvAdL3fGkkegZJi5kI9YVFv8QsJ/CFeFUvfwTVXc52Y1Po+2hUrYQHA+PTscFNclFxfVPq7btcb
	QeKv3Pa4apL0NmLWq9Nd/WmsbYbwuyz6aa7aYkoZBewuMEYXpBZ9lPb8ivhZxdhZVNd/fHQR5yH
	PCAMaO6GOPR0ArgL3ZBz5cMpCGGf0plPiK+1u464WEbmP09aEbLwMcnU/oVgiHTv9P4rc9ZKxgJ
	u9w4H0NM3qyCzd2OiLdpbWW7Boy4zQyQh2T3ySAhjsh622UEXE5h0l+l6HnJvUab2kHO+YDfF92
	6ZCN5gxLBrBiJeDYYqJU4oMJJlCWHod/ArQ4/k7R2WvXG9EVDdV0kodAP+1BnzjCAY6p/JYxU7O
	XOY8bJ6Ba0H3eMorY4bfVdVAGuPakDxQfS35BPiZqBGd00hRI6AvN0m3sN284PRrnNirIw6bFr6
	2suYi7wBGO0TJQ4m1VGwAiwagPXQNzNEG9TbmYiSGAvXQ==
X-Received: by 2002:a05:600c:b99:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-4a1d75a9828mr204102215e9.1.1792491924037;
        Tue, 20 Oct 2026 03:25:24 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:23 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/8] bpf: move ksock_connect() out of init kfunc set
Date: Tue, 20 Oct 2026 10:25:07 +0000
Message-ID: <20261020102512.518479-4-mahe.tardy@gmail.com>
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

This allows to ksock_send() to various destinations by allowing to call
ksock_connect() in the send path instead of initializing it once for all
in the SYSCALL program. It was limiting in cases ksock was used to reply
to specific destinations.

We need to break this potential cycle between the two LSM hooks and BPF
programs calling kfuncs triggering themselves:

socket_sendmsg program
  bpf_ksock_connect()
    connect_socket() -> security_socket_connect()
      socket_connect program
	bpf_ksock_send()
          kernel_sendmsg() -> sock_sendmsg() -> __sock_sendmsg()
            security_socket_sendmsg()
              socket_sendmsg program

Breaking this on one edge is sufficient, so in this commit we prevent
bpf_ksock_connect() to be called from LSM programs attached to the
security_socket_sendmsg() hook.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 6c508c7a0adc..87329c4a2f8e 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -144,7 +144,7 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
  * Connects the socket to the specified remote address and port.
  *
  * This function may sleep while connecting the socket, so it can only be used
- * in sleepable BPF programs (SYSCALL).
+ * in sleepable BPF programs.
  *
  * Return: 0 on success, negative errno on error.
  */
@@ -243,7 +243,6 @@ __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)

 static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
@@ -254,6 +253,7 @@ static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
 BTF_KFUNCS_START(ksock_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_kfunc_btf_ids)

@@ -265,6 +265,14 @@ BTF_ID(func, bpf_lsm_socket_sendmsg)
 BTF_ID_UNUSED
 #endif
 BTF_ID_LIST_SINGLE(bpf_ksock_send_id, func, bpf_ksock_send)
+
+BTF_ID_LIST(bpf_lsm_socket_connect_id)
+#ifdef CONFIG_SECURITY_NETWORK
+BTF_ID(func, bpf_lsm_socket_connect)
+#else
+BTF_ID_UNUSED
+#endif
+BTF_ID_LIST_SINGLE(bpf_ksock_connect_id, func, bpf_ksock_connect)
 #endif

 static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
@@ -278,7 +286,17 @@ static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 #ifdef CONFIG_BPF_LSM
 	if (prog->type == BPF_PROG_TYPE_LSM) {
 		if (prog->aux->attach_btf_id == bpf_lsm_socket_sendmsg_id[0] &&
-		    kfunc_id == bpf_ksock_send_id[0])
+		    (kfunc_id == bpf_ksock_send_id[0] ||
+		    /*
+		     * Break the socket_sendmsg -> bpf_ksock_connect() ->
+		     * socket_connect -> bpf_ksock_send() -> socket_sendmsg'
+		     * cycle. Blocking this edge is enough.
+		     */
+		     kfunc_id == bpf_ksock_connect_id[0]))
+			return -EACCES;
+
+		if (prog->aux->attach_btf_id == bpf_lsm_socket_connect_id[0] &&
+		    kfunc_id == bpf_ksock_connect_id[0])
 			return -EACCES;

 		return 0;
--
2.43.0

