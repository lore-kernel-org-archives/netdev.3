Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F42F8BEE
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743323; cv=none; b=hGtXbWZedHA69e0ovJHiFwUken7OqeIi59dgSHNA33d7bEJSaoQxvIShUw4jINrR/wCfcjQ2GUEVR4RMfSKwB49yw00D6x29fN//eK8OkzJg8nmzj6+TsxMK0Qn42DedO0qkeSINcQ615hfpRLTo/FKVpBGY1XqkEAMfXmQv4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743323; c=relaxed/simple;
	bh=hVK5ZaKV4XKlAN+5/oG1cx4MwyE5N3AwnSgb6VJtQF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Go1q7ZozDhOrGID9HhaQ0De/GgnsF1i2MyXy4dqAQg1uHztVepUmTK4Sa9KHsJURbSxiUxBA+zsNBRrllxaibEy6jGyOZKBTY9SYF7UoLQe1uvCIow06tHuvEe4LNIx8ox4GHovL/o5bTEB1sZFubI7S4q4L/KEzNSALvUNlB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSZeBCac; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSZeBCac"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso31717985ad.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 21:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790743321; x=1791348121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ud4fTEqxQzrUTwARn11POV1Taqipw52FWd2xdX+lQEY=;
        b=nSZeBCact6qaShd68BNW4fkcVF1wCHtyXGtdU79kJo1OlXmjB2UPcSPAfmzmsXZBaO
         3diFhUCQqzM4QoysSPzKyp+bi2fpghVWOyxt52QPbiX380kQOxqxVVx45pCDnoQLH5MU
         8Pl73CDaK3M4h1ikjiK9zNfMpFNV0eoC8VOv5wIq702eZ5NkAee4EgJpWbJ4CXehb/xy
         z1TfOK9AwTOCF2OSauAt7NLpAAkrTjauJsQse1+3saC0mIWG9FAwdyC9+OkQUH2Lz+Z9
         eMtyu4r0Z6AZHsLlqCm1w0jJISTzwcc8kCgb1O5PueRz1ilf3c9UwQTQ37cnxNc/nErC
         XYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790743321; x=1791348121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ud4fTEqxQzrUTwARn11POV1Taqipw52FWd2xdX+lQEY=;
        b=1Zc3Ho2OTdXeWc896z8ALorLq6YN604yez2DVqdZT2D4JjdM7g1uGt1gNTPqddUUKS
         rz5+gkf6G43nZO7lYhUc6NQ4dQRp02uk7c91ZgH8FFlD0S46Y3nPSFVJE6smK7O2J5pj
         +lh2G0qWkbPlpJySDkdDc96WFxmRFOD/IFVfrPNe7iHogEIJfNMvwqUCLQXLgP7abbSh
         cO0Cup9ITVmHR1FWRhjBEIPqWCfJFbQUM/loCTHvZE/MbJJkIC3Mf5k30PtQsaXH+CaC
         9khp8XjxJdoACWGm+icrsl3Otj0lUuj5j2Tl3VEx7EENO6yHuF6kNahwcKQJwVaSZ9N5
         ZEPA==
X-Forwarded-Encrypted: i=1; AKwUvBw3+dhiokD7cWLC9AnuJqBS25Y/OCIXa5/kZrn36E0+u/e0SBw61OUur7UzVVbLVLHKzTr7Zr8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0eO/p2FydYGjsOgPvOnWpEspZzxsfx9L8vddc/PgygTWTlLeC
	N27PQ8PmZIz71YYJdTNvKOEHGL52kZ6HOuWSLCgxEJfNO4CtKYmftfbhry+o12KM
X-Gm-Gg: AYBFou2DZ3RI4p0Bcm63/IrkXKiUuzWWgll/sG9qsOjSaFBrkHtcwGZ0yynNxrhaE4E
	YqTo3NtAraSDipLakf4HlRoom+e3ZTe6AcKfpV0mdvZahMR/bCvYNjGRUUKS35fO0Kfq/ZsT/fP
	Od9NfhfIA+6mq6Hdcdr+poQig/c8QJgOr4XsfjkrLFscpmb6Vvp20+qFENTYVPTw235B14wH9BB
	dMFFiKm5FUt0Z736cl7B74g5biJPD/+SafCrVMVgYMbWiXyxMl3ZeloSyi3M+MTEgxifP8sD5yl
	xaqkpau4T2fsHFGRlgZZj+wq+lLR6SwFye64ircRneE1NdKqw7TMxXvKeJ81b/JMobHIE2FZ9bz
	4nUyfyL/gdE+thvilZGaUgCp3cuSwyHqq6EhhIdKLQA+txUbuL+JsZDnJoGuAQPQL3s4pOrwPyc
	hP7Gi9pehWakG9LWCuyc4jmJfGWLhaJi+VM3uxjrDBw1Qu0zS56TRk+grmqELx7kAt1K5uleFR0
	tSpX7dp9dI=
X-Received: by 2002:a17:902:ce90:b0:2df:9eb0:761a with SMTP id d9443c01a7336-2e2e4a25a1bmr2167915ad.25.1790743320928;
        Tue, 29 Sep 2026 21:42:00 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5b89c06sm538155ad.24.2026.09.29.21.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:42:00 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload length
Date: Wed, 30 Sep 2026 13:41:45 +0900
Message-ID: <20260930044147.3818241-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_alloc_skb() sizes its skb from the total guest descriptor
length, while virtio_vsock_hdr.len independently declares the payload
length.  Since commit ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs
for handling large receive buffers"), large descriptors use skb fragments.

virtio_vsock_skb_put() currently changes only skb->len for a nonlinear
skb, leaving skb->data_len and all fragments attached.  The zero-payload
fast path skips the helper entirely.  A guest can therefore retain the
full descriptor allocation while receive credit accounts no payload.

On Linux v7.2, 455 zero-payload skbs retained 30,255,680 bytes on a
256 KiB receive buffer while rx_bytes and buf_used remained zero.  A
full-payload control retained 265,984 bytes in four skbs.  The existing
SKB_TRUESIZE(0) queue budget caps skb count but does not account for these
descriptor-sized fragments.

Set skb->len to the fragment length before calling pskb_trim(), then trim
to the declared payload length.  This releases unused fragments and lets
skb_condense() reduce truesize.  Move the zero-payload return after the
helper so zero-length packets are trimmed too.

These skbs are newly allocated, unique, and have no frag_list, so the trim
does not enter an allocation-bearing path.  Keep a warning for a violated
caller contract.

The fixed v7.2 image left a one-byte skb with no fragments and reduced
the zero-payload queue to one 960-byte skb.  The build had no compiler
warnings, and the run had no sanitizer, WARN, oops, or panic findings.

Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Required configuration is CONFIG_VSOCKETS, CONFIG_VIRTIO_VSOCKETS_COMMON,
and CONFIG_VHOST_VSOCK.

The source reproducer is available privately to maintainers and is
omitted from this public AI-assisted report. It exercises the real
allocation helper and VSOCK receive queue from an in-kernel module, not
a live guest virtqueue. Guest control is source-confirmed, but live guest
end-to-end validation and deliberate host OOM were not performed. No KASAN
splat is expected or claimed; the oracle is retained truesize and receive
credit state above.

 drivers/vhost/vsock.c        | 6 ++----
 include/linux/virtio_vsock.h | 9 ++++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index abed1fbcf66c..fa59456abda9 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -400,10 +400,6 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	payload_len = le32_to_cpu(hdr->len);
 
-	/* No payload */
-	if (!payload_len)
-		return skb;
-
 	/* The pkt is too big or the length in the header is invalid */
 	if (payload_len + sizeof(*hdr) > len) {
 		kfree_skb(skb);
@@ -411,6 +407,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	}
 
 	virtio_vsock_skb_put(skb, payload_len);
+	if (!payload_len)
+		return skb;
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..31358683e23e 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -51,10 +51,13 @@ static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
 {
 	DEBUG_NET_WARN_ON_ONCE(skb->len);
 
-	if (skb_is_nonlinear(skb))
-		skb->len = len;
-	else
+	if (skb_is_nonlinear(skb)) {
+		skb->len = skb->data_len;
+		if (WARN_ON_ONCE(pskb_trim(skb, len)))
+			return;
+	} else {
 		skb_put(skb, len);
+	}
 }
 
 static inline struct sk_buff *

base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
-- 
2.55.0
