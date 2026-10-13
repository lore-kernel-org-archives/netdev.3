Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C04DE700
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923217; cv=none; b=upG7LGDjetAqoUwdlagWMPzz98SIxmm3+7BhVujYN2qKquMX8e/JvKhKPeHic52MgnYmkmIITJ5FxRXIcO55gCIqmheL5kOyrHnzEZMcnOl23V7j813vSlYpbOQ8GCyH3yaU8XabrC8BaDIa7Zp3IFFLyM/qOPIeD6LtLBmbaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923217; c=relaxed/simple;
	bh=V5uNWa0sZ09E+nF9ri+MYvrcP2KcScAZahLPgG6Ey4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MoKvfJ46WNML5kSywknq6VKDz6TCEtGrCfEPukVccyaiJX2EBB8fTw6mznWM5upL3pfHHFerk3YCvXNkVVyB5cpmDbK0kdHdvMQb2wt8l72I72bJDUyhcg69fEkPQpf5KqDoFphxJ+MVhnK0V++7/OkuSXvRpzoISsoMQV//ZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PZwUPQKB; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PZwUPQKB"
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so3658605e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1791923212; x=1792528012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oIMuUjeZJwIQtyzOfZxTGCOya3S9aZceRW3NszHc4qQ=;
        b=PZwUPQKB393v/iGIUj+d5HYnKHlXFI6DebwAZSRtX8UmJrvRyvwlG0h0tJ7OontGRQ
         ODUQxQUpkXW0J2YaFUJ57+6a9jiAubCRlepwECtTnn+HdXz1K3MZqqoBRMNypeU+XZmW
         1yi00F/CjEpBmI6NSWZXc/LW/CgJUqJVk5Niisas0Yvfd/HUGiYC/fdzeOWFnUjNQeGV
         KHgURVondpf83KGgRUwZt3WKtazlX7dWmZtZx3SQm8z8zFzVWVnfBpXnmnz7lHrt6RVC
         IMUNePFBafcANQ288PNbFA04XARLFV1VUErFC8ktY0fqB3DQss26nbVcUUR2mD13XsUU
         wKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923212; x=1792528012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oIMuUjeZJwIQtyzOfZxTGCOya3S9aZceRW3NszHc4qQ=;
        b=ymsiMu6ZHkCp9S3J3ZKT2BvicvbQTkCACPb7LqcvPUdvvKHM4TgYRfmWiYMPclgNkf
         HWQnJgcjtI1asFNbdPuwvcNQXYS4c8Y9KwG9Y+2vJR4R2zQnOrjM8zDkGS/3TOGsBigt
         8kBXBhW+OVb4tIrLsif+DKi0crfu7FlaBF16nPfTSsc9UWm9IM0dhmKy/arRySku0/n0
         hm2j1PAQ3KCt7AdYwfaWAffhJJnIAInjais6slKQWTikkYiupmnlMklJzQAXxlugHj2n
         OmYiSNwAoA0BOV9l7w7ZP9086Cu7K58GfAtqN4zjWIAv8wvTAtTyWXklHskrSzcajQ/Q
         0msg==
X-Gm-Message-State: AFq9FYLTJsxiWaNzvMQxnLoTOO2F+Q++VyAd8zV1DKvEpqet4lOJ+Av8
	7LtOFoD3ijiMCYlrsaGpzwQsi7Lk9Zv3VN33HQ/YxPjc/TxraIgr97tjAY92P1T/E9kqe/gZ7WU
	YOfUlio1fzOU3MvozON8koy1SxxOeHfx6tBqU
X-Gm-Gg: AYBFou2BgP++34AwH/2f6RJcGw/i/bGfea1JhLPbTi3e+M3HJ/ORcXsaxZv18KEOc5n
	ZrO0dyNQM2dgi0G3mVLv4UMR3+uq8pyKUszjDti2WkMg/zr34/dheeVVSgcR6AJ0OAT06aAOS//
	h33VKa2FNfqOzvN5CAVFIBhcsxXAoViEzUh/Tf+1otPvvihzQgLe4STZFNsDHSKAEV86ny7ivKb
	jLaf4H9wIbv16m+xkvFpP2gxig7XrSKxKDhl3J8S67rgqysusoxXk4T6k7BeqDc4rh+SShsUqby
	b3Pxca/pNS4Ll7sA+6yzd7P0mcO8d+6B1KLzpLyVfSKpKx2JZKrwjdAURQ3Mvg+B+5BnzXlxh7l
	IeedENhajOW5RAGiP7GBciWy44FjokP7tqiY=
X-Received: by 2002:a05:600c:a01:b0:49f:ce72:e931 with SMTP id 5b1f17b1804b1-4a18e4fe3e1mr288287835e9.35.1791923212133;
        Tue, 13 Oct 2026 13:26:52 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4a18be904b1sm42263425e9.16.2026.10.13.13.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:26:52 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.112.16.167])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id AB16B4017A;
	Tue, 13 Oct 2026 14:26:50 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 9FCECDC0D0D; Tue, 13 Oct 2026 14:26:50 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH] tls: keep TX and RX hardware offload on the same device
Date: Tue, 13 Oct 2026 14:26:47 -0600
Message-ID: <20261013202647.2206263-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After TX is offloaded on device A, a route change, or a change in the
usable-slave set of an 802.3ad or balance-xor (layer3+4) bond, can make
RX setup program device B. tls_device_attach() sees the existing TLS
destructor and keeps ctx->netdev pointing at A. The RX driver state on B
is then untracked: tls_dev_resync() and tls_dev_del() are invoked on A
for a context it never created, and neither socket close nor
NETDEV_DOWN on B calls tls_dev_del() for B, so the driver context leaks.
The reverse setup order has the same problem.

Check the shared device binding under device_offload_lock before each
tls_dev_add(). Permit the first attachment and a second direction on the
same device. Reject a different device, including when the old binding
was cleared by NETDEV_DOWN: the TLS destructor remains installed and
tls_device_attach() cannot establish a new binding. Setup then falls
back to software for the requested direction.

The RX check precedes allocation and software setup. TX uses its existing
resource unwind path without calling the driver. Document the shared
binding and clarify that fallback is per direction.

Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 Documentation/networking/tls-offload.rst | 16 ++++++++++------
 net/tls/tls_device.c                     | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/tls-offload.rst b/Documentation/networking/tls-offload.rst
index e5802bcd4d22..cf0e599c06a1 100644
--- a/Documentation/networking/tls-offload.rst
+++ b/Documentation/networking/tls-offload.rst
@@ -71,12 +71,16 @@ During driver initialization device sets the ``NETIF_F_HW_TLS_RX`` and
 pointer in the :c:member:`tlsdev_ops` member of the
 :c:type:`struct net_device <net_device>`.
 
-When TLS cryptographic connection state is installed on a ``ktls`` socket
-(note that it is done twice, once for RX and once for TX direction,
-and the two are completely independent), the kernel checks if the underlying
-network device is offload-capable and attempts the offload. In case offload
-fails the connection is handled entirely in software using the same mechanism
-as if the offload was never tried.
+TLS cryptographic connection state is installed separately for RX and TX
+on a ``ktls`` socket. For each direction, the kernel checks if the underlying
+network device is offload-capable and attempts the offload. If offload fails,
+that direction is handled in software as if offload had never been tried.
+
+Both hardware directions share one device binding. Once one direction is
+offloaded, the other direction must use the same device. If a route change
+selects a different device, or ``NETDEV_DOWN`` has cleared the binding,
+hardware offload of the other direction is declined and it uses software
+instead.
 
 Offload request is performed via the :c:member:`tls_dev_add` callback of
 :c:type:`struct tlsdev_ops <tlsdev_ops>`:
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f11d0528fc43..d954e17a327b 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1022,6 +1022,17 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 	return tls_device_reencrypt(sk, tls_ctx);
 }
 
+/* Both directions share ctx->netdev. A second direction must use that
+ * device; after NETDEV_DOWN clears it, no new direction can be offloaded.
+ */
+static bool tls_device_can_attach(struct tls_context *ctx, struct sock *sk,
+				  struct net_device *netdev)
+{
+	return sk->sk_destruct != tls_device_sk_destruct ||
+	       rcu_dereference_protected(ctx->netdev,
+					 lockdep_is_held(&device_offload_lock)) == netdev;
+}
+
 static void tls_device_attach(struct tls_context *ctx, struct sock *sk,
 			      struct net_device *netdev)
 {
@@ -1157,6 +1168,11 @@ int tls_set_device_offload(struct sock *sk)
 		goto release_lock;
 	}
 
+	if (!tls_device_can_attach(ctx, sk, netdev)) {
+		rc = -EOPNOTSUPP;
+		goto release_lock;
+	}
+
 	ctx->priv_ctx_tx = offload_ctx;
 	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
 					     &ctx->crypto_send.info,
@@ -1227,6 +1243,11 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto release_lock;
 	}
 
+	if (!tls_device_can_attach(ctx, sk, netdev)) {
+		rc = -EOPNOTSUPP;
+		goto release_lock;
+	}
+
 	context = kzalloc_obj(*context);
 	if (!context) {
 		rc = -ENOMEM;
-- 
2.50.1

