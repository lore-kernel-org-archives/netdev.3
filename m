Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491929;
	b=qHLloqziON9pqrOgBVp/cWfgOV9wIKOA51QcOAkqjRz/3t9itsGO+Yb269VUv5TbPwZe
	 cz9/9yp4F+jSW+APTJSIu687sH9noyDQp5AvZJRVrECmczrjW2oR6tTK7/j51Wk6DTdmD
	 pBc8z5yIHBdYo81g4R8RddNamaFIvaHFSDWn7dOJipcVNcSBLvXFk4ggHC18bCgc+Qb1x
	 OtDtGv6405rpyMU9d7QkjpTJATCoxNIhQ+k3oI01w3DFN4R56WCW9o4ld9NMfysJHKU+J
	 g0Q0PMkqUt9/CErefFu+dQnmd6WPkEXFulAGi1waHO7nB+69H5TTBqbZE4l19fU+0dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ddVaI0v2f71ZZ44CArj4LpoVJsryP700DD1ocplBW6M=;
	b=t9qrD9JJLMBxT5OWovjIghkDJJPgHgxQWgNAzkpyRx4y3/ngvxkT1sQI3EjhGoJ6RM1D
	 ivcracOrAq5w83QFrxGZqU3cmFYoYYepLcRbohM7E+PJewkjQv7ljhEbLWX35DAuA6rje
	 /dsJRcCB4DYGG1LBArusvWH/8Sw19qKVxF3cGPxywZrvCiCJoyKSsuUd97tg4AHdkS2rf
	 BiDjbOLXTNDNvppByFpRJ3K7cGs0RQ4vj/8swYabZEd6WYX0Nfwx1KMh3hpQz+DFNT1jJ
	 O+UMP/UtZ0cZZ2Z/PD3SO6KTeAsPnOkDR0bpfRmdUo8eq8T89eClCMGOQVkUDBGmqDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hg32D8c0;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD560A263B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AD560A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hg32D8c0
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso31259745e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491927; x=1793096727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddVaI0v2f71ZZ44CArj4LpoVJsryP700DD1ocplBW6M=;
        b=Hg32D8c0YB0vq+nwCCni7BZCvEQ4j6c2smN1VtqDfAtpRqex+OgzBtiTA1tnwA8rXP
         AczlMkWvkljOf3TqbbBn8+NzW3jH0w/0ElDduqdBxn8BW3sNNshAYDEpHM0H9kOi2ArH
         7Xo8F8G1kteEmy4sS9ZRVgsz1gSrP0DNPYIhbf3m0TjCMXWxy7EYMaBbNQ2UQw1imGR3
         iEx/QRgal/tOXJN2/8/oHlZgnFJvdQFFFcLS4eWmCwEXZso3IStgzWAxjUqBhKsA0eBn
         DXfCCBF9agMoXTwaTLAWOYSOBGTRv8YWlUAC0BbsomEVRTWIHMcNKi+dCe/U+RQJ9p/9
         cmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491927; x=1793096727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddVaI0v2f71ZZ44CArj4LpoVJsryP700DD1ocplBW6M=;
        b=cdxLSkQetEQkqG6UxHu2hRzQzUMg9yZYoNtQpfyrtYuGdC+/2ipmca90b8+W8scTyw
         EugB6Ltmd6sO41thNawhtTNim5k2daFZnjeSeFzOavGNfjr8E6wHPU6vK3YStn4TG6Wp
         gcF5TULTJWhyN0VSWJ0ZekfOqRP1j8BfB2YnHB+UQEOWYXnxxnCxK9jEa5wN0EL5iWYm
         orgcEH2r6QtYNJx2VHifiMHkoiQeE2tl6J7wkPQhjdW09lQ4DJdP+Ft3NSUbh57InqYk
         QmoU768a4tT2Pa5Wfd/02Vf0rLs1bdwfh89AVhKmazBYvitl8Bui6TgeOw1QHGOLfDRk
         NpBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcUc2bcA+N11SUGjzaq/9fT2yAHHiaR9lZEIkSr4Uws1meW0Vw0aZFsPjCC2t6J9Ht1H157Xo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOCNlKoLBz9QtFzObBDAngHbqua1IeGsaWgwk2PiMLvP0nRNnW
	nlFxlSpMamCGfeZm98u+V+bd4rcnYRonJCCeaIWDjiaT0SSM777qQB0a
X-Gm-Gg: AYBFou1OerjM/PZ0rosaM68bxQCyacD+mpqgzKtJui5n/U2jUa/OzHqgVGdLLFlsNfD
	IGdSMnFVdpj4BKeHPy7wKczE2wrDtaS29fC6Pkhmcq2LVBUekmEu76NEL608Xl4NRCyIGT4Ffyd
	+73CzZvq8k2nODnJ3IFjD7ypi0YiwN6hnevYiqCjYuz9iyVpNcfHDYXOgbSLDMrkMfw3RrFXaEX
	w9pokKCkTXApSzYPW46cO+LxJupJ+OxwWKr6aeuh29j0taZZ9w1RQJUOqz7qc34GvfuYVt0TulQ
	8MCNbJ2UERvKeISPMTn/p3P+6/6g5Q6RllW60QarpNypaIoiK8HOo7xch999HfNEiRQxbG84Gmy
	XN+EMerP3OL0fx/0H/w3i8Q/5D16Jfe9y3d9oJEHBDH2AvP4S1wXBJnrR5HbuGtCW3auLgHaorO
	Q7nc8rGAAWQGio5YU1jsjdb4Bd7eQTtVxFEflkC+uk2yaVn0waP9+7oGSM3wfqC+gK4kb6NR+Ry
	GrPNkwXm+sNoVtUH/CdtRAHGRSlUfsu4rb5Ef1DMUEA9Q==
X-Received: by 2002:a05:600c:3b13:b0:4a0:2150:55fb with SMTP id 5b1f17b1804b1-4a1d75ad08amr259692375e9.4.1792491927077;
        Tue, 20 Oct 2026 03:25:27 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:26 -0700 (PDT)
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
Subject: [PATCH bpf-next 7/8] selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
Date: Tue, 20 Oct 2026 10:25:11 +0000
Message-ID: <20261020102512.518479-8-mahe.tardy@gmail.com>
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

Similarly to '7b0dfbf5776b ("selftests/bpf: Test forbidden
bpf_ksock_send() LSM attach")', tests that the verifier filter prevents
bpf_ksock_sendto() to be called in a LSM program attached to
security_socket_sendmsg() as it would create a direct recursion.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
index 7b5d118e5750..82901c9e78c8 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -33,7 +33,26 @@ int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
 }

 SEC("lsm.s/socket_sendmsg")
-__description("bpf_ksock operations other than send are allowed from socket_sendmsg LSM hook")
+__description("bpf_ksock_sendto is rejected from socket_sendmsg LSM hook")
+__failure __msg("calling kernel function bpf_ksock_sendto is not allowed")
+int BPF_PROG(socket_sendmsg_ksock_sendto, struct socket *sock,
+	     struct msghdr *msg, int size, int ret)
+{
+	struct bpf_ksock *ks;
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		return ret;
+
+	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
+	bpf_ksock_release(ks);
+
+	return ret;
+}
+
+
+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock acquire and release are allowed from socket_sendmsg LSM hook")
 __success
 int BPF_PROG(socket_sendmsg_ksock_allowed, struct socket *sock,
 	     struct msghdr *msg, int size, int ret)
@@ -103,6 +122,7 @@ int BPF_PROG(socket_connect_ksock_allowed, struct socket *sock,
 		return ret;

 	bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
 	bpf_ksock_release(ks);

 	return ret;
--
2.43.0

