Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE242F6E3
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381858; cv=none; b=TfhSCjn27vzjRcYTP7qbYb6SkpYisbTl+PY5PKGOInkmHZg4+4qLp/0EsQlpwTn/RMMxzjx9sOsu7x1PxUPd1JfK3gymIbJvHRDoSQ8YOQ6PCnJOqWE0VYtGcBz7jOVTxVGnWtmwnbo0bepykzAlN/Mcxfg5Ul1IVcP5y3gxNME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381858; c=relaxed/simple;
	bh=P9yChhC5nEAPRJBgrn49F1A2elik1HxqQF0r8qN6qek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWr2lxBnuyDS9vz7AsWbQmMGq8/0gzbM/JJsncWTvUECIFqhFA+8HEVtrcTf3gJsHAtSkGbWTdE14LTnvsxTdTUt0/Yyre7IykhxCkvIHrz7rRVdHKaCNFVs8yenFKHVNElphGSviFgV2pRYUSRtYgiQ+KYVN0wVgRPKvZjlr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avd80ZSk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avd80ZSk"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1230958a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786381856; x=1786986656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhsqyhzE48bljLLTr+dFhyiqwriY9sOBMtlHTtICd3s=;
        b=Avd80ZSkOicBcGVtsD7BWjbpvUVp7NwN6QlSYiW6CREUAFYkKlqLm5aiiYUI7208fs
         Bf22+zgU+p/3MuzcRv8pHoTwF66dX1vaZPzP3EYe2fzRCB2CbLMW/jatm7LTgpPF6c1n
         B5TxyLckYSvXZZIGd3wOgsQRSXYbJ0xX+CWOFq0y0pgPzdWYDeV+DuFLqsbK/Oi8DwNN
         0gkUKU0s0+0aOKRKe9XIpf71w3Qoq4E1HFzGQYQ5yXTqKpDVsuWMQDdOX89glmxKzLx7
         zamE3SNtI0ITKIoNAEpG7jhUUq4yF5wgFi0uUgkaE7QDYbtd7+qgUgUzl0XN12g+0YaS
         ciQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381856; x=1786986656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhsqyhzE48bljLLTr+dFhyiqwriY9sOBMtlHTtICd3s=;
        b=PzvroFSvumjHVVpdFTVwlCpRxgl4Njgvjd2Piqdx1J9UX8ulK3yoCnLOPvDNfE56sX
         MFqL+IkQOW8wJLEA/UKZsKAOju004nuEcYBRoiPUwa2qdHSZbW21eFXeYvc6UlJOinDZ
         BPHTxbJWKcKMEVJAG4BlthIplOpjFOlOr9E+BHxOcneY+bTZ7wYtZTfU+AQz24KZE+zP
         R6F3QhIEdpxacfQIx1PD3RSCypJA9dyDzZF1RLNTxcuOEOphVBkaBRTNPQ5T7duFMERq
         ys8k9Z7LDRA5BLCI9+DRHhYt80Lo8YvZhtxJ/sL2YQEv7ccwHvNiVNxrGbpmMbznP4zV
         0+JQ==
X-Forwarded-Encrypted: i=1; AHgh+RplYIrScptcFXC+Casod6UVONTKrQA8sYprOhdHiT9VE5XGCe8vw8+uPwyG9RnhHaFEn0E1Bvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UWh6+zgXbVFmAvbqkaWs//FaXw96br7CikE/QnfeMtQpJqi1
	WkbisPcLo64T906GYiYHoTPsx8xFV934jiKgSmn4gt4zPfPzXBDJMjjZ
X-Gm-Gg: AR+sD13/eEzlGA6ruSkiKfFuZs/m2A3HmjtSoTW7nuRBvKPx6ICIuGSDEHlfnp02Nhd
	UXmMTIcBMgZrvu3hTGsaEuxmq9FlTJAE5PMLyZJLc7Z87y9wE3NkPARvpSDqSO43g0Dw7ZmsBan
	1mNFAOfnppCEGv5iO8Aa2QrVT7k78ZrYIWc4SPyWF3J0zXGjhw2aJtJPkiHCu3pXcDzC9JWLziW
	f3RQeEUQFxU3khQouiAac/ENf2izBS8Af3PsgPz10+alJrzL7bR+UruWNE2VHIP69PPBOLSrT4Y
	GNOZ/eJTSG3UvC+E6Iw0CEFaYcnAs25Wkv8t/vfEBe+zNYPE6dOGVtKA6+rgv+PTViCf4HjHMJa
	2c20HZj2D9O3hGrTwPZITnfxGEDJn29cX6fmLlH7R1PpeB3dRMRfWGTl/77dDXimhoxLXDdah9h
	ab6LyGcDC/XpB+hhdtA+BlKppxBl3uTDwXeJIgj9kdXH2mnxagtoAwFUSjieWUUg==
X-Received: by 2002:a05:6a20:7344:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3cbada660a2mr33795635637.8.1786381856114;
        Mon, 10 Aug 2026 10:10:56 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199cf49sm37194663c88.3.2026.08.10.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:10:55 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dmitry Torokhov <dtor@vmware.com>,
	Andy King <acking@vmware.com>,
	George Zhang <georgezhang@vmware.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] vsock: use sock_error() to consume sk_err after a failed connect
Date: Tue, 11 Aug 2026 01:09:32 +0800
Message-ID: <20260810170935.2242314-4-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810170935.2242314-1-phind.uet@gmail.com>
References: <20260810170935.2242314-1-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsock_connect() returns sk_err to userspace but does not clear it:
  if (sk->sk_err) {
            err = -sk->sk_err;

For a blocking connect() the error has already been delivered as
connect()'s return value, so leaving it set causes subsequent operations
like poll()/epoll() to keep reporting POLLERR even though the connect
failure was already delivered.

The error should be consumed once it has been returned to userspace.
Switch to sock_error(), which reads and clears sk_err atomically,
matching the behavior of other protocol implementations such as
__inet_stream_connect().

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Tested-by: Wupeng Ma <mawupeng1@huawei.com>
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index b59890bbd217..1a287719f24a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1842,12 +1842,10 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 	}
 
-	if (sk->sk_err) {
-		err = -sk->sk_err;
+	err = sock_error(sk);
+	if (err) {
 		sk->sk_state = TCP_CLOSE;
 		sock->state = SS_UNCONNECTED;
-	} else {
-		err = 0;
 	}
 
 out_wait:
-- 
2.53.0

