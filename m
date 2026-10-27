Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065932;
	b=PSOvIHh4YEjGiKeGxCRWusb49kUKYEoFOgQ0S7WX0362iM+Y6kcWD0W/P/2fo2gNKiwY
	 XzUMsXvKp22tH09Te8UQ2vg6fePDPqekbyjx17sXOPe+GHdjVQxbAPpYy6UwqQS7PMO7m
	 R89zsW77kfA/q6MpOx6xb4v8EDpUZ8RgdUzpeKjmoOiUkOVuGdlFglYhUA54Zloma8uzE
	 UZpVgKLYJsIG0MfR/YJaDp1XmEwhGPoh3wys88Rdy+vNXJI2TDdMj/UQO/wbOjL2Z8JhC
	 ruM1VO+yLAApZ5/hkxyldevTnI/MZACK981n+P6Y4n3q0hqZQuMSNa741z7Kytrbzww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Dmw+4NxcC4V2T43bzcaT/Js2XAXbRw0OaytvY2/dX+M=;
	b=ewVII6WTUogy24DeQtF470ym4Gs7xmHUnGH49hGFFm1XW/qpfnG5WO06gearGtdqXPQN
	 6GCGl5hX076e3wjMEDUaYwZzCM2Ql45ym94fGa/teLNFfenNEY1tnhYh/+rj6qWH/6Wi7
	 opoR8EEyYELCYct2X4V9chtFLVvlX02TLarPJ1vT4jsleGmmq6zLUrWj5xcwI0W6HhN85
	 ss0Q5jbN2wPu49ficaTCzEexrkr4zi9tkccn3I+1Y4fKoFAq2J7DTH0jgvtRXWTAZnJkX
	 XxPyPkJAWv7oxU1SMXqShw6JmNKGS5VffnqaqGmrojqqvFWEZDaph48DdD+vpcM72PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=G6JO7Vam;
	arc=none smtp.remote-ip=209.85.208.100
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com [209.85.208.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7C606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A7C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=G6JO7Vam
Received: by mail-ed1-f100.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so6210933a12.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793065930; x=1793670730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dmw+4NxcC4V2T43bzcaT/Js2XAXbRw0OaytvY2/dX+M=;
        b=G6JO7VamvuhFqGO4lSSNfUKa+vnljUJXzw/dWT+d+1O2l3q2S/bUr0OYEkJV4qn0Av
         H9zZoPH3ryQGKsg3Qpx8ygAtdmqQZFbaNqdNVhQK5Wqnl5MBaHxECugWWrn8VIxNSn0A
         RZ0V6yspWWdNScKxWjegOO1NZiaMy5LNHSo2Ka8drakqN1+iFpJlDI0FCrNykhLtEorE
         NhdypyIYw2ZjwJWTXSK9wrPv4w/quyhgzI1JF1ZHeM1pSwxitpLw4YUa+OmKwIZgzrAQ
         ZRqsbEaIi5F1Vu5NmXkVROqtd7cSjWyLys6ir2wNVSVHqEy0Epq/qImfBpu9mp/CK/Rq
         eUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793065930; x=1793670730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dmw+4NxcC4V2T43bzcaT/Js2XAXbRw0OaytvY2/dX+M=;
        b=rm0auNdA0ksPygcG72CJdKkZLW8YOXcaKjo3/BzV7ydho5pIsk/QN/bxXwl+SMAXjH
         7xGyfBkjE6qEREQxXSyfCeA2LFDAwlChdKd6KDPmete7ls8YPTlNMwdfoSLWpcbky23z
         j65a/UD7H3OxNvBiylXvh9f518DGk4u8jY9mWTXLeiwqwIAuVCW2F5pP7l6lt3ussK8e
         woR4ZqJlQijNUihPyTA4CdKBrJLqef88DhX/sEcR+BGIPDfiqnGV4oOXfhNbmu7e6wty
         HR5TrDaUxCMJ+pEDMfjCYM40lF7Iyi0AN2YKSohYVhQkP2eaIlV6WF5kEuWZg9CpD3mG
         busw==
X-Gm-Message-State: AFq9FYLOgCwlmAG6p6jhzmzeLVc2u2LU/ta+wyEIzfPh5zUTiM+w08XA
	61DwTJwxMA1YeKsZMxtDq4EjlRY9XQ20rZwhf/EzWN/FR4PvxUehHPJk0tIT0dliYzLDZQaicTb
	U0DfbslXP47r8Lf3/TLqF3DPiHEcL0rxGypob
X-Gm-Gg: AYBFou1zTJuIXczSm/4l9lAwKpCnrBOXMhP5qe13Fxbw1pwY14Hb8UvIyWwnkAjw4Sa
	KkO3jY6qsSdJxGEbtIpGPvWWDaSj/JP4Y5uVrpFe5BoNHGmQxZKYFVz4C2CG/EEBISUrHbL8R5o
	ggSaJaAtcO/JYRryYmHO4Mp74QLDrSAqjv3uMDidwYgNEkH/K5KVvf4bED8uRmdrQPapIwq7ND2
	LCV+NyTGI50soJoiq4FbATSofL/3svTtKwR5+0iCvG/FPyYuEsJkhF47B/zbIqfPpAv5uBF9qWY
	BfV0AT8+gXxIEiA0OUvGPE4qyLQV2a13gb+xvCyAZ5Va2Z9hQIv+UVpv44PpvdmMfehOZxS3reQ
	3Xl2LAvEgJrXybbWqFtZYpq8HK6VNO4DlPGk=
X-Received: by 2002:a05:6402:2142:b0:6b3:b10c:40f9 with SMTP id 4fb4d7f45d1cf-6b442ff1deamr6770420a12.31.1793065929813;
        Mon, 26 Oct 2026 18:52:09 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-6b4458fa8dcsm1689318a12.4.2026.10.26.18.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 18:52:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id A7E1E40146;
	Mon, 26 Oct 2026 19:52:07 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 9DA37DCE126; Mon, 26 Oct 2026 19:52:07 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@mellanox.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] tls: restrict device-down TX fallback to hardware TX sockets
Date: Mon, 26 Oct 2026 19:52:05 -0600
Message-ID: <20261027015205.2169253-1-rjethwani@purestorage.com>
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

tls_device_down() installs tls_validate_xmit_skb_sw() on every socket with
hardware offload in either direction, but tls_sw_fallback() needs a
hardware TX context in priv_ctx_tx. An RX-only socket's NULL priv_ctx_tx
crashes the fallback on its next transmit, for instance after the device
comes back up:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  RIP: 0010:_raw_spin_lock_irqsave+0x31/0x60
   tls_sw_fallback+0x11b/0x450
   validate_xmit_skb.isra.0+0x14f/0x420
   __dev_queue_xmit+0x5e8/0xf30

A software-TX socket's priv_ctx_tx is a tls_sw_context_tx, which the
fallback would walk as a hardware context.

Only install the fallback on hardware TX sockets. Today tx_conf alone
cannot identify them from tls_device_down(): tls_set_device_offload()
drops device_offload_lock before it publishes the validator, and
do_tls_setsockopt_conf() stores tx_conf = TLS_HW later still, under
lock_sock, which tls_device_down() does not take. That leaves two
windows. A NETDEV_DOWN before the validator store installs the software
fallback, only for the hardware validator to overwrite it with
ctx->netdev already cleared. A NETDEV_DOWN after the validator store
leaves the fallback in place. Both read tx_conf as TLS_BASE and skip
tls_dev_del(TX) today, which the destructor never retries
(tls_device_queue_ctx_destruction() only queues it while ctx->netdev is
set), so the driver TX context leaks. Gating the fallback on tx_conf
alone would make the second window a regression: the hardware validator
would stay in place with ctx->netdev cleared, so
tls_is_skb_tx_device_offloaded() keeps reporting offloaded.

Set tx_conf to TLS_HW in tls_set_device_offload() before dropping
device_offload_lock, and publish the validator there too, so
tls_device_down() sees both or neither. rx_conf has the same window and
leaks the driver RX context, as tls_device_offload_cleanup_rx() skips
tls_dev_del() once ctx->netdev is NULL, so set it the same way in
tls_set_device_offload_rx().

The unconditional fallback install, and its overwrite by the hardware
validator, date from c55dcdd435aa; the TX and RX leaks from 4799ac81e52a.

The NULL dereference was reproduced on an RX-only socket, which now
survives an interface down/up cycle and keeps receiving TLS records. The
software-TX case and the setsockopt/NETDEV_DOWN races are from code
inspection only.

Fixes: c55dcdd435aa ("net/tls: Fix use-after-free after the TLS device goes down and up")
Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 1a5f328d80a5..9e0863dd2f96 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1176,13 +1176,15 @@ int tls_set_device_offload(struct sock *sk)
 		goto release_lock;
 
 	tls_device_attach(ctx, sk, netdev);
-	up_read(&device_offload_lock);
 
 	/* following this assignment tls_is_skb_tx_device_offloaded
 	 * will return true and the context might be accessed
-	 * by the netdev's xmit function.
+	 * by the netdev's xmit function. Publish it and tx_conf under
+	 * device_offload_lock so tls_device_down() sees both or neither.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
+	ctx->tx_conf = TLS_HW;
+	up_read(&device_offload_lock);
 	dev_put(netdev);
 
 	return 0;
@@ -1258,6 +1260,11 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto free_sw_resources;
 
 	tls_device_attach(ctx, sk, netdev);
+	/* do_tls_setsockopt_conf() stores rx_conf too, but only after
+	 * device_offload_lock is dropped. Set it here so tls_device_down()
+	 * sees TLS_HW and releases the driver RX context.
+	 */
+	ctx->rx_conf = TLS_HW;
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
@@ -1326,10 +1333,17 @@ static int tls_device_down(struct net_device *netdev)
 	spin_unlock_irqrestore(&tls_device_lock, flags);
 
 	list_for_each_entry_safe(ctx, tmp, &list, list)	{
+		bool tx_hw = ctx->tx_conf == TLS_HW;
+
 		/* Stop offloaded TX and switch to the fallback.
 		 * tls_is_skb_tx_device_offloaded will return false.
+		 * Only HW TX sockets have the context the fallback needs.
+		 * The single read above keeps the fallback and tls_dev_del()
+		 * below in agreement.
 		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+		if (tx_hw)
+			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
+				   tls_validate_xmit_skb_sw);
 
 		/* Stop the RX and TX resync.
 		 * tls_dev_resync must not be called after tls_dev_del.
@@ -1346,7 +1360,7 @@ static int tls_device_down(struct net_device *netdev)
 		synchronize_net();
 
 		/* Release the offload context on the driver side. */
-		if (ctx->tx_conf == TLS_HW)
+		if (tx_hw)
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_TX);
 		if (ctx->rx_conf == TLS_HW &&
-- 
2.50.1

