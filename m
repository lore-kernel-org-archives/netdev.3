Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5B38F621
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328477; cv=none; b=U0tLuZw0nbosJsTjFN4kEzP8rMpqxh8ruFR+fpCoyna96WfNc8By02ADMgHowWQIlzOMVjhSXfM47XBYMVPtXYPpSVKXnWtKJMkUe1Nla2GQwbxWHRbYFEY8nYoqFlWl+4MhQneDYg/XrZvbiy0q4t6qI8gRz0Grg6t0/22BnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328477; c=relaxed/simple;
	bh=l1FYr/h4A8jxcp8GDzNRh39SKVx39p+AQr04pGB34Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dg4ebnXj3S/WME00naGOKqgMV0OqRrMGCPbfyKn6amfiOMhSvMSRdF6CnBTpF1juoxIBj7Ushu5VAzcXP7p5trZ19N4VqL2lzLPOCOA7OuRgEUQnRM6FPLLtpV2YfAg9UG/UYhM33NS+vGE2uaGK1G+kq9VOK67bXcoc2ZR3D/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K7xVq5wN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K7xVq5wN"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so3931621f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1784328467; x=1784933267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RhgJdWZQnROGQR34BVPV0MbCak+drB0v3np3QJuAdV0=;
        b=K7xVq5wNAriVVkf+e2Ri4ThUH8771nrkkU0du/jT0d6Y1VMqhKOWT/A3RmErqVB3Ps
         8k5UYa9irAkVmgV48rot16YQAGFTXnTX7oOT8xGhW1wQtI9mBuHXt9Lzj3Qj6w42uLiB
         JxZu+Qb5CANtE1asVpJn+XP2+5UiMjU4cTQqzBnCv46aoai6IlsIm/kv23e5jrqC45qX
         WK12RZoVo+7ovEzsprtFkHwI1rW4eAWqvQhJyaw9Z1fvQ1iN24sJGqwornY4omWogmE9
         oWZlflgrWtmdf+Q7zI1lDgRASnDOBemP2t5Hq6RzOqtZy11dAirx2nvZWx5QtkjRrUKk
         VRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784328467; x=1784933267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhgJdWZQnROGQR34BVPV0MbCak+drB0v3np3QJuAdV0=;
        b=FogzYHkohhvfAkbYyh4P78GjwbEe8Pbee7QjVswWHxc/n8UigUBaBbUSylmbXWOoh1
         XSmwzq1HbmpmgUB8PIVoDlfoeIKtkwfY6a+ouNRZ4CQakeCc3Aik+oKWhgj/2QLzfwzW
         mRZhDOlcLy2Baq+DPJ7B2VIDn9Hynp6+ek5Q3+ljGGwTptrTQY5WLcIvNUiNoqDnKI5z
         kFrHGlGmmC9gt38kbCMGYSCl/Ipwmi95vW1Ffe6l31JjQnPcMg+ZcRVLGMX+qmbFQFW7
         DWxEK5yMoBCDxVMR1X7yzPmV63hwR6sKpbZRGzcjhfR5CuTiHZ6yE9m3K+ddJgapbGv3
         xl5Q==
X-Gm-Message-State: AOJu0YxzHRoDiN3M4R73W4pBqYsbHxbeO1zDiWfI4I0Ll5XAA2o/EhOT
	rq2Dr/UuCcmXbX1sgkrneDGLGXyVut2r0SrXHtm4q2V61yYO/CzaWIU25xi+DXLDypstk/Dl/Kn
	/OOe9D3bXcGgf3LzK9S2pLaGa7/dj9aGbMdvj2+hlF2tR+A7zp9ICPupd9rU8aKizHEJ2eRif92
	HlbmM/3EdU9/juNKJq/iNhe/+1En2TAnAWWaT0KhdDe8iyFrA=
X-Gm-Gg: AfdE7cm/UcTLpQgQ61olr8ElDpDME1kqA/3p88g4Dli0RldRLxJ+0zE2HtmsVMBzW4t
	7/II+39cYDsKiCNTysce2vs6maNU2JTGOVqlDxwkVzQRRp4YQ0iqB7gRW8v4xKv/mgb2EnJA9ih
	ZLnNsC2wiktTm2WLh+XFb4FPnk8dLgxlHJPN5cEgyCy+ETtaE/o9y7DeHhjUJVn4qyUxWea31z8
	Z22ksXq0wd7gGihVP1jJRQR48+wahAVA4a+9l6hM0SkEQ4Eje1ynuOvf5bY75OwkxFr8BYhkD7U
	nxAf6tHpKH0pMtyzi9yVFSsmdoZyPk0gWMKi7mOgh7j0LFXdJUvvkdVlFCOMu//9aA3ki6/XTcQ
	YJ9NMgrLig0K4gCVBuX0By8C803t/cCEF9BD+MXmGVgaEvTQrjIQexVEKTijUIoD41gd2Hj9OnO
	iZYbR1C/lUGSgpQ1t2Z0lWKNjkG5t1p9O74ZTYgj+alTAXyfQDcPtgtVdANbP97+KCnGjXfpVBc
	Hd1psYilLdSCl7dPOqe9T8N+STDBtvxx3YvMwPuBUSUhErv/ZbniiOocJCL7lXrPXzYkwHA+qIw
	xX5bSsXA4MBqfHSF9QfZcOwq
X-Received: by 2002:a05:6000:4b19:b0:47f:28e2:d4c4 with SMTP id ffacd0b85a97d-47f623052e7mr5673214f8f.2.1784328466600;
        Fri, 17 Jul 2026 15:47:46 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63edd7d3sm6367135f8f.25.2026.07.17.15.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:47:45 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	nils.juenemann@gmail.com,
	borisp@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	shshitrit@nvidia.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH] net/mlx5e: ktls: guard RX resync against missing TLS context
Date: Fri, 17 Jul 2026 16:46:46 -0600
Message-Id: <20260717224646.2782929-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resync_update_sn() handles CQE_TLS_OFFLOAD_RESYNC by looking up the
socket with inet_lookup_established() / __inet6_lookup_established()
and then dereferencing tls_get_ctx(sk) on the assumption that the
returned socket owns the TLS context that produced the CQE.

That assumption is not guaranteed. The established lookup matches only
on the 5-tuple and does not filter on TLS ULP state, so it can return a
TCP_ESTABLISHED socket with no TLS context attached. In that case
tls_get_ctx(sk) is NULL and the RX resync path dereferences it.

In the observed crash, the returned socket was TCP_ESTABLISHED with both
icsk_ulp_ops and icsk_ulp_data NULL, i.e. a socket without a TLS ULP
attached at lookup time. This can happen if a stale resync CQE is
matched to a different socket for the same 5-tuple, or otherwise
resolves to a socket without a TLS context.

Fetch tls_get_ctx(sk) once after the TIME_WAIT check and bail out if it
is NULL, then pass the sampled tls_context down to the resync helpers.

Fixes: 0419d8c9d8f8 ("net/mlx5e: kTLS, Add kTLS RX resync support")
Link: https://lore.kernel.org/netdev/20260705104419.4014-1-nils.juenemann@gmail.com/
Reported-by: Nils Juenemann <nils.juenemann@gmail.com>
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../mellanox/mlx5/core/en_accel/ktls_rx.c       | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index bca45679e201..a1cab11a07dc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -471,12 +471,12 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 /* Runs in NAPI.
  * Function elevates the refcount, unless no work is queued.
  */
-static bool resync_queue_get_psv(struct sock *sk)
+static bool resync_queue_get_psv(struct tls_context *tls_ctx)
 {
 	struct mlx5e_ktls_offload_context_rx *priv_rx;
 	struct mlx5e_ktls_rx_resync_ctx *resync;
 
-	priv_rx = mlx5e_get_ktls_rx_priv_ctx(tls_get_ctx(sk));
+	priv_rx = mlx5e_get_ktls_rx_priv_ctx(tls_ctx);
 	if (unlikely(!priv_rx))
 		return false;
 
@@ -500,6 +500,7 @@ static void resync_update_sn(struct mlx5e_rq *rq, struct sk_buff *skb)
 	struct tls_offload_resync_async *resync_async;
 	struct net_device *netdev = rq->netdev;
 	struct net *net = dev_net(netdev);
+	struct tls_context *tls_ctx;
 	struct sock *sk = NULL;
 	unsigned int datalen;
 	struct iphdr *iph;
@@ -538,12 +539,20 @@ static void resync_update_sn(struct mlx5e_rq *rq, struct sk_buff *skb)
 	if (unlikely(sk->sk_state == TCP_TIME_WAIT))
 		goto unref;
 
-	if (unlikely(!resync_queue_get_psv(sk)))
+	/* Established lookup is tuple-based and may return a socket without
+	 * a TLS ULP attached. Sample the TLS context once and bail out if
+	 * none is present.
+	 */
+	tls_ctx = tls_get_ctx(sk);
+	if (unlikely(!tls_ctx))
+		goto unref;
+
+	if (unlikely(!resync_queue_get_psv(tls_ctx)))
 		goto unref;
 
 	seq = th->seq;
 	datalen = skb->len - depth;
-	resync_async = tls_offload_ctx_rx(tls_get_ctx(sk))->resync_async;
+	resync_async = tls_offload_ctx_rx(tls_ctx)->resync_async;
 	tls_offload_rx_resync_async_request_start(resync_async, seq, datalen);
 	rq->stats->tls_resync_req_start++;
 
-- 
2.25.1

