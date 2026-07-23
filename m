Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B13379C28
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827297; cv=none; b=UilhvyiVe/1NKx2Du58Js2u9qlOyG9qHkXFYbvLTaUWCe5MnRNCsKkILp0fyXPH4N71vFvp4CJ4RPAFS7FPHPv6SG+yZ1iafnI+f+a27EDz2nqC9MpYJTXtvgLwAP0lcxsBTk8Tiy/PlhmmePkZ5gya/zewQI1aGWlcXj5JZTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827297; c=relaxed/simple;
	bh=k+4nMpcoQz97bn369q+zy/rYAZg95mHwCblqq+PQHkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDaa2RiDBzkNpmAjPno1ZN7PaZq5fa2tJ9BU22ae8GANiPLJkmBFNHzahxFnobjzZkbpzMkaCReJgFe8zay+RmdeAmTPDBz0T3JyKBivMa0f2ChVM6VuWb1d7QkW+uqcGKwoooZcNjgVOJ5KSjY2XwmXT3ZnSHEOmoZAhqmAWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRGWUqjO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRGWUqjO"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc61541f8cso8361735ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827296; x=1785432096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LJeMWpwJDiKmOBxcOAr9yxPeFdYnA9I6db3ePnFBGMA=;
        b=rRGWUqjOmrGLCpoMGsM3zNMBBWfSZdp14bwWWlfUdJPY/xFZAT8Ym7iF0WKOHhbTN1
         J0lSdOW2VrMsTOEkySNofGGq0SER2zvCV+pQzFMVPzly/2DTiwxJeQw1h2bMhk2gfLRa
         y6GsqTTzMCayiH8FQygrnUm/VsA2YLWyHsimsRpoePN9pXsRo0q07lvkwMPFR3SfuqXF
         CLin6A5LJYe+wOAeBEnpyo+9UhCr2v5LRdSe6F3ezNmb1tkgTrh4LlgJ2cMVb5gu41+w
         3k6zipgwgLoetKHsqSM1AV6IKEwmnODpsVYYVTqKTd9cZnY14Bm+gzPQyiNwsb/ta0gK
         BbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827296; x=1785432096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LJeMWpwJDiKmOBxcOAr9yxPeFdYnA9I6db3ePnFBGMA=;
        b=jBpdbqAiZNJnQHDEDmvXq+4b/M+XVqOsDl3AeFUvOZulCPwDMgJ/59f6zGnPVyPMZK
         mgVsxbxHzuCQUkUsp4BiBYJ+RB1G1UNgEiyoDPyuGJjKo75ocF/oclvCTDseh+V/5dRb
         2hnH4ZFKjG5/3fblNZ4BHfzozAHuos9Ey8Whrv8bN4mldeoMti/Vwk7FV+T7VPNKYTnX
         sk9r2RgpqocEwwcIrGpjcWvRvx0omFR7ynhw5MAINFjc8FHBcp6CUXytk5KGiVGmrmpE
         nmzSl0D18iqhl7AMrlmE3KXl1hyTBTXbZDE+0jK+2qpWjXzS0a7Nq2vegqH9TIQV/rW9
         aZYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYSvkd5uq+1LNXlH26SKMnV1ecV32h5ZeSxt7JKU5TrQA5Cjiz7+zj+RJCvK7seUWK1/sVzXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12yUClA9NQKg11k2O7OoTDNEGpT4YaALOyTftqgkQ3OwWvetc
	fQmVgB68TuxjGDymQU6/Z37xWzWRRnq6XM/8rrbqrHSuMV4ibouV3rNy
X-Gm-Gg: AR+sD11mdDjzOSSYKqU/39Dwa17vrjZ7bUrOAEw+TwwAnhAx/GriYPYi/Uyryou0unU
	rhpJPq/LoF/EYQ3yvY0pQMHe8O1PZSNz9zFxoeMVPDmtqjR0/f2kjiwMoRwX1QjT4l6gv2tXdlF
	PyhCT6bUFp/srOUdKnKnBR6nvKHdczAEOJ/OdlQV8CVFy8kPKZNl+T2I1mt+INCW2w8sONYaRtO
	sqXc3VZS7cZWdtqD/4Q3YHeIBMtEtX8cCxYdu52N4KUUZF9D//K4wukWINH9lR0HsjsvUI2sfEX
	8qGXoGnLr1PO9dX0pOEoO4XE9pH4SxS66f+fijt5lcdaAb7sBt1FmCiUyDfM1Ug/f9juJ4F7ZLc
	W8+BS3V3O/AJ5UzAW4L3nCcFUtnDrsFev7Br32XVeQ9ZybRI2VMPirS5OFj39ehKNgsbkzeCdBf
	uHTO9aT8/HYw3nzvlv4l4=
X-Received: by 2002:a17:902:c407:b0:2cb:402:70cc with SMTP id d9443c01a7336-2cfa95867b4mr41040635ad.28.1784827295640;
        Thu, 23 Jul 2026 10:21:35 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df09a9dsm20967373eec.19.2026.07.23.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:21:35 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	dtor@vmware.com,
	georgezhang@vmware.com,
	acking@vmware.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] vsock: clear stale sk_err before listen()
Date: Fri, 24 Jul 2026 01:21:14 +0800
Message-ID: <dfc66494f95ad847e58409a9fc4bcbb7b0d12766.1784649300.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784649300.git.zihanx@nebusec.ai>
References: <cover.1784649300.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

A failed loopback connect() can leave sk_err set on a reusable
AF_VSOCK socket. If userspace then calls listen() on the same socket,
the stale error remains attached to the listener. When a later child
reaches vsock_accept(), the accept path sees listener->sk_err,
rejects the child, and drops only the transient accept reference.

On virtio-based loopback this can leave the rejected child orphaned in
the vsock tables, so repeated iterations leak children and can
ultimately drive the guest into OOM.

Clear sk_err when a socket is transitioned into TCP_LISTEN so an
earlier failed connect() does not poison a new listening socket.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a06f708f3..3482ba594 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1729,6 +1729,10 @@ static int vsock_listen(struct socket *sock, int backlog)
 		goto out;
 	}
 
+	/* sk_err might have been set as a result of an earlier
+	 * (failed) connect attempt.
+	 */
+	sk->sk_err = 0;
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_state = TCP_LISTEN;
 
-- 
2.43.0
