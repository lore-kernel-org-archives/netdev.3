Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508857;
	b=aH91XCJ4D8y5gJnLQPyVVWdmWGe27jnl4wUTNdk42nSCDR58R+kpXruyMmujjsJZckxp
	 mrCdEHwtDp5qsGKkNexp3p6lcABavvCZurY8YwvMU4AG4rOgOQ61FsgvEGPT6eKtZ0/ao
	 eJy3VcKah+syuGw70rmHRKs6vm5KOgilCAUss4NvciCKlt7ypZew5F2rUcBBQOXSb+Vln
	 VkbY9AUh6HaEBc3Ss/HNl07NnydRGbRYpMgMpEqm/D1MQ3UOS2/DsIhy4ymUZzWkzb94D
	 Xes3q/qJLLHiXBurmXDYRBI9tjAyzkwxOebfQIWSm68HaBgbDqJrTJjP7iHGLryv4Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=/KS4MM+90L5b3yl4IF+KZ1cxg7psw7VcH7wSJwMesDk=;
	b=FdLHAAnHG3saypicvZYBXJ76jh2p0AfJvM0+HfeW9EagnOuDClLVvMhbJh0wd+zZWYH2
	 0k+Q8I7F8ifDdLkGLDym5qvMXYMjV4shoPKdK9lpuGtjioHwZ9eVt42Kd9GvXBrdnu0rE
	 gTTmJZdKKCxtK0w/QmL+8JNK1TCW5idR/u0ISuJRcVlDHjxKrRxJANtjelNabxgTapQ+5
	 RfmRT/ws6houOgK6EfFQsSO6ppDBhU0FJYAx7tnCM9SftLrZeAgzdQKhvn32rNH2J8We+
	 de90NxPhYuRrm83UcmkoxVIfhb5X84g/3N9frqSKMcaMDoNyhLGvJjEmKsB2uyU4hsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XAYwuqzw;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADD606A332
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FADD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XAYwuqzw
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so19123885ad.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508856; x=1793113656; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/KS4MM+90L5b3yl4IF+KZ1cxg7psw7VcH7wSJwMesDk=;
        b=XAYwuqzwhJRHpb2wnmdJp/kFWyjyM2aoEz/hOGR7L3NfVt16xhjPpYJEnLFu6o/qXp
         /HR/kZvZrsSyqK9A1aL1myqjLZke7z8qdD0zD7HKDG5bUACqMt4aZ0amTHQyCkudsFJg
         +8uUbiJ6eqsbcAnUnui1GemFN+ePuwd/W6jC/Kqis6JSpLzBJ8J38up3A+ahvIRsyJXp
         ANXBlAFWhBMEkW3+ptu9TiGfHzzo102/rb4tu2XxZrpacpMI8ne+ur7pz6y80Y7Oa3nY
         NSCzghm/U+Njwx8RTqV5yGBuGT0SfSxcls8JGl+C3WtSufm0KUwa8IdhFDiq8RntfBki
         FF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508856; x=1793113656;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/KS4MM+90L5b3yl4IF+KZ1cxg7psw7VcH7wSJwMesDk=;
        b=xVuYWmv6ya7bocoFpyO+zwra829zMAooZBngbg6RABBwIEW6Jupe8vO+8nFdHY0FDK
         HYz032zTDZvg8cBDqAjnPi9rlz7TtanMZoomGQNQ9ykMBjs0O5pR8FjJ+jA32NH+yfnj
         tBfSm7ky4Ju0LkrKOcJ4VhbMnyxI1s31JrzOvmJzUXFIekyWm/uQmLCTKFWNZtPMhr8o
         9W/ubEJWn1qJTHPzTmAYC2f3CRqo9EexJ8fSnKPPwCdSsIZ/sN4ckaTC1VtzO8GwQkuB
         F/mqgTYdhHPcHP47R1MDwAKhKGHeH5ncM1kxTxVeLM3hrnW2E+SdhZkIcYpRD8X1RDQk
         GpvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZWxa0jiGAB+z1NzkoUaskrE3GnDpHqiRvA4au9D4mXgLpn5/gOE2Y5ThlOQM4j8bEKzpqxUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKB8gwkztk8XLeT4fm/NWtjKPO5lr2Yhrjx9Cu+Z3wDGbgIBU2v
	Aj4+pE/1Kg35LJsDRJ4jxBfOdEJCUTrlGKPfyi7L9AMRUslUPl9zkaoi
X-Gm-Gg: AYBFou33f+9qMTAaGVvt9/IT5zN/1sMd/tAgvaCBdPE8yGDYpKPgauQCY0adjvNuFft
	SgdZ0wBC2v8kbGYRGFj5mgpxalH6Juaffaxb8j/oG/HMsuC8WJlnc8d8f+LWOUQyR9VluYA2nQ/
	FMbMRaqtOeVJIguJQZkTcj5logxL/49CHOLMKBmHFM6GFR17UfVJmyC4rd8Mi+4VPr9Dg90EjQD
	wqft3oel1nzQap6mH97Uyk5x2cw9OxE3JrwNvPDLnKjW5RkCbKLdPJcAxmLJNZLoHAAOW5P7+EG
	OynlpLR/uhJnG9ZqCJRRCltpR4dOzqw2KXZAsgqparj68DU4S2BdOaTz+jEeVrOY78seDApn7GI
	k+I5OpiISV5V+yO9eBt+O7QAfurxHkuXSNPNzrBWwwarMUDhuPpC+eka77u5vMoIh7yx2Vcl1jV
	vMGTTH1Hgas+GyuvSpKzGtyxvOlYLMJCItmMyLVkmasHEAaomp/9Y2W92KAS3bVBErioWvnxItg
	xDMZiVKqukAknO+oL1bMM5W/aJOXgwh0VnSzK/f2Oj6lMQfdCWGRU/ozSONX9LuGOP8+HB2ifj3
	s8w=
X-Received: by 2002:a17:903:2c47:b0:2e9:9c65:1af9 with SMTP id d9443c01a7336-2e9a6d41d0dmr98863285ad.53.1792508855484;
        Tue, 20 Oct 2026 08:07:35 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ae277sm277345ad.76.2026.10.20.08.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:07:32 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 15:07:31 +0000
Message-Id: <DM9RCU3BDWEG.1C32ZIVU95S76@gmail.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <willemb@google.com>, <eddyz87@gmail.com>, <edumazet@google.com>,
 <john.fastabend@gmail.com>, <kuba@kernel.org>, <horms@kernel.org>,
 <liamwisehart@meta.com>, <martin.lau@linux.dev>, <pabeni@redhat.com>,
 <song@kernel.org>, <netdev@vger.kernel.org>, <sdf.kernel@gmail.com>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <kuniyu@google.com>,
 <memxor@gmail.com>, <emil@etsalapatis.com>, <almagui@kernel.org>
Subject: Re: [PATCH bpf-next 0/8] bpf: Expand ksock send-path support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261020102512.518479-1-mahe.tardy@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 03:25 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> * allow bpf_ksock_connect() to be called in the send path
> * add bpf_ksock_sendto() kfunc to complement to bpf_ksock_send()
>
> This is useful when using ksock to reply to differents peers while
> reusing the same UDP socket and generally works toward the goal of ksock
> to support the basic socket operations.

can we drop connect from LSM progs and patches 1-5 altogether ?
bpf_ksock_sendto() alone replies to different peers on one socket.

connect + send from LSM progs can't do that reliably. The socket is
shared through the kptr and sleepable progs run concurrently. Between
bpf_ksock_connect(A) and bpf_ksock_send() on one CPU, another CPU does
bpf_ksock_connect(B) and the datagram for A goes to B.

Without connect there, acquire/release in socket_sendmsg has no user:
nothing can be done with that reference. bpf_ksock_sendto() is in
ksock_kfunc_btf_ids, so the current filter rejects it in socket_sendmsg
already. Then no need for bpf_ksock_send_id, bpf_ksock_sendto_id,
bpf_ksock_connect_id, bpf_lsm_socket_connect_id and the cycle comment.

Selftests are left out below. Patch 8 stays as is, patch 7 stays
without the socket_connect hunk.

Something like this (compile tested only):

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 48a2e23..48757dc 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -37,6 +37,25 @@ static void ksock_release_work_fn(struct work_struct *work)
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
 __bpf_kfunc_start_defs();

 /**
@@ -155,22 +174,9 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
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
@@ -212,19 +218,25 @@ __bpf_kfunc void bpf_ksock_release_dtor(void *ks)
 CFI_NOSEAL(bpf_ksock_release_dtor);

 /**
- * bpf_ksock_send() - Send data through a BPF kernel socket.
+ * bpf_ksock_sendto() - Send data through a BPF kernel socket to a remote address.
  * @ks:		The BPF kernel socket context. Must be an acquired reference.
  * @data:	Pointer to the data to send.
  * @data__sz:	Size of the data to send.
+ * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or NULL to use
+ *		   the connected destination.
+ * @addr__sz:	Size of the address union, ignored when the address is NULL.
  *
- * Sends data on a connected socket, best-effort and nonblocking. This may sleep
+ * Sends data to the specified address, or to the connected destination when
+ * the address is NULL, best-effort and nonblocking. This may sleep
  * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
  *
  * Return: Number of bytes sent on success, negative errno on error.
  */
-__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
-			       u32 data__sz)
+__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
+				 const union bpf_ksock_addr *addr__nullable,
+				 u32 addr__sz)
 {
+	struct sockaddr_storage sa;
 	struct msghdr msg = {
 		.msg_flags = MSG_DONTWAIT,
 	};
@@ -232,11 +244,34 @@ __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
 		.iov_base = (void *)data,
 		.iov_len = data__sz,
 	};
-	int ret;
+	int addrlen;

-	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
+	if (addr__nullable) {
+		addrlen = bpf_ksock_addr_to_sockaddr(addr__nullable, addr__sz, &sa);
+		if (addrlen < 0)
+			return addrlen;
+		msg.msg_name = &sa;
+		msg.msg_namelen = addrlen;
+	}

-	return ret;
+	return kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
+}
+
+/**
+ * bpf_ksock_send() - Send data through a BPF kernel socket.
+ * @ks:		The BPF kernel socket context. Must be an acquired reference.
+ * @data:	Pointer to the data to send.
+ * @data__sz:	Size of the data to send.
+ *
+ * Sends data on a connected socket, best-effort and nonblocking. This may sleep
+ * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
+ *
+ * Return: Number of bytes sent on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
+			       u32 data__sz)
+{
+	return bpf_ksock_sendto(ks, data, data__sz, NULL, 0);
 }

 __bpf_kfunc_end_defs();
@@ -255,6 +290,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_kfunc_btf_ids)

 #ifdef CONFIG_BPF_LSM

pw-bot: cr
