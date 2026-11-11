Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439774;
	b=1GP1akXLnXjpIivotT072WCvs5uyP18iFeP0G/zZQfch8IlLxVBFoVTcbdf63z4jSIov
	 9SOEs8d3PIdg9yCA3cPZjaG9rhHrcnxrRJKhQRitMrF6JBAzQqpjYwLyN5LfA9rGVWdWL
	 U1DYpckF2Y2t5nG47PNlxSNmQ/UIbrrooi05vOR7BFvaVEtKW07UMAudG4srglkIRsobk
	 +OHKM4TnslD90Zbj0X52M7ug6VvqWmZJu3VwiDdN2/tBOcdW/RsYEg1c7lKLm0W65z/9w
	 i8/sGNGdhtBmI16LvmP3vENYzJWZ1Ah3AyzcuHzckRrnGUAbIp95NXpHoN0/7zwCZ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SV61AWuFj+xJrSyTwfuNk6VD7evkiM7nc7+uIWbifTk=;
	b=Td2sbP/tNECkAtN/tkwV0AHEptGHpJCDXJ2fxcj5hEal2i9Wy6orNgnC/GB9Mr38KZKL
	 MHVt0+zIL4PQ9apUiya5mVbO3ZhwlULihH7W0/WVPyryK+EuOZufVGEHuFXVQbskhtPjj
	 y36ldZZ9vURAZipstdmEO/CuR/EkdK7KZ7U+TZcT2NvnWEB5YrrxH/JcsIS6EvFUwZFzh
	 CiZlK7PGnD1gRSV6xCm2oeYu8srsASBBuzV2y3xzEEwGiznHVgsFL/duFJlVr9drbOstf
	 G/Hhc1AtpdY6X7UHFrZYK7IDi7G541Ky0ersI/S69PUQX/VIwAxx4cq/iaQrMHP8sgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=PuP8UbO5;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C048606A32D
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C048606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=PuP8UbO5
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdab938dc83so1464492a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794439773; x=1795044573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SV61AWuFj+xJrSyTwfuNk6VD7evkiM7nc7+uIWbifTk=;
        b=PuP8UbO5odcYd+XvCfWfn0Zyym6q7Sbj+Fv8/Z8D5RTsM8yke+2Tlqwy9CikNlO/3O
         47vkx3BbKRqEBTEDmD2s9/VL1z6uQPj7Rz6MIBMW/uOw9YCgEln7VLvylYHi+Kyw6Y5X
         WsnWwpePds/F+ZA4E5ZhDJtSpBnF3fc1WUGxAq5yHGLGocGXUIsdgJZcc/5O4l21qtP7
         saCUsKPjHziQ8MG2oyP/EJ5tniTtTKGHc2bW712tOTywh6OqTy6mbjUu3yRVtLAMj+Iu
         YLVYDGFt6jJiQoscfog0+SPqMo+dw6MzPCXE71IbA+I1LkSG9fQU29ICZIcXw1sQxsBV
         QmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439773; x=1795044573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SV61AWuFj+xJrSyTwfuNk6VD7evkiM7nc7+uIWbifTk=;
        b=MzRU/HnF7QxX6LD4bmdSWri9jqyF14djnmZqrtHbyg0TdO4q5zEC1RF38DytslrhNI
         lvN4JwmyjInoywa2+SDj5vzLGSAJGQAUUXVXp2+i7nRKm96tVQwhtGQwS93Krm6299ec
         +8AkbRPSuKnFJMp3177q6QhrGZnOG+Rmm2qm2DjpoSTa8JtA3GNyWxF4Mox/hKLF3Kka
         /l5cxCvh3Sf6UFWFmEO98ofjQmfbNNfLUNDUhTV0VcFanuM6iJQnnN29YcJuYRINybFR
         J5H8gJhRi9Q2Nl+PJAAg5rKgRMk+nrDNgalfvrgZhCVor9UbsRmjS6BvwrnL9W3wGrGh
         akDg==
X-Gm-Message-State: APuU4Z9Mh5145i4UTBiz0VD35uFpUJ/Mx0h03RWWL/FEVbBfky7CJqSP
	U9xVdLKvavPIHxaMZwDjyyJNhIWnboc7lgaDVFKM41XjUk1AFAv5/b8eZIWShbAwdpS70F3EF3N
	QvP8FPQGTJ/Of+Sy9qp3YheYsrtp2yTXCAx0MLhWKbomZk3upGlYi
X-Gm-Gg: AYBFou2fNB1yu3YlXIGeyl+lLanZGE4ePXDXxJ7Gw+n8ROrStZLDSLuvy0m1y1cp7MH
	ggb0NwO59UdAHfe6ibpDm0CG70LVeSxHUDSSDufRIx3pX+0zbdZml7papDti6A7zaSJPBQXON7b
	T6Pt7mqCb5/GkW0uZs+brURpKyDERHt/CtqqRN1/BbsygkDtEdLrhLEQm5+KCXu6mmi+1lX5Aqz
	lWRIc94QEMJEIDix8KSUN75m+mRyuRLwwhrA2aKKXh7OUU49kewwamRhWWApcUH5ExX2hPjXrAo
	7fEIMWNbP8UQ+gYD++UhBtjKdR1AXPAlw3e08wHvNYbvoAsorTRa7rgWhSC3F3imKgtdYtZqhdg
	lMlAXE0xVlxSbL83b24o=
X-Received: by 2002:a17:90b:35cb:b0:3ab:b39f:41cd with SMTP id 98e67ed59e1d1-3b182fde4f4mr3706861a91.60.1794439773311;
        Wed, 11 Nov 2026 15:29:33 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197cca680sm597818a91.6.2026.11.11.15.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 15:29:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 8E29740357;
	Wed, 11 Nov 2026 16:29:32 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 87B58DC0876; Wed, 11 Nov 2026 16:29:32 -0700 (MST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	stable@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Boris Pismenny <borisp@mellanox.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 1/2] tls: restrict device-down TX fallback to hardware TX sockets
Date: Wed, 11 Nov 2026 16:29:28 -0700
Message-ID: <20261111232930.2532497-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

tls_device_down() installs the hardware TX fallback on RX-only and
software-TX sockets. The fallback expects a hardware context in
priv_ctx_tx, so an RX-only socket crashes on its next transmit:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  tls_sw_fallback+0x11b/0x450
  validate_xmit_skb.isra.0+0x14f/0x420
  __dev_queue_xmit+0x5e8/0xf30

Switch only tls_validate_xmit_skb() to tls_validate_xmit_skb_sw(), and use
the cmpxchg result to decide whether to delete driver TX state. Publish
the hardware validator before releasing device_offload_lock.

Driver deletion cannot rely on tx_conf or rx_conf: they are published
after setup releases the lock, so device-down can miss a completed
attachment and leak driver state. Track RX state with TLS_RX_DEV_CLOSED:
set it at context creation and after deletion, and clear it after a
successful driver add under device_offload_lock. This avoids deleting
absent RX state and reading configuration bitfields while their shared
byte is updated.

Found by code inspection. The reproduced RX-only crash is fixed: the
socket survives interface down/up and continues receiving TLS records.
Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Cc: stable@vger.kernel.org
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    |  8 ++++----
 net/tls/tls_device.c | 19 ++++++++++++-------
 net/tls/tls_main.c   |  1 +
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index e57bef58851e..915f39bddc83 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -187,10 +187,10 @@ enum tls_context_flags {
 	 * to be atomic.
 	 */
 	TLS_TX_SYNC_SCHED = 1,
-	/* tls_dev_del was called for the RX side, device state was released,
-	 * but tls_ctx->netdev might still be kept, because TX-side driver
-	 * resources might not be released yet. Used to prevent the second
-	 * tls_dev_del call in tls_device_down if it happens simultaneously.
+	/* No RX device state is installed. Set at context creation and after
+	 * RX tls_dev_del, cleared after a successful RX tls_dev_add. Prevents
+	 * deleting absent or already released RX state while ctx->netdev may
+	 * still be kept for TX.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
 };
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 4cdfbb57ecff..a42cbc89db2b 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1195,13 +1195,13 @@ int tls_set_device_offload(struct sock *sk)
 		goto release_lock;
 
 	tls_device_attach(ctx, sk, netdev);
-	up_read(&device_offload_lock);
 
 	/* following this assignment tls_is_skb_tx_device_offloaded
 	 * will return true and the context might be accessed
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
+	up_read(&device_offload_lock);
 	dev_put(netdev);
 
 	return 0;
@@ -1282,6 +1282,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto free_sw_resources;
 
 	tls_device_attach(ctx, sk, netdev);
+	clear_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
@@ -1314,12 +1315,11 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 
 	netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
 					TLS_OFFLOAD_CTX_DIR_RX);
+	set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
 
 	if (tls_ctx->tx_conf != TLS_HW) {
 		dev_put(netdev);
 		rcu_assign_pointer(tls_ctx->netdev, NULL);
-	} else {
-		set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
 	}
 out:
 	up_read(&device_offload_lock);
@@ -1350,10 +1350,14 @@ static int tls_device_down(struct net_device *netdev)
 	spin_unlock_irqrestore(&tls_device_lock, flags);
 
 	list_for_each_entry_safe(ctx, tmp, &list, list)	{
+		bool tx_hw;
+
 		/* Stop offloaded TX and switch to the fallback.
 		 * tls_is_skb_tx_device_offloaded will return false.
 		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+		tx_hw = cmpxchg(&ctx->sk->sk_validate_xmit_skb,
+				tls_validate_xmit_skb,
+				tls_validate_xmit_skb_sw) == tls_validate_xmit_skb;
 
 		/* Stop the RX and TX resync.
 		 * tls_dev_resync must not be called after tls_dev_del.
@@ -1370,13 +1374,14 @@ static int tls_device_down(struct net_device *netdev)
 		synchronize_net();
 
 		/* Release the offload context on the driver side. */
-		if (ctx->tx_conf == TLS_HW)
+		if (tx_hw)
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_TX);
-		if (ctx->rx_conf == TLS_HW &&
-		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		if (!test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_RX);
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+		}
 
 		dev_put(netdev);
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b8d5a843f761..9b06d0f035c5 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -935,6 +935,7 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 		return NULL;
 
 	mutex_init(&ctx->tx_lock);
+	set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
 	ctx->sk = sk;
 	/* Release semantic of rcu_assign_pointer() ensures that
-- 
2.50.1

