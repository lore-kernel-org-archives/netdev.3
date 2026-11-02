Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646883;
	b=y6S/xQFLjcgZP29SR1czYHrsWJcpOBf6pI/O3W5PqejsGA5EpaTjDi5BSYGq3coVA4oN
	 Xixu7H99xWL+cyLeRMUH0WdEYnyC+n7rj//PLHpwp2wOw1wfnFq/trKF9TUMYB+l637mk
	 R8LUTVtGhQtDTsVL2Hck6kzwImozdNJfQqSndDnXCGqUjJNfsM2sOHDqvG2inq0NIpHiY
	 4yMJNcabz4Z1PjgloOUcm9KLwv1aUQ3P4YYBGc894bktKPG21t0uIodAG46Mb8zUduwFc
	 tWMOA0bgeefY+NoBlx1OIMiS0TR5hmrjY6NE42F7cwNEBYR7xz/VH6NS7g7kMZ2bcMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZVsuCPHQOVUX+J0ERU9EzUWJOblLPkY73pQVUzYA+s4=;
	b=bngzjVPtClTxKk8lDziQ1A7MfMXuNupd1EapNTTcdQGQMd4mmjUpc9VLjP4n6Gyph3UX
	 Jlq9VzHeytgSZDALwL6iPbRGhh3DKoCsMUS2NZH0FsmYBJvqGBAVET1Bfwq7vuxJfVvg7
	 9OTv6MORvYJF42F4EnVQoxO+BFUu+kiVI09aUqKsPgs5nNpAN2Xj9RdNyhINgMBEuzgjz
	 U1XipE7go/Mrb2J7OJHjmVKI/ll1v6Q7q/0bj+6LandxNom+o4+ddWyJbrXNHPS7EVJ6F
	 9qW8tOtFyCVSCn/VP4adzKKtA7bN3YIhDRgW/35lKnnBkslw3V0j24R1bpTzASVHx2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IhiP8h5j;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D49606D81C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D49606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IhiP8h5j
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso3835843c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646883; x=1794251683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVsuCPHQOVUX+J0ERU9EzUWJOblLPkY73pQVUzYA+s4=;
        b=IhiP8h5jzlmVlab52upLzwlOFij5iekEIG/X+yYfMJG3DW1rdsi4zAbXqX2qE1NgLu
         JdBpIyjfMkSoEncClqlyb/NpnB0PAOc3LDyPl6zZQ6q0wbOlm1d+/CVNbScLvG1z6sxM
         i/HtGMFHaaYHwKydBo3RF8fpo0x9IWf/CCQt417191kH9vwvO4fL/HkwHY1G4fXwz505
         V/Pkctgjr+J6Fprs5cmLUlEdFgPYno+VvEoPo9SVJosTUo/rIBV0RTAPhAJjEeIoWzxB
         +K8n6+YCssxKAswNrAWo32Hkd8dEq5TMp2WfY7UsPeLV7QucuSk+d/u1UkcvMprBCBBC
         5p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646883; x=1794251683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZVsuCPHQOVUX+J0ERU9EzUWJOblLPkY73pQVUzYA+s4=;
        b=I50r+yrTZgU0yt30ymaUmOdw9ro+6HKPnIVFmtQ0RCzR/Qi+aiUJ960lPNBqKZXjfz
         /DbcC8kn21K5MWJx6XD0KvMfoCTRzaU2tfMsrd1eF7AimoQYpt3N1IjvvJnCEWssbldf
         L4WnkxLKblZRghZ5bZPIDnKHXZZV4zNKOA5EJV35A/FnI3x8OI5WNCXgnt/gMAQGQmLG
         On3amwRlE6rLTNJRj4dt8DsjUgO0TOzfDqK8YuKj/5Mb9sMd/lQc7c9sZ+wFVj7dirCH
         PFa7S/foqVej/u/9YRVdNYEkyBEPVrZFdbQtJWN6cGz/tCB1Ft8t5uOYSGU4jOrkzcJT
         /Vdg==
X-Gm-Message-State: AFq9FYL6sCR3DHzRwdOx7N3r4DYHrjBwgo3VONNsIwd7/UZL9KCpCmFr
	Bi2MPFQYO1jP4bVyu46VAW2lq9VK1wHiTNUfGuxudtdT6vpHmlBzO8bz9kK8dZzb
X-Gm-Gg: AYBFou0AcDDbN3/1q2XhEcJpM2woU3PPsGfPWZN/KcfYDS1e81MQflgs79wnUOJvYYZ
	MGzLuCukIxK7APAcx5TPHQKR9lNuDEBuBP/TBzmRlRkZoGrJwypDcNOAmg0n9aWKIamOx9TUy8X
	rHPTZ/6h8D7aizKrXfD9mfuz3vp1GzIoOG5kFLCUEK0cZLboiiuvdNHu6jry9xzcB6E2kPAki/l
	N0V1NFeNo0rfn4D8Y+RPZhGOdf4pOmekbJHaIN769o9HtQ3cbsKtQ4P9dbiLAU3qPOZtkguLAdM
	utB60QJ+LUUD4tjkAqWviAilcSmibgTbNWBB78Ix8Op9Li0pWH2EB3OtXegVW6KFe+0b+PktRad
	EK8CqL8bJoCitXTONCjVvJddIZWCSHLGjaSuF/7/wQZdShwnG4xZ4HSc6ch/QTMauwFi4d3ne7O
	KsFTfB2bfuuC14SADFeeh9VzpWzJaqGSBGREVdgJDHUZLRUyt+nTOAp9U5jCwhE5UB5634I6anv
	Gw3flPHGuiEurjW5WcFO86/yL9MZ+HUQ79M6c045RfePo2mDUqO3ZFFaNAivTRxYFOHIpyfna3o
	Dg8YzRqyAg3UQeNa6uZwXNo=
X-Received: by 2002:a05:7022:281:20b0:1ac:91b6:8dfd with SMTP id a92af1059eb24-1ade9e3e335mr15040908c88.31.1793646882743;
        Mon, 02 Nov 2026 11:14:42 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:67::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm36444456c88.12.2026.11.02.11.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:14:42 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 3/7] net: devmem: use niov_shift in net_devmem_get_niov_at()
Date: Mon,  2 Nov 2026 11:14:34 -0800
Message-ID: <20261102191438.1059771-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102191438.1059771-1-sdf@fomichev.me>
References: <20261102191438.1059771-1-sdf@fomichev.me>
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
---
 net/core/devmem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 32fafbfa1359..6339f221bc82 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -455,13 +455,15 @@ struct net_iov *
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

