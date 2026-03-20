Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211173E557A
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030254; cv=none; b=ZCk/a1QqVu4vSXnAjMGCQ+8n2lvdFiHJIqup9aHxXZM6eHW/W6frjLAQnVJNFUiFT7aHNj2BxmzobQJ4VMRBmkYQD9AsPoumHbOcE5m7oS0F06Au6mvwR5V8DrGh8DVDfvla5pqR0PMA/oxYYT0KI6gRxe1jtIce2KmBu+tXziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030254; c=relaxed/simple;
	bh=Bj04iTXB7MhKSrOnlUvWs1/LZRy/U40aj1lrebnr4kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NqfPGU1+oyW3yN30ELg0TM0R0D6b3dPawfhThAEC9Ot1eLAX4AtX0YaKTqi7jDvR/Y3DQtz1670/OJi6drMh9aH86ipUid+mT1BISKVm2DWPXrcLNIdrAnTmKq09zbHWgbohcOaFDXuDmd61Yuj7ZQ+O+LFdugU82pjHvLlUQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+U8BTzn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+U8BTzn"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35bb863824fso1175678a91.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030249; x=1774635049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOf9LcnO5IRemgfOLwtBwbNVtgVrreL+MONpjgDCJOc=;
        b=G+U8BTznQj2zP7rwDb2gB9WqQIms2m7rgquampiYFjtqLH3W5k+3dIZOj/7NAFixB3
         mEeemIzxNHekLWvUShp+d43c9WaeJ9LxqkNvJ9F+HNNcRuivU5FuOsycKxcOw7nqWvNn
         9ZPnysO0LZVXLHs9mJfShvuy/2d7SsOqN7TyDykgJ2Kl5PtwXN6IHdiQM0irHqtn0wKV
         DkIMZG+/u55QESIEKw6pcaWGhRDLov9ja5fA9anE7kpRfEJIaATFQdIhgabSlvBYZ6ji
         LIcoZ1KYNY8w6g+eWs93StY7UOaP6z/R/h3/7XCclD949fQLplfQz5Jge/3ei8WzNcb0
         /0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030249; x=1774635049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOf9LcnO5IRemgfOLwtBwbNVtgVrreL+MONpjgDCJOc=;
        b=UZ9GTqM51+dhWIraPBDpvSCyVSgkriSxcb5ejYHMFSrszh/VARuJsCt1/VQxaPn3Q5
         ClE2PDwUH1KqVhdnAJ/eI6Yqr2qgCOMNYFo06DC5kqq8crC86ouC8ctnbNQxvaTIuOIK
         rro8QKV724uXxmY7N4HLdkXplTKc601YHJmsxde7Mjf9HC2NtuiljoiEGKrJd52n+dmy
         hHCf3q6DvU2W2/ii7OPAeqMMnGwV/hQQ+wadOTNyuKEJRIY/Mo3laCDFPUIUaKzgFa44
         2rE9Ciy85HdJyjWGMN0MKa6L8cWB6nECuopXXg652P3GZ6NUsjjea+jR3wBAq/XHrAOR
         D5sw==
X-Gm-Message-State: AOJu0Yyk/cI1DThvaUWAwNoGvkQ8WmheAX8ElZIih3hyn7jSuyq7VYRm
	uim6Tyzx5+V1uBCJPiM3dzkGvzkKvR2uUcVSuC+TAo3+Fr85hkD39uJs
X-Gm-Gg: ATEYQzzbHsGaGwinnWngVC2L0pa7IbNjlKOi+L3BGJ5e3A72/bmIYDY/EBBnt9CniAG
	pWzQz8C9NDxwVS+68BnDiJP5hT3DYV2G/nrWwcHTsOdV3yYxKCcyhRNtirZnK3f0GLtXr6RdDwN
	DDn1Hgu90vTF9FeIX/GaW0Jnsw0Sr2KbqgKCl0z8hfTCeYiztrYanVTwHloPScEK4Inl9EMpppx
	gu+eDE0Q5eITFYFfG/5saJZp6fsVCJ1Tqq0a/wlmNYmmOUWb0PEvfN6HbRJJz3KR2EviX0ezQB5
	mlDrI+gQRahRcH1N6W9dLTfjhG+I0hgGIX3Tm6ki1H9rJeLrpm9ZsoYRlkSGuZSbZeQ0evHU/3t
	naaE7niKurFG5o41L1N0hs/YqvOrhgThCIicjIYFEk4NXaqTsocOWYdTNm4OwFRTz1k53WUIbgE
	kGtdEdM4EggHD534lubNMqtHOYPFImZNLA7MgfU0knxYdJ7J6C/5AE5JF0Wb2DGMLexGEAdRI=
X-Received: by 2002:a17:90b:3f88:b0:35b:a44f:b8a with SMTP id 98e67ed59e1d1-35bd2ba3293mr3032450a91.6.1774030249148;
        Fri, 20 Mar 2026 11:10:49 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd368837bsm959352a91.11.2026.03.20.11.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:10:48 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v4 3/5] svcrdma: remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
Date: Sat, 21 Mar 2026 02:09:53 +0800
Message-Id: <20260320180955.150696-4-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320180955.150696-1-seanwascoding@gmail.com>
References: <20260320180955.150696-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards in
svc_rdma_accept(). Since dprintk() already evaluates to a no-op
(via no_printk) when debugging is disabled, these explicit guards
are unnecessary.

Verification with .lst files under -O2 confirms that the compiler
successfully performs "dead code elimination". Even when variables
(like 'sap' in this case) are declared outside of #ifdef, they are
completely optimized out (no stack allocation, no symbol references
in the final executable) as they are only referenced within dprintk().

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 +++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f2d72181a6fe..0759444bda50 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -413,6 +413,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	struct rpcrdma_connect_private pmsg;
 	struct ib_qp_init_attr qp_attr;
 	struct ib_device *dev;
+	struct sockaddr *sap;
 	int ret = 0;
 
 	listen_rdma = container_of(xprt, struct svcxprt_rdma, sc_xprt);
@@ -559,20 +560,16 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		goto errout;
 	}
 
-	if (IS_ENABLED(CONFIG_SUNRPC_DEBUG)) {
-		struct sockaddr *sap;
-
-		dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
-		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
-		dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
-		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
-		dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
-		dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
-		dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
-		dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
-		dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
-		dprintk("    ord             : %d\n", conn_param.initiator_depth);
-	}
+	dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
+	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
+	dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
+	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
+	dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
+	dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
+	dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
+	dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
+	dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
+	dprintk("    ord             : %d\n", conn_param.initiator_depth);
 
 	return &newxprt->sc_xprt;
 
-- 
2.34.1

