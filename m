Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9E318121
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144029; cv=none; b=a8WqMLq/YUsBIthPegOqEE11p9U+z8n8MBBQmbq5E6DrWmbtWycnRtL54AEEuyYMtCPf5FmJZlIlZCYNzJ9VpKRjKyRXQovm1b6pOFzSQaaY8bbI+4Ltk5oaX0+OMsaynZnxtHi32Rgf7sLG9DhmmelI/qXNAZZYt3qlPhXlGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144029; c=relaxed/simple;
	bh=pCv2uNV2MVL3fxbs5ZXcM2FwQJP2y6IJtwscrfbR71s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5aUTFP9IqI6uUywQos99uvAk/tUxk8+xYP8az+Df6DwdJDmUxJg1DzWDSebCcNAfkgguIF9RF/TEPQvI9jEDMV/a6o4pzpy7l8U2bd7FsbSZdFXKIKAHrN06GUDBpoQErQIys0XfnZs9xCqj+3PYheC1TtgnQTpDlZGlcaKeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI5FRJFk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI5FRJFk"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36b903567fdso7595033a91.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781144025; x=1781748825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFklSXz22wlzAbFptOPmN5E20uk8JdhKComw8Vj+xSs=;
        b=EI5FRJFkcrx31TR1Y0U1P3VqzVgZu8h/H+n5QGXVzkMPBCXgbCVxkxQX6DqYde4uue
         2kY+3e4bwmz8nXI8/MdD+xhRnz4vx5DPwHZnCbYRNQcFXBlSP7JR8HWn3nNZpKNBR4j3
         LXPCWtloTeXdB28MUnGKmdPOqzMZ+9CbCX3VnR6+oT+mmlTqse/NI+rtJ0dGXaBpqgIW
         gaRkz6LaHt8qEMF4t9W9GXWAGpvVqWhTxaZSIguuucNRuTOQKs1kvIVW6XwYIfEyHYEz
         ZbUMNNYU9fjS7ik4M2YfydnBDg4Vju0uwtjbXdmdJ0fgY89WFZ9SiAQT3aOYxCKVoE3B
         KhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781144025; x=1781748825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFklSXz22wlzAbFptOPmN5E20uk8JdhKComw8Vj+xSs=;
        b=in+ESKN2gCApZRRwRdfbsurpAXeqRys2jcWICRMYi9ld2xredak2NTtqWFLRLrb91i
         5dn1/eU4rHUokkdskII0dTk3FXa7Sd8Ovp13e5b8U9DMyd6Xd2PP2PvjYZiwKyTdLrCz
         4iiF6W8N4fFopV8IOAf4DwBZS0+yfnl2ltNas/embf2dfBpkhC7aYcIaU91vipTaJKi+
         Z/dUy+iLW8a0NygSfwkFY0BDRJanB/6D+sfRcYVqGGbPINRUQ86REQ3qn26YW+L6jplp
         99CKJ3ysUTJBzIylMgI+y7iOi+8FdLQgL9jW/mvo/Ckb4qPyFKPzcj8feOf4Fp4dk4Cq
         BJWg==
X-Gm-Message-State: AOJu0YxC1K/LLMTxYnysL2+D+E004xL7+F5fQ7Kv/tvLeGDXnugwpDrU
	iAvrMt/na0p+6TyCwOVzYMVqxO3ufc6JNHUhXis35JbG6wnMmBf+0TJFp+SWXiZsxQ==
X-Gm-Gg: Acq92OGa/9z8JYqD2WXpJOi++1TZA0ZVg17o8cq1n+fGgfmHNDWJoreKZjHCA7dRE3g
	VKXAXe+bpcIN3DVKl7oQhQx0boORl2HFJkqx0F33f7STw9W5KNMLtGrbdXN8MuIEcyWwoAyejgZ
	hQoyE2e5uzeYtPvlcyjuNDiS3jz9iehm+PGi05cNd4fHSkpun8fdzyPV58IfboAf3wDhNHht6FZ
	a/zNdR/DGJMVnoe1SY2LbKu+aa0zHbat/PuSGtEYF/0W38Wl9NdYVnHIipfFJAACztXSM4Nq0fk
	DsUHMvH1Hq5YXnneRWcyjxfiFw3+v4EIzW6s44XNgp2guiiJA+1wnJfzlbxBxEfEoLWKhS0hT5K
	AhV4HqmYcrvPh9txCjZFkk8yQs/+7wQwEDcweWXPcXXKHllfgxgYkwcclhsmXTZSTuHGzC7jGGr
	pTkv7iB0VZuXOb5T5B96GCTos/MTrrakIObDzNXn1nyEgX+lvNsxcEBtGmg+2s0gaiB8QnQ2HdA
	+srzQ==
X-Received: by 2002:a17:90b:2e07:b0:36b:a0fa:ff96 with SMTP id 98e67ed59e1d1-377a75cc34amr931123a91.12.1781144025387;
        Wed, 10 Jun 2026 19:13:45 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a0eb9sm732006a91.4.2026.06.10.19.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:13:45 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v2 2/2] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
Date: Thu, 11 Jun 2026 02:13:17 +0000
Message-ID: <20260611021317.69362-3-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611021317.69362-1-rafdog35@gmail.com>
References: <20260611021317.69362-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of vsock_remove_pending() must also call sk_acceptq_removed()
to keep sk_ack_backlog consistent. Move the call into
vsock_remove_pending() itself to make it automatic and prevent future
callers from forgetting it.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c       | 3 +--
 net/vmw_vsock/vmci_transport.c | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 73e6416ee9..b9772a0205 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -493,6 +493,7 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
 	list_del_init(&vpending->pending_links);
 	sock_put(listener);
 	sock_put(pending);
+	sk_acceptq_removed(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_pending);
 
@@ -761,8 +762,6 @@ static void vsock_pending_work(struct work_struct *work)
 
 	if (vsock_is_pending(sk)) {
 		vsock_remove_pending(listener, sk);
-
-		sk_acceptq_removed(listener);
 	} else if (!vsk->rejected) {
 		/* We are not on the pending list and accept() did not reject
 		 * us, so we must have been accepted by our user process.  We
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 91516488a7..a417403c8d 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -980,11 +980,8 @@ static int vmci_transport_recv_listen(struct sock *sk,
 			err = -EINVAL;
 		}
 
-		if (err < 0) {
+		if (err < 0)
 			vsock_remove_pending(sk, pending);
-			sk_acceptq_removed(sk);
-		}
-
 		release_sock(pending);
 		vmci_transport_release_pending(pending);
 
-- 
2.54.0

