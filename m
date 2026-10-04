Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A140802B
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099281; cv=none; b=l9OxTbJB1VDHSMihPGb/PkxzCPePJUguuj1izck8laYGRezZLSg1Wyo+iRpgdX1NIrrr0ontxWbLALfNQiGWUpG20EFOjlhb2EUFc4hLTV7Li5l4lP6EsPu6+t6F/uGK6HiGnfKi4BPWyIXDjenIEDpqXO40tF/jorx6EuxTudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099281; c=relaxed/simple;
	bh=oV8I52EnEn4Do2vf3jRoStkeuMXWZFI+JGNnneSg3Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8wz6zbJmz4F22wpHMIGOKaBNGrTM36FnapI/LRMebR0qTZux8comaNZJuAFvX4mX/Nqrlc+teQ6scB/0DxLkVzA1++xasE/1xWYUXwKbM/6OdlUKb9CFJGRSfzYv3yTlVuKh3RGxitp+agG8kGAHpJ56wDkZg6BaQkdpan8Jlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlC846XP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlC846XP"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e30b9f1441so9238855ad.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791099271; x=1791704071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3TSxZwHRoZMu3vBmEpKbk/Zl8R7mBDI5Id5VQd4Apzw=;
        b=TlC846XPO2Gv+JsPUu5xUx66cWpftMkB/Z2wAhQWBpx/7mXVNPBCIUSnLiLVna7gCO
         t99eU3AcaHJRvCi4mkwrsuIhRMrH9FbdI3ylKBv91MO0v/fK9Q37EG4LwYPPn+AiZF1j
         BpP0PXJL9CbKTjPVT0e0fXuhWA1ch8wOgTy1nGv3fBszLn2hrPqIiH5/E0ZUdjJ6nDXC
         6MqyWJZWHRYgE+1cqtAuA+pahi/ADtvexVJYyZ3iamzNJjRBYFWjwXEI1+/5Q6bnPGNQ
         72qRT4b5mVb4TW75tQkwMce3T2PayOTyQI2o/RgDRoazTIdXxpDGEOlPSZ2KEhukV5NM
         mjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791099271; x=1791704071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3TSxZwHRoZMu3vBmEpKbk/Zl8R7mBDI5Id5VQd4Apzw=;
        b=PKHIFijlzVEl76zqVFTWoYP8ZjvhuYciv0WetoW+lfYPJDLgMYZQg46jddh/YIYkjv
         b0uLm3hvmP7puo4GlgKFpmlqSOsqfNRrcf4gHiLDiMV66edFLUrtAc9b2PxcnGJ5AT+l
         OonnisUMndHNPhrSF0YVbOwly1cOZoswGzgFw9TU7j74hqb01SmBtDbjW0aGHdL4xh35
         Yeh6qemm29Irlf39p1eij6kHTJaNtQcc8+aCZTGk155KAjY6GUso2RE8Ushg2DKbaMxV
         zAwohFWfm7JmkQ673SCWxVtIjSZtAb9pRINTva8pMiWbgcv4XftZMcimaf43F7sB7MkK
         vvIQ==
X-Forwarded-Encrypted: i=1; AKwUvBznD7Ejd4OJkRlUAZTC70Uhaiuv7xRWXGg1zxn1smqGmKhC2eOYTUaSa8XGAb2/K1hoVu49dqI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTNt1i7XW2MVP9Xtr5rs9ad7teUq6pJcPk8FBtS2ybJUkdxRyr
	iOBdLf+j8C3Jkfka26ZPQMDVlsgM9mpylLGwsp1JGRmVqMXH5OSp2X6d
X-Gm-Gg: AYBFou2cge23iutsdKh5idznm/IuBhWxKV1dRVlGRsQwpe7Ioi9cVf2UirqWEHGmPg+
	ilyNbssxa975V98R3Lkoo20QbzkO8gBwagKmi+BH648L68u/07mC7FJPysRhcktzvQ0/uvLXKBo
	VEo9mZIgUUYw0J7xf9wmGumcsfKhKEaPv01z4BNJX5oQt9EsSMH9kTUoYff8QFOIYJD5gRLeami
	x3fP3RAH7mjsKG8+alzOe/rkwiPcsmwabj918oNc0UHBm5s3dJq17bnfO0NTmQfW4hqTdVTATDp
	8HR2Ypeylhnp/818i/ll1J0CUbuSVOO5M3sL9jIXLTUXKOGUTopKIAxsVTkpyeuB8Up0/6HKTP9
	9qlhhxTzI1rWIvIgHAtbGvEEoZUfiGDu6IpTAb7SMPVNgzRO7Rg7pQ6DtCStTR+RdPUG9nQJLCR
	vXxX2EB+ciJqW0a9HoKKxW9cWRP9b1wP6t2Jc27YUbWNg+2eTuLmgXxbQl7RdYjG9sU6kqQtqtX
	/0CVgqhYb0=
X-Received: by 2002:a17:902:f686:b0:2e2:dc50:16a8 with SMTP id d9443c01a7336-2e510573f7cmr31772435ad.27.1791099271346;
        Sun, 04 Oct 2026 00:34:31 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f7312aasm21800865ad.79.2026.10.04.00.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 00:34:29 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] vhost/vsock: size receive SKBs from declared payload
Date: Sun,  4 Oct 2026 16:34:19 +0900
Message-ID: <20261004073419.4039011-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_alloc_skb() allocates an skb from the total guest descriptor
length before reading hdr->len.  Descriptor capacity and declared payload
length are independent, so a guest can supply a large descriptor with a
zero or short payload.

On Linux v7.2, 455 zero-payload packets with 64 KiB descriptors retained
30,255,680 bytes on a 256 KiB receive buffer while rx_bytes and buf_used
stayed zero.  A full-payload control retained 265,984 bytes.  The existing
SKB_TRUESIZE(0) budget caps skb count but does not account for the
descriptor-sized allocation.

Repeating this across connections can exhaust host kernel memory.

Trimming after allocation is insufficient.  Linear skbs retain their full
head, while a nonlinear payload exceeding head tailroom can retain its
first page fragment.

Copy the header into a stack object, validate hdr->len before allocating,
and size the skb from the declared payload plus the header.  This keeps the
allocation proportional to receive accounting for both linear and
nonlinear skbs.

Use payload_len > len - sizeof(hdr) for validation.  This avoids addition
overflow on 32-bit hosts and ensures payload_len fits the subsequent
int-length copy path.

Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- validate the header before allocation with an overflow-safe bounds check;
- size the skb from declared payload and remove the global trim-helper
  change;
- remove the generic clean-validation statement from the changelog; and
- add Will Deacon to Cc.

v1: https://lore.kernel.org/netdev/20260930044147.3818241-1-4ncienth@gmail.com/

Built and booted on v7.2 with KASAN, UBSAN and LOCKDEP.  A focused
allocation/queue probe retained 436,800 and 582,400 bytes for 455 zero and
341-byte packets, versus 30,255,680 bytes for the vulnerable zero case.  No
KASAN report, WARN, oops or panic occurred.  The probe injects skbs
in-kernel rather than through a live guest virtqueue.
 drivers/vhost/vsock.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index abed1fbcf66cc5..35f75e23c7497e 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -364,7 +364,7 @@ static struct sk_buff *
 vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
-	struct virtio_vsock_hdr *hdr;
+	struct virtio_vsock_hdr hdr;
 	struct iov_iter iov_iter;
 	struct sk_buff *skb;
 	size_t payload_len;
@@ -382,34 +382,32 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
-	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
-
 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
-	hdr = virtio_vsock_hdr(skb);
-	nbytes = copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
-	if (nbytes != sizeof(*hdr)) {
+	nbytes = copy_from_iter(&hdr, sizeof(hdr), &iov_iter);
+	if (nbytes != sizeof(hdr)) {
 		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
-		       sizeof(*hdr), nbytes);
-		kfree_skb(skb);
+		       sizeof(hdr), nbytes);
 		return NULL;
 	}
 
-	payload_len = le32_to_cpu(hdr->len);
+	payload_len = le32_to_cpu(hdr.len);
+
+	/* The pkt is too big or the length in the header is invalid */
+	if (payload_len > len - sizeof(hdr))
+		return NULL;
+
+	/* Allocate only for the payload declared in the header. */
+	skb = virtio_vsock_alloc_skb(payload_len + sizeof(hdr), GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	memcpy(virtio_vsock_hdr(skb), &hdr, sizeof(hdr));
 
 	/* No payload */
 	if (!payload_len)
 		return skb;
 
-	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len + sizeof(*hdr) > len) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
 	virtio_vsock_skb_put(skb, payload_len);
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.55.0

