Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342683;
	b=A5bymyalxPb/F7PjLOoCDSyc578KDyHjcqeuWevKJaXlCktLQEHMfODR3zMg1bRwWIMi
	 iP15ThEq1H9wOwTIQmEegPp9rv6dKQPusXCkvLhos36qcYh1hQTOdCZb8m2UU5Mnon9a1
	 1/ll70sQE6rkh0cKlR4dnBX/90iMbCdMq7INiRzYmJ5F3SealaCrMxZv1e/OkVgyfsIBY
	 u/ZxzmmFlNQ3gjd1ARiW+4RbAQvnz3mFQnrzvuYGPlhlnssxuG756iRhLTGe9WwRCG5l/
	 Q7D2RqFq8lDzR1BTTBIpdmb0dtN4jw+onL5B00WoFozbmjHrp6X42iSRFC4DVXyj89Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KVgic764o0iBpmXvPU3DCQnb57odNSKZ7p6xGDlXMlc=;
	b=oox/UxXy96ShK9SNk6OsiTO7Exjn+CgT5SEjfuoIgeLcwCYKV8TMvSz/LhBRV/RRD/LK
	 gyW8SFJKGFpy2FcySc+M+Iy/nA6ao0M97U3xt/XUdTQsuTRU8VWDCc/+geedF4ecbIuaV
	 P3MpCqP6hb6HhEZQ4+EvFCSx4ESWGYXtvvvO/5sww7LHlmU66I2x/E7OcRvw+zXmwfJgM
	 scddNcYZ5i/Y2XvH9y3MknC1pMafp6JwrhyFG/BsYBOhpiEYza3rotyviLVLfwJBSz/k7
	 AZ8T5uC1L8EBNfPbMOcYgwo9K0tpQQSHj9HuH/h//U9zQ7W/MBNHsp+dLdo6965m1CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aipXEA6J;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA2606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1FA2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aipXEA6J
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a9f9473029so220540b3a.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793342682; x=1793947482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVgic764o0iBpmXvPU3DCQnb57odNSKZ7p6xGDlXMlc=;
        b=aipXEA6JAApVHjDKmzVEGRXy9PdB/5s0w6omxzgzDN/CSCHQUtbciRfLoVEAx966Oh
         AGl2/2al8EFD0reNSEMGxdw6mwROiysRLy//jh9f1b1djY5j7BF3QqGyiOpY7eXKWkIx
         ShlJ+kxMLJgvviBWicaEvoVrZCLlYKCcIFGjih2xMgJlCtJUZUDg1yxZJMpfkQtW1f6w
         gzJxqesAoL59H8sfOv9o3jqnGOX6/Htk3Cm8zqCKTsIn9U0jBLdAh8db8IYaJTs/Raix
         hOZq3/zaMADwO+km6d2iDg5XAWmH9fhFTavj5mmRR8mbUNOQz1eHUI6dEprlw4Top0RH
         7Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793342682; x=1793947482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVgic764o0iBpmXvPU3DCQnb57odNSKZ7p6xGDlXMlc=;
        b=OQRRzBVC+1orjdQ/b/OEsXy/ASeNBQKgxgoH+IwjUAznaIuaFZ4kFmQWZuGlWyJecV
         yOTa+lou9Y93u5+mXoek2OvDZAy79btGrcMRuSW44EWk9IuxM4s+oq7sef+sGjSJuvIs
         BDPs+LED0bcUSTWVUk5wI/vNloJdFrnVaa7XrkDnxh8RhFShdcX5//QO09KS0Ibk+HvK
         CcHN66d10w5PWgidliHbnaPJOTpCgI4eCI3xxcYyz9LULmxx0d23MaSJy/Ars+xxIrAw
         DXBIcl/QM2sEmeyLGxBnjiOEX8Dl9eeE+BsplbtTrpTfbT0MNFQ25VsUlGgCY/ZKzc15
         sZrg==
X-Forwarded-Encrypted: i=1; AKwUvByTF9Y/p948AMSb+dBASFy2A9KIQq2SHm+AUy6fOfl7rZL99y2vHtvAMaLREQS3wszhad5ckIo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJq9MbIBP+88xrM3LL4A+NtSNWYxapHkgYBCmoYujRCaMQbERl
	1yKDfI4nKTDYhPtqAlGxCb3Y5G5A+/ypZ6y7uupQVFdVpzPt8lhCUmqs
X-Gm-Gg: AYBFou1M0sdLUBgWuA2yTEcmLmPsHt2Bnxr9pULL/uyLloNWXQKKa2FKoBvvheJF5B0
	nscOg0fbe/w4QGRj5t4AiaWAz8CrC/TLuGPEI60eeSVpJ8UOLq5PC57jOqTGumuj5D5/lrPz/sP
	NFU9uiDxbrNYzTYU7N3+DMlccIE97CeBMBvE/nj5YOmhVvLGO7D2tsuqm20z/NohUcW6Bcjr7JF
	rrAB/isocOhsJQijueS7pMxvBrv/Cpnm/CkRzXONi5UNGnXYQlFa0bn+fls1do+B/ao1eqHAeQR
	0dzTCwyEVcD9UgM6R7Z+KVCjSFOwxnMSGDOgBYwvCedYMV/byv3qD9QJDHXWwC3a1tcyON3ufgn
	M66IMuB0Vmi8+M3sMSAOSRbZpQXqhoFEelQLh8fOymCzoCD7JTguOFuFThLjQ0lwngtuZH1doR3
	Z6hfObHj6bbKAo4YMLKPKB9uIida3qQ2fm6vBDpBwsZSN4oKgzPMLa44QTOC7eNCMs2lZVA+KDl
	mg3/eFzVn603K0NM6prxwQARfnJbacYdz/eQUA+gdLCOfHvsm1DLVZj6QmYd+JJ0Rab4PBchMIR
	oODml4kHq2UM+2enToW6/HG5u/qeCrD9W917wrPsbQ==
X-Received: by 2002:a05:6a00:4612:b0:857:726d:2e96 with SMTP id d2e1a72fcca58-8a9bd1faff2mr1359294b3a.19.1793342682057;
        Thu, 29 Oct 2026 23:44:42 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8a9ef56b38dsm363397b3a.31.2026.10.29.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 23:44:41 -0700 (PDT)
From: phind.uet@gmail.com
To: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	George Zhang <georgezhang@vmware.com>,
	Andy King <acking@vmware.com>,
	Dmitry Torokhov <dtor@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vsock: reject negative tv_usec in SO_VM_SOCKETS_CONNECT_TIMEOUT
Date: Fri, 30 Oct 2026 14:43:50 +0800
Message-ID: <20261030064428.73930-1-phind.uet@gmail.com>
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

The timeval validation checks tv_usec < USEC_PER_SEC but not
tv_usec >= 0, so a negative tv_usec makes the timeout computation
wrap into a bogus value, later tripping "schedule_timeout: wrong
timeout value" instead of being rejected.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d0508887a2fb..1d7d53542724 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2156,7 +2156,8 @@ static int vsock_connectible_setsockopt(struct socket *sock,
 					     optname == SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD);
 		if (err)
 			break;
-		if (tv.tv_sec >= 0 && tv.tv_usec < USEC_PER_SEC &&
+		if (tv.tv_sec >= 0 && tv.tv_usec >= 0 &&
+		    tv.tv_usec < USEC_PER_SEC &&
 		    tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)) {
 			vsk->connect_timeout = tv.tv_sec * HZ +
 				DIV_ROUND_UP((unsigned long)tv.tv_usec, (USEC_PER_SEC / HZ));
-- 
2.43.0

