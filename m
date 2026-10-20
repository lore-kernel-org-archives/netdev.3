Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511941;
	b=3UTG+LZQOXd8cB6R+1RSZbBAcoVTqso8LvDb45pUVuEsI4FxY+axpHEAzxHz0hzgeWcN
	 9qQ3aEV2IVq2si1AgWlK8B1O02PF6FXi02Wg4aWj73zZCSfkFp+md31C4yl3CkCGJrCmu
	 CFOUHssDgVrcNxSqRL7qvreK/017hKYZXOkl3aMbpIzdOdX0EkksKZKu1/gZYeZo13gE7
	 syH16xTncTjAXBNMqA3E50JFoWqmmXQGiDlub/B7TcACkC1fGWpW+F9c55J7FhYyS5n2h
	 6Whqb5AwrTwV9BFk5oKR7MiEi2bOigYT37JtZ3ElK8ZPkCnmXbBt75EKzqHh5lBnrVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7OId8RJ5d9QD0eD16AKrMXmzoMAteLxYLWOYcbZVb2A=;
	b=wZBE7f+AMuz7Q05JJy7YRM/QiTO8dBDubaKtGnQzL0l3aWjxypnHtADsGpNgc1AtLo53
	 7RafFxa0T1oWki3P6EeTHb/33O44Fq6qbjSjJTP1tLDikJblnSAiPNYjjwieA6FxCUoF6
	 vquHAF16XPCMgGiRKVk+pRFif3E+d+x6a3y85VN0hYZRxoX1gUvck0nu2VISEgT8NUsPn
	 NeA4+m7g1SzrTzd4tT9V23BTxS8LonXKzH7nlD1R+CdyuD4GDOVkPSnkpqI8UY+bAOPNu
	 WP1rQnd4SToXd0/e7qWoiIjXpDKN8lwFRasoJIZlp4Ofnnq5wrcCtR9mFZ3vR8VQt2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=itgc0umX;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD195606A32E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD195606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=itgc0umX
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so26090355e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511939; x=1793116739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OId8RJ5d9QD0eD16AKrMXmzoMAteLxYLWOYcbZVb2A=;
        b=itgc0umXTf7OyExxknwmQf9gwtXN/BXakhLmirFMBrYCVUlXX7PhhibEFGhQlcw4TL
         dGacBS8pO2xsvXAG/qXr9hxZP74fQRLX/yuBDffoWoX4090NeXSiuYRuZMI8Z/I0ZW2t
         J2xS/41pLbpWZuDB9S2FRZwLVDqDqdKcRFyusw20nWH3MLD2QB/m70cNr75sMRF9bpfd
         ZUyjhL3o6rm4pxJxS+XJhkXsYwepgJ0MMK7wBEC5jFVMwXvgkfVwvre9Oezc7kzS90mL
         o83Absvy1iRVfGx4l/NnqKh3VnIvlVhqZnts8hfWx9Ga6INJUI7XoLSKndG7qgymwIyi
         8nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511939; x=1793116739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OId8RJ5d9QD0eD16AKrMXmzoMAteLxYLWOYcbZVb2A=;
        b=Nm5GiIIRuLdSnh0ebSmue/2GM8A80rQCYn/pE+0/aYDoGMYA2a/W8lRuAHNk0j4iLe
         MGcC7ZLDMZqIhbk8pPBuJeTZ2BPf87pJ8SRjwh6uDW2CKa9VWqkkO61AVC18PflKQ1Wk
         KdptSGu5H3D9W22kd3D4kqD8iQQ4iT7BXG0Pe4gs91C+IgVlzXujkunIM+QJ9bPbF/Tv
         gMtxN75c++//QMfKRJ9HpbLgJdwUUoWQPU5NzdsNq5eijMVGzrXbpqhGRg50MoX2/UMi
         A0+SdoP3eu04kmupJPRpzT2rVL7iXJ5iiPswH0wCDiNjqng1FLIae4ldovZqDi0xg1sZ
         Weqg==
X-Forwarded-Encrypted: i=1; AKwUvBz8OtLaMELOrjP5J81iUgW9E4TMy5os8vqNKBajxQLy+1dRMHh90pS6MRiBueY7xRWUz7ul72w=@vger.kernel.org
X-Gm-Message-State: AFq9FYL26DEuqqA3/aTCbeb6pWGRB1VXrkK8isPxOcpNej8BCNvyJE2J
	Egq4OUgSmb0JUcnNPOiCurj6UaTU1T340kLJqc2wSjYQjPM8PgtHFBsm
X-Gm-Gg: AYBFou2kyYxUatJwOY/jzhjgEWTDs2sT7d+FyZ9lizvqGleXLc8W0twOmMPxU90cBSx
	2aEYFCZLUChJfdCqs0J4e8PMVSPJ+fHo2RlHETXjLwUyNBveHta+Fr83J6hSCRN/Dj5Mh2OCnul
	QQfo8HgvslR5T1MDGdlk2KuQuYo5vQb7x/QqDxKXHYpIGPMqPTZWATS/nioRJgC22PdNqaYzYxs
	GvW5xTlIzo3lwPjC9FY5yShzMQgViQuhuv50iz3dgOwaErlmE9E9UuoJcwOMKlp1C0ctoP1rlvt
	V/erADP6M+LJ7g0V4pYrFI8KkWp6D1bpMFhTOsrSY5wFptA4eeSPn2K/IcKOfBCTDNeSSkwMipi
	CorRgN/ocjV93bcn8K5Cq5myj2TfNkTkMzV7Uzrw1QJfYESQaiDD7VdkxVlML6h6a2B3hoK3DMc
	5XFNmb1wyocLQt6AR7yNftC3SE+pyrzEyRDE1+BxyMUdQ68Bewv9LmgMujAhfL9mgVk4fNlFImm
	cHU+KTZMtnpbnsszNiliGdilZ5u3Q7HiTig/AbZ9avKGtsoK+arLd0g
X-Received: by 2002:a05:600c:81c8:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4a1d7616576mr221716865e9.29.1792511939046;
        Tue, 20 Oct 2026 08:58:59 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff02sm5627335e9.6.2026.10.20.08.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:58:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/3] bpf: add bpf_ksock_sendto() kfunc
Date: Tue, 20 Oct 2026 15:58:46 +0000
Message-ID: <20261020155848.75711-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020155848.75711-1-mahe.tardy@gmail.com>
References: <20261020155848.75711-1-mahe.tardy@gmail.com>
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

The motivation is to plumb more of the socket API into ksock, thus
supporting sendto() in addition to send() which makes a lot of sense in
the context of UDP sockets which are the only type currently supported.
This is useful when ksock is used to reply to specific addresses or send
to multiple addresses.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 27 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 48a2e2327ace..37168f43c16c 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -37,6 +37,49 @@ static void ksock_release_work_fn(struct work_struct *work)
 	kfree(ks);
 }

+static int bpf_ksock_addr_to_sockaddr(const union bpf_ksock_addr *addr,
+				      u32 addr_sz, struct sockaddr_storage *sa)
+{
+	if (!addr || addr_sz != sizeof(*addr))
+		return -EINVAL;
+
+	/* Kfunc memory arguments may be unaligned. */
+	memcpy(sa, addr, sizeof(*addr));
+
+	switch (sa->ss_family) {
+	case AF_INET:
+		return sizeof(struct sockaddr_in);
+	case AF_INET6:
+		return sizeof(struct sockaddr_in6);
+	default:
+		return -EAFNOSUPPORT;
+	}
+}
+
+static int ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data_sz,
+			const union bpf_ksock_addr *addr, u32 addr_sz)
+{
+	struct sockaddr_storage sa;
+	struct msghdr msg = {
+		.msg_flags = MSG_DONTWAIT,
+	};
+	struct kvec iov = {
+		.iov_base = (void *)data,
+		.iov_len = data_sz,
+	};
+	int addrlen;
+
+	if (addr) {
+		addrlen = bpf_ksock_addr_to_sockaddr(addr, addr_sz, &sa);
+		if (addrlen < 0)
+			return addrlen;
+		msg.msg_name = &sa;
+		msg.msg_namelen = addrlen;
+	}
+
+	return kernel_sendmsg(ks->sock, &msg, &iov, 1, data_sz);
+}
+
 __bpf_kfunc_start_defs();

 /**
@@ -155,22 +198,9 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
 	struct sockaddr_storage sa;
 	int addrlen;

-	if (!addr || addr__sz != sizeof(*addr))
-		return -EINVAL;
-
-	/* Kfunc memory arguments may be unaligned. */
-	memcpy(&sa, addr, sizeof(*addr));
-
-	switch (sa.ss_family) {
-	case AF_INET:
-		addrlen = sizeof(struct sockaddr_in);
-		break;
-	case AF_INET6:
-		addrlen = sizeof(struct sockaddr_in6);
-		break;
-	default:
-		return -EAFNOSUPPORT;
-	}
+	addrlen = bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
+	if (addrlen < 0)
+		return addrlen;

 	return connect_socket(ks->sock, &sa, addrlen, 0);
 }
@@ -225,18 +255,29 @@ CFI_NOSEAL(bpf_ksock_release_dtor);
 __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
 			       u32 data__sz)
 {
-	struct msghdr msg = {
-		.msg_flags = MSG_DONTWAIT,
-	};
-	struct kvec iov = {
-		.iov_base = (void *)data,
-		.iov_len = data__sz,
-	};
-	int ret;
-
-	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
+	return ksock_sendto(ks, data, data__sz, NULL, 0);
+}

-	return ret;
+/**
+ * bpf_ksock_sendto() - Send data through a BPF kernel socket to a remote address.
+ * @ks:		The BPF kernel socket context. Must be an acquired reference.
+ * @data:	Pointer to the data to send.
+ * @data__sz:	Size of the data to send.
+ * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or NULL to use
+ *		   the connected destination.
+ * @addr__sz:	Size of the address union, ignored when the address is NULL.
+ *
+ * Sends data to the specified address, or to the connected destination when
+ * the address is NULL, best-effort and nonblocking. This may sleep
+ * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
+ *
+ * Return: Number of bytes sent on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
+				 const union bpf_ksock_addr *addr__nullable,
+				 u32 addr__sz)
+{
+	return ksock_sendto(ks, data, data__sz, addr__nullable, addr__sz);
 }

 __bpf_kfunc_end_defs();
@@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_kfunc_btf_ids)

 #ifdef CONFIG_BPF_LSM
--
2.43.0

