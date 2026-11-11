Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437267;
	b=1LSJ11I7WzC/Z9WFqRXNenNFGsuTKq3tE2J+4xbtZsprkVkLko3xABPV/bIBsYtzWix+
	 lpodO3SYnTmVfTHwXFk8grgGT3if/JRewkGxmINgKE+etQ+mMUYamwKpnCQ70i/b1fuMi
	 lx1MvaYKMbb2JVMLHyVxV3tsVdTKmRphLZA5GcVWeSwBtWRzFvDfBd53OlovbEa40c/eQ
	 JQJ6IyO8OEohGBbwYdAeiTfZms4xIs9HJ8QMSwTxDBYVBJSITKhouppd6wUZOtMTYJ84g
	 FlQDm2FXPg4erjjf1tTvmdTEXg59U7pZPi1xh27SMMfnk+MBzjU6Q0fqCrBLjmiSbRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tp4FwDBE4d49Hi9WrTjNIMNYb2nVWF+rLrH6T68Pxk4=;
	b=YyrjXk49LoCRPHsU7rvjXRuT1ZLYzkqPLEBthWc/j9LNt1Yccsfo7C2dQ1jghjrb8D12
	 /ilTHVIbrailzUS6fiNwAPZ4iZliLlCmi5qwMphKEfyW4PVunni8S5uJPMCSe7SCAkvB5
	 e9hrmAaefOFN7lc7AwL4QukZtC2NAmq62B/IesvQOgppfSp3VxBO9NHzzruGCb50S3AED
	 kEda+nV6nOwrXSk4EMBX6fuxF6HfitP8rlGIsYzUk8R2ghmj2VXu3H7xsi+aq8BGJ1Jxo
	 Xudwzu5wF/UhDpGRHT5gN50MS3otWX7c3pdDtuSylQK2taKyMWS3cYFW5WqnIELgCDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LLuo6V/7";
	arc=none smtp.remote-ip=74.125.229.131
Received: from mail-dl2-f3.google.com (mail-dl2-f3.google.com [74.125.229.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EACB606E2AA
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EACB606E2AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LLuo6V/7
Received: by mail-dl2-f3.google.com with SMTP id a92af1059eb24-1afb6473195so706587c88.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437266; x=1795042066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tp4FwDBE4d49Hi9WrTjNIMNYb2nVWF+rLrH6T68Pxk4=;
        b=LLuo6V/7kIsfNKiTCG734leNRhC9dyI/J8vOcEIJ7nHklg/FevWrQTnrhiRgp0MDf4
         ljL2KVoCzseQ2GNnAwyATO9XCS4ckFDZ0RbEx6EwB4IWqje5bupXLy1wqgqrYhCyz/Kr
         kg1K35thVoKr6zz0wLAzm0MA0hTwUGGICCp1EBVVZhvmNbD8gkt1yTckU3hCP9O6GiLE
         6P0IfwW/i6lEmzLVUTNYvfnqFMSvzMEUKGqa0qIVQQgZJCNjA4xwVkoznQyjVYzcpfBx
         ocjjzHxI3A2PkgiLRQ3K73ZT/cJVVeaAsrgfw3DCP/+xNXD22ctrZYrh5wLNPJZtq7Yr
         Hbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437266; x=1795042066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tp4FwDBE4d49Hi9WrTjNIMNYb2nVWF+rLrH6T68Pxk4=;
        b=kIBIG2BIBNYwMUAfmq+cGnLZgj8sCtJPsO7UDtqbv+QQ8uyKK2NmhBY0jY63vgbyME
         uW0e/dFSfYdBqxPNlIF7QPxMxC1j7uYMt3DJWWg9kfp/YkFQnqVLpJvEvlWRSStmya9X
         s+rm5stfz6audOoAp5Q+ZCxhDiX3fjMGnx8+bX52XyLkTncp8esAMKjxrPFIIiUHAQt1
         YCQ0ae9gbwP1P7jEh8+vxc5JloEpn6J/JK+bpmkjIPp0TJUBkB7sGVs3QNfM8d2fI1SB
         LufZfsmFd0eogDevU1dLeDfaNWpAfAPUzna+M4s6MUkAcQQnv3bAeXZxLA5zw4L20OCq
         w7Dg==
X-Gm-Message-State: APuU4Z/Palsu76usldKwjgGMj+3bDjB57FS6cA8UUFZ1UG4WACDzt3M/
	t8+hX61Z6rVzuiV0ESyKg/whin5g9rXzsEjt2oz7AfyNxzK7j85R8hiILsReoKoViq0=
X-Gm-Gg: AYBFou3ZIqcx/LQPsVrvngcid6cctIEaaY3Y3xXQvO0ofdjUEShSbhL4b7t5bQbFysH
	04UG5qAMrkR4alEroeO/GWotxWWU4nbH79ZcZ6b+e089kYsWJY+3cccK3G+6i4iRMwELT0SVzAr
	Hm50NOHRzXPUrqwdbIOrfCgBkAhdKIM9ItHW42W9qcVmL2Z1V4hMJRiFbee9O1yRJEi7OKfvpGw
	Y0Yfu6U6Fx8r9Ck+9gx1wPSVRBxTxJ/vnaAJDHHQ4h7sR3Hw8cOSgflDqClVNGnUcu+Vr21i3P8
	xdfTHu3frEFPfPwtOE7Sx9uyp0Kie/5GfLRy1hkzWrf0n+zE9fPaZauoe5tqS11jnx8f3IviMBT
	LHWd2LWLqpFjuvRc/Dq3HnGJxqGVqFHy3uLmAGzv7E3Ltrc9Mh4BA7Z7dn2SZC+T2HeqtCK/Uun
	eIMBVrF7bF/ZQLDcijSYpuKEh3qm7z87hqNecvD6YjAsnL0z5n44f9GATvpAh52eyzQsDEycAY2
	uNyYyS2DPLp6Y3W71xySwpyC9QyyFvbGQmwddpFJqtSpnLHDPBSaTF2WWiDPqyjEC52tsGkAcRc
	eRDu6RUkwU9m7yTMAc4ObT0=
X-Received: by 2002:a05:701b:2610:b0:199:e38c:29a0 with SMTP id a92af1059eb24-1b3c03390c1mr3026458c88.31.1794437265699;
        Wed, 11 Nov 2026 14:47:45 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:61::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890e04sm19170807c88.2.2026.11.11.14.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:47:45 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	leitao@debian.org,
	dtatulea@nvidia.com,
	asml.silence@gmail.com,
	bobbyeshleman@meta.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 3/5] net: devmem: use niov_shift in net_devmem_get_niov_at()
Date: Wed, 11 Nov 2026 14:47:38 -0800
Message-ID: <20261111224740.2744522-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111224740.2744522-1-sdf@fomichev.me>
References: <20261111224740.2744522-1-sdf@fomichev.me>
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

TX bindings use PAGE_SIZE net_iovs, and the TX lookup hard-codes it.
Derive the index and offset from binding->niov_shift instead, so TX
bindings can use larger net_iovs. No functional change, TX bindings are
still created with PAGE_SHIFT.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/devmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 5c7d9640e9d1..c6868f39261a 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -581,13 +581,15 @@ struct net_iov *
 net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
 		       size_t virt_addr, size_t *off, size_t *size)
 {
+	size_t niov_size = 1UL << binding->niov_shift;
+
 	if (virt_addr >= binding->dmabuf->size)
 		return NULL;
 
-	*off = virt_addr % PAGE_SIZE;
-	*size = PAGE_SIZE - *off;
+	*off = virt_addr & (niov_size - 1);
+	*size = niov_size - *off;
 
-	return binding->tx_vec[virt_addr / PAGE_SIZE];
+	return binding->tx_vec[virt_addr >> binding->niov_shift];
 }
 
 /*** "Dmabuf devmem memory provider" ***/
-- 
2.53.0-Meta

