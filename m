Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692995;
	b=WIhDCd8cJteQzXdnQVCa6tcBS5JVTKwnGmiq8cHYkm1/trN8xqYj53EFVEpnH5Qi4MUa
	 m9LQ8/+Rzr6Wt5xDbH/ibjFbvWYXE/61sLwk/D64Ovze9sGdbTWD9ksSt87bHjKQDOt5p
	 cMgFNlB7Qtpa3N61FYZRkpFPsYnx8hPpEyxTTVPwybNtjEq5xpPGvSYUoFskHqt3+0i7C
	 BLGVvK5hQK3R6D1aZYL6ACnJhvG2+t8KoGx03bG/AtCO/tWIDaQj307VC2ro31W//vBKV
	 qC160B6DRF2ytqelpVnpAsd4C/b0Zgmg7tsnNyJb3EBCKXh1HYgAjgeHEo6uoWL2JmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=525OXRTkCGukB1Pg+MVGVcjD+Y2Gy39duVYWV6D2upE=;
	b=bJTdWTjS5bG1Q56XO5as749cLCGAU5Hf4xdjEGFJde9mz5RotS0YzaB5LrM1I2Qu3R9g
	 KyeIlPjXIni7IoxuhcslAv2YQChXM46xWcMS5PIQDaf+XIGOPF6Rj75SR/M2SIyHAxtgt
	 gnkr0AT3RqanO6uQR4JTd/ABmSaUiZgIwPYRZqv4lWBB1NUHCG/NjjAqJjxTAS1uVGKpg
	 F+XiJTNctJrYG7HsLtj9kOCejf+1B1eywkJPsAL80NXe12H7BzP3RHYKJ5b5hF3/8WQiS
	 43GSz/SAuhUk9MrzJo5glr8GYyi6/txKhTPOu8N1sAflox7gwV+sGOAp6JFSphL+S/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hcffg22g;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E38606A321
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82E38606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hcffg22g
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d870d54so57487f8f.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792692994; x=1793297794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=525OXRTkCGukB1Pg+MVGVcjD+Y2Gy39duVYWV6D2upE=;
        b=Hcffg22glfuo9j+UoU7FtA9i9R7VpB3T/VL3uZbDnH5e68P/XJk13CMFRtIOp623fs
         66i6bEo2d4xxGRnFRhDb1bvug5cLCrbP8TbA7RWV1L8nzdMTzPVrGwLDh4o3c2YRLaUq
         WZ/0y/nLop5sYGu2lhtx1L8tx+Sw0OIsRZwD/em1IwQSrVEndp0uRItr7BSoHo7JIU3c
         naeEpHBuWgUZsjYS7S5oAPZLrs+LSq132BFLwfwNCH3UEGBMCzeK5VfH0croHRZhrL9U
         EtuPBhxbs1y2NcJxMSPBe34WYH0p/Y7Gjfe7DbxMKa1TZAOWpDuTlwuueScCPmF+L+zK
         GKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792692994; x=1793297794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=525OXRTkCGukB1Pg+MVGVcjD+Y2Gy39duVYWV6D2upE=;
        b=l/CnQEN4/exY9ERvjUUa40kBlgvr8tOWcK8iYV7sZ3u8xL0AfH8D/NHw0FLbgRCmuO
         oVIOZvL3UVD/ynjHU7j8Zva6IURmtKSxiHMXHbkBU20mFSpY+JL2B1y1WUKzdnPC39u3
         n2b+dE5dpvM2SwL1DJRAf5CxaTQBtQKnJ0uYLpZYJUYrMyniUy4Xan3GR4Ywue9KvbXe
         o2s86QIVlZ04Pw9P/n+9wsHATGRGJbrtzXvn7G8BWJyXM9DMb5t8fJzKGVfrnZ3Fvt8O
         DjFTgyX0LqYKx0wGIANPWz2cTOGWvI9bUOGPjGRqKY1v/PDWkwoxp8BtctLVaf4NxtOZ
         P8tg==
X-Forwarded-Encrypted: i=1; AKwUvByY5cBpjoa5RNqCeFqt9sy+XBH1tkVJordxl5d9yXFeqhdQ5f6fkFCATdwObuZfLKKFd0pMzQ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSVwqsc8Nxvm9wh72coNi7NV3GogMdjunePQWiynApKyskxHuy
	GOw3XtzoMktyh+S2rg/PaReP8IJGa/SnbNSzMmqRxazzF2X4+XZtI6GN
X-Gm-Gg: AYBFou0GHgltSjpvVh8cxw8G5+R9LWlr1+PxivfXfu//nJjmJtQGZtbtWgLn5Ld5YKy
	r1XUquzCpoAJUADoqDWtSxEmzSkJEZJacaqFeX2d/rcBCva9UmdSxkiCUnsd2KPW05XV5i+ddzV
	nNJCTqID/1xwdNmyY5LPCoD3aZ3K8Qssc/170XFTRzgOIznJRUsAYlIvqiQMcFVetoeJB78pA0Z
	7NMsrNIV8Vlv48evZTFCCPXLLsJtrErVrOI2d9h0HjXq82uKtytaU6Ys55sgB/Kx56vNRTXC7mJ
	qaD29DftgtogX+yLip+BW2UqyFYoQljL9DFIJDMVguhzjH1omqktkjuc8mH6pEKSRsTgZcXfX2y
	WJCuTuCjIuUlimqNE/HVAKVlczedbyvHq9z9CLpmFVCf/irxpHDqNGu5yvTOuRpDW2D2RCpwhF4
	jCwlgJ8k6WCv/CyzhElw5hofRQs1PS7CuHRzqAxTXEEWbkAjsW6kEIHwd/iZdHOcRjndcqCX/2m
	Tt5EQVywtslzUF0YVeiyLJ+YI1tmgAiKysoMhKBjFBTpKXNicybNtkSz5bsRKxzKVt1xNi9nobc
	PdvuSkr6VLy3QXxspfMvkYfgCW4=
X-Received: by 2002:a5d:5d09:0:b0:487:342:d141 with SMTP id ffacd0b85a97d-48e2649da0dmr13328204f8f.23.1792692993734;
        Thu, 22 Oct 2026 11:16:33 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3796b2b4sm18451f8f.7.2026.10.22.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:16:33 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_ksock_bind() kfunc
Date: Thu, 22 Oct 2026 18:16:20 +0000
Message-ID: <20261022181620.247201-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022181620.247201-1-mahe.tardy@gmail.com>
References: <20261022181620.247201-1-mahe.tardy@gmail.com>
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

Reuse the existing basic ksock test to also bind to a specific source
and verify that the source address was respected when receiving.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 22 ++++++++++++++-----
 .../selftests/bpf/progs/ksock_common.h        |  2 ++
 tools/testing/selftests/bpf/progs/ksock_lsm.c | 18 +++++++++++----
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index dd6b167623d9..9827aeccf3f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -10,6 +10,7 @@

 #define NS_TEST "ksock_lsm_ns"
 #define RECV_PORT 7777
+#define LOCAL_KSOCK_PORT 6666
 #define RECV_TIMEOUT_SEC 5

 struct ksock_test_env {
@@ -63,6 +64,8 @@ void test_ksock_lsm(void)
 		.sin_family = AF_INET,
 		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
 	};
+	struct sockaddr_in src_addr = {};
+	socklen_t src_addrlen = sizeof(src_addr);
 	struct ksock_lsm *skel;
 	char recv_data[sizeof(skel->data->send_data)] = {};
 	ssize_t n;
@@ -76,9 +79,10 @@ void test_ksock_lsm(void)
 	if (!ksock_test_env_setup(&env))
 		goto fail;

-	/* Step 1: Run the setup SYSCALL prog to create the ksock */
+	/* Step 1: Create, bind, and connect the ksock from the SYSCALL prog. */
 	skel->bss->ipv4_remote = htonl(INADDR_LOOPBACK);
 	skel->bss->remote_port = RECV_PORT;
+	skel->bss->local_port = LOCAL_KSOCK_PORT;
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_setup),
 				     &opts);
 	if (!ASSERT_OK(err, "ksock_setup run"))
@@ -108,10 +112,18 @@ void test_ksock_lsm(void)
 		       "LSM send bytes"))
 		goto fail;

-	n = recvfrom(env.rfd, recv_data, sizeof(recv_data), 0, NULL, NULL);
-	if (ASSERT_EQ(n, sizeof(recv_data), "recvfrom len"))
-		ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
-			     "payload match");
+	n = recvfrom(env.rfd, recv_data, sizeof(recv_data), MSG_TRUNC,
+		     (struct sockaddr *)&src_addr, &src_addrlen);
+	if (!ASSERT_EQ(n, sizeof(recv_data), "recvfrom len"))
+		goto fail;
+	if (!ASSERT_EQ(ntohs(src_addr.sin_port), LOCAL_KSOCK_PORT,
+		       "source address port"))
+		goto fail;
+	if (!ASSERT_EQ(ntohl(src_addr.sin_addr.s_addr), INADDR_LOOPBACK + 1,
+		       "source address ip"))
+		goto fail;
+	ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
+		     "payload match");

 fail:
 	if (tfd >= 0)
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
index 2a32cff2fbe9..87321f4ba4f5 100644
--- a/tools/testing/selftests/bpf/progs/ksock_common.h
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -11,6 +11,8 @@

 struct bpf_ksock *bpf_ksock_create(const struct bpf_ksock_create_opts *opts,
 				   u32 opts__sz, int *err__uninit) __ksym;
+int bpf_ksock_bind(struct bpf_ksock *ks, const union bpf_ksock_addr *addr,
+		   u32 addr__sz) __ksym;
 int bpf_ksock_connect(struct bpf_ksock *ks, const union bpf_ksock_addr *addr,
 		      u32 addr__sz) __ksym;
 struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm.c b/tools/testing/selftests/bpf/progs/ksock_lsm.c
index 9808451098ef..28da777eea6c 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm.c
@@ -10,6 +10,7 @@

 char send_data[32] = "hello from bpf ksock";

+__u16 local_port;
 __be32 ipv4_remote;
 __u16 remote_port;
 int target_pid;
@@ -32,19 +33,28 @@ int ksock_setup(void *ctx)
 		return err;

 	addr.sin.sin_family = AF_INET;
+	addr.sin.sin_port = bpf_htons(local_port);
+	addr.sin.sin_addr.s_addr = bpf_htonl(0x7f000002); /* 127.0.0.2 */
+
+	err = bpf_ksock_bind(ks, &addr, sizeof(addr));
+	if (err)
+		goto err_release;
+
 	addr.sin.sin_port = bpf_htons(remote_port);
 	addr.sin.sin_addr.s_addr = ipv4_remote;

 	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
-	if (err) {
-		bpf_ksock_release(ks);
-		return err;
-	}
+	if (err)
+		goto err_release;

 	err = ksock_ctx_insert(ks);
 	if (err && err != -EEXIST)
 		return err;
 	return 0;
+
+err_release:
+	bpf_ksock_release(ks);
+	return err;
 }

 SEC("lsm.s/socket_bind")
--
2.43.0

